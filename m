Return-Path: <linux-kernel+bounces-231050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D010091857C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78FB31F25FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271B918A921;
	Wed, 26 Jun 2024 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xoxqtRD4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159AA18A929
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414850; cv=none; b=euKSou8YFB+yZIvJ9srVhb0wYMmPJmiGD56Leka+eWlXb0DxTAn1/W7jZ2K65BnkG75SqjkaOK5X4jgb71JAIqnV03W7epk2/OBe2D6Ogzi6QxDIxJUFz91NwFQYXZ5Am9I45iYk7obbyZuSD695mXcbTRPwF+JUEJy5apZm4is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414850; c=relaxed/simple;
	bh=ERBNKSeZKdfxzsLO/18RGz0vTGZDdTbf/1zv3RgfJHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIo9X4LB47us0nrSGVDDuyFWgiVKSZTOWGooF1KrYoxEHGp9DUTfbpf/mDxMnLwjdyOod4WdWJiDxgCeOdn5gJ8djBTIZiEXf/E47VyqJ5C+QDCW/TryUMAKCWvQ44RzTHl9377eq+GztNk7H7wOaYj1mXFsSHMICdlzzpjb2/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=xoxqtRD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FF4C4AF07;
	Wed, 26 Jun 2024 15:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719414849;
	bh=ERBNKSeZKdfxzsLO/18RGz0vTGZDdTbf/1zv3RgfJHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xoxqtRD4ZJJgbKK/R5DUhRsV/PGYsg8+Fjrv1JjkDLc2CnzFjViCCDDrxsAXHrwVt
	 mikBZQie9KKUOte6uPlSEsaLOe997qWALvcsqMOYOoiKzK0KTnUXPwpLKWLv8Ylzbg
	 D/OhRwZaiEr4AGm8kIMEWUVl1lTLkiLQb7ai8ZfM=
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Uros Bizjak <ubizjak@gmail.com>,
	Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] x86-32: fix cmpxchg8b_emu build error with clang
Date: Wed, 26 Jun 2024 08:11:32 -0700
Message-ID: <20240626151131.550535-2-torvalds@linux-foundation.org>
X-Mailer: git-send-email 2.45.1.209.gc6f12300df
In-Reply-To: <CAHk-=wiWEgSo2Tb_bih7mnS27zAPL+RGg_7yX4qK1f710-j-Ng@mail.gmail.com>
References: <CAHk-=wiWEgSo2Tb_bih7mnS27zAPL+RGg_7yX4qK1f710-j-Ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel test robot reported that clang no longer compiles the 32-bit
x86 kernel in some configurations due to commit 95ece48165c1
("locking/atomic/x86: Rewrite x86_32 arch_atomic64_{,fetch}_{and,or,xor}()
functions").

The build fails with

  arch/x86/include/asm/cmpxchg_32.h:149:9: error: inline assembly requires more registers than available

and the reason seems to be that not only does the cmpxchg8b instruction
need four fixed registers (EDX:EAX and ECX:EBX), with the emulation
fallback the inline asm also wants a fifth fixed register for the
address (it uses %esi for that, but that's just a software convention
with cmpxchg8b_emu).

Avoiding using another pointer input to the asm (and just forcing it to
use the "0(%esi)" addressing that we end up requiring for the sw
fallback) seems to fix the issue.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406230912.F6XFIyA6-lkp@intel.com/
Fixes: 95ece48165c1 ("locking/atomic/x86: Rewrite x86_32 arch_atomic64_{,fetch}_{and,or,xor}() functions")
Link: https://lore.kernel.org/all/202406230912.F6XFIyA6-lkp@intel.com/
Suggested-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This is the minimal patch, with the other simplifications removed.

I still think that the case where somebody passes in a "oldp" that can
change during the cmpxchg is entirely broken, and is not actually valid. 

If it was valid, we'd have to use READ_ONCE() and WRITE_ONCE() in the
"oldp" updates anyway just to make verification tools happy. We don't.

But hey, that simplification doesn't matter for fixing this build issue,
so let's keep the change minimal. 

 arch/x86/include/asm/cmpxchg_32.h | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index ed2797f132ce..62cef2113ca7 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -93,10 +93,9 @@ static __always_inline bool __try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp,
 									\
 	asm volatile(ALTERNATIVE(_lock_loc				\
 				 "call cmpxchg8b_emu",			\
-				 _lock "cmpxchg8b %[ptr]", X86_FEATURE_CX8) \
-		     : [ptr] "+m" (*(_ptr)),				\
-		       "+a" (o.low), "+d" (o.high)			\
-		     : "b" (n.low), "c" (n.high), "S" (_ptr)		\
+				 _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8) \
+		     : "+a" (o.low), "+d" (o.high)			\
+		     : "b" (n.low), "c" (n.high), [ptr] "S" (_ptr)	\
 		     : "memory");					\
 									\
 	o.full;								\
@@ -122,12 +121,11 @@ static __always_inline u64 arch_cmpxchg64_local(volatile u64 *ptr, u64 old, u64
 									\
 	asm volatile(ALTERNATIVE(_lock_loc				\
 				 "call cmpxchg8b_emu",			\
-				 _lock "cmpxchg8b %[ptr]", X86_FEATURE_CX8) \
+				 _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8) \
 		     CC_SET(e)						\
 		     : CC_OUT(e) (ret),					\
-		       [ptr] "+m" (*(_ptr)),				\
 		       "+a" (o.low), "+d" (o.high)			\
-		     : "b" (n.low), "c" (n.high), "S" (_ptr)		\
+		     : "b" (n.low), "c" (n.high), [ptr] "S" (_ptr)	\
 		     : "memory");					\
 									\
 	if (unlikely(!ret))						\
-- 
2.45.1.209.gc6f12300df


