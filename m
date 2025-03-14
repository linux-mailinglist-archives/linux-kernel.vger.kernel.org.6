Return-Path: <linux-kernel+bounces-562225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 553C1A61F5E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BD541897D7D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA8A236A99;
	Fri, 14 Mar 2025 21:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQZfgOzL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA54235C01
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 21:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988525; cv=none; b=mdt1m3mKCDJs07PMfopqe4PM+/jBXj7gXQ54NbcO+s7QnJneoGfBKDwMhlpvFlD0ptbnpxJ2AWH8LTYePPmllKyAqK83lvWuhjoAh5vP1Hx9CnbH6eQ3HaBFvbYXrWIc2eo06OBvP3vt6Jz9XlY6VnXXkfpj9ryNzn/IVVkiqTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988525; c=relaxed/simple;
	bh=qkGFv5PkAYcsVJJDYuUSexRQt+wXN3/4FXTTpwxW2NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDOby0vu7JNSbJrTSqq+QhC0YKWPV530lLCM2Vr8Tz+zJmjyD6537hnA+lldg31bgg8i1ZUsTTffEA8uEplmopLIBogUOApnxvUoeispPWgfm/DW+qjiaiZTqDG48v5/nrMiN6EGZZfudFdzMwIoGWxB/7OaPyu6eka9d48axKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQZfgOzL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E4CC4CEEF;
	Fri, 14 Mar 2025 21:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741988524;
	bh=qkGFv5PkAYcsVJJDYuUSexRQt+wXN3/4FXTTpwxW2NI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nQZfgOzL1IkA/XyvFXbht5J0EPTQVYmV5Z7C8DDVCDs9yuZdttYIvwRxsUbLPLlZe
	 cecAEaGCpwNkL/56dllMDJ1e430Dze7US1UlVwwEnZJCnVrQDgSK8XVC5iHXXbvG9X
	 LPeiUcAObJiaW4jHh8ydRAUbLVHb2x5j1y6rVfGOZk2MacTsJyZBlxRVoNN9xq2a9h
	 H5unFA3tBLpMGx5xbjo0tCVVvzpk7blLZm8eNaOWGNDJj3nAAwZ5WWrWqTKZSMHeXf
	 fEFniofwyX+I8ViUNlUVf4j3pHAV5amugYUTjIgCV3/u+GGdolLhuF+ItPTll6aEkG
	 izSC6QT3RQi3g==
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
Subject: [PATCH 19/20] x86/uaccess: Use alternative_io() in __untagged_addr()
Date: Fri, 14 Mar 2025 14:41:32 -0700
Message-ID: <df08c856d0f2b7f2db503249d551d09408393cc3.1741988314.git.jpoimboe@kernel.org>
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
 arch/x86/include/asm/uaccess_64.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index c52f0133425b..b507d5fb5443 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -26,10 +26,10 @@ extern unsigned long USER_PTR_MAX;
  */
 static inline unsigned long __untagged_addr(unsigned long addr)
 {
-	asm (ALTERNATIVE("",
-			 "and " __percpu_arg([mask]) ", %[addr]", X86_FEATURE_LAM)
-	     : [addr] "+r" (addr)
-	     : [mask] "m" (__my_cpu_var(tlbstate_untag_mask)));
+	alternative_io("",
+		       "and " __percpu_arg([mask]) ", %[addr]", X86_FEATURE_LAM,
+		       ARG([addr] "+r" (addr)),
+		       ARG([mask] "m" (__my_cpu_var(tlbstate_untag_mask))));
 
 	return addr;
 }
-- 
2.48.1


