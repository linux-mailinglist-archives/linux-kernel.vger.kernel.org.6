Return-Path: <linux-kernel+bounces-549662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4441A55531
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFAEF188D93A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9274826B966;
	Thu,  6 Mar 2025 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Miyyzai8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F34225D54C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741286420; cv=none; b=b6c7sz6DhpW018oFmKtvSmhfHBjQQJ4AE3daIpT0KKMN1ClwNZ4j5OvmiPwneVk+oDH6FEHe/aRHgGJQxMct0FvBXDsfWwgVImZuShOtMvu1tDZNsuyupqy98AI3ggO0H4YcGsM0VT7cDzSIY0oPgM7Q8sPv2V9on6IXjPvhgKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741286420; c=relaxed/simple;
	bh=LkKR288RE+h611Y9F4OQZCS2oNAv31ZfvfnKlmFsXKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PJIKCs3c1vGBrtLf0PFctBeVltMzAT/4ZXW05vxPOmnzPdMSAC0dB4dsVuGvrwE7Ag4/79rFQbnAmPBgVq6NAZ3mI1CrCH5KnPCSEUkBwczs69O+d2zC30CRLMwfnFgY2+BdPrm+IYiZ1Zhrwt2LYp64VA4zOV0LRt/sHt9N+vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Miyyzai8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741286418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9Lmst4VUAQQ3LJJdXWEWRCBJzpFOzVT70uwpvEP3i+I=;
	b=Miyyzai8kfdrFmB4GwGRK0dk4g8iMo7gVUKadGBAt/zzo2RXxQTE5Mm0SosPLWM57mSBWH
	dZDZuvNa+ZJOFtIHe6VEx2jKkh+mrtQGAC9tU+ZGPjclm3+RUCo6xNcXoALDN/+OslfBwm
	96xpubaEIPcxtv/D8lGx/vpZwtXJ2is=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-UQ2ZaQfMNuy9MuKnYOQxmQ-1; Thu, 06 Mar 2025 13:40:16 -0500
X-MC-Unique: UQ2ZaQfMNuy9MuKnYOQxmQ-1
X-Mimecast-MFC-AGG-ID: UQ2ZaQfMNuy9MuKnYOQxmQ_1741286415
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3910b93cb1eso538273f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 10:40:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741286415; x=1741891215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Lmst4VUAQQ3LJJdXWEWRCBJzpFOzVT70uwpvEP3i+I=;
        b=Eh0rCI24XbslcoMC+HHG7zFUPjQiEC2jVafcEhiMM4OCTToSSOhIvE6K9KrRO6oU4p
         VdCbpqD168rEQEF9GTYyQyx7Gw/mPNLmjo8Kb6cGETubmeqYLh+FmaIprTWRnMUNTllZ
         Tl3+30rKQY2ucd4f0nUkyjCiWCtj53dIEgp55OWGsRwB2uZ1arNrTS4LVTcDt45r4z4g
         gwDup2SNTbuwBSchmxk+pYqF9+PG/7Fw4XXuoxcsPUy0WTBzTxRgoiRllcyOQZSatI4l
         BU9zvLcOAF+TQhbjvsrzgThS+22gpm6sEa8SLBvxXcU//SIa6UgEa1bFibBMYO3dWYyR
         lAYA==
X-Forwarded-Encrypted: i=1; AJvYcCXes40kvtZ9b2IDziwRUjNJm3bKKzDUZ/aaCz/CkjnktvT3ub2sXhKo5s21PpQZ/Cg2MULv7I50qUHirP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi7xwSNl9nLpof74tcAuaWOc0BxIRr0e3WBIXwsQ2FHXdLD0iH
	lkGYRnTR/hjm2fj9mRAOfed6ukbkJ1Ls+kXbVAyQNWJCV3ITb3UXUUH6ua5p9HK4AqNYSMhc5JQ
	CKRU8v9oVRV/i0+IDVCrEptaJpnuoFIUm/miJPsHbgtd9YtnRQTOLUc4b+31E6g==
X-Gm-Gg: ASbGnctzR78dCNGy5sof4c289n8Z+YdNblPMR7h9IxTxi/SH2wwpukd9Bs0PaTg/hwG
	FfJCwx9teDVdxT0bxH9aCjoRLnFf4Vq/0r0cD3n8b9AMogPbt3nNsThwyotJsANKjSn0TcTQ7/+
	uQFpW9du9DZw2wzICoSm7Pwqq9xKI00LBWk6aq3jmgWIXr2YTn/xN3YHAOp4xyt55eU2k71ZL3U
	9N9zXzt2aNMWNDEquVx3aagOSCzX5ssJpxZb3U+qnWpsT/DYajHBWW+tqRQpHUdr2mZ3rjyAqix
	HciYQ9/cGDUgHaqbthOp/DhePe2psMRJWYBskty46QAcKywSPXMmIR46Ks5T23hFuIXdVeE82is
	bcA==
X-Received: by 2002:a5d:47a2:0:b0:391:3150:96fb with SMTP id ffacd0b85a97d-39132d6325bmr200932f8f.23.1741286415179;
        Thu, 06 Mar 2025 10:40:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+PIlhHHUzNDRAUatrj6r8bLMc9x2BjUmkvzjVG8Z/wDAKyIEVDRSOx3ZM1Q7ROAl8MR6S/Q==
X-Received: by 2002:a5d:47a2:0:b0:391:3150:96fb with SMTP id ffacd0b85a97d-39132d6325bmr200910f8f.23.1741286414795;
        Thu, 06 Mar 2025 10:40:14 -0800 (PST)
Received: from rh.fritz.box (p200300f6af284000f9ca1328aeaacdd4.dip0.t-ipconnect.de. [2003:f6:af28:4000:f9ca:1328:aeaa:cdd4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfcdasm2767640f8f.23.2025.03.06.10.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 10:40:14 -0800 (PST)
From: Sebastian Ott <sebott@redhat.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: arm64: Writable TGRAN*_2
Date: Thu,  6 Mar 2025 19:40:13 +0100
Message-ID: <20250306184013.30008-1-sebott@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow userspace to write the safe (NI) value for ID_AA64MMFR0_EL1.TGRAN*_2.
Disallow to change these fields for NV since kvm provides a sanitized view
for them based on the PAGE_SIZE.
Also add these bits to the set_id_regs selftest.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 arch/arm64/kvm/sys_regs.c                     | 21 +++++++++++++++----
 .../testing/selftests/kvm/arm64/set_id_regs.c |  3 +++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 14faf213d483..0730ed8314d0 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1948,6 +1948,21 @@ static int set_id_aa64pfr1_el1(struct kvm_vcpu *vcpu,
 	return set_id_reg(vcpu, rd, user_val);
 }
 
+static int set_id_aa64mmfr0_el1(struct kvm_vcpu *vcpu,
+				const struct sys_reg_desc *rd, u64 user_val)
+{
+	u64 sanitized_val = kvm_read_sanitised_id_reg(vcpu, rd);
+	u64 tgran2_mask = ID_AA64MMFR0_EL1_TGRAN4_2_MASK |
+			  ID_AA64MMFR0_EL1_TGRAN16_2_MASK |
+			  ID_AA64MMFR0_EL1_TGRAN64_2_MASK;
+
+	if (vcpu_has_nv(vcpu) &&
+	    ((sanitized_val & tgran2_mask) != (user_val & tgran2_mask)))
+		return -EINVAL;
+
+	return set_id_reg(vcpu, rd, user_val);
+}
+
 static int set_id_aa64mmfr2_el1(struct kvm_vcpu *vcpu,
 				const struct sys_reg_desc *rd, u64 user_val)
 {
@@ -2787,10 +2802,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	ID_UNALLOCATED(6,7),
 
 	/* CRm=7 */
-	ID_WRITABLE(ID_AA64MMFR0_EL1, ~(ID_AA64MMFR0_EL1_RES0 |
-					ID_AA64MMFR0_EL1_TGRAN4_2 |
-					ID_AA64MMFR0_EL1_TGRAN64_2 |
-					ID_AA64MMFR0_EL1_TGRAN16_2 |
+	ID_FILTERED(ID_AA64MMFR0_EL1, id_aa64mmfr0_el1,
+				      ~(ID_AA64MMFR0_EL1_RES0 |
 					ID_AA64MMFR0_EL1_ASIDBITS)),
 	ID_WRITABLE(ID_AA64MMFR1_EL1, ~(ID_AA64MMFR1_EL1_RES0 |
 					ID_AA64MMFR1_EL1_HCX |
diff --git a/tools/testing/selftests/kvm/arm64/set_id_regs.c b/tools/testing/selftests/kvm/arm64/set_id_regs.c
index 1d65f4a09e6f..322b9d3b0125 100644
--- a/tools/testing/selftests/kvm/arm64/set_id_regs.c
+++ b/tools/testing/selftests/kvm/arm64/set_id_regs.c
@@ -146,6 +146,9 @@ static const struct reg_ftr_bits ftr_id_aa64pfr1_el1[] = {
 static const struct reg_ftr_bits ftr_id_aa64mmfr0_el1[] = {
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64MMFR0_EL1, ECV, 0),
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64MMFR0_EL1, EXS, 0),
+	REG_FTR_BITS(FTR_EXACT, ID_AA64MMFR0_EL1, TGRAN4_2, 1),
+	REG_FTR_BITS(FTR_EXACT, ID_AA64MMFR0_EL1, TGRAN64_2, 1),
+	REG_FTR_BITS(FTR_EXACT, ID_AA64MMFR0_EL1, TGRAN16_2, 1),
 	S_REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64MMFR0_EL1, TGRAN4, 0),
 	S_REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64MMFR0_EL1, TGRAN64, 0),
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64MMFR0_EL1, TGRAN16, 0),
-- 
2.42.0


