Return-Path: <linux-kernel+bounces-355883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6448499585D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938B01C21633
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A78215039;
	Tue,  8 Oct 2024 20:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="UHuW2gwm"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E1F215004
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419187; cv=none; b=Adhu0CeESxxHW8TaIXl2PfyTtxUmgeYvVvJxac2GovfG6ESMCADJV5ceYuhk3Ua0adPgELqJfWv2eZEhgvzOlB0S2xMoPapgqsTyd2Xuko2GdBNYZTn2nxig9A+f7trmCH5mRDPOtzD6edKToXclYjiqeIPow6s/l7SQuV6UsP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419187; c=relaxed/simple;
	bh=KY26xdckWACS81P/D6fYz0DZyc5yfJMGo9paPkx9kSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aNnd5XlVEHMh+An14WBvmayWhgmPGU25k1pqzCmkNEgSeQBvF5Y08t6dZJZ5+tAJVMp+TCC3ciHmqD67Gq68dgl+Szn7wXm5Ey030yU8eRIVNAqt9NoThpsQ0rACszQLRrjV1UHcjlonH6cvTnfND8fpyPzlk0S8WZArKnby4pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=UHuW2gwm; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XNSGS1yPhz6ClY9M;
	Tue,  8 Oct 2024 20:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1728419180; x=1731011181; bh=UasMGEPZfI6iBoR6Va7cr765yA/RCU2cx+1
	KLttYL8o=; b=UHuW2gwmlC52XhV2/1Xf/dr8sBtYaksSh1bQcgFY+fmj63Rc8OK
	IFGyFbdVFiTiPMyp5d0E88GTWh3i6zBpVicnIvzE+YgBhFZVaR9wirVpYOi94oPp
	mqc3mzaW+eV7veNwy/R1g3lp3csyk1qqkB70WrzM04jTMlivQP1t+op55PdesAES
	Umy+bnnCtX2LL7OK0kQ7AfldvCqnvHGPj3IFfHnkKxbN+W290mDm9kJgnbkYA0sY
	EFCshIljHGI76UynrDw68JdZ7z0bwXkO2djHYuCnZE+MC9No2IYX4Tzqxe7Zao2n
	OP5XWgVh147fyuiESnRfdzqh6lA7b4ZLBGw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6lZ7QgC_YNBP; Tue,  8 Oct 2024 20:26:20 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XNSGN2RnPz6ClY9L;
	Tue,  8 Oct 2024 20:26:20 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 00/21] Reduce the scope of 'nr_irqs'
Date: Tue,  8 Oct 2024 13:25:39 -0700
Message-ID: <20241008202601.3737326-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

In addition to the global 'nr_irqs' variable, there are plenty of local
variables with the same name. This makes reviewing kernel patches and
auditing kernel source code harder than necessary. Hence this patch serie=
s
that reduces the scope of the global 'nr_irqs' variable to file scope and
that introduces functions for retrieving and setting the value of this
variable.

Accesses of the global variable 'nr_irqs' have been identified with
Coccinelle.

Please consider this patch series for the next merge window.

Thanks,

Bart.

Changes compared to v1:
 - Renamed the accessor functions: number_of_interrupts() has been rename=
d into
   irq_get_nr_irqs() and set_number_of_interrupts() has been renamed into
   set_number_of_interrupts().
 - Made the description of patch 01 more detailed. It is now explained in
   detail why it is useful to introduce accessor functions for 'nr_irqs'.
 - Cache the irq_get_nr_irqs() return value if it is used as a loop upper=
 bound
   or inside a loop body instead of relying on CSE (common subexpression
   elimination) by the compiler.
 - Split the hamradio patch into two patches - one patch per driver.

Bart Van Assche (22):
  genirq: Introduce irq_get_nr_irqs() and irq_set_nr_irqs()
  ARM: Switch to irq_get_nr_irqs() / irq_set_nr_irqs()
  LoongArch: Switch to irq_set_nr_irqs()
  powerpc/cell: Switch to irq_get_nr_irqs()
  s390/irq: Switch to irq_get_nr_irqs()
  x86/acpi: Switch to irq_get_nr_irqs() and irq_set_nr_irqs()
  hpet: Switch to irq_get_nr_irqs()
  net: 3com: 3c59x: Switch to irq_get_nr_irqs()
  net: hamradio: baycom_ser_fdx: Switch to irq_get_nr_irqs()
  net: hamradio: scc: Switch to irq_get_nr_irqs()
  scsi: aha152x: Switch to irq_get_nr_irqs()
  serial: core: Switch to irq_get_nr_irqs()
  serial: 8250: Switch to irq_get_nr_irqs()
  serial: amba-pl010: Switch to irq_get_nr_irqs()
  serial: amba-pl011: Switch to irq_get_nr_irqs()
  serial: cpm_uart: Switch to irq_get_nr_irqs()
  serial: ucc_uart: Switch to irq_get_nr_irqs()
  sh: intc: Switch to irq_get_nr_irqs()
  xen/events: Switch to irq_get_nr_irqs()
  fs/procfs: Switch to irq_get_nr_irqs()
  genirq: Switch to irq_get_nr_irqs()
  genirq: Unexport nr_irqs

 arch/arm/kernel/irq.c                  |  5 ++--
 arch/loongarch/kernel/irq.c            |  4 +--
 arch/powerpc/platforms/cell/axon_msi.c |  2 +-
 arch/s390/kernel/irq.c                 |  2 +-
 arch/x86/kernel/acpi/boot.c            |  6 +++--
 arch/x86/kernel/apic/vector.c          |  8 +++---
 drivers/char/hpet.c                    |  1 +
 drivers/net/ethernet/3com/3c59x.c      |  2 +-
 drivers/net/hamradio/baycom_ser_fdx.c  |  1 +
 drivers/net/hamradio/scc.c             |  4 ++-
 drivers/scsi/aha152x.c                 |  2 +-
 drivers/sh/intc/virq-debugfs.c         |  1 +
 drivers/tty/serial/8250/8250_port.c    |  2 +-
 drivers/tty/serial/amba-pl010.c        |  2 +-
 drivers/tty/serial/amba-pl011.c        |  2 +-
 drivers/tty/serial/cpm_uart.c          |  2 +-
 drivers/tty/serial/serial_core.c       |  2 +-
 drivers/tty/serial/ucc_uart.c          |  2 +-
 drivers/xen/events/events_base.c       |  2 +-
 fs/proc/interrupts.c                   |  4 +--
 fs/proc/stat.c                         |  4 +--
 include/linux/irqnr.h                  | 36 +++++++++++++++-----------
 kernel/irq/irqdesc.c                   | 26 +++++++++++++++++--
 kernel/irq/irqdomain.c                 |  2 +-
 kernel/irq/proc.c                      |  3 ++-
 25 files changed, 81 insertions(+), 46 deletions(-)


