Return-Path: <linux-kernel+bounces-366129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4594F99F137
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27EE1F2386A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44DF1D9580;
	Tue, 15 Oct 2024 15:31:06 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABFD147C91
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006266; cv=none; b=hIbrDoU8iTinuOH04oNalKlOOoyOLx+kkVLboZdNFH1i9h5tRY7q/nV0LOeYToA/Om8fWYvtuXPQBuvRXEzMQ8duMh2EyT5yHmtgtdpAb2q0vTtSCSdtWEViuaGDK+BmCl1be62Z0OUsLy5BEfQh08R2Zl1poFtUcOD3JTnXcb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006266; c=relaxed/simple;
	bh=i59obFdqyI72PyNeSYD1U0n4WunXxK1/6SIvjpa+z/Q=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BvY1kVuW/R068KvlEAiUUWKub4+Jy7GQSc+eDV4Ae4hk9o/OvFLS75rEllMBGiBtO+J9W6rE/gUgmwLAXeXJPgZB1kypUr/vWjDhiRt3hSUmNx2W/pZwlAOIUHvoo/astM5YOoOvGlMGM0mR2zNM717Gqx5K9ynYYMix571/zmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10452C4CECF;
	Tue, 15 Oct 2024 15:31:06 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t0jW9-00000002z4s-2ejC;
	Tue, 15 Oct 2024 11:31:25 -0400
Message-ID: <20241015153125.494414250@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 15 Oct 2024 11:31:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 1/2] ring-buffer: Fix refcount setting of boot mapped buffers
References: <20241015153105.843619901@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

A ring buffer which has its buffered mapped at boot up to fixed memory
should not be freed. Other buffers can be. The ref counting setup was
wrong for both. It made the not mapped buffers ref count have zero, and the
boot mapped buffer a ref count of 1. But an normally allocated buffer
should be 1, where it can be removed.

Keep the ref count of a normal boot buffer with its setup ref count (do
not decrement it), and increment the fixed memory boot mapped buffer's ref
count.

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20241011165224.33dd2624@gandalf.local.home
Fixes: e645535a954ad ("tracing: Add option to use memmapped memory for trace boot instance")
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1c69ca1f1088..a8f52b6527ca 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10621,10 +10621,10 @@ __init static void enable_instances(void)
 		 * cannot be deleted by user space, so keep the reference
 		 * to it.
 		 */
-		if (start)
+		if (start) {
 			tr->flags |= TRACE_ARRAY_FL_BOOT;
-		else
-			trace_array_put(tr);
+			tr->ref++;
+		}
 
 		while ((tok = strsep(&curr_str, ","))) {
 			early_enable_events(tr, tok, true);
-- 
2.45.2



