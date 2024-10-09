Return-Path: <linux-kernel+bounces-357111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF50996BB5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D90281A48
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE42194C9D;
	Wed,  9 Oct 2024 13:21:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F3218787A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480074; cv=none; b=AFpy5Ctg+eG+n0JDlCKbxIxyf1/yjSOM4UHwDpojv0dYMrii6i6n2yYUaHjrCTxYU0Rk02BW0tX8aXlMbrTocGhQHh8anecLlToH/aljc7g/POMqDLNqcfsOPb8e2NXOgcSPs0AKfvgD7UnhqqsCksJcsrkRU2Pavh+LsT6u7Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480074; c=relaxed/simple;
	bh=3Cr7EKzldQ3CMuhyq8frFbcLS6Nfov75OYQCVau/llc=;
	h=Message-ID:Date:From:To:Cc:Subject; b=UpyPhtLU/772EHULziy0sBGiBQgJpA/mnXbLWdU9bkTwHrNwc9vceawYcU0AGvRM5yqaMir1OvncHvnl2sHqJ1M4HnjDBNK+6pgM/FZmyLacA3gsCzQYUUGWi5jRqKpW1mQUXYCHxaEhn9whLRdQ7RtyhdLozIC2URZzU3Oi8TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CCBC4CEC5;
	Wed,  9 Oct 2024 13:21:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1syWcx-0000000175L-2dhX;
	Wed, 09 Oct 2024 09:21:19 -0400
Message-ID: <20241009132104.470687911@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 09 Oct 2024 09:21:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/6] tracing: Updates for 6.13
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: e53244e2c8931f9e80c1841293aea86ef8ad32a3


Josh Poimboeuf (1):
      tracepoints: Use new static branch API

Justin Stitt (1):
      tracing/branch-profiler: Replace deprecated strncpy with strscpy

Li Chen (1):
      ftrace: Use this_cpu_ptr() instead of per_cpu_ptr(smp_processor_id())

Steven Rostedt (2):
      tracing: Remove definition of trace_*_rcuidle()
      tracepoint: Remove SRCU protection

Zheng Yejian (1):
      tracing: Remove TRACE_EVENT_FL_FILTERED logic

----
 include/linux/trace_events.h         |  4 ---
 include/linux/tracepoint-defs.h      |  4 +--
 include/linux/tracepoint.h           | 60 +++---------------------------------
 include/trace/events/preemptirq.h    |  8 -----
 kernel/trace/trace.c                 | 44 ++++++--------------------
 kernel/trace/trace.h                 |  4 ---
 kernel/trace/trace_branch.c          | 10 ++----
 kernel/trace/trace_events.c          |  2 --
 kernel/trace/trace_events_hist.c     |  2 +-
 kernel/trace/trace_events_user.c     |  4 +--
 kernel/trace/trace_functions.c       | 10 ++----
 kernel/trace/trace_functions_graph.c |  8 ++---
 kernel/trace/trace_hwlat.c           |  4 +--
 kernel/trace/trace_mmiotrace.c       |  8 ++---
 kernel/trace/trace_osnoise.c         | 12 ++------
 kernel/trace/trace_preemptirq.c      | 26 ++++------------
 kernel/trace/trace_sched_wakeup.c    |  8 ++---
 kernel/tracepoint.c                  | 55 ++-------------------------------
 scripts/tags.sh                      |  2 --
 19 files changed, 44 insertions(+), 231 deletions(-)

