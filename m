Return-Path: <linux-kernel+bounces-559140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E92A5EFF2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C05A3B139C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367BA2641D4;
	Thu, 13 Mar 2025 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LtRo/dIf"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE26E1EFF95
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741859504; cv=none; b=IW/ulZ5HELvsUcFO2GKWUPXk38R7wdFXqFq2BjM6KdKYOYC50jUDsNg36z2pUT+QPBPGvdtKJGbwPcuUiHQCp7wMPR3XAO3dQ0y00xsSxgHfy8yLIl9b79OLaNdk1SIEqb6zBxs1Zx/bFmwUvv/h2CZHMAtBpJFKZs1D4XxMD6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741859504; c=relaxed/simple;
	bh=QgYfWBbjniwPDhzWoyGsOU37LL+wBsYx4FA84RaPSfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scwaAuOfgbVbXzG4AzyJNDi6F4A05rk5UWDovtTc1PhudIOloA4bhGA02V5ZB+w/HtV/3CbLFdf6kgClcOMuCNV3qIyTDduhI16ySzAx1TqtL8Mx9wb9bN6c6WS5765mvzpj6x5A63icSAVqMbfoGtNMqYIo7c28DgCFbfnF7Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LtRo/dIf; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-549a4a4400aso857422e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 02:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741859500; x=1742464300; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QgYfWBbjniwPDhzWoyGsOU37LL+wBsYx4FA84RaPSfo=;
        b=LtRo/dIfsWYMJQT5ln6pwRHdVIumv/esAbki/zje09+sexV5+Zd+0X5G+KDC54LkKz
         9DdB7GPwGQHccIIITH1Y3aTJo4a3j8Q0Q94K8YVWvJXC14MFJej9k1eub0mI+S1hjRzO
         1xUoazG10QyOd38pBrwwmL3gH8WPBlCij3JhHU0yqVebBSBBPnTnOsSViO7EQJ+0Eu+P
         xb3AOHDuTMQBWRNlT2HkVWh7qy1vEI+Nc5KQBbAHF4CZ7S5zZIXlZKHR2vs4zU+shi92
         RK4gvf9Q+lBwFRcDiyt7AEhzwESD1t/vN5L1izWilDTgV5whON7PS+7svi1AHew8wGzl
         HJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741859500; x=1742464300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QgYfWBbjniwPDhzWoyGsOU37LL+wBsYx4FA84RaPSfo=;
        b=B1nNvJFPq4gQHh98G1PGjxJyudGpHtY2znYNW9sIVT84e/MmZepD0vAnlGYcSXzoim
         HjPitasuQqA0Jbc0l9/ZnHkinKwRjKQsaqSdhsx/xu5VBNq0VksNcej3KEu8CoSHbHLM
         sbOX+FyZWE8tcoM66IsjR1frtkgw+suRVw6+OSpc+FP3ywR/9OiyfCMGubXTy+hJ3TYf
         plnZKDOlUZW0LBV/4/yAHVsBBy5WKiaRrgVXU3LoEXc4cQCtyi976cp7aq4vyqSR54AO
         cULtUFWPMZdWtBp4s1EIU9SESW7BaBHybt6NvXgJsY7EG7R2mOMk/kjqWdsaG9YjvsK0
         GOQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL5P+Ro7KXWWcM6I1TNT6Es3ArKZhBS+GuJ+aqSzWCeYwg5VWo0ILQB6nPxMcyp2Wu0iHimMlGw+hExG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwBZr1r0yhCv74GVvlhmNfx5lh1NLibMfPgQdMZiIYN0kUpZAB
	BZ57COjivWTsqkzAdmBcUsMME36Z3cf4pNQOsikKDcAMohN/SO+h0f9cpzF7yPV13tUBqOl8Gub
	ZnDecTDiqI1qodrtmpbAxnlInHL+LsLWD0Zuq7g==
X-Gm-Gg: ASbGncs6nbuXXBIqaQr9qmMCYlO9P12+DSSJHeHewsRg1aXBdgr6eWiDrnVyrxG2zdk
	4ChFG16cEo1h8fDgO02TtuF0lAQB0LIIiRhfG8OW2Aap8thr7Z+KlbzySz5I4fHj/482KN6JPqi
	fxMqSF8V9QeJcUrORoKPGDNVxAWTNF1yg=
X-Google-Smtp-Source: AGHT+IG3yO5UKX7BvX8TOnQpocO31aqeIzqAIGkMVMg/xWmE6h9YKu7EryZASHPYLGHFC2RM9d53W/G30tx+Snpz0hA=
X-Received: by 2002:a19:f810:0:b0:549:91bc:67a9 with SMTP id
 2adb3069b0e04-549abaacaaamr3300696e87.9.1741859499720; Thu, 13 Mar 2025
 02:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313051953.4064532-1-baolu.lu@linux.intel.com>
In-Reply-To: <20250313051953.4064532-1-baolu.lu@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Thu, 13 Mar 2025 17:51:28 +0800
X-Gm-Features: AQ5f1Jqrdmo7VWV6PyLD1e4rhSBwqyKwJOXS2K4j0MErxoy_ssJnjuYFCbVU2qM
Message-ID: <CABQgh9HKaDyDQXGB5ZEGg5q4a9ak_8OB9XQ+TpUNcZd_ZMeCAQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
	Fenghua Yu <fenghuay@nvidia.com>, Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Hi, Baolu

On Thu, 13 Mar 2025 at 13:19, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> The new method for driver fault reporting support relies on the domain
> to specify a iopf_handler. The driver should detect this and setup the
> HW when fault capable domains are attached.
>
> Move SMMUv3 to use this method and have VT-D validate support during
> attach so that all three fault capable drivers have a no-op FEAT_SVA and
> _IOPF. Then remove them.
>
> This was initiated by Jason. I'm following up to remove FEAT_IOPF and
> further clean up.
>
> The whole series is also available at github:
> https://github.com/LuBaolu/intel-iommu/commits/iommu_no_feat-v4

I got an issue on this branch.

Linux 6.14-rc4 + iommu_no_feat-v2
drivers/pci/quirks.c
quirk_huawei_pcie_sva will set dma-can-stall first
arm_smmu_probe_device will check dma-can-stall and set stall_enabled
accordingly.

This branch
arm_smmu_probe_device happens first, when dma-can-stall = 0, so
stall_enabled =0.
Then drivers/pci/quirks.c: quirk_xxx happens

Still in checking.

And this branch does not need these two patches, right?
c7b1397bef3c iommu/arm-smmu-v3: Implement arm_smmu_get_msi_mapping_domain
5cd34634a73e iommu/dma: Support MSIs through nested domains

Thanks

