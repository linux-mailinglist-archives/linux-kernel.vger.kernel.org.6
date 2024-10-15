Return-Path: <linux-kernel+bounces-366536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FC299F6DB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607C61F23352
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177461FF046;
	Tue, 15 Oct 2024 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="sso4f+B9"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0347A1F5856
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019445; cv=none; b=MHuKZTePdiw9Z/K3O6KJ8RSaDPwiBVid3knu454kJ2tGQwf5h/NftKMv66/mstAqQ/wV6jpY8bnUASsIOc7BQ8gDZ44/yX14KK22+plAS7ZlX1h5F0KD82S1K5qsVm8eftomP5Axrwr9uf0q4NU0fWWV01XDFhWiJXB7Lr3164w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019445; c=relaxed/simple;
	bh=Tr4xJM//9j8z/dwDTOVBf6kpLLhCrbCIcoEJRO5I6Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWdn7zfrbNJ7yzgJkVLk7vG5HPSJvvtQGVzXctVVThLPG/SdOW6FhDuNCPQKEU2KVjXsbeq1rqzsN1XWU7hGz5OMOXU5JZKRF8zUP3oPqrAJdFinYykmv+/AxhUD91fQMd5PDAGMN8HZ4fkIuS5uQeD/jnxpbTZl1351BCynKpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=sso4f+B9; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XSkFr5YCczlgMWC;
	Tue, 15 Oct 2024 19:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1729019438; x=1731611439; bh=iIm2g
	x3rCNvsrpUtyulAZ8xNRwU0lWliRsAvvXQ26vM=; b=sso4f+B9ywkgPtffxscE3
	5tp3FlmfjsfjRTD7uHYP5D15FtcRKp7Zqmi7nhmSwLvgSG3955rFWgFwKi+msnr8
	CNrMJnOLjzGIq9AnRXVurXmCwvEFtqeIO9aOE7jdseWj1MU/jf502mAmOopu5RXp
	0ST6meZpmaQ+ZLTSbOSLK1nFHtHMFupaTAViTsEE93P2oBTVCLMcOguQg9+sCsxl
	v09KSZn0kj0Jg9iwEj/mpDVnV1mYt6Mh3SkU5C7TJOVGef4PTkcT1LV/1UbukwDV
	O/i/3DkZpOhGBgqjdWNIbFFtvuEEaq+7B+/zb70YCJq96aypnRPybIMg0cXzJf/r
	Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 8ksGpHNVfkMk; Tue, 15 Oct 2024 19:10:38 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XSkFp2tPZzlgMW9;
	Tue, 15 Oct 2024 19:10:38 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 14/22] serial: amba-pl010: Switch to irq_get_nr_irqs()
Date: Tue, 15 Oct 2024 12:09:45 -0700
Message-ID: <20241015190953.1266194-15-bvanassche@acm.org>
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

