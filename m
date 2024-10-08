Return-Path: <linux-kernel+bounces-355890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED8D995864
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47064284BD1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038552185A3;
	Tue,  8 Oct 2024 20:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="nGYfMeSG"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038B7217906
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419194; cv=none; b=ijE0D7v0VKKz8DUlcJtuY2v7lBPXp4GaFI4AKWb/V3SlNd6XXrcoDOSNJgE5wpBL+gwVXeBXQuKr+vjZGq4aGQ4/7MFgumNdmGQAapOCbf+R3S59zcc6ZelhZpKlb+sG+sHiQ66yiagZL60lWRaJH7E6XHVYvu6Lhtre6Za4T34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419194; c=relaxed/simple;
	bh=cT7F/iY47iYil3nLGGv9FagpjGOTPwfm3obxBEiZcRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+5z5C9/ccgBtG2j/5ProCpkIVjVJAM6RNm3c4LUayeQfDxPrfxTgtPUBlRRzd8RtB1Y19/S+BFpFUvvmZNmGhkdStXPvLsNEnHzuBMB48EVC3FX0ayg/j+WzMAeYA+2E6QiHYkWzpg96S3f/YvEc9o6pXqeEl2W+Ydv0FBL9Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=nGYfMeSG; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XNSGY16dvz6ClY9b;
	Tue,  8 Oct 2024 20:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1728419186; x=1731011187; bh=F0uiC
	daEPfklLraV0W8TwdVwRj1KJ8hn/CxPHZaXW7w=; b=nGYfMeSGm6VektWLT1c8u
	kJRbOJaQxnp8Uhm7D+1ejwsEfOlBbUGOFRyNtwuWKMv5S99ymIVMCKv+8V+P2nAp
	Er0AGRR5E79lK09CD8d4I2EB6R1BxK9QBIg7VXMbuGOhj95uZ6DxjVfy6Lj8ss7g
	PQFOxkDoSkrFcovFa7AjiaosHDiNTzv6DmC1xIkXrhtU5nl8o2Xp2bDlXUvZXi1F
	Emcfy+pScjy+nlmF/1td0Iz3mORAdxiZo33Y3I+cNXDJj1Cba8SXb/u1zDnWoa1e
	+m00Z08VaZMlWp8MZZ9nNs8kTuClorix4pyDV9YCAwA3PB49e07U2nogAvSuno5H
	Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ybeO8WKbWyYN; Tue,  8 Oct 2024 20:26:26 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XNSGT2RVPz6ClY9Y;
	Tue,  8 Oct 2024 20:26:25 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Steffen Klassert <klassert@kernel.org>
Subject: [PATCH v2 08/22] net: 3com: 3c59x: Switch to irq_get_nr_irqs()
Date: Tue,  8 Oct 2024 13:25:47 -0700
Message-ID: <20241008202601.3737326-9-bvanassche@acm.org>
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

Cc: Steffen Klassert <klassert@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/net/ethernet/3com/3c59x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/3com/3c59x.c b/drivers/net/ethernet/3co=
m/3c59x.c
index 082388bb6169..790270912913 100644
--- a/drivers/net/ethernet/3com/3c59x.c
+++ b/drivers/net/ethernet/3com/3c59x.c
@@ -1302,7 +1302,7 @@ static int vortex_probe1(struct device *gendev, voi=
d __iomem *ioaddr, int irq,
 	if (print_info)
 		pr_cont(", IRQ %d\n", dev->irq);
 	/* Tell them about an invalid IRQ. */
-	if (dev->irq <=3D 0 || dev->irq >=3D nr_irqs)
+	if (dev->irq <=3D 0 || dev->irq >=3D irq_get_nr_irqs())
 		pr_warn(" *** Warning: IRQ %d is unlikely to work! ***\n",
 			dev->irq);
=20

