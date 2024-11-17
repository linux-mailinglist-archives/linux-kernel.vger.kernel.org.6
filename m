Return-Path: <linux-kernel+bounces-412061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D0C9D0340
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 12:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F5DA283CFA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 11:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED609170A11;
	Sun, 17 Nov 2024 11:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="g3uU7i02"
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7265733E7;
	Sun, 17 Nov 2024 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731842530; cv=none; b=NvMM2NlOlGHtj4mfhQWks0hmNhTGVM+vWcieIyVAg3eto4r+hIK7nhzTLUp0fWyA0WobaLhBizsz2uyvubEq/tM4z+O5+jhfaee2Lo9vm6tKH7c0ORPsdPu1FwhCWRP/oBFJSw6jal7RZI6C+x5HCTBF4G3CrSjl4LmwvVXhTLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731842530; c=relaxed/simple;
	bh=GL6L0RdEB3pV7TqNFOrFDekS6axn/OVeGdxC9qw5byM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tOsyRwhh4opw+/55JS/vk1HLDgl8OujH/40NQ5R/erV3/R9x/giQ93xXtE9g9bzegje2LdbBPTKHlbquOd3slRLrD7AVG9aNL5JhepCs0hFNNlZC6vTBHOhMgNCHNMIHa6RxBinRbZp7bzUtR7DS5KJdNSW5Ra3nl+0UKM7Pkwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=g3uU7i02; arc=none smtp.client-ip=80.12.242.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id CdLltujfVkz9DCdLltiABX; Sun, 17 Nov 2024 12:21:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731842518;
	bh=wutmjbunPazncW+7ACgp5eT9w4BJnbyk7q/fyDFLZ9g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=g3uU7i02kt7I5UMCR2YSd0Jh7XdjTBkf1sV5I1IvB/dWjRSWhguCsUDnUcPk9SjIQ
	 xDbA/sY5wzXGp8+lUTDjx2fYMIK+VM/BprxDh/mzNzDLzaFTigAq1Hoc/IMPxrGRgY
	 yqA2uh+d8/VzX1GnsqNb4qS5v8Iar4rlm+iGqNfcHgGXZGryfmrV7xDXJMq7kAN91Y
	 JyYvVYr2+ybGGGY+e7EVDLVvyXFZCP6CqVg1QbNvsA7+wIQU+PEWXsGIqQSmnZ+BLd
	 JF7rqbpM7vRTqz1nBMLz3TAqN9PhVDxzsu0uCkF/T2TkPAYdSfR9bSUBG7OXrejMFw
	 x+wqWFVIao+EQ==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 17 Nov 2024 12:21:58 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Thomas Gleixner <tglx@linutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Marc Zyngier <maz@kernel.org>,
	Aisheng Dong <aisheng.dong@nxp.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] irqchip/imx-irqsteer: Fix irq handling if an error occurs in imx_irqsteer_irq_handler()
Date: Sun, 17 Nov 2024 12:21:43 +0100
Message-ID: <ad6514c771fef0ac2d1b3c050c6db5d5e0fd034d.1731842478.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

chained_irq_enter(() should be paired with a corresponding
chained_irq_exit().

Here, if (hwirq < 0), a early return occurs and chained_irq_exit() is not
called.

Add a new label and a goto for fix it.

Fixes: 28528fca4908 ("irqchip/imx-irqsteer: Add multi output interrupts support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

Review with care, irq handling is sometimes tricky...
---
 drivers/irqchip/irq-imx-irqsteer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
index 75a0e980ff35..59abe5a8beb8 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -135,7 +135,7 @@ static void imx_irqsteer_irq_handler(struct irq_desc *desc)
 	if (hwirq < 0) {
 		pr_warn("%s: unable to get hwirq base for irq %d\n",
 			__func__, irq);
-		return;
+		goto out;
 	}
 
 	for (i = 0; i < 2; i++, hwirq += 32) {
@@ -153,6 +153,7 @@ static void imx_irqsteer_irq_handler(struct irq_desc *desc)
 			generic_handle_domain_irq(data->domain, pos + hwirq);
 	}
 
+out:
 	chained_irq_exit(irq_desc_get_chip(desc), desc);
 }
 
-- 
2.47.0


