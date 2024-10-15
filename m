Return-Path: <linux-kernel+bounces-366537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F62499F6DC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3565D1F24030
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672F21FF024;
	Tue, 15 Oct 2024 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Np4eVw0V"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609941FF025
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019445; cv=none; b=jQmxHVxD/DAIVnWmPx43+Lc8l6cv24/6Mey3eGYpRRq6PHvYMaWI+K4Alah1NixQAH2Esx0XB4PlaCBlZxOth8R/VnvuH9QHJw5vQ/Q6rjnVxfxLDmFdgC88g2Z7K9whvItLrpv1t7X1G8KdOOs7Awy7zGzxwM/9hojp7dO7Kjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019445; c=relaxed/simple;
	bh=2OGBgyd5ddxaB6oSbulKRQywvfKc2bUgYfm3df92ovQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxHqnsmdXqPzpXtf+Fqh9AJxqLP5Hr/3+xzY8+qMqbYZIW34oAazkD0JgM599BCRVbv2OVdJvWGw52+QYAm36Y/1ZQdzkd+bY4WkiUii9SeLTRQxPzaM7bQv0pj0m5o7fzUde1CDtT/QWulzb/OQaYFHRf/VD0j+QTNpUAM3uco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Np4eVw0V; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XSkFr027bzlgMVs;
	Tue, 15 Oct 2024 19:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1729019438; x=1731611439; bh=h9btA
	iRfDbRreRXsMKtJ+PkFCghGuPSwuuSslr3gXeg=; b=Np4eVw0VtqaMsnBOGWeBw
	M5HxJmqEsj9SlOtgJEoJQ3T0TqXQHbmc0r4/G0wrwyiziuj2RNi/0HMnFmUGDEXe
	jftquR11mc/vgUp/w6Lb5Vt7aT6J+sAzLZs6F5XPCJA0zWpVAWCdkqMXhlOOs6tN
	bbK/iLIHbLE4f1Y7cWI0NXz+Md5JR8KVRE0YYPF71O4cl4PUMdMuI5YWnteHRBjb
	/+8GPDz+HoKE1qSQTiKKmOkDB2gRgv9Tz4EA4OWdC3LVPORTR2sbzMxlnHFCmVUR
	sIiNiHOCepEO3VNbE3oxhAVx7IMnJoNzfY6b/aCnlxwbVey3nQuU+r7wEXsHwL6r
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id HzAZcxiGZYEF; Tue, 15 Oct 2024 19:10:38 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XSkFn4FfWzlgMW2;
	Tue, 15 Oct 2024 19:10:37 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 13/22] serial: 8250: Switch to irq_get_nr_irqs()
Date: Tue, 15 Oct 2024 12:09:44 -0700
Message-ID: <20241015190953.1266194-14-bvanassche@acm.org>
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

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/tty/serial/8250/8250_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
index 3509af7dc52b..0b886c0924da 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3176,7 +3176,7 @@ static void serial8250_config_port(struct uart_port=
 *port, int flags)
 static int
 serial8250_verify_port(struct uart_port *port, struct serial_struct *ser=
)
 {
-	if (ser->irq >=3D nr_irqs || ser->irq < 0 ||
+	if (ser->irq >=3D irq_get_nr_irqs() || ser->irq < 0 ||
 	    ser->baud_base < 9600 || ser->type < PORT_UNKNOWN ||
 	    ser->type >=3D ARRAY_SIZE(uart_config) || ser->type =3D=3D PORT_CIR=
RUS ||
 	    ser->type =3D=3D PORT_STARTECH)

