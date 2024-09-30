Return-Path: <linux-kernel+bounces-344617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A169498ABE4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB401C2186D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60E519F46D;
	Mon, 30 Sep 2024 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="CHltemIa"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B972019F120
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720217; cv=none; b=AYFMVUyIEcwMgXJgZAVFEDlJZ2s2qX75OkpORA8rKOtfTv0sbFlCFx5rgxcCSSbzZ4jNiHhN6p3Grlqk1+/uNvA+Sj0IFraui/RM7tH4QNJpr9vf6cKjrJHLJ26KVCDXT6rFBj+j0Hb90Qat6E4UhLHYnnoH1EUNIRLWxyBCKx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720217; c=relaxed/simple;
	bh=O1eOjWCAtNLhnexFpLL5J5PPe+mlIKQu2HmQKu1CPC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KEbQpVrLEboAzMbMplR/+5G9Rc4Jo4/yceYY4IyQ89qToJFjwCnqQ3IUc3uVNhsGztJovK41ecZmEPZH5c2x3DgK82YG5YtpgK3C2kmRtc9BqdLh7RgIxphaYhILqhD86H0nV7Lmklt1/Y1sgdqrJB7jsa6y5t6+JcBgxlL6WYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=CHltemIa; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XHTmV4GqJzlgMVp;
	Mon, 30 Sep 2024 18:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1727720199; x=1730312200; bh=YrrsL
	mRHtyzEl2R+JJ0CHpOhsc95BWTuETBby/3SRIY=; b=CHltemIae9YOK0VkowaoW
	mlTnQMs+vN4UDZPMGXmzJ3VqIxpkINo8+3Cnwf8lsIHiv3+94uH+Y5kjE/qSnjOW
	mqVz5cDnnGjG/8G9MPaoBxJA2enLaiEsBfIH6GX066icsPJzT5+I6zhBEgbmGNqa
	bjWQ2D+tBfE0wiwwcN37Oahoz8/rXYh/2VpfI0fk8YeytRl8VJyGNPc/bAuV0+B8
	zNtrRg/YqA/eoqFZlmLMZVxsnRbGfJoKdXiRVBDzLkRzQoQkxxV19tGxKlFhDgml
	642iBKRNnkbw2ReKKLrZGB/JMse/i+7qOpB3BIh053fuROI/hAQWQlFzvEjXsvIr
	Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id MMla2CYGmRAR; Mon, 30 Sep 2024 18:16:39 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XHTmR3QZPzlgMW5;
	Mon, 30 Sep 2024 18:16:39 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 20/21] genirq: Switch to number_of_interrupts()
Date: Mon, 30 Sep 2024 11:15:59 -0700
Message-ID: <20240930181600.1684198-21-bvanassche@acm.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20240930181600.1684198-1-bvanassche@acm.org>
References: <20240930181600.1684198-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the number_of_interrupts() function instead of the global variable
'nr_irqs'. This patch prepares for changing 'nr_irqs' from an exported
global variable into a variable with file scope.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/irqnr.h  | 15 ++++++++-------
 kernel/irq/irqdomain.c |  2 +-
 kernel/irq/proc.c      |  5 +++--
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/linux/irqnr.h b/include/linux/irqnr.h
index a8b2cb6146e8..81b76949c52e 100644
--- a/include/linux/irqnr.h
+++ b/include/linux/irqnr.h
@@ -12,7 +12,8 @@ extern struct irq_desc *irq_to_desc(unsigned int irq);
 unsigned int irq_get_next_irq(unsigned int offset);
=20
 # define for_each_irq_desc(irq, desc)					\
-	for (irq =3D 0, desc =3D irq_to_desc(irq); irq < nr_irqs;		\
+	for (irq =3D 0, desc =3D irq_to_desc(irq);				\
+	     irq < number_of_interrupts();				\
 	     irq++, desc =3D irq_to_desc(irq))				\
 		if (!desc)						\
 			;						\
@@ -20,17 +21,17 @@ unsigned int irq_get_next_irq(unsigned int offset);
=20
=20
 # define for_each_irq_desc_reverse(irq, desc)				\
-	for (irq =3D nr_irqs - 1, desc =3D irq_to_desc(irq); irq >=3D 0;	\
-	     irq--, desc =3D irq_to_desc(irq))				\
+	for (irq =3D number_of_interrupts() - 1, desc =3D irq_to_desc(irq);	\
+	     irq >=3D 0; irq--, desc =3D irq_to_desc(irq))			\
 		if (!desc)						\
 			;						\
 		else
=20
-# define for_each_active_irq(irq)			\
-	for (irq =3D irq_get_next_irq(0); irq < nr_irqs;	\
+# define for_each_active_irq(irq)					\
+	for (irq =3D irq_get_next_irq(0); irq < number_of_interrupts();	\
 	     irq =3D irq_get_next_irq(irq + 1))
=20
-#define for_each_irq_nr(irq)                   \
-       for (irq =3D 0; irq < nr_irqs; irq++)
+#define for_each_irq_nr(irq)					\
+       for (irq =3D 0; irq < number_of_interrupts(); irq++)
=20
 #endif
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index e0bff21f30e0..298930f2525a 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1225,7 +1225,7 @@ int irq_domain_alloc_descs(int virq, unsigned int c=
nt, irq_hw_number_t hwirq,
 		virq =3D __irq_alloc_descs(virq, virq, cnt, node, THIS_MODULE,
 					 affinity);
 	} else {
-		hint =3D hwirq % nr_irqs;
+		hint =3D hwirq % number_of_interrupts();
 		if (hint =3D=3D 0)
 			hint++;
 		virq =3D __irq_alloc_descs(-1, hint, cnt, node, THIS_MODULE,
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 9081ada81c3d..c301dfd7d9d0 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -457,7 +457,7 @@ int __weak arch_show_interrupts(struct seq_file *p, i=
nt prec)
 }
=20
 #ifndef ACTUAL_NR_IRQS
-# define ACTUAL_NR_IRQS nr_irqs
+# define ACTUAL_NR_IRQS number_of_interrupts()
 #endif
=20
 int show_interrupts(struct seq_file *p, void *v)
@@ -477,7 +477,8 @@ int show_interrupts(struct seq_file *p, void *v)
=20
 	/* print header and calculate the width of the first column */
 	if (i =3D=3D 0) {
-		for (prec =3D 3, j =3D 1000; prec < 10 && j <=3D nr_irqs; ++prec)
+		for (prec =3D 3, j =3D 1000;
+		     prec < 10 && j <=3D number_of_interrupts(); ++prec)
 			j *=3D 10;
=20
 		seq_printf(p, "%*s", prec + 8, "");

