Return-Path: <linux-kernel+bounces-381491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFE99AFFE0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5B11C209DF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A4A1DE3A7;
	Fri, 25 Oct 2024 10:19:00 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81AC1D90DD
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729851539; cv=none; b=uhwBkd5qTw5gTgBALGIgXJO+/wuvl7aMd/WAubWtNJLLtNWIpBhCqq6Gnn5T78oBKWNr/L2i8EqB7YjisV3A2GMnhTyJJmMH9jMGi5ULlVA/93fve3dz7bk7Wvn/EkrMrhjrboRIJTHCo4A/IBoGYX3ze4ECC7roskpCFgogvc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729851539; c=relaxed/simple;
	bh=IgKDcTC6KaQz4yryWEWXpMnpSN4/94FCEA8uwygxHnA=;
	h=Message-ID:Date:From:To:Cc:Subject; b=u5XXFG+sss8UihsB05MFtcBBVEauf1whBbaR6dzFvG44Hsy5+8dSw04owxcP/w5HRaiiRzZfIRoiZ5bTX2/Vb92r9n357HGQwTruTaB5v31l5J+5y/EtetkS8fHOtTKuQqpGiIM9IRAHmra2pPlYwmwTuqfvaiN+gavM9k4HRuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DC6C4CECC;
	Fri, 25 Oct 2024 10:18:59 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t4HPx-00000004rep-22fV;
	Fri, 25 Oct 2024 06:19:41 -0400
Message-ID: <20241025101910.054222333@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 25 Oct 2024 06:19:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/2] fgraph: Fixes for 6.12
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


Fixes for function graph:

- Fix missing mutex unlock in error path of register_ftrace_graph()

  A previous fix added a return on an error path and forgot to unlock the
  mutex. Instead of dealing with error paths, use guard(mutex) as the mutex
  is just released at the exit of the function anyway. Other functions
  in this file should be updated with this, but that's a cleanup and not
  a fix.

- Change cpuhp setup name to be consistent with other cpuhp states

  The same fix that the above patch fixes added a cpuhp_setup_state() call
  with the name of "fgraph_idle_init". I was informed that it should instead
  be something like: "fgraph:online". Update that too.

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ftrace/fixes

Head SHA1: a574e7f80e86c740e241c762923f50077b2c2a30


Li Huafei (1):
      fgraph: Fix missing unlock in register_ftrace_graph()

Steven Rostedt (1):
      fgraph: Change the name of cpuhp state to "fgraph:online"

----
 kernel/trace/fgraph.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

