Return-Path: <linux-kernel+bounces-427212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 296C79DFE34
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA7428063A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F561FC7DB;
	Mon,  2 Dec 2024 10:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KqHp/csF"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276D21FC7D9
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 10:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733134005; cv=none; b=sQwFy+EcqDO8zYafyMeVZe3o0BQJ2NzDramSrOBML2c3zs70dBEHi47xANnwk5GxeICwyxRNTEf86/7CoXrz4kCJriBX2BglXj/tXoQbxV6ouhNNaeGvxMo7oc4+j+kHbjiYZJxzr3NY8aYGqhQTW3uphC0jXPQbKJR4eEcEODw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733134005; c=relaxed/simple;
	bh=GgRTctJjjmFR+2EV4ZLRM9XiD3udOEtrsRG/wQwZASg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XcKoQdjah2RlwUuR6SUY8WZ0BdOZKFhRAnD80pS+rPNZS7T/06SRvS6DomT9ypPTEzHbuFow/QNxEXt+cpjMU3oVlytJhd+f0/GEboVDxVUycZuFoCLDm7swiLGNSB49KSsNJQv4ul39Q7SZocZNkpDw+zNDKwm7QbU7Lt/7BXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KqHp/csF; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53df7f6a133so4239989e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 02:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733134001; x=1733738801; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8t93WpEYk3nDKkUudzjr3g8bA0wys8uB5XNs0VtJ1aI=;
        b=KqHp/csFb+Z7YmaHIW6PjZvRXFVl0jHvsnFQ0zBfLTXjPft6mj9Y/XxSs2P6HvVIb6
         NzVr94dy92Jzi45OWkykcw7jLW1fgXZl47Gu8S/pGtuXCTX04L1dJUVfr/VIRq43vk8F
         qhnPm8dXomhSMLH1wIwGJODi7T96yEqF5t6mmM0Vf6qAvNjOvOQEVQ5GKI4VCwg4XbHe
         VLO3JvlDf+zZXqHsW7OJMID+V2Zg+v79xi+pAFEKz5IawFC5bfklEmo93QZ4WRnyMAwR
         PXt9Xp4+/E4iCzx07lKijpz2XEZNKntyrRoWA0OgwZoxOYKxT0bZ9jABHv8iqegoILNa
         eJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733134001; x=1733738801;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8t93WpEYk3nDKkUudzjr3g8bA0wys8uB5XNs0VtJ1aI=;
        b=N099+aJVtnJv7bGWhgnIVJBrQmQvX7iCVxLIL6Zg8GuWnv1+a6Cm5FjipTtjj+uR9z
         C0fBwijamu2d/FtPhmVb1Kc3EpEQN/zQgLOXVzTKTWTcSjTXvM9iuto/ZAWu1uki4xiK
         bj+dsiYOr/jYx2upAaA/zbZoACWRXxgs/LCPLXbzrdEPRaZ1Mr+SAMB9OagOvcEDQX1x
         5+2EP/2arrIuqUHL5F9HLLmzVCtGDt1jItVZTp8JqAzobd2egvTn9hByP5usBnttG0a8
         WokSueRNwlrDvNmPIjgYn81IQr57PCr3zAToMvDftmGQ01pEEgUUUOprcLAjmWWWx9V5
         RGSg==
X-Forwarded-Encrypted: i=1; AJvYcCX1Lc95bcAudPZ1SyrjB+Y2UM/TFZz4svchmzljiAw3Iin8X/bI8iQvZmNwRKPNBO5dTBCjsmT9YIj7uQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO6wjnH1VqWZ4tbssibnOAMRJPvBVLJBEln9D8aC67AqujggBj
	94SCPE6YMo0wJtuvDvFzOjGN7mZgRWXm7GUOGLiHOuyrYDxvnrFID3fLIeDWOZQ=
X-Gm-Gg: ASbGncussVTsNaP2CcIqNTOSNqHo15n5BHKUaQakkCHwShcBwEoszRJIRmeJVMDAd4D
	4bFfUHK1qBedIoyXBJaJJrCqpJ2EWcVQE48nMd9pYEAbtehSc8vpYtftt+kkSQm3CABUsW+bVw3
	BCBG0QKf0Y7E77XpUr4TvfntVM+XJJPE03OunUwtFuCqHmeuSL1Fa7Th/bdyq/mme0LGMEe5rXL
	bog9wd/4NufS7e7iZ48nVDcwSP70IO1Swy4h+MGb5hr6LGMzbSih/a9dg==
X-Google-Smtp-Source: AGHT+IHbH0cvmJT2yx5NWUiOIEXeDVP9elqk8kJiJCCcfIiHjfj52Z/RMITv0CgC14CJdFE5cVHdfw==
X-Received: by 2002:a05:6512:3181:b0:53d:d5be:4bd9 with SMTP id 2adb3069b0e04-53df00cf711mr11571431e87.22.1733134001292;
        Mon, 02 Dec 2024 02:06:41 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df646f191sm1418314e87.136.2024.12.02.02.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 02:06:39 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 00/14] drm/msm/dp: perform misc cleanups
Date: Mon, 02 Dec 2024 12:06:30 +0200
Message-Id: <20241202-fd-dp-audio-fixup-v2-0-d9187ea96dad@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKaGTWcC/22NQQ6CMBBFr0Jm7ZhpLaS48h6GRaUDTGIoaYVoC
 He3du1u3v/5b3ZIHIUTXKsdIm+SJMwZ9KmCfnLzyCg+M2jShhpV4+DRL+hWLwEHea/5brW1F3Y
 tG4K8WyLnojjvXeZJ0ivET3mxqV9abEqR/WPbFBIa6i3zo6F+qG9PmV0M5xBH6I7j+AIizTofs
 wAAAA==
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
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2287;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=GgRTctJjjmFR+2EV4ZLRM9XiD3udOEtrsRG/wQwZASg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnTYasqHrxgs6JE7M1hdNH3pJDJpsqVsEy30IHc
 OgfiW2uBP+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ02GrAAKCRCLPIo+Aiko
 1a/yB/9yeB+1vh6Ib4i/1wq8ZlRx95FOtXSk+vAwqwI+qAQ/T66c/gjRGwveviKMzjYp5HGqNch
 yW37GhGioJontuzz92aByij7NmUpY7OaJA9Y7n1UE9f6gPltN70WNcLwGqvv2LgpR1qwzmnfQvD
 z6OBbiEkYFUDBkzTcv20abdx3qTku6ZSp0BrZIHCMBu8rlTM6zfSKasJhJ9BfpimlD0dftil7Wh
 Hp0wvrCw1fOURXBvFfdd7I98OZLcLJUGKT1C9TIBXG/VDGezOga7fIP6xRFW16d+LoV2uuhv8Qp
 V5fiCnKIdkA46Kf5wem2VGKJfcgHDqE2PkL6De/CWynSSsvU
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

- Fix register programming in the dp_audio module
- Rework most of the register programming functions to be local to the
  calling module rather than accessing everything through huge
  dp_catalog monster.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v2:
- Set safe_to_exit_level before printing it (LKP)
- Keep TPG-related functions (Abhinav)
- Link to v1: https://lore.kernel.org/r/20241108-fd-dp-audio-fixup-v1-0-40c8eeb60cf5@linaro.org

---
Dmitry Baryshkov (14):
      drm/msm/dp: set safe_to_exit_level before printing it
      drm/msm/dp: fix msm_dp_utils_pack_sdp_header interface
      drm/msm/dp: drop msm_dp_panel_dump_regs() and msm_dp_catalog_dump_regs()
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

 drivers/gpu/drm/msm/dp/dp_audio.c   |  362 ++++------
 drivers/gpu/drm/msm/dp/dp_aux.c     |  195 +++++-
 drivers/gpu/drm/msm/dp/dp_aux.h     |    9 +-
 drivers/gpu/drm/msm/dp/dp_catalog.c | 1267 +----------------------------------
 drivers/gpu/drm/msm/dp/dp_catalog.h |  177 +++--
 drivers/gpu/drm/msm/dp/dp_ctrl.c    |  575 ++++++++++++++--
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |    5 +-
 drivers/gpu/drm/msm/dp/dp_display.c |   36 +-
 drivers/gpu/drm/msm/dp/dp_panel.c   |  234 ++++++-
 drivers/gpu/drm/msm/dp/dp_panel.h   |   14 +-
 drivers/gpu/drm/msm/dp/dp_reg.h     |   17 +
 drivers/gpu/drm/msm/dp/dp_utils.c   |   10 +-
 drivers/gpu/drm/msm/dp/dp_utils.h   |    2 +-
 13 files changed, 1176 insertions(+), 1727 deletions(-)
---
base-commit: f486c8aa16b8172f63bddc70116a0c897a7f3f02
change-id: 20240615-fd-dp-audio-fixup-a92883ea9e40

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


