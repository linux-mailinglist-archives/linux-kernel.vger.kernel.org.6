Return-Path: <linux-kernel+bounces-355882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFC299585B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8E351C21539
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC310215023;
	Tue,  8 Oct 2024 20:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="A+IiciE9"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DC4215000
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419186; cv=none; b=U0NfgYVA3Ycv2VqOY2HJf05HmYpHftfA5yboHGUItVTdL1EtoNFnSV2OmRAekLogLrMmWSiSiR9AgzmkVpLmtkrbPlRb9X9g9JFuS0vnXiZVVDmFZiMIyiCc3Aplq3+yOeZq/UmOh1yfu3jAfPwUdpXxioJzPfOVQn7UHG7vmxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419186; c=relaxed/simple;
	bh=Ed8gV8GKAA9ytfqVU4j8TQz2cYhGZTws2c4f7c2Cd9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fABIqiVrK5Qx7UzZvIqnV+owkTBiqNsGBmv0K/uXuYEQmB5YFTAgF41Bw0jP55vF8pf+fNtsrt2iHGLjUBgdFV4SgEN03B6Yu2waw5s2xkUsVw1dzMSNnrxb67D3QoQy1DC7ezFDxJZ5Lc5YArVCDkkvghqInf8alIWZwvmDuQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=A+IiciE9; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XNSGS1kH0z6ClY9X;
	Tue,  8 Oct 2024 20:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1728419181; x=1731011182; bh=6Hpou
	3I2vTXbdkDW0wPhZhYVi/91c/wd5OQP0eCgeOk=; b=A+IiciE93a2mO1ux7UZoa
	OZQeTy8xqLCVlQdD0DAVrSVQ85p8hDGgzuf7WRWtzb6dyAu4+568jvwJYDqPm04J
	G1GI7DItBwHllUpgC5ifnXq+AGh3rQ2P2kk16RabztWK13c2fEJQvtpGFFdu2jZ5
	IUY64LP9AHxeV+vckbQI+Zp2PBs4mQU3KqMmSuvtAwgwrOd3zvvRrs9uEK3ftt5V
	TntS9co1r8BpB8XWMu6V5eDXKm583DP5GMFDx/OBZIpPwmE+fqzB0f1b/xpditfL
	3Mt9t/9a2GDGw4zho2/hdvdAtgnto0iRSeFn4Cd73NqfEC6dqhynoGIwwGj8G2nB
	Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id LFtF10rKgvnu; Tue,  8 Oct 2024 20:26:21 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XNSGN682mz6ClY9M;
	Tue,  8 Oct 2024 20:26:20 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 01/22] genirq: Introduce irq_get_nr_irqs() and irq_set_nr_irqs()
Date: Tue,  8 Oct 2024 13:25:40 -0700
Message-ID: <20241008202601.3737326-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
In-Reply-To: <20241008202601.3737326-1-bvanassche@acm.org>
References: <20241008202601.3737326-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare for changing 'nr_irqs' from an exported global variable into a
variable with file scope. This change will prevent accidental changes of
assignments to a local variable 'nr_irqs' into assignments to the global
'nr_irqs' variable. Suppose that a patch would be submitted for review th=
at
removes a declaration of a local variable with the name 'nr_irqs' and tha=
t
that patch does not remove all assignments to that local variable. Such a
patch converts an assignment to a local variable into an assignment into =
a
global variable. If the 'nr_irqs' assignment is more than three lines awa=
y
from other changes, the assignment won't be included in the diff context
lines and hence won't be visible without inspecting the modified file. Wi=
th
this patch series applied, such accidental conversions from assignments t=
o
a local variable into an assignment to a global variable are converted in=
to
a compilation error.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/irqnr.h |  2 ++
 kernel/irq/irqdesc.c  | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/irqnr.h b/include/linux/irqnr.h
index 3496baa0b07f..7419b807b71b 100644
--- a/include/linux/irqnr.h
+++ b/include/linux/irqnr.h
@@ -6,6 +6,8 @@
=20
=20
 extern int nr_irqs;
+unsigned int irq_get_nr_irqs(void) __pure;
+unsigned int irq_set_nr_irqs(unsigned int nr);
 extern struct irq_desc *irq_to_desc(unsigned int irq);
 unsigned int irq_get_next_irq(unsigned int offset);
=20
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 1dee88ba0ae4..b0733959f8ae 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -141,6 +141,29 @@ static void desc_set_defaults(unsigned int irq, stru=
ct irq_desc *desc, int node,
 int nr_irqs =3D NR_IRQS;
 EXPORT_SYMBOL_GPL(nr_irqs);
=20
+/**
+ * irq_get_nr_irqs() - Number of interrupts supported by the system.
+ */
+unsigned int irq_get_nr_irqs(void)
+{
+	return nr_irqs;
+}
+EXPORT_SYMBOL_GPL(irq_get_nr_irqs);
+
+/**
+ * irq_set_nr_irqs() - Set the number of interrupts supported by the sys=
tem.
+ * @nr: New number of interrupts.
+ *
+ * Return: @nr.
+ */
+unsigned int irq_set_nr_irqs(unsigned int nr)
+{
+	nr_irqs =3D nr;
+
+	return nr;
+}
+EXPORT_SYMBOL_GPL(irq_set_nr_irqs);
+
 static DEFINE_MUTEX(sparse_irq_lock);
 static struct maple_tree sparse_irqs =3D MTREE_INIT_EXT(sparse_irqs,
 					MT_FLAGS_ALLOC_RANGE |

