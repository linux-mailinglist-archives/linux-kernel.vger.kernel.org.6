Return-Path: <linux-kernel+bounces-562209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1A3A61F3E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA0D3B9A24
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED342066C4;
	Fri, 14 Mar 2025 21:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdc3W5Ae"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95FA1C84C9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 21:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988516; cv=none; b=QEFjvU14lRLFS6jVqIxsncq6sueRJ4508zfa4eq6hWg/DBVAm+SuMdrWFiEpRTy0Tmg55c58kryvxI3nw5y7hNoWXDLhdfGlY/KEq7k/qKd49q4nrSl1tlTEq8skA1RDpakGjf3X2YQ41HhvuQ4FIxqNtGboUjkxJFRPNLEJbRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988516; c=relaxed/simple;
	bh=QAJqgGLEgB7Uus6Hk6A5Xn5+3cxtjhIC2QgVp51gRuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OmD/2XMISUqh3z926VAxM+7aw7C3HKDAi4R4UpIkn6JFIYCAZ5xvmcXCumEZye6MpedKI5p7DJs19YOD7qdfhZ4YkZoKZtM4/KjDRQbO30BR7XIp9KR3gPOXok7Y6Wg6pgrOCL6iHXSUyRz9JElc7sqN+Xe+4mfx3fdVeyHfuuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdc3W5Ae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B6DC2BCFA;
	Fri, 14 Mar 2025 21:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741988516;
	bh=QAJqgGLEgB7Uus6Hk6A5Xn5+3cxtjhIC2QgVp51gRuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kdc3W5AeKZY8S2hbQeBmv4Bu+7hWvFGu3cmFbRwRZoqz1H/GdCTysdmn8QhG4q+Kj
	 F9vq9zOfSx05bdh2VJwSLfedd0ucU8iiELBfqoHhtQlTOqpEBbpaTfmHPl8QQGSNPr
	 +evwcNs/3x33FH0cPYSOeh8MsZXlbZCS2WLGDqaCmFlJYQEB4s5NZ9AR5x8+XVk4FA
	 XGAOKRw49RNiKTT3YvckUc/944uv/8oFx4rdUC2XWmhFMn91amSUBIq/u5onsd982o
	 /D0N+jzsZ+1oRSsiHu1WvjkqlCaWghWY8Z2qZeVwxYJT0qxGwnlO3kTSABr4hRKRwd
	 5UPO8aYD/ZZnQ==
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
Subject: [PATCH 04/20] x86/cpu: Use named asm operands in clflushopt()
Date: Fri, 14 Mar 2025 14:41:17 -0700
Message-ID: <c007f4ddbfdfe92777a7df35bc121cf9bf0d0682.1741988314.git.jpoimboe@kernel.org>
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

Use named operands in preparation for removing the operand numbering
restrictions in alternative_io().

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/special_insns.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 21ce480658b1..b905076cf7f6 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -176,10 +176,9 @@ static __always_inline void clflush(volatile void *__p)
 
 static inline void clflushopt(volatile void *__p)
 {
-	alternative_io(".byte 0x3e; clflush %0",
-		       ".byte 0x66; clflush %0",
-		       X86_FEATURE_CLFLUSHOPT,
-		       "+m" (*(volatile char __force *)__p));
+	alternative_io(".byte 0x3e; clflush %[val]",
+		       ".byte 0x66; clflush %[val]", X86_FEATURE_CLFLUSHOPT,
+		       [val] "+m" (*(volatile char __force *)__p));
 }
 
 static inline void clwb(volatile void *__p)
-- 
2.48.1


