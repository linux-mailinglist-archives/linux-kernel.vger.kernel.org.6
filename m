Return-Path: <linux-kernel+bounces-355895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B56DD995869
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D5B128378C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C32E2194B0;
	Tue,  8 Oct 2024 20:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ZGf9sNqR"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCED218D8E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419199; cv=none; b=LbzmTq1Uw4UcYnZp3cqMXN3imbCsKBsBa3oIDMngbhX7pGIUstzTLUHgk8C6xos8S6XgE4smY+6hlfHM4ZN5lUj+5J9zgZL5SW1/Yu/0Ame5gXL9RlGQ4ZXLUloDALdCIpzj3kzmIJNWa44gZ+nET1FuVTqtVZzX+3hGyMSHaKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419199; c=relaxed/simple;
	bh=DrqtvCE2lnd5KR5p3FcXCwKB3jBN/mKnGgfPrdONWEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdLudR1GH+6apKfQTA+zpenmXwfMPsydZ/ohBDN1F3iGKlUJlnr2aOzRzrcsSM461wzOOzsOs9+gQhvXC7YFHVd6XHkVJQrJvVkI/RVnzKbWqM2ay53UAIch3Oyg4aihcDYQijwiQCTZTy3ZhYDepc0x9N/6L0bw8aDwlchoAJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ZGf9sNqR; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XNSGZ75HSz6ClY9T;
	Tue,  8 Oct 2024 20:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1728419188; x=1731011189; bh=pWpjN
	7U18uDbYTFuGlMzhKb18KDKDMcWIDteI1u8OXk=; b=ZGf9sNqROL6LfeLAkdt9n
	h7R5OOnuZ5QMZIomrWeGJhjWiTK1LDy0L55IgDnU1f/wBlOxKXcInj0Bs+RXVtN5
	qNYIJE/WzmayZZ6br6IT3WQ4cqrhH/6kFG8jPxp0sqVS8XqaSCEwDiOJ8T+vfQwh
	yBgW2XlgvIgm0VgSGg862gsBvXP/0cr7Vb2AR0F2i/zKDJ03SgWs6tj0WGCQniay
	Y3lTcN03mgiWUxLE/8Zg/VuQx1c9wsWn/EA95U0adqeLF5iRMFftDsQaQ1L7YPdo
	CU3hojrlgKaUMPcx3lNveoiPn2pfjNKQdttXpVdYG5rU+Gi0O8x+MS989JI2cwma
	Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id nQBttlXBftmo; Tue,  8 Oct 2024 20:26:28 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XNSGX2q85z6ClY9g;
	Tue,  8 Oct 2024 20:26:28 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 13/22] serial: 8250: Switch to irq_get_nr_irqs()
Date: Tue,  8 Oct 2024 13:25:52 -0700
Message-ID: <20241008202601.3737326-14-bvanassche@acm.org>
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

