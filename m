Return-Path: <linux-kernel+bounces-255266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01304933E32
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B141F2158C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9A5181305;
	Wed, 17 Jul 2024 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ARjwEpBf"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F340D180A8E;
	Wed, 17 Jul 2024 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721225535; cv=none; b=cPObM2Bx3FR9w5Hbx8WRLVN/F2/3Czh6Ls3AfDffJuZPto4L+qDSeMQcCkr8n+JCLf7DV9Py2JKIDmtL3sELoKAg8ZJfUCl0IQwQQ67zYPtHjiun1IGzW31emCY056aKpFeWo3vtvk3dlyqeCSh+RIS5JCLTFeHs5Wl9wij6zbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721225535; c=relaxed/simple;
	bh=Y0nH3ByV5200W06bkaVQD7x7tp8lRjYmTsL0s2QRqUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cP/tt0eddKzpxNra9yCIXH6yhqK0cNZ7sRNDHz+RaSH2/2Oa1sONjO/QMzvkOQ/p/76zTeeMCU0rKtxhCpOf/S1qgRdQVI6A68KZ4UdT+kTurvvKj36yfsGp69cvbni5jgWyvdzv3gmbIsaLZwlKPr2YJfMJ/irJuw1pGnLHcA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ARjwEpBf; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 34AC9240003;
	Wed, 17 Jul 2024 14:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721225524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0cMHAF7GJKaYaEw27XTSd8T22HVixtecNYUERalZAYY=;
	b=ARjwEpBfK6tZJ63z0co08mLrGjqIMVMMf8LONIX5NvYmEWmWtg/W3Ye3yPzhpOeGKTTBSv
	hSCbmHmsrrwVIfJ072tIW1uPBYcFAypvZaoGqTphshNz5/4l+RlAEEKiDPLKwUDS/fU9D4
	zgewBQ9Jiuw3nfYoA3kIyn+fPyvRwUI603xOo8Q1COAHC3oCKhRY6B+Pkg0vBh048J92gj
	e+DVrFNzC47WoxTk6prDZSCyZsq7+baurUmRnmytEBKhdZXv2hvdtG8J5gFXwMdplxrHO1
	n9DOAqiNBVagKbxmRt32uxeOa+yClKVT1sew9PQknSoSIYs+NyST5IYkqX09lA==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: David Lechner <david@lechnology.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Christopher Cordahi <christophercordahi@nanometrics.ca>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH] clk: davinci: da8xx-cfgchip: Initialize clk_init_data before use
Date: Wed, 17 Jul 2024 16:12:01 +0200
Message-ID: <20240717141201.64125-1-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

The flag attribute of the struct clk_init_data isn't initialized before
the devm_clk_hw_register() call. This can lead to unexpected behavior
during registration.

Initialize the entire clk_init_data to zero at declaration.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/clk/davinci/da8xx-cfgchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/davinci/da8xx-cfgchip.c b/drivers/clk/davinci/da8xx-cfgchip.c
index ad2d0df43dc6..ec60ecb517f1 100644
--- a/drivers/clk/davinci/da8xx-cfgchip.c
+++ b/drivers/clk/davinci/da8xx-cfgchip.c
@@ -508,7 +508,7 @@ da8xx_cfgchip_register_usb0_clk48(struct device *dev,
 	const char * const parent_names[] = { "usb_refclkin", "pll0_auxclk" };
 	struct clk *fck_clk;
 	struct da8xx_usb0_clk48 *usb0;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 
 	fck_clk = devm_clk_get(dev, "fck");
@@ -583,7 +583,7 @@ da8xx_cfgchip_register_usb1_clk48(struct device *dev,
 {
 	const char * const parent_names[] = { "usb0_clk48", "usb_refclkin" };
 	struct da8xx_usb1_clk48 *usb1;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 
 	usb1 = devm_kzalloc(dev, sizeof(*usb1), GFP_KERNEL);
-- 
2.45.0


