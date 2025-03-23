Return-Path: <linux-kernel+bounces-572826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5E0A6CF27
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 13:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB38A3B5D62
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 12:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365BD205E06;
	Sun, 23 Mar 2025 12:29:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAECE2054E8
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742732950; cv=none; b=gUs/HxKHbkkzqp5wDUkZUzIWYxfxKdpKklezmNpNYACyWdHyE7Wfu8GXfJbIcLFV3Mv8KMY5w32hZg0DVCnCYU1Z0/f3NJ+bvIs3qqy8M+xezpSv1s3IR+6TmlHjfUQfhMtFimPEaNwV7LlCcUb4MUN1yKtbKfwtaZxvXkR1b+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742732950; c=relaxed/simple;
	bh=Uwb4Lb9eyabuPAjwq6WajlQAHEed0Uk9bkWZRPTAICg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=SlSMdFEBAuhiox0f8ow0TDGLta3FrGUbHuakDk6N7tNip/NzPOXjQsgWqrSqK8VMeKbLBh8Z1Y9c2+eEzSSynlBjh5bNgdAEpTn6CigVxqn0LWRwrLbp3jXylG/S0QmptBGS6r1zy0hgjAttcSUDQdghCurdsGRt4vk45DNiL94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD53C4CEE8;
	Sun, 23 Mar 2025 12:29:10 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1twKSb-00000001yek-2wx1;
	Sun, 23 Mar 2025 08:29:49 -0400
Message-ID: <20250323122949.551203678@goodmis.org>
User-Agent: quilt/0.68
Date: Sun, 23 Mar 2025 08:29:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Huang Shijie <shijie@os.amperecomputing.com>
Subject: [for-next][PATCH 03/10] tracepoint: Print the function symbol when tracepoint_debug is set
References: <20250323122933.407277911@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Huang Shijie <shijie@os.amperecomputing.com>

When tracepoint_debug is set, we may get the output in kernel log:
     [  380.013843] Probe 0 : 00000000f0d68cda

It is not readable, so change to print the function symbol.
After this patch, the output may becomes:
     [   55.225555] Probe 0 : perf_trace_sched_wakeup_template+0x0/0x20

Link: https://lore.kernel.org/20250307033858.4134-1-shijie@os.amperecomputing.com
Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/tracepoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 1848ce7e2976..62719d2941c9 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -127,7 +127,7 @@ static void debug_print_probes(struct tracepoint_func *funcs)
 		return;
 
 	for (i = 0; funcs[i].func; i++)
-		printk(KERN_DEBUG "Probe %d : %p\n", i, funcs[i].func);
+		printk(KERN_DEBUG "Probe %d : %pSb\n", i, funcs[i].func);
 }
 
 static struct tracepoint_func *
-- 
2.47.2



