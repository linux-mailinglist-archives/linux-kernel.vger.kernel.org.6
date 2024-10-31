Return-Path: <linux-kernel+bounces-390015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EC39B7484
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B51284C66
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 06:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D73514659B;
	Thu, 31 Oct 2024 06:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fY6XB+a9"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25123145A03
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 06:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730356110; cv=none; b=Hga/ciSRCP7H0vQUatL7zeTwHi8YG+Pe1ibRhakeFsrry1GBgVgZH2AxEbTCrJFYN0TGRjsnAlYrtLe1AcJbsi1//pkBTFRfNsef3MK0AlRzQBbZ7EI7AhGSnFH+JJqYgJpCOL+tUMgQ+TdFTtfN832Z7cFPgmbSA+3ZmiglWhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730356110; c=relaxed/simple;
	bh=MKqc+jnQFmyBLCFxWGJ3NUD1kakYxp1Ft7jvVu1cUio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JFiw/p/kSS+ejIx1/wdVv/9C+axWhRht3NZyGaq+WLEaaIqsR+OeI/sbrWes1tNhr2qS/oZL/BbvH9mILMfR4N9Gbyf1iEVFdHETg9uETJVFpdRGYfbVVfyfZCTWO9MBjDI7kMOF1cI5cTAemNu7N0Q/++avH3N9zYAsqlk5Xrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fY6XB+a9; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539f53973fdso523853e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 23:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730356104; x=1730960904; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0A+2k/ULHhbtDsFz6ukwr2SikYuSBp3Zz6My29BV53I=;
        b=fY6XB+a9GcvCY54J/6TCzSg+CFj7efwDBSnGFtOhF8l4VX7duOpc27ENEfN+QUTbs8
         qfo9uf7ksKv4G21sRhXh34ZrNekFpKwMxFeJWpDqPAuC8cD5OcRfZCysrEEV69n2Ekpn
         JWAxJNllYlXYUzbxvjz1H3WeD2rO1u++uDWk+UjtrJ3BFAykNy+zxTNabfu8sY0Q6J+Z
         df1m25hI34NoqQikQkmLMzG4ZqNcav3mLIJiVc3J2UB2Jnnss3stSS+EgoZ4zvhIbKnF
         J4/4JBQv9+1LfhwE3S8pUdBv6piptGORTZXSSw/SNO8EkaQy69zZrwYP5BMGBFhlulV1
         ZHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730356104; x=1730960904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0A+2k/ULHhbtDsFz6ukwr2SikYuSBp3Zz6My29BV53I=;
        b=qJaI3qR9oIwUg8AcbtQbv+KevnauWMKKhggIOREEExPOPJoBKWhL5P2U2HYFKqvB2r
         yGmGptZiHU86LCbo6VVMFrsAbYyYbmvtr8uAZZYSTcc+RUMQFvLynRyLwojJbJg3ruCG
         kh9xY7jXc8cRycM9pFxpU2Mxtm2UVv5C/Ku8j24ys54/acp0IlYacd+9ui5VHBKgxgIH
         in63np+WoMfAUqRlYm8tnPzhThlZnJq8LE4KqCweRTedTYo0MI/bBYQU554PNne9LDmx
         fpYjicgTrKK2WQkos/ht0I1GuYh5neTu//Zqy3vOGS6G3+np2MgCOfqSvlRUsNJ4N5lO
         4SGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTCaXSO7dn9zm0zogh2BeaXOvH6rb4RCKL6sKhs+pUfk73IIyfV9PxxMFKWaRtX7SQegjLoU9iX/XSLEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC6K8FbonLfP5QoBUIWkfm0A6lpYERfY/C3scbfXsKUf0ww1IU
	dll5r6HJxlu0lFb5alM+/WE2AkXb6A81xuhOx5b6oGP5qk6Uaonto7msbZ+/kbFfdIqCrwJCA2v
	ZyPLp+ITSNyXPyg57y3I9kVOO6V2A5E51nNItYg==
X-Google-Smtp-Source: AGHT+IFS7cpOzSPiFnYyQueXqV7l2SMv8NBdQwLcqFAZDqrWEol+iOoyDA3s2GJBPsOCBe+TjxRn94cV+pCmUA4hIqQ=
X-Received: by 2002:a05:6512:2243:b0:539:8ee8:749e with SMTP id
 2adb3069b0e04-53c7bbc136cmr376123e87.3.1730356103938; Wed, 30 Oct 2024
 23:28:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730313494.git.nicolinc@nvidia.com>
In-Reply-To: <cover.1730313494.git.nicolinc@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Thu, 31 Oct 2024 14:28:12 +0800
Message-ID: <CABQgh9GYOgBJwRhvsWpPwS4vgDzCvXCAUxc8DQy8ObHAOvpbRQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] iommufd: Add vIOMMU infrastructure (Part-2: vDEVICE)
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, joro@8bytes.org, 
	suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com, 
	dwmw2@infradead.org, shuah@kernel.org, iommu@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, baolu.lu@linux.intel.com, 
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org, 
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com, smostafa@google.com, 
	yi.l.liu@intel.com, aik@amd.com, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Oct 2024 at 05:36, Nicolin Chen <nicolinc@nvidia.com> wrote:
>
> Following the previous vIOMMU series, this adds another vDEVICE structure,
> representing the association from an iommufd_device to an iommufd_viommu.
> This gives the whole architecture a new "v" layer:
>   _______________________________________________________________________
>  |                      iommufd (with vIOMMU/vDEVICE)                    |
>  |                        _____________      _____________               |
>  |                       |             |    |             |              |
>  |      |----------------|    vIOMMU   |<---|   vDEVICE   |<------|      |
>  |      |                |             |    |_____________|       |      |
>  |      |     ______     |             |     _____________     ___|____  |
>  |      |    |      |    |             |    |             |   |        | |
>  |      |    | IOAS |<---|(HWPT_PAGING)|<---| HWPT_NESTED |<--| DEVICE | |
>  |      |    |______|    |_____________|    |_____________|   |________| |
>  |______|________|______________|__________________|_______________|_____|
>         |        |              |                  |               |
>   ______v_____   |        ______v_____       ______v_____       ___v__
>  |   struct   |  |  PFN  |  (paging)  |     |  (nested)  |     |struct|
>  |iommu_device|  |------>|iommu_domain|<----|iommu_domain|<----|device|
>  |____________|   storage|____________|     |____________|     |______|
>
> This vDEVICE object is used to collect and store all vIOMMU-related device
> information/attributes in a VM. As an initial series for vDEVICE, add only
> the virt_id to the vDEVICE, which is a vIOMMU specific device ID in a VM:
> e.g. vSID of ARM SMMUv3, vDeviceID of AMD IOMMU, and vRID of Intel VT-d to
> a Context Table. This virt_id helps IOMMU drivers to link the vID to a pID
> of the device against the physical IOMMU instance. This is essential for a
> vIOMMU-based invalidation, where the request contains a device's vID for a
> device cache flush, e.g. ATC invalidation.
>
> Therefore, with this vDEVICE object, support a vIOMMU-based invalidation,
> by reusing IOMMUFD_CMD_HWPT_INVALIDATE for a vIOMMU object to flush cache
> with a given driver data.
>
> As for the implementation of the series, add driver support in ARM SMMUv3
> for a real world use case.
>
> This series is on Github:
> https://github.com/nicolinc/iommufd/commits/iommufd_viommu_p2-v6
> (QEMU branch for testing will be provided in Jason's nesting series)

Thanks Nico

I tested on aarch64, functions are OK.

But with some hacks
https://github.com/Linaro/linux-kernel-uadk/commit/22f47d6f3a34a0867a187473bd5ba0e0ee3395d4

Thanks

