Return-Path: <linux-kernel+bounces-358977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FC69985EE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528AB282840
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC46D1C8FDA;
	Thu, 10 Oct 2024 12:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VOYmbAvh"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E251C8FC1
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563309; cv=none; b=eK6bM09HNYTnRg3EynzaOteNIUe54FJo671U79N+SW2Yp+3Gw7/zaIqgo3Jag7enJijK95YVjF8xedlbmCcqGIxVYd0/AXdYhDbWsT/OFkjx18NkV4zms8jZZslTYrtKQt5qLN2es2x0fsF/7sSwpO0erJ24sKbRnLvEPswMUPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563309; c=relaxed/simple;
	bh=/o/yZ4swobCw3VY94GgXQ0C8aM777wTuhgBNMFNnV60=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VWbZIjX7Vw+empkcfnpvIBviy1S/etT1DadeVN/4mgzCcgkklh9s6ksT4w8+01ZCgo2TTMkgzGKczoMlE+bQIMQ6L/5sJQbtORd89BkXmRVOjd6vyJdVKb/or+BX0DvB0W73eTm9/TIHDsfwY5dX+ANjkbBBByHMdcraq/Uo+CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VOYmbAvh; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d9e31e66eeso18659217b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 05:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728563306; x=1729168106; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ysiTQYnIFAM+GVpiQPZxea96jDzKFB0S2bf0Q1srz24=;
        b=VOYmbAvhxap0cte9dg4PfMjRzh+VLx1RDazD2HeYqoERO/YW4lj1NtG+ntwSjn7VAg
         EgOg+QiKGOfX4uiwzrgNRmRfoPW/b4riat0uKDZPy0z8iZ4s5iO1X3uzPMgvzxRtqFDm
         19lEYb/PPOUyMF2GQ2iaxNAyDj/AJJ38r8S9gxCCG+nyzFWuDCwX7eFb++Tt7f7HlosH
         2zftoZZo43X3cj1LglIblXDE4BLfpO1dQZwARbknCClfbwD1efQX4CU03I7pbDR0OZUI
         WyjaJEuaflWSGt7amrLUw5o2uDYSs8TknSh5HD37aYSqiLwH/ripsVSzGDvICgIToS4d
         5M5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728563306; x=1729168106;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ysiTQYnIFAM+GVpiQPZxea96jDzKFB0S2bf0Q1srz24=;
        b=Gn7QBktkaM50jFBBBLbB7bKU6qhoyoW1A7N8lIiMQu8zl8Mq/HY4At3U0jotT4daZE
         4YsC0hUYFHF/9bFLNKaKzmoq2Frka5tMS7hPeYUQQpgYc/31TUZBNcXRzaAgBmBFTJBl
         tepMviitJBg7nyx/5bLf378XuYp8IyUkW+faLumf9pic1hNC6HMJ59vumZBze+XNDE6c
         bmr1yyhlyKsPF7yzK2G9bJ6zDoQGCLtC68feb1d9E9y1DjZ2a4S1xy/DLC0p+rZ3Wvom
         c6XaRyD+CfrBv8Oz2gAbdJfYRwx0lqXZcZIiZ7Yf0QlnSN9VoOIeBLnANbCHxp7acmlf
         ordA==
X-Gm-Message-State: AOJu0YxwBYiBbZr7A52wGepPj1zNndv9vLhNdZ9F/8aH+UzWY4Jbk1H4
	eISau6Vt4l4rtOxGm1mXceBBoSiYNOGw0EDJGyFSwpZNGlnKiWADKGZtT5EMzjyOt+/ptJV8LFB
	eyZ+o87qwcI9GG4BaG+VQsG70xFd1ycNLw6sR3kdQ9MatO/R9x8ze31GGbayVotjpW/TmlSpDr3
	ZLI91XCYqmDVUKJ3JjU/73YJfbyi58Wg==
X-Google-Smtp-Source: AGHT+IGYzCVf/jII8KomABTrMZDoXEXfru199j0RK0tDWPSxK1xkfDqRPfD8R/E6mn2ZF9v6gg5pIreS
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:690c:731:b0:6e3:eab:18b1 with SMTP id
 00721157ae682-6e3221767a6mr203727b3.1.1728563305577; Thu, 10 Oct 2024
 05:28:25 -0700 (PDT)
Date: Thu, 10 Oct 2024 14:28:07 +0200
In-Reply-To: <20241010122801.1321976-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010122801.1321976-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2591; i=ardb@kernel.org;
 h=from:subject; bh=RmdquyWiyHUUPxUBLvM2Ygamlf/86/TxkgF8NWyXERA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ39RGTnOvUT3GJzrx1X9JCRfnpo9w2pI/P+f72q8Y5HS
 2VhS1hJRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjI/VqGn4yKCg4MbTISnK/Y
 F87etqfSUuC0V+eSGs4vLtH5KVNelDP8M/12ry6phyVirtfhVYVX34UvNvU0q/3pKLY8Kf7HkZk prAA=
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241010122801.1321976-12-ardb+git@google.com>
Subject: [PATCH v2 5/5] crypto: x86/crc32c - Tweak jump table to validate
 objtool logic
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, keescook@chromium.org, 
	linux-hardening@vger.kernel.org, nathan@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jan Beulich <jbeulich@suse.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Tweak the jump table so
- the address is taken far way from its use
- its offset from the start of .rodata is != 0x0
- its type is STT_OBJECT and its size is set to the size of the actual
  table
- the indirect jump is annotated with a R_X86_64_NONE relocation
  pointing to the jump table

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S | 39 +++++++++++---------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
index 45b005935194..ba1cca66875b 100644
--- a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
+++ b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
@@ -93,10 +93,13 @@ SYM_FUNC_START(crc_pcl)
 #define    crc1		%r9
 #define    crc2		%r10
 
+	pushq	%rbp
 	pushq   %rbx
 	pushq   %rdi
 	pushq   %rsi
 
+	leaq	jump_table(%rip), %rbp
+
 	## Move crc_init for Linux to a different
 	mov     crc_init_arg, crc_init
 
@@ -168,9 +171,9 @@ SYM_FUNC_START(crc_pcl)
 	xor     crc2, crc2
 
 	## branch into array
-	leaq	jump_table(%rip), %bufp
-	movslq	(%bufp,%rax,4), len
-	addq	len, %bufp
+	movslq	(%rbp,%rax,4), %bufp
+	addq	%rbp, %bufp
+	.reloc	., R_X86_64_NONE, jump_table
 	JMP_NOSPEC bufp
 
 	################################################################
@@ -310,24 +313,11 @@ LABEL less_than_ %j			# less_than_j: Length should be in
 	popq    %rsi
 	popq    %rdi
 	popq    %rbx
+	popq    %rbp
         RET
 SYM_FUNC_END(crc_pcl)
 
 .section	.rodata, "a", @progbits
-        ################################################################
-        ## jump table        Table is 129 entries x 2 bytes each
-        ################################################################
-.align 4
-jump_table:
-	i=0
-.rept 129
-.altmacro
-JMPTBL_ENTRY %i
-.noaltmacro
-	i=i+1
-.endr
-
-
 	################################################################
 	## PCLMULQDQ tables
 	## Table is 128 entries x 2 words (8 bytes) each
@@ -462,3 +452,18 @@ K_table:
 	.long 0x45cddf4e, 0xe0ac139e
 	.long 0xacfa3103, 0x6c23e841
 	.long 0xa51b6135, 0x170076fa
+
+        ################################################################
+        ## jump table        Table is 129 entries x 2 bytes each
+        ################################################################
+.align 4
+jump_table:
+	i=0
+.rept 129
+.altmacro
+JMPTBL_ENTRY %i
+.noaltmacro
+	i=i+1
+.endr
+.size	jump_table, . - jump_table
+.type	jump_table, @object
-- 
2.47.0.rc0.187.ge670bccf7e-goog


