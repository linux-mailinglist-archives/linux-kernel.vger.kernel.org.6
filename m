Return-Path: <linux-kernel+bounces-405846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8752D9C580B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478572816A0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBF21CD21A;
	Tue, 12 Nov 2024 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AE7przNI"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD471F7555
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731415339; cv=none; b=an3xnWi6WACYIInx7LaobGo4X2ZaWOZL0OBBVOL0pus5dfo+yDwH2/9AcjWbHr8ZtH38QcZRDQLITvzAbK3xsnPCdcf1jdGEu3s9HNttGwtRXb7J5zv8cxUjYJRx+NUwNvtNH/pAzmRY5aJWXDC8Juz+/MHtgwEasBydSB79KOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731415339; c=relaxed/simple;
	bh=vck9A7I4MCyjIJP3zaUhpPQydiIvjOEfosdjxwxSE4A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fdm+ntseRKyczVdhHPV/1W8N0Ioud/HNA1+sePndHM4RQqrJR04g3tlepxHfNDCWl+2ezTalf6m+NgrfRasiZ+aEhY704Q8YoTR70ASXrHIiVN1CE8MBm0MQG8qgIYLglQqWt4Riavb1Sv7sLK627ePATIb8UqOlqNqLQRyWXG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AE7przNI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACCe5Q3021982;
	Tue, 12 Nov 2024 12:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=t1aUO01cDL75CMSISr0QnXUv+8fz
	xpIW7UT5DA5YzEU=; b=AE7przNIq2r4VCALzvaM24jig9OCPhZCDVlufv21xCiz
	6RW2tYKm/1GBpHIJKsX2AtsH086QT5WbwGPv0bfqpwiVV3nDjmChQffxYKOu3K+X
	OZBR2Jwo/XJMaMmFSNwkciYJXBWi/5q5NNzAAw1pHE/aSBFYNu5xmaXmeHfM9Ken
	9mcNu4grWu1zjYHoOz4gR1wTKB7u/Xa/zcvHwlvoeJmkMugD2+SVIdmW61R08Plz
	dVOCOnKSYYGq7cMfbfVv0K6fALL9z7BIxpPfxaM7BDet3ZzzHEMFBwQv5cneTT/m
	afzmDJIP+CJ50N9r1UyFo5w+/HBi5rk6GXN2gN2vvA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42v77h8099-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 12:42:08 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4ACCg8RS026837;
	Tue, 12 Nov 2024 12:42:08 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42v77h8093-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 12:42:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACB25v5008243;
	Tue, 12 Nov 2024 12:42:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tjeyhc9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 12:42:06 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ACCg5Xn55902632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 12:42:05 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E357D2004D;
	Tue, 12 Nov 2024 12:42:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2139A2004B;
	Tue, 12 Nov 2024 12:42:03 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.181])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Nov 2024 12:42:02 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>, briannorris@chromium.org,
        kees@kernel.org, nathan@kernel.org, yury.norov@gmail.com,
        linux@weissschuh.net, gjoyce@ibm.com
Subject: [PATCH] cpumask: work around false-postive stringop-overread errors
Date: Tue, 12 Nov 2024 18:11:24 +0530
Message-ID: <20241112124127.1666300-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Y55HHuNB4WkWf1SPnuF0iD65_H7nphVF
X-Proofpoint-GUID: OAaygNV7X9sJQQEp11TIUWLjsyY1oPca
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411120102

While building the powerpc code using gcc 13, I came across following
errors generated for kernel/padata.c file:

  CC      kernel/padata.o
In file included from ./include/linux/string.h:390,
                 from ./arch/powerpc/include/asm/paca.h:16,
                 from ./arch/powerpc/include/asm/current.h:13,
                 from ./include/linux/thread_info.h:23,
                 from ./include/asm-generic/preempt.h:5,
                 from ./arch/powerpc/include/generated/asm/preempt.h:1,
                 from ./include/linux/preempt.h:79,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/swait.h:7,
                 from ./include/linux/completion.h:12,
                 from kernel/padata.c:14:
In function ‘bitmap_copy’,
    inlined from ‘cpumask_copy’ at ./include/linux/cpumask.h:839:2,
    inlined from ‘__padata_set_cpumasks’ at kernel/padata.c:730:2:
./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ reading between 257 and 536870904 bytes from a region of size 256 [-Werror=stringop-overread]
  114 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
./include/linux/fortify-string.h:633:9: note: in expansion of macro ‘__underlying_memcpy’
  633 |         __underlying_##op(p, q, __fortify_size);                        \
      |         ^~~~~~~~~~~~~
./include/linux/fortify-string.h:678:26: note: in expansion of macro ‘__fortify_memcpy_chk’
  678 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
      |                          ^~~~~~~~~~~~~~~~~~~~
./include/linux/bitmap.h:259:17: note: in expansion of macro ‘memcpy’
  259 |                 memcpy(dst, src, len);
      |                 ^~~~~~
kernel/padata.c: In function ‘__padata_set_cpumasks’:
kernel/padata.c:713:48: note: source object ‘pcpumask’ of size [0, 256]
  713 |                                  cpumask_var_t pcpumask,
      |                                  ~~~~~~~~~~~~~~^~~~~~~~
In function ‘bitmap_copy’,
    inlined from ‘cpumask_copy’ at ./include/linux/cpumask.h:839:2,
    inlined from ‘__padata_set_cpumasks’ at kernel/padata.c:730:2:
./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ reading between 257 and 536870904 bytes from a region of size 256 [-Werror=stringop-overread]
  114 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
./include/linux/fortify-string.h:633:9: note: in expansion of macro ‘__underlying_memcpy’
  633 |         __underlying_##op(p, q, __fortify_size);                        \
      |         ^~~~~~~~~~~~~
./include/linux/fortify-string.h:678:26: note: in expansion of macro ‘__fortify_memcpy_chk’
  678 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
      |                          ^~~~~~~~~~~~~~~~~~~~
./include/linux/bitmap.h:259:17: note: in expansion of macro ‘memcpy’
  259 |                 memcpy(dst, src, len);
      |                 ^~~~~~
kernel/padata.c: In function ‘__padata_set_cpumasks’:
kernel/padata.c:713:48: note: source object ‘pcpumask’ of size [0, 256]
  713 |                                  cpumask_var_t pcpumask,
      |                                  ~~~~~~~~~~~~~~^~~~~~~~

Apparentrly, above errors only menifests with GCC 13.x and config option
CONFIG_FORTIFY_SOURCE. Furthermore, if I use gcc 11.x or gcc 12.x then I
don't encounter above errors. Prima facie, these erros appear to be false-
positive. Brian informed me that currently some efforts are underway by
GCC developers to emit more verbose information when GCC detects string
overflow errors and that might help to further narrow down the root cause
of this error. So for now, silence these errors using -Wno-stringop-
overread gcc option while building kernel/padata.c file until we find the
root cause.

Link: https://lore.kernel.org/all/7cbbd751-8332-4ab2-afa7-8c353834772a@linux.ibm.com/
Cc: briannorris@chromium.org
Cc: kees@kernel.org
Cc: nathan@kernel.org
Cc: yury.norov@gmail.com
Cc: linux@weissschuh.net
Cc: gjoyce@ibm.com
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 kernel/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/Makefile b/kernel/Makefile
index 87866b037fbe..e5adba7a30f1 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -120,6 +120,7 @@ obj-$(CONFIG_CFI_CLANG) += cfi.o
 obj-$(CONFIG_PERF_EVENTS) += events/
 
 obj-$(CONFIG_USER_RETURN_NOTIFIER) += user-return-notifier.o
+CFLAGS_padata.o += $(call cc-disable-warning, stringop-overread)
 obj-$(CONFIG_PADATA) += padata.o
 obj-$(CONFIG_JUMP_LABEL) += jump_label.o
 obj-$(CONFIG_CONTEXT_TRACKING) += context_tracking.o
-- 
2.45.2


