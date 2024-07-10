Return-Path: <linux-kernel+bounces-247917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B621492D64D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DACB71C20A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFAF195FE6;
	Wed, 10 Jul 2024 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fQlilCJg"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49341194C92
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628745; cv=none; b=pFj4kmpgjHjpuYNeNZx2YppO5k/XmPsn4EidE3y2tjODOAzTFDcJEGYGMXIM9TFnd3EcwoIY/60VnF7iIh38vhjvYUczmABi4CQU9WNp54JdUGZ0bWiQrrJSY4RaQLm7Omk4fyl3Gi1CMiYm+DgwEmLBq5Vjl4K3748zHKqIY04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628745; c=relaxed/simple;
	bh=Aw+qOfPBAhV3Wh+oUUeS3SfuDDbpI8Ih1xiyhtsZ7/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aoa1HNVe97nlTX3NXQLLJaztrO98GTLWDVtRa8Z4PvoUiexQg+8zQvGjulvz8RIBDTePXCOHPeNxTs6MoPahRyFIkWpinoDteq0hrK07lsO6RyLoAxWf0vmvv4amfV9vB0xYdcRrtKlmOzfxO0mdFmtbeszbeTSqtGWR4KEWF3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fQlilCJg; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eeb1ba0468so32138231fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720628741; x=1721233541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pscEsLCW2+xzc/V+pxCdqIstr838YuHky5BjadKIhsg=;
        b=fQlilCJgsnJrT41FPRSbcJpkoaM1cWudDFazfemBhyXsvNp5iNLTbQOAaoWsBYwPKu
         J/P5R9KEwhrWtzqNDaS+gdb8gH5dk2ej+ooffFVdtNjY2/IIvg5adTm50SEdgyrTAQ4U
         MfJmpBLW5Opy42Vp8nBgEh2phSSjYOxvxTef/U11hUYsPlgfPThyjDfLF7B+rbyuZMuf
         WqpL1vuOfiEEjfQyOsaWWZSDYs3oQWoUyvSumw8ja/doTw8kPBej712VW5CQKZ7rjg6Y
         9vIKRRmZ0qWuiwrlxq0mWF7au0Z0cj4u/FgLPLlYU8SsPAJ7aTQxYlZl2acFqwMgxJiS
         d4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720628741; x=1721233541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pscEsLCW2+xzc/V+pxCdqIstr838YuHky5BjadKIhsg=;
        b=wab64ot1ai7xnx/LZ+ftYZECQlIL/q9gWOO2EjK3XUhPAb7spFYddIXS/qwUCrG5B0
         Xg/N8EfMnnlu18Kpipn3oFPGlaAPpjYOghGhztHwCvG2V9+215mRcON/hOeaLh96lFJM
         bdywd5LwipUgEdHb/RPHcaPcA6LUrxAY7S9xCuykbgpa+Xvkq1VXICBGYYSsuRrSwBwY
         VBWnNPepXOsHsXX41YSprPt9ewz71oZwqmmC0kinTjMCxKpOW4t3IpMSbLFA6SCuAsSV
         V87Vpo8K9a3uzMSVrN8OKKLPDUFHrZ9sY96f9fQXchphHs5Q/8GmsFdYLkx2bCEWpGS8
         Vf/g==
X-Forwarded-Encrypted: i=1; AJvYcCXlm5XoW/MJfMtPkUUiam8dzakQKXdq8qaHBciWCsrLX/eakKvGI3xfHoFeI9vU2y2LjK1w0jNKlIQFaWMWZS9pMQsKVSAj7ZdUQUUO
X-Gm-Message-State: AOJu0YyKT1an3XcPbee55XcGCE3HvjA/pNcd43FHQRXfQB3J41/0RATB
	WexKisI13jYajVWIjr6PbzLyBTvkdtqULwrqjj07hzNu4skTNDDLzSw//+z555s=
X-Google-Smtp-Source: AGHT+IFIOpVSt5nlbmui7fixIPX2FqGConbERPv2cHi/A6AIyFf4bo75VDo2gZeMvyu3iyHJ9ZWGTg==
X-Received: by 2002:a2e:3315:0:b0:2ec:543a:b629 with SMTP id 38308e7fff4ca-2eeb318a0f7mr39237081fa.34.1720628741455;
        Wed, 10 Jul 2024 09:25:41 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:1c99:6356:8466:36cf])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4266f6e09e5sm88693815e9.5.2024.07.10.09.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 09:25:41 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Jan Dakinevich <jan.dakinevich@salutedevices.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH 5/8] reset: amlogic: add reset status support
Date: Wed, 10 Jul 2024 18:25:14 +0200
Message-ID: <20240710162526.2341399-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710162526.2341399-1-jbrunet@baylibre.com>
References: <20240710162526.2341399-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Add a callback to check the status of the level reset, as done in
the reset driver of the audio clock controller.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/reset-meson.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 3e0447366ba6..65ba9190cb53 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -69,6 +69,23 @@ static int meson_reset_level(struct reset_controller_dev *rcdev,
 				  BIT(bit), assert ? BIT(bit) : 0);
 }
 
+static int meson_reset_status(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	struct meson_reset *data =
+		container_of(rcdev, struct meson_reset, rcdev);
+	unsigned int val, offset, bit;
+
+	meson_reset_offset_and_bit(data, id, &offset, &bit);
+	offset += data->param->level_offset;
+
+	regmap_read(data->map, offset, &val);
+	val = !!(BIT(bit) & val);
+
+
+	return val ^ data->param->level_low_reset;
+}
+
 static int meson_reset_assert(struct reset_controller_dev *rcdev,
 			      unsigned long id)
 {
@@ -85,6 +102,7 @@ static const struct reset_control_ops meson_reset_ops = {
 	.reset		= meson_reset_reset,
 	.assert		= meson_reset_assert,
 	.deassert	= meson_reset_deassert,
+	.status		= meson_reset_status,
 };
 
 static int meson_reset_probe(struct device *dev, struct regmap *map,
-- 
2.43.0


