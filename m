Return-Path: <linux-kernel+bounces-560444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A24EA6044E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C90216817C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA92C1F7075;
	Thu, 13 Mar 2025 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OeQLx8/g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCEC1547F5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 22:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741904988; cv=none; b=hDpjVrsp3xesAuZJpfIjJnUI4BqslWy0TKe+z9HCO8cv17oDPkHRrtc1fmReemCQUVsA4gzzm3bJ7SFg2O8YqdyVcQqMTdjjdhA32ZOFXTaC8w6PvyIP1GGig7f48GWAzZ75WcAIjKSzitKVE+rcv5snjMeDkThaHvEo5l9srT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741904988; c=relaxed/simple;
	bh=W4l0NeKdCYYSdf64Mfd1QqztrVo99rDTgWV39DTBURs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NY+BFAE0PZiPKjgMK7IjGahlAIiQW8jrC2/a/rrRdbo9orYbwRpKRHH2VkRgMFWItRNsvwA9P47hR+Aya6pp6q57OklXYcE5N9e3BcK9QOd5gPkzfPTTY20xQlIhy0JdmsskgUO8YGvCNRDMcyr/NlpGdKW278vyVmuai2u1KKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OeQLx8/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111E5C4CEDD;
	Thu, 13 Mar 2025 22:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741904987;
	bh=W4l0NeKdCYYSdf64Mfd1QqztrVo99rDTgWV39DTBURs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OeQLx8/gl7MdE+T3Mf+eqjtpNhvro4bzvv2OAkYyQ1ZN3DcQ/co1ZiooNMNDg1w7d
	 v3cS+LctVNtftw0VXmf5Ge6VU6yOfwLXZTJjRMns56jMA6pQU6LHPb39cSqiiyHmqn
	 DWeeJxYAeZsrrDSkWwSgDt3+0UwX+wZ5FBBfYkLw=
Date: Thu, 13 Mar 2025 15:29:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Waiman
 Long <longman@redhat.com>, Joel Granados <joel.granados@kernel.org>, Anna
 Schumaker <anna.schumaker@oracle.com>, Lance Yang <ioworker0@gmail.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, Yongliang Gao
 <leonylgao@tencent.com>, Steven Rostedt <rostedt@goodmis.org>, Tomasz Figa
 <tfiga@chromium.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
Message-Id: <20250313152946.69f209c76a6f479c46584ef0@linux-foundation.org>
In-Reply-To: <174046695384.2194069.16796289525958195643.stgit@mhiramat.tok.corp.google.com>
References: <174046694331.2194069.15472952050240807469.stgit@mhiramat.tok.corp.google.com>
	<174046695384.2194069.16796289525958195643.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Feb 2025 16:02:34 +0900 "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> The "hung_task" shows a long-time uninterruptible slept task, but most
> often, it's blocked on a mutex acquired by another task. Without
> dumping such a task, investigating the root cause of the hung task
> problem is very difficult.
> 
> This introduce task_struct::blocker_mutex to point the mutex lock
> which this task is waiting for. Since the mutex has "owner"
> information, we can find the owner task and dump it with hung tasks.
> 
> Note: the owner can be changed while dumping the owner task, so
> this is "likely" the owner of the mutex.
> 
> With this change, the hung task shows blocker task's info like below;

Seems useful.

> ...
>
> +static void debug_show_blocker(struct task_struct *task)
> +{
>
> ...
>
> +}
> +#else
> +#define debug_show_blocker(t)	do {} while (0)
> +#endif
> +

Nit. It's unpleasing to have one side a C function and the other a
macro.  Plus C functions are simply better - only use a macro if one
has to!

So,

--- a/kernel/hung_task.c~hung_task-show-the-blocker-task-if-the-task-is-hung-on-mutex-fix
+++ a/kernel/hung_task.c
@@ -125,7 +125,9 @@ static void debug_show_blocker(struct ta
 	}
 }
 #else
-#define debug_show_blocker(t)	do {} while (0)
+static inline void debug_show_blocker(struct task_struct *task)
+{
+}
 #endif
 
 static void check_hung_task(struct task_struct *t, unsigned long timeout)
_


