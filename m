Return-Path: <linux-kernel+bounces-562224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B492DA61F5D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE5F46391D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A80C2356DB;
	Fri, 14 Mar 2025 21:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peen/c8c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD3323534D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 21:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988524; cv=none; b=XCblQlH6MzQwJHqHUnlhsFdvjNjv1Q9wmWCD8tNKbD5RnLn48tsk7kCAEmrQE95Oosn1y9uRiAifJAXPWQdYnMEHEPth1ksF/n5WvgDDpHyBi+wUKi9IydH/kyaU0RVig2VUCr6DHNYPH6/GhWK4Wz5qNNkIxLk9sSJgk9+7TQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988524; c=relaxed/simple;
	bh=AreQbbOYtWwAMQIbhfmQ76qIqLFTx9WDsYMwGmBhvpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okiMlNmZFCj8naKdMcbHoPVpovsGmCd+EAyMl6Zlsm4vOe6645JNLkSelo7HMAHOynlZSttpfsBcQ3fE8if4yPgw8Lhoq9AE/aQNioPNqCu/EvJG5GmrGl0QKo0nA+wO6aSM+gQXlP1aKjPO89PJxGd4cF+gBf6hAwWc96XQXBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peen/c8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF96FC4CEEC;
	Fri, 14 Mar 2025 21:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741988524;
	bh=AreQbbOYtWwAMQIbhfmQ76qIqLFTx9WDsYMwGmBhvpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=peen/c8c4J5WCi7pvH6CNjLTHGbb53GaJbwk1vDWQknULWIYSZZ8klIJ5lUoFUSWa
	 fGBkFGcMjag94NlnGJm/npLydaePkiNZdJIHE18dL9IrK6mhPpxU8AkmPUk8onX7Ki
	 nboRfA5FtgjvqtPiYutbjJTgwInvXHQ9ZP4bO9VG30WFuE6A8ierq3sqbaxOaYSKpe
	 bpEOcFckmbmmG/nZQkoc33aifsZAV3uNH4IaABqWq5YClxgWA16FlMMLTY7Azf5zeL
	 8HcwhsUThIqwR+be3OsibiLO5GhMSlizFO0TIGNtm4QUGyJPi4x7Q2OAyidrGAvwDE
	 YZdudgjtjTb7A==
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
Subject: [PATCH 18/20] x86/smap: Use alternative_io() in smap_{save,restore}()
Date: Fri, 14 Mar 2025 14:41:31 -0700
Message-ID: <1f39866bca670a7d0087febee29ab5061b8f9fef.1741988314.git.jpoimboe@kernel.org>
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

Use the standard alternative_io() interface.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/smap.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
index 60ea21b4c8b7..8b77ddcb37e7 100644
--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -39,20 +39,22 @@ static __always_inline unsigned long smap_save(void)
 {
 	unsigned long flags;
 
-	asm volatile ("# smap_save\n\t"
-		      ALTERNATIVE("",
-				  "pushf; pop %[flags]; clac\n\t", X86_FEATURE_SMAP)
-		      : [flags] "=rm" (flags) : : "memory", "cc");
+	alternative_io("",
+		       "pushf; pop %[flags]; clac\n\t", X86_FEATURE_SMAP,
+		       ARG([flags] "=rm" (flags)),
+		       ARG(),
+		       ARG("memory", "cc"));
 
 	return flags;
 }
 
 static __always_inline void smap_restore(unsigned long flags)
 {
-	asm volatile ("# smap_restore\n\t"
-		      ALTERNATIVE("",
-				  "push %[flags]; popf\n\t", X86_FEATURE_SMAP)
-		      : : [flags] "g" (flags) : "memory", "cc");
+	alternative_io("",
+		       "push %[flags]; popf\n\t", X86_FEATURE_SMAP,
+		       ARG(),
+		       ARG([flags] "g" (flags)),
+		       ARG("memory", "cc"));
 }
 
 /* These macros can be used in asm() statements */
-- 
2.48.1


