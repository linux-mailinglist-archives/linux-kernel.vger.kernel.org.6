Return-Path: <linux-kernel+bounces-410129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D5A9CD4F5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 02:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71B38B23735
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 01:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426EE41AAC;
	Fri, 15 Nov 2024 01:18:56 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C3A2629D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 01:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731633535; cv=none; b=jmrhL6SD5Pk7vpOuWLG1MdjbAy85pvLWGX+QZlGWtAkK58OYMnIe5B2E3Mito9J9esjpXlcVOSbZFGKcJ59MsC9WJ+JGaSXedZTwCG8unM6zYWzC5VaqeOAdLia9aomUTnFvKw7Gbe5atjFSU1eJtAYZJAGGU/c+u8xOtIvd4tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731633535; c=relaxed/simple;
	bh=j3Yc9esCHcVJb2KmDLHstL0XXEqzdkKMJZMzq1aSNA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=okJm3idbjNdFKa9AbkQ1wzGROPiAx47MigF5axVTQ7X5FPWUg9JGe5d4aC6cJRH4NbufsgpejlsGmFoC+l9oPiHGYQxEley1UdvZ043kl+KIzsxji369V6jkOy40ET035weNR6LrAZodcoashoqXv+60fCE4se06t0AnikioB9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46736a178827-f7130;
	Fri, 15 Nov 2024 09:18:48 +0800 (CST)
X-RM-TRANSID:2ee46736a178827-f7130
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56736a178f13-dc523;
	Fri, 15 Nov 2024 09:18:48 +0800 (CST)
X-RM-TRANSID:2ee56736a178f13-dc523
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: frank.li@nxp.com
Cc: imx@lists.linux.dev,
	jassisinghbrar@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2] mailbox: imx: Modify the incorrect format specifier
Date: Fri, 15 Nov 2024 09:18:46 +0800
Message-Id: <20241115011846.2330-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <ZzYoWFVhfNnAcAmy@lizhi-Precision-Tower-5810>
References: <ZzYoWFVhfNnAcAmy@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Replace %i with %u in snprintf() because it is "unsigned int".

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
v1->v2:
	Modify commit info and add review tag.

 drivers/mailbox/imx-mailbox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index f815dab3be50..3fe51b2de89e 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -782,7 +782,7 @@ static int imx_mu_init_generic(struct imx_mu_priv *priv)
 		cp->chan = &priv->mbox_chans[i];
 		priv->mbox_chans[i].con_priv = cp;
 		snprintf(cp->irq_desc, sizeof(cp->irq_desc),
-			 "%s[%i-%i]", dev_name(priv->dev), cp->type, cp->idx);
+			 "%s[%i-%u]", dev_name(priv->dev), cp->type, cp->idx);
 	}
 
 	priv->mbox.num_chans = IMX_MU_CHANS;
@@ -819,7 +819,7 @@ static int imx_mu_init_specific(struct imx_mu_priv *priv)
 		cp->chan = &priv->mbox_chans[i];
 		priv->mbox_chans[i].con_priv = cp;
 		snprintf(cp->irq_desc, sizeof(cp->irq_desc),
-			 "%s[%i-%i]", dev_name(priv->dev), cp->type, cp->idx);
+			 "%s[%i-%u]", dev_name(priv->dev), cp->type, cp->idx);
 	}
 
 	priv->mbox.num_chans = num_chans;
-- 
2.33.0




