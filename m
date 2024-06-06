Return-Path: <linux-kernel+bounces-204246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AA68FE63B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B94F1F22FB6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC50D197552;
	Thu,  6 Jun 2024 12:11:02 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5825C195F27
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675861; cv=none; b=rWlytpwh8ewySoFO2n5cNSfyTmn4P3Kw5TAk9gHwxbTWd/8HKk0UZmpw2sjBcviWvKyi/5o9qORdCrArJgm+qTuIiBuXwyGkHNKQyKtGJb6QQVRSCIlxLwyJmGDmyKft9VaB0b4oFkYfrdRoQYNfetWvCTt2ZAaWgJoAYm1gpIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675861; c=relaxed/simple;
	bh=H4J/vOPaYGRMPo4WfrxbkfzY1t5g0RPt7rHCPw01rI8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=diSz4rRUzwh2DEwVXvd/1hLrlGW+6384KsXZMQka++Fm2vlsuv2qBb12r6k9ahRzZqoIcgC/13rCA7ycla9ij9p/pESLAkSVPb2/ZitGmPi/obO8Aywo0WKlreefoE4Kq5Uk+HhyBdlrhCGsTSBmedftE7GBbWt+FnfRFMFngKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6AFC4DE0B;
	Thu,  6 Jun 2024 12:11:01 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sFBxR-00000000nLK-23op;
	Thu, 06 Jun 2024 08:11:05 -0400
Message-ID: <20240606121105.350727218@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Jun 2024 08:10:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 06/15] ftrace: Convert "inc" parameter to bool in
 ftrace_hash_rec_update_modify()
References: <20240606121004.857581251@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The parameter "inc" in the function ftrace_hash_rec_update_modify() is
boolean. Change it to be such.

Also add documentation to what the function does.

Link: https://lore.kernel.org/linux-trace-kernel/20240605180409.021080462@goodmis.org

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 4140d0ce25f1..256b5e07c39a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1883,7 +1883,24 @@ static bool ftrace_hash_rec_enable(struct ftrace_ops *ops)
 	return __ftrace_hash_rec_update(ops, true);
 }
 
-static void ftrace_hash_rec_update_modify(struct ftrace_ops *ops, int inc)
+/*
+ * This function will update what functions @ops traces when its filter
+ * changes.
+ *
+ * The @inc states if the @ops callbacks are going to be added or removed.
+ * When one of the @ops hashes are updated to a "new_hash" the dyn_ftrace
+ * records are update via:
+ *
+ * ftrace_hash_rec_disable_modify(ops);
+ * ops->hash = new_hash
+ * ftrace_hash_rec_enable_modify(ops);
+ *
+ * Where the @ops is removed from all the records it is tracing using
+ * its old hash. The @ops hash is updated to the new hash, and then
+ * the @ops is added back to the records so that it is tracing all
+ * the new functions.
+ */
+static void ftrace_hash_rec_update_modify(struct ftrace_ops *ops, bool inc)
 {
 	struct ftrace_ops *op;
 
@@ -1907,12 +1924,12 @@ static void ftrace_hash_rec_update_modify(struct ftrace_ops *ops, int inc)
 
 static void ftrace_hash_rec_disable_modify(struct ftrace_ops *ops)
 {
-	ftrace_hash_rec_update_modify(ops, 0);
+	ftrace_hash_rec_update_modify(ops, false);
 }
 
 static void ftrace_hash_rec_enable_modify(struct ftrace_ops *ops)
 {
-	ftrace_hash_rec_update_modify(ops, 1);
+	ftrace_hash_rec_update_modify(ops, true);
 }
 
 /*
-- 
2.43.0



