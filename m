Return-Path: <linux-kernel+bounces-540117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE438A4ADDE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 21:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73B316CC5E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 20:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047DB1E882F;
	Sat,  1 Mar 2025 20:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YTkbivqh"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EFA1D63D9
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 20:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740861592; cv=none; b=K8y+7v7WEMWBKDNo9QjTwoOnAyCr2OXp/blOuGE2vmEBo9PSVtKyp5oGOEGxJMRTv1T4nDYWcS5V2owomJ3fWU2Bz3mlQ6Iv5NbgqwB7BNJy5GYqztmdkTAohhQUIdj9eVXD7ypebyQ3DGJPE62cMHLpcQIN64lKaXVAfmxKDO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740861592; c=relaxed/simple;
	bh=hZO10I/DG1vyNEkMu0QuAX4yVnOsd0XWkUBtv8xUeKY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pGQEX28m89eNrgFOXP9RGhCSC4c85Dr/T1saCHkH03AQXFRMDbu3V4kLM94GYYaAoIQu5EvhFXnvlT/8ycSEDoncyKZ+Al9MM/Z0IJQgxoz8i9huuVyebUC4PS9TCceFAUBt8E3b5tcrPS9O2CQ9AonPYbw6xY1nKZbPUAK2/7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YTkbivqh; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30bb2fdbb09so584251fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 12:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740861587; x=1741466387; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FO233HjXSk+m9KpXwWyCXVtwo2BCKYqAyRibwb4PoCo=;
        b=YTkbivqhZKscTFr6XbBpsBWCFCbTSE26F0E76ccJTlUayfg03UiCfdTD+09+1RkuSu
         L+3F4hQ/9LrD7Xc+kqxboEUF3foJ2rXDiS6inQmpN1yPlRMrGaMkGebnBJK2jtx6vEoN
         21JkUoMjPv62VggKkUmGVNt+o6dniGZO09eC3TD1qYqhviN63TkOUt2GH6xw5mH2Ppij
         8Ymy1kUhnfNaeNx42z9FM9B2cLFlsUI3BePLycBtkxDZ3FtLM5p3QgMtYb0gBbtT6kaN
         hjjQFfeJSULCosNQHXM9FVmevh8M9HXqvSC9qJeFbF7GMAEEKLg5cIgOCNLEaEynOaWO
         PTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740861587; x=1741466387;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FO233HjXSk+m9KpXwWyCXVtwo2BCKYqAyRibwb4PoCo=;
        b=jos11u84NIvYuLx/w0G4zo/Usygz/lIMOiNj+Gx11KIY69j0nVnLvj9F5pcrDDgXvt
         yH+IWy7CB7dHbwrruCMuyOxBz/NGt8rq9PoauOLzIrNZoG46KlbEY2XGiEsRDX7NaWAU
         6cdZCbsoDC7hbiSS7MPYzCqd4ljJDqPrv9GiRhnnriaLGYObJ2n7V38sNyCNdHSB+1YZ
         Q6m+Ve+YXzoWSdVPeiGfIHH7UcWjH2LYfcPtp5qttzkVF5pk3+w1FiArnPJu0IIpY6D3
         xsMt3HCUPhrChR3Z3acpquxMRcE+bEtD13cbifwSGaSc4/wrMqmWGdHvWkk9KpQnauMS
         qbFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzgmL804Rv7GHoxOiqxyPdzMIR8jwBWR/e/oOciletJFatixoABJxhnfHMufFU5L3Wh47SsZA96MkoxRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyox5h2tAIviWOca92Kx8QXQKGgdO3PLLCCPxfKqrnoBNJ5+F7r
	cqImcoCJi2uuYsmt6K63McEoTsErRXeKo/iaA2Qcz5yfz8mlinsSqb8s18eX2t4=
X-Gm-Gg: ASbGncu8OV77GuU7rlEbZaK9tlPV5gz6+73R/aHlXCokuXW0sAh54rgaDPCatbYf/wL
	tFW2y4kpPzuREbuuWR6CusymKA4pHLQTf9MfKTVLHT4a4lb04Za8qrFV7s/mtibEk8CJOIn+2vm
	V1ep+pCugIfZeQCu/vjJ6hgiqBvrblBUo39//4fgyk6P6YLtYg8WtFYkePlGQf5SlG9xkmgKM9C
	Z8GO2BOTcPV+tu83B1EilPK2wOiTvC8Dp/z4P/WiI//colFaEFnzEWf9S4hKkjc5aufnXoeDgK9
	2ZvQcUIUHuLRvJRSniWCijud2J/nA3eeVfG7VSe/13AZVAcqrha5
X-Google-Smtp-Source: AGHT+IEpanYYiiYwRCJ9SOfItKmTyjjKRX8yWGESce2mZ6MgVsbxOhqOhLZCVSk5BJMSLzg818lUUg==
X-Received: by 2002:a05:651c:1541:b0:307:2bc6:5eb4 with SMTP id 38308e7fff4ca-30b931f9d32mr28568051fa.3.1740861587113;
        Sat, 01 Mar 2025 12:39:47 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b931524efsm6668921fa.60.2025.03.01.12.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 12:39:45 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH RFC v2 0/7] drm/display: dp: add new DPCD access functions
Date: Sat, 01 Mar 2025 22:39:35 +0200
Message-Id: <20250301-drm-rework-dpcd-access-v2-0-4d92602fc7cd@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIdww2cC/3WNwQ6CMBBEf4Xs2TXdgpJ4MjHxA7waDrBdoFEo2
 RrUEP7dhrvHN5N5s0AU9RLhlC2gMvvow5jA7jLgvh47Qe8SgzW2IJsTOh1Q5R30gW5ihzWzxIi
 NadlKUboj5ZDGk0rrP5v4DrfrBaoU9j6+gn63s5m2KnkPhqj8550JDZYtG2vEFK7h89OPtYZ90
 A6qdV1/0cFrTMIAAAA=
X-Change-ID: 20241231-drm-rework-dpcd-access-b0fc2e47d613
To: Lyude Paul <lyude@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 Jani Nikula <jani.nikula@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 Jani Nikula <jani.nikula@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2489;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=hZO10I/DG1vyNEkMu0QuAX4yVnOsd0XWkUBtv8xUeKY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnw3CPdZnNfQzvTNfvm624R2DWUI4vkz/LXqKhA
 MuM0BvXi2OJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ8NwjwAKCRCLPIo+Aiko
 1QN0B/40RX6HQ2yZIjBR9Q+Kcc6Vhtt8O6fvz6k27NSg1LWXTHHAG9lsjsPgR8mETncfA7+cL1S
 TTp16ccbJW9iUoivWOUq1eKMMRXqUTZKBi69cOmyu7nRBcEKWEVMfQFDiquX42fi3qlZdAc5W7N
 TLVR7V6hYRK06fccrNzVGwqSzmLy6vRE6KC+Ut3tBzGxIBqMYqQFbdaWYQDEwoD7OcuC4Zu//cg
 OL+6n/FYhotBL57blqx31J7sqNOSR0uuau1xDo4xe3Oh8u63mNtlr0C46XXf7Z5K4axtWvhx1Tb
 /f78njkOdV1oI6Cqoy24Hq174DyVXm4sJVQiIiAGyA2AgyAx
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Existing DPCD access functions return an error code or the number of
bytes being read / write in case of partial access. However a lot of
drivers either (incorrectly) ignore partial access or mishandle error
codes. In other cases this results in a boilerplate code which compares
returned value with the size.

As suggested by Jani implement new set of DPCD access helpers, which
ignore partial access, always return 0 or an error code. Reimplement
existing helpers using the new functions to ensure backwards
compatibility.

This series targets only the DRM helpers code. If the approach is found
to be acceptable, each of the drivers should be converted on its own.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v2:
- Reimplemented new helpers using old ones (Lyude)
- Reworked the drm_dp_dpcd_read_link_status() patch (Lyude)
- Dropped the dp-aux-dev patch (Jani)
- Link to v1: https://lore.kernel.org/r/20250117-drm-rework-dpcd-access-v1-0-7fc020e04dbc@linaro.org

---
Dmitry Baryshkov (7):
      drm/display: dp: implement new access helpers
      drm/display: dp: change drm_dp_dpcd_read_link_status() return value
      drm/display: dp: use new DCPD access helpers
      drm/display: dp-aux-dev: use new DCPD access helpers
      drm/display: dp-cec: use new DCPD access helpers
      drm/display: dp-mst-topology: use new DCPD access helpers
      drm/display: dp-tunnel: use new DCPD access helpers

 drivers/gpu/drm/amd/amdgpu/atombios_dp.c           |   8 +-
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-core.c    |   2 +-
 drivers/gpu/drm/display/drm_dp_aux_dev.c           |  12 +-
 drivers/gpu/drm/display/drm_dp_cec.c               |  37 ++-
 drivers/gpu/drm/display/drm_dp_helper.c            | 307 +++++++++------------
 drivers/gpu/drm/display/drm_dp_mst_topology.c      | 105 ++++---
 drivers/gpu/drm/display/drm_dp_tunnel.c            |  20 +-
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c       |   4 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   |  24 +-
 drivers/gpu/drm/msm/dp/dp_link.c                   |  18 +-
 drivers/gpu/drm/radeon/atombios_dp.c               |   8 +-
 include/drm/display/drm_dp_helper.h                |  92 +++++-
 12 files changed, 322 insertions(+), 315 deletions(-)
---
base-commit: c0eb65494e59d9834af7cbad983629e9017b25a1
change-id: 20241231-drm-rework-dpcd-access-b0fc2e47d613

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


