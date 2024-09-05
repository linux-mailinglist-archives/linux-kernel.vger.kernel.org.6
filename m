Return-Path: <linux-kernel+bounces-316242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C7696CCFF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19EAC1F28DF1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E25B1487F4;
	Thu,  5 Sep 2024 03:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aBYe0GCo"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E9C140E30
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 03:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725505708; cv=none; b=k7SRC7ZByH3qPAY4e/ig3dCD3D0i4zy00aWp713bOiX625gtYJTltbhf3CYPi+k3/0D8/VX6rrXTTttsNCyrGdZPgajDbljtPuH7K/rWzNQRjh2OExVRs0W3o/ZLwaCCiahREOSMrEEtl4h0qD4/LMzdL2g4D/m82o5OoMR3PoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725505708; c=relaxed/simple;
	bh=/uc/spJSdC+Q0uOvIRVDDGVfhgEPfChpAlvRBCMAkJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jZAUkRwYACRvgpfpDs3AUrSj/sMuk4fAom89CYwkha+oaQFp9AkgiOLRxegd5L845mYviSmHL9NWFDFbEjJS4CcRimcwtNxazvGRmBj+qeyLPfqidFqpdusA8VijLQIK5iFxx/X6NHDq5BGykTumOLdJOqNxWtlfbvoLuKjXpfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aBYe0GCo; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53653ee23adso3924e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 20:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725505705; x=1726110505; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aCUd9z1LcLMx6hSjP2k+xgb3eFs9dKtX8QI9QhSVFF0=;
        b=aBYe0GCo7NICxWqfVblVqsbMYUI9GOMQzTwz+trBlzc1OK4z+skkAtcVyei33UEuqW
         PYxV7/FyR8h4QIXN2xdPHVQZE8t9O/bPv2HugXPw0mUwdhVSG/dIUXbOoZNeQjG8XszH
         kWHTyTG23HeZSjDG4XXjj1+TS7tYKalRum4AA4/R8aftFM6oTzN6cUIxwjAvsDJ0JZwb
         MLEuW7AFCuydRR2+RpId/8HsiBIlxb3+OYYwYOyAzZDy78ttTgULIhi7q4Hbp2g7OmqS
         7XTQBu/tBiU/1X85fHgwZftcwZ7aUkZFECfzHktLqhpiq+syDEp5NVEpX1/U+0+kww2r
         ViFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725505705; x=1726110505;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCUd9z1LcLMx6hSjP2k+xgb3eFs9dKtX8QI9QhSVFF0=;
        b=HM+6+2ia9TXOFsXyi+lttdI7gW0uQC+XqhO3C2UBEKtKnGvathO2BRzK57NqkzC/Nd
         8sTxXbO8nYYEon4l4kJD8bYqofNOUyxTEA2no3iEErRw51XW+TRH8pu6A71BG4Jd3Pck
         aNEslPzhCRrhwjBVDmClMTnAcuXf9bBj0i8IxYOKZGlYNoMZ5AnyB+xTFiJeDRqlXMWV
         Cbu5cEUlpWyx+fEPbTaKRkI2y6hc0VFEKte1JdGZap/FiWH4KQ3fm40EV5uPKvzrRCpC
         bKEEE4Acy7V+a8HdGMKA3BMU18JxiqI1cGQjwwLuntHbPlLSMbL+XAZSithsGhdH6ehx
         AQ+A==
X-Forwarded-Encrypted: i=1; AJvYcCU2s2vHK5v9Tm2cyd86qP4BqvyNwzEzrTqPu5K6LmfWfEpOaGChSu/LfonLjJPlkWENiiSgSX5ItYZMxMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA/f/9HcwAcvL6o1rdfU95VmtaZiuRr+OWZQIM0luvDvfIYHS5
	zbn5PxuQICEyBoQae+pxJ8ygsR6oJN5Zs7o+skPfIs6tFnv881N+VeK+uYRfKc0=
X-Google-Smtp-Source: AGHT+IE/2jE3CvFlvvIXHzJupYuHbi2/1IhdOJoiEbZkzmE63Jt8Mh6dMcluwOLczC02VOgLi+O/ew==
X-Received: by 2002:a05:6512:b82:b0:530:ae22:a6ea with SMTP id 2adb3069b0e04-53546b91ef2mr14631592e87.40.1725505704199;
        Wed, 04 Sep 2024 20:08:24 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-535407ac190sm2485277e87.96.2024.09.04.20.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 20:08:23 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 05 Sep 2024 06:08:21 +0300
Subject: [PATCH 1/2] drm/xe: select DRM_DISPLAY_DSC_HELPER
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-fix-dsc-helpers-v1-1-3ae4b5900f89@linaro.org>
References: <20240905-fix-dsc-helpers-v1-0-3ae4b5900f89@linaro.org>
In-Reply-To: <20240905-fix-dsc-helpers-v1-0-3ae4b5900f89@linaro.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1005;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=/uc/spJSdC+Q0uOvIRVDDGVfhgEPfChpAlvRBCMAkJQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBm2SClH3jAjsQwXueRbupby/Qyxo1pNCBRE+FYy
 TrQumjDJhWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZtkgpQAKCRCLPIo+Aiko
 1WUdB/4mLKT7toID+4EsvnWOp5TQO7a7GiChrUuI653sWs0XNN89QO+aQlpsdo+wgVvTcrvWvBO
 C6i8x2AwjrHm9cSIn5uu66DDhCRRCiCelWh8vwvtQNgwDP30tOt38PSkFuLdZhEQfeJZvBPBC/u
 JS/Y5Npl49z2KqrYk9QbimEg9oy0KI9Aj0nva6UW5rNWFw0ZBy1d2taaUr/KBPdp1F2VkUtoWtx
 ecBErdsaSdt5CHrTfB4FXFE8eVr083nB6qqd2UQNsHA2SdUD3IFLJCk0zqUkbyZ0UCXzgizmuf7
 vixPcb25txPAUaZD+YKZIsHQ2gGnzMPV7x1YmszSmdjXVpUA
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The Xe driver shares display code with the i915 driver, pulling in the
dependency on the DSC helpers this way. However when working on
separating DRM_DISPLAY_DSC_HELPER this was left unnoticed. Add missing
dependency.

Fixes: ca097d4d94d8 ("drm/display: split DSC helpers from DP helpers")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409032226.x6f4SWQl-lkp@intel.com/
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/xe/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index 7bbe46a98ff1..ebd0879e04d4 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -14,6 +14,7 @@ config DRM_XE
 	select DRM_PANEL
 	select DRM_SUBALLOC_HELPER
 	select DRM_DISPLAY_DP_HELPER
+	select DRM_DISPLAY_DSC_HELPER
 	select DRM_DISPLAY_HDCP_HELPER
 	select DRM_DISPLAY_HDMI_HELPER
 	select DRM_DISPLAY_HELPER

-- 
2.39.2


