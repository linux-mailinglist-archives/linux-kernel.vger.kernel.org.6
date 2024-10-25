Return-Path: <linux-kernel+bounces-381490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E589AFFDF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F331C24E34
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4063A1DE2C2;
	Fri, 25 Oct 2024 10:19:00 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D813E1D8DF8
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729851539; cv=none; b=PSKst+wWMRn8NLSEM5lhdX+xpD1FHLidxird6wNkn6jQtG3cqlzUpgtscsMbFbMgl90H/8fhYj7uhwdX5ZdpJW2oSUvrbFpsbs8SDUX2kDiIcvmwo0G0f+cNK6yt8M6uIDOVG9FSFI4HAhlXLIvNyqF5s10K2UfJ4Q0SjFUoh5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729851539; c=relaxed/simple;
	bh=d3uJcPwMcfeTjJjRl96boF6hbfwnXQhKDRY8RJd7uvs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=KwvQSQYNtuftJNbnJyN2FZnkMqtuY3nISR/4G60+Z4rmevDz/36Ehfhs+GrpIOp1m/TR9oOd91XjcsTRxWmxIg1PRag/kS9Voencpw2VoQYjYulDVpNh627GwwjQHdrUtlmG/Y/BSIp3RffyDsAaA4BbqPgyNxh+OQRahi2eXuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CF6C4CEC3;
	Fri, 25 Oct 2024 10:18:59 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t4HPx-00000004rfz-3NzE;
	Fri, 25 Oct 2024 06:19:41 -0400
Message-ID: <20241025101941.675760393@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 25 Oct 2024 06:19:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [for-linus][PATCH 2/2] fgraph: Change the name of cpuhp state to "fgraph:online"
References: <20241025101910.054222333@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The cpuhp state name given to cpuhp_setup_state() is "fgraph_idle_init"
which doesn't really conform to the names that are used for cpu hotplug
setups. Instead rename it to "fgraph:online" to be in line with other
states.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/20241024222944.473d88c5@rorschach.local.home
Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: 2c02f7375e658 ("fgraph: Use CPU hotplug mechanism to initialize idle shadow stacks")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index cd1c2946018c..69e226a48daa 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1255,7 +1255,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	guard(mutex)(&ftrace_lock);
 
 	if (!fgraph_initialized) {
-		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "fgraph_idle_init",
+		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "fgraph:online",
 					fgraph_cpu_init, NULL);
 		if (ret < 0) {
 			pr_warn("fgraph: Error to init cpu hotplug support\n");
-- 
2.45.2



