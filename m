Return-Path: <linux-kernel+bounces-443682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5558B9EFAAB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF11F1896C28
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2EE22A7F1;
	Thu, 12 Dec 2024 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QKBTwQHI"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434ED242F19
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026808; cv=none; b=C+drbCVieiEpEcHPqMucZOD3F7TKngI5KwQ6tDYF83If30iE3VWMynl8EQ0OoP4afxpm5rO5cqKIAcUvACMmQEpkzrlgau/tUcEGyD2cgxh5DsyGlJ/VL0SFzjP/EROkhG9CgkOAuhLow8anJe8vFZ+gHki8qbYLgbWBzgSUIXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026808; c=relaxed/simple;
	bh=B1FDcer+KcePlYxW4wV0I3DBTYeqD4qGCUqX0IOiiig=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YW8dazBAo4H3dWE7M7ErGmzKnG8+y5ehZp0hSkX3mVDQuykOhbejvhm/S7XpBObXAq9QqpfSlis74aYl2ZiQNeSQq3cUMD18xuUDtb1Gobn7nFm7J6hF3GtUr+dgrmzWUfxPEUCSnwCAk0U944cxGqYXBwJTX837IN9CPOmJeVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QKBTwQHI; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-434fe2b605eso5729625e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026804; x=1734631604; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ajIKdrUqITXEhupzYVVmmPjTpdyF1nqGjC97azBMTVk=;
        b=QKBTwQHIdr6GBa8/VujLTvdntLRH/516Ls6jYSQ3O/4vmqk2g7q61YK63K5u4rX0OO
         QiiBN526zC81iFwmGd+b7rQDtMPFolb8mFHYAzrDFkXMIIvWlUU3Jom7NCjQ4YZdiRuM
         /0ZiTjdXrwVzWS8mryGwcv0VJxtOyZGpDw5Q9TcHygFx+gAZSJLzR/2eXpfe7pqkAUzA
         BgG8B+sL4+LBNKQ7UbWzwa/DNzy15GqO89ltSwifC5Vh2nmPhF2y/EcA7nYbk3vCndZ9
         B3rtiV3napNFsYAVxtvCPCh7TqNsJhDHexe1IK+HFaHrDLWzp8MRZaP4ji+CvaxR/QrT
         t+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026804; x=1734631604;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ajIKdrUqITXEhupzYVVmmPjTpdyF1nqGjC97azBMTVk=;
        b=SK8opJF6wPeo6j6Fod01dj18Baoa/cO23h8T2iZQ/ReVK8zu5UGvrLdEA3E4l7a2Y3
         2Lluh1QzQFDy6u9+IEGsHBgIck5stChLPnLHdv/p9Q+tznhOOeGxRuMbLUao+hwDewOt
         bzfGgUNTIH4+EjxJUqmDsNxeR7vfcQzpGqj0C3/ufsmhPZjl36XRnuIN+7VBipKQbTVH
         1OBBvHtj8UiUKzZGFykXebOlkWDe+XOBJNGldhoxC8rMauA5IMbTpVbdD34Ojqp7nwZa
         C0WS+gL1QmDFEvQlCG3Hs5gfNGUExWOO9CCSF7+dXZ9jjdw8eBl/oxsM5ZjEGMYQETLF
         Kq+A==
X-Forwarded-Encrypted: i=1; AJvYcCXdn9p8f57TnQYSkLEJW/FB0tW8bYys033crfmWhEeOHHGfgIuo3/6ALCJ5gq3a1UOpd162jyzvnmr4Fsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE18McCI2SdlklOO/yNosCuUbf5Y7si06y1Emf2J/QuIX4w0gB
	HydGw2LIAuD33A7rLdaZnmDWexQx3bhF1Y5crD903YYUuh08bpuSq+Mk2MWFCIbJZuXOE1e/BXi
	6qPct7o5qFA==
X-Google-Smtp-Source: AGHT+IF8vdJDKvGLsvTQvgAsP/DNyJ5otwtCZgR3B2II3FkJG+cRU0VYMTYD1iadajRkM2BnXV0BxcynsvJ72Q==
X-Received: from wmlf18.prod.google.com ([2002:a7b:c8d2:0:b0:434:9da4:2fa5])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:350c:b0:434:a4a6:51f8 with SMTP id 5b1f17b1804b1-4361c2bbb02mr71819045e9.0.1734026804672;
 Thu, 12 Dec 2024 10:06:44 -0800 (PST)
Date: Thu, 12 Dec 2024 18:04:22 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-59-smostafa@google.com>
Subject: [RFC PATCH v2 58/58] iommu/arm-smmu-v3-kvm: Support command queue batching
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

Similar to the kernel driver, we can batch commands at EL2 to avoid
writing to MMIO space, this is quite noticable if the SMMU doesn't
support range invalidation so it has to invalidate page per page.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/include/asm/arm-smmu-v3-common.h | 16 ++++
 arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c | 95 ++++++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 15 ----
 3 files changed, 88 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/include/asm/arm-smmu-v3-common.h b/arch/arm64/include/asm/arm-smmu-v3-common.h
index f2fbd286f674..2578c8e9202e 100644
--- a/arch/arm64/include/asm/arm-smmu-v3-common.h
+++ b/arch/arm64/include/asm/arm-smmu-v3-common.h
@@ -573,4 +573,20 @@ struct arm_smmu_cmdq_ent {
 	};
 };
 
+#define Q_OVERFLOW_FLAG			(1U << 31)
+#define Q_OVF(p)			((p) & Q_OVERFLOW_FLAG)
+
+/*
+ * This is used to size the command queue and therefore must be at least
+ * BITS_PER_LONG so that the valid_map works correctly (it relies on the
+ * total number of queue entries being a multiple of BITS_PER_LONG).
+ */
+#define CMDQ_BATCH_ENTRIES		BITS_PER_LONG
+
+struct arm_smmu_cmdq_batch {
+	u64				cmds[CMDQ_BATCH_ENTRIES * CMDQ_ENT_DWORDS];
+	struct arm_smmu_cmdq		*cmdq;
+	int				num;
+};
+
 #endif /* _ARM_SMMU_V3_COMMON_H */
diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
index 60f0760f49eb..62760136c6fb 100644
--- a/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
@@ -96,12 +96,20 @@ static void smmu_reclaim_pages(u64 phys, size_t size)
 #define Q_WRAP(smmu, reg)	((reg) & (1 << (smmu)->cmdq_log2size))
 #define Q_IDX(smmu, reg)	((reg) & ((1 << (smmu)->cmdq_log2size) - 1))
 
-static bool smmu_cmdq_full(struct hyp_arm_smmu_v3_device *smmu)
+static bool smmu_cmdq_has_space(struct hyp_arm_smmu_v3_device *smmu, u32 n)
 {
-	u64 cons = readl_relaxed(smmu->base + ARM_SMMU_CMDQ_CONS);
+	u64 smmu_cons = readl_relaxed(smmu->base + ARM_SMMU_CMDQ_CONS);
+	u32 space, prod, cons;
 
-	return Q_IDX(smmu, smmu->cmdq_prod) == Q_IDX(smmu, cons) &&
-	       Q_WRAP(smmu, smmu->cmdq_prod) != Q_WRAP(smmu, cons);
+	prod = Q_IDX(smmu, smmu->cmdq_prod);
+	cons = Q_IDX(smmu, smmu_cons);
+
+	if (Q_WRAP(smmu, smmu->cmdq_prod) == Q_WRAP(smmu, smmu_cons))
+		space = (1 << smmu->cmdq_log2size) - (prod - cons);
+	else
+		space = cons - prod;
+
+	return space >= n;
 }
 
 static bool smmu_cmdq_empty(struct hyp_arm_smmu_v3_device *smmu)
@@ -112,22 +120,8 @@ static bool smmu_cmdq_empty(struct hyp_arm_smmu_v3_device *smmu)
 	       Q_WRAP(smmu, smmu->cmdq_prod) == Q_WRAP(smmu, cons);
 }
 
-static int smmu_add_cmd(struct hyp_arm_smmu_v3_device *smmu,
-			struct arm_smmu_cmdq_ent *ent)
+static int smmu_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 {
-	int i;
-	int ret;
-	u64 cmd[CMDQ_ENT_DWORDS] = {};
-	int idx = Q_IDX(smmu, smmu->cmdq_prod);
-	u64 *slot = smmu->cmdq_base + idx * CMDQ_ENT_DWORDS;
-
-	if (smmu->iommu.power_is_off)
-		return -EPIPE;
-
-	ret = smmu_wait_event(smmu, !smmu_cmdq_full(smmu));
-	if (ret)
-		return ret;
-
 	cmd[0] |= FIELD_PREP(CMDQ_0_OP, ent->opcode);
 
 	switch (ent->opcode) {
@@ -175,15 +169,49 @@ static int smmu_add_cmd(struct hyp_arm_smmu_v3_device *smmu,
 		return -EINVAL;
 	}
 
-	for (i = 0; i < CMDQ_ENT_DWORDS; i++)
-		slot[i] = cpu_to_le64(cmd[i]);
+	return 0;
+}
+
+static int smmu_issue_cmds(struct hyp_arm_smmu_v3_device *smmu,
+			   u64 *cmds, int n)
+{
+	int idx = Q_IDX(smmu, smmu->cmdq_prod);
+	u64 *slot = smmu->cmdq_base + idx * CMDQ_ENT_DWORDS;
+	int i;
+	int ret;
+	u32 prod;
+
+	if (smmu->iommu.power_is_off)
+		return -EPIPE;
+
+	ret = smmu_wait_event(smmu, smmu_cmdq_has_space(smmu, n));
+	if (ret)
+		return ret;
+
+	for (i = 0; i < CMDQ_ENT_DWORDS * n; i++)
+		slot[i] = cpu_to_le64(cmds[i]);
+
+	prod = (Q_WRAP(smmu, smmu->cmdq_prod) | Q_IDX(smmu, smmu->cmdq_prod)) + n;
+	smmu->cmdq_prod = Q_OVF(smmu->cmdq_prod) | Q_WRAP(smmu, prod) | Q_IDX(smmu, prod);
 
-	smmu->cmdq_prod++;
 	writel(Q_IDX(smmu, smmu->cmdq_prod) | Q_WRAP(smmu, smmu->cmdq_prod),
 	       smmu->base + ARM_SMMU_CMDQ_PROD);
 	return 0;
 }
 
+static int smmu_add_cmd(struct hyp_arm_smmu_v3_device *smmu,
+			struct arm_smmu_cmdq_ent *ent)
+{
+	u64 cmd[CMDQ_ENT_DWORDS] = {};
+	int ret;
+
+	ret = smmu_build_cmd(cmd, ent);
+	if (ret)
+		return ret;
+
+	return smmu_issue_cmds(smmu, cmd, 1);
+}
+
 static int smmu_sync_cmd(struct hyp_arm_smmu_v3_device *smmu)
 {
 	int ret;
@@ -685,6 +713,23 @@ static void smmu_tlb_flush_all(void *cookie)
 	kvm_iommu_unlock(&smmu->iommu);
 }
 
+static void smmu_cmdq_batch_add(struct hyp_arm_smmu_v3_device *smmu,
+				struct arm_smmu_cmdq_batch *cmds,
+				struct arm_smmu_cmdq_ent *cmd)
+{
+	int index;
+
+	if (cmds->num == CMDQ_BATCH_ENTRIES) {
+		smmu_issue_cmds(smmu, cmds->cmds, cmds->num);
+		cmds->num = 0;
+	}
+
+	index = cmds->num * CMDQ_ENT_DWORDS;
+	smmu_build_cmd(&cmds->cmds[index], cmd);
+
+	cmds->num++;
+}
+
 static int smmu_tlb_inv_range_smmu(struct hyp_arm_smmu_v3_device *smmu,
 				   struct kvm_hyp_iommu_domain *domain,
 				   struct arm_smmu_cmdq_ent *cmd,
@@ -694,6 +739,7 @@ static int smmu_tlb_inv_range_smmu(struct hyp_arm_smmu_v3_device *smmu,
 	unsigned long end = iova + size, num_pages = 0, tg = 0;
 	size_t inv_range = granule;
 	struct hyp_arm_smmu_v3_domain *smmu_domain = domain->priv;
+	struct arm_smmu_cmdq_batch cmds;
 
 	kvm_iommu_lock(&smmu->iommu);
 	if (smmu->iommu.power_is_off)
@@ -723,6 +769,8 @@ static int smmu_tlb_inv_range_smmu(struct hyp_arm_smmu_v3_device *smmu,
 			num_pages++;
 	}
 
+	cmds.num = 0;
+
 	while (iova < end) {
 		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
 			/*
@@ -749,11 +797,12 @@ static int smmu_tlb_inv_range_smmu(struct hyp_arm_smmu_v3_device *smmu,
 			num_pages -= num << scale;
 		}
 		cmd->tlbi.addr = iova;
-		WARN_ON(smmu_add_cmd(smmu, cmd));
+		smmu_cmdq_batch_add(smmu, &cmds, cmd);
 		BUG_ON(iova + inv_range < iova);
 		iova += inv_range;
 	}
 
+	WARN_ON(smmu_issue_cmds(smmu, cmds.cmds, cmds.num));
 	ret = smmu_sync_cmd(smmu);
 out_ret:
 	kvm_iommu_unlock(&smmu->iommu);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index d91dfe55835d..18f878bb7f98 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -20,8 +20,6 @@ struct arm_smmu_device;
 
 #define Q_IDX(llq, p)			((p) & ((1 << (llq)->max_n_shift) - 1))
 #define Q_WRP(llq, p)			((p) & (1 << (llq)->max_n_shift))
-#define Q_OVERFLOW_FLAG			(1U << 31)
-#define Q_OVF(p)			((p) & Q_OVERFLOW_FLAG)
 #define Q_ENT(q, p)			((q)->base +			\
 					 Q_IDX(&((q)->llq), p) *	\
 					 (q)->ent_dwords)
@@ -35,13 +33,6 @@ struct arm_smmu_device;
 
 #define CMDQ_PROD_OWNED_FLAG		Q_OVERFLOW_FLAG
 
-/*
- * This is used to size the command queue and therefore must be at least
- * BITS_PER_LONG so that the valid_map works correctly (it relies on the
- * total number of queue entries being a multiple of BITS_PER_LONG).
- */
-#define CMDQ_BATCH_ENTRIES		BITS_PER_LONG
-
 /* High-level queue structures */
 #define ARM_SMMU_POLL_TIMEOUT_US	1000000 /* 1s! */
 #define ARM_SMMU_POLL_SPIN_COUNT	10
@@ -100,12 +91,6 @@ static inline bool arm_smmu_cmdq_supports_cmd(struct arm_smmu_cmdq *cmdq,
 	return cmdq->supports_cmd ? cmdq->supports_cmd(ent) : true;
 }
 
-struct arm_smmu_cmdq_batch {
-	u64				cmds[CMDQ_BATCH_ENTRIES * CMDQ_ENT_DWORDS];
-	struct arm_smmu_cmdq		*cmdq;
-	int				num;
-};
-
 struct arm_smmu_evtq {
 	struct arm_smmu_queue		q;
 	struct iopf_queue		*iopf;
-- 
2.47.0.338.g60cca15819-goog


