Return-Path: <linux-kernel+bounces-274357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A46E947746
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28FDE1C210C2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9D314D433;
	Mon,  5 Aug 2024 08:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1jJV19q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B9E149E05
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722846364; cv=none; b=MmupsjeRbe5WQAIINAxIcXVkvxF+re/OnxbPiV3v/coMq6Lm2bpgSQUab6F7hR6oinmLQbfSgo3Ggsx6SL4RKEGrO20JU9d1sNgiC5OiDNMzNhp/txOBHxwWyvGrml6ocom0ZDdtT0Lm9qMyH4Ug1TfV9/J5NTq0Khgs9sRm5RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722846364; c=relaxed/simple;
	bh=6dwbUCoI5S7wePU7otIi5xZ534cvsIdQTEVDfXae6E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGBamqeL6Vc/dkP6BSfTS0ZFoV6H+4mGSMT6FMIlZz+F+10CHByyCPY65asPuk3N6fBYOJ8MzCBOPNXwl4LGIAbenqtvNq4r/W75rC0tVsmSFh3nZqQBDJCzqpNspHvZLkMCa38nMnwoAxXAm/58XBtONG8azyywy224O8LNVk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1jJV19q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722846362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IdnDLnsXWEQ6RVAumOXnOOh7mrwkaymI4Jc/Y5qxz/8=;
	b=E1jJV19qmw/uMkaW74mv5nQdHxqczShZA+aW5t+YWmGzplOivW+SNaeBftUitS8DZvuBIH
	pQibY8V62nE+1pQatyGPKuP+m8gokrfog20YKEnH89ctT2ZHkvly9852BGYY0iFE4MnXaa
	1cglb3v03RxZBjl0jbUEkwOFHhIXtD0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-zt63iU0eNmCvm2YUEGW2Mw-1; Mon, 05 Aug 2024 04:25:59 -0400
X-MC-Unique: zt63iU0eNmCvm2YUEGW2Mw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ef1ba2a5e6so104534941fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 01:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722846357; x=1723451157;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IdnDLnsXWEQ6RVAumOXnOOh7mrwkaymI4Jc/Y5qxz/8=;
        b=Sk11xOMXiX+/vPq33nebug6S2IUt+B4rRNb0tV7zuCBOyuX2YZIg2pEDI2ylL8Ouok
         SshuF9402sMZi1GwhFiikPiZ0Q2YLg9uoXyHwVbIUu3MNskJWX2AiYPRs6jGdG3GOTry
         F63Xqx16tPa/hubnNn6pdsBCoDYqG1Gkjy2Iqnb/RBhY5/OsfaaSTsw0SaklnWNHno0l
         7VJh16wNwF27/o0FC8k4kWnsBPx7EmNPzcIfQFB5XuxXOerIPAYPK528oUDtw2XDtfws
         ImxTHFm5zcDYhv0oomnIQsOWCzj2Imu93pr3Uf+LYxe6Hxoyl7VW5PpG3X/SO+8veM3r
         CBNg==
X-Forwarded-Encrypted: i=1; AJvYcCUm9S80ysEfLUuw7x5v8/6I+FQifvydh7PZNPEuearsNnyokDqWKp/ZNPY9tamCUcXCTl+sM4z0UL9UnSlEUpHD+RqMLCrfg4S7Zm/e
X-Gm-Message-State: AOJu0YzP3hs9fAVer5ijP0Se1PkNz+/3n6DteVMpwkp99L/eDcWaCHGN
	zhI8cO14BObKwgEOavmpEzNCAzGSp1PPcyoreaK3eqQlDiZZVXN3ZxJrc6t0XC/mxh9EXGLHUrG
	L9V/+ohevGSfcakb1AslJcPxIibvF9DUUASlu1IZBFCWwNcX5kYSs+CirjKH382bNRTy5ag==
X-Received: by 2002:a2e:9ecb:0:b0:2ee:87b9:91a7 with SMTP id 38308e7fff4ca-2f15aa87cedmr67675991fa.18.1722846357416;
        Mon, 05 Aug 2024 01:25:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsXonxhnbF7y/SEo+8UNCkXh1OH8gxWMWHsntkfxFG8gi9ahQmlsboo+pmk8i2fc4VpWKqgw==
X-Received: by 2002:a2e:9ecb:0:b0:2ee:87b9:91a7 with SMTP id 38308e7fff4ca-2f15aa87cedmr67675681fa.18.1722846356422;
        Mon, 05 Aug 2024 01:25:56 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17d:dd95:f049:da1a:7ecb:6d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb9d54esm188671405e9.43.2024.08.05.01.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 01:25:55 -0700 (PDT)
Date: Mon, 5 Aug 2024 04:25:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	maxime.coquelin@redhat.com, xieyongji@bytedance.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	21cnbao@gmail.com, penguin-kernel@i-love.sakura.ne.jp,
	linux-mm@kvack.org, akpm@linux-foundation.org
Subject: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
Message-ID: <20240805042421-mutt-send-email-mst@kernel.org>
References: <20240805082106.65847-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240805082106.65847-1-jasowang@redhat.com>

On Mon, Aug 05, 2024 at 04:21:06PM +0800, Jason Wang wrote:
> Barry said [1]:
> 
> """
> mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> __GFP_NOFAIL without direct reclamation may just result in a busy
> loop within non-sleepable contexts.
> ""“
> 
> Unfortuantely, we do that under read lock. A possible way to fix that
> is to move the pages allocation out of the lock into the caller, but
> having to allocate a huge number of pages and auxiliary page array
> seems to be problematic as well per Tetsuon [2]:
> 
> """
> You should implement proper error handling instead of using
> __GFP_NOFAIL if count can become large.
> """
> 
> So I choose another way, which does not release kernel bounce pages
> when user tries to register usersapce bounce pages. Then we don't need

userspace

> to do allocation in the path which is not expected to be fail (e.g in
> the release). We pay this for more memory usage but further

what does "we pay this for more memory usage" mean?
Do you mean "we pay for this by using more memory"?
How much more?

> optimizations could be done on top.
> 
> [1] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8ZQ2saLnUdfOGOLg@mail.gmail.com/T/#m3caef86a66ea6318ef94f9976ddb3a0ccfe6fcf8
> [2] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8ZQ2saLnUdfOGOLg@mail.gmail.com/T/#m7ad10eaba48ade5abf2d572f24e185d9fb146480
> 
> Fixes: 6c77ed22880d ("vduse: Support using userspace pages as bounce buffer")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/iova_domain.c | 18 ++++++++++--------
>  drivers/vdpa/vdpa_user/iova_domain.h |  1 +
>  2 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
> index 791d38d6284c..933d2f7cd49a 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -162,6 +162,7 @@ static void vduse_domain_bounce(struct vduse_iova_domain *domain,
>  				enum dma_data_direction dir)
>  {
>  	struct vduse_bounce_map *map;
> +	struct page *page;
>  	unsigned int offset;
>  	void *addr;
>  	size_t sz;
> @@ -178,7 +179,10 @@ static void vduse_domain_bounce(struct vduse_iova_domain *domain,
>  			    map->orig_phys == INVALID_PHYS_ADDR))
>  			return;
>  
> -		addr = kmap_local_page(map->bounce_page);
> +		page = domain->user_bounce_pages ?
> +		       map->user_bounce_page : map->bounce_page;
> +
> +		addr = kmap_local_page(page);
>  		do_bounce(map->orig_phys + offset, addr + offset, sz, dir);
>  		kunmap_local(addr);
>  		size -= sz;
> @@ -270,9 +274,8 @@ int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
>  				memcpy_to_page(pages[i], 0,
>  					       page_address(map->bounce_page),
>  					       PAGE_SIZE);
> -			__free_page(map->bounce_page);
>  		}
> -		map->bounce_page = pages[i];
> +		map->user_bounce_page = pages[i];
>  		get_page(pages[i]);
>  	}
>  	domain->user_bounce_pages = true;
> @@ -297,17 +300,16 @@ void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain)
>  		struct page *page = NULL;
>  
>  		map = &domain->bounce_maps[i];
> -		if (WARN_ON(!map->bounce_page))
> +		if (WARN_ON(!map->user_bounce_page))
>  			continue;
>  
>  		/* Copy user page to kernel page if it's in use */
>  		if (map->orig_phys != INVALID_PHYS_ADDR) {
> -			page = alloc_page(GFP_ATOMIC | __GFP_NOFAIL);
> +			page = map->bounce_page;
>  			memcpy_from_page(page_address(page),
> -					 map->bounce_page, 0, PAGE_SIZE);
> +					 map->user_bounce_page, 0, PAGE_SIZE);
>  		}
> -		put_page(map->bounce_page);
> -		map->bounce_page = page;
> +		put_page(map->user_bounce_page);
>  	}
>  	domain->user_bounce_pages = false;
>  out:
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
> index f92f22a7267d..7f3f0928ec78 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.h
> +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> @@ -21,6 +21,7 @@
>  
>  struct vduse_bounce_map {
>  	struct page *bounce_page;
> +	struct page *user_bounce_page;
>  	u64 orig_phys;
>  };
>  
> -- 
> 2.31.1


