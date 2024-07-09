Return-Path: <linux-kernel+bounces-246495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C299992C2A6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40D801F24695
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF4618004F;
	Tue,  9 Jul 2024 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="QMgwa4y/"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF7017B048
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720546784; cv=none; b=rK0YlACLkiVORxZhhLH8Jo3aqcDyUK1hkYtR0wdq+xfpSnZCA2sAVpDkGQeaj5vhTAN6UPZeasaXuZudQHGsIOd9Vo+IBBJ7X7kcPZRap9UU0fU2Zpse9WNYfDNKRKCwJvVer20o8pzDxYSrbgAIvdtk0RgKTgMUhbiAPtNKV1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720546784; c=relaxed/simple;
	bh=iZR0NGWR5vQW1Y6XAHVII3rqckWYwV27vJBs+YmWQHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Txb0zwrc6Ac59WC1OlwziIs3HktKwZ95xTGtPTOvw49iqZAlfkDw9p2Za2pksMdq7zrUrHCGGLF+/Oe8HbaMPfTfkx2F3YTda7XvpLrwpj7vGPZJfZN1X4mUozeLlZEWlQXegPsX8kppogqxtnBlNtvun8XUBPyrTDOzByM7VPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=QMgwa4y/; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-79f08b01ba6so246825385a.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 10:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720546782; x=1721151582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oe7d24KWB8rzk++ulHp+tuuvOpse+BwjRMWl/Nf52L0=;
        b=QMgwa4y/zfmsg1YIt48ELY/p/FytyzPiZLLfoxB79+l+o6Hs3aQY1Mgm9NIBy9xXLA
         BSXmcyWf9vt3dVImNHfJ+PM8x+NllalNsy/Yx7LGdKSgeJTp6j6lGwbv2Ck+XZfvn+c0
         jhMOGg7x/Yk66loD4FIoIdYSH0kzRYqX7KFKhVmClMi5kh/5xypZjMeXBlEDngwZhZMY
         HiYztUG5laQOH0gbnvR96Pl5+2TrUtVG4YhCJvDBCQsswAjTzgWSDyt+3NKd56i+XRmC
         rRzKWWMLAG1fdliAUxs9RFE4BJ+MS/8DHY8T72qY7R/+OXcOdidw1zNOk/lU++G3QwI0
         UbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720546782; x=1721151582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oe7d24KWB8rzk++ulHp+tuuvOpse+BwjRMWl/Nf52L0=;
        b=v8utZrvGknvaUdSrnz/goq9uQlyPW3PUED5659s0i8KuJEHYca10TBaY4ky2/skNHc
         lz3JAflIQG0Iu2PQ7HoWGBQQjNRJCuzqp8d3P4jN8c3CRK0mL+PPt+OSszD4DL0oeWBx
         NhfHf4NRAa+Fz6zozPwHatoapXENCMVNz7KPy8K6W8vY99DVgkznP8d8zaevIHg1kcQQ
         ZT51+3415t2jDstMkW8ESVScyGGL3F9F1BjBlOnYVAbTYz+PAxZyY5YcdyC8ciwdqFnB
         fAYQqNK84GS4VjrfB2jBI0N00QllsTuT2yPCHWF3Xr1XdykKwC41thPi94haGWnUxaGo
         2CYw==
X-Forwarded-Encrypted: i=1; AJvYcCWeHlOu4lFIPqpVhmtSDfrx3WijLxNWn9SyjmTtBdwm5FLY36Zp0tDocqmPXbDSz3c/goO3NMOvY2J7AHbBlkpZz649DaAcla/Ce/9q
X-Gm-Message-State: AOJu0YyRJJ7++QNwMzmuJ8x5dp5qF9aB5JxLiNMUgxa/cOvNeyXgUFQM
	lW3amblf8DAOX8oBiuv818sg84kXCavTFiLFn+XsXFAstsgjoerqRouzBbTX70I=
X-Google-Smtp-Source: AGHT+IGWO7bA4cK6KdAEt99qo/k1Gyg+6RZq4MQ67Cvy2nU3f5DYdGmozbUGc4IeTVAirQbmHO6UsQ==
X-Received: by 2002:ae9:e411:0:b0:79f:1bb:e7e6 with SMTP id af79cd13be357-79f1b5a9a89mr506394585a.18.1720546781921;
        Tue, 09 Jul 2024 10:39:41 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f18ff6762sm117547785a.10.2024.07.09.10.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 10:39:41 -0700 (PDT)
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
Subject: [PATCH v4 3/4] RISC-V: pi: Add kernel/pi/pi.h
Date: Tue,  9 Jul 2024 13:39:36 -0400
Message-ID: <20240709173937.510084-4-jesse@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709173937.510084-1-jesse@rivosinc.com>
References: <20240709173937.510084-1-jesse@rivosinc.com>
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
V3 -> V4:
 - No changes
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


