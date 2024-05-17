Return-Path: <linux-kernel+bounces-182508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97C18C8C27
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 20:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7381C2263B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 18:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8293B12FF6D;
	Fri, 17 May 2024 18:12:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2F21FC8
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 18:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715969540; cv=none; b=p5dRNVj3pBXLwMNR6y8MPwEDGYq0qh1trB4nnMrz8Ea5a7Br/kDhvz7Uq4dZDhofJaK/cQzZnMMBk+tuAvunZvTG3DqH5UgyLY1ZMauv5gdJKJHcf5yj8PpyXiRY83oa89VTJRvSiJDwIAhEFV3pagbZ4l5GBfursK427qvbJiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715969540; c=relaxed/simple;
	bh=y/2x6b/ornAg7rdI250+1KgKVyHjQhNSZkRYqHut4XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mnZtk6yEbLH0+3NS8IU0w9P2Xn7fcuK0kObOhdh6OtOwfnQoXVf1FMIn3TofQ8LTeogiafF9NF5Hc44lILwRfnjsjSh4L0ea2DvKdAzRdWo93oIr9D9LAm3beaNdOL2fOe4QZJgRYmln+U7h/pfTPsNlLTcTIaxtXjtrQTKe4Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2DAC2BD10;
	Fri, 17 May 2024 18:12:18 +0000 (UTC)
Date: Fri, 17 May 2024 14:12:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Daniel Bristot de Oliveira <bristot@kernel.org>,
 John Kacur <jkacur@redhat.com>
Subject: [GIT PULL] tracing/tools: RTLA updates for 6.10
Message-ID: <20240517141247.0ec1242a@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus,

Specific for timerlat:

- Improves the output of timerlat top by adding a missing \n,
  and by avoiding printing color-formatting characters where
  they are translated to regular characters.

- Improves timerlat auto-analysis output by replacing '\t'
  with spaces to avoid copy-and-paste issues when reporting
  problems.

- For timerlat, make the user-space (-u) option the default,
  as it is the most complete test. Add a -k option to use
  the in-kernel workload.

- On timerlat top and hist, add a summary with the overall
  results. For instance, the minimum value for all CPUs,
  the overall average and the maximum value from all CPUs.

- timerlat hist was printing initial values (i.e., 0 as max,
  and ~0 as min) if the trace stopped before the first Ret-User
  event. This problem was fixed by printing the "       - "
  no value string to the output if that was the case.

For all RTLA tools:

- Add a --warm-up <seconds> option, allowing the workload to
  run for <seconds> before starting to collect results.

- Add a --trace-buffer-size option, allowing the user to set
  the tracing buffer size for -t option. This option is mainly
  useful for reducing the trace file. Now rtla depends on
  libtracefs >= 1.6.

- Fix the -t [trace_file] parsing, now it does not require
  the '=' before the option parameter, and better handles the
  multiple ways a user can pass the trace_file.txt


Please pull the latest trace-tools-v6.10 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-tools-v6.10

Tag SHA1: 2e2ffd01fe2dd06c66621bf7404beb31beb50ea1
Head SHA1: 59c22f70b2951d81de410d477ae536ba951b4f37


Daniel Bristot de Oliveira (8):
      rtla/timerlat: Simplify "no value" printing on top
      rtla/auto-analysis: Replace \t with spaces
      rtla/timerlat: Use pretty formatting only on interactive tty
      rtla/timerlat: Add a summary for top mode
      rtla/timerlat: Add a summary for hist mode
      rtla: Add the --warm-up option
      rtla/timerlat: Make user-space threads the default
      rtla: Add --trace-buffer-size option

John Kacur (3):
      rtla/timerlat: Fix histogram report when a cpu count is 0
      rtla: Fix -t\--trace[=file]
      rtla: Documentation: Fix -t, --trace

----
 Documentation/tools/rtla/common_options.rst        |  11 +-
 .../tools/rtla/common_osnoise_options.rst          |   4 +
 .../tools/rtla/common_timerlat_options.rst         |  10 +-
 tools/tracing/rtla/Makefile.config                 |   2 +-
 tools/tracing/rtla/src/osnoise_hist.c              |  55 +++-
 tools/tracing/rtla/src/osnoise_top.c               |  55 +++-
 tools/tracing/rtla/src/timerlat_aa.c               | 109 ++++----
 tools/tracing/rtla/src/timerlat_hist.c             | 294 ++++++++++++++++++---
 tools/tracing/rtla/src/timerlat_top.c              | 250 +++++++++++++++---
 tools/tracing/rtla/src/trace.c                     |  15 ++
 tools/tracing/rtla/src/trace.h                     |   1 +
 11 files changed, 653 insertions(+), 153 deletions(-)
---------------------------

