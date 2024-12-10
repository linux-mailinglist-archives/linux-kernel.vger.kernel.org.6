Return-Path: <linux-kernel+bounces-438924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1755F9EA852
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 06:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F93616C7A8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 05:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29C72309AE;
	Tue, 10 Dec 2024 05:56:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CFF22ACDE
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733810178; cv=none; b=IsWUMWKEhTSODIkVTmNlFy3ceWk/9FxGh05pla36rJGrgSpb6p469TtnAy2L15ImHrdEIUcJcgeJcNjp31KwplinFYd3p4a2dHYEIsm1zzObT86oYL9L2upKXRW7FZSHxNmVxaEOFOD8QWXiRuSjLrfBg67wBUUvvRVXGgWpTqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733810178; c=relaxed/simple;
	bh=fGnXF4mftoJWeweuF/nNp7ZdSgW/TlFsq9GN/9YpIVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NAo+J+j+mNfNfkP4Cn4sAV3WxMl1B+VLPZaW1e+rJbQOyLCwhSBlFRuaK6Qmpoj0mW+nR1Vo502c5WuLj1diQI/K7jRxmZ4AGSwQBgd6AGPWkZ/9DV18EDBxlNFuZfHXycWOhEmmgN8PovStrN/ukyAVfy3YviQ6rZSIjQjLqx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFAD9113E;
	Mon,  9 Dec 2024 21:56:44 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.48.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B88A93F58B;
	Mon,  9 Dec 2024 21:56:12 -0800 (PST)
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
Subject: [PATCH V2 34/46] arm64/sysreg: Add register fields for SPMDEVARCH_EL1
Date: Tue, 10 Dec 2024 11:22:59 +0530
Message-Id: <20241210055311.780688-35-anshuman.khandual@arm.com>
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

This adds register fields for SPMDEVARCH_EL1 as per the definitions based
on DDI0601 2024-09.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/sysreg | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 3b217ce3fe28..d423bb218a9f 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -157,6 +157,15 @@ Field	15:12	Revision
 Field	11:0	Implementer
 EndSysreg
 
+Sysreg	SPMDEVARCH_EL1	2	0	9	13	5
+Res0	63:32
+Field	31:21	ARCHITECT
+Field	20	PRESENT
+Field	19:16	REVISION
+Field	15:12	ARCHVER
+Field	11:0	ARCHPART
+EndSysreg
+
 Sysreg	SPMDEVAFF_EL1	2	0	9	13	6
 Res0	63:40
 Field	39:32	Aff3
-- 
2.25.1


