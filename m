Return-Path: <linux-kernel+bounces-234537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A1C91C7AE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476DD1F23885
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE4E7D3F1;
	Fri, 28 Jun 2024 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gwmail.gwu.edu header.i=@gwmail.gwu.edu header.b="RNjj+KFM"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470FE7D3EF
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 20:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719608346; cv=none; b=DSanWQNQ4FJ4OmSOAmFFPoUFtBntG/o/0mKk/cH0e2RX8wtETRIABuiAIRKEDJQuIpVjyekuzZQutPoy7S5Re2l+RC5RsltnGEpir4Qwm2hWwMOL3EQ7+hD+ZlUVL+WkLgtCglneK4zf5BReYf2E+INi9KWBzWK01oZQatqlqto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719608346; c=relaxed/simple;
	bh=2eJB5k5VnksUIe7vKwMOUzHrzf7eO6CRJLUlboXcHb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMTQIZZyELDZwBRoPlArVU+n/NXtNFcy31ZNqhFdCBIBS/7D+/g5sCfH6TvBjQoy/WaKCvbEucZ7Hh43d3T6Rfar+yySDUQqdIlX7YBZEflaX/V+G/+Cesn5Xvq2IPVTSyLkXsjuabSBmvnSVScopjXtlb3Q089zV6NxBQ4orJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gwmail.gwu.edu; spf=pass smtp.mailfrom=gwmail.gwu.edu; dkim=pass (2048-bit key) header.d=gwmail.gwu.edu header.i=@gwmail.gwu.edu header.b=RNjj+KFM; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gwmail.gwu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gwmail.gwu.edu
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f4c7b022f8so7247505ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 13:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gwmail.gwu.edu; s=google; t=1719608344; x=1720213144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IORRBfp0Ewdr4NJXGZVsVL9mCEVSyuiUr27OIsqu6N0=;
        b=RNjj+KFMZlHcrsNQp9OjpUxGf+gSuSVM6nvNZbPeWwEMDkSCaj3U0OaKamiyvU/rqT
         9CvILCU/I8D69iHUVr12S78L+LrzeyIK1PGyN+InhQvMVpTUQewoIWvcr4bIPsSWx2X+
         L2nLo43DZbCCs6ceEzhRa/WUuYQiCJ9SL+pgPlttErNx9dNWroJLQblmaNn7H8anZ0UZ
         YgaDQYFz2i8+WbvDZaKf87W3z1F37KOHlkdT5IvRy4yh6+fz3jRm9yE13OJPTbibwnH4
         /488Zs6Ougd/ICPyd1hkan4lrtui827t+xo/ayPR+/hBupKy/Dh2WB5GhbJfKs6XFkMl
         ILhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719608344; x=1720213144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IORRBfp0Ewdr4NJXGZVsVL9mCEVSyuiUr27OIsqu6N0=;
        b=bBIDlBHclKzJNnEJtJ+WDfOpIeqVIT3mVVdWyffvqYieJxXECvP7ISJq8SRiWB+reV
         zyuJH8m7ns0g8HFAnxkyIhbkFLUrqtKEjXLO19kv0uSOkHNrbi/J4r2B72DbQs62Dx6G
         52hQxX+j3DlVvKWVxYfE5+UF9zMFY3prmlhkT3KXsZc11YMJx+QA2l+pkTkoehuPotOO
         fgDtHGYOYScDzpXGcvcGQvDsdEBAJ0IjEDPhMsdI2dClHmLdNLsP5TwZdKlZ6IGCqnQK
         S4oN0vEUJO0WkFE4SV4JrlqSG/HIugfVpNMbIxGZs03Z7rJNHxsS40QVZiDAM6fNnjiV
         1Nug==
X-Forwarded-Encrypted: i=1; AJvYcCWi3px1/snnYUlpEo5CweasD2M5CM4ZG2sJgM7GlFZzRwbaMhisRWaxADR0YhMvEXbhXyvv2QpqvHVpn2lxn5/BiZVSWXkyoG5NL8AM
X-Gm-Message-State: AOJu0YyDvuseVTokDbNivHeeh+iGHZVOoeCOtoKBscZIJz9hdRT5/TNe
	ELP0JBsRbPI8tGgolU0Zb8IbN9nAwDswH4ldL/+oX8+UVPH9gUt73jziZN7Xdw==
X-Google-Smtp-Source: AGHT+IExps8pzKWT7KxzQbIwg1CxXl9puvUHsya+uGADBA82LLEBRmY+uRgHuIHkiWG4e22L8hbQIQ==
X-Received: by 2002:a17:902:e810:b0:1f9:b974:cbd6 with SMTP id d9443c01a7336-1fa238e4711mr188163455ad.1.1719608344583;
        Fri, 28 Jun 2024 13:59:04 -0700 (PDT)
Received: from aw-m18-r1.. (syn-023-241-237-137.res.spectrum.com. [23.241.237.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1568f4esm19709635ad.191.2024.06.28.13.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 13:59:04 -0700 (PDT)
From: Matthew Schwartz <mattschwartz@gwmail.gwu.edu>
X-Google-Original-From: Matthew Schwartz <mattschwartz@gwu.edu>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Kyle Gospodnetich <me@kylegospodneti.ch>,
	Hans de Goede <hdegoede@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Matthew Schwartz <mattschwartz@gwu.edu>
Subject: [PATCH v4 2/2] drm: panel-orientation-quirks: Add labels for both Valve Steam Deck revisions
Date: Fri, 28 Jun 2024 13:58:22 -0700
Message-ID: <20240628205822.348402-3-mattschwartz@gwu.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628205822.348402-1-mattschwartz@gwu.edu>
References: <20240628205822.348402-1-mattschwartz@gwu.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This accounts for the existence of two Steam Deck revisions
instead of a single revision

Signed-off-by: Matthew Schwartz <mattschwartz@gwu.edu>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index ac8319d38e37..3f84d7527793 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -420,14 +420,14 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Galaxy Book 10.6"),
 		},
 		.driver_data = (void *)&lcd1280x1920_rightside_up,
-	}, {	/* Valve Steam Deck */
+	}, {	/* Valve Steam Deck (Jupiter) */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Jupiter"),
 		  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "1"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
-	}, {	/* Valve Steam Deck */
+	}, {	/* Valve Steam Deck (Galileo) */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Galileo"),
-- 
2.45.2


