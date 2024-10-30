Return-Path: <linux-kernel+bounces-388150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95259B5B48
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 06:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564152848AF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 05:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367741D14E2;
	Wed, 30 Oct 2024 05:36:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE081CFEBF
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 05:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730266572; cv=none; b=VsvdHmXLykdGmaxGHjj0uRCQ9S1Eui0AnF1KHUT3uPdPD6mm5j2OtTqzuNc1jJJ/vk3qZXC7bir7Ru9klG7v4GCLhuLlgG1Er1lkWDZDyMBP+T1+SEz3o7jUBa+LIHIvQL5FbglXz65X7IwAd1zzzat+8gV8yVpaFzAkMRxN45A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730266572; c=relaxed/simple;
	bh=C/P4YFKOxfIINPnLJNGwaI787j2YgQiojpvwktaVW/Y=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Y/U7dCGW5MYB3lCnbHCHeLHeEYtM1kchI3T7s+1QeU6K4qJndaY23dMQ024WiNJH/N/aQuYyylC9vzFOzQ8+uiwY/04IsG/7ivUoJUW416mLqltNENWX+Tb5w4jj7lf+5MhPumReMSiAsFc4DIBtL6Ky2CYbyQnuz0ZAeItXLSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473D2C4CEE9;
	Wed, 30 Oct 2024 05:36:12 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t61OD-00000005BF6-2LUc;
	Wed, 30 Oct 2024 01:37:05 -0400
Message-ID: <20241030053705.422226102@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 30 Oct 2024 01:36:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [for-next][PATCH 6/7] ftrace: Use guard to take the ftrace_lock in release_probe()
References: <20241030053650.956861738@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The ftrace_lock is held throughout the entire release_probe() function.
Use guard to simplify any exit paths.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/20241028071308.250787901@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 64997416415e..c0fabd7da5b2 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5288,7 +5288,7 @@ static void release_probe(struct ftrace_func_probe *probe)
 {
 	struct ftrace_probe_ops *probe_ops;
 
-	mutex_lock(&ftrace_lock);
+	guard(mutex)(&ftrace_lock);
 
 	WARN_ON(probe->ref <= 0);
 
@@ -5306,7 +5306,6 @@ static void release_probe(struct ftrace_func_probe *probe)
 		list_del(&probe->list);
 		kfree(probe);
 	}
-	mutex_unlock(&ftrace_lock);
 }
 
 static void acquire_probe_locked(struct ftrace_func_probe *probe)
-- 
2.45.2



