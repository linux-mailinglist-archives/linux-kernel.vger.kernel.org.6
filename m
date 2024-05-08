Return-Path: <linux-kernel+bounces-173815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 046CE8C05EF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADEC52845DF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D24B1327F5;
	Wed,  8 May 2024 20:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iiHu3Awk"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11507131E59
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 20:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715201602; cv=none; b=Y4M5IbxDDdisCvNCSrHcOshtFvRhhJodAkPwrucv0OKZSyZ17eI1JEociOzRudIq4ZSIfUnQ4JGQjhuPpMQHls9lpR+y5MV+TKpvOARmrCYvnF49XhIxu/tYCYP6XnVl1s56FLVfNIKbshBpH8QuQnCFlVPmiCM/kUsX/87lszE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715201602; c=relaxed/simple;
	bh=n07cet+ooVwUA0uJv8Y6mZYMPV/YLtLnLn+A9Q0pcWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEX1j/olrUhvuSwhVY7KeYOjnrZaZONETs/OQ20RxcRYKlFvxO0y4uPl3aNtlY5BSGwLhL5Y4INwCQo8MDxVdJm2vCi4/8OiUpufKu79SMxtmpHKWLFe5UZtCXoEN0mXasjV0MY7JNw8+v99ynlkwFTXqIvHopJGd0501kgbOBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iiHu3Awk; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2b36232fa48so184516a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 13:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715201600; x=1715806400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9F2O1ySgZCzUPwkKOIVF7CvO8xaM7qBPiKzCHpLk+3I=;
        b=iiHu3AwkwX7oFstR9fwxoUwpGamOnj0/zLDghVnKQvvW9DbSuDEJ9HQJ5artVfoJsR
         iKDccXNbh6WIK/DidZvhmpUgHmnCg27Mmvlmhoi3lF/5DkxCRd3/mh+daYd6lgyvYXpn
         /IeOqbNlEkQM/Z5hrw7n+PQtAH18IQA06K25g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715201600; x=1715806400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9F2O1ySgZCzUPwkKOIVF7CvO8xaM7qBPiKzCHpLk+3I=;
        b=EEcxeIIfu4NS744ay7iY5w6+EC1kHZQim+ChTcHSZ3Q2vWpz4MusXEfNkUG43mOwoX
         gcIy+lT4RU4bOp0mHhBEUXBFFYMuZcIrZKpc25tJFhwE1TLAvGUno+9q1sPfM0mHoMS7
         WeXKfhoe1WR/+2Ch/oHlXH9mLxfVKWx4N79T3J/qhVVzxCffPf9VZhaAFE6qSYWibtex
         BNaPnVraQd9qKzLdH1Dl7Z9CM/3PW+zOkYQHQ1P4CpXykD/L/DC/cypFHw5/dc4DFVoi
         kvPP0eQk4MwcL04yhTUxswc3c87riBDrCVPw5MQFa4sV9NtrXUr5t/mXYnhbt9jcM7aG
         DJUA==
X-Forwarded-Encrypted: i=1; AJvYcCU/k1OCoAdEd/wOGOmvOWZ2N8n3KSb/A030acLzJep+aaUjMEkv+nk0mQj6gGTkLJGZgt4PX+8BbjtJKfD5P2dPd4IAYL+0DMSHXiCS
X-Gm-Message-State: AOJu0YzeAPlzmX5svaUhtW2Ry4y6GhkE/GSNNyLHCquoxhSLKUFuom9G
	yDGNbXi/lrmzWFmTs1GYXefMV3UMu/EP6+0VhVMHsoMmFFzS6ylJIGFJW5H3/g==
X-Google-Smtp-Source: AGHT+IHcvmXqDVJ/bC9j+Qc7/hlGGXc3bJX7RxOprm6cXhjNiCfIYQ8UUIU69gAVZPyxLM1azYo0gw==
X-Received: by 2002:a17:90b:212:b0:2b3:28be:df00 with SMTP id 98e67ed59e1d1-2b61649c518mr3600358a91.4.1715201600424;
        Wed, 08 May 2024 13:53:20 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:40f4:feca:59e0:d3ca])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67126ad51sm6887a91.25.2024.05.08.13.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 13:53:19 -0700 (PDT)
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
Subject: [PATCH v4 3/9] drm/mipi-dsi: mipi_dsi_*_write functions don't need to ratelimit prints
Date: Wed,  8 May 2024 13:51:45 -0700
Message-ID: <20240508135148.v4.3.I9982cd5d8014de7a4513f5619f66f88da49ce4ec@changeid>
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


