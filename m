Return-Path: <linux-kernel+bounces-366535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A2499F6DA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0500EB22777
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E2C1FE11B;
	Tue, 15 Oct 2024 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="qxziVxmK"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FBA1FE103
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019443; cv=none; b=X44UMIQNz54puEeEZzuNXK7RkA0UG9QdkfokA+J8NUZef103v1Na+HvI026ybSZvXUgD7ZCQu94etbIZ8R/+83FLMiS0r2oRLJa+0C2VTywPALSi/WyUYm/VDTaEMjdZz+RlhIWWyNmj8njjsWOjQhWrkM0+mfleSjMSNosD25w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019443; c=relaxed/simple;
	bh=SfhdFzHqVpx7LTAYXD6t5wjhqCtfwdF/aBqePt9e2c4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlYBCLjS2HXavFgitMaf/YTQ21Yzvh03p/kj6gwlsBg3V+6JJIbKRxtuLo99Ju/MJuKkRc1OZIg8RUEITRvbmmHzyiDaUCr0BzEP7+M1CnNlYOGKhWvlcLfwys6qAspnTaPmpQS6udoHTl2DS6l7jYuqvroCjlxxIb4xT91kNE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=qxziVxmK; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XSkFq1JqxzlgMWB;
	Tue, 15 Oct 2024 19:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1729019437; x=1731611438; bh=IpggZ
	X0ctIGVK1RK1Frti8Qu/cg14Ny6ZZtM3yqVRXY=; b=qxziVxmKExuC4B7GcRGr4
	uQUYqec2eplnHbXYoyuS+dN8MEf0Pew4owoCSw1VuCMtUlFvgDiVIbLFUWgrXM+9
	5WtNR1CTVO4g2IhyVnjBqd+laEtFJVPQ5Mxn1dgCs7bCSwIv7reoJyGvKszMSlyJ
	vi/IFp610jq7lcwHjjOcC7v/Fx39sI53mZ2EFWRM1R4lM13fBUtSwYNOm1rThy6w
	ZrvWTs26kz2cmddo/fOg3eSvKfQp2Pp1+Yu+TipnQrhWW9eYlxTqSWN11uQkEzlm
	bShR/u/69G0YC+MLcqsxYkMNl6LuFY5pQKPzhtZL7D8em5mH8ckAgtB0GXoQAznd
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id RFKZMll3aPIx; Tue, 15 Oct 2024 19:10:37 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XSkFm4ffLzlgMVs;
	Tue, 15 Oct 2024 19:10:36 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 12/22] serial: core: Switch to irq_get_nr_irqs()
Date: Tue, 15 Oct 2024 12:09:43 -0700
Message-ID: <20241015190953.1266194-13-bvanassche@acm.org>
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
 drivers/tty/serial/serial_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
index d94d73e45fb6..74fa02b23772 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -919,7 +919,7 @@ static int uart_set_info(struct tty_struct *tty, stru=
ct tty_port *port,
 	if (uport->ops->verify_port)
 		retval =3D uport->ops->verify_port(uport, new_info);
=20
-	if ((new_info->irq >=3D nr_irqs) || (new_info->irq < 0) ||
+	if ((new_info->irq >=3D irq_get_nr_irqs()) || (new_info->irq < 0) ||
 	    (new_info->baud_base < 9600))
 		retval =3D -EINVAL;
=20

