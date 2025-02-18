Return-Path: <linux-kernel+bounces-520253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCAAA3A790
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C30716C26C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C6C1E834D;
	Tue, 18 Feb 2025 19:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cBgDL0iJ"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC5521B9FF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907055; cv=none; b=CMY6arNUM+8zV//N/Ul5oJMUNBezi5z7yGnt7TWuoQpPWHtGuUEjU6g0uTyBAt/gtWAI7SNEmKu7UZkiptC1tKAvHuumvEqeUmgcY0pX9WouaNFRdZCpeMGIzy1KnW//aL3zteaMlUn8OJSyZrRiQPy+oMoGTsItLPYhTGr7Gpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907055; c=relaxed/simple;
	bh=RfNdAqHaKYXIX+EYOkQ5lgsT/Z6MiVQ0NUsu4u5DgDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FGcNIzSq5IiTDDF1Xdkm+HB9EF7yUHNwtf/SpxqOM3//Lx/4kRhYquuMaWoM2GVcrRiTwpfo5HQa60fiOnjNmfSyGinj6ZSfsLeQyXYv+NfujK3mwoYDlcY+0as0ZMrRqo05G6UEmcvsPlu0c4f+Fga1AnxXLfGrA1ZcWA518s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cBgDL0iJ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5df07041c24so6141705a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 11:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739907051; x=1740511851; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V2IJA96cn2epCMiVThMTa+CHJ1H46iDl1Xl8KOw8NEU=;
        b=cBgDL0iJiAiR3wj5cwBqhlcg3CezOnwe0hvHo2dKVh15VdH6Jxic+DtNXZq67TGeRb
         zgUsK3n6XPlbyCqfl7LwD4+ReYuabu2ys6f9ugwufdKJJc/YbAZKerKhlexltXQrS4Xy
         +viZUSS+/p5NPcUj/PgcUbHzwjJGT4MdLBaAvgB8seZ+vCSLjQbX1rkLiwL6Jytd2lY/
         f0KzrTHblUe59LwoOHARWP2YgaudB7KBhCreQ3PskhwORw2pn/ibCszMiHAytnsImerH
         qS92b6NU8lRY4YsF2MqR7t3lg3VBdI9zY2ASSGmzEvdBOz8L4WJD8sn48+M+D0Ow0/y+
         06/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739907051; x=1740511851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2IJA96cn2epCMiVThMTa+CHJ1H46iDl1Xl8KOw8NEU=;
        b=mrEzGXam1mqllv40p6Uje+qDjsuIk59L+/sByfMf9J9p6o5Ix9XfRix3i/WZbbDrYG
         j3F+E3IJx2sFI2NQP5hMQX4KM9FjD1dTbOFLChxYhZipqr0COOOdJ+nSjfHNrxUcshJH
         2p3WRIAMaGw0kiGroPuD4Lz4HLjNM8y4ln4QVR6+7/ejjx4WJgryxGt/2WBh7+Jt5Nam
         nSKnazmh3wUg4XMGzD/jI0Vrl57XWUil+S3mS9Y7epbrGof3v4FUd6F0MIXmW3/NG8z5
         pFRyINn5dcM4G7aTCMaLgqSasbtT2bV+WTZURixhzsdr5OtlsKWheIQoY2Xo1KWR52JF
         NmCw==
X-Gm-Message-State: AOJu0Yzp4R2nH37AYIi1b8Sl6VVZMOsTo3TToTP8D2YRPfyOAc8JQNpG
	G5teckMUm5IdU0+B5f3dPvFYlhySucox4kWPHT1Y/8f4W2qZNrO7j8SPdmHIH28=
X-Gm-Gg: ASbGncstbTQ+cfUGUmT1L21Aa+sCscLj4GJIZ77f9CYdnwv8KxL+hgqPdqku63OvQZf
	jpYiR0WG8ZqMJBxK+vYHmJi8+izSQP+KZ9g+tr7O3K/oKvem3toFUBLvtbu+s9Fs10LFGswy4Ix
	DJ3y+NOfCOsnHgRBkRqNwAoc8k2Q1mXTn6npVZ2D0QGKRnepi3JhhXF6xsGTpq0IhgGPg78O7ao
	mGYVtc79PO7neQvEI1AW0L/K3fzYTrGykUIP1q+p5y/4G9Wm6zydUHhZBNRtCFZRPkj/AfVGbnc
	99DSkknXLfxP1sdF+Z3YSkwEe4Qy
X-Google-Smtp-Source: AGHT+IHXtRDavoFEuaxpZTZMT0EqHfm1KbVfaahxr8Qdj+LPqSMJy9KjmSUTGyYJHs3yvBW2gyEYug==
X-Received: by 2002:a05:6402:1ec8:b0:5e0:69b3:441c with SMTP id 4fb4d7f45d1cf-5e069b34491mr6798656a12.26.1739907050796;
        Tue, 18 Feb 2025 11:30:50 -0800 (PST)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:cbaf:af0:839d:fb4a])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1c3ce5sm9338985a12.17.2025.02.18.11.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 11:30:49 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 18 Feb 2025 20:29:51 +0100
Subject: [PATCH v4 6/8] reset: eyeq: drop device_set_of_node_from_dev()
 done by parent
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250218-aux-device-create-helper-v4-6-c3d7dfdea2e6@baylibre.com>
References: <20250218-aux-device-create-helper-v4-0-c3d7dfdea2e6@baylibre.com>
In-Reply-To: <20250218-aux-device-create-helper-v4-0-c3d7dfdea2e6@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Danilo Krummrich <dakr@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Douglas Anderson <dianders@chromium.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1584; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=Ay58eJ7ot5/ul3WJ0A2vWFebi7iz9JDlKKz/MQBcPk0=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBntN/UNRwYRSxCacN/wjpG+gTD5T1KG1hcBQsMM
 QnDuvUYONiJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZ7Tf1AAKCRDm/A8cN/La
 hWCyEACe+SnGCN6YdYLKgHmg2tCmpB+scSaVfptOtiiCaNmkm2ceymUua+hl4HQuc+cggoymEAI
 NRoyFjvpDwxEsenxo50indBSo4J+xKz/BxfWgchbJ5jBN98rcIbG8qbRJoK6bofmL8VieWY/C9n
 QziuMeen3+L6VIqwheLwS89czpdFIbtEchmvyO7447kPZT/f9tcqTtHyZZQ9ZWmUEPqyytQH3g1
 FXnb/QkITd2cOjX8fiWKCwqHnHuZZioCk73ybWlnXFChDFTJO1C/Kubw+Ku8ou5Oi1eNm5DpAKD
 AnhlKqHvcd9jAybx2STZQG34ILyCq0PGKCqdShGQNi3dEiokHFL3C08wZwHaieTJgG/BRqHDLxd
 +zWCAJ1BPN4sHUG0VUhEU1N3y5PLQTlN+fqW1PfZs66fZF3RWN2m6IST2cjtFQqOp9qEe9VL2m9
 h+b2UEflNPJZnzrxvGsMYOa1GOe3xEDN35bjBbnpOKh+SqsEnFVFvC/O08+02k2pGEvuCJgPAjN
 cmFW/PiIsKprUWk5c8WAdIAGfcL4OPNoHW/au92eXmWfXnZY45TkkT8Hkk2hgbQosUEC1eOtFKf
 MF1kq+BTKv4twjueAZWSPLgmQ+t+yWBdXZDVBktP2ocMRM8KOEqTeFZuMEw7Sebi/SXGVa4YK25
 DPOtNJY5VIKPj0g==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

From: Théo Lebrun <theo.lebrun@bootlin.com>

Our parent driver (clk-eyeq) now does the
	device_set_of_node_from_dev(dev, dev->parent)
call through the newly introduced devm_auxiliary_device_create() helper.

Doing it again in the reset-eyeq probe would be redundant.
Drop both the WARN_ON() and the device_set_of_node_from_dev() call.
Also fix the following comment that talks about "our newfound OF node".

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/reset-eyeq.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/reset/reset-eyeq.c b/drivers/reset/reset-eyeq.c
index 02d50041048b42921e3e511148cd29f215b5fc5e..8018fa895427bb1e51ea23b99803dc7fe6108421 100644
--- a/drivers/reset/reset-eyeq.c
+++ b/drivers/reset/reset-eyeq.c
@@ -420,17 +420,8 @@ static int eqr_probe(struct auxiliary_device *adev,
 	int ret;
 
 	/*
-	 * We are an auxiliary device of clk-eyeq. We do not have an OF node by
-	 * default; let's reuse our parent's OF node.
-	 */
-	WARN_ON(dev->of_node);
-	device_set_of_node_from_dev(dev, dev->parent);
-	if (!dev->of_node)
-		return -ENODEV;
-
-	/*
-	 * Using our newfound OF node, we can get match data. We cannot use
-	 * device_get_match_data() because it does not match reused OF nodes.
+	 * Get match data. We cannot use device_get_match_data() because it does
+	 * not accept reused OF nodes; see device_set_of_node_from_dev().
 	 */
 	match = of_match_node(dev->driver->of_match_table, dev->of_node);
 	if (!match || !match->data)

-- 
2.47.2


