Return-Path: <linux-kernel+bounces-562220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B383A61F5F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF63885C5D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51198231C9F;
	Fri, 14 Mar 2025 21:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awyFYt59"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E7722FAD4
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 21:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988522; cv=none; b=F+Mn/eKFp8tK2D6wVF8eOVVWkkzN+zdZOM6OPpVW9/CMFUZTyg49XBH2P1My4Bb3s2Y9AM2IehmaMq5+V2Jj3jQQBVwtKKjKyG7m56vrodu9ENF4NW85xA0RVdajfAvTnx+J0Ca6pn/XPU7pnsqc/rXEwBih2WJvtwiLjXV4SFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988522; c=relaxed/simple;
	bh=KpuDHlj/pZSHps6eommEykhCFA6r+jko10x/uIaSe94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UgUbyV4V5fjlihxdY3Qw8Y8Vj0d121/wtSgNQlV5RLc8IPaF/KL7sNg1J9cMToW/wUwRPe2ikBdmoY2ZQrJBF5zvHpuMFo7Vhbrm/u8L5aE31cXhN8Py7sYN2noVU9qBJnANKN6+8fwLPSkWOnK+iA4+RJaz6W2sc8MpKYbBVC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awyFYt59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A38C4CEEC;
	Fri, 14 Mar 2025 21:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741988522;
	bh=KpuDHlj/pZSHps6eommEykhCFA6r+jko10x/uIaSe94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=awyFYt59Fp0lPWg5tAEJkSlzW2QqAp7N+RQhvAghyh0xF+ihXCGk6AsaNSm4RufQr
	 sSLHjLAVtsHxzhf4QD/tP5UT2Cz9X1u81ygteWM3PXi697C2DRq0eL3rHhyxVwYbM3
	 y8uV7oLYN3AUmKhsLmRfKrWjNjtVpspW0GrtMMr4K58ZXzlTuGHGZPKzQ9uZce0vyx
	 0P7senMsgQ/owj6AZ0CA/6KVeWt6+94LBFjaw0Ck4GHGn5ayW7b7ZobEM8o7U3ePuN
	 hiDVSputVZszqv6uYZrXP2HRnYW/MXU+TTejNTQmJD7EMCqdnD8TkN3YxwyDZyPBZR
	 iKmcLCs8Pv96Q==
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
Subject: [PATCH 14/20] x86/barrier: Use alternative_io() in 32-bit barrier functions
Date: Fri, 14 Mar 2025 14:41:27 -0700
Message-ID: <1c2fe7f93c4dd8a87c2e1fa8b780a8a2968be445.1741988314.git.jpoimboe@kernel.org>
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
 arch/x86/include/asm/barrier.h | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index db70832232d4..489a7ea76384 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -12,12 +12,23 @@
  */
 
 #ifdef CONFIG_X86_32
-#define mb() asm volatile(ALTERNATIVE("lock addl $0,-4(%%esp)", "mfence", \
-				      X86_FEATURE_XMM2) ::: "memory", "cc")
-#define rmb() asm volatile(ALTERNATIVE("lock addl $0,-4(%%esp)", "lfence", \
-				       X86_FEATURE_XMM2) ::: "memory", "cc")
-#define wmb() asm volatile(ALTERNATIVE("lock addl $0,-4(%%esp)", "sfence", \
-				       X86_FEATURE_XMM2) ::: "memory", "cc")
+#define mb() alternative_io("lock addl $0,-4(%%esp)",			\
+			    "mfence", X86_FEATURE_XMM2,			\
+			    ARG(),					\
+			    ARG(),					\
+			    ARG("memory", "cc"))
+
+#define rmb() alternative_io("lock addl $0, -4(%%esp)",			\
+			     "lfence", X86_FEATURE_XMM2,		\
+			     ARG(),					\
+			     ARG(),					\
+			     ARG("memory", "cc"))
+
+#define wmb() alternative_io("lock addl $0, -4(%%esp)",			\
+			     "sfence", X86_FEATURE_XMM2,		\
+			     ARG(),					\
+			     ARG(),					\
+			     ARG("memory", "cc"))
 #else
 #define __mb()	asm volatile("mfence":::"memory")
 #define __rmb()	asm volatile("lfence":::"memory")
-- 
2.48.1


