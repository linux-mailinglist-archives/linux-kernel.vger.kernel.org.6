Return-Path: <linux-kernel+bounces-178752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 352288C5729
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 15:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CACABB2461B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 13:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6636C152DF2;
	Tue, 14 May 2024 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pQHINjjF"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FCB144D0D
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 13:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715693123; cv=none; b=QMxXW33Mi4XObvPdFMBgaGnv2rkw4j/xtprmO2W5MHHr0HiJ4VNFXq6yhM6MRxrPESpNqyLME9g4MJO48lM3rzGbuh+CfoXpQhkpoVRxEQa6nGS709LfL7vO4k/Vl2+t8UPI+tPwMvSyLH6giDcza/832PJjCOJK5R4EyPNTjtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715693123; c=relaxed/simple;
	bh=+n+p71FsVXSZnSqnPZSR7Gebkas5kDdrnnrrTE+h4TA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X+bV+ri3XiSJUYn0IT3BDiBw98mUmBdExJHKssamXZZiRBj18VOXUpSDD7OT75Umo3caLEQXuf2P6vQOKP3PqZTD1pX3ejl85bruwi1GxBlnWr75fZPhoSWTgB87ehwcCUVYUd1IXgEZJdyWbCgsOWt7709XwsSLwWQmHGEroGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pQHINjjF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44ECRBMv026738;
	Tue, 14 May 2024 13:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=3n/ZlQ5YtgNJ9JIHG4LHRuzQOsWQLVdpqdKqZaiPdJ8=;
 b=pQHINjjFiQxMQ50xXngJm7memBdJ3dJ92Afme7HilrwbrIunZNC0y/u12orov1i6shCd
 EnD33lqehj4YeSj27Vpq5wbC/veo2Bn+KmKVc7WaUZOrKZK1GdmSkhOH8i/1es2EmW1N
 C1AxcFPmkEa6DYs+Q3veY5I/Sir0Lv0/TTetoTjWE+4TDHGeeHafwdF0XKz4Aswa+/Uw
 ni0M38TXKFFRawCKU7CGIApko7IcatEwR3i4ZY/04Isu3rD8Kfi4odGCT6LB4/5/St/S
 u04RQQmmsLhqeGKRcDoctd4ojxo4/NrRqGXBulBllg3PmScBFEg1tRjPA8kY72IQCu+P Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y47yfr572-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 13:25:12 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44EDPCaw031055;
	Tue, 14 May 2024 13:25:12 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y47yfr56w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 13:25:12 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44EBV5TR020460;
	Tue, 14 May 2024 13:25:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2kcywqs3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 13:25:11 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44EDP5vx28181082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 13:25:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 230C82004B;
	Tue, 14 May 2024 13:25:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EEAC2004D;
	Tue, 14 May 2024 13:25:02 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.in.ibm.com (unknown [9.204.206.66])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 May 2024 13:25:02 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        naveen.n.rao@linux.ibm.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, aboorvad@linux.vnet.ibm.com
Subject: [PATCH v2] arch/powerpc: Remove unused cede related functions
Date: Tue, 14 May 2024 18:54:55 +0530
Message-ID: <20240514132457.292865-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9LgwXteiPL8gZt72kAIJKYJLjqr-VlRy
X-Proofpoint-GUID: ZJQNh9_3lPi27d1Sy1a78-f54yRmc6Gu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_06,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=718 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2405140095

Remove extended_cede_processor() and its helpers as
extended_cede_processor() has no callers since
commit 48f6e7f6d948("powerpc/pseries: remove cede offline state for CPUs")

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v1 -> v2:
1. Remove helpers of extended_cede_processor()

 arch/powerpc/include/asm/plpar_wrappers.h | 28 -----------------------
 1 file changed, 28 deletions(-)

diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
index b3ee44a40c2f..71648c126970 100644
--- a/arch/powerpc/include/asm/plpar_wrappers.h
+++ b/arch/powerpc/include/asm/plpar_wrappers.h
@@ -18,16 +18,6 @@ static inline long poll_pending(void)
 	return plpar_hcall_norets(H_POLL_PENDING);
 }
 
-static inline u8 get_cede_latency_hint(void)
-{
-	return get_lppaca()->cede_latency_hint;
-}
-
-static inline void set_cede_latency_hint(u8 latency_hint)
-{
-	get_lppaca()->cede_latency_hint = latency_hint;
-}
-
 static inline long cede_processor(void)
 {
 	/*
@@ -37,24 +27,6 @@ static inline long cede_processor(void)
 	return plpar_hcall_norets_notrace(H_CEDE);
 }
 
-static inline long extended_cede_processor(unsigned long latency_hint)
-{
-	long rc;
-	u8 old_latency_hint = get_cede_latency_hint();
-
-	set_cede_latency_hint(latency_hint);
-
-	rc = cede_processor();
-
-	/* Ensure that H_CEDE returns with IRQs on */
-	if (WARN_ON(IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG) && !(mfmsr() & MSR_EE)))
-		__hard_irq_enable();
-
-	set_cede_latency_hint(old_latency_hint);
-
-	return rc;
-}
-
 static inline long vpa_call(unsigned long flags, unsigned long cpu,
 		unsigned long vpa)
 {
-- 
2.45.0


