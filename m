Return-Path: <linux-kernel+bounces-359274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C230099899B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B8C289F75
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340051E5726;
	Thu, 10 Oct 2024 14:25:45 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EA71D0435
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570343; cv=none; b=Fx4yjkKW84CX0QVBlvpWnkeegVvjyT0YbI07EWOgyNQ587uGk7OniIpJRewLeeXT5ITkqogK7tGg8KAW1pPAi08nD5ksAJ4ozFb6zuhBVedbsRw+1Q8t2IK6jj852tWpxRJEnpvYrMLhDKWaalcYFXONZyEak+B1Ew3f7VVucW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570343; c=relaxed/simple;
	bh=ydcUIT5QrBwXxZEI4ghkmBBsj/Dk4TQBvAe8VQCEruA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=UaVkwa7UG8QU4MSRzRdQIEPaMyOi4oQFPGN6cEEDpGiaTvt84WHYCvRlnTXNohtZMGXAP31qV8drmFVcC2Bf+n+FvpM22iNkwZaFSbor1DnZaNDzQL8kawAPkD+krVWY8LluoMkF2tNmiEtt3ROT3v+FTPmDImE2C+vfHSaFTbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4461EC4CED0;
	Thu, 10 Oct 2024 14:25:43 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1syu6x-00000001HLJ-17oM;
	Thu, 10 Oct 2024 10:25:51 -0400
Message-ID: <20241010142551.130902358@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 10 Oct 2024 10:25:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uros Bizjak <ubizjak@gmail.com>
Subject: [for-next][PATCH 10/10] tracing: Use atomic64_inc_return() in trace_clock_counter()
References: <20241010142537.255433162@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Uros Bizjak <ubizjak@gmail.com>

Use atomic64_inc_return(&ref) instead of atomic64_add_return(1, &ref)
to use optimized implementation and ease register pressure around
the primitive for targets that implement optimized variant.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20241007085651.48544-1-ubizjak@gmail.com
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_clock.c b/kernel/trace/trace_clock.c
index 4702efb00ff2..4cb2ebc439be 100644
--- a/kernel/trace/trace_clock.c
+++ b/kernel/trace/trace_clock.c
@@ -154,5 +154,5 @@ static atomic64_t trace_counter;
  */
 u64 notrace trace_clock_counter(void)
 {
-	return atomic64_add_return(1, &trace_counter);
+	return atomic64_inc_return(&trace_counter);
 }
-- 
2.45.2



