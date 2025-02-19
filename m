Return-Path: <linux-kernel+bounces-522040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DD0A3C535
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829C11890564
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4E71FF1B3;
	Wed, 19 Feb 2025 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XbGMXRZr"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AAF1FDE12
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983011; cv=none; b=XOEIVW23blzNQmVo4bw63Fqh5A8+O/TGFbpKvGCx89Szip29xpRiCzjHtRIKG8kusBjSICko/YsgukqqQP1tZLD1eiiKb0azsDTJMewXxFNPxctIy/Ej3Y7CukorZmhdSexAYjypYqyqB90MOYx5CGjAbHe8OHyYY9dA2JKsYp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983011; c=relaxed/simple;
	bh=7/R9Q29okdEYiDknWp2ksDiZmvkLI7PssYu9BwnB2K0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VI5qMnvTEImaexXGiA626IobB+ahC8UAn/v1BEWBwqFN9+C7QXZ9ZN8mlwE8PvRjWZOK3Qpdh706IxiwT5Dj5FZ9dJCskOPF908G0rL/xlrGkYZnNVR9iKdQP4p+0d+KOrQSIwvYUA3R2V4VaYK4JwcF5iF1S+NK4JB7wtDtCzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XbGMXRZr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=U88omwiH5A+inj+uOYAaqUYCMp5kwoQ7OKMg92ce4XM=; b=XbGMXRZr9CESTWAEvEqgc2HyNd
	YCkSknwhnGk2i23J3Robj++By5p63VWH84RNGz88HXVdP0r65K/EXoBLRIT5I4I2qcxz+v12pTroI
	07055jck3j3FqodDJ/8Zx+eic24HV3ENzWFOJQ/LAvzWIFa38X3AkEOp+c49v5EM3UJgDKKvF110i
	RhJABt7FJHQE5n6LylPMOMo2g6JD14RrhRIp5bXf7CMuP9LplQT5Q1/u26GO0EJ2DNhMrKAcr8xas
	/+6WmcYJJbNaCKdA2Z11Bq2gSv9wDujqiJrxBF3IojI63UCbfyAojqcBwRlTTaV2Rf1g1UCv5cNUn
	MfO7V8sg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tkn3z-00000006Whh-3pdO;
	Wed, 19 Feb 2025 16:36:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 024C63007F0; Wed, 19 Feb 2025 17:36:43 +0100 (CET)
Message-ID: <20250219163514.688460830@infradead.org>
User-Agent: quilt/0.66
Date: Wed, 19 Feb 2025 17:21:11 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 alyssa.milburn@intel.com,
 scott.d.constable@intel.com,
 joao@overdrivepizza.com,
 andrew.cooper3@citrix.com,
 jpoimboe@kernel.org,
 jose.marchesi@oracle.com,
 hjl.tools@gmail.com,
 ndesaulniers@google.com,
 samitolvanen@google.com,
 nathan@kernel.org,
 ojeda@kernel.org,
 kees@kernel.org,
 alexei.starovoitov@gmail.com,
 mhiramat@kernel.org,
 jmill@asu.edu
Subject: [PATCH v3 04/10] x86/traps: Allow custom fixups in handle_bug()
References: <20250219162107.880673196@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

The normal fixup in handle_bug() is simply continuing at the next
instruction. However upcomming patches make this the wrong thing, so
allow handlers (specifically handle_cfi_failure()) to over-ride
regs->ip.

The callchain is such that the fixup needs to be done before it is
determined if the exception is fatal, as such, revert any changes in
that case.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/traps.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -287,11 +287,12 @@ static inline void handle_invalid_op(str
 
 static noinstr bool handle_bug(struct pt_regs *regs)
 {
+	unsigned long addr = regs->ip;
 	bool handled = false;
 	int ud_type, ud_len;
 	s32 ud_imm;
 
-	ud_type = decode_bug(regs->ip, &ud_imm, &ud_len);
+	ud_type = decode_bug(addr, &ud_imm, &ud_len);
 	if (ud_type == BUG_NONE)
 		return handled;
 
@@ -315,7 +316,8 @@ static noinstr bool handle_bug(struct pt
 	switch (ud_type) {
 	case BUG_EA:
 		if (handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
-			regs->ip += ud_len;
+			if (regs->ip == addr)
+				regs->ip += ud_len;
 			handled = true;
 		}
 		break;
@@ -323,7 +325,8 @@ static noinstr bool handle_bug(struct pt
 	case BUG_UD2:
 		if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
 		    handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
-			regs->ip += ud_len;
+			if (regs->ip == addr)
+				regs->ip += ud_len;
 			handled = true;
 		}
 		break;
@@ -340,6 +343,9 @@ static noinstr bool handle_bug(struct pt
 		break;
 	}
 
+	if (!handled && regs->ip != addr)
+		regs->ip = addr;
+
 	if (regs->flags & X86_EFLAGS_IF)
 		raw_local_irq_disable();
 	instrumentation_end();



