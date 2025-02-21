Return-Path: <linux-kernel+bounces-526089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9F9A3F9EC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A7BD86608B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D86215793;
	Fri, 21 Feb 2025 15:52:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B18321505C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153143; cv=none; b=ReraveAqzOCFqSjm2dAz/5uL2waXzf80crWx+Ev/uAMSlmN2L/eHyj5o10fFFUt79M/FcT0WUwrjPESkT2lEscUNZ7jOMjpaCZ7wWzGeEQ+du9SI3BTVsEFubfnT0sTu+d4J7aEP3qNbqOSGLyCgPpsFCeTRZakpxz0l6qAwzcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153143; c=relaxed/simple;
	bh=3iUBIWBbUV2MnTgkSTiKS6AZ0qhvJdfXi5B+lzGQ4kQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BEidKOYXSaYxrFVEvKyai88H9OIiphp+NKfmxM60Ayd62OuBG5IJQ+c1W6cEuXu3qhgx9HI0DfRFiKbU2VRQKs5DQEWOth0Y0WPJSMcC7iVoGIcc/tv2FaJfj+/cEFCJPYMUy4wxR7kqH/UD8alSlwd9aTLPHcZO580pn9Nkb60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FC2C4CEE4;
	Fri, 21 Feb 2025 15:52:23 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tlVKe-00000006KTc-26JF;
	Fri, 21 Feb 2025 10:52:52 -0500
Message-ID: <20250221155252.355693893@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 21 Feb 2025 10:52:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sven Schnelle <svens@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>
Subject: [for-linus][PATCH 5/7] selftests/ftrace: Update fprobe test to check enabled_functions file
References: <20250221155210.755295517@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

A few bugs were found in the fprobe accounting logic along with it using
the function graph infrastructure. Update the fprobe selftest to catch
those bugs in case they or something similar shows up in the future.

The test now checks the enabled_functions file which shows all the
functions attached to ftrace or fgraph. When enabling a fprobe, make sure
that its corresponding function is also added to that file. Also add two
more fprobes to enable to make sure that the fprobe logic works properly
with multiple probes.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Link: https://lore.kernel.org/20250220202055.733001756@goodmis.org
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Tested-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../test.d/dynevent/add_remove_fprobe.tc      | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
index dc25bcf4f9e2..449f9d8be746 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
@@ -7,12 +7,38 @@ echo 0 > events/enable
 echo > dynamic_events
 
 PLACE=$FUNCTION_FORK
+PLACE2="kmem_cache_free"
+PLACE3="schedule_timeout"
 
 echo "f:myevent1 $PLACE" >> dynamic_events
+
+# Make sure the event is attached and is the only one
+grep -q $PLACE enabled_functions
+cnt=`cat enabled_functions | wc -l`
+if [ $cnt -ne 1 ]; then
+	exit_fail
+fi
+
 echo "f:myevent2 $PLACE%return" >> dynamic_events
 
+# It should till be the only attached function
+cnt=`cat enabled_functions | wc -l`
+if [ $cnt -ne 1 ]; then
+	exit_fail
+fi
+
+# add another event
+echo "f:myevent3 $PLACE2" >> dynamic_events
+
+grep -q $PLACE2 enabled_functions
+cnt=`cat enabled_functions | wc -l`
+if [ $cnt -ne 2 ]; then
+	exit_fail
+fi
+
 grep -q myevent1 dynamic_events
 grep -q myevent2 dynamic_events
+grep -q myevent3 dynamic_events
 test -d events/fprobes/myevent1
 test -d events/fprobes/myevent2
 
@@ -21,6 +47,34 @@ echo "-:myevent2" >> dynamic_events
 grep -q myevent1 dynamic_events
 ! grep -q myevent2 dynamic_events
 
+# should still have 2 left
+cnt=`cat enabled_functions | wc -l`
+if [ $cnt -ne 2 ]; then
+	exit_fail
+fi
+
 echo > dynamic_events
 
+# Should have none left
+cnt=`cat enabled_functions | wc -l`
+if [ $cnt -ne 0 ]; then
+	exit_fail
+fi
+
+echo "f:myevent4 $PLACE" >> dynamic_events
+
+# Should only have one enabled
+cnt=`cat enabled_functions | wc -l`
+if [ $cnt -ne 1 ]; then
+	exit_fail
+fi
+
+echo > dynamic_events
+
+# Should have none left
+cnt=`cat enabled_functions | wc -l`
+if [ $cnt -ne 0 ]; then
+	exit_fail
+fi
+
 clear_trace
-- 
2.47.2



