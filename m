Return-Path: <linux-kernel+bounces-289633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 939BF95488D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3F21F22A9B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD76B1B29AC;
	Fri, 16 Aug 2024 12:16:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C6318FC83
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 12:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723810574; cv=none; b=jhI/rCviFPPrfVRzJmcrGuaHUDoH6WXm65PAWmIITDaLUcQBaSIyasrY2aUFy7SW4XMfnKZ6u+E9VJFvHdfjNFmW2Sw8nl9ltQeOwNvShOlQL1/f90HgADL7UYMU/lTEU3waMe3IEKrkTCFoJ7sbFgx8pLO5Xx/YdLLYzagFjC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723810574; c=relaxed/simple;
	bh=l8ZnAKQEVAGLvUew7fQPzHPBzvrXX2LGq4Z4vYmF+X0=;
	h=Message-ID:Date:From:To:Cc:Subject; b=WTappxdPSWpadxPxH3LBUkD9+weqIcMyTS61LRNgLigZmkMjiaeaIWyDVPOobq5VrHZD/yuoOE9GTgODrs/XDylNXRYCi+tmOMrPVzjrhCgSiwCsZ1qSN6s1kenDKMak5pC9j0A8BDwf+addur+DbrbRl//Qy60qOMwHU0k7x3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3BEC32782;
	Fri, 16 Aug 2024 12:16:13 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1sevse-000000024BC-0NCe;
	Fri, 16 Aug 2024 08:16:32 -0400
Message-ID: <20240816121611.805849825@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 16 Aug 2024 08:16:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/2] tracing: Fixes for 6.11
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


A couple of fixes for tracing:

- Prevent a NULL pointer dereference in the error path of rtla

- Fix an infinite loop bug when reading from the ring buffer when closed.
  If there's a thread trying to read the ring buffer and it gets closed
  by another thread, the one reading will go into an infinite loop
  when the buffer is empty instead of exiting back to user space.

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/urgent

Head SHA1: 90574d2a675947858b47008df8d07f75ea50d0d0


Dan Carpenter (1):
      rtla/osnoise: Prevent NULL dereference in error handling

Steven Rostedt (1):
      tracing: Return from tracing_buffers_read() if the file has been closed

----
 kernel/trace/trace.c                 |  2 +-
 tools/tracing/rtla/src/osnoise_top.c | 11 ++++-------
 2 files changed, 5 insertions(+), 8 deletions(-)

