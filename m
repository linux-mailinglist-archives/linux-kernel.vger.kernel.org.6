Return-Path: <linux-kernel+bounces-323457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E9E973D6C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B744A1C25174
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A601AB53A;
	Tue, 10 Sep 2024 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fvcF+/tX"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4401A3BB0
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985990; cv=none; b=WJfiif95jBivPwkg8LCl5svqtWpTvWIoXqbiFimX/xfHhy5ESo4vFyviw+80Y+jN4i2okEBPjln/Hr4KIlelMFlPlOeJcvt8FU5/6mPGxNu5tDXYsonKNGOopxXI9Asv6kKFa5Z9WhP4JLiJF3X58bLtQq5oRFmG8s9AlosU7JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985990; c=relaxed/simple;
	bh=iSedGQJkeoX1rk7eD0ZddgTbF2MZs7+12PeFSEIOANY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ELim3WekqEVHq/BCohW24fl0ThuLy3FsquIOh1p3JM9RoxBkZI2D2hHvHbWRfyaA8S/LsTxdeVTzehP3JrR28EN8dLV9o2ERv/ZF2hV6/m2bhaJ2E+aVcjHGSQxmLowLXWQ1wiGovWL2Jh4iyz7Jy2R9zVBgezRgCoLPM8V7RHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fvcF+/tX; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cc8782869so4782285e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725985987; x=1726590787; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yr1sayqKxsWDgBZHQ1bM3Uke54ske3bCnU2ZK9PgUEo=;
        b=fvcF+/tXE5wz0CfMUFibGZfQMHPAdpOtPokniYnMHw4E+BwyCcK+ftYvU0PF6MKjqD
         3QfVHjZEw0DTye90uk4nnEjQAC3iRrsQzCAgwE7DOfEoMwjjdWp3/dV5zhuLZexNgk9q
         RBsBcUBGSqHSHWw3zS6ezrULk3Tab/c/L+na4oBkLqb0nw/B9+q/gWh8Jz82vhHCIhPT
         Of8s/TqCS3LYXU+GKKxE3SyOjG00IzDljyKHJFx4XgGb9khAT22j9vibR0kOMaty5+yD
         5sC8ClYF0bYVtbEhRKOeNYKspdUX8sKVRIg4HX/IbSxAqZQCa9AOyb7EGxb6JZCTzawr
         lPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725985987; x=1726590787;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yr1sayqKxsWDgBZHQ1bM3Uke54ske3bCnU2ZK9PgUEo=;
        b=oOuBv2IbBinKpaXaZiE93udxOib6w974N3RMRJ+NSYzMdUACEyqEFMn7cds4iGx8pP
         91SpZ0QMSftfn/2/sLkTx04DTs/ED98OTgUYLX5/fyr2w6JSDaHd4aHO9rvgBvQVhEG4
         sqB+yY8F3tYp8pbbHtG3X8jJRfqEBZ+fSzfC27YwUekykFjEOnB7DqvbPeay0WH1DCXM
         coShJDT1CEuOvCDplU/qvLf54Imy8wj/erxBc34q9NaZpl/73rnAwE9biRT6tjxTikz0
         6gWv6JVE0hpJPr2Y4VCTmzVdCPvkbwvP3rAez/sQrWxEptos4CvRZ5KqvdoMuybZ8lMA
         gqBA==
X-Forwarded-Encrypted: i=1; AJvYcCWssKtVkAYqZLRBhH6g5qWxwsnr4+XkMjp3KyYoTbYCApaElnptL314niwzCBDppvX1jVKx+C9z0JEHn+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGAiCOUI+qcHus+cd+OKlpNJ6W/sEbVUA5Eg6I2bn1buNsmDoG
	epZ+BpzdzZfbuVtkakGLF0NF/5v7TiDCOhLnADQ6ys0ETXQbvld0LYuF/fHsl5E=
X-Google-Smtp-Source: AGHT+IELeFZVXHB+dwXP0xf8ZS6Er0WzIl4bpD5+ge/OijJX97JS1vEUgvv9Z7lgj+Okf1bFaFzwGg==
X-Received: by 2002:a05:600c:3505:b0:42c:b950:680b with SMTP id 5b1f17b1804b1-42ccd32def2mr1984735e9.20.1725985986626;
        Tue, 10 Sep 2024 09:33:06 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:8ba7:bfe4:fea9:65b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42cc1375189sm25076025e9.1.2024.09.10.09.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 09:33:05 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 10 Sep 2024 18:32:47 +0200
Subject: [PATCH v5 5/9] reset: amlogic: use reset number instead of
 register count
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-meson-rst-aux-v5-5-60be62635d3e@baylibre.com>
References: <20240910-meson-rst-aux-v5-0-60be62635d3e@baylibre.com>
In-Reply-To: <20240910-meson-rst-aux-v5-0-60be62635d3e@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2112; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=iSedGQJkeoX1rk7eD0ZddgTbF2MZs7+12PeFSEIOANY=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBm4HS45Bs5y3vQPAmVRmGscavL+gV5EWCMzd7SC
 9DniJBvY4OJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZuB0uAAKCRDm/A8cN/La
 hYidD/oDQlXMGcC2jMCZUcZhPtkNwrsiXGV3YnQzZ/hEtN6zIOn1pG2sP692fUaetlarc979okT
 8FKOG19JZIkY3XWvjinkjjAA4r7zladAnmiUBjcIBURVH324hvQEzfvZfyM/rby29mHLZ2TYZt+
 Ck8Xln43sdaOBg29bIzpPGbGFn/YrjYl9uBjpV7rFqzsb7y2mcsShZ/78n/oc1XemLRjEBO5gZM
 RrkCyKKjh9nDwUuP8yeAysbwIIpLDX0r4a9qjc0axe9ZWZb0Ikrw6B3sS9xsXN483JlZaCp0y2Z
 dT/OYZAV7R6uLFfwQztxV8kC7eKiEUQvoDKt+9TIGaJcY7DgGLC+YDW4cWEpkManE4NCyjUQQH+
 96R0YMhIiEqOK8fCbblAVxQucnVT5Ndtx0zB4SOnr1zlWrWboCVPVEdDJp9P/IyyKTddG/Y7egT
 GAvDOY3j5Y9phAbBuldCt/RlckHHXArWis5uvbDmS0UbqiYLDEUHLYDI7V13F+UOYOZ5xPDbK5y
 AVu2RffIF9oihE/UG6u1Hz7/mD5S3AolHvxIGeOMb9vqKW8RQbVwhdF8jZ7DKmU42JLOiZ3DlqN
 KhGydB/QWi59I0xvR53rUOvKYgVJMLt5n7W9smRox69akxsJwjy03hyqVZA+/ZL6zEXhl4lvm87
 vN9FRnWbdwhxqWQ==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The reset driver from audio clock controller may register less
reset than a register can hold. To avoid making any change while
switching to auxiliary support, use the number of reset instead of the
register count to define the bounds of the reset controller.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/reset-meson.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 6a90613c8095..e31c1b7c9e4d 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -17,7 +17,7 @@
 #include <linux/types.h>
 
 struct meson_reset_param {
-	unsigned int reg_count;
+	unsigned int reset_num;
 	unsigned int reset_offset;
 	unsigned int level_offset;
 	bool level_low_reset;
@@ -87,28 +87,28 @@ static const struct reset_control_ops meson_reset_ops = {
 };
 
 static const struct meson_reset_param meson8b_param = {
-	.reg_count	= 8,
+	.reset_num	= 256,
 	.reset_offset	= 0x0,
 	.level_offset	= 0x7c,
 	.level_low_reset = true,
 };
 
 static const struct meson_reset_param meson_a1_param = {
-	.reg_count	= 3,
+	.reset_num	= 96,
 	.reset_offset	= 0x0,
 	.level_offset	= 0x40,
 	.level_low_reset = true,
 };
 
 static const struct meson_reset_param meson_s4_param = {
-	.reg_count	= 6,
+	.reset_num	= 192,
 	.reset_offset	= 0x0,
 	.level_offset	= 0x40,
 	.level_low_reset = true,
 };
 
 static const struct meson_reset_param t7_param = {
-	.reg_count      = 7,
+	.reset_num      = 224,
 	.reset_offset	= 0x0,
 	.level_offset   = 0x40,
 	.level_low_reset = true,
@@ -156,8 +156,7 @@ static int meson_reset_probe(struct platform_device *pdev)
 				     "can't init regmap mmio region\n");
 
 	data->rcdev.owner = THIS_MODULE;
-	data->rcdev.nr_resets = data->param->reg_count * BITS_PER_BYTE
-		* regmap_config.reg_stride;
+	data->rcdev.nr_resets = data->param->reset_num;
 	data->rcdev.ops = &meson_reset_ops;
 	data->rcdev.of_node = dev->of_node;
 

-- 
2.45.2


