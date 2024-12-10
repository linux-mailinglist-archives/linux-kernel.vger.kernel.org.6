Return-Path: <linux-kernel+bounces-438902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA939EA83C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 06:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD37E188CBFE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 05:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D33622839D;
	Tue, 10 Dec 2024 05:54:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D580B227592
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 05:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733810063; cv=none; b=npo1hsoON2g7T2nXY7+WJtsadSNO22yISbFgzTZPbFXwdjW3od6gm3lHzFl5tT3udniJgZIt32059Ng9qr4TUGOXILoIkg92S6I38ATv8HpIChBByU763+KKDno1wOWWwewaEXp5DLlgmeaDo1skulhBKsCipZh+BwYHy1XtGE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733810063; c=relaxed/simple;
	bh=1RlLYctFbW5Kwc1/mtCPA1pFyYkzRM/kpPE2QU96Saw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jHECFyBAM/OQ4ybd2XRRv9r3D0Mck0WM72bw3xawLHsgLtHtHQSlSsa5b/pj8F76TvyZlh6Qp+jVZkcPGLT+EEKDsxrEDp4Pxfk2Zhqfv/2QlCkptfnxHOfSns5QJ0ZR08d1ZsbHnTJWILt50lbKYDm3wuC++PDoSkvMcu5vbpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50C4D113E;
	Mon,  9 Dec 2024 21:54:48 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.48.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EB6373F58B;
	Mon,  9 Dec 2024 21:54:15 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	maz@kernel.org
Cc: ryan.roberts@arm.com,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH V2 12/46] arm64/sysreg: Add register fields for TRBMPAM_EL1
Date: Tue, 10 Dec 2024 11:22:37 +0530
Message-Id: <20241210055311.780688-13-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241210055311.780688-1-anshuman.khandual@arm.com>
References: <20241210055311.780688-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds register fields for TRBMPAM_EL1 as per the definitions based
on DDI0601 2024-09.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/sysreg | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index a5e31e4c4474..78564b24b187 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -3413,6 +3413,19 @@ EndEnum
 Field	7:0	Attr
 EndSysreg
 
+Sysreg	TRBMPAM_EL1	3	0	9	11	5
+Res0	63:27
+Field 	26	EN
+UnsignedEnum	25:24	MPAM_SP
+	0b00	SECURE_PARTID
+	0b01	NON_SECURE_PARTID
+	0b10	ROOT_PARTID
+	0b11	REALM_PARTID
+EndEnum
+Field	23:16	PMG
+Field	15:0	PARTID
+EndSysreg
+
 Sysreg	TRBTRG_EL1	3	0	9	11	6
 Res0	63:32
 Field	31:0	TRG
-- 
2.25.1


