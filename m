Return-Path: <linux-kernel+bounces-544968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C99FA4E765
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A964243DE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F9429CB3C;
	Tue,  4 Mar 2025 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQDiBMWJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0356F29CB35
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105833; cv=none; b=eE0pb1iYBAgg8iPxQF3S/BxoZ+RmVxP7+OEnkhPxeDWE6pecq4TIC7Nfd0pyelibdqVzaNQo5z6gGHvc8vykbKj7qW0Cp5c4nbNs/a3MSERPafnnxg/aXyb6Ex+vsr+akAaKwQdruBmdLprrYSoxWva0qTMkAF8kICLQjQzZvjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105833; c=relaxed/simple;
	bh=1peCX6R7h30DTJOxD1LU6DMIih5rffyXOoAucAoALe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vCZ79V36DkUzHzunAsZhR//Gq/wP0/L10qBbux+Dv0IVgypcnS1c5NJ/HBGfUW2FrR3Dj0LIVV0rOXRM+ci1R9lqHo1DRBQye9Rwba0Y2oq75Aqen3RTB3EF9HFHl+M+feQjlaXf1T7vuEtjvkFEa1IxHAVOArz6jkOLAH3kH9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZQDiBMWJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741105830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uPv451Hu7Di4D/sapxzf/F2GAAzWxvqZ/lL0oqguUyU=;
	b=ZQDiBMWJSe3c3tu4fgcAHA4fSsBngTUV314HkVIbTQtRI2aSaAb5t+wpUa8s73JU0rlJE9
	Z7GrLZVuH0kwnr02Q+PprXgsVE0HFQrXXmN9u9fliT/x+3MU0ve77ShFJ436+Qxa4IYkJP
	pYuEK52cNaK5hBKQ9SL/PxqXC3HOTog=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-cJtD5uTSNymyu3fSiwrJRA-1; Tue,
 04 Mar 2025 11:30:26 -0500
X-MC-Unique: cJtD5uTSNymyu3fSiwrJRA-1
X-Mimecast-MFC-AGG-ID: cJtD5uTSNymyu3fSiwrJRA_1741105825
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3FEE1801A10;
	Tue,  4 Mar 2025 16:30:24 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.44.33.176])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26D23300018D;
	Tue,  4 Mar 2025 16:30:18 +0000 (UTC)
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
	jbrnak@redhat.com
Subject: [PATCH] perf tests probe_vfs_getname: Skip if no suitable line detected
Date: Tue,  4 Mar 2025 17:30:15 +0100
Message-ID: <20250304163015.969720-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
 tools/perf/tests/shell/lib/probe_vfs_getname.sh           | 8 +++++++-
 tools/perf/tests/shell/probe_vfs_getname.sh               | 8 +++++++-
 tools/perf/tests/shell/record+script_probe_vfs_getname.sh | 8 +++++++-
 tools/perf/tests/shell/trace+probe_vfs_getname.sh         | 8 +++++++-
 4 files changed, 28 insertions(+), 4 deletions(-)

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
index 0c5aacc446b3..9e99647fc61a 100755
--- a/tools/perf/tests/shell/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/probe_vfs_getname.sh
@@ -12,7 +12,13 @@ skip_if_no_perf_probe || exit 2
 # shellcheck source=lib/probe_vfs_getname.sh
 . "$(dirname $0)"/lib/probe_vfs_getname.sh
 
-add_probe_vfs_getname || skip_if_no_debuginfo
+add_probe_vfs_getname
 err=$?
+
+if [[ $err -ne 0 && $err -ne 2 ]]; then
+    skip_if_no_debuginfo
+    err=$?
+fi
+
 cleanup_probe_vfs_getname
 exit $err
diff --git a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
index 5940fdc1df37..2724adc23e8f 100755
--- a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
@@ -34,8 +34,14 @@ perf_script_filenames() {
 	grep -E " +touch +[0-9]+ +\[[0-9]+\] +[0-9]+\.[0-9]+: +probe:vfs_getname[_0-9]*: +\([[:xdigit:]]+\) +pathname=\"${file}\""
 }
 
-add_probe_vfs_getname || skip_if_no_debuginfo
+add_probe_vfs_getname
 err=$?
+
+if [[ $err -ne 0 && $err -ne 2 ]]; then
+    skip_if_no_debuginfo
+    err=$?
+fi
+
 if [ $err -ne 0 ] ; then
 	exit $err
 fi
diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 708a13f00635..f5cc59225cf1 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -25,8 +25,14 @@ trace_open_vfs_getname() {
 }
 
 
-add_probe_vfs_getname || skip_if_no_debuginfo
+add_probe_vfs_getname
 err=$?
+
+if [[ $err -ne 0 && $err -ne 2 ]]; then
+    skip_if_no_debuginfo
+    err=$?
+fi
+
 if [ $err -ne 0 ] ; then
 	exit $err
 fi
-- 
2.48.1


