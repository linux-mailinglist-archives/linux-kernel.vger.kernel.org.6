Return-Path: <linux-kernel+bounces-344603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E30D98ABD4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE907283603
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9B419AD90;
	Mon, 30 Sep 2024 18:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="H7PVlgqE"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FBC19308C
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720204; cv=none; b=U5CrN/znT/0v6kdcvkbywh857Ff75XSRvPqXZOXtN/BanJdPhWDGGCoOs8HdspqXctQn9fXv1q7ifn3NfPnfzmlPxF3wBG7+0y4GUsSl7M4Ai5sk94CewIH2DpMeDGiQM3Yb5AtdffBgtu9GCVC4F98uXZwQ43PtWjJBXFIVMng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720204; c=relaxed/simple;
	bh=NJCInSfn9nK72/PFVWrZOJoInnOMjvNenZOn9B14gEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ub7mGH98pniOIMJwWfHLo/N26kAv5LDFntHcopZM13P02RlMW7kHHpHHUmweXofWzsqwmFw0JKMVZh521AQensSMiTbdG1Ni/6g7Af4aQEgOzL4ujH6xxiZ6UMTVY5D3Odd8vSNewBGQtBJEM2naY0R3MXMasWSSGwg9/FLnhoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=H7PVlgqE; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XHTmL2ZCdzlgMVw;
	Mon, 30 Sep 2024 18:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1727720192; x=1730312193; bh=/FyHs
	pQt8YHnPxUibekfAU8vzJWmnNO5YkwG5NK6KRA=; b=H7PVlgqE66PE+YTsFzkYJ
	KeyesNeoj3IcfYyU+B3HF1o9F5joXmjST/RfDY2n2NN2zB255f/CU0e4Mb2ASxL1
	qoBkMETvWe0LuHF9ZaoorF0rpopIYi8TGh1B4eJMadaQ6NHX3+fsO4OtgNK1ioM7
	lLHFk1btVd74AGLFr9kQAuPW7b4DkHsR5s8KS7QiVbOpITunjMWiDLGTQRdmWY0j
	LLnLt2cAfsRZYsf7cgTz5/nFIOfr93o8gDsLyE9V+BOkhGuws0sczjylyyrli1S3
	IwwdZbb1pz+h8mdhG/XJfjYNwvBjGLwGRa+R+cxTLJO3QGP0odtQDca4Zg4Z0vy1
	Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tTxNDlfryow6; Mon, 30 Sep 2024 18:16:32 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XHTmH4YCJzlgMVg;
	Mon, 30 Sep 2024 18:16:31 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Steffen Klassert <klassert@kernel.org>
Subject: [PATCH 08/21] net: 3com: 3c59x: Switch to number_of_interrupts()
Date: Mon, 30 Sep 2024 11:15:47 -0700
Message-ID: <20240930181600.1684198-9-bvanassche@acm.org>
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

Cc: Steffen Klassert <klassert@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/net/ethernet/3com/3c59x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/3com/3c59x.c b/drivers/net/ethernet/3co=
m/3c59x.c
index 082388bb6169..f7f2baf33f50 100644
--- a/drivers/net/ethernet/3com/3c59x.c
+++ b/drivers/net/ethernet/3com/3c59x.c
@@ -1302,7 +1302,7 @@ static int vortex_probe1(struct device *gendev, voi=
d __iomem *ioaddr, int irq,
 	if (print_info)
 		pr_cont(", IRQ %d\n", dev->irq);
 	/* Tell them about an invalid IRQ. */
-	if (dev->irq <=3D 0 || dev->irq >=3D nr_irqs)
+	if (dev->irq <=3D 0 || dev->irq >=3D number_of_interrupts())
 		pr_warn(" *** Warning: IRQ %d is unlikely to work! ***\n",
 			dev->irq);
=20

