Return-Path: <linux-kernel+bounces-178921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 743138C597B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4494E1C21462
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E437F17F376;
	Tue, 14 May 2024 16:14:57 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEF45B1FB
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715703297; cv=none; b=Tc3qvo4a1oSIzkssXQKOOdhBwHFoPv4Ovh0NppIO05xmtTyTjufACaeTc3tSXQQ8ZaRV6/IF1ShobDZ4VAGvy/+mhmS3UHl+dnkui77qxIeFAXEu2gIhb85eo42qMO16pmpZqppkIFjWUcTfdKsSO0lFppmFRqw/DKSoiXgmx0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715703297; c=relaxed/simple;
	bh=OGpJLE/d7lmQD/l1DIBMPMRQRRcls6gFoJ4WHiI00HA=;
	h=Message-ID:Date:From:To:Cc:Subject; b=owlQShWNpjO+CtkYVh9ay/CVsc+BwC8EdZtM/xa67xwB7RaAoqQrn8l3P5VzZkVJU0YV4YZ6XNqau2sD+VzH1Cd+ZIsc9EytWioeXgTWZ7D/gQjguyxOVJu/nzCUezcE2yf56HxEPJRD95hq05eHMyXP+YMxykNrri1dpzcc89s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597EDC2BD10;
	Tue, 14 May 2024 16:14:57 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s6uoD-00000003t2U-4497;
	Tue, 14 May 2024 12:15:21 -0400
Message-ID: <20240514161438.134250861@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 14 May 2024 12:14:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/7] tracing: Various clean ups and fixes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is some clean ups and fixes for this merge window.


Dr. David Alan Gilbert (2):
      ftrace: Remove unused list 'ftrace_direct_funcs'
      ftrace: Remove unused global 'ftrace_direct_func_count'

Hao Ge (1):
      eventfs: Fix a possible null pointer dereference in eventfs_find_events()

Paul E. McKenney (1):
      ftrace: Use asynchronous grace period for register_ftrace_direct()

Thorsten Blum (1):
      tracing: Improve benchmark test performance by using do_div()

Yuran Pereira (1):
      ftrace: Replaces simple_strtoul in ftrace

Zheng Yejian (1):
      ftrace: Fix possible use-after-free issue in ftrace_location()

----
 fs/tracefs/event_inode.c       |  7 ++---
 include/linux/ftrace.h         |  3 --
 kernel/trace/fgraph.c          | 11 -------
 kernel/trace/ftrace.c          | 68 ++++++++++++++++++++++--------------------
 kernel/trace/trace_benchmark.c |  2 +-
 5 files changed, 39 insertions(+), 52 deletions(-)

