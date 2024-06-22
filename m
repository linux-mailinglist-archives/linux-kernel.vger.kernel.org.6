Return-Path: <linux-kernel+bounces-225708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70700913425
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 15:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23FC81F22542
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 13:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4983F16F8F9;
	Sat, 22 Jun 2024 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gn8ed99h"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6B516F835;
	Sat, 22 Jun 2024 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719061979; cv=none; b=fz0IKBg1vw0KqM5RKB6rm7IMcYrn7FSZhFzOkuuHuLVw8/Iul/Gd6dXzji/efFW+zQyjFwuI/WGpsSGK+8102r8HxSVcOaxt2TTYSW611gfNY0E2kBYenNAK7gDvufhFHYkUGR3NmsNZDEx5GtGhR+mGdP7fh6pnKDgYUspfxBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719061979; c=relaxed/simple;
	bh=NOkj/f8lAc7kTz5X7jDGaKXy+Z6EDvf0UOG45AeiUzs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ACZPR19a9KZFTN/sxgOi6TX7viqpLIF+9OzNYZQdi3w48kL40A4xYbgxQqJKMnRjhcKiKPCCNlpY8LicwEYwBkuMtOecK42C3dFN3DBYwv61Fej8wESWLKyLuMluDg6Nymb9Z4ETovcKq3Gy8r1NREtTmqwVP6ncfwoA3CA4jrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gn8ed99h; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6f13dddf7eso347889966b.0;
        Sat, 22 Jun 2024 06:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719061976; x=1719666776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1KIghhhap73u1S2Fgyv5RhQSmZlNkggPnJ4NqRaVR4E=;
        b=gn8ed99hK3f7hP4UgaYN2eyiJeWBOuim/KDTbdkj67O1/FKwK4KrDCf1e9sNWPYEAO
         9/FalHXA8u4oCQ4O14DYsJmAUsdS0NSvLqf91597w8v5tBT2BjJuSdjyA+ueUftt0GKk
         LymgXCYnjlYmTBr2CT1oGV+jDopwAasyQe7TqEi6LXSAIr+kT7ObQ5OcxIjoGxKBqtpj
         pqSVEbT8RrGoDM0ZIxnQ3j/0WEn3QlnzvCKG2OKFshnaBIQLM0+fhpmcbH+dNMFUFCUU
         sgtY0y4L5U3iKLTF5DOgTyGHqDAWKOvHDLlpNco2yCurT0lyCDCDInd30YInsAJ3TvY2
         ZlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719061976; x=1719666776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KIghhhap73u1S2Fgyv5RhQSmZlNkggPnJ4NqRaVR4E=;
        b=C3lswE+0M1lTN2BJFpw4bQElrkUHts/qv6+1btgyGupONB6Z2ujaQOxpL7w/u/8JPo
         GYhKAGoIorAeTKL3NzWZ50eM5X3yM3zpLuFutV0tQhufBX2CuuYjE88ybDiPMfEEjkr5
         EbeUvhqKvkRYrfKSi0yjxbcgQwsjvMT0ejkjB/YzVNCg94ygzKEhgjrP+OlHDkPecy0Q
         rttYUooiBmN83/ff9DAkadLBLPdRfLDi1qrAStpe/vCZ/eBFaZeVJD8vCBSotK9VGxNV
         BEIw17r/Gf61IUMn2fZqLRTb+mYzyX6qeGZyUpHN1t2umz7LOqIJtkg1mw7IlfBh7se1
         CQ0A==
X-Forwarded-Encrypted: i=1; AJvYcCVR4mqZYNQLIWIVStbUeAvfwek6bvRyrgDz9rgPLKmh0MfN2F5bItrx33J7xAXLEzjWpIg6RXx8bhLBNEbWW0jMCT/U1Q19Hp+mDSofVlabzfRiHl+uAhSLPRxROg+GCSML8dwGf+1k19WtazEI3m4noLou3ewv86eOcyo3QEQcc64Vm0VT
X-Gm-Message-State: AOJu0YyEtbEXxKuNlxtmaewo6S2vOJQdVpt6Qmw200jxaXe1k1hfj0EG
	n1BQTga6iPpK98sKX6CDA5KPq1RCc2eFFF0Id5Cx1hTIcVNsolzA
X-Google-Smtp-Source: AGHT+IH5qt1PObEvU6yvifso7ZxFmIBxYQ215NYI9UltdYVsYxH03ugtpQPpYu3t5Veq/1dFONMdDA==
X-Received: by 2002:a17:906:7f05:b0:a6e:4693:1f6e with SMTP id a640c23a62f3a-a7242c39be2mr24427066b.29.1719061976155;
        Sat, 22 Jun 2024 06:12:56 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf42a724sm197708166b.16.2024.06.22.06.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 06:12:55 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: [PATCH v2 2/2] ASoC: Add support for ti,pcm5242 to the pcm512x driver
Date: Sat, 22 Jun 2024 13:12:45 +0000
Message-Id: <20240622131245.2607533-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622131245.2607533-1-christianshewitt@gmail.com>
References: <20240622131245.2607533-1-christianshewitt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible string to enable support for the ti,pcm5242 DAC chip
in the pcm512x driver.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
Changes since v1:
- add pcm5242 to SPI too as suggested by Mark Brown

 sound/soc/codecs/pcm512x-i2c.c | 2 ++
 sound/soc/codecs/pcm512x-spi.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/sound/soc/codecs/pcm512x-i2c.c b/sound/soc/codecs/pcm512x-i2c.c
index 4be476a280e1..92bcf5179779 100644
--- a/sound/soc/codecs/pcm512x-i2c.c
+++ b/sound/soc/codecs/pcm512x-i2c.c
@@ -39,6 +39,7 @@ static const struct i2c_device_id pcm512x_i2c_id[] = {
 	{ "pcm5122", },
 	{ "pcm5141", },
 	{ "pcm5142", },
+	{ "pcm5242", },
 	{ "tas5754", },
 	{ "tas5756", },
 	{ }
@@ -51,6 +52,7 @@ static const struct of_device_id pcm512x_of_match[] = {
 	{ .compatible = "ti,pcm5122", },
 	{ .compatible = "ti,pcm5141", },
 	{ .compatible = "ti,pcm5142", },
+	{ .compatible = "ti,pcm5242", },
 	{ .compatible = "ti,tas5754", },
 	{ .compatible = "ti,tas5756", },
 	{ }
diff --git a/sound/soc/codecs/pcm512x-spi.c b/sound/soc/codecs/pcm512x-spi.c
index 4d29e7196380..6629b862f47d 100644
--- a/sound/soc/codecs/pcm512x-spi.c
+++ b/sound/soc/codecs/pcm512x-spi.c
@@ -36,6 +36,7 @@ static const struct spi_device_id pcm512x_spi_id[] = {
 	{ "pcm5122", },
 	{ "pcm5141", },
 	{ "pcm5142", },
+	{ "pcm5242", },
 	{ },
 };
 MODULE_DEVICE_TABLE(spi, pcm512x_spi_id);
@@ -45,6 +46,7 @@ static const struct of_device_id pcm512x_of_match[] = {
 	{ .compatible = "ti,pcm5122", },
 	{ .compatible = "ti,pcm5141", },
 	{ .compatible = "ti,pcm5142", },
+	{ .compatible = "ti,pcm5242", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pcm512x_of_match);
-- 
2.34.1


