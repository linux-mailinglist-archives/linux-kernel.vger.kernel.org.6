Return-Path: <linux-kernel+bounces-236365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A96E91E12D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ADF81C22929
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3182F15ECEB;
	Mon,  1 Jul 2024 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zAbhBlpi"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EC1158DA4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719841769; cv=none; b=ld0CEUCDiSl2deDZy4rtA3uWaqTqCuP4rzxuYdez9Rv/TblgQ16+BV06nZxBSNgahEeeQfeBflGJWNIpFd++NrEy1+YUWSkmdZSl4aQlAJzMOQUd5jZhMsE6vydF2L9zJrZoibI5TF738aUzXEKXFbzQ1WCs6pU9EAw08jYS/4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719841769; c=relaxed/simple;
	bh=VNdxMse+Oe9mdLojU0mCGXeQ+DZJWA0+7HJj8kVIBnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=se5ybLs+lnJbDunsXFCoSXsySHolhWAHN8CMteConTSodyylMbhR5YLRTuHEeImThK0kSD2kGR/syIYktklu6md0AdQOGHq/D3WF2YPNeol039iSzNtT2pDFLqwFh3bcSFDGqLgOu2Io+GybwHQTT95ThNz9Y9vjMwZv8otCr6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zAbhBlpi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-424ad991c1cso27509735e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 06:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719841766; x=1720446566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cSHA3q4477yqFVwlHVRNBlCXfb85cUCdbiSbrNOhrjA=;
        b=zAbhBlpioynIxwqGkBDCjKnFX+FDQypff34UQ/yVIqMkOTEeG6mJDKkPrQazpXnshy
         6LpTOsqWeGXZgolmGxKCqfaT6xSM/9VAbHCuxLa1gdvRqgs6eDu99mPnldsgS/SszUoS
         OS9srVQMUI03o9uUDii7E0Aqt7vSWmjJ65Yo8VvpuTzj0xO1uKD9fW2xjjrZuMMIYiKd
         9LaOQ1WC5+GvYBN0SbSbxlOMTbEIxRzkvRodHfSc6zOIeVKFOqDIQbmmMbTumd5O98P5
         sQU9q6qcjjof9sGQyjf15IwUtJWbJC1vUroAtIqbB9xRAVz9RX8yVVxgpwFZbMlGwmBI
         XxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719841766; x=1720446566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSHA3q4477yqFVwlHVRNBlCXfb85cUCdbiSbrNOhrjA=;
        b=YJZfvU+MPN4W8GWq14SWclPaEVmKYc0rRFgHTum9ICt3hC/dDE6XAtfxSbaR3u9Plg
         NIJTzx8NIMcebktFv6wr3m4CuHNCGjKtJlOPWqzPCaxFiGstbUgSGzmOxCMqnSF9xHuT
         zoOJOwCZh/bNKyjbEWzI/p72pIk/inmZlJo069pkmq+fqTxIIyqOZ13yjVpgGL66HVgk
         ZhpbkQG8h7i9RbLtxdJVeTq0TYOK3Fgn0dvfQfgHLWTTJYmEBeNLkFw4I5KuHZc5F34O
         jvI8EvVPEu8xoJUBYgW7EFDJYaSHXfCJEJRfVN3o2yyTry3aWxszZo01W4jyTY7JnsrZ
         G3ow==
X-Forwarded-Encrypted: i=1; AJvYcCWDKVhJsUvm0JvoY9k8QLly6B0EVfFd8kjhb8tHp5agGAw4wzjdJH2RUOldQl38FBNsOVzgKmIBlv90IZGRohs/GxQNzo+xgLwHt72U
X-Gm-Message-State: AOJu0YymQhNLwlUQ+y17/uQ/AiSf1DNnstfQYiZakcB4aKd5fViBX7ZV
	HhSv6cVMF/kh8hetHUpUrQunUaDTwRT4mP2HXnOsWz+jtUefhhDdjQ4RHmJrRRI=
X-Google-Smtp-Source: AGHT+IEpUblqE9v0NeLJXlJ5ozpWe9TPxae1ZcK0gTo7GHEOOUFGF+Khzv2YHvZ8TnyhE/LhRgJFOA==
X-Received: by 2002:a05:600c:47c7:b0:425:5f73:e2e1 with SMTP id 5b1f17b1804b1-4257a00c088mr49663315e9.22.1719841766025;
        Mon, 01 Jul 2024 06:49:26 -0700 (PDT)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4257fc934b2sm58300515e9.44.2024.07.01.06.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 06:49:25 -0700 (PDT)
Date: Mon, 1 Jul 2024 14:49:42 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 0/4] iommu: Remove iommu_fwspec ops
Message-ID: <20240701134942.GC2414@myrica>
References: <cover.1718994350.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718994350.git.robin.murphy@arm.com>

On Fri, Jun 21, 2024 at 07:46:35PM +0100, Robin Murphy wrote:
> v1: https://lore.kernel.org/linux-iommu/cover.1713523251.git.robin.murphy@arm.com
> 
> Hi all,
> 
> Here's v2 of this little cleanup, with acks and the additional cosmetic
> tweak suggested by Andy. There were some slightly non-trivial changes in
> the rebase so I've left off Jean-Philippe's tested-by from v1, but I've
> given it a quick spin on arm64 ACPI and DT and all seems well still.

virtio-iommu arm64/x86 DT/ACPI still work as well

Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> 
> Thanks,
> Robin.
> 
> 
> Robin Murphy (4):
>   iommu: Resolve fwspec ops automatically
>   ACPI: Retire acpi_iommu_fwspec_ops()
>   OF: Simplify of_iommu_configure()
>   iommu: Remove iommu_fwspec ops
> 
>  drivers/acpi/arm64/iort.c             | 19 +++-------
>  drivers/acpi/scan.c                   | 36 +++++--------------
>  drivers/acpi/viot.c                   | 11 ++----
>  drivers/iommu/arm/arm-smmu/arm-smmu.c |  3 +-
>  drivers/iommu/iommu-priv.h            |  7 ++++
>  drivers/iommu/iommu.c                 | 20 +++++------
>  drivers/iommu/mtk_iommu_v1.c          |  2 +-
>  drivers/iommu/of_iommu.c              | 50 ++++++++++-----------------
>  drivers/iommu/tegra-smmu.c            |  2 +-
>  drivers/of/device.c                   | 30 ++++++----------
>  include/acpi/acpi_bus.h               |  3 +-
>  include/linux/iommu.h                 | 15 ++------
>  12 files changed, 65 insertions(+), 133 deletions(-)
> 
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 

