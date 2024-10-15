Return-Path: <linux-kernel+bounces-366542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C2899F6E3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797A91C23820
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A8F1F80CF;
	Tue, 15 Oct 2024 19:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="pFMWzpkF"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D650201005
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019451; cv=none; b=FgxR1C/ukTiZvzympds4Mn+zibcrjE4Aiw+/B+nPE1briHfak+Xj8DRiV2NK17RbBMtz9wpdtNUaxzbSj6BYgnIBPEOqAsfuIBr79afbNUUDszWYkTEDqgLOGG0x+uL+gwYq4oPwMy6sK8eqcY5ANS/bB97+v7NStnLot/Ln4Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019451; c=relaxed/simple;
	bh=5HZ7p64O0x91+cTt4ZszeGfeNnzhdgH36tTCgLAP2nU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RG4Ti5CJLpQj5pcKx09LPsmu6idbhW41bveFGjnGKAXsQ4KXnYRufofRDLDIat5mzROu3+QRbsMAL7EottJo++Z1ViPAMAy5MGTz++0ULa1mspv4mAJ6tIdeiKElVz4PMEJKrcHSSUP3KftsIfHQ3WdvM6E5rdjhG4EObIzgoc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=pFMWzpkF; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XSkFy74z6zlgMW1;
	Tue, 15 Oct 2024 19:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1729019444; x=1731611445; bh=jQN7C
	RCJ2b5AE108+aOTtBMaODrxsc5Ex4oLuFRxEEc=; b=pFMWzpkFv/qLs6+2JVS3P
	cJjgx5GgFt+klZMJTo56xeaZoyTlz3XrrZM1k2jovmUVljkeWkRNWtxbkYc1KbJV
	PSPAdTulO54YLzLIJ2E1fm+bEIxQPDKOq6uMwD6K7F2ZCVcFi0SX6xDpDmRTbEJx
	I8NzjvSpycdL15QPFZa59eL46eVua+PlL3wVFZ4DiqXmhauC6IvopAxRTj5AFnnz
	loXIEIhmEpLn2R2cXVcWypQbmMUPYmRJBzoO81NWvK2VoQFAePK0o4aDoKJTFFad
	BNmnXrXJP/MNQY9lJAao455cNIoaeAheLXLOoJEDHasCYul24GUQuBnYgwGd24q9
	Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Hqse_NpOurPP; Tue, 15 Oct 2024 19:10:44 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XSkFv3NFVzlgMW2;
	Tue, 15 Oct 2024 19:10:43 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH v3 19/22] xen/events: Switch to irq_get_nr_irqs()
Date: Tue, 15 Oct 2024 12:09:50 -0700
Message-ID: <20241015190953.1266194-20-bvanassche@acm.org>
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

Cc: Juergen Gross <jgross@suse.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/xen/events/events_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events=
_base.c
index 81effbd53dc5..985e155ebe4b 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -411,7 +411,7 @@ static evtchn_port_t evtchn_from_irq(unsigned int irq=
)
 {
 	const struct irq_info *info =3D NULL;
=20
-	if (likely(irq < nr_irqs))
+	if (likely(irq < irq_get_nr_irqs()))
 		info =3D info_for_irq(irq);
 	if (!info)
 		return 0;

