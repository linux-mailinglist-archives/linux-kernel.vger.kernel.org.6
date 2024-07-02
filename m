Return-Path: <linux-kernel+bounces-237803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4EA923E59
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A10861F22D5E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370E4185E42;
	Tue,  2 Jul 2024 13:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="T4lOlGv1"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B3917C7BA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719925341; cv=none; b=D9g01VbHfTgyI66JufVPLjUjZngiUWPNkrWN58/qyk5WLyLYrm6PfD7J/wop6pkY+dx0wnYnUh31FpGqQiSezezWXCU/Fh7Pb1K2MaRICb5+ez0R0Np+MghnD0LhWjQAD8hyjnqoDQCo+rfUBdcoQFwbcXz1DZYTABOiLkzvdSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719925341; c=relaxed/simple;
	bh=DAdIZvwEiKtAVExhHqOKj9IXsq6dgQuoMJr3y7yZ/eE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oqVozXszTN1YdfNA1XxG4qzpsxW2DzKXWHhxhhaQvmhcpg6748xSWFwFjnD4hXdDJYcpuU9rKOJrJT9xXQ1miAlF3r0PydFcnQzr+ANG/Vc7jMDF+5U+yhEgFQ1pfhSwI32feZ3o5enep/lRbrm6wjJOkPzIm01A/GeLVFWkCoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=T4lOlGv1; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-706b539fcaeso3695499b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 06:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1719925337; x=1720530137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiCsbkDl++ofERmfipEXieQ2TEHJHpnCgluA4Du+09M=;
        b=T4lOlGv18Zq+oWiMgIKc1bLbFqnE1P+JWQQT5xttYNdVwiYAZcPGDvbu8y6OXf1UJi
         mjR/v+EpGufxSdSKuZQ8oGWiMPTCf53PEooKEO7ROvzky8IcHzjAAJkG+HMUhh7Zug7l
         fBYgWAy++hc/XX10+0n5xpJ6Fr0smMqbe7/FTzSGc2grkoqMugZl62U9c7MDYERUKdgS
         8oqdvmZRMgWiDSZgkVlKC9xg3MNY6LvGG5xkd/4b7IpocnTpr8sT7EBKWHaLMNZG8LU8
         L0U93iOd+FA4/fgRBK6kTdVewCBMdohrUabutv1etFQPWlpIhMN7ECOgDvX67Y5gatSA
         iueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719925337; x=1720530137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiCsbkDl++ofERmfipEXieQ2TEHJHpnCgluA4Du+09M=;
        b=rY8NQgz2TtKsILxhGFSRdjaQunvDJDztoFkYFpn+jICdtN/uwyedSegmq/OzLrlf+9
         aBvO5wO16BLMLtnQLuR1gsedAHPkWQgQ/WuZ8QYoaroKQVV27TLPMbrJmXpdQDWZWkf5
         Su8mhePO1nq9rLQOrb8G89aF6aSsxUktcoRGvIXcyTNtijRjw90TPdribALJ9sSlMWBE
         B2pznCq3xyPw/zgCEQ2Q0FPPM8XpQT0AeY2ZC8xrJTn9vwvrKa4T4V8Wvu0N+MptFGUO
         YJwPtvU0JKldi6hdjNCaqNCQXW/voYbLr771GihuSCTJmAaNtE/ca5HadK3Ce+tLC0qS
         k+gQ==
X-Forwarded-Encrypted: i=1; AJvYcCV78Irb4FwVheHeM8RqIZfkSsBwotLoi4gSCitA8R6/ENggmTItioQI2FWeDHBjaHto21Uq7NhpVRfuBFbTorjJ+kHHgN6MCKkZhpzy
X-Gm-Message-State: AOJu0YxxgLk1ArGMyWoBXBSx4mzCurlWmGDP8UDYmGn2fC69Lq1Ti4v/
	kqvdYW8pb+nvuk7aVOai3rn4wN7UmT+5EEKmzS3ZTS4uQxu+FY24LVgI7dOFLaU=
X-Google-Smtp-Source: AGHT+IHH3JhogvrhCgD2ca9wrj6+3t0HRKDtiF2sqIxu2j9I6BLcLP/vJMQkUJkewdqnp8fehSA7lA==
X-Received: by 2002:a05:6a20:1b10:b0:1bd:2c3d:ccae with SMTP id adf61e73a8af0-1bef62672d5mr10421681637.29.1719925335331;
        Tue, 02 Jul 2024 06:02:15 -0700 (PDT)
Received: from yc.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6c8ec50csm6233111a12.59.2024.07.02.06.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 06:02:14 -0700 (PDT)
From: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To: sam@ravnborg.org,
	neil.armstrong@linaro.org,
	daniel@ffwll.ch,
	dianders@chromium.org,
	linus.walleij@linaro.org,
	swboyd@chromium.org,
	airlied@gmail.com,
	dmitry.baryshkov@linaro.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org
Cc: lvzhaoxiong@huaqin.corp-partner.google.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v1 2/2] drm/panel: jd9365da: Support for Melfas lmfbx101117480 MIPI-DSI panel
Date: Tue,  2 Jul 2024 21:01:38 +0800
Message-Id: <20240702130138.2543711-3-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240702130138.2543711-1-yangcong5@huaqin.corp-partner.google.com>
References: <20240702130138.2543711-1-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Melfas lmfbx101117480 is a 10.1" WXGA TFT-LCD panel, use jd9365da
controller, which fits in nicely with the existing panel-jadard-jd9365da-h3
driver. Hence, we add a new compatible with panel specific config.

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
 .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 246 ++++++++++++++++++
 1 file changed, 246 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index c6b669866fed..5b525a111b90 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -850,6 +850,248 @@ static const struct jadard_panel_desc kingdisplay_kd101ne3_40ti_desc = {
 	.enter_sleep_to_reset_down_delay_ms = 100,
 };
 
+static int melfas_lmfbx101117480_init_cmds(struct jadard *jadard)
+{
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
+
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe1, 0x93);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe2, 0x65);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe3, 0xf8);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x74);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0xbf);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0xbf);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1f, 0x70);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x20, 0x2d);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x21, 0x2d);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x22, 0x7e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0xfe);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x19);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x12);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x78);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3e, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0x7f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0xa0);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x74);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x56, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x8e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5a, 0x2e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x1a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5c, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x7f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x69);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x59);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x4e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x4c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x30);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x4a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x4a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x68);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x57);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x5b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x4e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x24);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x12);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x7f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x69);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x59);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x4e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x4c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x30);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x4a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0x4a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7b, 0x68);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7c, 0x57);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x5b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0x4e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7f, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x24);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x12);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x82, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x52);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x55);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0x55);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x50);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x77);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x05, 0x57);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x06, 0x55);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x07, 0x4e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x08, 0x4c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0a, 0x4a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0b, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x55);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0d, 0x46);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0f, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x10, 0x55);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x11, 0x55);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x12, 0x55);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x13, 0x55);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x14, 0x55);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x15, 0x55);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x16, 0x53);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x55);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0x55);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x51);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x77);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0x57);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x55);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1d, 0x4f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1e, 0x4d);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1f, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x20, 0x4b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x21, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x22, 0x55);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x23, 0x47);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x25, 0x41);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x26, 0x55);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x27, 0x55);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x28, 0x55);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x29, 0x55);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2a, 0x55);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2b, 0x55);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2c, 0x13);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2d, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2e, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2f, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x30, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x31, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x32, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x33, 0x0d);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x34, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x36, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3b, 0x11);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3e, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0x12);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x46, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x47, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x48, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x49, 0x0c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4a, 0x0e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4b, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4c, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4d, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4e, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4f, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x50, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x51, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x52, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x53, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x54, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x56, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5c, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x6c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x6c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x75);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0xb4);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x6c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x6c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x0c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x88);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0xbb);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x2a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0x23);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x11);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x36, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2b, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2e, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe6, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe7, 0x06);
+
+	return dsi_ctx.accum_err;
+};
+
+static const struct jadard_panel_desc melfas_lmfbx101117480_desc = {
+	.mode = {
+		.clock		= (800 + 24 + 24 + 24) * (1280 + 30 + 4 + 8) * 60 / 1000,
+
+		.hdisplay	= 800,
+		.hsync_start	= 800 + 24,
+		.hsync_end	= 800 + 24 + 24,
+		.htotal		= 800 + 24 + 24 + 24,
+
+		.vdisplay	= 1280,
+		.vsync_start	= 1280 + 30,
+		.vsync_end	= 1280 + 30 + 4,
+		.vtotal		= 1280 + 30 + 4 + 8,
+
+		.width_mm	= 135,
+		.height_mm	= 216,
+		.type		= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+	},
+	.lanes = 4,
+	.format = MIPI_DSI_FMT_RGB888,
+	.init = melfas_lmfbx101117480_init_cmds,
+	.lp11_before_reset = true,
+	.reset_before_power_off_vcioo = true,
+	.vcioo_to_lp11_delay_ms = 5,
+	.lp11_to_reset_delay_ms = 10,
+	.exit_sleep_to_display_on_delay_ms = 120,
+	.display_on_delay_ms = 20,
+	.backlight_off_to_display_off_delay_ms = 100,
+	.display_off_to_enter_sleep_delay_ms = 50,
+	.enter_sleep_to_reset_down_delay_ms = 100,
+};
+
 static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
 {
 	struct device *dev = &dsi->dev;
@@ -926,6 +1168,10 @@ static const struct of_device_id jadard_of_match[] = {
 		.compatible = "kingdisplay,kd101ne3-40ti",
 		.data = &kingdisplay_kd101ne3_40ti_desc
 	},
+	{
+		.compatible = "melfas,lmfbx101117480",
+		.data = &melfas_lmfbx101117480_desc
+	},
 	{
 		.compatible = "radxa,display-10hd-ad001",
 		.data = &cz101b4001_desc
-- 
2.25.1


