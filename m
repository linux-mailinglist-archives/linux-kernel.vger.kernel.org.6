Return-Path: <linux-kernel+bounces-215891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4358A90986B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 15:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D0CBB21A74
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 13:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F4247F6C;
	Sat, 15 Jun 2024 13:10:05 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35EB19D8A2
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718457004; cv=none; b=W3L6jgMlmczITvSeZYKOJATQl/WCWABEGKPhihJRIe47TnNbeTGPHUBN5aPeqZQ+JGGQ2VRRe69cxcPh3fggNg62aCkUia2hImh4QSwvpG2TNHfs8uoM1r8iiTxWOb9witsvDteOQEWVr4GMR0LNRTSIOIVdr9QSoQwQ0WQgjsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718457004; c=relaxed/simple;
	bh=VFQIMSguBYuNH6wlWQkCPTuswfrUnQ7eTVKyijRvXmo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=RDPdM1K/ncouPFFAlp886+fklZJivKQws6LZRc2oLnu0yJoG9zE1GPFlpY15ESsMR0TFAuGsvF1mtkFUvOBRMlqtUNVsGeSuFP9np/7zRXDHcARdePfN0XT56ykrYUO1ejw4atVrY93D0HCant9mlNwPSgsOyaGJqPh/vIqV+7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E9FC116B1;
	Sat, 15 Jun 2024 13:10:03 +0000 (UTC)
Date: Sat, 15 Jun 2024 09:10:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH] function_graph: Add READ_ONCE() when accessing
 fgraph_array[]
Message-ID: <20240615091001.04a33174@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ftrace/for-next

Head SHA1: 63a8dfb889112ab4a065aa60a9a1b590b410d055


Steven Rostedt (Google) (1):
      function_graph: Add READ_ONCE() when accessing fgraph_array[]

----
 kernel/trace/fgraph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---------------------------
commit 63a8dfb889112ab4a065aa60a9a1b590b410d055
Author: Steven Rostedt (Google) <rostedt@goodmis.org>
Date:   Thu Jun 13 09:52:23 2024 -0400

    function_graph: Add READ_ONCE() when accessing fgraph_array[]
    
    In function_graph_enter() there's a loop that looks at fgraph_array[]
    elements which are fgraph_ops. It first tests if it is a fgraph_stub op,
    and if so skips it, as that's just there as a place holder. Then it checks
    the fgraph_ops filters to see if the ops wants to trace the current
    function.
    
    But if the compiler reloads the fgraph_array[] after the check against
    fgraph_stub, it could race with the fgraph_array[] being updated with the
    fgraph_stub. That would cause the stub to be processed. But the stub has a
    null "func_hash" field which will cause a NULL pointer dereference.
    
    Add a READ_ONCE() so that the gops that is compared against the
    fgraph_stub is also the gops that is processed later.
    
    Link: https://lore.kernel.org/all/CA+G9fYsSVJQZH=nM=1cjTc94PgSnMF9y65BnOv6XSoCG_b6wmw@mail.gmail.com/
    Link: https://lore.kernel.org/linux-trace-kernel/20240613095223.1f07e3a4@rorschach.local.home
    
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Fixes: cc60ee813b503 ("function_graph: Use static_call and branch to optimize entry function")
    Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
    Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 8317d1a7f43a..fc205ad167a9 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -641,7 +641,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	{
 		for_each_set_bit(i, &fgraph_array_bitmask,
 					 sizeof(fgraph_array_bitmask) * BITS_PER_BYTE) {
-			struct fgraph_ops *gops = fgraph_array[i];
+			struct fgraph_ops *gops = READ_ONCE(fgraph_array[i]);
 			int save_curr_ret_stack;
 
 			if (gops == &fgraph_stub)

