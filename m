Return-Path: <linux-kernel+bounces-302958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0F6960587
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB9BB281A66
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A279219D8A4;
	Tue, 27 Aug 2024 09:27:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3636F19D09C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724750824; cv=none; b=J7FoqNb8u58ppegYG6NhGBEuKVRiLqnLogOTZvGiso30UTvMEZMcDeSpX3PLpa9tEXvn9KJDv6qs9Rxt3iU2OyeydV/dW03vlRylrrL2pwnrjsLB5zV8Ko07lPke63gvJ76d8x3yr3/+J0lDGuPdbpASzBwVHyoDmCQirNoVnG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724750824; c=relaxed/simple;
	bh=tvN/uNR2QEGS77TEOIwM2CA+r3hhgrfmQyXSGzqM5Nc=;
	h=Message-ID:Date:From:To:Cc:Subject; b=redS2+1Xr+rXu4Rvc1VJhlRTB2llIy0lTsH6X4/qEG5Ofv+f8iJu8kTz9AzOOEeVLkJEwmSUl8nUIkmKmdIL2+E81Mh3znC4ErReUyGoTvRxLVQ3b2bMoZy4fO9S6BzBy0ePlnxPbLC4YVFSfgrf0RxCdwJhsFPzTcdyZnzytz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F8CC8B7B4;
	Tue, 27 Aug 2024 09:27:03 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1sisUM-00000004SKH-0iNQ;
	Tue, 27 Aug 2024 05:27:46 -0400
Message-ID: <20240827092716.515115830@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 27 Aug 2024 05:27:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/8] ring-buffer: Updates for 6.12
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ring-buffer/for-next

Head SHA1: 2fcd5aff92aab479a9a89cfce2dbc9c6a9455b4f


Steven Rostedt (7):
      ring-buffer: Don't reset persistent ring-buffer meta saved addresses
      ring-buffer: Add magic and struct size to boot up meta data
      tracing: Add "traceoff" flag to boot time tracing instances
      tracing: Allow trace_printk() to go to other instance buffers
      tracing: Have trace_printk not use binary prints if boot buffer
      tracing: Add option to set an instance to be the trace_printk destination
      tracing/Documentation: Start a document on how to debug with tracing

Vincent Donnefort (1):
      ring-buffer: Align meta-page to sub-buffers for improved TLB usage

----
 Documentation/admin-guide/kernel-parameters.txt |  23 ++++
 Documentation/trace/debugging.rst               | 159 ++++++++++++++++++++++++
 Documentation/trace/ftrace.rst                  |  12 ++
 kernel/trace/ring_buffer.c                      |  79 ++++++++----
 kernel/trace/trace.c                            | 127 ++++++++++++++++---
 kernel/trace/trace.h                            |   4 +-
 kernel/trace/trace_output.c                     |   5 +-
 tools/testing/selftests/ring-buffer/map_test.c  |  14 +++
 8 files changed, 385 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/trace/debugging.rst

