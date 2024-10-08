Return-Path: <linux-kernel+bounces-355903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06A0995871
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 672E9284FD3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688A321BB02;
	Tue,  8 Oct 2024 20:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="LuPl73Iv"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8229421B448
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419207; cv=none; b=C9PClKRZFi6Qd7iAeA0G5jSh6p1P2HGsvRT1+y8N3W9EM6L8KS50QzfyewTF4xbWi/c1P3R1sXsqxtXThYV4R/cdBO0qHXdg/qvEAKz+narkTjw0islx7JVbWptsriXceJGwpi+XsiBPvrn0uPq/EVL9/ARhhQdn7/4MDWFd2HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419207; c=relaxed/simple;
	bh=MOgE/7N4bgY9jRHLrBzKwPnkGmOSTCG3apIaru2LFFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxaO9wLciUPKUPBy2Q6kYLYHt6FGBVn/gX3k8wkrHP+/fyPt6//HNjyeEyKWzj1JjdoGteYIErMmlJ35pl40nUd/MgqqEARRnfeozCJir0aSs4Q1aSayZmuPfNYYkaYfAuRYSJQSyAjW6M4M0lCyZ2+HWBWl6L2VubjsnufN7nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=LuPl73Iv; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XNSGh2jWTz6ClY9Y;
	Tue,  8 Oct 2024 20:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1728419194; x=1731011195; bh=dCydM
	2CMzllpwzzMb7EVvSy19h7i9m9RpbLLePrDLTA=; b=LuPl73IvVrSKKT3PWebcC
	PPHaAQEQtizXJE/E5ZDQ6L2Zi4L+4ENLKTj/qNJUFORut5aYQChHKupqjGrx5ciQ
	qoZSpJP/0GH/MOa0fqoT/sNxKd9RRLXTXid7gG/uapdi8INCjJx4uPDsCCFQakV7
	aa4cj0Y9I0fhbEp7EJtnObOGZR4lAWs3EwRuoJkBPdSiXHM5qBw555ltrtv7EfON
	mx+P9lLx0cDgT/wGkPtzKJhASl8AvX7823BD0JYRXvTOeopUncrOimFCTKdYTIvN
	wUo/PyFUPSJke1bALLylo1ASyXgCZMStvjUsYtXyvq/aRErgv4OyH/Jmk2boJVsD
	w==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id PqWAGJCNjW_f; Tue,  8 Oct 2024 20:26:34 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XNSGd4sw2z6ClY9P;
	Tue,  8 Oct 2024 20:26:33 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 22/22] genirq: Unexport nr_irqs
Date: Tue,  8 Oct 2024 13:26:01 -0700
Message-ID: <20241008202601.3737326-23-bvanassche@acm.org>
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

Unexport nr_irqs and declare it static now that all code that reads or
modifies nr_irqs has been converted to number_of_interrupts() /
set_number_of_interrupts().

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/irqnr.h | 1 -
 kernel/irq/irqdesc.c  | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/irqnr.h b/include/linux/irqnr.h
index a33088d27c54..e97206c721a0 100644
--- a/include/linux/irqnr.h
+++ b/include/linux/irqnr.h
@@ -5,7 +5,6 @@
 #include <uapi/linux/irqnr.h>
=20
=20
-extern int nr_irqs;
 unsigned int irq_get_nr_irqs(void) __pure;
 unsigned int irq_set_nr_irqs(unsigned int nr);
 extern struct irq_desc *irq_to_desc(unsigned int irq);
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index b0733959f8ae..8696500309e3 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -138,8 +138,7 @@ static void desc_set_defaults(unsigned int irq, struc=
t irq_desc *desc, int node,
 	desc_smp_init(desc, node, affinity);
 }
=20
-int nr_irqs =3D NR_IRQS;
-EXPORT_SYMBOL_GPL(nr_irqs);
+static int nr_irqs =3D NR_IRQS;
=20
 /**
  * irq_get_nr_irqs() - Number of interrupts supported by the system.

