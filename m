Return-Path: <linux-kernel+bounces-225958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5339291385A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 08:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81082B22536
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 06:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5E03770C;
	Sun, 23 Jun 2024 06:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rUevm3qc"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD488182DA;
	Sun, 23 Jun 2024 06:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719125356; cv=none; b=ZNNg95/b5m3YFNBVZ4FpywtQp9Pm/OXe3ETScCjUxR3fLD0pg0V1WeEN63zsBavIUeB0ygmvZ0tHpJs+be5C8e+qJB5sKYDrAoJOZkW2HD7D26dHkD9GayqnmanCvCg9KWdOGQc2RQPUTld55sFH07tZwQraj1iEx+jw7x5xcxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719125356; c=relaxed/simple;
	bh=8shOS+NXFpO9mUfTX7cVHZ+WZ+81ZzYhFzKd6q13X30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LVurqAfoSYBEMxOOjK3cDDpXVIGvrDxx1YZ9Xns/VDZd93wUElq4+MrIZNnjUz4qcD3Altz5mWbZ+LdJqonR6k7dwgU8jHPmMb9JLP/OqxK1iEqa6wkd9ApyZVmHUgNXWK0HE2lsNEouFznVewNqpvfyGo0dZ8ro/workWf3YQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rUevm3qc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45N5um48030148;
	Sun, 23 Jun 2024 06:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=wNUT4qB16oU0B9AdYNAqHW2XO3
	PvmyEikYkySb1r2QU=; b=rUevm3qc7pwt/rUs0Le2UeMMz6gFhldWDJFsX4/Nxi
	s4z6/NKYRmkDMgro7DFqdDl1mXoBfNgEmx4b2+SxHIxMLV+x9+DFkxt6w0YnVp9v
	8oJ7j6wU//h28LuwWEnle8hd/ByBOFi807L4hLMAJgdI0MkjYotPaL3xiR9+Up5W
	f6PHzIxEFjUogx1gggZVZV/BRzTwqBh+DfNjHWack5znrAMWoL53T7BNeX2H8Gm+
	KaJCDxiVx3F8xWXc8ai+V6+PR4yNLyrDilyZkwRnL/bnEdoPi7k5v0ZM+WkKRQrt
	rZeobipNGzQO5Le4BhCQhyezcyDWuLftNHFcu49t9D/A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yx8agrmcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Jun 2024 06:49:04 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45N6n4s6007655;
	Sun, 23 Jun 2024 06:49:04 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yx8agrmcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Jun 2024 06:49:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45N5jTSJ019602;
	Sun, 23 Jun 2024 06:49:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yx9xph2xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Jun 2024 06:49:02 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45N6mu4557016638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Jun 2024 06:48:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCBA520043;
	Sun, 23 Jun 2024 06:48:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4708F20040;
	Sun, 23 Jun 2024 06:48:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.64.228])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 23 Jun 2024 06:48:54 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH V4 1/3] tools/perf: Fix the string match for "/tmp/perf-$PID.map" files in dso__load
Date: Sun, 23 Jun 2024 12:18:48 +0530
Message-Id: <20240623064850.83720-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RHwa-B5Mt_1vf0FZaGBQ9JANL8GsGauv
X-Proofpoint-GUID: MdzsZNEAQpkcDIrV5TRLt6m7vdEa-1DW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-23_01,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406230047

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
function is_perf_pid_map_name to do this check. In "struct dso",
dso->long_name holds the long name of the dso file. Since the
/tmp/perf-$PID.map check uses the complete name, use dso___long_name for
the string name.

With the fix,
	# ./perf test "test perf probe of function from different CU"
	117: test perf probe of function from different CU                   : Ok

Signed-off-by: Athira Rajeev<atrajeev@linux.vnet.ibm.com>
---
Changelog:
v3 -> v4:
Added commit message with usage of dso__long_name

v2 -> v3:
Addressed review comment from Adrian and James.
Added perf_pid_map_tid to save the tid and modified
is_perf_pid_map_name to use this internally.

v1 -> v2:
Addressed review comments from Adrian.
Added helper function is_perf_pid_map_name to check
dso name of form "/tmp/perf-%d.map". Used sscanf
instead of regex comparison.

 tools/perf/util/dso.c    | 12 ++++++++++++
 tools/perf/util/dso.h    |  4 ++++
 tools/perf/util/symbol.c |  3 ++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index dde706b71da7..2340c4f6d0c2 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1652,3 +1652,15 @@ int dso__strerror_load(struct dso *dso, char *buf, size_t buflen)
 	scnprintf(buf, buflen, "%s", dso_load__error_str[idx]);
 	return 0;
 }
+
+bool perf_pid_map_tid(const char *dso_name, int *tid)
+{
+	return sscanf(dso_name, "/tmp/perf-%d.map", tid) == 1;
+}
+
+bool is_perf_pid_map_name(const char *dso_name)
+{
+	int tid;
+
+	return perf_pid_map_tid(dso_name, &tid);
+}
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index df2c98402af3..d72f3b8c37f6 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -809,4 +809,8 @@ void reset_fd_limit(void);
 u64 dso__find_global_type(struct dso *dso, u64 addr);
 u64 dso__findnew_global_type(struct dso *dso, u64 addr, u64 offset);
 
+/* Check if dso name is of format "/tmp/perf-%d.map" */
+bool perf_pid_map_tid(const char *dso_name, int *tid);
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


