Return-Path: <linux-kernel+bounces-366538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6D099F6DF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDA39282FA9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2002003BA;
	Tue, 15 Oct 2024 19:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Zu8gjTr3"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543211FF04D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019447; cv=none; b=oSyzr2p031FeQ5h+8gRspsvy2XrLg/WIYGBZSD2eD2ByMwYvNUfRVG9xfphYEeRU0xYkl7qzdamnuSnFb8bky/JkMOEEmbVu9DoE6/0Oxnbbx2X8S4m0vGIECKYjYt2Ak9xDJ+DE9a13TTbGg/ra1DKemKt9aCNCyeYlsdzcGKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019447; c=relaxed/simple;
	bh=rwSTrxMeDR58NLoluBPOaLrltx8AiPSHezxn/EIQS3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pYxZIzr5hd97apOuxDJFWPCQowDtZKhYCqvmyKLhR4SsMPxSpqRqswXWGYR2q2mldb3a40u+2kdkksZyfX4x3AqpAoQPg05UoDJ8fa3+X4wT9QYGyQ/Ouh3ZcHyxXBikkBBjbRUEu4MNcEG9ZqLkMxo+p4XVL7alx+s76/48vic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Zu8gjTr3; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XSkFt5dhZzlgMW0;
	Tue, 15 Oct 2024 19:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1729019440; x=1731611441; bh=6Gadi
	ssd1xRreJMHFyFxcuAmyYPn7MUE3CNrw0CZYtM=; b=Zu8gjTr34Jc7U5V8vq2aN
	hRtrSgmk4Rn3SS3/tQOs7lUApWa4c5A+3OciqyKv6tNStQMpgP1qDIE9ke8oHgTj
	NDBfH2totli89FLR59LShRWzK6yZ/vy8tfyvSEEPpK07Ql/NSPdBjNuJ5xpqBD46
	e8/I2bAKeu7HNB3c6+P9pnMDNlP+k+8dO54HxZdB57An/Z1ZcrzczrCHMLQM1WVp
	gmfDIQVxaN5QS9IRLyD9oiKKyRe//Z6DrqwAMRlEGvQ4OB3uYKoF6yg0lpZ8jvjD
	0ZYNg5K9KtqXfAj7SkBLmMstXZLgK++aA3C+Rr9oea0rnWWYlCl88Az8pFfeVJKb
	A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id YrsHb6FFs8Xd; Tue, 15 Oct 2024 19:10:40 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XSkFr1bP1zlgMW2;
	Tue, 15 Oct 2024 19:10:40 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 16/22] serial: cpm_uart: Switch to irq_get_nr_irqs()
Date: Tue, 15 Oct 2024 12:09:47 -0700
Message-ID: <20241015190953.1266194-17-bvanassche@acm.org>
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
 drivers/tty/serial/cpm_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/cpm_uart.c b/drivers/tty/serial/cpm_uart.=
c
index a927478f581d..6eb8625de435 100644
--- a/drivers/tty/serial/cpm_uart.c
+++ b/drivers/tty/serial/cpm_uart.c
@@ -631,7 +631,7 @@ static int cpm_uart_verify_port(struct uart_port *por=
t,
=20
 	if (ser->type !=3D PORT_UNKNOWN && ser->type !=3D PORT_CPM)
 		ret =3D -EINVAL;
-	if (ser->irq < 0 || ser->irq >=3D nr_irqs)
+	if (ser->irq < 0 || ser->irq >=3D irq_get_nr_irqs())
 		ret =3D -EINVAL;
 	if (ser->baud_base < 9600)
 		ret =3D -EINVAL;

