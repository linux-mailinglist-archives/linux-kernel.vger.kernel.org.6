Return-Path: <linux-kernel+bounces-514002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ECBA35136
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB43A188F208
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE6226E156;
	Thu, 13 Feb 2025 22:25:13 +0000 (UTC)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDFB19DF61
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739485513; cv=none; b=m5BMr9aw+IwzQYiwbOOiI/uXxr1QnaxsWcTTCLoaGN0b9g0AJDRN7b+RkvJ6PbH5tYnNaxdg+wlAap0DjYkB4gh71vLEIDRmO95kiMUipMbni/2s46KWDeDH5UlN+7WwtgZLV4jNPRDqB9vUeF81xoQcqXa7ZEr9MK30KacKmXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739485513; c=relaxed/simple;
	bh=DnfesddrGT9hqAxcdICl3YI2rN/lJYMdcJHjxprkjvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i35N07j/UewZZrKErZbO+xSUYVJzdeasStKSi7V6eZHn7xB6lOciyplc0Br49DqHGCTVgAVZHFyAdzJW+MjPcNJ1UN2iurBMXqlLlQ6hCx3MUaZM49cFZuu+2tJhVPbgkiwFWs8Si0FqbJcN5JI04A3KeE1wWq/Ll6KeHBTUbg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uejji.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uejji.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3f3df03d786so366334b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:25:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739485510; x=1740090310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOf+oTFhezeZp7A7S6xFlFzN9A3TZcxPi96KVYSkQNw=;
        b=IkXY9WXOSDYE9AhgiHb/lN8bmdX7seOUao5/w/az6i1ucY/9Ip0g0Zjhh8WtKTEUoi
         tdyAG8zhkZ15JO2FZUbOVq/Rq2VGghfqpOU1MdkuS3GiU3HZWakZ/QdAjvYQqlLJSMzE
         cxwr+n53E4d9FWuPTCBqXEl6lzkJUD1bv7eNro4NfqmMmKDzXEAlpWgHHXhYb4W22YxM
         uggwhy0NsF3zhjg5nhQS6YTQswBkzzY474c6W4Cw2R80WX97iT7tQihCRI7RKfpgKgNP
         BNHPdKz3a+/yW6/HJQyTMHD+HlQtygEs4MfcxTKgLNzMX7tS8+SuiyVQLs0jCJaepNzm
         /ATg==
X-Forwarded-Encrypted: i=1; AJvYcCWoZQ8YOzpyo5Qlm7ujyj19IGcIfbkmF5yJkL83qFRbtce5CdbI66TxlFoBgn+is+sDz/yPNRFurLbSuy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBRtybSkOXjbausVSehfzG+KpTLX7DJSGNfEqubQTpk9IeYY9Z
	tifOh1nf4KOdov44Kg49bX0zrs/qwxq3/UhJWccRkCVuXK80UhWG
X-Gm-Gg: ASbGncuW2KM4KGCwVywt3ENrJE0eQXw91Jh3Zdlol26Zt7EkTprpqjV19iF/tQXahCD
	GFPOLjrXRxs4o33OmRkDYv9nQQgcwDxTPvFYQVn0nfEbu3Yd3z/LbrioqpC+t6uMZtweB8kr152
	zUQD+souyqCHN1pI49CrogXUjRnLFq9fILSIgQ0GgipIZrIMYppmUuNpiindvw6PpKQBo9KqnHL
	EfRA+SO0r+PEsThc9/c+WlTLCnA1efZ8BUNYfqfZghdvTnNNehlqMOqAUtHLiB4k464hW6Qpfqe
	MJ/ZcPlI4AT+p3UE
X-Google-Smtp-Source: AGHT+IHY462naqcxbU+WmujVb19V1k7ZxzD9YMysyY+tEALiFHOLwX8wFNZvcbO20X2XQT1X+YV8mQ==
X-Received: by 2002:a05:6808:3c88:b0:3f3:ca45:4315 with SMTP id 5614622812f47-3f3d8dcbdabmr3557346b6e.9.1739485510556;
        Thu, 13 Feb 2025 14:25:10 -0800 (PST)
Received: from muster.uejji.net ([47.188.205.107])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-727001cde00sm984184a34.5.2025.02.13.14.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:25:10 -0800 (PST)
From: John Edwards <uejji@uejji.net>
To: Hans de Goede <hdegoede@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: John Edwards <uejji@uejji.net>,
	Andrew Wyatt <fewtarius@steamfork.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Paco Avelar <pacoavelar@hotmail.com>
Subject: [PATCH v3 2/5] drm: panel-orientation-quirks: Add quirks for AYA NEO Flip DS and KB
Date: Thu, 13 Feb 2025 22:24:50 +0000
Message-ID: <20250213222455.93533-3-uejji@uejji.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250213222455.93533-1-uejji@uejji.net>
References: <20250213222455.93533-1-uejji@uejji.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrew Wyatt <fewtarius@steamfork.org>

The AYA NEO Flip DS and KB both use a 1080x1920 portrait LCD panel.  The
Flip DS additionally uses a 640x960 portrait LCD panel as a second display.

Add DMI matches to correctly rotate these panels.

Signed-off-by: Andrew Wyatt <fewtarius@steamfork.org>
Co-developed-by: John Edwards <uejji@uejji.net>
Signed-off-by: John Edwards <uejji@uejji.net>
Tested-by: Paco Avelar <pacoavelar@hotmail.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index f9c975338..c5acf2628 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -93,6 +93,12 @@ static const struct drm_dmi_panel_orientation_data onegx1_pro = {
 	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
 };
 
+static const struct drm_dmi_panel_orientation_data lcd640x960_leftside_up = {
+	.width = 640,
+	.height = 960,
+	.orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP,
+};
+
 static const struct drm_dmi_panel_orientation_data lcd720x1280_rightside_up = {
 	.width = 720,
 	.height = 1280,
@@ -202,6 +208,18 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_PRODUCT_NAME, "AIR"),
 		},
 		.driver_data = (void *)&lcd1080x1920_leftside_up,
+	}, {    /* AYA NEO Flip DS Bottom Screen */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "FLIP DS"),
+		},
+		.driver_data = (void *)&lcd640x960_leftside_up,
+	}, {    /* AYA NEO Flip KB/DS Top Screen */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
+		  DMI_MATCH(DMI_PRODUCT_NAME, "FLIP"),
+		},
+		.driver_data = (void *)&lcd1080x1920_leftside_up,
 	}, {	/* AYA NEO Founder */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYA NEO"),
-- 
2.43.0


