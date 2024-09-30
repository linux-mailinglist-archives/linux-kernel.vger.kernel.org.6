Return-Path: <linux-kernel+bounces-344596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D08A598ABC9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D2D1C2251D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74401990C6;
	Mon, 30 Sep 2024 18:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="W/3MHJ/S"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9733E1925B3
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720197; cv=none; b=hk3zhTLScXk5m2M7isDhoZnI55GcRBzLc49aTFcdef13c5H6ye2H7E5qfaZBLJjW4+Du2FCHLoZDJztzg1LjfwwQ55idVmJwpyxGo1RdWrWjC4JqRXTL89dMEKH+O7I52Q08O9JU8R8d7J2yGj7KoL0d5m5YXf0azmAMDJUI5Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720197; c=relaxed/simple;
	bh=mQfYozbRd7RQfdmZP183Tu8UEqBSN6yZUv9Qk2BrY8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ixcreNPlrtRcWE1P4HUkt/ahEk487OAlLwN84l2mP43LprBwAKzwCHKcmhEGu+f36welh7qiId3j3hy61SNajlocKuubjZG98u4TiuXl2t3Enf/4RzsSZh/nOBoXhaMVn/RHQ4FnLC2PpDfFB+7iXq69I6DQo15xkrTdZuePeN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=W/3MHJ/S; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XHTmF4XplzlgMVm;
	Mon, 30 Sep 2024 18:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1727720186; x=1730312187; bh=Sswb4AzmCd2+54ajX3hdz+ULFG2kYmvWhI3
	x++FQtXU=; b=W/3MHJ/Sp0sdsVQYcavAyNB47Pvh5Emd5AQfy5kyilJ11vBjqHw
	ABWfrA5RY80sVQ/emlOMnZ03vAqzARwmezjby8sSlCSjsIxX1fT+NrRtii4zxahH
	IOWd397oNxNUdr3qysFelXHCnx8RJurGoy5J9GJQezsfixTC94jYW8fIaZPy/rj3
	krhyipozYTuQQ/V2j/RrD7IPmbqGrITlSO8fChBtSNwHHe5jvNKjT5WH+daSrH+Z
	fmj82SgcQVIN4C4SYhFzKsDzDfxr11viRusd1xsE8BsLlcUq5g08nn3263wVxr3p
	9JtiQEV0jlZHuFAzW6A7IeiN8FKv7I+MU6w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id TkjlN3t4JHhi; Mon, 30 Sep 2024 18:16:26 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XHTmB2jbBzlgMVc;
	Mon, 30 Sep 2024 18:16:26 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 00/21] Reduce the scope of 'nr_irqs'
Date: Mon, 30 Sep 2024 11:15:39 -0700
Message-ID: <20240930181600.1684198-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
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
variable. Please consider this patch series for the next merge window.

All patches in this series except the first and the last two have been
generated by applying the following Coccinelle semantic patch on the
kernel tree:

// git grep -lw nr_irqs | grep -Ev 'kernel/irq/irqdesc.c|include/linux/ir=
qnr.h' | while read -r f; do spatch --sp-file replace-nr_irqs.spatch --in=
-place "$f"; done
@@
global idexpression nr_irqs =3D~ "^nr_irqs$";
expression E;
@@
-nr_irqs =3D E;
-return nr_irqs;
+return set_number_of_interrupts(E);

@@
global idexpression nr_irqs =3D~ "^nr_irqs$";
expression E;
@@
-nr_irqs =3D (E);
+set_number_of_interrupts(E);

@@
global idexpression nr_irqs =3D~ "^nr_irqs$";
expression E;
@@
-nr_irqs =3D E;
+set_number_of_interrupts(E);

@@
global idexpression nr_irqs =3D~ "^nr_irqs$";
@@
-nr_irqs
+number_of_interrupts()

Thanks,

Bart.

Bart Van Assche (21):
  genirq: Introduce number_of_interrupts() and
    set_number_of_interrupts()
  ARM: Switch to number_of_interrupts() / set_number_of_interrupts()
  LoongArch: Switch to set_number_of_interrupts()
  powerpc/cell: Switch to number_of_interrupts()
  s390/irq: Switch to number_of_interrupts()
  x86/acpi: Switch to number_of_interrupts() /
    set_number_of_interrupts()
  hpet: Switch to number_of_interrupts()
  net: 3com: 3c59x: Switch to number_of_interrupts()
  net: hamradio: baycom_ser_fdx: Switch to number_of_interrupts()
  scsi: aha152x: Switch to number_of_interrupts()
  serial: core: Switch to number_of_interrupts()
  serial: 8250: Switch to number_of_interrupts()
  serial: amba-pl010: Switch to number_of_interrupts()
  serial: amba-pl011: Switch to number_of_interrupts()
  serial: cpm_uart: Switch to number_of_interrupts()
  serial: ucc_uart: Switch to number_of_interrupts()
  sh: intc: Switch to number_of_interrupts()
  xen/events: Switch to number_of_interrupts()
  fs/procfs: Switch to number_of_interrupts()
  genirq: Switch to number_of_interrupts()
  genirq: Unexport nr_irqs

 arch/arm/kernel/irq.c                  |  5 ++---
 arch/loongarch/kernel/irq.c            |  4 ++--
 arch/powerpc/platforms/cell/axon_msi.c |  2 +-
 arch/s390/kernel/irq.c                 |  2 +-
 arch/x86/kernel/acpi/boot.c            |  6 ++++--
 arch/x86/kernel/apic/vector.c          |  8 ++++----
 drivers/char/hpet.c                    |  2 +-
 drivers/net/ethernet/3com/3c59x.c      |  2 +-
 drivers/net/hamradio/baycom_ser_fdx.c  |  4 ++--
 drivers/net/hamradio/scc.c             |  6 +++---
 drivers/scsi/aha152x.c                 |  2 +-
 drivers/sh/intc/virq-debugfs.c         |  2 +-
 drivers/tty/serial/8250/8250_port.c    |  2 +-
 drivers/tty/serial/amba-pl010.c        |  2 +-
 drivers/tty/serial/amba-pl011.c        |  2 +-
 drivers/tty/serial/cpm_uart.c          |  2 +-
 drivers/tty/serial/serial_core.c       |  2 +-
 drivers/tty/serial/ucc_uart.c          |  2 +-
 drivers/xen/events/events_base.c       |  2 +-
 fs/proc/interrupts.c                   |  4 ++--
 fs/proc/stat.c                         |  4 ++--
 include/linux/irqnr.h                  | 18 ++++++++++--------
 kernel/irq/irqdesc.c                   | 17 +++++++++++++++--
 kernel/irq/irqdomain.c                 |  2 +-
 kernel/irq/proc.c                      |  5 +++--
 25 files changed, 63 insertions(+), 46 deletions(-)


