Return-Path: <linux-kernel+bounces-355897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 170DD99586B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B78F21C217A5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD86B219CA1;
	Tue,  8 Oct 2024 20:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="OURmHUPN"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0372194A5
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419201; cv=none; b=u7VdqL7b/FtShmYkySSdVrQg1yxjR7RJ3FxlkhsgVZI4l9pXCGc+1u+rzK//aNPHFzxyH64ptZR90yHU9G03xPwm3zNF3Lr+W5pfjn7ngu2zMASHKW6+HTLpgdODWreURW59y4a+ugTEyMnV/+I++Eme8H++FggxyPOq99rx6Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419201; c=relaxed/simple;
	bh=CKhChBHrmIOJ6VVJGQlaw2//NXLCiKsUtwH1VvzB/RM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6+uRTdagAzSQCoOIsIey1xY4t/nUBd33f/ROnmp4wo6LdJAPHY3wwg6mVr2j27mtQF+kQzAij8GSwAtiy3snmIBPb0Uj5AZnnZqJEg9trBIrAGRx1wg3HY8ojJTQTmMQStb8eZR9G8XaF388cWCmZ93V3+uW4LUE/9LRCnnIJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=OURmHUPN; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XNSGb6hrNz6ClY9q;
	Tue,  8 Oct 2024 20:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1728419189; x=1731011190; bh=p6cMM
	168PmmiAlpKiMMt9WygxY142DKnEcNQe7MMpb4=; b=OURmHUPNO3dOjP2WTf0Dy
	roEjeLkuD+BSw4LGWYD6cYesoURu4tYoglIqz/ppffp49Poqf84RmsjuzwxhVSMV
	zduapfTr7ubt8PcZZLny928Y0MthwDjpwf0zbRyMITB4SzqG7VuHrPlkwPfB8ZfM
	kRBwQHPtsv0ZQyicGWLgbf3v9GTv9qCtaEya3Rhp+ov4rGMIgYyGC1xew1DMSmea
	1RuiDEiFBYTTiwI1zvZIzUPXAxcrNrGmgxJ52PsVK+TIGRrmup/cS6sshog+MI71
	bLX/8m5PNMkNL6zrCQ4FxRV+QK6C56FbcV64V+bowy8ud2RN+b08wK2mtKdl3OVD
	g==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id YfQYrHMS9Esw; Tue,  8 Oct 2024 20:26:29 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XNSGY34JLz6ClY9Y;
	Tue,  8 Oct 2024 20:26:29 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 15/22] serial: amba-pl011: Switch to irq_get_nr_irqs()
Date: Tue,  8 Oct 2024 13:25:54 -0700
Message-ID: <20241008202601.3737326-16-bvanassche@acm.org>
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

