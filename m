Return-Path: <linux-kernel+bounces-353515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A09992ED8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6C42839ED
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC011D88A8;
	Mon,  7 Oct 2024 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="en9pM/JD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AE91D5ACE
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310762; cv=none; b=kULPslOePXXdWB00Id0A33iSL4+bmeNjMKzTfCpzO8OeIgZ2PkzG1Tz5QNPJxEPULa1PZKxpMFv0JKymrlt9YlgNM0f8SgrLemwLgnT+F78TwzUVOrw9ixQwHDnzk5+u6jHHl6idRc1sS6mnrjA/fWXuZKyyJqQxoYiTRj6tVz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310762; c=relaxed/simple;
	bh=fPpRhAkOlLyr7I5GWfCVLmcMUp2CHa8v4oEGbZ9nCQg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNNwnyoEyPNY+IsNVqDkrUf6wrYSGs4Y143pSO0i4gz6yrdGdoY2PkN83UIG9a0HT1UhJENHM3P81MKHHSe5wuq/5kadmwskE6v5n80vWmgNdii21nrm6OjHL3Ke5KZ2FBY9xp951PGjy9bK+OK6T7Gf9x/9BGCioLKsa/nCbZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=en9pM/JD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728310759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1kPk7t5vf7Zw0tZf27l+JYytji+SaN7OikNPmFvip+c=;
	b=en9pM/JDPcXzG01BLKoyi+Wl2d5bc1nxbMWCK3KwcVRb1cVJnYExwppt9NzvRMz57oAkxE
	dEpmtUZA6A7XzG9PdUCjKbnk06u1/faoxbbgiKujqn8hi60UpVsq3DVbMriPnyTSDRYxM2
	DyLQEevD93at8CKFlhUQG5H6EWPKcgc=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75--W_7QEYDNmSqOADvGLUrUg-1; Mon, 07 Oct 2024 10:19:18 -0400
X-MC-Unique: -W_7QEYDNmSqOADvGLUrUg-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-834a9a3223aso64310039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 07:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728310757; x=1728915557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kPk7t5vf7Zw0tZf27l+JYytji+SaN7OikNPmFvip+c=;
        b=mpHmyrJWa0TTWheEK0J68kJIs955wfLyhjJCKCsCsoG4viK+sI0eydyTOpq+mo1e55
         2SRBHm6QTLYCUWL8IelqMn55hXyZt965reQ6rX1+eDeDTNgsWZnzapADuXxDbHNGGvNX
         U+BKAKoiJh62v4vtvxP0353zlBgacNVLCJOvD3zjqch2qIvgowEVtkObt0hrzzYLp578
         7Vi2YD9r1nCsEbQhmaU02JpT2aWjyx6NEMJPfxqLhTIIwcw8lkVcMxxtHyuwmTDBtzJx
         AEKBiLqkQXRzv0eUKjQNEZ2Hk+rMcsZ3wE9JHyVnQTNqJNPxKHfmkjYfX5XOypW5TIkT
         XyzA==
X-Forwarded-Encrypted: i=1; AJvYcCVhPAC61+TyVYXYulc2Bv2/iQVgwZt29toJP+3bKgIlk76gLrFSsVpCjfwYibgODYX70iyI3e3R14ZYeLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMHNNhNR3i5t6ZtMdZhXntd0R8Z57aAYMsJF0knMnGozuKY8ZQ
	yUybFI6arUVIGZyYrAfgMPJrhdkOUzD0Qdu0h0cMxuBtOjBQsIcpuoASSzlNtlX1LaHE90RvBOC
	+BWjfaUZ9pgEGTts/K8hy/uBOm+d+ghjLIktmsyspHdRoVvwW8jKwh21mW8OmEw==
X-Received: by 2002:a05:6e02:1fc8:b0:3a2:57d2:3489 with SMTP id e9e14a558f8ab-3a375be37d2mr28439545ab.3.1728310757359;
        Mon, 07 Oct 2024 07:19:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLWUg4d6eCvTKO1CP5bCnvIo2LY6WKj6iaBq4rEUA4pzdXrjH5RxquxJO/p3ji7vOzKVrjxQ==
X-Received: by 2002:a05:6e02:1fc8:b0:3a2:57d2:3489 with SMTP id e9e14a558f8ab-3a375be37d2mr28439335ab.3.1728310756968;
        Mon, 07 Oct 2024 07:19:16 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db71114d91sm1080564173.130.2024.10.07.07.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 07:19:16 -0700 (PDT)
Date: Mon, 7 Oct 2024 08:19:13 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: <ankita@nvidia.com>
Cc: <jgg@nvidia.com>, <yishaih@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <kevin.tian@intel.com>,
 <zhiw@nvidia.com>, <aniketa@nvidia.com>, <cjia@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <vsethi@nvidia.com>,
 <acurrid@nvidia.com>, <apopple@nvidia.com>, <jhubbard@nvidia.com>,
 <danw@nvidia.com>, <anuaggarwal@nvidia.com>, <mochs@nvidia.com>,
 <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/3] vfio/nvgrace-gpu: Enable grace blackwell boards
Message-ID: <20241007081913.74b3deed.alex.williamson@redhat.com>
In-Reply-To: <20241006102722.3991-1-ankita@nvidia.com>
References: <20241006102722.3991-1-ankita@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 6 Oct 2024 10:27:19 +0000
<ankita@nvidia.com> wrote:

> From: Ankit Agrawal <ankita@nvidia.com>
> 
> NVIDIA's recently introduced Grace Blackwell (GB) Superchip in
> continuation with the Grace Hopper (GH) superchip that provides a
> cache coherent access to CPU and GPU to each other's memory with
> an internal proprietary chip-to-chip (C2C) cache coherent interconnect.
> The in-tree nvgrace-gpu driver manages the GH devices. The intention
> is to extend the support to the new Grace Blackwell boards.

Where do we stand on QEMU enablement of GH, or the GB support here?
IIRC, the nvgrace-gpu variant driver was initially proposed with QEMU
being the means through which the community could make use of this
driver, but there seem to be a number of pieces missing for that
support.  Thanks,

Alex

> There is a HW defect on GH to support the Multi-Instance GPU (MIG)
> feature [1] that necessiated the presence of a 1G carved out from
> the device memory and mapped uncached. The 1G region is shown as a
> fake BAR (comprising region 2 and 3) to workaround the issue.
> 
> The GB systems differ from GH systems in the following aspects.
> 1. The aforementioned HW defect is fixed on GB systems.
> 2. There is a usable BAR1 (region 2 and 3) on GB systems for the
> GPUdirect RDMA feature [2].
> 
> This patch series accommodate those GB changes by showing the real
> physical device BAR1 (region2 and 3) to the VM instead of the fake
> one. This takes care of both the differences.
> 
> The presence of the fix for the HW defect is communicated by the
> firmware through a DVSEC PCI config register. The module reads
> this to take a different codepath on GB vs GH.
> 
> To improve system bootup time, HBM training is moved out of UEFI
> in GB system. Poll for the register indicating the training state.
> Also check the C2C link status if it is ready. Fail the probe if
> either fails.
> 
> Link: https://www.nvidia.com/en-in/technologies/multi-instance-gpu/ [1]
> Link: https://docs.nvidia.com/cuda/gpudirect-rdma/ [2]
> 
> Applied over next-20241003.
> 
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> 
> Ankit Agrawal (3):
>   vfio/nvgrace-gpu: Read dvsec register to determine need for uncached
>     resmem
>   vfio/nvgrace-gpu: Expose the blackwell device PF BAR1 to the VM
>   vfio/nvgrace-gpu: Check the HBM training and C2C link status
> 
>  drivers/vfio/pci/nvgrace-gpu/main.c | 115 ++++++++++++++++++++++++++--
>  1 file changed, 107 insertions(+), 8 deletions(-)
> 


