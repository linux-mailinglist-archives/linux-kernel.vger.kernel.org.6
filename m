Return-Path: <linux-kernel+bounces-572737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AABFA6CDE5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 06:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19D93AB02B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 05:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646AB202C31;
	Sun, 23 Mar 2025 05:08:57 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB06202993
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 05:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742706537; cv=none; b=t62AEa0NVPEyZIbw+n76pPem5U1IERFiX7phi+kXuxOuvhIKKKM5s7XZCrTaRTUFwlhcx94W5NaIWMmmILgcHwfU3bn390r+Qx1uN6KVRi/SIGWrM59Yn4mSl7t81l5yBxospkcDKUAQLDAY1ncWJ2tX+NFF6obfkyMBeT72nX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742706537; c=relaxed/simple;
	bh=z1CpyVs8YeB3s7kVIV8MfD1Z/fa0HB9KogiZjwRwKdE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=JWdG40Vl9UhOZbeaJ1jH6P/RwLPXNH4zyhheUM1F0UE6IN1E/1bZR67b5Zd45l+tyynSer1FlSYYm7weUhJU/AfTPrGMmtI2T5mwioNDNmOEtRay1T6gMOjCnCR9MeEqRbuS8D67bUWPNinGD1bgJWuRI3R5OgW+DPbUcbIx50U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FF6C4CEE4;
	Sun, 23 Mar 2025 05:08:55 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1twDaY-00000001x14-0NLI;
	Sun, 23 Mar 2025 01:09:34 -0400
Message-ID: <20250323050933.941248766@goodmis.org>
User-Agent: quilt/0.68
Date: Sun, 23 Mar 2025 01:09:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Abaci Robot <abaci@linux.alibaba.com>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [for-next][PATCH 4/4] ring-buffer: Remove the unused variable bmeta
References: <20250323050914.459621318@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Variable bmeta is not effectively used, so delete it.

kernel/trace/ring_buffer.c:1952:27: warning: variable ‘bmeta’ set but not used.

Link: https://lore.kernel.org/20250317015524.3902-1-jiapeng.chong@linux.alibaba.com
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=19524
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 94be81edffd2..302b1404213c 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1949,7 +1949,6 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages, int scratch_size)
 {
 	struct ring_buffer_cpu_meta *meta;
-	struct ring_buffer_meta *bmeta;
 	unsigned long *subbuf_mask;
 	unsigned long delta;
 	void *subbuf;
@@ -1964,8 +1963,6 @@ static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages, int sc
 	if (rb_meta_init(buffer, scratch_size))
 		valid = true;
 
-	bmeta = buffer->meta;
-
 	for (cpu = 0; cpu < nr_cpu_ids; cpu++) {
 		void *next_meta;
 
-- 
2.47.2



