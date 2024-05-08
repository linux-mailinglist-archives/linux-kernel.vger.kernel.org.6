Return-Path: <linux-kernel+bounces-173813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4BD8C05E9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31A701C21E98
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22960131BCE;
	Wed,  8 May 2024 20:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QQDCM1tr"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6988A131749
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 20:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715201598; cv=none; b=MUxW7O0SSpJGU5sN9B86/00/e95Nph9coRKQxIT8Wl7ArQbqHnq/EfGvawFAbvzN1yYHs3TsSemUhRXOYj85xiRkq+8fK7DqcJyfAvF0aWbpNNY8uLJnnX0mwTfYAnat+Z3OPby0k39ffAP6ldiN5lM/vXtAextn27aGQNXZjDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715201598; c=relaxed/simple;
	bh=Upf7UQC2uqkcdoWjEHeP4Zbn1dIJLMIhXusngBn0b44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPxq1TFrkDWf82HEKi77vZ3cxAWjI3cJzLfJziPA+6w67a97m4gtzQ560G2fN1D1JrgHlU8rCRXZQYmsKG7gPDf/3mYXlzi/LMUjcdvKbzacUxVjstMfFppGObLZjRNBGMs3InaG0fvuQw0vhTkVfzYyL2ACpOer7DiTcM3KEeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QQDCM1tr; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2b3646494a8so182961a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 13:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715201595; x=1715806395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Uu6dCXHK9Tlz6RzQlfXaGHd6MvNaaLjZ+6OmZoYDL8=;
        b=QQDCM1trYuisqgtQ+pogvFbCX1CRUKmAIwOoSUyN+/vuShgmpOk3JfHfyB1lBM+5KP
         5BIS0LvT2kd/9O7ZYWjQ8JrlgrWu20kAI3ZvlZPXrvu+ze/PSwOMRZUHrxQnLTFTxFHq
         FjCrew8OmRq//Ofc7PYoWx4kD1Ajjc85sqeGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715201595; x=1715806395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Uu6dCXHK9Tlz6RzQlfXaGHd6MvNaaLjZ+6OmZoYDL8=;
        b=qM/U7C2TSZ7m/nDHYcTo4cfwFPIkQPjm3BLp61pY1SqEvah6IcZ13hZndGi88srW99
         jYUyjNEomQGe4j17xCBkYyTP30w17/shXj1rn++A/vGTgz5TNfI2ALrK2F/+XYMyQrHQ
         BspkAQPxlHOtIEKosvOWt+uUVN+8J5sflJnPctuV6KZecnT+r3M3r70kThdAiVjZXjEI
         S4tIIXMsjDsIO6pmpy9hJYb7QvMjhJWnF20YDLcih/WojEcYl45Mbz5U566Hmw69n5l1
         mr3aUZw+EsbJS6jW+Cv9NDA3Y5quzaJlr98QIFLlwnWcspYhEoS5K5DttcI46KpQhMGU
         +Csw==
X-Forwarded-Encrypted: i=1; AJvYcCWsgD5oynNrBflGp9l8DGUwzwViLjqMEKfHhBT7Q6q5a0VeSGkDiOmvaX1H1jO6LyMz5F5lM+4sWrJX3otMeWHTQGasgq72qydqQi8F
X-Gm-Message-State: AOJu0YzENsMmstej6CDTNniiWSvK3AuQETZ0/pOBKoxYGewRQBNdBS2S
	gGmAlhD4WN9N406akQ6EMp8qklbR/nhgchqTuBJs4nXgjPe3IH8vu6iiiPgk5w==
X-Google-Smtp-Source: AGHT+IGM10kfCU9PJbF6g09K3gqT+mWhajj+UxNJ1qHGBNNy3dM43AM4NZqN37FUm4SOCw5YgXlQbw==
X-Received: by 2002:a17:90b:1207:b0:2a4:833f:2c1b with SMTP id 98e67ed59e1d1-2b61639cb22mr4194425a91.9.1715201595621;
        Wed, 08 May 2024 13:53:15 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:40f4:feca:59e0:d3ca])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67126ad51sm6887a91.25.2024.05.08.13.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 13:53:15 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: lvzhaoxiong@huaqin.corp-partner.google.com,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Hsin-Yi Wang <hsinyi@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Joel Selvaraj <jo@jsfamily.in>,
	Brian Norris <briannorris@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/9] drm/mipi-dsi: Fix theoretical int overflow in mipi_dsi_dcs_write_seq()
Date: Wed,  8 May 2024 13:51:43 -0700
Message-ID: <20240508135148.v4.1.I30fa4c8348ea316c886ef8a522a52fed617f930d@changeid>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240508205222.2251854-1-dianders@chromium.org>
References: <20240508205222.2251854-1-dianders@chromium.org>
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


