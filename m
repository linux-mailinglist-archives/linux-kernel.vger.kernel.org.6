Return-Path: <linux-kernel+bounces-175038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD358C1974
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 907D22814EC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9EF12D1ED;
	Thu,  9 May 2024 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PBEI7HH7"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9D110A0D
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 22:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715294260; cv=none; b=OEUv3FYOvbSQibYU1QO4xiHmkx8WzqM7b4zjVsKnkAv8zVmawsu1d+7aGNuuDDZMuClawRDLevZWQ6J7h1kFhXiAOZsliXOYf9lI2U3AaRtCmZl+feA2ZufkHZ1IU/sljW8jyYc+pEytwL1aDjvztTEXey+4vDIOdmPFyo5Dms4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715294260; c=relaxed/simple;
	bh=VxcZp1w/YGAckFLVc2gsng7lHzErKTzZobRSJjoTank=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JDaBUEDNEfciso2C9UBSWwIE98FY+ORcActUvLgexPp1CE9mJF92WHcmhVTz8zcmauPgy9R82GzI/05TzHLdAsxwrQLpx7WDTZLxUV8qH7tbNhExqKJ6+G4WwrjefE9wGPHs2frYmDMxDzyj/TB6C1rNTOki300+e3ObGB1WWW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PBEI7HH7; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51ff65b1e14so1516979e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 15:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715294256; x=1715899056; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IwDfo96K4ZN1gvjMKsnALPIr6uZujP2Mw+2zG530qIc=;
        b=PBEI7HH70CwVuPekImxaNAyhYq3s2G9xj/UxYdFcniwVAzoEQnbqnfCrSJMDrnELph
         0mt0GfFM02pLFAxzcUwTR+z+vEtICpO6vR/9PajFHki/958QV7S9E/8akCFP8SYzyKe0
         vsvMXkJA5c3a7MG4t+9EG8ofekiJAt+knjGB7/c1RKKufvvvTgEA9sBEDZpi4Xh2om+8
         wNrMrB/qu1qjY4IzDWQKkwTvz0rrRFu+UVMTsmvBkOyo7XgXshWXEbL1hTNyZDLM78Il
         TIuGPE7xNnz6UBxL3ar+tAHlL11QV+G4fCslk7fiD9tI8f3CuYhvUC33GcDdCpHqF+ZS
         z3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715294256; x=1715899056;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IwDfo96K4ZN1gvjMKsnALPIr6uZujP2Mw+2zG530qIc=;
        b=f8rudbCsBPdDe4HoliWRfAvQnjdHCl5JxgZiMkuj4UXm4hmKmrfYKp7Ov4G8Q4RH5g
         hSLVh2pBXl7A1vwiPpnBt6cV4C4FhAojWWuyXwEa4wghQIS3EzInhRtlOn9bB71TzHua
         PIC6BcB4cuxv2pTqT3an9zx/7iyKSruuKZn+Yw5kP3yzAkdHcZfA/cJb9ugE1mYQOmh0
         BmXVyk0g+uJGjgB0SNNTpPie/ymSpgSJH1j1cFwt7wfwDirf25x8xmzvTs0uxa/UhKvJ
         NnfomNEgwkm2HrJh6KlYZSlcgrVAom9DhQRERklbdZOnEmkeUOymOn9pk7WqJR1r18q5
         djgg==
X-Forwarded-Encrypted: i=1; AJvYcCXU+dlkqp85TgDyZlOhnCUEyQ4vEqVMraTtfi5EKN+0IC0cs0VMgPWTihsyn3hXltiz6anHQBCETN6oJ45EYJpeZ54iUA3YMhh3R0SZ
X-Gm-Message-State: AOJu0YwEjDnKg6cEoWAieyYAFNGOcIS1kEcu65ykVFUf28QMSKz1syMO
	W9M7BWsVILJuPIL6u9OSSE8kJ7RW4+12C6keQOGmzw7gYmhP0Y8UXQ6IbuNxvvg=
X-Google-Smtp-Source: AGHT+IGh0M0O5qEntvykXCw1Hf9FQ/GL1VJ5wmKdoAgEPaW2ZM/BGtJRM/SOUMuG+gJBtyPWBzWThA==
X-Received: by 2002:a05:6512:3b94:b0:51d:8b86:6588 with SMTP id 2adb3069b0e04-5220f76f343mr666423e87.0.1715294256332;
        Thu, 09 May 2024 15:37:36 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d32f1sm457974e87.181.2024.05.09.15.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 15:37:35 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH RFC 0/7] drm/mipi-dsi: simplify MIPI DSI init/cleanup even
 more
Date: Fri, 10 May 2024 01:37:33 +0300
Message-Id: <20240510-dsi-panels-upd-api-v1-0-317c78a0dcc8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC1QPWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDU0MD3ZTiTN2CxLzUnGLd0oIU3cSCTF0Tc8vElCSjJINUA0MloMaCotS
 0zAqwodFKQW7OSrG1tQCYmgFLaQAAAA==
To: Douglas Anderson <dianders@chromium.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Vinod Koul <vkoul@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1721;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=VxcZp1w/YGAckFLVc2gsng7lHzErKTzZobRSJjoTank=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmPVAuMV3wx2gZaFh7kczhgwtAqtMTSfjEM9Uxj
 L8jsu8mx6mJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZj1QLgAKCRCLPIo+Aiko
 1UuCB/9yNsgxlbxhybmzf+kdUFmXa5mewjR7yrDjRzsCLGxkMG2OfBf9EbH/LkBTpAJit6Kq/pw
 cxFlLPJ1hFzZ2m6uWekZJjT1waOHg/OsZvpB0EiSFjUh7O2giMM8BnM44eKsFsSBtsKco+LoU0I
 i6fJOFKnDmdGtPxNDT/X+cxjoslYCBdkaNa46lGpZ1qXaorPzgViDAyP9kBHP1LwbaiRG5GsEyj
 6MCp83FWkGyrw4jeS6vNeMaws8dWFkLppISqsducdRIvzo+xVZM0XFegI8U8/0H7oB2czry5FSI
 lvn25E9NxdXCXOFY9wjJqKFKfsVWV/NECnx1ZfccC9aIMtTL
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Follow the example of mipi_dsi_generic_write_multi(),
mipi_dsi_dcs_write_buffer_multi(), mipi_dsi_generic_write_seq_multi()
and mipi_dsi_dcs_write_seq_multi(). Define _multi variants for several
other common MIPI DSI functions and use these functions in the panel
code.

This series also includes a fix for the LG SW43408. If the proposed
approach is declined, the fix will be submitted separately.

Depends: https://lore.kernel.org/dri-devel/20240508205222.2251854-1-dianders@chromium.org/

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (7):
      drm/mipi-dsi: wrap more functions for streamline handling
      drm/panel: boe-tv101wum-nl6: use wrapped MIPI DCS functions
      drm/panel: ilitek-ili9882t: use wrapped MIPI DCS functions
      drm/panel: innolux-p079zca: use mipi_dsi_dcs_nop_multi()
      drm/panel: novatek-nt36672e: use wrapped MIPI DCS functions
      drm/panel: lg-sw43408: add missing error handling
      drm/panel: lg-sw43408: use new streamlined MIPI DSI API

 drivers/gpu/drm/drm_mipi_dsi.c                 | 209 +++++++++
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c |  73 +--
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c  |  30 +-
 drivers/gpu/drm/panel/panel-innolux-p079zca.c  |   9 +-
 drivers/gpu/drm/panel/panel-lg-sw43408.c       |  74 ++--
 drivers/gpu/drm/panel/panel-novatek-nt36672e.c | 587 ++++++++++++-------------
 include/drm/drm_mipi_dsi.h                     |  19 +
 7 files changed, 578 insertions(+), 423 deletions(-)
---
base-commit: c09cb909a4fba9c42baa343bb9a84986c15d5f01
change-id: 20240510-dsi-panels-upd-api-479adb2b0e01

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


