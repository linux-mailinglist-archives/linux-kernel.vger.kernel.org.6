Return-Path: <linux-kernel+bounces-268351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3763494238D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 01:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68FF71C22662
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFEE192B79;
	Tue, 30 Jul 2024 23:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="JfoWytVU"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2266E18CC1E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 23:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722383165; cv=none; b=ggYebcJgzpkH7MwLdgNbIK5SZxMGDIym1wUhDo6YOIPr13dUULLPgmqYumw3e13LN2zkQpn1nUcte0KkHtJNn24ySavMcgCrDJa2cQjieqQSx0IpA+OhKJ1UHEhuMs4GOzT8KkcPc2fTjgiONS4UBJYrGhV8GTti4sjF2wHn5Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722383165; c=relaxed/simple;
	bh=/F2IkqN6onhi8bqBg+Ffra8tWyO9XNvT/nQhWcfnN24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ANB1MtNDVlTJLtFkmeq6S6kqf39R2NmOzVgtS91gQTLKOcw5yNSmD3EmnWsRuNaxyiqup7layXtc12tJDg8psvunpF0Xi3Kl6HPYPx4Co096sR+EHf1kQQUH/9ooy7kFKAYeKO2tNjTTwwQpQ1ObgK9oqBj0bz7X7nN2uRRHPRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=JfoWytVU; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso5603508a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1722383161; x=1722987961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1I1Xf39ndiqFsWjFiF87exVBTjo0QTgARXHDppQr8z0=;
        b=JfoWytVU1KVqd5RFWpCaRBkF/BqIZCiQ9OopqdfzDgvA+DNEBWXNsiKJdPZ4qPT0Vd
         H7lbG9OgymYa6BZm/eBWVcXDnU1hV/YMW0rsdWECMm/oQUr+OJelc+H3PRnjOPUnVkRn
         HcAD/Z5tIbZDBEO+Jsc8nmm6o6Q5X9hEmQxiwZ626jb46J50dHta/IkkGBX9BNRCE2nR
         Z8uTpvvU5bZFkHzeW9oFUz9yEfjzKtajH5FjlmOJLYJ8E3ma9Nv525CQuxHgYNGbKmxC
         u9E/NY3+nEOcDlf4pkdhPlyZlOYt6zWvMVTKi25yjVR5jf/6xUdmCRUkETES/OIV7uzq
         Kytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722383161; x=1722987961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1I1Xf39ndiqFsWjFiF87exVBTjo0QTgARXHDppQr8z0=;
        b=LPVUL3zOYaEfEy57DBRn/PvVHVynCe+dAVU8fKY36f7uT12xageE7L0568wnh7CUBp
         72rPAUpgzxU7PPSJeqqznuvvoU2FlIy6fka2tR5h3e2ke1HHVLCokGnYR3yHxwlXNDBx
         WhdssyWdtXUJHP+KlXT9ajZ5MvFB5D/Q2cJ1XnWy7cXOe/vv7LuD4VcRl3o9NIGyWSzF
         ZXLgTl18v0S0NvmqVc0RpalZHB5dmQUfen3aE46/7R4KrY1nSxK+2989ngvrIF204Ncj
         20m4Hp1wUSlBCHdpVb1w/oYpXsTr/nBs+ERefhoHvbAhbkANLu9fyAJ6wU0Av7nnJ8Q2
         KpxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlifNkgz/FJRQW2uZr5hPa/q/hW8k3N5/dL5GU1o9HrRhDt7VDTsgK9fjhRCrInwukMJGob/etrkB8DnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrQz085FMFIici1sF/EOfVK2pOrvVaPul1wR/wGN0VimIA9gDj
	6o+kcKk81078wuHgyU5p7nPSH7r9aWf5x7RWuuab5x7pAQ+4vc4JXlxpRrCKfj1qm90OAWfW3tw
	CE/0=
X-Google-Smtp-Source: AGHT+IFAqKafX8aRVJKcPGIDXAPBt1l3roBbIwncVQu/DpqAKoun9DJpA1Bn0XY2A7WL+ctL0IkviA==
X-Received: by 2002:a05:6402:35d6:b0:5a2:2fa5:f146 with SMTP id 4fb4d7f45d1cf-5b021f0dcfbmr8913623a12.28.1722383161200;
        Tue, 30 Jul 2024 16:46:01 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63c50fdesm7861299a12.56.2024.07.30.16.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 16:46:00 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: geert@linux-m68k.org
Cc: linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [RESEND PATCH] m68k: cmpxchg: Use swap() to improve code
Date: Wed, 31 Jul 2024 01:45:07 +0200
Message-ID: <20240730234506.492743-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the local variable tmp and use the swap() macro instead.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 arch/m68k/include/asm/cmpxchg.h | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/m68k/include/asm/cmpxchg.h b/arch/m68k/include/asm/cmpxchg.h
index 4ba14f3535fc..71fbe5c5c564 100644
--- a/arch/m68k/include/asm/cmpxchg.h
+++ b/arch/m68k/include/asm/cmpxchg.h
@@ -3,6 +3,7 @@
 #define __ARCH_M68K_CMPXCHG__
 
 #include <linux/irqflags.h>
+#include <linux/minmax.h>
 
 #define __xg(type, x) ((volatile type *)(x))
 
@@ -11,25 +12,19 @@ extern unsigned long __invalid_xchg_size(unsigned long, volatile void *, int);
 #ifndef CONFIG_RMW_INSNS
 static inline unsigned long __arch_xchg(unsigned long x, volatile void * ptr, int size)
 {
-	unsigned long flags, tmp;
+	unsigned long flags;
 
 	local_irq_save(flags);
 
 	switch (size) {
 	case 1:
-		tmp = *(u8 *)ptr;
-		*(u8 *)ptr = x;
-		x = tmp;
+		swap(*(u8 *)ptr, x);
 		break;
 	case 2:
-		tmp = *(u16 *)ptr;
-		*(u16 *)ptr = x;
-		x = tmp;
+		swap(*(u16 *)ptr, x);
 		break;
 	case 4:
-		tmp = *(u32 *)ptr;
-		*(u32 *)ptr = x;
-		x = tmp;
+		swap(*(u32 *)ptr, x);
 		break;
 	default:
 		x = __invalid_xchg_size(x, ptr, size);
-- 
2.45.2


