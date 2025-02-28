Return-Path: <linux-kernel+bounces-538824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B56A49D75
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EBB5174BDF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8902726FDB6;
	Fri, 28 Feb 2025 15:29:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F40E1EF398
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756573; cv=none; b=t5M5g0UmhdXcjpooJVcew8tZhKCdBEOQuihevHvbQ8aIhYJ5d8HEBon9E0w+B11BU0xiIJKXBvsBRUGFB6ifDt5J7OpjfCfYjOSHh1VHHtv//VgiWglFTJjRMq7JBrNAoHdoxZCFX6EAljkFpDC8kLt2G05n5evWCubPgiCH+64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756573; c=relaxed/simple;
	bh=tpc0/ziulvn5c4ZdC9qmfIr2qA1apP1byGL26sHuBiU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=nQMnXpsJmbWwoKt/pxT1GidSfJqA0ypFBR5FzAlEaWfn8uSSodgr27SNRfer8iBFZXUhWEO7EnyGRck+dgRNrZtVy+kgQlmQwBa3rBfaMuauqPcfUUVLoYGP3EyZnVHv4rby78W96o1f47LtOOAYz480fs5AIiMr2hQ5YMv+bNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F42C4CEE8;
	Fri, 28 Feb 2025 15:29:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1to2Je-0000000ABhh-2QwM;
	Fri, 28 Feb 2025 10:30:18 -0500
Message-ID: <20250228153018.433948918@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 28 Feb 2025 10:30:05 -0500
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
Subject: [for-linus][PATCH 2/3] selftests/ftrace: Let fprobe test consider already enabled functions
References: <20250228153003.725613767@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Heiko Carstens <hca@linux.ibm.com>

The fprobe test fails on Fedora 41 since the fprobe test assumption that
the number of enabled_functions is zero before the test starts is not
necessarily true. Some user space tools, like systemd, add BPF programs
that attach to functions. Those will show up in the enabled_functions table
and must be taken into account by the fprobe test.

Therefore count the number of lines of enabled_functions before tests
start, and use that as base when comparing expected results.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Link: https://lore.kernel.org/20250226142703.910860-1-hca@linux.ibm.com
Fixes: e85c5e9792b9 ("selftests/ftrace: Update fprobe test to check enabled_functions file")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../test.d/dynevent/add_remove_fprobe.tc       | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
index 449f9d8be746..73f6c6fcecab 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
@@ -10,12 +10,16 @@ PLACE=$FUNCTION_FORK
 PLACE2="kmem_cache_free"
 PLACE3="schedule_timeout"
 
+# Some functions may have BPF programs attached, therefore
+# count already enabled_functions before tests start
+ocnt=`cat enabled_functions | wc -l`
+
 echo "f:myevent1 $PLACE" >> dynamic_events
 
 # Make sure the event is attached and is the only one
 grep -q $PLACE enabled_functions
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne 1 ]; then
+if [ $cnt -ne $((ocnt + 1)) ]; then
 	exit_fail
 fi
 
@@ -23,7 +27,7 @@ echo "f:myevent2 $PLACE%return" >> dynamic_events
 
 # It should till be the only attached function
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne 1 ]; then
+if [ $cnt -ne $((ocnt + 1)) ]; then
 	exit_fail
 fi
 
@@ -32,7 +36,7 @@ echo "f:myevent3 $PLACE2" >> dynamic_events
 
 grep -q $PLACE2 enabled_functions
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne 2 ]; then
+if [ $cnt -ne $((ocnt + 2)) ]; then
 	exit_fail
 fi
 
@@ -49,7 +53,7 @@ grep -q myevent1 dynamic_events
 
 # should still have 2 left
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne 2 ]; then
+if [ $cnt -ne $((ocnt + 2)) ]; then
 	exit_fail
 fi
 
@@ -57,7 +61,7 @@ echo > dynamic_events
 
 # Should have none left
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne 0 ]; then
+if [ $cnt -ne $ocnt ]; then
 	exit_fail
 fi
 
@@ -65,7 +69,7 @@ echo "f:myevent4 $PLACE" >> dynamic_events
 
 # Should only have one enabled
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne 1 ]; then
+if [ $cnt -ne $((ocnt + 1)) ]; then
 	exit_fail
 fi
 
@@ -73,7 +77,7 @@ echo > dynamic_events
 
 # Should have none left
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne 0 ]; then
+if [ $cnt -ne $ocnt ]; then
 	exit_fail
 fi
 
-- 
2.47.2



