Return-Path: <linux-kernel+bounces-355899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE2C99586C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AEF6283D5A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B2B21A6F4;
	Tue,  8 Oct 2024 20:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="RP81AgpN"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3733219C9D
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419203; cv=none; b=JXv60XKt1M8L8RatT10ZV9Y3LbtZRTzuoKhONmd0Bh7o4ad6abNx+GdzMC6grj7Gtc4lu9TnZRMpnHQT3ITzkZkWgqRbN8T2ijBZIHJxrENzNI3GQQfH1l62y4bQgVCyEnw++m+Q10BB01MJyg/N/cWMu4tM8M9veEdX7ipZJik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419203; c=relaxed/simple;
	bh=swMZD7FI8tCMDI93QQDPusZo5dN9MRVyXNFRhg1T0BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTg7WBqqMWrPxpLt/4Y8iNa5Eo6zu0M/5D8/YNZqlxTVcWD/xHCcHS3lJb1ZPau9HHVQgWRfkXb94KftXzLuon82dljkY4i5DuM3hO7VDmqnYGMALYLrdDQKBk9yAtTD+URdMPbXK0FXoVuvAHhX8D4KyPPLSBBkE3jIMX+nenM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=RP81AgpN; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XNSGd2nZCz6ClY9y;
	Tue,  8 Oct 2024 20:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1728419191; x=1731011192; bh=MuVeu
	XQSH5og23lQCkYHFjWws9QSXge+/a1m3nADjLA=; b=RP81AgpNaFnRpk0he3HZ8
	zmrgzXK6nnocTE+kzg0OgbC5VaMpZ5hUB88kHWK9gh1jKY3Y3i0J6s1A7ZC4MvNT
	6CWNGeEDMfY9UgKFq8fUCkGMtUdqnVCYXHVVsAAnBuMEzU9i0bplUAhOa/JqWFMV
	QulpX/HlC8FpdVkEIp36fiU4A8UncTqRXtcCX5vMLSUVYNMHZv9dnWj6rwhB7hCF
	8wwTRNs/P02229OPWyq3ZBlXqDGld6sa7mmpvPJVr7OgEYnGvz09GtdUil5N1xby
	2qtj4cj9eIq79vMfuLGDvF87DfpSNCK7O+WICRRttbQs/afopTde1767y8O99vYy
	Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id yzDA3dBUBOJa; Tue,  8 Oct 2024 20:26:31 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XNSGZ3gtVz6ClY9P;
	Tue,  8 Oct 2024 20:26:30 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Timur Tabi <timur@kernel.org>
Subject: [PATCH v2 17/22] serial: ucc_uart: Switch to irq_get_nr_irqs()
Date: Tue,  8 Oct 2024 13:25:56 -0700
Message-ID: <20241008202601.3737326-18-bvanassche@acm.org>
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

Cc: Timur Tabi <timur@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/tty/serial/ucc_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.=
c
index 53bb8c5ef499..4eed909468ff 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1045,7 +1045,7 @@ static int qe_uart_verify_port(struct uart_port *po=
rt,
 	if (ser->type !=3D PORT_UNKNOWN && ser->type !=3D PORT_CPM)
 		return -EINVAL;
=20
-	if (ser->irq < 0 || ser->irq >=3D nr_irqs)
+	if (ser->irq < 0 || ser->irq >=3D irq_get_nr_irqs())
 		return -EINVAL;
=20
 	if (ser->baud_base < 9600)

