Return-Path: <linux-kernel+bounces-513300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB89A3489D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0CB1623D7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E7019D092;
	Thu, 13 Feb 2025 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xvd8jUfW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223CD155326
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739461997; cv=none; b=hqoRr3wyzI0Me63b6/LWJcDFDs+Y+mQYZQ/41jcdDXcqVwga3X3PjYbvLpf8e2Tm+bO/Td5Nx5v0QNS/Q5P723jMP4Mqofj4R4O9QMfNbvTcD07+afEUZBswtj9mAZDXiFwvlW/HW+q+7PMHsSaubwf54MnTIEOrTO9Ow3pLxqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739461997; c=relaxed/simple;
	bh=Fr0YTAU+jzS2hTVLmxjX355fDOiiw6bVHBgQDsvSUwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuMsgNCH8t4P8Yq+fwX6sS1PwPacJhltbLR/rlDW+o/fz5uSouYGBS2hFJg25DnMZBSKjW5TSGhh15A1Jz7bsaN1WjtVxfxWjA5f6zCusR/RpbfL7x+xM9fNFncOFz523Wi5KtR5hkmBi/AzunitHjGLzUog35j7EQzA0tEKdD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xvd8jUfW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739461995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wm65mUYAEbhhNi250l1nY6B0IiEBXXQj82KeWsM7Zn0=;
	b=Xvd8jUfW71PjHtuma3sYKMUcHlsvTz8gHw5d5CnOrezvv/bIdqfe33AKPj/xQcQFMJGQ20
	pNABMEjgODXPapdNuJxaIPOYlutjeaSX+S/XVG3YNFh/WqsKiV4cxCeyjrKfub0RBjIKk5
	5GSUOYc2+7VknwzXI2Qtf91bcfRrdHo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-cArGOL9wNqmXUW6VsLH36w-1; Thu, 13 Feb 2025 10:53:13 -0500
X-MC-Unique: cArGOL9wNqmXUW6VsLH36w-1
X-Mimecast-MFC-AGG-ID: cArGOL9wNqmXUW6VsLH36w
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ab7ee928985so118949066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 07:53:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739461992; x=1740066792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wm65mUYAEbhhNi250l1nY6B0IiEBXXQj82KeWsM7Zn0=;
        b=sqv+goSTzRP+YEerw69pW/9tAT0k9JfI9jqzEP14SwXsAPIj+3ewohWWqSJOpeZYoY
         sDU6N/6pPT3HY8iOB9dju3RcCs19kMuf36m3fJV9eGZCl+kiaQ/Fb4BCkXJn/R51Y4FF
         06URLFXhDtMD1bjus3BkhMkEVAaglnqxYGbBR0Crv9YfpBuixur0pPgoNWRd9YiGgY6K
         J3KEDAoN4WhXpxOVwoVvjjZVaxSB3DipxQj0AoIjbHMpagBhoxODtQ+2f6Z78mqizN3f
         YgV8zUswVMDT3e+YXOtvS6tv10YNMPdiYRGVmLbQOwjaN9ABwawRHBU44WqCLVqepMMu
         bbfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ4q/2r7GBU3EijR74yPb8ZELXWxXV1SVv5sJmZEULWHgqBr7FCE8aAV9ebPwWntGg+3HbLSpoNT/1KTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxH/D20EtbSgsiFRYcU4GvRzQBYMtVdJZ93ivpl5KS9XR4PtEK
	0g+BdYBQNBZWruk0oM6flT+g5RBE9XaI77k/zMadNQOs++ub3+HffTBEbj949n1/jzXuJzi+Sxi
	3dfh81V/MXzNkugPNw9Scff3ZtmGjhcRN4/2ag1Wp7CD0622PgZr+uv0IAFOIQg==
X-Gm-Gg: ASbGncs0c/Kp2sfErfexbdSA/MvMphQ/VSx15cJlk3gtGozTdM1OR28nKP/Ey1smSBS
	v3RgdrwqAcyXkBx1N9R9fbEWKttL9zCuY0u+JcA63/HiBbhKN7npgrbFLRx5nRSRGUaNIwr+kLb
	3UinTrCNeRwqB4xCS/ilhvjT81PoMs7PireSY+CLCDHxE3FoPsHq8jrqgbHO+xmHshUC5mPpyvN
	8Wg+MhaLRwj2VDMyxE6Z1q85tUiSu5qB2I9k3mjnea3DzSH3QuN9QO2nEsKjMNCBkxEGGh9lQ==
X-Received: by 2002:a17:907:9710:b0:ab2:c1da:b725 with SMTP id a640c23a62f3a-ab7f33f5f15mr585699466b.30.1739461992364;
        Thu, 13 Feb 2025 07:53:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPYyt4663087uMZIIKURYrG8Pp4HqyogPBtf0brGd9uzETM6Wmccz2T6+v992nLi1pX3fRsA==
X-Received: by 2002:a17:907:9710:b0:ab2:c1da:b725 with SMTP id a640c23a62f3a-ab7f33f5f15mr585695966b.30.1739461991960;
        Thu, 13 Feb 2025 07:53:11 -0800 (PST)
Received: from redhat.com ([2a02:14f:171:92b6:64de:62a8:325e:4f1d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532581acsm156316266b.50.2025.02.13.07.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 07:53:11 -0800 (PST)
Date: Thu, 13 Feb 2025 10:53:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	fnkl.kernel@gmail.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH 0/5] virtio: obtain SHM page size from device
Message-ID: <20250213105231-mutt-send-email-mst@kernel.org>
References: <20250213-virtio-shm-page-size-v1-0-5ee1f9984350@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-virtio-shm-page-size-v1-0-5ee1f9984350@redhat.com>

On Thu, Feb 13, 2025 at 04:49:14PM +0100, Sergio Lopez wrote:
> There's an incresing number of machines supporting multiple page sizes
> and, on these machines, the host and a guest can be running with
> different pages sizes.
> 
> In addition to this, there might be devices that have a required and/or
> preferred page size for mapping memory.
> 
> In this series, we extend virtio_shm_region with a field to hold the
> page size. This field has a 16-bit size to accommodate into the existing
> padding virtio_pci_cap, simplifying the introduction of this additional
> data into the structure. The device will provide the page size in format
> PAGE_SIZE >> 12.
> 
> The series also extends the PCI and MMIO transports to obtain the
> corresponding value from the device. For the PCI one, it should be safe
> since we're using an existing 16-bit padding in the virtio_pci_cap
> struct. For MMIO, we need to access a new register, so there's a risk
> the VMM may overreact and crash the VM. I've checked libkrun,
> firecracker, cloud-hypervisor and crosvm, and all of them should deal
> with the unexpected MMIO read gracefully. QEMU doesn't support SHM for
> the MMIO transport, so that isn't a concern either.
> 
> How the SHM page size information is used depends on each device. Some
> may silently round up allocations, some may expose this information to
> userspace. This series includes a patch that extends virtio-gpu to
> expose the information via the VIRTGPU_GETPARAM ioctl, as an example of
> the second approach.
> 
> This patch series is an RFC because it requires changes to the VIRTIO
> specifications. This patch series will be used as a reference to
> propose such changes.
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>


don't you want to negotiate the page size with the
driver then?

> ---
> Sergio Lopez (5):
>       virtio_config: add page_size field to virtio_shm_region
>       virtio: introduce VIRTIO_F_SHM_PAGE_SIZE
>       virtio-pci: extend virtio_pci_cap to hold page_size
>       virtio-mmio: read shm region page size
>       drm/virtio: add VIRTGPU_PARAM_HOST_SHM_PAGE_SIZE to params
> 
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c |  5 +++++
>  drivers/virtio/virtio_mmio.c           | 13 +++++++++++++
>  drivers/virtio/virtio_pci_modern.c     | 31 ++++++++++++++++++++++++++++---
>  drivers/virtio/virtio_ring.c           |  2 ++
>  include/linux/virtio_config.h          |  1 +
>  include/uapi/drm/virtgpu_drm.h         |  1 +
>  include/uapi/linux/virtio_config.h     |  7 ++++++-
>  include/uapi/linux/virtio_mmio.h       |  3 +++
>  include/uapi/linux/virtio_pci.h        |  2 +-
>  9 files changed, 60 insertions(+), 5 deletions(-)
> ---
> base-commit: 4dc1d1bec89864d8076e5ab314f86f46442bfb02
> change-id: 20250213-virtio-shm-page-size-6e9a08c7ded1
> 
> Best regards,
> -- 
> Sergio Lopez <slp@redhat.com>


