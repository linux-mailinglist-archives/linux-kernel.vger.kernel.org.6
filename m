Return-Path: <linux-kernel+bounces-214368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF258908357
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15541C2276F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CAB147C96;
	Fri, 14 Jun 2024 05:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hep1KusM"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B166513959B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 05:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718343076; cv=none; b=ctFYBEJwydLsIzAz/gKUCQqACvvCG4AI9egCaJrQwSXloJWwEA3yYeOVMeK82zTzpA7f+VCh8jqmSPrL9ZAoWktsnZzj24EZl2kiWPjmkszl3jRN7krht6QDm2A5Njl3QuTzQddLWzY3qn9j7lDlzGAmXfNNqbSHqJj9ejNe7O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718343076; c=relaxed/simple;
	bh=1FAI2M+RDz3A9KGneIzMG3P4EX7MhLgB78nrMZI1BdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPE4LRAcsxYFecXmToERctmXY6af4eQD7egQqseBetubRbyoG9ukyP+ehfJMl1xxARta+3YDFVN35iw40UFHdtO8CXnDQ++HBCgYda/1x2k9CGI3Um5buMACTqimxgbNXEBKsYPpWINMwLv3YbY4AigrXnqE8A9zSetpGdl9gpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hep1KusM; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6f8edde24b3so1051050a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 22:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718343074; x=1718947874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XAzRVuGiwiPjuyzyla5fhPiLV7P+Mj2MHeHS/YDHrio=;
        b=hep1KusMRCX0NeoP8UV5NsYGSeuqYXJ2QHTXlwcpMi/IFKmHTZ7jTCuD8InlE28VcV
         kvswWZyHi6ZOVEnsh0bL9ihacrIOFugKrD7+NDZJfvL8RT+jSRgHiRmyqJ3wFTp63TRQ
         Yn+/1X5BalFR1JU9KNWUbbesKkIaYGTdQHMzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718343074; x=1718947874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAzRVuGiwiPjuyzyla5fhPiLV7P+Mj2MHeHS/YDHrio=;
        b=Z/jrNiNwCLXzdGW+KB1u+lfOCoCVhsuMesj46ohbO0BaxEwOt8Nrx5oXNf7iLKvLRR
         lycnQ8RqGr/UbS5fBAvChZ59LYm1ulPwBsFnE1Y+J90pTT4DmU8O/NIuG37hGMCMbmwU
         7knj1q642mc1gZgRenALCAmQH8rkywujGX3JBxYiuFyMlwXVGOnd4zqZZ9WPKqrkpQRm
         75gcWHcCVkX56RZ+N9jCPMS5LmErOI/ih5RYjVxMhtjdAl1VmU5v9EA+rRIEUn+1/PM6
         wQVwFRflLyiMUYOLfTES9SV/nityUAJxJBt926x9HPQiNmbdG0xcIheKb+nOOmn0MmAj
         PcUA==
X-Forwarded-Encrypted: i=1; AJvYcCXOeqJV9pVUEImb4ugpPwQmvHDIHT31CeFRJbgyOm1kpeXN1DexIOOE6ne+uqxOZoayYJWFspBYZ5qL9iocJ1v6sK9/mfUu2U0QdgMd
X-Gm-Message-State: AOJu0YxpLkO+eFSAMhjZAPnaPu90lo8y3kNK+Wcwros6yPHUXrSMQlrJ
	7dKETzyaVEHBFsnLzrJiLKymauBLmB3O10RrvL11uYUXW+NW6En0c7yJggEpAD3oewaqC/TtuWU
	=
X-Google-Smtp-Source: AGHT+IEPAopWXgVdFsrPU52iQbDb8e6jDzC7bOOXcHsj4ssPn3xyg7Zl+WfquFEcWNc07XkYD/ktmw==
X-Received: by 2002:a05:6870:2012:b0:250:7b2f:f273 with SMTP id 586e51a60fabf-25842c1376fmr1664164fac.53.1718343073742;
        Thu, 13 Jun 2024 22:31:13 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:3d3b:dde3:8620:4416])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb414fesm2250205b3a.133.2024.06.13.22.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 22:31:13 -0700 (PDT)
Date: Fri, 14 Jun 2024 14:31:08 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jisheng Zhang <jszhang@kernel.org>, Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: use copy_page for full page copy
Message-ID: <20240614053108.GC479513@google.com>
References: <20240613000422.1918-1-jszhang@kernel.org>
 <ZmvUMPc1eEOwUo7h@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmvUMPc1eEOwUo7h@infradead.org>

On (24/06/13 22:25), Christoph Hellwig wrote:
> On Thu, Jun 13, 2024 at 08:04:22AM +0800, Jisheng Zhang wrote:
> > commit 42e99bd975fd ("zram: optimize memory operations with
> > clear_page()/copy_page()") optimize page copy/clean operations, but
> > then commit d72e9a7a93e4 ("zram: do not use copy_page with non-page
> > aligned address") removes the optimization because there's memory
> > corruption at that time, the reason was well explained. But after
> > commit 1f7319c74275 ("zram: partial IO refactoring"), partial IO uses
> > alloc_page() instead of kmalloc to allocate a page, so we can bring
> > back the optimization.
> > 
> > commit 80ba4caf8ba9 ("zram: use copy_page for full page copy") brings
> > back partial optimization, missed one point in zram_write_page().
> > optimize the full page copying in zram_write_page() with copy_page()
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  drivers/block/zram/zram_drv.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > index 3acd7006ad2c..4b2b5098062f 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -1478,11 +1478,13 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
> >  	dst = zs_map_object(zram->mem_pool, handle, ZS_MM_WO);
> >  
> >  	src = zstrm->buffer;
> > -	if (comp_len == PAGE_SIZE)
> > +	if (comp_len == PAGE_SIZE) {
> >  		src = kmap_local_page(page);
> > -	memcpy(dst, src, comp_len);
> > -	if (comp_len == PAGE_SIZE)
> > +		copy_page(dst, src);
> >  		kunmap_local(src);
> > +	} else {
> > +		memcpy(dst, src, comp_len);
> > +	}
> 
> I know this is pre-existing code, but why do we need to kmap
> for comp_len == PAGE_SIZE and not for the other cases?  Something
> feels really obsfucated here.

It is tricky a little.

If we managed to compress page (size < zsmalloc uncompressible watermark)
then src is per-CPU buffer with compressed data.  Otherwise src is original
page (with uncompressed data).

