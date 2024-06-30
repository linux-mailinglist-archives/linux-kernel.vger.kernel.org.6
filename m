Return-Path: <linux-kernel+bounces-235396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2851091D498
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 486CA1C20C6A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD9D15EFC5;
	Sun, 30 Jun 2024 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="eQ73jcYn"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A950E12C499
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786760; cv=none; b=P3k1+dosiSvO6HyFODyyX2SE0vW8vQGv/jOgtRa5K6xzuJ7CKYVaLyDzqB40hMzUsgMdLORFk1EKTslFRfgxZ++1Mt2oKnQoYOc9Wm7Spxam+FW0RYBhXeYS2qmPSS+vFiwSkU63XjBKyNxvDDRGkPTpweACuZXUw+MCwt1bP30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786760; c=relaxed/simple;
	bh=FbGSoRFwxRiSicykWFX2xIgG/nXa7pXgXNfRqH+jZfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQ2INvISZddbJHalezKVC/PUJGjyx19d13WRI9PQxUKNucS50eiBaUPuO+LcMb/IQZvIIYJ6bSsd++/HYyDKzXZAX/upquz9sbxwfUcxwumJwL6tQhRyH0yTlnhGkVzqYrPL3QwZOsL6RsGPcXMKqYUiyopx3Jq9hROtmQUS2Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=eQ73jcYn; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3pH3Gfhzll9f8;
	Sun, 30 Jun 2024 22:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786756; x=1722378757; bh=LliaY
	argkXdQsN8JGePFJHBGFVLgvUuT090pigrHkZc=; b=eQ73jcYn9kBNvbDmytm6Y
	LgOd2D4SLWRW4Y7rn1FI7TnI/cGjz9u0Y2LJKqZCEQwEN2UJuxZtgUkPXT3/2iaZ
	UWqC+oZHouR+oKPVDBBARaylHgGawIGaHIE5r/CmdA1TwICQCXYh3AgOK1ifuDDn
	K5RTEUpg7467ggX1Mvhiqm0FF3uvDxeqfKejc2zkE7y5RjiFbM5H1bpvTBmZvLVs
	idrEcI8RfuAMfHu+utAQkdPEAAKVogm/TAOdRpzWG317ifsx48qh2uOG2C8wgj73
	QYMQb5aGf1D1h0PamyCzeYssHAIwUvtS5EpIlZ5L9yp+IaK/iLJsL7Gu+G0mBdlc
	g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id IYK1VSJPLImN; Sun, 30 Jun 2024 22:32:36 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3pB01cVzll9fB;
	Sun, 30 Jun 2024 22:32:33 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: [PATCH 47/53] serial: max3100: Simplify a create*_workqueue() call
Date: Sun, 30 Jun 2024 15:27:05 -0700
Message-ID: <20240630222904.627462-48-bvanassche@acm.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240630222904.627462-1-bvanassche@acm.org>
References: <20240630222904.627462-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Pass a format string to create*_workqueue2() instead of formatting the
workqueue name before create*_workqueue() is called.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/tty/serial/max3100.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index fda63918d1eb..e8e7a36d73cf 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -548,7 +548,6 @@ static void max3100_shutdown(struct uart_port *port)
 static int max3100_startup(struct uart_port *port)
 {
 	struct max3100_port *s =3D to_max3100_port(port);
-	char b[12];
 	int ret;
=20
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
@@ -564,8 +563,7 @@ static int max3100_startup(struct uart_port *port)
 	s->parity =3D 0;
 	s->rts =3D 0;
=20
-	sprintf(b, "max3100-%d", s->minor);
-	s->workqueue =3D create_freezable_workqueue(b);
+	s->workqueue =3D create_freezable_workqueue2("max3100-%d", s->minor);
 	if (!s->workqueue) {
 		dev_warn(&s->spi->dev, "cannot create workqueue\n");
 		return -EBUSY;

