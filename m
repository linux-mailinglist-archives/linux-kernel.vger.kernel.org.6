Return-Path: <linux-kernel+bounces-219800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD4090D7D9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04C021F23474
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B21513B585;
	Tue, 18 Jun 2024 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SeI5NUWI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B0A13790B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725901; cv=none; b=OqaXc7j1jV4tOJ6ghb+5U1ZZO6HsaModN93bGigARO7puZMMPhZughieP34lC1895HRO43gu07dxDIr2yA1JZHmSNpB/cW36gKwBC2jDufcL3mgFLAq5byC+lmHC4mbLm5qhP8hYrsjep4h/grMJaqMW0fzAE7k8hCqrBTvhMuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725901; c=relaxed/simple;
	bh=Lgpc90nKB87dyDcERAWICDYnV6YS1lcg3UEUBLb6OqU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DY3iI/lOrCwP5kxcaTj85AnEZRIOHCfgy4U0CfA7qH3imA0bpBMqLR+kUBOkyG+Ns7wf0V+BV6DfpCPAULBadnaMtUTI8NxzYb98IGgMKEXS8OOGXpxt7e4qDCBSEOwasvPNzFDL5U2q/cflw6YYLWhvkX9VB9qcJhPMj4U9b9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SeI5NUWI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718725899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PjSGFR/9hcTm8rLTkGHUAeik1m3Y5cdjjiw+zxskYFU=;
	b=SeI5NUWIV9nVSJh0/Ry5c4hBVPKkpL4kwnHwXfLmGDEyGDLltcy1aGa1QMBwOHt+DYA1gE
	1kSUvHxxGOtGy7HXk0vJGuC+arWBc5zc0DIuK4epI/MP0zJbegh7ZEx9KeTHsjKlX4P7pn
	HttvJKvGVsvrfdhK/srdslwQbLpZnP8=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-38K0CyTZNJCD-4vc-nTeRA-1; Tue, 18 Jun 2024 11:51:37 -0400
X-MC-Unique: 38K0CyTZNJCD-4vc-nTeRA-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-24c501a9406so4876108fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718725897; x=1719330697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjSGFR/9hcTm8rLTkGHUAeik1m3Y5cdjjiw+zxskYFU=;
        b=lBAlGIqSOL/pv3J6p/8IIcg7P/db6+aHgrShYvhhXm9ywcF5xEfE/xkmOuT6dxeoPS
         BuspZYXKOm6ZZYyRFvxgojIN0jYtyzhRnvfUfebUePviglMESBOl/ncn9AtXPfpoN3qP
         dztAJbLgnXt5NO8cl24ozl4vV7iRlx4vIEUGFjfZnWp4GXuALGTp6zlLv5DwyzvT6tpW
         x8IqpXCDLoxrq75IQfsbaq8Cs+3sGxSuwK9lbsa/uYxr5AtDOXhCqVzIV9GKkTX6hfag
         Qd1kg2PAHj+TzT8DXirKTO9hsKDVlQRgsPjK4IBtAXo3sIEUerh+vfh+kXV+OvluiSIs
         ut8g==
X-Forwarded-Encrypted: i=1; AJvYcCV4GhWafz74FBu2jtgRXFeFJXOQhMC0zlhJiDBIwQGlGMAgTO0ilFGiB4CW5Eh0RHgY+WddCdwTSUq8tai1J0E6Ve3E3og+H9IDuO74
X-Gm-Message-State: AOJu0YyldweBqDstK6TjFtgGYpVgF4LBA5zPEEL7ea7ue/mcu7rAJakk
	tDZMPyB8euWkoKDCrOdWATbpb1dIr/jVa8USQF7uStA+M9Zxkv9PIAtMd2OVpXtog2rvCtoSfnk
	gltAqdwB5zExaeTYnDdxC2hgQ3+efHb4A+PeZObC1iecWZ4NBGSeC11LhiKD+GQ==
X-Received: by 2002:a05:6870:8182:b0:254:8a0c:de4c with SMTP id 586e51a60fabf-25c94a21307mr170557fac.29.1718725896762;
        Tue, 18 Jun 2024 08:51:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE94IS+ik8v5kXlspSo6TVS47o9TWiOF1gb6qUVvv+zpMjmsvNrcNTEoeLkyLjoERTXlXp6Bw==
X-Received: by 2002:a05:6870:8182:b0:254:8a0c:de4c with SMTP id 586e51a60fabf-25c94a21307mr170537fac.29.1718725896455;
        Tue, 18 Jun 2024 08:51:36 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a94e74fsm3228521fac.9.2024.06.18.08.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 08:51:35 -0700 (PDT)
Date: Tue, 18 Jun 2024 09:51:34 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Gerd
 Bayer <gbayer@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v3 2/3] vfio/pci: Tolerate oversized BARs by disallowing
 mmap
Message-ID: <20240618095134.41478bbf.alex.williamson@redhat.com>
In-Reply-To: <20240529-vfio_pci_mmap-v3-2-cd217d019218@linux.ibm.com>
References: <20240529-vfio_pci_mmap-v3-0-cd217d019218@linux.ibm.com>
	<20240529-vfio_pci_mmap-v3-2-cd217d019218@linux.ibm.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 May 2024 13:36:25 +0200
Niklas Schnelle <schnelle@linux.ibm.com> wrote:

> On s390 there is a virtual PCI device called ISM which has a few rather
> annoying oddities. For one it claims to have a 256 TiB PCI BAR (not
> a typo) which leads to any attempt to mmap() it failing during vmap.
> 
> Even if one tried to map this "BAR" only partially the mapping would not
> be usable on systems with MIO support enabled however. This is because
> of another oddity in that this virtual PCI device does not support the
> newer memory I/O (MIO) PCI instructions and legacy PCI instructions are
> not accessible by user-space when MIO is in use. If this device needs to
> be accessed by user-space it will thus need a vfio-pci variant driver.
> Until then work around both issues by excluding resources which don't
> fit between IOREMAP_START and IOREMAP_END in vfio_pci_probe_mmaps().
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 80cae87fff36..0f1ddf2d3ef2 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -28,6 +28,7 @@
>  #include <linux/nospec.h>
>  #include <linux/sched/mm.h>
>  #include <linux/iommufd.h>
> +#include <linux/ioremap.h>
>  #if IS_ENABLED(CONFIG_EEH)
>  #include <asm/eeh.h>
>  #endif
> @@ -129,9 +130,12 @@ static void vfio_pci_probe_mmaps(struct vfio_pci_core_device *vdev)
>  		/*
>  		 * The PCI core shouldn't set up a resource with a
>  		 * type but zero size. But there may be bugs that
> -		 * cause us to do that.
> +		 * cause us to do that. There is also at least one
> +		 * device which advertises a resource too large to
> +		 * ioremap().
>  		 */
> -		if (!resource_size(res))
> +		if (!resource_size(res) ||
> +		    resource_size(res) > (IOREMAP_END + 1 - IOREMAP_START))
>  			goto no_mmap;
>  
>  		if (resource_size(res) >= PAGE_SIZE) {
> 

A powerpc build reports:

ERROR: modpost: "__kernel_io_end" [drivers/vfio/pci/vfio-pci-core.ko] undefined!

Looks like only __kernel_io_start is exported.  Thanks,

Alex


