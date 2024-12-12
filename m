Return-Path: <linux-kernel+bounces-443326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9747E9EED13
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C80284A6A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDA1223C67;
	Thu, 12 Dec 2024 15:40:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C958223C43
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018034; cv=none; b=aySstbzWMmipQHdZe+alKmS3DXBEU2RcFkjDSEGEGcdQV1iOtHz+LiPPQQcltDtcgiLujG8nVSgFmQH/yRNWAJsCFQigebWC3FAYYpCEbpi9sEnW1Dvuc/GGzrzv1nTcQHrzbk8An9eckrfpkAQ3+s3/YsS7x5q2vsepyCzeGAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018034; c=relaxed/simple;
	bh=TZP8HTUImwAuE055rBsksbEdAsMjhLZ+NGn0d3bO4ek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BRXqYH3aPSoaPx9rDYJjtcw8nTpmZNFx0BBJ1EmCU3+VIqnsFHyizbnpYbzBW+R1/44p+B0NenxGliwZ5zgC3nYpDu7nT8U23rWHNUp0FnVJ4sr5gTdZh2I/QmMgMej5B+3VSjwc8gcvYIhDuRYBxTGKoLeAPeYC/hnYZfxJdgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A4C21764;
	Thu, 12 Dec 2024 07:41:01 -0800 (PST)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0922F3F720;
	Thu, 12 Dec 2024 07:40:31 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Zeng Heng <zengheng4@huawei.com>,
	Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	James Morse <james.morse@arm.com>
Subject: [RFC PATCH 6/6] arm_mpam: [NFU] Development diagnostics for MPAM ID assignments
Date: Thu, 12 Dec 2024 15:40:00 +0000
Message-Id: <20241212154000.330467-7-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212154000.330467-1-Dave.Martin@arm.com>
References: <20241212154000.330467-1-Dave.Martin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Purely for development purposes, add some printks to show what MPAM
IDs actually get assigned and configured.

This would otherwise be observable only though statistical
measurements of performance (or not observable at all).

This change is not intended for upstream.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/mpam.h              | 7 +++++++
 drivers/platform/arm64/mpam/mpam_devices.c | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm64/include/asm/mpam.h b/arch/arm64/include/asm/mpam.h
index df725d2d9d05..4ae2e635e261 100644
--- a/arch/arm64/include/asm/mpam.h
+++ b/arch/arm64/include/asm/mpam.h
@@ -66,6 +66,9 @@ static inline void mpam_set_cpu_defaults(int cpu, u16 partid_d, u16 partid_i,
 	default_val |= FIELD_PREP(MPAM1_EL1_PMG_I, pmg_i);
 
 	WRITE_ONCE(per_cpu(arm64_mpam_default, cpu), default_val);
+
+	pr_info("MPAM: CPU%d -> (D=%d:%d, I=%d:%d)\n",
+		cpu, partid_d, pmg_d, partid_i, pmg_i);
 }
 
 static inline void mpam_set_task_partid_pmg(struct task_struct *tsk,
@@ -81,6 +84,10 @@ static inline void mpam_set_task_partid_pmg(struct task_struct *tsk,
 	regval |= FIELD_PREP(MPAM1_EL1_PMG_I, pmg_i);
 
 	WRITE_ONCE(task_thread_info(tsk)->mpam_partid_pmg, regval);
+
+	pr_info("MPAM: task %s[%d/%d] -> (D=%d:%d, I=%d:%d)\n",
+		current->comm, current->pid, current->tgid,
+		partid_d, pmg_d, partid_i, pmg_i);
 #endif
 }
 
diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
index 41962dd1bb68..dd84c0aa50f6 100644
--- a/drivers/platform/arm64/mpam/mpam_devices.c
+++ b/drivers/platform/arm64/mpam/mpam_devices.c
@@ -3158,6 +3158,12 @@ int mpam_apply_config(struct mpam_component *comp, u16 partid,
 
 	mpam_extend_config(comp->class, cfg);
 
+	pr_info("mpam_apply_config(): comp %d partid %d cfg={0x%x: 0x%lx, 0x%lx, %u, %u}\n",
+		comp->comp_id, partid, cfg->features,
+		(unsigned long)cfg->cpbm,
+		(unsigned long)cfg->mbw_pbm,
+		cfg->mbw_min, cfg->mbw_max);
+
 	if (!mpam_update_config(&comp->cfg[partid], cfg))
 		return 0;
 
-- 
2.34.1


