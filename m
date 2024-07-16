Return-Path: <linux-kernel+bounces-253747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F5D93264E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA722829B7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4A913A896;
	Tue, 16 Jul 2024 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="yD3zbuPD"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F7B17C233
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 12:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721131890; cv=none; b=s6TJGe9sWgl12dhewzhqjWzc8LcOmM8magZ4VjZOMXgnf6m+eDvFo6s/VAu9ZvTctmqgS5sGmGmtlLSzSsTPo/S6+xkwqPKQBHbSJNBbU6TNDnQ8YiWx/YUyCXEE7rl/MQHhbUYppRLCbFGO4ijKfOxJWsLNfQCNbI81Bxp92aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721131890; c=relaxed/simple;
	bh=yHRc2l77XnaKCe7MZwOxpFSi2WaH3VG2HRPrN2VnpkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=YuxsCBaYkbPDfhAeuNjQXt/Zbq0rmhw9RgWX5B0EY95F3Dea48dv0ee8e8AkqQON39dt8Sa4iiaD7Tx72nKchbi1xf888Z3C7GZ+cw+eZ+N+/b7763I/9Rh+dCf3FL+SCDUxKv7R4HtmZURipzy7G54VJzCz6dDyayY1/WOSKlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=yD3zbuPD; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70aec66c936so3953177b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 05:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1721131888; x=1721736688; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=blbSlELLECRmvXwv7SN5IDYSjruj8AHGnyhct2EWwU4=;
        b=yD3zbuPDrqM4IBwef4ij+5PUA7xaZJUoAfenWIj0e5xpLEo2rz+R60Thtt9PNw2yEN
         gUoSvonfIfWNQ3Udnz4x8Bb5xgyevc29B6g24QxolcBazXYmihoTn+rfRwGi3oOjVe/9
         p1wX6PF0IQVAY79lRrAXy1gJh1SnhkidCEFaybNBN8NRga+Ttt7IXyiP6f3S4zQkAwMd
         jEy/MUyVgkMoQ651rzFB++nWH2ITNvOOhvkolfXSRLMnJDsTJScd4HDTpl2YzDT+KBd5
         QdDLzkpKS/1sWz41Y9JE1KAxlWTAvVXZ11yyn4+bxKlVK3pq2GpaQvELcOU9locOFqRK
         ZYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721131888; x=1721736688;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=blbSlELLECRmvXwv7SN5IDYSjruj8AHGnyhct2EWwU4=;
        b=tMVi5KflGWGchnWo7fUtvjyQC9O0++wvT16Bj5uDvKcqVq9yfvjN0BhfPYbxLhrA7j
         PVHRqPEgZqPxqKuRI636e0m8quC/e7itm1SRIlWIJf6ERkZqG74FhlQzY3TveCH2KjwX
         L6UBvcREFumwWT7qkkSnsazC6xj6lHX3N+NGDJvJKE13/M62ZrZvqQbrWA0USn0albUQ
         3UlkwYaI1HRtlzJuuRIKJqoU9FKWZbL4RXCQuglod8ZTxErHyN62JEfrcqccD/KMquT4
         jDqHDoiHuU4+QhxvnXumwwZ1+VbkpGTJS+jYkWIqxwWjlPc2rCz1+etu+3q5nI1qEZ+K
         MsxA==
X-Forwarded-Encrypted: i=1; AJvYcCVAjNJF5ztkZio3WppWYCRyffpeuRnq9bAhS5u3wz+YDvlA4n4Z2nRBO+3pclWjpiXC0ToOIVaGglyd9t9b4VQ78zyf5Is4x4eaBVGp
X-Gm-Message-State: AOJu0YxID3LMxDJsUz+Ao7zsIEvy/i5UGoOlW64V+zQuNbE2S1YvCrcD
	8c1XQL/ftUIEo4EI0Av7GCY3h7IMz2+4Jr6MnTx19K9r2Ssclj8+RIKrBvldKoQ=
X-Google-Smtp-Source: AGHT+IH/k4jWImyIjbW7yGtrYYEDR8z48Mphe/dvltvql6yF6cg+o7MKJy0g0ldWT8SGBXoYS+4sGA==
X-Received: by 2002:a05:6a00:3a19:b0:706:5dab:83c4 with SMTP id d2e1a72fcca58-70c1fba1248mr2131358b3a.14.1721131887544;
        Tue, 16 Jul 2024 05:11:27 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eccc48bsm6114065b3a.203.2024.07.16.05.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 05:11:27 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	airlied@gmail.com,
	mripard@kernel.org,
	dianders@chromium.org,
	hsinyi@google.com,
	awarnecke002@hotmail.com,
	quic_jesszhan@quicinc.com,
	dmitry.baryshkov@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v2 1/2] drm/panel: boe-th101mb31ig002 : Fix the way to get porch parameters
Date: Tue, 16 Jul 2024 20:11:11 +0800
Message-Id: <20240716121112.14435-2-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240716121112.14435-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240716121112.14435-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The current driver can only obtain the porch parameters
of boe-th101mb31ig002. Modify it to obtain the porch
parameters of the panel currently being used.

Fixes: 24179ff9a2e4524 ("drm/panel: boe-th101mb31ig002 : Make it compatible with other panel.")
Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---
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


