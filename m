Return-Path: <linux-kernel+bounces-443654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD589EFA87
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 543921896760
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0C02397BD;
	Thu, 12 Dec 2024 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tiZibgwR"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015D0238E1E
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026750; cv=none; b=CRPdqPCpIEsB/XShDcB76iNrrI5e8aU9tDYuc2VAMM9hCbXKQYegpKHtvlzEIhAblq+KNsPO1BjTd+1NMUcg1vS4tlyiaaz2Y+fieXlpqE+xSOF0L+sxkZtdA8a0kPcstZ1nbImiHg+gfDXQ9ppP4Gerz0j0TwgXD4IxHQp/S+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026750; c=relaxed/simple;
	bh=ZTCW3MPLRkAgIQ6KHNuQcNDS5MIsVNoOiDzEFUuD1n4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lp19Npn+Cwzrc+jzQ2mfSqvMzo+ir0RoRenwh8af4UvrgMKbGkXqWC2ztzsaZSUDYFG4/suUUpOuqkTfXS7Yc5u2GE6OpPOULcAvq+90FeSKwPNMlLA/k4KfH7v1IbUNlIS11a/9eKw8YQTjY1ki6ED81TKJX2YvFSJYbrwMsY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tiZibgwR; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4359206e1e4so9237035e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026747; x=1734631547; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HFThXzKnjRTlltuWbtKfTZlx0mgnbefnBgFBqpI1yLQ=;
        b=tiZibgwR9mCK1czs75GK3pUCVwoIaJZLqOBsqqcFjgwqOTgEK8W8MYSrJZNmUfgu2F
         KBeypDkh0YsLvcNuK1ZE83OfB+DkTgHFtd9V5tsAoUg7UBNjnZUSeyRHTGs/b4nMsnbv
         rUGOKb2/FqPY9VkU1MXHh29vL7DUrEn0a8zlyyGmrUy50Qt9bpJ63xRkPnfXOeq1Zr7g
         mZr4ill7op0YWsCNqj5kMxl+vdwZr0xXq5IiXJJshyUpO0MMip/qiM9uSFlZpEAlllyT
         SRuHNBsuACY9BIk/BUgMMz4TxQgt/AlbOQgFiEdqgfIrlmbToAjhX+Ooo/PLmrpE1bu7
         z71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026747; x=1734631547;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFThXzKnjRTlltuWbtKfTZlx0mgnbefnBgFBqpI1yLQ=;
        b=RviuKf9RdBkIGmjSx92crYYLU4txOoMXvoU1+1/xoma3cY0JB0IUTn5Os7V2zel+QG
         bUhHtqRhbkFqePWC3PTxWwS2VmRoWJnBk5AhP0t4pUuz0hx7BpFIfWqLmLR3yxotDCye
         u2V9AnLwW4xNj0JNzBS0GvZOQ9onrRdCDQyHEZcwgksR9vYIolxvAgglXBnaGbEDa8+M
         /Cu/qXoxFvtd/LEdaeA6P8jgDFhR0qvryjHBYIgfwEPsH3v4fp8+tlwPcG63e4G8qWU9
         Y7/pR4flYsk1NZmpKHV0YTF7yKh8C65C7s3VQtGKDXN5iwvfLsNNyOgUb0Q9BrjR/9jI
         SGjg==
X-Forwarded-Encrypted: i=1; AJvYcCWkF6L1njrYquImrNxGNbCCw8+PLrB+gyGlOH3JjuPq3Nnb4AHZLQr4hBGchtTFeNYDbpgI8zwEMQzw5zQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEBUqoxLjhQg8lnU+KvtxROvJEfoSBpKU3CuIE9ap4utkSHkZG
	hrnBOLnCDfZ9omLjwKrKJmPQlJOxlD/SquHw9wSXGLyA9QoTZeZvwkXGomRZZ3yCBvF6mhC83Zp
	8LMszVJKhvg==
X-Google-Smtp-Source: AGHT+IEcA6NxPQcYOWP3jecw4tajvZQj85hXUMMgjZMFtmkSC/sm2wXlubiRoWv+mV1LLv3tR1NkxUnUlZkBAA==
X-Received: from wmdv18.prod.google.com ([2002:a05:600c:12d2:b0:436:164a:763e])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:524b:b0:434:a781:f5d9 with SMTP id 5b1f17b1804b1-4361c3aaefamr76123965e9.11.1734026746134;
 Thu, 12 Dec 2024 10:05:46 -0800 (PST)
Date: Thu, 12 Dec 2024 18:03:54 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-31-smostafa@google.com>
Subject: [RFC PATCH v2 30/58] KVM: arm64: smmu-v3: Reset the device
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, robdclark@gmail.com, joro@8bytes.org, 
	robin.murphy@arm.com, jean-philippe@linaro.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, vdonnefort@google.com, qperret@google.com, 
	tabba@google.com, danielmentz@google.com, tzukui@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Now that all structures are initialized, send global invalidations and
reset the SMMUv3 device.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c | 38 +++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
index 5020f74421ad..58662c2c4c97 100644
--- a/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
@@ -441,6 +441,40 @@ static int smmu_init_strtab(struct hyp_arm_smmu_v3_device *smmu)
 	return 0;
 }
 
+static int smmu_reset_device(struct hyp_arm_smmu_v3_device *smmu)
+{
+	int ret;
+	struct arm_smmu_cmdq_ent cfgi_cmd = {
+		.opcode = CMDQ_OP_CFGI_ALL,
+	};
+	struct arm_smmu_cmdq_ent tlbi_cmd = {
+		.opcode = CMDQ_OP_TLBI_NSNH_ALL,
+	};
+
+	/* Invalidate all cached configs and TLBs */
+	ret = smmu_write_cr0(smmu, CR0_CMDQEN);
+	if (ret)
+		return ret;
+
+	ret = smmu_add_cmd(smmu, &cfgi_cmd);
+	if (ret)
+		goto err_disable_cmdq;
+
+	ret = smmu_add_cmd(smmu, &tlbi_cmd);
+	if (ret)
+		goto err_disable_cmdq;
+
+	ret = smmu_sync_cmd(smmu);
+	if (ret)
+		goto err_disable_cmdq;
+
+	/* Enable translation */
+	return smmu_write_cr0(smmu, CR0_SMMUEN | CR0_CMDQEN | CR0_ATSCHK);
+
+err_disable_cmdq:
+	return smmu_write_cr0(smmu, 0);
+}
+
 static int smmu_init_device(struct hyp_arm_smmu_v3_device *smmu)
 {
 	int ret;
@@ -472,6 +506,10 @@ static int smmu_init_device(struct hyp_arm_smmu_v3_device *smmu)
 	if (ret)
 		return ret;
 
+	ret = smmu_reset_device(smmu);
+	if (ret)
+		return ret;
+
 	return kvm_iommu_init_device(&smmu->iommu);
 }
 
-- 
2.47.0.338.g60cca15819-goog


