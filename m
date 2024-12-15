Return-Path: <linux-kernel+bounces-446600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 951CF9F26AC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 23:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01D216478B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 22:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C861C3C0A;
	Sun, 15 Dec 2024 22:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OPpSKvIn"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6AC1922F2
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 22:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734302658; cv=none; b=ZrfnjwQ1hs4/wOO4RQtQOMyekLNBiwiNRauSbaf9e1FTvNfU98pyuc8HrhRzOX1PA+1iloyEO50juPjhnujr0EOlRPkv63A4H2gK3+wwyqfEAxmKQBqLZHFcgrGMd/euW+vhyBeLmEtr1ebHD1wz30j7kV+swh9z+pqxlgPsYPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734302658; c=relaxed/simple;
	bh=Wpqm+AyDhFEWkmbxwA9sIDOpZewkcmgIhwh63TRGv8s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bGwoq+93KXWF29U5GV4AsXo0H4IvQtotnr/1E26osAI3R/SuA4I9aMVXptouyfBpSbamNVzbHqm4WEdIch4awCgLOiyRRPyBg4gRnw1SG85hUrMf2LTouVlu2SglBlQD0NXld28SWKEXcGORiqmJ2Buxo3RLclSJbm/ClwiAsQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OPpSKvIn; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30227ccf803so38805991fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 14:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734302654; x=1734907454; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wiyM++KsOVFJwW6aj3SElwGQilAMp0843gWRbVSsNyE=;
        b=OPpSKvInWGiF4hooeQmq0gPf/upyet/Zd8YV1zwYfNXm3QdR8JfOJylT89B9+yO5Ur
         4YWl0Sl5DtStRwOjvWCOSpXoKy8OXzbv+g9Xv2SDhA+XJ/DNrNPbvZeWYT8mFRlUziqt
         mPCS5qdsdwRDUZ/T1ry2kjU9YfnXIo5+1EJ7zS4Go8mLema9MIOL18aEkYPwlwjZEwBz
         P5aX98uDY29G3lImctVrS9b9UKPaEidQfG6iTka5dHx2JWO6XGbNzV6t72jMB4I8cV+8
         k1kiX0eDAfVmwCeabmXmENjod7OYaWysKPIUAQS39KPUVtkZQ/KHMdgA10Nfs2en7JQ9
         sbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734302654; x=1734907454;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wiyM++KsOVFJwW6aj3SElwGQilAMp0843gWRbVSsNyE=;
        b=qGXhQP3NyUV6dVd2bPF49ppyt0pnqYShwNDaldVTsNUnKPVQTxA5A3FKuAHS3HjmWG
         IJ5rWo/0RS1JhLYRS97EvLcCEKTTJiSntELiMX9EQlQ3bahJIoGDyBCBR61wUGcgVheC
         rh/lt/ZVbf8OYW5RVe//YaFNAjs60x8FjhOAu4qj58Ub3ycYgL0kP865UmqjEg3NhmZZ
         2dkwz2CGrX8DsmpU+WVTwmidaTs4WlZmskttHNlkaI7Jz8wtdwxEmy2ET7qX2eF0Usl7
         bqWvtNBVhb4uVlCIumgNCFIMYq1xvkEXNRNgm3QzzJ6BhlJ6qwJcd2LWydcpDTsJuyMz
         XLBg==
X-Forwarded-Encrypted: i=1; AJvYcCWOIaGekZvi1in70UHGnsMQ5DemKvVVLI+ioX7y+xkRr68NMWYRFK/6i8s4DbcOkqltnNuYuoTk/FDTMfE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgbx0mhrZw7RezC5AEwLij5MxeAzNbX+2BqJEsmahr27+8Zg8G
	iykHca2+2pf5KDCjDQ2e0AlW3g9O/TI/8qOKqQP7CIFJKFxSy+1roCF3vUlyxw8=
X-Gm-Gg: ASbGncvM6Q2KRU/KFj5SkHFn7jkCFtKtUKMQyXgbUb7kYqb3huugjfMLIm0bbnwxR9v
	fV8t4uDg083ZBMAteecfP4uLQ8rbepAzm9WaVfFyOj/qV58jhSa348LgcqcLa4tQAZ5QhaDW+tP
	S112h+ntUi6FjRvCoh601JOsUw2mVB9oHXbZr1ZDDBi/ADauxmLtlJLy81OC4zOfW31dxgGaP2z
	xEWBMY5jgRJOFIILLurB09OlmlwxsheGhFc1s5CJ6XOdscD964e+HzDAvS44qbS
X-Google-Smtp-Source: AGHT+IEOhOyrKe1fLpCJJfj1HpV10RlKePzB/U3HENJTDq1jhvZe00iwG9BTg13phbpjEcOYuHRqmQ==
X-Received: by 2002:a05:651c:a0b:b0:302:1861:6df4 with SMTP id 38308e7fff4ca-302545b95a2mr31173471fa.35.1734302654082;
        Sun, 15 Dec 2024 14:44:14 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-303441a41d1sm7201701fa.100.2024.12.15.14.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 14:44:12 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v4 00/16] drm/msm/dp: perform misc cleanups
Date: Mon, 16 Dec 2024 00:44:05 +0200
Message-Id: <20241216-fd-dp-audio-fixup-v4-0-f8d1961cf22f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALVbX2cC/23OzQ6CMAwH8FcxOzuzDxjDk+9hPIytwBLDyCaLh
 vDuFi5q5LL036a/biYJoodEzoeZRMg++TBgKI4HYnszdEC9w0wEEwVTvKSto26kZnI+0NY/J6x
 robUEU0PBCO6NEXCwmdcb5t6nR4iv7UTma3fTOGd6R8ucMlowqwEaxWxbXu5+MDGcQuzIymXxI
 fDZIwQSrua6wk8pZ9wfIb8IvktIJFjDrSqhco2RP8SyLG/EYisrOQEAAA==
X-Change-ID: 20240615-fd-dp-audio-fixup-a92883ea9e40
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Paloma Arellano <quic_parellan@quicinc.com>
Cc: Douglas Anderson <dianders@chromium.org>, 
 Stephen Boyd <swboyd@chromium.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3146;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Wpqm+AyDhFEWkmbxwA9sIDOpZewkcmgIhwh63TRGv8s=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnX1u4wieuIPQwzqElGGzCtUpWfcSN8u5hmioBG
 RarSfXTLzWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ19buAAKCRCLPIo+Aiko
 1RJcCACHIiksgRxZonl/xVOB+7hh+ZEPQ+0ON2piCtujhFjfY4qqgmkz0jzhN89O3CsYSmJtMca
 Ay3TCNKsqVU/ePat29r97DSBJs6y/rR4JLt6Mznv+mSNsapkLMvzguM6O9umxUe5WzqRID52g5M
 8EnVYbpmp3hDmdqVUiUE+eKQdmVzNw4E9jj7c6py2rgkLv+keNS1rzyZJ7UcKs+4wgoqjrO27KN
 LP/82VaUeROMzU8kUkSS/nYgK+PhQD44gU2b/U/5uCfNS8i8BsGUsA/IqRrptXX3vZqd9TNzIgf
 2x7cFeOF8A9Njdoei6P0E6bSqckwZdwML+b4jw+AYrDhbq3I
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

- Fix register programming in the dp_audio module
- Rework most of the register programming functions to be local to the
  calling module rather than accessing everything through huge
  dp_catalog monster.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v4:
- Rebased on top of linux-next + msm-fixes, dropping picked up patches
  (Abhinav)
- Reordered patches to move dp_audio patches earlier (Abhinav).
- Added several more patches, dropping dp_catalog.c completely.
- Link to v3: https://lore.kernel.org/r/20241212-fd-dp-audio-fixup-v3-0-0b1c65e7dba3@linaro.org

Changes in v3:
- Fixed falce -> false typo (Abhinav)
- Dropped wrong c&p comment from msm_dp_read_p0() (Stephen)
- Changed msm_dp_aux_clear_hw_interrupts() to return void (Stephen)
- Fixed most of line length warnings
- Link to v2: https://lore.kernel.org/r/20241202-fd-dp-audio-fixup-v2-0-d9187ea96dad@linaro.org

Changes in v2:
- Set safe_to_exit_level before printing it (LKP)
- Keep TPG-related functions (Abhinav)
- Link to v1: https://lore.kernel.org/r/20241108-fd-dp-audio-fixup-v1-0-40c8eeb60cf5@linaro.org

---
Dmitry Baryshkov (16):
      drm/msm/dp: drop msm_dp_panel_dump_regs() and msm_dp_catalog_dump_regs()
      drm/msm/dp: use msm_dp_utils_pack_sdp_header() for audio packets
      drm/msm/dp: drop obsolete audio headers access through catalog
      drm/msm/dp: drop struct msm_dp_panel_in
      drm/msm/dp: stop passing panel to msm_dp_audio_get()
      drm/msm/dp: split MMSS_DP_DSC_DTO register write to a separate function
      drm/msm/dp: pull I/O data out of msm_dp_catalog_private()
      drm/msm/dp: move I/O functions to global header
      drm/msm/dp: move/inline AUX register functions
      drm/msm/dp: move/inline ctrl register functions
      drm/msm/dp: move/inline panel related functions
      drm/msm/dp: move/inline audio related functions
      drm/msm/dp: move more AUX functions to dp_aux.c
      drm/msm/dp: move interrupt handling to dp_ctrl
      drm/msm/dp: read hw revision only once
      drm/msm/dp: drop the msm_dp_catalog module

 drivers/gpu/drm/msm/Makefile        |    1 -
 drivers/gpu/drm/msm/dp/dp_audio.c   |  379 ++++------
 drivers/gpu/drm/msm/dp/dp_audio.h   |    8 +-
 drivers/gpu/drm/msm/dp/dp_aux.c     |  216 +++++-
 drivers/gpu/drm/msm/dp/dp_aux.h     |   15 +-
 drivers/gpu/drm/msm/dp/dp_catalog.c | 1340 -----------------------------------
 drivers/gpu/drm/msm/dp/dp_catalog.h |  128 ----
 drivers/gpu/drm/msm/dp/dp_ctrl.c    |  607 ++++++++++++++--
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |   19 +-
 drivers/gpu/drm/msm/dp/dp_debug.c   |    1 -
 drivers/gpu/drm/msm/dp/dp_display.c |  157 ++--
 drivers/gpu/drm/msm/dp/dp_link.c    |    1 +
 drivers/gpu/drm/msm/dp/dp_panel.c   |  276 +++++++-
 drivers/gpu/drm/msm/dp/dp_panel.h   |   22 +-
 drivers/gpu/drm/msm/dp/dp_reg.h     |   19 +
 15 files changed, 1278 insertions(+), 1911 deletions(-)
---
base-commit: 952b5ed3020b50205f223e28ab182539210089c7
change-id: 20240615-fd-dp-audio-fixup-a92883ea9e40

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


