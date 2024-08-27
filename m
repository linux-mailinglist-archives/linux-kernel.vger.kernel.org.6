Return-Path: <linux-kernel+bounces-302619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5972D960113
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0D1282A18
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 05:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECB3757FC;
	Tue, 27 Aug 2024 05:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HGqrFDzf"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA77650271;
	Tue, 27 Aug 2024 05:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724736819; cv=none; b=PWZGPDTG+8gWZZizN0UEGPrmBCVcj6JtUB/uq6tVfl/+BW3fYuT+V5ww6zVUhsv96lQ0r8bsrgw6iQSX5i9J8JNVpXuc0Puov8bsCkTGcBPTBlU50mU3xzRuWgZg2YgKGW/XxWr3w6fiTDMTVwxAq1GvjinnhakRLv4rL/6d1FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724736819; c=relaxed/simple;
	bh=GjYKUppYwaLDrXAtDXbjph1eB+YvbnJ3lOttkWp67Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxXHWy61BZa54NKm9A+nX4fnLh1741XJOMZ89OsRe+86eLnvD5zWkAUbaUJBkDO80W+n7I7NWdX7LkWgJX8/KE3Gws2ys31Kp7imkDUK4CuFpay9j5RqsLkPm8AwWFdXs899+RN9SSxYt9Yi1sc7b2vyWQygtvIYvkGUaEYeDk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HGqrFDzf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R1xQtY015375;
	Tue, 27 Aug 2024 05:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=lxZVbaVv5iXRU
	/3CuRpiZMhKeGOceRIz0n81YR6OilQ=; b=HGqrFDzfmvMQlHTZvntc+Yl+/dfUB
	DzvaVDBEHsY6IV7YRLGJZJKepLOOXS0iGB1L3UhBYvsGvoUWwTT5tYlOLfIHTbpz
	P66MJb2s7Eyt1J6PgHdpMoRA9eGzJS2qTgqy9t25VhtniCG32JprVEdP7zBdLnkA
	/IHT31XMGyA9GQ+SxAjFFc69qpAOyf5ek0GcNTaBQbCLIA5LEa+Z2JQo6B3pGX/I
	pWrVt3iDkw0cvfJ7sUrQEZMKp1hlIcN0MWU36zCX3dvsf1Ma0KqBQc5uQieb8yot
	qZ31LUIOd0iJDdshFlKLo5QE9f7NCOetf57ofHuRdr7LWdeHgZayOZ6Hg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 417g51j2jh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 05:33:31 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47R5XUP5023594;
	Tue, 27 Aug 2024 05:33:30 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 417g51j2j8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 05:33:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47R2RhtZ003141;
	Tue, 27 Aug 2024 05:33:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 417tupsbdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 05:33:23 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47R5XKr648431578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 05:33:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DE6F2004B;
	Tue, 27 Aug 2024 05:33:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 101BF20043;
	Tue, 27 Aug 2024 05:33:14 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.ustream.lldns.net (unknown [9.200.51.96])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Aug 2024 05:33:13 +0000 (GMT)
From: Kajol Jain <kjain@linux.ibm.com>
To: acme@kernel.org, irogers@google.com
Cc: namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        hbathini@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: [PATCH 2/3] perf vendor events power10: Move the JSON/events
Date: Tue, 27 Aug 2024 11:02:05 +0530
Message-ID: <20240827053206.538814-2-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240827053206.538814-1-kjain@linux.ibm.com>
References: <20240827053206.538814-1-kjain@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MwIbe0OzEfKkeSVEB07B-E3uA-TlojNy
X-Proofpoint-GUID: BppccydX7eBidaJNsV5f-qFcZcd6X1nl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_04,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015
 phishscore=0 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408270039

Move some of the JSON/events from others.json to
more appropriate json files for power10 platform.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 .../arch/powerpc/power10/cache.json           |  15 ++
 .../arch/powerpc/power10/datasource.json      |  15 ++
 .../arch/powerpc/power10/frontend.json        |  10 ++
 .../arch/powerpc/power10/locks.json           |  10 ++
 .../arch/powerpc/power10/memory.json          |  30 ++++
 .../arch/powerpc/power10/others.json          | 130 ------------------
 .../arch/powerpc/power10/pipeline.json        |  45 ++++++
 .../pmu-events/arch/powerpc/power10/pmc.json  |   5 +
 8 files changed, 130 insertions(+), 130 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power10/cache.json b/tools/perf/pmu-events/arch/powerpc/power10/cache.json
index 839ae26945fb..9814a59fce31 100644
--- a/tools/perf/pmu-events/arch/powerpc/power10/cache.json
+++ b/tools/perf/pmu-events/arch/powerpc/power10/cache.json
@@ -1,4 +1,19 @@
 [
+  {
+    "EventCode": "0x1002C",
+    "EventName": "PM_LD_PREFETCH_CACHE_LINE_MISS",
+    "BriefDescription": "The L1 cache was reloaded with a line that fulfills a prefetch request."
+  },
+  {
+    "EventCode": "0x200FD",
+    "EventName": "PM_L1_ICACHE_MISS",
+    "BriefDescription": "Demand instruction cache miss."
+  },
+  {
+    "EventCode": "0x30068",
+    "EventName": "PM_L1_ICACHE_RELOADED_PREF",
+    "BriefDescription": "Counts all instruction cache prefetch reloads (includes demand turned into prefetch)."
+  },
   {
     "EventCode": "0x300F4",
     "EventName": "PM_RUN_INST_CMPL_CONC",
diff --git a/tools/perf/pmu-events/arch/powerpc/power10/datasource.json b/tools/perf/pmu-events/arch/powerpc/power10/datasource.json
index 283284745d9c..a5d5be35b5e6 100644
--- a/tools/perf/pmu-events/arch/powerpc/power10/datasource.json
+++ b/tools/perf/pmu-events/arch/powerpc/power10/datasource.json
@@ -1,4 +1,14 @@
 [
+  {
+    "EventCode": "0x1505E",
+    "EventName": "PM_LD_HIT_L1",
+    "BriefDescription": "Load  finished without experiencing an L1 miss."
+  },
+  {
+    "EventCode": "0x100FC",
+    "EventName": "PM_LD_REF_L1",
+    "BriefDescription": "All L1 D cache load references counted at finish, gated by reject. In P9 and earlier this event counted only cacheable loads but in P10 both cacheable and non-cacheable loads are included."
+  },
   {
     "EventCode": "0x200FE",
     "EventName": "PM_DATA_FROM_L2MISS",
@@ -9,6 +19,11 @@
     "EventName": "PM_DATA_FROM_L3MISS",
     "BriefDescription": "The processor's L1 data cache was reloaded from beyond the local core's L3 due to a demand miss."
   },
+  {
+    "EventCode": "0x400F0",
+    "EventName": "PM_LD_DEMAND_MISS_L1_FIN",
+    "BriefDescription": "Load missed L1, counted at finish time."
+  },
   {
     "EventCode": "0x400FE",
     "EventName": "PM_DATA_FROM_MEMORY",
diff --git a/tools/perf/pmu-events/arch/powerpc/power10/frontend.json b/tools/perf/pmu-events/arch/powerpc/power10/frontend.json
index 456971f60814..684374fe5699 100644
--- a/tools/perf/pmu-events/arch/powerpc/power10/frontend.json
+++ b/tools/perf/pmu-events/arch/powerpc/power10/frontend.json
@@ -84,6 +84,11 @@
     "EventName": "PM_VECTOR_ST_CMPL",
     "BriefDescription": "Vector store instruction completed."
   },
+  {
+    "EventCode": "0x4D05E",
+    "EventName": "PM_BR_CMPL",
+    "BriefDescription": "A branch completed. All branches are included."
+  },
   {
     "EventCode": "0x4E054",
     "EventName": "PM_DTLB_HIT_1G",
@@ -94,6 +99,11 @@
     "EventName": "PM_ITLB_MISS",
     "BriefDescription": "Instruction TLB reload (after a miss), all page sizes. Includes only demand misses."
   },
+  {
+    "EventCode": "0x00000048B4",
+    "EventName": "PM_BR_TKN_UNCOND_FIN",
+    "BriefDescription": "An unconditional branch finished. All unconditional branches are taken."
+  },
   {
     "EventCode": "0x00000040B8",
     "EventName": "PM_PRED_BR_TKN_COND_DIR",
diff --git a/tools/perf/pmu-events/arch/powerpc/power10/locks.json b/tools/perf/pmu-events/arch/powerpc/power10/locks.json
index b5a0d6521963..a8ea4d0def1a 100644
--- a/tools/perf/pmu-events/arch/powerpc/power10/locks.json
+++ b/tools/perf/pmu-events/arch/powerpc/power10/locks.json
@@ -4,9 +4,19 @@
     "EventName": "PM_STCX_FAIL_FIN",
     "BriefDescription": "Conditional store instruction (STCX) failed. LARX and STCX are instructions used to acquire a lock."
   },
+  {
+    "EventCode": "0x2E014",
+    "EventName": "PM_STCX_FIN",
+    "BriefDescription": "Conditional store instruction (STCX) finished. LARX and STCX are instructions used to acquire a lock."
+  },
   {
     "EventCode": "0x4E050",
     "EventName": "PM_STCX_PASS_FIN",
     "BriefDescription": "Conditional store instruction (STCX) passed. LARX and STCX are instructions used to acquire a lock."
+  },
+  {
+    "EventCode": "0x000000C8B8",
+    "EventName": "PM_STCX_SUCCESS_CMPL",
+    "BriefDescription": "STCX instructions that completed successfully. Specifically, counts only when a pass status is returned from the nest."
   }
 ]
diff --git a/tools/perf/pmu-events/arch/powerpc/power10/memory.json b/tools/perf/pmu-events/arch/powerpc/power10/memory.json
index 885262957beb..0d7191b3f2c6 100644
--- a/tools/perf/pmu-events/arch/powerpc/power10/memory.json
+++ b/tools/perf/pmu-events/arch/powerpc/power10/memory.json
@@ -69,6 +69,11 @@
     "EventName": "PM_XFER_FROM_SRC_PMC3",
     "BriefDescription": "The processor's L1 data cache was reloaded from the source specified in MMCR3[30:42]. If MMCR1[16|17] is 0 (default), this count includes only lines that were reloaded to satisfy a demand miss. If MMCR1[16|17] is 1, this count includes both demand misses and prefetch reloads."
   },
+  {
+    "EventCode": "0x3F04A",
+    "EventName": "PM_LSU_ST5_FIN",
+    "BriefDescription": "LSU Finished an internal operation in ST2 port."
+  },
   {
     "EventCode": "0x3C054",
     "EventName": "PM_DERAT_MISS_16M",
@@ -108,5 +113,30 @@
     "EventCode": "0x4C05A",
     "EventName": "PM_DTLB_MISS_1G",
     "BriefDescription": "Data TLB reload (after a miss) page size 1G. Implies radix translation was used. When MMCR1[16]=0 this event counts only for demand misses. When MMCR1[16]=1 this event includes demand misses and prefetches."
+  },
+  {
+    "EventCode": "0x000000F880",
+    "EventName": "PM_SNOOP_TLBIE_CYC",
+    "BriefDescription": "Cycles in which TLBIE snoops are executed in the LSU."
+  },
+  {
+    "EventCode": "0x000000F084",
+    "EventName": "PM_SNOOP_TLBIE_CACHE_WALK_CYC",
+    "BriefDescription": "TLBIE snoop cycles in which the data cache is being walked."
+  },
+  {
+    "EventCode": "0x000000F884",
+    "EventName": "PM_SNOOP_TLBIE_WAIT_ST_CYC",
+    "BriefDescription": "TLBIE snoop cycles in which older stores are still draining."
+  },
+  {
+    "EventCode": "0x000000F088",
+    "EventName": "PM_SNOOP_TLBIE_WAIT_LD_CYC",
+    "BriefDescription": "TLBIE snoop cycles in which older loads are still draining."
+  },
+  {
+    "EventCode": "0x000000F08C",
+    "EventName": "PM_SNOOP_TLBIE_WAIT_MMU_CYC",
+    "BriefDescription": "TLBIE snoop cycles in which the Load-Store unit is waiting for the MMU to finish invalidation."
   }
 ]
diff --git a/tools/perf/pmu-events/arch/powerpc/power10/others.json b/tools/perf/pmu-events/arch/powerpc/power10/others.json
index 3789304cb363..1bf802076ee0 100644
--- a/tools/perf/pmu-events/arch/powerpc/power10/others.json
+++ b/tools/perf/pmu-events/arch/powerpc/power10/others.json
@@ -1,89 +1,19 @@
 [
-  {
-    "EventCode": "0x1002C",
-    "EventName": "PM_LD_PREFETCH_CACHE_LINE_MISS",
-    "BriefDescription": "The L1 cache was reloaded with a line that fulfills a prefetch request."
-  },
-  {
-    "EventCode": "0x1505E",
-    "EventName": "PM_LD_HIT_L1",
-    "BriefDescription": "Load finished without experiencing an L1 miss."
-  },
-  {
-    "EventCode": "0x1F056",
-    "EventName": "PM_DISP_SS0_2_INSTR_CYC",
-    "BriefDescription": "Cycles in which Superslice 0 dispatches either 1 or 2 instructions."
-  },
-  {
-    "EventCode": "0x1F05A",
-    "EventName": "PM_DISP_HELD_SYNC_CYC",
-    "BriefDescription": "Cycles dispatch is held because of a synchronizing instruction that requires the ICT to be empty before dispatch."
-  },
   {
     "EventCode": "0x10066",
     "EventName": "PM_ADJUNCT_CYC",
     "BriefDescription": "Cycles in which the thread is in Adjunct state. MSR[S HV PR] bits = 011."
   },
-  {
-    "EventCode": "0x100FC",
-    "EventName": "PM_LD_REF_L1",
-    "BriefDescription": "All L1 D cache load references counted at finish, gated by reject. In P9 and earlier this event counted only cacheable loads but in P10 both cacheable and non-cacheable loads are included."
-  },
   {
     "EventCode": "0x2E010",
     "EventName": "PM_ADJUNCT_INST_CMPL",
     "BriefDescription": "PowerPC instruction completed while the thread was in Adjunct state."
   },
-  {
-    "EventCode": "0x2E014",
-    "EventName": "PM_STCX_FIN",
-    "BriefDescription": "Conditional store instruction (STCX) finished. LARX and STCX are instructions used to acquire a lock."
-  },
-  {
-    "EventCode": "0x2F054",
-    "EventName": "PM_DISP_SS1_2_INSTR_CYC",
-    "BriefDescription": "Cycles in which Superslice 1 dispatches either 1 or 2 instructions."
-  },
-  {
-    "EventCode": "0x2F056",
-    "EventName": "PM_DISP_SS1_4_INSTR_CYC",
-    "BriefDescription": "Cycles in which Superslice 1 dispatches either 3 or 4 instructions."
-  },
   {
     "EventCode": "0x200F2",
     "EventName": "PM_INST_DISP",
     "BriefDescription": "PowerPC instruction dispatched."
   },
-  {
-    "EventCode": "0x200FD",
-    "EventName": "PM_L1_ICACHE_MISS",
-    "BriefDescription": "Demand instruction cache miss."
-  },
-  {
-    "EventCode": "0x3F04A",
-    "EventName": "PM_LSU_ST5_FIN",
-    "BriefDescription": "LSU Finished an internal operation in ST2 port."
-  },
-  {
-    "EventCode": "0x3405A",
-    "EventName": "PM_PRIVILEGED_INST_CMPL",
-    "BriefDescription": "PowerPC instruction completed while the thread was in Privileged state."
-  },
-  {
-    "EventCode": "0x3F054",
-    "EventName": "PM_DISP_SS0_4_INSTR_CYC",
-    "BriefDescription": "Cycles in which Superslice 0 dispatches either 3 or 4 instructions."
-  },
-  {
-    "EventCode": "0x3F056",
-    "EventName": "PM_DISP_SS0_8_INSTR_CYC",
-    "BriefDescription": "Cycles in which Superslice 0 dispatches either 5, 6, 7 or 8 instructions."
-  },
-  {
-    "EventCode": "0x30068",
-    "EventName": "PM_L1_ICACHE_RELOADED_PREF",
-    "BriefDescription": "Counts all instruction cache prefetch reloads (includes demand turned into prefetch)."
-  },
   {
     "EventCode": "0x300F6",
     "EventName": "PM_LD_DEMAND_MISS_L1",
@@ -94,16 +24,6 @@
     "EventName": "PM_L1_ICACHE_RELOADED_ALL",
     "BriefDescription": "Counts all instruction cache reloads includes demand, prefetch, prefetch turned into demand and demand turned into prefetch."
   },
-  {
-    "EventCode": "0x4D05E",
-    "EventName": "PM_BR_CMPL",
-    "BriefDescription": "A branch completed. All branches are included."
-  },
-  {
-    "EventCode": "0x400F0",
-    "EventName": "PM_LD_DEMAND_MISS_L1_FIN",
-    "BriefDescription": "Load missed L1, counted at finish time."
-  },
   {
     "EventCode": "0x00000038BC",
     "EventName": "PM_ISYNC_CMPL",
@@ -139,64 +59,14 @@
     "EventName": "PM_ST1_UNALIGNED_FIN",
     "BriefDescription": "Store instructions in ST1 port that are either unaligned, or treated as unaligned and require an additional recycle through the pipeline. This typically adds about 10 cycles to the latency of the instruction. This only includes stores that cross the 128 byte boundary. Counted at finish time."
   },
-  {
-    "EventCode": "0x000000C8B8",
-    "EventName": "PM_STCX_SUCCESS_CMPL",
-    "BriefDescription": "STCX instructions that completed successfully. Specifically, counts only when a pass status is returned from the nest."
-  },
   {
     "EventCode": "0x000000D0B4",
     "EventName": "PM_DC_PREF_STRIDED_CONF",
     "BriefDescription": "A demand load referenced a line in an active strided prefetch stream. The stream could have been allocated through the hardware prefetch mechanism or through software."
   },
-  {
-    "EventCode": "0x000000F880",
-    "EventName": "PM_SNOOP_TLBIE_CYC",
-    "BriefDescription": "Cycles in which TLBIE snoops are executed in the LSU."
-  },
-  {
-    "EventCode": "0x000000F084",
-    "EventName": "PM_SNOOP_TLBIE_CACHE_WALK_CYC",
-    "BriefDescription": "TLBIE snoop cycles in which the data cache is being walked."
-  },
-  {
-    "EventCode": "0x000000F884",
-    "EventName": "PM_SNOOP_TLBIE_WAIT_ST_CYC",
-    "BriefDescription": "TLBIE snoop cycles in which older stores are still draining."
-  },
-  {
-    "EventCode": "0x000000F088",
-    "EventName": "PM_SNOOP_TLBIE_WAIT_LD_CYC",
-    "BriefDescription": "TLBIE snoop cycles in which older loads are still draining."
-  },
-  {
-    "EventCode": "0x000000F08C",
-    "EventName": "PM_SNOOP_TLBIE_WAIT_MMU_CYC",
-    "BriefDescription": "TLBIE snoop cycles in which the Load-Store unit is waiting for the MMU to finish invalidation."
-  },
   {
     "EventCode": "0x0000004884",
     "EventName": "PM_NO_FETCH_IBUF_FULL_CYC",
     "BriefDescription": "Cycles in which no instructions are fetched because there is no room in the instruction buffers."
-  },
-  {
-    "EventCode": "0x00000048B4",
-    "EventName": "PM_BR_TKN_UNCOND_FIN",
-    "BriefDescription": "An unconditional branch finished. All unconditional branches are taken."
-  },
-  {
-    "EventCode": "0x0B0000016080",
-    "EventName": "PM_L2_TLBIE_SLBIE_START",
-    "BriefDescription": "NCU Master received a TLBIE/SLBIEG/SLBIAG operation from the core. Event count should be multiplied by 2 since the data is coming from a 2:1 clock domain and the data is time sliced across all 4 threads."
-  },
-  {
-    "EventCode": "0x0B0000016880",
-    "EventName": "PM_L2_TLBIE_SLBIE_DELAY",
-    "BriefDescription": "Cycles when a TLBIE/SLBIEG/SLBIAG command was held in a hottemp condition by the NCU Master. Multiply this count by 1000 to obtain the total number of cycles. This can be divided by PM_L2_TLBIE_SLBIE_SENT to obtain the average time a TLBIE/SLBIEG/SLBIAG command was held. Event count should be multiplied by 2 since the data is coming from a 2:1 clock domain and the data is time sliced across all 4 threads."
-  },
-  {
-    "EventCode": "0x0B0000026880",
-    "EventName": "PM_L2_SNP_TLBIE_SLBIE_DELAY",
-    "BriefDescription": "Cycles when a TLBIE/SLBIEG/SLBIAG that targets this thread's LPAR was in flight while in a hottemp condition. Multiply this count by 1000 to obtain the total number of cycles. This can be divided by PM_L2_SNP_TLBIE_SLBIE_START to obtain the overall efficiency. Note: 'inflight' means SnpTLB has been sent to core(ie doesn't include when SnpTLB is in NCU waiting to be launched serially behind different SnpTLB). The NCU Snooper gets in a 'hottemp' delay window when it detects it is above its TLBIE/SLBIE threshold for process SnpTLBIE/SLBIE with this core. Event count should be multiplied by 2 since the data is coming from a 2:1 clock domain and the data is time sliced across all 4 threads."
   }
 ]
diff --git a/tools/perf/pmu-events/arch/powerpc/power10/pipeline.json b/tools/perf/pmu-events/arch/powerpc/power10/pipeline.json
index 21b23bb55d0d..940375d251cb 100644
--- a/tools/perf/pmu-events/arch/powerpc/power10/pipeline.json
+++ b/tools/perf/pmu-events/arch/powerpc/power10/pipeline.json
@@ -94,11 +94,21 @@
     "EventName": "PM_CMPL_STALL_LWSYNC",
     "BriefDescription": "Cycles in which the oldest instruction in the pipeline was a lwsync waiting to complete."
   },
+  {
+    "EventCode": "0x1F056",
+    "EventName": "PM_DISP_SS0_2_INSTR_CYC",
+    "BriefDescription": "Cycles in which Superslice 0 dispatches either 1 or 2 instructions."
+  },
   {
     "EventCode": "0x1F058",
     "EventName": "PM_DISP_HELD_CYC",
     "BriefDescription": "Cycles dispatch is held."
   },
+  {
+    "EventCode": "0x1F05A",
+    "EventName": "PM_DISP_HELD_SYNC_CYC",
+    "BriefDescription": "Cycles dispatch is held because of a synchronizing instruction that requires the ICT to be empty before dispatch."
+  },
   {
     "EventCode": "0x10064",
     "EventName": "PM_DISP_STALL_IC_L2",
@@ -229,6 +239,16 @@
     "EventName": "PM_NTC_FIN",
     "BriefDescription": "Cycles in which the oldest instruction in the pipeline (NTC) finishes. Note that instructions can finish out of order, therefore not all the instructions that finish have a Next-to-complete status."
   },
+  {
+    "EventCode": "0x2F054",
+    "EventName": "PM_DISP_SS1_2_INSTR_CYC",
+    "BriefDescription": "Cycles in which Superslice 1 dispatches either 1 or 2 instructions."
+  },
+  {
+    "EventCode": "0x2F056",
+    "EventName": "PM_DISP_SS1_4_INSTR_CYC",
+    "BriefDescription": "Cycles in which Superslice 1 dispatches either 3 or 4 instructions."
+  },
   {
     "EventCode": "0x20066",
     "EventName": "PM_DISP_HELD_OTHER_CYC",
@@ -329,6 +349,16 @@
     "EventName": "PM_DISP_STALL_IC_L3",
     "BriefDescription": "Cycles when dispatch was stalled while the instruction was fetched from the local L3."
   },
+  {
+    "EventCode": "0x3F054",
+    "EventName": "PM_DISP_SS0_4_INSTR_CYC",
+    "BriefDescription": "Cycles in which Superslice 0 dispatches either 3 or 4 instructions."
+  },
+  {
+    "EventCode": "0x3F056",
+    "EventName": "PM_DISP_SS0_8_INSTR_CYC",
+    "BriefDescription": "Cycles in which Superslice 0 dispatches either 5, 6, 7 or 8 instructions."
+  },
   {
     "EventCode": "0x30060",
     "EventName": "PM_DISP_HELD_XVFC_MAPPER_CYC",
@@ -458,5 +488,20 @@
     "EventCode": "0x400F8",
     "EventName": "PM_FLUSH",
     "BriefDescription": "Flush (any type)."
+  },
+  {
+    "EventCode": "0x0B0000016080",
+    "EventName": "PM_L2_TLBIE_SLBIE_START",
+    "BriefDescription": "NCU Master received a TLBIE/SLBIEG/SLBIAG operation from the core. Event count should be multiplied by 2 since the data is coming from a 2:1 clock domain and the data is time sliced across all 4 threads."
+  },
+  {
+    "EventCode": "0x0B0000016880",
+    "EventName": "PM_L2_TLBIE_SLBIE_DELAY",
+    "BriefDescription": "Cycles when a TLBIE/SLBIEG/SLBIAG command was held in a hottemp condition by the NCU Master. Multiply this count by 1000 to obtain the total number of cycles. This can be divided by PM_L2_TLBIE_SLBIE_SENT to obtain the average time a TLBIE/SLBIEG/SLBIAG command was held. Event count should be multiplied by 2 since the data is coming from a 2:1 clock domain and the data is time sliced across all 4 threads."
+  },
+  {
+    "EventCode": "0x0B0000026880",
+    "EventName": "PM_L2_SNP_TLBIE_SLBIE_DELAY",
+    "BriefDescription": "Cycles when a TLBIE/SLBIEG/SLBIAG that targets this thread's LPAR was in flight while in a hottemp condition. Multiply this count by 1000 to obtain the total number of cycles. This can be divided by PM_L2_SNP_TLBIE_SLBIE_START to obtain the overall efficiency. Note: 'inflight' means SnpTLB has been sent to core(ie doesn't include when SnpTLB is in NCU waiting to be launched serially behind different SnpTLB). The NCU Snooper gets in a 'hottemp' delay window when it detects it is above its TLBIE/SLBIE threshold for process SnpTLBIE/SLBIE with this core. Event count should be multiplied by 2 since the data is coming from a 2:1 clock domain and the data is time sliced across all 4 threads."
   }
 ]
diff --git a/tools/perf/pmu-events/arch/powerpc/power10/pmc.json b/tools/perf/pmu-events/arch/powerpc/power10/pmc.json
index 04732698d9b2..6f5b0e8fde12 100644
--- a/tools/perf/pmu-events/arch/powerpc/power10/pmc.json
+++ b/tools/perf/pmu-events/arch/powerpc/power10/pmc.json
@@ -129,6 +129,11 @@
     "EventName": "PM_PMC6_OVERFLOW",
     "BriefDescription": "The event selected for PMC6 caused the event counter to overflow."
   },
+  {
+    "EventCode": "0x3405A",
+    "EventName": "PM_PRIVILEGED_INST_CMPL",
+    "BriefDescription": "PowerPC instruction completed while the thread was in Privileged state."
+  },
   {
     "EventCode": "0x3006C",
     "EventName": "PM_RUN_CYC_SMT2_MODE",
-- 
2.43.5


