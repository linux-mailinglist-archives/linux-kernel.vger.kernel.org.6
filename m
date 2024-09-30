Return-Path: <linux-kernel+bounces-344146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7878F98A561
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003B91F25431
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BD518FC79;
	Mon, 30 Sep 2024 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T9pDMmXe"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878482AE8E
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703221; cv=none; b=RfPuB2CF8a2Px2qQOgfyWDxOw+driqmGgxNTgPRotWwPfhMvfDH5GItJAAv6nY6EAibRV7kivebkYEcdTSFhyu1i+8GtHlIPSdVliLfTTpi8VXIyQ84qhYfCO8irLvU0ix0F+FSKCyPyN0a8K8V8D4pYM3OGHg4pSs6eTFaLbOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703221; c=relaxed/simple;
	bh=AdETirvF3wcdOb3DW5GCvr469kBotBZhk+1MCxQyejk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gId7dVPSx1EvXoCx0qi4OqyGRMtVQHaXLK2n00MTCJIE5I4+cCa9tHdlZek9N0C2wDwiV8pr5N8DVw2YHS//FJoF7JaLM07iiLODZHN9yn/HzJJTuF0g3uZqO75/bvYe0gulUwWMaRhDG5nZ5rKaohJQzmdHNEfxcHPGadxYzEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T9pDMmXe; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cb1dd2886so267125e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 06:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727703218; x=1728308018; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3VVCxvZrybUBrzJDdX4zyvndOPszmnOFeDIEh38tMFA=;
        b=T9pDMmXenKluO+oPjkfpTVlkeeF73aLDBSev9V6+zCu6WEX4krlmTVQpvYQ3qRoouF
         8w5vF17/GM9pOTt5ZGNzyKbWcci/qmz432sr4wx9NFCe2gVmoLgv68dRY2RLb6NsXX76
         Tmz2kyPHehYvSX4J2dfNjpH1P9PAzjYDp9+WTJAnVx3HPpseN3gzJK4t+KkESlakXuHn
         KcsPaFT8M4YuL9NCcsDQjSxC3fvpIDUsA/DZu6/QU7DZsHjM6nHM6kiD4t8fo5/V+t1D
         SA7v4oRUt2TWr5rjTJbR3A6gBaAwDbjgtR6AmK593HPFE07Pp4oRVLbs5XQ82zwLYzIv
         RSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727703218; x=1728308018;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3VVCxvZrybUBrzJDdX4zyvndOPszmnOFeDIEh38tMFA=;
        b=V+JpFceHtkoWHO8TBcRN7FoZNkRnA52KH+s/A1ix9t3wFFQiOPQAsQU+Jqj0Du0pVt
         wanMzZzfgWh7NhdI7Y1E8hbRqQleOLEMmAwSiSTiEwiPwOK62Op5/z32ESiKtmsEJz+n
         HmluLr1y/QtLKdRuRm6+4SGafWGKzMbneqjglcsdbRd9ftW1pbCQmsLVJSybk4TwW/sk
         y+17FjqHlwgXH/rN3/Nncf8TGwlHSRRNhE74FBXshUUcK+yWNYm+ZZZu3vTAQy8Z9ufn
         N3fzvfhuloZIieoHkiC3iSEgRDotI9wrfCXTz5zuAL/K4q4MjV01FM/8f+T9yPvBVDbw
         99GA==
X-Forwarded-Encrypted: i=1; AJvYcCVxNt6FQAioYhQYxrthwdbQA8S4D5udOm2JEhrY4EeIbYsErmywOzjBuE+/K3+1dyXdmurG5e/8c6ArnqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPAx70gtzC6YmhCCUNwpGMbdnS29AttLxJPogDril3zvSG8GlB
	BhKIyz7boszYlK8I5P44TdiYxXkXNIua9XlP9+A+QDZ9hRdYPxKrm5gA+d6wvA==
X-Google-Smtp-Source: AGHT+IFMH5L0pvpmEOu9B/xo7F1qms5sXo0CY3+b4sAlhT15NuJIZjNjckS85DY40ep0tj6rvI/YIQ==
X-Received: by 2002:a05:600c:4e16:b0:426:6edd:61a7 with SMTP id 5b1f17b1804b1-42f5f860051mr4781325e9.7.1727703217493;
        Mon, 30 Sep 2024 06:33:37 -0700 (PDT)
Received: from google.com (105.93.155.104.bc.googleusercontent.com. [104.155.93.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd565e767sm9094454f8f.38.2024.09.30.06.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:33:36 -0700 (PDT)
Date: Mon, 30 Sep 2024 13:33:32 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: kvm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>, kwankhede@nvidia.com,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Quentin Perret <qperret@google.com>
Subject: Re: [RFC] Simple device assignment with VFIO platform
Message-ID: <ZvqorIqETNmk4V4p@google.com>
References: <CAFgf54rCCWjHLsLUxrMspNHaKAa1o8n3Md2_ZNGVtj0cU_dOPg@mail.gmail.com>
 <0e87a96a-98ed-48ad-9235-900d46fe5400@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e87a96a-98ed-48ad-9235-900d46fe5400@redhat.com>

Hi Eric,

On Mon, Sep 30, 2024 at 03:05:38PM +0200, Eric Auger wrote:
> Hi Mostafa,
> 
> On 9/27/24 18:17, Mostafa Saleh wrote:
> > Hi All,
> >
> > Background
> > ==========
> > I have been looking into assigning simple devices which are not DMA
> > capable to VMs on Android using VFIO platform.
> >
> > I have been mainly looking with respect to Protected KVM (pKVM), which
> > would need some extra modifications mostly to KVM-VFIO, that is quite
> > early under prototyping at the moment, which have core pending pKVM
> > dependencies upstream as guest memfd[1] and IOMMUs support[2].
> >
> > However, this problem is not pKVM(or KVM) specific, and about the
> > design of VFIO.
> >
> > [1] https://lore.kernel.org/kvm/20240801090117.3841080-1-tabba@google.com/
> > [2] https://lore.kernel.org/kvmarm/20230201125328.2186498-1-jean-philippe@linaro.org/
> >
> > Problem
> > =======
> > At the moment, VFIO platform will deny a device from probing (through
> > vfio_group_find_or_alloc()), if it’s not part of an IOMMU group,
> > unless (CONFIG_VFIO_NOIOMMU is configured)
> >
> > As far as I understand the current solutions to pass through platform
> > devices that are not DMA capable are:
> > - Use VFIO platform + (CONFIG_VFIO_NOIOMMU): The problem with that, it
> > taints the kernel and this doesn’t actually fit the device description
> > as the device doesn’t only have an IOMMU, but it’s not DMA capable at
> > all, so the kernel should be safe with assigning the device without
> > DMA isolation.
> >
> > - Use VFIO mdev with an emulated IOMMU, this seems it could work. But
> > many of the code would be duplicate with the VFIO platform code as the
> > device is a platform device.
> >
> > - Use UIO: Can map MMIO to userspace which seems to be focused for
> > userspace drivers rather than VM passthrough and I can’t find its
> > support in Qemu.
> In case you did not have this reference, you may have a look at Alex'
> reply in
> https://patchew.org/QEMU/1518189456-2873-1-git-send-email-geert+renesas@glider.be/1518189456-2873-5-git-send-email-geert+renesas@glider.be/
> >
> > One other benefit from supporting this in VFIO platform, that we can
> > use the existing UAPI for platform devices (and support in VMMs)
> >
> > Proposal
> > ========
> > Extend VFIO platform to allow assigning devices without an IOMMU, this
> > can be possibly done by
> > - Checking device capability from the platform bus (would be something
> > ACPI/OF specific similar to how it configures DMA from
> > platform_dma_configure(), we can add a new function something like
> > platfrom_dma_capable())
> >
> > - Using emulated IOMMU for such devices
> > (vfio_register_emulated_iommu_dev()), instead of having intrusive
> > changes about IOMMUs existence.
> >
> > If that makes sense I can work on RFC(I don’t have any code at the moment)
> So if I understand correctly, assuming you are able to safely detect the
> device is not DMA capable you would use the
> 
> vfio_register_emulated_iommu_dev() trick. Is that correct?

Yes, my guess the challenge here would be discovering that through the
platform bus.

Thanks,
Mostafa

> 
> Thanks
> 
> Eric
> 
> >
> > Thanks,
> > Mostafa
> >
> 

