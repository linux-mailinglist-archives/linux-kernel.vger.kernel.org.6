Return-Path: <linux-kernel+bounces-438905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6279EA83F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 06:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DBD316B107
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 05:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013BE22757D;
	Tue, 10 Dec 2024 05:54:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FD8228399
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 05:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733810075; cv=none; b=K2fsxlVy1G4Ds0d1/5WfWleXu7qBejv6ubYsuxUYQfVcQFPDEX/WJ8sDVRXQsIJ1k2fFPuDfuzb978BND9w5LMsVVr8YogubtvJk2gqh/7ztQ/IJSCvDCxUEDCMCfgHO/jfg+sV1Q+KuvVV6NeZ/LY+kReQ07qtuyQd0zKYyg6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733810075; c=relaxed/simple;
	bh=CkWuJ6ySX6r4bux7eNmSMQJssrIudgD9DBeGeA6Gu8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jw8F8U3IDMUmrpc57cPLfx53XAUVI8ko9yS34c0YF+3uhEZm72dbB53Z3dJ87bGwdwAFM4ZNxyX5+D50xyM/JTcFLnjrfwNKoOHSSMvwAki3vShzZlchA2B9JJOX16H2KRvrIQ1v4SF9UtUOzqRaqz+PhUPxqZrMmOIigb1WK6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02D54113E;
	Mon,  9 Dec 2024 21:55:02 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.48.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 28CC23F58B;
	Mon,  9 Dec 2024 21:54:29 -0800 (PST)
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
Subject: [PATCH V2 15/46] arm64/sysreg: Add register fields for PFAR_EL1
Date: Tue, 10 Dec 2024 11:22:40 +0530
Message-Id: <20241210055311.780688-16-anshuman.khandual@arm.com>
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

This adds register fields for PFAR_EL1 as per the definitions based on
DDI0601 2024-09.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/sysreg | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 18b814ff2c41..e33edb41721a 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -3533,3 +3533,10 @@ Field	5	F
 Field	4	P
 Field	3:0	Align
 EndSysreg
+
+Sysreg	PFAR_EL1	3	0	6	0	5
+Field	63	NS
+Field	62	NSE
+Res0	61:56
+Field	55:0	PA
+EndSysreg
-- 
2.25.1


