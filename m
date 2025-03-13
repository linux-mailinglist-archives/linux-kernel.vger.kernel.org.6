Return-Path: <linux-kernel+bounces-560024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43116A5FCC7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28766188D884
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A511268FF4;
	Thu, 13 Mar 2025 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNLBIWMV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A85E14D29B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885121; cv=none; b=f5mbGA/lwKQ9Cek3Ab6M035Gbk1l+t7yI1w6z/yEDwh7GZIOXf/nKlroHZKRAd4RmuZTxMUf4mfdGkXxB56NfWfmEcWdw6tyATWmxUl0owV396QA6KE+DR6WMEf7BH14Oo3dkWjgKqSvyqJXkTX6HyCNUPgZ2S/zExR0TE7Hqfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885121; c=relaxed/simple;
	bh=4LOJG5LANL9VKSEqiuiXMCW9QjiqEYlbfcwFQUZNUJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nl21iowVee/eCFOemVZDtMq1X+Cgp25G4PpiKT/WQ7GOOAGaG3jY+WhtJh5bXmMtidFa/yM5WN/tlPZmWUzGf40VXLNvySpWSpbNZOOjcp48byB1MEK7pG5FRd0CWATWCnCqEc5pEafa8L0oCMRh3gGaDQkF+iCflqFPiuqCW5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NNLBIWMV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741885118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5E/X2960dgOpPkkr3NA3ursQ9UNrA7fKelexI4Oc0Lo=;
	b=NNLBIWMV4XsGg6tKwk5rBunDigBrkoclJF5hn6dFaAPZ6dtHPhF9Gp4exKqWw6DZqWyLFW
	wnCgFcoMQN+ZOombaGVfvfugzVdr8GMcbFwzWldh9gEpeteSbU8J8oQMOVft96uohk2Ujl
	ZuuG1qQcMCwDwtyYRspcs9DXvflNSEI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-kEKOQ6xUNG-K4iw3jO81Fw-1; Thu,
 13 Mar 2025 12:58:35 -0400
X-MC-Unique: kEKOQ6xUNG-K4iw3jO81Fw-1
X-Mimecast-MFC-AGG-ID: kEKOQ6xUNG-K4iw3jO81Fw_1741885113
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED61019560AB;
	Thu, 13 Mar 2025 16:58:32 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.44.32.42])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EED261955BCB;
	Thu, 13 Mar 2025 16:58:27 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	kan.liang@linux.intel.com,
	mpetlan@redhat.com,
	tglozar@redhat.com,
	jbrnak@redhat.com,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2] perf test probe_vfs_getname: Skip if no suitable line detected
Date: Thu, 13 Mar 2025 17:58:24 +0100
Message-ID: <20250313165824.7711-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

In some cases when calling function add_probe_vfs_getname, line number
can't be detected by perf probe -L getname_flags:

  78         atomic_set(&result->refcnt, 1);

	     // one of the following lines should have line number
	     // but sometimes it does not because of optimization
	     result->uptr = filename;
             result->aname = NULL;

  81         audit_getname(result);

To prevent false failures, skip the affected tests
if no suitable line numbers can be detected.


Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
---
v2:
- check if return from add_vfs_getname equals to 1 since
it is only option in case of fail

v1: https://lore.kernel.org/linux-perf-users/Z8pAep0GJsMFTyEi@google.com/T/#t
---
 tools/perf/tests/shell/lib/probe_vfs_getname.sh          | 8 +++++++-
 tools/perf/tests/shell/probe_vfs_getname.sh              | 8 +++++++-
 .../perf/tests/shell/record+script_probe_vfs_getname.sh  | 8 +++++++-
 tools/perf/tests/shell/trace+probe_vfs_getname.sh        | 9 +++++++--
 4 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index 5c33ec7a5a63..89f72a4c818c 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -19,8 +19,14 @@ add_probe_vfs_getname() {
 			result_aname_re="[[:space:]]+([[:digit:]]+)[[:space:]]+result->aname = NULL;"
 			line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_aname_re" | sed -r "s/$result_aname_re/\1/")
 		fi
+
+		if [ -z "$line" ] ; then
+			echo "Could not find probeable line"
+			return 2
+		fi
+
 		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
-		perf probe $add_probe_verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring"
+		perf probe $add_probe_verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring" || return 1
 	fi
 }
 
diff --git a/tools/perf/tests/shell/probe_vfs_getname.sh b/tools/perf/tests/shell/probe_vfs_getname.sh
index c51a32931af6..b210576f1971 100755
--- a/tools/perf/tests/shell/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/probe_vfs_getname.sh
@@ -13,7 +13,13 @@ skip_if_no_perf_probe || exit 2
 # shellcheck source=lib/probe_vfs_getname.sh
 . "$(dirname $0)"/lib/probe_vfs_getname.sh
 
-add_probe_vfs_getname || skip_if_no_debuginfo
+add_probe_vfs_getname
 err=$?
+
+if [[ $err -eq 1 ]] ; then
+	skip_if_no_debuginfo
+	err=$?
+fi
+
 cleanup_probe_vfs_getname
 exit $err
diff --git a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
index fd5b10d46915..a26248d52628 100755
--- a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
@@ -35,8 +35,14 @@ perf_script_filenames() {
 	grep -E " +touch +[0-9]+ +\[[0-9]+\] +[0-9]+\.[0-9]+: +probe:vfs_getname[_0-9]*: +\([[:xdigit:]]+\) +pathname=\"${file}\""
 }
 
-add_probe_vfs_getname || skip_if_no_debuginfo
+add_probe_vfs_getname
 err=$?
+
+if [[ $err -eq 1 ]] ; then
+        skip_if_no_debuginfo
+        err=$?
+fi
+
 if [ $err -ne 0 ] ; then
 	exit $err
 fi
diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 60fccb62c540..4956cd9be41f 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -25,9 +25,14 @@ trace_open_vfs_getname() {
 	grep -E " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch/[0-9]+ open(at)?\((dfd: +CWD, +)?filename: +\"?${file}\"?, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
 }
 
-
-add_probe_vfs_getname || skip_if_no_debuginfo
+add_probe_vfs_getname
 err=$?
+
+if [[ $err -eq 1 ]] ; then
+        skip_if_no_debuginfo
+        err=$?
+fi
+
 if [ $err -ne 0 ] ; then
 	exit $err
 fi
-- 
2.48.1


