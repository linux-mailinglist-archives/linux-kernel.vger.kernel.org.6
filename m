Return-Path: <linux-kernel+bounces-555002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9591A5A458
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566451890561
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2841D8DF6;
	Mon, 10 Mar 2025 20:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GtXG+r1W"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AF51CD205
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637077; cv=none; b=PA1aInkoYK1ZfLnmSDdDPbLsMxM7j+yHRZ3eotF9aC6iEKOygXQqOFuxmwk4OyapyZxA8Td/ecrMB6a3H+snDIuvP33ip0+olIRkP9Kxf/DWP+Bz6Jdej85wv8M3W1y/s+aSq5+MpD9YNP7WNrDJOyn0APyz8JQGMp0w1Qz4/FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637077; c=relaxed/simple;
	bh=0I46IlE0eevSTbe6HgNGjPfeIS7xnB2S0NKk5f7/Yc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AWJaB297u7Iu9QhqQeTZSswuILH9uBhq3Hvfh2r4VJkbNmk3AxHegnwl15hNYmXcJIUTXy7+VUZB22+j8d5P+liIDpm/Vsg4aYTNA758+mvz775cDnEPuLwzDNHVMulBMBhtyomivpqRM7dqFVG9wnC8Jqy1gFJBTRd7ReF+XJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GtXG+r1W; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741637063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QKEtd75rPVsd5FrismUxBPw8k8s1SS03XckANZg+1No=;
	b=GtXG+r1WybhFG2HKhJ7aHeW77ftOlVxjTPYaAYsDDuUGptrFh/SC3CD9t/w0lkzmykHP7g
	GW8lywhzdbjgt9w/9LtF4Ra2PFBu/zLqGgB/1TJn0ihD9qx4vze2d43ncGATfiOrVHA+UZ
	jFeCO4MV7fzxxoCxl5vHqjC0chqYdVU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing/synthetic: Replace deprecated strncpy() with strscpy()
Date: Mon, 10 Mar 2025 21:03:58 +0100
Message-ID: <20250310200359.450172-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strncpy() is deprecated for NUL-terminated destination buffers; use
strscpy() instead and remove the manual NUL-termination.

The destination buffer 'buf' is used only with kstrtouint() and must be
NUL-terminated, but not NUL-padded. The source string 'start' is also
guaranteed to be NUL-terminated and meets the __must_be_cstr()
requirement of strscpy().

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/trace/trace_events_synth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index e3f7d09e5512..4b51f74897b4 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -207,8 +207,7 @@ static int synth_field_string_size(char *type)
 	if (len == 0)
 		return 0; /* variable-length string */
 
-	strncpy(buf, start, len);
-	buf[len] = '\0';
+	strscpy(buf, start, len + 1);
 
 	err = kstrtouint(buf, 0, &size);
 	if (err)
-- 
2.48.1


