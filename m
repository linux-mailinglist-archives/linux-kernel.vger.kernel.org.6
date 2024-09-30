Return-Path: <linux-kernel+bounces-344609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4354298ABDC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9FEC2836D9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C351991BE;
	Mon, 30 Sep 2024 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="kuxILmnX"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C52A19CC2B
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720209; cv=none; b=a3CjSg7L4ri9wIZkHnZ0/+ZG4IIi0lgzmbsZr3OAmRRZcf3A0kXYj0oexwfjQzl73ZOgAwMIw/xB39BL/mHjNHhoRXval9P3N/2kOc9FhMUayR5KoJimgTHNfN9FIMsamKtm54Xn2EcRZJwDt5YijLPV8OydFvnla6uLqUO66BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720209; c=relaxed/simple;
	bh=tI5bPvzAI+6GfLvdd7nI58ZuBKGLASunJCp52K+MQPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfmEdJOQvnpCEskBsktMsHKNBMsAvkvQfszU/BUu5sQYIn2uJcFIb43dPH6dDc9CqAPtrgOajlXqqfnQegPnbdoWjLCay8/de2I+ikLs2tClnp4wqKDhayEKvHHdnZFemB2pbHtUKbGWESyVDCmPYGTI3DP37O8quObj+y2X2BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=kuxILmnX; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XHTmP0YWTzlgMW1;
	Mon, 30 Sep 2024 18:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1727720195; x=1730312196; bh=geXJO
	ZcuyEVQCly4ZWEBVD/6rpKCh7arY02+Ime2144=; b=kuxILmnXU/1e9qE3JhSUB
	vqf4ctYR2LBNSy40rbtyDxk7Nb6zDr4nbvSmUzLzJzkg8BLPzThyRmPI0CY+hhXS
	gHMCp5mIM5tlflRJ3UbainnU5/YvPTBWO+LS1xsMLRFKJwgzgdvSQG8xTG85c9aw
	xUAhq7XuiheWFDWHGGwGT43+qHBdLmsgkiCT1MjgRH3CCMlLytOKZ6LzbwamYq9g
	oJAThtm8cvdo/PzDGgQCoKsX9ezD200DK2yk10xOxKMeaFcCzdVZw6qRM5KoqQ8H
	Yx1z1O2V3VL/wLgfyz3LJ3MuFEbTENMzz4U1t5yrMnPGGg//Ri4uVh9aUutZ0Wul
	A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 0xJoHZjU9MjW; Mon, 30 Sep 2024 18:16:35 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XHTmL6ZMszlgMVg;
	Mon, 30 Sep 2024 18:16:34 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 13/21] serial: amba-pl010: Switch to number_of_interrupts()
Date: Mon, 30 Sep 2024 11:15:52 -0700
Message-ID: <20240930181600.1684198-14-bvanassche@acm.org>
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

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/tty/serial/amba-pl010.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl=
010.c
index eabbf8afc9b5..cd7be4453dd5 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -499,7 +499,7 @@ static int pl010_verify_port(struct uart_port *port, =
struct serial_struct *ser)
 	int ret =3D 0;
 	if (ser->type !=3D PORT_UNKNOWN && ser->type !=3D PORT_AMBA)
 		ret =3D -EINVAL;
-	if (ser->irq < 0 || ser->irq >=3D nr_irqs)
+	if (ser->irq < 0 || ser->irq >=3D number_of_interrupts())
 		ret =3D -EINVAL;
 	if (ser->baud_base < 9600)
 		ret =3D -EINVAL;

