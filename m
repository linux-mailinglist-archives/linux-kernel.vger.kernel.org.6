Return-Path: <linux-kernel+bounces-366545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4394C99F6E6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA3E1C238C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D4C201005;
	Tue, 15 Oct 2024 19:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="uPfjUteq"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F314B20262A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019454; cv=none; b=VhuWNIEZNfVM30lPVZimxsENavCeXp8NxmS6osk0J2djq4lz/eqd5DOLIQF7ILMYmBpVE9l1TUmwrpM2xv/IWWwMwmQ5KuoO7/k+ju3wnPJCeeFMb8aaJaP96ZR+lwb+FcFXpvCafH1baqRGwvZSMLCOZPr/PnkmhV47sVe9qgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019454; c=relaxed/simple;
	bh=ngsHDoV9KfS7WyJdzmcnvIUktyGVLD+61W9vJKdGERk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i94r1CRfZI5aBZaOFL1uCL+3u3ZWTt1DepLbuin1shXS8K7Y5ik/27YgcXoMYiSZ6gmH12LtbwIirQjGCtAR9HadnD+Mmq/ASYRpkbQCSL9gzHxgccM9bBuPO2iQeDGswNXhx9wZN5ndLWTtcKXWYRgfIiUsMQFevc2o1EWms7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=uPfjUteq; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XSkG06xg1zlgMVy;
	Tue, 15 Oct 2024 19:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1729019445; x=1731611446; bh=d1DwS
	MHLYc4VX3zs0aggkzGrfbw6HeD6IpGcohc8YHo=; b=uPfjUteqjyC2tMLnIx/vR
	LwDfgZjigMRPtd8f5W7zlGAXkcQAdabtmzwC9zO6QN8iA1+GFRkwYffFcGNm+jBn
	s9sRJb7ql1SmPTn3RISEbTjWhPQSlBDwcSVtMlf5gsc5XzaRtk/HPp0Hts6elyjT
	WlKrlsy5lmPimJWACgaKRgGV+99RCc59OGg/BfA1zRnkK1Dbk85ENnCZu875RJ1d
	yDJH+Xz9X2hhDFgXlRyEwkdLH9boo1PYKqmBCTdOMVQH6NBTrJPgmfzDJ0F+PK2z
	8A5E/1RPbBgomtaWpwiTtBgvtEGnR2zrHH8hEiXZak5Diul5U3FLPl70U6t1uPY8
	g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tPdOjNKAOP8Z; Tue, 15 Oct 2024 19:10:45 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XSkFx2v2qzlgMWH;
	Tue, 15 Oct 2024 19:10:45 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 21/22] genirq: Switch to irq_get_nr_irqs()
Date: Tue, 15 Oct 2024 12:09:52 -0700
Message-ID: <20241015190953.1266194-22-bvanassche@acm.org>
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

Use the irq_get_nr_irqs() function instead of the global variable
'nr_irqs'. Cache the result of this function in a local variable in
order not to rely on CSE (common subexpression elimination). Prepare
for changing 'nr_irqs' from an exported global variable into a variable
with file scope.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/irqnr.h  | 33 +++++++++++++++++++--------------
 kernel/irq/irqdomain.c |  2 +-
 kernel/irq/proc.c      |  3 ++-
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/include/linux/irqnr.h b/include/linux/irqnr.h
index 7419b807b71b..a33088d27c54 100644
--- a/include/linux/irqnr.h
+++ b/include/linux/irqnr.h
@@ -11,26 +11,31 @@ unsigned int irq_set_nr_irqs(unsigned int nr);
 extern struct irq_desc *irq_to_desc(unsigned int irq);
 unsigned int irq_get_next_irq(unsigned int offset);
=20
-# define for_each_irq_desc(irq, desc)					\
-	for (irq =3D 0, desc =3D irq_to_desc(irq); irq < nr_irqs;		\
-	     irq++, desc =3D irq_to_desc(irq))				\
-		if (!desc)						\
-			;						\
-		else
-
+#define for_each_irq_desc(irq, desc)                                    =
  \
+	for (unsigned int __nr_irqs__ =3D irq_get_nr_irqs(); __nr_irqs__;   \
+	     __nr_irqs__ =3D 0)                                             \
+		for (irq =3D 0, desc =3D irq_to_desc(irq); irq < __nr_irqs__; \
+		     irq++, desc =3D irq_to_desc(irq))                      \
+			if (!desc)                                        \
+				;                                         \
+			else
=20
 # define for_each_irq_desc_reverse(irq, desc)				\
-	for (irq =3D nr_irqs - 1, desc =3D irq_to_desc(irq); irq >=3D 0;	\
-	     irq--, desc =3D irq_to_desc(irq))				\
+	for (irq =3D irq_get_nr_irqs() - 1, desc =3D irq_to_desc(irq);	\
+	     irq >=3D 0; irq--, desc =3D irq_to_desc(irq))			\
 		if (!desc)						\
 			;						\
 		else
=20
-# define for_each_active_irq(irq)			\
-	for (irq =3D irq_get_next_irq(0); irq < nr_irqs;	\
-	     irq =3D irq_get_next_irq(irq + 1))
+#define for_each_active_irq(irq)                                        =
\
+	for (unsigned int __nr_irqs__ =3D irq_get_nr_irqs(); __nr_irqs__; \
+	     __nr_irqs__ =3D 0)                                           \
+		for (irq =3D irq_get_next_irq(0); irq < __nr_irqs__;      \
+		     irq =3D irq_get_next_irq(irq + 1))
=20
-#define for_each_irq_nr(irq)                   \
-       for (irq =3D 0; irq < nr_irqs; irq++)
+#define for_each_irq_nr(irq)                                            =
\
+	for (unsigned int __nr_irqs__ =3D irq_get_nr_irqs(); __nr_irqs__; \
+	     __nr_irqs__ =3D 0)                                           \
+		for (irq =3D 0; irq < __nr_irqs__; irq++)
=20
 #endif
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index e0bff21f30e0..ec6d8e72d980 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1225,7 +1225,7 @@ int irq_domain_alloc_descs(int virq, unsigned int c=
nt, irq_hw_number_t hwirq,
 		virq =3D __irq_alloc_descs(virq, virq, cnt, node, THIS_MODULE,
 					 affinity);
 	} else {
-		hint =3D hwirq % nr_irqs;
+		hint =3D hwirq % irq_get_nr_irqs();
 		if (hint =3D=3D 0)
 			hint++;
 		virq =3D __irq_alloc_descs(-1, hint, cnt, node, THIS_MODULE,
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 9081ada81c3d..d226282c5b66 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -457,11 +457,12 @@ int __weak arch_show_interrupts(struct seq_file *p,=
 int prec)
 }
=20
 #ifndef ACTUAL_NR_IRQS
-# define ACTUAL_NR_IRQS nr_irqs
+# define ACTUAL_NR_IRQS irq_get_nr_irqs()
 #endif
=20
 int show_interrupts(struct seq_file *p, void *v)
 {
+	const unsigned int nr_irqs =3D irq_get_nr_irqs();
 	static int prec;
=20
 	int i =3D *(loff_t *) v, j;

