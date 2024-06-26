Return-Path: <linux-kernel+bounces-229880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 359C7917578
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 03:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8264EB22CDC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 01:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F32EC142;
	Wed, 26 Jun 2024 01:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bslfgaoQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DFB9474
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 01:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719364391; cv=none; b=MdJ/jv9IjjQQtBEo5aGh5zN0IG8Dv1UmIYPWE/V61kIECsrFq+9Oy/QJhvDcjhcHj883hRwOaC4Qytjv/n1Cxg8xxoBGZkRrxsebL7oJy8RcJ/K3RTQAJcnjUUqJV6byuF8oyHu5fieW4gOilpx9sNCGLnfXxGUfw14Z8xz/faM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719364391; c=relaxed/simple;
	bh=hFPzcxl6UY4spGPXRlxKz+vqL+RDnRsahb8H1N4odMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWyz5QfMVkCdfrLfnQi0m0F8ePn5j4ljRuSoaRwnNWudyEqd/rCG7GCgJ7YbUGNWYP43eUWz+xmKbAiXFEJlCePDiYgJDcbcd3xZxr6oRtXxB/P7VIHfa22/Y4DNopO4DpFuaW0omZzHHoefjw4STzK7LRaxPKtk8BM3gVCTPyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bslfgaoQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79708C32781;
	Wed, 26 Jun 2024 01:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719364390;
	bh=hFPzcxl6UY4spGPXRlxKz+vqL+RDnRsahb8H1N4odMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bslfgaoQ4K4qDxjEzaWjngcbACWEKEf/yd81vA5KzwSN0ciT/35QfNbmV3uNn3iFx
	 bAXEnvBA4h8DLzuj89koJcHFmu1RUZqfR9usYeDdvj5IHjpb2I7aSWB56wmrI4yCg3
	 foIG7f1WvDw7W0jC6sgcO1JdNcqQUbyUJete3ftQ=
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Uros Bizjak <ubizjak@gmail.com>,
	Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] x86-32: fix cmpxchg8b_emu build error with clang
Date: Tue, 25 Jun 2024 18:09:25 -0700
Message-ID: <20240626010924.478611-2-torvalds@linux-foundation.org>
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

Added commit message, and updated the asm to use '%a[ptr]' instead of
writing out the addressing by hand. 

Still doing the 'oldp' writeback unconmditionally.  The code generation
for the case I checked were the same for both clang and gcc, but until
Uros hits me with the big clue-hammer, I think it's the simpler code
that leaves room for potentially better optimizations too. 

This falls solidly in the "looks ok to me, but still untested" category
for me.  It fixes the clang build issue in my build testing, but I no
longer have a 32-bit test environment, so no actual runtime testing.

 arch/x86/include/asm/cmpxchg_32.h | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index ed2797f132ce..4444a8292c7a 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -88,18 +88,17 @@ static __always_inline bool __try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp,
 
 #define __arch_cmpxchg64_emu(_ptr, _old, _new, _lock_loc, _lock)	\
 ({									\
-	union __u64_halves o = { .full = (_old), },			\
-			   n = { .full = (_new), };			\
+	__u64 o = (_old);						\
+	union __u64_halves n = { .full = (_new), };			\
 									\
 	asm volatile(ALTERNATIVE(_lock_loc				\
 				 "call cmpxchg8b_emu",			\
-				 _lock "cmpxchg8b %[ptr]", X86_FEATURE_CX8) \
-		     : [ptr] "+m" (*(_ptr)),				\
-		       "+a" (o.low), "+d" (o.high)			\
-		     : "b" (n.low), "c" (n.high), "S" (_ptr)		\
+				 _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8) \
+		     : "+A" (o)						\
+		     : "b" (n.low), "c" (n.high), [ptr] "S" (_ptr)	\
 		     : "memory");					\
 									\
-	o.full;								\
+	o;								\
 })
 
 static __always_inline u64 arch_cmpxchg64(volatile u64 *ptr, u64 old, u64 new)
@@ -116,22 +115,19 @@ static __always_inline u64 arch_cmpxchg64_local(volatile u64 *ptr, u64 old, u64
 
 #define __arch_try_cmpxchg64_emu(_ptr, _oldp, _new, _lock_loc, _lock)	\
 ({									\
-	union __u64_halves o = { .full = *(_oldp), },			\
-			   n = { .full = (_new), };			\
+	__u64 o = *(_oldp);						\
+	union __u64_halves n = { .full = (_new), };			\
 	bool ret;							\
 									\
 	asm volatile(ALTERNATIVE(_lock_loc				\
 				 "call cmpxchg8b_emu",			\
-				 _lock "cmpxchg8b %[ptr]", X86_FEATURE_CX8) \
+				 _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8) \
 		     CC_SET(e)						\
-		     : CC_OUT(e) (ret),					\
-		       [ptr] "+m" (*(_ptr)),				\
-		       "+a" (o.low), "+d" (o.high)			\
-		     : "b" (n.low), "c" (n.high), "S" (_ptr)		\
+		     : CC_OUT(e) (ret), "+A" (o)			\
+		     : "b" (n.low), "c" (n.high), [ptr] "S" (_ptr)	\
 		     : "memory");					\
 									\
-	if (unlikely(!ret))						\
-		*(_oldp) = o.full;					\
+	*(_oldp) = o;							\
 									\
 	likely(ret);							\
 })
-- 
2.45.1.209.gc6f12300df


