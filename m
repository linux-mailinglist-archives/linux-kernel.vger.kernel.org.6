Return-Path: <linux-kernel+bounces-547917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2C2A52197
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B31B1691E1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0990205E36;
	Wed,  5 Mar 2025 23:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="viIuGAIJ"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC2D1FCFF5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 23:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215645; cv=none; b=XXEMFGT2UKtm0TABDO/gLRL5Ird4iRRl/sVjgQEDihjHSC7yPAKRECo7bEQyWNSmNdOAKXiWfGJKtFug+l24S9zCcTCIby1rsu9uax8VxLFj22KfwefkNnfSuj/J/3x1W5iLTMUFpps746aLyF7WrhkqAxiB5KjIYE+S++72lTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215645; c=relaxed/simple;
	bh=g0QrlFghj/wYi3pHrM1E4FGE1hrhwiJrmPHndROZfrM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cXz58uDActblyNxV3Er4SeFZsOPsg1C5javfOEz4ftfajslz2zWNCQfHOTCFckJ5qbDPZVTCYlavfOKkEV5AdPDTCY8YfF3PJ7S8DOICEjnb47B5S40FF3n29ghwA0skOXceJSDzho6vIKpXEwerThZK5qfOFJqcEVJtey5EXpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=viIuGAIJ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2feae794508so134948a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 15:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741215641; x=1741820441; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AXOEYTInHDTSYq1AFClqzRbl+ZkEHDGXfjWhKaTrwBI=;
        b=viIuGAIJ+9zKm2yHZZ+ubC79wWT6YnguDBSbTxjUniltvcf8EbGMT1RA0sryKUVerh
         nFTdll5kzh6tbupawS+OB2pwCWeWAPTPgnL9AvneMGLas4ZzXzz4L1MfhVrEpEMt06wO
         KwBy5WeZSbgtPdf5smNhjk9Mtf9kug2yZAiLvoUIl30d3HDT2J7HzmWIR15SRCzLf3eZ
         A5mfdCbpt9LYPS/TAoiqdGliMbaitpozX1gbBPLRBJZv3Y6Tvx+F7CFDaF+C8wMvzmqg
         qAFIXeoOXQ/h8BT9yZOyrmYne7rCv45ogN4Fvxm8nEsiXCKrgD3tvEJ/KKbfs6VjHTB7
         GgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741215641; x=1741820441;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AXOEYTInHDTSYq1AFClqzRbl+ZkEHDGXfjWhKaTrwBI=;
        b=jFbmHJUjVlKzB8TSF3fOQUuV/KiTwtF6m4sv1KWa8zN2DQUy3S6TyScxkCKneEd9L3
         OJzpdxJmhwAQaotI8kLc598AcFWxPoSQjtwE9xKP/p9pcMi2D+fdDg2dxXnB4jNW6fOo
         CFIgBWM1sPVFERdoGSLefm0fDhpzSlstmSGXcKyS+v7hk0FHPRuuogExKwzBIFEquq7E
         XU/S1Ej3tn8qpxmILpUuCKsaghAyX6t7/83OPoIDyDf1hc6JnL04Qtk2PXXYF5mE9GcT
         klaQbtIrqJXB9wjZ+EF/CirK+1/2QYq2oPCdDLQOfATkLVN4EPAzIupND72BoryC5II+
         8SLA==
X-Forwarded-Encrypted: i=1; AJvYcCWjfOMIhQz0SbeqgO69daKQjDpBwhHz35aYmut2KksldJo7d8hpwZU3y4qPyBqTJdvJBToR9prLICSTgfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJC7jvOl+9GVnFsN91zxJoabxG/XlIb+2PpAweEyN2ghxx1Spu
	KnTGK9b6/tqwMRVw9zE1GIDcFGcb5nOD5vWnXMMbiU7jwitODqoZPyh3Cs4diXI=
X-Gm-Gg: ASbGncuMZbh+OeHD6bkZNsq/1oKK9jPyNv2b/m8dujtkEtuPOevxdFNri8wxJiBuo5O
	QIXMa63NSteKnKSxE9okh8nY7rvN64KlJDEropwatjpOn+23UrZEQsr+wuHO/VnfIvbSSt/2iov
	KjSO+F1MK2OeB4WmDBYQoDqx7JepWCMEWEmKO4OzwZ6fYhHbIBP9bjP0F/FUnLCHAS3gPH9+t0I
	b2ytbQRXR+5UIwE6xQ41a1UfjI7+3n/0lEeYwJ1Bs//Yw/F4t6AD9HOG1AOX0ttu4+IktCEDu3D
	q1/34019/1qX3JFnBduKTKySZWJf8WqZD0dMsw533anbAiHdAuGz5jMy0YU0
X-Google-Smtp-Source: AGHT+IGC2nc8khTnmGuhu0Gds3SKj5WRJ4Lw9OkM+lUlr5dLYMfrx7W+qe5bbMu3V+b1JB/wwlZfuw==
X-Received: by 2002:a05:6a21:78a8:b0:1f3:48ef:8aa0 with SMTP id adf61e73a8af0-1f34944ed96mr9881349637.6.1741215641152;
        Wed, 05 Mar 2025 15:00:41 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7dedd22esm10593413a12.63.2025.03.05.15.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 15:00:40 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH RESEND v4 0/4] entry: Move ret_from_fork() to C and inline
 syscall_exit_to_user_mode()
Date: Wed, 05 Mar 2025 15:00:24 -0800
Message-Id: <20250305-riscv_optimize_entry-v4-0-0d81bb45203f@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, Thomas Gleixner <tglx@linutronix.de>, 
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2306; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=g0QrlFghj/wYi3pHrM1E4FGE1hrhwiJrmPHndROZfrM=;
 b=owGbwMvMwCXWx5hUnlvL8Y3xtFoSQ/qJ69Mea/w8opI0a+Kna9vNuo8tW5fAtvxt4uYpv19N8
 504pyJgT0cpC4MYF4OsmCILz7UG5tY7+mVHRcsmwMxhZQIZwsDFKQATKQ9g+J81JzTmQg+vl6Dw
 6m9zz3m/LCjLuBUzMeizw23LdC2dBV2MDIsme6f4GU82P2Yu9ueXXMqj14vzqnwCntwxKK5c8Sp
 yIRcA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Similar to commit 221a164035fd ("entry: Move
syscall_enter_from_user_mode() to header file"), move
syscall_exit_to_user_mode() to the header file as well.

Testing was done with the byte-unixbench [1] syscall benchmark (which
calls getpid) and QEMU. On riscv I measured a 7.09246% improvement, on
x86 a 2.98843% improvement, on loongarch a 6.07954% improvement, and on
s390 a 11.1328% improvement.

Since this is on QEMU, I know these numbers are not perfect, but they
show a trend of general improvement across all architectures that use
the generic entry code.

[1] https://github.com/kdlucas/byte-unixbench

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v4:
- I had messed up warning for ct_state() on rebase, correct that issue
- Link to v3: https://lore.kernel.org/r/20250124-riscv_optimize_entry-v3-0-869f36b9e43b@rivosinc.com

Changes in v3:
- Fixup comment to properly reflect args (Alex)
- Fix prototypes for loongarch (Huacai)
- Link to v2: https://lore.kernel.org/r/20250123-riscv_optimize_entry-v2-0-7c259492d508@rivosinc.com

Changes in v2:
- Fixup compilation issues for loongarch
- Fixup compilation issues with CONFIG_CONTEXT_TRACKING_USER
- Link to v1: https://lore.kernel.org/r/20250122-riscv_optimize_entry-v1-0-4ee95559cfd0@rivosinc.com

---
Charlie Jenkins (4):
      riscv: entry: Convert ret_from_fork() to C
      riscv: entry: Split ret_from_fork() into user and kernel
      LoongArch: entry: Migrate ret_from_fork() to C
      entry: Inline syscall_exit_to_user_mode()

 arch/loongarch/include/asm/asm-prototypes.h |  8 +++++
 arch/loongarch/kernel/entry.S               | 22 ++++++-------
 arch/loongarch/kernel/process.c             | 33 +++++++++++++++----
 arch/riscv/include/asm/asm-prototypes.h     |  2 ++
 arch/riscv/kernel/entry.S                   | 20 +++++++-----
 arch/riscv/kernel/process.c                 | 21 +++++++++++--
 include/linux/entry-common.h                | 43 +++++++++++++++++++++++--
 kernel/entry/common.c                       | 49 +----------------------------
 8 files changed, 119 insertions(+), 79 deletions(-)
---
base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
change-id: 20240402-riscv_optimize_entry-583843420325
-- 
Charlie Jenkins <charlie@rivosinc.com>


