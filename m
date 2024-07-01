Return-Path: <linux-kernel+bounces-236870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38CE91E7FD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99631282D17
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3FB16F826;
	Mon,  1 Jul 2024 18:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="K8RbXcQ9"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D6A10F9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 18:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719859941; cv=none; b=kS/X1npsceRCeYRCgoO3icmWposZ6G4gGFU0l7j3n4gAIp0Ulrpc1juCXWUA5fFJLkTx4rowJFO23O1YqPT+K7dZuUNUgIzEF2W2+km25QBXPKS3+g9OjaB1q4bOJ1y2vLNqe+f3dejgJfUfbmySQMvV+E9qnh8pjCSOJ0tZXk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719859941; c=relaxed/simple;
	bh=ZcG+b3Dv/SnxxwfzU/Qq9Bc/ThEdYMBG2LbDPkLlC9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TpONiIU1SrsPRZzcazBDR9POamd1CLJqEghaMeQu5QkfXSBwgP4vUEDP4zSHfUemNRJ7ypKzzX+hOAOdVPw+8wkMV/AJK79cvMKka4GF88lkmQHmN9McKhDVJdniTI/yCAIWSKNejsZHvwLJC4p1PAZh/o/DNgTfzHMnO2bz1bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=K8RbXcQ9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f9c6e59d34so27058205ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 11:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719859939; x=1720464739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itcRXPPZh8Q3BXWaLokMC5j6eLfJ7AJxltwXOVqlQWc=;
        b=K8RbXcQ97Pun0jPkmi+5jJ9RiV1uQE+IQxZnQQZ4NcoBarDXfZcY/LfOmE6rJaYd61
         N9ilmMkgE8Lng0EVB+jjfVG9QSPCSiq/NJL7c1jwYgDjJASnfCxsTgzJbmT0vs0t1EWG
         HfSoRtLBr1cjRiyUiTVdEyJ0kT2akyLKiI0bQNqSwh0CFwhnHBa2ZLxtZBC3msSo/Ukj
         BPNwNmYrawuCfD0QHcLxjrjQZAmWozH54uezn94s12xDvhrDBAHZ/WknXJTBzBa1jJCS
         /gEVMJtFpG9X8om42nR2+DVVrg4UwMXrv/9m6Ac2WGkXwiG4+LhtTvCODanx3N/voums
         vPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719859939; x=1720464739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itcRXPPZh8Q3BXWaLokMC5j6eLfJ7AJxltwXOVqlQWc=;
        b=PB9YUHFdscfeL/sp+1ktRo6DtgqQwXxUuwy6lQFSaD/0xUXhEtZiP5tV//YJI/jYWo
         jRVpU7VVf7MdsyQC+HczlApnReSsUWufS5r3ZQO+nANbBcJuDti8eSQ2T7HA5e1ODzt6
         N2qDjMNdMtlBGpqD0yvFNQo1Wl6V/A0wnXkWEMVvGKRteODZ5jGinBVSyTM2FrWniRzR
         2kBNJHfn/Hfl33keD79H52yfQus7E+RFIQL4W2Iq+65KGnlsFM1rd/CCPzjFiShavYXS
         SjVhlDfQJtej0/gXbM6De2Ze3rRx6A/7VVaP2IC1wENjCjxXCYCWeorR99pNWej+sc6k
         Ezog==
X-Forwarded-Encrypted: i=1; AJvYcCVHxX6mkjqIFoBpYzzNzwGAlqrcnAHlZ6BwvNjB/dk+kouujmirdxqMRCyXOsCI12dCAEkei6zFZWTf5G9TbGTtSt8fTEwE1fXIgXQK
X-Gm-Message-State: AOJu0YxWmADTnUmRneh+X/whnCkMO3iV40cd6H5DDXy+9Mud4REyNkRC
	fLF7w8HTDGZbacocEcF1d61sjVeWCgcFL5Cpkm+qAOzkyhxi4P53cpltWZBUqTp4YhI8PNIwhZB
	l
X-Google-Smtp-Source: AGHT+IGIUJjGzCtP0TFRY0kOYr6wkwolnJ7bp8Bd4PCKOWhg54h7MqyOQeiMmVlGODF0WvjecY3/hQ==
X-Received: by 2002:a17:903:32d2:b0:1f6:fe0d:ad47 with SMTP id d9443c01a7336-1fadbd08cbbmr59034325ad.62.1719859939141;
        Mon, 01 Jul 2024 11:52:19 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10d1ccesm69883375ad.20.2024.07.01.11.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 11:52:18 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Wende Tan <twd2.me@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sami Tolvanen <samitolvanen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v3 3/4] RISC-V: pi: Add kernel/pi/pi.h
Date: Mon,  1 Jul 2024 14:51:31 -0400
Message-ID: <20240701185132.319995-4-jesse@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701185132.319995-1-jesse@rivosinc.com>
References: <20240701185132.319995-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add pi.h header for declarations of the kernel/pi prefixed functions
and any other related declarations.

Suggested-by: Charlie Jenkins <charlie@rivosinc.com>
Signed-off-by: Jesse Taube <jesse@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
V1 -> V2:
 - New patch
V2 -> V3:
 - Spelling
---
 arch/riscv/kernel/pi/cmdline_early.c | 10 ++--------
 arch/riscv/kernel/pi/fdt_early.c     |  7 +------
 arch/riscv/kernel/pi/pi.h            | 17 +++++++++++++++++
 3 files changed, 20 insertions(+), 14 deletions(-)
 create mode 100644 arch/riscv/kernel/pi/pi.h

diff --git a/arch/riscv/kernel/pi/cmdline_early.c b/arch/riscv/kernel/pi/cmdline_early.c
index f6d4dedffb84..fbcdc9e4e143 100644
--- a/arch/riscv/kernel/pi/cmdline_early.c
+++ b/arch/riscv/kernel/pi/cmdline_early.c
@@ -6,15 +6,9 @@
 #include <asm/pgtable.h>
 #include <asm/setup.h>
 
-static char early_cmdline[COMMAND_LINE_SIZE];
+#include "pi.h"
 
-/*
- * Declare the functions that are exported (but prefixed) here so that LLVM
- * does not complain it lacks the 'static' keyword (which, if added, makes
- * LLVM complain because the function is actually unused in this file).
- */
-u64 set_satp_mode_from_cmdline(uintptr_t dtb_pa);
-bool set_nokaslr_from_cmdline(uintptr_t dtb_pa);
+static char early_cmdline[COMMAND_LINE_SIZE];
 
 static char *get_early_cmdline(uintptr_t dtb_pa)
 {
diff --git a/arch/riscv/kernel/pi/fdt_early.c b/arch/riscv/kernel/pi/fdt_early.c
index 899610e042ab..40ee299702bf 100644
--- a/arch/riscv/kernel/pi/fdt_early.c
+++ b/arch/riscv/kernel/pi/fdt_early.c
@@ -3,12 +3,7 @@
 #include <linux/init.h>
 #include <linux/libfdt.h>
 
-/*
- * Declare the functions that are exported (but prefixed) here so that LLVM
- * does not complain it lacks the 'static' keyword (which, if added, makes
- * LLVM complain because the function is actually unused in this file).
- */
-u64 get_kaslr_seed(uintptr_t dtb_pa);
+#include "pi.h"
 
 u64 get_kaslr_seed(uintptr_t dtb_pa)
 {
diff --git a/arch/riscv/kernel/pi/pi.h b/arch/riscv/kernel/pi/pi.h
new file mode 100644
index 000000000000..493c8cb7c0e6
--- /dev/null
+++ b/arch/riscv/kernel/pi/pi.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _RISCV_PI_H_
+#define _RISCV_PI_H_
+
+#include <linux/types.h>
+
+/*
+ * The following functions are exported (but prefixed). Declare them here so
+ * that LLVM does not complain it lacks the 'static' keyword (which, if
+ * added, makes LLVM complain because the function is unused).
+ */
+
+u64 get_kaslr_seed(uintptr_t dtb_pa);
+bool set_nokaslr_from_cmdline(uintptr_t dtb_pa);
+u64 set_satp_mode_from_cmdline(uintptr_t dtb_pa);
+
+#endif /* _RISCV_PI_H_ */
-- 
2.45.2


