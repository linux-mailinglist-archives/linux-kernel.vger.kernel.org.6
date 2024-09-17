Return-Path: <linux-kernel+bounces-331838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3913797B1D5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A1A1F22E8A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52C719F474;
	Tue, 17 Sep 2024 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qB93pYbb"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA82B19F41B
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726585416; cv=none; b=nWyvxqdt7++hlcUPkz/rV2IJFQ8Xyvq2xkHQoAs4pzT88t7otZZexDX7k3qczmmDV8AE3mc6BzipUBG+njeWk3qjihvQ18VydW9dpYJvyQZsKEQjrZe6spr611bCageVDGZ/Byd+TnySPrkmKsSGIsIHKZOIdOwUXg/7S7fI2SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726585416; c=relaxed/simple;
	bh=xY9XpkDmSD/xk6OEETkgGDk1u5UGujSDYdc4wxzsr8c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UtOaqXT3OOroN36Ydu9m3liTww39SyXtFV8Lu1gEYCD+9v5tu3Ak2tRzWRaYi6Q9njUkYtQR4Ht7mDvinc1XS12WVM1oYIBjnhGTU2bYe3ZH0aIhbgcZ/VvhWA35nwPZXoXSqcSgno84ehUzhL47t8Auq+8fm0RtgalskSSbbI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qB93pYbb; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cacabd2e0so49457255e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726585411; x=1727190211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ND6eYc2e5z5r+zC7yHLZpkb+5DC0X9uw7m7bHoeXpy8=;
        b=qB93pYbbuazHoCUBxNhmGTV9rmDbsoCPgZJWFyKITjVWPtC0MixJJv3Ccp48vOL6nb
         ada/ssb0JH3+RBP7uLiOIbDK1DCwUKPka6dqsAfRTBc2FF/Sjafe/qztAMlxRObcL4em
         cQetQG9kWQ7CKoJEqsRy3D2GKb+l+V82BmWTRaNDG4hHoecel1xx4Uhq2GbnTw/S6akX
         CTZGbZz7TgsdunqeePl9BzEJG7HeS6O1qnJ5m1cuKmsCzxOzCwOER27N8N23nMDaRqre
         CNrEn0dreoB+p8DCQ0CKWWOVxk/HVhFLyp5RxXa+crCHFUDcDId1ev2Cc97xt6jjYxK+
         QdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726585411; x=1727190211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ND6eYc2e5z5r+zC7yHLZpkb+5DC0X9uw7m7bHoeXpy8=;
        b=eUKd/vzwiKXTYJdKJvNrWcrxsZ0dfpiG9Sun4W0vbgL2Y/dvnQerdhos6VkgsekRuA
         PayHzrsg5pX7WR3AG7bhJuIkP9Koj1ibkq6x+Fuva5xTiW5ktPzA/sqIgxqGrmWpDRav
         zaroi0o0+Xl6iNBO7oimNHeWyNF1bGTTT5NISufQspHCNA/1utH9BL83GVf0n//fdOKi
         zCXM8aEBwBUrGFg1AVMTENPIPLV5tIHrXEico8nwLepW9cXrQszNwIsKCItCykPIT99h
         AzyeOY3peM8BFA6BsaPmreeJ6bXCH0mAW62NAwilHRQuO1xxVZ4WXkPpU1RtGX2qLkty
         S0MQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0o2yLUu4VKwR8ce/p0rYO0ZKHdtXsQ8PfVSnCf/4mEiUNyW0hxYM7rgRm8tlP5POdw2Kb3Z1dA3Kf/yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFBvhT0018I2vKPFJSN5wr6FKvqXzAcaTLW5U4P/tOcpFDce8N
	qGgk64LH6S/OKPTwiDy3mXsSulabh49ykdJNXH8YnWQ5RShCZR3o1kV0Fg199io=
X-Google-Smtp-Source: AGHT+IFcVadBxh+qAbSCLQDPMzD1mmtwUDKphd/cCXTI/LhLVwku41hzZL7m/dPisydjMBeLLD04ig==
X-Received: by 2002:a05:600c:1e10:b0:42c:bd27:4c12 with SMTP id 5b1f17b1804b1-42cdb522cf7mr148867315e9.10.1726585410790;
        Tue, 17 Sep 2024 08:03:30 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (83-65-76-156.static.upcbusiness.at. [83.65.76.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e81a5sm9812770f8f.34.2024.09.17.08.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 08:03:30 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	syzbot+ba9eac24453387a9d502@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH -fixes] riscv: Fix kernel stack size when KASAN is enabled
Date: Tue, 17 Sep 2024 17:03:28 +0200
Message-Id: <20240917150328.59831-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We use Kconfig to select the kernel stack size, doubling the default
size if KASAN is enabled.

But that actually only works if KASAN is selected from the beginning,
meaning that if KASAN config is added later (for example using
menuconfig), CONFIG_THREAD_SIZE_ORDER won't be updated, keeping the
default size, which is not enough for KASAN as reported in [1].

So fix this by moving the logic to compute the right kernel stack into a
header.

Fixes: a7555f6b62e7 ("riscv: stack: Add config of thread stack size")
Reported-by: syzbot+ba9eac24453387a9d502@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000eb301906222aadc2@google.com/ [1]
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/Kconfig                   | 3 +--
 arch/riscv/include/asm/thread_info.h | 7 ++++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ccbfd28f4982..b65846d02622 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -759,8 +759,7 @@ config IRQ_STACKS
 config THREAD_SIZE_ORDER
 	int "Kernel stack size (in power-of-two numbers of page size)" if VMAP_STACK && EXPERT
 	range 0 4
-	default 1 if 32BIT && !KASAN
-	default 3 if 64BIT && KASAN
+	default 1 if 32BIT
 	default 2
 	help
 	  Specify the Pages of thread stack size (from 4KB to 64KB), which also
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index fca5c6be2b81..385b43211a71 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -13,7 +13,12 @@
 #include <linux/sizes.h>
 
 /* thread information allocation */
-#define THREAD_SIZE_ORDER	CONFIG_THREAD_SIZE_ORDER
+#ifdef CONFIG_KASAN
+#define KASAN_STACK_ORDER	1
+#else
+#define KASAN_STACK_ORDER	0
+#endif
+#define THREAD_SIZE_ORDER	(CONFIG_THREAD_SIZE_ORDER + KASAN_STACK_ORDER)
 #define THREAD_SIZE		(PAGE_SIZE << THREAD_SIZE_ORDER)
 
 /*
-- 
2.39.2


