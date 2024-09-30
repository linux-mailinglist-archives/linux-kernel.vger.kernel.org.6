Return-Path: <linux-kernel+bounces-343950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE8598A1B5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07951C217E1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E72A19D8B4;
	Mon, 30 Sep 2024 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DJI55ujH"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB78819D087
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 12:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727697907; cv=none; b=ZSlbrci1SGFt9w6SrqHHT7ooLUnbOh8FSoP2dFAd/U7JKY0C8lvOWQ2vF1pTVsVWoyIVvQ544bq5HotG8TRKQW8GijofE4Ob+Z+z45F2ZsQ6DC9C3OSS/G2mo0TC9sDEh0D+BC4ySJJdyOFxVZdjmWs0v1U4bg9+PFqCO7wfHEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727697907; c=relaxed/simple;
	bh=87v9QUWrd9KJQVHdmwih7BqMWpDw/nyVGryHPM6oqVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i5zVS+awwDYWWJIU3R+tDX8k8Gh0WK6lVo8SuDJMEss1fcrIwi2zYlYV3IM4nBsdQjxOrM9BwgcSLh4J5f64BzbpyJU2LxmBcNO4nkvx3VgqrfiNyGTFLhPefmv80EOOronwLcx4kpD/8AEXaU5eQJeZ0B9T7URE6ddrwQvUbH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DJI55ujH; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cb2aaf4a73so45116036d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 05:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727697905; x=1728302705; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ebt+1b/55aPXlqauBXJO18wSUl/XzTUjhH2wTMyzrFA=;
        b=DJI55ujHYgG4ANIeBMVErFc/kYlsHXXgQRc2Cwmprm/KOHc16WPE7Uch8miyzXu1ET
         /X7wKhZVXgmlPyY79IInkqgg6Ay5hiEpImhCPpCeQbLERcC/+ei+rrgqYyNumCzTcHnd
         28LjKvRTwMv6bUZ6Q+a9doliGAC1LrCOJHyJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727697905; x=1728302705;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ebt+1b/55aPXlqauBXJO18wSUl/XzTUjhH2wTMyzrFA=;
        b=nGcbG7X6pNGaXEK1mBrvCgqAI0QjjkmjMyLGQstnOXDFre5d3iAOy4ezgAUpXRLRMd
         DeGiQKIYbGh5nnwh6tcn6M/S4B6HykLwWp9lzeRamkgAi+LTShPQ5IyYLPSDBrvrxw5n
         CCOE3z23GVCIQT8xXPbzf1cfyZTP+qHkzAmHhXQRmFh3jm347mCGpK6tZNwBUzyIAX2W
         Qu3V2eSgHVeotdrPO98EvOkvVxkf+L6W1QzpaSOk5HZtUgOXOZnb7LCpBqvx9nao9DwR
         Pdx/1ghmMFlBjQluiLVFVk+/2R5oejawWG+GcjznLrmyRBOLdK6vs9RGKXTwltdQNIKP
         6ofw==
X-Forwarded-Encrypted: i=1; AJvYcCXzXJERLl6b2h03cPV0L4MSaT6Zvsa91b+8WjLOyqphBNgFUzdOuDfEOSIGx48rQsSiriuupcE+/1M5gOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ0h6w+gZe8+9FlOOQ7lEgS9mcjRnmfICqaJDCSpiPoCMTrsre
	LknnGXFGVgQWrvtwkZRrZzlBlkAxg1LD4mG2lMOMqO2HtWIrCrVxnCTAL2cGEA==
X-Google-Smtp-Source: AGHT+IG7DxsLwmOc7mkRl/MFKW8HAXRHroSnhiAWX2HVxDFuz0PGg7dWtpjL7qcJseQqckH9Ha41Tg==
X-Received: by 2002:a05:6214:448c:b0:6c1:8663:e8f0 with SMTP id 6a1803df08f44-6cb3b61465amr169180096d6.28.1727697904581;
        Mon, 30 Sep 2024 05:05:04 -0700 (PDT)
Received: from denia.c.googlers.com (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b694369sm38822536d6.144.2024.09.30.05.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:05:04 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:25 +0000
Subject: [PATCH 30/45] media: i2c: cx25840: Use string_choices helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-cocci-opportunity-v1-30-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bingbu Cao <bingbu.cao@intel.com>, Tianshu Qiu <tian.shu.qiu@intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, Mike Isely <isely@pobox.com>, 
 Olli Salonen <olli.salonen@iki.fi>, 
 Maxim Levitsky <maximlevitsky@gmail.com>, Sean Young <sean@mess.org>, 
 Sergey Kozlov <serjk@netup.ru>, Abylay Ospan <aospan@netup.ru>, 
 Jemma Denson <jdenson@gmail.com>, 
 Patrick Boettcher <patrick.boettcher@posteo.de>, 
 Ming Qian <ming.qian@nxp.com>, Zhou Peng <eagle.zhou@nxp.com>, 
 Andy Walls <awalls@md.metrocast.net>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Jean-Christophe Trotin <jean-christophe.trotin@foss.st.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Eddie James <eajames@linux.ibm.com>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, Tomasz Figa <tfiga@chromium.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Tim Harvey <tharvey@gateworks.com>, 
 Benjamin Mugnier <benjamin.mugnier@foss.st.com>, 
 Sylvain Petinot <sylvain.petinot@foss.st.com>, 
 Jacopo Mondi <jacopo+renesas@jmondi.org>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, openbmc@lists.ozlabs.org, 
 linux-aspeed@lists.ozlabs.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

The following cocci warnings are fixed:
drivers/media/i2c/cx25840/cx25840-ir.c:1089:4-9: opportunity for str_enabled_disabled(filtr)
drivers/media/i2c/cx25840/cx25840-ir.c:1028:4-21: opportunity for str_enabled_disabled(cntrl & CNTRL_DMD)
drivers/media/i2c/cx25840/cx25840-ir.c:1113:4-21: opportunity for str_enabled_disabled(cntrl & CNTRL_MOD)
drivers/media/i2c/cx25840/cx25840-ir.c:1030:4-21: opportunity for str_enabled_disabled(cntrl & CNTRL_RFE)
drivers/media/i2c/cx25840/cx25840-ir.c:1115:4-21: opportunity for str_enabled_disabled(cntrl & CNTRL_TFE)
drivers/media/i2c/cx25840/cx25840-ir.c:1101:4-21: opportunity for str_enabled_disabled(irqen & IRQEN_ROE)
drivers/media/i2c/cx25840/cx25840-ir.c:1107:4-21: opportunity for str_enabled_disabled(irqen & IRQEN_RSE)
drivers/media/i2c/cx25840/cx25840-ir.c:1097:4-21: opportunity for str_enabled_disabled(irqen & IRQEN_RTE)
drivers/media/i2c/cx25840/cx25840-ir.c:1135:4-21: opportunity for str_enabled_disabled(irqen & IRQEN_TSE)
drivers/media/i2c/cx25840/cx25840-ir.c:1026:4-21: opportunity for str_yes_no(cntrl & CNTRL_RXE)
drivers/media/i2c/cx25840/cx25840-ir.c:1111:4-21: opportunity for str_yes_no(cntrl & CNTRL_TXE)
drivers/media/i2c/cx25840/cx25840-ir.c:1103:4-21: opportunity for str_yes_no(stats & STATS_RBY)
drivers/media/i2c/cx25840/cx25840-ir.c:1099:4-21: opportunity for str_yes_no(stats & STATS_ROR)
drivers/media/i2c/cx25840/cx25840-ir.c:1105:4-21: opportunity for str_yes_no(stats & STATS_RSR)
drivers/media/i2c/cx25840/cx25840-ir.c:1095:4-21: opportunity for str_yes_no(stats & STATS_RTO)
drivers/media/i2c/cx25840/cx25840-ir.c:1131:4-21: opportunity for str_yes_no(stats & STATS_TBY)
drivers/media/i2c/cx25840/cx25840-ir.c:1133:4-21: opportunity for str_yes_no(stats & STATS_TSR)
drivers/media/i2c/cx25840/cx25840-core.c:2369:2-8: opportunity for str_enable_disable(enable)
drivers/media/i2c/cx25840/cx25840-core.c:2392:2-8: opportunity for str_enable_disable(enable)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/i2c/cx25840/cx25840-core.c |  4 ++--
 drivers/media/i2c/cx25840/cx25840-ir.c   | 34 ++++++++++++++++----------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/media/i2c/cx25840/cx25840-core.c b/drivers/media/i2c/cx25840/cx25840-core.c
index a90a9e5705a0..dd8474609092 100644
--- a/drivers/media/i2c/cx25840/cx25840-core.c
+++ b/drivers/media/i2c/cx25840/cx25840-core.c
@@ -2366,7 +2366,7 @@ static int cx25840_s_audio_stream(struct v4l2_subdev *sd, int enable)
 		return 0;
 
 	v4l_dbg(1, cx25840_debug, client, "%s audio output\n",
-		enable ? "enable" : "disable");
+		str_enable_disable(enable));
 
 	if (enable) {
 		v = cx25840_read(client, 0x115) | 0x80;
@@ -2389,7 +2389,7 @@ static int cx25840_s_stream(struct v4l2_subdev *sd, int enable)
 	u8 v;
 
 	v4l_dbg(1, cx25840_debug, client, "%s video output\n",
-		enable ? "enable" : "disable");
+		str_enable_disable(enable));
 
 	/*
 	 * It's not clear what should be done for these devices.
diff --git a/drivers/media/i2c/cx25840/cx25840-ir.c b/drivers/media/i2c/cx25840/cx25840-ir.c
index 8cef9656c612..6f3978135178 100644
--- a/drivers/media/i2c/cx25840/cx25840-ir.c
+++ b/drivers/media/i2c/cx25840/cx25840-ir.c
@@ -1023,11 +1023,11 @@ int cx25840_ir_log_status(struct v4l2_subdev *sd)
 
 	v4l2_info(sd, "IR Receiver:\n");
 	v4l2_info(sd, "\tEnabled:                           %s\n",
-		  cntrl & CNTRL_RXE ? "yes" : "no");
+		  str_yes_no(cntrl & CNTRL_RXE));
 	v4l2_info(sd, "\tDemodulation from a carrier:       %s\n",
-		  cntrl & CNTRL_DMD ? "enabled" : "disabled");
+		  str_enabled_disabled(cntrl & CNTRL_DMD));
 	v4l2_info(sd, "\tFIFO:                              %s\n",
-		  cntrl & CNTRL_RFE ? "enabled" : "disabled");
+		  str_enabled_disabled(cntrl & CNTRL_RFE));
 	switch (cntrl & CNTRL_EDG) {
 	case CNTRL_EDG_NONE:
 		s = "disabled";
@@ -1086,33 +1086,33 @@ int cx25840_ir_log_status(struct v4l2_subdev *sd)
 		  pulse_width_count_to_us(FIFO_RXTX, rxclk),
 		  pulse_width_count_to_ns(FIFO_RXTX, rxclk));
 	v4l2_info(sd, "\tLow pass filter:                   %s\n",
-		  filtr ? "enabled" : "disabled");
+		  str_enabled_disabled(filtr));
 	if (filtr)
 		v4l2_info(sd, "\tMin acceptable pulse width (LPF):  %u us, %u ns\n",
 			  lpf_count_to_us(filtr),
 			  lpf_count_to_ns(filtr));
 	v4l2_info(sd, "\tPulse width timer timed-out:       %s\n",
-		  stats & STATS_RTO ? "yes" : "no");
+		  str_yes_no(stats & STATS_RTO));
 	v4l2_info(sd, "\tPulse width timer time-out intr:   %s\n",
-		  irqen & IRQEN_RTE ? "enabled" : "disabled");
+		  str_enabled_disabled(irqen & IRQEN_RTE));
 	v4l2_info(sd, "\tFIFO overrun:                      %s\n",
-		  stats & STATS_ROR ? "yes" : "no");
+		  str_yes_no(stats & STATS_ROR));
 	v4l2_info(sd, "\tFIFO overrun interrupt:            %s\n",
-		  irqen & IRQEN_ROE ? "enabled" : "disabled");
+		  str_enabled_disabled(irqen & IRQEN_ROE));
 	v4l2_info(sd, "\tBusy:                              %s\n",
-		  stats & STATS_RBY ? "yes" : "no");
+		  str_yes_no(stats & STATS_RBY));
 	v4l2_info(sd, "\tFIFO service requested:            %s\n",
-		  stats & STATS_RSR ? "yes" : "no");
+		  str_yes_no(stats & STATS_RSR));
 	v4l2_info(sd, "\tFIFO service request interrupt:    %s\n",
-		  irqen & IRQEN_RSE ? "enabled" : "disabled");
+		  str_enabled_disabled(irqen & IRQEN_RSE));
 
 	v4l2_info(sd, "IR Transmitter:\n");
 	v4l2_info(sd, "\tEnabled:                           %s\n",
-		  cntrl & CNTRL_TXE ? "yes" : "no");
+		  str_yes_no(cntrl & CNTRL_TXE));
 	v4l2_info(sd, "\tModulation onto a carrier:         %s\n",
-		  cntrl & CNTRL_MOD ? "enabled" : "disabled");
+		  str_enabled_disabled(cntrl & CNTRL_MOD));
 	v4l2_info(sd, "\tFIFO:                              %s\n",
-		  cntrl & CNTRL_TFE ? "enabled" : "disabled");
+		  str_enabled_disabled(cntrl & CNTRL_TFE));
 	v4l2_info(sd, "\tFIFO interrupt watermark:          %s\n",
 		  cntrl & CNTRL_TIC ? "not empty" : "half full or less");
 	v4l2_info(sd, "\tCarrier polarity:                  %s\n",
@@ -1128,11 +1128,11 @@ int cx25840_ir_log_status(struct v4l2_subdev *sd)
 		  pulse_width_count_to_us(FIFO_RXTX, txclk),
 		  pulse_width_count_to_ns(FIFO_RXTX, txclk));
 	v4l2_info(sd, "\tBusy:                              %s\n",
-		  stats & STATS_TBY ? "yes" : "no");
+		  str_yes_no(stats & STATS_TBY));
 	v4l2_info(sd, "\tFIFO service requested:            %s\n",
-		  stats & STATS_TSR ? "yes" : "no");
+		  str_yes_no(stats & STATS_TSR));
 	v4l2_info(sd, "\tFIFO service request interrupt:    %s\n",
-		  irqen & IRQEN_TSE ? "enabled" : "disabled");
+		  str_enabled_disabled(irqen & IRQEN_TSE));
 
 	return 0;
 }

-- 
2.46.1.824.gd892dcdcdd-goog


