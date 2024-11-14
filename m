Return-Path: <linux-kernel+bounces-409600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 831D19C8F03
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4735C28B5BC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C6B1BC49;
	Thu, 14 Nov 2024 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="Qz6y5aZV"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C1213CA8D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731600107; cv=none; b=oGp1uO6YP3M98K/3xnor52Hoc49B7/qt5dIOy2LqvJwOMDpj/t5Q8SkEgId033r4Atf5M372MY++NHmQHiYsbwfc56j4wtxyZVpOebelaAILl1A3l7Uq8/W7Ko7HK0xLnvzMFWMs7u4YWRwoXPIa+7o/1DoitW6wRHylJCAPgDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731600107; c=relaxed/simple;
	bh=RgRcDTZ0cd2d3Z1miPXnLWTGyap0Y17dAsHzTAg8FY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a5KIN1nUDgb7Wd+NIM+x6EnIRHTMPLV7KsVcrgcQCUGQqf2vWNzh/Ja8saM5tHRDfKQHXDutz/7PpTPkrbmBjS4n6TETrXxBuEOn0pMBgciFhcFA7NyTmhgi8FoN9v8PZ8LyEg2gJsnIJ8lYErip6O3nHDAutSDLnbqp2Byr1ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=Qz6y5aZV; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53da07b78dfso857752e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1731600104; x=1732204904; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T7c9J9xmOBZy0E+gA1j8HfGDniMhcLFy7E+lLxJu1Tw=;
        b=Qz6y5aZV4ocBS1XT8wCXP91WURgtSO4lsn35zt9niKTiqQbWFXeMI5x7KVBnXcllwT
         Ue4+kN0G8g7ljhbeReg7FZYOgcUSRJqNEPe9FZlhP6LN4E0ezwISFGeLFReK2OTYI5CB
         nOXAX8xwAFrx7meT4KIy6dlyyo+PnRb9WMHsfIdcM+HzZlOGoN/rUaCAeKzBvNy1axCL
         BJvDkxUrDJmku6EgE/Ywzp/J0lH2TahH3P0wdnyUQMHUDrCyfja11hzfciebMURGQXyw
         g+7nzny0OM0EiNqPzzHJEsimW7ys0dchKbg6MRMRlm8t/Ry2bapvMH6fc5q0VOhFxqsg
         O4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731600104; x=1732204904;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7c9J9xmOBZy0E+gA1j8HfGDniMhcLFy7E+lLxJu1Tw=;
        b=KMf/my6MGfFZTrTDQhjCkFJCkoFFNfXyQtZlz7ApasebYISnLmKlRKu0uXicjVSBQ8
         weECgsxG7p57r3+Hp+JmpOmdhGHWm3bXZMk3dqrVVl5b+jMKXCjUvVnCZ/RZBApHd/iW
         Kyn7OSgp0V0j/XzFFOzfqmlVtDBJnyNi269HrkhAUasMsTy1yMHHlfTyKz/7bPbBxDrU
         j8RIhj+5lbayoRWnfzAHNHjE5hbgLPAqeFZm/X8n0csVcYQ1Shnt8KUxXBjmHYmwVUIf
         hFU+HE69Cq+xzvx9EDdEQ0xDGVk8a3ZLNNRojDpldKlQRyBiH8AmKHJXG0VghLiOR6l2
         CxOA==
X-Forwarded-Encrypted: i=1; AJvYcCXCoGPDbsQUMe/rBpjKA8GWLn+wc+HlAfrVY4gH11WrTVzoD77CUw9dd9N40U/eQD6IAviMnOZHXpeNKRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUqVD0RsM5isa+xStTb/jZYM37nyAK2PC2GPTbwuSK/+aBThIn
	HQR47bKR0rQjv1P/4Cp2nkwzNKJ0LsmyPcT8J0o9Pzmi5nQ7TarvxcaF1R6D9sc=
X-Google-Smtp-Source: AGHT+IH2B2O4sDgX4PQFuQz83D5q69hXTp9OqNeMo5HRiiv9F39wpipZ5EJMNQCetw5Zzb0qXWSGxQ==
X-Received: by 2002:a05:6512:3b1f:b0:539:f807:ad93 with SMTP id 2adb3069b0e04-53d9feddd90mr4485395e87.38.1731600103640;
        Thu, 14 Nov 2024 08:01:43 -0800 (PST)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-382200fe00esm1139024f8f.42.2024.11.14.08.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:01:43 -0800 (PST)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 14 Nov 2024 16:01:13 +0000
Subject: [PATCH 1/3] media: i2c: imx290: Limit analogue gain according to
 module
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-media-imx290-imx462-v1-1-c538a2e24786@raspberrypi.com>
References: <20241114-media-imx290-imx462-v1-0-c538a2e24786@raspberrypi.com>
In-Reply-To: <20241114-media-imx290-imx462-v1-0-c538a2e24786@raspberrypi.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

The imx327 only supports up to 29.4dB of analogue gain, vs
the imx290 going up to 30dB. Both are in 0.3dB steps.

As we now have model specific config, fix this mismatch,
and delete the comment referencing it.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/media/i2c/imx290.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
index ee698c99001d..da654deb444a 100644
--- a/drivers/media/i2c/imx290.c
+++ b/drivers/media/i2c/imx290.c
@@ -176,6 +176,7 @@ struct imx290_model_info {
 	enum imx290_colour_variant colour_variant;
 	const struct cci_reg_sequence *init_regs;
 	size_t init_regs_num;
+	unsigned int max_analog_gain;
 	const char *name;
 };
 
@@ -876,14 +877,10 @@ static int imx290_ctrl_init(struct imx290 *imx290)
 	 * up to 72.0dB (240) add further digital gain. Limit the range to
 	 * analog gain only, support for digital gain can be added separately
 	 * if needed.
-	 *
-	 * The IMX327 and IMX462 are largely compatible with the IMX290, but
-	 * have an analog gain range of 0.0dB to 29.4dB and 42dB of digital
-	 * gain. When support for those sensors gets added to the driver, the
-	 * gain control should be adjusted accordingly.
 	 */
 	v4l2_ctrl_new_std(&imx290->ctrls, &imx290_ctrl_ops,
-			  V4L2_CID_ANALOGUE_GAIN, 0, 100, 1, 0);
+			  V4L2_CID_ANALOGUE_GAIN, 0,
+			  imx290->model->max_analog_gain, 1, 0);
 
 	/*
 	 * Correct range will be determined through imx290_ctrl_update setting
@@ -1441,18 +1438,21 @@ static const struct imx290_model_info imx290_models[] = {
 		.colour_variant = IMX290_VARIANT_COLOUR,
 		.init_regs = imx290_global_init_settings_290,
 		.init_regs_num = ARRAY_SIZE(imx290_global_init_settings_290),
+		.max_analog_gain = 100,
 		.name = "imx290",
 	},
 	[IMX290_MODEL_IMX290LLR] = {
 		.colour_variant = IMX290_VARIANT_MONO,
 		.init_regs = imx290_global_init_settings_290,
 		.init_regs_num = ARRAY_SIZE(imx290_global_init_settings_290),
+		.max_analog_gain = 100,
 		.name = "imx290",
 	},
 	[IMX290_MODEL_IMX327LQR] = {
 		.colour_variant = IMX290_VARIANT_COLOUR,
 		.init_regs = imx290_global_init_settings_327,
 		.init_regs_num = ARRAY_SIZE(imx290_global_init_settings_327),
+		.max_analog_gain = 98,
 		.name = "imx327",
 	},
 };

-- 
2.34.1


