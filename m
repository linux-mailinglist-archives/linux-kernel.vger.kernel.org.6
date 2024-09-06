Return-Path: <linux-kernel+bounces-318945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 166E696F57F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350171C23570
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAD81D0DDA;
	Fri,  6 Sep 2024 13:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AiWYhf04"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03271CF28C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725629727; cv=none; b=dG8sNpf9BhyaK+x+LqYLlV3Y2cW5R6Ik5/gj746Az+vDRVTDXt9KekOaZFGgXE0GFlNHZeUYIBrH7COpI58p6zSii7jczZzEdWHhnqwsVUd3GpJx8ZRmZKJbfPa+1APEZ++mVUckLNad8U3Jf+r6iyLFeZkOrnoE76Y68LajauU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725629727; c=relaxed/simple;
	bh=G/tkeTFlEEIIRl13gZHjvQ8SKXa0knkQG6ZsLKG6Sak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SYG0V6uMBUot0iTpwRto9Y58U28TmE3OmJecoCM9dzCKw6/VKiz9UHv1sfWR2oKa1OjvBWl5nWzUqGeAECDhjH8HvQx4eYMjvd9ucI40YMFo9OXYW5TUVP36bmLpGn7CnjzsriuGTZWNT0zxf0YArTjNp5mf/3BvF52pVBhLkx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AiWYhf04; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42c5347b2f7so16681255e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 06:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725629723; x=1726234523; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/Yf+6uxXV0kV2P21eOVpIseB4Hi71hF6SfqZ+9Zm0M=;
        b=AiWYhf044UtLsQp8nFbBXwuz0Xz/BCBPFM0UeqpdBxDTKu2QahUDm4wL+EO7H2wO+j
         ouH5wbbi6g9UXi5hPWSbJ/pXddx6T9TebR+SRc+04wbpfUUEcrzzww8RDuL3K2O2ecXk
         3NuCraiBC2zsuzYgtMxnNf0EV5sh68Y69TB8xaUo3c0WEvPKg1Uap8DPCjpUWM5Zmda1
         ayQudobK9IgSxHOXvD0S0hbxO7H7K9cM2VY+2c6fCQg3gSxyTQHsGJB00qLBOhRcJw9C
         oJwTqWCj67nsbbaGg1tZ5ddKulvYcC5eMsB6d+MgaPLMRp0TJEJwQjUWCg+o6O8ykQcr
         xKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725629723; x=1726234523;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/Yf+6uxXV0kV2P21eOVpIseB4Hi71hF6SfqZ+9Zm0M=;
        b=jN/9caRTyTgpuzMSvrBHyCqJ6ro8L7l2sUp0W+BWmhERQFwIzzgcdUF9qGy/LdH8az
         quEFFlaGl5+gmKMMRx5n7GZMQo8HorZ6/Qhog/jThG+Fw27XY4uxFKYEAQ12z3SYgNeh
         O72Lriwbh35hx5XfaTAesKGnTSE2riI1h3E2HOuaGEooG5gEtctInLjezt1U06MHtYEM
         k3K1cIFmiGLcboJuBfdcG+k+14D3FO1byDD5Bunqm7Y4BQVlqKFkAE4X+OP19140VZFG
         f6ea64WRhgRv4780Q+lzHOW6eil0c5dPEnuExgH/TsSx7n2J14md8N+0zA6qvYUnBsm8
         8Vcg==
X-Forwarded-Encrypted: i=1; AJvYcCUbvB/F4NmN4Dh6HohY/2Jm5dngpWkGx1NdnQ2dujRhwfHAuoHLa9s0q/dxvdJoq0/yxjO1/e7JwJhntyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwazYTCgv8a+pYkjuxEzkLns3DETX4stu+hg2usfLAyJE4s38nX
	Pa6ImlND5ZMsbRgQmbnUM4fw7S3feXdmvdaplMyqn1TIXH668EnOWGIBzpipAgZMcTEU/OKct/Z
	v
X-Google-Smtp-Source: AGHT+IF4VeYSejIOXDRrzU8oFu6IoWvoH1EbJ5dlPLojrpKx18ZFCT5/tQgZrXuWY+yDBawS4bkpsg==
X-Received: by 2002:a05:600c:5102:b0:425:80d5:b8b2 with SMTP id 5b1f17b1804b1-42bb01bd7f2mr186682155e9.16.1725629722686;
        Fri, 06 Sep 2024 06:35:22 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:b0ad:b504:10d4:481d])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3749eea60e2sm21684597f8f.62.2024.09.06.06.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 06:35:22 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 06 Sep 2024 15:34:49 +0200
Subject: [PATCH v4 4/9] reset: amlogic: add driver parameters
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-meson-rst-aux-v4-4-08824c3d108b@baylibre.com>
References: <20240906-meson-rst-aux-v4-0-08824c3d108b@baylibre.com>
In-Reply-To: <20240906-meson-rst-aux-v4-0-08824c3d108b@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2306; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=G/tkeTFlEEIIRl13gZHjvQ8SKXa0knkQG6ZsLKG6Sak=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBm2wURQtL+kwNEuoxQUrfvKDLVp+YLuENebFZ9b
 EI5WC0kuH+JAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZtsFEQAKCRDm/A8cN/La
 hTELD/9DwP8483wvZNoxdOUqFzHXI3fW9Yq0ENw8+O5MWleGZI7s4zhbM5tR0nhZ+eKIJ/04OLH
 uTBXT/3cAuJbsvKvZhkfHNYFLmwIuZ8TnAeKDv3FOCdOLNI+eTxU/laPVSffIlMeL0IaSmXArU7
 rAtJuSsfQk85EWJAC3Pukr4UTlixjjA47G3MTYNX5fsYwFnnir96qY32HuM1IFKUoeHGqYcg5e/
 xfhXtHap04BOu1MW8ivfRiPP+VcqbHyiRnmHUgSWD7oG+lv/a+5j5j9B4nsb3v9/9EOQ/QwqiWp
 90DR917dWwxagt/dwUl8q157/xg8F1v2LjbQNxNzkHzA+0CeMtmzHEGS65jGyC9xigrqSy2I6z/
 EoFCKxup+FH15RJm3EPgL+xLoy84E9w44Rx9Y4IQgOsjaFEdyPhDY1Qk0UBcZLynvqxQSuIOZv7
 E+RjWDMPz1gqZyp+i4PabmhMkAXe8/4MoXWG+Dc3NX3gk0vS2Kjoc+cfQPBHFnSV+XOkG0FZjyG
 Wf87NMBWnjbOilmSXsAVHUZtRwuI+j2tFpeKFzd2Ct3KM/irXsIixyN8G8gQ3y9uDjViSD+gYrz
 U6VHtXjD7AR+tNrrBdSxscGgheUbcmQNcnYSyJmP07GxaxX2z2mgTIhq3iKkZDOEpyzcn+BvtMy
 Rk9kgTHEN+8PZGw==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

To allow using the same driver for the main reset controller and the
auxiliary ones embedded in the clock controllers, allow to customise
the reset offset, same as the level offset. Also add an option to make
the level reset active low or high.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/reset-meson.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 50bd2241ef2f..6a90613c8095 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -18,7 +18,9 @@
 
 struct meson_reset_param {
 	unsigned int reg_count;
+	unsigned int reset_offset;
 	unsigned int level_offset;
+	bool level_low_reset;
 };
 
 struct meson_reset {
@@ -46,6 +48,7 @@ static int meson_reset_reset(struct reset_controller_dev *rcdev,
 	unsigned int offset, bit;
 
 	meson_reset_offset_and_bit(data, id, &offset, &bit);
+	offset += data->param->reset_offset;
 
 	return regmap_write(data->map, offset, BIT(bit));
 }
@@ -59,9 +62,10 @@ static int meson_reset_level(struct reset_controller_dev *rcdev,
 
 	meson_reset_offset_and_bit(data, id, &offset, &bit);
 	offset += data->param->level_offset;
+	assert ^= data->param->level_low_reset;
 
 	return regmap_update_bits(data->map, offset,
-				  BIT(bit), assert ? 0 : BIT(bit));
+				  BIT(bit), assert ? BIT(bit) : 0);
 }
 
 static int meson_reset_assert(struct reset_controller_dev *rcdev,
@@ -84,22 +88,30 @@ static const struct reset_control_ops meson_reset_ops = {
 
 static const struct meson_reset_param meson8b_param = {
 	.reg_count	= 8,
+	.reset_offset	= 0x0,
 	.level_offset	= 0x7c,
+	.level_low_reset = true,
 };
 
 static const struct meson_reset_param meson_a1_param = {
 	.reg_count	= 3,
+	.reset_offset	= 0x0,
 	.level_offset	= 0x40,
+	.level_low_reset = true,
 };
 
 static const struct meson_reset_param meson_s4_param = {
 	.reg_count	= 6,
+	.reset_offset	= 0x0,
 	.level_offset	= 0x40,
+	.level_low_reset = true,
 };
 
 static const struct meson_reset_param t7_param = {
 	.reg_count      = 7,
+	.reset_offset	= 0x0,
 	.level_offset   = 0x40,
+	.level_low_reset = true,
 };
 
 static const struct of_device_id meson_reset_dt_ids[] = {

-- 
2.45.2


