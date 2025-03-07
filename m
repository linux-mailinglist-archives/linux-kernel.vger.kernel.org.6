Return-Path: <linux-kernel+bounces-550167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D85F5A55C21
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D0E1896141
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D6649641;
	Fri,  7 Mar 2025 00:45:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBD910A1F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 00:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741308327; cv=none; b=jd54VT7e8TLO4BFJEPQRV7bVm8citqsyEEtay1NZvQy+//p986zdmnp0tFsWhGpZ8PoSC1EX23HCskhQfuNz4pcR7tWGmXCEkCW7Rgr4TI9Dl8gECOuLiPYuglgbwG4sFPwGrhANXuewaNWKjkWRxmUrVj8m9y02fkZO59cXn0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741308327; c=relaxed/simple;
	bh=oKj/CTSpC+LF4GQ5CpB3zWsuCSt2BMhTqQ3SA00fYq4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=F58lxVjXgKrCbFjVihcUK9IuACO1VSThr+sbP2lijq3/zY5IenQ+QbKTepAuuAtNOE+nU3v1wCR0mJHQb7/dRHbvERPn5SQhwFtc0tlgazu+XDTZWk1HxWJL/I/bLeHOiXtGSviKQ8si/2lUB/0d1crjWrYKiyyz+YgSWUGJf3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E0BC4CEEB;
	Fri,  7 Mar 2025 00:45:27 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tqLqA-000000005AC-3v0o;
	Thu, 06 Mar 2025 19:45:26 -0500
Message-ID: <20250307004526.790035373@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Mar 2025 19:45:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [for-next][PATCH 2/3] tracing/user_events: Slightly simplify user_seq_show()
References: <20250307004511.688485107@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

2 seq_puts() calls can be merged.

It saves a few lines of code and a few cycles, should it matter.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/845caa94b74cea8d72c158bf1994fe250beee28c.1739979791.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 3effc6fce20e..af42aaa3d172 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -2793,11 +2793,8 @@ static int user_seq_show(struct seq_file *m, void *p)
 
 		seq_printf(m, "%s", EVENT_TP_NAME(user));
 
-		if (status != 0)
-			seq_puts(m, " #");
-
 		if (status != 0) {
-			seq_puts(m, " Used by");
+			seq_puts(m, " # Used by");
 			if (status & EVENT_STATUS_FTRACE)
 				seq_puts(m, " ftrace");
 			if (status & EVENT_STATUS_PERF)
-- 
2.47.2



