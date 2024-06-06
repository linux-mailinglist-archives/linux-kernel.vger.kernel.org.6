Return-Path: <linux-kernel+bounces-204251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D4D8FE640
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4F4D1C22883
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C02219883B;
	Thu,  6 Jun 2024 12:11:03 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D989197523
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675862; cv=none; b=KvIpcKEmw9LkZYB4eZ3vwRtWBPy6vz/hDjTPL2ePPKJtEx5jHCdQv4CMLb9VGg/X2Cp54MbiRbD2VJTfT3APCoLhtFh7zyxP+L3NWGlqQxPciWX9YUUa+oShZJ1d4gN623M66ykEQyPu3TwarL6o16DLpZAJ2TTiTymu1M5J/oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675862; c=relaxed/simple;
	bh=O4Z8RIZmGILc7wFuWKxh23fcOr7gMxekIIMSeGbJnB0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=UgR5RRyGmV5I+ZgGdnUprj/ZOp0NZ9EQ7fe9ylT+W1pN/zII36dlOebTs7C08nlwpXd5xoBDAgL3cSXjur59FJYwDNGMtdDmCj0AECzI8lM6pPqTnQrdtMCjAZKwjGShCpcVjtesfFrrNtqZEX+Dv2Z3KvzasaBmWGe9Wt/QLn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8865C4AF5F;
	Thu,  6 Jun 2024 12:11:01 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sFBxS-00000000nOK-1qO2;
	Thu, 06 Jun 2024 08:11:06 -0400
Message-ID: <20240606121106.299363966@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Jun 2024 08:10:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 kernel test robot <lkp@intel.com>
Subject: [for-next][PATCH 12/15] function_graph: Make fgraph_do_direct static key static
References: <20240606121004.857581251@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The static branch key "fgraph_do_direct" was not declared static but is
only used in one file. Change it to a static variable.

Link: https://lore.kernel.org/linux-trace-kernel/20240605202708.936515302@goodmis.org

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: cc60ee813b503 ("function_graph: Use static_call and branch to optimize entry function")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406051711.dS1sQZ9n-lkp@intel.com/
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 4bf91eebbb08..63d828054c79 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -515,7 +515,7 @@ static struct fgraph_ops fgraph_stub = {
 static struct fgraph_ops *fgraph_direct_gops = &fgraph_stub;
 DEFINE_STATIC_CALL(fgraph_func, ftrace_graph_entry_stub);
 DEFINE_STATIC_CALL(fgraph_retfunc, ftrace_graph_ret_stub);
-DEFINE_STATIC_KEY_TRUE(fgraph_do_direct);
+static DEFINE_STATIC_KEY_TRUE(fgraph_do_direct);
 
 /**
  * ftrace_graph_stop - set to permanently disable function graph tracing
-- 
2.43.0



