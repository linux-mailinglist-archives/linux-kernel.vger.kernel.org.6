Return-Path: <linux-kernel+bounces-439353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6CC9EAE08
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E37D168546
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FAE78F4C;
	Tue, 10 Dec 2024 10:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zl9ev07G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cyfeiU1S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766E223DE8F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733826859; cv=none; b=onKQpZA9tESrIi3juLBTQb5c1RwyFFtueUkYzWDf09raUGprUInNfGT5qqcUED27fcPx5qDgMwWN3wEaFZwTdNZVKZCKp5DhbNM6h9mc0v2erYnCv3b1laSt25/DFzTlWScz/Pxe7QOmK+hV997lbQ6Pne34ctmslh7Uzyu2CSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733826859; c=relaxed/simple;
	bh=gego9RvxALQhoSTSNVAgb3Dyy5CvdMsla4tRwq1dw/4=;
	h=Message-ID:From:To:Cc:Subject:Date; b=cQllS69g1q1hpnp49e/5rYidC2oTNqxGxW03idTJ8SPoJSq9hAL0oh0GNRITWXj89AdTWcv68QDmyNOpTkrrRgeF4n6GX8UPtpwkHD9oxuCHZwbuyU22zTFaJjIMOFdWrntbK8TlQ6oC9m0kS9uI5mp26H3TAGQJhEH/vtVTm3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zl9ev07G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cyfeiU1S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241210102148.760383417@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733826849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=h9qgpz4lS70aKClBFDEHAAmood6tXGEvuWqydrq2ReA=;
	b=Zl9ev07GTP0j7eZG9yvSTU2q7ULG2xw4d4XaJIHN5JDyOvuDAU5xj4Pj0oUbsteuZSDYBF
	a8Q1BWiiGHGdrzSKOB1elHb6x6mfSJh08kfrmkLaNaWSvSJFSI1ITdKAZl/dKuRqiJbLdK
	VGu4Spblrk6jps2A/Eh3Yaf79JelW2eNXSw9OFx0JFILbKzbYZgJeIT8xDPqP9WI8L54Ng
	nhB5/ouNKoOFQcDIbDMwHQVd5WNB+5lA+8zDZ/0sh1ar1/iuSpFgo/R9u6CCirANHHLmE6
	xzbf9nFmkZCXFXEq19SgAH6lefBysxjZoynbj1UFUnnZoB24R/GwC3Ey/UfxWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733826849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=h9qgpz4lS70aKClBFDEHAAmood6tXGEvuWqydrq2ReA=;
	b=cyfeiU1Sl4NRBZCvhhAL/c9FC/uaiuwmvQwE9cdXL8n5sRZMFosa+kU+dIH2/TPZ68w15V
	Ju9Nn5cQn9PDusAw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Anup Patel <apatel@ventanamicro.com>,
 Vineet Gupta <vgupta@kernel.org>,
 Brian Cain <bcain@quicinc.com>,
 Wei Liu <wei.liu@kernel.org>,
 Steve Wahl <steve.wahl@hpe.com>,
 Joerg Roedel <joro@8bytes.org>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 Juergen Gross <jgross@suse.com>
Subject: [patch 0/5] genirq, x86: Rework deferred interrupt affinity logic
Date: Tue, 10 Dec 2024 11:34:09 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In a recent discussion about the potential race condition with unmaskable
MSI interrupts on RISC-V:

  https;//lore.kernel.org/all/87r06gq2di.ffs@tglx

it turned out that RISC-V needs the GENERIC_PENDING_IRQ infrastructure to
close the gap.

It turns out that the logic behind GENERIC_PENDING_IRQ is slighly
convoluted and backwards for the general case:

   1) The default is to defer, which is not what the majority of interrupt
      controllers need.

   2) Deferrement is handled as per interrupt flag. That's a pointless
      exercise as the requirement is actually per interrupt controller.

To ease the conversion of RISC-V, rework the logic to make the deferrement
based on an interrupt chip flag and convert x86 over, which then allows to
remove the current double book keeping of the non-deferrement flag.

The conversion is done in two steps with an intermediate config switch as
RISC-V needs a trivial way to backport the changes.

Thanks,

	tglx
---
 arch/arc/Kconfig                    |    1 -
 arch/arc/kernel/mcip.c              |    2 --
 arch/hexagon/Kconfig                |    1 -
 arch/x86/hyperv/irqdomain.c         |    2 +-
 arch/x86/kernel/apic/io_apic.c      |    2 +-
 arch/x86/kernel/apic/msi.c          |    3 ++-
 arch/x86/kernel/hpet.c              |    8 --------
 arch/x86/platform/uv/uv_irq.c       |    2 --
 drivers/iommu/amd/init.c            |    2 +-
 drivers/iommu/amd/iommu.c           |    1 -
 drivers/iommu/intel/irq_remapping.c |    1 -
 drivers/pci/controller/pci-hyperv.c |    1 +
 drivers/xen/events/events_base.c    |    6 ------
 include/linux/irq.h                 |   14 +++-----------
 kernel/irq/Kconfig                  |    4 ++++
 kernel/irq/chip.c                   |    4 +---
 kernel/irq/debugfs.c                |    2 +-
 kernel/irq/internals.h              |    2 +-
 kernel/irq/settings.h               |    6 ------
 19 files changed, 16 insertions(+), 48 deletions(-)

