Return-Path: <linux-kernel+bounces-181207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2F48C7901
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D16B281A2E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E449814BFA5;
	Thu, 16 May 2024 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hbJwNewz"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2043B14D71B
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715872137; cv=none; b=FZTJyQysZi0OGndWi7ZOlW5G/vYnw+dYLCqM4YgHuAVOyEuGqr5VFnBLHJP74B8L6zwAlfNhC2eLA5Hj93aF7btAqcdHujW6ZX5bAWNEhjEoOhWYyzvxTPdjxGwu1NjRgjfrUW80Quyb2MOsPGr8R8Bv1sGjLodNQ4WqLP7vWu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715872137; c=relaxed/simple;
	bh=tGtxQtR7HQ0uRAG9sLpag+dAG8Y70atmcVnT7vJqVsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XIrWWxkrUGD37Tadf3Pzk1HUiiuRNhuMdcakGsTT1TQdAPrEfO3N3c2xx0Bxe7IFJwUO4RmraOkcySKqIwk1rf/31JW4Mctdkx5H1mZqw0LpMq3NFiwVyf9SNqBnKmIBkCMNWGKwzFpu69pFS/V+wnbpvAmVBeLnwjN89+OrpVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hbJwNewz; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e0933d3b5fso11258241fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715872133; x=1716476933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRHJOwdVIwklQU4oj6tmH8SkcGKM9hDuvtKA2hq20zY=;
        b=hbJwNewzud1Oefpi9c5VwSDD8IUG8RsAFst1DYriSvb0AkKWLyEnRXKXQYP8h7Tp87
         EdEQ17XITvLG6F5tkmd5zge1YRcT7ihBxmh6rtPdqNeg4TJQluEqRLWVUFeqH3UJPP9j
         II7hVjn5dq9H/kXFFf6RPOSvMujTbzJFVtNrbnfuqBJ4cpPdnKXVk0uWuFYvULANVmdo
         fdEHwtNJoILubrIkdfflLp/oboCzsI7YafTfaVUB2wkMclUTpBKBlLthNV0iNKIZFcVa
         2LkGWVry1io8Kjmv4HnHedZkZmcmFa98o6uqFom96+fW8tiNMKrls5tBzAiiOcEKIAvY
         Bumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715872133; x=1716476933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRHJOwdVIwklQU4oj6tmH8SkcGKM9hDuvtKA2hq20zY=;
        b=CJwXoowRQFaoSon7JNaVGGmgfPKE869AmUcEixqLZGFgWZEnNAacp/SqVfdBf+JBHB
         EaAe4gWPQDcPtFMhxP5tif39SU/IjYYH9We11I34oN1UiExLYGmhUndpN0UBZpKRYurr
         k0wblJVwTFMfQ6vLxOOP8Yt2KTc4rj+qO0hPyDaCVQmrbzvxvExvDdLZAgXL18sTTbFU
         87ERsymQhnXgzWoMqgH/MKEc4K8fti3By2eWhZkb9GxRcJoNYK40Shjt7dJzuafdFhc0
         4eW38jjAUHzK0zmLqC4fKD09WjoLjmYuIlSqWYYd4OIUVS0p7BwrnFQBlwWaspmJnkMJ
         5N5g==
X-Forwarded-Encrypted: i=1; AJvYcCXzoCfWonM+I6NPx7D5DNgno2Uu9Qvn3um3vAKyZEBlpUJc0Zg7w9X1odw9S5mdqUHi4rC2j2bd0ePlfLR2mZpzCJoZht2+bYiRB630
X-Gm-Message-State: AOJu0YzpUk501Pu0vzjFhO8d2hq1myRIXUoMjOhCyYS0w+JmqSeF9tpg
	HQow3IcLWPiIhGRTsd7YDt2eDHecolSb4wh2HjenVigD0i00IuhwX30qghjUUPI=
X-Google-Smtp-Source: AGHT+IHu52Tyfwl/3CPcNq8casphAsBV/Ti3JZcRRlwYTeXDmESt1XeztpWut4mxoqayT/xcvdJZXw==
X-Received: by 2002:a2e:97c3:0:b0:2e1:f253:152a with SMTP id 38308e7fff4ca-2e5204aef69mr132927271fa.51.1715872133305;
        Thu, 16 May 2024 08:08:53 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:1fce:7e5a:e201:edd5])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-41f87c25459sm309351725e9.18.2024.05.16.08.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 08:08:52 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Jan Dakinevich <jan.dakinevich@salutedevices.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [RFC PATCH 6/9] reset: amlogic: add toggle reset support
Date: Thu, 16 May 2024 17:08:36 +0200
Message-ID: <20240516150842.705844-7-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240516150842.705844-1-jbrunet@baylibre.com>
References: <20240516150842.705844-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Add the emulation for the reset callback using level reset if reset is not
directly supported. This is done to keep the functionality of reset
driver of audio clock controller. This is expected to work by the related
reset consumers.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/reset-meson.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 65ba9190cb53..e34a10b15593 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -17,6 +17,7 @@
 #include <linux/types.h>
 
 struct meson_reset_param {
+	const struct reset_control_ops *reset_ops;
 	unsigned int reset_num;
 	int reset_offset;
 	int level_offset;
@@ -98,6 +99,18 @@ static int meson_reset_deassert(struct reset_controller_dev *rcdev,
 	return meson_reset_level(rcdev, id, false);
 }
 
+static int meson_reset_level_toggle(struct reset_controller_dev *rcdev,
+				    unsigned long id)
+{
+	int ret;
+
+	ret = meson_reset_assert(rcdev, id);
+	if (ret)
+		return ret;
+
+	return meson_reset_deassert(rcdev, id);
+}
+
 static const struct reset_control_ops meson_reset_ops = {
 	.reset		= meson_reset_reset,
 	.assert		= meson_reset_assert,
@@ -105,6 +118,13 @@ static const struct reset_control_ops meson_reset_ops = {
 	.status		= meson_reset_status,
 };
 
+static const struct reset_control_ops meson_reset_toggle_ops = {
+	.reset		= meson_reset_level_toggle,
+	.assert		= meson_reset_assert,
+	.deassert	= meson_reset_deassert,
+	.status		= meson_reset_status,
+};
+
 static int meson_reset_probe(struct device *dev, struct regmap *map,
 			     const struct meson_reset_param *param)
 {
@@ -118,13 +138,14 @@ static int meson_reset_probe(struct device *dev, struct regmap *map,
 	data->map = map;
 	data->rcdev.owner = dev->driver->owner;
 	data->rcdev.nr_resets = param->reset_num;
-	data->rcdev.ops = &meson_reset_ops;
+	data->rcdev.ops = param->reset_ops;
 	data->rcdev.of_node = dev->of_node;
 
 	return devm_reset_controller_register(dev, &data->rcdev);
 }
 
 static const struct meson_reset_param meson8b_param = {
+	.reset_ops	= &meson_reset_ops,
 	.reset_num	= 256,
 	.reset_offset	= 0x0,
 	.level_offset	= 0x7c,
@@ -132,6 +153,7 @@ static const struct meson_reset_param meson8b_param = {
 };
 
 static const struct meson_reset_param meson_a1_param = {
+	.reset_ops	= &meson_reset_ops,
 	.reset_num	= 96,
 	.reset_offset	= 0x0,
 	.level_offset	= 0x40,
@@ -139,6 +161,7 @@ static const struct meson_reset_param meson_a1_param = {
 };
 
 static const struct meson_reset_param meson_s4_param = {
+	.reset_ops	= &meson_reset_ops,
 	.reset_num	= 192,
 	.reset_offset	= 0x0,
 	.level_offset	= 0x40,
-- 
2.43.0


