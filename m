Return-Path: <linux-kernel+bounces-438913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 069C79EA847
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 06:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A5916B6B0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 05:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F5D227578;
	Tue, 10 Dec 2024 05:55:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C56C228367
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 05:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733810131; cv=none; b=uxsRjtgxxLFW13fcSWH0K6DFt3NxyuEOuGrbjjBKb4lcfg0zSHrza3kyLZqJTTNQtpzb1hGkfiKbnhtLzPea1KQGIWuiHdnlF1J++x31prS14dIpzfuUlyETI8O8mx9OzwD4Jywy9aRLqB1JqtJriHX7uBLqkTxya4J++P2cSsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733810131; c=relaxed/simple;
	bh=xSBEoCorZlY1lWDEC5qLIfdNP/wF1P/IJSrPeR2Cz4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=urfkui5AXsZeqpU7ugpF/mB74ljflJKPYVyikqaoEJR4AxPyQaH5Q2FbVBs7DpvXML753q26Nzad2z6PSMbMyJgGKIuvwFRLK86FSbP1JykvKRupEOaXG+riyIM+8O4D5uVDaWDoHfb5v3/4UI1XRZbzBactORNse0SCLrrmWyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F5A1113E;
	Mon,  9 Dec 2024 21:55:57 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.48.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C04C53F58B;
	Mon,  9 Dec 2024 21:55:25 -0800 (PST)
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
Subject: [PATCH V2 23/46] arm64/sysreg: Add register fields for PMICFILTR_EL0
Date: Tue, 10 Dec 2024 11:22:48 +0530
Message-Id: <20241210055311.780688-24-anshuman.khandual@arm.com>
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

This adds register fields for PMICFILTR_EL0 as per the definitions based
on DDI0601 2024-09.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/sysreg | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 8baf57c06dbd..7db912a81bbd 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2595,6 +2595,27 @@ Sysreg	PMICNTR_EL0	3	3	9	4	0
 Field	63:0	ICNT
 EndSysreg
 
+Sysreg	PMICFILTR_EL0	3	3	9	6	0
+Res0	63:59
+Field	58	SYNC
+Field	57:56	VS
+Res0	55:32
+Field	31	P
+Field	30	U
+Field	29	NSK
+Field	28	NSU
+Field	27	NSH
+Field	26	M
+Res0	25
+Field	24	SH
+Field	23	T
+Field	22	RLK
+Field	21	RLU
+Field	20	RLH
+Res0	19:16
+Field	15:0	evtCount
+EndSysreg
+
 SysregFields	HFGxTR_EL2
 Field	63	nAMAIR2_EL1
 Field	62	nMAIR2_EL1
-- 
2.25.1


