Return-Path: <linux-kernel+bounces-228008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 536919159A9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D03B8B244BE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F831A2FA2;
	Mon, 24 Jun 2024 22:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="NcOofN60"
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2911A2C03;
	Mon, 24 Jun 2024 22:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267159; cv=none; b=LD9x7gJSc4Yt3SK84LK7rVFiHik/Anqy6s1sfoImTWChHa3sLJ7ClhtzDC8+ElNYyvajYAfjA8EsFr50YGZMAbPytiN94DymkLoRauHfJMuQxtHpyTmL04okHrm33TB0Xtud1H2OVkulyMIWVtznGEg7iwqgn32OSHK4NfEleOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267159; c=relaxed/simple;
	bh=YRsO8fG+tWrFqE5S9ft2lAKRu/1mvtsiDA/UMSSP0f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjS+uriWjUinEGDwL5HLWLKF/OCjGMuexvZNlHCAbZEq9YueF3ngEAbCJ39htTn74F6D2byi5k2Pje43hHsGj+tqMiOkRKfYJCbS6hDdsK/3z6pnz86c1kVUVCHAvDWZtR57wRBe8pUjx120J5XzveGnLOaxMc7PHzMWtDTW6xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=NcOofN60; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355088.ppops.net [127.0.0.1])
	by m0355088.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 45OExZPE016200;
	Mon, 24 Jun 2024 22:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM202306; bh=beDAkvKYsDlCVLz13QLf8oA
	MscanV0EKlCxkUmhBfqk=; b=NcOofN60eggD0fDtyENxaoXl1pTKI3kjFo/BZUW
	rDhrNO3IKgdPV3JNqsMKA/eT8il00pVvW420+O6x/TG9VtWXABKDFqec5HrUJawW
	BRofFlq7rKojw1Bf5cC9oOdmA8PN2g3t3xbvl6Qd4h+an6DnZHbrqP1snVtWr2AM
	3NZFYVAdR7b6avcv3eR6Y4XRE0nI36AhVqtk0tfNAeP4aGM8BhNnL601exSiy2Q7
	gsFR+kE3N/kVz1fiRy4woTc1giQBXF+XaouC4Nfqj3KV9aJw2y2yowEExkvt9YnL
	QNqTKvR3RDyKQk86jB3DZG1Cb+06dCbiEWiuUIVOtdDuGkg==
Received: from ilclpfpp01.lenovo.com ([144.188.128.67])
	by m0355088.ppops.net (PPS) with ESMTPS id 3yxbstk762-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 22:12:22 +0000 (GMT)
Received: from va32lmmrp02.lenovo.com (va32lmmrp02.mot.com [10.62.176.191])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ilclpfpp01.lenovo.com (Postfix) with ESMTPS id 4W7Mdd4Wdszcxq9;
	Mon, 24 Jun 2024 22:12:21 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by va32lmmrp02.lenovo.com (Postfix) with ESMTPSA id 4W7Mdd16g3z2VbbV;
	Mon, 24 Jun 2024 22:12:21 +0000 (UTC)
Date: Mon, 24 Jun 2024 17:12:19 -0500
From: Maxwell Bland <mbland@motorola.com>
To: linux-mm@kvack.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Maxwell Bland <mbland@motorola.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/6] arm64: add APTable encoding to pagetable defs
Message-ID: <z7v77vr34beigy6hy75mfsnssihc2gxzc4z4xioork343wki2n@gjv6kdxo6zxc>
References: <2bcb3htsjhepxdybpw2bwot2jnuezl3p5mnj5rhjwgitlsufe7@xzhkyntridw3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bcb3htsjhepxdybpw2bwot2jnuezl3p5mnj5rhjwgitlsufe7@xzhkyntridw3>
X-Proofpoint-ORIG-GUID: cBD7-o-fMElZ7gAEi_7CTo0KFY4fieW1
X-Proofpoint-GUID: cBD7-o-fMElZ7gAEi_7CTo0KFY4fieW1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_19,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015
 mlxlogscore=715 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240177

Add in the APTable permission bit encoding to describe table-level
hierarchical access control

Signed-off-by: Maxwell Bland <mbland@motorola.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 9943ff0af4c9..8c229fc96c0a 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -146,6 +146,11 @@
 #define PMD_SECT_UXN		(_AT(pmdval_t, 1) << 54)
 #define PMD_TABLE_PXN		(_AT(pmdval_t, 1) << 59)
 #define PMD_TABLE_UXN		(_AT(pmdval_t, 1) << 60)
+/*
+ * APTable[1:0] encoding for hierarchical data access control
+ */
+#define PMD_TABLE_KERN		(_AT(pmdval_t, 1) << 61)
+#define PMD_TABLE_PRDONLY	(_AT(pmdval_t, 1) << 62)
 
 /*
  * AttrIndx[2:0] encoding (mapping attributes defined in the MAIR* registers).
-- 
2.43.0



