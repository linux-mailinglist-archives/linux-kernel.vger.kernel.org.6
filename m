Return-Path: <linux-kernel+bounces-366525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BE099F6D0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB2B284AE0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545381F8182;
	Tue, 15 Oct 2024 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="1/98/a6q"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58AE1F5820
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019432; cv=none; b=XeKZiJaaOYKa/MYGXXIaR7+BJ/CKGBH5No6GpC9bNYYO8WvEDFo5zURw6Q33K+HUfIZ/oGfK3JL76iS9XcT6PpYaj8mgVuU/mBGOoGud8YT1O/LQqQiRQLnbKPX3Qe3KDSyy/HsV/YStGWCM+GfRMnkRBdbsNTT4frMYpTsnwBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019432; c=relaxed/simple;
	bh=13iyl3tkt/KH3WSFGCNZ75R+ZsPtVYJ21tNP3lxAntE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qHkzJGmj0Afr6J6xd62wosLvmV7ixn8aRfGrBvahWUfi60a45MfwdinwBz78akXxXvfRaZrYgQFApwSv3/dzq8MjI5dqD8cJjcsYn3qNtdk4IsEZGoCeK9NK/Op0vgE88Pmv4zBp5FFFpsG34DP95VIgCCR2innsoQhEHNXdoUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=1/98/a6q; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XSkFd5dl1zlgMVv;
	Tue, 15 Oct 2024 19:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1729019423; x=1731611424; bh=W88TTuUhnY31/9FlPTFIiu9601xGgCON0k3
	HAotyVWw=; b=1/98/a6qyaKQCBGb9+jRk0v1CKKKVbsbIEPUbUtGCvNqbCE8dsE
	gAUKpOGXsNwjXKArrjkKaqqvr7hCWk6MM/qrTb+D5nXPThU4m6fzoRSj/DTm7lHH
	JkOyZlYrKYCqWIZsRr7jB6GUv+p+Xx3zc+JSMenKQcJN2LSUXccJAnRxQI4lcuHd
	M5BdUememVM8fnP1dSHJONd/JFnVWyWjPU5nIg0yM5ZNatcp2R9yIeRvHNeAy6Qo
	ag4qHZ2h+CQ2huZ/zOh9iTpUu6Z5MN/MxAUkg6sQVkahA0JSwb5zGuHH/RXEb+Kk
	JdR/BcxyWwlWWIIz/wwZecs8wkJ27Ccnx+w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id qyXeiO_pxTSt; Tue, 15 Oct 2024 19:10:23 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XSkFV3WwfzlgMVh;
	Tue, 15 Oct 2024 19:10:21 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 00/22] Reduce the scope of 'nr_irqs'
Date: Tue, 15 Oct 2024 12:09:31 -0700
Message-ID: <20241015190953.1266194-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
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

Changes compared to v2:
 - Changed "This patch prepares" into "Prepare" in the several patch
   descriptions.
 - Changed the type of 'nr_irqs' from 'int' into 'unsigned int'.

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
 - Changed the return type of the accessor functions from 'int' into
   'unsigned int'.
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


