Return-Path: <linux-kernel+bounces-199176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAAC8D8371
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D0AA1F2597F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738AE12DD92;
	Mon,  3 Jun 2024 13:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cnY/tYH3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F361D12D765
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419923; cv=none; b=gynVgcub3E8yiohbeQUD3kLWBn/aCqmHIsQG2a8TSLUVs331z8vVx9/AzWfnr2Q97mks8KM0wVuaGdFVvtHEflJIW0kE/Jkr9qwc2m/apWl68Vz4m8eGk7fRInPtL5xuy94aNS0I97gPMnLLzMryL9JpShCn2n5oMP0bsi7tf/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419923; c=relaxed/simple;
	bh=TJTRbI1YKquApQQ9jbhfJ+XZ0A2gQSbCs7exr8rWRMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OmwDXy6qFfUj63EboszYpkJ+KVm2WXtxSkvCa05JdPYI9LNm8yWUsQroTuaO7kWyzEtL0YLcl1tZNA3BkpjOfDBbImaFHiIo8GCt0cLtggr69KXsF379/udgWdN+7Q99rHUkKIkEJCz6Oku+JiTGBbLdxW5zhW5ruPWwIxG4BMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cnY/tYH3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717419921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gwVJ1n8x5DPX1iJh7AaLYp6ZnC4UC7CFdil3T4wvPJA=;
	b=cnY/tYH31smethC385iXQlguf96lhxZmRCn6k4YTlawzDhfARdlL1y0OyyJWWT88bZ102t
	GsHlzikUDza217CmEfr+Ek3aO3fd326uj5xmYfEFGtTexnYlLFejiBVcKnRueBz1Vx/o7/
	uFBBtcMVkNFHJ0zLs5VQ3X+nhpHL1JA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-oK-nfpZGMVuA3uJUFfFZLg-1; Mon, 03 Jun 2024 09:05:19 -0400
X-MC-Unique: oK-nfpZGMVuA3uJUFfFZLg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6ae259a01ffso41766406d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 06:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717419919; x=1718024719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gwVJ1n8x5DPX1iJh7AaLYp6ZnC4UC7CFdil3T4wvPJA=;
        b=BrvzWRXZbkuLMwyV41D8px9V/Bea4MWEzsJRmN/7OfIjdxrf2mOYIGWPdZxNl/voJS
         Zehq+X9BzgQmP17+6bKLY3/YFdZKLIvY/5YRuIwNJkju+suhWif8uCMhrTR3m3/8DFsT
         cFaKWYnlgE+aAybxhrM0KhVdpAAy50a1bANYGmnzfQ5Ws1EKZxKVTeP08rMK2L5AegjK
         RAgihQwjrGv+cJ8pKubIDcvOhqq+sA+9R0aJlcNNziUPb0EYlzws4nK04T5gxylbP6DQ
         5AnRpwUope/uZsvfCMdFKpZGgxzsXVYnptVx1XQUKOIM98wBtjsw6aKGRDrid1yMV2l4
         uuuw==
X-Forwarded-Encrypted: i=1; AJvYcCXptZp5L7aoBUmhDqLeOW3lP4VrgP9FLrdO5pEK2fFVWhZXZO0GlKLD7/IYNk8spHKk3DSg0rC2Iwk8/VYoqgXTIdc6XYt8omPB3VgS
X-Gm-Message-State: AOJu0YzHBZw+d8c53RBgr4nK1CXIY8FS/pECX6lhh4HTBla/mzP/X5pd
	ebh3lLmG+AMrePEeWxAL8In7qPuoRUcMVM1Mf5AmkFlex6KnEOnKfUAo8EMwy4dW4cAp0LtSVmf
	fXnxrC5Jp5zB3a9mQt5I50XlNYCdb6ez51PTtmpiws6o+PyqL0NNXDrbkmkZCSw==
X-Received: by 2002:a05:6214:3f85:b0:6ae:1055:9873 with SMTP id 6a1803df08f44-6aecd69ff0amr132249076d6.21.1717419918980;
        Mon, 03 Jun 2024 06:05:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzXldOqmMa82FdbgGR14vKWcQ/hV4lzO7eHnKKTyIwxcHDOqCEim+11uqARDYIXC9iMYqEPQ==
X-Received: by 2002:a05:6214:3f85:b0:6ae:1055:9873 with SMTP id 6a1803df08f44-6aecd69ff0amr132248586d6.21.1717419918495;
        Mon, 03 Jun 2024 06:05:18 -0700 (PDT)
Received: from rh.redhat.com (p200300c93f02d1004c157eb0f018dd01.dip0.t-ipconnect.de. [2003:c9:3f02:d100:4c15:7eb0:f018:dd01])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4b4179f4sm30558826d6.113.2024.06.03.06.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 06:05:18 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shaoqin Huang <shahuang@redhat.com>,
	Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v4 2/6] KVM: arm64: maintain per VM value for CTR_EL0
Date: Mon,  3 Jun 2024 15:05:03 +0200
Message-ID: <20240603130507.17597-3-sebott@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603130507.17597-1-sebott@redhat.com>
References: <20240603130507.17597-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for CTR_EL0 emulation maintain a per VM value for this
register and use it where appropriate.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
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


