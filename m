Return-Path: <linux-kernel+bounces-366540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D72FF99F6E1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE2F1F24038
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2DE20100B;
	Tue, 15 Oct 2024 19:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="YcnqlYnd"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF422003B8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019449; cv=none; b=XIEAj1YllMjvVTt0QFeL/SZsnNqQbPQ4ghatEf8mw9/LOGk544K9qSaklxY+MdZWr0yRzpV9PUkmhH19XlAikjin47jaZGFjIGFPymigC/BbXDpw3YknrSCnWjZsXP9umRo18NwHitdBUkG/mB6YSlAxN6Pb/fl1/B6wi8LnWz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019449; c=relaxed/simple;
	bh=XCkgaoCW/g4Kn/PEsYqEdPVS612Hp7XsBq4MZWdPkeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZsYor9Aew7pBLHbXQoVi++b4dZjWJ4t9A+yJ/lASlYCZLr/CUED9Hwd9UhUO0OiFoxjJgbyHBoBG9JdDYFZcGwL9BJktZo2KTlYqud9vMoNvActyBUWo+YCFanVIwhz+sRWJ36DNyyD2YW8SLWq9PbiQOWNe27YDXSdy9yHZDeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=YcnqlYnd; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XSkFw17pdzlgMWF;
	Tue, 15 Oct 2024 19:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1729019442; x=1731611443; bh=/CFQm
	D8dplrCU79nB1uv1N+1ezjtp4CJbD1+mGPTw/4=; b=YcnqlYndeBN0+DtQlkp2m
	vv9c9UzEFMKvI+eTj2sBTZhjT6ufItYLxD973NNxpnOAqOujLXjaSZmPeRdpazDB
	7hf2ytspYhG+3wvgHaOuO4ofba9NhCcTIGKTZjb1aMfrmDtX9VzcsgYuXQCi3zQ/
	jEdb+HyMn6i2cPyDEGCzQHj9N3GhKYbQsnj8pTasfSrQXLV3ajZcqMCiV9cHt7gh
	BybNoJp1idZQRew9br3iZgO1pgIR1SJNoLojcKowkChKnCKNTsTToZx3wJ+DodUS
	POjpPCAPIsTIxfW5SOwHn2EzuJdlheWlGamF77Lhtt1CPdf9n+lGgXPFt1110gLI
	A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id X4ps6AwKg_oN; Tue, 15 Oct 2024 19:10:42 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XSkFs0tXzzlgMW9;
	Tue, 15 Oct 2024 19:10:40 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Timur Tabi <timur@kernel.org>
Subject: [PATCH v3 17/22] serial: ucc_uart: Switch to irq_get_nr_irqs()
Date: Tue, 15 Oct 2024 12:09:48 -0700
Message-ID: <20241015190953.1266194-18-bvanassche@acm.org>
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

