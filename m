Return-Path: <linux-kernel+bounces-439707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 361839EB2EA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2D5D1881B59
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177F41A9B3E;
	Tue, 10 Dec 2024 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lVw1oADC"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D3417580
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840215; cv=none; b=aHUn4PbcuBQthjSFFNzp/8aPAi8gSbEKGSf9mUYNDonpma0TdFgAtq/5MT4DjhXeUpErXDjohlTFW/wqgaf5knPPgsuKWT7pRYXUMjjUcXolyrclAvKDl/xk5ixD+1qwvqzWtmUFGzsHxXYtdQS06qSXgr0CaSNMybYN/cuoVxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840215; c=relaxed/simple;
	bh=5yWtH0/AHsQas2EHkU/GrIi2GqCzfjr8NZABeuJRXOs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ttxk7jcbYiIKZQs5riG42fApOWla+KNejxsc/UXsQYVVMbYU5YApGDZuVvB/CWlPKdtCMLF6nbC9wvK3ZgykCNciMEgn9B2sIgNna6MVQ75FikFWgUAWicVz0TkIMQEItep6LtF8vlacxdJUeJmVIVUetWD12EW4VpM77rdxw5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lVw1oADC; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d27243ba8bso8389069a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733840212; x=1734445012; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GwH0G8nePkS2BSjAdjZHUSwomZZVrTT3UjSpzowmTtQ=;
        b=lVw1oADCZsH7ZgfkfAAXUb+BTgQ/Qw/hZoNjftLGBUQwZgifoTZp5FRFzBofCV4btv
         1l7upmwFo6dgdzOv2Hq1rFDDj2dGfAiOrDSptT4/Q9loE1C7xJ/LgcTjc6Y5IDMTcjUa
         jA9/Xm9zHAnfbBFeSLgvxUAyKO69vsVPj+OdPL70jGcnnDS8OWaNDu9gb4FTqUTX/0Ut
         Cp2lNEMNImfslCMZpuuvr4Wla4tRxW6Fqob4ml3oovxvUr2YqaWjkb5Utgl3xOiECtlm
         MmlktNblP3ZT6vD0w7lfacHRpJQrIuY278JgYMRxgwkJQqamgz0j8/ONv1HxHBPxrVJK
         vGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733840212; x=1734445012;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GwH0G8nePkS2BSjAdjZHUSwomZZVrTT3UjSpzowmTtQ=;
        b=eMPp2G0+HmA4XkzlPEj0muBxRaqjduvhK7g4T/sjBYPvKmHYLH8meqbv7xR4uF6zrH
         2L4Rzot+qtRbPpVn/DPREECkHlgRgjrzxJ5/MdHjRmH2BVhG85sYbUmz6xMCPWPbPvZs
         bh2dMaKNLoCiLQaoNPJJoXmOQo59rHQRi0eqWRyN0sm3zw1v/Vt22mJ56jMy/bF3P9ca
         wunat0D5puE48k/Fb8rKH1TzwqrCID7W/8BRRkLVqUoSc8sTMAjiGGQ8ESS4A7HHjAyX
         MOoicJYuJSYxFnHzsv2VANT3zj0nqqO3Pi1Jffc1fbCbxqvtc6/VAdtofmnzoTg5faNq
         EG1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxQ+j3lIKKVZMmglML9kvnxHzws4mb9O8IEQvpqcXAYYytww/Y5HwqX+I1Ak6BHuXzvELGtxr0agilXkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtQCWo2YEpzum+GqYAYsTnydAaMpjJxX32plAS81gtHxqIr9Y3
	6kioBy7FOgyHycN8zmk9Irw8HtJEZGt313bpIqNdYDMO6nSN83lSuZ3uI8gKLlY=
X-Gm-Gg: ASbGnctild6AK//Khv7YLq4CM5L79fqFLn5qVoGNlfwYF7Qt3ImOJReSmSe8A8raEx2
	slUYL1YS7dL90EVONKajA3HE6CXwByKYUwvdzdWaTMNf5tIIU71wf0Dl//5jkQmv9SiC/s9rudZ
	G1RbNSBSdzOkDc5XqLREvDVfSkKIR0OGa2hz1walQIg06DIoz4X7DGth5ROwNJ9wVxA0rJ6jLay
	hkHjdfWtojqed7yGmbElFZAAUpKIwQkzQTYHjusPlMBAjMFwLt0KGGd+oNSHA==
X-Google-Smtp-Source: AGHT+IGWk/qbRHRjKqV0wfeV5P+rWVopoCMPfZBVc89GTsbwmZWowfsav1SqSjh4fO5srkk+bmeMSA==
X-Received: by 2002:a05:6402:2807:b0:5d3:ba42:e9fe with SMTP id 4fb4d7f45d1cf-5d4185319dbmr5684088a12.12.1733840211953;
        Tue, 10 Dec 2024 06:16:51 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3dc2602b0sm5104362a12.18.2024.12.10.06.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 06:16:51 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/4] drm/bridge: move
 drm_atomic_helper_connector_hdmi_check() to drm_bridge_connector
Date: Tue, 10 Dec 2024 16:16:46 +0200
Message-Id: <20241210-bridge_hdmi_check-v1-0-a8fdd8c5afa5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE5NWGcC/y3M4QpFQBCG4VvR/D5ba0OcW9FJ7Aw7icMsUnLvN
 vx8vvreAzwJk4dvdIDQxp7/Y0D8icC6euxIMQaD0SaJjU5VI4wdVQ4Hrqwj26uixTxDTBtTaAi
 /Sajl/W6Wv8dC8xrSyzue5wVsmTwQeAAAAA==
X-Change-ID: 20241205-bridge_hdmi_check-9fd86dd5b290
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1296;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=5yWtH0/AHsQas2EHkU/GrIi2GqCzfjr8NZABeuJRXOs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnWE1RE7/f5a24T6MflVG9Cf6Zh6wNv1sHzeB7U
 Re5U7qSIrqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1hNUQAKCRCLPIo+Aiko
 1WXTB/4idxCjQtZmhLjO7DL7OJyaix+Q8eg4eF4lr6z3ejiJF2RJWNH0GF5rtiNwILnhFTBCMqu
 omzbamg597QXtaYapZGMLnjiquloTdfZp4Q3g7hcGCcpApVJHuylTUE4j3fd5k04Nswo30z1dJf
 IZ/kJIwM5xlif1VVg0gbo4tj9qcHNMHoHflRwc7DoU6m+dTM5CduuKmj2m9yMlJDgY9Hvvbqfci
 dc/ignmbRRuHHCNiLuXoLJB1T3gQkwlVX1XQ3g4pbiMBb/jE8ITHyTtyaFBMZ/4VWvAruJv161Q
 9AT9L24chTox01OHwbKMa7B9xsiepN9knePLrlZ8bZ1cHpbm
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Reduce boilerplate code and move calls to
drm_atomic_helper_connector_hdmi_check() to the drm_bridge_connector.
Initially the drm_bridge_connector didn't use HDMI state helpers
directly, so each driver had to call that function on its own. Since the
commit 9a71cf8b6fa4 ("drm/bridge-connector: reset the HDMI connector
state") it depends on DRM_DISPLAY_HDMI_STATE_HELPER, allowing us to use
the helper from the generic code too.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (4):
      drm/display: bridge_connector: provide atomic_check for HDMI bridges
      drm/bridge: ite-it6263: drop atomic_check() callback
      drm/bridge: lontium-lt9611: drop atomic_check() callback
      drm/bridge: dw-hdmi-qp: drop atomic_check() callback

 drivers/gpu/drm/bridge/ite-it6263.c            | 10 ----------
 drivers/gpu/drm/bridge/lontium-lt9611.c        | 10 ----------
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c   | 17 -----------------
 drivers/gpu/drm/display/drm_bridge_connector.c | 13 +++++++++++++
 4 files changed, 13 insertions(+), 37 deletions(-)
---
base-commit: 84e541b1e58e04d808e1bb13ef566ffbe87aa89b
change-id: 20241205-bridge_hdmi_check-9fd86dd5b290

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


