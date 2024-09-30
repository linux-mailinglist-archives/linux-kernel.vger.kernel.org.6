Return-Path: <linux-kernel+bounces-344606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5647F98ABD9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109C5283511
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFBD19CC36;
	Mon, 30 Sep 2024 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="FzVJ8H79"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF39919B5A9
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720207; cv=none; b=XBvrkeISUuWlxUqGJxV9m2FnRzz1allPdakdPPJ1/ShofAcg4HfUCXH1AmhlQOxvrSH6rVVuhGQ6JjqlnmvS2OAjmopRHEaoGS5z2oRdm+PSra0ogrZvLWzDDVjYKhzZMMhioxct3oA9wdGC98/3zqHNY2ZxyKJTouB22aiCcLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720207; c=relaxed/simple;
	bh=pWaMWkuSllB+CQda9mOKht1N1SvdDwIPgLrD/64Xiyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pya+xPqayqK71Z6bU4ZtpyHw3InBQna+V4sWLc7vgrfcJyO/RnVxw/Hm+qXSMVk7QdASD82wPOkhWp/kCia1pxm2wD86NyPwIyyTx2tXSd8WITXjkm9yM8hEMN+orUWfwsLd7A8y9lO5B6tR6BR2kqFppEnSRp2WLdklHOsKG0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=FzVJ8H79; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XHTmM4Nc9zlgMVj;
	Mon, 30 Sep 2024 18:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1727720192; x=1730312193; bh=DrwA1
	+tnKRpQ5wovrYeDwGrGCejaXWfUOom3syoPYdk=; b=FzVJ8H79Nrtz+S9Scf6rS
	7BFjqvdiEGwX/WUni+SLUYabHsMV7CksUkvclXfRJgpn1QOdRkpWIPPA9geUnhSb
	yqBBP50FaLU7UyaOUbt1a4AMlQcb2aycnIuULsQPRNOou314Z0QeZf6IxYc7EOaF
	/BakOi9YeCTi4P/AXSj5Oc6/AgCe0Yp8wUbTeTuQ9fhbOvs+rU/rOdMTVNb5leV1
	zdU+/tBTFWkQTC7lTIGVJdHqMelUzFYooA/fDQArLEQ89ldk/zpSpw8fmesfXDP0
	Cin+Jb7jTHq2rT0mBKk7nIZBD2mGLZtS2cKichmnOud26Yjufx/uyJYdjFj1xNkZ
	Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id fABHgC3Es83k; Mon, 30 Sep 2024 18:16:32 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XHTmJ201tzlgMVd;
	Mon, 30 Sep 2024 18:16:32 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Thomas Sailer <t.sailer@alumni.ethz.ch>
Subject: [PATCH 09/21] net: hamradio: baycom_ser_fdx: Switch to number_of_interrupts()
Date: Mon, 30 Sep 2024 11:15:48 -0700
Message-ID: <20240930181600.1684198-10-bvanassche@acm.org>
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

Cc: Thomas Sailer <t.sailer@alumni.ethz.ch>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/net/hamradio/baycom_ser_fdx.c | 4 ++--
 drivers/net/hamradio/scc.c            | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/hamradio/baycom_ser_fdx.c b/drivers/net/hamradio=
/baycom_ser_fdx.c
index 646f605e358f..8c6ca1c001d5 100644
--- a/drivers/net/hamradio/baycom_ser_fdx.c
+++ b/drivers/net/hamradio/baycom_ser_fdx.c
@@ -379,10 +379,10 @@ static int ser12_open(struct net_device *dev)
 	if (!dev || !bc)
 		return -ENXIO;
 	if (!dev->base_addr || dev->base_addr > 0xffff-SER12_EXTENT ||
-	    dev->irq < 2 || dev->irq > nr_irqs) {
+	    dev->irq < 2 || dev->irq > number_of_interrupts()) {
 		printk(KERN_INFO "baycom_ser_fdx: invalid portnumber (max %u) "
 				"or irq (2 <=3D irq <=3D %d)\n",
-				0xffff-SER12_EXTENT, nr_irqs);
+				0xffff-SER12_EXTENT, number_of_interrupts());
 		return -ENXIO;
 	}
 	if (bc->baud < 300 || bc->baud > 4800) {
diff --git a/drivers/net/hamradio/scc.c b/drivers/net/hamradio/scc.c
index a9184a78650b..e00cd21422a3 100644
--- a/drivers/net/hamradio/scc.c
+++ b/drivers/net/hamradio/scc.c
@@ -1469,7 +1469,7 @@ static void z8530_init(void)
 	printk(KERN_INFO "Init Z8530 driver: %u channels, IRQ", Nchips*2);
 =09
 	flag=3D" ";
-	for (k =3D 0; k < nr_irqs; k++)
+	for (k =3D 0; k < number_of_interrupts(); k++)
 		if (Ivec[k].used)=20
 		{
 			printk("%s%d", flag, k);
@@ -1735,7 +1735,7 @@ static int scc_net_siocdevprivate(struct net_device=
 *dev,
=20
 			if (hwcfg.irq =3D=3D 2) hwcfg.irq =3D 9;
=20
-			if (hwcfg.irq < 0 || hwcfg.irq >=3D nr_irqs)
+			if (hwcfg.irq < 0 || hwcfg.irq >=3D number_of_interrupts())
 				return -EINVAL;
 			=09
 			if (!Ivec[hwcfg.irq].used && hwcfg.irq)
@@ -2140,7 +2140,7 @@ static void __exit scc_cleanup_driver(void)
 		}
 	=09
 	/* To unload the port must be closed so no real IRQ pending */
-	for (k =3D 0; k < nr_irqs ; k++)
+	for (k =3D 0; k < number_of_interrupts() ; k++)
 		if (Ivec[k].used) free_irq(k, NULL);
 	=09
 	local_irq_enable();

