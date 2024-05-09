Return-Path: <linux-kernel+bounces-174207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE808C0BA7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 860211C22480
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 06:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D69F13CA98;
	Thu,  9 May 2024 06:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="UCO1M5kK"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A811487C4
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 06:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715237032; cv=none; b=Ji4UGKXLWH23sSUf234Lz8+reMpHSBEt6S1fCyqiw1lZzqtjGG8DYe0y3q60LTjjoalCenc0DUDXfZrDRpGIwm+GWEUXp9rfQQH6t8QALIY7xsk6GrEx36JtXRddVHPzY3lebVz4Q7S/qXO6GbcTdYg1mu5oIPi9l/4dhDSQ6NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715237032; c=relaxed/simple;
	bh=z0VeJcL96AqRVzT5qnJ66IpNfYLBcQu1yXU9oB/gYIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IIUAKMr+Erf3MWk6QStXsZ8g5cZhkqORBWUFq6g34ITLL7kroKrYcC9g2AA0VJkY8GSb5CsMIoBTSzB0J+QQTgsYbAGgh69IjLYxokeecRnOE2ieidselYswCc5Y1QcHVAvV2zidBmOClou4gM67DbjjugxO6leoS1Q/hcuhcgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=UCO1M5kK; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f4302187c0so1192819b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 23:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1715237030; x=1715841830; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qdNwDMuXrR6P9sQoTx7HaymUgCSP7NbO1d3jQaKTXrw=;
        b=UCO1M5kKOkbwDn6fzJaYfRNx2e+iKi5CPsXy7nglEPwRwzZqpWgSEFxdFLqu+IqGdd
         bNQH4OQ0dbvPi6eppWvNaBb467UeAGCCPVzWOc3B/+SAblgmxADWzTglN0h5yG93n+NS
         SL0g+46hgyOftZxoHrynYEnI9f8dmJUvLINiPF2g2pDqvYvyXsWgSrVqPusj1CBRl3M1
         HMV7rHoTNduSnmAZMZPOg6oC4ylRNUr9dBAxrLyksEylwttiNnnfdognoiBVUBisH4IZ
         90ChNypastwN8FrHq3VHCCZsj/0JsgrMdRFkyPNaUkO8kwjvVulMcHmFnrYYtyq9zMlF
         O3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715237030; x=1715841830;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdNwDMuXrR6P9sQoTx7HaymUgCSP7NbO1d3jQaKTXrw=;
        b=LTllibMiYw2D98FCZckHUXRZCQYA9inUYRw0lk4roA5LV/1zRBevnBcXTKTV5TlbPM
         V0gbwjFZgJs2wk2iB9gpeapdFWY202wpjOldl48fPVJXCshgi9HJ7TeFYVh3Ps1Hkaek
         57z0A9S57NoqV2K8VboQszURjvzx0AAo6pbyCEVVjVnca/v6HEnzkLEO2jcjRZ6gCTPS
         f69liabJ1CmEeyerhvlunVKqbSiou30BMBchJ+5pL9eJzNEkFfYG5z5KfItu/Z7LTdGn
         QY6UXqoq6KCaTnt3LtbC3G9b+5ctDDpajA1aCayYrV4GCIC1TuWWq+xJSsxRiHZ16hv+
         Hz5g==
X-Forwarded-Encrypted: i=1; AJvYcCWdVT0EEDpL5IkstulOA6+VZ6uqCQ1lO5eQMgSIOz45i0QxplTLajO42uh7C7Lr/+3gKqCKST8CCmIpAiBkDROxbON1vEubJrWdHHLl
X-Gm-Message-State: AOJu0YzoBWbVsNkzHLw2TQjtzRokkzNLTCGQU/IqPqcqxTd43Ia+rwqU
	J/jWYSbPvQZCe7OKBmMWNfB4yDG537F3xpdvIdXolN83ve4T1hBdl+rDUzRA4Xg=
X-Google-Smtp-Source: AGHT+IFtEWfX91TqFZW9UFRmOuHgn5tfP7k3JfcAXizZ5z6i731Dyk1Sl8kjv7kTqNMiRG6Xt8qz4Q==
X-Received: by 2002:a05:6a20:4322:b0:1a9:d27c:3151 with SMTP id adf61e73a8af0-1afd14746a3mr3092502637.23.1715237030525;
        Wed, 08 May 2024 23:43:50 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-634103f7237sm597394a12.71.2024.05.08.23.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 23:43:50 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.co,
	dianders@google.com,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v1 2/2] HID: i2c-hid: elan: Add ili2900 timing
Date: Thu,  9 May 2024 14:43:36 +0800
Message-Id: <20240509064336.9803-2-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240509064336.9803-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240509064336.9803-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>

ILI2900 requires reset to pull down time greater than 10ms,
so the configuration post_power_delay_ms is 10, and the chipset
initial time is required to be greater than 100ms,
so the post_gpio_reset_on_delay_ms is set to 100.

Signed-off-by: lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>
---
 drivers/hid/i2c-hid/i2c-hid-of-elan.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of-elan.c b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
index 5b91fb106cfc..3073620b2dec 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of-elan.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
@@ -137,10 +137,18 @@ static const struct elan_i2c_hid_chip_data ilitek_ili2901_chip_data = {
 	.main_supply_name = "vcc33",
 };
 
+static const struct elan_i2c_hid_chip_data ilitek_ili2900_chip_data = {
+	.post_power_delay_ms = 10,
+	.post_gpio_reset_on_delay_ms = 100,
+	.hid_descriptor_address = 0x0001,
+	.main_supply_name = NULL,
+};
+
 static const struct of_device_id elan_i2c_hid_of_match[] = {
 	{ .compatible = "elan,ekth6915", .data = &elan_ekth6915_chip_data },
 	{ .compatible = "ilitek,ili9882t", .data = &ilitek_ili9882t_chip_data },
 	{ .compatible = "ilitek,ili2901", .data = &ilitek_ili2901_chip_data },
+	{ .compatible = "ilitek,ili2900", .data = &ilitek_ili2900_chip_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, elan_i2c_hid_of_match);
-- 
2.17.1


