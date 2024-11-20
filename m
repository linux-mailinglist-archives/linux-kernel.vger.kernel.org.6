Return-Path: <linux-kernel+bounces-416246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CCC9D4279
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C75284202
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0201C4A16;
	Wed, 20 Nov 2024 19:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="UQGRTx8k"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BBA1BC06C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 19:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732130254; cv=none; b=sgRVIzPYTC7nO+KGtM7ntz7Oyk0apsZdsoBsZ4NbdwOznYMo6YoUv//79IYIeU4b5GFC7HlYt9jA0ySMYQkGUyIuewxbSobEdtKwPhtpwUuvEGgyEAR2ygU5753UPJbqVwviizr5j9kTVS3MWh1cyPZy8Tc/m92Cfau4oiUS/LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732130254; c=relaxed/simple;
	bh=qU/BCtVEF31P/c3SNLO19S/y0k70QJXixpBlPsGMgJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gH76yy2pglAYQTENQPwlAuExGJEqPcBGkcRu2Z09DhH3RdHU/RbxuAldL4VJkRHyn1+4QBkU5LKmrVBN3lZtdSmk2ocpd7Tip9mlAmG4Wj/aJoEFDj6Yav74c0vL2A+4QIa52ivFGk+X4e5fbHavAl5rwhPlhQx8uoTP8nmd/CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=UQGRTx8k; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-382423e1f7aso21888f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 11:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1732130251; x=1732735051; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w9/cR/dqviroqX2VCS26LbceoYUIdqbcsui+WHfkKVw=;
        b=UQGRTx8kY4S4yNsI10m2iMdHRU2aSCXydrZKBp+KM9pYJsaJD7CVu22VPgF2lXYnuf
         tUd9Ri9mFP7Hsu7SJashedF4cEJUI4aP3Ba2hQ1Qa5kqZ/J9ZhUP+my5WFZK9bEcRBXf
         YiH8j6Im8bJeXtL6Mr05FwswRjWtc12PVsKdXKEKvm/a9ckU1W9tMvXh2dtYPiq0NF0J
         O3ly2Xlapxt4zoXvmENnsCTnQ8Vc0arT5G8jKNpWwfCsJFPhRZKf+gxaa4y+NFS7EVjS
         nUzPQrVTrnHhbe06FUhiEAb3rN0CHGKqjA/5YbWsB5HeGK9HxdYqRMiRxJhJsTcjlINh
         qfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732130251; x=1732735051;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9/cR/dqviroqX2VCS26LbceoYUIdqbcsui+WHfkKVw=;
        b=Ja3D2Vy9lcluTMEvdC0fzzOG+C8EHiGk34vebJs/TGA8sPYKtWlsR7m2WMXP80BEL+
         jw/YsCyDio432Qy8WNsjWeBARyYCujlOvjgySlOiMmXwI6Gbmq2P6i9MfQjmlwX9J2EL
         Y9tkSY6jHo4krjxI7hLQ3978w8vPSEA030WxJEzNzVC8NnbaCFWeI3xrguJT97+ByaH+
         FPGi3/eGBUf2kspUjKAVxDuh/qnQui4ZbO1fKpeqdVG2tI2Ex++gkg7KQ+HXCtS/8lLF
         Q83eHud8pS36Zvug0dhffJsSGd8VDLfCx3rN2A/UIzcGs3OHf9MSvFNqMccRYHPy93OF
         ikoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQBGsDM0wZOCuX27wdrxnJTN7wv3kStwajxERQD+00LLWMOqqVmPocUy1EDIiyBce0lsoyRot0q7aGJIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU8qCOajRY9wlZkTBJTCIRW5m/mP4ha2Ql+fkPLS4VbbC96pQd
	JAfEOS9jQWsKvArTa+GutyE91zmqUN82KfuIDD+jWhAMNVuMfYB8Ju4G0/Lmeh0=
X-Google-Smtp-Source: AGHT+IHPj9lIQrPiRfD7rVN0tVOtOkEexmIO3vjJFqQ8BVd0pibyDdS6UXNk2coAs2i3XgIY5wW6Sw==
X-Received: by 2002:a5d:5f52:0:b0:382:47d0:64be with SMTP id ffacd0b85a97d-38254afc606mr2848672f8f.29.1732130250837;
        Wed, 20 Nov 2024 11:17:30 -0800 (PST)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3825a2c5ef2sm172457f8f.53.2024.11.20.11.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 11:17:30 -0800 (PST)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 20 Nov 2024 19:17:04 +0000
Subject: [PATCH v2 2/4] media: i2c: imx290: Register 0x3011 varies between
 imx327 and imx290
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-media-imx290-imx462-v2-2-7e562cf191d8@raspberrypi.com>
References: <20241120-media-imx290-imx462-v2-0-7e562cf191d8@raspberrypi.com>
In-Reply-To: <20241120-media-imx290-imx462-v2-0-7e562cf191d8@raspberrypi.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

Reviewing the datasheets, register 0x3011 is meant to be 0x02 on imx327
and 0x00 on imx290.

Move it out of the common registers, and set it appropriately in the
sensor specific sections. (Included for imx290 to be explicit, rather
than relying on the default value).

Fixes: 2d41947ec2c0 ("media: i2c: imx290: Add support for imx327 variant")
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/media/i2c/imx290.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
index da654deb444a..7d794a509670 100644
--- a/drivers/media/i2c/imx290.c
+++ b/drivers/media/i2c/imx290.c
@@ -268,7 +268,6 @@ static const struct cci_reg_sequence imx290_global_init_settings[] = {
 	{ IMX290_WINWV, 1097 },
 	{ IMX290_XSOUTSEL, IMX290_XSOUTSEL_XVSOUTSEL_VSYNC |
 			   IMX290_XSOUTSEL_XHSOUTSEL_HSYNC },
-	{ CCI_REG8(0x3011), 0x02 },
 	{ CCI_REG8(0x3012), 0x64 },
 	{ CCI_REG8(0x3013), 0x00 },
 };
@@ -276,6 +275,7 @@ static const struct cci_reg_sequence imx290_global_init_settings[] = {
 static const struct cci_reg_sequence imx290_global_init_settings_290[] = {
 	{ CCI_REG8(0x300f), 0x00 },
 	{ CCI_REG8(0x3010), 0x21 },
+	{ CCI_REG8(0x3011), 0x00 },
 	{ CCI_REG8(0x3016), 0x09 },
 	{ CCI_REG8(0x3070), 0x02 },
 	{ CCI_REG8(0x3071), 0x11 },
@@ -329,6 +329,7 @@ static const struct cci_reg_sequence xclk_regs[][IMX290_NUM_CLK_REGS] = {
 };
 
 static const struct cci_reg_sequence imx290_global_init_settings_327[] = {
+	{ CCI_REG8(0x3011), 0x02 },
 	{ CCI_REG8(0x309e), 0x4A },
 	{ CCI_REG8(0x309f), 0x4A },
 	{ CCI_REG8(0x313b), 0x61 },

-- 
2.34.1


