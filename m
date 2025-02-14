Return-Path: <linux-kernel+bounces-514602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A627A35927
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C8B16BD6B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1332E227B88;
	Fri, 14 Feb 2025 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YkQWJ9Zz"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CBF22616C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739522609; cv=none; b=OgK2Id2+5h0RahHaye2G3N2FnYE0lIkbUPoX7FBmV30KOXMzOvt3mCQz8EDias7+6DTLEkJwoaCvUnwAZOg9DvLO6iRTVycFg+pDqFFDY6iQB7P5GsqensYkwD/0jPV5nNr2peEVyoun2e+g9BVSlGk7NEFXU8BrUFImbnrWemw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739522609; c=relaxed/simple;
	bh=CXPc3y668anJq9lBRrDv5CYpwtXv7HerEoD7uqDJSrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKLRY7897j2VH8NTozuzpGodlWcm/OjRoXJAwnaUCXAOVQphR7MDQ7dZ9+l28NC9qaUTqS7wgDeK86UiiiuuAxieL1KgZXa1vyrVilt30joRsZbW4/NLOAqEGw+7oNm5smjndrbqBKI9rXkIvK9Uw1EfHRlwj3juyfDXaWarBYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YkQWJ9Zz; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-545054d78edso1827675e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 00:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739522604; x=1740127404; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YrGWn46F9945+gUUg8W+kiuyxDl8keZLgoB3N8SvlL8=;
        b=YkQWJ9Zzrgehpt6l4Gg4oQtyaKESE9IiPFOxeKWduu9Sf4WgSUGx8m9qft4PVPISml
         KsrJ4jRHXkpptYBxv6efpUwqp6h01W2zXvaJfyxznH4ujlx7dz0CrcilfFbWsY1tU87l
         vogd1h/rpcuwZTdsewEu99PfKBxqm4EzmSVwUOMQdcPsH7u+A9x2YNqoGxreBtUArfH/
         DCpYFcH/cJzc4wb3MxjgRCxzrESZBlcmkmX6u79HfLq7jwxqCH/cB3ZV+X7ALOnKhMXG
         k2vouItNRKXvqc3ifY4x428c+kOzNiydeWNKt7CTWwLzGxVMfWozrEhmEu102uR3h0hD
         pqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739522604; x=1740127404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YrGWn46F9945+gUUg8W+kiuyxDl8keZLgoB3N8SvlL8=;
        b=RMT3TkuHVgqQPQZEkElwxOhhWCJ7bDoZ78cU8C5fh9BIVTTm8GzmC7ele0Lw4OEgf2
         jsiATiJjZVXksUXjUEfBLOHyqJhqE4ZHWK708llpB+YwsNgqBcxcyPk1z6V0q0gL2Ofn
         9LZDVe9G+XFVLjAvYyUtzOJJ0R7gBj8VrZyXBkKC2Mns7Bbk/QZ9uTDXdM65ywmkz795
         Daoo5r06a4hoMYYkw4xvqKIaaJDmNv+dk+3stmwWNzymFgGAPKyGwMbBR54E12Wk1ao8
         6TmtNR14BC6HC2ESO4igRExVv2mNeXwj1eWDtwl8tVQE3C8enu8ykKy/Pel5cIzKG60R
         A+lw==
X-Forwarded-Encrypted: i=1; AJvYcCVjgnRC6jbaMl2dnV7OLmu1fQokAIIv2/ahLN/37OLlw6M838aJjZRhcDdRdA5Nj4gxz0fD3FLn1nlBASE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsO+R5E1xK6B7Om0Yg50Rx2S+pCpjQILLO1UbwXh2O73CwaOXy
	BgPPd381i2HSR9/yWclfsnvitTs6Xh+RAqYvTyjJDH2xyIqKfXTbbM5H8y/tLP42J+qwvbe26tv
	UXrdcWdeZS9VXWb+TRTKupYDljqk3MtZSLJF0ig==
X-Gm-Gg: ASbGncsvstcXxOJn8TnWkPIpoV7PGP95fcdZgR5ck7TElWZdc+0Mjk3UW4mqDmt7Eab
	gGZ7Hkk3/qWZF0qYrx+qedysrVdlg8Is2NSMAbpCPWfea5GLtwSC0agK1qg70I61gpPXOxtVMDn
	2IUA==
X-Google-Smtp-Source: AGHT+IEy54NZS39ARrjg/49nfZ2l3CeZ4lYDsrIyQaSITqrHjX5TvkMyKcPqBEKExLhAOiEB7VqLqCeUMkrmy70IrdI=
X-Received: by 2002:a05:6512:6ce:b0:545:2b68:9360 with SMTP id
 2adb3069b0e04-5452b689407mr281546e87.23.1739522604517; Fri, 14 Feb 2025
 00:43:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
In-Reply-To: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Fri, 14 Feb 2025 16:43:12 +0800
X-Gm-Features: AWEUYZkjQWE-qK49xiiBKEEkxJP-7Ch5gON0NzmMUVyroeED-rVwKmIQ7uLah4I
Message-ID: <CABQgh9FMy7oVt9+enSpJxXvkux+czMFqbsPZVgmBV+rFWWvhGA@mail.gmail.com>
Subject: Re: [PATCH 00/12] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Vinod Koul <vkoul@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi, Baolu

On Fri, 14 Feb 2025 at 14:11, Lu Baolu <baolu.lu@linux.intel.com> wrote:
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
> https://github.com/LuBaolu/intel-iommu/commits/iommu_no_feat-v1

I quickly test this branch

1. host test is OK

2. qemu boot one device, test ok,
though reports this when guest bootup.
vfio-pci xxx: resetting
vfio-pci xxx: reset done

3. qemu boot multi device,  test fails, host kernel reports [Hardware Error]
qemu can boot no problem
Test fails.

Will do more check without these patches.

Thanks

