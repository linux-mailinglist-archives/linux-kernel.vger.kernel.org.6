Return-Path: <linux-kernel+bounces-295712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5431B95A066
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79A8C1C20924
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB721B3B07;
	Wed, 21 Aug 2024 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VnSdu5K2"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC191B2ED4
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251843; cv=none; b=q0zOivclND8ZcOu7YeX0I3IBRcKVxPuM+CNUy33FPHIgFDOjQD0nDEMtNx6cTvaRV/Xt4F2XiadH0gn0zudy9NlhywVxdkQm9TLg7FtiAFgWP6DWOUihuJFA8AEoW3Bp+4AwgUnm/SOi74iLv10nngkTGKXsQn5qI8Z48I/bdbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251843; c=relaxed/simple;
	bh=Z/klwxhfFQZMsRRKQiC4qGjLrlCBhnEQhg+syghZ4hg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bv+chsSG8Hx2GJB3fwHOBT2XdJJbN7yRjYrNWu+yY2U7zZ5Kw1xNTMITm0gA3712nuzVAf+jSaiNUivc9obLgdW4/fYPOgkTboCtt/fqbQ2VEbE6scDKSlo2k3RaIUXDeMJYN60va2CuDgqpxosVw56OdPfVYYXPGYVb9kj4Txk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VnSdu5K2; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0151E1C0004;
	Wed, 21 Aug 2024 14:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724251838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W8hCqk9NjgpLa2l+icWWFrRXKEtWEtdAqPxiijLHIvQ=;
	b=VnSdu5K20s4xXDpQkhWRoSJKtcumgfTlqLCfS1Fiyt2uYdmL3QuRVrQ6XYGB56FK51r2YP
	XtFKHpY7AXAOFxLr45kSre1MYwmvaKzQVJckXH4maFZWe/c6mr+hqQIJAl6hi04uC99g1F
	MyKMlqSOK+k8yoSqfthaRJTMjC6cGbL4xpnjRyUYf260eCkX3XqtAMsFYizV8eSfSfu63h
	Y1JANRDrEGOinP4PTL4Vh5MABZR4hSEIH6iVFFVGHedvscwtsKfc7yEgdkY2XkR3j3J9c0
	Ge70VsHZTRtKstyiRnBgJq5bGsHfh6N3jAtTICVFrFZaFTyouYjncVjtCSME7g==
Date: Wed, 21 Aug 2024 16:50:34 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Thomas Gleixner <tglx@linutronix.de>, Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Regression on Macchiatobin from the irqchip driver
Message-ID: <20240821165034.1af97bad@fedora-3.home>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi everyone,

I've been testing out some network series on the Macchiatobin (Armada
8k SoC) and I stumbled upon a crash at boot, that showed-up on the
latest net-next branch :

[    2.755698] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
[    2.757592] mmcblk0: mmc0:0001 8GME4R 7.28 GiB
[    2.766033] Mem abort info:
[    2.766036]   ESR = 0x0000000096000004
[    2.774534]  mmcblk0: p1
[    2.777086]   EC = 0x25: DABT (current EL), IL = 32 bits
[    2.779893] mmcblk0boot0: mmc0:0001 8GME4R 4.00 MiB
[    2.784965]   SET = 0, FnV = 0
[    2.784969]   EA = 0, S1PTW = 0
[    2.784972]   FSC = 0x04: level 0 translation fault
[    2.784976] Data abort info:
[    2.790648] mmcblk0boot1: mmc0:0001 8GME4R 4.00 MiB
[    2.792943]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    2.796867] mmcblk0rpmb: mmc0:0001 8GME4R 512 KiB, chardev (234:0)
[    2.801002]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    2.801006]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    2.830960] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000101a75000
[    2.837436] [0000000000000008] pgd=0000000000000000, p4d=0000000000000000
[    2.844265] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    2.850560] Modules linked in:
[    2.853631] CPU: 2 UID: 0 PID: 51 Comm: kworker/u18:2 Not tainted 6.10.0-12649-g25010bfdf8bb #10
[    2.862457] Hardware name: Marvell 8040 MACCHIATOBin Double-shot (DT)
[    2.868926] Workqueue: events_unbound deferred_probe_work_func
[    2.874800] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    2.881794] pc : msi_lib_irq_domain_select+0x28/0x58
[    2.886786] lr : irq_find_matching_fwspec+0xf0/0x120
[    2.891778] sp : ffff8000871f39e0
[    2.895107] x29: ffff8000871f39e0 x28: 0000000000000000 x27: ffff00013f7e11e8
[    2.902281] x26: 0000000000000004 x25: ffff00013f7e11d0 x24: ffff800086764dd0
[    2.909453] x23: ffff800081633b28 x22: ffff8000871f3a68 x21: 0000000000000001
[    2.916624] x20: ffff800086764df0 x19: ffff000101171000 x18: ffffffffffffffff
[    2.923797] x17: ffff000100de8a0c x16: ffff000100de8a00 x15: ffff000100da9cca
[    2.930969] x14: ffffffffffffffff x13: 0030354072656c6c x12: 6f72746e6f632d74
[    2.938141] x11: 7075727265746e69 x10: 0000000000036018 x9 : 0000000000000001
[    2.945314] x8 : ffff8000871f3ab8 x7 : 0000000000000000 x6 : 4d0c1e0cade3e5ec
[    2.952486] x5 : 6c65632d0c1e0c4d x4 : ffff00013f7e11e8 x3 : ffff000101171000
[    2.959659] x2 : 0000000000000004 x1 : 0000000000000000 x0 : 0000000000000000
[    2.966831] Call trace:
[    2.969288]  msi_lib_irq_domain_select+0x28/0x58
[    2.973928]  irq_find_matching_fwnode+0x4c/0x78
[    2.978484]  of_msi_get_domain+0x11c/0x138
[    2.982602]  mvebu_icu_subset_probe+0x5c/0x124
[    2.987068]  platform_probe+0x68/0xdc
[    2.990748]  really_probe+0xbc/0x2a4
[    2.994343]  __driver_probe_device+0x78/0x12c
[    2.998722]  driver_probe_device+0xdc/0x160
[    3.002926]  __device_attach_driver+0xb8/0x134
[    3.007392]  bus_for_each_drv+0x80/0xdc
[    3.011248]  __device_attach+0xa8/0x1b0
[    3.015103]  device_initial_probe+0x14/0x20
[    3.019307]  bus_probe_device+0xa8/0xac
[    3.023162]  deferred_probe_work_func+0x88/0xc0
[    3.027714]  process_one_work+0x150/0x294
[    3.031743]  worker_thread+0x2e4/0x3ec
[    3.035510]  kthread+0x118/0x11c
[    3.038756]  ret_from_fork+0x10/0x20
[    3.042353] Code: d65f03c0 b9400820 35ffffa0 f9404461 (b9400823) 
[    3.048473] ---[ end trace 0000000000000000 ]---

I bisected the bug and the crash appeared at :

fbdf14e90ce4 ("irqchip/irq-mvebu-sei: Switch to MSI parent")

I've briefly looked at it, and it seems the NULL pointer that's being
dereferenced here is the "ops" pointer in msi_lib_irq_domain_select [1]

I'm not very familiar with the irqchip subsystem, my best guess
is that this is being called for the ap_domain, in the irq-mvebu-sei
driver, which doesn't have any msi_parent_ops set [2].

By looking at the msi_lib_irq_domain_select() implementation however, I
notice that it appears to be expected that these ops can be NULL by
looking at the check in the return line :

	return ops && !!(ops->bus_select_mask & busmask);

However, the line above dereferences the ops pointer without prior
check :

	/* Handle pure domain searches */
	if (bus_token == ops->bus_select_token)
		return 1;

As I said, this area of the kernel isn't very familiar to me, but I got
my board to boot with the following patch :

--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -128,6 +128,9 @@ int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
        const struct msi_parent_ops *ops = d->msi_parent_ops;
        u32 busmask = BIT(bus_token);
 
+       if (!ops)
+               return 0;
+
        if (fwspec->fwnode != d->fwnode || fwspec->param_count != 0)
                return 0;
 
@@ -135,6 +138,6 @@ int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
        if (bus_token == ops->bus_select_token)
                return 1;
 
-       return ops && !!(ops->bus_select_mask & busmask);
+       return !!(ops->bus_select_mask & busmask);

----------------------------

I have zero confidence that this is the correct solution to the issue
so feel free to ditch that solution :) I'll gladly test any
patch for that on the MCBIN.

Let me know if you want me to run more tests.

Thanks,

Maxime

[1] : https://elixir.bootlin.com/linux/v6.11-rc4/source/drivers/irqchip/irq-msi-lib.c#L125
[2] : https://elixir.bootlin.com/linux/v6.11-rc4/source/drivers/irqchip/irq-mvebu-sei.c#L423

