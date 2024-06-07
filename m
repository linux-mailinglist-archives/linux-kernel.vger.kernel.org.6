Return-Path: <linux-kernel+bounces-206123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F26F6900494
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61801B24805
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBB919413E;
	Fri,  7 Jun 2024 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ki3KsX5O"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63D018F2C9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766588; cv=none; b=exiGPHWR8FtuZ6Y0jU/fz3F4F8DMT3tVWAls7UmZtvGwKGlY2e3mK2+YnM84kBMr0jLAZSoOuERem3qzmpMmnFY0i6+PWxP3fXL7bqqMYZs/kX80ue0jPCs6o//Z5/URW0PmD701Sz5UeVzogqTeJlYUDEg6Vp2qtdY8HkQ5Ru8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766588; c=relaxed/simple;
	bh=UrMGMcNriQlSOJwP/1Zz6CgLy9Xu2g7DPohrk5dATq0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FcRqTi8YTHmLyRbBqCLqlgQRcQ0JqRrryRslJCmis9p7vhfoxZnPpJpp/x9AFT1JrGSm044Y6oUl2FFA+PhNxdfLwVGsxoiBSGpJbSyjMapKAzz0++qb7SivaNCZHq7RWVbEKpncfaZuvqdndMLKdgSBBSoqOY98MJEs5gQcl/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ki3KsX5O; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52b90038cf7so3259439e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 06:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717766584; x=1718371384; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L546UJDJwDhNtD4MhBT8mwI/8o9qvecKvmvta6wWkb0=;
        b=ki3KsX5OefWNL8GymNoIo8K7nUAuH2GtEI2v9xQCmy40AaVKOT2t92YTFjW3Eg9PoT
         A4Hl1zLkY0GdSFudBS+fsrCA8pyiq+Mj52W5ZZ4OZ0XdLtC8z1qm1FHs4uL+hWX9KIPc
         5a4+BIb5NCuLibv2Ia4IozfAZ0/E9CGV78nqp4pJob1q3o9odQraA8JpdEXhLo3IkviL
         ofxKSUk9zbCYGnXINzG7UjErV36PJc/Qlgalu32kDOSoIgK6lSdCeoGtJawHsbDqTbvH
         4sGJyxDKKYIElCvbpxBzDUP9lQpY9GMYznGA98f6CqPTCm9ARYLH/T+gmagHEa3rAxiY
         QMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717766584; x=1718371384;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L546UJDJwDhNtD4MhBT8mwI/8o9qvecKvmvta6wWkb0=;
        b=v8pvW0cKkbGe9UYbdaoOHUTVR14/jdL0PYlRRH2Hh15GOAClfQ/ChG84RKtvohpeIu
         SEIfdSU5hWtpXeTV02AtsZHjDvKu/cSPw2O339ug7P5ifcip3pwke0L/v2t3mMxquGQV
         UNMs+3YrTB+6jP/bBd0ZtUwfV8UiA1D3ystyLnWcCZGKQ+TwAnycxnxpxGbY7mC4OjWI
         L7tLTWWqWK6UHuDfgHcMfVgzGDDs/nvoHX4DVvtqyU1s9IXnjToga9V5Asm62scYEz6u
         vHC0s7TbwCcQCIi9f/zigXZ+/GeevvawczwtzlcRjn2RIQAudOh3ivGcfKFnKw6ky3N/
         xtGA==
X-Forwarded-Encrypted: i=1; AJvYcCX3hB8dy+IrIH2Pcy2p4j9xxjQGPphMGvOnMLnK/oIdceG6RJ/Bb0voYoUj3xoxRy+5+k7iFX+w6wlqEi7pen7m+gt92liRAwUz51nj
X-Gm-Message-State: AOJu0YxMMA+iW4JdG20eExXdjNDW3xRVs7IWB+JcegAK+2Jy1Iyh1DPc
	hMLhyGWD3Pw5M3ZnJEi2Ef6CAoyGNOZQgfMeSCKJNR0bUZ6l9IxAnZq8Fuz0TGo=
X-Google-Smtp-Source: AGHT+IETFIbMY0Y2oLYRx8o9U2fmxMfpNQDewBvZPnUdqZCTzhxVb1bTC1GHZmV1wsrekpTCCZU94A==
X-Received: by 2002:a05:6512:3d0b:b0:528:ce56:96d with SMTP id 2adb3069b0e04-52bb9fc57bdmr2387528e87.50.1717766583904;
        Fri, 07 Jun 2024 06:23:03 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bc27640easm80944e87.104.2024.06.07.06.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 06:23:03 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v5 0/9] drm/msm: make use of the HDMI connector
 infrastructure
Date: Fri, 07 Jun 2024 16:22:57 +0300
Message-Id: <20240607-bridge-hdmi-connector-v5-0-ab384e6021af@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALEJY2YC/3XNTWrDMBAF4KsErasw0ujH7ir3CF3Y1jgeaKUiB
 5MSfPdOAiUpwcv3mPfNVc1UmWb1vruqSgvPXLIE/7ZTw9TlE2lOkpUF6wAh6r5yknZKX6yHkjM
 N51J1JIzeUQgmgZLtd6WRL3f3+CF54lnOfu5vFnNr/8RmQ1yMBt1CH1r0HmyAwyfnrpZ9qSd1I
 xf7zLRbjBXGYAM9dUgUXxl8MB5hi0FhOpNM41JoRsIXxj0zZotxwnhjYIytw2DtP2Zd11/RWnJ
 +kAEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4310;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=UrMGMcNriQlSOJwP/1Zz6CgLy9Xu2g7DPohrk5dATq0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmYwm18SLgn8aWyu2mlHE6QjZVyAXZw8OOMk4Dk
 pUidJfNbuKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZmMJtQAKCRCLPIo+Aiko
 1RIEB/0dVe7IKSj692e/FGCihXn4ugrt/2cRxNJO9bwpQXeaPV2gqXe82A2MwkmIDPoenwnQ5Zx
 g0J+xJgGxRspZ+Zq7mJL21Mb/n/hcp9nIRIbkGUYH7XqcoxC14M1BlGbI45hjq8SxvGDGbCUvwO
 O/sho5s09CLF37PeF82MifVaMcrRgZtcbCpxXdf+UKQMn+iP2Myvh8Vbdg9XT2bVQLRJDM6LYku
 QGTnRn40+CeepvN9TSryAF6jNfOJLHUn3moXEVcfjgUu2kkj9dNeecC+FSH+QDvUtLoGMBrNC8S
 2LFQ8ZsTkhrVuz6UK+MNK9ULelUyhdFt2ily3UmYDE91dC07
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

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v5:
- Made drm_bridge_funcs::hdmi_clear_infoframe() callback mandatory for
  DRM_BRIDGE_OP_HDMI bridges (Maxime)
- Added drm_atomic_helper_connector_hdmi_disable_audio_infoframe()
  instead of passing NULL frame to
  drm_atomic_helper_connector_hdmi_update_audio_infoframe() (Maxime)
- Disable Audio Infoframe in MSM HDMI driver on audio shutdown.
- Link to v4: https://lore.kernel.org/r/20240531-bridge-hdmi-connector-v4-0-5110f7943622@linaro.org

Changes in v4:
- Reworked drm_bridge_connector functions to remove ternary operators
  and to reduce indentation level (Maxime)
- Added hdmi_ prefix to all HDMI-related drm_bridge_funcs calls (Maxime)
- Made vendor and product mandatory to the HDMI bridges (Maxime)
- Documented that max_bpc can be 8, 10 or 12 (Maxime)
- Changed hdmi->pixclock to be set using tmds_char_rate instead of
  calculating that manually (Maxime)
- Changed mode_valid to use helper function instead of manually
  doing mode->clock * 1000
- Removed hdmi_mode in favour of connector->display_info.is_hdmi
- Link to v3: https://lore.kernel.org/r/20240530-bridge-hdmi-connector-v3-0-a1d184d68fe3@linaro.org

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
Dmitry Baryshkov (9):
      drm/connector: hdmi: allow disabling Audio Infoframe
      drm/bridge-connector: switch to using drmm allocations
      drm/bridge-connector: implement glue code for HDMI connector
      drm/msm/hdmi: switch to atomic bridge callbacks
      drm/msm/hdmi: turn mode_set into atomic_enable
      drm/msm/hdmi: make use of the drm_connector_hdmi framework
      drm/msm/hdmi: get rid of hdmi_mode
      drm/msm/hdmi: update HDMI_GEN_PKT_CTRL_GENERIC0_UPDATE definition
      drm/msm/hdmi: also send the SPD and HDMI Vendor Specific InfoFrames

 drivers/gpu/drm/display/drm_hdmi_state_helper.c |  36 +++
 drivers/gpu/drm/drm_bridge_connector.c          | 107 ++++++--
 drivers/gpu/drm/drm_debugfs.c                   |   2 +
 drivers/gpu/drm/msm/Kconfig                     |   2 +
 drivers/gpu/drm/msm/hdmi/hdmi.c                 |  47 +---
 drivers/gpu/drm/msm/hdmi/hdmi.h                 |  18 +-
 drivers/gpu/drm/msm/hdmi/hdmi_audio.c           |  74 ++----
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c          | 310 +++++++++++++++++++-----
 drivers/gpu/drm/msm/registers/display/hdmi.xml  |   2 +-
 include/drm/display/drm_hdmi_state_helper.h     |   1 +
 include/drm/drm_bridge.h                        |  81 +++++++
 11 files changed, 496 insertions(+), 184 deletions(-)
---
base-commit: 222d50ef3700aefb694e55a7a1f03d3fe2cb67f9
change-id: 20240307-bridge-hdmi-connector-7e3754e661d0

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


