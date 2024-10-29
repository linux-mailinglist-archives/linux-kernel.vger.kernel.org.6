Return-Path: <linux-kernel+bounces-386171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B63919B4000
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCD81F2335F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2498192B95;
	Tue, 29 Oct 2024 01:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2peZm0O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0D3192597
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730167002; cv=none; b=WTPaq1mqJWCivewwv+JAK4LPUWGMGSLaLRn7GauocjVVKANGxvB9aSg4A3QlfxBd+ZgqQzIPx3bN1o2tKE8JEDktNNYl5gnMk173AtcobcTUHMieQFD+nJhZaKrZ3jW80K7/hxfLKIk+yhNst5E6hDbtyeUAM0hephfXKRImpPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730167002; c=relaxed/simple;
	bh=IH1dsBAzC1/NpJlrtMMREhzqss6Zpig4JOkpaJnGywY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SxpsGN3uRcyiGjPP3/D+a2/YQIyZTp76W0uyWm7PNTAtckQyQVH9pvsLDdlKI4w01dza0HMXtZrghc0JokjW1cf3zwWjA4FnViw/8ecM5KYhX7UigIRzg6Lu+ROUkwqVJlemPlG+qUOzLCH9BxHqwsdYEsLLYrAMAmTqKJx6xKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2peZm0O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F036DC4CEF0;
	Tue, 29 Oct 2024 01:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730167001;
	bh=IH1dsBAzC1/NpJlrtMMREhzqss6Zpig4JOkpaJnGywY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X2peZm0O71m3epHvfIPaBj3APxpxfGhiAsSTBzDsBoPz7gMoTX2iJ8O7bUUwXqf41
	 FFG4jMF9Bc1/4auMk4Cow8uemoyn2VKep/jQAqriZNwKcKiLM2vQGlQQ4BTS0SanDH
	 cXqkPX8mSf9NeN9bHG/7jZ5oVITF942ntMW2U9lBnmr4Fyn2EhGuGzXuEtGca7XYPf
	 WL3qXZLipOH8LC+/mFN64Pt6/hS6JJYtYPCO4Iq9dT62GTtejsVShVWu8spWELKt+w
	 c7FhnzmjYsirTRtAGVHh3TEuwKi6BX0hJ1j+D/UGtQXkAI7EdDVKVmoZUzlFKlbKfX
	 xo2dlU2WSsCHg==
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
Subject: [PATCH v3 6/6] x86/uaccess: Converge [__]get_user() implementations
Date: Mon, 28 Oct 2024 18:56:19 -0700
Message-ID: <d8fcb2f521c5186639d1cfd296ddc672d9c224f4.1730166635.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730166635.git.jpoimboe@kernel.org>
References: <cover.1730166635.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The x86 implementations of get_user() and __get_user() are now
identical.  Merge their implementations and make the __get_user()
implementations aliases of their get_user() counterparts.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/lib/getuser.S | 58 +++++++++---------------------------------
 1 file changed, 12 insertions(+), 46 deletions(-)

diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index 7da4fc75eba9..6f4dcb80dd46 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -103,53 +103,19 @@ SYM_FUNC_START(__get_user_8)
 SYM_FUNC_END(__get_user_8)
 EXPORT_SYMBOL(__get_user_8)
 
-/* .. and the same for __get_user, just without the range checks */
-SYM_FUNC_START(__get_user_nocheck_1)
-	mask_user_address size=1
-	ASM_STAC
-	UACCESS movzbl (%_ASM_AX),%edx
-	xor %eax,%eax
-	ASM_CLAC
-	RET
-SYM_FUNC_END(__get_user_nocheck_1)
-EXPORT_SYMBOL(__get_user_nocheck_1)
-
-SYM_FUNC_START(__get_user_nocheck_2)
-	mask_user_address size=2
-	ASM_STAC
-	UACCESS movzwl (%_ASM_AX),%edx
-	xor %eax,%eax
-	ASM_CLAC
-	RET
-SYM_FUNC_END(__get_user_nocheck_2)
-EXPORT_SYMBOL(__get_user_nocheck_2)
-
-SYM_FUNC_START(__get_user_nocheck_4)
-	mask_user_address size=4
-	ASM_STAC
-	UACCESS movl (%_ASM_AX),%edx
-	xor %eax,%eax
-	ASM_CLAC
-	RET
-SYM_FUNC_END(__get_user_nocheck_4)
-EXPORT_SYMBOL(__get_user_nocheck_4)
-
-SYM_FUNC_START(__get_user_nocheck_8)
-	mask_user_address size=8
-	ASM_STAC
-#ifdef CONFIG_X86_64
-	UACCESS movq (%_ASM_AX),%rdx
-#else
-	xor %ecx,%ecx
-	UACCESS movl (%_ASM_AX),%edx
-	UACCESS movl 4(%_ASM_AX),%ecx
-#endif
-	xor %eax,%eax
-	ASM_CLAC
-	RET
-SYM_FUNC_END(__get_user_nocheck_8)
-EXPORT_SYMBOL(__get_user_nocheck_8)
+/*
+ * On x86-64, get_user() does address masking rather than a conditional bounds
+ * check so there's no functional difference compared to __get_user().
+ */
+SYM_FUNC_ALIAS(__get_user_nocheck_1, __get_user_1);
+SYM_FUNC_ALIAS(__get_user_nocheck_2, __get_user_2);
+SYM_FUNC_ALIAS(__get_user_nocheck_4, __get_user_4);
+SYM_FUNC_ALIAS(__get_user_nocheck_8, __get_user_8);
 
+EXPORT_SYMBOL(__get_user_nocheck_1);
+EXPORT_SYMBOL(__get_user_nocheck_2);
+EXPORT_SYMBOL(__get_user_nocheck_4);
+EXPORT_SYMBOL(__get_user_nocheck_8);
 
 SYM_CODE_START_LOCAL(__get_user_handle_exception)
 	ASM_CLAC
-- 
2.47.0


