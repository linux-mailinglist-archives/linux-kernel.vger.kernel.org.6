Return-Path: <linux-kernel+bounces-574496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E58A6E5F9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1568173A50
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397891F2B82;
	Mon, 24 Mar 2025 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFqBHEgb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CCF1F151B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853386; cv=none; b=YTF/fIt5v2UDTHGQYuI4LyiarPhYVf1EhNRYuE/64+l72SjZvlSphJ7ly1xobyvm7qUoJJwfTNL3UcAGTuCnvp90bvV2gkplgS+MJz7vVDu8VRWI0oMDH3z4NRXy5EhaZpOkQBhm3OX5ScK6g6bUlo+TrsnZJHHYIhE709kAxCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853386; c=relaxed/simple;
	bh=aBDMNLcDU6h6g4YKrzDky3LA6LD1n2gyF+z9f/hf9Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWKas4985W/OvWou3YvX6XjrY46aDZuGFEMuB43Kuf+Nu01QRkUi9hqJmr2bVFk45aHI35UfIlRkMG1bRXLKnqQa2QOPr7Ka0tc8pG85x9p+L5UXWRXgDNbO3BG916WdfmerCPLDEQY6CgRiTJKOCarDN6y+8frfk2sCt0igPb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFqBHEgb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C12FC4CEE4;
	Mon, 24 Mar 2025 21:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742853386;
	bh=aBDMNLcDU6h6g4YKrzDky3LA6LD1n2gyF+z9f/hf9Ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NFqBHEgbWNOfHb44J9n1c0fGq6REmLXE+XyJMLl3pnL5eEwiO1cTX/XxCvy76ZRXg
	 yelXrlgtiSNUFN3PmPnnLF/e3UdiPDmiigw/h7BcFHW96ig0l99sAGZkp2zCnrvqj6
	 XNgCQyNAviNiqmGvaPTekToFgkLZomK/pqs1mOjsmHwJvS/yQrloE8zJcmz6pJmWpW
	 FaQ28RsKzVRx3a9phWO5fMg/J//nrv3nH0HPkfbnwLmAqZ5lY31RLNT8ijHt4fbMsw
	 K+T3E7NGE5k1YmRDyQ/J4lg0gK2iVoxjvLAVGnhmETy6b+zClr2AzYl+C78f1eZ9FQ
	 o8DL4ChMPSmpg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 11/22] objtool: Fix up some outdated references to ENTRY/ENDPROC
Date: Mon, 24 Mar 2025 14:56:01 -0700
Message-ID: <5eb7e06e1a0e87aaeda8d583ab060e7638a6ea8e.1742852846.git.jpoimboe@kernel.org>
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

ENTRY and ENDPROC were deprecated years ago and replaced with
SYM_FUNC_{START,END}.  Fix up a few outdated references in the objtool
documentation and comments.  Also fix a few typos.

Suggested-by: Brendan Jackman <jackmanb@google.com>
Suggested-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/linkage.h                 |  4 ----
 include/linux/objtool.h                 |  2 +-
 tools/objtool/Documentation/objtool.txt | 10 +++++-----
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index 5c8865bb59d9..b11660b706c5 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -134,10 +134,6 @@
 	.size name, .-name
 #endif
 
-/* If symbol 'name' is treated as a subroutine (gets called, and returns)
- * then please use ENDPROC to mark 'name' as STT_FUNC for the benefit of
- * static analysis tools such as stack depth analyzer.
- */
 #ifndef ENDPROC
 /* deprecated, use SYM_FUNC_END */
 #define ENDPROC(name) \
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index c722a921165b..248d9363ca85 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -69,7 +69,7 @@
  * In asm, there are two kinds of code: normal C-type callable functions and
  * the rest.  The normal callable functions can be called by other code, and
  * don't do anything unusual with the stack.  Such normal callable functions
- * are annotated with the ENTRY/ENDPROC macros.  Most asm code falls in this
+ * are annotated with SYM_FUNC_{START,END}.  Most asm code falls in this
  * category.  In this case, no special debugging annotations are needed because
  * objtool can automatically generate the ORC data for the ORC unwinder to read
  * at runtime.
diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
index 28ac57b9e102..9e97fc25b2d8 100644
--- a/tools/objtool/Documentation/objtool.txt
+++ b/tools/objtool/Documentation/objtool.txt
@@ -34,7 +34,7 @@ Objtool has the following features:
 - Return thunk annotation -- annotates all return thunk sites so kernel
   can patch them inline, depending on enabled mitigations
 
-- Return thunk training valiation -- validate that all entry paths
+- Return thunk untraining validation -- validate that all entry paths
   untrain a "safe return" before the first return (or call)
 
 - Non-instrumentation validation -- validates non-instrumentable
@@ -281,8 +281,8 @@ the objtool maintainers.
    If the error is for an asm file, and func() is indeed a callable
    function, add proper frame pointer logic using the FRAME_BEGIN and
    FRAME_END macros.  Otherwise, if it's not a callable function, remove
-   its ELF function annotation by changing ENDPROC to END, and instead
-   use the manual unwind hint macros in asm/unwind_hints.h.
+   its ELF function annotation by using SYM_CODE_{START,END} and use the
+   manual unwind hint macros in asm/unwind_hints.h.
 
    If it's a GCC-compiled .c file, the error may be because the function
    uses an inline asm() statement which has a "call" instruction.  An
@@ -352,7 +352,7 @@ the objtool maintainers.
    This is a kernel entry/exit instruction like sysenter or iret.  Such
    instructions aren't allowed in a callable function, and are most
    likely part of the kernel entry code.  Such code should probably be
-   placed in a SYM_FUNC_CODE block with unwind hints.
+   placed in a SYM_CODE_{START,END} block with unwind hints.
 
 
 6. file.o: warning: objtool: func()+0x26: sibling call from callable instruction with modified stack frame
@@ -381,7 +381,7 @@ the objtool maintainers.
 
    Another possibility is that the code has some asm or inline asm which
    does some unusual things to the stack or the frame pointer.  In such
-   cases it's probably appropriate to use SYM_FUNC_CODE with unwind
+   cases it's probably appropriate to use SYM_CODE_{START,END} with unwind
    hints.
 
 
-- 
2.48.1


