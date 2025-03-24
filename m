Return-Path: <linux-kernel+bounces-574502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD52A6E60D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6993B8F4E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837CA1F4610;
	Mon, 24 Mar 2025 21:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qn6UzrqT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56721EB5F4
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853389; cv=none; b=Nyo8rcVejVBIDyem0r9+yeOq6haWgIOQ/Lex0qa3IoHgrAFNAlxsL6IucOuUJjATiAPvOndmyxfsLAdp8FqnkBuKq4Q24e5fYHy6M0rb723g/0hMUMUp2AxkaURC/GXNCTwPS6d60KAKjCvx/x8f7EO+61VTP3P32ZilF/hWS4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853389; c=relaxed/simple;
	bh=Q0e+jxUlQcnZIxhwPBuE5JgMeJO9eNl4R7CNugxR5gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUGVAcSi5NKKqsQMCqot8OeUD1hoHa2Lxy12oMhyaGg9bWBUk5slXXxEC8YRc4xAxy9rF0yuavJsnbHcC4vCAtlnse0ecGMuxfRjzw5o15Smhm9VeY+sY3+X5mULz6V/FMR0rMoRgffEnW0EmNwbI8w+R9O5fFAvU2ODz9vh7Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qn6UzrqT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F108C4CEDD;
	Mon, 24 Mar 2025 21:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742853389;
	bh=Q0e+jxUlQcnZIxhwPBuE5JgMeJO9eNl4R7CNugxR5gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qn6UzrqT6xep3HeIv1eyz62P3PLrDOL9PCilW8yIqIHmKPQfYECAgQc1cFF3qoSQx
	 NAMfQ9h04qofOjJjiVNT8fCkuPaeRP2wKJZ7nLaY6EU9A2Xt3HrrKljAFgA0sQame5
	 jl1ofpYxCapvRdiqOWo//06/CUA3/allCC9EL2zWKcvdOi1ilEwUXKCCI3IxSVQecM
	 +O02Q49BL5WBBrSpyEXXHimVCjDAd+GLRhY+nyjy7HWbcToxgPrAdRHe73mANV/311
	 fgC6/C7TrQYsd49KbVjVhiwVxcZnzMYapGnUdGu4F3zYJbZDWi0HRKDsHQoNRKsKET
	 pMs5llV5rfmfg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 17/22] panic: Disable SMAP in __stack_chk_fail()
Date: Mon, 24 Mar 2025 14:56:07 -0700
Message-ID: <a3e97e0119e1b04c725a8aa05f7bc83d98e657eb.1742852847.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742852846.git.jpoimboe@kernel.org>
References: <cover.1742852846.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__stack_chk_fail() can be called from uaccess-enabled code.  Make sure
uaccess gets disabled before calling panic().

Fixes the following warning:

  kernel/trace/trace_branch.o: error: objtool: ftrace_likely_update+0x1ea: call to __stack_chk_fail() with UACCESS enabled

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 kernel/panic.c        | 6 ++++++
 tools/objtool/check.c | 5 ++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index d8635d5cecb2..f9f0c5148f6a 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -832,9 +832,15 @@ device_initcall(register_warn_debugfs);
  */
 __visible noinstr void __stack_chk_fail(void)
 {
+	unsigned long flags;
+
 	instrumentation_begin();
+	flags = user_access_save();
+
 	panic("stack-protector: Kernel stack is corrupted in: %pB",
 		__builtin_return_address(0));
+
+	user_access_restore(flags);
 	instrumentation_end();
 }
 EXPORT_SYMBOL(__stack_chk_fail);
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f4b9fcc395eb..a953ce5fe395 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1194,12 +1194,15 @@ static const char *uaccess_safe_builtin[] = {
 	"__ubsan_handle_load_invalid_value",
 	/* STACKLEAK */
 	"stackleak_track_stack",
+	/* TRACE_BRANCH_PROFILING */
+	"ftrace_likely_update",
+	/* STACKPROTECTOR */
+	"__stack_chk_fail",
 	/* misc */
 	"csum_partial_copy_generic",
 	"copy_mc_fragile",
 	"copy_mc_fragile_handle_tail",
 	"copy_mc_enhanced_fast_string",
-	"ftrace_likely_update", /* CONFIG_TRACE_BRANCH_PROFILING */
 	"rep_stos_alternative",
 	"rep_movs_alternative",
 	"__copy_user_nocache",
-- 
2.48.1


