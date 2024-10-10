Return-Path: <linux-kernel+bounces-358784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4BA99839D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170B11F226AB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90F412D21F;
	Thu, 10 Oct 2024 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iO9CTIRa"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C7A47A60
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 10:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728556331; cv=none; b=a4MyYFcLkbvuaEtrVEaWuEv2nl/0CNIdrZlyVks1lxfhOjMSjREl3EAUr6fJ2vL8GDi884Ao6GgxeD58HRLln++Pv3pqiyeHryXlUt4yFDdfumg3irEXD5M4L2wrKB0kgPSEN5OcTQ4L6R5tSqnz/WNXHqYCzuLYlftEjNfme+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728556331; c=relaxed/simple;
	bh=U8Qpq6Kc34eBmGAV0KHkX48owBKgN62YeboZL5ZEL24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B4Q5ZNdL80DR8xchiXsYykmByXOVTu5bQ4yvYPO7CTTayCAUtjOv0S1iK6EY5959ufSuc6vdFuAquNz/68z+kO8n6IMaM4pSCzs87xUNdIGhbmUqc9jrik5ht8PIoe8aAwfvwIyj23QX8gCjUNtI7u7607gyMxyJWLjuYYb7Cxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iO9CTIRa; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c937b5169cso628126a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 03:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728556328; x=1729161128; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EKfCr8K8XATwTEc5LZiBxGmuNZQGRkSeS/Vp37hWSP4=;
        b=iO9CTIRafMWM/3qogsIez7rMNcKU3vOfOjrZFn2Y3I3pqoQhSoM4bbLktlKYFtFyp5
         25XDESm+sxJ1sK5B2G5aiMM0b6BZPaniJFoKhjur8fOJlFH6OLCZVJPf4stQ9UbJ7i0i
         sDrO7c+TiDP6BnTLEwAgYS6oGouOQEtT2DxyASpCXVKF0sQK20MIM7yLzcKR3/sOVl85
         U2cd/blTpaLHeATJKco0krAMO/BeXFa9qBZIYNzdg7cQKplSnRDemzBAMeNlio6ecc42
         zdTfId8/T0rRIu7amzOF+Wlp7ta9JkC0Muf9RFu2y5/Z50lLOGuRjJV53D6gEsXXHsD5
         TN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728556328; x=1729161128;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EKfCr8K8XATwTEc5LZiBxGmuNZQGRkSeS/Vp37hWSP4=;
        b=r9R5UnPtBzF6zPwXzXEZyyKf9VgXSEU+QBvhLOqxRbbwVINcIcip9eaaLcZexP2UrI
         qHQD0KUU4Wiagqjm1ZQA075nCDR8Kb6P0BNkff9Xd3CBOJopky1DCAuoaLYw9sfv2e64
         RcxWIYIaBv9OuPdhytyPAgEcYihU6NYjOIouD2fIWx54lRmrZhMNTyrpc6a0HpYHkOcW
         Cudw8btMLyeiGQ1lwGIqRQ6iA5KqtKWEAGLAdVsLzi1Cxz2wbLfkMHidNiu+zG3gTUQh
         DlOsBDS0+K7sMSl/dzj2D4hp7tL97cc08w5/+ing7YYUnPoq9lctarWSKOQfhPTo0asL
         lyZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeRAm6yX4NQKRbu3YfVPIh3eMFf+J9uFD9m1PukxnZbpVaceQy/h+vd9CyGv5ddNYgdubml8mold3oQko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1TaApGrnurEgPup5podgjXleYrESx1dqblTrV38ewVvGcNOFQ
	1Mz+RArr6aD2fY3zsgHXUquyFgxFyJHbVA6vfPJUVQkj9NAEswCE
X-Google-Smtp-Source: AGHT+IGJ+FHXEoWNw2jQBNeAzKGmH/WOieImY89fddm17ppYNB7oLiViUmG4HFDkNWVkiKeN91bdCw==
X-Received: by 2002:a05:6402:3508:b0:5c5:cda5:9328 with SMTP id 4fb4d7f45d1cf-5c93353c8f1mr2301881a12.4.1728556327707;
        Thu, 10 Oct 2024 03:32:07 -0700 (PDT)
Received: from [127.0.1.1] (leased-line-46-53-189-107.telecom.by. [46.53.189.107])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c93715159csm597314a12.42.2024.10.10.03.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 03:32:07 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 10 Oct 2024 13:31:42 +0300
Subject: [PATCH] drm/mipi-dsi: fix kernel doc on
 mipi_dsi_compression_mode_multi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-starqltechn_integration_upstream_drm_fix-v1-1-cf3cb1d1ce77@gmail.com>
X-B4-Tracking: v=1; b=H4sIAA2tB2cC/x2N0QrCMAxFf2Xk2UKbCk5/RaSULd0Crs4kE2Hs3
 y0+ngvnnh2UhEnh1u0g9GHlV20QTh0Mc64TOR4bA3o8Bx+8U8vyfhoNc01cjSbJ1py0rWpCeUm
 jLKnw110QY4w9lmtfoN2tQm3+p+6P4/gBybGUlHoAAAA=
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728556326; l=1225;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=U8Qpq6Kc34eBmGAV0KHkX48owBKgN62YeboZL5ZEL24=;
 b=0IvFTL9sBSstv6QvX78a5xbC9GwOL1MGNboZNiXyqkJTGKUSlN9NQQkpBoLOL5fdnaeNOEkVh
 eVqSaAam8fNDcU45aT0VMQ5EUCvJoP4JEZ8GynpFID4DaDrS2ZjnOVh
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Replace dsi parameter on ctx in kernel doc of
mipi_dsi_compression_mode_multi function.

Fixes: 975bdea8c470 ("drm/mipi-dsi: add mipi_dsi_compression_mode_multi")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410092245.tfsuUllL-lkp@intel.com/
Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index d8ee74701f1e..5e5c5f84daac 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -1522,7 +1522,7 @@ EXPORT_SYMBOL(mipi_dsi_compression_mode_ext_multi);
 
 /**
  * mipi_dsi_compression_mode_multi() - enable/disable DSC on the peripheral
- * @dsi: DSI peripheral device
+ * @ctx: Context for multiple DSI transactions
  * @enable: Whether to enable or disable the DSC
  *
  * Enable or disable Display Stream Compression on the peripheral using the

---
base-commit: 4c93ede2b0c73a7708f46a01669769d15d31e1d2
change-id: 20241010-starqltechn_integration_upstream_drm_fix-72233382f98f

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


