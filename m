Return-Path: <linux-kernel+bounces-366531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B4299F6D6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58ACE1C21021
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C248A1F5849;
	Tue, 15 Oct 2024 19:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="kYFecuAb"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8B21FBF47
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019439; cv=none; b=Iaz4qQvCDH/0wbrqn56Pt6qEp4isCqYkWALwhUCRw8elr/xHv2Cfie85qWxXXcQG814v6f6FTGSkjojU2E9gl7DDSaKGPODILyGZvVmklUX3P+RDLonoutzw39/OKVbhDSfpho2VGh1zFgQnIvqAzXrU7zotudSdaK6MilKa06k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019439; c=relaxed/simple;
	bh=UB2jBVWQDmVnfC2RkzsAIuhOdwX7jnVvXPKnj7NwtBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7yTWFwbWGEvUbVB0dyeLv7ua6Ncy8vRB4wXDIL2ZzfgLTbJsaEAeJLilhqGjalXDteJUuPkq94Hs6twn3RZFbVVMfcS2dbI+5bodlPiseURe/Eo8l1XcwtVAt7UniohLd/2Upd/glEwNGic98yhzpprlSNHgT+S1op3kXwXzUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=kYFecuAb; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XSkFl0JmLzlgMW6;
	Tue, 15 Oct 2024 19:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1729019432; x=1731611433; bh=ZYBxu
	f5NupBJUX+GVfcekz7nBMciH3P4e+lYjt6FhM0=; b=kYFecuAbUnrd1FHkYqrNk
	XDtEQ5SuI4ZfhmnCNfAQkalJgKlCo/8RDEnKl7EQePK7hF74Z3DkV1MjUI4hzkd4
	xch2bGESx5RovWUa17wFtCt+ySOhSAyZXjptDtR8i6ccP4V91W8c/Ux1LzIdhOIx
	NwuNt5I0eg2TCZmtvuaxHUW7R6LMLRvRWuTLDjq7Y9vDsTyobD/33SWiST+kX8M3
	qTjySrqekrRY6D4OKAgfpzXM95O+frt/3hdDYFikTKHj+HYbgYn+aGiiCu4Gk6wA
	649jKzaftcd5aSqeb2fcDu//ahF/Y31O1oNLhxVm1VuRRS6QY0b6TGW1rOc2LFEt
	Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id fmHpLwORTUMd; Tue, 15 Oct 2024 19:10:32 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XSkFf61JVzlgMVw;
	Tue, 15 Oct 2024 19:10:30 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Steffen Klassert <klassert@kernel.org>
Subject: [PATCH v3 08/22] net: 3com: 3c59x: Switch to irq_get_nr_irqs()
Date: Tue, 15 Oct 2024 12:09:39 -0700
Message-ID: <20241015190953.1266194-9-bvanassche@acm.org>
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

