Return-Path: <linux-kernel+bounces-194770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A958D41C3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 01:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B978C286F5E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 23:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361D6200107;
	Wed, 29 May 2024 23:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Td6v7cZw"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B771CB31C
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 23:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717024352; cv=none; b=B5wCczLbQxNF5X44YWdjgHRkJGFfhyjb+LJvi5zQkupYUYKER2N0tiheQaimsU5NkcKoSKiPwHQwRRjdZdHw36UcFkqOeGKRMdXLyblfiT39fEOeZBtCdmwdevjtJ87yMyDV0mNzQhn9cWztli5h+VRie7PXoLMfpMJloJHKGbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717024352; c=relaxed/simple;
	bh=K5f1oCCKwffOJ6cxdd7XW0UTw/TTSMDXlaLsFScHRec=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ny2bVBNHoJLR9KdtKfNOSgZRUpINyzCTdqLwCnb7dW8Pdf4GqvZM1n8eQtYNLFl82glBYMfX7iVwdMasPPgndM+vZfyzJ77ejdANhr9RhmJANGYCj4dOc88x8zxPZO2M/ZFoWtT4GkLdO3z90wqRddGhkX11z7sp6Qb2RoMPBI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Td6v7cZw; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52a54d664e3so353237e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 16:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717024348; x=1717629148; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QCeLGri5tnpDOe2DivnhztrkNF0hgqupYfwv9NgZRyc=;
        b=Td6v7cZwz0y9ixx+vutgUAsKpg6tjd+HbXU03UsmXYtOMCCphYrBVftU+Xt3K+Z6sQ
         9KuYLmyfdq8BsOQIbf9qNXatjVOwzHj3zyq0/10WZAHopu4+hqFRNA28uXUQqHfIJM0G
         01wJ6DhSpppD/csqWsrsjHwA4KYVuhW6muI7uwogtR/8JWeqAAbmeJNgcUjLoANObfMJ
         hjlWNMFhH2Pt89txf0+EnLIh7E0bGREkUqSlcbIQOonCXEDGBDIXTbTyhk8LK2MKduwm
         ySiolDb3gYnovUrz9SuHcqfY05T/MSE1B5o9qAmgSkJmizFLCToNl9gj2CJa6JuucAco
         md3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717024348; x=1717629148;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QCeLGri5tnpDOe2DivnhztrkNF0hgqupYfwv9NgZRyc=;
        b=GeiA6mwRxNiFYoxb+DEzr16NI0PcNPiYXX2AsKneRL8kyKEIzdc2sVm1NrevvmaKDW
         D6+TWhLmeWqZRxtRgGd3TpEzkR3YIn3gKdQxxpm3oa3+PBhyajUb/wlILhHvb8jUeVxp
         qHmvT5fFjP9LwEZ2tksfaRa4X7FUpsTsHaS4nKsRXfY/NEDrw74YpQJghGfHAj/+MJUH
         JBdFjX0mDChqA84G4zhJrSHI84MwVDY3l65OtjIorul9CLpt8ohXZdAtMMA3YkjOC2Ib
         WtUVKxutm/WKmd+IrULVJha8MeMHzDom3sQDSaDkKUO2KhxlAKZIHSqYEUA02Yfoa19J
         fPqw==
X-Forwarded-Encrypted: i=1; AJvYcCUJxFHPdRW1+mBUOCUeKMfFk94LyRf7Ako1rPel5wqyptiwCQx0qF2qbmhfBMwyobLoc5FmVw+fKqk9JZCgRcxAv4Ba19LcmocYigC6
X-Gm-Message-State: AOJu0YxfZ17RLChMrV1DjiaWC/K0h8056xWm+3jzyY07LNQ0D6Y6X8Mb
	C2WSDLen4CZ9sckkLMVg7JpI5GASy1SI9DT5UDfOFBWR3R11MFrimXHh+UFZ0kM=
X-Google-Smtp-Source: AGHT+IGYpt2DxsWSN4VRJToaIsased6v+8hlXaQxqyBwrowNYESyXyUzOhnEcHA9RATrmIVwLWAF/w==
X-Received: by 2002:ac2:51d4:0:b0:521:532d:eb38 with SMTP id 2adb3069b0e04-52b7d491b07mr334531e87.63.1717024348305;
        Wed, 29 May 2024 16:12:28 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529acea1ea8sm1015998e87.276.2024.05.29.16.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 16:12:27 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v3 0/7] drm/msm: make use of the HDMI connector
 infrastructure
Date: Thu, 30 May 2024 02:12:23 +0300
Message-Id: <20240530-bridge-hdmi-connector-v3-0-a1d184d68fe3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFe2V2YC/3XNQQ6CMBAF0KuQrq2ZttCCK+9hXAAdYRJtSWsaD
 eHuFhITXbD8P/PfzCxiIIzsVMwsYKJI3uWgDgXrx9YNyMnmzCTIEhQY3gWyuR3tg3jvncP+6QM
 3qExVotbCAsvbKeCNXpt7ueY8Usxn7+1NEmv7FesdMQkOvIFON6qqQGo438m1wR99GNhKJvnLN
 HuMzIxQNXTYKkTzzyzL8gFomhxGAgEAAA==
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3794;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=K5f1oCCKwffOJ6cxdd7XW0UTw/TTSMDXlaLsFScHRec=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ1r4tqiAjusBD3S+67ZJbgto2Fz9bcGzWJVVS4PaDgSn+
 xrcPHC6k9GYhYGRi0FWTJHFp6Blasym5LAPO6bWwwxiZQKZwsDFKQATyVvF/j+sSt//1m7L7nj2
 o+K85/y/equ4ZjKVnWvn6LjvZvO/PlSD8czqwJ0mZpkz9veXdEevkvn5d9U95sglEdZRM+bp3XG
 +96XHzarHQDf9J1td/tpQ04Ygl/5Jp305ve1fX1boPlNc/jW04Nf+5Jq7FiteXr5wZWlUE3+X/I
 r4F06CO2OlT37YFZRq/t7OgqnUtFxB2fP2ycNVG+unWZxc9fJkwdTubGdGb9PPR1O2zTpRUxn+I
 Ioz97UV+/n69N3lm/44nTOZPjPBzO5nbFPF11VxJX/tjp3eILPA6lRrt5zikW3BW1kX1Z2JO+G0
 pl8rtljze6HODpFjrYbMjN71biI6gue9P/4PlihbGy0KAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

This patchset sits on top Maxime's HDMI connector patchset ([1]).

Currently this is an RFC exploring the interface between HDMI bridges
and HDMI connector code. This has been lightly verified on the Qualcomm
DB820c, which has native HDMI output. If this approach is considered to
be acceptable, I'll finish MSM HDMI bridge conversion (reworking the
Audio Infoframe code). Other bridges can follow the same approach (we
have lt9611 / lt9611uxc / adv7511 on Qualcomm hardware).

[1] https://patchwork.freedesktop.org/series/122421/

To: Andrzej Hajda <andrzej.hajda@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Robert Foss <rfoss@kernel.org>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
To: Jonas Karlman <jonas@kwiboo.se>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Daniel Vetter <daniel@ffwll.ch>
To: Rob Clark <robdclark@gmail.com>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
To: Sean Paul <sean@poorly.run>
To: Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org
Cc: freedreno@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Changes in v3:
- Rebased on top of the merged HDMI connector patchset.
- Changed drm_bridge_connector to use drmm_connector_init() (Maxime)
- Added a check that write_infoframe callback is present if
  BRIDGE_OP_HDMI is set.
- Moved drm_atomic_helper_connector_hdmi_check() call from
  drm_bridge_connector to the HDMI bridge driver to remove dependency
  from drm_kms_helpers on the optional HDMI state helpers.
- Converted Audio InfoFrame handling code.
- Added support for HDMI Vendor Specific and SPD InfoFrames.
- Link to v2: https://lore.kernel.org/r/20240309-bridge-hdmi-connector-v2-0-1380bea3ee70@linaro.org

Changes in v2:
- Dropped drm_connector_hdmi_setup(). Instead added
  drm_connector_hdmi_init() to be used by drm_bridge_connector.
- Changed the drm_bridge_connector to act as a proxy for the HDMI
  connector  infrastructure. This removes most of the logic from
  the bridge drivers.
- Link to v1: https://lore.kernel.org/r/20240308-bridge-hdmi-connector-v1-0-90b693550260@linaro.org

---
Dmitry Baryshkov (7):
      drm/connector: hdmi: accept NULL for Audio Infoframe
      drm/bridge-connector: switch to using drmm allocations
      drm/bridge-connector: implement glue code for HDMI connector
      drm/msm/hdmi: switch to atomic bridge callbacks
      drm/msm/hdmi: make use of the drm_connector_hdmi framework
      drm/msm/hdmi: update HDMI_GEN_PKT_CTRL_GENERIC0_UPDATE definition
      drm/msm/hdmi: also send the SPD and HDMI Vendor Specific InfoFrames

 drivers/gpu/drm/display/drm_hdmi_state_helper.c |  14 +-
 drivers/gpu/drm/drm_bridge_connector.c          | 114 ++++++++--
 drivers/gpu/drm/drm_debugfs.c                   |   2 +
 drivers/gpu/drm/msm/Kconfig                     |   2 +
 drivers/gpu/drm/msm/hdmi/hdmi.c                 |  44 +---
 drivers/gpu/drm/msm/hdmi/hdmi.h                 |  16 +-
 drivers/gpu/drm/msm/hdmi/hdmi_audio.c           |  74 ++-----
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c          | 271 ++++++++++++++++++++----
 drivers/gpu/drm/msm/registers/display/hdmi.xml  |   2 +-
 include/drm/drm_bridge.h                        |  82 +++++++
 10 files changed, 455 insertions(+), 166 deletions(-)
---
base-commit: 03e98b48e2125d0cc99eeaace0f06290e20a1c55
change-id: 20240307-bridge-hdmi-connector-7e3754e661d0

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


