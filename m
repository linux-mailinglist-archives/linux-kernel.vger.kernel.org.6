Return-Path: <linux-kernel+bounces-375465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BB09A963F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 04:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E77E7B22875
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 02:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B4113AD3F;
	Tue, 22 Oct 2024 02:29:29 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687DF13957B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 02:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729564169; cv=none; b=mxTNk2SkWfldReDVl9h2NKiCEtv3BoxgBr04g2vo7vlrPvW3AX0CpwtRYdMPrpRB3BjS2MztTxKHKFCaH7KKjdXVtUpl7gO/FWFXPV41mgYPqBlwbON3V1KMBV/YVVzI+UHmgl9JhB+hjxbKqGxwAvAxBQsV7osdjSkYUVfm6Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729564169; c=relaxed/simple;
	bh=o5p0evTJ87uWJFGARawD85YbDHCUXfZ9AMz5MOc4c/s=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Mz2S0rEuo1Cen1sDf4/lB6aBUwGg3MBHTe5bvLjzXhkRlvmzvejhAHur9N6Wrn5wf8y493rYqFgKA5xkBmNFP34Cd7JUNC4o0AEKoYGn+O5cvJogbOYYnq+ryZDJI/W2pP/83tHvc7hOMNGW/a51fQbe4i7jEIw17eH5t5ddeiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26644C4CEE9;
	Tue, 22 Oct 2024 02:29:29 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t34ep-00000004dz9-2bXH;
	Mon, 21 Oct 2024 22:30:03 -0400
Message-ID: <20241022023003.478971102@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 21 Oct 2024 22:29:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thorsten Blum <thorsten.blum@linux.dev>
Subject: [for-next][PATCH v2 3/3] ring-buffer: Use str_low_high() helper in ring_buffer_producer()
References: <20241022022919.695045683@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Thorsten Blum <thorsten.blum@linux.dev>

Remove hard-coded strings by using the helper function str_low_high().

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20241018110709.111707-2-thorsten.blum@linux.dev
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer_benchmark.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer_benchmark.c b/kernel/trace/ring_buffer_benchmark.c
index 008187ebd7fe..cdc3aea12c93 100644
--- a/kernel/trace/ring_buffer_benchmark.c
+++ b/kernel/trace/ring_buffer_benchmark.c
@@ -307,14 +307,14 @@ static void ring_buffer_producer(void)
 	if (!disable_reader) {
 		if (consumer_fifo)
 			trace_printk("Running Consumer at SCHED_FIFO %s\n",
-				     consumer_fifo == 1 ? "low" : "high");
+				     str_low_high(consumer_fifo == 1));
 		else
 			trace_printk("Running Consumer at nice: %d\n",
 				     consumer_nice);
 	}
 	if (producer_fifo)
 		trace_printk("Running Producer at SCHED_FIFO %s\n",
-			     producer_fifo == 1 ? "low" : "high");
+			     str_low_high(producer_fifo == 1));
 	else
 		trace_printk("Running Producer at nice: %d\n",
 			     producer_nice);
-- 
2.45.2



