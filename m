Return-Path: <linux-kernel+bounces-240660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82A0927097
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24FA1B2460F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 07:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C79F1A2552;
	Thu,  4 Jul 2024 07:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="lTo/UmSy"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF3510A35
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 07:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720078213; cv=none; b=iALmMn7DEuRyU4gKQYdU+U0+0FcgFYCVgfyIxqSSr3wR+M+gVDniaHRKF/9x/ULlSkzmP9kjKt7x0hnIHym6uIS/o5G588RsqvtzP8OBjoXIKlf5i3WTko2an4aJulKqTvKc9ZcTZuBdXyBcJpw2q09n8agT3iZk/0TPau3E/+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720078213; c=relaxed/simple;
	bh=bNEd2Xe81AAP6BMXl4V4U7zeGUa86JogxJOrukzl6mU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=gl71z/FR6A1NJ+aG2il3bfj6vxKKj1Fh1BR6gwZfO/mOnMZswZcKStuAoxdJMBymZNt1PGtlUx+vjfxfhu1+fRhFHX+hr9muTm3FXvCc5Fap2iUluoW1n6Li/9IKkbtDecbHSvmjgDMRdmm/HCQAi2w1q48b6a1jfGmzkNLbX+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=lTo/UmSy; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-706b539fcaeso1148719b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 00:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1720078211; x=1720683011; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HoZASCSjh5HMX+iYg6EyKw+Bujbjq1YrTEDuwpgZE9Q=;
        b=lTo/UmSyP+l2hg5ks6/K7aKshz9F2PuldIdKON1uRUlAtnSkh0rZ/3SVQtB8U062Nq
         IPxobnBQDOr5ekzQQBienHC6hrZFf6/uc/UL0oYrYZ3samjSih6MISwu3LaPTBMe040l
         2FfcODib80/qUCjngMpHpaHvMdPhZ2eD2Wq6qvYo+S+INy/xZhjm2TyjzdmWfaF/U8PX
         FJlAxgpdgf+VKvjSKi5RZ6MM0fWs0O7jGRhs3VVodyA4R2Emmt0X+0/DjpglflM2CQ65
         wT9hIRJwpowTe5fKZVNPpJZZwBgaTEJoMWKI9iZoGkehsqaFcydxkUnYwO/nI0iePeyg
         nDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720078211; x=1720683011;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HoZASCSjh5HMX+iYg6EyKw+Bujbjq1YrTEDuwpgZE9Q=;
        b=IBcPAm6w3FGj+irw7R6nsSwPfQKQ+XZjICiUzuoK4vmFppL8E6BaCL+zzDdIe6aTfe
         k2kxcVaxM0VvZtVMfFa4lHefKWt6G3ta1Se2I8CrQ7GFSFigV2U7gAaY0CmZqyVqmhfA
         0jIP1cE3dkX4FK/OeLiy12C5uEzq9fbmPUuHEob6130UgaB09daLLvJJG3ppv6YGsJz7
         q192+/zJ7jRRhTVx/jGEl5AE38mGaRS52Po8m5ticjdbKGQ50DFjlJV3vGnLrIi6XTmi
         2DZanQwZ5FSMB3WMbv65iUksYLim8i7+yoK/Jw+DAGdzfoVn3GXBgbY3ZyCBfjFZ3IgP
         7Pvw==
X-Forwarded-Encrypted: i=1; AJvYcCU57bm5thLhUyRE/rSYFakA0ZLOqJoyAMAUN+puRk0x3nqjVP/buCJyZfACmsMCMMSxdGDALD4veMkEC4SEKnUVMYDJ/uRgJTqObCWY
X-Gm-Message-State: AOJu0Yzd+pu9+AY1exz9dlImNoXOEwXQ23p1kBWRCawrWwMxxPoDkWyU
	kSew1UG14nC4ylONxk40lMyrYbbCDXnX4fSprfWQHdSepyHD3b8ZgmaiOwGGLV0=
X-Google-Smtp-Source: AGHT+IF0CGZi0nRLYzMbd6CFtfqKawTIK20i6+6QYDX1nOMjNRk44Geb04TJIT85AHJuXHPHgbzLXA==
X-Received: by 2002:a05:6a20:5510:b0:1be:c3f8:aeda with SMTP id adf61e73a8af0-1c0cd1a53b8mr766246637.16.1720078209074;
        Thu, 04 Jul 2024 00:30:09 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6a8dbb2fsm7735699a12.31.2024.07.04.00.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 00:30:08 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	airlied@gmail.com,
	daniel@ffwll.ch,
	mripard@kernel.org,
	dianders@google.com,
	hsinyi@google.com,
	awarnecke002@hotmail.com,
	quic_jesszhan@quicinc.com,
	dmitry.baryshkov@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v5 0/5] Support Starry er88577 MIPI-DSI panel
Date: Thu,  4 Jul 2024 15:29:53 +0800
Message-Id: <20240704072958.27876-1-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The Starry is a 10.1" WXGA TFT LCD panel. Because Starry-er88577 
and boe-th101mb31ig002 have very similar inti_code, after 
discussing with Dmitry Baryshkov, We will modify it based on the 
panel-boe-th101mb31ig002-28a.c driver instead of using a separate 
driver.

Changes between V5 and V4:
- PATCH 1/5: Add a new patch, make it compatible with more panels.
- PATCH 2/5: Add a new patch, change devm_gpiod_get() to devm_gpiod_get_optional() in the Probe() function.
- PATCH 3/5: Add a new patch, use wrapped MIPI DCS functions.
- PATCH 4/5: Add it to the "boe,th101mb31ig002-28a.yaml.
- PATCH 5/5: Compatible with starry-er88577 panel in panel-boe-th101mb31ig002-28a.c driver.
- Link to v4: https://lore.kernel.org/all/20240620115245.31540-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V4 and V3:
- PATCH 1/2: Move positions to keep the list sorted.
- PATCH 2/2: Adjust the ".clock" assignment format.
- Link to v3: https://lore.kernel.org/all/20240614145609.25432-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V3 and V2:
- PATCH 1/2: This add the bindings to panel-simple-dsi.
- PATCH 2/2: Add a separate driver for Starry-er88577, and Use the new mipi_dsi_dcs_write_seq_multi() function.
- Link to v2: https://lore.kernel.org/all/20240601084528.22502-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V2 and V1:
- PATCH 1/4: Delete some unnecessary information.
- PATCH 2/4: Use the new mipi_dsi_dcs_write_seq_multi() function, deleted some unnecessary functions.
- PATCH 3/4: Add compatible for Starry-er88577.
- PATCH 4/4: Add starry panel configuration in panel-kingdisplay-kd101ne3 driver.
- Link to v1: https://lore.kernel.org/all/20240418081548.12160-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Zhaoxiong Lv (5):
  drm/panel: boe-th101mb31ig002 : Make it compatible with other panel.
  drm/panel: boe-th101mb31ig002: switch to devm_gpiod_get_optional() for
    reset_gpio
  drm/panel: boe-th101mb31ig002: use wrapped MIPI DCS functions
  dt-bindings: display: panel: Add compatible for starry-er88577
  drm/panel: :boe-th101mb31ig002: Support for starry-er88577 MIPI-DSI
    panel

 .../display/panel/boe,th101mb31ig002-28a.yaml |   2 +
 .../drm/panel/panel-boe-th101mb31ig002-28a.c  | 298 +++++++++++++-----
 2 files changed, 215 insertions(+), 85 deletions(-)

-- 
2.17.1


