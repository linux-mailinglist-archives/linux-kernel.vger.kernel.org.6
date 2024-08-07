Return-Path: <linux-kernel+bounces-277708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 068C894A50A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29ACC1C20BFC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AB01D3653;
	Wed,  7 Aug 2024 10:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="CLeazjuC"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299181D2F7E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 10:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723025093; cv=none; b=Qsx5VLR14vhXBAS8R2V0XOBSxeZpVXaXEpE11wRZSx2EmfEUVZrBajj22TJWzGTjYN6bMxFj4EtpDBD3F1XFpL2V+BgQeWsCbuFAX483INUtmzyW1O+3UoYPEI7l5cQlebaxBhol4fIQBCVOMjd0gBX5jX7JZqLv+o7ODbNzC04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723025093; c=relaxed/simple;
	bh=+SO+kewOFTcQn2nqM40ixWdKUUYwpfn7ClOeFBE6OMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jewgxGqBHJGny1TqUcUN9NWQguZheDzaXrju4gNH8ir6dymhz7bAdddX8qIUtq7JGPpRdMuzF7gxSofMsVpC3bvTQAWzq5Rv35IT0Gq2i8/b8p2orTqajNGjiRGI8v4jvYQpecLuJafB7NL5ydEezXta/Qp1qT/altFb4qe904o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=CLeazjuC; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d19d768c2so1214822b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 03:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1723025089; x=1723629889; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G8sD5tWPojbSoMGIcSaH0qeF9w3YLQb1BQMuSnaj9rk=;
        b=CLeazjuClPFzszG7xZW25KllNYqeXJ3vkZLTdRXegQbMjpJ/lyMj1jM9QZNuIbN8IY
         MmKh2DsaCwSobceokLSqWJVxMf+KlZ9ppxey0olyZnjTeI99Ao+zFcEVzXdmhFHJv5/s
         NS6lylylYEgrmDYPZ5Rb3ehVgRUHDHFfxX+gZrE2or98LU3DvQqAUhSPIm1luBL6nYqW
         wQXcC2U2YlpqzzAxkCX79ig5ZRRAKqyNuMSWSEDO/1yxBhDXgjDm5PKzcw5G8wYL9zG5
         Uhwo4ZPyh42FTmYcIdF2ePHP1el4hurbgk0kaRTO7g7tsobi8MrCJJWAoNegHYlmrhXg
         oQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723025089; x=1723629889;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G8sD5tWPojbSoMGIcSaH0qeF9w3YLQb1BQMuSnaj9rk=;
        b=QSll+zdeWDQ5uFvk715WXp6V9jKWmYjSpESPbTvSsp8XF4p1FodKrcRJpJefluQCLy
         g3WB9fxZi7NwloEvnnuu7MIzqhDGilQHvFy+0D5Nh6V6KbrBQzhj3je4QnmSzkK7kfG3
         TEr83vLoKzHa/FTK9UCv0GxCJE2vNgsgVBOf+5Dv/A+q0Fb0Jo0IonHQECXWdnBlPfLo
         Kncimx3A3qV37K+U614Zg3GSCWK8iGPyqJi19F0h1/976x8TniZwQPkVnNV1LTbbhEDp
         nYChlcbiY4bh9mb+W0eGYn0YJ6jZBGSFQcZ3tBoy+dsedu+Fuhry2YL0/udIS1l0CW8X
         V/2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmCURNAqh3nOx7g7EDZs36V7KAqw7wIZa+bKU9ez1UF3e4TKJSGOq6WvbnRq3UDwwffQeWF3kMWAuQobzqgT7DMBmmNaMtXKFZtFS6
X-Gm-Message-State: AOJu0YzvQRZViIVzfyP+WOBVMEvcHgtKj1mWDfdApUCojOTMJhNZVzQu
	r53O/H81GEC/k6LfV8jvxYZBdHy2qLQ8frBfCqdqFmdBnTvCJqmz4H88hPPRVBA=
X-Google-Smtp-Source: AGHT+IELjUmVEpYVv5wdEeeHbgamYsaeKFOxsCWc01Nmqe8Yl8RaZRDYduWqqEPdR0Xpy6I1WQodnQ==
X-Received: by 2002:a05:6a20:258e:b0:1c4:ae14:4e3d with SMTP id adf61e73a8af0-1c6995809d9mr21497125637.13.1723025089264;
        Wed, 07 Aug 2024 03:04:49 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecdff89sm8119248b3a.103.2024.08.07.03.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 03:04:48 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	dianders@chromium.org,
	hsinyi@google.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	jagan@edgeble.ai,
	dmitry.baryshkov@linaro.org,
	jani.nikula@linux.intel.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v3 2/2] drm/panel: jd9365da: Modify the init code of Melfas
Date: Wed,  7 Aug 2024 18:04:29 +0800
Message-Id: <20240807100429.13260-3-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240807100429.13260-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240807100429.13260-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Modify the Melfas panel init code to satisfy the gamma
value of 2.2

Acked-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---
Changes between V3 and V2:
-  1. No changed.
v2: https://lore.kernel.org/all/20240806034015.11884-3-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V2 and V1:
-  1. No changed.
v1: https://lore.kernel.org/all/20240725083245.12253-3-lvzhaoxiong@huaqin.corp-partner.google.com/
---
 .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 78 +++++++++----------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index ce73e8cb1db5..44897e5218a6 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -873,22 +873,22 @@ static int melfas_lmfbx101117480_init_cmds(struct jadard *jadard)
 	jd9365da_switch_page(&dsi_ctx, 0x01);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x74);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0xbf);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0xd7);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x01);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0xbf);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0xd7);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x01);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1f, 0x70);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x20, 0x2d);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x21, 0x2d);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x22, 0x7e);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0xfe);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0xfd);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x19);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x28);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x05);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x08);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x12);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x78);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x7e);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0xff);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3e, 0xff);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0x7f);
@@ -899,47 +899,47 @@ static int melfas_lmfbx101117480_init_cmds(struct jadard *jadard)
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x74);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x02);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x56, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x8e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x6a);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x09);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x0a);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5a, 0x2e);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x1a);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5c, 0x15);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x7f);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x69);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x59);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x4e);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x4c);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x40);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x45);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x30);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x4a);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x49);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x4a);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x68);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x57);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x5b);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x4e);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x73);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x56);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x38);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x36);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x2f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x19);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x32);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x31);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x31);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x4f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x3e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x47);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x36);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x31);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x24);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x12);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x02);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x7f);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x69);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x59);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x4e);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x4c);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x40);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x45);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x30);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x4a);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x49);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0x4a);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7b, 0x68);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7c, 0x57);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x5b);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0x4e);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7f, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x73);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x56);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x38);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x36);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x2f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x19);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x32);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x31);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0x31);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7b, 0x4f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7c, 0x3e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x47);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0x36);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7f, 0x31);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x24);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x12);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x82, 0x02);
-- 
2.17.1


