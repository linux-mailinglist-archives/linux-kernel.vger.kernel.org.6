Return-Path: <linux-kernel+bounces-519869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F9EA3A2F0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205C51885708
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341D826FA4B;
	Tue, 18 Feb 2025 16:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+yWgzCh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E716826D5CA
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739896495; cv=none; b=N4rQgICC+bASnOQIVAZ8GySz2J/pbhL547WqC/b7zTlcfzKagfUtJElDczOPCQEU5RDQnap4PFFjhN+ybxJ7lFcDsYBzbtLMi4zRXNYkTpFJ9esGkcdd0ZTT+ZTk1VRh6MDjpo637fvcJ4ayqzxYCHEoGdosl/70x5kKkdBbitA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739896495; c=relaxed/simple;
	bh=48SNocFIEyTD401Bn7uEPWmyPGgbFKE7acbIYbRpQLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+c/ix7Ezz7kqqKdInLIgAncC805wYYc38+jEs2Li1co0qKx6+ZSj6fb1FnB6Fs2fpEeFkAvcuMVU9Z1XKzjX5ePlW4ggYMKDehH656UGYjRU/SWL3nneSgaFHMnlCfaDteUJX0EUYroBLqYhHlHbmcKlTlUgoGfq1SYMYsNZUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X+yWgzCh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739896493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RdghYHu234rwHRoSlAkfrkrUKfnT4YJfki186RS5/GU=;
	b=X+yWgzChE/hRGL1PfDgdeo0Jqz2At+8DUApHp6BeWWzx6B5TskMMI2f6WrRHalmz+FDqb9
	rYEvW9VFnKiHLB52RLjg8tKTwkUubYicgs2dc0PE2/Ky0OV8HelpV5jo/SB1nr4/6w/hZh
	qgUepxPo8u9otPlROvl/58I+c1KyTco=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-gQFdXMjyN6az8V25UKJiOw-1; Tue, 18 Feb 2025 11:34:51 -0500
X-MC-Unique: gQFdXMjyN6az8V25UKJiOw-1
X-Mimecast-MFC-AGG-ID: gQFdXMjyN6az8V25UKJiOw_1739896491
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43942e82719so49555345e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:34:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739896490; x=1740501290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdghYHu234rwHRoSlAkfrkrUKfnT4YJfki186RS5/GU=;
        b=omJVA5fAfTi9csn5ixeudD0lX2Lwzgg+K8dKn/nIcaRZuGDGU117XbZAk7pMLlZtdV
         tKOa645HfjrlU47owRVN1COlL2byaIJ41TyXUWLjFBYx3lSmfgNqk3cBypy23TpNrDR9
         BDLdTIGKNti9HEKYYWeu+NUP+os5FzKNOFu2vMJYYZV7w2aR+EtuFFyNaanIJzPfsb65
         t5rcm6sGuF+XDBR/QTdkKKwxGi0zZUWhrau7QhXjU4hiCX2CgNOowa3rwqOzcEUSQUdH
         ePw5agfDK2D8NYqClVDEvCLlWvxjvw+gPpoZBqEVr6kasb5JKz65EwfciHtC+muO5I3V
         Mbeg==
X-Forwarded-Encrypted: i=1; AJvYcCUYvmHNLmuZ8zcHwBBaYcfMzVxi7FF39jD4fEwEpl0JVhr6c0WEeNM5MmFtKS6WEQdSUo55ggkhIWRO5z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTzJrJP2OGFHbBzXZYI61v6ngKUyM89zOPt2zwk03cQjmeVakL
	+wTazA3OBdZnTsCF6rxTnhvXWAXvUmkDrNjipEOtcAMI01m7AECzQUTpsXgvhIR6Yoe/VosyxuZ
	vZw8k+djLL5ZugulfMtkepyJEQKwvmo3Iw88nJUq0BxltwEfPPPMPQTDnR5MOLQ==
X-Gm-Gg: ASbGnct0Ic/Ek1H5n5Tl2obCVmzniSMBXvATWgaw+4rVj8c29qHhHZ/+htEaHNXEpvT
	woptH52yrYdHf3YMJJbXZA49YCt3I6ddf9UCzDheOXixQ1aLRBDzFP+fGndYpkWX+WkCyNwYDzf
	QUyBPTyzP1arO7ucQ3fda+fUxMvTmGjUd2jcNyVzPtGhFLTDw9lOEF7hugxANLsHEriY1NoDXMw
	lVnbsmk/x6V680pT9K2Nu5282oHrKOMlnqy8hEy4jHwcgNw9pLYjTCA8SatSFICJZ6r/oeKBBwE
	ZcV6Ix9XAC8iy/0yYbd+XciJM+tCBVwll9f7uaQK2y+t0vOm34fQAPeTRC/tXo+Vgyvj
X-Received: by 2002:a05:600c:3b9c:b0:439:967b:46fc with SMTP id 5b1f17b1804b1-43999d8f506mr3286565e9.8.1739896490602;
        Tue, 18 Feb 2025 08:34:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGr/dmaK1oQWajwLZOsOW11YMixQScvE0fX+ohPe438Pqvb/Vo3/S0ChTjcAbtFCmmO7n+NIw==
X-Received: by 2002:a05:600c:3b9c:b0:439:967b:46fc with SMTP id 5b1f17b1804b1-43999d8f506mr3286265e9.8.1739896490174;
        Tue, 18 Feb 2025 08:34:50 -0800 (PST)
Received: from rh.redhat.com (p200300f6af0e4d00dda53016e366575f.dip0.t-ipconnect.de. [2003:f6:af0e:4d00:dda5:3016:e366:575f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4396b5267eesm85091845e9.0.2025.02.18.08.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 08:34:49 -0800 (PST)
From: Sebastian Ott <sebott@redhat.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: Cornelia Huck <cohuck@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] KVM: selftests: arm64: Test writes to MIDR,REVIDR,AIDR
Date: Tue, 18 Feb 2025 17:34:43 +0100
Message-ID: <20250218163443.32836-5-sebott@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218163443.32836-1-sebott@redhat.com>
References: <20250218163443.32836-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assert that MIDR_EL1, REVIDR_EL1, AIDR_EL1 are writable from userspace,
that the changed values are visible to guests, and that they are
preserved across a vCPU reset.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 .../testing/selftests/kvm/arm64/set_id_regs.c | 32 +++++++++++++++----
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/set_id_regs.c b/tools/testing/selftests/kvm/arm64/set_id_regs.c
index 217541fe6536..d719c2ab1e31 100644
--- a/tools/testing/selftests/kvm/arm64/set_id_regs.c
+++ b/tools/testing/selftests/kvm/arm64/set_id_regs.c
@@ -230,6 +230,9 @@ static void guest_code(void)
 	GUEST_REG_SYNC(SYS_ID_AA64MMFR2_EL1);
 	GUEST_REG_SYNC(SYS_ID_AA64ZFR0_EL1);
 	GUEST_REG_SYNC(SYS_CTR_EL0);
+	GUEST_REG_SYNC(SYS_MIDR_EL1);
+	GUEST_REG_SYNC(SYS_REVIDR_EL1);
+	GUEST_REG_SYNC(SYS_AIDR_EL1);
 
 	GUEST_DONE();
 }
@@ -609,18 +612,31 @@ static void test_ctr(struct kvm_vcpu *vcpu)
 	test_reg_vals[encoding_to_range_idx(SYS_CTR_EL0)] = ctr;
 }
 
-static void test_vcpu_ftr_id_regs(struct kvm_vcpu *vcpu)
+static void test_id_reg(struct kvm_vcpu *vcpu, u32 id)
 {
 	u64 val;
 
+	val = vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(id));
+	val++;
+	vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(id), val);
+	test_reg_vals[encoding_to_range_idx(id)] = val;
+}
+
+static void test_vcpu_ftr_id_regs(struct kvm_vcpu *vcpu)
+{
 	test_clidr(vcpu);
 	test_ctr(vcpu);
 
-	val = vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_MPIDR_EL1));
-	val++;
-	vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_MPIDR_EL1), val);
+	test_id_reg(vcpu, SYS_MPIDR_EL1);
+	ksft_test_result_pass("%s\n", __func__);
+}
+
+static void test_vcpu_non_ftr_id_regs(struct kvm_vcpu *vcpu)
+{
+	test_id_reg(vcpu, SYS_MIDR_EL1);
+	test_id_reg(vcpu, SYS_REVIDR_EL1);
+	test_id_reg(vcpu, SYS_AIDR_EL1);
 
-	test_reg_vals[encoding_to_range_idx(SYS_MPIDR_EL1)] = val;
 	ksft_test_result_pass("%s\n", __func__);
 }
 
@@ -647,6 +663,9 @@ static void test_reset_preserves_id_regs(struct kvm_vcpu *vcpu)
 	test_assert_id_reg_unchanged(vcpu, SYS_MPIDR_EL1);
 	test_assert_id_reg_unchanged(vcpu, SYS_CLIDR_EL1);
 	test_assert_id_reg_unchanged(vcpu, SYS_CTR_EL0);
+	test_assert_id_reg_unchanged(vcpu, SYS_MIDR_EL1);
+	test_assert_id_reg_unchanged(vcpu, SYS_REVIDR_EL1);
+	test_assert_id_reg_unchanged(vcpu, SYS_AIDR_EL1);
 
 	ksft_test_result_pass("%s\n", __func__);
 }
@@ -675,13 +694,14 @@ int main(void)
 		   ARRAY_SIZE(ftr_id_aa64isar2_el1) + ARRAY_SIZE(ftr_id_aa64pfr0_el1) +
 		   ARRAY_SIZE(ftr_id_aa64pfr1_el1) + ARRAY_SIZE(ftr_id_aa64mmfr0_el1) +
 		   ARRAY_SIZE(ftr_id_aa64mmfr1_el1) + ARRAY_SIZE(ftr_id_aa64mmfr2_el1) +
-		   ARRAY_SIZE(ftr_id_aa64zfr0_el1) - ARRAY_SIZE(test_regs) + 2 +
+		   ARRAY_SIZE(ftr_id_aa64zfr0_el1) - ARRAY_SIZE(test_regs) + 3 +
 		   MPAM_IDREG_TEST;
 
 	ksft_set_plan(test_cnt);
 
 	test_vm_ftr_id_regs(vcpu, aarch64_only);
 	test_vcpu_ftr_id_regs(vcpu);
+	test_vcpu_non_ftr_id_regs(vcpu);
 	test_user_set_mpam_reg(vcpu);
 
 	test_guest_reg_read(vcpu);
-- 
2.42.0


