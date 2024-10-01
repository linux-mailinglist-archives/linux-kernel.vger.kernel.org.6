Return-Path: <linux-kernel+bounces-345640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B5698B873
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8FB1C229D7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDAD2B9B0;
	Tue,  1 Oct 2024 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cf8919jl"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DD03BB50
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 09:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775502; cv=none; b=KtidOXrMGOzE50eSU/tbrNjF2izCY1D48RPtox3fmcH1UnUcZmvICvr0rLDZNq5tQp7x7HM1lKpGxSlhzb720K/gEnx4vOVE99T/SMSsbbkYMKewppsgtRJvP8dITWl2TI4s3q4zdOQvRta5IcI2TtDc4MCUYowCv11kJfiPcJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775502; c=relaxed/simple;
	bh=Cpx3AeJyQwnuEuBnEmjNQ88jDDc8nnxpY5yUvChiiDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S30y+FlM2SZ23RA/oYIkmzHWadscqHSFiSmHo1peX3IzhCNkYhQw5HEVcUhDPOU7ziwHnDL4/l91o+yafcGE/ZnctGk0ZlGzyV6HgLvFaU5zQs6/RQ5NoPoB/0tlTfopJaygcDji3pHIab6yx/yyXPVDKjb0qjK8pSpxP+qCaes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cf8919jl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b6458ee37so32755635ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 02:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727775500; x=1728380300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6ziXpabWoT+cHo2FMgHSApxGngpcxDuLrv8V1LP1luA=;
        b=cf8919jljsZ6kktQPow+qFAI77L7FWrzZX1tEmqzXNi6aAXKcozEDtVrVH5plCmTtL
         3RoWmywb7leUA3nJthmVrqbIKGA1LgVXq1d+X9IP9bAJaLNK82tc3SfRQa0gof7vx5PZ
         VV+i8pvBsq5ix5TsOptIa7AHlIq4Kr7pTmxtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727775500; x=1728380300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ziXpabWoT+cHo2FMgHSApxGngpcxDuLrv8V1LP1luA=;
        b=msh5+szNCeLxkSUa4VhhIaf+6DYF55l5Dgh5d7RwdDzV2+P7qxl5hKgaMatfz7H5wr
         tYhfiDft342OqAG+h6jLBzJCzui0cWNMa2huHrh1wijNYdwDHC2R9mks/DtYf7ePa/bA
         fbEcKQYYxiSLjqAplqDGrR7ixj2Hd7Pf/NcBuhJB2q0+R11Z5Fg//i4uMo16Bgaq3yd8
         7ouSk+1S2w2/BIySnwPrLWv5LJeBMbp9U0aggYWW85ilobObb/Dje7rW7vbxNn25r6Bl
         2tWW75YvKpnhLOikOE4jzZThAGe+nQHjEW2oLmTklnpRTq/IP4r0+M/gEaZXC0Jbvix0
         dS+w==
X-Forwarded-Encrypted: i=1; AJvYcCWlrVC7IfBseHZXCg0LOlbm5v3u/yOvOgOAz7oWSHPU2xtB/jt2DR2msukkRQjqIOJ/AiHOsdfU2UpSbsY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc1hqCUmVKwxvt5+nI83wvPYTphn5LfNuWgzxAX2wvMBbvHREb
	yrDuo/2iaD5IIw4jMXWpc//f0aL7tWPa1dZYZEBC5S4bxsH8c7RhwkZf4lArkQ==
X-Google-Smtp-Source: AGHT+IF24jB+QWOJMW7Lc40JtllgUfd6H5l1orvGNaAB/Xbwklif8b/5HjnAkM9TxmV3LP6xto3+TQ==
X-Received: by 2002:a17:902:c403:b0:20b:4d4c:43e with SMTP id d9443c01a7336-20b4d4c057emr188965825ad.15.1727775500570;
        Tue, 01 Oct 2024 02:38:20 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6e0e:9591:90bc:e522])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e5ecc1sm66591385ad.268.2024.10.01.02.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 02:38:20 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] Input: elan_i2c - Wait for initialization after enabling regulator supply
Date: Tue,  1 Oct 2024 17:38:14 +0800
Message-ID: <20241001093815.2481899-1-wenst@chromium.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Elan trackpad controllers require some delay after enabling power to
the controller for the hardware and firmware to initialize:

  - 2ms for hardware initialization
  - 100ms for firmware initialization

Until then, the hardware will not respond to I2C transfers. This was
observed on the MT8173 Chromebooks after the regulator supply for the
trackpad was changed to "not always on".

Add proper delays after regulator_enable() calls.

Fixes: 6696777c6506 ("Input: add driver for Elan I2C/SMbus touchpad")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
This will unfortunately slightly slow down the driver probe and resume.
An optimization would be to check if the regulator is enabled already,
and shorten or skip the delay if it is. This would require a new API
though.
---
 drivers/input/mouse/elan_i2c_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index ce96513b34f6..89556f61004e 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -46,6 +46,8 @@
 #define ETP_FWIDTH_REDUCE	90
 #define ETP_FINGER_WIDTH	15
 #define ETP_RETRY_COUNT		3
+/* H/W init 2 ms + F/W init 100 ms w/ round up */
+#define ETP_POWER_ON_DELAY	110
 
 /* quirks to control the device */
 #define ETP_QUIRK_QUICK_WAKEUP	BIT(0)
@@ -1237,6 +1239,8 @@ static int elan_probe(struct i2c_client *client)
 		return error;
 	}
 
+	msleep(ETP_POWER_ON_DELAY);
+
 	/* Make sure there is something at this address */
 	error = i2c_smbus_read_byte(client);
 	if (error < 0) {
@@ -1374,6 +1378,8 @@ static int elan_resume(struct device *dev)
 			dev_err(dev, "error %d enabling regulator\n", error);
 			goto err;
 		}
+
+		msleep(ETP_POWER_ON_DELAY);
 	}
 
 	error = elan_set_power(data, true);
-- 
2.46.1.824.gd892dcdcdd-goog


