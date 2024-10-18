Return-Path: <linux-kernel+bounces-371579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8EB9A3CE1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C52A5B2A8B0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FA6204023;
	Fri, 18 Oct 2024 11:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ahKq3fIc"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B2A2038CE
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729249692; cv=none; b=As7ZwGKYliLDIdEUYTtqLdLpcLMYhYdB4g2DQLTGYJU+h6PXsR5O1cGmG8MDdcpd2D25V9S7Ytl7qPpPQrTkjLO5SsHjHc0x6gAHhLGM/A9bxoFkG4zMGSXBAXCHVpW5bVBcxyzoogal2ucQ80PL7z6+hsdOsOmusmLOp+bwjzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729249692; c=relaxed/simple;
	bh=2dykOaDocdoeUGOi6ZyrRq9wQyJ9q60Dh04Mdz4OtPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PcNnzuhXJRSyJpTDy77DO/UNRQXJCDzO9/MDbkgkz9UFTY73aZ+iQ2peSYLY4q0deUdH31HXiTZ4BDTLeD/n6o/+1xF6zt0iMp3mBkg7srebU/kd/WQSc55GkNeVBcLo0b4pGVtKi/5EFKoHLho51TUUU/jfVqmUBsV1vlCJbPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ahKq3fIc; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729249683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FFS3M7sbO4p1IWXMEOjxLWO1Q9u2Y4kIF/muM4ow1dc=;
	b=ahKq3fIczcWr/DpKd5yEN+DfjeJDielS95Yd7pllg6kAhjRJo1TeCProyBWa62En8VHHpY
	6mr05rS23GW8ri0LOjWfuJ21dVMc1viTEzEC/EDI6Kgcg2qeTvrmkMeYwjAUbEMZqQUued
	werXSFkFKUuEDmRlqgBovMrvz/cPn+U=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] ring-buffer: Use str_low_high() helper in ring_buffer_producer()
Date: Fri, 18 Oct 2024 13:07:10 +0200
Message-ID: <20241018110709.111707-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the helper function str_low_high().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
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
2.47.0


