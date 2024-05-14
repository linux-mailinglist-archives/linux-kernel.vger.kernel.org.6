Return-Path: <linux-kernel+bounces-178373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D26B08C4CC3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 09:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EC721F216BD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 07:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BB011723;
	Tue, 14 May 2024 07:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SGyU4jV5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228091DA2F
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 07:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671386; cv=none; b=Ny63u6gwmPeTCJIwvGbzM4mCHDQB8FxdpUjK8PbmgnuTc08DJQrX1clI1bzjdrc1YGTcQIQEPSrQN1vQDDZ6e9Se7KSmlAecJQ/uZFCS3njRZkiEqcD4i0KK/hsScN1aopMzhL48LKMhCclCc/EQ0rE3kKPLa3Vj0ApmENuM0DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671386; c=relaxed/simple;
	bh=dLdaCow7P2Xib4OcE/09HYpSkp4Gr7+ElTge/KPtjtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lew1AloBmzNt92005lpJB+DkvvxN7utSL71kjKdtMBUJtCCm0EnjqNKBF2jXtAnNoL6kvEPEaK7vTaICkVr28X22lBjLi4FXRpb79YvC6hyNxLQkYi7/NniCpkGtJkMtxXdEHVBWAg6tcIfamDssDt7Ui5FIUa+NCaeHuJe5qkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SGyU4jV5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715671384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4wO7UP5uZ9GbYlk7RUrHboh34vCyWLtZOIaQcDBJ5dg=;
	b=SGyU4jV5c+l3E88dldqILC7h5HdXU6lHb/7hcsr5kNB8pcBs89pbAJzc1E/yvAeSzJ/5Dr
	P+ezDXoaG7STtxpqSwG++HQ0HgQoC9te8R3Dr/j5ah+kpMIKMxfDuE2IdXzsPTySnAaX7m
	iwa2sVvDK+jM4uxOMKunzSy2NxSJneI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-rL4hHq40NwKgNbe-w82gdA-1; Tue, 14 May 2024 03:23:02 -0400
X-MC-Unique: rL4hHq40NwKgNbe-w82gdA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6a1530209deso123552706d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 00:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715671382; x=1716276182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wO7UP5uZ9GbYlk7RUrHboh34vCyWLtZOIaQcDBJ5dg=;
        b=Et4H7vKmJYCTUa5/Ytr95E1Bx8RJ8cTHUvPveUEbNro9sG3w5MzgdnbmLtNJMVy14N
         l3//Beq6ehtzDXDW7bAK43zjWd2KJYNJHMHqPcBlcniHFq7059PXQXs67a0zdVInXXzm
         yZle+EkKQqWNuurrrWBFSA1ux0dv5WWm3Kg4mj4QqVHOxl5PCCDaUEwqSmwEybAYkY8k
         zZW6vITpfPE5H1724g6Zfw2lQH6fbymOrSBpz2wB4eKnoePKLxN0qblbIFfwsCbklkJE
         cJr7JG4wKMzWOJaSjJCO/JHehwgMER/fgeIq/WgVLce5W1W+1XdPv4JBqW5puseyBYv+
         tAhw==
X-Forwarded-Encrypted: i=1; AJvYcCW/mEeq7vrRblqeBid1byJZNXZ0n0+F7rDlACa0wJOviOR7yjo2vcZQ9CIEp5BNDdmtvSGXV6hJ6tk1XKJvI07PS+yMjzDsljR9Uof1
X-Gm-Message-State: AOJu0YwsZQ0AgyBicWdrCkCeTvIBjlD77g18X9l7PWZs9+ejtMpWcpTd
	xTQbpwmCskSzGN/cq7BjQWhFHaKz9DaMSD3326qa+aRvABOF/cr3CFOY6hOL5LGjRVohZXbH0Vs
	59hm43DK/33gA790E0atJowBZRfZ/WgrVZNfXIvUuArYOjW0RzKJbphM91lFIOQ==
X-Received: by 2002:a0c:eec6:0:b0:6a0:e8ed:49a6 with SMTP id 6a1803df08f44-6a15cc96cedmr264843776d6.27.1715671381819;
        Tue, 14 May 2024 00:23:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL+IuDEP1OeSc3CrfYuG8GF7qjHL+o2EAfKbDGMN9FevsDKBoeIuPMJwzJc0jicKEcMQt2kw==
X-Received: by 2002:a0c:eec6:0:b0:6a0:e8ed:49a6 with SMTP id 6a1803df08f44-6a15cc96cedmr264843506d6.27.1715671381475;
        Tue, 14 May 2024 00:23:01 -0700 (PDT)
Received: from rh.redhat.com (p200300c93f4cc600a5cdf10de606b5e2.dip0.t-ipconnect.de. [2003:c9:3f4c:c600:a5cd:f10d:e606:b5e2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1ccd4esm50917516d6.97.2024.05.14.00.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 00:23:01 -0700 (PDT)
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
Subject: [PATCH v3 2/6] KVM: arm64: maintain per VM value for CTR_EL0
Date: Tue, 14 May 2024 09:22:48 +0200
Message-ID: <20240514072252.5657-3-sebott@redhat.com>
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

In preparation for CTR_EL0 emulation maintain a per VM for this
register and use it where appropriate.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 arch/arm64/include/asm/kvm_host.h |  2 ++
 arch/arm64/kvm/sys_regs.c         | 21 ++++++++++++++-------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 212ae77eefaf..1259be5e2f3e 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -331,6 +331,8 @@ struct kvm_arch {
 #define KVM_ARM_ID_REG_NUM	(IDREG_IDX(sys_reg(3, 0, 0, 7, 7)) + 1)
 	u64 id_regs[KVM_ARM_ID_REG_NUM];
 
+	u64 ctr_el0;
+
 	/* Masks for VNCR-baked sysregs */
 	struct kvm_sysreg_masks	*sysreg_masks;
 
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 41741bf4d2b2..0213c96f73f2 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -219,9 +219,9 @@ void vcpu_write_sys_reg(struct kvm_vcpu *vcpu, u64 val, int reg)
  * Returns the minimum line size for the selected cache, expressed as
  * Log2(bytes).
  */
-static u8 get_min_cache_line_size(bool icache)
+static u8 get_min_cache_line_size(struct kvm *kvm, bool icache)
 {
-	u64 ctr = read_sanitised_ftr_reg(SYS_CTR_EL0);
+	u64 ctr = kvm->arch.ctr_el0;
 	u8 field;
 
 	if (icache)
@@ -248,7 +248,7 @@ static u32 get_ccsidr(struct kvm_vcpu *vcpu, u32 csselr)
 	if (vcpu->arch.ccsidr)
 		return vcpu->arch.ccsidr[csselr];
 
-	line_size = get_min_cache_line_size(csselr & CSSELR_EL1_InD);
+	line_size = get_min_cache_line_size(vcpu->kvm, csselr & CSSELR_EL1_InD);
 
 	/*
 	 * Fabricate a CCSIDR value as the overriding value does not exist.
@@ -283,7 +283,7 @@ static int set_ccsidr(struct kvm_vcpu *vcpu, u32 csselr, u32 val)
 	u32 i;
 
 	if ((val & CCSIDR_EL1_RES0) ||
-	    line_size < get_min_cache_line_size(csselr & CSSELR_EL1_InD))
+	    line_size < get_min_cache_line_size(vcpu->kvm, csselr & CSSELR_EL1_InD))
 		return -EINVAL;
 
 	if (!ccsidr) {
@@ -1886,7 +1886,7 @@ static bool access_ctr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	if (p->is_write)
 		return write_to_read_only(vcpu, p, r);
 
-	p->regval = read_sanitised_ftr_reg(SYS_CTR_EL0);
+	p->regval = vcpu->kvm->arch.ctr_el0;
 	return true;
 }
 
@@ -1906,7 +1906,7 @@ static bool access_clidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
  */
 static u64 reset_clidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 {
-	u64 ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
+	u64 ctr_el0 = vcpu->kvm->arch.ctr_el0;
 	u64 clidr;
 	u8 loc;
 
@@ -1959,8 +1959,8 @@ static u64 reset_clidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 static int set_clidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 		      u64 val)
 {
-	u64 ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
 	u64 idc = !CLIDR_LOC(val) || (!CLIDR_LOUIS(val) && !CLIDR_LOUU(val));
+	u64 ctr_el0 = vcpu->kvm->arch.ctr_el0;
 
 	if ((val & CLIDR_EL1_RES0) || (!(ctr_el0 & CTR_EL0_IDC) && idc))
 		return -EINVAL;
@@ -3557,6 +3557,13 @@ void kvm_reset_sys_regs(struct kvm_vcpu *vcpu)
 	struct kvm *kvm = vcpu->kvm;
 	unsigned long i;
 
+	if (!kvm_vcpu_initialized(vcpu))
+		/*
+		 * Make sure CTR_EL0 is initialized before registers
+		 * that depend on it are reset.
+		 */
+		kvm->arch.ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
+
 	for (i = 0; i < ARRAY_SIZE(sys_reg_descs); i++) {
 		const struct sys_reg_desc *r = &sys_reg_descs[i];
 
-- 
2.42.0


