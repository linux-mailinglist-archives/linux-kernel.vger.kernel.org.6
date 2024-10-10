Return-Path: <linux-kernel+bounces-359304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E50409989F7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 643A61F2A4D7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990471E4938;
	Thu, 10 Oct 2024 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nejMMP82"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761601E47CF;
	Thu, 10 Oct 2024 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570672; cv=none; b=JxO+Uld5I+/KHrn5w0XjlTyw/5PYMDkp5PPZSfs9WK851rP1eU7OdDvlLsGWkGE/xivQddFAV1bJBu6og2mzDyAGhHerWV8icDgXp7ja4QQDoS+ez6LxeZjFqZDCkC06Sgh4I2MQLmfF9ght9CaONEcrCFExUR7kEv8ciwo5xnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570672; c=relaxed/simple;
	bh=ILCXzCNriTcnDA+vrxWd3kYuc+ycw60MBINF0NmoD6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=THGx50SXTQ08XWWSysCuKzIENONuCD2+vwuyxYFqi5+/x1BhtwYA4ff9RSewuyEeYCN4JpeDxMJOZBZ7M+KGl9+HA6HB2GeUh4QsGftZ6KVuAH6NXD/nR0N38JwOfbuIqntAmAeTkPLGIDrdpNxIuP3y14N3ffVugDJgc9QA3Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nejMMP82; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AEKe47021953;
	Thu, 10 Oct 2024 14:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=y/M2n1FmX9ppa
	sHgfRkb35Rzv4ll+ENmXS9vSuJHhRU=; b=nejMMP82UEruE8Fjl+xaLCc6sYWHe
	oOD7KLqPEop1aFsIlnA2vXvua7Hd3tthGluFbaguy17De23YfR1igP8EAHJ6ZNyf
	4ZoW3KBHD5GufhpxhjFSr/wslSobhA5jDPMRxc3UAwFnvE0/yf7H2G66g+CLkXSO
	hGpNJiQ5xJFhEUqARVWhjYZScMwI+r108lUbxAWYN9L8vXulncWPilyLhdarJTgz
	yKYZorhw67IJyTJFkPudpekp512B8L6JVgIy6vBK0t6ad5qydy1CI+BiduN6jXc1
	sdCJi6hVBj6fWOa943B+4fMHshDOHkVN3pqLiYrlbdKVKpmZigXzHl+mQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 426gkp01r2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 14:31:04 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49AEV4Jg013538;
	Thu, 10 Oct 2024 14:31:04 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 426gkp01qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 14:31:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49AE0ZR9022852;
	Thu, 10 Oct 2024 14:31:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 423jg17xhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 14:31:03 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49AEUxsK49807676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 14:30:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA47A20043;
	Thu, 10 Oct 2024 14:30:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E199920040;
	Thu, 10 Oct 2024 14:30:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.254.159])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Oct 2024 14:30:53 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org, hbathini@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH V3 2/2] tools/perf: Add support to handle compatible mode PVR for perf json events
Date: Thu, 10 Oct 2024 20:00:35 +0530
Message-Id: <20241010143035.50907-2-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20241010143035.50907-1-atrajeev@linux.vnet.ibm.com>
References: <20241010143035.50907-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6a7K8nSkPiEL9_vTEwrxCyqwRt2g8a1O
X-Proofpoint-GUID: YYxfAFgBDTKw8NWb6vx1QTOaN_2k0bpp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_11,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410100096

perf list picks the events supported for specific platform
from pmu-events/arch/powerpc/<platform>. Example power10 events
are in pmu-events/arch/powerpc/power10, power9 events are part
of pmu-events/arch/powerpc/power9. The decision of which
platform to pick is determined based on PVR value in powerpc.
The PVR value is matched from pmu-events/arch/powerpc/mapfile.csv

Example:

Format:
	PVR,Version,JSON/file/pathname,Type

0x004[bcd][[:xdigit:]]{4},1,power8,core
0x0066[[:xdigit:]]{4},1,power8,core
0x004e[[:xdigit:]]{4},1,power9,core
0x0080[[:xdigit:]]{4},1,power10,core
0x0082[[:xdigit:]]{4},1,power10,core

The code gets the PVR from system using get_cpuid_str function
in arch/powerpc/util/headers.c ( from SPRN_PVR ) and compares
with value from mapfile.csv
In case of compat mode, say when partition is booted in a power9
mode when the system is a power10, this picks incorrectly. Because
PVR will point to power10 where as it should pick events from power9
folder. To support generic events, add new folder
pmu-events/arch/powerpc/compat to contain the ISA architected events
which is supported in compat mode. Also return 0x00ffffff as pvr
when booted in compat mode. Based on this pvr value, json will
pick events from pmu-events/arch/powerpc/compat

Suggested-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---

 tools/perf/arch/powerpc/util/header.c | 32 ++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
index 6b00efd53638..adc82c479443 100644
--- a/tools/perf/arch/powerpc/util/header.c
+++ b/tools/perf/arch/powerpc/util/header.c
@@ -10,6 +10,18 @@
 #include "utils_header.h"
 #include "metricgroup.h"
 #include <api/fs/fs.h>
+#include <sys/auxv.h>
+
+static bool is_compat_mode(void)
+{
+	u64 base_platform = getauxval(AT_BASE_PLATFORM);
+	u64 platform = getauxval(AT_PLATFORM);
+
+	if (!strcmp((char *)platform, (char *)base_platform))
+		return false;
+
+	return true;
+}
 
 int
 get_cpuid(char *buffer, size_t sz)
@@ -33,8 +45,26 @@ char *
 get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
 {
 	char *bufp;
+	unsigned long pvr;
+
+	/*
+	 * IBM Power System supports compatible mode. That is
+	 * Nth generation platform can support previous generation
+	 * OS in a mode called compatibile mode. For ex. LPAR can be
+	 * booted in a Power9 mode when the system is a Power10.
+	 *
+	 * In the compatible mode, care must be taken when generating
+	 * PVR value. When read, PVR will be of the AT_BASE_PLATFORM
+	 * To support generic events, return 0x00ffffff as pvr when
+	 * booted in compat mode. Based on this pvr value, json will
+	 * pick events from pmu-events/arch/powerpc/compat
+	 */
+	if (!is_compat_mode())
+		pvr = mfspr(SPRN_PVR);
+	else
+		pvr = 0x00ffffff;
 
-	if (asprintf(&bufp, "0x%.8lx", mfspr(SPRN_PVR)) < 0)
+	if (asprintf(&bufp, "0x%.8lx", pvr) < 0)
 		bufp = NULL;
 
 	return bufp;
-- 
2.27.0


