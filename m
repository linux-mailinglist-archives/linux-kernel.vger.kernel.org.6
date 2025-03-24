Return-Path: <linux-kernel+bounces-573809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BA2A6DCC9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF553B02AF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F00B25FA39;
	Mon, 24 Mar 2025 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RMFsKuL7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J1vCQBiK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3974725FA22
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826055; cv=none; b=pZMtUGaMyn89qWfAus0bG/sGsm+1XbMQdc80tahCOmmJr71Y4N9YOJ0fOupD6InV8d53rfRzf7DM1nug9aZRd3gme5NdZhg0CYVE0bIKvdTyOhQ4Y1+swTSVkbms82uzqj9PM2tAY9NLIe+MODEwZl1sIfeAoZV0Z3wwxPH8JY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826055; c=relaxed/simple;
	bh=6GF/cyvtwarm61iqKRBEKqwKaoiqcTQEU9Sk3cTJfVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOduVPOi8kD4Ae1sZsP9usYpcyCHbtN/8be+QWCy7ON2KgLQsJCAGrOBgYEriT33gdorVs1InCka7fLNamAJG7xldVcU32d/Dd7QjFO0jmmKAdiTH8STXmIwUKxGaFRuo2MTFgsjfF9kM+9cJOuN1wnaZhXK7JTUPKtEW4L7aXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RMFsKuL7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J1vCQBiK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742826052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fBfo8AXB79SPLI7+74Hw01qjH5lduLL/N5gJi7n6n7M=;
	b=RMFsKuL7x07sEeJci4R7/3RoSMtvdLvr7D0MAuDgpkS6kzRmJCvg5jGOhpHyPRGsLdiRQW
	T5nuVV8YHutjZXT3pahJV0IutwnH1wbjK8cGJN6rju3JDtHi4r1IOVq6YL/o0TSzrSGjdv
	4qKjVT6QAG2KIuVEfbTbYpCNYD4HFRZ++09xFs3NkPPseBaqMyTvOic4JFd56mo8Qbhlip
	sk/CCGZUchSVOrVezu7z/xmtWg7owXFvkvIHK2QDkqekNu4as0X/diPw2m3Ci0cxldIMCC
	ZOtyEEaK/rUSrykMPo6dBW6lde43VbhWOY68DiKeh8aTIiBhzgPrqfb0KIV65g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742826052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fBfo8AXB79SPLI7+74Hw01qjH5lduLL/N5gJi7n6n7M=;
	b=J1vCQBiKRdQszRa4OJlsoaxk1sOKQhjoiUFK25cHYiviHlhRHdYvkE43r44Rm7104pkVDc
	hi+9PBYDFsMfZYBQ==
To: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v3 02/20] tools/x86/kcpuid: Exit the program on invalid parameters
Date: Mon, 24 Mar 2025 15:20:23 +0100
Message-ID: <20250324142042.29010-3-darwi@linutronix.de>
In-Reply-To: <20250324142042.29010-1-darwi@linutronix.de>
References: <20250324142042.29010-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the user passed an invalid CPUID index value through --leaf=index,
kcpuid prints a warning, does nothing, then exits successfully.
Transform the warning to an error, and exit the program with a proper
error code.

Similarly, if the user passed an invalid subleaf, kcpuid prints a
warning, dumps the whole leaf, then exits successfully.  Print a clear
error message regarding the invalid subleaf and exit the program with the
proper error code.

Note, moving the "Invalid input index" message from index_to_func() to
show_info() localizes error message handling to the latter, where it
should be.  It also allows index_to_func() to be refactored at further
commits.

Note, since after this commit and its parent kcpuid does not just "move
on" on failures, remove the NULL parameter check plus silent exit at
show_func() and show_leaf().

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index abfeecce5aa8..8585c1009c8b 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -481,9 +481,6 @@ static void decode_bits(u32 value, struct reg_desc *rdesc, enum cpuid_reg reg)
 
 static void show_leaf(struct subleaf *leaf)
 {
-	if (!leaf)
-		return;
-
 	if (show_raw) {
 		leaf_print_raw(leaf);
 	} else {
@@ -505,9 +502,6 @@ static void show_func(struct cpuid_func *func)
 {
 	int i;
 
-	if (!func)
-		return;
-
 	for (i = 0; i < func->nr; i++)
 		show_leaf(&func->leafs[i]);
 }
@@ -528,10 +522,9 @@ static inline struct cpuid_func *index_to_func(u32 index)
 	range = (index & 0x80000000) ? leafs_ext : leafs_basic;
 	func_idx = index & 0xffff;
 
-	if ((func_idx + 1) > (u32)range->nr) {
-		warnx("Invalid input index (0x%x)", index);
+	if ((func_idx + 1) > (u32)range->nr)
 		return NULL;
-	}
+
 	return &range->funcs[func_idx];
 }
 
@@ -550,18 +543,19 @@ static void show_info(void)
 		/* Only show specific leaf/subleaf info */
 		func = index_to_func(user_index);
 		if (!func)
-			return;
+			errx(EXIT_FAILURE, "Invalid input leaf (0x%x)", user_index);
 
 		/* Dump the raw data also */
 		show_raw = true;
 
 		if (user_sub != 0xFFFFFFFF) {
-			if (user_sub + 1 <= (u32)func->nr) {
-				show_leaf(&func->leafs[user_sub]);
-				return;
+			if (user_sub + 1 > (u32)func->nr) {
+				errx(EXIT_FAILURE, "Leaf 0x%x has no valid subleaf = 0x%x",
+				     user_index, user_sub);
 			}
 
-			warnx("Invalid input subleaf (0x%x)", user_sub);
+			show_leaf(&func->leafs[user_sub]);
+			return;
 		}
 
 		show_func(func);
-- 
2.48.1


