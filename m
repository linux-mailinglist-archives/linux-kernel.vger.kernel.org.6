Return-Path: <linux-kernel+bounces-438911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC7B9EA845
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 06:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831AD168B73
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 05:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DA1228377;
	Tue, 10 Dec 2024 05:55:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5968C22619B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 05:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733810122; cv=none; b=Se89xkSeqYeo8Eklm06E0SuYAFVlLm6eK0Lgex9HPYYbWW9vAv/G4K8uU32VktfXOMjLWiSizjuGape6zpuf0fw76ulCBE1Q2ukEl7v368fn0DFX6DHgk7zbcGsWFAXePLs6RcFzvqed+PHfG8je+pK9V5ruObpdR1AbMwuJWgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733810122; c=relaxed/simple;
	bh=4V8AiB5qbO666DVHri+1axeGcTw5XaiQ0D2S/tTvk50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZKWYzcaaHrR2DeV5nJCQXPRQ80/GkW//QzgYqfp5jwaHEsVTZ9GBlBdA9AkkqSe1MzUm+l9V8mN8D+ptb+umJkquXbaByU1l4h2Y32w69iJfe82L37+ig2qGFcYXTE/oZhMQv3g8J/3OS4w3SU12CEbx8V88dszIBJ9mnO/Md/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 173BB113E;
	Mon,  9 Dec 2024 21:55:49 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.48.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A2FF43F58B;
	Mon,  9 Dec 2024 21:55:14 -0800 (PST)
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
Subject: [PATCH V2 21/46] arm64/sysreg: Add register fields for SPMACCESSR_EL1
Date: Tue, 10 Dec 2024 11:22:46 +0530
Message-Id: <20241210055311.780688-22-anshuman.khandual@arm.com>
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

This adds register fields for SPMACCESSR_EL1 as per the definitions based
on DDI0601 2024-09.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/sysreg | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 22d2ba231059..ff833f6f7f6d 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -114,6 +114,41 @@ Res0	63:1
 Field	0	OSLK
 EndSysreg
 
+Sysreg	SPMACCESSR_EL1	2	0	9	13	3
+Field	63:62	P31
+Field	61:60	P30
+Field	59:58	P29
+Field	57:56	P28
+Field	55:54	P27
+Field	53:52	P26
+Field	51:50	P25
+Field	49:48	P24
+Field	47:46	P23
+Field	45:44	P22
+Field	43:42	P21
+Field	41:40	P20
+Field	39:38	P19
+Field	37:36	P18
+Field	35:34	P17
+Field	33:32	P16
+Field	31:30	P15
+Field	29:28	P14
+Field	27:26	P13
+Field	25:24	P12
+Field	23:22	P11
+Field	21:20	P10
+Field	19:18	P9
+Field	17:16	P8
+Field	15:14	P7
+Field	13:12	P6
+Field	11:10	P5
+Field	9:8	P4
+Field	7:6	P3
+Field	5:4	P2
+Field	3:2	P1
+Field	1:0	P0
+EndSysreg
+
 Sysreg	SPMDEVAFF_EL1	2	0	9	13	6
 Res0	63:40
 Field	39:32	Aff3
-- 
2.25.1


