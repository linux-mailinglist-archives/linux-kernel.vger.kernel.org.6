Return-Path: <linux-kernel+bounces-178396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046178C4CFF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 09:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 677F3B22807
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 07:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7849A17C77;
	Tue, 14 May 2024 07:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HsnkgtWf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B3117BD2
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 07:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671688; cv=none; b=MBqoa1Qc28RHHl8NKmJYUx1YcgR/kgIgNJu6h7cFc2CNduhjY/3TpefSq6oUZTln5WIWwjU0s24zIwn3IwIerX5aOGmEvzT/Wie95Al3AHRDeuJKRsVGy84fT66YHxbZjG8ThCT9XhCRN1Lze+KutW8/zw3J6/Kes6LosDavl4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671688; c=relaxed/simple;
	bh=pdBP/poxNQkLoCpZlP6M+ozK0xi+66h+bhcdCKIIlcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WmE0Put4QKrtMeq8QWqTG4gmUxidm7MkOkC2lB6SAwu7uL0+QKnEH1jZISlXroFl9o/EZUKphnKqFXwYgVTzJKXN8fOlYZ3Xs1YHDgCNF4Iqa41xDS856+b4q79BZXP0tqS1+dXe8hc74TbzA9QCNMHQk3mqzCxGhWtKfNN6dyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HsnkgtWf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715671685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/gMpEmtI+IAI1lEUeLeMcm+4WhBEW2fmE2xkm8KyS0=;
	b=HsnkgtWfLaJUiuvaDbosuUK1q1zk7LT1kchu6i+xOiKtlPCre073qV6ujsUMScTDisRHrR
	RGs8P51z9UUyx5YlcxRlTxdQwnt0/RrfmHG39/fQAI3TvIOpi6cIkMHLDMzt4Uz1RxQsgH
	USNCWLKLL3HdZvzeEGueKmyCRCPMunQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-YCjYwyIZNeKtW8ejBJzPow-1; Tue, 14 May 2024 03:23:04 -0400
X-MC-Unique: YCjYwyIZNeKtW8ejBJzPow-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6a1530209deso123553006d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 00:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715671384; x=1716276184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/gMpEmtI+IAI1lEUeLeMcm+4WhBEW2fmE2xkm8KyS0=;
        b=TwzJAk+6KkHKSLj0M3ucrIpuCWVpOvebltuGNcbzCx/GCKEXGG0YB/x9gS1xUSFMVQ
         CpnoO9DCyIJCQC8c/DZKOAK4txJDGv07Vq1RcVXk+0VLsNR4iitTbYWtRuqNXJn6Nwye
         jgOUJ313aSWUeXJC1jEHFKHcq/KOH8s5gA81+3K6Xd8KLNf3wDk2dVo1SbKgDNm4alds
         arbHl609pj0QWzdg0rF3v+eZ74sj/wZ8CzoiyrPbIkeeK4jfU21m5gy8gdpkzk9QV/DY
         h2gI9s/3rzXxg3GLx5696a8C3qKru3eoScNLVZ62rB7l8OW0PnYDeGrmiAPv95b9tLW+
         rkSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsbB5mCQT+IqQQHOIcekvDZiBl0td53Ne1QKw3zt2RQ9U3MmzYUd0ENovGGesIt7gnoEIf5Jn14DvEdy0CoNOYZs84fSMHRvb4PvdN
X-Gm-Message-State: AOJu0Yxlw0J6tRLe3ButjDx7pbboHIrxFckqq/FLTYqlYRDFnspWZX1z
	ySvGmsyLcmikweXgBzbOvwlMJPNdmt2cKOWYr3z08KOSnXqC/tvGMa6lmIE1sgVeXPL+9hDON4u
	Jb/ztdBnBBqP52Tm2gzCIT93R3exZirtx3yB3LHzAWjTicdeJd1GskMexHTJ0ZA==
X-Received: by 2002:a05:6214:4903:b0:6a0:e5cd:a66a with SMTP id 6a1803df08f44-6a16798b72cmr206212086d6.24.1715671383844;
        Tue, 14 May 2024 00:23:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJGrKm6swz5CxYuqHAR7YAvfD3qZgiXFXmXmEN+UZo19xxwFL5nUJkieiEsNX+PH4OW99qRg==
X-Received: by 2002:a05:6214:4903:b0:6a0:e5cd:a66a with SMTP id 6a1803df08f44-6a16798b72cmr206211936d6.24.1715671383475;
        Tue, 14 May 2024 00:23:03 -0700 (PDT)
Received: from rh.redhat.com (p200300c93f4cc600a5cdf10de606b5e2.dip0.t-ipconnect.de. [2003:c9:3f4c:c600:a5cd:f10d:e606:b5e2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1ccd4esm50917516d6.97.2024.05.14.00.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 00:23:03 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v3 3/6] KVM: arm64: add emulation for CTR_EL0 register
Date: Tue, 14 May 2024 09:22:49 +0200
Message-ID: <20240514072252.5657-4-sebott@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514072252.5657-1-sebott@redhat.com>
References: <20240514072252.5657-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CTR_EL0 is currently handled as an invariant register, thus
guests will be presented with the host value of that register.

Add emulation for CTR_EL0 based on a per VM value. Userspace can
switch off DIC and IDC bits and reduce DminLine and IminLine sizes.

When CTR_EL0 is changed validate that against CLIDR_EL1 and CCSIDR_EL1
to make sure we present the guest with consistent register values.
Changes that affect the generated cache topology values are allowed if
they don't clash with previous register writes.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 arch/arm64/kvm/sys_regs.c | 130 +++++++++++++++++++++++++++++++++-----
 1 file changed, 114 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 0213c96f73f2..8e8acf3dd9bd 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -215,13 +215,8 @@ void vcpu_write_sys_reg(struct kvm_vcpu *vcpu, u64 val, int reg)
 /* CSSELR values; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
 #define CSSELR_MAX 14
 
-/*
- * Returns the minimum line size for the selected cache, expressed as
- * Log2(bytes).
- */
-static u8 get_min_cache_line_size(struct kvm *kvm, bool icache)
+static u8 __get_min_cache_line_size(u64 ctr, bool icache)
 {
-	u64 ctr = kvm->arch.ctr_el0;
 	u8 field;
 
 	if (icache)
@@ -240,6 +235,15 @@ static u8 get_min_cache_line_size(struct kvm *kvm, bool icache)
 	return field + 2;
 }
 
+/*
+ * Returns the minimum line size for the selected cache, expressed as
+ * Log2(bytes).
+ */
+static u8 get_min_cache_line_size(struct kvm *kvm, bool icache)
+{
+	return __get_min_cache_line_size(kvm->arch.ctr_el0, icache);
+}
+
 /* Which cache CCSIDR represents depends on CSSELR value. */
 static u32 get_ccsidr(struct kvm_vcpu *vcpu, u32 csselr)
 {
@@ -1880,6 +1884,45 @@ static int set_wi_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 	return 0;
 }
 
+static const struct sys_reg_desc *get_sys_reg_desc(u32 encoding);
+
+static int validate_clidr_el1(u64 clidr_el1, u64 ctr_el0)
+{
+	u64 idc = !CLIDR_LOC(clidr_el1) ||
+		  (!CLIDR_LOUIS(clidr_el1) && !CLIDR_LOUU(clidr_el1));
+
+	if ((clidr_el1 & CLIDR_EL1_RES0) || (!(ctr_el0 & CTR_EL0_IDC) && idc))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int validate_cache_top(struct kvm_vcpu *vcpu, u64 ctr_el0)
+{
+	const struct sys_reg_desc *clidr_el1;
+	unsigned int i;
+	int ret;
+
+	clidr_el1 = get_sys_reg_desc(SYS_CLIDR_EL1);
+	if (!clidr_el1)
+		return -ENOENT;
+
+	ret = validate_clidr_el1(__vcpu_sys_reg(vcpu, clidr_el1->reg), ctr_el0);
+	if (ret)
+		return ret;
+
+	if (!vcpu->arch.ccsidr)
+		return 0;
+
+	for (i = 0; i < CSSELR_MAX; i++) {
+		if ((FIELD_GET(CCSIDR_EL1_LineSize, get_ccsidr(vcpu, i)) + 4)
+		    < __get_min_cache_line_size(ctr_el0, i & CSSELR_EL1_InD))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 static bool access_ctr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 		       const struct sys_reg_desc *r)
 {
@@ -1890,6 +1933,55 @@ static bool access_ctr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	return true;
 }
 
+static u64 reset_ctr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd)
+{
+	vcpu->kvm->arch.ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
+	return vcpu->kvm->arch.ctr_el0;
+}
+
+static int get_ctr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
+		   u64 *val)
+{
+	*val = vcpu->kvm->arch.ctr_el0;
+	return 0;
+}
+
+static int set_ctr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
+		   u64 val)
+{
+	u64 ctr = vcpu->kvm->arch.ctr_el0;
+	u64 writable_mask = rd->val;
+	int ret;
+
+	if (val == ctr)
+		return 0;
+
+	if (kvm_vm_has_ran_once(vcpu->kvm))
+		return -EBUSY;
+
+	if ((ctr & ~writable_mask) != (val & ~writable_mask))
+		return -EINVAL;
+
+	if (((ctr & CTR_EL0_DIC_MASK) < (val & CTR_EL0_DIC_MASK)) ||
+	    ((ctr & CTR_EL0_IDC_MASK) < (val & CTR_EL0_IDC_MASK)) ||
+	    ((ctr & CTR_EL0_DminLine_MASK) < (val & CTR_EL0_DminLine_MASK)) ||
+	    ((ctr & CTR_EL0_IminLine_MASK) < (val & CTR_EL0_IminLine_MASK))) {
+		return -EINVAL;
+	}
+
+	mutex_lock(&vcpu->kvm->arch.config_lock);
+	ret = validate_cache_top(vcpu, val);
+	if (ret) {
+		mutex_unlock(&vcpu->kvm->arch.config_lock);
+		return ret;
+	}
+
+	vcpu->kvm->arch.ctr_el0 = val;
+	mutex_unlock(&vcpu->kvm->arch.config_lock);
+
+	return 0;
+}
+
 static bool access_clidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			 const struct sys_reg_desc *r)
 {
@@ -1959,10 +2051,9 @@ static u64 reset_clidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 static int set_clidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 		      u64 val)
 {
-	u64 idc = !CLIDR_LOC(val) || (!CLIDR_LOUIS(val) && !CLIDR_LOUU(val));
 	u64 ctr_el0 = vcpu->kvm->arch.ctr_el0;
 
-	if ((val & CLIDR_EL1_RES0) || (!(ctr_el0 & CTR_EL0_IDC) && idc))
+	if (validate_clidr_el1(val, ctr_el0))
 		return -EINVAL;
 
 	__vcpu_sys_reg(vcpu, rd->reg) = val;
@@ -2475,7 +2566,11 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_CCSIDR2_EL1), undef_access },
 	{ SYS_DESC(SYS_SMIDR_EL1), undef_access },
 	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
-	{ SYS_DESC(SYS_CTR_EL0), access_ctr },
+	{ SYS_DESC(SYS_CTR_EL0), access_ctr, .reset = reset_ctr,
+	  .get_user = get_ctr, .set_user = set_ctr, .val = (CTR_EL0_DIC_MASK |
+							    CTR_EL0_IDC_MASK |
+							    CTR_EL0_DminLine_MASK |
+							    CTR_EL0_IminLine_MASK)},
 	{ SYS_DESC(SYS_SVCR), undef_access },
 
 	{ PMU_SYS_REG(PMCR_EL0), .access = access_pmcr, .reset = reset_pmcr,
@@ -3651,6 +3746,13 @@ static bool index_to_params(u64 id, struct sys_reg_params *params)
 	}
 }
 
+static const struct sys_reg_desc *get_sys_reg_desc(u32 encoding)
+{
+	struct sys_reg_params params = encoding_to_params(encoding);
+
+	return find_reg(&params, sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
+}
+
 const struct sys_reg_desc *get_reg_by_id(u64 id,
 					 const struct sys_reg_desc table[],
 					 unsigned int num)
@@ -3704,18 +3806,11 @@ FUNCTION_INVARIANT(midr_el1)
 FUNCTION_INVARIANT(revidr_el1)
 FUNCTION_INVARIANT(aidr_el1)
 
-static u64 get_ctr_el0(struct kvm_vcpu *v, const struct sys_reg_desc *r)
-{
-	((struct sys_reg_desc *)r)->val = read_sanitised_ftr_reg(SYS_CTR_EL0);
-	return ((struct sys_reg_desc *)r)->val;
-}
-
 /* ->val is filled in by kvm_sys_reg_table_init() */
 static struct sys_reg_desc invariant_sys_regs[] __ro_after_init = {
 	{ SYS_DESC(SYS_MIDR_EL1), NULL, get_midr_el1 },
 	{ SYS_DESC(SYS_REVIDR_EL1), NULL, get_revidr_el1 },
 	{ SYS_DESC(SYS_AIDR_EL1), NULL, get_aidr_el1 },
-	{ SYS_DESC(SYS_CTR_EL0), NULL, get_ctr_el0 },
 };
 
 static int get_invariant_sys_reg(u64 id, u64 __user *uaddr)
@@ -4083,6 +4178,9 @@ static void vcpu_set_hcr(struct kvm_vcpu *vcpu)
 	 */
 	if (!kvm_has_feat(kvm, ID_AA64ISAR0_EL1, TLB, OS))
 		vcpu->arch.hcr_el2 |= HCR_TTLBOS;
+
+	if (kvm->arch.ctr_el0 != read_sanitised_ftr_reg(SYS_CTR_EL0))
+		vcpu->arch.hcr_el2 |= HCR_TID2;
 }
 
 void kvm_calculate_traps(struct kvm_vcpu *vcpu)
-- 
2.42.0


