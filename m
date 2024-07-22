Return-Path: <linux-kernel+bounces-258712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFAB938C03
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7B21C212F6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85E816B3AE;
	Mon, 22 Jul 2024 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="aSB9LwDf"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DAE16B399
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721640290; cv=none; b=R7iuajSaJ0rHAB6PuuPxsfOhM+8o87flJiu5GLhVjrpx2LkjjyeIaHgWL2KkP/33XDvuFWGExds7MDy8R1BW5HasWb8D12cze2LcUvvOig5nKZhqR4tupguDULgR2Xx+u0O9xgL9lvCiDDiMNekrGvcUwbhf+d6sTqnXpCWpnQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721640290; c=relaxed/simple;
	bh=FlP2wdxDnO64bsZkCAlgwvDDaTDtZXrhsF+LLRdKESk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WOBaqfhUSogdMiGB4yKw0+FUs6J9KBMr9zd1yGfOb4uUXUv55jAsf6KJsS+Ryd7cSCFo/Vsu9U2YATQgmlo5HbXbRo9o+L/8IIaoB25EOrec/dHddDjVvp4ex7DJsy0VLXABgnoYtxnHDhQP5WPZtlhdkov/an48vRd/VILhxJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=aSB9LwDf; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-703d5b29e06so1662101a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 02:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1721640287; x=1722245087; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TB89ZlKNnXu3g5oV+TfDlJrKIEZjcQAqTnoqfzrRSzQ=;
        b=aSB9LwDfNQcg0bYuwc2Z5VUzHexH2T4Eqig2SixVCrSO0w6zaHLEDaVfJAkD4PLsLL
         +u0DRGRVwPmMGPhMRlqbKLL9NRZuOyCYAJSpoDEcyc0Lh+gp4ANGxaiP+e+OMKhpk+KT
         xIpLHBUkz0ULVGyFFclEgV4KoWC+y0wTGp8LJR+4Z3a0i7F1hpNOH9wr89tvD4tTcGM0
         UA2gbYWhJ7JJ2Yip0UTEeLj5PkX10eIwjDb9T9bCAtEAUOMcEMqJbYj6JN8TDVQWPfsm
         bUl1/7DiufgfO3pNmUoS9ffbxgjkbJ0WLXXSnzNlE40OAIKPO5GQsLCLTRlin9e1tPzn
         a68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721640287; x=1722245087;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TB89ZlKNnXu3g5oV+TfDlJrKIEZjcQAqTnoqfzrRSzQ=;
        b=oxHhM5hi8xZAOQfLikg+N9DHMsztlgmPgzBXQQFSlAXyUZg1IFhm9HHwm2m4rUJBS7
         Pjd/eVz8lD3NFFPtcMG7qRxmDxQ9v1cPH5i6EXuAaZdUZIab+wa23Sqfm+C212c8w+7/
         OEvURsNE4gJw3c64D4+4DyT14nJkWsQvrPHhZ5Nef7SG4FjXQUMKWD2hlVaHMkERPsmy
         eHZp7jdduUpbtghISz+PNLwm8iw1/1caW6+72pHADYkXV/hiAuBc20uc1fsPNyzN8wJu
         Hq2DIvLQHslp8Hprh8uE7D01R2AeNrirBU4GL6saTYEWtgTUpFZ0CFjlsodaNYv3AH7q
         eO0w==
X-Forwarded-Encrypted: i=1; AJvYcCUUOXakpdrvDIaVb0QDiVpH0sdWzwS4mSzrjrYwAtzabKnop5ARC2YdWzG02syGnpP6UFCRbVYpqR+JL8WPec0cRmXPp8dLBJqgtgMU
X-Gm-Message-State: AOJu0YwpZzQlgnLME+1hPOmai53a+t0ym1h93nXpGzx0sJWdUispgvLg
	64LjZA6NHBuxzF+aA8tsdwwyYeSXNJNh/UBTghP7FPRDUzAvk9WCpqueFc6+wE4=
X-Google-Smtp-Source: AGHT+IFfThZoo9NFJtDQgeJWtBACTXjfL99jN1cVv6gplQuuD4LIHLvJVra5GuCL4Hfsc/oHk1k2mg==
X-Received: by 2002:a05:6870:4714:b0:261:fd5:aa34 with SMTP id 586e51a60fabf-263ab54f89amr3032889fac.30.1721640287279;
        Mon, 22 Jul 2024 02:24:47 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d26efe61dsm1639901b3a.149.2024.07.22.02.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 02:24:46 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	sam@ravnborg.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	dianders@chromium.org,
	hsinyi@google.com,
	awarnecke002@hotmail.com,
	dmitry.baryshkov@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v3 1/2] drm/panel: boe-th101mb31ig002 : Fix the way to get porch parameters
Date: Mon, 22 Jul 2024 17:24:27 +0800
Message-Id: <20240722092428.24499-2-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240722092428.24499-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240722092428.24499-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The current driver can only obtain the porch parameters
of boe-th101mb31ig002. Modify it to obtain the porch
parameters of the panel currently being used.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---
Changes between V3 and V2:
-  1. No changes.
v2: https://lore.kernel.org/all/20240716121112.14435-2-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V2 and V1:
-  1. No changes, Modify the commit information format.
v1: https://lore.kernel.org/all/20240715031845.6687-2-lvzhaoxiong@huaqin.corp-partner.google.com/
---
 drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
index b55cf80c5522..d4e4abd103bb 100644
--- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
+++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
@@ -312,15 +312,14 @@ static int boe_th101mb31ig002_get_modes(struct drm_panel *panel,
 	struct boe_th101mb31ig002 *ctx = container_of(panel,
 						      struct boe_th101mb31ig002,
 						      panel);
+	const struct drm_display_mode *desc_mode = ctx->desc->modes;
 	struct drm_display_mode *mode;
 
-	mode = drm_mode_duplicate(connector->dev,
-				  &boe_th101mb31ig002_default_mode);
+	mode = drm_mode_duplicate(connector->dev, desc_mode);
 	if (!mode) {
 		dev_err(panel->dev, "Failed to add mode %ux%u@%u\n",
-			boe_th101mb31ig002_default_mode.hdisplay,
-			boe_th101mb31ig002_default_mode.vdisplay,
-			drm_mode_vrefresh(&boe_th101mb31ig002_default_mode));
+			desc_mode->hdisplay, desc_mode->vdisplay,
+			drm_mode_vrefresh(desc_mode));
 		return -ENOMEM;
 	}
 
-- 
2.17.1


