Return-Path: <linux-kernel+bounces-549201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D2AA54EFA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79D6C3B348A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6EF211A19;
	Thu,  6 Mar 2025 15:26:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC562116FB
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741274777; cv=none; b=lacJGdTz5Jm3NYowdi953WYPUm2o/PyNfPDMBYCAT/Q7o8JLjBGLsWjiVGrDgvbgxKPb9EWT0AWSgYlwpS4y3HW2+iK+8c9emtUpxPEu9SH47MXXpa6tOTOzuUbpsAP86F1pBPOAKu1AvjDgpu4sPxXDNDsFWw+mCCUerJyYj9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741274777; c=relaxed/simple;
	bh=j1KvYqPMO88Wlm6ZyB/cSGmgGTYcPy27QLi0G7r2utQ=;
	h=Message-ID:Date:From:To:Cc:Subject; b=EusVw9MT+tp8WGILoHz+W8lofsnFxwtC1HEbWQ5Sx5RADuaSvt5kZnTUV4QnA1mgE+q1cUP8o15aX4C0QNkO/3SQ/wWFwbQ9FYapH970yw/jKu/kIUpNBOXIO1U49SrLNo5veuXy0iRrAiKL9qE3ZXkKa8ZGCHXqwu5YroJ2UbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72C9C4CEE0;
	Thu,  6 Mar 2025 15:26:16 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tqD74-00000000MaL-0rE1;
	Thu, 06 Mar 2025 10:26:18 -0500
Message-ID: <20250306152548.763044302@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Mar 2025 10:25:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/10] ring-buffer: Updates for v6.15
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ring-buffer/for-next

Head SHA1: c6a1b7c2e58d048ed8b7b2f331fef42b52376336


Feng Yang (1):
      ring-buffer: Fix bytes_dropped calculation issue

Steven Rostedt (9):
      ring-buffer: Allow persistent ring buffers to be mmapped
      ring-buffer: Use kaslr address instead of text delta
      ring-buffer: Add buffer meta data for persistent ring buffer
      ring-buffer: Add ring_buffer_meta_scratch()
      tracing: Have persistent trace instances save KASLR offset
      module: Add module_for_each_mod() function
      tracing: Have persistent trace instances save module addresses
      tracing: Show module names and addresses of last boot
      tracing: Update modules to persistent instances when loaded

----
 include/linux/module.h      |   6 +
 include/linux/ring_buffer.h |   8 +-
 kernel/module/main.c        |  13 ++
 kernel/trace/ring_buffer.c  | 299 ++++++++++++++++++++++++++++----------------
 kernel/trace/trace.c        | 268 +++++++++++++++++++++++++++++++++++----
 kernel/trace/trace.h        |  15 ++-
 kernel/trace/trace_events.c |  40 ++++--
 7 files changed, 493 insertions(+), 156 deletions(-)

