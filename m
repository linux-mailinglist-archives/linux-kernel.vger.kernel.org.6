Return-Path: <linux-kernel+bounces-223228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77884910FFA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC651C24BEA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990B01C007E;
	Thu, 20 Jun 2024 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ6Gl21+"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0EB1C0DED
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906282; cv=none; b=NkUVJXCv4y+2x0t+1ssofwxH3wMTRbHbERMmSKMq2ox7mGiQvncwY2GtfAfFsGZzAZYx7uxnMX8B4DjXYjJHP0rG8yvFH3g6iVgulwBZNIxApCVweEJXd8wtvWp8EZUCyrIhqa2WjDRExe6D8h8K1B2Wr+YO5W95KCYItQUZKkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906282; c=relaxed/simple;
	bh=CvUGneMbBEz1yZXc0tmhKn1m4dEY/czL5W1N3gs4WcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAxytrvi3+ilnI+xl4l2qfeIzKkq6UpZSjV0GmkCZNdwIupDTuo9TWci3hqnR9jPEYW7JPQxL9071zzg9qJUnJxeCM+TV/FmrUUgDbPwgXENpaznNVXhPw8WKWd4qwMHwRM2YgmY2H9gYsIM55LfLKlXlOvO2sGr6NYNaWW8sP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJ6Gl21+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f9b364faddso10597805ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 10:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906280; x=1719511080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJqqXRh/eOzPQsK99Bb/yzPgqho23i5/Ws9ra3QtPAE=;
        b=dJ6Gl21+0wH00d6JQcnBxXFXKmuV4DFYgxvewtSSzCaAkCI2W2V+Sv0O+pu6zt2hpC
         Lp87kcGrONgZAPQlg0aDNqgqlKz6p4ndDRQ2UC4k6JWYofAi0XP/uBL/V8iLLX/Afsuw
         u7wlkJ/xZYu/wGnQuvyugBhDFkkGX2tMpan6w7g7NY2nJ8EhiTLt6TVswbuWjZ6vs+Rs
         Bh7sbLpctQMvb6x1ZnT1jqvK2QTqWiy04uYErsjIyn47M6UgfPpO7BF50M8VgZ4kENuq
         /wq/XBg6/U46KTynkUb5lxS/IdZCgLWnJHLXQkNfWSp0bWf2Vhd78UoVvg2rPNv3xqWT
         3VEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906280; x=1719511080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJqqXRh/eOzPQsK99Bb/yzPgqho23i5/Ws9ra3QtPAE=;
        b=W4pAsImt59syVRzGK+pOMueySwaqCiPIvFg2R1twQwz6g6b57fKWinfdDYlVlYd7zc
         nnscdHST1sYtoy568GJijFBpwt+AneOvlQ8UDNpqIQDqxgREQJPVwUX5Z980Zat2czL7
         i8tPPdChQiQbc4JGLis59dcMlKgFjGpE0HF+9X8HeGUrmQUZt6Jz0LcYp5pL5G0bVHCc
         EX7l48VgfWCqSVwucBxc7xsxkCTeDaU7MRW7O07DjkVlzF33cqkbaOXzE8R2lTyQLv0V
         AGrap+A3G/U05z3Yj29EXat0/yVeZ34dSnX5oyKeXtpLO0icJH86x0onwjySE3NzSIRB
         e80g==
X-Gm-Message-State: AOJu0YyPc1v+/UOoykYwZoTW5+Q+1IvVtK/zxrsrrAsnO0Vabm14A4uX
	pd1GAl9kO/zBM/YYChjo8nba/X23wB7st06VL3ElX0vZn/e520zBoubmQ1W0pJo=
X-Google-Smtp-Source: AGHT+IF4qTXDJh2dmu7C8j7KbrNKpNe1traR1hBaJSEqONmhCH9MELk4yXOVD6L7Rof1XKmaGu/wKA==
X-Received: by 2002:a17:903:1211:b0:1f8:3c9e:3ba8 with SMTP id d9443c01a7336-1f9aa3b50b0mr70367035ad.10.1718906280486;
        Thu, 20 Jun 2024 10:58:00 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f339fbsm139710805ad.262.2024.06.20.10.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:58:00 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Colin Ian King <colin.i.king@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v4 18/40] powerpc: optimize arch code by using atomic find_bit() API
Date: Thu, 20 Jun 2024 10:56:41 -0700
Message-ID: <20240620175703.605111-19-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620175703.605111-1-yury.norov@gmail.com>
References: <20240620175703.605111-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use find_and_{set,clear}_bit() where appropriate and simplify the logic.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/powerpc/mm/book3s32/mmu_context.c     | 11 +++---
 arch/powerpc/platforms/pasemi/dma_lib.c    | 46 ++++++----------------
 arch/powerpc/platforms/powernv/pci-sriov.c | 13 ++----
 3 files changed, 20 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/mm/book3s32/mmu_context.c b/arch/powerpc/mm/book3s32/mmu_context.c
index 1922f9a6b058..ece7b55b6cdb 100644
--- a/arch/powerpc/mm/book3s32/mmu_context.c
+++ b/arch/powerpc/mm/book3s32/mmu_context.c
@@ -17,6 +17,7 @@
  *    Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
  */
 
+#include <linux/find_atomic.h>
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/export.h>
@@ -50,13 +51,11 @@ static unsigned long context_map[LAST_CONTEXT / BITS_PER_LONG + 1];
 
 unsigned long __init_new_context(void)
 {
-	unsigned long ctx = next_mmu_context;
+	unsigned long ctx;
 
-	while (test_and_set_bit(ctx, context_map)) {
-		ctx = find_next_zero_bit(context_map, LAST_CONTEXT+1, ctx);
-		if (ctx > LAST_CONTEXT)
-			ctx = 0;
-	}
+	ctx = find_and_set_next_bit(context_map, LAST_CONTEXT + 1, next_mmu_context);
+	if (ctx > LAST_CONTEXT)
+		ctx = 0;
 	next_mmu_context = (ctx + 1) & LAST_CONTEXT;
 
 	return ctx;
diff --git a/arch/powerpc/platforms/pasemi/dma_lib.c b/arch/powerpc/platforms/pasemi/dma_lib.c
index 1be1f18f6f09..db008902e5f3 100644
--- a/arch/powerpc/platforms/pasemi/dma_lib.c
+++ b/arch/powerpc/platforms/pasemi/dma_lib.c
@@ -5,6 +5,7 @@
  * Common functions for DMA access on PA Semi PWRficient
  */
 
+#include <linux/find_atomic.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/pci.h>
@@ -118,14 +119,9 @@ static int pasemi_alloc_tx_chan(enum pasemi_dmachan_type type)
 		limit = MAX_TXCH;
 		break;
 	}
-retry:
-	bit = find_next_bit(txch_free, MAX_TXCH, start);
-	if (bit >= limit)
-		return -ENOSPC;
-	if (!test_and_clear_bit(bit, txch_free))
-		goto retry;
-
-	return bit;
+
+	bit = find_and_clear_next_bit(txch_free, MAX_TXCH, start);
+	return bit < limit ? bit : -ENOSPC;
 }
 
 static void pasemi_free_tx_chan(int chan)
@@ -136,15 +132,9 @@ static void pasemi_free_tx_chan(int chan)
 
 static int pasemi_alloc_rx_chan(void)
 {
-	int bit;
-retry:
-	bit = find_first_bit(rxch_free, MAX_RXCH);
-	if (bit >= MAX_TXCH)
-		return -ENOSPC;
-	if (!test_and_clear_bit(bit, rxch_free))
-		goto retry;
-
-	return bit;
+	int bit = find_and_clear_bit(rxch_free, MAX_RXCH);
+
+	return bit < MAX_TXCH ? bit : -ENOSPC;
 }
 
 static void pasemi_free_rx_chan(int chan)
@@ -374,16 +364,9 @@ EXPORT_SYMBOL(pasemi_dma_free_buf);
  */
 int pasemi_dma_alloc_flag(void)
 {
-	int bit;
+	int bit = find_and_clear_bit(flags_free, MAX_FLAGS);
 
-retry:
-	bit = find_first_bit(flags_free, MAX_FLAGS);
-	if (bit >= MAX_FLAGS)
-		return -ENOSPC;
-	if (!test_and_clear_bit(bit, flags_free))
-		goto retry;
-
-	return bit;
+	return bit < MAX_FLAGS ? bit : -ENOSPC;
 }
 EXPORT_SYMBOL(pasemi_dma_alloc_flag);
 
@@ -439,16 +422,9 @@ EXPORT_SYMBOL(pasemi_dma_clear_flag);
  */
 int pasemi_dma_alloc_fun(void)
 {
-	int bit;
-
-retry:
-	bit = find_first_bit(fun_free, MAX_FLAGS);
-	if (bit >= MAX_FLAGS)
-		return -ENOSPC;
-	if (!test_and_clear_bit(bit, fun_free))
-		goto retry;
+	int bit = find_and_clear_bit(fun_free, MAX_FLAGS);
 
-	return bit;
+	return bit < MAX_FLAGS ? bit : -ENOSPC;
 }
 EXPORT_SYMBOL(pasemi_dma_alloc_fun);
 
diff --git a/arch/powerpc/platforms/powernv/pci-sriov.c b/arch/powerpc/platforms/powernv/pci-sriov.c
index cc7b1dd54ac6..e33e57c559f7 100644
--- a/arch/powerpc/platforms/powernv/pci-sriov.c
+++ b/arch/powerpc/platforms/powernv/pci-sriov.c
@@ -3,6 +3,7 @@
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 #include <linux/bitmap.h>
+#include <linux/find_atomic.h>
 #include <linux/pci.h>
 
 #include <asm/opal.h>
@@ -397,18 +398,12 @@ static int64_t pnv_ioda_map_m64_single(struct pnv_phb *phb,
 
 static int pnv_pci_alloc_m64_bar(struct pnv_phb *phb, struct pnv_iov_data *iov)
 {
-	int win;
+	int win = find_and_set_bit(&phb->ioda.m64_bar_alloc, phb->ioda.m64_bar_idx + 1);
 
-	do {
-		win = find_next_zero_bit(&phb->ioda.m64_bar_alloc,
-				phb->ioda.m64_bar_idx + 1, 0);
-
-		if (win >= phb->ioda.m64_bar_idx + 1)
-			return -1;
-	} while (test_and_set_bit(win, &phb->ioda.m64_bar_alloc));
+	if (win >= phb->ioda.m64_bar_idx + 1)
+		return -1;
 
 	set_bit(win, iov->used_m64_bar_mask);
-
 	return win;
 }
 
-- 
2.43.0


