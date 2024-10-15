Return-Path: <linux-kernel+bounces-366523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC1F99F6CE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50491F24030
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D841F5821;
	Tue, 15 Oct 2024 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="17C437Oj"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C681CACE5
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019430; cv=none; b=F7dQxVZK/3HnLOKffiakvwWWH0x0H8YG/YNWoxtTqJurgk8MQ9ZMuiBPkUdZn+/H+Lq33cBuTbiDFEz7QZMR3yw4bWjLdsiJvWZh7qqQso9S4Atn1QVCbnzpkNVIkapH2HhLf0hGsbQHCOS/6MDwMpbJ+rsAg1w+rcICuDqanu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019430; c=relaxed/simple;
	bh=RGN6xJBub6siG5dh9zPouMtM5TtvJmzA74YPri9Ychw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZt4ktpxdOqMJmivNEGTqLH2UJD0JJS4VpcIeXvd0lOSXiVLlxMjtPfTJ3ttcVT/vgZNbb3qD4qDi0wNbvzepSxMgMCdvdraCsnnG/f5gp03VkWa5GemTuJYk+YhW3+t7IDMLIlFwv2lY2lkNXrwvQ0aji/6d2hb4exYLTTFBfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=17C437Oj; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XSkFb0ZrQzlgMVy;
	Tue, 15 Oct 2024 19:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1729019423; x=1731611424; bh=Euw5p
	48mmCF3tyeddZlOyjeu2JGIv4T0JCbtH3vU/TI=; b=17C437Oj0oPhsrNgMEM0Y
	lWi3mlVyuA026iN+Ri6wuw0o6pHkhe6Po4gI7qbjqUReV0VtqEiZG0UAQIUen8pm
	vd8j2CrUf37drz2O11GzBdhpKTkHOK+UHrTgAxRPz7SzHP+zz4GTOF+wMNIqU4h/
	/hAd0Boom8OQrAcDsprFHKgTkSqa4TUoXCi4GmzCixxE5fO+IgP1sIZMlQm0qiS5
	fsOzcQ5zYfH2GmdfvASbCvgAAx56ZKaqlN4YzwKeBFmqTKN2P/4ckJBLttP0ISzo
	GwkJZaweIb25b/D1kd8jDBJTFFQ5p9JzNFPCBVx6kmtR+Vf6Sbe/Y6go8EqhlBOM
	g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 2nJppFLqZ9dS; Tue, 15 Oct 2024 19:10:23 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XSkFW1WVHzlgMVs;
	Tue, 15 Oct 2024 19:10:23 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 01/22] genirq: Introduce irq_get_nr_irqs() and irq_set_nr_irqs()
Date: Tue, 15 Oct 2024 12:09:32 -0700
Message-ID: <20241015190953.1266194-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To: <20241015190953.1266194-1-bvanassche@acm.org>
References: <20241015190953.1266194-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare for changing 'nr_irqs' from an exported global variable into a
variable with file scope. This will prevent accidental changes of
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

