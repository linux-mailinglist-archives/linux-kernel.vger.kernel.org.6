Return-Path: <linux-kernel+bounces-207937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC654901E2A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711731F23BE2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD617407C;
	Mon, 10 Jun 2024 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r77kvj7W"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEBD335A7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011685; cv=none; b=IYDj6uOfa2v8cUiqN7DuMMevadmSi46UUJOc6CYFholDpi8f29OdqPovcg7jxM4OsznunJTiuQKYAqTvlJXZGFSHjVJdZpAYZPgSe3jRpWNmsL8OKTfsvHe8MpK/j7tmlOZ2FgkUNtIu63FjC+ztImkPCmQB6ziH8PWacwN32VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011685; c=relaxed/simple;
	bh=P81jxZJDbNIbVJp+B8/qYs3oR2c2jO7ManIxlVtueTM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lCujq1IYGj7qzVSY5taAukWKh9/qtKOvONQO3gJpac6nx+8MR0Dv8oDJSAXxYhCLETLtFAwoCBBJcmIWv/LPobpYSRo8ARBDIdyzt0a0rbfBSTRFY6KWeuzECcW+YNKU/YpUT0kwjfv5NhbbVN20mBJ8Szr2ZMoIMJyevIoydRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r77kvj7W; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45A8wYGC018114;
	Mon, 10 Jun 2024 09:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=+z71MF369660wRQJUmSjKs7mzP
	RmgR7mIvSlb0DU0Yo=; b=r77kvj7Wpn/XEfPqnvwy+1yPEbwXErKHFyCR1dJH0g
	qGb/JLU516TucrLEdInJsJYiopzVxgIFNwo6BL+Ggbr0DoRpIiksYlrx523zbX0I
	1z8k2QMfAN77hwqcxi/A07UDWhK+vm1j4Q4g9ysqICj3vKbgvCVKEd7rqs5fVN/i
	kCRVQSP4gbOQFvygHsur0xkE9TRYhhg5BJqefT8ozrrzWnbdii+VC0THPuxvTwHM
	qZfEEhXfAAOL98JzsUgKskVRsq+c/mX9dPR9l5EediUqGCnG0oUzhTvNVng9Jb4v
	5UIm0j6Tnx/byfSCfSEuyg6XuD7pfPccY6Bkpfs7fGNg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ynxerr2n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 09:28:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45A9P83j028680;
	Mon, 10 Jun 2024 09:27:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yn1mtxxsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 09:27:59 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45A9Rt1v51249526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Jun 2024 09:27:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97E9820065;
	Mon, 10 Jun 2024 09:27:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74B4420063;
	Mon, 10 Jun 2024 09:27:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Jun 2024 09:27:55 +0000 (GMT)
From: Peter Oberparleiter <oberpar@linux.ibm.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, allison.henderson@oracle.com,
        chuck.lever@oracle.com, oberpar@linux.ibm.com
Subject: [PATCH] gcov: add support for GCC 14
Date: Mon, 10 Jun 2024 11:27:43 +0200
Message-Id: <20240610092743.1609845-1-oberpar@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aqaj9prAp1gRYoBHNWEQEVlhrCE3Bp-1
X-Proofpoint-ORIG-GUID: aqaj9prAp1gRYoBHNWEQEVlhrCE3Bp-1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406100071

Using gcov on kernels compiled with GCC 14 results in truncated 16-byte
long .gcda files with no usable data. To fix this, update GCOV_COUNTERS
to match the value defined by GCC 14.

Tested with GCC versions 14.1.0 and 13.2.0.

Reported-by: Allison Henderson <allison.henderson@oracle.com>
Reported-by: Chuck Lever III <chuck.lever@oracle.com>
Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>
---
 kernel/gcov/gcc_4_7.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/gcov/gcc_4_7.c b/kernel/gcov/gcc_4_7.c
index 74a4ef1da9ad..fd75b4a484d7 100644
--- a/kernel/gcov/gcc_4_7.c
+++ b/kernel/gcov/gcc_4_7.c
@@ -18,7 +18,9 @@
 #include <linux/mm.h>
 #include "gcov.h"
 
-#if (__GNUC__ >= 10)
+#if (__GNUC__ >= 14)
+#define GCOV_COUNTERS			9
+#elif (__GNUC__ >= 10)
 #define GCOV_COUNTERS			8
 #elif (__GNUC__ >= 7)
 #define GCOV_COUNTERS			9
-- 
2.40.1


