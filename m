Return-Path: <linux-kernel+bounces-247918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9017292D64E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45376289E99
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5165196C9C;
	Wed, 10 Jul 2024 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eHNRRPSK"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1AE1953BE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628746; cv=none; b=nSJOPg+OBuxDfIBhDo2ho5Bjjj+C6zwx/BYHHMHxSQXMTJ8mbmmbUUOzULhsE8HcYL8tf3YOX0fldYQsGH17BUQKzWgwLKsheo7McyHSHkZog2dwRy2HH2SZkiX1ePnvTi6WGLJqUzys+LqR+GJNNHKPVW5w29qLz281rNH/IRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628746; c=relaxed/simple;
	bh=tGtxQtR7HQ0uRAG9sLpag+dAG8Y70atmcVnT7vJqVsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKdR7YIxYO23t2qTqrnNTPX+LzuJIQo/xTjrO4XyojAGM8s28gPO0POrjldd1t1Ma3K9Q4MA6ZgDGQ1rA+9RQ1GCQPj/Bx1ecpJeGrSHTdVzwAduC/MXvHyQO3MBFLVOWvnUDKTkqltxjjIaqMUPA5F4F1oDlMH8B6rn4q+HSbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eHNRRPSK; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52eafa1717bso3841703e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720628742; x=1721233542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRHJOwdVIwklQU4oj6tmH8SkcGKM9hDuvtKA2hq20zY=;
        b=eHNRRPSKr4nKOK+kMBlBy+RrxmqHaiKL9GRHi9AsE2xXNYaSl3BP2oY1jLin2hktQ7
         +mIf8iJLANSRNySqbW9kVLUWsPddAONB/jgI3URN9MoTVaolhSD61CWsN3YAxOBvYWYN
         Z+mTPbsJ5ck8Ha/YhQTr53El49pZMihP3IBEaDzwl01eyxlItJqSUdw8HXv9WK/yoYFV
         Xn5eE4iGooAOtkstA3jkUdbg5oa+KOrMF0/cKry9LRbrW3KMKJLei7RGM0V1B4YkH0KH
         94Xx1r8abDZp/j+/B8+2sUhGfwj8HUa3Wn+XJS1mtTc1D//AmYxe0zIhawVvp7G6nfNl
         idAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720628742; x=1721233542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRHJOwdVIwklQU4oj6tmH8SkcGKM9hDuvtKA2hq20zY=;
        b=nJTldI6G00ucCPNsx19tRlyLx5u8qU9/WFnzQYSCKJ/c3sUJrq3c5Og0U61yqkcY2z
         MMtKkcllXGApfIh8fOoNQCLHrSfI/sO08FEni79WVXGp5gyRdcuVletOyjFVOO9vSICT
         cKp7gGwsmAnyc0BIr0a/+Nw60kk9iFX2BalwzYL39QdadaRE21R9Zb6r7BgUJJa5v81B
         4VQJx5JikwhNd5UlMgs3rY6vDAiLNuaHjrhJH4Y193AHwgSTAr2REmqcIZucrQn3xrkj
         JG3mXacgoHoev0OJQRouh/sA8CCQYabvc4EMC+X5Y32atZKwxKQkEHxicoVwljyJEb5d
         kzKg==
X-Forwarded-Encrypted: i=1; AJvYcCVEAIjrfM+g1CdVmZK0QwUmdv4Ck3MDJBFdWzhq7v5GnO5NC0SxXsOTpvaKkuXdPiA8NofDPKF3KXCzW1244pIyhltfNkD3vhJkbc7y
X-Gm-Message-State: AOJu0YwqqoZaL6bz2G1CnMvyUqb+VwKpdh8wYSXcGiIIdUQcWwZ8+vcB
	r5zvzdDF/AZXPuaOsElqHI7SYdg9mqDjJO++X9Kdo60hHLhpU2Sl2bUEPvaSLc4=
X-Google-Smtp-Source: AGHT+IGoeOCZklKr0/1tvlfZaKQ+3YXN1j9s6sBPZnGkb/G0RZztUbY1oN6KCwJUbQaOeD8WjqbHnw==
X-Received: by 2002:a05:6512:108c:b0:52e:9480:9e71 with SMTP id 2adb3069b0e04-52eb9996055mr3907030e87.28.1720628742241;
        Wed, 10 Jul 2024 09:25:42 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:1c99:6356:8466:36cf])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4266f6e09e5sm88693815e9.5.2024.07.10.09.25.41
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
Subject: [PATCH 6/8] reset: amlogic: add toggle reset support
Date: Wed, 10 Jul 2024 18:25:15 +0200
Message-ID: <20240710162526.2341399-7-jbrunet@baylibre.com>
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


