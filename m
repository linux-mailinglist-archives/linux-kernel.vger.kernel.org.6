Return-Path: <linux-kernel+bounces-370651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C09869A301E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E8A1C21AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B481D6DD4;
	Thu, 17 Oct 2024 21:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAf3RJLG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5F01D63DA
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 21:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729202129; cv=none; b=SIVz/TB0HkZS71jc6HGfLxBg6g4EWwLOfZfiOPcEx/M6FU3AVYK+iGCUlue9LrLWYgBeElsV3MCryHRCP7Tter0celw6m3c+yk/8HSnPoxPvVtZvx73Z0LlmijwJWMkDLh+8MqYZS26BuQVrJIx26Sw7au1ZKwePze6x9CYi5MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729202129; c=relaxed/simple;
	bh=xfgOc7lTaXmUYWAtPlY5EDc6fxKMFQn54g5tpKh/iYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/x6QgRYlATJtOuWK9mmCt68Ib/vDXNiI9hks0Q0p0GhbwG8N3u3f5Ifzs/SIhhMap2SFavx2y3za2wJD9H4ripXWyurG2d3APc/zDzT3o5KGPWRSVS7LruCnTfhK2OscegRFFhcdoDMrYc8C7UgwsmrENug+sAKR5UNy/M+HJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAf3RJLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54825C4CED2;
	Thu, 17 Oct 2024 21:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729202128;
	bh=xfgOc7lTaXmUYWAtPlY5EDc6fxKMFQn54g5tpKh/iYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tAf3RJLGarfzTLeMnQbadhPeskZRMtA2DGorwTgKO/UVRrLECKX9Jb53OUjyLQ5O+
	 RkMS9uNs6oHcwAc5nf9SB5TTqo/0q+P++YVF9PieqhHBFsJ2Nn02Vc/zATf8WMNWcz
	 6A3fk34YHGLyWGbMrzecfgFFgW+aaH/n3sO1DpZuPl71DDI7CTZA4NQnXre7u48w/+
	 tHTjzHDN8gLnQBYjN1UK5+GwCyXFeWQcQKOC3DYKqu6iGxuqv2vsi+5ltcUxGlZi4K
	 RqdTPM+H+IpoqnFYdA19gi+j6Oo8okTqCyrGJW6uWOuVKNAELOeDiY0xGGZ35JI8+2
	 XXGaZkCCJuo+Q==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Waiman Long <longman@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v2 2/6] x86/uaccess: Avoid barrier_nospec() in __get_user()
Date: Thu, 17 Oct 2024 14:55:21 -0700
Message-ID: <0777ac8e8c8d669fa56971dcba68b6f1c1980d39.1729201904.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729201904.git.jpoimboe@kernel.org>
References: <cover.1729201904.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 64-bit, the barrier_nospec() in __get_user() is overkill and
painfully slow.  Instead, use pointer masking to force the user pointer
to a non-kernel value in speculative paths.

Doing so makes get_user() and __get_user() identical in behavior, so
converge their implementations.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/lib/getuser.S | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index 094224ec9dca..7c9bf8f0b3ac 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -105,6 +105,26 @@ SYM_FUNC_START(__get_user_8)
 SYM_FUNC_END(__get_user_8)
 EXPORT_SYMBOL(__get_user_8)
 
+#ifdef CONFIG_X86_64
+
+/*
+ * On x86-64, get_user() does address masking rather than a conditional
+ * bounds check so there's no functional difference with __get_user().
+ */
+SYM_FUNC_ALIAS(__get_user_nocheck_1, __get_user_1);
+EXPORT_SYMBOL(__get_user_nocheck_1);
+
+SYM_FUNC_ALIAS(__get_user_nocheck_2, __get_user_2);
+EXPORT_SYMBOL(__get_user_nocheck_2);
+
+SYM_FUNC_ALIAS(__get_user_nocheck_4, __get_user_4);
+EXPORT_SYMBOL(__get_user_nocheck_4);
+
+SYM_FUNC_ALIAS(__get_user_nocheck_8, __get_user_8);
+EXPORT_SYMBOL(__get_user_nocheck_8);
+
+#else /* CONFIG_X86_32 */
+
 /* .. and the same for __get_user, just without the range checks */
 SYM_FUNC_START(__get_user_nocheck_1)
 	ASM_STAC
@@ -139,19 +159,16 @@ EXPORT_SYMBOL(__get_user_nocheck_4)
 SYM_FUNC_START(__get_user_nocheck_8)
 	ASM_STAC
 	ASM_BARRIER_NOSPEC
-#ifdef CONFIG_X86_64
-	UACCESS movq (%_ASM_AX),%rdx
-#else
 	xor %ecx,%ecx
 	UACCESS movl (%_ASM_AX),%edx
 	UACCESS movl 4(%_ASM_AX),%ecx
-#endif
 	xor %eax,%eax
 	ASM_CLAC
 	RET
 SYM_FUNC_END(__get_user_nocheck_8)
 EXPORT_SYMBOL(__get_user_nocheck_8)
 
+#endif /* CONFIG_X86_32 */
 
 SYM_CODE_START_LOCAL(__get_user_handle_exception)
 	ASM_CLAC
-- 
2.47.0


