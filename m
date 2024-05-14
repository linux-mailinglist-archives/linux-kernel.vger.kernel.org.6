Return-Path: <linux-kernel+bounces-178995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E4C8C5A39
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0F43B220EC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0569D1802C4;
	Tue, 14 May 2024 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FOSH4oIm"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D798C17F39E
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715707317; cv=none; b=ss6ou0rL0NBIzYrzR1WFhaDfJLBH8+gKPWm2Qvtdd9IPNxY5RloU4FKJyXni3mfB83jIO0KhCwa2HT9FG9hdWxEwvue3zQGTWDxLz+XayMSFLmXdMxyMlZnF8lT/RSbfsrkp0K6sxEUKFB2BBgWMEoKG4smeWjI0AqXx77XH8jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715707317; c=relaxed/simple;
	bh=Upf7UQC2uqkcdoWjEHeP4Zbn1dIJLMIhXusngBn0b44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhQ2T4NStk7tn9nsaV1/5B67fv9EOEAX6GP0tlaJv4s8t6SIQRJcwaujwkfF5GTlFF8Zl/oioENrbJ73pKtJ9xJCOcH6fpwiAOsb7ieYxdQOL0fs4U2cJiZ71RE180SOmLsfJ3YgeFzCZJq+Rm/OTUd/5JgD4Dl7GFG/OotU8t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FOSH4oIm; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ee42b97b32so47643875ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 10:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715707315; x=1716312115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Uu6dCXHK9Tlz6RzQlfXaGHd6MvNaaLjZ+6OmZoYDL8=;
        b=FOSH4oImgjw/WOIhYImu6E3lhctMpmDOtENZPKRsGTB+qcuLxJOxsrLDKYXcQdzCQl
         8izyOvxFH9AAtc+cup+443jqvxqpLlOE78mj+t4jF7OI+laOGd8V+lIbCkHanelY/Lpp
         Vb9mfPWyzYq9MDTLUL9VV01IirJQm2g6ftLRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715707315; x=1716312115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Uu6dCXHK9Tlz6RzQlfXaGHd6MvNaaLjZ+6OmZoYDL8=;
        b=KE/4lImZYfFRZvhSqwVpNyMmZi9G+lLX2wwUtzEQz0dZpoPSBEt3OuxEnQEUwd1+uw
         0JcedrOrpaNP3noO2UFg5w65KDtbLDHDUkQ6GE5ebt5ThExrl1nsISTSTYeuQB4gVyIS
         OwGiEF7+29+BdrsChVtjNe30HKZY/c8/OrXaRAlktXATDQ8I2DaLAIOphc6sRBYHjjt9
         wgIW6pQwIiiw3mDP0SfsMtudm8gL9Nc8tFcEuuXIjOkoi0hWsm++Jwwe1hkfHjz/du4S
         jDLM1ouKa//EcqWv6T8VMXjZQwf48ISgOde82GxhITTsWYETRs3vb1sq02+IfbYUOxqt
         iVSw==
X-Forwarded-Encrypted: i=1; AJvYcCUqIdwxiGqKv4fjU9cF0dCR9lbeLm91p1KvQjOozsIFniE5gOJpQLMN1pPA7m9EzqqAGbjeSGZQ9G+vEntufuDLCdN6K6HsOaBUpRtO
X-Gm-Message-State: AOJu0YwnOkAPlKw3Mf6Slx4Dd8AOET6+zeRrUBlRmoWUpuzFkvDVakCt
	kVMs7z5P1CHWQ79io67uCctnfVb6I9lgfiwtLmW0XbjBwkS2Pr2o2RS58hjrWQ==
X-Google-Smtp-Source: AGHT+IGjeyNjIsqx/qIdTeqiOr7chjKO4qVOUsbjOG2rvGAEFIqKBZ+MLM5yAX47d9CWwJWEw+PbHg==
X-Received: by 2002:a17:902:da8c:b0:1ee:b35e:963f with SMTP id d9443c01a7336-1ef43d18cb3mr161152385ad.26.1715707315153;
        Tue, 14 May 2024 10:21:55 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:ef10:6fdf:5041:421f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf3101csm100147575ad.121.2024.05.14.10.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 10:21:54 -0700 (PDT)
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
Subject: [PATCH v5 1/9] drm/mipi-dsi: Fix theoretical int overflow in mipi_dsi_dcs_write_seq()
Date: Tue, 14 May 2024 10:20:51 -0700
Message-ID: <20240514102056.v5.1.I30fa4c8348ea316c886ef8a522a52fed617f930d@changeid>
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

The mipi_dsi_dcs_write_seq() macro makes a call to
mipi_dsi_dcs_write_buffer() which returns a type ssize_t. The macro
then stores it in an int and checks to see if it's negative. This
could theoretically be a problem if "ssize_t" is larger than "int".

To see the issue, imagine that "ssize_t" is 32-bits and "int" is
16-bits, you could see a problem if there was some code out there that
looked like:

  mipi_dsi_dcs_write_seq(dsi, cmd, <32767 bytes as arguments>);

..since we'd get back that 32768 bytes were transferred and 32768
stored in a 16-bit int would look negative.

Though there are no callsites where we'd actually hit this (even if
"int" was only 16-bit), it's cleaner to make the types match so let's
fix it.

Fixes: 2a9e9daf7523 ("drm/mipi-dsi: Introduce mipi_dsi_dcs_write_seq macro")
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v3)

Changes in v3:
- Use %zd in print instead of casting errors to int.

Changes in v2:
- New

 include/drm/drm_mipi_dsi.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 82b1cc434ea3..70ce0b8cbc68 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -333,18 +333,18 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
  * @cmd: Command
  * @seq: buffer containing data to be transmitted
  */
-#define mipi_dsi_dcs_write_seq(dsi, cmd, seq...)                           \
-	do {                                                               \
-		static const u8 d[] = { cmd, seq };                        \
-		struct device *dev = &dsi->dev;                            \
-		int ret;                                                   \
-		ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));    \
-		if (ret < 0) {                                             \
-			dev_err_ratelimited(                               \
-				dev, "sending command %#02x failed: %d\n", \
-				cmd, ret);                                 \
-			return ret;                                        \
-		}                                                          \
+#define mipi_dsi_dcs_write_seq(dsi, cmd, seq...)                            \
+	do {                                                                \
+		static const u8 d[] = { cmd, seq };                         \
+		struct device *dev = &dsi->dev;                             \
+		ssize_t ret;                                                \
+		ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));     \
+		if (ret < 0) {                                              \
+			dev_err_ratelimited(                                \
+				dev, "sending command %#02x failed: %zd\n", \
+				cmd, ret);                                  \
+			return ret;                                         \
+		}                                                           \
 	} while (0)
 
 /**
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


