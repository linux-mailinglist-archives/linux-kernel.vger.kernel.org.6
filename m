Return-Path: <linux-kernel+bounces-523826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C858A3DBC6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D897D178F84
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B91B1FA164;
	Thu, 20 Feb 2025 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZXyZZiu6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JOlYIair"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAE11F9A8B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059689; cv=none; b=E5Q6R+8aXyp4/h/v9N8Epz0W67n3nzz+K62v8GuOOc6e/w5AQYwCZGHIUKSf1E1T1CpCjdngQBvSLhQHpXy3TIruFMAOqcqRCqh8XNtBFSmfFfHEZ4vkOHaBQ/bP6fZBcQzq12RViPRyO0ukk8iFqQRhzw4fOyOx6CWLh/aqxZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059689; c=relaxed/simple;
	bh=njYQI0JkqSG9nmZdfTM+SiQqXdo0ZB/2scswfcxNOq0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rc1uDff80A6ua0M8CSLAyA1egCDEA5lIAkVQQbJ/6mwVAMrEYGadIGGG0lkpR9ONM8ncvDMHL4qgz1D2IPNTvTTQR+SWDAzbDph0vgDNt1LSQZmKBYLPOx/f5BOI7O/s79gzshTfCT45tJHQuy5353UNxCihO+Z9RYm3UERwemo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZXyZZiu6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JOlYIair; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740059685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QD11Ne9DcKnhelWjnLTjIo907OByVtQIcZFYttKj9Mo=;
	b=ZXyZZiu6fQzbxCFJQqDVVgundVzHGnEXcdeIqL8ClGR3W4b1Ey4eB+bTwF/enWU27f8iqb
	6KyA7/MQ5+4mod88342BBvtXI+vCoBPYpCYRijL9dHXlnwtvDBBjL0UlnDDdTX10nwEXmW
	jsYAhyvt6xLy9RlDs67Ql11fUBmelfip+FdZsakH1fprNWVgYX6++nHjJaPYloPBm4VA0v
	IFuty6l3DyATYYOFxtg2zcjAW9Ds2GEw9k7nBYAhVx3ERa6N3DIbq2pGTCTvipVDRjp0gL
	4kJQa5/yTN+Sfg7lfSZUTM6HSWCZzUaCTAp5bmp5CUkg6T9zSKhyM/B5zR7lhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740059685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QD11Ne9DcKnhelWjnLTjIo907OByVtQIcZFYttKj9Mo=;
	b=JOlYIairSeSWXDphePdqMGRdnMIe0izKqy7x+haK/irgiQkE4fPAmmUH2rnIn+wrOo4/nr
	pM3+j/mvSiuJWVCA==
To: Mark Brown <broonie@kernel.org>, Anup Patel <apatel@ventanamicro.com>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, hpa@zytor.com, Marc
 Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement
 <gregory.clement@bootlin.com>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Atish Patra
 <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>, Sunil V L
 <sunilvl@ventanamicro.com>, Anup Patel <anup@brainfault.org>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v6 02/10] irqchip/irq-msi-lib: Optionally set default
 irq_eoi/irq_ack
In-Reply-To: <Z7Xto0WZ-Crxunik@finisterre.sirena.org.uk>
References: <20250217085657.789309-1-apatel@ventanamicro.com>
 <20250217085657.789309-3-apatel@ventanamicro.com>
 <Z7Xto0WZ-Crxunik@finisterre.sirena.org.uk>
Date: Thu, 20 Feb 2025 14:54:45 +0100
Message-ID: <87jz9kiuvu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 19 2025 at 14:41, Mark Brown wrote:
> On Mon, Feb 17, 2025 at 02:26:48PM +0530, Anup Patel wrote:
> I'm seeing boot regressions with qemu on arm64 in -next which bisect
> down to this patch.  We hit a NULL pointer dereference:
>
> <6>[    0.898900] virtio_blk virtio1: 1/0/0 default/read/poll queues
> <5>[    0.910197] virtio_blk virtio1: [vda] 3906250 512-byte logical blocks (2.00 GB/1.86 GiB)
> <1>[    0.924459] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> <1>[    0.924508] Mem abort info:
> <1>[    0.924521]   ESR = 0x000000008600002b
> <1>[    0.924559]   EC = 0x21: IABT (current EL), IL = 32 bits
> <1>[    0.924580]   SET = 0, FnV = 0
> <1>[    0.924597]   EA = 0, S1PTW = 0
> <1>[    0.924616]   FSC = 0x2b: level -1 translation fault
> <1>[    0.924667] [0000000000000000] user address but active_mm is swapper
> <0>[    0.924833] Internal error: Oops: 000000008600002b [#1] PREEMPT
> SMP

Uuurg. I wish I had double checked that the final submitted patch covers
_ALL_ incarnations of this. The below delta patch should address it.

Thanks,

        tglx
---
diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
index e150365fbe89..bdb04c808148 100644
--- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -203,6 +203,7 @@ static bool its_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 const struct msi_parent_ops gic_v3_its_msi_parent_ops = {
 	.supported_flags	= ITS_MSI_FLAGS_SUPPORTED,
 	.required_flags		= ITS_MSI_FLAGS_REQUIRED,
+	.chip_flags		= MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG_SET_ACK,
 	.bus_select_token	= DOMAIN_BUS_NEXUS,
 	.bus_select_mask	= MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
 	.prefix			= "ITS-",
diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index 3fe870f8ee17..3e1d8a1cda5e 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -201,6 +201,7 @@ static bool mbi_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 static const struct msi_parent_ops gic_v3_mbi_msi_parent_ops = {
 	.supported_flags	= MBI_MSI_FLAGS_SUPPORTED,
 	.required_flags		= MBI_MSI_FLAGS_REQUIRED,
+	.chip_flags		= MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG_SET_ACK,
 	.bus_select_token	= DOMAIN_BUS_NEXUS,
 	.bus_select_mask	= MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
 	.prefix			= "MBI-",
diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index bd337ecddb40..9c62108b3ad5 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -146,6 +146,7 @@ static const struct irq_domain_ops pch_msi_middle_domain_ops = {
 static struct msi_parent_ops pch_msi_parent_ops = {
 	.required_flags		= PCH_MSI_FLAGS_REQUIRED,
 	.supported_flags	= PCH_MSI_FLAGS_SUPPORTED,
+	.chip_flags		= MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG_SET_ACK,
 	.bus_select_mask	= MATCH_PCI_MSI,
 	.bus_select_token	= DOMAIN_BUS_NEXUS,
 	.prefix			= "PCH-",




