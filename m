Return-Path: <linux-kernel+bounces-352074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2989919CF
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 21:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28101F21ECC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 19:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C8E15AAC1;
	Sat,  5 Oct 2024 19:12:10 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC2F4E1CA
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728155530; cv=none; b=MorfaQaCRNRKxaOCriD+r71xATGkeOGdAB5xp/j2UFnBN+vA1y5cd8cDAi2oGiGp6niPB8ZIJiKF7AUSWbtr0m5DubwNzMvNP1HJirP76V4Shdun/Xvaqx4o5R6VyIF82iD02EC3qy3f6Pxd4AY83beSaMkKVJYadnFXMO5UWZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728155530; c=relaxed/simple;
	bh=gQRzpYjNCzFyfYQPD+AkRRjCkOa26TkQddJW9U4ZfTk=;
	h=Message-ID:Date:From:To:Cc:Subject; b=O64jI/7mdcnbSWc6ksIN9dHmcKHSIdjqquoIH3+fjOcB/nMP15baGgk0bHp9TjaU9D3z9Yy8r+1rJ4ac/Wtm3Wsact0LZhaTEAAm3Wdw6dndar0KBNRtnpiKUpgWYNf3I9smKDRpitJGM5HJ7P5sDWegRXsuWAk6Oevo0Ubto1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3ACDC4CECF;
	Sat,  5 Oct 2024 19:12:09 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1sxADE-00000005N7K-1U8g;
	Sat, 05 Oct 2024 15:13:08 -0400
Message-ID: <20241005191252.411117350@goodmis.org>
User-Agent: quilt/0.68
Date: Sat, 05 Oct 2024 15:12:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/2] ftrace: Updates for 6.13
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ftrace/for-next

Head SHA1: 474ec3e849686a02d00c5bd7a80c3042505b66bb


Donglin Peng (1):
      function_graph: Support recording and printing the function return address

Oleg Nesterov (1):
      function_graph: Remove unnecessary initialization in ftrace_graph_ret_addr()

----
 include/linux/ftrace.h                             |  27 ++-
 kernel/trace/Kconfig                               |  10 +
 kernel/trace/fgraph.c                              |  24 ++-
 kernel/trace/ftrace.c                              |   3 +-
 kernel/trace/trace.h                               |  11 +-
 kernel/trace/trace_entries.h                       |  29 ++-
 kernel/trace/trace_functions_graph.c               | 216 ++++++++++++++++-----
 kernel/trace/trace_irqsoff.c                       |   3 +-
 kernel/trace/trace_sched_wakeup.c                  |   3 +-
 kernel/trace/trace_selftest.c                      |   9 +-
 .../ftrace/test.d/ftrace/fgraph-retval.tc          |   2 +-
 11 files changed, 275 insertions(+), 62 deletions(-)

