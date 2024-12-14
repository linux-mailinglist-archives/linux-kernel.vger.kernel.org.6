Return-Path: <linux-kernel+bounces-446000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 102769F1E5D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 12:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102C0167C62
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 11:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E2A18EFCC;
	Sat, 14 Dec 2024 11:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="juRtzyi0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/kT1pB5h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAB8170A13
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734177024; cv=none; b=n/voia3llaNgsm5nKGnpimT4PKMhmXTqvf3Y+FPFJnv22HN22Y1WlFIAip7PhhjYfGmgC4tmkyWgm3nT+3ai9bb8jSoSWzLw4haW+AMET7Q58Nj57hcTHBCLJrlANjgzopv7A5TF6K4CxTPjWR3kOb6dl6utXVpb1kjrBXRs5+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734177024; c=relaxed/simple;
	bh=/mBUerS5XSezqwy29grxEF7QW9CSdXhISx4SRZhtWWQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cey60kcqi3KI6R52E1AK/ETsE5RF55sLvc0PgNX7XJXrzzXqD6MJLHyqyAyvtAaxDuOu2i1F/b+RX9JVTYU3/sBFC4UHxiLcRj5N7YYj0wVjGZvAc/euX8brkh3sD8hS1F6a+ZjdC6OPN7XPJ9NEQFt54U05u3TgTIdjj1KXoFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=juRtzyi0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/kT1pB5h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734177019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qzhprNUpJd8crZLNLycupfbl2vwMD3GsAtuBolAfNoY=;
	b=juRtzyi0tetJHjKFjtFzHZG7rWMU4N8Z58M+GYecSxP5OJThN+DFmtm9cO61sR2kWiqmHQ
	aamdpY7MSgaRK0jejENepHm7pqpbIV8dXvr/b0xNRygbfKV41faD1da+0ZTkahJiz3d6Wq
	MoxS5DwJOQ65jC2q/A1LDK+Mc5Z2581zOPBbZfG3LPUewGXQt5v6A96GfZvtomJrybn2wP
	CGCB3gC00aVXPfUwJixgX/ugMNN2SxXIsBUh5dmnwAPX//dbQkAaAMJdEpdkHqSq2Cn2az
	03VLM3QxmGOrVuCg4HPkkCaAFisP9EJorj4KtmkR8sYQK/REPQTQSCDxsaRTqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734177019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qzhprNUpJd8crZLNLycupfbl2vwMD3GsAtuBolAfNoY=;
	b=/kT1pB5h9x7NYf+v7YUGm9akGgpE576x1ScHoRdyaND8OyrX8q/cgdov3dsKva4erlJZ2+
	EcwB2vgCs/C9LpAA==
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>, Sunil V L
 <sunilvl@ventanamicro.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [Patch] PCI/MSI: Handle lack of irqdomain gracefully
In-Reply-To: <CAHVXubiNMp9chdUdvYjiQC2LMhNMMaGEiLMWZ-4RSV54jakP3g@mail.gmail.com>
References: <20241213115704.353665-1-alexghiti@rivosinc.com>
 <87v7vn917f.ffs@tglx>
 <CAHVXubiNMp9chdUdvYjiQC2LMhNMMaGEiLMWZ-4RSV54jakP3g@mail.gmail.com>
Date: Sat, 14 Dec 2024 12:50:18 +0100
Message-ID: <87ed2a8ow5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexandre observed a warning emitted from pci_msi_setup_msi_irqs() on a
RISCV platform which does not provide PCI/MSI support:

 WARNING: CPU: 1 PID: 1 at drivers/pci/msi/msi.h:121 pci_msi_setup_msi_irqs+0x2c/0x32
 __pci_enable_msix_range+0x30c/0x596
 pci_msi_setup_msi_irqs+0x2c/0x32
 pci_alloc_irq_vectors_affinity+0xb8/0xe2

RISCV uses hierarchical interrupt domains and correctly does not implement
the legacy fallback. The warning triggers from the legacy fallback stub.

That warning is bogus as the PCI/MSI layer knows whether a PCI/MSI parent
domain is associated with the device or not. There is a check for MSI-X,
which has a legacy assumption. But that legacy fallback assumption is only
valid when legacy support is enabled, but otherwise the check should simply
return -ENOTSUPP.

Loongarch tripped over the same problem and blindly enabled legacy support
without implementing the legacy fallbacks. There are weak implementations
which return an error, so the problem was papered over.

Correct pci_msi_domain_supports() to evaluate the legacy mode and add
the missing supported check into the MSI enable path to complete it.

Fixes: d2a463b29741 ("PCI/MSI: Reject multi-MSI early")
Reported-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: stable@vger.kernel.org
---
 drivers/pci/msi/irqdomain.c |    7 +++++--
 drivers/pci/msi/msi.c       |    4 ++++
 2 files changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -350,8 +350,11 @@ bool pci_msi_domain_supports(struct pci_
 
 	domain = dev_get_msi_domain(&pdev->dev);
 
-	if (!domain || !irq_domain_is_hierarchy(domain))
-		return mode == ALLOW_LEGACY;
+	if (!domain || !irq_domain_is_hierarchy(domain)) {
+		if (IS_ENABLED(CONFIG_PCI_MSI_ARCH_FALLBACKS))
+			return mode == ALLOW_LEGACY;
+		return false;
+	}
 
 	if (!irq_domain_is_msi_parent(domain)) {
 		/*
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -433,6 +433,10 @@ int __pci_enable_msi_range(struct pci_de
 	if (WARN_ON_ONCE(dev->msi_enabled))
 		return -EINVAL;
 
+	/* Test for the availability of MSI support */
+	if (!pci_msi_domain_supports(dev, 0, ALLOW_LEGACY))
+		return -ENOTSUPP;
+
 	nvec = pci_msi_vec_count(dev);
 	if (nvec < 0)
 		return nvec;

