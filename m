Return-Path: <linux-kernel+bounces-514001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB95A35134
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28074188F685
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D3D26FA47;
	Thu, 13 Feb 2025 22:25:09 +0000 (UTC)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE4219DF61
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739485509; cv=none; b=NDCcaSmONP4ZG7/YTNHCOqFtWMw1tfpn26Q8aOpgbkqeYrgGapDwgAcjmyr9b2QG+NkoanqpLMgfzYUJJHnnswDXLpKKZNF4/QjIV3wxpVL5XNxUiY+J4W0ffBULcSJTirdm9kURpRVf12oFkoFRx0fP3cWb3KcxuojUGwbPvI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739485509; c=relaxed/simple;
	bh=zQVOgiwvWQUivhg/+Xi7FB5o4BA3uiKaM6s/bNaES3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YjpeNVMBpbTHsQXl7SVQKWKhH7+hu32bSgxJOr8ZGBJ4pC0G2ukpgeKkaBkcUmg/ri0qCCJBsy40DS0mM+dl/Ue0csIRqzF6wjpxQVInEhKcaITiDeb7xsisqsXqDFHlAgphcA8lZEuY0oFJc2T/ANo3nNyUpscVEKCZvgodpN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uejji.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uejji.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-726ed7a316cso835962a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:25:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739485507; x=1740090307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkhhJpvktwkvV7LdqnfaxhleGSqjs7jvYncE9GyNCL4=;
        b=u7UuPhGOYZq+1flBRTd5n+/85Kudj9UkPWzjGMde8W9JRN3pbBlWy+lWW9+smj2HBN
         ffZwtXH64Yq0N180khZHJFEcWgf5DoFigOgvYIrBYDBlivVaJHXb81RzWEi7NuJg4mcN
         HqhQSM4oasZpB4JBzIMTccIt+exZ+R8KxhV8pyd4rufnw7xrotTCoQi2dKFFD1bNY0K3
         CdHe+5OjDU/wm8/C1z6ONv/B5uXP14h63EjAhOFOklqS6Xb2ntG4nLH0T5fU+INUZZeA
         1wXR910Esgv46huiyoU5tbzBnsdsAPPUau09MDDxNIodvQTp8RSOFrnFjtwvbCEhVmdJ
         xOHw==
X-Forwarded-Encrypted: i=1; AJvYcCUj8OgdnRW1khUb6OPbZF2N3JR0F6Rpo8w268YW//PBAGZWSrGpd0cYSN39LnWvrQuU2g4ifdNG9v1PcHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAtnkGDyIkss1ZdXvAHC6ZWfntTWfAm1MEk9+FJipvFwZ8rIRC
	fbnMADL+j63PCt/bU7lqkCzf23JfwoTtHs9ufBsMGsMl3Kd5S42/
X-Gm-Gg: ASbGncswFtX8NztpMmLcVrcxisRZKgFvWPNhnmfr7KlhkaHGiieWtF68pk3IBMhnxP3
	OlOx4Z1EBh0YDBe+8E/+A9v0x82qmaowZQg3LdzqW5lFsy/p7X0Sf0A1d3tAeMjCO0dnGcJQY/M
	gX2aq4+ns0CJTGbuBOp4X1wxvUro+GTm7yxem5jZVrFC9kc7KtPniZ5SMs5E4d5uneZJtvPU+WM
	6o0JTRRFmwbV8LjSJ3ciwHnNDbxy+38EbDOyGmXYFKtN5gcQsurSe8lxWQrwAS2TjG/IkQYsdVA
	6jB1dtDgVk6zTcK1
X-Google-Smtp-Source: AGHT+IFtP3uWg6TAJVNiySjP6wyYc+vZZ1FwohqMlkNmdGPgIgWEz6mzL0Op7/CYpJPMYbspPWQF4g==
X-Received: by 2002:a05:6830:6813:b0:71d:f239:c0a8 with SMTP id 46e09a7af769-726f302c18dmr5158284a34.6.1739485506968;
        Thu, 13 Feb 2025 14:25:06 -0800 (PST)
Received: from muster.uejji.net ([47.188.205.107])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-727001cde00sm984184a34.5.2025.02.13.14.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:25:06 -0800 (PST)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] drm: panel-orientation-quirks: Add support for AYANEO 2S
Date: Thu, 13 Feb 2025 22:24:49 +0000
Message-ID: <20250213222455.93533-2-uejji@uejji.net>
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

AYANEO 2S uses the same panel and orientation as the AYANEO 2.

Update the AYANEO 2 DMI match to also match AYANEO 2S.

Signed-off-by: Andrew Wyatt <fewtarius@steamfork.org>
Signed-off-by: John Edwards <uejji@uejji.net>
Tested-by: John Edwards <uejji@uejji.net>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 4a73821b8..f9c975338 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -184,10 +184,10 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T103HAF"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
-	}, {	/* AYA NEO AYANEO 2 */
+	}, {	/* AYA NEO AYANEO 2/2S */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
-		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "AYANEO 2"),
+		  DMI_MATCH(DMI_PRODUCT_NAME, "AYANEO 2"),
 		},
 		.driver_data = (void *)&lcd1200x1920_rightside_up,
 	}, {	/* AYA NEO 2021 */
-- 
2.43.0


