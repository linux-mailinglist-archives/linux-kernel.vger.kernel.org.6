Return-Path: <linux-kernel+bounces-344078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A42798A3F0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B193B2449C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFFC18FDB2;
	Mon, 30 Sep 2024 13:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bVKV7mFw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B0818FC89
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 13:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727701550; cv=none; b=SfOt8OAPqWPV4tz2ymoSMPgo2w1kX+H+on6kS7cU7nCoBj6PFZ78BViJ506dQ16XIZqX9KQNewZkOhQqtzCflAzn9CW0EXfpMyEIuCRtz1HlKOVsDOgWLyyuUdQpRRreDbaKkRgKPEsisnUTPNPaPX/Tlwgr4ERZxoJQyflTjGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727701550; c=relaxed/simple;
	bh=hj/SNwljcEycIBCEDJrPTLpUEwkueOxa0HSYZ8D4ub4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKw+0X5rat9Lyjks48THnoUw1eyHdTclkgQcUj09rQeajxXln3kqTN7mPILYkdhFvpl4UA3y12LcWS9/GQ9N4iyNVr/L/f247aN0blFPALWrluCl2wZqDH5nXRUBnL9pklizOe4RmkbTkuzdhT2rMm6uU12E88yLRzONR0giT9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bVKV7mFw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727701547;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hj/SNwljcEycIBCEDJrPTLpUEwkueOxa0HSYZ8D4ub4=;
	b=bVKV7mFwsshfSmvIUMWlU7gzg9ujKXBC/E6RqAvJKLkETuQ+jjync9uscX+QZJLg1wYtBX
	ju58KVhWcH2sqIE8vjT2hkzKN+7I1y1OpYiA9yoUotP1l7/l3FEpKhk4mKFRWXbrO1B48P
	bCP3RkFYWuQjHvELv7Oa5/wl9Ipl7l8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-bIi0eiJ5M_qFYVC-uO7Zkg-1; Mon, 30 Sep 2024 09:05:45 -0400
X-MC-Unique: bIi0eiJ5M_qFYVC-uO7Zkg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb2c5d634so28868935e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 06:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727701543; x=1728306343;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hj/SNwljcEycIBCEDJrPTLpUEwkueOxa0HSYZ8D4ub4=;
        b=hWNqJTs7mwlsx9Z36cddsO7P486j9hi3HPQjFT8w5Vvn1fFqjj1bMjxqv+CaI7tihW
         OdumRlyOLA1CsPTOsR1m6um7WsKEapiuoYGdUO8VAmMRigTFr0np1fHUagD1M2h7mihr
         ++MrWKbsZ51HfXKohZJJyoXj7hdbX30cGyWcSEhrgqmmHclvAdISPkAsehHjg4FghAGH
         6qBSDx887PCD/rx9D9XyZggL5ZbooVWiXx/FhdrzRZ53cM27AbOY1U8mXg4g7D6dVydQ
         rGHEiR4HdlYq+nrEbtS8ixVjE3mHSBDc9kdxOqNc4zTCz4NC8zt/sVcceqCHHN7X12qV
         1T+A==
X-Forwarded-Encrypted: i=1; AJvYcCXc0mqQc/gWFSSwZMesKamte/ahM5qb1cAl61UdliHXixVqgl7SkVi1jXtaQBspcsx9HFam1Mdx5N19wHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmmAq1f5souvluR6eaWAK+T7bf36C8uFyPrQ99hX63PEG2tKDK
	qH8S+aEYNXvGtO4IjiWCeHfd+58O8Qkl11DfxBfAK40XBqr6WYZyPMBtY7iaAm3/0EyfNhTD1M5
	XJCqycxx3jSXKMpKGjallPA0rYZhpdY+QvFidDJ88anOmwJ52ZOoFyd4CbzswW3k7X7Jx3kAf
X-Received: by 2002:a05:600c:3b06:b0:42c:d7da:737b with SMTP id 5b1f17b1804b1-42f58430021mr81419015e9.9.1727701542287;
        Mon, 30 Sep 2024 06:05:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEN2T7BnuOY+eccu/wlVP80snQssOjZepMM/r/Vvdnjg7tLAxJOpAg/1glj/2ePX/3nEJHRMA==
X-Received: by 2002:a05:600c:3b06:b0:42c:d7da:737b with SMTP id 5b1f17b1804b1-42f58430021mr81418535e9.9.1727701541560;
        Mon, 30 Sep 2024 06:05:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969ddadcsm151215335e9.7.2024.09.30.06.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 06:05:40 -0700 (PDT)
Message-ID: <0e87a96a-98ed-48ad-9235-900d46fe5400@redhat.com>
Date: Mon, 30 Sep 2024 15:05:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [RFC] Simple device assignment with VFIO platform
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, kvm@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>, kwankhede@nvidia.com,
 Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
 Quentin Perret <qperret@google.com>
References: <CAFgf54rCCWjHLsLUxrMspNHaKAa1o8n3Md2_ZNGVtj0cU_dOPg@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFgf54rCCWjHLsLUxrMspNHaKAa1o8n3Md2_ZNGVtj0cU_dOPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mostafa,

On 9/27/24 18:17, Mostafa Saleh wrote:
> Hi All,
>
> Background
> ==========
> I have been looking into assigning simple devices which are not DMA
> capable to VMs on Android using VFIO platform.
>
> I have been mainly looking with respect to Protected KVM (pKVM), which
> would need some extra modifications mostly to KVM-VFIO, that is quite
> early under prototyping at the moment, which have core pending pKVM
> dependencies upstream as guest memfd[1] and IOMMUs support[2].
>
> However, this problem is not pKVM(or KVM) specific, and about the
> design of VFIO.
>
> [1] https://lore.kernel.org/kvm/20240801090117.3841080-1-tabba@google.com/
> [2] https://lore.kernel.org/kvmarm/20230201125328.2186498-1-jean-philippe@linaro.org/
>
> Problem
> =======
> At the moment, VFIO platform will deny a device from probing (through
> vfio_group_find_or_alloc()), if it’s not part of an IOMMU group,
> unless (CONFIG_VFIO_NOIOMMU is configured)
>
> As far as I understand the current solutions to pass through platform
> devices that are not DMA capable are:
> - Use VFIO platform + (CONFIG_VFIO_NOIOMMU): The problem with that, it
> taints the kernel and this doesn’t actually fit the device description
> as the device doesn’t only have an IOMMU, but it’s not DMA capable at
> all, so the kernel should be safe with assigning the device without
> DMA isolation.
>
> - Use VFIO mdev with an emulated IOMMU, this seems it could work. But
> many of the code would be duplicate with the VFIO platform code as the
> device is a platform device.
>
> - Use UIO: Can map MMIO to userspace which seems to be focused for
> userspace drivers rather than VM passthrough and I can’t find its
> support in Qemu.
In case you did not have this reference, you may have a look at Alex'
reply in
https://patchew.org/QEMU/1518189456-2873-1-git-send-email-geert+renesas@glider.be/1518189456-2873-5-git-send-email-geert+renesas@glider.be/
>
> One other benefit from supporting this in VFIO platform, that we can
> use the existing UAPI for platform devices (and support in VMMs)
>
> Proposal
> ========
> Extend VFIO platform to allow assigning devices without an IOMMU, this
> can be possibly done by
> - Checking device capability from the platform bus (would be something
> ACPI/OF specific similar to how it configures DMA from
> platform_dma_configure(), we can add a new function something like
> platfrom_dma_capable())
>
> - Using emulated IOMMU for such devices
> (vfio_register_emulated_iommu_dev()), instead of having intrusive
> changes about IOMMUs existence.
>
> If that makes sense I can work on RFC(I don’t have any code at the moment)
So if I understand correctly, assuming you are able to safely detect the
device is not DMA capable you would use the

vfio_register_emulated_iommu_dev() trick. Is that correct?

Thanks

Eric

>
> Thanks,
> Mostafa
>


