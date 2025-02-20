Return-Path: <linux-kernel+bounces-524682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6950DA3E5BC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DADD17A6D1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DFD266B72;
	Thu, 20 Feb 2025 20:20:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE23264634;
	Thu, 20 Feb 2025 20:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740082828; cv=none; b=cHkE+ow4TXFgKv0g5StOaNeoB/Qof4TPDAvBQQFaX3ORZ+zR9dPOOQPJsLUTwvv/t5ARNqSs/7DWr85AtVLNtt5zc+/KpXmpG8NEEoPFa2OLTTH7ex4/NlzAsSVtiqfTxhtAWFI5drT8jNKswHiYna83Bnd+S1g6k/cdqV7nmP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740082828; c=relaxed/simple;
	bh=pAozlZlRZLz4o8quuwhxeiPSC2RgvEOkmxTuBGY5Kd8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=nN8f+NShiujsA1P7ifN4JNPVrBO/iR3Pq2GT/rjmIukLzKu2S/MeWAZAza9veIrp9GS3TU878YPYQvZ1Kl5PYj8nuyOc+eJcCsJrSJ6aUagoNGt208HBIYC4fpXtNLoyunDxtsGSchP6i8UGz8ZARrHmij0YmBe1CV6t+QYCyZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63292C4CEE4;
	Thu, 20 Feb 2025 20:20:28 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tlD2V-00000005fYm-3g63;
	Thu, 20 Feb 2025 15:20:55 -0500
Message-ID: <20250220202055.733001756@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 20 Feb 2025 15:20:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Heiko Carstens <hca@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v3 5/5] selftests/ftrace: Update fprobe test to check enabled_functions file
References: <20250220202009.689253424@goodmis.org>
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



