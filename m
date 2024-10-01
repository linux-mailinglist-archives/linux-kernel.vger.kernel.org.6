Return-Path: <linux-kernel+bounces-346703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D72198C7B6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 23:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B341F23B07
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845A31CEAD0;
	Tue,  1 Oct 2024 21:42:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EA619F41B
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 21:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727818937; cv=none; b=j4uPdGNLVbPYMcqMi9dNZ7C7e5o9dusqJnyvSwnVWpCdFi3+VbyFOgEJwmzOo46ICpAQL2rq5NfKix8y0toR99jpkykt5d4kxWYlqr28W73dWjixDwIVmygTts0CUhNQBi2D/rI3Hi23wQEGuW9Bg0tlKEPs+nBbps+kqlm8sl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727818937; c=relaxed/simple;
	bh=Ynd+tsPq/fs069g8TcRzdpif+JGCfIdsKNvcS+u780Q=;
	h=Message-ID:Date:From:To:Cc:Subject; b=cGYXSwHl+GR8Ph0LN+22jgRhBJRT1qmroO/p9rm7KS1js66ugPF0jbxQSFd2+2RcnXHWw8jzkiYH4gC1aB8Ja3HRljKDd8JgFimgiYk90LBwW5FsAPPoR5S7ZWO59+Rv6DWLgu09ACJYkZUdUwQeLWzxc3FL5UkXqYoz0bB6qGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C704EC4CEC6;
	Tue,  1 Oct 2024 21:42:16 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1svkeA-00000004cs6-3qCZ;
	Tue, 01 Oct 2024 17:43:06 -0400
Message-ID: <20241001214241.688116616@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 01 Oct 2024 17:42:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/5] tracing/ftrace: Updates for 6.13
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ftrace/for-next

Head SHA1: f1f36e22bee967db5e812a65e24389e54c46f3c2


Masami Hiramatsu (Google) (2):
      tracing: Fix function timing profiler to initialize hashtable
      tracing: Add a comment about ftrace_regs definition

Steven Rostedt (3):
      fgraph: Use fgraph data to store subtime for profiler
      ftrace: Use a running sleeptime instead of saving on shadow stack
      ftrace: Have calltime be saved in the fgraph storage

----
 include/linux/ftrace.h               | 31 +++++++++++--
 include/linux/sched.h                |  1 +
 kernel/trace/fgraph.c                | 85 +++++++++++++++++++++---------------
 kernel/trace/ftrace.c                | 49 +++++++++++++++------
 kernel/trace/trace.h                 |  1 +
 kernel/trace/trace_functions_graph.c | 52 +++++++++++++++++++++-
 6 files changed, 167 insertions(+), 52 deletions(-)

