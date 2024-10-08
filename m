Return-Path: <linux-kernel+bounces-355896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7755299586A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56A01F24CB9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA23219C99;
	Tue,  8 Oct 2024 20:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="IZJmyMsv"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C783C21949A
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419201; cv=none; b=Lg3wP/g+XYKgMUiDM2ERMfkdvTdnA/3FI9UpgmfqRrRzgT6V8ryG62pbENzYEWsiwfXTrpgk6WF8qTDklsUMruvVE3/EPIgciDRvZ4kEADFG6IRbZt+L3hK8OCThc9YdKcimOrAsIsp0IDW65tidBHTBmP2U28GhWJO9xNyCe1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419201; c=relaxed/simple;
	bh=OeYDwU/0wVBci/xl84qCLTD64iJtOG4g86TdENaIHcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+X7n9k4GsKFSl6UJ/4MaJsStl7A7Rxbq4I4XX3MOwmAjVOkZBl6JbuhOo7cD727/zi9ZDoRlXFF04iY2z3uW0oQLVYT577WIju/wSAjvRldsxPj7hhkp0RBzB8FrE0fMKmjmQSCji1pyLt8fb60wShXL1Tmkv+4287YmELcxGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=IZJmyMsv; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XNSGb3H56z6ClY9p;
	Tue,  8 Oct 2024 20:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1728419189; x=1731011190; bh=9lACP
	2kF+rFvlPMnYD36bW+64oJAXBLB01JhEGP2uCI=; b=IZJmyMsviaDgEKVuczZ20
	+IUe/ZdrKo5rducQ+mRFX/2qe4tnVafR2VP2shzvC5HPlX0aKEbxn+85ul/4QkjI
	HKnxSshUdmQ6FbxzTTXfCT2u1sr7w36asc7txuP+U77RvSHUtAZZ4Rl2DXnb321w
	qmZsTp0/pRs8zueV6vzqq/AOu2unHHr7MF3bAQgzC1LSxpytMbMjnS+nsDK1Jc1a
	hhEk4hmaWzLTLnpPJomDzRTFLJ2l/BWd2aOaJmI8ezGxPSU6BDa/XE253UyZRqli
	2NRm1BNR/y9fnoFYPHaDK6A0GFPC6w8qd+ZKJZ2m4ENkirYvLN4Tsg3ekcKhEpvL
	g==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id S6_nQazdHDVs; Tue,  8 Oct 2024 20:26:29 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XNSGX6Vp0z6ClY9L;
	Tue,  8 Oct 2024 20:26:28 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 14/22] serial: amba-pl010: Switch to irq_get_nr_irqs()
Date: Tue,  8 Oct 2024 13:25:53 -0700
Message-ID: <20241008202601.3737326-15-bvanassche@acm.org>
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

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/tty/serial/amba-pl010.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl=
010.c
index eabbf8afc9b5..c3a7fad02ac9 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -499,7 +499,7 @@ static int pl010_verify_port(struct uart_port *port, =
struct serial_struct *ser)
 	int ret =3D 0;
 	if (ser->type !=3D PORT_UNKNOWN && ser->type !=3D PORT_AMBA)
 		ret =3D -EINVAL;
-	if (ser->irq < 0 || ser->irq >=3D nr_irqs)
+	if (ser->irq < 0 || ser->irq >=3D irq_get_nr_irqs())
 		ret =3D -EINVAL;
 	if (ser->baud_base < 9600)
 		ret =3D -EINVAL;

