Return-Path: <linux-kernel+bounces-344610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2BA98ABDD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FA90283505
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23DE19D8B4;
	Mon, 30 Sep 2024 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="F8Sfu0ft"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53651991B8
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720211; cv=none; b=NNmZ02VElBqjowRmdWbfHR5eKpvHHoHtVHQ0d9SGtPMFtDh/dcTCtgc6T9uEzDeyDPbR/A/ayPBDxzIYq4qOJr+17JR8ayS3PmGsL7NjQBEHvw8FIdGSjk3TSH35xi+lKJx25cygC577V+0LgLeeM0z2YBiA44Avb4aEoUJQEuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720211; c=relaxed/simple;
	bh=Dct37ToelrEux3h2L7+66DjOPdMfbwBzGrwXE4KlsYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHGHxKrdC5yv6Bu0PhjC9/heJBQPVZunXbB/fQf9k2jn9y7gM/DoN5yfG0wT54rcjiB6VWpdEV1Yy5iV6cqj+xtQmORdtFB1EPropsFgn69WKN/FvRxk4I0lIFyufA6CNeIMiPdQ7cJfHW4ex4ETVshcHuiyzP3KxZ+0jiOXJl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=F8Sfu0ft; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XHTmP4vtmzlgMW2;
	Mon, 30 Sep 2024 18:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1727720195; x=1730312196; bh=0Nlgx
	huuD1zprJH35npIR6imXcbz1rH5FfnRv/IoXM8=; b=F8Sfu0ftISzizUgpZZ8X3
	HIrFyKxhQHDbtnuKOF1mCmA7zTcPEF8vDzX8nUMCsFScvT3Rt9R0HxWUGptJk8pG
	j4EarfJ4nSNjNPtts3TdiptKIkRL8QPP+V9WLf7vbTWLSA8S/YhC+TmL9dCIisBG
	xpZbinXjzanIW103DDVQ7Ju1+j2SJIHaKvlo6v5Q7ob4+4LWchsQbwdZVTDsHFt2
	Fz1gMtQyCd3k7R7CCDAA8XG25XXLkhWEaQFzp3VGk2cyxgKevvxT1FS59n6s9EIG
	vgM7t8ijpGJh+7bfvNvb3Z4i7vPk5Sf92/QhUOO5UKo/q9/Ydb5bm5axKfn/8r2J
	A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id KiKa9vRGqDJo; Mon, 30 Sep 2024 18:16:35 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XHTmM3NpnzlgMVc;
	Mon, 30 Sep 2024 18:16:35 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 14/21] serial: amba-pl011: Switch to number_of_interrupts()
Date: Mon, 30 Sep 2024 11:15:53 -0700
Message-ID: <20240930181600.1684198-15-bvanassche@acm.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20240930181600.1684198-1-bvanassche@acm.org>
References: <20240930181600.1684198-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the number_of_interrupts() function instead of the global variable
'nr_irqs'. This patch prepares for changing 'nr_irqs' from an exported
global variable into a variable with file scope.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/tty/serial/amba-pl011.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl=
011.c
index 7d0134ecd82f..6f39323cb652 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2202,7 +2202,7 @@ static int pl011_verify_port(struct uart_port *port=
, struct serial_struct *ser)
=20
 	if (ser->type !=3D PORT_UNKNOWN && ser->type !=3D PORT_AMBA)
 		ret =3D -EINVAL;
-	if (ser->irq < 0 || ser->irq >=3D nr_irqs)
+	if (ser->irq < 0 || ser->irq >=3D number_of_interrupts())
 		ret =3D -EINVAL;
 	if (ser->baud_base < 9600)
 		ret =3D -EINVAL;

