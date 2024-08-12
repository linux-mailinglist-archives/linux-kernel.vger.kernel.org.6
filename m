Return-Path: <linux-kernel+bounces-283781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2672194F89E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5879281288
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDB119B3C4;
	Mon, 12 Aug 2024 20:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IyZbvZO+"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848D219AD9E
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495998; cv=none; b=lFHk+3ECC51t9CPiMTahynbvVitnBunaaM/FX3b+MfKnIaYmr08TFIiw4hYLts8VOzxsA2Bj9Fm/9g7VvoAdkR592Cax5Pw+yjO+NEu3fdi8d6jvTNFCnZ8h1Yuu/jYkvZNEACfHDq5WEe8Qvrf6u4CyiF5Z0YhC3gY0t623K+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495998; c=relaxed/simple;
	bh=TeYbM+CVhzHcQNp4eQLi3mHUQ9ETw2IglY5kCOkU/q4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LQNPQHTOdLByq4XTFNuhHgTtCMzomwLMW4nYS7oEqLtQ1IG9ysIvBf+i4yE/bi0d9ykbPzZIzW1S6DCTTqlSuX9HX4BhrN6kK3sNs41bVn/VVGIhAyqb9tWdszV7LHLFMvfeGm6XXaCov/2cOrK4OCk88Qikg3njYzL8RHuFgIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IyZbvZO+; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-66a2aee82a0so94485427b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495995; x=1724100795; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DuUqrCWF/xHWcFuXKlPjIWucc9/NhZLN0OsUooYWUjg=;
        b=IyZbvZO+wxArsIHKKziZi67scjuTIO4+tlWJknpEMFY8zm7jBDjGlfabTVZEidGKkP
         Sv7ZXyzoFDfMMjqMY+p69NavxjNkdssJUL3pnSQWb+hbJE7dks6ssKOFbVLnuvnRqxBl
         O5GTLzeYdEvmzQpOO6WIAN+cYd01YHT7xPv3PR242oE5zyuu3qA91PB5dR+mAW1SlBTS
         AAjlz47Bw4fvFEun620tTxkExoJ6Rs/IxO4Hum5ZRzK+dDrq91LA93wjuikDsH2jz/WX
         /dRPwDoMrkNylwA0XegH1/rFYed0qiNDRHjxMsdP31wOvJiz5xbP6CsIFN2MGOeNgckq
         Kdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495995; x=1724100795;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DuUqrCWF/xHWcFuXKlPjIWucc9/NhZLN0OsUooYWUjg=;
        b=jaGXr1in7JWIJYc7NGYLb8t9D/FEOapQPxxXp7pm+3j7lC8i94kZeumigFq8WojP8w
         8NLx5KfsrecrQXsruegsFeEkvJ+TSu8Ao3xSkYk5ltY7kbMa0yqnNK9ytu6U23xW4pQe
         YDQdf/F4UJ0Ub6DdJ1ng8Mef62yBYV89CXoNr32xFf/+ZF9Zj9K9CuerPwoHfosr0V7M
         qdXKLQ8JnmDFawt3Gbr46RfXJEEUQiuelmhLdoDcpEPI5YPdAufO/wZ0BkBuB0fvS8E3
         dvZuZPlsr34YnoYsgmfK9mNVRtL1B76akQOjKCDG1+zRlGBicO/rMbGOH6qaBKCKJvYY
         rfqw==
X-Gm-Message-State: AOJu0YyjTuoCwewrXqduF1R2ECH4dDLOoew7DZht19uuFAzl6CG9GeGw
	l51bA7BaQqF7EWErWV/ybdvB03DlJ2mO/PFWg6IlYLq2DeR8I98TxIfA22Q8ytTtdf+8tVJmWMs
	Z1ZcH2QLphMee/qQR0/5AaMcZRn2K5wEmQ+juOigYKLfOFKLBl4XKFgAjM+RA4renc212WtIicK
	5wYefM+B2sn4e2xJpz/fk4oNpQ5cdlACiQCS0NueHyWAGXOXVnIxA=
X-Google-Smtp-Source: AGHT+IENy8kvftAeMsPnXaFLGnElxbpTX8pP3lf5fKRnJiwZqy3MmYbMOT7IN0Eau0daUlvYKEg/llpPkpn9+g==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a25:aa46:0:b0:e0b:d229:af01 with SMTP id
 3f1490d57ef6-e113ce919bdmr1758276.6.1723495994572; Mon, 12 Aug 2024 13:53:14
 -0700 (PDT)
Date: Mon, 12 Aug 2024 20:52:55 +0000
In-Reply-To: <20240812205255.97781-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812205255.97781-1-smostafa@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240812205255.97781-3-smostafa@google.com>
Subject: [PATCH 2/2] iommu/arm-smmu-v3: Report stalled S2 events
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, will@kernel.org, robin.murphy@arm.com, 
	joro@8bytes.org
Cc: jgg@ziepe.ca, nicolinc@nvidia.com, mshavit@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Previously, S2 stall was disabled and in case there was an event it
wouldn't be reported on the assumption that it's always pinned  by VFIO.

However, now since we can enable stall, devices that use S2 outside
VFIO should be able to report the stalls similar to S1.

Also, to keep the old behaviour were S2 events from nested domains were
not reported as they are pinned (from VFIO) add a new flag to track this.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 +++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8d573d9ca93c..ffa865529d73 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1733,6 +1733,7 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 	u32 sid = FIELD_GET(EVTQ_0_SID, evt[0]);
 	struct iopf_fault fault_evt = { };
 	struct iommu_fault *flt = &fault_evt.fault;
+	struct arm_smmu_domain *smmu_domain;
 
 	switch (FIELD_GET(EVTQ_0_ID, evt[0])) {
 	case EVT_ID_TRANSLATION_FAULT:
@@ -1744,10 +1745,6 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 		return -EOPNOTSUPP;
 	}
 
-	/* Stage-2 is always pinned at the moment */
-	if (evt[1] & EVTQ_1_S2)
-		return -EFAULT;
-
 	if (!(evt[1] & EVTQ_1_STALL))
 		return -EOPNOTSUPP;
 
@@ -1782,6 +1779,15 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 		goto out_unlock;
 	}
 
+	/* It is guaranteed that smmu_domain exists as EVTQ_1_STALL is checked. */
+	smmu_domain = to_smmu_domain(iommu_get_domain_for_dev(master->dev));
+
+	/* nesting domain is always pinned at the moment */
+	if (smmu_domain->enable_nesting) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	iommu_report_device_fault(master->dev, &fault_evt);
 out_unlock:
 	mutex_unlock(&smmu->streams_mutex);
@@ -3373,8 +3379,10 @@ static int arm_smmu_enable_nesting(struct iommu_domain *domain)
 	mutex_lock(&smmu_domain->init_mutex);
 	if (smmu_domain->smmu)
 		ret = -EPERM;
-	else
+	else {
 		smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
+		smmu_domain->enable_nesting = true;
+	}
 	mutex_unlock(&smmu_domain->init_mutex);
 
 	return ret;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 0dc7ad43c64c..f66efeec2cf8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -745,6 +745,8 @@ struct arm_smmu_domain {
 	spinlock_t			devices_lock;
 
 	struct mmu_notifier		mmu_notifier;
+
+	bool				enable_nesting;
 };
 
 /* The following are exposed for testing purposes. */
-- 
2.46.0.76.ge559c4bf1a-goog


