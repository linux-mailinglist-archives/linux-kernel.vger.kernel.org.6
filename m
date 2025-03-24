Return-Path: <linux-kernel+bounces-573822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044A2A6DCDC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B76E1170412
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B78E261586;
	Mon, 24 Mar 2025 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LN6inNs3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EhCLgIez"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B131262812
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826087; cv=none; b=NuAN764CaT7C2/RZC9YnBKIuCtXK7vKvefixqKuNjSD3FGqZ4y6HkNW06HH03pCgCx2MtJszpSv5oL8JVj6Az25WMiN1GCCbNd+UWk6IRChn2lYMad+ol8PDp44M+kNFjZ7q57VSunO+RdVqbUHVDxh+VKHpagHxZPV7XwN2XOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826087; c=relaxed/simple;
	bh=Adf+zN0jZwi1RYzCLoCEtx2M+jktmNOuFEJOe/QrH74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LAuiCr6MjBNK9Zm5xr4hPw3rTGEhy0lErnfXyyTprTFSD4BIm9hC4yIPCH5nRbvANfuqlUv3+UKcpdb0hEWzW56ygV/sY7TGqZBFTS6rNEVL+YcHIM0dwJh9R6fIP4kVGsWlZasbyMK4MI4eJU7Seopm5zq7lYMNlh9EAe5i8o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LN6inNs3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EhCLgIez; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742826084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLdZ2DXpJDx8yhYu4D1b1KQ/w9DYKov9AN7jy9kVAKA=;
	b=LN6inNs3J2PmOc3/Pf1fY/GcDUC+pTwxbx9U+OzN+nXcmUUq/abOIhf1e0pbLFEOxvR7IF
	uPHXdc2JC2GiEN5QghLjh6qWzrAA0yHh2ksXw1KOxCHyN2wuXtSIuYvv63ekPf/66EPdC0
	VNvpfShdMvtj+aL+h0t20nLPg0mo2SYgICUNHRff8jHF1F292hApOtpkYrNWC5uJmNYtxk
	WjRrzP6WrWoMESPTprTalVFzNHVcWoWtuHDXSG1O4assooRyQAbn2k7ssQZ5ju414taeav
	JlHaSQO3TctlWHa2b1LiOOwyGYjw/77Tk2pyovLby99pjEjmFIXUEa9OB9KFAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742826084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLdZ2DXpJDx8yhYu4D1b1KQ/w9DYKov9AN7jy9kVAKA=;
	b=EhCLgIezvblPLYzFiGfNkKpy4d7d7XD8pJzBXHqZ1HN7DAlING1OnqMjiH3AuLZ6oWmB9R
	d8Fn13nF/LNiskAA==
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
Subject: [PATCH v3 12/20] tools/x86/kcpuid: Extend CPUID index mask macro
Date: Mon, 24 Mar 2025 15:20:33 +0100
Message-ID: <20250324142042.29010-13-darwi@linutronix.de>
In-Reply-To: <20250324142042.29010-1-darwi@linutronix.de>
References: <20250324142042.29010-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the CPUID index mask macro from 0x80000000 to 0xffff0000.  This
accommodates the Transmeta (0x80860000) and Centaur (0xc0000000) index
ranges which will be later added.

This also automatically sets CPUID_FUNCTION_MASK to 0x0000ffff, which is
the actual correct value.  Use that macro, instead of the 0xffff literal
where appropriate.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 00a3b7a8953c..0ba0d440482c 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -71,7 +71,7 @@ enum range_index {
 	RANGE_EXT = 0x80000000,		/* Extended */
 };
 
-#define CPUID_INDEX_MASK		0x80000000
+#define CPUID_INDEX_MASK		0xffff0000
 #define CPUID_FUNCTION_MASK		(~CPUID_INDEX_MASK)
 
 struct cpuid_range {
@@ -173,7 +173,7 @@ static bool cpuid_store(struct cpuid_range *range, u32 f, int subleaf,
 	 * Cut off vendor-prefix from CPUID function as we're using it as an
 	 * index into ->funcs.
 	 */
-	func = &range->funcs[f & 0xffff];
+	func = &range->funcs[f & CPUID_FUNCTION_MASK];
 
 	if (!func->leafs) {
 		func->leafs = malloc(sizeof(struct subleaf));
@@ -228,7 +228,7 @@ void setup_cpuid_range(struct cpuid_range *range)
 
 	cpuid(range->index, max_func, ebx, ecx, edx);
 
-	idx_func = (max_func & 0xffff) + 1;
+	idx_func = (max_func & CPUID_FUNCTION_MASK) + 1;
 	range->funcs = malloc(sizeof(struct cpuid_func) * idx_func);
 	if (!range->funcs)
 		err(EXIT_FAILURE, NULL);
@@ -512,7 +512,7 @@ static inline struct cpuid_func *index_to_func(u32 index)
 	if (!range)
 		return NULL;
 
-	func_idx = index & 0xffff;
+	func_idx = index & CPUID_FUNCTION_MASK;
 	if ((func_idx + 1) > (u32)range->nr)
 		return NULL;
 
-- 
2.48.1


