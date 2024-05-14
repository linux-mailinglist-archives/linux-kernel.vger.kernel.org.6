Return-Path: <linux-kernel+bounces-178924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8B88C597E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8C1281EC7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A22D17F395;
	Tue, 14 May 2024 16:14:58 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BF417F370
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715703297; cv=none; b=T5Dpd29kIOQM4zH5Sy1/IIF1vV/q3/pPcch87fN9CmqkZtgrv6RPTRpF/CtXZZHq/xEy0j9ZFY68GgxHrLh+uR6o1GFE4xo17jnuzLkqHR+tPrTVVB3ho1dnfjZacGbvNiur+LYaqm4aIatkPzKtYmXoCi0Q43F+yNZgQc4f1Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715703297; c=relaxed/simple;
	bh=plML4HWJuSi8kL6RJveAZUXjgIqw99uTWZgZMDW1oE4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Elbi2tUSCYfgKAkPxwaimyH48NTm28fmu0l2P6CiUnsKgwaEqGEvRKJpB+rODZR+/QQnFQ2X03HIw9LzhzSpLyRuzkjAz66fGrqyjKkw3zgPl5WsXpPSrUY8LIFafOpxfAmKrf2Tx0VFdpqc9ZXACx9yv16a9mVpFbzVJ6NAYa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DC3C4AF0F;
	Tue, 14 May 2024 16:14:57 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s6uoE-00000003t3y-1uf4;
	Tue, 14 May 2024 12:15:22 -0400
Message-ID: <20240514161522.320473028@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 14 May 2024 12:14:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thorsten Blum <thorsten.blum@toblux.com>
Subject: [for-next][PATCH 3/7] tracing: Improve benchmark test performance by using do_div()
References: <20240514161438.134250861@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Thorsten Blum <thorsten.blum@toblux.com>

Partially revert commit d6cb38e10810 ("tracing: Use div64_u64() instead
of do_div()") and use do_div() again to utilize its faster 64-by-32
division compared to the 64-by-64 division done by div64_u64().

Explicitly cast the divisor bm_cnt to u32 to prevent a Coccinelle
warning reported by do_div.cocci. The warning was removed with commit
d6cb38e10810 ("tracing: Use div64_u64() instead of do_div()").

Using the faster 64-by-32 division and casting bm_cnt to u32 is safe
because we return early from trace_do_benchmark() if bm_cnt > UINT_MAX.
This approach is already used twice in trace_do_benchmark() when
calculating the standard deviation:

	do_div(stddev, (u32)bm_cnt);
	do_div(stddev, (u32)bm_cnt - 1);

Link: https://lore.kernel.org/linux-trace-kernel/20240329160229.4874-2-thorsten.blum@toblux.com

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_benchmark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_benchmark.c b/kernel/trace/trace_benchmark.c
index 811b08439406..e19c32f2a938 100644
--- a/kernel/trace/trace_benchmark.c
+++ b/kernel/trace/trace_benchmark.c
@@ -104,7 +104,7 @@ static void trace_do_benchmark(void)
 		stddev = 0;
 
 	delta = bm_total;
-	delta = div64_u64(delta, bm_cnt);
+	do_div(delta, (u32)bm_cnt);
 	avg = delta;
 
 	if (stddev > 0) {
-- 
2.43.0



