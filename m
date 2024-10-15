Return-Path: <linux-kernel+bounces-366539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2795099F6E0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02782838B6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23DC2003C6;
	Tue, 15 Oct 2024 19:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="dVCZYGdc"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E501FF051
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019448; cv=none; b=PTnaxr0A4K5Y9VRtaya6bs1I1A3JhpKTdxSWTXK2XANdjXXxcvgWTcnIyyePZUePuU/0CDzBG/yDnXibRlNmx1BeJJbpJprdYQOsZdDJQLaFPgXRCJxqJn8rDLIbw34z8BRIGH0cN38eMKs6flwBwShjsGuCJKJ1Y8Aqgg+c1yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019448; c=relaxed/simple;
	bh=pT280GpY5z821adqTjhmYJtpOlpEdhOD3ynw3U2ED1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5EyIMVFBj4wDRxvPHxRXSLSy6HvF5uXdFLmZTHHXtdI1mehTsaHukTVVIZoLcN28ETsGxsE/0664FE435//WoPkTH3o3R2Hvf5PZ6ijCY7tl3sefuTHxOpq6gDEk8/IXLxZHFjdZ72D7e/cH8NVnwRkqo/PViUx2Z4nkElBkV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=dVCZYGdc; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XSkFs5Ps5zlgMWD;
	Tue, 15 Oct 2024 19:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1729019440; x=1731611441; bh=Gd1SR
	C1KqUqbgF9nzPrVTNhfzYfVVvm7H7GFssZv5aU=; b=dVCZYGdcRQHXRcvZ4Vbsg
	Bl+VFwz5Ay9eFWVQIJA4DZSjXiQ65gn07oiZzcorX8KYrsWnuFTVNxF4u0nCQ+Sm
	aeTQO99mGwCrcZoxdiKTT/4npqQJzvNVWXd3x78ecU7XCJ3WiBgiiaUmE1m6Onzq
	EaVtl0ubJxLNU1uxplxWWHiLLSjnk6+lZNucwM6NiJUjDCqh6jmvVAVl5VKHXUXW
	nCPtKG2RFA04lMtqvg5ghDe1Du+yG0yEt92VqdIV34yGAEPHSwRF168xRjoRdadM
	Kxz+5GfG2RejCXL9ore8A/jDgg94OhZsN6ngJqSAui6TUr3tQ8L85TwvQB0wQBp9
	A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id PErwcsaYakgI; Tue, 15 Oct 2024 19:10:40 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XSkFq15yMzlgMW0;
	Tue, 15 Oct 2024 19:10:38 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 15/22] serial: amba-pl011: Switch to irq_get_nr_irqs()
Date: Tue, 15 Oct 2024 12:09:46 -0700
Message-ID: <20241015190953.1266194-16-bvanassche@acm.org>
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
'nr_irqs'. Prepare for changing 'nr_irqs' from an exported global
variable into a variable with file scope.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/tty/serial/amba-pl011.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl=
011.c
index 7d0134ecd82f..1c60850030b1 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2202,7 +2202,7 @@ static int pl011_verify_port(struct uart_port *port=
, struct serial_struct *ser)
=20
 	if (ser->type !=3D PORT_UNKNOWN && ser->type !=3D PORT_AMBA)
 		ret =3D -EINVAL;
-	if (ser->irq < 0 || ser->irq >=3D nr_irqs)
+	if (ser->irq < 0 || ser->irq >=3D irq_get_nr_irqs())
 		ret =3D -EINVAL;
 	if (ser->baud_base < 9600)
 		ret =3D -EINVAL;

