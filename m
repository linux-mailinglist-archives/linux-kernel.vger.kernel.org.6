Return-Path: <linux-kernel+bounces-384599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DB49B2C1A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3371C21FD9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AEC1CCB37;
	Mon, 28 Oct 2024 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZWZ2XYaD"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F0719258B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730109409; cv=none; b=mxRLdUuX8kvddEEWi37k2KFCh3HYKsuSPIh2uC7z5cGxP/N/CcG7gDtHmNAfsZGcSPoHGyLGcUYqrOME8tdoYZ9faZvmmJUZr6jHmV8Ee09W3DjYx7ohdX+HWa+2yoRWMmX7iIv19SDZmmZdC+/CuS2pPtIeV072RQUGg7FH3Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730109409; c=relaxed/simple;
	bh=RiH6D3l1BYetcyeHc3NgSPwEUIKjfMpkQxy3ymImDug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBPKc4XtgwWgj+JKdlllPdqSnmF8oLX0ESGBIjZ2vFQu8hLw6LpJNr/fS4FjI/jwhhrKBZt1tJH1lRVb8musUPgf5FrF3DDmXUFuwQfJYLkOOrxJN1j1JeLkr5em/cirWJ2IsEh9po8u+toruSieCjq5K7rbHrD7xipLvNOoKbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZWZ2XYaD; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539fbbadf83so5149626e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 02:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730109405; x=1730714205; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P8zwHHVlFDhC3eCYRjgzIufh+8Duk97Oi3BDhNd/SH0=;
        b=ZWZ2XYaDEOb4YvzWC6Xod4tHZNE7eA627aOFl9M80ifWq4FapjlQRo2Q5y20ctixdw
         CEctk5TwA7GJVV+CUCJbrCG0r2LZ5EwbKyVDOchrrdxI7PrdxNSiI78wefXzjjfN9FHE
         9mrcwbWOcT3HAV0Ie2up8nNGHcHykDfdsS2SI3my7SacycHsQd3zBTAHbIWzzFj6rznf
         pMSlj92GiLo1DgZRIUvrBhcEmJoA8WKuCHjRaMvsXQNWS6rEQHO/bWp8yykPRBGUAdGM
         NSm0VOUXrJIKDHU0P0qXaKFVo5fbcedBl3OpNOQrm3LdCxIdrKrW3/U8Yp8sLaeaJc4H
         G/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730109405; x=1730714205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P8zwHHVlFDhC3eCYRjgzIufh+8Duk97Oi3BDhNd/SH0=;
        b=N72MsWnA4n1ZbORSUBJ4MLumGEHVeZpfb09Xlx9hdCwZljxc20VsDgl+UlvLKjpZZl
         crTCqXJMKqX30AS9RU7flx+NWSon+h+JKIOJhNyk9yqEJJcsx5wxm+vtDoFYGHuEC1y5
         ULGbu4lWzbNjLlpjCPtwaqTe30G555l8619BcbMW0Mqpc4vKQIQO7v9RLmUJ/A7i4Y5C
         HTPBQ2pBTlpU2lgI6OXSA16Y14dU9iRI7qGcgHfiEaOnlPfm4vv/HBTY/WIC/v8jyynn
         ZwzekN4EfSOdZX064f9WclZGoK0SAMFAfbijAr2f85Dp2U0vMAeTmlDp69m9w+d70hEt
         d2Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXs9GKSkHbPmNbqYZV4r63Oq56A5wrP5O48jAmbtoaN/Nm3N094eKFEn/D0lWr7vGUTekknlCPIZfVU2sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWCCO9WFWX07/59x6PmGOgMMIMn1XtMx2vYAIxPW8cDs1/q/kK
	bhJDb+Pf4WH82KeVVVwMXJ/uRVa0+rWagESw/Gf04K/KkVjiOwOd2FOiHDrvR4hC2SMpS2uoQyH
	fUcwlZ5YsQaKHnwbeIraglddKU4/wMvZi01rjUg==
X-Google-Smtp-Source: AGHT+IGPJlmP5++H8GZgIolANUUnQm/hil6sECZXrtRl0gMOO8zCL/uGJFkEPpBWQMpVap1I8eF1RQlMPNEQCKQkew0=
X-Received: by 2002:a05:6512:2304:b0:53a:aea:a9e1 with SMTP id
 2adb3069b0e04-53b34a1afd9mr3531208e87.54.1730109405411; Mon, 28 Oct 2024
 02:56:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com> <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca> <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
 <20241016152503.GB4020792@ziepe.ca> <CABQgh9FCJcOa0G0Kj__NUm-Q8C9uH4ud04XcHv+3c48T2qEnug@mail.gmail.com>
 <20241017120518.GI4020792@ziepe.ca> <CABQgh9EnEqDKkxg3VUgjSqBzz27h8B3Ct4w=A0vR6JK=d7fXHQ@mail.gmail.com>
 <20241017130805.GA926121@ziepe.ca> <f218230c-ae01-4168-b36e-5e502de6b3db@linux.intel.com>
 <CABQgh9GU4xp=7Svs_Ni=bvNKECKKUjHgq4d-FjT5Y_4wu44kDA@mail.gmail.com>
 <CABQgh9HYDRVOYtL=jgc4CqX0XhNmCtBDOCm8S6_mgBzBtZVk7Q@mail.gmail.com> <e030bf31-330c-4734-be13-634174c7b099@linux.intel.com>
In-Reply-To: <e030bf31-330c-4734-be13-634174c7b099@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 28 Oct 2024 17:56:28 +0800
Message-ID: <CABQgh9EQjEpHLn76g0Fdu7L6PwmYbiJxuPT-OSPKo7SrN7dAgQ@mail.gmail.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt attach/detach/replace
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 27 Oct 2024 at 22:26, Baolu Lu <baolu.lu@linux.intel.com> wrote:

>
> Can you please make this change a formal patch by yourself? As I don't
> have hardware in hand, I'm not confident to accurately describe the
> requirement or verify the new version during the upstream process.
>

OK, how about this one

Subject: [PATCH] iommufd: modify iommufd_fault_iopf_enable limitation

iommufd_fault_iopf_enable has limitation to PRI on PCI/SRIOV VFs
because the PRI might be a shared resource and current iommu
subsystem is not ready to support enabling/disabling PRI on a VF
without any impact on others.

However, we have devices that appear as PCI but are actually on the
AMBA bus. These fake PCI devices have PASID capability, support
stall as well as SRIOV, so remove the limitation for these devices.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/fault.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index bca956d496bd..8b3e34250dae 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/pci-ats.h>
 #include <linux/poll.h>
 #include <uapi/linux/iommufd.h>

@@ -27,8 +28,12 @@ static int iommufd_fault_iopf_enable(struct
iommufd_device *idev)
         * resource between PF and VFs. There is no coordination for this
         * shared capability. This waits for a vPRI reset to recover.
         */
-       if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
-               return -EINVAL;
+       if (dev_is_pci(dev)) {
+               struct pci_dev *pdev = to_pci_dev(dev);
+
+               if (pdev->is_virtfn && pci_pri_supported(pdev))
+                       return -EINVAL;
+       }

        mutex_lock(&idev->iopf_lock);
        /* Device iopf has already been on. */
--

2.25.1

