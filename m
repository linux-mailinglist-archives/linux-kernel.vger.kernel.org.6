Return-Path: <linux-kernel+bounces-178996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A1E8C5A3E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98EC5B22575
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1978E180A64;
	Tue, 14 May 2024 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gkcWa4c5"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23921802C1
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715707319; cv=none; b=pKuDpM39c4fZCel+sWOnM7KuxarNPlp4wtyzlxQxTjyh9pOpjplqCdn93Ev6j/2F4sBDOL1YzZOpoWzc4tOPhs34gMK932PjHNNTLfqxPmmzD0b5WMR4ZZfFB14Js5YOayWSELXTthzMARacDLbnSRAZ+4wulMqPh7v9KJYJfTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715707319; c=relaxed/simple;
	bh=x2/OnYIYkyXnQCQ5vX3XkS/1O36D1J7pW0EOFe5QTpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7BpR/Zxrqlotu8TWSRefRePy5Dn2Rug50QBEuh6GpumjYvEnr4GCu49+1ySigTqSV7agy2Is+k3mO4BNwEc2jX50qklTUyt4OgMgJ1RZo/LgM3ELCvwEelDTilS9kiRchiyKYW7BMq6c2nqny9IbW57j1sXCAbVVuj4fcrR64Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gkcWa4c5; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1eb24e3a2d9so51471765ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 10:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715707317; x=1716312117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+Or8KqEsgChQkx7PQCuukTAwNzg+3SO5efP38g6ozU=;
        b=gkcWa4c52zRXRcXf0HmAeco5rS2Xw0JsyFDI8P2Bp25iPNSWreY3GZsRbOQvjoE1f3
         K3JHJnr1ygq/ulA0UR774/cZttqG1wPgwLkniq8k0AtcJFE3Qr+vIk4BD2xMO9FEAQTJ
         ApvifE6/HsH21vZXmgmEamKi8qkx8FAiZ+vfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715707317; x=1716312117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+Or8KqEsgChQkx7PQCuukTAwNzg+3SO5efP38g6ozU=;
        b=Wcq25xyO0Yec0St2qUhSlD+4L1Oy0SM8aJRcvJenhQsIWjKbuQwkV1cLNrZJiuzhQB
         4/c4SAdNRTcy+UUTa/GfTTaSVqmLDgvCUn4KOc49hO6UJdeWh1j8oyvh1DO30Vyzj7Wr
         jL0PIq8NyS3+weAQunRr6rup88jHLjBLSKufoh524+huF4WzMgzQRntUQScKDgtYVVX9
         w8+ROT5D7V4FO7j7GF/IyZ4+22TW3dp3/6tkYprD16UO5on3VPZZdMT0su2hKRhWsxDt
         uY5DZoxJHoX7sEHe4lQuk4kMtGwgVxH9mxvj1QGVXUk2e/akdzrkyiRKUw6i2G9hR8Ru
         qm5g==
X-Forwarded-Encrypted: i=1; AJvYcCVlKYwYTgoYitJlkC7VdxECvz+XzHoMU8mg1Dq1qxVugCT4DlnOCP5n+hoq0uuY+NxEGRlZuI8+WHw/extf8/P9zWQRFigUl44DUSUA
X-Gm-Message-State: AOJu0YzElnaItHDKkfQlJ/OhCQuobdlMWwOVTpoCt7KqLceF6tu+j5RG
	6cbMI8biAigCn6A4KKGhx0yS84aNW8APu1cJV4tFI96v9I4fZ1LPSpqIQyMNkQ==
X-Google-Smtp-Source: AGHT+IE5+z/vnNxyc7q5T1nnaWe7eAZU+7yxjqVeuIT+BTUFK8rCGVprvdfaAHD303EVUueR7yCNug==
X-Received: by 2002:a17:902:6542:b0:1eb:1240:1aea with SMTP id d9443c01a7336-1ef43d12749mr155731325ad.20.1715707317226;
        Tue, 14 May 2024 10:21:57 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:ef10:6fdf:5041:421f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf3101csm100147575ad.121.2024.05.14.10.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 10:21:56 -0700 (PDT)
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
Subject: [PATCH v5 2/9] drm/mipi-dsi: Fix theoretical int overflow in mipi_dsi_generic_write_seq()
Date: Tue, 14 May 2024 10:20:52 -0700
Message-ID: <20240514102056.v5.2.Iadb65b8add19ed3ae3ed6425011beb97e380a912@changeid>
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

The mipi_dsi_generic_write_seq() macro makes a call to
mipi_dsi_generic_write() which returns a type ssize_t. The macro then
stores it in an int and checks to see if it's negative. This could
theoretically be a problem if "ssize_t" is larger than "int".

To see the issue, imagine that "ssize_t" is 32-bits and "int" is
16-bits, you could see a problem if there was some code out there that
looked like:

  mipi_dsi_generic_write_seq(dsi, <32768 bytes as arguments>);

..since we'd get back that 32768 bytes were transferred and 32768
stored in a 16-bit int would look negative.

Though there are no callsites where we'd actually hit this (even if
"int" was only 16-bit), it's cleaner to make the types match so let's
fix it.

Fixes: a9015ce59320 ("drm/mipi-dsi: Add a mipi_dsi_dcs_write_seq() macro")
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v3)

Changes in v3:
- Use %zd in print instead of casting errors to int.

Changes in v2:
- New

 include/drm/drm_mipi_dsi.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 70ce0b8cbc68..e0f56564bf97 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -314,17 +314,17 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
  * @dsi: DSI peripheral device
  * @seq: buffer containing the payload
  */
-#define mipi_dsi_generic_write_seq(dsi, seq...)                                \
-	do {                                                                   \
-		static const u8 d[] = { seq };                                 \
-		struct device *dev = &dsi->dev;                                \
-		int ret;                                                       \
-		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));           \
-		if (ret < 0) {                                                 \
-			dev_err_ratelimited(dev, "transmit data failed: %d\n", \
-					    ret);                              \
-			return ret;                                            \
-		}                                                              \
+#define mipi_dsi_generic_write_seq(dsi, seq...)                                 \
+	do {                                                                    \
+		static const u8 d[] = { seq };                                  \
+		struct device *dev = &dsi->dev;                                 \
+		ssize_t ret;                                                    \
+		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));            \
+		if (ret < 0) {                                                  \
+			dev_err_ratelimited(dev, "transmit data failed: %zd\n", \
+					    ret);                               \
+			return ret;                                             \
+		}                                                               \
 	} while (0)
 
 /**
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


