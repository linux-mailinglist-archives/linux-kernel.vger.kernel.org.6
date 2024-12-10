Return-Path: <linux-kernel+bounces-439708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9A29EB2ED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135A31881B50
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2461B1AB6E6;
	Tue, 10 Dec 2024 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QwY6imyY"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59B478F4E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840216; cv=none; b=cxem31BzolI/3N/dlzvbi6UAoz1zO0IH6J22Xy/uy5UIAPRo+lc83x1j0CppmjYaXY1A3Xv6ECZvyameYUry6z/20YSrsBk8H3v96VtM9TmcM3mCEAjS7mxXwLIn7ILQLEF98TEtngXFBvQfmLkNoQ0Sd8Re7twwDY4vN48lj2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840216; c=relaxed/simple;
	bh=w8Xw25H9E0EowRWue4E3JonkkP8YUynIV0Mvq3TC5nw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=adRSMYgEmMc5RYVfHA1hDHxm0tljrAgU0LnHetCS9M+HOuUR19fl1Lg3mh+p1GpEp2w3gy9hyMd6ZALLD/nfpnBV3MaHTntHJVoXWkZl5RSTWzavJDBBDzQpRvS3lwqutw0QAv2w2xbdjut0Q7xQQs/ZOj0Zq/vNQ+pzAMeLxE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QwY6imyY; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso5700570a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733840213; x=1734445013; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YDx6hbMot9hPe7Zgw4rNyld1Z3a4kDtP9bTMjfYhMss=;
        b=QwY6imyYllfFqBY69tDTkoiXMqAshJur9qg6/rK1dQTTV1peFT6m5+Yoilpm35UWpT
         S0dJ1Mix8BQyHcDv3+c867gJaFDoMfWIltai9dh5rHlIl7tzACs7LipaEiJz2G1PCYA3
         BRi5TAy+1PBbUDLNUYjQCx7x51Uc3u1MVdWs8g4bSfDQASLSA70ajIAg40PnX74Wrhp6
         6iSe2A12Wy8fVNnp7sGrVQHimQ8Xeiu2kG9xaAgy/PnPMpDup9zVISVV+rqPv/hKWTT1
         F0fZz+8kCG6ntY7JCA7dG5p0gns0KgZYD8AAPLCbAC+S2RLac3cYhr7iPyxCBGvPYf5R
         ttvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733840213; x=1734445013;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDx6hbMot9hPe7Zgw4rNyld1Z3a4kDtP9bTMjfYhMss=;
        b=v7IuHVxk5nUJGVg0vZnI0YoqkjlI00ER9CmzHAH84V+zdpQpQy1CX/W6FIleLlBzsT
         vTQ6kehVVmFhXZrV+G/4vi5/6Ma76xA9wi3XQLYwtEGrHIG7yajghZHiB/cdfFYN85Ro
         zPToaipnRfPIvRJ2KNRqt4flYDnifPaCEyC4ZEnVWquaTOi12olhn8vomz07PT3IVPX1
         IeZiZa+X5Xk75Wuh7s93awztNRSIEkf6aUqsnvlEvIJP3VmqS6wqfGlsX5llT6P42lBM
         S5tDzFFdnzgoy1/RAaTRyNwEOwWgGgdwIfUELZno2MWszCRmmFMEgZxcthpgU9Le8q7p
         yA5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU93Hpo7hWhws7XhkQyDLg6jTNiYWqMwLDc+whmXM3gHPIaKZKK2McTmBM9zKvk42zvhC+qcyoZN9C0A4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmY/xxhHdtPbZWA29oBvMCSoskJLUTtljehcMBNaw7fP+10iYG
	63ugqsbyIlqbwGvUG225tSVGv12UzVscA2NuR2q+pGBI6RvBN/AoDgl0xIhWjEU=
X-Gm-Gg: ASbGncvUwYJrx+EvUQoPTeC2SkX+bJd/EClM5jYau+jS40WWbszbDKlBxiq+BqRrwGH
	FaZ3QMcQfRUuZ7guqhm2xY0yfSrEWVnLb4zKtcZA0ktkS1QTOODEjq6Hyt3MLBe5MmnaddQAUe0
	d9oeVACJ2F+5nkUQmN8RbVd03DPuBNFnu4ZqfO39GBKbsfYZLgiqo3o5CJCn0NaGfQr2p9NLlmB
	WwutkbvKNE/2N+u+mROeAuxbWowUXD6j3UtgEbsBjT7IuEOBDtTtNfS6COtjA==
X-Google-Smtp-Source: AGHT+IGWT8mMHqxsdN4hdP58Pe8rJU3Stb8+4FvxSrZ3iQfKkTBWo2xyAfZGSkKZNrpT0n9roYgJVA==
X-Received: by 2002:a05:6402:5212:b0:5d0:b1c4:7081 with SMTP id 4fb4d7f45d1cf-5d41e163a48mr3441285a12.4.1733840213072;
        Tue, 10 Dec 2024 06:16:53 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3dc2602b0sm5104362a12.18.2024.12.10.06.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 06:16:52 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 10 Dec 2024 16:16:47 +0200
Subject: [PATCH 1/4] drm/display: bridge_connector: provide atomic_check
 for HDMI bridges
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-bridge_hdmi_check-v1-1-a8fdd8c5afa5@linaro.org>
References: <20241210-bridge_hdmi_check-v1-0-a8fdd8c5afa5@linaro.org>
In-Reply-To: <20241210-bridge_hdmi_check-v1-0-a8fdd8c5afa5@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=w8Xw25H9E0EowRWue4E3JonkkP8YUynIV0Mvq3TC5nw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnWE1R5NPKL4rqV+jR0KPOXn80x27rRanZM+VQ5
 Q4r9GgPzaKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1hNUQAKCRCLPIo+Aiko
 1atnB/9dz6pBR9aU669+5H2pdnKug29xlZBRPLZmzo+E5oJewM3cZD09he4jEBfGB6H63phwgKT
 PCpN6NcXKee8q0yILHUXjqQPoq0+AETXNH6uHzI0+4meAAff39OFtOxfONhTOBikdBNVu1/L126
 34Smslj0Au4U5ptSosFI37VyPtgVeA3YkXyr762Thi+gFQikGCujFrG4rmoYiMn7YiCtGjO2kHo
 bAYnERIBIUqUoLvx/uC1WeTp2w3aS+e4u4SjSuB5yGIiPaOyqOw5Fwn0eyiotVWCwsbb0E6Oc6E
 XV7eLYsE+JEFYPpHPhaLSGyysWCYM1XeqIHTJMgcP4HrwECy
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The bridges using HDMI connector framework have a call to
drm_atomic_helper_connector_hdmi_check() in their atomic_check()
callback. In order to reduce boilerplate and make simplify bridge's
code, use drm_atomic_helper_connector_hdmi_check() to implement
drm_connector.atomic_check() for HDMI bridges.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 512ced87ea18c74e182a558a686ddd83de891814..f6e0b6f1ffdd392ee15ddfd9ec85452a88122d42 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -313,11 +313,24 @@ drm_bridge_connector_mode_valid(struct drm_connector *connector,
 	return MODE_OK;
 }
 
+static int drm_bridge_connector_atomic_check(struct drm_connector *connector,
+					     struct drm_atomic_state *state)
+{
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(connector);
+
+	if (bridge_connector->bridge_hdmi)
+		return drm_atomic_helper_connector_hdmi_check(connector, state);
+
+	return 0;
+}
+
 static const struct drm_connector_helper_funcs drm_bridge_connector_helper_funcs = {
 	.get_modes = drm_bridge_connector_get_modes,
 	.mode_valid = drm_bridge_connector_mode_valid,
 	.enable_hpd = drm_bridge_connector_enable_hpd,
 	.disable_hpd = drm_bridge_connector_disable_hpd,
+	.atomic_check = drm_bridge_connector_atomic_check,
 };
 
 static enum drm_mode_status

-- 
2.39.5


