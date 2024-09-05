Return-Path: <linux-kernel+bounces-316241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B37896CCF9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416DE1F28C9B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CC325634;
	Thu,  5 Sep 2024 03:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gb7qhpmG"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D2613774A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 03:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725505708; cv=none; b=XYKmZvq3Krmmslc9O9qcLOGwt/4WcSUNSyCSK0cf2rEUrDCOXK/Ck5RgZDI2t5ZCu9DVGuxcjOpzRKIpYT9erFlOYHaz9K+O7GZvH5ZKtW9R47eUYyvz4wUlLaSljArnM5MP/VR1C9yehQ8FvE9bDySb8qFq83iFndopt0eyArk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725505708; c=relaxed/simple;
	bh=viS4n3xLp03m75Vm5VBHdsK94DFv3lMuD1s+hR1hOlM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eA8SvMhlgjLlG0wdctbS1qVi+sQ3m3RPzpmSjJnnVj4w4N2s7PyL2/O9LCF83aRQ9qroZmzoqiUogmTee+gIKjH9hFWTjNDgVqTnbJFtNWatIJz5oEU8NlL5pdcS89DG/t2i8o1JJJHx09wDXHMPQD7VDO4zRQVDpn7V9hmUrh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gb7qhpmG; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53568ffc525so263794e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 20:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725505704; x=1726110504; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HvYt71IhRdNBRbqhn8a/BIchlxMJnpCn80h85xgik/M=;
        b=Gb7qhpmGD8uDhYdVHqLDq6GfOEtr2jc4skVeIdUasYrDe6n5mdd7/Bi8hH9UOqNMvl
         2qDsAu56+6AhXLiEOL0juEN/Zf0nZDHTW82mKCNdfg/Xznwjbm2qNuveRjdRo6gALj7y
         ZWRCFzng3pSaWfNPf9ZToEsedO2XqPtQtilihERx3aai9VPZeYKetwmvWL2XzRCM6Dzo
         4Ta0t9fXjHIqjWOBU+YsDC5SmRTMfv/QwpZ6IyQMwfRDO+4/tD2LvE/Qoz7lavt1qntT
         GH2XZr1DVUJqoSu0D1WdfNzQ5dfd4fKJAZVn6805ghB88iihhAAlhyfpDk460+ac9uji
         xEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725505704; x=1726110504;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HvYt71IhRdNBRbqhn8a/BIchlxMJnpCn80h85xgik/M=;
        b=XLEvuQ8qGQQr0gtultqMwyXc38qsl0VHUd3BFMuwBzBFEg0FgjTQlSCg00ch6Jzyi+
         mzvmlKIMiKbWyLEuJiJX4dDnlGfK7QbXWPv9kCrw0da9RkaoVAaSDhH0B5tuHrI/tXaS
         xS5Rv6ItsHAv2Jp1zyanaYmmqV6wO798njCvUUVziz//PGImC5b6ArUa/v5r4/kWSe4H
         T0eCN/yfRSDRbeEBH+rZrwXy1oJPtyEvy+9IkhjzxgsH/gR/YttKYRH52vdKxfobdIfp
         4YgC+J7n5tqzfUscBXY2+kRSPl0nK4XFMHt6swE8+NmT3buqpCySFJ9dVuvPAMtuQFfB
         7Mxw==
X-Forwarded-Encrypted: i=1; AJvYcCVuc5cmlTgVKIDHzm+G+dy70jKn0SfjTDJC8YXIp4LbqSkl8FZFKb31G1he6sRLM2sYv8Mv1vrVrQk3nGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz62SETb9l/G9UXE3rMIk3Alm3qa4DIiaA/ruIgSC7WEJdDOAuk
	A+l55+1AgaA0wMpFLEU6WyBoDUMxu9/TNBZnzbKjaabtKFn55SoErr2nv1mGjRjzOEtaRxzAZZ9
	u
X-Google-Smtp-Source: AGHT+IEiDYfVZsrNlZ5O8YNAwFl2737GXUD/v4D2IGhJ131AJFOBBx+cluZA8P+8k5TWguYcgEK3Pw==
X-Received: by 2002:a05:6512:2803:b0:535:6cf6:92f7 with SMTP id 2adb3069b0e04-5356cf694a0mr862945e87.59.1725505703317;
        Wed, 04 Sep 2024 20:08:23 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-535407ac190sm2485277e87.96.2024.09.04.20.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 20:08:22 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/2] drm: add two missing DRM_DISPLAY_DSC_HELPER selects
Date: Thu, 05 Sep 2024 06:08:20 +0300
Message-Id: <20240905-fix-dsc-helpers-v1-0-3ae4b5900f89@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKQg2WYC/x2MQQqAIBAAvxJ7bsHKIvtKdChdcyEqXIhA/HvSc
 WBmEghFJoGpShDpYeHrLNDUFdiwnjshu8LQqlYro3r0/KITi4GOm6Jgt416UN5uZvVQqjtSUf7
 jvOT8AfRsPL1hAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=670;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=viS4n3xLp03m75Vm5VBHdsK94DFv3lMuD1s+hR1hOlM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBm2SClVPVGX65kkU0QRSPr0U4aIl+tCD84SrxEb
 rkB79ppEqWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZtkgpQAKCRCLPIo+Aiko
 1VFjCACTrtFG/p4A2auGtjYg3mDRqLDcCvd7/H9xfsmeO1q8pLN+lwwLJ3mcHh7moIV1ykCamfk
 vsig0eklrVMOTjUN5El/ucqiO11eIGsaFYsyJvYAHh4HaBpiFDUZO6Oz/y+yMx/l/z7jW0jt4fG
 rkXsZJ9+w1HpA4oCLrmI78gViOgVETjg47JTRFY4BNJdUkNtyuN2UeJrN/0X3aD1Fwx/ifrJRxM
 a9SKoACBKOe/SAqoiVagQCseXyMW1mN34htWl/Csxw9P7nEFrp58F60+irx09GtyQXqu6fdsALa
 E6Stjms28Tz66hYuU5tyG/6yxg3zzDxAmjK5teFd7bli8OaK
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add two selects for DRM_DISPLAY_DSC_HELPER which got missed in the
original commit ca097d4d94d8 ("drm/display: split DSC helpers from DP
helpers") and were later reported by LKP.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (2):
      drm/xe: select DRM_DISPLAY_DSC_HELPER
      drm/msm: add another DRM_DISPLAY_DSC_HELPER selection

 drivers/gpu/drm/msm/Kconfig | 1 +
 drivers/gpu/drm/xe/Kconfig  | 1 +
 2 files changed, 2 insertions(+)
---
base-commit: fdadd93817f124fd0ea6ef251d4a1068b7feceba
change-id: 20240905-fix-dsc-helpers-3b8460fcb9af

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


