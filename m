Return-Path: <linux-kernel+bounces-217356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 958A490AEAB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A7A1C242AC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9A61991D3;
	Mon, 17 Jun 2024 13:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HPlgxYpR"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A398B197A9A;
	Mon, 17 Jun 2024 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718629440; cv=none; b=U2rnUDIpEZ8cK3Vd44YMr6FO9oVD1TRh1Yn1DI5UoNExKRXGi/CLeQ1x4sjQNV7vjriVVEXUR6m3ly4wvZOH3DGq4fqmf4mW3YgaIH/Gn5NsZrEDnp4ELovvB9T+nN1/FKaiLgtEPrjaJQOV8ZY0R6aV/peAb47Oo3Epsc/30w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718629440; c=relaxed/simple;
	bh=pCT7W04LnD6l9y/HFu2bMAK4iu/96wc7GXCK6milrYU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bf1DNgZvXkq/zX8iW7gTXWWEavhymjSOoWgPP0OiW2E7wtfqU6QcaP07FQFwwdTCa5vSky5mcHD8KR4CsXKiPk45Wb9tsoUS+Q91iRBGCWwvOohowGWeiF5eyA0WRDpwJHZCKf657zxjw7mdIQizGnSgpvhDyZyo0NjbrEWdxFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HPlgxYpR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HARLEq028427;
	Mon, 17 Jun 2024 13:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=b8DKrD+MUczif2pbsNNR8jx4+f
	6p6CebDMGQUxbt2oM=; b=HPlgxYpRBt+n7HdrD7S8W+IHTP669ufZUZrdFYeAcl
	lQY0N+rUi8wZhvyTHHMK+MfFU4Jjok9xauIl1xQpkHXS1PyuPkP9GkFJ+hjA8Fv3
	d35UAVxoY9DHYdVXbuUEeky+czzCLJswbFg/Jd6J2abtTdrWFXua+X5YfK93I4y9
	IAjHt3QwSgJ4hf5omEGKfSDqhyOF2WueiJMvBE+dEnC4QmbCUwStvC9WgwgVwUyJ
	C+OQO/OUsGx6vieI9xgiD2Tl8gSXAOIbDge6G3CXbLC3obMVJ+57mq6X34g0KMfp
	DfTBO/ioYTHYnKdlrwE8RLoPVhy5tIj71HcAA3uvk7Hg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytj408ju5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 13:03:45 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45HD3imp005347;
	Mon, 17 Jun 2024 13:03:44 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytj408ju4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 13:03:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45HBKjiR019500;
	Mon, 17 Jun 2024 13:03:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ysnp0tdrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 13:03:43 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45HD3bpJ54722928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 13:03:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BD9D2004D;
	Mon, 17 Jun 2024 13:03:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15A6E2004B;
	Mon, 17 Jun 2024 13:03:35 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.120.218])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Jun 2024 13:03:34 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH V2 1/3] tools/perf: Fix the string match for "/tmp/perf-$PID.map" files in dso__load
Date: Mon, 17 Jun 2024 18:33:30 +0530
Message-Id: <20240617130332.13427-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0bIx__JvlTPUa5cwsPvOiSg8hOPVDXWh
X-Proofpoint-GUID: QJ_Qqkfu_Er2SR-1wtianOIYGinmzzqH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_11,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170100

Perf test for perf probe of function from different CU fails
as below:

	./perf test -vv "test perf probe of function from different CU"
	116: test perf probe of function from different CU:
	--- start ---
	test child forked, pid 2679
	Failed to find symbol foo in /tmp/perf-uprobe-different-cu-sh.Msa7iy89bx/testfile
	  Error: Failed to add events.
	--- Cleaning up ---
	"foo" does not hit any event.
	  Error: Failed to delete events.
	---- end(-1) ----
	116: test perf probe of function from different CU                   : FAILED!

The test does below to probe function "foo" :

	# gcc -g -Og -flto -c /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-foo.c
	-o /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-foo.o
	# gcc -g -Og -c /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-main.c
	-o /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-main.o
	# gcc -g -Og -o /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile
	/tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-foo.o
	/tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-main.o

	# ./perf probe -x /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile foo
	Failed to find symbol foo in /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile
	   Error: Failed to add events.

Perf probe fails to find symbol foo in the executable placed in
/tmp/perf-uprobe-different-cu-sh.XniNxNEVT7

Simple reproduce:

 # mktemp -d /tmp/perf-checkXXXXXXXXXX
   /tmp/perf-checkcWpuLRQI8j

 # gcc -g -o test test.c
 # cp test /tmp/perf-checkcWpuLRQI8j/
 # nm /tmp/perf-checkcWpuLRQI8j/test | grep foo
   00000000100006bc T foo

 # ./perf probe -x /tmp/perf-checkcWpuLRQI8j/test foo
   Failed to find symbol foo in /tmp/perf-checkcWpuLRQI8j/test
      Error: Failed to add events.

But it works with any files like /tmp/perf/test. Only for
patterns with "/tmp/perf-", this fails.

Further debugging, commit 80d496be89ed ("perf report: Add support
for profiling JIT generated code") added support for profiling JIT
generated code. This patch handles dso's of form
"/tmp/perf-$PID.map" .

The check used "if (strncmp(self->name, "/tmp/perf-", 10) == 0)"
to match "/tmp/perf-$PID.map". With this commit, any dso in
/tmp/perf- folder will be considered separately for processing
(not only JIT created map files ). Fix this by changing the
string pattern to check for "/tmp/perf-%d.map". Add a helper
function is_perf_pid_map_name to do this check.

With the fix,
	# ./perf test "test perf probe of function from different CU"
	117: test perf probe of function from different CU                   : Ok

Signed-off-by: Athira Rajeev<atrajeev@linux.vnet.ibm.com>
---
Changelog:
v2 -> v2:
 Addressed review comments from Adrian.
 Added helper function is_perf_pid_map_name to check
 dso name of form "/tmp/perf-%d.map". Used sscanf
 instead of regex comparison.

 tools/perf/util/dso.c    | 7 +++++++
 tools/perf/util/dso.h    | 3 +++
 tools/perf/util/symbol.c | 3 ++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index dde706b71da7..4dabb82d8018 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1652,3 +1652,10 @@ int dso__strerror_load(struct dso *dso, char *buf, size_t buflen)
 	scnprintf(buf, buflen, "%s", dso_load__error_str[idx]);
 	return 0;
 }
+
+bool is_perf_pid_map_name(const char *dso_name)
+{
+	int tid;
+
+	return sscanf(dso_name, "/tmp/perf-%d.map", &tid) == 1;
+}
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index df2c98402af3..44a3a5c97daf 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -809,4 +809,7 @@ void reset_fd_limit(void);
 u64 dso__find_global_type(struct dso *dso, u64 addr);
 u64 dso__findnew_global_type(struct dso *dso, u64 addr, u64 offset);
 
+/* Check if dso name is of format "/tmp/perf-%d.map" */
+bool is_perf_pid_map_name(const char *dso_name);
+
 #endif /* __PERF_DSO */
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 9e5940b5bc59..aee0a4cfb383 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1799,7 +1799,8 @@ int dso__load(struct dso *dso, struct map *map)
 	const char *map_path = dso__long_name(dso);
 
 	mutex_lock(dso__lock(dso));
-	perfmap = strncmp(dso__name(dso), "/tmp/perf-", 10) == 0;
+	perfmap = is_perf_pid_map_name(map_path);
+
 	if (perfmap) {
 		if (dso__nsinfo(dso) &&
 		    (dso__find_perf_map(newmapname, sizeof(newmapname),
-- 
2.35.3


