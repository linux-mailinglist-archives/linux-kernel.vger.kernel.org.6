Return-Path: <linux-kernel+bounces-252142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AF4930ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991FD1F21247
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 07:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA521BF58;
	Mon, 15 Jul 2024 07:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="1ipEMgeB"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191DB1849DA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721028742; cv=none; b=ZHXFMtl9mhF99nvsoGuJVJLhWmtByzQZ5HhnpmaukgvBsjuqou8V1NgGYkX7yBoKiPHbi2p9ohWElzNDOJB4AGXhKSgYTQDbewRlj5vrGRkUUF4iPuxza87EhgwMw3nbksUx94J6QBHiy9vFlgr2Jy4hF6eFYZCbNujAieFiw8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721028742; c=relaxed/simple;
	bh=Wj+y2xH+fb1vgKQJ0Wx3We1jyaAKeM1X2Ah1mX60tE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZPdOCv4GKveQ2aro/kfpxB8lyJgHLyZExdcUHcrM2QsRamT2u9WeOjAV5EkmTOL2GGqCRr6E+z/yrMJvdugHZyUEuYQFqyhJyB0/gyrUlMU3Hq8ooFiqGk6Ixn6ITtjBNWuhn4yWbv3UWnVAx68m1fz0OpYwKd00q3IkHdM2CHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=1ipEMgeB; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d9e13ef8edso2587567b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 00:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1721028740; x=1721633540; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7tSdEjfL5WvW40eGzJQunfNw/Y4s8XxgreL5/ZRUVN8=;
        b=1ipEMgeBIuaAEa5uMEEU3KACYBX5sawXluML00Sg0WUeZNRdhkGE/gJ02Q8HjYILyV
         tYV5HGgmG5GppNoOb9wJ9ktlvTCvA6XfhnKMK4tSAF7Ox5UYWj5Q81rC1Nfxus4su85I
         u9tzWQyxS2omhsbQj3tYgI7MyeWUZnBPvtVhL7Q1k6GEUxUY5X11A9Mz9F74dRoc82xn
         qim7vJMXQQQKUHgJcB0WNAuBpA5NgesTjRgmyO2ju/tpS0zYXeM/MppXYLyrPf+Xjgvi
         smMseqgYCyo/VLDWziAoOdn3CzniNWrYkTBrRFx6hOk+ptPMsTskYU1+jYSGXNLpH1wm
         zZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721028740; x=1721633540;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7tSdEjfL5WvW40eGzJQunfNw/Y4s8XxgreL5/ZRUVN8=;
        b=jq23D9jEJU13FPAh7udxRwS0amJoPC2vAXty6MrtLqM0if9SH6j3+80YX2qQsQEHKd
         3NEXovjX2x87veBMANr8pv9khWzUPsjJiOc08Zucc+xQN6D4vdfW8W20WBLwuV7hrBZc
         APmoF+6B6auRKBMHvW/jde44CY9BlXOPooUQLWK0ZAywwzAB41H9BWpBoL/uv8ErdyTm
         Zm45gYnAwiQh1sDoPEBcGVsKrJ1zbN2bD7kLcFaYklnV8fgOF99hRTreEzK1hD3E3ZSd
         hjsyHkuZF3hgIax/XoEN86GvbtfG8I4jtyCpCIcXdnz9deu9XcXMXatQkDEFE6Xdpxij
         K20w==
X-Forwarded-Encrypted: i=1; AJvYcCWYHeBYKm7wYrluVDUaEcxX10m5d0m9QUcwV+G1Hwhu+3Exo2MGbRAVkRpRpGGuRzTq+pDmmutObCiIzkwO9QHmO8PgeMY2AqBAiBUP
X-Gm-Message-State: AOJu0YyB3tUNEQDs9dAoaiPkZaiex9u0/aIqCT/+Jiu+CLVQk8s2pRl5
	KXLjKKPypZNbSFDXzGSPJRgM8+bJpi8swFzhZ6ttp6F6/7ult6snF7s3KMW/zRE=
X-Google-Smtp-Source: AGHT+IF5nVlSoSWF3wVdiB5RBQbm7n1CGUfwFKuZunS686w2E5L5f0Q7K6i3LlOFF3EUqu5eZmFamw==
X-Received: by 2002:a05:6808:2897:b0:3d9:dc70:10f7 with SMTP id 5614622812f47-3d9dc7014e7mr14538611b6e.42.1721028740157;
        Mon, 15 Jul 2024 00:32:20 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eca75a6sm3654464b3a.164.2024.07.15.00.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 00:32:19 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.co,
	linus.walleij@linaro.org,
	dianders@google.com,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v2 2/2] HID: i2c-hid: elan: Add elan-ekth6a12nay timing
Date: Mon, 15 Jul 2024 15:31:59 +0800
Message-Id: <20240715073159.25064-3-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240715073159.25064-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240715073159.25064-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Elan-ekth6a12nay requires reset to pull down time greater than 10ms,
so the configuration post_power_delay_ms is 10, and the chipset
initial time is required to be greater than 300ms,
so the post_gpio_reset_on_delay_ms is set to 300.

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Changes between V2 and V1:
-  1. No changes.
v1: https://lore.kernel.org/all/20240704085555.11204-3-lvzhaoxiong@huaqin.corp-partner.google.com/
---
 drivers/hid/i2c-hid/i2c-hid-of-elan.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of-elan.c b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
index 091e37933225..3fcff6daa0d3 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of-elan.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
@@ -152,6 +152,13 @@ static const struct elan_i2c_hid_chip_data elan_ekth6915_chip_data = {
 	.main_supply_name = "vcc33",
 };
 
+static const struct elan_i2c_hid_chip_data elan_ekth6a12nay_chip_data = {
+	.post_power_delay_ms = 10,
+	.post_gpio_reset_on_delay_ms = 300,
+	.hid_descriptor_address = 0x0001,
+	.main_supply_name = "vcc33",
+};
+
 static const struct elan_i2c_hid_chip_data ilitek_ili9882t_chip_data = {
 	.post_power_delay_ms = 1,
 	.post_gpio_reset_on_delay_ms = 200,
@@ -174,6 +181,7 @@ static const struct elan_i2c_hid_chip_data ilitek_ili2901_chip_data = {
 
 static const struct of_device_id elan_i2c_hid_of_match[] = {
 	{ .compatible = "elan,ekth6915", .data = &elan_ekth6915_chip_data },
+	{ .compatible = "elan,ekth6a12nay", .data = &elan_ekth6a12nay_chip_data },
 	{ .compatible = "ilitek,ili9882t", .data = &ilitek_ili9882t_chip_data },
 	{ .compatible = "ilitek,ili2901", .data = &ilitek_ili2901_chip_data },
 	{ }
-- 
2.17.1


