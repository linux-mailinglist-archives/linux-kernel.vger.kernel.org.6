Return-Path: <linux-kernel+bounces-187465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB6F8CD236
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0EDA1F22A31
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD4013BAE5;
	Thu, 23 May 2024 12:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tXioXp4B"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333C81E481
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716466918; cv=none; b=hbGaE2Vq/hwW5FxZGL52QBmXGQN03ugJs8zL7o5pXOUGdY7qkXnIh7d2lA0OCBZ6twK36cp8fgWd8kOewqSSoio+MHFjQV6frkOn9xjLDEyKs80xKfPUCXI2yhlu/If/8iRkkYIrUtzq0/ksI/9euQ6kWlmFA3LbBU4HM8SrjmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716466918; c=relaxed/simple;
	bh=TPRP6quwI20vkUHC6uWJ0C+xU9kghayT19hIMW7/QXI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=CktgvrTEN6H18WvAzAPLAtGxOlTHiz/9m8ZlfCi/K/qvJ1snG81iC2hpUtUHKoEO2UhX+omw9fKmt1Br6Xjf74gOqaaOqKiQYHOqZPkrCQ4UlYC1/hnogTEdQOuXi9A3HuLmU0PC+Z1A1e7DbkINjy3NshDOYDRp4B61ZCK4KVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tXioXp4B; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240523122153epoutp039f41fee878de26ad8a136213d2767df7~SHZBbKYke1582015820epoutp03R
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:21:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240523122153epoutp039f41fee878de26ad8a136213d2767df7~SHZBbKYke1582015820epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716466913;
	bh=dCdsFBMCJNBGSFA8zN9A1mOK5RSQ0g/MuPcHI9kU46M=;
	h=From:To:Cc:Subject:Date:References:From;
	b=tXioXp4BlvkeRIEYEi8ShS+muCfYg5wB7Qv4URW2gdzG6Lvt0IouhALxCoT8cUoI1
	 KBFbDLcAdlQXm5JwVB5Qh5YlcI9zK0rZx523wGmNJ5EoiCw6gRf2TfX5e4SVJuEXr6
	 b4j0v0yYzYCQwulJSAbXLqDc57m4HZntzCuzLu4o=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240523122153epcas1p1a99c7b6297a57decdc14c6a087629835~SHZBETWpr3249832498epcas1p12;
	Thu, 23 May 2024 12:21:53 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.243]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VlS352Vgtz4x9Pv; Thu, 23 May
	2024 12:21:53 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	06.8C.10158.1E43F466; Thu, 23 May 2024 21:21:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20240523122152epcas1p49d579e40d4ef0c442820cc01f79ab38b~SHZAP8a2M1457214572epcas1p4x;
	Thu, 23 May 2024 12:21:52 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240523122152epsmtrp211d6a4a045ffe4cdd8b1a2faae5c33fe~SHZAPXNwz2728927289epsmtrp2H;
	Thu, 23 May 2024 12:21:52 +0000 (GMT)
X-AuditID: b6c32a38-8e1ff700000027ae-47-664f34e175fe
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	3C.75.19234.0E43F466; Thu, 23 May 2024 21:21:52 +0900 (KST)
Received: from parkseongsu-desktop.. (unknown [10.252.69.73]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240523122152epsmtip1cbc0c169586933f2b001ca9daf73ae3b~SHZAEi88b3013530135epsmtip1T;
	Thu, 23 May 2024 12:21:52 +0000 (GMT)
From: Seongsu Park <sgsu.park@samsung.com>
To: catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	infinite.run@gmail.com, sgsu.park@samsung.com
Subject: [PATCH] arm64: Cleanup __cpu_set_tcr_t0sz()
Date: Thu, 23 May 2024 21:21:46 +0900
Message-Id: <20240523122146.144483-1-sgsu.park@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmge5DE/80g97LAhY/v7xntHi/rIfR
	4s/G3UwWmx5fY7W4vGsOm8XS6xeZLN43dLFatNwxdeDwWDNvDaPHzll32T02repk89i8pN6j
	b8sqRo/Pm+QC2KKybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8
	AnTdMnOAzlFSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgV6BUn5haX5qXr5aWW
	WBkaGBiZAhUmZGcc+D2PteAcZ8XNzdwNjB0cXYycHBICJhLX365gBLGFBHYwSnxaGdbFyAVk
	f2KUuHv7GyucM2fbfVaYjnOP57FBJHYySjTc7GWHq+qY9YUZpIpNQEti9T+QBCeHiECoxOsZ
	69lAbGaBconnU+YCxTk4hIEmHb9SCBJmEVCVePj1OBOIzStgLbHl0hFGiGXyEvsPnmWGiAtK
	nJz5hAVijLxE89bZzCB7JQQusUtc7t7CAtHgInHi2yYoW1ji1fEt7BC2lMTnd3vZIOxiiX1f
	1jBD2DUSD+btgbLtJTqetbGA3MYsoCmxfpc+xC4+iXdfe1hBwhICvBIdbUIQprLEua2OEKak
	xJ8FehAzPCS2/D/JCgnPWIm2d82sExjlZiG5fxaS+2chrFrAyLyKUSy1oDg3PbXYsMAEHonJ
	+bmbGMEpUMtiB+Pctx/0DjEycTAeYpTgYFYS4Y1e6ZsmxJuSWFmVWpQfX1Sak1p8iNEUGKIT
	maVEk/OBSTivJN7QxNLAxMzIxMLY0thMSZz3zJWyVCGB9MSS1OzU1ILUIpg+Jg5OqQYm+VCH
	XqGNvCcvtTiLL9tzOCTwenS9rcBN351pFY++fzHtN1j8ZUVgDf+tMuGO2SkZheZynjaTTfWe
	ViVJJ/lIxmkGMq+rmLZrc+LRs+st3700f1V04pEqT+SX5Y5VoTUdBqxPo+V6PZ6cq1lxZw/H
	/gLBtEdaCYbdNXNThTnfGN6T/r9HTo1RPHDaznXxXM1p0Z7XlSRZY084H9ncsGWuh5T3vKq9
	Oxrmv612P1fpyaWrPDtM1fx1LXvdxQgPPZPdz/495hK/nLzz4WXvByHTFm5pi/NVfFMyPXjH
	p5Nq6qIzZh2fY3lVrCVkbu5B7eJp+/7oVtqUPXMOEcpWuKuhcfZr4b77L1wO2zR+/6fEUpyR
	aKjFXFScCAAiiyhcCgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSnO4DE/80g6UX5Sx+fnnPaPF+WQ+j
	xZ+Nu5ksNj2+xmpxedccNoul1y8yWbxv6GK1aLlj6sDhsWbeGkaPnbPusntsWtXJ5rF5Sb1H
	35ZVjB6fN8kFsEVx2aSk5mSWpRbp2yVwZRz4PY+14Bxnxc3N3A2MHRxdjJwcEgImEucez2Pr
	YuTiEBLYzihxZO4+VoiEpET7u8ssXYwcQLawxOHDxRA1HxglfjX2soDUsAloSaz+18sOYosI
	REqcfXaRCcRmFqiWeP56FiNIrzDQguNXCkHCLAKqEg+/Hgcr4RWwlthy6QgjxCp5if0HzzJD
	xAUlTs58wgIxRl6ieets5gmMfLOQpGYhSS1gZFrFKJpaUJybnptcYKhXnJhbXJqXrpecn7uJ
	ERyoWkE7GJet/6t3iJGJg/EQowQHs5IIb/RK3zQh3pTEyqrUovz4otKc1OJDjNIcLErivMo5
	nSlCAumJJanZqakFqUUwWSYOTqkGJj6eVb9s9osfnqD06OycxZYPXG+sXy50/eAu0R+dDDOr
	W6OW6qb9/MszU99TVLbS+J5/4nQpthKHp2a+ns9rUyftYuJalLjn/2Lf06znWScdflfwyu9M
	9tar9gmh7UkT9gnNMbaNsZhxMHqlfXXSjLXcM7M4M8J+bzkznaey8lH4mnfSc1J+Le9OdXk3
	X9Zus4dg9KqsTyIcsW/rLP1nORZ4cL2X8fk58c3fw8XK6/v6OTdGXSp0acuql2Mz8pmw2/Tm
	6hVCbYWvZ+ZXObYut3VX+Rsgb3PCzKLy8Z+tqVo6L8Wscy9FKXDM/NTQp9D/a23u4yAtBzEz
	F+MpEYHHPN/zmT7/PF++5tT9lRGrlViKMxINtZiLihMB5i9Vq8MCAAA=
X-CMS-MailID: 20240523122152epcas1p49d579e40d4ef0c442820cc01f79ab38b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240523122152epcas1p49d579e40d4ef0c442820cc01f79ab38b
References: <CGME20240523122152epcas1p49d579e40d4ef0c442820cc01f79ab38b@epcas1p4.samsung.com>

The T0SZ field of TCR_EL1 occupies bits 0-5 of the register and encode
the virtual address space translated by TTBR0_EL1. When updating the
field, for example because we are switching to/from the idmap page-table,
__cpu_set_tcr_t0sz() erroneously treats its 't0sz' argument as unshifted,
resulting in harmless but confusing double shifts by 0 in the code.

Co-developed-by: Leem ChaeHoon <infinite.run@gmail.com>
Signed-off-by: Leem ChaeHoon <infinite.run@gmail.com>
Signed-off-by: Seongsu Park <sgsu.park@samsung.com>
---
 arch/arm64/include/asm/mmu_context.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index c768d16b81a4..bd19f4c758b7 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -72,11 +72,11 @@ static inline void __cpu_set_tcr_t0sz(unsigned long t0sz)
 {
 	unsigned long tcr = read_sysreg(tcr_el1);
 
-	if ((tcr & TCR_T0SZ_MASK) >> TCR_T0SZ_OFFSET == t0sz)
+	if ((tcr & TCR_T0SZ_MASK) == t0sz)
 		return;
 
 	tcr &= ~TCR_T0SZ_MASK;
-	tcr |= t0sz << TCR_T0SZ_OFFSET;
+	tcr |= t0sz;
 	write_sysreg(tcr, tcr_el1);
 	isb();
 }
-- 
2.34.1


