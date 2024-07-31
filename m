Return-Path: <linux-kernel+bounces-269730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 725DD94363A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A6B1F22A31
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F184D16E88B;
	Wed, 31 Jul 2024 19:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6BtyNQZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392A116E86F;
	Wed, 31 Jul 2024 19:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722453248; cv=none; b=l2M3I1PGWt2oPrIYV9l5dQVLQ/qitVKask8CcgapD11uGna56uZ1zT4MxziLYLUD1odk7s4CiqZrZgbYmj5dmPdOU4cYzqKQGT6Ye3bOH7QmYIT09cdr/QXYMouk71HcwEC3iaP1argdyCS58klBydCdqXqnFL5yNQ5xij1hZts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722453248; c=relaxed/simple;
	bh=FZnEeld0Lth4UK91GvRatrGqtdswn6yWY0BBRWmhQps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TwsQ3+EdcDnJMjsNQ2Xbg84FxhH8UXncY7G7I9yCk8j7xSAWuWxlXjNfnaUmqkhzM/U09qDRq1T5kBINT3k5KpoSW4NqFAcOQAlk9iyc03zrRrjHImvJR22O81ZaG5bv/DzEmTVdXjyIl9llMGF7vdlX/lWlEboytpsICD4lENw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6BtyNQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB01EC116B1;
	Wed, 31 Jul 2024 19:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722453248;
	bh=FZnEeld0Lth4UK91GvRatrGqtdswn6yWY0BBRWmhQps=;
	h=From:To:Cc:Subject:Date:From;
	b=P6BtyNQZD1Oa70wh5KRZjYDxUITJ40xp/xoL0dpLHa/tccxjP2hvTOJdA/jTzG6fN
	 DhGdbEyeXFJUodGpse3h5Zl2oE1ao9fGaDEoCiGJfTPoUe/Zl7BSfNplvKASxiSk81
	 DXEjqInWnmkRKHt2Pg8aAjI/J6iHy7sk6ApC2kxr1IP8YqO47PIgykWHKs/w2Cxk9H
	 zY6fkmKvZ2KoP8waeyxrLTeF61sGeSpNY4qTCxpaww8pMCRaaY1XgUmU/cAUDNVmUw
	 1Sl6ZvEkn2oZW0Sq/t+dYrzy23YE/7jGVF5bYtR2vMpAY1ugvBDAgNS/RtMEhBbzNE
	 beSL2PViZYa9Q==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-usb@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: chipidea: Use of_property_present()
Date: Wed, 31 Jul 2024 13:12:56 -0600
Message-ID: <20240731191312.1710417-18-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of_property_present() to test for property presence rather than
of_get_property(). This is part of a larger effort to remove callers
of of_get_property() and similar functions. of_get_property() leaks
the DT property data pointer which is a problem for dynamically
allocated nodes which may be freed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/usb/chipidea/ci_hdrc_imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index bdc04ce919f7..c64ab0e07ea0 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -128,7 +128,7 @@ static struct imx_usbmisc_data *usbmisc_get_init_data(struct device *dev)
 	 * In case the fsl,usbmisc property is not present this device doesn't
 	 * need usbmisc. Return NULL (which is no error here)
 	 */
-	if (!of_get_property(np, "fsl,usbmisc", NULL))
+	if (!of_property_present(np, "fsl,usbmisc"))
 		return NULL;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
-- 
2.43.0


