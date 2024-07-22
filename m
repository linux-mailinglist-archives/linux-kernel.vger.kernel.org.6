Return-Path: <linux-kernel+bounces-258583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2668938A15
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0488B210C1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 07:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D5813B5B4;
	Mon, 22 Jul 2024 07:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="QjskFLXz"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E58D77A1E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 07:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721633526; cv=none; b=GtGXLXzwcOIi83K9rpurp5SBmZlGI2zn/4ZBgMw5QCf3sk9T9SCc/4zjCl21LTihRnkg1CkbVM3ySItGfj7TvustyRqY2MC6XR1t6WcB8VjnvawajuvzBMdj2SEFZsXElEzYHhQX4f0wR3+PExuD24qZIA3Y0BDziE/BeMyL59s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721633526; c=relaxed/simple;
	bh=lSLkqh+31wCIs4vlZ8wvzRHmLo3ZWREJRBUJU0f5UC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TdjW/lts3Ave0WjFgt9olSEvqgKdevEAdkcaaEElpNK0L5JwjjeUsnXaHcNMXoJs+FwIIk6zgraJXUR6I0dDZF1U1tOY7KsRa2QcbXTKOM99/J8hNosQKSuwHsEOikMJw4k61fbXcyncF5AYO41tcfXvE1fcdA1DXKaQAcn9cKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=QjskFLXz; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7037a208ff5so2308944a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 00:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1721633523; x=1722238323; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XtmPe8ZJK5pZD4LlL68HmeLqmeSQWeM4tCQK5wpvSgs=;
        b=QjskFLXzGigUQDlSi3/5zC9lgdqgzF5mq3YnFCpVftKHx6snLQfJCQ/EbXKAg71WKH
         fbFSh7r98KmIe8xpnWtbVGR0Z6UHS3PLRNxxZMgI5H/f8xHapoFsN6yVy7Qcs0IuP1yY
         wpAq+Bo7zQEiWtOCFyuOtF3sSz6XgglqTsU2Yn490+DtAxlszc/hjbeXs75UBAZnHE8S
         fCHth9QwmgnNygHHpg2BoEgyMzqAp6Xry4F4/qF7YNVsBf3fcPmVieq1FBxCE4wIWy0d
         nBVV3kUh+NxP45IUTVVgk5CKdMRxdMIs+554p9scy3KRGvcaj6usrGkyXHEw8TZqugxC
         Euew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721633523; x=1722238323;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XtmPe8ZJK5pZD4LlL68HmeLqmeSQWeM4tCQK5wpvSgs=;
        b=LGwCK4pyYkEX1m1QG3ITZjePzB3U7eAK1tIr/+h0yfp2nr+a5CNM0U44Np8GMOZkMC
         Mb0bn0ETYNcfwH65HCE/cZPmV2AxZfkJn2hsaAJNO52oPsobEPUVNnuWyFOHfOI29BRJ
         ivil3Em3oanj31qsElRSP3JQAEvLF2ssQYyAu9+JPPr2lwaLMsfhJYQtUU76RZYamN9p
         OHJ7f+ZnfYH9AIcyJGjW2zyJb5ucZRxUahjFOO7a5gPR6doyCMtQtO7AOewJuwv3yAP+
         aKXZmjPXmxgpLlsXiCZAZhsnlJjVDzVwOArfuKeyptN3AbO3XPdTi+ZD98ztzYvzs/q/
         cY0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWP+cKyDIn1O0UNzKondRaibcfIJ2BKf9GRkTheM2G5vUCMdpbxhH6UFZo/lnmbtbeFMPXcXfqjSMPgzPD9q464lQ5zSuAOQv5eXFd1
X-Gm-Message-State: AOJu0YxmFkWPOjBRod+2ESiwo+E3xI9gJpJakK5pA8Ulhyj/wDKGrzLn
	PSNf5eIGhWedXbJIL7AkHs/X1/RxvJ3cNIhN/Km3DgZ0fVFuQhRjQlBamDbO5xw=
X-Google-Smtp-Source: AGHT+IEg4NSILA1YLMa11VPFL+p8V/3CB487/N4g+VcGFw1eoRMCp9wAkwWbl2NChxxU8jftD+UVVg==
X-Received: by 2002:a05:6830:2807:b0:703:6003:11f4 with SMTP id 46e09a7af769-708fdb2292dmr10515146a34.14.1721633523650;
        Mon, 22 Jul 2024 00:32:03 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-79f0e6c9461sm4081162a12.61.2024.07.22.00.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 00:32:02 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org,
	linus.walleij@linaro.org,
	dianders@google.com,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v4 2/2] HID: i2c-hid: elan: Add elan-ekth6a12nay timing
Date: Mon, 22 Jul 2024 15:31:36 +0800
Message-Id: <20240722073136.8123-3-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240722073136.8123-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240722073136.8123-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Elan-ekth6a12nay requires reset to pull down time greater than 10ms,
so the configuration post_power_delay_ms is 10, and the chipset
initial time is required to be greater than 300ms,
so the post_gpio_reset_on_delay_ms is set to 300.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---
Changes between V4 and V3:
-  1. No changes.
v3: https://lore.kernel.org/all/20240716082851.18173-3-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V3 and V2:
-  1. No changes.
v2: https://lore.kernel.org/all/20240715073159.25064-3-lvzhaoxiong@huaqin.corp-partner.google.com/

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


