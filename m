Return-Path: <linux-kernel+bounces-546051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5735FA4F5AE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 04:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F30E216F09A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB9318950A;
	Wed,  5 Mar 2025 03:50:31 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536F18F54
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 03:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741146631; cv=none; b=dqXtsZ7gEuOg+cqvlBZiQPauPs6IERf2bMCYNFIq0UDvshQidG/dOEMLjkGPjTL2OeUXiBty1RFFrBfVS3WUBWwHHYdItlTv+ueQGxCM8RhPBwyENkkvYNWlC6pGdFjnVzrUbQYwthOARLQe4ezUU80LgAHDDT4+RaaR7gBE2Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741146631; c=relaxed/simple;
	bh=GIXLfprnAG1B0EuI5bbRU/x8RcJ/d5jHQVsB+Cp5gRM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ApUebWE8vGAbPmvKd2ksHj3ANMRHYLWeeohs6/eg/HhwMR+Fa1eNSYRV4+bly3fXYNOR1Q9ig2yM3LpS4Hjhjipzg/od0M37wYaSw4hcNF6fBXu2QcWyefunD8q9QnVIgBIUWFEAkFq5PsiS8krTmvrSWfHN9shaDxiRQJS2Feo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C443C4CEEC;
	Wed,  5 Mar 2025 03:50:31 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tpfn5-0000000CYUx-2NZp;
	Tue, 04 Mar 2025 22:51:27 -0500
Message-ID: <20250305035127.420450015@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 04 Mar 2025 22:51:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 2/6] ftrace: Have ftrace_free_filter() WARN and exit if ops is active
References: <20250305035107.307030265@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The ftrace_free_filter() is used to reset the ops filters. But it must be
done if the ops is not currently active (tracing). If it is, it will mess
up the ftrace accounting of what functions are attached and what is not.

WARN and exit the ftrace_free_filter() if the ops is active when it is
called.

Currently, it doesn't seem if anything does this, but it may in the
future.

Link: https://lore.kernel.org/all/20250219095330.2e9f171c@gandalf.local.home/

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20250219135040.3a9fbe00@gandalf.local.home
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 6b0c25761ccb..de25c0505b6b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1296,6 +1296,8 @@ static void free_ftrace_hash_rcu(struct ftrace_hash *hash)
 void ftrace_free_filter(struct ftrace_ops *ops)
 {
 	ftrace_ops_init(ops);
+	if (WARN_ON(ops->flags & FTRACE_OPS_FL_ENABLED))
+		return;
 	free_ftrace_hash(ops->func_hash->filter_hash);
 	free_ftrace_hash(ops->func_hash->notrace_hash);
 }
-- 
2.47.2



