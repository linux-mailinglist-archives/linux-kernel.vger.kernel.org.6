Return-Path: <linux-kernel+bounces-355891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8911A995865
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8801F249B2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76361218D66;
	Tue,  8 Oct 2024 20:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="dYTsrZuO"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB5621858C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419195; cv=none; b=qzBRu59cXeVv4TFCwfrG9/GNlT0c2nf47HzcV3VdiGGc7SOat5jZ23Ssc25hQgUBYq9csAXUrn1UHYLMNJH5vNy0wQgP2IobNRJ/Ay/0b7ZdBwr2IMgpIFdSKMEvoTEThP7d4NcN8R73gfwJ6xhrlyrL/kuVWlAPvXH7rkxITys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419195; c=relaxed/simple;
	bh=moKAU0SZ6I/5dYVRk5QjSDZbMnqbi4apKwSv+1U97QY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eaVzEGkvUPLRh0x58kY5fGLv06ENEvfZmtN3rwSGikeyB32UYb2jhT8WJ3HUju77q0qubInPEJBEyIqHYO2qWXgoBBmWIjDHFnWcqVl6eNpMQeibruP7wtfMc3TQPj7hFxWKIzNAq+98xEStkYpq2FZo7EHgqHcA7x7tlN4vyTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=dYTsrZuO; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XNSGZ1HpDz6ClY9m;
	Tue,  8 Oct 2024 20:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1728419187; x=1731011188; bh=LUQpW
	HP9gysuNTAWl+iwBIz82gJ2ZTSCiMvlcyN+QiU=; b=dYTsrZuOL4rFWwi0/LMdk
	ppSAQeRm2LBT1tuvwAqYKXrrogjIXlDLgdXJrBbCNk3oDbEY/Mby9cT5I2HCo35P
	7eIqxG7YrKYMEIix6JqJQKZTAUknUjyoBouihFJSCHf2yM2vir8xihxTwFlVIKep
	/gE3e/wN3Y7orDJz/dFDCGAqbWGf5geENwql0OCx+YIdnBwS3xPK4Qh0z9KIt38m
	WZJ0E4rxEEPXGp4OBqPhbpP28OreAuFohHDNdISWevY5gLXOyLL8CZdrI4h0vI98
	iZq7pJHvbKySzbWgiLASLssdbULjj6g+/6cwFQfcUxIxAJZ5zjZOB4mykkgYb+gP
	A==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id jNZ9XKFb3fI3; Tue,  8 Oct 2024 20:26:27 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XNSGV4HrPz6ClY9R;
	Tue,  8 Oct 2024 20:26:26 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Joerg Reuter <jreuter@yaina.de>
Subject: [PATCH v2 10/22] net: hamradio: scc: Switch to irq_get_nr_irqs()
Date: Tue,  8 Oct 2024 13:25:49 -0700
Message-ID: <20241008202601.3737326-11-bvanassche@acm.org>
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
'nr_irqs'. This patch prepares for changing 'nr_irqs' from an exported
global variable into a variable with file scope.

Cc: Joerg Reuter <jreuter@yaina.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/net/hamradio/scc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hamradio/scc.c b/drivers/net/hamradio/scc.c
index a9184a78650b..c71e52249289 100644
--- a/drivers/net/hamradio/scc.c
+++ b/drivers/net/hamradio/scc.c
@@ -1460,6 +1460,7 @@ scc_start_calibrate(struct scc_channel *scc, int du=
ration, unsigned char pattern
=20
 static void z8530_init(void)
 {
+	const unsigned int nr_irqs =3D irq_get_nr_irqs();
 	struct scc_channel *scc;
 	int chip, k;
 	unsigned long flags;
@@ -1735,7 +1736,7 @@ static int scc_net_siocdevprivate(struct net_device=
 *dev,
=20
 			if (hwcfg.irq =3D=3D 2) hwcfg.irq =3D 9;
=20
-			if (hwcfg.irq < 0 || hwcfg.irq >=3D nr_irqs)
+			if (hwcfg.irq < 0 || hwcfg.irq >=3D irq_get_nr_irqs())
 				return -EINVAL;
 			=09
 			if (!Ivec[hwcfg.irq].used && hwcfg.irq)
@@ -2117,6 +2118,7 @@ static int __init scc_init_driver (void)
=20
 static void __exit scc_cleanup_driver(void)
 {
+	const unsigned int nr_irqs =3D irq_get_nr_irqs();
 	io_port ctrl;
 	int k;
 	struct scc_channel *scc;

