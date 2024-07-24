Return-Path: <linux-kernel+bounces-260801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE2A93AE63
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 11:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC391C23294
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9A0136982;
	Wed, 24 Jul 2024 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BY1/P57/"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DCC1BF2B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 09:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721812567; cv=none; b=AbytofKj4CBwsAW61tKj+gACVb2DcJeoFtoxyZr/ZqVo4WSrCrDqnNQkqXF1NKf1xtZJ/3X1O+BIHaM2TE0KsZJcExK61rtaH/v/SI/gZcG0czZkUAdohMY6hnGx3Nu0rEWTKg6RFQE4l7VhtQMfI/DThWW9bk3lluxheFlJ4+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721812567; c=relaxed/simple;
	bh=Sy434Bqjmf4grcXj1vskiSucCwd3KPthS6BX3Mj9oAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byqR3AyPrz5knVSb4bTX6pOuE/FCHBW2AnxNTSoX8h2au837lWDBcnEjM1fVprXxEB686bHPGcnwvfqRCexoLhPr8PIcGG/PvJQzUOClR95ASPLRcjrHXouBwfN9Vs/GJszxK9nV2TxtFnvZ8Jm9hf5sFmsHW2ro6jblcDZAKqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BY1/P57/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4266f796e67so18665e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721812564; x=1722417364; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ygJSKrWMDAjdVSQe60t5hakwwPYHO6218k/HD89MldQ=;
        b=BY1/P57/JQijzRmBxfLPjBe1FBppYeqBNiMMx33SAbOvV1+Rh7TofT8TFu3as4Y3ij
         k75qOPvy9b1rzyXr2X+lZCPj2aGYGXpwGYTiVnf/bNOV9n10oN3hAC5zhkUmJj+Xcc0q
         BumTQwELJSWH3Je4xmOPyU2WaiF06SMtsDpbz6iAC5Asn4R/OkgRiQE2/QnHuIXQzs6I
         96gVc7MGDSMaBobm3ciBJk18gjhuu2v446QGCSq+vfdYpU4G8WxC7jfuoMsi8ygEdkVr
         hcw91KCQl7JzmmbOhlYd69azXcyyJIHHuYWgAwdfU7b8t7Vvn32y5OARA/byhiQfIgdU
         GqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721812564; x=1722417364;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ygJSKrWMDAjdVSQe60t5hakwwPYHO6218k/HD89MldQ=;
        b=Dn1vT9shnx2RgPbYSlCPn+2tPI0hdcaCxCjDlDg3WUyKCdiANnPWwbFVsLSXeqP1/E
         NF/z9eEGMhagLy6Sq0gxYIs/qei3OkhAmlXcyZbp/tb5h86H6nG1P2beB04T73n3gHTI
         yQT4SKLUDMt4BCRpuk3CujWOUf4DbkSikPe5BXbYCYE4P0iCi65fxQoQjQ0NqlItWKUQ
         NZW+/bGNoYbEIbAh1eboNXvdB9BViGHCBWJ45gw7XpTd6qgMwie+VaXkpTn5DH2GG3Ss
         E3RYeFILpPMNNbPMxjCKdrZ5vOyKNRpm3ywCsrk9/bq6WEqzdKGO11Yxft4I0x3pGDg/
         PUOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRMjAgqjDHzstKJ+5x4IVs5ciLf+tBaCfLbO9rc9idFk4L8lSCMFvAnp4Ed4U5adX2br8CPjtifMiJSqtVtqA417nSEzfzuSBPwyoD
X-Gm-Message-State: AOJu0Yz/4pWvrBjxUqfiQf81LveLUdKw9r0hHrhcGY1bHfgyeuyvvloP
	MO72ajAeJDCuKPTVRvjVp5RFg0yeWVNDDmMmD7P1GgvMiDfa2ZYEaim9szPeGg==
X-Google-Smtp-Source: AGHT+IF3QlQMXqH4LoJywcOciD0LmPSwkAcFafGCHPR+lrWYNX14/VtUHyZJTeMONKmAUpvJ2SsPgA==
X-Received: by 2002:a05:600c:4752:b0:426:66fd:5fac with SMTP id 5b1f17b1804b1-427f7ae7a36mr951915e9.2.1721812562491;
        Wed, 24 Jul 2024 02:16:02 -0700 (PDT)
Received: from google.com (180.232.140.34.bc.googleusercontent.com. [34.140.232.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3687868b7cesm13783734f8f.37.2024.07.24.02.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 02:16:01 -0700 (PDT)
Date: Wed, 24 Jul 2024 09:15:58 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Kunkun Jiang <jiangkunkun@huawei.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	Michael Shavit <mshavit@google.com>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	wanghaibin.wang@huawei.com, yuzenghui@huawei.com,
	tangnianyao@huawei.com
Subject: Re: [bug report] iommu/arm-smmu-v3: Event cannot be printed in some
 scenarios
Message-ID: <ZqDGTnH8TCxEkkEV@google.com>
References: <6147caf0-b9a0-30ca-795e-a1aa502a5c51@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6147caf0-b9a0-30ca-795e-a1aa502a5c51@huawei.com>

Hi Kunkun,

On Wed, Jul 24, 2024 at 09:42:09AM +0800, Kunkun Jiang wrote:
> Hi all,
> 
> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> 1797                 while (!queue_remove_raw(q, evt)) {
> 1798                         u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
> 1799
> 1800                         ret = arm_smmu_handle_evt(smmu, evt);
> 1801                         if (!ret || !__ratelimit(&rs))
> 1802                                 continue;
> 1803
> 1804                         dev_info(smmu->dev, "event 0x%02x received:\n",
> id);
> 1805                         for (i = 0; i < ARRAY_SIZE(evt); ++i)
> 1806                                 dev_info(smmu->dev, "\t0x%016llx\n",
> 1807                                          (unsigned long long)evt[i]);
> 1808
> 1809                         cond_resched();
> 1810                 }
> 
> The smmu-v3 driver cannot print event information when "ret" is 0.
> Unfortunately due to commit 3dfa64aecbaf
> ("iommu: Make iommu_report_device_fault() return void"), the default
> return value in arm_smmu_handle_evt() is 0. Maybe a trace should
> be added here?

In my opinion this change should be reverted as it’s very useful to
print event faults (for debugging crashes) as not always tracing is
available and enabled, and as we don’t want to print paging events
we should know if a device handled it or not.

Otherwise, as best effort from the driver, we can only skip printing
for IOPF enabled devices something like this? (or may be use
arm_smmu_master_sva_enabled() as I see only SVA uses it)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a31460f9f3d4..57f3a7d0e40f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1777,7 +1777,11 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 		goto out_unlock;
 	}

-	iommu_report_device_fault(master->dev, &fault_evt);
+	if (master->iopf_enabled)
+		iommu_report_device_fault(master->dev, &fault_evt);
+	else
+		ret = -ENODEV;
+
 out_unlock:
 	mutex_unlock(&smmu->streams_mutex);
 	return ret;

But let’s see what others think.

Thanks,
Mostafa

> 
> Thanks,
> Kunkun Jiang
> 

