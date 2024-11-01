Return-Path: <linux-kernel+bounces-392384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 600F39B9372
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150BD1F246A6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F471A727D;
	Fri,  1 Nov 2024 14:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cn2Mnfum"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B419A1A0721
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730471891; cv=none; b=lDtGpfUHZ95qNLcaDLJWAog7mnk5buEWXI9Lv/4abj0xR8WOinXMe+Zv3s6xtvKQLpXv2O2klSSImxC9xJIihYM7Xo0beQRGQA9XDbwjs4cs0XBFewTDyh/IGi9lB0NLS70fjrziv5O31gmaRwPXGzLvGBW8gH/LzdqSAns1xW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730471891; c=relaxed/simple;
	bh=AjV3KOmTQnBtBgqgDRTdiS8Vk+F9jjcQQcys2nNY5GI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fer4CCw4ZETWaIqHT85vSPGcEVjE2uHDuSzf839jcOQzVxLIfQ77ZkmwvPQ07rqb753iBfdUYmthxLy/SHhm/dOZoSEtW/MQxxxZie49XxJsV0XQs8XacJ9csYe0TrrkmOOaZVxPQfJfEIuO2YmDZqsJk0yvUSrSNypbO2JBCVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cn2Mnfum; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730471888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qV7dwY45yM9S1ZYcLQd9U+2DZJRTGxY0iWGmYsPKj1s=;
	b=cn2MnfumRSuDVm3xnzo+7fcTE/4Ia7hGpr4W3cK0rLQbBvVaz+HW1Vmitr070pzQ2AaZij
	2SEqvl18kAHXTc1YTEv9vT1PqvzHgmCxg4ExHWFGE71P08dg+7CCZw1h4cryk/EPbiHv5c
	3WPVkeaKE9UPVIaa4qWGObitKFn0Wvg=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505--hfjiQn4MzyzU2QhrSELaw-1; Fri, 01 Nov 2024 10:38:07 -0400
X-MC-Unique: -hfjiQn4MzyzU2QhrSELaw-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3d7eb237dso1958005ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 07:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730471887; x=1731076687;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qV7dwY45yM9S1ZYcLQd9U+2DZJRTGxY0iWGmYsPKj1s=;
        b=mUlvMqMr6Ow87155JVcVgz4X5yStk3BA7VPJyjgh/T+brc95Tt8JfsVFU3gLAwQsu4
         shLAVzqbFMVtvWy1KC7bACgepJD21N3VXybz4X9InLRTXzU19Yy7WOmkCnlqwlrHtaTS
         OASG8AnMWpRgkJYtUwXgG3w8huGrYKjPK9ri3V4mRc2XWdpYy0WO5x+KeZIevXuGwYYM
         T/euSQ7xjoXOdulJlbOgZ5vRr+ntqPiIIuo4RQvV+TwCLw6sWNsIcbZeYA+mijITONc3
         IgDGWVXAcuihuQAtzgRu72V1fyFJr2xdakcbxCxcGWf7xw2d4+4FYiSOoHMIEsdbUz/8
         7c8g==
X-Forwarded-Encrypted: i=1; AJvYcCXLg0QMxgjzA0UfOVOS87DB+sw+HLMy6bvt0BheH/sfIz9BubkdJ2uOooRyRK8mY6AB5eO/ahb/uslc/tU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3w2n+9XnqOhEreti89OsYT5xkyJ7vQWjytBL59K9eyiGVN+Pj
	R4wG3hXr+HSENdcF0QCoeAGEtfEh8vklv41cNNBYG1LS2yOlEbU0Nt0w5//koWsJoD2hOFifn2Z
	l4UfCI4mFwKaLwgpjOLqXoi/JmcDNP0pfmelT9hi7CMSmLyq/AG98g9deHxu2vg==
X-Received: by 2002:a05:6602:2150:b0:83a:acc8:5faf with SMTP id ca18e2360f4ac-83b1c62fb00mr540837039f.5.1730471886937;
        Fri, 01 Nov 2024 07:38:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXJW/i7LBIXYahlsw8I7b7GzGZ4pKFWW6BKIF/t1yROBU3vqy0nknibGhVjgr7ahX2TXz8DQ==
X-Received: by 2002:a05:6602:2150:b0:83a:acc8:5faf with SMTP id ca18e2360f4ac-83b1c62fb00mr540836139f.5.1730471886606;
        Fri, 01 Nov 2024 07:38:06 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83b67bbe8ddsm83510839f.32.2024.11.01.07.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 07:38:06 -0700 (PDT)
Date: Fri, 1 Nov 2024 08:38:03 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: <ankita@nvidia.com>
Cc: <jgg@nvidia.com>, <yishaih@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <kevin.tian@intel.com>,
 <zhiw@nvidia.com>, <aniketa@nvidia.com>, <cjia@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <vsethi@nvidia.com>,
 <acurrid@nvidia.com>, <apopple@nvidia.com>, <jhubbard@nvidia.com>,
 <danw@nvidia.com>, <anuaggarwal@nvidia.com>, <mochs@nvidia.com>,
 <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] vfio/nvgrace-gpu: Add a new GH200 SKU to the
 devid table
Message-ID: <20241101083803.3418d15b.alex.williamson@redhat.com>
In-Reply-To: <20241013075216.19229-1-ankita@nvidia.com>
References: <20241013075216.19229-1-ankita@nvidia.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Oct 2024 07:52:16 +0000
<ankita@nvidia.com> wrote:

> From: Ankit Agrawal <ankita@nvidia.com>
> 
> NVIDIA is planning to productize a new Grace Hopper superchip
> SKU with device ID 0x2348.
> 
> Add the SKU devid to nvgrace_gpu_vfio_pci_table.
> 
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>  drivers/vfio/pci/nvgrace-gpu/main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
> index a7fd018aa548..a467085038f0 100644
> --- a/drivers/vfio/pci/nvgrace-gpu/main.c
> +++ b/drivers/vfio/pci/nvgrace-gpu/main.c
> @@ -866,6 +866,8 @@ static const struct pci_device_id nvgrace_gpu_vfio_pci_table[] = {
>  	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_NVIDIA, 0x2342) },
>  	/* GH200 480GB */
>  	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_NVIDIA, 0x2345) },
> +	/* GH200 SKU */
> +	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_NVIDIA, 0x2348) },
>  	{}
>  };
>  

Applied to vfio next branch for v6.13.  Thanks,

Alex


