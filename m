Return-Path: <linux-kernel+bounces-178375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04038C4CC5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 09:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ACDF282576
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 07:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510A2179A3;
	Tue, 14 May 2024 07:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqvWTVEZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1C515EA6
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 07:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671395; cv=none; b=gq9rMZdG8+WKdxYJTp0+fqBHB1fvpU+kamXcYSW0HloAvJbzl52Z/+SE8hFo2m3AiObTF1CXCxX4Fs5O6M+VM/i40bA0kMl5xivjSHXsNGqvceDK9tsvGwp545QPvdUjEKUuc8TFDbdGnjL/M+3/QktrPjk3+HRJh7mWA7ZkH6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671395; c=relaxed/simple;
	bh=wY+GRzCRFH5gnq+ih1QfRxaZi4OYPpugBgelwQ2YeW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJJGFECm4zJVjyU4qDygTFYCZ/W+uf9uz9CgXFCZGMq9ahDVWsX0e0f0xLu8r/6GG0ptO6jZeNgD/cGCNABO/M4sN5yPVKwOkMJzGmdW+nPeL0t8ib5oUamwiOaEDoD2QI0QpNIJ9tTZYQFXhAsw/v02BdbcgURjJuEjgzoO4qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BqvWTVEZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715671393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qmTJtxNzwCydsCweSeZKkzPt91K1xWWXybaXzLbEATg=;
	b=BqvWTVEZamN6OO+g9CpoFWHLO8RZxz6jAyYvHYI02r7pf9lBiEQuBj1gfG+RzLyMlBFtVS
	SBcWQZOGG4+rnsqOqJezauoQdW/5i1bx9s3PPJHJxGGVqmKHSsmp91yvfhDOH0WFC6bkC5
	emtcCsF6vt1jifgfa8aaKgHjcbM+8r0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-7-ECFLzTMqqfLicpe3mnIQ-1; Tue, 14 May 2024 03:23:11 -0400
X-MC-Unique: 7-ECFLzTMqqfLicpe3mnIQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-43de2f59d09so65725751cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 00:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715671390; x=1716276190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmTJtxNzwCydsCweSeZKkzPt91K1xWWXybaXzLbEATg=;
        b=V7IJZypS48FXYoOTDr7cFGiaSuVkwe8RLvzKvqiui8zD+1Zo/QwKggIqhJkVoYZdJb
         Qyby7T4XLQ7PMeLhvUubWCqQ4qFJpbhdgwY9Op/ifDDSdKJKFWSfnK0PmVUyjJfqHNpb
         SbfaXMkL5VgLglV7vuOrlkaVIgdHpdGNt0WzXXCmAbq8kPtDKrAqxocLzIJQo0CqWgDX
         eeks95itvHlNvBSrqSwHF7W5nLx5mtZzcJSp3Cl1Ls73h1NCpNc/D5y2svXuojxLqR83
         dgU7lO+jDja45OAVdncZIhTGSzAmfnHAxortZ83Z9yfvmiVCki2mZ1OrgegeqHP8hdf3
         b3KA==
X-Forwarded-Encrypted: i=1; AJvYcCWRPgxDc99/pnlixkntMp2vcGT+CqUGjUbEL22irBfjq7sm2m/gI/q1vx0GylLKtp2oCpSrimY5q9MYtSl/qV2JUR7O3bO5EgJ7wLib
X-Gm-Message-State: AOJu0Yxe5+rNk1tehJR0/vBaOBW+ej6krlGeSuSJIN9OKHzTKRXAo+aX
	bas2L4kC2FE7QXUFIupSRBzGHVqsXO2+h26lhnfJvqzgnpD4Ri5alDfZCjVMFJ51doGgUlk1PpU
	FvZLL/v0GFBFw+F2rCiwyjqGSWUWt1PzlFSmCSpBQ/jau3tH6UIE4lQTwfyYLpQ==
X-Received: by 2002:a05:6214:5b87:b0:6a0:cd69:374d with SMTP id 6a1803df08f44-6a16824151fmr150030376d6.50.1715671390420;
        Tue, 14 May 2024 00:23:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ2R7/7LcuNEr1pVh3mkLXVqAI7slnKMsvoAq1Lye2TXziw5bgVSkgrOVRGpraSzpR7RDmOA==
X-Received: by 2002:a05:6214:5b87:b0:6a0:cd69:374d with SMTP id 6a1803df08f44-6a16824151fmr150030156d6.50.1715671389920;
        Tue, 14 May 2024 00:23:09 -0700 (PDT)
Received: from rh.redhat.com (p200300c93f4cc600a5cdf10de606b5e2.dip0.t-ipconnect.de. [2003:c9:3f4c:c600:a5cd:f10d:e606:b5e2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1ccd4esm50917516d6.97.2024.05.14.00.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 00:23:09 -0700 (PDT)
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
Subject: [PATCH v3 6/6] KVM: selftests: arm64: Test writes to CTR_EL0
Date: Tue, 14 May 2024 09:22:52 +0200
Message-ID: <20240514072252.5657-7-sebott@redhat.com>
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

Test that CTR_EL0 is modifiable from userspace, that changes are
visible to guests, and that they are preserved across a vCPU reset.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 .../testing/selftests/kvm/aarch64/set_id_regs.c  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/kvm/aarch64/set_id_regs.c b/tools/testing/selftests/kvm/aarch64/set_id_regs.c
index a7de39fa2a0a..9583c04f1228 100644
--- a/tools/testing/selftests/kvm/aarch64/set_id_regs.c
+++ b/tools/testing/selftests/kvm/aarch64/set_id_regs.c
@@ -219,6 +219,7 @@ static void guest_code(void)
 	GUEST_REG_SYNC(SYS_ID_AA64MMFR1_EL1);
 	GUEST_REG_SYNC(SYS_ID_AA64MMFR2_EL1);
 	GUEST_REG_SYNC(SYS_ID_AA64ZFR0_EL1);
+	GUEST_REG_SYNC(SYS_CTR_EL0);
 
 	GUEST_DONE();
 }
@@ -490,11 +491,25 @@ static void test_clidr(struct kvm_vcpu *vcpu)
 	test_reg_vals[encoding_to_range_idx(SYS_CLIDR_EL1)] = clidr;
 }
 
+static void test_ctr(struct kvm_vcpu *vcpu)
+{
+	u64 ctr;
+
+	vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_CTR_EL0), &ctr);
+	ctr &= ~CTR_EL0_DIC_MASK;
+	if (ctr & CTR_EL0_IminLine_MASK)
+		ctr--;
+
+	vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_CTR_EL0), ctr);
+	test_reg_vals[encoding_to_range_idx(SYS_CTR_EL0)] = ctr;
+}
+
 static void test_vcpu_ftr_id_regs(struct kvm_vcpu *vcpu)
 {
 	u64 val;
 
 	test_clidr(vcpu);
+	test_ctr(vcpu);
 
 	vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_MPIDR_EL1), &val);
 	val++;
@@ -525,6 +540,7 @@ static void test_reset_preserves_id_regs(struct kvm_vcpu *vcpu)
 		test_assert_id_reg_unchanged(vcpu, test_regs[i].reg);
 
 	test_assert_id_reg_unchanged(vcpu, SYS_CLIDR_EL1);
+	test_assert_id_reg_unchanged(vcpu, SYS_CTR_EL0);
 
 	ksft_test_result_pass("%s\n", __func__);
 }
-- 
2.42.0


