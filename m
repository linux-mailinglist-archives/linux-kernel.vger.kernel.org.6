Return-Path: <linux-kernel+bounces-322025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03AF972303
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 21:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C450285155
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875DB189B98;
	Mon,  9 Sep 2024 19:50:54 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B9E18C31
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725911454; cv=none; b=kvuKaSgNrQ6nB+TDMg0upLOyKFrv9/DCzjAGxbSyZ0LbLr9k9DB0hgfcbPM6VA1opWeY+vYZRP/WMixhtJ3INLtJmvc2LqFNX/rZ/I/F3FUcbpaYgqq9TQ3gqi7GTnB43aOlJteFxmGh2l95CsJoPZ3fw0Vfh42orFeEzkhZ0t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725911454; c=relaxed/simple;
	bh=GRp8q/3HQ3vkq3VSpuKIiSsQOrS0hrSgqHi/aQjwbXw=;
	h=Message-ID:Date:From:To:Cc:Subject; b=KogtxWUoM7SyNDj4FW26R/zHZUdUTpp89m/aYKpLKZYtJOM4rFfabx3mWj8xFfYx/N+0OsRwk1G+SQBgsiZWEZMTsCmiQrSRW7Dwhj6zpfWaOQlJdzRBpbNqG9Ix1d5XfEJ83lfGkfPBmMKh6akuxulrRv4UI3yJVOa/ODBFW9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3FDC4CEC5;
	Mon,  9 Sep 2024 19:50:53 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1snkPV-000000009W4-1OQ7;
	Mon, 09 Sep 2024 15:50:53 -0400
Message-ID: <20240909195035.533786334@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 09 Sep 2024 15:50:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/2] tracing: A couple more fixes for 6.11
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


More tracing fixes for 6.11:

- Move declaration of interface_lock outside of CONFIG_TIMERLAT_TRACER

  The fix to some locking races moved the declaration of the
  interface_lock up in the file, but also moved it into the
  CONFIG_TIMERLAT_TRACER #ifdef block, breaking the build when
  that wasn't set. Move it further up and out of that #ifdef block.

- Remove unused function run_tracer_selftest() stub

  When CONFIG_FTRACE_STARTUP_TEST is not set the stub function
  run_tracer_selftest() is not used and clang is warning about it.
  Remove the function stub as it is not needed.

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/urgent

Head SHA1: eac6c0f8f297db0ee4434d076faf45a594c42b42


Andy Shevchenko (1):
      tracing: Drop unused helper function to fix the build

Steven Rostedt (1):
      tracing/osnoise: Fix build when timerlat is not enabled

----
 kernel/trace/trace.c         |  4 ----
 kernel/trace/trace_osnoise.c | 10 +++++-----
 2 files changed, 5 insertions(+), 9 deletions(-)

