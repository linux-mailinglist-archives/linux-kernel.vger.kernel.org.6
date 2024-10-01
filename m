Return-Path: <linux-kernel+bounces-345133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFDF98B270
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 04:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F28C7285203
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 02:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394607581B;
	Tue,  1 Oct 2024 02:45:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDCB74E26
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 02:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727750722; cv=none; b=ODP5rUzqfY9XF18ux6Vxd9BV6VViE5JK/4IZ6WNVq6NHCarxvpPIVpmCn29xA4Fvn0UiaL66G1SlM7PXvdZCpqmhBHwUw+UnQ0Lf4ZhPCKQhVPoZQ0NCk7SVwioKo2A4zVUAQG1aOYmKflAwk0/IWQ1K+NmXBTKG46hyUmjo2nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727750722; c=relaxed/simple;
	bh=QpWWLEKHzMWsLJ7pOprUWrOxJOJasgVq7bpn6Xc0Q/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OjOsfOXdvf/55UChEbNB7EaWntyhtFCoHgBFljcXjZGIZ4s0oHYHM3LScTiHvmVQS813wc9s5fKEgWPxza6KJSio6nq/pqVNc8+WTQspaUEpJAMd/a/9XWZDk+6rjpfiGaGkocEhEzwuJTda6dGB3symNwG4YgBeoP9Yx3+mA7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B2A4367;
	Mon, 30 Sep 2024 19:45:50 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.61])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 79C413F58B;
	Mon, 30 Sep 2024 19:45:17 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	maz@kernel.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 19/47] arm64/sysreg: Add register fields for PMUACR_EL1
Date: Tue,  1 Oct 2024 08:13:28 +0530
Message-Id: <20241001024356.1096072-20-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241001024356.1096072-1-anshuman.khandual@arm.com>
References: <20241001024356.1096072-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds register fields for PMUACR_EL1 as per the definitions based
on DDI0601 2024-06.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/sysreg | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 7e16e436eb58..05799570a2d0 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2246,6 +2246,43 @@ Res0	63:5
 Field	4:0	SEL
 EndSysreg
 
+Sysreg	PMUACR_EL1	3	0	9	14	4
+Res0	63:33
+Field	32	FM
+Field	31	C
+Field	30	P30
+Field	29	P29
+Field	28	P28
+Field	27	P27
+Field	26	P26
+Field	25	P25
+Field	24	P24
+Field	23	P23
+Field	22	P22
+Field	21	P21
+Field	20	P20
+Field	19	P19
+Field	18	P18
+Field	17	P17
+Field	16	P16
+Field	15	P15
+Field	14	P14
+Field	13	P13
+Field	12	P12
+Field	11	P11
+Field	10	P10
+Field	9	P9
+Field	8	P8
+Field	7	P7
+Field	6	P6
+Field	5	P5
+Field	4	P4
+Field	3	P3
+Field	2	P2
+Field	1	P1
+Field	0	P0
+EndSysreg
+
 Sysreg	PMECR_EL1	3	0	9	14	5
 Res0	63:5
 UnsignedEnum	4:3	SSE
-- 
2.25.1


