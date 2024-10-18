Return-Path: <linux-kernel+bounces-372405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A53249A482D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200C91F211EA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A50A20694D;
	Fri, 18 Oct 2024 20:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ya5tsoGl"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A9E205AD0
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729283676; cv=none; b=o6br421UyDpgil34bXKKcULK64WM6kN2Msep3FK0Excbtl1n7VGZSpcTWGsp5hl+NhOSRbFqJWGA08bxI81n42bVMwn9gTLJxO9DFlgsY8iYZBsYkqXEEwOX9Cdw+9eh0VThpJMQCy6+f+j0MHpKGovwUK3amEDNHRDSoc3sCNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729283676; c=relaxed/simple;
	bh=NVgLRwt8YngxLk2l766d34PGqOxCoja034TmXCo3gEs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rX7lSeKQohgdLE6UaM6IdAn/OyFivPBXLCvlm+cobTHOJYfoeMEbQiYh+bMKVSnXsvH/jOieczVrpNo1jMvnd/+aF3O+wY+0tSNq6ARxCYiQzV+qHEbFtEgmSDEI1ql0l3yDhlFTzMXYxoWkXQanQTss+cwjqqUw97/ffVOXF4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ya5tsoGl; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e7e73740so2414342e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729283672; x=1729888472; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sCcPwV47XH0yJdbksS/rJtyE3ZkZ9IgFn3oQZBYAYBs=;
        b=ya5tsoGlmVUJz2pV2GkRsvOMT8lm+88ZpBT/ZsuRqPK40TPougtxG1mNL+E1PnO2hV
         MqTcIMPbyeVKVtkGhCErNRhTLyCmWbP6JmA+jN+BiwgMBulFWpHWOEI29HWvmeysMvEF
         YssjLJz52BQUT4cA8LyFa96enyJpCFaTqdmvnj2w2CWXR7RAplMJ5jGThyVTpgJsEYpF
         L9uyJkQWXCRxjEmR8a+L64JpALEfHxav7tHUfpuMpbgGaLc6XhpcsUg8MszaAtZqJQAV
         6cvGoPmDVStakXZM78MgbXXJNJT2nuqrU4u/mzGA0E2/WlpTDnWKHlEfRw/acDp1wJXl
         cIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729283672; x=1729888472;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sCcPwV47XH0yJdbksS/rJtyE3ZkZ9IgFn3oQZBYAYBs=;
        b=MmZdXYXQIVQDajj0XGVR91NWi36glJRsvLYCNjgitqP+GuzYrTu1H0BemPMLP49IS0
         Qd3UI/ISOhr/pjQC4Zf7t7QzqDkemE682StICUytofDZlaXL8zEZqv6SULz1Dv84vn98
         bhMAssI2FhRnmRZV9YJVjgcONzH9WAKBSq7t38c95mgu6QYQ3k8wQ+LYGNeIkAhF+lMn
         lPxPj09851PW9NYbFeW/eZCSH6Xy6Fv1jMKrmeCTXF4/1rh2+zEAN+d/iEEWXDG7dmHj
         l2SjKlv4DfG3gFDsLnFLCMtdOrh45QvJf6KbXw+0OCQhDAXMaC5Yxugqw3542Jy0Rugs
         Q1og==
X-Forwarded-Encrypted: i=1; AJvYcCVzRbzWfQq0PGCU34FqxowkxKl6i7BreUoi9YFU47r+YxqgoPWK7tEHtCCqCHAMM2IvshJNpRQoOJHpLJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSSgptLiOUHna6yoUJhheXOV95/PxuCP8LIt7d1InKmIhvvyI9
	iAC+iMRVvr+pMnOPIOBntY2BAeNJdEkUpkrTcaXk/owOdqjYIjxglL66XDDsaIo=
X-Google-Smtp-Source: AGHT+IELPtenzGW4LLaGWUAYzBlOsnHcuhLHJ49lUB7TfHK/mvIGRg0GSftC9WVPQgye44/HgrcATg==
X-Received: by 2002:a05:6512:1387:b0:539:d428:fbf2 with SMTP id 2adb3069b0e04-53a152170ccmr2519278e87.13.1729283672001;
        Fri, 18 Oct 2024 13:34:32 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151f0e09sm314047e87.146.2024.10.18.13.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 13:34:31 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/6] drm/display: hdmi: add drm_hdmi_connector_mode_valid()
Date: Fri, 18 Oct 2024 23:34:18 +0300
Message-Id: <20241018-hdmi-mode-valid-v1-0-6e49ae4801f7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAErGEmcC/x3MQQqAIBBA0avErBtQMZCuEi1EpxxIDQUJwrsnL
 d/i/xcqFaYK6/RCocaVcxqQ8wQu2HQSsh8GJZSWQhoMPjLG7AmbvdijteS0VmYR0sGo7kIHP/9
 x23v/AGP7nrlhAAAA
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1527;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=NVgLRwt8YngxLk2l766d34PGqOxCoja034TmXCo3gEs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnEsZWTzWWmG5oZnAvNyyF1pWnZXCGdwJa35Rle
 GgQVwoA06yJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZxLGVgAKCRCLPIo+Aiko
 1YBNB/9soM6Y9tnx5H+1z9yVAqXzFA2tjpHv/OUSQ/QJrgTGwHmMNVvs8UGD+b5nNxwZIi06/eG
 mlCQ67VnWcoy9ujIYfTcMYLozAEAZ01tgSB9DR7HObujc/XwiC+X8gWLQdPxV4FJ9tNHy/KCzr7
 dujoIoUyiNpD4N5o+67DuTbxTptGAwxhyYT5pP9qVNFXGom7P2bmDPQzaWzVV6tyhcKI1tVTy3b
 liBsVRSceDQf4G/OX/tYWsOxp4ZogmNzFLtny0b0eMGaWJkGgLLn4AnwgMP/LuJTbA4wfa5X1bt
 ZfojiYFL+0Hgx2XNPRHTvRLcpebRRnTE6IML2YkVsDihRZan
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Several HDMI drivers have common code pice in the .mode_valid function
that validates RGB / 8bpc rate using the TMDS char rate callbacks.

Move this code piece to the common helper and remove the need to perform
this check manually. In case of DRM_BRIDGE_OP_HDMI bridges the check can
be dropped in favour of performing it in drm_bridge_connector.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (6):
      drm/display: hdmi: add generic mode_valid helper
      drm/sun4i: use drm_hdmi_connector_mode_valid()
      drm/vc4: use drm_hdmi_connector_mode_valid()
      drm/display: bridge_connector: use drm_bridge_connector_mode_valid()
      drm/bridge: lontium-lt9611: drop TMDS char rate check in mode_valid
      drm/bridge: dw-hdmi-qp: replace mode_valid with tmds_char_rate

 drivers/gpu/drm/bridge/lontium-lt9611.c        |  4 +---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c   | 12 +++++-------
 drivers/gpu/drm/display/drm_bridge_connector.c | 16 +++++++++++++++-
 drivers/gpu/drm/display/drm_hdmi_helper.c      | 25 +++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c         | 12 +-----------
 drivers/gpu/drm/vc4/vc4_hdmi.c                 |  4 +---
 include/drm/display/drm_hdmi_helper.h          |  4 ++++
 7 files changed, 52 insertions(+), 25 deletions(-)
---
base-commit: af44b5b5776cc6ac1891393a37b1424509f07b35
change-id: 20241018-hdmi-mode-valid-aaec4428501c

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


