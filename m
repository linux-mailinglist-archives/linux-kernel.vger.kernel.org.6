Return-Path: <linux-kernel+bounces-408735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7709C82DF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 06:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F2B284B9C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 05:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2A51E8854;
	Thu, 14 Nov 2024 05:59:42 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63251E0E13
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 05:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731563981; cv=none; b=m/IylPZxiYDZIfNbICtdtCNL0rvv5y8L86IYL+fJzKs1aNvkoPeopHlF3sp5gZjPDEIEbV8BLXYS1UCxwmc7B0kVJBHI+SMO1QLtBI4nDoNOs/KRKk4sAF3QcQXR6m5hgSBjXO/zh1Slwc/QyoOjKHfXDPdDzkYYBGkMtC95spE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731563981; c=relaxed/simple;
	bh=QTWnHqyT/LNaWSZzix5iE+Id6VEUHg02HTfxPYltqjY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MeoFRJLQLx/MilQfDIeGbe3wf4jGsAHSji85hAF6IB4HmMGo0Cw0UZzI/UceFFH+oySDzchk95hoz072ukiJ2XNYZg3adwwnRO9UpPCs9BclnacWAQ0HjggzIZ989yHa08/pvDkZ5r7HGKh7wFTGvvjVvy8pYS9ezd56EcDE5x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee6673591be790-ee060;
	Thu, 14 Nov 2024 13:59:29 +0800 (CST)
X-RM-TRANSID:2ee6673591be790-ee060
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee8673591c0612-ab314;
	Thu, 14 Nov 2024 13:59:29 +0800 (CST)
X-RM-TRANSID:2ee8673591c0612-ab314
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: jassisinghbrar@gmail.com
Cc: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] mailbox: imx: Modify the incorrect format specifier
Date: Thu, 14 Nov 2024 13:59:26 +0800
Message-Id: <20241114055926.38502-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

The format specifier of "unsigned int" in snprintf()
should be "%u", not "%i".

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
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




