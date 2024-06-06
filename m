Return-Path: <linux-kernel+bounces-204249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB308FE63D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA63284A12
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAD4197A7B;
	Thu,  6 Jun 2024 12:11:03 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0AC195FD5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675861; cv=none; b=fBYuvHgOamWqPfQR6uGw395ItfnPeEvygfy0sL4oZkwxKmE5UQAR8ed2K5IfsB9AL09qMRMzSotSh7H1s2K2Ukc4790ye0fKqAKJZ8XBXesacM+jRmrDQvhkFTT9WtXtewjj3Wqsoef98HkvHH5CmwUz0zhgZCY3hURMFCFQvGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675861; c=relaxed/simple;
	bh=1USSILCftAKY2knoh2V0QYMEyPvdlS6a70pxmpzW/yw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=EpuAarIEyb2svTlrS5OS+vXoBsc/X+318Les7ma7+fzu/Rn5+VlEosUiXOvWI1MbtnCG4ilngJRh1+NxPi+ye4colemJSaz+D6KEbozqvRyGarPxoAmB1T6ovvPk1QXcT+hYzpwPVEr+shpDCm4vOJweffow6F1gi24u9wfHLEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A59BC4DDE5;
	Thu,  6 Jun 2024 12:11:01 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sFBxR-00000000nMp-440Z;
	Thu, 06 Jun 2024 08:11:05 -0400
Message-ID: <20240606121105.828859387@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Jun 2024 08:10:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 09/15] ftrace: Assign ftrace_list_end to ftrace_ops_list type cast to RCU
References: <20240606121004.857581251@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Use a type cast to convert ftrace_list_end to RCU when assigning
ftrace_ops_list. This will quiet the sparse warning:

 kernel/trace/ftrace.c:125:59: warning: incorrect type in initializer (different address spaces)
 kernel/trace/ftrace.c:125:59:    expected struct ftrace_ops [noderef] __rcu *[addressable] [toplevel] ftrace_ops_list
 kernel/trace/ftrace.c:125:59:    got struct ftrace_ops *

Link: https://lore.kernel.org/linux-trace-kernel/20240605202708.450784356@goodmis.org

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 9c4d01b1bb68..034242675e7b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -122,7 +122,7 @@ static int ftrace_disabled __read_mostly;
 
 DEFINE_MUTEX(ftrace_lock);
 
-struct ftrace_ops __rcu *ftrace_ops_list __read_mostly = &ftrace_list_end;
+struct ftrace_ops __rcu *ftrace_ops_list __read_mostly = (struct ftrace_ops __rcu *)&ftrace_list_end;
 ftrace_func_t ftrace_trace_function __read_mostly = ftrace_stub;
 struct ftrace_ops global_ops;
 
-- 
2.43.0



