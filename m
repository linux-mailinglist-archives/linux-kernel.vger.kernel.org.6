Return-Path: <linux-kernel+bounces-413767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF159D1E5E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 03:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CE0DB23F43
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9471213AD26;
	Tue, 19 Nov 2024 02:40:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C59427735
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 02:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731984016; cv=none; b=Sh1J2qPLvpiG0Hmivyqqqc2wBUUSsv8ybdE5yukn1Rv0ub/StZe+SlhAT7zYckVvPKwwDg11hvE3LQqYmhIHYz/nzWe2OHIE1+m+t0uhpzBetmYmPfjzoE4CFZdvwsZKhJya0obIgIwzUG3GclVaqjFhAN2zZPK2Ey26cSIU+3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731984016; c=relaxed/simple;
	bh=E8GVV2n39vdgH8Xm+hQoZ9UJxHQ0EScZ3apa6cC55Y8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=C11ZKuRWDvBYCxfRgEmN2hgpXY9vAGJ3RvHLixJyGYguas9IrPaxjZCsSKI81xZYf62Etm4jIRnX9TMBuj91DqA5WKpR1++5C2qrxDFAWGTQ8W35lX+pZ+xu0sDpQgHPpa95qTdS11TdXJalDUELp7y9pjl3lKyFQHwK0bSpjqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22204C4CECF;
	Tue, 19 Nov 2024 02:40:16 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tDEAa-0000000ED2y-3O3W;
	Mon, 18 Nov 2024 21:40:48 -0500
Message-ID: <20241119024048.661745967@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 18 Nov 2024 21:40:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Colin Ian King <colin.i.king@gmail.com>
Subject: [for-next][PATCH 1/3] tracing: Remove redundant check on field->field in histograms
References: <20241119024016.371665360@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Colin Ian King <colin.i.king@gmail.com>

The check on field->field being true is handled as the first check
on the cascaded if statement, so the later checks on field->field
are redundant because this clause has already been handled. Since
this later check is redundant, just remove it.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20241107120530.18728-1-colin.i.king@gmail.com
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c288b92fc4df..9c058aa8baf3 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1354,10 +1354,7 @@ static const char *hist_field_name(struct hist_field *field,
 	} else if (field->flags & HIST_FIELD_FL_TIMESTAMP)
 		field_name = "common_timestamp";
 	else if (field->flags & HIST_FIELD_FL_STACKTRACE) {
-		if (field->field)
-			field_name = field->field->name;
-		else
-			field_name = "common_stacktrace";
+		field_name = "common_stacktrace";
 	} else if (field->flags & HIST_FIELD_FL_HITCOUNT)
 		field_name = "hitcount";
 
-- 
2.45.2



