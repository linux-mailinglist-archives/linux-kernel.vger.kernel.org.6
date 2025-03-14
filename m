Return-Path: <linux-kernel+bounces-562215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68677A61F4E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0233BAAFE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61811207E0A;
	Fri, 14 Mar 2025 21:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPiLjhuX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EF12236FF
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988519; cv=none; b=uek8HmHVjRfYpcYjAWbfFzTG1YpF0l0xP9sBE4jUzRueISRpyzSZPmiBGc3K59MekGI0oLvYIIsc9yWgDRYH33KbXXrqHjRHgm3TlBQ/eJta2kl4wvOa57wBemB3nHgp+CCEnDgtYEBAjSZ7FTu0J+oyz3xmxPZeZ5Ic9RCvBMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988519; c=relaxed/simple;
	bh=aH0rkUHCdMTzerOSvwPo+McsPGNQiwPk8iR1J5A1GLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6+iYuZrOt18tgIPJ09F5aQ5V3QrV+WogC0ZwLvR+Zkx5xbJPrfHEaS7udjRlYGItn6l1110o5yDeeKDzMyWrBFe5j28brgNWHTWoKlaEVQx/NxbAA9Em4msFlT6KdvODDVQES52Dp6EExuzkE+ZRrKihv5gzq46ET+tt7+U8eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPiLjhuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F91C4CEEE;
	Fri, 14 Mar 2025 21:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741988519;
	bh=aH0rkUHCdMTzerOSvwPo+McsPGNQiwPk8iR1J5A1GLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mPiLjhuXgIQqEI4VteXg13KpBAwFY3uLetHjDNAgNzwibFsOlcnIAsDexqYpt8QQO
	 /+Dn5NWcTbfqfg/yFwUDZOi7hj1vPnaheJKIX9fXVkdvp5Udczb8Btt1RVWZzsF9ym
	 qwVm7mvMx9Borf3aeXbOusdhxf3wrCjsewQJwKS0spU8xyU64VkODM9DmmP1jTId3Q
	 uaRLDbHIzIr0l6aK8U8bysTPcIDTFYLTigIM8lUbhmVog7vn703yBKmgV3Z0Qf5RtI
	 nzpqw+uN2YWP2lrL64RpA8cgQ79qdBad/q732ws3+L7u/z26L9H7JKERcA9whqhmMq
	 CFmIuDEFm0Y2w==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 09/20] x86/alternative: Simplify alternative_io() interface
Date: Fri, 14 Mar 2025 14:41:22 -0700
Message-ID: <ede5fcf72e26fc0a6f443d7393c804e39d51c029.1741988314.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741988314.git.jpoimboe@kernel.org>
References: <cover.1741988314.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to alternative_call(), change alternative_io() to allow outputs,
inputs, and clobbers to be specified individually.

Also add in the "memory" clobber for consistent behavior with the other
alternative macros.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/alternative.h   | 15 +++++++++++----
 arch/x86/include/asm/apic.h          |  3 ++-
 arch/x86/include/asm/special_insns.h |  3 ++-
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 3804b82cb03c..870b1633e1e0 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -219,10 +219,17 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	asm_inline volatile(ALTERNATIVE(oldinstr, newinstr, ft_flags) \
 		: : input)
 
-/* Like alternative_input, but with a single output argument */
-#define alternative_io(oldinstr, newinstr, ft_flags, output, input...)	\
-	asm_inline volatile(ALTERNATIVE(oldinstr, newinstr, ft_flags)	\
-		: output : input)
+/*
+ * Alternative inline assembly with input, output and clobbers.
+ *
+ * All @output, @input, and @clobbers should be wrapped with ARG() for both
+ * functionality and readability reasons.
+ */
+#define alternative_io(oldinstr, newinstr, ft_flags, output, input, clobbers...)	\
+	asm_inline volatile(ALTERNATIVE(oldinstr, newinstr, ft_flags)			\
+			    : output							\
+			    : input							\
+			    : "memory", ## clobbers)
 
 /*
  * Like alternative_io, but for replacing a direct call with another one.
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 6526bad6ec81..8b0c2a392f8b 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -100,7 +100,8 @@ static inline void native_apic_mem_write(u32 reg, u32 v)
 
 	alternative_io("movl %[val], %[mem]",
 		       "xchgl %[val], %[mem]", X86_BUG_11AP,
-		       ARG([val] "+r" (v), [mem] "+m" (*addr)));
+		       ARG([val] "+r" (v), [mem] "+m" (*addr)),
+		       ARG());
 }
 
 static inline u32 native_apic_mem_read(u32 reg)
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index a6a3f4c95f03..16fb2bc09059 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -178,7 +178,8 @@ static inline void clflushopt(volatile void *__p)
 {
 	alternative_io(".byte 0x3e; clflush %[val]",
 		       ".byte 0x66; clflush %[val]", X86_FEATURE_CLFLUSHOPT,
-		       ARG([val] "+m" (*(volatile char __force *)__p)));
+		       ARG([val] "+m" (*(volatile char __force *)__p)),
+		       ARG());
 }
 
 static inline void clwb(volatile void *__p)
-- 
2.48.1


