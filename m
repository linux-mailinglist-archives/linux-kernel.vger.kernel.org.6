Return-Path: <linux-kernel+bounces-409310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA4E9C8B43
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0763B262BC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1661FBC9A;
	Thu, 14 Nov 2024 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="YHPOpTfN"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F311FB3F7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731588691; cv=none; b=nnuTtANNFI5kVchQ1z+SCYtyeB3K6CE4p+MzlB7QZB9gPvPr151DRWNrvd+nsN0dU4Ok6gKwaDRAZD1G/rw0kDT4QnYqls4YF4OlyaGpOPn6/2twekPTbt7tYBKb5HC/xOzHVIxlYjputKlYD4cDRvs5e9Dn4fXLCNWZ1wlqvZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731588691; c=relaxed/simple;
	bh=Epo/XoTq1b514RFdrpV34NQcKsekqQJV/6icel7gcX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mec5sWxs68BHYPf48ZH/ieMVRKJwvRQwXZbELcUHC9Dngb5yhZTNprR2gtg76dyaq1SS2ofo35tiwPJ2R9wfRKGxWNNsyCbEQ3eE200XYqscqNeMdb1bcQVzPAiw3/0daQJZkxlon9a1uOd3BQ1u11u++l0CymJ+KcwQ1ovbYPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=YHPOpTfN; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731588683;
	bh=/xyoIRSJmInmDwoONzd0nO8B+3gcPMzdo/aHrDLApD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YHPOpTfNP4nKRfK9Nih6QLMj3M5I4vIxVjEbH/SBX90PK8Ktl9JiYkjaYxlcKQ67O
	 6qqmRuQFcPS6gHlVy1YZQtW49+U9JjWk81IUVo2cRj+svkEkAghTVLUaIVOZRv6fhk
	 bqrn876wcS9gi5ryRxeQbxtqbqmgj6BWv5IlcRWx/Fj2uc5Hu97fxYGXjAvWKckufa
	 DpcDjlDtcdEJ/s1BPE9ChsghoBAIaLGl8WG6u+0SaEeHfP0P+2NeVVNMuu8hKdcbea
	 ZrFjjUVJu7GxfAoFTUbsL3O0Fz6OIOThKPdwn6rlq1VxPGz2CXvort80oU2sAeeyq1
	 91zcY/YfMuUfA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xq0QM49bgz4xTx;
	Thu, 14 Nov 2024 23:51:23 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>,
	<jk@ozlabs.org>,
	<arnd@arndb.de>,
	<geoff@infradead.org>
Subject: [RFC PATCH 14/20] powerpc: Remove UDBG_RTAS_CONSOLE
Date: Thu, 14 Nov 2024 23:51:03 +1100
Message-ID: <20241114125111.599093-14-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114125111.599093-1-mpe@ellerman.id.au>
References: <20241114125111.599093-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IBM Cell blade support was the last user of UDBG_RTAS_CONSOLE.

Although it's still possible to build it via
PPC_EARLY_DEBUG_UDBG_RTAS_CONSOLE, AFAIK it's not useful on any
other platfoms, because only Cell and JS20 era machines provided the
RTAS get/put-term-char functions.

If anyone is using it or needs it we can always resurrect it from git.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig.debug     |  7 ----
 arch/powerpc/kernel/rtas.c     | 75 ----------------------------------
 arch/powerpc/kernel/udbg.c     |  3 --
 arch/powerpc/platforms/Kconfig |  4 --
 4 files changed, 89 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 20d05605fa83..f15e5920080b 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -216,13 +216,6 @@ config PPC_EARLY_DEBUG_RTAS_PANEL
 	help
 	  Select this to enable early debugging via the RTAS panel.
 
-config PPC_EARLY_DEBUG_RTAS_CONSOLE
-	bool "RTAS Console"
-	depends on PPC_RTAS
-	select UDBG_RTAS_CONSOLE
-	help
-	  Select this to enable early debugging via the RTAS console.
-
 config PPC_EARLY_DEBUG_PAS_REALMODE
 	bool "PA Semi real mode"
 	depends on PPC_PASEMI
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index d31c9799cab2..d7a738f1858d 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -798,66 +798,6 @@ void __init udbg_init_rtas_panel(void)
 	udbg_putc = call_rtas_display_status_delay;
 }
 
-#ifdef CONFIG_UDBG_RTAS_CONSOLE
-
-/* If you think you're dying before early_init_dt_scan_rtas() does its
- * work, you can hard code the token values for your firmware here and
- * hardcode rtas.base/entry etc.
- */
-static unsigned int rtas_putchar_token = RTAS_UNKNOWN_SERVICE;
-static unsigned int rtas_getchar_token = RTAS_UNKNOWN_SERVICE;
-
-static void udbg_rtascon_putc(char c)
-{
-	int tries;
-
-	if (!rtas.base)
-		return;
-
-	/* Add CRs before LFs */
-	if (c == '\n')
-		udbg_rtascon_putc('\r');
-
-	/* if there is more than one character to be displayed, wait a bit */
-	for (tries = 0; tries < 16; tries++) {
-		if (rtas_call(rtas_putchar_token, 1, 1, NULL, c) == 0)
-			break;
-		udelay(1000);
-	}
-}
-
-static int udbg_rtascon_getc_poll(void)
-{
-	int c;
-
-	if (!rtas.base)
-		return -1;
-
-	if (rtas_call(rtas_getchar_token, 0, 2, &c))
-		return -1;
-
-	return c;
-}
-
-static int udbg_rtascon_getc(void)
-{
-	int c;
-
-	while ((c = udbg_rtascon_getc_poll()) == -1)
-		;
-
-	return c;
-}
-
-
-void __init udbg_init_rtas_console(void)
-{
-	udbg_putc = udbg_rtascon_putc;
-	udbg_getc = udbg_rtascon_getc;
-	udbg_getc_poll = udbg_rtascon_getc_poll;
-}
-#endif /* CONFIG_UDBG_RTAS_CONSOLE */
-
 void rtas_progress(char *s, unsigned short hex)
 {
 	struct device_node *root;
@@ -2135,21 +2075,6 @@ int __init early_init_dt_scan_rtas(unsigned long node,
 		rtas.size = *sizep;
 	}
 
-#ifdef CONFIG_UDBG_RTAS_CONSOLE
-	basep = of_get_flat_dt_prop(node, "put-term-char", NULL);
-	if (basep)
-		rtas_putchar_token = *basep;
-
-	basep = of_get_flat_dt_prop(node, "get-term-char", NULL);
-	if (basep)
-		rtas_getchar_token = *basep;
-
-	if (rtas_putchar_token != RTAS_UNKNOWN_SERVICE &&
-	    rtas_getchar_token != RTAS_UNKNOWN_SERVICE)
-		udbg_init_rtas_console();
-
-#endif
-
 	/* break now */
 	return 1;
 }
diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
index 0a72a537f879..862b22b2b616 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -36,9 +36,6 @@ void __init udbg_early_init(void)
 #elif defined(CONFIG_PPC_EARLY_DEBUG_RTAS_PANEL)
 	/* RTAS panel debug */
 	udbg_init_rtas_panel();
-#elif defined(CONFIG_PPC_EARLY_DEBUG_RTAS_CONSOLE)
-	/* RTAS console debug */
-	udbg_init_rtas_console();
 #elif defined(CONFIG_PPC_EARLY_DEBUG_PAS_REALMODE)
 	udbg_init_pas_realmode();
 #elif defined(CONFIG_PPC_EARLY_DEBUG_BOOTX)
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index b78c132d47ab..fea3766eac0f 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -70,10 +70,6 @@ config PPC_DT_CPU_FTRS
 	  firmware provides this binding.
 	  If you're not sure say Y.
 
-config UDBG_RTAS_CONSOLE
-	bool "RTAS based debug console"
-	depends on PPC_RTAS
-
 config PPC_SMP_MUXED_IPI
 	bool
 	help
-- 
2.47.0


