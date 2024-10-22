Return-Path: <linux-kernel+bounces-375821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CF29A9B4D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9DA01F226A1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8169E1527B1;
	Tue, 22 Oct 2024 07:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dgBth4ZO"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BDF14D2A0
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 07:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729582845; cv=none; b=Yr0zmJFqYsvQNiI5swOgfA/zwiRAoxS0HOG6xm5CumdCAh0mR0ddqMxQ2ZhPL2mdd3kD+y77BIRjDAbTWLMY8b//76TMDisioh5FsQW/IY0RnKFTMGzSyzfLFXjB/6iwa9UDRPab7Pf3NgJXEs2M75e0ou+iyMp4o1VuJTWnKMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729582845; c=relaxed/simple;
	bh=OCyZ/2+h6UGqULDJygrT1ngtsq46a7O9EeLZj3AKUhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sQH8iiiWyhtXxWPH+Wl68MrMjsiEyrofpUOElXrCFY05BAa6fyVQVbhx4htADQsPr7xu0nInMWVHAfq5oltdPugKXuQDYTLp64BAozZ9qnVgV/bSm77VT6KF85F0ROObSHnrCI+VIEY2qR7BspHHiKOdH6T4//yWTZ6xRLKILN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dgBth4ZO; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729582841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=akdSUd/5NvtAAcUIf222jn4Ox4XAStWLETkQ330gzUM=;
	b=dgBth4ZOEu2lV/THO3ndfNigkqwg9YQK2xytHfCis2zfvTkP1h0TzjBvkkhR/g2zAocCaL
	7kU66AegAxfNqYmnSPXsMN/IufOVX+Wdjt84ziSeD4NQWykSyz+TCi/8m2t6INyP0veH4l
	5N5hQ9m0X/fW3+VFr3XvOY5z2V8k9i8=
From: Andrea Righi <andrea.righi@linux.dev>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH for-6.12-fixes] sched_ext: fix fmt__str variables in kfuncs
Date: Tue, 22 Oct 2024 09:40:35 +0200
Message-ID: <20241022074035.139897-1-andrea.righi@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Commit 3e99aee7ce48 ("sched-ext: Use correct annotation for strings in
kfuncs") renamed some parameters without updating the body of the
functions, triggering build errors like this:

kernel/sched/ext.c:6881:45: error: ‘fmt’ undeclared (first use in this function)
6881 |       if (bstr_format(&scx_exit_bstr_buf, fmt, data, data__sz) >= 0)
     |                                             ^~~

Fix by renaming also the varibles in the affected kfuncs.

Fixes: 3e99aee7ce48 ("sched-ext: Use correct annotation for strings in kfuncs")
Signed-off-by: Andrea Righi <andrea.righi@linux.dev>
---
 kernel/sched/ext.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ff24d652c386..280beea63fa9 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6738,7 +6738,7 @@ __bpf_kfunc void scx_bpf_exit_bstr(s64 exit_code, char *fmt__str,
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&scx_exit_bstr_buf_lock, flags);
-	if (bstr_format(&scx_exit_bstr_buf, fmt, data, data__sz) >= 0)
+	if (bstr_format(&scx_exit_bstr_buf, fmt__str, data, data__sz) >= 0)
 		scx_ops_exit_kind(SCX_EXIT_UNREG_BPF, exit_code, "%s",
 				  scx_exit_bstr_buf.line);
 	raw_spin_unlock_irqrestore(&scx_exit_bstr_buf_lock, flags);
@@ -6759,7 +6759,7 @@ __bpf_kfunc void scx_bpf_error_bstr(char *fmt__str, unsigned long long *data,
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&scx_exit_bstr_buf_lock, flags);
-	if (bstr_format(&scx_exit_bstr_buf, fmt, data, data__sz) >= 0)
+	if (bstr_format(&scx_exit_bstr_buf, fmt__str, data, data__sz) >= 0)
 		scx_ops_exit_kind(SCX_EXIT_ERROR_BPF, 0, "%s",
 				  scx_exit_bstr_buf.line);
 	raw_spin_unlock_irqrestore(&scx_exit_bstr_buf_lock, flags);
@@ -6791,10 +6791,10 @@ __bpf_kfunc void scx_bpf_dump_bstr(char *fmt__str, unsigned long long *data,
 
 	/* append the formatted string to the line buf */
 	ret = __bstr_format(buf->data, buf->line + dd->cursor,
-			    sizeof(buf->line) - dd->cursor, fmt, data, data__sz);
+			    sizeof(buf->line) - dd->cursor, fmt__str, data, data__sz);
 	if (ret < 0) {
 		dump_line(dd->s, "%s[!] (\"%s\", %p, %u) failed to format (%d)",
-			  dd->prefix, fmt, data, data__sz, ret);
+			  dd->prefix, fmt__str, data, data__sz, ret);
 		return;
 	}
 
-- 
2.47.0


