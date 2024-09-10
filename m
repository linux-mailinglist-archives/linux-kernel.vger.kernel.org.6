Return-Path: <linux-kernel+bounces-323688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1569741D5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74E7CB24A75
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D666A1A4E69;
	Tue, 10 Sep 2024 18:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="1edacjsS"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDC2170A2B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725992196; cv=none; b=jJpl8w82ipQyNarfr6Gy+HdBM478YyskpMnmOxX/fjWvj9v3Fbpt0dkYhjWIjUJfY//UoDlhRFcPduoVHI6YWaokrOg0vTOh604eyQ4epWFRS0vHmOYJTV9mJxK/UEpX+frq5a6uWEQg04TUn54g7HKZke/K4Co5wgkhjY+q16k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725992196; c=relaxed/simple;
	bh=8hmUDwS0xpt5FMXF89X1yK9Oh529ACoRTyY1uSeqoQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGqOt4JLB4d+m3MlthFNWY9gFR5rqBa5UYEdOoWl9aDkvqRFmKkQg4DmOm5HPNDWv6w+vhNeI9bmh2lPOTO8k9IZsvhjg+5OOR5aSgyh1qxAkq6HD24hgrDUctVAUFE3uG85SwcQZk0PM+ln/qFG79as0OAGpka4+4gnv1NtEtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=1edacjsS; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7BA44BFB9D;
	Tue, 10 Sep 2024 20:16:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1725992189; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=uCweU3Lk1T+91XKOciulF6pemJgorXgwSwPa475ru3Y=;
	b=1edacjsSPuflsVcYxBqFqQRRnnCwkqLCQoKjsu8q7rKDRR8IsgW+IF1j9ngKKOnTB7h8lv
	VEfmgBfDaVLKPAB0YyfbOiZwDVlOtrhFLk8fzOuk9SeBoykWcnLaxbUw7gPAN4pGoxDLvu
	fWY0ANlDbRQAyRQa8KCdDjsF6geoea6T1V47LFVlVmi71rML19SBqNn7Ld37g2/8AWnoDV
	2LhfhiP+2uvlTYrzBvu5bfgpwO0zvv1POu/ADY+PDjM6L9f0HkVMZTumZNR6E8ohWi/cpD
	UpJAjz07RqiMo7NM3C40B1v0WKWXgVCbuX2AId3uA0LihN+objK+GSer+m5P3w==
From: Frieder Schrempf <frieder@fris.de>
To: Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Vinod Koul <vkoul@kernel.org>
Cc: Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Frieder Schrempf <frieder@fris.de>,
	Adam Ford <aford173@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Marco Felsch <m.felsch@pengutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/2] phy: freescale: fsl-samsung-hdmi: Add references for calculating LUT parameters to comment
Date: Tue, 10 Sep 2024 20:14:52 +0200
Message-ID: <20240910181544.214797-2-frieder@fris.de>
In-Reply-To: <20240910181544.214797-1-frieder@fris.de>
References: <20240910181544.214797-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Mention the Reference Manual and the scripts and tools available
to help calculating the PLL parameters for additional LUT entries.

Suggested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Signed-off-by: Frieder Schrempf <frieder@fris.de>
---
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index 1203143bad7a..401178bfcdda 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -61,7 +61,13 @@ static struct phy_config calculated_phy_pll_cfg = {
 	.pll_div_regs = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00 },
 };
 
-/* The lookup table contains values for which the fractional divder is used */
+/*
+ * The lookup table contains values for which the fractional divder is used.
+ * Please see the i.MX8MP Reference Manual and the resources at [1] for
+ * additional information on calculating values for table entries.
+ *
+ * [1] https://codeberg.org/fschrempf/samsung-hdmi-phy-pll-calculator
+ */
 static const struct phy_config phy_pll_cfg[] = {
 	{
 		.pixclk = 22250000,
-- 
2.46.0


