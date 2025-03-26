Return-Path: <linux-kernel+bounces-576689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB70A7130B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FCA918813A1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23D61B0401;
	Wed, 26 Mar 2025 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmxJhTwe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9331A4F2F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742978891; cv=none; b=taGek/RTOVl93aciAfTJD43q7sFMoMp8g+p449RM5tigoCc0F75iw4W2ducLfuGxr8fQtSQuDIWvU3w5vLMEn/f1e+Es2Qmygw59qU/RsD/HIcshJNuHdJriH+roBOpQTb1J9+EhMkgSiDbzsid4ZY+RSDnVQl4P3EmqOwr6vq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742978891; c=relaxed/simple;
	bh=rM1fgvuZjHgchIiNVtEtSB8H8tN6AbjiUueRZ1K9fWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9Cy/fikFn/jQYDCU0FUOqubYcfxgVs1iTL7+c3ymFwmCf2oaNi7s9CMst8eIrQ6h0Nm35CvEX/rC+0sZ3/zNlzn3GJTs9+RCBIsApWb3yxY23MsjGOWM+zJspxWJMJwCrXlk0zdaziJZ5dHELqVn0LOQKeUzsxBEeWK2qpdiZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmxJhTwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AA4C4CEEE;
	Wed, 26 Mar 2025 08:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742978890;
	bh=rM1fgvuZjHgchIiNVtEtSB8H8tN6AbjiUueRZ1K9fWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HmxJhTweFAcarxcmnxj1toiUfd+c5nhXRDHHakb/+RmbLJUm5cljov4YpNlQFNLWP
	 +HD9IptfqDokqtmP9DyTASPMuJZCBtwWZUOxCqe5rdbgrWoCKM6AMyCat0YRr+KEBf
	 L8zT9krFy0Nr/sON/EQg1l1/ILwwRkNGK7qCpwezZNsWE5XPUZ1EYdJ8Wf8IegjaTp
	 5ZYvt/ZeLje06sB7+hmxaRe0ODoACkdn7ZrpvlD8hJOwVN5RlyxT36w8lY3VsJE3o0
	 jMMvZQK8jnFF3uK5/v9HGBIgP9yBT3cWlmYQaZHZrVBKT5E7b2WCxGLLpmCC3NnAup
	 ERVD0wwBDboNA==
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 5/5] bugs/core: Do not print CPU and PID values in__warn() output
Date: Wed, 26 Mar 2025 09:47:50 +0100
Message-ID: <20250326084751.2260634-6-mingo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250326084751.2260634-1-mingo@kernel.org>
References: <20250326084751.2260634-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For most warnings it's repeated anyway a few lines later, as
part of the register dump:

  WARNING: CPU: 0 PID: 0 at kernel/sched/core.c:8511 sched_init+0x20/0x410
           ^^^^^^^^^^^^^
  Modules linked in:
  CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.14.0-01616-g94d7af2844aa #4 PREEMPT(undef)
  ^^^^^^^^^^^^^^^^^^

In fact the later dump is richer, as it includes the 'comm' line as well.

As a side effect, this makes some space for the 'file' field to be augmented
with extra information (the condition string in particular).

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/panic.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index d8635d5cecb2..3101c21ca39f 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -725,12 +725,9 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 	disable_trace_on_warning();
 
 	if (file)
-		pr_warn("WARNING: CPU: %d PID: %d at %s:%d %pS\n",
-			raw_smp_processor_id(), current->pid, file, line,
-			caller);
+		pr_warn("WARNING: %s:%d at %pS\n", file, line, caller);
 	else
-		pr_warn("WARNING: CPU: %d PID: %d at %pS\n",
-			raw_smp_processor_id(), current->pid, caller);
+		pr_warn("WARNING: at %pS\n", caller);
 
 #pragma GCC diagnostic push
 #ifndef __clang__
-- 
2.45.2


