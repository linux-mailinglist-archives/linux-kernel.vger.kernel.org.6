Return-Path: <linux-kernel+bounces-400833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D399C12F8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A54B1F23211
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463173FE4;
	Fri,  8 Nov 2024 00:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lzwmQQS1"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B7C1BD9CF
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 00:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731025303; cv=none; b=nuEvHcCQTEQUTYwl1Ss3+Q6L0YaTI8/mgCqLxyHvZaFcL2Dlb6VpYzSlKabmOlnPSp4cyyM/VFcjSic5tkMHciBH75e51chZ1VD1MyqNJhBu1g0+zDoKx/+3dVkC7s6Sgt71p+Q1Pevx/bNCdwk+qzGqfl8JdYufcmfifmN7Ppw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731025303; c=relaxed/simple;
	bh=r9WESZjKdOkeXGTwKva4YI7nk9aqwglx/YUyTfzdpvw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iM5VnFrScbu0R6nyFTsFUolvfLKMqOh3HNZ+wTX8Ts4vKniEuVAxnXez/1zCw55HIAQX6RKfPyZQOmQtK5yB7nQ452OewtlrWxxXWngbWd7qiI24ToS0kXkjDEH+cxT3Y/cKjyDOk2aPMgQeoG1d3GnPgRBS+kzJ4yFsm/9iwLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lzwmQQS1; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb5743074bso13389371fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 16:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731025300; x=1731630100; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XkmztPsPBVyoZtfInzYanDDrqrjRXuvhvkAniG80EPw=;
        b=lzwmQQS1yJpbBbk7GuG/vDwZiyd5lp3SkEYyF0ow+JaBIX/UPwcPkeGR7FmsI3te/B
         fC3WpLmC4Yrcb0kjAGMh2GuAB/iXtSYocHet0mJDdYjMy8blk/tilz9yvSFCo5I0m9L/
         UodIe10jYcTEmX6O832lFhmd+Zhu/zTos/TgRvgS+rLF8oUaivSBJv93mhnVEbOXv7wC
         jYEfVW6ZHMl8EFnKMQr0o6wrRZIDUI40cDrU+NAYSC56n5FapBaW5klLwRcc+80IF27q
         2Dxpsw4G938PX738DjxakVEp6pl61Z9fX2c1hKBlcFTm3OFklXmSKZ1D+XeoY/QgAe/B
         Zl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731025300; x=1731630100;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XkmztPsPBVyoZtfInzYanDDrqrjRXuvhvkAniG80EPw=;
        b=IGbjn/lwRW13yQcfPtTu5YKQq2w+clF5glXRvBkDvU9WoXLLgDRYx2Nx+g818IvREE
         klJdEZ0uHrtgaUKQIo5N/BCeVCIlQrikuo/e4+upbM8Fq/dS8efByH0aEgvAW0nmNaoO
         5J3NwnDSriVxSHytwVlNbA/Cabsyp3XCMV+16jhJgIQJCgZ3nX2ZknGmiu1ULW2MGIKv
         At25EFPfkxN7wFPuWeHiv1rjax9wBsYHkuvsBfDFDJPFi5tnPg6uBni2KOHsIXaPQqA4
         A2o+UYKfIaS1i33u1y53nBBuNc81hY6MuQOUACZcxl+6ofIaaBX2kM0J0PFQIPpFD1k6
         ghAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhVn3rWrUnNod1P7qZmxsExR4+7AoBcUBhC59WS30oiOh4HcnhShiRc4GBHFEpMmrIzKjWSvWXFbZyqmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU7K22PNzbNhvbpWMhQvq30qwp09s566b3iXBysciQwbmdRs91
	cn6kR1ho8/vQLJPDp5dYEEb07NE/lqqNZD5Ba+S6oZW6eSHB3J0x9HvA/T83ZA8=
X-Google-Smtp-Source: AGHT+IFbNMtUPns1qTynN8HZcSiuZu16DPiMYzRyHXArsYkIgDJIRH1ePYCu1PPeNPpy2EObDqkAyw==
X-Received: by 2002:a2e:a995:0:b0:2fb:5be4:3645 with SMTP id 38308e7fff4ca-2ff2072d207mr1892951fa.0.1731025299517;
        Thu, 07 Nov 2024 16:21:39 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff17900a63sm4195191fa.47.2024.11.07.16.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 16:21:38 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 00/14] drm/msm/dp: perform misc cleanups
Date: Fri, 08 Nov 2024 02:21:31 +0200
Message-Id: <20241108-fd-dp-audio-fixup-v1-0-40c8eeb60cf5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAItZLWcC/x2MywqAIBBFf0Vm3YDaA+1XooXkVLOxUIwg+veGd
 udwuPeBQpmpwKgeyHRx4SOJmEbBsoe0EXIUB6ttpwfT4xoxnhhq5ANXvquwt861FDx1GmR3ZpL
 wf07z+35uosEiYwAAAA==
X-Change-ID: 20240615-fd-dp-audio-fixup-a92883ea9e40
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Paloma Arellano <quic_parellan@quicinc.com>
Cc: Douglas Anderson <dianders@chromium.org>, 
 Stephen Boyd <swboyd@chromium.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2063;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=r9WESZjKdOkeXGTwKva4YI7nk9aqwglx/YUyTfzdpvw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnLVmOZd/6kdB/fROCTsWps6ilXvB+F0J8Juy0+
 dJdNf38eK+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZy1ZjgAKCRCLPIo+Aiko
 1S+lB/90k8vJL9oASKM6AlkVuibdH1L8eVx6hkMy9KAPhsWwxPe6eKiMs09KHBR1oJhRWZKaqHz
 zNBc7Lc+2AV9+7GPFheJcQgb6PGwLkOoin9i90T4GVxvsu/Js1JNqNxM2dll1ZD9clbWqG2ukt5
 7b+2T5enDV/767x2uQuISdNUUB1egRIXudLvmtpYTPNI7qoIHZwu9h2fXV6Z3y/IlG9nRevba+5
 Wy1OjYPDwXkfwmGSWv6q2NYPqwcAawqsV6SxNFEszxvMfJQNqnAbzihfDDFGbRFPe33kdKUAuo4
 d2doKZ9KBdHY5Tb6AdwXvvPtRhJjotzBai1ptLLtMIw63u8A
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

- Fix register programming in the dp_audio module
- Rework most of the register programming functions to be local to the
  calling module rather than accessing everything through huge
  dp_catalog monster.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (14):
      drm/msm/dp: fix msm_dp_utils_pack_sdp_header interface
      drm/msm/dp: drop msm_dp_panel_dump_regs() and msm_dp_catalog_dump_regs()
      drm/msm/dp: drop msm_dp_panel_tpg_config()
      drm/msm/dp: pull I/O data out of msm_dp_catalog_private()
      drm/msm/dp: move I/O functions to global header
      drm/msm/dp: move/inline AUX register functions
      drm/msm/dp: move/inline ctrl register functions
      drm/msm/dp: move/inline panel related functions
      drm/msm/dp: use msm_dp_utils_pack_sdp_header() for audio packets
      drm/msm/dp: drop obsolete audio headers access through catalog
      drm/msm/dp: move/inline audio related functions
      drm/msm/dp: move more AUX functions to dp_aux.c
      drm/msm/dp: drop struct msm_dp_panel_in
      drm/msm/dp: move interrupt handling to dp_ctrl

 drivers/gpu/drm/msm/dp/dp_audio.c   |  360 ++++------
 drivers/gpu/drm/msm/dp/dp_aux.c     |  195 +++++-
 drivers/gpu/drm/msm/dp/dp_aux.h     |    9 +-
 drivers/gpu/drm/msm/dp/dp_catalog.c | 1267 +----------------------------------
 drivers/gpu/drm/msm/dp/dp_catalog.h |  177 +++--
 drivers/gpu/drm/msm/dp/dp_ctrl.c    |  575 ++++++++++++++--
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |    5 +-
 drivers/gpu/drm/msm/dp/dp_display.c |   36 +-
 drivers/gpu/drm/msm/dp/dp_panel.c   |  150 +++--
 drivers/gpu/drm/msm/dp/dp_panel.h   |   15 +-
 drivers/gpu/drm/msm/dp/dp_reg.h     |   17 +
 drivers/gpu/drm/msm/dp/dp_utils.c   |   10 +-
 drivers/gpu/drm/msm/dp/dp_utils.h   |    2 +-
 13 files changed, 1078 insertions(+), 1740 deletions(-)
---
base-commit: 74741a050b79d31d8d2eeee12c77736596d0a6b2
change-id: 20240615-fd-dp-audio-fixup-a92883ea9e40

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


