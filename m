Return-Path: <linux-kernel+bounces-178997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6618C5A3F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 282EBB219CA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E2D180A82;
	Tue, 14 May 2024 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FTDdMqdw"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322CB180A67
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715707321; cv=none; b=T80PedGURtWAKextWbRg7/NY32etc9SR5lgiGYVPpz5lGbk1qriarW+nETzdHGzLExtDG+GHrFoX4gyM7udxkNkcSkwOLsnaS3nW/cRx/FmFp9FO14di0g1vL7Jgz1UZFJvYlOpGAny9vtNzjVUCNJ0pwOB7QwFI3fthMn8SlNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715707321; c=relaxed/simple;
	bh=n07cet+ooVwUA0uJv8Y6mZYMPV/YLtLnLn+A9Q0pcWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbtuBWmVnCPJVN4kfteRsHaQXP7uCN3qu7M5Q8lyeMzFPBZ2yRk+3XezwHx2AlL1tHTwYA5cpz4wgv2FQqD7qYx0rvKmMsWmJzDRfwO8N8VwDgI19BrrsJxb9nUjlx8ec8cB9u5ak5iQMxVZa3EhomIGrQvSxTZbQWBneZVEsHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FTDdMqdw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ecddf96313so49981135ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 10:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715707319; x=1716312119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9F2O1ySgZCzUPwkKOIVF7CvO8xaM7qBPiKzCHpLk+3I=;
        b=FTDdMqdwRG2GAsvIQCdjBOnhhp5JebJimK6AprZW65TqGnDSO9QfYtNmhBkG5PhWrg
         u3c+YSI9jSLjYl4m0e35C4UfQIUKvpUdfpTwKQfrJ958Wja82JYHNYTz1LYJq+0KSUh7
         yt3rjFWGz/NoKoSA+MWnUa0dVGcbJQrZS2M5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715707319; x=1716312119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9F2O1ySgZCzUPwkKOIVF7CvO8xaM7qBPiKzCHpLk+3I=;
        b=K57hQ2v7tTgfI7QUuG/ToxM/5MI+43CkapXWcWmpHqtlLav/4M6PAvEDyOz316d9ON
         EwCTVHtAC2mF9SEHjqU+vaZ5AVoRtFeq/qN7oOucxGhdlviBu1YzzpRL8IMDN1ieXF86
         qm1zt7gJsJ3mHW81c/OOgz/IbQgyGlfnp3AF0B+JRIMsAk0wYPgeRmWuz8Itu1Q4lIRs
         Rw74+WIhpBLsWGRkvpYWjxKZABfilzahVSNuyYHdaA7GvX95pGPkSZSo+LcUbZW59//q
         SuPEdvpaidOE/Ziz/RAFq/Vhewqx1FQiaj+YEsRYVf20MB2XH2dUe+/OXF5aoFUG8oT5
         Ilpg==
X-Forwarded-Encrypted: i=1; AJvYcCXH+IxeVhEcwZGTfls8voH7+qIvfgv2RMFJaAWExXlVdEot0mh0aqX7QZyyQnc6zhVMofExCXGb3tNhZcLGyf8dNgbdM+/o8erKQavV
X-Gm-Message-State: AOJu0YwWNaVo1V/YEYyVxX4LbW/JqekjO8zgn9yqSg0uGtRFMgvpAO2W
	af+MXZ3qMYudJmJOQ77NREv1O8pfLQ09TlsKuYG+aa/vxWAIKUxyPHKBH3riQg==
X-Google-Smtp-Source: AGHT+IF5Hi8A8gvBVkU38EIZ/5cpHdnK9nFkHtcNa75rxG8dzS/5sKxvVlEhSFAbLfiuOFv8u7J5hQ==
X-Received: by 2002:a17:902:e808:b0:1eb:4a72:91ff with SMTP id d9443c01a7336-1ef43f4e4c3mr222172195ad.49.1715707319574;
        Tue, 14 May 2024 10:21:59 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:ef10:6fdf:5041:421f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf3101csm100147575ad.121.2024.05.14.10.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 10:21:58 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
	lvzhaoxiong@huaqin.corp-partner.google.com,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Brian Norris <briannorris@chromium.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Joel Selvaraj <jo@jsfamily.in>,
	Hsin-Yi Wang <hsinyi@google.com>,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/9] drm/mipi-dsi: mipi_dsi_*_write functions don't need to ratelimit prints
Date: Tue, 14 May 2024 10:20:53 -0700
Message-ID: <20240514102056.v5.3.I9982cd5d8014de7a4513f5619f66f88da49ce4ec@changeid>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240514172136.1578498-1-dianders@chromium.org>
References: <20240514172136.1578498-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We really don't expect these errors to be printed over and over
again. When a driver hits the error it should bail out. Just use a
normal error print.

This gives a nice space savings for users of these functions:

$ scripts/bloat-o-meter \
  .../before/panel-novatek-nt36672e.ko \
  .../after/panel-novatek-nt36672e.ko
add/remove: 0/1 grow/shrink: 0/1 up/down: 0/-16760 (-16760)
Function                                     old     new   delta
nt36672e_1080x2408_60hz_init               17080   10640   -6440
nt36672e_1080x2408_60hz_init._rs           10320       -  -10320
Total: Before=31815, After=15055, chg -52.68%

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v3)

Changes in v3:
- ("mipi_dsi_*_write functions don't need to ratelimit...") moved earlier.

Changes in v2:
- New

 include/drm/drm_mipi_dsi.h | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index e0f56564bf97..67967be48dbd 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -314,17 +314,16 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
  * @dsi: DSI peripheral device
  * @seq: buffer containing the payload
  */
-#define mipi_dsi_generic_write_seq(dsi, seq...)                                 \
-	do {                                                                    \
-		static const u8 d[] = { seq };                                  \
-		struct device *dev = &dsi->dev;                                 \
-		ssize_t ret;                                                    \
-		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));            \
-		if (ret < 0) {                                                  \
-			dev_err_ratelimited(dev, "transmit data failed: %zd\n", \
-					    ret);                               \
-			return ret;                                             \
-		}                                                               \
+#define mipi_dsi_generic_write_seq(dsi, seq...)                           \
+	do {                                                              \
+		static const u8 d[] = { seq };                            \
+		struct device *dev = &dsi->dev;                           \
+		ssize_t ret;                                              \
+		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));      \
+		if (ret < 0) {                                            \
+			dev_err(dev, "transmit data failed: %zd\n", ret); \
+			return ret;                                       \
+		}                                                         \
 	} while (0)
 
 /**
@@ -340,8 +339,7 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
 		ssize_t ret;                                                \
 		ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));     \
 		if (ret < 0) {                                              \
-			dev_err_ratelimited(                                \
-				dev, "sending command %#02x failed: %zd\n", \
+			dev_err(dev, "sending command %#02x failed: %zd\n", \
 				cmd, ret);                                  \
 			return ret;                                         \
 		}                                                           \
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


