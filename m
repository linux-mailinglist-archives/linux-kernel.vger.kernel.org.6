Return-Path: <linux-kernel+bounces-514005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43345A35139
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4373ACEC1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2A2270EDC;
	Thu, 13 Feb 2025 22:25:23 +0000 (UTC)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5F1270EBA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739485522; cv=none; b=Qfrl5Fbtf64Pm8P14kuUI3qAqk8LhOuIjJ3AH71n0c4Olous90ADqu9N8gkUYnvORUWlGzR1T7z9t1nI8KEpuFVVQixu7fyTOKXRYTnmozE0R1kT2gusHs9AmeCYBwqkC4ufmg8CRhJknR4ZYp5akXv8ki4TFQ/AYbbBf2W+9EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739485522; c=relaxed/simple;
	bh=ELXizX1kw5ax5XItAwU0C3qHnZ74Fb89lqj8BXn7L5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=llLLUlewBDnp3o5nOPQvXIktoWrvXcCNFIg8yRInu+C03qUsZ797rEufILhjDoDIFE+PzpS25CZtlcVmem4vvSYHDPHdSD1Ev+1ucgrU4IARwiWwg5ZsNpRpBBt3bzZCNpsUJIPK1bMQA7qoQtbS4ycoZudVrwDCOSkBsRlUiFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uejji.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uejji.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-726f17859f1so1175391a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:25:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739485520; x=1740090320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbXz1euv/cPJto4Z2heNFSHbQ1+cD/Kyl1f7KOCLRQA=;
        b=R09NeFZjEoUV1/eWMO5FVqi1PH6PC9hfQFJ4X/940jMcke3Sf9zTOLdnY7rpXne44d
         yAoirgo9xSFbRMnVmfMzJXIt5Cj36bgoxteSNvYY3L8ZP6UF82IlRq7ufBcyYQjbd8Qp
         r4pRYgRu7mUFZmERCibVMIPfcyHzCuAgro7WSvl0W9cBRqaRKEjJGV+s3bOcM/avMqRr
         CTdew1/8aqCYeWA9rhRLo2h56LV0KIIykVoxokwgP6s0xmmv9izeqprxVVgRiCCHCVy1
         tqSbPJSe+6qD27Dqm9DsAyIv94ZN5l0bqr8rngd68JO/oVh+Ye2HPplOeePM2XX/gHLj
         rMww==
X-Forwarded-Encrypted: i=1; AJvYcCX++a5bJ9KAx6YyRdhKw6/sPPhJiCaKaGgdC1zWDxI+RLs74zZGXISdSBc3u4G24ABR4jF3J5KgRiY2GIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYI2JHmAPpFLfsFTbp+4MIyIFh6ZZ4eruo2xrXDLocSmnx1set
	gFKAaVAi4xUR19FRzTbR26h7JKTHvvTZbwNb4OBjawxJx58TnJDe
X-Gm-Gg: ASbGncvBCHnx+NKDL/HmcxvEDsFjZQZtQO6tO1+r8gW3EpD1wHGEKKRZf6sOvc52kCK
	hIeJaQsY0QV9r8ztzhNl7S/xhNxwf1+TGsva7PH6Ld90gGUJFwzgS1OIpLe8DuB7lnvHjATWSLO
	2LeRRYDgQDAwqHyjsrG0ywU409nutg5jyTsZXD66RubEnfwjwB6eA5II84yTsYHfUuZbpzVb99y
	qKoyqXn1giDvqW5hpoBCAUNtRfp8xqVGQannzLrKcy5lU2ADGrKIkU1Sl4wvVRiPj2mDObdWzRt
	yzuGvYYa2QMmxssF
X-Google-Smtp-Source: AGHT+IHxK1p4NsYf81sYIzrNKJsg7ljfMe1tLS+UA3xHsLoNyXR1fUqhVsxBfQAGVM5OOQZiQYT3AQ==
X-Received: by 2002:a05:6830:1318:b0:726:fe71:5373 with SMTP id 46e09a7af769-726fe715469mr2911731a34.4.1739485520213;
        Thu, 13 Feb 2025 14:25:20 -0800 (PST)
Received: from muster.uejji.net ([47.188.205.107])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-727001cde00sm984184a34.5.2025.02.13.14.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:25:19 -0800 (PST)
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
	=?UTF-8?q?Jo=C3=A3o=20Pedro=20Kurtz?= <joexkurtz@gmail.com>
Subject: [PATCH v3 5/5] drm: panel-orientation-quirks: Add quirk for OneXPlayer Mini (Intel)
Date: Thu, 13 Feb 2025 22:24:53 +0000
Message-ID: <20250213222455.93533-6-uejji@uejji.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250213222455.93533-1-uejji@uejji.net>
References: <20250213222455.93533-1-uejji@uejji.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Andrew Wyatt <fewtarius@steamfork.org>

The Intel model of the OneXPlayer Mini uses a 1200x1920 portrait LCD panel.
The DMI strings are the same as the OneXPlayer, which already has a DMI
quirk, but the panel is different.

Add a DMI match to correctly rotate this panel.

Signed-off-by: Andrew Wyatt <fewtarius@steamfork.org>
Co-developed-by: John Edwards <uejji@uejji.net>
Signed-off-by: John Edwards <uejji@uejji.net>
Tested-by: João Pedro Kurtz <joexkurtz@gmail.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index e6148cc31..88aa57c15 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -129,6 +129,12 @@ static const struct drm_dmi_panel_orientation_data lcd1080x1920_rightside_up = {
 	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
 };
 
+static const struct drm_dmi_panel_orientation_data lcd1200x1920_leftside_up = {
+	.width = 1200,
+	.height = 1920,
+	.orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP,
+};
+
 static const struct drm_dmi_panel_orientation_data lcd1200x1920_rightside_up = {
 	.width = 1200,
 	.height = 1920,
@@ -473,6 +479,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONE XPLAYER"),
 		},
 		.driver_data = (void *)&lcd1600x2560_leftside_up,
+	}, {	/* OneXPlayer Mini (Intel) */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK TECHNOLOGY CO., LTD."),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONE XPLAYER"),
+		},
+		.driver_data = (void *)&lcd1200x1920_leftside_up,
 	}, {	/* OrangePi Neo */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "OrangePi"),
-- 
2.43.0


