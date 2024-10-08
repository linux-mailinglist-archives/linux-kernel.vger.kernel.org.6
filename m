Return-Path: <linux-kernel+bounces-355889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FA8995863
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50DDBB242E7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C2221858B;
	Tue,  8 Oct 2024 20:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="EZMudz6v"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F20216435
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419193; cv=none; b=A9hWJl1YBbn0c6qdsrCWLCbBHoZaEQ13S53Gx48YJ0sauJgp1cx5/X3M3SppcbjriFf/JrjwPRUhqZ/uLTfC0RPBeqgb/Li/CTxTfTrTUPJLxJdZzrx6Jkho1U/MXjMceBg0G4vLYNu9NSGldcC70QtLMrEkiru5WrY18vnXttY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419193; c=relaxed/simple;
	bh=lnKKOwLK5Gi1cepcIygvi0h2DSr/l2rRZz7I41rmwSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgoloAatM/wagvpVLa0reGr/nftLb0vO4qU6FJDFcADKpV7Oqqrc8gPeClNyG2cWehIxEe5Q/8icASjWG2nZz6pEdhZ+YuI0VZtI437uUrMLGrK/6Y+xoPedh/0wM0j8GZobcejmnwKFfUYxdEhXoumrCuIs+rQotKTfXb/bFZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=EZMudz6v; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XNSGX6bdqz6ClY9j;
	Tue,  8 Oct 2024 20:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1728419186; x=1731011187; bh=xoMeL
	cCXQ0f+ms3Bse8o8XtuDIj4bYAX5BXD8HdafpM=; b=EZMudz6v3YGX857oBXYQ3
	qd6YSGpeEpMd3yzwG6M8EuYihsmqTUnBRKLNAnw6re85uJe39YBHFAdFuXCiCWtc
	SpKNV2x6a4NTnl10A/+IXuzKDfTspABFE8huw9v24eCPcoMflRloEfrPaAkZtvK1
	0Nuz2Omy5Qma1YbLm+ZTthSzcbnk8xTqLagBIn026JFkIbgsozditGmEfNarqq5x
	RgTZ+PXbupEve8BOI57+Qs7/cD0SeJKYIhICgehEueC0WtAMNHHgL7ycbDQ4+aCo
	Tm7CELs5SVsWeHpSsrtqNz84avcM3M8edT3fxalviuO5DCrv2MQ299V77RGQAql2
	A==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 4MyCu1naAdOg; Tue,  8 Oct 2024 20:26:26 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XNSGT6mD8z6ClY9b;
	Tue,  8 Oct 2024 20:26:25 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Thomas Sailer <t.sailer@alumni.ethz.ch>
Subject: [PATCH v2 09/22] net: hamradio: baycom_ser_fdx: Switch to irq_get_nr_irqs()
Date: Tue,  8 Oct 2024 13:25:48 -0700
Message-ID: <20241008202601.3737326-10-bvanassche@acm.org>
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

