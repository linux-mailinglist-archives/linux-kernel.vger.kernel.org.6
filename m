Return-Path: <linux-kernel+bounces-254158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D93932F9D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C9BC281D18
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B87D1A01CF;
	Tue, 16 Jul 2024 18:03:06 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FDC1A01B3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 18:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152985; cv=none; b=SBcXFFeLjFyU/5xEeW0k1FPZj2EZIPSsulBAVV0dYIVqwOUx1RPn7gMJku19p5nZcVQb4/pVaU6ZcA2WLvWmU9zwlAOOI+sadzHf177HpLrKtlEyDuroNxxrb0fSsiR9Yy6HDrLAwtXfRGnmU0LV2K+QjGlRxR7C010xT978OKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152985; c=relaxed/simple;
	bh=e99cUqpAw0Ze+FD8QbMChbZyDn00kbYml6vaF7x7WKQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=nD7WxqNaYoJcvZDLL7SlDpQrXlAG2btrfPIsmlSvK6qiRp64Bpy03RV8osUxMIPpZj9eTpN/4tG6PviR1Y/tFP0yFMH/pzFEKnQfOpRCRgKnCQNeb9PXlrIhwNkVOVr+vaaeqswh4OPekAD4yVbnNozJtmtPVgbDT4tx9syBzXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630C3C4AF0B;
	Tue, 16 Jul 2024 18:03:05 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1sTmW0-000000006uJ-3K6U;
	Tue, 16 Jul 2024 14:03:04 -0400
Message-ID: <20240716180304.655162704@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 16 Jul 2024 14:02:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Subject: [for-next][PATCH 1/2] tracing: Fix NULL vs IS_ERR() check in enable_instances()
References: <20240716180223.593493907@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Dan Carpenter <dan.carpenter@linaro.org>

The trace_array_create_systems() function returns error pointers, not
NULL.  Fix the check to match.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: e645535a954a ("tracing: Add option to use memmapped memory for trace boot instance")
Link: https://lore.kernel.org/9b23ea03-d709-435f-a309-461c3d747457@moroto.mountain
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 71cca10581d6..5462fb10ff64 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10507,7 +10507,7 @@ __init static void enable_instances(void)
 		}
 
 		tr = trace_array_create_systems(name, NULL, addr, size);
-		if (!tr) {
+		if (IS_ERR(tr)) {
 			pr_warn("Tracing: Failed to create instance buffer %s\n", curr_str);
 			continue;
 		}
-- 
2.43.0



