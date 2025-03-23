Return-Path: <linux-kernel+bounces-572832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D41E2A6CF2E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 13:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8642E3B61E0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 12:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB6521D59A;
	Sun, 23 Mar 2025 12:29:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39004205E0A
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 12:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742732951; cv=none; b=ax7Bzig4+mKDQb+tOJkG0YWTgd7J9wRMVwZNxB1Nv9Anop0lJbevqRotd5qHFHInrgo0UIS0yMwTUzZ2sQJ5wX3JI0Lx6Jq86b5diYchJJtkyx9oPzbZFuCBLsB1/wOtlYHN2Cw5oey2nMGlmy1yy73tuu7MXktjuReJUFKT1JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742732951; c=relaxed/simple;
	bh=6b+1hq0u02rQnD+nc7i3nUA1B1IWhtOUZIFiB9pYoB0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=bMm54yGUxvESAOWGex5CRPAEMVit2+wAN71xOFDdGLf2/fSz0G/UIjDb7kL+9YwL4CZ+k6b9CAzbA0F4iQBON3ro1fpHeIw8tQRWehs/XeMqR1/g192wpXWy5tSG24DJ7zbuLiHETlT+9iKnt0Z/dqw6q/77PFLI3h1az8z8p5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC94C4AF0B;
	Sun, 23 Mar 2025 12:29:11 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1twKSc-00000001yhC-2Gn5;
	Sun, 23 Mar 2025 08:29:50 -0400
Message-ID: <20250323122950.397439862@goodmis.org>
User-Agent: quilt/0.68
Date: Sun, 23 Mar 2025 08:29:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Gabriele Paoloni <gpaoloni@redhat.com>
Subject: [for-next][PATCH 08/10] tracing: fix return value in __ftrace_event_enable_disable for
 TRACE_REG_UNREGISTER
References: <20250323122933.407277911@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Gabriele Paoloni <gpaoloni@redhat.com>

When __ftrace_event_enable_disable invokes the class callback to
unregister the event, the return value is not reported up to the
caller, hence leading to event unregister failures being silently
ignored.

This patch assigns the ret variable to the invocation of the
event unregister callback, so that its return value is stored
and reported to the caller, and it raises a warning in case
of error.

Link: https://lore.kernel.org/20250321170821.101403-1-gpaoloni@redhat.com
Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 513de9ceb80e..8e7603acca21 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -790,7 +790,9 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 				clear_bit(EVENT_FILE_FL_RECORDED_TGID_BIT, &file->flags);
 			}
 
-			call->class->reg(call, TRACE_REG_UNREGISTER, file);
+			ret = call->class->reg(call, TRACE_REG_UNREGISTER, file);
+
+			WARN_ON_ONCE(ret);
 		}
 		/* If in SOFT_MODE, just set the SOFT_DISABLE_BIT, else clear it */
 		if (file->flags & EVENT_FILE_FL_SOFT_MODE)
-- 
2.47.2



