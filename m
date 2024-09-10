Return-Path: <linux-kernel+bounces-323831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 951E79743F7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42A22287490
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B482183CA2;
	Tue, 10 Sep 2024 20:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kv7H5s2Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFDB2AD13
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 20:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725999519; cv=none; b=cwsOzBL+DsOEOHuq/lKaW+A0SzZX2ILs+3HgNXBYi70c16A4zO17Ww7tgvzQHkwhdfJLph+y0F8Sle4dCqcJrdpAIhPiQSayAEIm0gjfIHpdTuALd5OJWh37yN0IxYCX6+QSkpdUgSGp9EQruq2dEzkJK6pie9MmW5MW37X2h6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725999519; c=relaxed/simple;
	bh=TAoZNcbkrffTNjvrTn00faJPH/qZ5L4usm0drwp9xAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/5X2lnwcQdOWZUuQu+hEFzxC9TJwVLwh/sW4fr0gHuRrkJXbupLdv7+Xrmz7sMG3D3CA9YUrvgoqmwGZnI5y6SNDqpmFBoeKczNWI3gd4WBHWJKIZ1STiDtFFj2/zbyLQW+WeWM/77JX8UYNDwNjg6z+UHno0p3X1gci18rZ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kv7H5s2Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725999516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R98WPsv5DcjO+2fj601F0xB34R9dMYvuHz2AKaHWeKU=;
	b=Kv7H5s2QJ2TrkYsUJCQzsjjjtM/sIWPSSXQqM1LCQsvSuYURjRJU35V+MJGtRxKnA9N+RL
	qaJnAjia454MRclbifDpeXsLrgXap6Ouj6VXUQh4nF4rZm5ZvgDP6QmENh05mr6LNKXJf5
	BPZyX2EiFLYExXXTsMw2lLmaA96/uMs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-SiZU81Y4MRuxAEZLyrxIPg-1; Tue, 10 Sep 2024 16:18:35 -0400
X-MC-Unique: SiZU81Y4MRuxAEZLyrxIPg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a868b6d6882so17932166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 13:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725999514; x=1726604314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R98WPsv5DcjO+2fj601F0xB34R9dMYvuHz2AKaHWeKU=;
        b=t8/Na6NB4K37KKLFuOaesIEoCODVpOFo7zAIadT0wyIMQyp+2vbh5T8win51wTPLHe
         bXRyJnd7EqNloZ2GxQ0tq4wU951S6dugLf1xTMPxDZY6RcG7NSLfbb2KqQ8RVZhw9dk6
         v+v8Ji3EjyI/zFoVhtHEtK/atFvS8WKCT1sek2vOpW9YN09MeHknKIsgtzSGYA/ZC5yP
         0zGRzEcr8lL5Sp0ujlGvJUSd1M9DbSnKZADPmUrSgtXijZHf1A4HG3LuHiULZJBIzRWe
         Y6iu3RMh+CEWXCN+YekW6joeq1e4Gk99sAmE9BYrMXXKvxvghyp9w08kwYRBUTJ465Yy
         qzzg==
X-Gm-Message-State: AOJu0YzbzMMFD+ry49EIafaVl2j3vGCkRcDHBIvb1hNjC143meWy5XMO
	a+/RHGd63l94dHbvk8wwv7qp4ff7+Bpyy9KoV+y4DTWFyG+7ikQLyf5LkekjkZlZELVni3P7RhU
	xrlCUUJCgzEwlqSLnGVeNSh72M/hSwaqQbckQ0Scp24/1CGd2S8hROE5TCDmS8w==
X-Received: by 2002:a17:907:d1a:b0:a8a:6bd8:b671 with SMTP id a640c23a62f3a-a8ffaac08abmr220660066b.5.1725999514329;
        Tue, 10 Sep 2024 13:18:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq5fbQ6BGaMv0cPkfGuaqAVwF+zGrA7/gctX0lOfIlCyL/ruUfB8xmIoU+UhSiCOfTzEqhiA==
X-Received: by 2002:a17:907:d1a:b0:a8a:6bd8:b671 with SMTP id a640c23a62f3a-a8ffaac08abmr220656666b.5.1725999513633;
        Tue, 10 Sep 2024 13:18:33 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:f5ce:2d9:5bfa:9916:aa0a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d5da53sm518761066b.209.2024.09.10.13.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 13:18:32 -0700 (PDT)
Date: Tue, 10 Sep 2024 16:18:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 3/5] virtio-mem: s390x support
Message-ID: <20240910161812-mutt-send-email-mst@kernel.org>
References: <20240910191541.2179655-1-david@redhat.com>
 <20240910191541.2179655-4-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910191541.2179655-4-david@redhat.com>

On Tue, Sep 10, 2024 at 09:15:37PM +0200, David Hildenbrand wrote:
> Now that s390x code is prepared for memory devices that reside above the
> maximum storage increment exposed through SCLP, everything is in place
> to unlock virtio-mem support.
> 
> As virtio-mem in Linux currently supports logically onlining/offlining
> memory in pageblock granularity, we have an effective hot(un)plug
> granularity of 1 MiB on s390x.
> 
> As virito-mem adds/removes individual Linux memory blocks (256MB), we
> will currently never use gigantic pages in the identity mapping.
> 
> It is worth noting that neither storage keys nor storage attributes (e.g.,
> data / nodat) are touched when onlining memory blocks, which is good
> because we are not supposed to touch these parts for unplugged device
> blocks that are logically offline in Linux.
> 
> We will currently never initialize storage keys for virtio-mem
> memory -- IOW, storage_key_init_range() is never called. It could be added
> in the future when plugging device blocks. But as that function
> essentially does nothing without modifying the code (changing
> PAGE_DEFAULT_ACC), that's just fine for now.
> 
> kexec should work as intended and just like on other architectures that
> support virtio-mem: we will never place kexec binaries on virtio-mem
> memory, and never indicate virtio-mem memory to the 2nd kernel. The
> device driver in the 2nd kernel can simply reset the device --
> turning all memory unplugged, to then start plugging memory and adding
> them to Linux, without causing trouble because the memory is already
> used elsewhere.
> 
> The special s390x kdump mode, whereby the 2nd kernel creates the ELF
> core header, won't currently dump virtio-mem memory. The virtio-mem
> driver has a special kdump mode, from where we can detect memory ranges
> to dump. Based on this, support for dumping virtio-mem memory can be
> added in the future fairly easily.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
>  drivers/virtio/Kconfig | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 42a48ac763ee..fb320eea70fe 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -122,7 +122,7 @@ config VIRTIO_BALLOON
>  
>  config VIRTIO_MEM
>  	tristate "Virtio mem driver"
> -	depends on X86_64 || ARM64 || RISCV
> +	depends on X86_64 || ARM64 || RISCV || S390
>  	depends on VIRTIO
>  	depends on MEMORY_HOTPLUG
>  	depends on MEMORY_HOTREMOVE
> @@ -132,11 +132,11 @@ config VIRTIO_MEM
>  	 This driver provides access to virtio-mem paravirtualized memory
>  	 devices, allowing to hotplug and hotunplug memory.
>  
> -	 This driver currently only supports x86-64 and arm64. Although it
> -	 should compile on other architectures that implement memory
> -	 hot(un)plug, architecture-specific and/or common
> -	 code changes may be required for virtio-mem, kdump and kexec to work as
> -	 expected.
> +	 This driver currently supports x86-64, arm64, riscv and s390x.
> +	 Although it should compile on other architectures that implement
> +	 memory hot(un)plug, architecture-specific and/or common
> +	 code changes may be required for virtio-mem, kdump and kexec to
> +	 work as expected.
>  
>  	 If unsure, say M.
>  
> -- 
> 2.46.0


