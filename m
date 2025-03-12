Return-Path: <linux-kernel+bounces-557292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D661A5D6B5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 07:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E09189C420
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F2E1E5B70;
	Wed, 12 Mar 2025 06:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKupKixu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072B61E5B6F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 06:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741762630; cv=none; b=KEv8MnGC6nlMh0jTx4Skn/ZWdqqaCg9wQx0LZAa/e/XdyVAJgavMWc1RT+KjIPHxuQrtNPOke0bwXrRLvwA0U//IJFEIt6Vy9oYXJrFVTMD005bt+gylIthvCGsmeXqupexs9q9bhpgeLRcPRk1m/ZxJyJzHSR011dkBaNAK4qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741762630; c=relaxed/simple;
	bh=CGj6X8im0j6eyvz1ZiOGqKpsN+vOoTYaN9QnyzioSZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyjF/tfi7+PcKXPwpxM+Adm0Nq4BhXnVufG+eKtbG/kFOBmvBjgncGMK8a/tlnt7MErLBDe38jnisgLeLEUkqahGP6Ln/azOV7VQ85pcDxxIkuthmhMb+7BSbasKHvuelerOKxny34QXDXJv5S6kjW5ph9Uwjropx2xcFEKfGZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cKupKixu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741762628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ngFN5P8pa+SiEt1Ew8FmKgFK9481luIZ3P3zqtJw6G4=;
	b=cKupKixu0pgM283QzKnMquaa5FimMxsNLQ0DlUX9AqzxUd1Z+BhHVgqvK/sofj9531xrkC
	odUR3qPy75F2jveM/MbWPSFK9hIfAoHvKdnqw7LJknX6T6bG2CUJFrtMf1Xlo7zWTn1st/
	024yWaJuEejvHTD6nKyezq7NMmxUYCI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-FV0nGbm5NJGyn01jtftntg-1; Wed, 12 Mar 2025 02:57:06 -0400
X-MC-Unique: FV0nGbm5NJGyn01jtftntg-1
X-Mimecast-MFC-AGG-ID: FV0nGbm5NJGyn01jtftntg_1741762625
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-438da39bb69so44446455e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 23:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741762625; x=1742367425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngFN5P8pa+SiEt1Ew8FmKgFK9481luIZ3P3zqtJw6G4=;
        b=NzJ2a40JCDoqdUTpp1sHxJYSYgV0WFJPUISYKcADuJ/QqRVwdtsXf1tFexZoLsSL9+
         8h+AhpLv9WjBxeRp+TE/C80qvmsTq4ImiBTKbDF2063PrLJ8nmsMbaEQOTyPCVw4eUV6
         jwxKuXCae24JpwzUbFYLUUZwVaVLWmwKwUae2zOsDZUbb9jOBlp4mEC2A6j6kmn/WwIs
         0EhggDsDu6jOdawdFfo6/xksh8ImPTV5c1K97r8FD9gcA3Kp5NCBqibBS7qF4dDBdnIt
         bo1yyLkeX1z7DqvA55M92g/i8QSCwHMj0Kufi3AoOFp+G6eylLbeAEuFOi4nFg1wxQtL
         015w==
X-Forwarded-Encrypted: i=1; AJvYcCUDbkDUe1Bkb3m4JIR52WjjHbjqL3cwSNhMIMBVdAL9T55HgTJGtztuKPGShraCICGVwVfkS4l3B9msdmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhtCRsO8I4kFiACEduFiWy9sRtQPCK/4Zdt4oOunZRptpkTYPP
	7NTZphi0aLmAJu5dxRYYoSGBafc9i2nr9bfNW7OELqTENm3DHrwspT6vPohX7xK/swLZ78kaFgn
	jZPwjyWtJqV0l+TZQYBsB3uoTHos5Uff+NzBFr4n+EOobr/TUvg8QHobep3nzeA==
X-Gm-Gg: ASbGncsr8a8jSTR8Ir7VQbGXFIxUdLnZhjqIERcRqWnf5WZuMJhx6aVgXefTW6LH9ur
	dsKNWtrhgYKoqxjkLod42X5z1sjMIWGHcIAFrKwrmQSQ24ZYu7f/BdSu+f025bwPd6+9OPZoAaf
	5dMWykilNlnRQBloPJDhCP0A4izADpccMg3l54Q1bToJzJr7kIAiwt+A8Hj4MB0eR1zsnL1mSdQ
	C/eBMXo1Nu6Ai4O89GMhHFNo3pWszmN+oAtTxEZvhybZOTQ4LtqmYXT6W3uqjT6ADAnyRSNkt9t
	szsFDvBgkw==
X-Received: by 2002:a05:600c:5618:b0:43b:ce3c:19d0 with SMTP id 5b1f17b1804b1-43cdfb7db88mr143183295e9.29.1741762625056;
        Tue, 11 Mar 2025 23:57:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXQUbnjKhdX7cSTwHc/sH5KUBC9yqYpY1/TKqBEmz2tDiKoCFs3roMwKysiE2/kbKi5UsENQ==
X-Received: by 2002:a05:600c:5618:b0:43b:ce3c:19d0 with SMTP id 5b1f17b1804b1-43cdfb7db88mr143183025e9.29.1741762624636;
        Tue, 11 Mar 2025 23:57:04 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a731031sm11806955e9.7.2025.03.11.23.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 23:57:03 -0700 (PDT)
Date: Wed, 12 Mar 2025 02:56:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com,
	jerrin.shaji-george@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de,
	gregkh@linuxfoundation.org, david@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgross@suse.com,
	sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, nphamcs@gmail.com, yosry.ahmed@linux.dev,
	kanchana.p.sridhar@intel.com, alexander.atanasov@virtuozzo.com
Subject: Re: [RFC 4/5] vmx_balloon: update the NR_BALLOON_PAGES state
Message-ID: <20250312025607-mutt-send-email-mst@kernel.org>
References: <20250312000700.184573-1-npache@redhat.com>
 <20250312000700.184573-5-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312000700.184573-5-npache@redhat.com>

On Tue, Mar 11, 2025 at 06:06:59PM -0600, Nico Pache wrote:
> Update the NR_BALLOON_PAGES counter when pages are added to or
> removed from the VMware balloon.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  drivers/misc/vmw_balloon.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> index c817d8c21641..2c70b08c6fb3 100644
> --- a/drivers/misc/vmw_balloon.c
> +++ b/drivers/misc/vmw_balloon.c
> @@ -673,6 +673,8 @@ static int vmballoon_alloc_page_list(struct vmballoon *b,
>  
>  			vmballoon_stats_page_inc(b, VMW_BALLOON_PAGE_STAT_ALLOC,
>  						 ctl->page_size);
> +			mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
> +				vmballoon_page_in_frames(ctl->page_size));


same issue as virtio I think - this counts frames not pages.

>  		}
>  
>  		if (page) {
> @@ -915,6 +917,8 @@ static void vmballoon_release_page_list(struct list_head *page_list,
>  	list_for_each_entry_safe(page, tmp, page_list, lru) {
>  		list_del(&page->lru);
>  		__free_pages(page, vmballoon_page_order(page_size));
> +		mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
> +			-vmballoon_page_in_frames(page_size));
>  	}
>  
>  	if (n_pages)
> @@ -1129,7 +1133,6 @@ static void vmballoon_inflate(struct vmballoon *b)
>  
>  		/* Update the balloon size */
>  		atomic64_add(ctl.n_pages * page_in_frames, &b->size);
> -


unrelated change

>  		vmballoon_enqueue_page_list(b, &ctl.pages, &ctl.n_pages,
>  					    ctl.page_size);
>  
> -- 
> 2.48.1


