Return-Path: <linux-kernel+bounces-215247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B32909043
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178F41C20CFA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3571B180A78;
	Fri, 14 Jun 2024 16:30:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01F41756A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382647; cv=none; b=Gkqq5Gd2ctvI9tXqjwEQ0EXUh5yiNPo0sgFfzfbpJ7vBOhfiZ6T6ttq7Tk+viK1mgUG9rxblPB9G2jD7i3zgOccoXGI2lmxS4fn8FjHJOWiHqN3bFJuJGJwLp7V86V6So2KYkwAUTc7z8AmquxYJZX8xi9Swl7ioYfdck/v3V8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382647; c=relaxed/simple;
	bh=NP/w9eF1odFhNih4JuDBdoZkpi6HfrXoTgiTK2coqdY=;
	h=Message-ID:Date:From:To:Cc:Subject; b=bZ1+5/kG6vjCKa9vzK69e2lJCoupQK9w2RautUsQyA1jn39UWeI9mho7GWVHIZ0phrHDG16XgVUoWuJhdFL6+oymTKOjRVFYcn5Bl1fGjXWANloolp64D39eKgBO37GIDQXtffVVS7pY5rD9422458jGk39Dk6C14PwyrZoNkWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697DAC2BD10;
	Fri, 14 Jun 2024 16:30:47 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sI9pW-00000001roz-1Q7d;
	Fri, 14 Jun 2024 12:31:10 -0400
Message-ID: <20240614163015.456541709@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 14 Jun 2024 12:30:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/13] tracing/ring-buffer: Persistent traces across a reboot or crash
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ring-buffer/for-next

Head SHA1: a62b4f6fbdffa8e90959da485b68f844241d300f


Steven Rostedt (Google) (13):
      ring-buffer: Allow mapped field to be set without mapping
      ring-buffer: Add ring_buffer_alloc_range()
      ring-buffer: Add ring_buffer_meta data
      tracing: Implement creating an instance based on a given memory region
      ring-buffer: Add output of ring buffer meta page
      ring-buffer: Add test if range of boot buffer is valid
      ring-buffer: Validate boot range memory events
      tracing: Add option to use memmapped memory for trace boot instance
      ring-buffer: Save text and data locations in mapped meta data
      tracing/ring-buffer: Add last_boot_info file to boot instance
      tracing: Handle old buffer mappings for event strings and functions
      tracing: Update function tracing output for previous boot buffer
      tracing: Add last boot delta offset for stack traces

----
 Documentation/admin-guide/kernel-parameters.txt |   9 +
 include/linux/ring_buffer.h                     |  20 +
 kernel/trace/ring_buffer.c                      | 878 +++++++++++++++++++++---
 kernel/trace/trace.c                            | 242 ++++++-
 kernel/trace/trace.h                            |  10 +-
 kernel/trace/trace_output.c                     |  12 +-
 6 files changed, 1056 insertions(+), 115 deletions(-)

