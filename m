Return-Path: <linux-kernel+bounces-519564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 948C6A39E17
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D54D160F1B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F642698AD;
	Tue, 18 Feb 2025 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WM9S1n6m"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428FF2405EC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887075; cv=none; b=GOw897QgzUBVwZHpSaTnGKSBAnZ+q1yBnBvRyeJ1023Gp9uUrpXtApo+wmlpen8Uz3cZRcxvuxdvp2gbPbWNvmShEQn3CTEI2dhnuCWBHuo08BbLEJjDTH3j56K5a2sqotjEMbd57OLX9Mp1vi6SIheDryv87nVV/5dtVMvinmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887075; c=relaxed/simple;
	bh=mjDenaaQ7wiKZP/6kXoXNdqWpfV2tzD8WJLCcuMaDUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uthPGkqIiaPGFTqdGJCR1u8WbCTBEFBT+kLgg/FWcdB6xPDrPDzMn8sS+x/KB+XCL9pWTkncB8cvxdEY0AHED5/9/u3IJRicpEaDtmxmDtydaMgmNNwT+83d+RsE0w8IAYb9g2Ymy395NEHxucDqyWUYLaO3Ou0e4/rWKCDYScc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WM9S1n6m; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c0b0ca6742so46642985a.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 05:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1739887073; x=1740491873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ODOKacfYrjCnJrk/J14hycY632tV3hHO3fKyUm3wGk=;
        b=WM9S1n6mu57/tzJSw3tkPuO3bNktRqmYnu0IUriF9NhG8LZF+e8w+4z7DuuYBND6F+
         52ln9T2nAQcRo+JRSO3A05sx9/dZHoo2axc1S/BWHnl1JO5zYdirI8uYknCFn5aC0k/P
         p08F5qMep62tbCoJ+ZqKdki22CuUWNp8SNU/ZfE3VR4e7nLQ46rvciQirnl32PsREHgj
         cBfakAjTZQifZ71paR1MAuTq8aG5MicXWNA5+L/3sf41ysaUUB/LcLjPOwH5FDstqemA
         mvpdGLq4p+JEZJc7EFXEMeRnbG+pn64q1Fs7PpqAH8bwKgUOA1YewtdWLR6TgkJtnaCl
         pMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739887073; x=1740491873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ODOKacfYrjCnJrk/J14hycY632tV3hHO3fKyUm3wGk=;
        b=xARklevLV9j6tLEEAz4KFTYz/OVDKtao1/sKdYuK47OfN1HYMWQuTLdZbj2gICaaIR
         ydzT5tA9cK6EDqdmzbXLM1+Z8chVqPZxjMCbAjgDhQod20BjB4yvc7XxxOsvS4Iw5Vfz
         xEmkTioPzMQ6FbbclH3mGckZt0gnd4XIAfFoFQwPRjFdarolHkp7xHV9IUrbNMzuiNGc
         X18UZUzNGiCM00Hy9ppi444dg+tkIbVZgH3K7uxqNbnvEwrceQ2T1Es2nD/RGpHAajei
         jys7zd0jrdVchz5PfsrjNdtLDaCWLm+RwPEnXkoYx1RZsZD41+1vwk6QlUphJIPV8f63
         c4sA==
X-Forwarded-Encrypted: i=1; AJvYcCWD77IWij1uRuhlqofexm8qVccrMGYF0XDcfLn32FPkJT7E4eeqrOewjckbbIgSIqNy9+SeSPF3BnIVOB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyECzbxeaNpesXR+1tl4Bzrziq3WxkBCNy1Ne9i8aQTHgaNfS+
	E0h191U6l5ezC37ZxXzYcWsY1XWL15Q0t9bDSxPSC4PhEXC+uGHaLNpq9zeNX9Gd2lplES71xR4
	Z
X-Gm-Gg: ASbGnctt+f59wzkBTiFAEHrv6UcIRCAA8Q4R9MKJKKSxs0lPtvXUFZwdwoD0QpDvhOx
	4JkjieMBemivfALAAtGzdhUygS5srddKEaUMC5l1cb1UmcOnVlOUAamjdcr+NXvYvn51ezB73Vu
	QsIY8rAXxQ31L31U1tT8V8N/6sWrrs8CVsDuhf9eqsTO8r6zpWGl0Uv2DOmP0nbEgQb1epelh49
	p8nZSW6Z4zg5BJhCHggQoez2S62iP5G4/xGrG0KdewHKUIGU1RK2SaWijxkOHd0ruINRqn4LjH6
	ffPgYivB19Eby3AhipT/7egkQfFWi6D1EYxsUnIGVlEJ7dtnnGP8iELKTM3L3yRk
X-Google-Smtp-Source: AGHT+IGnquONRh4jZxhzbOJMSBQWDzK54g9h0WDOQSasnk/EgY+QQVjDbrbwf62w4X5dTww+5oqo5g==
X-Received: by 2002:a05:620a:4507:b0:7c0:79c3:fd2a with SMTP id af79cd13be357-7c08aa7a1c9mr1816331685a.43.1739887073141;
        Tue, 18 Feb 2025 05:57:53 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c099dfd028sm273570785a.34.2025.02.18.05.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 05:57:52 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tkO6h-0000000HU7f-448O;
	Tue, 18 Feb 2025 09:57:51 -0400
Date: Tue, 18 Feb 2025 09:57:51 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH 00/12] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
Message-ID: <20250218135751.GH3696814@ziepe.ca>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <CABQgh9FMy7oVt9+enSpJxXvkux+czMFqbsPZVgmBV+rFWWvhGA@mail.gmail.com>
 <20250214125600.GA3696814@ziepe.ca>
 <CABQgh9FQYe46hfjcs+o6GfLaS7OfSqrmvXUzOKd6PRK8oBF8Jw@mail.gmail.com>
 <d578bf4c-f475-42bf-9cb8-21941fc7af88@linux.intel.com>
 <CABQgh9EG3gjtw19qvr7OhxKmR8E6+xwBf9b3=WPNrXRc-m9DjQ@mail.gmail.com>
 <59998dcc-9452-4efd-be69-d95754217633@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59998dcc-9452-4efd-be69-d95754217633@linux.intel.com>

On Tue, Feb 18, 2025 at 10:57:30AM +0800, Baolu Lu wrote:
> > > > [  304.961340]  __iommu_attach_device+0x2c/0x110
> > > > [  304.961343]  __iommu_device_set_domain.isra.0+0x78/0xe0
> > > > [  304.961345]  __iommu_group_set_domain_internal+0x78/0x160
> > > > [  304.961347]  iommu_replace_group_handle+0x9c/0x150
> > > > [  304.961350]  iommufd_fault_domain_replace_dev+0x88/0x120
> > > > [  304.961353]  iommufd_device_do_replace+0x190/0x3c0
> > > > [  304.961355]  iommufd_device_change_pt+0x270/0x688
> > > > [  304.961357]  iommufd_device_replace+0x20/0x38
> > > > [  304.961359]  vfio_iommufd_physical_attach_ioas+0x30/0x78
> > > > [  304.961363]  vfio_df_ioctl_attach_pt+0xa8/0x188
> > > > [  304.961366]  vfio_device_fops_unl_ioctl+0x310/0x990
> > > > 
> > > > 
> > > > When page fault triggers:
> > > > 
> > > > [ 1016.383578] ------------[ cut here ]-----------
> > > > [ 1016.388184] WARNING: CPU: 35 PID: 717 at
> > > > drivers/iommu/io-pgfault.c:231 iommu_report_device_fault+0x2c8/0x470
> > > It's likely that iopf_queue_add_device() was not called for this device.
> > iopf_queue_add_device is called, but quickly iopf_queue_remove_device
> > is called during guest bootup.
> > Then fault_param is set to NULL.
> > 
> > arm_smmu_attach_commit
> > arm_smmu_remove_master_domain
> > // newly added in the first patch
> >         if (master_domain) {
> >                    if (master_domain->using_iopf)
> 
> It seems the above check is incorrect. We only need to disable iopf when
> an iopf-capable domain is about to be removed. Will the following
> additional change make any difference?

The check looks right, it should only disable if it was enabled? The
refcounting is what keep track of the 'about to be removed' and it
should  be that using_iopf and domain->iopf_handler are mostly the
same.

Hmm, I think the issue is related to nested

to_smmu_domain_devices() returns the S2 parent for the nesting domain
always

Which means the smmu_domain->devices list (on the s2) will end up with
two entries for the same SID during the replace operation at VM boot,
one with faulting and one without.

I think that arm_smmu_remove_master_domain() will end up removing the
wrong master_domain because arm_smmu_find_master_domain() can't tell
the two apart.

When I wrote this there was no nested and the list devices list was
unique to each domain, so everything inside was the same.

Like below?

Jason

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b14f1d0ee7076b..dc8708b414468e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2710,10 +2710,9 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
 	pci_disable_pasid(pdev);
 }
 
-static struct arm_smmu_master_domain *
-arm_smmu_find_master_domain(struct arm_smmu_domain *smmu_domain,
-			    struct arm_smmu_master *master,
-			    ioasid_t ssid, bool nested_ats_flush)
+static struct arm_smmu_master_domain *arm_smmu_find_master_domain(
+	struct arm_smmu_domain *smmu_domain, struct iommu_domain *domain,
+	struct arm_smmu_master *master, ioasid_t ssid, bool nested_ats_flush)
 {
 	struct arm_smmu_master_domain *master_domain;
 
@@ -2722,6 +2721,7 @@ arm_smmu_find_master_domain(struct arm_smmu_domain *smmu_domain,
 	list_for_each_entry(master_domain, &smmu_domain->devices,
 			    devices_elm) {
 		if (master_domain->master == master &&
+		    master_domain->domain == domain &&
 		    master_domain->ssid == ssid &&
 		    master_domain->nested_ats_flush == nested_ats_flush)
 			return master_domain;
@@ -2812,8 +2812,8 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
 		nested_ats_flush = to_smmu_nested_domain(domain)->enable_ats;
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	master_domain = arm_smmu_find_master_domain(smmu_domain, master, ssid,
-						    nested_ats_flush);
+	master_domain = arm_smmu_find_master_domain(smmu_domain, domain, master,
+						    ssid, nested_ats_flush);
 	if (master_domain) {
 		list_del(&master_domain->devices_elm);
 		if (master->ats_enabled)
@@ -2889,6 +2889,7 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 		master_domain = kzalloc(sizeof(*master_domain), GFP_KERNEL);
 		if (!master_domain)
 			return -ENOMEM;
+		master_domain->domain = new_domain;
 		master_domain->master = master;
 		master_domain->ssid = state->ssid;
 		if (new_domain->type == IOMMU_DOMAIN_NESTED)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 5653d7417db7d9..fe6b88affa4a60 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -907,6 +907,11 @@ void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
 struct arm_smmu_master_domain {
 	struct list_head devices_elm;
 	struct arm_smmu_master *master;
+	/*
+	 * For nested domains the master_domain is threaded onto the S2 parent,
+	 * this points to the IOMMU_DOMAIN_NESTED to disambiguate the masters.
+	 */
+	struct iommu_domain *domain;
 	ioasid_t ssid;
 	bool nested_ats_flush : 1;
 	bool using_iopf : 1;

