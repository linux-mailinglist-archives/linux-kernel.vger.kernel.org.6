Return-Path: <linux-kernel+bounces-204245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 384E88FE638
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFB862834E7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDA01667E3;
	Thu,  6 Jun 2024 12:11:01 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44847195F23
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675861; cv=none; b=V/35l2V8HBr3Ay8m5nbO7ecQErLM7IavFFgKX/zlyZb8BE0Mm5xtgAL23GQ3lGiwrdqEfoEojSaFHUkA5DxRcwQYEh938rFyZAS4GtD+aqJ+vVcCU/6EVjzzNhCCzwcT1lHveuY0OjTNHaScaTsg//NhlL0IO1qT6Dm76d/qf/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675861; c=relaxed/simple;
	bh=UQmRInHjs4WMU28q1p/Y/++JZxg0i2kAsZIONMTIPYM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=o0XPjZdjrkTmx6Cc2uyjMHMOHsOcTzhhrEhLzMOr8sHrbYXVgpXdEhGWH7jtO/cGtmkKw/eyMJK75DPE/QgioXYtttFFT22LkMzTGHLSlE1Wb/iyHqZQeVkmozYJfQux/gRQ/DiMvrf5pKAcQL7zQv5EgmzdWoAB5TbszOk9blw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E56C4DDF4;
	Thu,  6 Jun 2024 12:11:00 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sFBxR-00000000nKq-1NW6;
	Thu, 06 Jun 2024 08:11:05 -0400
Message-ID: <20240606121105.194409809@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Jun 2024 08:10:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 05/15] ftrace: Add comments to ftrace_hash_rec_disable/enable()
References: <20240606121004.857581251@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Add comments to describe what the functions ftrace_hash_rec_disable() and
ftrace_hash_rec_enable() do. Also change the passing of the "inc" variable
to __ftrace_hash_rec_update() to a boolean value as that is what it is
supposed to take.

Link: https://lore.kernel.org/linux-trace-kernel/20240605180408.857333430@goodmis.org

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index abcdffa4d572..4140d0ce25f1 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1863,14 +1863,24 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
 	return update;
 }
 
+/*
+ * This is called when an ops is removed from tracing. It will decrement
+ * the counters of the dyn_ftrace records for all the functions that
+ * the @ops attached to.
+ */
 static bool ftrace_hash_rec_disable(struct ftrace_ops *ops)
 {
-	return __ftrace_hash_rec_update(ops, 0);
+	return __ftrace_hash_rec_update(ops, false);
 }
 
+/*
+ * This is called when an ops is added to tracing. It will increment
+ * the counters of the dyn_ftrace records for all the functions that
+ * the @ops attached to.
+ */
 static bool ftrace_hash_rec_enable(struct ftrace_ops *ops)
 {
-	return __ftrace_hash_rec_update(ops, 1);
+	return __ftrace_hash_rec_update(ops, true);
 }
 
 static void ftrace_hash_rec_update_modify(struct ftrace_ops *ops, int inc)
-- 
2.43.0



