Return-Path: <linux-kernel+bounces-572163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DECA6C784
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 04:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F11D7A7E6F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 03:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA15139D1B;
	Sat, 22 Mar 2025 03:51:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E705081ACA
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 03:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742615494; cv=none; b=NSOo2S2FE2bMke/+u5Qjc0pUkpFI5hHGoJthRn+nV9aRLf+c6dLpCyNyglik1Qd6GcVko1WlDzrtvqbz5eql+FvYH8aeBgJ7wZFk7cjqvSNoE7pfXjHj82EkYHW4gDXgQ/X2SxpEYlwH6clCIT0xn8l5qgpwwMv0FfD9Ty1u18Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742615494; c=relaxed/simple;
	bh=02WrvHsOfQhcL/BORu8PlTubY86zzCr9LziW66YhE2w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JUmP21GIBcEE6SaXXH4fhUqQLCtPc1RvloSSp5GD93RS/ZypBil8pFcWGy3g7BNYPMHEcw1AvCFNXqug08wrZ6Hca2eYIiGct6SzCjHmaROczxKe9aq9SekvFiN85kSInV3olCnALMnQs79MeG/4g++FH/akBWBUV7GdlD28n7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 324DD106F;
	Fri, 21 Mar 2025 20:51:38 -0700 (PDT)
Received: from entos-yitian-01.. (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 04ADF3F694;
	Fri, 21 Mar 2025 20:51:26 -0700 (PDT)
From: Jia He <justin.he@arm.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev
Cc: Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	Jia He <justin.he@arm.com>
Subject: [PATCH] KVM: arm64: pmu: Avoid initializing KVM PMU when KVM is not initialised
Date: Sat, 22 Mar 2025 03:51:15 +0000
Message-Id: <20250322035115.118048-1-justin.he@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, `kvm_host_pmu_init()` does not check if KVM has been
successfully initialized before proceeding. This can lead to unintended
behavior if the function is called in an environment where KVM is not
available, e.g., kernel is landed in EL1.

Signed-off-by: Jia He <justin.he@arm.com>
---
 arch/arm64/kvm/pmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index 7169c1a24dd6..e39c48d12b81 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -227,6 +227,13 @@ void kvm_host_pmu_init(struct arm_pmu *pmu)
 {
 	struct arm_pmu_entry *entry;
 
+	/*
+	 * Prevent unintended behavior where KVM is not available or not
+	 * successfully initialised, e.g., kernel is landed in EL1.
+	 */
+	if (!is_kvm_arm_initialised())
+		return;
+
 	/*
 	 * Check the sanitised PMU version for the system, as KVM does not
 	 * support implementations where PMUv3 exists on a subset of CPUs.
-- 
2.34.1


