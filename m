Return-Path: <linux-kernel+bounces-344607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D685798ABDA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 568A2B23948
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C56D19CCEC;
	Mon, 30 Sep 2024 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="EHioEd2F"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A70019C55C
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720207; cv=none; b=qqbjRE5/7V5ckYC9HB+ovbzSXE8OdBEiNNx2DVl//ZJ9jOmn3awqdRMGkEq5GVhPJusqpiSmFGKssYoOA/Nd1osOjyGvrFNpStmGG7oYBWaDA4HK6P0mJgr5jQJm3PD3zTvUnMhtDgQb9sduvx3hPh5K/1vVQkWSl+fmOF1vH+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720207; c=relaxed/simple;
	bh=5z28fO5V28Z2opAPJnNqd14EPDLfxMvV4sbkdzlmvBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUMjKYMqRDYL867pfGLhKmFI2MwVCPNFBowS+wcPTiQ+4H6co/T22b/8N+jKtFg2cSPpMZqNfKFeKetUn0dYaDMytQDZ1kp6yr65akX9ZTigF/Pipyw/92uG6ycI+owvjlhXpGKSkuVjN31H9Ug2vY8RDRYWb7Ggu3id9yKOmAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=EHioEd2F; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XHTmM6JwrzlgMVd;
	Mon, 30 Sep 2024 18:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1727720194; x=1730312195; bh=0+Ch/
	BKiZvV++ve+EGfFUWSvrOjh1lqfEkF+rOd9w5Y=; b=EHioEd2FAqPyyZoZtLa1Z
	z92La5AOFNDmdaoByzeqbY55rFIogrO99wzbycNg4xxZW2x75/vqnUZw4cP8EJjH
	kJnRxCxD6DRuaQrF5P0O9yPC4uGctOJ1A7ZrOQZy3cOQOh//F+cE7htWgHH3Abif
	b+b7jP+6usTr48eFKNTmgadOHMIW9ryN3B87rCCBmSEWEmfRWtxDaSw4vsOP2fS6
	w2x0EITKdaIadvKP3UcMqmhzXJu2qCZFQfJ1DzLMKrXCJ1PcnxyT7QOZRYSkgOsv
	QN3ff0Il8QLhUKzIlIWK+lix4sKeN4Eu5/56dKGQOp6ZhwyIP1JBVpQpRThHaw0W
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id lpu3rqtcFwHO; Mon, 30 Sep 2024 18:16:34 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XHTmK4PKHzlgMVt;
	Mon, 30 Sep 2024 18:16:33 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 11/21] serial: core: Switch to number_of_interrupts()
Date: Mon, 30 Sep 2024 11:15:50 -0700
Message-ID: <20240930181600.1684198-12-bvanassche@acm.org>
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

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/tty/serial/serial_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
index d94d73e45fb6..fb3915065ecd 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -919,7 +919,7 @@ static int uart_set_info(struct tty_struct *tty, stru=
ct tty_port *port,
 	if (uport->ops->verify_port)
 		retval =3D uport->ops->verify_port(uport, new_info);
=20
-	if ((new_info->irq >=3D nr_irqs) || (new_info->irq < 0) ||
+	if ((new_info->irq >=3D number_of_interrupts()) || (new_info->irq < 0) =
||
 	    (new_info->baud_base < 9600))
 		retval =3D -EINVAL;
=20

