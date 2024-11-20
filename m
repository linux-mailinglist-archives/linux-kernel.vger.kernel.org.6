Return-Path: <linux-kernel+bounces-415887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A55E99D3DB7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23333B28FCD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF501AF0A1;
	Wed, 20 Nov 2024 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBLrQpeO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E3B1AA783
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732113058; cv=none; b=eghbfRrLVJXKwNAo6Jl7RvMzhUmKrQl7EztF15oSS+cVk1B+pLBdMC+yrM1+FZ4CGVsha5a4sNoR9ovsb1MQs6o2MOw3vf1uwL0TmT27VzmOPsUYb1YjH9PfZEYoQDKzGkLLAR0Aw6w6Ijw2EMdzIimIQkF3jpktQQzfue0mhcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732113058; c=relaxed/simple;
	bh=5pmYZbvrLupwj4BJfJQOcTaV2EEDO5P+XVwKmsfrkH0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fwUxVRltQnfMQ0eiprdMV/03jY8wIg01bDUHl1tskq3cOtLriPVrfokEZELPj5z/n0gH0klGVBzNL1JiqVV6qV5Iz/sIWYZJb5huetK4pa8Qh0MM9KJcHVKoFuct9vr0Hvev3SfRhJumyhJpsL5JwfzIYMuT/YTNB0woDTcF1Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QBLrQpeO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732113056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vMaVfU9xtl9jCnZwV3bp7ALlJWztWPDTsfcs4kOcUr4=;
	b=QBLrQpeOh/zCDpXaAIyPxhnVuqJPhY744S8xVsDhjUIsgC9HFvahSWo+UCigZUb8Xug6oZ
	BQekXyPRB84IDPM1PLdHkgEzVzdVkWUrBD4V2laLN5NTPOkDo9K05eNEJIqdKVNwqQHK8D
	9yiVLZ9VNbFKNdekYvPsI33D1eJ/Pxg=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-jg5P1FfwPi-_95nmIeVRcg-1; Wed, 20 Nov 2024 09:30:52 -0500
X-MC-Unique: jg5P1FfwPi-_95nmIeVRcg-1
X-Mimecast-MFC-AGG-ID: jg5P1FfwPi-_95nmIeVRcg
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-71e7858820eso5708644b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 06:30:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732113052; x=1732717852;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vMaVfU9xtl9jCnZwV3bp7ALlJWztWPDTsfcs4kOcUr4=;
        b=Dc8lDmVUaYX9wcJy1aukXPt9Nc4gMMUtCbNITwhnEQfHGVQUdBiMsj7+feKLPt5kR7
         qNTeFbBbczbfcR526txlag8dmN51ITIV82PYdEzmUsrreKSb3r96N0r6pxXimIw5VG9D
         FEE0zcfNhhHkYj+hypdSL7hypGJOgLHjNoV54xXqLaC92ETcDMYMHiefM1+lkBKE3bwa
         Gyva2h1eRvp1Fe+hoZq0dOtHSwTzvLToI3SkujhRDfWC0L1O1I81x8/df3ThnwZi4RDM
         2A2ynHlJyt0XzQ5yOODcj/72pmJN5Tpks/kBmuk4Hqm9hcZN2QzvD/gFMwtnxRQVGGsE
         Yr3w==
X-Forwarded-Encrypted: i=1; AJvYcCVII2R2Tla/IaRLoh4jlahjaTNHTSs/bve/slP+FPcTqAzxQMNFjZCveKuGhnVzh3ne7DRZWHCNQW6Hc7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3MYZxIECPfeKnEaWgxy1Xk//DpdkNVy0TYzA2u4Af1q3o7V2z
	m/1FFDluOiSlegekNqj61W/AOG87Y7NTQ3HOYc9J1smL2HQbQq0+7qnj9n1TAJN+zSqMLLkLfMZ
	VoV59JChswHu2LfxaGQDRe65+l6UZHsON4nMPhAjlKsRRdzd/Tp3kPIQP2g22oQ==
X-Received: by 2002:a17:90b:3881:b0:2ea:3d2e:a0d7 with SMTP id 98e67ed59e1d1-2eaca6fdca2mr3531595a91.15.1732113051808;
        Wed, 20 Nov 2024 06:30:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECdkxl+S+2db1pctE3VVYMcpzPK6h3n3Y5C+YW4i4MDyKHmQUKlg5WY2488lvUjDv3+OYg8g==
X-Received: by 2002:a17:90b:3881:b0:2ea:3d2e:a0d7 with SMTP id 98e67ed59e1d1-2eaca6fdca2mr3531540a91.15.1732113051300;
        Wed, 20 Nov 2024 06:30:51 -0800 (PST)
Received: from [10.200.68.91] (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead02eca46sm1348721a91.7.2024.11.20.06.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 06:30:50 -0800 (PST)
Message-ID: <67f6b7e9ff32593bf66f72ff1269458c3733ecae.camel@redhat.com>
Subject: Re: [PATCH] drm/bochs: Replace deprecated PCI implicit devres
From: Philipp Stanner <pstanner@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 20 Nov 2024 15:30:40 +0100
In-Reply-To: <20241017125145.34729-2-pstanner@redhat.com>
References: <20241017125145.34729-2-pstanner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-17 at 14:51 +0200, Philipp Stanner wrote:
> bochs uses pcim_enable_device(), which causes pci_request_region() to
> implicitly set up devres callbacks which will release the region on
> driver detach. Despite this, the driver calls pci_release_regions()
> manually on driver teardown.
>=20
> Implicit devres has been deprecated in PCI in commit 81fcf28e74a3
> ("PCI:
> Document hybrid devres hazards").
>=20
> Replace the calls to pci_request_region() with ones to always-managed
> pcim_request_region(). Remove the unnecessary call to
> pci_release_regions().

Just saw that this patch is still floating around. Anyone feeling
responsible for bochs who could review this?


P.


>=20
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
> =C2=A0drivers/gpu/drm/tiny/bochs.c | 6 +++---
> =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tiny/bochs.c
> b/drivers/gpu/drm/tiny/bochs.c
> index 31fc5d839e10..888f12a67470 100644
> --- a/drivers/gpu/drm/tiny/bochs.c
> +++ b/drivers/gpu/drm/tiny/bochs.c
> @@ -217,7 +217,7 @@ static int bochs_hw_init(struct drm_device *dev)
> =C2=A0
> =C2=A0	if (pdev->resource[2].flags & IORESOURCE_MEM) {
> =C2=A0		/* mmio bar with vga and bochs registers present */
> -		if (pci_request_region(pdev, 2, "bochs-drm") !=3D 0) {
> +		if (pcim_request_region(pdev, 2, "bochs-drm") !=3D 0)
> {
> =C2=A0			DRM_ERROR("Cannot request mmio region\n");
> =C2=A0			return -EBUSY;
> =C2=A0		}
> @@ -258,7 +258,7 @@ static int bochs_hw_init(struct drm_device *dev)
> =C2=A0		size =3D min(size, mem);
> =C2=A0	}
> =C2=A0
> -	if (pci_request_region(pdev, 0, "bochs-drm") !=3D 0)
> +	if (pcim_request_region(pdev, 0, "bochs-drm") !=3D 0)
> =C2=A0		DRM_WARN("Cannot request framebuffer, boot fb still
> active?\n");
> =C2=A0
> =C2=A0	bochs->fb_map =3D ioremap(addr, size);
> @@ -302,7 +302,7 @@ static void bochs_hw_fini(struct drm_device *dev)
> =C2=A0		release_region(VBE_DISPI_IOPORT_INDEX, 2);
> =C2=A0	if (bochs->fb_map)
> =C2=A0		iounmap(bochs->fb_map);
> -	pci_release_regions(to_pci_dev(dev->dev));
> +
> =C2=A0	drm_edid_free(bochs->drm_edid);
> =C2=A0}
> =C2=A0


