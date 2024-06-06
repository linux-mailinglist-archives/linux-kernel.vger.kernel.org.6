Return-Path: <linux-kernel+bounces-203715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D3E8FDF67
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2B51C2158B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 07:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0196B13B293;
	Thu,  6 Jun 2024 07:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FT9np/9j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13FE13A896
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 07:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717658334; cv=none; b=WN3R5UX4ObHwpV+yOzaDNkrmXtfCvnf3Ksq3s/heXZUZS5O9gJKhiTZiTK8akh+jcmO0rdvVOUtTXrX5lPGm2LyFX2ebcE3ydDLbsjQ1hunjGqCmOtOZECJe4+Gd8IaSaxqDjGp1d6FgpWkxa6g60wtHxxX7d9tPwW3LAbEJnNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717658334; c=relaxed/simple;
	bh=oogjLwTgHPDKdJboP9zTfcvNz3yggXEeinlMPoQL/PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZ9f+bcBF9j8p7xCswJkACZTec9mdKfAlcpF7CQNyCZydhkzRDiIrAVfXL/3a26W2ZAVnhlCv2Pdlzo5nXuLDIS9WiowEwhoGMRh6WDgB6Sf8NGP2rWFl89cXlDQXHmaD5ZVPQZBpejqT9aAQE3ahfFVsktpZ1+vnVjiUb1mLFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FT9np/9j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717658331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DnNgXsFNzCy0InHxHbl/oFWafRsx14xzXtW04Ib8MOQ=;
	b=FT9np/9j2vYAbqI3yCGUNFKdkyHq3Rcmbr2R2PFlAprrjW1B1p+1Pt1G6ruobEf7T/Snan
	qWsUphcHrJwkFdOgXFQZRSoecV4vwXQ3mUnoQCkBXwBQm97CjF4YKZAe+VGltKYxoOKL46
	2gLuiBdvPK8Dy+JQySGtGMVRIcOiU+4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-I5FOl6JAM4iP-fyGtQ_McA-1; Thu, 06 Jun 2024 03:18:45 -0400
X-MC-Unique: I5FOl6JAM4iP-fyGtQ_McA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a68c0bb18e3so16704466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 00:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717658324; x=1718263124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnNgXsFNzCy0InHxHbl/oFWafRsx14xzXtW04Ib8MOQ=;
        b=UtoqcPCsMDjeyGC2PsJdE9hN7xQ4HQTqwDVdVNOlwD5V3rrq13D5M0AHDoXhLe24Ez
         yfsqmoix5TLEh+2Di3XjEW/LrgVGKYNvcP89R3c9WR11vXSsjqnD5ACIrAXijSPI9rFS
         YYHgHMQyK+c93Mnnu4AHmarGYD/HcDWo/IgVnUt3RAIlX21Frjzn7x3DQ4NeASLTf/4K
         vDTaZs+y0OkqzkWnktMa6e375Sli5os7bS90uG+bpobmZOqK8wXtassIKIi5/xhYaf60
         S2DVOrYibAz0I4oJ6auBCpWmIPfFM1dnbXe6kP5NXwEOVGr+BBc/IT9Y8kAxkv0R2/aB
         SrPw==
X-Forwarded-Encrypted: i=1; AJvYcCWdhLHjXMDt4sxA3TduakBkq3g3rya7s8xWORVaQKkGK6kILW6IcbDiNCB01UWDx3HlHixrGZi51oXL05BP0RSfRaBNsrOl7Hd3bgw+
X-Gm-Message-State: AOJu0YznERf9CZi12vaV1RoxpgWnPJA1bh8GpkoL/MwcCH0kgliAFItU
	eAUK7HFl5J4qUp99G0AEnUfNP+z4G50BItQo31+EFKaKey90gCyoAs6zwazwtT/yGhIlnMHk2Yg
	cbNe6d6+fSuGTE/RKyeKsy2WMC4rNxZxmC8K8SQPqp3IcD5OZl6V+UbfY4OP53A==
X-Received: by 2002:a17:906:f28f:b0:a68:dff5:b153 with SMTP id a640c23a62f3a-a699f67ecddmr302761266b.33.1717658324223;
        Thu, 06 Jun 2024 00:18:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ0hybjvC9Ghsz91IEElthfbzx3nnHI0CBKidzNm5YHGJFz2dGcO4+FDkQheBagmgGj19jFA==
X-Received: by 2002:a17:906:f28f:b0:a68:dff5:b153 with SMTP id a640c23a62f3a-a699f67ecddmr302758766b.33.1717658323740;
        Thu, 06 Jun 2024 00:18:43 -0700 (PDT)
Received: from redhat.com ([2.55.59.85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80581716sm54728666b.19.2024.06.06.00.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 00:18:43 -0700 (PDT)
Date: Thu, 6 Jun 2024 03:18:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: cuitao <cuitao@kylinos.cn>
Cc: jasowang@redhat.com, virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/virtio: Use the __GFP_ZERO flag of kmalloc to
 complete the memory initialization.
Message-ID: <20240606031810-mutt-send-email-mst@kernel.org>
References: <20240605135245.14921-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605135245.14921-1-cuitao@kylinos.cn>

On Wed, Jun 05, 2024 at 09:52:45PM +0800, cuitao wrote:
> Use the __GFP_ZERO flag of kmalloc to initialize memory while allocating it,
> without the need for an additional memset call.
> 
> Signed-off-by: cuitao <cuitao@kylinos.cn>
> ---
>  tools/virtio/linux/kernel.h | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
> index 6702008f7f5c..9e401fb7c215 100644
> --- a/tools/virtio/linux/kernel.h
> +++ b/tools/virtio/linux/kernel.h
> @@ -66,10 +66,7 @@ static inline void *kmalloc_array(unsigned n, size_t s, gfp_t gfp)
>  
>  static inline void *kzalloc(size_t s, gfp_t gfp)
>  {
> -	void *p = kmalloc(s, gfp);
> -
> -	memset(p, 0, s);
> -	return p;
> +	return kmalloc(s, gfp | __GFP_ZERO);
>  }


Why do we care? It's just here to make things compile. The simpler the
better.

>  static inline void *alloc_pages_exact(size_t s, gfp_t gfp)
> -- 
> 2.25.1


