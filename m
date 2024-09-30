Return-Path: <linux-kernel+bounces-344616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF0598ABE3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB811C22ABA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6E219F42C;
	Mon, 30 Sep 2024 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="AXrxa8dt"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD7819EED3
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720216; cv=none; b=ApgpBoDp64O/3KohM8CsrZQbmNRaaZAQ8hf0Nb1NHXRGmseTCYTruxl3mQ/R1uU3HZdcXRigeplkXFH/6F/bUdOd54xPTv3Da76x8L7dNzhbm4DideQHWQyaS5b4AD95ffpVM6UdhxpobIYS/WAUD5JOYbwtF/XRqC0shuAla58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720216; c=relaxed/simple;
	bh=FFNIGd1PTwXL41R/P9rsLH3qrxw/xZOnH4jWZnAlG+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SIgfV07HmCpN3rYDucV2i4y3MWQ+eEn3dNUDjpiCW8MnyBDfmhii3t2WR6AIvoWFbBPghKkOPH6oaKEyZu39Ksdigxf6oz65nkqeIho26bYJcAfNgfU0tcdotc0WX9HZM9/kU5TbL6L3jdzklVKoPHkXaFdtz6EYtJqoZutHyBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=AXrxa8dt; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XHTmV2lCszlgMVt;
	Mon, 30 Sep 2024 18:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1727720200; x=1730312201; bh=ZUVil
	A+1yNgLRbERUpn2nw9/1mhPQfi+T3ff+eFHMH8=; b=AXrxa8dtHPshV3brU2Gtf
	OSWLs1hH4HD2915CcW0LsotXjP6CP9cZdJtSdwhTN7dMbMURQUooFSlw1QA0ZGSZ
	NJLX83tbn9NlbYbVf5SycNYfkCkLN1JTnLlfHcjNTSHWMppxtfnPRc+uAPOMmr00
	ed0UHrttkNhUs6ReCPZ5CkmnYIuHzvoj9Gktez2bCnwvZ9djQtRDyddRR1tlX0m6
	np3wtTe5jxX/NHJdEot61fm6J7hWpQLiL3z/bZnCxe1XhJ50zhKjt7KCKtcnSVq7
	NCvY+dZh+3Xd3JH3+cbtGkAIzYL5zGVSRoqEI0cAXG835rywXEsI1wTDCt4X/E60
	A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id y86niYjyHECS; Mon, 30 Sep 2024 18:16:40 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XHTmS0Dw5zlgMVp;
	Mon, 30 Sep 2024 18:16:39 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 21/21] genirq: Unexport nr_irqs
Date: Mon, 30 Sep 2024 11:16:00 -0700
Message-ID: <20240930181600.1684198-22-bvanassche@acm.org>
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

Unexport nr_irqs and declare it static now that all code that reads or
modifies nr_irqs has been converted to number_of_interrupts() /
set_number_of_interrupts().

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/irqnr.h | 1 -
 kernel/irq/irqdesc.c  | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/irqnr.h b/include/linux/irqnr.h
index 81b76949c52e..82060d75642c 100644
--- a/include/linux/irqnr.h
+++ b/include/linux/irqnr.h
@@ -5,7 +5,6 @@
 #include <uapi/linux/irqnr.h>
=20
=20
-extern int nr_irqs;
 int number_of_interrupts(void) __pure;
 int set_number_of_interrupts(int nr);
 extern struct irq_desc *irq_to_desc(unsigned int irq);
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 8c6280843964..dea51c641f87 100644
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
 int number_of_interrupts(void)
 {

