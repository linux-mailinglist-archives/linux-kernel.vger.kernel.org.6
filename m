Return-Path: <linux-kernel+bounces-538822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 685ADA49D72
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D3561893927
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFC826FD9F;
	Fri, 28 Feb 2025 15:29:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250A31EF376
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756573; cv=none; b=EImN6CsjhIkt7m/F4wCQ0amyXueHHmOOqgFBe/+LgfLTaU6nShxZGjtfgzxd7YBl158wqT6MJ1S+LR4x95qOssGrQuYamS8OUL65q1pNtoyOat2BTqkQ9yccd1gqeZrZXbXR+ImVxkb1C6OMUwtk4p7mJ0Adnx4HzEW+/JId1FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756573; c=relaxed/simple;
	bh=nZ28q8kxXuMmnIjqnLFj3UujY58CeeoE9W/SgAXo56s=;
	h=Message-ID:Date:From:To:Cc:Subject; b=VtdqMqEBuWKoffTq5ZGJaHfjg5TOWAIXg+x+U+6xK5nuW85LYkjPsmhR/rCa+/H+tJcPvNbQNmSR8sU5tn+YuBuk9Su6rf6EJ+B4Ay0Qa9zsti7q+Pl6/l5yt1OQLILuMimaz9lERYr1WSw0b4MZOTzXKQQufsYo1FJGjUvqZV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F7BC4CEE2;
	Fri, 28 Feb 2025 15:29:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1to2Je-0000000ABgg-0zLz;
	Fri, 28 Feb 2025 10:30:18 -0500
Message-ID: <20250228153003.725613767@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 28 Feb 2025 10:30:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/3] tracing: Fixes for v6.14
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


Tracing fixes for v6.14:

- Fix crash from bad histogram entry

  An error path in the histogram creation could leave an entry
  in a link list that gets freed. Then when a new entry is added
  it can cause a u-a-f bug. This is fixed by restructuring the code
  so that the histogram is consistent on failure and everything is
  cleaned up appropriately.

- Fix fprobe self test

  The fprobe self test relies on no function being attached by ftrace.
  BPF programs can attach to functions via ftrace and systemd now
  does so. This causes those functions to appear in the enabled_functions
  list which holds all functions attached by ftrace. The selftest also
  uses that file to see if functions are being connected correctly.
  It counts the functions in the file, but if there's already functions
  in the file, it fails. Instead, add the number of functions in the file
  at the start of the test to all the calculations during the test.

- Fix potential division by zero of the function profiler stddev

  The calculated divisor that calculates the standard deviation of
  the function times can overflow. If the overflow happens to land
  on zero, that can cause a division by zero. Check for zero from
  the calculation before doing the division.

  TODO: Catch when it ever overflows and report it accordingly.
        For now, just prevent the system from crashing.

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/fixes

Head SHA1: a1a7eb89ca0b89dc1c326eeee2596f263291aca3


Heiko Carstens (1):
      selftests/ftrace: Let fprobe test consider already enabled functions

Nikolay Kuratov (1):
      ftrace: Avoid potential division by zero in function_stat_show()

Steven Rostedt (1):
      tracing: Fix bad hist from corrupting named_triggers list

----
 kernel/trace/ftrace.c                              | 27 +++++++++----------
 kernel/trace/trace_events_hist.c                   | 30 +++++++++++-----------
 .../ftrace/test.d/dynevent/add_remove_fprobe.tc    | 18 ++++++++-----
 3 files changed, 38 insertions(+), 37 deletions(-)

