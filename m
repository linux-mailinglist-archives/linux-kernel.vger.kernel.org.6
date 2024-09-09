Return-Path: <linux-kernel+bounces-322040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB59D972340
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 842D22855B9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70E7189903;
	Mon,  9 Sep 2024 20:08:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D751F95E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 20:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725912508; cv=none; b=RrIYvQB/ZuPEKZHT00JqPOtPQzliHqhdNEnx/SLROtB+Gj+6UJ03KFUKTJKckwxQN0gp0VjiX6rgkFrNQXkFBMDmGitBLyvC2Nr3GunzyuPqx1hXn3N4ARxUj7SS0y7YzYB/OJYLisFQA1pbYx++TKyNf9i96dUOTCYmek/JJ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725912508; c=relaxed/simple;
	bh=0nlGwDo/5yCYj/fY28XPyPPzEjACYJ5PsHX6WB+6Dq8=;
	h=Message-ID:Date:From:To:Cc:Subject; b=Vf4yvWbwE1yVRB97sKX7tVhaEFBmG34DPpJLOzEpcRuU1DEe+BYGg6ZBr83SdLxIxGu8vgWbBWrnNHTVdOSqbjE3mX78tR7dYDTspf7EeXTITSeQrobXLj2sUG8vbOtFxrf97g+pc1edLFEsED/Uol/s/C22tJsmIQ2E6pemwys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B300C4CECB;
	Mon,  9 Sep 2024 20:08:28 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1snkgV-000000009q1-3grM;
	Mon, 09 Sep 2024 16:08:27 -0400
Message-ID: <20240909200747.898018585@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 09 Sep 2024 16:07:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/2] tracing: tracing: A couple more fixes for 6.11 [ take 2 ]
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

Head SHA1: 4e378158e5c15bd237a6ff44b7abb9184d61208c


Andy Shevchenko (1):
      tracing: Drop unused helper function to fix the build

Steven Rostedt (1):
      tracing/osnoise: Fix build when timerlat is not enabled

----
 kernel/trace/trace.c         |  4 ----
 kernel/trace/trace_osnoise.c | 10 +++++-----
 2 files changed, 5 insertions(+), 9 deletions(-)

