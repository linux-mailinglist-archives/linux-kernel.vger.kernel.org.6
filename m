Return-Path: <linux-kernel+bounces-444825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 345F99F0D10
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49161883261
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EF41DFE33;
	Fri, 13 Dec 2024 13:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HEoStFZJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Esrj5Std"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F8D19AA58
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734095529; cv=none; b=bLw1NqZNc0MYAR6NxDq61lYwPkGfY2ZdoWDCHV6sdLUA2vSKQdWYwaDO9lGaQdwJT+AKmfM3rMA3yeJD5GSMXm7jNGAjuxaVaj1s/NFmdUg1i17AFh4DHaGjZXuN44D6DqjEQXz/jxNusxzH5ZQhS5Oou5tZEnEACPIyEF6ADfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734095529; c=relaxed/simple;
	bh=2ZvHVx7+NTEqzjXPXYN0yUkkdRjFrxYsb0E1/nRiOGo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WZe9xtOtLRWyiZfW/BU9Ix1dHpBCfOVI0yTfdatNB46TBzl2x6nLshfNnCUAzcsllSO3f+VL8H8BfkgmBtqUbFXx5j2Gl4UjKTFllrKanXHcKclSjtL9x9gMu3aXf+DwCNACV5jkHDkC+VQhxbD+gNcGw6hdIJq9QR7XPZmx8i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HEoStFZJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Esrj5Std; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734095525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1lE2poo2GMB98M3DjQRZUTgVcvXIDD7PPRxrzMRG9oM=;
	b=HEoStFZJ5EfQAolr9+hEMAnBOKOo2iMkTXBWt8foCfFSMDcHnFPVKA50yTBJyla3fdGosl
	HOJKQ1wi9Mku9Z3l2DzecaiWIIvkVzh2Rf3FRa1airQEh5s6XIIM4b8VqHz7tBbtvbkb4w
	QTKYsjqQz5v7Q0y62btYk6qsrYq/Wgemhc47UNqoV6eVMzXHvdjCieiL38PAcvCyroAlI7
	5aEj6yz9cLa/w2jz9eS8D/jQxV0sMjkdX52qTZrMFwVVyEkcYkdcxd8SCsC3OacvBE4AiM
	kDEX58aR11BlyQCe7by/JHzfoVjmYzarlt6e0mwTS9b/Rf/NKt4Z833QByE3NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734095525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1lE2poo2GMB98M3DjQRZUTgVcvXIDD7PPRxrzMRG9oM=;
	b=Esrj5StdaxwMDaPAcLNiXxAYNk9ctiiAfaJHXgTof+7R9B9+OYlpsjSDVrNs80W/Mjxkva
	xu8P/0iPq9mWBqAA==
To: Alexandre Ghiti <alexghiti@rivosinc.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Anup
 Patel <anup@brainfault.org>, Sunil V L <sunilvl@ventanamicro.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [RFC PATCH] riscv: Fix PCI warning by enabling
 PCI_MSI_ARCH_FALLBACKS
In-Reply-To: <20241213115704.353665-1-alexghiti@rivosinc.com>
References: <20241213115704.353665-1-alexghiti@rivosinc.com>
Date: Fri, 13 Dec 2024 14:12:04 +0100
Message-ID: <87v7vn917f.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Dec 13 2024 at 12:57, Alexandre Ghiti wrote:
> When the interrupt controller is not using the IMSIC and ACPI is enabled,
> the following warning appears:
>
> [    0.866401] WARNING: CPU: 1 PID: 1 at drivers/pci/msi/msi.h:121 pci_msi_setup_msi_irqs+0x2c/0x32
> [    0.867071] Modules linked in:
> [    0.867389] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.13.0-rc2-00001-g795582ce7e24-dirty #44
> [    0.867538] Hardware name: QEMU QEMU Virtual Machine, BIOS
> [    0.867672] epc : pci_msi_setup_msi_irqs+0x2c/0x32
> [    0.867738]  ra : __pci_enable_msix_range+0x30c/0x596

Removing a ton of badly formatted stack trace:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages

>
> So enable PCI_MSI_ARCH_FALLBACKS to get rid of this.

No. PCI_MSI_ARCH_FALLBACKS is really only meant for architectures which
implement the legacy fallbacks and not to paper over the underlying
logic bug in the pci/msi code. Of course the loongson folks ran into the
same problem two years ago and went for the sloppy fix without talking
to anyone...

Thanks for bringing it up instead of silently slapping it into the RISCV
tree !

The uncompiled patch below should fix this for real.

Thanks,

        tglx
---
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -185,7 +185,6 @@ config LOONGARCH
 	select PCI_DOMAINS_GENERIC
 	select PCI_ECAM if ACPI
 	select PCI_LOONGSON
-	select PCI_MSI_ARCH_FALLBACKS
 	select PCI_QUIRKS
 	select PERF_USE_VMALLOC
 	select RTC_LIB
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
@@ -442,6 +442,10 @@ int __pci_enable_msi_range(struct pci_de
 	if (nvec > maxvec)
 		nvec = maxvec;
 
+	/* Test for the availability of MSI support */
+	if (!pci_msi_domain_supports(dev, 0, ALLOW_LEGACY))
+		return -ENOTSUPP;
+
 	rc = pci_setup_msi_context(dev);
 	if (rc)
 		return rc;

