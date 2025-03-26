Return-Path: <linux-kernel+bounces-576687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824F8A7130A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45813B99CC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB591AB528;
	Wed, 26 Mar 2025 08:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bC/uzs+Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8071AA1F6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742978887; cv=none; b=cYWb31sIxktLdQNHnJMVRMH0/5z5Sb4tIWfh0gvWrus9pZYkHgmk9KCLCxKxrQUcuofL0O1SPP89oiJSshzkeXnvlTZP92hKG2eMW2hy/KaGSB23zHE8MG0hGdEybnJY1DkFHhim7430/r3lnl+BMBUI6Eje8/h7eZjeUFvzTXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742978887; c=relaxed/simple;
	bh=dSstgYB77qBPQJUZCAejs0eSom8yR3UEykjpoTiOVIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfO9/7k2ZTuGXbEBQZ6cElWzmlgirUglPNWIK3khBLX5juNotxrkrx7tRadEt121mYNS1+GYzdKznZK+aLx7SCYWkgWGLLF0gYMotGaQ1thKAHv7MtjmZd9mhB8b7U8FY+FisiJuN0XeSiSKAzEaFghQs0MevZs4QB1xstAF4jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bC/uzs+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E669C4CEF0;
	Wed, 26 Mar 2025 08:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742978887;
	bh=dSstgYB77qBPQJUZCAejs0eSom8yR3UEykjpoTiOVIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bC/uzs+ZgGAGidK4M6uBlnPQ1RbTtJ+tLYTK2TPpRlD/pI5w0gqvaidSTtp2wP84e
	 0voZcBu1KvMcbAiEczXAniSkO6Yq4rPqbEj6HwZ8kvyLtnN0GNyZaGe1ZnmilFiVbW
	 XI5cOM7Acbmns3WMDMrf3HqLroRJuWIO2Oi7GFrZKIpxF+xouhBUPuRYxfhZzvyEgR
	 TxdmtBuI/h5tTGu/Gu6qlIEKnHzdAyWbRNb/Co/Dl1g2dIHzQW8irMKIZvzCsCZ7yE
	 /TjzNL9sDmtD3xgAwLRJccOaB9rb64N1lDCTTdxU7zP4lSyJuWkcwEx9bcdnx1j7O+
	 c7IXy9+0b6pqw==
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 3/5] bugs/x86: Extend _BUG_FLAGS() with the 'cond_str' parameter
Date: Wed, 26 Mar 2025 09:47:48 +0100
Message-ID: <20250326084751.2260634-4-mingo@kernel.org>
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

Just pass down the parameter, don't do anything with it yet.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/bug.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 413b86b876d9..aff1c6b7a7f3 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -39,7 +39,7 @@
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 
-#define _BUG_FLAGS(ins, flags, extra)					\
+#define _BUG_FLAGS(cond_str, ins, flags, extra)				\
 do {									\
 	asm_inline volatile("1:\t" ins "\n"				\
 		     ".pushsection __bug_table,\"aw\"\n"		\
@@ -57,7 +57,7 @@ do {									\
 
 #else /* !CONFIG_DEBUG_BUGVERBOSE */
 
-#define _BUG_FLAGS(ins, flags, extra)					\
+#define _BUG_FLAGS(cond_str, ins, flags, extra)				\
 do {									\
 	asm_inline volatile("1:\t" ins "\n"				\
 		     ".pushsection __bug_table,\"aw\"\n"		\
@@ -74,7 +74,7 @@ do {									\
 
 #else
 
-#define _BUG_FLAGS(ins, flags, extra)  asm volatile(ins)
+#define _BUG_FLAGS(cond_str, ins, flags, extra)  asm volatile(ins)
 
 #endif /* CONFIG_GENERIC_BUG */
 
@@ -82,7 +82,7 @@ do {									\
 #define BUG()							\
 do {								\
 	instrumentation_begin();				\
-	_BUG_FLAGS(ASM_UD2, 0, "");				\
+	_BUG_FLAGS("", ASM_UD2, 0, "");				\
 	__builtin_unreachable();				\
 } while (0)
 
@@ -96,7 +96,7 @@ do {								\
 do {								\
 	__auto_type __flags = BUGFLAG_WARNING|(flags);		\
 	instrumentation_begin();				\
-	_BUG_FLAGS(ASM_UD2, __flags, ANNOTATE_REACHABLE(1b));	\
+	_BUG_FLAGS(cond_str, ASM_UD2, __flags, ANNOTATE_REACHABLE(1b)); \
 	instrumentation_end();					\
 } while (0)
 
-- 
2.45.2


