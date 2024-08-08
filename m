Return-Path: <linux-kernel+bounces-279250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0BD94BAF4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C228B1F23B4E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D864118C355;
	Thu,  8 Aug 2024 10:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cdWRkTMP"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E30E18B463
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 10:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723112890; cv=none; b=rQ6lXINe+cgWamPSOES0EdG0mCXGrRnooYOzyVyTr2jw+U7LhUBHgJjINejS7HHovnTrTbOeeKCxW+lER7x6+7yECWgUsCGTILXK7NFruZewuCDhUsd855kCUDl11XvZQsWNyNn+z4DqefSebH10if0iznDCOpO8i6o1Q6M7vdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723112890; c=relaxed/simple;
	bh=YH6KsNQo0XkKJ12/gKzCt+ALliyW2i9jpAtnP7Z0NFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ED7OaFABvYYpT5ijmdcxTqkfzLvZyrArfVBCfZnwsRWYoAqJLREhzLIA+ybKMwDfsvn6FaSfUjk9Kf2D2LhmgGKiihmMzO7s4QZfzu0qVjIlsp7pMEu2EgX2NclQn07IpbFhXyN93kKYZ7iy8yiitVZi44KkJMn6pW2HBRQjaLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cdWRkTMP; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so9719971fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 03:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723112886; x=1723717686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOSS3fc3XJBt3dG7ljbXMabd9Wrb6fH1OeKQO8767lc=;
        b=cdWRkTMPN3lvU1U7sQueCHZyGVIY1lBkjJlbNA+EIG2Tuf0JRP+0mX+DUYBsOe/kWe
         NxYEgUz3RBlLnXJ7f/ay7C0iYA+lJ72JK6TPPfAN84EcJyHW0DXS2PIuTesKPnOSkg7H
         1FecbQbvfdWzDn1xu4w55X8yeyO1dwdZlQErWBzDnttc1zoin3H7mccsMvwr5wEC2jLF
         HHuh8y6mmJ/+15fNbfpxp31f8ThaPu7be0JgLL08pmzP2FpcfFHzfvSZQZAAALKg9LmG
         NYWZ0xkbU2QvUMPd/5R6azh2tYNU9Uzj7QvgdxNMawMrMBop1CUZzv358NMkKbOJXsmJ
         4g0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723112886; x=1723717686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOSS3fc3XJBt3dG7ljbXMabd9Wrb6fH1OeKQO8767lc=;
        b=g+VhVzkiACEArZK8MQ8lpRrw7Pa5R+H6s+DFDP5nmAZdJ9phjOJrUtjHCFP6iLR47E
         Y7h0iLWYIMn5oF1JnxxhP6jdR8TCPcJTjzNM5htTGqqBIKOYYBJY/ZOeSJAsLWMkpyDy
         FBfdXarjLBJ62G/0Esk2ggY6jiC+6z9qaZDqZAj831CRz8vj+y0BH4bRFEKxzmX6YxlC
         0c9vNwZSdJaxNew4vd/3sVyleeiWSrpOczGAVId0eqaWBb2fRUHOZFciQD+0oStViweL
         Ty3C/nFfxxQt4UeQi+XkkWrFNB5RcbloqcnfzPyvZ84ur/fOri/KdJnK+K25JE9MDwl1
         sRDQ==
X-Forwarded-Encrypted: i=1; AJvYcCViPAmXSs9X9TVwnz8dCv0qQeXA6iJMMtpHEDu7X69u7NREq4GsOBrtGujUpQ9IkwZyO9bsX8ggqkywPgTtReBGSzFW4USGBZB2y92X
X-Gm-Message-State: AOJu0YyZm6hQp0ig9C6aAtK1YvK8VccIcvOAkV4um3TysUK3srsmjneo
	mAJ7ILZt/ODujDfty8A5yo78Xr7BBrVQ1EBzKfGTMT0UfXkVVhnvUBGBDHE3R5Y=
X-Google-Smtp-Source: AGHT+IFI4Eqtp43CGeBvgz1gjODE89pru0R69ELYaTYb+vmy6UxKtO66CovxVMStVbq01JgDsE81/A==
X-Received: by 2002:a2e:a595:0:b0:2ef:2c0f:283e with SMTP id 38308e7fff4ca-2f19de326d0mr11034371fa.12.1723112885800;
        Thu, 08 Aug 2024 03:28:05 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:ae7:4e79:8821:15db])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-36d27208c98sm1454596f8f.75.2024.08.08.03.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 03:28:05 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v3 6/9] reset: amlogic: add reset status support
Date: Thu,  8 Aug 2024 12:27:36 +0200
Message-ID: <20240808102742.4095904-7-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240808102742.4095904-1-jbrunet@baylibre.com>
References: <20240808102742.4095904-1-jbrunet@baylibre.com>
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

This is done keep the functionality when the audio reset controller
get migrated to meson-reset.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/reset-meson.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 5b6f934c0265..b16d9c32adb1 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -56,8 +56,7 @@ static int meson_reset_reset(struct reset_controller_dev *rcdev,
 static int meson_reset_level(struct reset_controller_dev *rcdev,
 			    unsigned long id, bool assert)
 {
-	struct meson_reset *data =
-		container_of(rcdev, struct meson_reset, rcdev);
+	struct meson_reset *data = container_of(rcdev, struct meson_reset, rcdev);
 	unsigned int offset, bit;
 
 	meson_reset_offset_and_bit(data, id, &offset, &bit);
@@ -68,6 +67,22 @@ static int meson_reset_level(struct reset_controller_dev *rcdev,
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
+	return val ^ data->param->level_low_reset;
+}
+
 static int meson_reset_assert(struct reset_controller_dev *rcdev,
 			      unsigned long id)
 {
@@ -84,6 +99,7 @@ static const struct reset_control_ops meson_reset_ops = {
 	.reset		= meson_reset_reset,
 	.assert		= meson_reset_assert,
 	.deassert	= meson_reset_deassert,
+	.status		= meson_reset_status,
 };
 
 static const struct meson_reset_param meson8b_param = {
-- 
2.43.0


