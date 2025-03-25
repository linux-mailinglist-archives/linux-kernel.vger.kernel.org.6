Return-Path: <linux-kernel+bounces-574631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A88A6E7D0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 01:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF691175656
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 00:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164CD13AA3C;
	Tue, 25 Mar 2025 00:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pmavc0Rl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E24838382;
	Tue, 25 Mar 2025 00:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742864148; cv=none; b=itzOTEKHCNWUKB1Bq+xv0anpC0qRwic5pHA1LBOxNyxUdayopjBSr5+fVvKfajux1CIVFULCrQBvWw/Iy4vk0cPcYIzDBotoZZS/OuQit3hdzH9u1u4z7i8c7yYu9IO6mwYhOtJOWKeKITxsOvXXx7q4BAuLPxUkLLCo0MailGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742864148; c=relaxed/simple;
	bh=NpcfTHMukeXCXP30oO1UEectOwTNw1m34QU+vW3Sbbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Nf/hnobjNlGpro+QfFjvXOMrMb/9wN9C3nvKJB7F8d1uzndFYWBvKOE/TcooKPsKZ8S4UgRXJ7rLqvr6RV003kvsJNQ7F0Bknkq6pyKIhEeKCuTmDVpdDWKq4S+1Y99vAutuIi8BO6IF6EMYntkwKmKmlsZnIrgf5aHdY5M5Ukg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pmavc0Rl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB7BCC4CEDD;
	Tue, 25 Mar 2025 00:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742864147;
	bh=NpcfTHMukeXCXP30oO1UEectOwTNw1m34QU+vW3Sbbo=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Pmavc0RlSBOGR6xNKAbF/ZR+32lscvN/+vAiuRs5EvOratNllS7fc9ufMMXXdFNwC
	 pF0HqlI/FUJcScL43RQAT/+I2h1KqLKoDtq4hnKzRm3WNNxygNN5OheR5CF+A+fEYZ
	 ds41xn56susr/8TI0seDvPSBrMCZultxtJzW2J0o9C7sa+PKY4z2UPvRjs+dpnqiZf
	 zW0v4rq2Fh4DYcMeEwjveh7tYE61s00b1NcaMg2QGh7rxunqEwDG9gbb+c/4x01iwi
	 oKwuRso27tw3IkTCdyGKwJjsF1bcy40Ld6OvX4xGw6NU4E5xmx0ZTwqri5p5kRgzVP
	 P1VySxhLYo2gA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB29C36002;
	Tue, 25 Mar 2025 00:55:47 +0000 (UTC)
From: Denis Mukhin via B4 Relay <devnull+dmukhin.ford.com@kernel.org>
Date: Mon, 24 Mar 2025 17:55:40 -0700
Subject: [PATCH v3] x86/early_printk: add MMIO-based UARTs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-earlyprintk-v3-1-aee7421dc469@ford.com>
X-B4-Tracking: v=1; b=H4sIAAv/4WcC/23MQQ6CMBCF4auQrq1pi0hl5T2MC9pOZaJSMiWNh
 HB3CytMXL6XfP/MIhBCZE0xM4KEEUOfR3komO3a/gEcXd5MCVWJUpYcWnpNA2E/Prk/a2O9FB6
 MZVkMBB4/W+12z7vDOAaatniS6/u/kySXXHsttavrVjt39YHc0YY3WzNJ7enpl6pMlbEGRKUuw
 ugdXZblC3ge2nPgAAAA
X-Change-ID: 20250313-earlyprintk-f68bcf10febc
To: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Denis Mukhin <dmukhin@ford.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742864146; l=5064;
 i=dmukhin@ford.com; s=20241125; h=from:subject:message-id;
 bh=RdmhzMXgwjWmCEHYWUItw+iaOq3OmT/DclEG21o0wbE=;
 b=DLjU+YwK42mtzlVicEbf642u6xddAlYO6z8RLgOGDSz5avySPSRCFa7osFhaV/NtS3/koWUUg
 MNxUjmiYQ1wBfTbCc2sltGt4f6HIhpmhJEa2jGotB/vBvvz15tpYdci
X-Developer-Key: i=dmukhin@ford.com; a=ed25519;
 pk=SsDZ9p39s0fqcpUKQuqKqrbn0rq6EtEAClvpOpzx6+U=
X-Endpoint-Received: by B4 Relay for dmukhin@ford.com/20241125 with
 auth_id=287
X-Original-From: Denis Mukhin <dmukhin@ford.com>
Reply-To: dmukhin@ford.com

From: Denis Mukhin <dmukhin@ford.com>

During the bring-up of an x86 board, the kernel was crashing before
reaching the platform's console driver because of a bug in the firmware,
leaving no trace of the boot progress.

It was discovered that the only available method to debug the kernel
boot process was via the platform's MMIO-based UART, as the board lacked
an I/O port-based UART, PCI UART, or functional video output.

Then it turned out that earlyprintk= does not have a knob to configure
the MMIO-mapped UART.

Extend the early printk facility to support platform MMIO-based UARTs
on x86 systems, enabling debugging during the system bring-up phase.

The command line syntax to enable platform MMIO-based UART is:
  earlyprintk=mmio,membase[,{nocfg|baudrate}][,keep]

Note, the change does not integrate MMIO-based UART support to:
  arch/x86/boot/early_serial_console.c

Also, update kernel parameters documentation with the new syntax and
add missing 'nocfg' setting to PCI serial cards description.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes in v3:
- Fixed formatting in early_mmio_serial_init()
- Rebased on tip/master, new code switched to using static_call_update()
- Doc update: added nocfg description for earlyprintk=pciserial and a note
  on 32-bit memory-mapped UARTs
- Link to v2: https://lore.kernel.org/r/20250314-earlyprintk-v2-1-2bcbe05290b8@ford.com

Changes in v2:
- Fixed description of early_mmio_serial_init()
- Link to v1: https://lore.kernel.org/r/20250313-earlyprintk-v1-1-8f818d77a8dd@ford.com
---
 Documentation/admin-guide/kernel-parameters.txt |  9 ++++-
 arch/x86/kernel/early_printk.c                  | 45 ++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3e5e41cbe3ce907bb286a6d86456241e02976f6d..1d1eaeac04b31ba808b9196d0f928050acfd17b7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1407,14 +1407,21 @@
 			earlyprintk=serial[,0x...[,baudrate]]
 			earlyprintk=ttySn[,baudrate]
 			earlyprintk=dbgp[debugController#]
-			earlyprintk=pciserial[,force],bus:device.function[,baudrate]
+			earlyprintk=pciserial[,force],bus:device.function[,{nocfg|baudrate}]
 			earlyprintk=xdbc[xhciController#]
 			earlyprintk=bios
+			earlyprintk=mmio,membase[,{nocfg|baudrate}]
 
 			earlyprintk is useful when the kernel crashes before
 			the normal console is initialized. It is not enabled by
 			default because it has some cosmetic problems.
 
+			Only 32-bit memory addresses are supported for "mmio"
+			and "pciserial" devices.
+
+			Use "nocfg" to skip UART configuration, assume
+			BIOS/firmware has configured UART correctly.
+
 			Append ",keep" to not disable it when the real console
 			takes over.
 
diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index fc1714bad04588abc3468a0e72df26513250162b..611f27e3890c2852cece31a9e948e7212c4e10fe 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -190,7 +190,6 @@ static __init void early_serial_init(char *s)
 	early_serial_hw_init(divisor);
 }
 
-#ifdef CONFIG_PCI
 static __noendbr void mem32_serial_out(unsigned long addr, int offset, int value)
 {
 	u32 __iomem *vaddr = (u32 __iomem *)addr;
@@ -207,6 +206,45 @@ static __noendbr unsigned int mem32_serial_in(unsigned long addr, int offset)
 }
 ANNOTATE_NOENDBR_SYM(mem32_serial_in);
 
+/*
+ * early_mmio_serial_init() - Initialize MMIO-based early serial console.
+ * @s: MMIO-based serial specification.
+ */
+static __init void early_mmio_serial_init(char *s)
+{
+	unsigned long baudrate;
+	unsigned long membase;
+	char *e;
+
+	if (*s == ',')
+		s++;
+
+	if (!strncmp(s, "0x", 2)) {
+		/* NB: only 32-bit addresses are supported. */
+		membase = simple_strtoul(s, &e, 16);
+		early_serial_base = (unsigned long)early_ioremap(membase, PAGE_SIZE);
+
+		static_call_update(serial_in, mem32_serial_in);
+		static_call_update(serial_out, mem32_serial_out);
+
+		s += strcspn(s, ",");
+		if (*s == ',')
+			s++;
+	}
+
+	if (!strncmp(s, "nocfg", 5)) {
+		baudrate = 0;
+	} else {
+		baudrate = simple_strtoul(s, &e, 0);
+		if (baudrate == 0 || s == e)
+			baudrate = DEFAULT_BAUD;
+	}
+
+	if (baudrate)
+		early_serial_hw_init(115200 / baudrate);
+}
+
+#ifdef CONFIG_PCI
 /*
  * early_pci_serial_init()
  *
@@ -351,6 +389,11 @@ static int __init setup_early_printk(char *buf)
 	keep = (strstr(buf, "keep") != NULL);
 
 	while (*buf != '\0') {
+		if (!strncmp(buf, "mmio", 4)) {
+			early_mmio_serial_init(buf + 4);
+			early_console_register(&early_serial_console, keep);
+			buf += 4;
+		}
 		if (!strncmp(buf, "serial", 6)) {
 			buf += 6;
 			early_serial_init(buf);

---
base-commit: cc086afdd3132fa2a80c3891639c2352521e5d73
change-id: 20250313-earlyprintk-f68bcf10febc

Best regards,
-- 
Denis Mukhin <dmukhin@ford.com>



