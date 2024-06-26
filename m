Return-Path: <linux-kernel+bounces-231260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB9D9189F1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906BE1F23B3D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC01818EFC7;
	Wed, 26 Jun 2024 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="I7S4wIoo"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8CC16F0DC
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 17:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719422242; cv=none; b=PyziM+j579yvFDkgL4Y6UKheGyfK2lvGhNpb39JBESNBFzx7qPsCacJ4iGkyZa0+v704bJhuShTwK0NVpUcpi9JFH/1oCBx/ax5iqohqBEh/X02xBW9AKEEWZf/adspm1xoU/hTCHPQINreFVraxwIPekCCmvGDmWsDg821lqT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719422242; c=relaxed/simple;
	bh=3DZZhmSFMOPavCMPfnNC4cOlShyrQAnClSJBDgY04zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D41hXuZt80I9SjMugCmNgXf6HikPAk+cEwJhookZUYJebTcrfjCM7ftm2bRErcpcQCw8RtSxOySG823DSPioK7Ku40nB0X1iNwmewUg4YpH9FNfQPbXK4tybV8Gqb6uX1VZnJoN7/OVg79GcTanJ6w/xtT+UrUIQQN+NH7katHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=I7S4wIoo; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c85ca2dc5cso652941a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 10:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719422239; x=1720027039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+lAD5jtfoEc4FrM9h7co7KfTqJwWQk8uXEwNnDDNnA=;
        b=I7S4wIooRpFe1+N/K3tHXNpXUVoZfGfpAKVRDhmj1z6KWkOm4MXLTUW8IKfgScIEeJ
         BN1ubmpSvcVMedNSL0x1/o/5srNRsjXYei02frnjsUKgzVxMKjygB6KX9R0V92CwnX4I
         oOTkW+ejcVBuru585kMN//1sZCW+6ogGkDjtiUjUBs2+VSSgLrTW/o6lPWy6j1juiv2e
         aWY+rceSdNuAmW7ROd9UtAo9UENFD/MkrRdTnpBG1mQISOIWBlVIQRUfnpKe/h5uzQTT
         i5FchXuJaiPLX4kDsvYpkwQQD1b8mC5uGpaxjxoS6xWfWuKBeuk3Z7zYfxi6W2cEAsCo
         CTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719422239; x=1720027039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+lAD5jtfoEc4FrM9h7co7KfTqJwWQk8uXEwNnDDNnA=;
        b=lvaLJR0z8cQAC5puVZ66Gtos+AzrUmiQGpI8QBapDWODE7Mah+KYjvvodATNv2vGYx
         EXzljXTInCM1UDvMXvqiWves54v/3o8BGTdLHfmoqcZfwTXL0jn0JpEAucr+TgqCUwon
         6v+Nfc0D1yJOiVFDbqipFd/4Ouy33K4hPZQ87B1wRazS+LKu5FijBlIjOdfHbI3ZDltU
         VZhDudQG2bQtAafigkFrCyVYpW67KfLQPT3isdJBGHHoVDaR0RaZPsvZbBhzH06+WkgQ
         cxcZYHMRrTgRX1BzPIo9rtuJOgPi62l4jTMLzyllQlYBjzSauQoYEZSx/a9q3YhqA5dR
         ep5g==
X-Forwarded-Encrypted: i=1; AJvYcCXkANmK/eEvQX4WBIibUNkMxU7c52+xJPQ1PH0/FuW7r9zExdgHZYwu9OH7pM528/8sURUzfgBCd69gzwn1zCf+/KJwx0BtsDeKr5i9
X-Gm-Message-State: AOJu0YxycMR8bTXaH3/RIZd+YyHQIeoeJbyfLThWDx4Tji3tG6Qd5yLT
	Lcduby6Aa2LEsmzbHv98MLJNVfS+4LRdC+Cgrlo8lIkCzOseGZCwyIBexa7+Cdo=
X-Google-Smtp-Source: AGHT+IGG7s6Oe33J/XmHTMtV5FMqVvWxCk+2M3wpvCrsMnzNwrLwsfiUejeLhxTVumdEvPHZXZpSuQ==
X-Received: by 2002:a17:90a:4094:b0:2c8:2236:e2c3 with SMTP id 98e67ed59e1d1-2c848a4399bmr15456635a91.17.1719422238599;
        Wed, 26 Jun 2024 10:17:18 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c8f3b5ad36sm83217a91.26.2024.06.26.10.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 10:17:18 -0700 (PDT)
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
	Chen Jiahao <chenjiahao16@huawei.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 2/3] RISC-V: pi: Add kernel/pi/pi.h
Date: Wed, 26 Jun 2024 13:16:51 -0400
Message-ID: <20240626171652.366415-2-jesse@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626171652.366415-1-jesse@rivosinc.com>
References: <20240626171652.366415-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add pi.h header for declarations of the kernel/pi prefixed functions
and any other related declarations.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
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
index 000000000000..65da99466baf
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
+ * The folowing functions are exported (but prefixed) declare them here so
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


