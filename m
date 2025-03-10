Return-Path: <linux-kernel+bounces-554294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A598CA595D7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D8D188E328
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F207F22A7E1;
	Mon, 10 Mar 2025 13:12:36 +0000 (UTC)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC3622A4C8
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741612356; cv=none; b=geK8tlHei7r0C6Xc41nfmqepMZZbo28PQn7d8Ipbp3h2GYExbPu4NzDLOaLnqj9lfNkNXaOVjgMTyQtUptt5gIg9IS0ZkjrfEzBcYimAFIHiza0qMxmgXIsEaxklJLzXbGqplO0iXIRE000zK0lKe60ZPDr78gghyA6mXdlUgT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741612356; c=relaxed/simple;
	bh=nAvuHzzzD1vjk4IVAEMk2VVjvLtAEdLA21AfJteG4g0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FSFgcs8e0PSlhOABRTD6ODZnst1UuPP6PAb8nAI1Iu0DTQ8Erwz/KQgi/md5apXdUMCNtt6qTQlXFuT5dKdrp+iNtRZv13jiHjzmfqdWkUGL82BClP5ipwcpdjie0RQgV9XZbvgy6ET+9rEGDko8y0MCrG3PBTYeLXGO/ITDHkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:777d:24a3:a680:631e])
	by baptiste.telenet-ops.be with cmsmtp
	id P1CP2E0064XipzN011CPiH; Mon, 10 Mar 2025 14:12:25 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1trcvI-0000000DSFS-1IAc;
	Mon, 10 Mar 2025 14:12:23 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1trcve-0000000HCUx-3PbE;
	Mon, 10 Mar 2025 14:12:22 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Magnus Damm <magnus.damm@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Nicolas Pitre <nico@fluxnic.net>,
	Simon Horman <horms+renesas@verge.net.au>,
	Kees Cook <kees@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ARM: shmobile: smp: Enforce shmobile_smp_* alignment
Date: Mon, 10 Mar 2025 14:12:20 +0100
Message-ID: <c499234d559a0d95ad9472883e46077311051cd8.1741612208.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the addresses of the shmobile_smp_mpidr, shmobile_smp_fn, and
shmobile_smp_arg variables are not multiples of 4 bytes, secondary CPU
bring-up fails:

    smp: Bringing up secondary CPUs ...
    CPU1: failed to come online
    CPU2: failed to come online
    CPU3: failed to come online
    smp: Brought up 1 node, 1 CPU

Fix this by adding the missing alignment directive.

Fixes: 4e960f52fce16a3b ("ARM: shmobile: Move shmobile_smp_{mpidr, fn, arg}[] from .text to .bss")
Closes: https://lore.kernel.org/r/CAMuHMdU=QR-JLgEHKWpsr6SbaZRc-Hz9r91JfpP8c3n2G-OjqA@mail.gmail.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
To be queued in renesas-fixes-for-v6.14.
---
 arch/arm/mach-shmobile/headsmp.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/headsmp.S b/arch/arm/mach-shmobile/headsmp.S
index a956b489b6ea12ca..2bc7e73a8582d2b3 100644
--- a/arch/arm/mach-shmobile/headsmp.S
+++ b/arch/arm/mach-shmobile/headsmp.S
@@ -136,6 +136,7 @@ ENDPROC(shmobile_smp_sleep)
 	.long	shmobile_smp_arg - 1b
 
 	.bss
+	.align	2
 	.globl	shmobile_smp_mpidr
 shmobile_smp_mpidr:
 	.space	NR_CPUS * 4
-- 
2.43.0


