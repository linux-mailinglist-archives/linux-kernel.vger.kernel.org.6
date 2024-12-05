Return-Path: <linux-kernel+bounces-432515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613409E4C60
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE6E282EBA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 02:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C1218BC1D;
	Thu,  5 Dec 2024 02:41:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A42A187848
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 02:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733366471; cv=none; b=niuNvo4xkECfOEmaMgVOqHtL/KgxxBHP5ey6GpRlfgO1KoQ1NqTNhijnOZoabEbp/UnXXYpa8musonWW2g3BvzGiGdSVwSVpc3H7OUKJLMooxeDAovzlQc/gaok7dzNpVpVDB1RZQ5bp8hOWy3OT1eAKTj4FP5JF+BnuJ7B0zXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733366471; c=relaxed/simple;
	bh=gaL6OGmQieL0w80rLmqF+9UrTb2um1wVwxod3jZiypg=;
	h=Message-ID:Date:From:To:Cc:Subject; b=hPUjyROw9yhjX8gMZfgEPEq8RVTha37OiNP0dF8id7MkB+TtcITVxlA736mkabt7Puh8ZrMGuV1R/dZLIdXsJyEVbN9h4mVqBt0pw9hCnDRLWfh2kMhLKdBFqNSrDP/RtbyA+YdKj+w+sInhByNCDXR2+4v9ro/0CiF0QDJEBJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E431C4CECD;
	Thu,  5 Dec 2024 02:41:11 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tJ1nn-000000022eG-1eiB;
	Wed, 04 Dec 2024 21:41:15 -0500
Message-ID: <20241205023552.609451828@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 04 Dec 2024 21:35:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/2] tracing: A couple of fixes for 6.13
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tracing fixes for v6.13:

- Fix trace histogram sort function cmp_entries_dup()

  The sort function cmp_entries_dup() returns either 1 or 0, and not
  -1 if parameter "a" is less than "b" by memcmp().

- Fix archs that call trace_hardirqs_off() without RCU watching

  Both x86 and arm64 no longer call any tracepoints with RCU not
  watching. It was assumed that it was safe to get rid of
  trace_*_rcuidle() version of the tracepoint calls. This was needed
  to get rid of the SRCU protection and be able to implement features
  like faultable traceponits and add rust tracepoints.

  Unfortunately, there were a few architectures that still relied on
  that logic. There's only one file that has tracepoints that are
  called without RCU watching. Add macro logic around the tracepoints
  for architectures that do not have CONFIG_ARCH_WANTS_NO_INSTR defined
  will check if the code is in the idle path (the only place RCU isn't
  watching), and enable RCU around calling the tracepoint, but only
  do it if the tracepoint is enabled.

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/fixes

Head SHA1: 2f88ccdee3326a6197573623cd31947391eb5579


Kuan-Wei Chiu (1):
      tracing: Fix cmp_entries_dup() to respect sort() comparison rules

Steven Rostedt (1):
      tracing: Fix archs that still call tracepoints without RCU watching

----
 kernel/trace/trace_preemptirq.c | 43 +++++++++++++++++++++++++++++++++++------
 kernel/trace/tracing_map.c      |  6 +-----
 2 files changed, 38 insertions(+), 11 deletions(-)

