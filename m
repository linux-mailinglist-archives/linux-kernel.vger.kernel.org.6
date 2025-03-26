Return-Path: <linux-kernel+bounces-576688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67713A7130C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3129B3BA9AA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CEE1AF0AE;
	Wed, 26 Mar 2025 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwuQkIxG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753CD1ADC7C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742978889; cv=none; b=IPzC3DkV1hEkAZsRQuHDYfUbN7qUov8NslCM3nFvFuxD4PTsnq56UknxP+Gjp40G9yWTRz5Hf5NkRcPs/IB+LaS5iejodU+7DiG+oPgccOJ0gXjZnBWr2OiNQv99/fxZQu8LFr+8/5X2rQdB+NDHPTPGQFc7LdrnQqW6JN1sKMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742978889; c=relaxed/simple;
	bh=s46mndiCDgBdGhU9v0W8yDZxe+ObIn5yW8f+r+yfxwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXWOlYVk626jZYryzXjZN6AXTQr7loFCtqG4aPKCX+JBPF1MOMUwOVkJpkHa/erQB90Hlmz3gGK/6FStlG9CdrPah8pks7DX2bs3SVrPgUBJxL/I+7lStK7sqSIXbTnC+/gEB4dic4liMWmP4adYsDguxW/hVTxYJwyuWsaOh5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwuQkIxG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4211C4CEEA;
	Wed, 26 Mar 2025 08:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742978889;
	bh=s46mndiCDgBdGhU9v0W8yDZxe+ObIn5yW8f+r+yfxwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LwuQkIxGUtVSzU4lh60VqKlv0r1/vcs3nzX6+RtyLlx10mo/iGrrm8i9r4RJepM1f
	 8SPhkjnBRIh3C/UpwRusgcZsW/Fd90HOPnt9mAPJSGdld86KN/biPUYtnc2Uy2BlJ6
	 ENjuJSHdc0L/Q7HJ2kciYcJ9R+Ut2Y+zwZd22W5EGhuhfzTtl3Es2OGotnUzgKaImC
	 KhQCx3oLJ+U84UBcAuR4MgospsxBWaeuIv6JF/L3uu8hTKRmUTR/3slpdknnqPTM+e
	 oB0FOArvsshEo4HP35J04MKe2YCnVt0aL/6/A4W3v3avEkMKjbK84c1SWQK3WMFSmL
	 7JgKh+L+hhWsw==
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 4/5] bugs/x86: Augment warnings output by concatenating 'cond_str' with the regular __FILE__ string in _BUG_FLAGS()
Date: Wed, 26 Mar 2025 09:47:49 +0100
Message-ID: <20250326084751.2260634-5-mingo@kernel.org>
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

This allows the reuse of the UD2 based 'struct bug_entry' low-overhead
_BUG_FLAGS() implementation and string-printing backend, without
having to add a new field.

An example:

If we have the following WARN_ON_ONCE() in kernel/sched/core.c:

	WARN_ON_ONCE(idx < 0 && ptr);

Then previously _BUG_FLAGS() would store this string in bug_entry::file:

	"kernel/sched/core.c"

After this patch, it would store and print:

	"[idx < 0 && ptr] kernel/sched/core.c"

Which is an extended string that will be printed in warnings.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/bug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index aff1c6b7a7f3..e966199c8ef7 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -50,7 +50,7 @@ do {									\
 		     "\t.org 2b+%c3\n"					\
 		     ".popsection\n"					\
 		     extra						\
-		     : : "i" (__FILE__), "i" (__LINE__),		\
+		     : : "i" (cond_str __FILE__), "i" (__LINE__),		\
 			 "i" (flags),					\
 			 "i" (sizeof(struct bug_entry)));		\
 } while (0)
-- 
2.45.2


