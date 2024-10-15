Return-Path: <linux-kernel+bounces-366714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6E599F902
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBAFD1C21C59
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FA71FBF77;
	Tue, 15 Oct 2024 21:24:05 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8641FAEE9
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729027445; cv=none; b=qlGNr5WokUMz8DbNKGs835cqLWDGQQlqIKwUuaMJM9C4Eh1vCcPnAj0twM7VsgsFqpLdu8532SlvdHoFnFmV678f264OU1/7XKzsj6nneBtT4lLvxZ/Er/AaybmbO1AnpMwL+0DuJTi5cK4E5FdnFKjoVj/5AVmnvvVacpo1nr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729027445; c=relaxed/simple;
	bh=QK8X94tByFInqDHTuFetKcS1kDi1+z4RzhFuZyLBHxw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BUpvJgM+W3zTAJLCu8QZ8lvIZXRWOIdBGHmX78Lx7+z44T6KXPIq7StC3cgDUy3Tl7RRSjsWGjR1aJGxCstdCd3qUnw/Rd4Jpe+OZ+M5CvljFbVMYMKhxnHZ8RRK2TIfxrJZTD3LT7F1mK2LOU/lZaLzvi4hf6z71m661Xg6Tes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B217EC4AF09;
	Tue, 15 Oct 2024 21:24:04 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t0p1k-0000000350d-3Ctb;
	Tue, 15 Oct 2024 17:24:24 -0400
Message-ID: <20241015212424.623565632@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 15 Oct 2024 17:24:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <shuah@kernel.org>,
 Donglin Peng <pengdonglin@xiaomi.com>
Subject: [for-next][PATCH 2/3] selftests/ftrace: Fix check of return value in fgraph-retval.tc test
References: <20241015212408.300754469@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The addition of recording both the function name and return address to the
function graph tracer updated the selftest to check for "=-5" from "= -5".
But this causes the test to fail on certain configs, as "= -5" is still a
value that can be returned if function addresses are not enabled (older kernels).

Check for both "=-5" and " -5" as a success value.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Donglin Peng <pengdonglin@xiaomi.com>
Link: https://lore.kernel.org/20241011132042.435f43cc@gandalf.local.home
Fixes: 21e92806d39c6 ("function_graph: Support recording and printing the function return address")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc
index e8e46378b88d..4307d4eef417 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc
@@ -29,7 +29,7 @@ set -e
 
 : "Test printing the error code in signed decimal format"
 echo 0 > options/funcgraph-retval-hex
-count=`cat trace | grep 'proc_reg_write' | grep '=-5' | wc -l`
+count=`cat trace | grep 'proc_reg_write' | grep -e '=-5 ' -e '= -5 '  | wc -l`
 if [ $count -eq 0 ]; then
     fail "Return value can not be printed in signed decimal format"
 fi
-- 
2.45.2



