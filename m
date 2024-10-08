Return-Path: <linux-kernel+bounces-355904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F43995872
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C4C1C21917
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBAD21BB1B;
	Tue,  8 Oct 2024 20:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="L6+eoClT"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B00E21B45C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419208; cv=none; b=QpLfX+s+L3vfZ7TDPvaGvlliMUZ6kXCX01z9YkMt0dFD4h2Ro++Lfj505z2P7MfOBQuQS+6xgfm2tn2vu1HOoRGk+KDOGGeShN3rHvNshHding3QNDelmK6FQSIbOCmn0gKnO0jVaDriwvz4bpTfECskyfrzYal1WBrlmV5qqmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419208; c=relaxed/simple;
	bh=c85tEugDzSd99VeIZ50PbpJLXU7eEVr4dI+KdUj3PV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPwuqhVOAMsBvpcjiiJue+zv+Gamv/VqqfEx+hU+zccPh7JTjtWvr+/NHoebq4b4O78inWAI++5FM7zEDIJh4RcrMCu3YuRDjt7ihTaJgrjWveEKCmrnRdAbKvBBrYPL4QIwyBfj7WQS+ZSccuxIeGKe/ckGvG0DHf9+Y3OEP0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=L6+eoClT; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XNSGh67pvz6ClY9P;
	Tue,  8 Oct 2024 20:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1728419193; x=1731011194; bh=fYOBw
	Meteuc9o60FUQSeXBBZgNw2hRpnVN7BBenY7x8=; b=L6+eoClTUACqavQ9DwY4W
	9xb3Xm9HcdOBNlYDKedk48cAcTWenu0ApkDWu1nUa4q4oGHd7z8H+RREvI2LA9N6
	bD1eofwemWnDE5CH7zasZLbo3lkqT8uUz980aPktAgzgTui8Xd+K+oA+EKVqUSQS
	OXmZQWh/EQlXUsaf33+VWV7pRjFd94LPwyqxB0uDtQBvib8Cfs++CA28k6ZuDbN9
	09Ji65+4HyQ6p3zHcWKzMyaroo4BlR+2gUZBrGZix4XSEapW4ljs0IaAxFcH5Ln0
	T8mMgrIQVDpR9HlPWRJzwWvcpZyaFg58vSXDB/gt5eOy0FNQ2jGuM6PJPZiRx17n
	w==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 8o3kJ2lcWnkU; Tue,  8 Oct 2024 20:26:33 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XNSGd1BBjz6ClY9k;
	Tue,  8 Oct 2024 20:26:33 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 21/22] genirq: Switch to irq_get_nr_irqs()
Date: Tue,  8 Oct 2024 13:26:00 -0700
Message-ID: <20241008202601.3737326-22-bvanassche@acm.org>
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

Use the irq_get_nr_irqs() function instead of the global variable
'nr_irqs'. Cache the result of this function in a local variable in
order not to rely on CSE (common subexpression elimination). This patch
prepares for changing 'nr_irqs' from an exported global variable into a
variable with file scope.

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

