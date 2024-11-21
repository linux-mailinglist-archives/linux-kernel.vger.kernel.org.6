Return-Path: <linux-kernel+bounces-417284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB5D9D5200
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E6D6B28E5B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5A31B0F2B;
	Thu, 21 Nov 2024 17:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RWoZGU5f"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBC01B0F0C;
	Thu, 21 Nov 2024 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732210908; cv=none; b=l5kl5kOZVhEc4R0zc3wJCdKLuoTOn/9DBFBLa+eYCx4qZVnzkigcTu+4PxM7m1+OxtMKGbr4j9rdY0Lr6bhh1cwUohrPZVCA0dqcsqIs29r64OA8hJuIvMgT8i2mWR909cJI4CEJv9StxNy6ognTXqytAyUDletjUJmKL3A5UOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732210908; c=relaxed/simple;
	bh=RaBfbrciyIqakLX7cnWptFaO5FDlwaJjgJ518OW2p1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Abve5mRnb/J07ykj387fBbq+jL4dP5EZbdFBeAj1IyT/z4knN25Dgy4JRhLtwIMc6W0dkwILeB7VftV4Orur2zZzhPF3PC9lgVNFBtLcHlzvW8IrxwdjWZy1SToHIJJBLFtRcLusTmaKIqPDXO0vX+40BxOWFLH7ILDREe8I4SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RWoZGU5f; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D004620010;
	Thu, 21 Nov 2024 17:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732210898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKTy8XWO2qgziAQ1aV4BgRlmD2JBLSeCDp8Nwyzn3qA=;
	b=RWoZGU5fJqpTbXKi5tH+r+d1vmD3mjfhf6zksxyRpNa2uNYJqMxwWp/aivD8zuRYvbeVR6
	HaBQw6HXteslHcYc5HeiakgI80i3lGL4NvA0dVR49fCXFMkNaqK2+x1vIMmPZyaCPYDUea
	EiEcuu2XP80YdISzxDRiKnFalLoPHLRrs+BPSDuUxPflkp3mdDL0rueP/9UY9TKAsH6hhh
	T3NGDcPuhqZ9mQTaTLd35fNleQXRbFnRYg12+0mlyMKpkFqtd7yXICaPQg7eEkmXvMJj/b
	7qTCJNRPyQTqux8xlrxIUqgH9YKhnerMsJ+IDdSQuq/HEUrdwwCHfsYqkgdD3Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 21 Nov 2024 18:41:12 +0100
Subject: [PATCH 2/5] clk: Add a helper to determine a clock rate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-ge-ian-debug-imx8-clk-tree-v1-2-0f1b722588fe@bootlin.com>
References: <20241121-ge-ian-debug-imx8-clk-tree-v1-0-0f1b722588fe@bootlin.com>
In-Reply-To: <20241121-ge-ian-debug-imx8-clk-tree-v1-0-0f1b722588fe@bootlin.com>
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Ying Liu <victor.liu@nxp.com>, 
 Marek Vasut <marex@denx.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Abel Vesa <abel.vesa@linaro.org>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Ian Ray <ian.ray@ge.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-Sasl: miquel.raynal@bootlin.com

In the context of the clock core, "determine" means we calculate a
possible clock rate based on its hardware capabilities and its current
upstream parent frequency. This is opposed to "round" which tries to
find the best parent and best rate and "recalc" which is about finding
the next output clock based on a parent frequency change.

The prototype is based on clk_recalc() which does exactly the same for
the "recalc" situation.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/clk/clk.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index d02451f951cf057d068f980d985c95deb861a2d9..f171539bbb842f57698249a475c62f3f5719ccd1 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1927,6 +1927,18 @@ long clk_get_accuracy(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(clk_get_accuracy);
 
+__maybe_unused
+static unsigned long clk_determine(struct clk_core *core, unsigned long rate)
+{
+	struct clk_rate_request req = {};
+
+	clk_hw_init_rate_request(core->hw, &req, rate);
+	if (__clk_determine_rate(core->hw, &req))
+		return 0;
+
+	return req.rate;
+}
+
 static unsigned long clk_recalc(struct clk_core *core,
 				unsigned long parent_rate)
 {

-- 
2.47.0


