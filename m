Return-Path: <linux-kernel+bounces-213255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCEF907327
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4D7285EB5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB20144313;
	Thu, 13 Jun 2024 13:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RKrtvdq0"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90217142E81
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284074; cv=none; b=sfvg0UdjOgREanvSgkdY33POrC78vl9BKDGNrHqjeooM6i4MXv8GOj5vZnMieHKbrXd3SDQHMFWhu8drqtyjKuz9AOw0zw3XfYsk6vat+D54jE41e+aKNfaC7MjcoEPYE8LlsTG72U5CfTkNU6Uss3WWFhH557KGN8emQFGdHt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284074; c=relaxed/simple;
	bh=KoeKOC9BxNbULIOx5THehrA2LvyMrmoh0J2kqk1uxqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NqSLDmqbb2s4XQGuGCRyvF5iw+4BCXiw3MOWvSGkX8hLy25SL8Lht3eqmZsmoCBro9U5ndwfMMQiga0iE49xGvgZe+ZcXWNNgwgGQAYSRBGgx+ushZD/tQJxt/X2gG+9gPxoDxoBfa+VFyFHs9v4HA44BREENVpPJKyls82nxns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RKrtvdq0; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 852C0240003;
	Thu, 13 Jun 2024 13:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718284064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jPqUbSf1Qdf1yloJtVBeCvPFg+XlI7QIXeQdbRho+l4=;
	b=RKrtvdq0hC2/jVYPZXrCIbBpbVPtezi8Xmq7AsBucCN/8VRQ01OeU+YJRYGXQFCu70cAoi
	gWo5WU2D20OwWRl8/jG7xhubDQeDJjH2l9MvjPn24E3qluWIvKiqPOsPFgsFaOXeDpFs/a
	ZfxJ20Hp1qY3w5fjqcthFwpFAi9CNqMUDhtiobwkGUMPVUZXY+Jz2QBMaDjHDDM9zBWE+1
	KLC46yShOdEA9/G+xuq10QmEQDqIipoFEX2res29SxNOYrQRsQtB4WtZjEVKw1/YjCvDQ8
	+UTcYTTpXkfxUEUzXCYc3jcT97+k+EoOtn/VwPR1S3wFtgiMvOM5k+lWhsbsdA==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Thu, 13 Jun 2024 15:07:31 +0200
Subject: [PATCH 2/2] mux: mmio: add resume support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240613-mux-mmio-resume-support-v1-2-4525bf56024a@bootlin.com>
References: <20240613-mux-mmio-resume-support-v1-0-4525bf56024a@bootlin.com>
In-Reply-To: <20240613-mux-mmio-resume-support-v1-0-4525bf56024a@bootlin.com>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, gregory.clement@bootlin.com, 
 theo.lebrun@bootlin.com, thomas.petazzoni@bootlin.com, u-kumar1@ti.com, 
 Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.12.0
X-GND-Sasl: thomas.richard@bootlin.com

From: Théo Lebrun <theo.lebrun@bootlin.com>

No need to save something during the suspend stage, as the mux core has an
internal cache to store the state of muxes.

This cache is used by mux_chip_resume() to restore all muxes.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/mux/mmio.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
index 30a952c34365..00405abe3ce3 100644
--- a/drivers/mux/mmio.c
+++ b/drivers/mux/mmio.c
@@ -130,13 +130,25 @@ static int mux_mmio_probe(struct platform_device *pdev)
 
 	mux_chip->ops = &mux_mmio_ops;
 
+	dev_set_drvdata(dev, mux_chip);
+
 	return devm_mux_chip_register(dev, mux_chip);
 }
 
+static int mux_mmio_resume_noirq(struct device *dev)
+{
+	struct mux_chip *mux_chip = dev_get_drvdata(dev);
+
+	return mux_chip_resume(mux_chip);
+}
+
+static DEFINE_NOIRQ_DEV_PM_OPS(mux_mmio_pm_ops, NULL, mux_mmio_resume_noirq);
+
 static struct platform_driver mux_mmio_driver = {
 	.driver = {
 		.name = "mmio-mux",
 		.of_match_table	= mux_mmio_dt_ids,
+		.pm = pm_sleep_ptr(&mux_mmio_pm_ops),
 	},
 	.probe = mux_mmio_probe,
 };

-- 
2.39.2


