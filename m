Return-Path: <linux-kernel+bounces-426064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EE39DEE69
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32BD9281287
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96075588B;
	Sat, 30 Nov 2024 01:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MF+gT5e3"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0D31F5F6
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931559; cv=none; b=f+gzAWq1fxtkew95T7kUzr481TC93+OAsuqGsGWnxvDRjPzkXEcAi+oQsF5zuYwf+NiisCp9o8N43hJRuYiPH/1s2/qPYldgN+k8NYjWBiKe44rojf6pPdDAKcDsW2bqvHNii+810mOvd7R0btmiVnbjmHA/EiDIBAhA3U50A38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931559; c=relaxed/simple;
	bh=3VcAga3hvcMUfVcAzQwDqmHLVIM+9BjN897sk6QijEc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WiXpvfXkuDgji21bgujtMDA7N+5G35jbsRtX+7hltGNcs4XFTRG85tlstTb+Q24sIBBxZMVjKRe313mA5y0A3tkNtAf8YUdb3j+r8uTAV0FKtuW5sPkJQd/HTwM2SQeqwlVtR/SWfI8XXvrvNf/5S6rnFX1FlUN35OAczOcVo/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MF+gT5e3; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53dd0cb9ce3so2073110e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732931556; x=1733536356; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0idVwC/Y8BowBuwoiQH15R6OW71zBvrSnYfglmGNHWM=;
        b=MF+gT5e3aAlnWnSL+h8I9yqWDRVV44LcuolnMXE5v3Q/rxCMrZWSoGgQbG2uBvXvAw
         EaQEAfa7/uwqvXxdhuxR1NH70dYto5qRuMYls6vo6/+kZIF2aUY+aLg6iReGdsAEQvDF
         O4aIBhgU7WxyUyvSnyVAC65nQIkD6GWH2F7EUU4dAyQ0shqa/PFTFGEhG9KoqLIP+CeL
         QZv6wOym6dKA/elOknfn1bG2Z+I30PKNd/84yzA1zSMDqAPAlkHCkBfG5VrKfekLwjGV
         ceZjtaRYZpXtOfCUpQ9LpdA7BHWZAOkTH0c2uGOWQ3KDwOvjjuHSeZYjTQ9NZQSSXnGD
         Jq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931556; x=1733536356;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0idVwC/Y8BowBuwoiQH15R6OW71zBvrSnYfglmGNHWM=;
        b=n5RaDaKozf6T72d+2i6vq7/Xyz/RuXiOYtJOwiNpqP3ByNfUyAjMezEh/pZbaJqDx9
         AKO7LoZIPMOraV6Q6jonm5QBBJmd28c0Yy80s2jmIOjq2A7PY2RzzBBzbvFTGS3TZpVl
         H+fzgEj4RHUCpfVbeQ+3Kg7srW5PZUcgsKT/Nq2gTJtxCnhlmkGlKb9Qj+ZRCvQ/BDzn
         NLLJFBv1AQO98Xxxon6+EXtLfDi2efY0h0ofzQnJtNgsqOAeuJSvagJPZe17fNKRv83w
         HboH7syEvEkWesct8sMFEtb7gL4MygUkRi7TcyceZmbPNEmlhwQBijQtr8yR6yiy7LJW
         NIQA==
X-Forwarded-Encrypted: i=1; AJvYcCVppYhh97k6lZsw9t5hBR1KQ0KofgwYCWVqBMMsauj5vAZhRULBIf5r9PKTi7Lk55hqnFenpZabNi5RO8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuyssYFrGUMBfAXRiSBic87z554ZdNX6zUggJnI9yGH1hGhaUb
	XBKhricoATJY0Ejn/X4pPXU+U5U95n5PTlZ06WEL2bG4Q1dOJXLjbthY0Qkh6rus6p0lu1SgIoS
	j
X-Gm-Gg: ASbGncuUI93PLaJtYxDFDejvDDnU8FJUAFMK8WdSP/KKQ45k+9mpSENv/fAKFdMe4iA
	fd78KOIgIfV4EbQZyBu0ZsbgRBANXfxaY1UpNn0wpR1IYbHXsKVZe6fiKQewkYMJwIzBosocpHD
	gOszoZQ23V7R2iLguo4mvRdvmLSN/BldlsrhsNrS876W2V4pb580y+UZVn4m5KoejI1yXdrQxaI
	yBI8FQwr4MVkHlICv3293yGm3ifvJlmpD9WYHAm65zpBK3pZA8A1qwqtA==
X-Google-Smtp-Source: AGHT+IEOzhXxDvsEIpRrEowV0sChYjq+QMeob7GWZCSiPE7ZrboRJzT4FPXckQ+mbro5wEegC/OfhQ==
X-Received: by 2002:a05:6512:3983:b0:53d:ed98:4a02 with SMTP id 2adb3069b0e04-53df0104907mr5269165e87.43.1732931555747;
        Fri, 29 Nov 2024 17:52:35 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6443172sm636408e87.84.2024.11.29.17.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:52:34 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v5 00/10] drm/display: hdmi: add
 drm_hdmi_connector_mode_valid()
Date: Sat, 30 Nov 2024 03:52:25 +0200
Message-Id: <20241130-hdmi-mode-valid-v5-0-742644ec3b1f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANlvSmcC/3XNwWrDMAzG8VcpPs/FlpXE6anvMXbQYrkRtHFxh
 tkoefe5vazF7Pj/QD/d1MpZeFWH3U1lLrJKWmp0bzs1zbScWEuorcAAWmO9nsNF9CUF1oXOEjQ
 RT4jgO2MnVa+umaN8P8T3j9qzrF8p/zweFHtf/7eK1Ub3jCMxemPjcDzLQjntUz6pO1bgD6hCC
 0AFqMfBxwAmUt8A7hkYW8BVoHPoJ3C9N0ML4BMA0AJYAYjMSN7R5zC+ANu2/QImxQRYcgEAAA=
 =
X-Change-ID: 20241018-hdmi-mode-valid-aaec4428501c
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3211;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=3VcAga3hvcMUfVcAzQwDqmHLVIM+9BjN897sk6QijEc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnSm/fvjfE0CWcAXr9KSR9cTNBZ3DlIiCtoE4lG
 DpPQzmfhVaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0pv3wAKCRCLPIo+Aiko
 1RzUB/wKuFVuYYbaERg38SyUJLRDaSgm+9ilE3D1p5SZHbKeahca1eECRZpBzpaniztBSnOap7S
 MSK0Yi378KQfEPC9z94rCyPKien7YuxYQ5+z2YYUWpX9wt4Pa1pXVZw3T/2XBgzaLNEUln7VNba
 1i9PjTN+TqokVzguj2GlwmOZxc5nMYOR+VwTgwFPXq7Dwa76BvNgVBCIoU90ILFZLCHUbNhorYG
 f1v+uf60UGNOyqr2e/hTRVdZc8hXIVIvyYRpIMHshnVlN2grD9j3as8+mvJBxqPnhFyNOsmW9TH
 Cl4Af68b7Tlg7FUAswAYyfTd4Q7yG97X9zjgYQ7nzcl9Vj37
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Several HDMI drivers have common code pice in the .mode_valid function
that validates RGB / 8bpc rate using the TMDS char rate callbacks.

Move this code piece to the common helper and remove the need to perform
this check manually. In case of DRM_BRIDGE_OP_HDMI bridges, they can
skip the check in favour of performing it in drm_bridge_connector.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v5:
- Fixed alignment after renaming the connector creation funciton
  (Maxime)
- Link to v4: https://lore.kernel.org/r/20241122-hdmi-mode-valid-v4-0-2fee4a83ab79@linaro.org

Changes in v4:
- Fixed build warning in VC4 driver by adding .mode_valid to
  vc4_hdmi_connector_helper_funcs (LKP)
- Reworked HDMI test helpers (Maxime)
- Expanded test descriptions and comments (Maxime)
- Added new EDID to test info.max_tmds_clock filtering (Maxime)
- Link to v3: https://lore.kernel.org/r/20241109-hdmi-mode-valid-v3-0-5348c2368076@linaro.org

Changes in v3:
- Moved drm_hdmi_connector_mode_valid() to drm_hdmi_state_helper.c
  (Maxime)
- Added commnt next to the preferred = list_first_entry() assignment
  (Maxime)
- Added comments to new tests, describing what is being tested (Maxime)
- Replaced sun4i_hdmi_connector_atomic_check() with
  drm_atomic_helper_connector_hdmi_check() (Maxime)
- Link to v2: https://lore.kernel.org/r/20241101-hdmi-mode-valid-v2-0-a6478fd20fa6@linaro.org

Changes in v2:
- Switched drm_hdmi_connector_mode_valid() to use common helper
  (ex-hdmi_clock_valid()) (Maxime)
- Added simple unit tests for drm_hdmi_connector_mode_valid().
- Link to v1: https://lore.kernel.org/r/20241018-hdmi-mode-valid-v1-0-6e49ae4801f7@linaro.org

---
Dmitry Baryshkov (10):
      drm/tests: hdmi: handle empty modes in find_preferred_mode()
      drm/tests: hdmi: rename connector creation function
      drm/tests: hdmi: return meaningful value from set_connector_edid()
      drm/display: hdmi: add generic mode_valid helper
      drm/sun4i: use drm_hdmi_connector_mode_valid()
      drm/vc4: use drm_hdmi_connector_mode_valid()
      drm/display: bridge_connector: use drm_bridge_connector_mode_valid()
      drm/bridge: lontium-lt9611: drop TMDS char rate check in mode_valid
      drm/bridge: dw-hdmi-qp: replace mode_valid with tmds_char_rate
      drm/sun4i: use drm_atomic_helper_connector_hdmi_check()

 drivers/gpu/drm/bridge/lontium-lt9611.c            |   4 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c       |  12 +-
 drivers/gpu/drm/display/drm_bridge_connector.c     |  16 +-
 drivers/gpu/drm/display/drm_hdmi_state_helper.c    |  21 ++
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |  32 +-
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 409 +++++++++++++++------
 drivers/gpu/drm/tests/drm_kunit_edid.h             | 102 +++++
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |   5 +-
 include/drm/display/drm_hdmi_state_helper.h        |   4 +
 9 files changed, 441 insertions(+), 164 deletions(-)
---
base-commit: 44cff6c5b0b17a78bc0b30372bcd816cf6dd282a
change-id: 20241018-hdmi-mode-valid-aaec4428501c

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


