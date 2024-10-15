Return-Path: <linux-kernel+bounces-366532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C40299F6D7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5135E285E6D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350181FC7E5;
	Tue, 15 Oct 2024 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="xtOYXv9f"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B941FBF55
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019439; cv=none; b=lnbdS5XdxPJLdTbh7NgVsls1ZDPKCSkZhfdQlwpQ3Dx4pwHyc7FrPOm8Yj9lrUX5UUIiM/kD6vZDVTvj5iYi6LiDkq/PAhzMnUcA/Dv0G5KtlXebpBh8R01r0BvdvmbgO2/oqfJl6sRlHIrVF1P1iuqha0QPWnb5fecxRvglOOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019439; c=relaxed/simple;
	bh=Wdb264ThQ4BCaseNxKsy0gSk1vLf86xdw+b7swnHjjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzKALmxa3IeVkKlWpvWJcH5jGXi5M/OEeF5WQ7ldUU5+frH97GfDtcpYam2/UzF1OZEvbyonX1zRxGtTK309C1xcTSYwMpycb9mwkTyMuPANFEQFk2OHE6B+3y7WGgg/Zl5Oyj8+DxH54nsp2+ND+WEQY/dhT1gZiGETyPj/+GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=xtOYXv9f; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XSkFl1mKPzlgMVw;
	Tue, 15 Oct 2024 19:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1729019433; x=1731611434; bh=9cB3M
	FiVxGQerHt+xMybJ3xvfoyIxIsDuExAmyjNsrM=; b=xtOYXv9fY7R26Tug5ZaNz
	Ox5SH60HTDDZYqzaGGTdrmyBLpPl4cdlmFx2NwtkUle6k9YHoeNoESfrPe82OLMG
	+3FsiqpDOdNvfhTZJJRTPbfai35Zh3vi/AI0+d0JtJ9iGChnWtswH/D242Wj9O+Z
	CdGD9Zt1wxy5W8DglO6ZIu9FnxmAQ2NHzU0hpfhUoJi0S+syOkXTbf5yyoCie/92
	2BlaQ687p7QV6079+9nsHN5P7VtdLB6i1sO0hDvfugUAPfhiWg7yVvdJoWRJH/JV
	I/rN/qmTm2zCpySOnl0rmISYMzNGl3PRRgrD3YS9Hj7NwPqSxbGpUoO+yz/qhShU
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id DeOA-sqmLoQy; Tue, 15 Oct 2024 19:10:33 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XSkFh3FXyzlgMVs;
	Tue, 15 Oct 2024 19:10:32 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Thomas Sailer <t.sailer@alumni.ethz.ch>
Subject: [PATCH v3 09/22] net: hamradio: baycom_ser_fdx: Switch to irq_get_nr_irqs()
Date: Tue, 15 Oct 2024 12:09:40 -0700
Message-ID: <20241015190953.1266194-10-bvanassche@acm.org>
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

Cc: Thomas Sailer <t.sailer@alumni.ethz.ch>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/net/hamradio/baycom_ser_fdx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/hamradio/baycom_ser_fdx.c b/drivers/net/hamradio=
/baycom_ser_fdx.c
index 646f605e358f..799f8ece7824 100644
--- a/drivers/net/hamradio/baycom_ser_fdx.c
+++ b/drivers/net/hamradio/baycom_ser_fdx.c
@@ -373,6 +373,7 @@ static enum uart ser12_check_uart(unsigned int iobase=
)
=20
 static int ser12_open(struct net_device *dev)
 {
+	const unsigned int nr_irqs =3D irq_get_nr_irqs();
 	struct baycom_state *bc =3D netdev_priv(dev);
 	enum uart u;
=20

