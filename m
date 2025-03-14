Return-Path: <linux-kernel+bounces-562223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E294BA61F5C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBBF2462FC8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3182356CE;
	Fri, 14 Mar 2025 21:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtJqmxV7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9BD2343AF
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 21:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988524; cv=none; b=AMJpvTpZfexZQ7utMsNkxNNUIs6W4Ilvmbk2z3AwQmxNvybCN86ysGCh/H2SMO/klPhwYu9MD+kWh3/I/NoNfos2OjlQsti96CLHjIUMhn7vQVgYWORRLpli8wse/RAz9zxouII6AxyVz/ZbngKjRAFO7cYtXG3gPBP7QYriAwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988524; c=relaxed/simple;
	bh=cIjsaFbFwtTvmpVudgpMPXuLdFSOFmDjD4OJNzfEUJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JmRZmGvq9f0GUCZQFTuhCkRtV1gfBYl5TeHs/fFJ6dkFcvzv9gyxrooVL8TQnOPOdKOf/BMuyogHQEcBieQurNnRrcQSuxnKK11xXBMllJ/YI0GFuAnYWo1NYIBuFOTl2acy7+T5Vkh5l9CjfhSvRfiBwhOv+6NJZQ3b/P5CSC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtJqmxV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4918EC4CEEF;
	Fri, 14 Mar 2025 21:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741988523;
	bh=cIjsaFbFwtTvmpVudgpMPXuLdFSOFmDjD4OJNzfEUJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UtJqmxV7hoMxDMVA64kc/Igh309ltaOhRT8r65+Pq3JUVvARqZDajOG5DbZu2T5+1
	 JZUnjjx5PIk0CKeZ9O8XUL5KzJE3D9AF9XuvJCGe/KpLzRM/oYQfD20z/wGcXkJBIP
	 oAensFkCFdVGJJHvipTYqhJCFcTC1LxxvMqWz7MXqENRHwkrR4EeC59x0+d8nFeqOJ
	 /18ur0im0NgquvIZjDig9AezlklPRC0VsxvUabPOcGAxiycMiU1dUGRfsQTOkM1G/N
	 HMfRr5MfqHVaTFPL/Mxt57A/hV5PLdetJtlWatVyPtW3tZ7m1NDqMVO/gU09ROlbzR
	 PkarKGWAZxmgQ==
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
Subject: [PATCH 17/20] x86/smap: Use named asm operands in smap_{save,restore}()
Date: Fri, 14 Mar 2025 14:41:30 -0700
Message-ID: <4631b5fb3e33af925f4bd82ecb56a5facff354cf.1741988314.git.jpoimboe@kernel.org>
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

Use named operands in preparation for using alternative_io().

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/smap.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
index 2de1e5a75c57..60ea21b4c8b7 100644
--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -40,9 +40,9 @@ static __always_inline unsigned long smap_save(void)
 	unsigned long flags;
 
 	asm volatile ("# smap_save\n\t"
-		      ALTERNATIVE("", "pushf; pop %0; " "clac" "\n\t",
-				  X86_FEATURE_SMAP)
-		      : "=rm" (flags) : : "memory", "cc");
+		      ALTERNATIVE("",
+				  "pushf; pop %[flags]; clac\n\t", X86_FEATURE_SMAP)
+		      : [flags] "=rm" (flags) : : "memory", "cc");
 
 	return flags;
 }
@@ -50,9 +50,9 @@ static __always_inline unsigned long smap_save(void)
 static __always_inline void smap_restore(unsigned long flags)
 {
 	asm volatile ("# smap_restore\n\t"
-		      ALTERNATIVE("", "push %0; popf\n\t",
-				  X86_FEATURE_SMAP)
-		      : : "g" (flags) : "memory", "cc");
+		      ALTERNATIVE("",
+				  "push %[flags]; popf\n\t", X86_FEATURE_SMAP)
+		      : : [flags] "g" (flags) : "memory", "cc");
 }
 
 /* These macros can be used in asm() statements */
-- 
2.48.1


