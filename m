Return-Path: <linux-kernel+bounces-515423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 575DAA3649D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29461188E4F4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8A6268C5D;
	Fri, 14 Feb 2025 17:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6k5sNlv"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608CB2686BC
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554230; cv=none; b=TPzm/BYrVwVfdMX8bSZlkiiyCsnS1ZtgKjeQ6cqJHFsSBMHLsvJmwkV1THPA0NssQ40ANqIZh3g0/2gdvXcySEFhVN3/+jAjJ3v6kYMHpBQN2QO/qxabgubSHlXdISsESQl4zD9SmgmXF2/AaljNDWf9NFGZHP4tPagj6RSyWwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554230; c=relaxed/simple;
	bh=arxPZo9xksFrI9j5jjf+YMntp3CmW0UM/dlz9WQGzPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N52wxNx1HGmRY7fJxxQQvln1cq+k2btpSRugyF2jgioM7+mJ/uYSjpRQQaikniLcW9fWaiNRYUWNatyWF2Cdb0/0JE0uxLGewqVTRVpDsPf8fi/v+GlczCvlESiHhvcsWrwc5bVTH8ZrL6YnRXSatTkXd4saz+cVs4engp0HYiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6k5sNlv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f5660c2fdso48642215ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739554228; x=1740159028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJYNUML0MGQT9wXkxrbGgMrZtvn5S8KShebTQWoG8yw=;
        b=I6k5sNlvSWIiMoj8UeMAwIvEVCBhRFYCFUfj9o4Yk+zODqLA7Zjy+8G9a8SyYoSSAl
         AX/8O2yYjJy8aki3R2pRlrdzu6kmLog9GdywWMq16ZM37ousgtUdjRH4xET0SBIOXWsh
         mdbSeTGOeFYxiIv+J38aN3Kgggqi5FIp+WZvSisyPnkDKA/5D3aIHexuhM07hppg9gID
         SJJIRGwDQ3Ug4FJ3Rh0VL/mLBPFvXeEYhr6VW92bzbTIAglQku6mkT3k0KXssd7evAnu
         ayd2Mt38k9H8gBYqASS5YOIB36rSi89wDoUd8gh6fQStIfVAHff9ziM/k38yqpLM33oo
         XuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739554228; x=1740159028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJYNUML0MGQT9wXkxrbGgMrZtvn5S8KShebTQWoG8yw=;
        b=l1Ko/apsesPGH+CJ1olAzn45m7apQT+67iKDHa94SEhCHrLXaKCSOD9RvrYsYJ+oqt
         PEe3Ys7XTe9BgM5xoXEiJTKwMPwnbgaSewJsaxMoCGVGHgS9ogCJxs8Oa3OmL+ONU9HA
         ez6gtYsjvNcMqZyG0ZgG0zE/TQ8T5Y0rEbm+eCrya3o3It6umiAX6A1QeraRdah8UoTW
         KYBTdF/OD2g9paPM775zSzlfIC6ML0DpFehf05Jd83WUkF3vDCsgq7j3Eiy+Bb8eV+HO
         IBPixjoG9IQaXUxnyEiiRGbn2SCKz/+rP6bGlDKQSEnUuP+x8ESnz2GMhEEViJBHGfHq
         5SBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu9WHZQG8H9SjgZFQq6TLUW/W/1CQyDhlHlzewfbt2OgsECgPLuBkLeV620LfBnxWuhgvs8qJtiVzIIwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlsqppw6vnY8XGZGF390bb1YceF3HhEgGXugPVIz4DwbRPrStd
	6j/7oWYjBFjZTbQzXjXCP6VQruOe0uU3L3F76hpH2y7xJL/NwC4B
X-Gm-Gg: ASbGncvlB28OfAcDeX3BWfi0Lqmh4v+hn/aiT4XO2XXW+xClBvkMdDBRR4ERSkUZ9YH
	FDbO3FQLHwKr+q8BUR3sEeEN2NcqL0rMOgLiCb0FoA2uYuDxE6JOPAoIMCSxXfxVIqeqP960cuY
	hjOxweHapRPRcpjsW7kNDp1b3B2PPAkX2w9gTYA/zoTrXWLTQmQbqseqM4QU6nCos9mIv0RF6b1
	hrf8HcfnqZX3ZY8bpxQCgRPr/be/Oqh0/U129TPIwPtJbD1knioe9FlDwKApLqdvO7g4l1JaGmV
	CzMSaQdFH4vvf76fkvQ2juSbi8ui2ZTP2w==
X-Google-Smtp-Source: AGHT+IGRkAOywRNji7tmotJx2ENcSkoDdiOXtImZCqPHJSs6Zt+vtvGSgMvUaBHElRF2eP2aIEIdSA==
X-Received: by 2002:a05:6a21:6e91:b0:1ee:321b:313b with SMTP id adf61e73a8af0-1ee8cc16c14mr490265637.41.1739554228635;
        Fri, 14 Feb 2025 09:30:28 -0800 (PST)
Received: from distilledx.SRMIST.EDU.IN ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adcc6fb20f8sm1355138a12.37.2025.02.14.09.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:30:28 -0800 (PST)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: neil.armstrong@linaro.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: quic_jesszhan@quicinc.com,
	dianders@chromium.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tejas Vipin <tejasvipin76@gmail.com>
Subject: [PATCH 1/2] drm/mipi-dsi: Replace mipi_dsi_dcs_set_tear_off with its multi version
Date: Fri, 14 Feb 2025 22:59:57 +0530
Message-ID: <20250214172958.81258-2-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214172958.81258-1-tejasvipin76@gmail.com>
References: <20250214172958.81258-1-tejasvipin76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mipi_dsi_dcs_set_tear_off can heavily benefit from being converted
to a multi style function as it is often called in the context of
similar functions.

Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 42 +++++++++++++++++++---------------
 include/drm/drm_mipi_dsi.h     |  2 +-
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 5e5c5f84daac..2e148753ea97 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -1265,25 +1265,6 @@ int mipi_dsi_dcs_set_page_address(struct mipi_dsi_device *dsi, u16 start,
 }
 EXPORT_SYMBOL(mipi_dsi_dcs_set_page_address);
 
-/**
- * mipi_dsi_dcs_set_tear_off() - turn off the display module's Tearing Effect
- *    output signal on the TE signal line
- * @dsi: DSI peripheral device
- *
- * Return: 0 on success or a negative error code on failure
- */
-int mipi_dsi_dcs_set_tear_off(struct mipi_dsi_device *dsi)
-{
-	ssize_t err;
-
-	err = mipi_dsi_dcs_write(dsi, MIPI_DCS_SET_TEAR_OFF, NULL, 0);
-	if (err < 0)
-		return err;
-
-	return 0;
-}
-EXPORT_SYMBOL(mipi_dsi_dcs_set_tear_off);
-
 /**
  * mipi_dsi_dcs_set_tear_on() - turn on the display module's Tearing Effect
  *    output signal on the TE signal line.
@@ -1713,6 +1694,29 @@ void mipi_dsi_turn_on_peripheral_multi(struct mipi_dsi_multi_context *ctx)
 }
 EXPORT_SYMBOL(mipi_dsi_turn_on_peripheral_multi);
 
+/**
+ * mipi_dsi_dcs_set_tear_off_multi() - turn off the display module's Tearing Effect
+ *    output signal on the TE signal line
+ * @ctx: Context for multiple DSI transactions
+ */
+void mipi_dsi_dcs_set_tear_off_multi(struct mipi_dsi_multi_context *ctx)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	ssize_t err;
+
+	if (ctx->accum_err)
+		return;
+
+	err = mipi_dsi_dcs_write(dsi, MIPI_DCS_SET_TEAR_OFF, NULL, 0);
+	if (err < 0) {
+		ctx->accum_err = err;
+		dev_err(dev, "Failed to set tear off: %d\n",
+			ctx->accum_err);
+	}
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_set_tear_off_multi);
+
 /**
  * mipi_dsi_dcs_soft_reset_multi() - perform a software reset of the display module
  * @ctx: Context for multiple DSI transactions
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 94400a78031f..bd40a443385c 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -346,7 +346,6 @@ int mipi_dsi_dcs_set_column_address(struct mipi_dsi_device *dsi, u16 start,
 				    u16 end);
 int mipi_dsi_dcs_set_page_address(struct mipi_dsi_device *dsi, u16 start,
 				  u16 end);
-int mipi_dsi_dcs_set_tear_off(struct mipi_dsi_device *dsi);
 int mipi_dsi_dcs_set_tear_on(struct mipi_dsi_device *dsi,
 			     enum mipi_dsi_dcs_tear_mode mode);
 int mipi_dsi_dcs_set_pixel_format(struct mipi_dsi_device *dsi, u8 format);
@@ -379,6 +378,7 @@ void mipi_dsi_dcs_set_page_address_multi(struct mipi_dsi_multi_context *ctx,
 					 u16 start, u16 end);
 void mipi_dsi_dcs_set_tear_scanline_multi(struct mipi_dsi_multi_context *ctx,
 					  u16 scanline);
+void mipi_dsi_dcs_set_tear_off_multi(struct mipi_dsi_multi_context *ctx);
 
 /**
  * mipi_dsi_generic_write_seq - transmit data using a generic write packet
-- 
2.48.1


