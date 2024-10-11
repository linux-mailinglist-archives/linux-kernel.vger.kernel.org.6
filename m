Return-Path: <linux-kernel+bounces-361546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A134399A98B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCBD3B23487
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC881CFEC0;
	Fri, 11 Oct 2024 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0pU1pj/n"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C831CF7C6
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666563; cv=none; b=VuhsCXJBrJcYYylJlCE7ye2Y1a91/JurCaENsMs5BvB06S+jpy96M6eWG1mTyvPYi/lE8ospcegvV7+pc8VoaW+4vMBUhCfEi5zJL8fp8eZbd7/tiuvY4itbjya36H7j/FPhnzeAIwkkU5UGPzVv3iO07MS9kPUx5QoGHkWl9JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666563; c=relaxed/simple;
	bh=2PjQVk510tcbfgZib7AgPxWnnYDh0QAwPChoXMnvxLk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rz/OY2c79yAFBFWIkQm70/I+pHUscuvJzSLQH6ioqYJqSv1s8TSd9WCLe43sUnyOeUcREB8WNfTbtkB98OH6E3RwWbaY9Gy3CrlSsNu9QhqcwqiUv1cU1Kw9QfVt9poq1FP31O2IkivF6OMOgImbZOLo8lyRjRyhwFK5QFm3nQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0pU1pj/n; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e24a31ad88aso2842515276.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728666561; x=1729271361; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EqKDRpMnKUFDCBzPjda6uGGHQMDnCKHOVUyUzH1aSkY=;
        b=0pU1pj/nOtxR1b9qf2oydny5YZiBFCdQo/bvL3t88g7ESgUDmCE/fsPperThBrJ2zo
         gG2YBaNw3RhQJvX6ZisFZaTh0Ww2aEWf92dNWu6JraqfmQrzY1V7+izF5f/r7ZaoNv09
         m80IuAaZqqmBMZp1kts535w08WCVKnd27Eupw58j7n29ULi2lwzuzIuLGudfC5IKqPt0
         MD3N6QW/Kaes6pAWRSry8svpJi4+qXUqkN7kCwOLPHFIwTEaDXpu6Pf4mMeiiysRPHyn
         COZWh6+3/x5gSijXPABL+JM5ZtmVKtI/icuaD/vujC2UYo0FYpSR8S+pxHjzdpvhl9g1
         Q9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728666561; x=1729271361;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EqKDRpMnKUFDCBzPjda6uGGHQMDnCKHOVUyUzH1aSkY=;
        b=WAkDKYp8Glyzi8UXcFekyPG3d7mtBWaGAg3+1hxh4NkDwNy3WhDCHLc0+hDNIL7ho9
         V1pOyipASB+EYtFMOyyw/OSt3Sei8CHqcD13mftgENt5c2meP4oDW7kJeUkbh3Mfvy31
         IdOtDTboLdFjTV3TaQOejAVvUzyeLbdTD1d6R1XF3gjZGQceQNoKRwfIp2IDP4OONq5j
         TgpdCQGrTZtcZOk0A8NHYLPxcGKTTceKL3/dUhil4s7YEIp8sm0QxuEgv3IM6iBhSNxk
         zj6NhU2kMETXu0jNwTWUpvUg745vDRb2KJdjD8wcARqCxy6mKEvkxut4seUwaSt5R/th
         m3vw==
X-Gm-Message-State: AOJu0YzmmXp4zN0q7DLQnFp66m/94qmvIbcoxPUlvqRw9PUDqrpNqXj2
	RikXV9T+8Z+hM+IhoJPUJthjq7OChP3S74isldAxi2LSuH90WSFULi2UcB29HYan7iME9ap8p59
	qF/KvxJqkl6XWenVd6WXrR2bEj7Pzcc0pj0xHfcWm8LKuc9Y+YiAIVU5mwGbCGGyfsSsIks8HhF
	makucE+ckj9aFsAECCIBhzvoBWg/tLnA==
X-Google-Smtp-Source: AGHT+IGig0d5gAOPvWubCGMNO+HS6pD/uIfah+XgCdryUbEN/NLF/DgvzT5KU18B+Vqf6kzsVXzoL8F5
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a25:ef0c:0:b0:e1c:ed3d:7bb7 with SMTP id
 3f1490d57ef6-e2919c5a54bmr1972276.1.1728666560536; Fri, 11 Oct 2024 10:09:20
 -0700 (PDT)
Date: Fri, 11 Oct 2024 19:08:55 +0200
In-Reply-To: <20241011170847.334429-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011170847.334429-10-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122; i=ardb@kernel.org;
 h=from:subject; bh=O1XJt0IMD45pv2Yzif9KcFzsw4OlwGa7+DE3CnbJzlw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ0zehXXKTcG3hKH5ilqN7VPNj45fmOiRemqqZWcpXs++
 IUkec3qKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNhM2JkeLw7Ybp/inLsketP
 lx1a+fIA5+GjMSmi/rejKnVb7vCfPMXwPyxi5YQ3XxViDx1bJ8Bs1tXxo+r6YkO91rWPWL/sCUt N4wEA
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011170847.334429-17-ardb+git@google.com>
Subject: [PATCH v3 7/8] crypto: x86/crc32c - Add jump table annotation
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, keescook@chromium.org, 
	linux-hardening@vger.kernel.org, nathan@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jan Beulich <jbeulich@suse.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Annotate the indirect jump with a relocation that correlates it with the
jump table emitted into .rodata. This helps objtool identify the jump
table, allowing it to infer the places in the code that are reachable
from the jump.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
index 45b005935194..7292090e76dd 100644
--- a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
+++ b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
@@ -171,6 +171,7 @@ SYM_FUNC_START(crc_pcl)
 	leaq	jump_table(%rip), %bufp
 	movslq	(%bufp,%rax,4), len
 	addq	len, %bufp
+	.reloc	., R_X86_64_NONE, jump_table
 	JMP_NOSPEC bufp
 
 	################################################################
@@ -327,6 +328,8 @@ JMPTBL_ENTRY %i
 	i=i+1
 .endr
 
+.size	jump_table, . - jump_table
+.type	jump_table, @object
 
 	################################################################
 	## PCLMULQDQ tables
-- 
2.47.0.rc1.288.g06298d1525-goog


