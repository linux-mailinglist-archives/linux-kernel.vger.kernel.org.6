Return-Path: <linux-kernel+bounces-204242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D458FE636
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E562282905
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465A8195F24;
	Thu,  6 Jun 2024 12:11:01 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81FB19599A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675860; cv=none; b=AQUVw/12oPKgo2xoaq/lV9Zk//XHL/41n2ieJCwHr/em+8abIzgu2IZDlsSToeSrB3swvMC8N4tIrMmwo82sTmvOJjhzKQXAUkotM6Y8eMG4h9aDoEC4udhbhEmx+l4skLnT3mWBCTgPi1JbaajVQ38lU2rxvpc7baILbQYC0pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675860; c=relaxed/simple;
	bh=Rspk0buCUkwvxU8eo6olbM8rLVcIyG11H0MjJgWcYCo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=HHVHb7cmZ7lR5a3MovbV12lWzadrUGUg6+3G0ctpHkQcmbbZEDjMk0UT6ySMLIYNRoEapDarBoe9A+1UBt19VEefIDBtf8NEgwYJwVJGXqAkI1A0ABn9kFXfVbQqUwRtRGtzD15+p8eZlpmfRp6ysbYhbRjsY0M6GGACG4ygz60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6EBC4AF1A;
	Thu,  6 Jun 2024 12:11:00 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sFBxQ-00000000nJN-3c1Y;
	Thu, 06 Jun 2024 08:11:04 -0400
Message-ID: <20240606121104.719232091@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Jun 2024 08:10:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 02/15] ftrace/selftests: Fix pid test with function graph not showing pids
References: <20240606121004.857581251@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The pid filtering test will set the pid filters and make sure that both
function and function_graph tracing honors the filters. But the
function_graph tracer test was failing because the PID was not being
filtered properly. That's because the funcgraph-proc option wasn't getting
set. Without that option the PID is not shown.

Instead we get:

	+ cat trace
	# tracer: function_graph
	#
	# CPU  DURATION                  FUNCTION CALLS
	# |     |   |                     |   |   |   |
	 3) ! 143.685 us  |  kernel_clone();
	 3) ! 127.055 us  |  kernel_clone();
	 1) ! 127.170 us  |  kernel_clone();
	 3) ! 126.840 us  |  kernel_clone();

When we should be getting:

	+ cat trace
	# tracer: function_graph
	#
	# CPU  TASK/PID         DURATION                  FUNCTION CALLS
	# |     |    |           |   |                     |   |   |   |
	 4)    bash-939    | # 1070.009 us |  kernel_clone();
	 4)    bash-939    | # 1116.903 us |  kernel_clone();
	 5)    bash-939    | ! 976.133 us  |  kernel_clone();
	 5)    bash-939    | ! 954.012 us  |  kernel_clone();

The test looks for the pids it is filtering and will fail if it can not
find them. Without fungraph-proc option set, it will not be displayed and
the test will fail.

Link: https://lore.kernel.org/all/Zl9JFnzKGuUM10X2@J2N7QTR9R3/
Link: https://lore.kernel.org/linux-trace-kernel/20240604152550.0c01d7cd@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: 35b944a997e2 ("selftests/ftrace: Add function_graph tracer to func-filter-pid test")
Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Tested-by: Mark Rutland <mark.rutland@arm.com>
---
 tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
index c6fc9d31a496..8dcce001881d 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
@@ -8,6 +8,7 @@
 # Also test it on an instance directory
 
 do_function_fork=1
+do_funcgraph_proc=1
 
 if [ ! -f options/function-fork ]; then
     do_function_fork=0
@@ -28,6 +29,7 @@ fi
 
 if [ $do_funcgraph_proc -eq 1 ]; then
     orig_value2=`cat options/funcgraph-proc`
+    echo 1 > options/funcgraph-proc
 fi
 
 do_reset() {
-- 
2.43.0



