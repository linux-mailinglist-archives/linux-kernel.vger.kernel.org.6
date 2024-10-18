Return-Path: <linux-kernel+bounces-372364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2BD9A47AD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901D81C2229D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2050120697C;
	Fri, 18 Oct 2024 20:07:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E22205ACD
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729282052; cv=none; b=Vz0swGlDNuMOb2WxUPkB07YRFdr9ZDZBjhubKQEFV37WtLoPip3NCRmNL5bbasL1G0XqCNSjpKSdzajBJCjuxS1/ATBdxbo7lCgJfRXwr2VHe/Tkz8KtQIO7zuvQRXFc7syWu48vdYivXrTaMUfeYbqXfk2YByt0gzc3oT+ZiKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729282052; c=relaxed/simple;
	bh=o5p0evTJ87uWJFGARawD85YbDHCUXfZ9AMz5MOc4c/s=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=M+/pbCJ2auNcNrutqOG5kfVlSJvfhEChWJ5AQB09PtvWWLYLKXLjvar9Ic/tPQfG98OLC2wLl+C+Yq6KrmfhHPVHc25r1ztS2jirIWkUZGAzbr+eqdzNaV4g22sOmzsgRGBDp5bezyCkUL0VRJATC1D/lbv43nD2H+31MSsV8KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E28BC4CED1;
	Fri, 18 Oct 2024 20:07:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t1tGR-00000004EyI-0eU1;
	Fri, 18 Oct 2024 16:07:59 -0400
Message-ID: <20241018200759.024381762@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 18 Oct 2024 16:07:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thorsten Blum <thorsten.blum@linux.dev>
Subject: [for-next][PATCH 3/3] ring-buffer: Use str_low_high() helper in ring_buffer_producer()
References: <20241018200746.849970367@goodmis.org>
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



