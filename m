Return-Path: <linux-kernel+bounces-420112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A75BD9D7655
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 18:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 108DCC41FF4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 15:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A82189F57;
	Sun, 24 Nov 2024 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKlqqnRx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573F818787A;
	Sun, 24 Nov 2024 14:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732457238; cv=none; b=QeQiUp4K7Ob+1xnsVg8mxnnPgr77Nqwyv3ODztg7qgey3OQVEQj1JGMB/CP+AUsYEbRZXnwRj33vXc7qf3t12DBvZA0O2TjNVnlWDNhZxNgm0iygYS+CofMiChNw7wm6OA+tQsQJLLpGGLukOtAQY+mlGipOkzTf05v7Ms+9Gj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732457238; c=relaxed/simple;
	bh=hEsIg8aAsdwalXsLOpm5dcCFEtD8GwTLrcsPwRmzB3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IrBNoob4YQm5u4z47PFvfpDDNYmDd5vRnbg5g8Ys4drKH56+oNYptvl5r6goa2ypMYmPH/SKcdhbGqJ/jvLCivX20OaYArHyHrASiK7HDd831e49PloeCsH5YHdPp6Bq1hgieHthXh5P8JQ2jC/gg1S8gSL1XEm+5Q4u+Rm8HdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKlqqnRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2987C4CED1;
	Sun, 24 Nov 2024 14:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732457237;
	bh=hEsIg8aAsdwalXsLOpm5dcCFEtD8GwTLrcsPwRmzB3w=;
	h=From:To:Cc:Subject:Date:From;
	b=sKlqqnRxgFPibjFENI175GGmn+Zw27RmsXUKJ2BZz72gXCHNh3r6bk+gJmmFqCzrj
	 yg2/k2MQ9Bbw59Y3/cETbVRjZSYZtVXfSW3YZNYkiNMg3lm7baiEcKzA9OUbZe2nc6
	 d1MpmMk5otREdlwFkAPfcPw1APEJelOGIyYckk65SLSJJVIHjjWcY5B7B0VLn1Ypzp
	 fc5lT2Qr+8vY95VTZ/gsp6ynDZeSJPVcbfl9BUCkcSJKtYaehsKeH0hBZc1BoFHcxF
	 Sif529F6ln5SYpdgnqhr50/2ABF7y1AvOhGIfEwerG93gzp1LmhsSHfyszTD2VnRoN
	 NZrb/MlBd0VYQ==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH] x86/ftrace: fix boot time slowdown
Date: Sun, 24 Nov 2024 16:07:05 +0200
Message-ID: <20241124140705.2883-1-rppt@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Steven Rostedt reported slowdown by over 30ms caused by commit 9bfc4824fd48
("x86/module: prepare module loading for ROX allocations of text")

  Before:

   # cat /sys/kernel/tracing/dyn_ftrace_total_info
  57695 pages:231 groups: 9
  ftrace boot update time = 14733459 (ns)
  ftrace module total update time = 449016 (ns)

  After:

   # cat /sys/kernel/tracing/dyn_ftrace_total_info
  57708 pages:231 groups: 9
  ftrace boot update time = 47195374 (ns)
  ftrace module total update time = 592080 (ns)

The slowdown happened because initial patching of kernel code for ftrace
was switched from text_poke_early() to text_poke() to accommodate ftrace
updates of module text allocated as ROX.

Restore the use of text_poke_early() for boot time patching of the kernel
code.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Closes: https://lore.kernel.org/all/20241118132501.4eddb46c@gandalf.local.home
Fixes: 9bfc4824fd48 ("x86/module: prepare module loading for ROX allocations of text")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/kernel/ftrace.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 4dd0ad6c94d6..9e50288abbaa 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -111,7 +111,7 @@ static int ftrace_verify_code(unsigned long ip, const char *old_code)
  */
 static int __ref
 ftrace_modify_code_direct(unsigned long ip, const char *old_code,
-			  const char *new_code)
+			  const char *new_code, struct module *mod)
 {
 	int ret = ftrace_verify_code(ip, old_code);
 	if (ret)
@@ -120,6 +120,8 @@ ftrace_modify_code_direct(unsigned long ip, const char *old_code,
 	/* replace the text with the new text */
 	if (ftrace_poke_late) {
 		text_poke_queue((void *)ip, new_code, MCOUNT_INSN_SIZE, NULL);
+	} else if (!mod) {
+		text_poke_early((void *)ip, new_code, MCOUNT_INSN_SIZE);
 	} else {
 		mutex_lock(&text_mutex);
 		text_poke((void *)ip, new_code, MCOUNT_INSN_SIZE);
@@ -145,7 +147,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec, unsigned long ad
 	 * just modify the code directly.
 	 */
 	if (addr == MCOUNT_ADDR)
-		return ftrace_modify_code_direct(ip, old, new);
+		return ftrace_modify_code_direct(ip, old, new, mod);
 
 	/*
 	 * x86 overrides ftrace_replace_code -- this function will never be used
@@ -164,7 +166,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	new = ftrace_call_replace(ip, addr);
 
 	/* Should only be called when module is loaded */
-	return ftrace_modify_code_direct(rec->ip, old, new);
+	return ftrace_modify_code_direct(rec->ip, old, new, NULL);
 }
 
 /*

base-commit: 9f16d5e6f220661f73b36a4be1b21575651d8833
-- 
2.45.2


