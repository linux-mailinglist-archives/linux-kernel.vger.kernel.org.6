Return-Path: <linux-kernel+bounces-308652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 457FE965FF3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C371F21FA8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C485192D80;
	Fri, 30 Aug 2024 11:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wqvYEwUE"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D42D179652
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 11:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015845; cv=none; b=eASgVtzcI7LeeebIDjuU+2IVpmPwmeEVs86FBxvdjfD0HtwRH1cUNQRtDeCYvNz5j76RWnj/YVYHVhsZ5RQGXDY5/WIRhRWffmR3w/5iIv4Zo+yo+lxUk7/hm7t50AkJdERL0LB+bPcDggHrEZANHNKu9HAIcMm1oRz15YGHO7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015845; c=relaxed/simple;
	bh=ab9XIFNRkElNQpuGfoqIdx/EdnklAjwA/TWC7rptbwA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pOENtnhyb/12xmt9R0l99VbD82y3T93XBDbhGmikDA01GWhQmu4vHutb5DW3qkMnPUk9tykh1LNcrGBEJnqrxSfFgYk9PHNsV/pq3d6iI2Y81Gw6kgB+PjTLERe5E4dpJ32Z6qW1BxpYC2wB+IReoWbTKSUU3x23dskz+f8iBDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wqvYEwUE; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02fff66a83so2779703276.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725015842; x=1725620642; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q/mKrNSDKBnu5yum3y3zhooOe1T+Lz6kz3xJIzbyQqs=;
        b=wqvYEwUERjQv8VU0H32IBBNDuyxq9uKve0sHZWLQU3HCtYKNFiQh4KkUqeTCHpsqa+
         vTKTqEfdaQGYIkTlz9lS5moZ4ZJ6q3NA/cZrXn19KpZgubUMJI5nshu/Me+482vnzhdA
         dcc0q5n0sIxzevPi4Udp2nXS8Ei9G8cNRifxlfZuvLWinB5CnK1ynuYQfGxCo5pDqqID
         NN7WKUel3HYoMRhRHDkmYTM5fOfMBOP2L4PTWBeDmY7aW45TeB6jRlvhudJKUqrglePq
         Jw4nkh0AIPWv7QzWAwPFuGoo+B4Z2Z5Er32jS7mCIBsRQKHn+MoBzgvKLH16GJ4c+Elu
         llhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725015842; x=1725620642;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/mKrNSDKBnu5yum3y3zhooOe1T+Lz6kz3xJIzbyQqs=;
        b=kla5z/SvjKdOhg0Kj4wP0RHZ+EoYXiQtcgU5KhHYwIgDHgEZOZl3U2R6AJ+JEdNkD4
         BQCrKCF3LHCoTcL0MDSnFH7iOBxCAuNwUbqK9m29FxAeFjaVEy2I0PEABfyPVV8B3KWh
         IlUWYC4A8aWCVsSHa1+2aAgsn+D2/HEPR2qpT0VoS6uAAYOSMduDVtEzDBtL/1shMNWY
         IRRR/OdIn9yuTLBmAKRjha0QCgdTA7q4HMaGxqzz8szF+nfLqY9817bvEHV3fPxlA3R4
         52enJkMsboTNbCaXmh2P3mOpQmLcf0k15rrv1FcaOWDbSzK/GUNNVvZXE6mEFKNqPnJR
         8JoQ==
X-Gm-Message-State: AOJu0Yz5X0k16PY+xolu7oMC6/F+rO8sDpBFs8rT1PZf6eqmaRDtDn6l
	Dy61xxt3Lia3ElSGd1xnv5m20tRwsTk81ppvl1C5Wgdbj8r+1JWp18di1IPEPIXqKlFXVaVs4Rr
	gMaLczIb0vUx7GjzSsF9alHBaFzLavthK2d7iQ3GnJzoWttP/i8/GA50uZgJqLt40HeN2cK8obJ
	O0hb+qdIZ5v3Vfgl1fmBB2/L2IDDgRecECzMVLuSWAusgn/xoG5xk=
X-Google-Smtp-Source: AGHT+IHCT4BVIVvVKE9Liin+BCArrCMLiB0xZjSA3o/HnMqT8IOHQAQ0c34vg5JpBmozpHBlZUKNiQlne5c01Q==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a25:a208:0:b0:e11:5e87:aa9 with SMTP id
 3f1490d57ef6-e1a7a179ee1mr2994276.8.1725015842037; Fri, 30 Aug 2024 04:04:02
 -0700 (PDT)
Date: Fri, 30 Aug 2024 11:03:48 +0000
In-Reply-To: <20240830110349.797399-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240830110349.797399-1-smostafa@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240830110349.797399-3-smostafa@google.com>
Subject: [PATCH v4 2/2] iommu/arm-smmu-v3-test: Test masters with stall enabled
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, will@kernel.org, robin.murphy@arm.com, 
	joro@8bytes.org
Cc: jean-philippe@linaro.org, jgg@ziepe.ca, nicolinc@nvidia.com, 
	mshavit@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

At the moment, the SMMUv3 unit tests assume ATS is always enabled,
although this is sufficient to test hitless/non-hitless transitions,
but exercising other features is useful to check ste/cd population
logic (for example the .get_used logic).

Add an enum where bits define features per-master, at the moment there
is only ATS and STALLs which are mutually exclusive, but this would
make it easier to extend with other features in the future.

Also, Add 2 more tests for s1 <-> s2 transitions with stalls enabled.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 83 ++++++++++++++-----
 1 file changed, 62 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index cceb737a7001..84baa021370a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -30,6 +30,11 @@ static struct mm_struct sva_mm = {
 	.pgd = (void *)0xdaedbeefdeadbeefULL,
 };
 
+enum arm_smmu_test_master_feat {
+	ARM_SMMU_MASTER_TEST_ATS = BIT(0),
+	ARM_SMMU_MASTER_TEST_STALL = BIT(1),
+};
+
 static bool arm_smmu_entry_differs_in_used_bits(const __le64 *entry,
 						const __le64 *used_bits,
 						const __le64 *target,
@@ -164,16 +169,22 @@ static const dma_addr_t fake_cdtab_dma_addr = 0xF0F0F0F0F0F0;
 
 static void arm_smmu_test_make_cdtable_ste(struct arm_smmu_ste *ste,
 					   unsigned int s1dss,
-					   const dma_addr_t dma_addr)
+					   const dma_addr_t dma_addr,
+					   enum arm_smmu_test_master_feat feat)
 {
+	bool ats_enabled = feat & ARM_SMMU_MASTER_TEST_ATS;
+	bool stall_enabled = feat & ARM_SMMU_MASTER_TEST_STALL;
+
 	struct arm_smmu_master master = {
+		.ats_enabled = ats_enabled,
 		.cd_table.cdtab_dma = dma_addr,
 		.cd_table.s1cdmax = 0xFF,
 		.cd_table.s1fmt = STRTAB_STE_0_S1FMT_64K_L2,
 		.smmu = &smmu,
+		.stall_enabled = stall_enabled,
 	};
 
-	arm_smmu_make_cdtable_ste(ste, &master, true, s1dss);
+	arm_smmu_make_cdtable_ste(ste, &master, ats_enabled, s1dss);
 }
 
 static void arm_smmu_v3_write_ste_test_bypass_to_abort(struct kunit *test)
@@ -204,7 +215,7 @@ static void arm_smmu_v3_write_ste_test_cdtable_to_abort(struct kunit *test)
 	struct arm_smmu_ste ste;
 
 	arm_smmu_test_make_cdtable_ste(&ste, STRTAB_STE_1_S1DSS_SSID0,
-				       fake_cdtab_dma_addr);
+				       fake_cdtab_dma_addr, ARM_SMMU_MASTER_TEST_ATS);
 	arm_smmu_v3_test_ste_expect_hitless_transition(test, &ste, &abort_ste,
 						       NUM_EXPECTED_SYNCS(2));
 }
@@ -214,7 +225,7 @@ static void arm_smmu_v3_write_ste_test_abort_to_cdtable(struct kunit *test)
 	struct arm_smmu_ste ste;
 
 	arm_smmu_test_make_cdtable_ste(&ste, STRTAB_STE_1_S1DSS_SSID0,
-				       fake_cdtab_dma_addr);
+				       fake_cdtab_dma_addr, ARM_SMMU_MASTER_TEST_ATS);
 	arm_smmu_v3_test_ste_expect_hitless_transition(test, &abort_ste, &ste,
 						       NUM_EXPECTED_SYNCS(2));
 }
@@ -224,7 +235,7 @@ static void arm_smmu_v3_write_ste_test_cdtable_to_bypass(struct kunit *test)
 	struct arm_smmu_ste ste;
 
 	arm_smmu_test_make_cdtable_ste(&ste, STRTAB_STE_1_S1DSS_SSID0,
-				       fake_cdtab_dma_addr);
+				       fake_cdtab_dma_addr, ARM_SMMU_MASTER_TEST_ATS);
 	arm_smmu_v3_test_ste_expect_hitless_transition(test, &ste, &bypass_ste,
 						       NUM_EXPECTED_SYNCS(3));
 }
@@ -234,7 +245,7 @@ static void arm_smmu_v3_write_ste_test_bypass_to_cdtable(struct kunit *test)
 	struct arm_smmu_ste ste;
 
 	arm_smmu_test_make_cdtable_ste(&ste, STRTAB_STE_1_S1DSS_SSID0,
-				       fake_cdtab_dma_addr);
+				       fake_cdtab_dma_addr, ARM_SMMU_MASTER_TEST_ATS);
 	arm_smmu_v3_test_ste_expect_hitless_transition(test, &bypass_ste, &ste,
 						       NUM_EXPECTED_SYNCS(3));
 }
@@ -245,9 +256,9 @@ static void arm_smmu_v3_write_ste_test_cdtable_s1dss_change(struct kunit *test)
 	struct arm_smmu_ste s1dss_bypass;
 
 	arm_smmu_test_make_cdtable_ste(&ste, STRTAB_STE_1_S1DSS_SSID0,
-				       fake_cdtab_dma_addr);
+				       fake_cdtab_dma_addr, ARM_SMMU_MASTER_TEST_ATS);
 	arm_smmu_test_make_cdtable_ste(&s1dss_bypass, STRTAB_STE_1_S1DSS_BYPASS,
-				       fake_cdtab_dma_addr);
+				       fake_cdtab_dma_addr, ARM_SMMU_MASTER_TEST_ATS);
 
 	/*
 	 * Flipping s1dss on a CD table STE only involves changes to the second
@@ -265,7 +276,7 @@ arm_smmu_v3_write_ste_test_s1dssbypass_to_stebypass(struct kunit *test)
 	struct arm_smmu_ste s1dss_bypass;
 
 	arm_smmu_test_make_cdtable_ste(&s1dss_bypass, STRTAB_STE_1_S1DSS_BYPASS,
-				       fake_cdtab_dma_addr);
+				       fake_cdtab_dma_addr, ARM_SMMU_MASTER_TEST_ATS);
 	arm_smmu_v3_test_ste_expect_hitless_transition(
 		test, &s1dss_bypass, &bypass_ste, NUM_EXPECTED_SYNCS(2));
 }
@@ -276,16 +287,20 @@ arm_smmu_v3_write_ste_test_stebypass_to_s1dssbypass(struct kunit *test)
 	struct arm_smmu_ste s1dss_bypass;
 
 	arm_smmu_test_make_cdtable_ste(&s1dss_bypass, STRTAB_STE_1_S1DSS_BYPASS,
-				       fake_cdtab_dma_addr);
+				       fake_cdtab_dma_addr, ARM_SMMU_MASTER_TEST_ATS);
 	arm_smmu_v3_test_ste_expect_hitless_transition(
 		test, &bypass_ste, &s1dss_bypass, NUM_EXPECTED_SYNCS(2));
 }
 
 static void arm_smmu_test_make_s2_ste(struct arm_smmu_ste *ste,
-				      bool ats_enabled)
+				      enum arm_smmu_test_master_feat feat)
 {
+	bool ats_enabled = feat & ARM_SMMU_MASTER_TEST_ATS;
+	bool stall_enabled = feat & ARM_SMMU_MASTER_TEST_STALL;
 	struct arm_smmu_master master = {
+		.ats_enabled = ats_enabled,
 		.smmu = &smmu,
+		.stall_enabled = stall_enabled,
 	};
 	struct io_pgtable io_pgtable = {};
 	struct arm_smmu_domain smmu_domain = {
@@ -308,7 +323,7 @@ static void arm_smmu_v3_write_ste_test_s2_to_abort(struct kunit *test)
 {
 	struct arm_smmu_ste ste;
 
-	arm_smmu_test_make_s2_ste(&ste, true);
+	arm_smmu_test_make_s2_ste(&ste, ARM_SMMU_MASTER_TEST_ATS);
 	arm_smmu_v3_test_ste_expect_hitless_transition(test, &ste, &abort_ste,
 						       NUM_EXPECTED_SYNCS(2));
 }
@@ -317,7 +332,7 @@ static void arm_smmu_v3_write_ste_test_abort_to_s2(struct kunit *test)
 {
 	struct arm_smmu_ste ste;
 
-	arm_smmu_test_make_s2_ste(&ste, true);
+	arm_smmu_test_make_s2_ste(&ste, ARM_SMMU_MASTER_TEST_ATS);
 	arm_smmu_v3_test_ste_expect_hitless_transition(test, &abort_ste, &ste,
 						       NUM_EXPECTED_SYNCS(2));
 }
@@ -326,7 +341,7 @@ static void arm_smmu_v3_write_ste_test_s2_to_bypass(struct kunit *test)
 {
 	struct arm_smmu_ste ste;
 
-	arm_smmu_test_make_s2_ste(&ste, true);
+	arm_smmu_test_make_s2_ste(&ste, ARM_SMMU_MASTER_TEST_ATS);
 	arm_smmu_v3_test_ste_expect_hitless_transition(test, &ste, &bypass_ste,
 						       NUM_EXPECTED_SYNCS(2));
 }
@@ -335,7 +350,7 @@ static void arm_smmu_v3_write_ste_test_bypass_to_s2(struct kunit *test)
 {
 	struct arm_smmu_ste ste;
 
-	arm_smmu_test_make_s2_ste(&ste, true);
+	arm_smmu_test_make_s2_ste(&ste, ARM_SMMU_MASTER_TEST_ATS);
 	arm_smmu_v3_test_ste_expect_hitless_transition(test, &bypass_ste, &ste,
 						       NUM_EXPECTED_SYNCS(2));
 }
@@ -346,8 +361,8 @@ static void arm_smmu_v3_write_ste_test_s1_to_s2(struct kunit *test)
 	struct arm_smmu_ste s2_ste;
 
 	arm_smmu_test_make_cdtable_ste(&s1_ste, STRTAB_STE_1_S1DSS_SSID0,
-				       fake_cdtab_dma_addr);
-	arm_smmu_test_make_s2_ste(&s2_ste, true);
+				       fake_cdtab_dma_addr, ARM_SMMU_MASTER_TEST_ATS);
+	arm_smmu_test_make_s2_ste(&s2_ste, ARM_SMMU_MASTER_TEST_ATS);
 	arm_smmu_v3_test_ste_expect_hitless_transition(test, &s1_ste, &s2_ste,
 						       NUM_EXPECTED_SYNCS(3));
 }
@@ -358,8 +373,8 @@ static void arm_smmu_v3_write_ste_test_s2_to_s1(struct kunit *test)
 	struct arm_smmu_ste s2_ste;
 
 	arm_smmu_test_make_cdtable_ste(&s1_ste, STRTAB_STE_1_S1DSS_SSID0,
-				       fake_cdtab_dma_addr);
-	arm_smmu_test_make_s2_ste(&s2_ste, true);
+				       fake_cdtab_dma_addr, ARM_SMMU_MASTER_TEST_ATS);
+	arm_smmu_test_make_s2_ste(&s2_ste, ARM_SMMU_MASTER_TEST_ATS);
 	arm_smmu_v3_test_ste_expect_hitless_transition(test, &s2_ste, &s1_ste,
 						       NUM_EXPECTED_SYNCS(3));
 }
@@ -375,9 +390,9 @@ static void arm_smmu_v3_write_ste_test_non_hitless(struct kunit *test)
 	 * s1 dss field in the same update.
 	 */
 	arm_smmu_test_make_cdtable_ste(&ste, STRTAB_STE_1_S1DSS_SSID0,
-				       fake_cdtab_dma_addr);
+				       fake_cdtab_dma_addr, ARM_SMMU_MASTER_TEST_ATS);
 	arm_smmu_test_make_cdtable_ste(&ste_2, STRTAB_STE_1_S1DSS_BYPASS,
-				       0x4B4B4b4B4B);
+				       0x4B4B4b4B4B, ARM_SMMU_MASTER_TEST_ATS);
 	arm_smmu_v3_test_ste_expect_non_hitless_transition(
 		test, &ste, &ste_2, NUM_EXPECTED_SYNCS(3));
 }
@@ -503,6 +518,30 @@ static void arm_smmu_test_make_sva_release_cd(struct arm_smmu_cd *cd,
 	arm_smmu_make_sva_cd(cd, &master, NULL, asid);
 }
 
+static void arm_smmu_v3_write_ste_test_s1_to_s2_stall(struct kunit *test)
+{
+	struct arm_smmu_ste s1_ste;
+	struct arm_smmu_ste s2_ste;
+
+	arm_smmu_test_make_cdtable_ste(&s1_ste, STRTAB_STE_1_S1DSS_SSID0,
+				       fake_cdtab_dma_addr, ARM_SMMU_MASTER_TEST_STALL);
+	arm_smmu_test_make_s2_ste(&s2_ste, ARM_SMMU_MASTER_TEST_STALL);
+	arm_smmu_v3_test_ste_expect_hitless_transition(test, &s1_ste, &s2_ste,
+						       NUM_EXPECTED_SYNCS(3));
+}
+
+static void arm_smmu_v3_write_ste_test_s2_to_s1_stall(struct kunit *test)
+{
+	struct arm_smmu_ste s1_ste;
+	struct arm_smmu_ste s2_ste;
+
+	arm_smmu_test_make_cdtable_ste(&s1_ste, STRTAB_STE_1_S1DSS_SSID0,
+				       fake_cdtab_dma_addr, ARM_SMMU_MASTER_TEST_STALL);
+	arm_smmu_test_make_s2_ste(&s2_ste, ARM_SMMU_MASTER_TEST_STALL);
+	arm_smmu_v3_test_ste_expect_hitless_transition(test, &s2_ste, &s1_ste,
+						       NUM_EXPECTED_SYNCS(3));
+}
+
 static void arm_smmu_v3_write_cd_test_sva_clear(struct kunit *test)
 {
 	struct arm_smmu_cd cd = {};
@@ -547,6 +586,8 @@ static struct kunit_case arm_smmu_v3_test_cases[] = {
 	KUNIT_CASE(arm_smmu_v3_write_ste_test_non_hitless),
 	KUNIT_CASE(arm_smmu_v3_write_cd_test_s1_clear),
 	KUNIT_CASE(arm_smmu_v3_write_cd_test_s1_change_asid),
+	KUNIT_CASE(arm_smmu_v3_write_ste_test_s1_to_s2_stall),
+	KUNIT_CASE(arm_smmu_v3_write_ste_test_s2_to_s1_stall),
 	KUNIT_CASE(arm_smmu_v3_write_cd_test_sva_clear),
 	KUNIT_CASE(arm_smmu_v3_write_cd_test_sva_release),
 	{},
-- 
2.46.0.469.g59c65b2a67-goog


