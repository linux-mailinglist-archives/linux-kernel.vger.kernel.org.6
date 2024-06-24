Return-Path: <linux-kernel+bounces-227794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4760E9156A5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36EA283EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A746B2556F;
	Mon, 24 Jun 2024 18:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+OMSpdt"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE2420DC5
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 18:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719254872; cv=none; b=dIEIXicoPav+ZbqNpKpt4ke0Aeq2/3CTEs3anEPiErAftJX14PBSe0tsIyr1KlUIvFUAKRVePasXLF0i8w5UxuyUtQIrTiuXurK18SPkwkvnV8ywdnUJipg4sjMQjOV1PSXQZKMJqMadKFmY4rs/A02S+D77PMuzEykhdy6Rmcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719254872; c=relaxed/simple;
	bh=kJYf+C112TAjceXL+gcnYsR/gCwwgpZzPUx14B88diY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/l2gIxfmkR6GQqvajEj4UoD7nDZnV//rWnhQrYA/IuAZxyhpPkzMGlCJsGPc47Ggu2gUnMZw0QiYD1GFQPS762P9fJCd7QksTODe8FuRhbwAczRMNYljEnHtJBeXYQ9F8gSfFl/0KUS5va+EZgxTqQcSydipEfqEUOxtQDkXEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+OMSpdt; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7152e097461so2910720a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719254871; x=1719859671; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X75dQKiSOlUCy9pmmHYzWRn/NUnCJh7U1nH+dGZQbWw=;
        b=Z+OMSpdtvi1JhTDpydK3X8rBctXR4tGKeg9vNuviFPnSPQYm30/HdUhfcj+ajTGJpq
         Mo9iqiuVvTi6uEOsJoE2K7NWTTEUoh5bmB28ckxIMf/14lsFeJzgpcUhL/OPy4HaiU6z
         XNzhFgrFk0AnJDO/Ji6CzT9jEPIFwBZSwvrd3nF45yQsbUVqMw09oR4RKGs0BRHRGMDt
         7FRgjns0RO4ShaJ2045y2tBWOom2nyNPjUhE0NKIzhsaVqYy378jWZxpNfTaFVSTYY0U
         mOIyO47CGDu1SI7Pn71nzhUIJUUNG8CHeQ4kmeaoc9gL+xcchRSiDRvIfgRyGQLdtUqm
         FIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719254871; x=1719859671;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X75dQKiSOlUCy9pmmHYzWRn/NUnCJh7U1nH+dGZQbWw=;
        b=kOVwPnkBh3gS7tQCVPJ00SBLB04cJ9Jze3DNwRKheClYuexnTNR7D40nSvV7x2RIY0
         0kBMURJB620RFcDbhLUeHcikA7SEsanjwDSxlJjauQnZm6bvC4YaqcixNKaW3e6buGz5
         p2AfKKy1uE9unBnMwVILMwBECHnX3esA6SNrZwwQ9/SVsXBb9qrineYEGJ0kiPGtGQlm
         OgmK9A1hd7TRONATQZOfNkdZQROF/ACBYXvHI69uILdofnBVWZ2dXnnuVe8SkFqEF/fP
         WyWHP7LE2UfWRaUUWkYfjDm2CvqekEhYSESkizAkrMlbHPrtpx9HOioTpdDQb4LEJBeN
         SBFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFpk5fuRa0Hx6wDp9a7AFzADhqLxW5WXvAcDmikKekj7RlunFvmJBW/o2VdpfFY7h2UG4fWkqGy6HDLl+S3dSTVeBhkPGy3/1ym7mu
X-Gm-Message-State: AOJu0YztZTg89lhIfqikFQq5mAsYCaNaJoVg4VZT5hw1apD7alSObNuZ
	/3/FJmTPkAm39hdp2YUTeRdttcbdktqDqP9bs/ds5G7mxL7IJKnG+5TSsHTMEQy43tkTR+5vlZd
	MtWujUb2HAUJDMwgKGrLkHx/oPsg=
X-Google-Smtp-Source: AGHT+IFgOFjVt4F9SvTNmHw1kNtIdzEuhWllPnK9yKggF6ZIlzq+iY+QwBn6jG/xblVw3e5Hd8NuC11DruE/SUilaI0=
X-Received: by 2002:a17:90b:3008:b0:2c8:7fad:b96c with SMTP id
 98e67ed59e1d1-2c8a2356842mr1895255a91.9.1719254870671; Mon, 24 Jun 2024
 11:47:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240519165321.2123356-1-sui.jingfeng@linux.dev>
In-Reply-To: <20240519165321.2123356-1-sui.jingfeng@linux.dev>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Mon, 24 Jun 2024 20:47:39 +0200
Message-ID: <CAH9NwWeioHvvvK1SSJMzm3VAkRLtOSOQwys99ZO-mO3DvzYcyQ@mail.gmail.com>
Subject: Re: [etnaviv-next v14 0/8] drm/etnaviv: Add driver wrapper for
 vivante GPUs attached on PCI(e) device
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

Hi

>
> drm/etnaviv use the component framework to bind multiple GPU cores to a
> virtual master, the virtual master is manually create during driver load
> time. This works well for various SoCs, yet there are some PCIe card has
> the vivante GPU cores integrated. The driver lacks the support for PCIe
> devices currently.
>
> Adds PCIe driver wrapper on the top of what drm/etnaviv already has, the
> component framework is still being used to bind subdevices, even though
> there is only one GPU core. But the process is going to be reversed, we
> create virtual platform device for each of the vivante GPU IP core shipped
> by the PCIe master. The PCIe master is real, bind all the virtual child
> to the master with component framework.
>
>
> v6:
>         * Fix build issue on system without CONFIG_PCI enabled
> v7:
>         * Add a separate patch for the platform driver rearrangement (Bjorn)
>         * Switch to runtime check if the GPU is dma coherent or not (Lucas)
>         * Add ETNAVIV_PARAM_GPU_COHERENT to allow userspace to query (Lucas)
>         * Remove etnaviv_gpu.no_clk member (Lucas)
>         * Fix Various typos and coding style fixed (Bjorn)
> v8:
>         * Fix typos and remove unnecessary header included (Bjorn).
>         * Add a dedicated function to create the virtual master platform
>           device.
> v9:
>         * Use PCI_VDEVICE() macro (Bjorn)
>         * Add trivial stubs for the PCI driver (Bjorn)
>         * Remove a redundant dev_err() usage (Bjorn)
>         * Clean up etnaviv_pdev_probe() with etnaviv_of_first_available_node()
> v10:
>         * Add one more cleanup patch
>         * Resolve the conflict with a patch from Rob
>         * Make the dummy PCI stub inlined
>         * Print only if the platform is dma-coherrent
> V11:
>         * Drop unnecessary changes (Lucas)
>         * Tweak according to other reviews of v10.
>
> V12:
>         * Create a virtual platform device for the subcomponent GPU cores
>         * Bind all subordinate GPU cores to the real PCI master via component.
>
> V13:
>         * Drop the non-component code path, always use the component framework
>           to bind subcomponent GPU core. Even though there is only one core.
>         * Defer the irq handler register.
>         * Rebase and improve the commit message
>
> V14:
>         * Rebase onto etnaviv-next and improve commit message.
>
> Tested with JD9230P GPU and LingJiu GP102 GPU.
>

I was able to test this series and will do a review in the next few
days. Hopefully this series will land anytime.

[    6.783267] etnaviv 0000:0c:00.0: enabling device (0000 -> 0003)
[    6.783324] etnaviv 0000:0c:00.0: JingJia Micro JM9100 has 1 GPU cores
[    6.783459] etnaviv 0000:0c:00.0: bound etnaviv-gpu,3d.0 (ops
gpu_ops [etnaviv])
[    6.783502] etnaviv-gpu etnaviv-gpu,3d.0: model: GC9200, revision: 6304
[    6.783635] [drm] Initialized etnaviv 1.4.0 20151214 for
0000:0c:00.0 on minor 1

Tested-by: Christian Gmeiner <cgmeiner@igalia.com>


> Sui Jingfeng (8):
>   drm/etnaviv: Add a dedicated helper function to get various clocks
>   drm/etnaviv: Add constructor and destructor for the
>     etnaviv_drm_private structure
>   drm/etnaviv: Embed struct drm_device into struct etnaviv_drm_private
>   drm/etnaviv: Fix wrong cache property being used for vmap()
>   drm/etnaviv: Add support for cached coherent caching mode
>   drm/etnaviv: Replace the '&pdev->dev' with 'dev'
>   drm/etnaviv: Allow creating subdevices and pass platform specific data
>   drm/etnaviv: Add support for vivante GPU cores attached via PCIe
>     device
>
>  drivers/gpu/drm/etnaviv/Kconfig              |   8 +
>  drivers/gpu/drm/etnaviv/Makefile             |   2 +
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c        | 159 ++++++++++------
>  drivers/gpu/drm/etnaviv/etnaviv_drv.h        |  27 +++
>  drivers/gpu/drm/etnaviv/etnaviv_gem.c        |  22 ++-
>  drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c |   2 +-
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c        | 144 +++++++++-----
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.h        |   4 +
>  drivers/gpu/drm/etnaviv/etnaviv_mmu.c        |   4 +-
>  drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c    | 187 +++++++++++++++++++
>  drivers/gpu/drm/etnaviv/etnaviv_pci_drv.h    |  18 ++
>  include/uapi/drm/etnaviv_drm.h               |   1 +
>  12 files changed, 468 insertions(+), 110 deletions(-)
>  create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c
>  create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.h
>
>
> base-commit: 52272bfff15ee70c7bd5be9368f175948fb8ecfd
> --
> 2.34.1
>


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy

