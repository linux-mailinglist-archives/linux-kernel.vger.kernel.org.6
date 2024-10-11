Return-Path: <linux-kernel+bounces-361547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DCF99A98C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73C941F22F6A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F38B1D014E;
	Fri, 11 Oct 2024 17:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GI35fbnM"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6B51CFEC5
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666565; cv=none; b=GRuxdsXUy8RIuEQbjLlYXnT5zpmiVvTqCoDp5TzKwnC8FEjOZ2y9AG7fbGe4PJDNU5uapDZZR37gjQU5uRNPaa/Wv2U5bsiyHbHRoWatbYMMVOYPOKHXUsCMA15bn5TOCMHRWRH7VauXvnjtVWm0rHWKJQxmIQoscjmTd4UHRZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666565; c=relaxed/simple;
	bh=dmzPGrFW6aOYMzz1IH4ndQp0FtWFFlmkgAnMYm8LZsM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XB7zLOmeuudW287hKJ3aSm/fM/nd0AFW+2HN7O1fZ78WwGd+OHrUXjvAkHuJ/3Q4+5PoiPZY3i4JPCVTlBKxTV39kLxvm2n6B29CHW2rKishl3sRNZThm5+Gqxh/2MPPrTpX/7d++FNR2W/Bq74Ks2biENcRdE/8azPS26n2L1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GI35fbnM; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e22f8dc491so42603827b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728666563; x=1729271363; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e8u1CNDm2+Bhw3m92z5B6moO+Nki7WTk10wOgvZqSdE=;
        b=GI35fbnMCkySVNH2TvfqLhyFIeEiYu2bCrc6zquv+r7LOeNciqEOaqWoaI9gR4BtnP
         sxvyx2trxM3rx954sxtyswuACZ2ICjFVNgxiQuhA4npiAFb4PFrOMaZ9oUvzZoq2dp71
         1e8CYOvGj6lCFoqx220whbnLJJUXOfOBjMjGmoF3mNpRI/sSS9OpGdxAvDnan1DEwTiK
         EIwQkTxZgh8trrZ7Kr0ooT4pN/MH4ADkaoF4e7ANmNuV0gRWb75HVA6nfdO/xzPNiCIF
         O36CdW0iM1H1TTNrYTc8CA91+GLo9ZKvhf6Mjc0111laX5Bv44GO7Jn1r5z6qCqdar7H
         ML3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728666563; x=1729271363;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8u1CNDm2+Bhw3m92z5B6moO+Nki7WTk10wOgvZqSdE=;
        b=w6jeFXJpiWZ60ZybjoCRJ/nPQsf13wMbIxKFL20pf/JN3Ugty+oB/5V2TQkJ9SibHn
         WXsCudEjPLK+Ykl83ud/S8oxwm9HLxPn0xW0vLnUtRaJLr3HpBxpvf1gfPA2un73+nnj
         2KJ595jiX1ZW4C0y5RU2jSr+B6VYGciuMxj93mA7I3HenCecjrrum/oIpct0quaRhuTx
         t6rTvPb3C0sRDvcELeqilPGJuIepMdXG/UWjZ4Dy5TjTpofc2+dBUhmg53/MMRdo/sIv
         o3iRL33eJJxXNpRKqVUbr1ImP6oLLzD8ItmQxDE2ORni8KgatXamwdbdI4iltzxtoGcB
         a+mg==
X-Gm-Message-State: AOJu0YwsgiU8gnSeDJD6aM/YUq7zBSL5oro/rDKu1tLsAb3ZOvAyeX01
	YwrfXmOp4VcZsZWp50DVUF7vOQYgfFfQyXSG5hqJThK0pK9SF8XeuRQ4rihUp2B+5jFfPjYLH/d
	TxSMCfVxO2VuK/PxeJrLLr8yw1TbgVwfpVjnfU7iCfDFvof/oBD6E9Gpua68IU9WRwR+iLJuC0q
	hIdVaGqIeGiAuJ8XQhh+FsaAvcKayETw==
X-Google-Smtp-Source: AGHT+IELPWPtiT4Q82wAv9kxv2a+A02raZYpuKW6YkhpqdM8qkrH2v2YSZ25ymK9rG/ipEu3ysaoSds0
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:690c:3190:b0:6e2:120b:be57 with SMTP id
 00721157ae682-6e347b4aec8mr83757b3.5.1728666562988; Fri, 11 Oct 2024 10:09:22
 -0700 (PDT)
Date: Fri, 11 Oct 2024 19:08:56 +0200
In-Reply-To: <20241011170847.334429-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011170847.334429-10-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3351; i=ardb@kernel.org;
 h=from:subject; bh=Hfh910Y5sSnn5hBkeQ8p28eswlQr4LHqPbKbxMAVhc0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ0zenW+ZiGDhuwr6Rk3jm4WtI45MFlvU1xb1zP3k1/yF
 Rq5VdI7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwEQW9zMyrPey+hV86aRT/v8I
 8defMvfutpU/FbW3Yf+0ugM2qzYLZDH8D5urnSY/RSlbw4UtxHhzheGW9zE9B0xVErOyXG3KbtV xAAA=
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011170847.334429-18-ardb+git@google.com>
Subject: [PATCH v3 8/8] crypto: x86/crc32c-intel - Tweaks to make objtool's
 life harder
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, keescook@chromium.org, 
	linux-hardening@vger.kernel.org, nathan@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jan Beulich <jbeulich@suse.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Tweak the asm crc32c asm code so that the jump table is more difficult
to decipher for objtool:

- load the address in the prologue
- move the jump table to the middle of .rodata, so that the section
  offset and the symbol offset differ
- emit an entry following the jump table that is unrelated
- add unconditional ENDBRs so we can test --ibt regardless of the kernel
  config

Test code only. Not intended for merging.
---
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S | 50 +++++++++++---------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
index 7292090e76dd..cbedf5820e30 100644
--- a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
+++ b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
@@ -93,10 +93,14 @@ SYM_FUNC_START(crc_pcl)
 #define    crc1		%r9
 #define    crc2		%r10
 
+	endbr64
+	pushq	%rbp
 	pushq   %rbx
 	pushq   %rdi
 	pushq   %rsi
 
+	leaq	jump_table(%rip), %rbp
+
 	## Move crc_init for Linux to a different
 	mov     crc_init_arg, crc_init
 
@@ -168,9 +172,8 @@ SYM_FUNC_START(crc_pcl)
 	xor     crc2, crc2
 
 	## branch into array
-	leaq	jump_table(%rip), %bufp
-	movslq	(%bufp,%rax,4), len
-	addq	len, %bufp
+	movslq	(%rbp,%rax,4), %bufp
+	addq	%rbp, %bufp
 	.reloc	., R_X86_64_NONE, jump_table
 	JMP_NOSPEC bufp
 
@@ -197,7 +200,7 @@ SYM_FUNC_START(crc_pcl)
 .altmacro
 LABEL crc_ %i
 .noaltmacro
-	ENDBR
+	endbr64
 	crc32q   -i*8(block_0), crc_init
 	crc32q   -i*8(block_1), crc1
 	crc32q   -i*8(block_2), crc2
@@ -207,7 +210,7 @@ LABEL crc_ %i
 .altmacro
 LABEL crc_ %i
 .noaltmacro
-	ENDBR
+	endbr64
 	crc32q   -i*8(block_0), crc_init
 	crc32q   -i*8(block_1), crc1
 # SKIP  crc32  -i*8(block_2), crc2 ; Don't do this one yet
@@ -241,7 +244,7 @@ LABEL crc_ %i
 	################################################################
 
 LABEL crc_ 0
-	ENDBR
+	endbr64
 	mov     tmp, len
 	cmp     $128*24, tmp
 	jae     .Lfull_block
@@ -311,26 +314,11 @@ LABEL less_than_ %j			# less_than_j: Length should be in
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
-.size	jump_table, . - jump_table
-.type	jump_table, @object
-
 	################################################################
 	## PCLMULQDQ tables
 	## Table is 128 entries x 2 words (8 bytes) each
@@ -465,3 +453,21 @@ K_table:
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
+
+.size	jump_table, . - jump_table
+.type	jump_table, @object
+
+	.long	crc_pcl - .
-- 
2.47.0.rc1.288.g06298d1525-goog


