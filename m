Return-Path: <linux-kernel+bounces-557291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D380A5D6AF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 07:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37233B3295
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364A71E8351;
	Wed, 12 Mar 2025 06:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFG/tEGR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297A81E5B6F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 06:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741762558; cv=none; b=HXHNQjglpApGobBy7vuSwymkBB35FjeoHVYZPp0aSh/36BoRtnh4wcefV5H5yR6gjlmfSTQ+RebAOmj8TY1TMkoTLcwgHSuxH+53k5Ta3FSsmq9eC5SmOsdtY9EMoqKK4xAFEcktDB7axBs08rRgXFS/IaIvtFXwF5/zjEx2BvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741762558; c=relaxed/simple;
	bh=mmZWO8rrKBhcxVobJcb1/dMSVYN+sIlK9Rb8Ecs/XBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5muCKinNRFVLScbwgnFzgKOATOUwxj1MqofnBP87frUq/TmBko1QrVTF8ykZzamqxaTrBoVME079wgNbuqR64oTI1mCM+aOt7EfX8NTm7XhLspCxVQ49NlydccOLK5ZwPHj/f7eu2Awm4EUaVv28istgkVy82Mw93raorYBR38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XFG/tEGR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741762556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M5urNoJLNtNizXgsJBqJ+K7FyEmcih4A00lRbzK+XcU=;
	b=XFG/tEGRGpxP5VwnKrQ6M6cP7pt0CpEdnPeI/f7zKLVyjOHR5CIR0KXpyVcdM1N0UxvUNx
	dZ96YvZ/Gxl6v8Ge1gBFw/AEnRTuFakuUNnjDj+cAUN4xm611kkcdf1uL1k2ZDda8dZ9WN
	Wmm7O358DKvpalSbON6ut34W3lwUIf4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-SPtoI_d6N8CkFqVklyj74A-1; Wed, 12 Mar 2025 02:55:53 -0400
X-MC-Unique: SPtoI_d6N8CkFqVklyj74A-1
X-Mimecast-MFC-AGG-ID: SPtoI_d6N8CkFqVklyj74A_1741762552
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43ce245c5acso31967345e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 23:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741762551; x=1742367351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5urNoJLNtNizXgsJBqJ+K7FyEmcih4A00lRbzK+XcU=;
        b=G2APq84mDQZZIcV9nLZzTKA66UlWvHUt3MTlpa1dTKVYe9b7Hp0khrRsj+XDA0Uu6s
         seYBwhPT9FLDw3OUckc1Mtqw6GUVQj5d8OMq17dzX6Uvrtak/QKf/2qwS4TbCnyJhSDm
         LIebxO+prsI0FLXyGR34RQsooiQxktHQdINR9c1GyX8fKe9hPguLczFt+4m6HLfVm3W8
         hBztDmW/ZNqlnYweHCfMAY06Dkb4jmBE98fl2csok/nHq/gMbhhuGaiP8Zb5NumI8nLp
         3jJcssHeTm44tHBus/nrtONSB+EcNOAEinH9dRWrBnIcqkjDQ5K0ZRdHUGXzp+xyoOsm
         2WEA==
X-Forwarded-Encrypted: i=1; AJvYcCVSOXYo6io/xeI4tgt8zLpuseaM8TditY4BresmobJwxGqXQCgyHu8ONWpZLBg/hJV9iEixjailyMxMeF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy460vmN+WgEpsQIFP41YJFwn8Q26z+kp3RrdaWhjYchjzSurcj
	AdST80n34Fjuz/cugnRTxD3h1t+V/A4R49t866bBr6jCh+x53Bzm8bxbcbvWGjKf/qQ7m7+BQ0G
	FHxciRVC26u1c4LrLsioY0kGMyqWy3lt1Co6BktEGMtpUipZLJDQ2eP6GIAf79nndzTkEwg==
X-Gm-Gg: ASbGncu5JKaeI6PDHQqa3msh7OuzdHf/g2R7NHL5QGIOu5KqY1m3lTCbIt+SXXqVHNs
	3oNHFHz0Lo3VbPDhlsY5gBTMe6kOLEaToPgF/pefQJnThG6oDLtLQQqKULYE+ZU3v3HSPcHdcnp
	hjsFmwc5FBXepRt1KmX+bJALNX30W6X3ZhN5wwnaGoR9SvfjnUpWQooHw3rR4bsX6omfiFApkE7
	97PVU0OOz5ReeoZ+Ynz/9vMxKo08qU/TeV2IAPFKpGOkJMrliqgPm6DJcUPgDOLSPvKtjyjFtjG
	56sof9Z6pA==
X-Received: by 2002:a05:6000:402a:b0:390:ed05:aa26 with SMTP id ffacd0b85a97d-39132d30c22mr15005784f8f.5.1741762551528;
        Tue, 11 Mar 2025 23:55:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDerobH2f/muGrjnyAjilHqba0+0kowFg3s8AIPcyJb001SG0K4ObuoiA+X/VxHvC5d0rDfQ==
X-Received: by 2002:a05:6000:402a:b0:390:ed05:aa26 with SMTP id ffacd0b85a97d-39132d30c22mr15005774f8f.5.1741762551189;
        Tue, 11 Mar 2025 23:55:51 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-394a8a5a304sm565705f8f.40.2025.03.11.23.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 23:55:50 -0700 (PDT)
Date: Wed, 12 Mar 2025 02:55:45 -0400
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
Subject: Re: [RFC 2/5] virtio_balloon: update the NR_BALLOON_PAGES state
Message-ID: <20250312025331-mutt-send-email-mst@kernel.org>
References: <20250312000700.184573-1-npache@redhat.com>
 <20250312000700.184573-3-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312000700.184573-3-npache@redhat.com>

On Tue, Mar 11, 2025 at 06:06:57PM -0600, Nico Pache wrote:
> Update the NR_BALLOON_PAGES counter when pages are added to or
> removed from the virtio balloon.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  drivers/virtio/virtio_balloon.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 89da052f4f68..406414dbb477 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -274,6 +274,8 @@ static unsigned int fill_balloon(struct virtio_balloon *vb, size_t num)
>  
>  		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
>  		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE;
> +		mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
> +			VIRTIO_BALLOON_PAGES_PER_PAGE);
>  		if (!virtio_has_feature(vb->vdev,
>  					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
>  			adjust_managed_page_count(page, -1);


This means the counter is in virtio balloon page units, which
runs counter to the declared goal of making the interface
hypervisor-agnostic.


> @@ -324,6 +326,8 @@ static unsigned int leak_balloon(struct virtio_balloon *vb, size_t num)
>  		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
>  		list_add(&page->lru, &pages);
>  		vb->num_pages -= VIRTIO_BALLOON_PAGES_PER_PAGE;
> +		mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
> +			-VIRTIO_BALLOON_PAGES_PER_PAGE);


Same.

Thanks,

>  	}
>  
>  	num_freed_pages = vb->num_pfns;
> -- 
> 2.48.1


