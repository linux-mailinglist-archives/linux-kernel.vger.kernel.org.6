Return-Path: <linux-kernel+bounces-309995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F219672DA
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 19:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C463EB21FEE
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 17:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE9D12B143;
	Sat, 31 Aug 2024 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="lI8vyQyT"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865D6524F
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 17:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725125892; cv=none; b=pTGJj7/k+pCr0ActpmlQ2byTNIMunmEqZkkLZDn0uL2b3NWN1O+yLbkSMAre3cHxsGy+MbpH4TwYdUEPjWZbidOmUWgyGrod1uzRoPOIGdLUUUlsDPNavAV7KJwOIVYGSRHiahD5lvuEWVOsof/7YND2sde4h/9Q34SyFFiAK2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725125892; c=relaxed/simple;
	bh=EOcY+L8D4N7IBlwX0Odqgg3/L91yrzTPjC+Iku5hHNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CfHurF9LTDCdO55OXwY4kcH25Gh6YjAllXaueH9fOjrMemYwZH8NyRMSHgrLcdQHbwCEu3nli5HU5Ap7M463RPTQfF5Szo4V7nr/qJf1WmPE8WZgdpt+J9pfxL5zvM1MZH9etjsYVZGKMQtOVrDVnNxRN/NbNhQoeJIABCW0KKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=lI8vyQyT; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d1daa2577bso2087893a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 10:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1725125890; x=1725730690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nluqqBb+BAUW3mwcol/Wa1SYLfCHE6NgsvZ2crcUy8o=;
        b=lI8vyQyTOq3WrDfD/ROu4zBwiufV4/UMlb56xwfKvhycAwNvODOkng/2Wz7lSqpP/y
         Uw4LtE+U4Jco6SkaV0qVKKxIiJuwdB2hY5sIx7hwIZ2ytcLteqVAhc7Uv2KGZPA11D9J
         7rHd4d1j1iZNrscXWsfV12bmfFPMkK0j3PIFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725125890; x=1725730690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nluqqBb+BAUW3mwcol/Wa1SYLfCHE6NgsvZ2crcUy8o=;
        b=JS+S//X6IecPPBpNsFBjfYN4Wu7rBzGwl9Eyxz4awKnmmhXBXbSEELa2P7K2jkVuKI
         aBPl0FJ8CugHnoSaoQkyDPfrUtGh0azMFUdhZUYMqeL5Y7yDdusl2mvvjnuBzvorHFgV
         AkepXKpOcdm2bsi88t0OKo9x/73t5qff0L2ZkSiKOarQcsmW13vwlmRV522SEpHmS1v7
         8obLGTtk306NQ2uJ1Uucdz/f69r0K2dwZns/hLeZWF04tW3i9t+9dgJuWT/tk2uYvV/S
         fxS0RUcoX1B58ZxipnYmNHmVChiX5L7V57iZHxo5K/rQVsVC3E/h5RsFQybTXtpBBeKQ
         Rl7w==
X-Gm-Message-State: AOJu0YxfiDGqCklheo0uDZmx7b5IehfJqi9blurQAuJM8mSVEqZWZEuD
	bXjQywR82z+trzhZTlfNf7YVOdq+LyVGL6EwNZ9rDxHrHDa7/xcM5YA80HS0nruXaWpdX0njKNd
	3ML0=
X-Google-Smtp-Source: AGHT+IE2Ffi11EGA/F9QwFJuoATtmqMyPnnYYlONozuFnraNZlN1i0q9MYJpYkbzcWvGRQnANbW9/g==
X-Received: by 2002:a17:90a:51c4:b0:2c2:df58:bb8c with SMTP id 98e67ed59e1d1-2d85619f138mr10586174a91.18.1725125889573;
        Sat, 31 Aug 2024 10:38:09 -0700 (PDT)
Received: from shiro.work.home.arpa (p1980092-ipxg00g01sizuokaden.shizuoka.ocn.ne.jp. [153.201.32.92])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d89fb0aa0dsm1469187a91.18.2024.08.31.10.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 10:38:09 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org,
	geert@linux-m68k.org,
	gerg@linux-m68k.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH] m68k/mvme147: Fix console for mvme147
Date: Sun,  1 Sep 2024 02:38:02 +0900
Message-ID: <20240831173802.2805586-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a38eaa07a0ce ("m68k/mvme147: config.c - Remove unused functions"),
removed the console functionality for the mvme147 and it never got put
back and/or wired up again.

Put the console write function back and wire it up like mvme16x does
so it's possible to see Linux boot on this fine hardware once more.

Fixes: a38eaa07a0ce ("m68k/mvme147: config.c - Remove unused functions")
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/m68k/kernel/early_printk.c |  3 +++
 arch/m68k/mvme147/config.c      | 37 +++++++++++++++++++++++++++++++++
 arch/m68k/mvme147/mvme147.h     |  6 ++++++
 3 files changed, 46 insertions(+)
 create mode 100644 arch/m68k/mvme147/mvme147.h

diff --git a/arch/m68k/kernel/early_printk.c b/arch/m68k/kernel/early_printk.c
index 3cc944df04f6..260179d2ed93 100644
--- a/arch/m68k/kernel/early_printk.c
+++ b/arch/m68k/kernel/early_printk.c
@@ -14,6 +14,7 @@
 
 
 #include "../mvme16x/mvme16x.h"
+#include "../mvme147/mvme147.h"
 
 asmlinkage void __init debug_cons_nputs(const char *s, unsigned n);
 
@@ -24,6 +25,8 @@ static void __ref debug_cons_write(struct console *c,
       defined(CONFIG_COLDFIRE))
 	if (MACH_IS_MVME16x)
 		mvme16x_cons_write(c, s, n);
+	else if (MACH_IS_MVME147)
+		m147_scc_write(c, s, n);
 	else
 		debug_cons_nputs(s, n);
 #endif
diff --git a/arch/m68k/mvme147/config.c b/arch/m68k/mvme147/config.c
index 8b5dc07f0811..d62a0be13796 100644
--- a/arch/m68k/mvme147/config.c
+++ b/arch/m68k/mvme147/config.c
@@ -32,6 +32,7 @@
 #include <asm/mvme147hw.h>
 #include <asm/config.h>
 
+#include "mvme147.h"
 
 static void mvme147_get_model(char *model);
 extern void mvme147_sched_init(void);
@@ -185,3 +186,39 @@ int mvme147_hwclk(int op, struct rtc_time *t)
 	}
 	return 0;
 }
+
+static void scc_delay(void)
+{
+	int n;
+	volatile int trash;
+
+	for (n = 0; n < 20; n++)
+		trash = n;
+}
+
+static void scc_write(char ch)
+{
+	volatile char *p = (volatile char *) M147_SCC_A_ADDR;
+
+	do {
+		scc_delay();
+	} while (!(*p & 4));
+	scc_delay();
+	*p = 8;
+	scc_delay();
+	*p = ch;
+}
+
+void m147_scc_write(struct console *co, const char *str, unsigned int count)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	while (count--)	{
+		if (*str == '\n')
+			scc_write('\r');
+		scc_write(*str++);
+	}
+	local_irq_restore(flags);
+}
diff --git a/arch/m68k/mvme147/mvme147.h b/arch/m68k/mvme147/mvme147.h
new file mode 100644
index 000000000000..a6611b540bb2
--- /dev/null
+++ b/arch/m68k/mvme147/mvme147.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+struct console;
+
+/* config.c */
+void m147_scc_write(struct console *co, const char *str, unsigned int count);
-- 
2.43.0


