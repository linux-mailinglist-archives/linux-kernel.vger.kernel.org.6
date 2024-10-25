Return-Path: <linux-kernel+bounces-382395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D689B0D24
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0AAD287C9A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386A820EA5C;
	Fri, 25 Oct 2024 18:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n7nmhSXY"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8537020EA3F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880658; cv=none; b=RubTmHX1Vv8dqUZblx5bdUUXW+aWjWY/+/EdHdNYJCCulw/FAQVJnd3/Fx/EvqeaYMy5dEWL+1MPOeQMGZ0hdi652CEzLm3w8RLAx0ZHrkAwKAyLab6TOGXoRym+UgYZ8Tg9eG1QG+xe8Pxb6eeIPPixwUgzOxKXkh3640GloSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880658; c=relaxed/simple;
	bh=9MaTPQcI0kQdWN9IrNV5oXDv71+tP8RwqE7/m2nJRyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrXcN1A5oSr5M4vU8P7unUeyqYGi2yLjDK9VhV1xK2AJQBq9n2YFSd1x6O6t0/6oCj2vP9j8X+V3tW2NqqXP2mrMvcWPvZikeJF+fG+OC3bDD93irJW6VmMfP4o35vJUPERRilYKt/l6cc80xkCbF7+MXNGNu1SthC4pdHeiEMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n7nmhSXY; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729880655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WvBdGV/fEuM1t1ncHOm4+9FLFUwv2pJggZf0gOiw5tU=;
	b=n7nmhSXYNWWwPRgwzEdAF6dz9klA0M5XAE3gthqTLWz1eb3m758VfO+i4G0qjXjatishgW
	luSdCFMukzAqipU76CQu054hbuPD4HAzci8qf8xhT34g5HUXaxv9vU+/dzJTlYu9wvTpih
	3bxhITS8dxoq/HJAGeW6WG8tbdaiV94=
From: Oliver Upton <oliver.upton@linux.dev>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH v4 04/18] arm64: sysreg: Add new definitions for ID_AA64DFR0_EL1
Date: Fri, 25 Oct 2024 18:23:39 +0000
Message-ID: <20241025182354.3364124-5-oliver.upton@linux.dev>
In-Reply-To: <20241025182354.3364124-1-oliver.upton@linux.dev>
References: <20241025182354.3364124-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Align the field definitions w/ DDI0601 2024-09 and opportunistically
declare MTPMU as a signed field.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/tools/sysreg | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 7061cf2d8444..e5d2c25fe463 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1200,7 +1200,7 @@ UnsignedEnum	55:52	BRBE
 	0b0001	IMP
 	0b0010	BRBE_V1P1
 EndEnum
-Enum	51:48	MTPMU
+SignedEnum	51:48	MTPMU
 	0b0000	NI_IMPDEF
 	0b0001	IMP
 	0b1111	NI
@@ -1208,6 +1208,7 @@ EndEnum
 UnsignedEnum	47:44	TraceBuffer
 	0b0000	NI
 	0b0001	IMP
+	0b0010	TRBE_V1P1
 EndEnum
 UnsignedEnum	43:40	TraceFilt
 	0b0000	NI
@@ -1224,11 +1225,18 @@ UnsignedEnum	35:32	PMSVer
 	0b0011	V1P2
 	0b0100	V1P3
 	0b0101	V1P4
+	0b0110	V1P5
 EndEnum
 Field	31:28	CTX_CMPs
-Res0	27:24
+UnsignedEnum	27:24	SEBEP
+	0b0000	NI
+	0b0001	IMP
+EndEnum
 Field	23:20	WRPs
-Res0	19:16
+UnsignedEnum	19:16	PMSS
+	0b0000	NI
+	0b0001	IMP
+EndEnum
 Field	15:12	BRPs
 UnsignedEnum	11:8	PMUVer
 	0b0000	NI
@@ -1238,6 +1246,7 @@ UnsignedEnum	11:8	PMUVer
 	0b0110	V3P5
 	0b0111	V3P7
 	0b1000	V3P8
+	0b1001	V3P9
 	0b1111	IMP_DEF
 EndEnum
 UnsignedEnum	7:4	TraceVer
-- 
2.47.0.163.g1226f6d8fa-goog


