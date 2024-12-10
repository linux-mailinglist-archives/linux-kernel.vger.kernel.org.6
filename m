Return-Path: <linux-kernel+bounces-438925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2CD9EA855
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB21188ECCB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 06:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28282227588;
	Tue, 10 Dec 2024 05:56:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BE822ACE6
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 05:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733810183; cv=none; b=cRVr+JLsNQOTVzVcuillre6bf1QRAmJtcU+gSeVznTTu0ONjQWs3Ju/AWk9aO5Kqt3xnGwEfREIPHlbn084JId4peSwj3QIgjQWABrBWxGZXB2CmhHRzONpIBLyMugqgCQQtfnkDcCKuGdnJAzXKkrFEeR1tswEDxIwSbIZJPNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733810183; c=relaxed/simple;
	bh=938nBJtBrRKWZT5HkfYq9eUO6nVS84CROf9Iurs+qgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LDyTspHBaitv2AEkHu84tXOa+7mG31T9gahPAo8LsXdfrgnymSHSG9YvgchxNJZVd0I6ypStaE1MgA1/MNQRnwfqoMnlHKPy7L7WdCVfccT1WlWhO+l6N03rg3CrmkJXy6P8hGrhr5CyT/NhcMvZsTyfX0hL5nTCSojduDFQT+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F784113E;
	Mon,  9 Dec 2024 21:56:50 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.48.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D5FAA3F58B;
	Mon,  9 Dec 2024 21:56:17 -0800 (PST)
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
Subject: [PATCH V2 35/46] arm64/sysreg: Add register fields for SPMCFGR_EL1
Date: Tue, 10 Dec 2024 11:23:00 +0530
Message-Id: <20241210055311.780688-36-anshuman.khandual@arm.com>
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

This adds register fields for SPMCFGR_EL1 as per the definitions based
on DDI0601 2024-09.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/sysreg | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index d423bb218a9f..f4f5d22948ad 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -178,6 +178,24 @@ Field	15:8	Aff1
 Field	7:0	Aff0
 EndSysreg
 
+Sysreg	SPMCFGR_EL1	2	0	9	13	7
+Res0	63:32
+Field	31:28	NCG
+Res0	27:25
+Field	24	HDBG
+Field	23	TR0
+Field	22	SS
+Field	21	FZ0
+Field	20	MSI
+Field	19	RAO
+Res0	18
+Field	17	NA
+Field	16	EX
+Field	15:14	RAZ
+Field	13:8	SIZE
+Field	7:0	N
+EndSysreg
+
 Sysreg	SPMINTENSET_EL1	2	0	9	14	1
 Field	63	P63
 Field	62	P62
-- 
2.25.1


