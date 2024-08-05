Return-Path: <linux-kernel+bounces-274696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DC8947B8E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6D7282632
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90A315AD9C;
	Mon,  5 Aug 2024 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XSyIoxhY"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C023158DC3
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 13:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863270; cv=none; b=GwEdBqpFbQHtlNaHXdDzb3a4Fd47b4slAREV7lfAF954fh9xlYl8tb8wyarGjV0M5VSzTAppSfv8pnGpvBLVX2C0BACsUQDxMhj+q3qzi1JheeYZuXqFXXj4Scvj0MPGBAC7msOk8BvTWuMWFUp21SRIZxMaYql1jmoujlafwP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863270; c=relaxed/simple;
	bh=wJkBeAzjeoNNrAC5UyDmHosLxmNzfztiYnZVihZRJFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DkW59Ngswxlrfni8avjtbXb5YSI5h29LdXm78k6Z7QjE5196nQ6v0DAtUGaz3ilO9p0Ukz9eqij+N32db48EsJh7/NeOIifUpEZpT6oxVLKB4sCpndRaf9PWdI+Vjv8IWACqQ23eOw3zSrU2GvQEKpRjnanvvXWkghwEeMhZAD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XSyIoxhY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 475C0HHZ032185;
	Mon, 5 Aug 2024 13:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=x5rCBDHnL29cOSsjoQMRo8sgH0
	PEpnfxpN3R9CXqsXE=; b=XSyIoxhYrQ3wl+RdfSPbz4itCly9NgWj3Exl2pyL8Z
	c5YcSbj7XYK1HAbSLZJQ4v1r/A9EyxUj6x9s1TT9ysLvMQWhWiy3/+PZtOSwIFa1
	6o3KzvDi5Iup+orUgGs9lHU1N01g/k8Y1uN0NcFlUaQUxF07RqKjHSgCpRcx3/al
	q/XLWh5Z/LcJOj9qvbXn43e33fDr7R7Q0mcJj0U9SoSvQTsAKTkt2HJfH0s7OD64
	dNAVwKMfqeueWmQTDh/e90LBxTn3/WBcb4mxByktFFQEg+d1Rdq+Xeulw8HyhbW0
	dHytSYjiCu4Z9xV/NN/6agLBKPIkoizvLe4yrVHApgBw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40txbjg541-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 13:07:37 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 475D7aWe021081;
	Mon, 5 Aug 2024 13:07:36 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40txbjg53x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 13:07:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 475BjShv024136;
	Mon, 5 Aug 2024 13:07:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40syvp6f6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 13:07:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 475D7S4156754574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Aug 2024 13:07:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19B512004B;
	Mon,  5 Aug 2024 13:07:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D556D20040;
	Mon,  5 Aug 2024 13:07:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Aug 2024 13:07:27 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com,
        sumanthk@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] s390/pai: Add node for s390 PAI counter support
Date: Mon,  5 Aug 2024 15:07:11 +0200
Message-ID: <20240805130711.2580740-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QYBFWq7EJTknUaoYEfXz0nJRvjnLDaKa
X-Proofpoint-ORIG-GUID: QP2FDEZ0DsGUiME_x0DcT5PlHqbwt2bn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_02,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 mlxlogscore=758 lowpriorityscore=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408050092

Commits

9f66572f2889 ("s390/pai_crypto: Enable per-task and system-wide sampling event")
582cc1b28e8c ("s390/pai_ext: Enable per-task and system-wide sampling event")

introduced support for multiple concurrent system-wide counting
and sampling events for s390 Processor Assist Information (PAI)
counters. Multiple s390 PAI counter events active at the same time
are chained by a list.  Add an s390 specific structure with number
pai_node to chain these events using hw_perf_event::pai_node.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>

---
 arch/s390/include/asm/pai.h        | 2 +-
 arch/s390/kernel/perf_pai_crypto.c | 2 +-
 arch/s390/kernel/perf_pai_ext.c    | 2 +-
 include/linux/perf_event.h         | 3 +++
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/pai.h b/arch/s390/include/asm/pai.h
index 25f2077ba3c9..e4fb8b522f56 100644
--- a/arch/s390/include/asm/pai.h
+++ b/arch/s390/include/asm/pai.h
@@ -77,6 +77,6 @@ static __always_inline void pai_kernel_exit(struct pt_regs *regs)
 
 #define PAI_SAVE_AREA(x)	((x)->hw.event_base)
 #define PAI_CPU_MASK(x)		((x)->hw.addr_filters)
-#define PAI_SWLIST(x)		(&(x)->hw.tp_list)
+#define PAI_SWLIST(x)		(&(x)->hw.pai_node)
 
 #endif
diff --git a/arch/s390/kernel/perf_pai_crypto.c b/arch/s390/kernel/perf_pai_crypto.c
index 2f5a20e300f6..429eab978b68 100644
--- a/arch/s390/kernel/perf_pai_crypto.c
+++ b/arch/s390/kernel/perf_pai_crypto.c
@@ -511,7 +511,7 @@ static void paicrypt_have_samples(void)
 	struct paicrypt_map *cpump = mp->mapptr;
 	struct perf_event *event;
 
-	list_for_each_entry(event, &cpump->syswide_list, hw.tp_list)
+	list_for_each_entry(event, &cpump->syswide_list, hw.pai_node)
 		paicrypt_have_sample(event, cpump);
 }
 
diff --git a/arch/s390/kernel/perf_pai_ext.c b/arch/s390/kernel/perf_pai_ext.c
index 6295531b39a2..e9d2dd1b478f 100644
--- a/arch/s390/kernel/perf_pai_ext.c
+++ b/arch/s390/kernel/perf_pai_ext.c
@@ -535,7 +535,7 @@ static void paiext_have_samples(void)
 	struct paiext_map *cpump = mp->mapptr;
 	struct perf_event *event;
 
-	list_for_each_entry(event, &cpump->syswide_list, hw.tp_list)
+	list_for_each_entry(event, &cpump->syswide_list, hw.pai_node)
 		paiext_have_sample(event, cpump);
 }
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1a8942277dda..d54e10c61d9e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -179,6 +179,9 @@ struct hw_perf_event {
 			u64	pwr_acc;
 			u64	ptsc;
 		};
+		struct { /* s390 processor assist information counter */
+			struct list_head	pai_node;
+		};
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 		struct { /* breakpoint */
 			/*
-- 
2.45.2


