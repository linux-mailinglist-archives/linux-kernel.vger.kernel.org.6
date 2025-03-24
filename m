Return-Path: <linux-kernel+bounces-574493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40DAA6E5F8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3A71736B6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620F11F1507;
	Mon, 24 Mar 2025 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l34lNBNN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808EB1F09B4
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853385; cv=none; b=dFZg4vgHBzxLW8L67JqE5BZbX2tDmED5u/dJmq4L8aB04NLLT3eoLy8z6UPJARfkGBtm0Dgd6src6YoLFfCjUQY6nNMkGm1imXB7AcM2mDZnwcWqUQ9bQNIQ3ZdR0YrmmnkYJqrCt+qzgMAYCMjpTF4SdU+z6w7dg6AL78pS0CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853385; c=relaxed/simple;
	bh=9KzMx8OrH5KiE28WpHpZyYhsLXyYJsiCVOCb8tcq390=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jztuw6UePEWBd62xfFzn0QOZW6j0+ISuy6SjTDFgBA7mYY0Ar62wdRhidu62jBsnUFsdXv3ZoNgn0CwBRrDa85SKhRrHf/7ecsH4alNPdpu7LA+o1iWqNA0On2tk1a+S04DrcNrArElvuEYoLZxFx2Ie5q24p/AJrW/ALMPE8Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l34lNBNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C52C4CEDD;
	Mon, 24 Mar 2025 21:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742853385;
	bh=9KzMx8OrH5KiE28WpHpZyYhsLXyYJsiCVOCb8tcq390=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l34lNBNNFttCdH7gl+2VjvFRZVOY+rWDnpDBU5QnfhOUvrfuGGWDNCc3cu95wktpl
	 tV3nvB37cJyz57FZ2bRLZmdqPKIk1ZvMmvn8t2KKoXFEnGevY3NpFbvFbKlY5omHpu
	 qDAV+vXSnTfrZVGil3VXYNNh2hxm6g/lwNtthFYpBP9qfINBB9G1fMcWz3+AYqgXvL
	 sdWu+GgZU13fJsY+xJ2zBtIgVa7BJ8QzZr0SFqrVYcHoofieKYgsFWrKHKiB8v43qv
	 8SX2CIp85e0/1NT/5tJZefUvYgHPrPsPqr9KITH6p2swGI/YzyBm2hIBL7MceSaGEt
	 lxykG0Lwfh9iw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 08/22] objtool: Properly disable uaccess validation
Date: Mon, 24 Mar 2025 14:55:58 -0700
Message-ID: <0e95581c1d2107fb5f59418edf2b26bba38b0cbb.1742852846.git.jpoimboe@kernel.org>
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

If opts.uaccess isn't set, the uaccess validation is disabled, but only
partially: it doesn't read the uaccess_safe_builtin list but still tries
to do the validation.  Disable it completely to prevent false warnings.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 032b3be409f2..3966fc81a77e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3195,7 +3195,7 @@ static int handle_insn_ops(struct instruction *insn,
 		if (update_cfi_state(insn, next_insn, &state->cfi, op))
 			return 1;
 
-		if (!insn->alt_group)
+		if (!opts.uaccess || !insn->alt_group)
 			continue;
 
 		if (op->dest.type == OP_DEST_PUSHF) {
@@ -3655,6 +3655,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			return 0;
 
 		case INSN_STAC:
+			if (!opts.uaccess)
+				break;
+
 			if (state.uaccess) {
 				WARN_INSN(insn, "recursive UACCESS enable");
 				return 1;
@@ -3664,6 +3667,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			break;
 
 		case INSN_CLAC:
+			if (!opts.uaccess)
+				break;
+
 			if (!state.uaccess && func) {
 				WARN_INSN(insn, "redundant UACCESS disable");
 				return 1;
@@ -4122,7 +4128,8 @@ static int validate_symbol(struct objtool_file *file, struct section *sec,
 	if (!insn || insn->visited)
 		return 0;
 
-	state->uaccess = sym->uaccess_safe;
+	if (opts.uaccess)
+		state->uaccess = sym->uaccess_safe;
 
 	ret = validate_branch(file, insn_func(insn), insn, *state);
 	if (ret)
-- 
2.48.1


