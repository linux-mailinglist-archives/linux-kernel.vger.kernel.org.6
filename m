Return-Path: <linux-kernel+bounces-316244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6897F96CD03
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8A9EB24529
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3BD14F9FF;
	Thu,  5 Sep 2024 03:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KfsoBZyB"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEA614373F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 03:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725505710; cv=none; b=qaVLtO7TaBBXJWJr1PUyYI4ZQgV8ZdnAqqjt5BehvMu35XFYxmJGMrUm2YmrcMmEhrqaI9h4AVoCKeUZnNlhod1h4v32jZ2NYs+Wqp/EUX0Nltpe3igmf1CYZ/lqCtJVaFcO47Pay7NHZ9LgNmBze+DciP0ikKr2p/BCHnkfR7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725505710; c=relaxed/simple;
	bh=BCbsERjKTr7ofnF9wFZIPROtJSJ8qvwLvP3xHx0S1jE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mhauS02701P56EEY8mkzKm0Y21WkQqtH+JbULIb0xCMofCB4I9U+INI/oSVvfi1QDDfYOCQnWzCjXXpZ6sRa5Vm/rUDyD0nhOk+MlWFRp7hBRa0bTj2yj+rcm+VseP/lf7fJO7iwvryaqhtyptFcRAEekGXzPth8TqMTgZm4ilY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KfsoBZyB; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5334c4d6829so229062e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 20:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725505706; x=1726110506; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wg90eho1NN5KHQOILS8jppGY/NSDMd/xispQJ9CCEd8=;
        b=KfsoBZyBq/CiTnaaOCCyfUJsgGHRWUHdSdzuFcqmjaihJneXb9ejDiU8fbY3SpYzO7
         osxj7AKWATzaWuzgmWub+E1d689Et/g9JtB2IEvVUc59VbN/LOoBswEGM/tSUYOSVVVh
         X8ZQMwafrTrlMD5PT7ujYAluvHar6lKrEjYNzzsJ8vgaZJDM7CekfCMvhWDIju0bq5Wa
         2iSD4HwDYUdTAYx0oNWHzHH3fWzWIyljPcHGYegWgumdyb3WwOAqBMD059aD41iCLXJg
         g+KXZ90Wlu+qR5vt8M4silbGBxU6v/EPy53jKMMGGt6mRHjMW9PtMtIkot37gXnkyQjE
         aPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725505706; x=1726110506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wg90eho1NN5KHQOILS8jppGY/NSDMd/xispQJ9CCEd8=;
        b=ZRaUPqXaM4XFZbJdjJE/FVXOwQke29ThM4elWENlPJbUUeNsZjP2YzJxMeySZs30l5
         uDrO1FtbpylvQwPOTqzh7kTd0R7Wm5JyBEB1NbqasSlS0kYwMjHIIuwl2ZMEaFAD9mjv
         fBSg3oXf2f9rMbdnMqR8t7QTgmKXwD9UBpE/XmJ+WfF1YgSTz9Bash992Nx+NaLbX0Hu
         tQjMcrMHLmMD4c1IW47R4EvbVf9Tllag5orKJ3k/VZDV1SbE1yM098tSq0s4fA94iVaq
         Aj9uQStSgXtYZIisntPDBzSMJtTt+WpJH0uR+Ad7HklOF7hOCmBzqVrNe8hvf8HNclq0
         d3uA==
X-Forwarded-Encrypted: i=1; AJvYcCWDM7uMxBt/oCOhmN0JNdeJ8dM1MdgAWiqtswlXv8nChOA4+A1jU4gSnK3M7qbHoQ5KZeqv0aYXz7LO2pE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHVRe3NpcMPBqOgbjKBVGbEnlvY5kLE5EIPo1PGU4AHqYzgRc2
	82MW4asIPmtRF3akQvcq/KYadlE5luCx97VIQrgrcYzZaG32AR+ZPH6CeLczSyU=
X-Google-Smtp-Source: AGHT+IFS2SH8V6BfMue9a/tZMnJv31NuvpbvMZDdc2zfWEvaj2lRGOa8zyeQpUNMbYTS6CvNIU5M1A==
X-Received: by 2002:a05:6512:3e26:b0:533:43bf:565d with SMTP id 2adb3069b0e04-53546b45292mr13195276e87.27.1725505705252;
        Wed, 04 Sep 2024 20:08:25 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-535407ac190sm2485277e87.96.2024.09.04.20.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 20:08:24 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 05 Sep 2024 06:08:22 +0300
Subject: [PATCH 2/2] drm/msm: add another DRM_DISPLAY_DSC_HELPER selection
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-fix-dsc-helpers-v1-2-3ae4b5900f89@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=961;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=BCbsERjKTr7ofnF9wFZIPROtJSJ8qvwLvP3xHx0S1jE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBm2SCmybu00XFAc9fujRRSrrHOHRKtSvgq5E7u+
 0ErMTKGuXaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZtkgpgAKCRCLPIo+Aiko
 1Sl9B/4zozy7yVS6RWpddXd9g6pE9XQMwgmW3D/LAFsWvdrVOcU5BdpMBXwAQ+3gnaRYYaRPGGR
 PQUnF4sf1JHAdvX7eftAQDwZqm1zS8sVpf0fkr+UKSF7wHKEozTwFKwUmHkMmeFnteiAz6D/DRf
 wB+GPvicWfQLGpW3QiXxv+7da8MRnB06s/P0d8N5G5I6ivuROWVNAQVrg0auvA5blTVz71UKafL
 pnPLsSrxE0BSdm1EIJRWgbIMcyr+X5tuhR4pQlQTSJonqC0i2MymA+Qxq2tF3DK5lTU9lXDK4uT
 wRua1p5tZQAvJqJTsLuK/5Jbd1JhWE09gePQQPwqeJh+hXUK
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

In the drm/msm driver both DSI and DPU subdrivers use drm_dsc_*
functions, but only DSI selects DRM_DISPLAY_DSC_HELPER symbol. Add
missing select to the DPU subdriver too.

Fixes: ca097d4d94d8 ("drm/display: split DSC helpers from DP helpers")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409040129.rqhtRTeC-lkp@intel.com/
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index 94d3ed4f7761..c8dda0ebd043 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -92,6 +92,7 @@ config DRM_MSM_DPU
 	bool "Enable DPU support in MSM DRM driver"
 	depends on DRM_MSM
 	select DRM_MSM_MDSS
+	select DRM_DISPLAY_DSC_HELPER
 	default y
 	help
 	  Compile in support for the Display Processing Unit in

-- 
2.39.2


