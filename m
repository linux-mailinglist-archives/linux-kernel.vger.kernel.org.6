Return-Path: <linux-kernel+bounces-416350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CAE9D4394
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 22:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7DF4B22D46
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 21:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5591CB9E9;
	Wed, 20 Nov 2024 21:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dHuSg9Tq"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43151CB333
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 21:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732138458; cv=none; b=bD69cMUWTWb+ZJG7+SIGI2GQi9MSjSD9omAkUJHlcqclfVTswKtcsW3LLAZDNBt0pGf6cfRLm5QepaGsimb/ufJH+KNuYlbGnVC9LB2gOyZBVwJdLHTfxDhFhyl3+eIbOG3y2+5Rcoyh3DQOJ8jOIRnMADSbZYTC+mDOyTaWR8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732138458; c=relaxed/simple;
	bh=/Whh0lLO/yI7/FPmO+jIOLQNQF0tPIusHK4fVYMh/RY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=own42kXWgi3YAhHmi+zA5HPFbm9Y1ZDKVjsdThrM3mdpcD+PABcNRovbySSd01M6Rlf15SFVnZRJtGXw/9m0fhybgprZwVXI018T0WZiBbB4EAsD349Oy15sO6qaCx5CtgOGL44LRbsAnOZZfdX6hYhlfjpb4PhGwB5fEiRaMuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dHuSg9Tq; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5ec1ee25504so137906eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 13:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732138456; x=1732743256; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cxS2Z0C5wIvgTQSNU8Qu3dmatgrBAAmj1e5pgYj3js0=;
        b=dHuSg9TqOdo09fewDAsy7NY8cehS9cgCTVdERzvUHYqGr85ZyTQ1evMmMz2w63X08d
         mlgUK7wNno9VXsLTRsY6RRviD/rqv541w26z66X5bPM+sqi9YahxkoY3OgPiXbd/29VB
         +K3MlHv75BKuQG6RtcqYBLTF5CrkD1RTCnIIjkF/JMuEomkZ903j3PHeoS9/4IqsS+6I
         jKgL/TqO41iXr4RZnMI/qN29L8QM4+bOBJrHk0M2TIQGc7hKY06sDstWA+4M8FTqPyrt
         9aihtzA5qGot4OvcK1bpXGPF9MuzxJgAx2hYp/5j/I5bypyQMG0BbyEJgSueCy3baWrc
         D/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732138456; x=1732743256;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxS2Z0C5wIvgTQSNU8Qu3dmatgrBAAmj1e5pgYj3js0=;
        b=pFAkfcljANGMWBTzWOR9Z4VDnQac9pyPOYg2/0FygLMQ8A0w+jFrZ7wcQNSn0jsvRg
         p4/uDPVzHI63JgFpOWBue1BE+g3e0BixRjiD6qKVzPNhLqRIZ6/vKwyjShoVYsngVevm
         0OKwIYXnMfnEZ3RQBpTlSb8JJblWIzjoGJur1H9y/tCBCJ7w61yWoKbKxmZSQsASejRp
         K9L5hRitkSZ5i1hal4Ecp9ibNvLeqI4+eWaOGC9rk7TMPjKRua32m66LErQlsvK0a2el
         N5mcYR1pX7NOym/7PeHau/Tta5SXyOPNjMXfaaADb9xQvPGxUaUY60XK4E9Rp2Rqa9g3
         Yoxw==
X-Forwarded-Encrypted: i=1; AJvYcCWzFNuJ3ET1jTRVc75zfMmMid0rTCzQn+m8O8+f5ELv0PZx52S+T/6cCv+yHd/74ynsOX+9q5cqBhlXcik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmqLVqEZn/IbzsvEEfaw5uIdolNuywWWuOcHri865kFN2GblVf
	WsDrJ2Euoi5aUYlvhQ3mrD1nyO8B1KkaBIjZm7eq2IN8bwaqXNwJVLYLKSMNBEQ=
X-Google-Smtp-Source: AGHT+IF2lB8QgTcV4vegaXvpiMgWjD/98kXniLRx2lPUYn1xYr2NIjkpvUWFO1Od3RLDELoRjuQ/NA==
X-Received: by 2002:a05:6870:ac85:b0:296:e46b:8d09 with SMTP id 586e51a60fabf-296e46bd876mr3947193fac.12.1732138455757;
        Wed, 20 Nov 2024 13:34:15 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651852c27sm4487365fac.2.2024.11.20.13.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 13:34:15 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 20 Nov 2024 15:33:34 -0600
Subject: [PATCH 11/11] iio: dac: max5821: use
 devm_regulator_get_enable_read_voltage()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-iio-regulator-cleanup-round-6-v1-11-d5a5360f7ec3@baylibre.com>
References: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
In-Reply-To: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Simplify the code by using devm_regulator_get_enable_read_voltage().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/max5821.c | 36 ++++--------------------------------
 1 file changed, 4 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
index 18ba3eaaad75..b062a18be5e7 100644
--- a/drivers/iio/dac/max5821.c
+++ b/drivers/iio/dac/max5821.c
@@ -32,7 +32,6 @@ enum max5821_device_ids {
 
 struct max5821_data {
 	struct i2c_client	*client;
-	struct regulator	*vref_reg;
 	unsigned short		vref_mv;
 	bool			powerdown[MAX5821_MAX_DAC_CHANNELS];
 	u8			powerdown_mode[MAX5821_MAX_DAC_CHANNELS];
@@ -295,11 +294,6 @@ static const struct iio_info max5821_info = {
 	.write_raw = max5821_write_raw,
 };
 
-static void max5821_regulator_disable(void *reg)
-{
-	regulator_disable(reg);
-}
-
 static int max5821_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
@@ -321,32 +315,10 @@ static int max5821_probe(struct i2c_client *client)
 		data->powerdown_mode[tmp] = MAX5821_100KOHM_TO_GND;
 	}
 
-	data->vref_reg = devm_regulator_get(&client->dev, "vref");
-	if (IS_ERR(data->vref_reg))
-		return dev_err_probe(&client->dev, PTR_ERR(data->vref_reg),
-				     "Failed to get vref regulator\n");
-
-	ret = regulator_enable(data->vref_reg);
-	if (ret) {
-		dev_err(&client->dev,
-			"Failed to enable vref regulator: %d\n", ret);
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(&client->dev, max5821_regulator_disable,
-				       data->vref_reg);
-	if (ret) {
-		dev_err(&client->dev,
-			"Failed to add action to managed regulator: %d\n", ret);
-		return ret;
-	}
-
-	ret = regulator_get_voltage(data->vref_reg);
-	if (ret < 0) {
-		dev_err(&client->dev,
-			"Failed to get voltage on regulator: %d\n", ret);
-		return ret;
-	}
+	ret = devm_regulator_get_enable_read_voltage(&client->dev, "vref");
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to get vref regulator voltage\n");
 
 	data->vref_mv = ret / 1000;
 

-- 
2.43.0


