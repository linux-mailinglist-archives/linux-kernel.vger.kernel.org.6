Return-Path: <linux-kernel+bounces-417992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 589499D5BA4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B991F217A8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B8F1D4323;
	Fri, 22 Nov 2024 09:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yiGertwK"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977D818BC0B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732266793; cv=none; b=j1KklT0dTUqjvFvRB3KdarDBDpef8rR4aho/sy7OBjbMU1djSxkNs4NJoMbdk1vBXDpDl7Za5NdBl6N2D610x7RstQ2OnBElPKScqtQ7zbfGN6+TSdZePObLWEWk+oC/qrQENzphJ6j+Q+gvmy5PaMvljkxT5HR+zH7Ty3wPX+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732266793; c=relaxed/simple;
	bh=dAGoBfBZPrQ28ollGsFDqICLzpx3eGynrKY+liYfcfc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ds8E6GNof8tnMBcvDr2VToVPM9Iq1l5Mx7oM70IUc2wmXt21HVLUOczJdf17iOrYfG9FkelVjvEtl3Hk36/6tGlf+4+Tr/N44DgDcJTGBDvavJ8mnpOXQ2/xo12fXiLjy52M7e2YpVBGx/iZFIj+eRNGytNZKTCBZJzmtLTkHdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yiGertwK; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53dd8a528feso117573e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 01:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732266789; x=1732871589; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yPJBOfYSV90IcFVSxfOZG/ZLElTJvS62cOj1dS8TNSc=;
        b=yiGertwKm04rOHXngxJeSQGNn+knC5Z8XsU4oUtFZrwYxXZDu3CPDqEqLWfJ0RRcZC
         jm8Wj6Q023VmoNUWAXD1aajiV8S//muRHXnTBBZCafCQVskiEdb5/oMIWNDdYt1UgrLi
         uJf0k/tM7LHGg+HT+GXs3XIvXplTQNV0uUyF/gtG6QN4Ohl4PsnhiGjZxkiOIv4WGZ0I
         YQWj7W8/REY6TT7LQ8PVsnPg8/Dzk0XfE+FNy0mo92qWxoVl1G9owaRGruPmDlYYwvEh
         ybmi+j29OTXAQKVUnlI6N89nr4pexbYoD6+3A/9DoWjBe0ltJfv6SUktzk/6f3uFQTeB
         dWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732266789; x=1732871589;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yPJBOfYSV90IcFVSxfOZG/ZLElTJvS62cOj1dS8TNSc=;
        b=Qqg5TmE2bhXGfutjO5m197SQGTOzrzCfAknL0wsMGw+3URvQqZgCIg2iRTKMBmfjnW
         PwR0ft3MeuZufIfBa9w11VVz6Je+hxCAe7apNnSvpv6zvIrZ6hM1YVZ1FrVIewJm+oOU
         PbSrJyXNiszJIvGq4vD+yWHTDQGUOKwKtu/vURHPnUqBwbTiZi9lpSgvX1TKZVLyodDc
         mhbQS9EEvq/DybzeJRYJ8GH5Lg0pSAnBGikpOmeGcikeBpnPoMR4VDkslM1vQ86LUmlC
         bBtXeSYtATFN3/JWpRezEdPw8i8zBE/cksESpGYfdLVkGb5mpBigAED552V7GJ3TuXFb
         s8jg==
X-Forwarded-Encrypted: i=1; AJvYcCWjNW4AM5ZWp65KqZ3L7R3kfhV/cu17qUHcy8fGjN5KVBSkLuZw9fOiniz6Uud222CV/+mA5MWCEyYcxc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRaLh4r5ro/byscb9zj59JMx6DQBl8/V0FRTJiZtX70oGmmtEh
	rcXkA0e7ba6MBn9wvvwd4Sg6WpZBuYVzb4Dgdjd5PPvKZp2yojC4GQBQbF7r0420Swk7qC9+hny
	7
X-Gm-Gg: ASbGnct4kglc3inAntl4GiDDcTJsm+kxZOKMemhjRL0aESGxI14cGQu6r/A/Qy/8VH0
	KVv+b+lb5UyC8z7lvoAPkr+y4igR6VyK9j2WySgWOjoVlDwS2BiOeFYlBDk7vfXcPHnOGcA61f5
	4MPQzUdJqo2GW6PEP0rF3W91ujNKBybd7Cmxh6mSow/JMOIu6SFfc+vR/UM4ItKoslnt5Op7rT5
	QiUK16NDbNnZoF+nq3ZOq15fxjAqCtO8VnkFh8/iw4HVjrJNDtoLwc1Yw==
X-Google-Smtp-Source: AGHT+IGEb5tRInMFtVE9GZficnUTiVO1xCATodroM7GK3ZevvdEIuIB/MI+jMs/pCyFMTD+eeIO8JQ==
X-Received: by 2002:a05:6512:10ca:b0:53d:a9b9:fdc0 with SMTP id 2adb3069b0e04-53dd389d8a1mr1112818e87.31.1732266789361;
        Fri, 22 Nov 2024 01:13:09 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2451386sm299530e87.77.2024.11.22.01.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:13:08 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v4 00/10] drm/display: hdmi: add
 drm_hdmi_connector_mode_valid()
Date: Fri, 22 Nov 2024 11:12:56 +0200
Message-Id: <20241122-hdmi-mode-valid-v4-0-2fee4a83ab79@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABhLQGcC/3XNTQrCMBCG4auUrI3kr2l05T3ERUim7UDbSCJBK
 b27aTcqxeX7wTwzkwQRIZFzNZMIGROGqYQ6VMT1duqAoi9NBBOKM25o70ekY/BAsx3QU2vBKSV
 Mzbgj5eoeocXnJl5vpXtMjxBf24PM1/W/lTllVIM6WVCG8ba5DDjZGI4hdmTFsvgARdgDogBWq
 8a0XrDW6h0gv4HTHpAFqKUyTkhtWPMLLMvyBlx47n8xAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3023;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=dAGoBfBZPrQ28ollGsFDqICLzpx3eGynrKY+liYfcfc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnQEsh97cY2ewxrd1QdOkVWNxJCVibvExTdRJp9
 9bHLnJ6vOeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0BLIQAKCRCLPIo+Aiko
 1aIBB/9UOalIiiDyCESbhN5VK1zX78Q2v5Cu6GR9StRIoyHvHhPD2SZblaTT0rK2OUduQIaCzil
 e43PDFRCRm4oTpATivZAvHM+yi203AUBJiwIOMAe3JA+lhIvMk3+ifawcrw9Cl72SEbVds3dBNt
 BIFRNdKbfHdX7wqjMVc2sNYXaGiXlxNEvRrur+Q56Z5uoO+XYx/CdGPi1clyXilpj3fMjPiIs5o
 dtyVnROt60CnOjUDof0ueLHTqnMk2Ydx3ZhtWbgLtC5avyxhU0xLPgjLAqQDjkW3BXf65sD++Ux
 wdtO/dYUJ6BFYYLwt4PattfJC/Uz53ohOyAbm08X1xxiSoWn
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Several HDMI drivers have common code pice in the .mode_valid function
that validates RGB / 8bpc rate using the TMDS char rate callbacks.

Move this code piece to the common helper and remove the need to perform
this check manually. In case of DRM_BRIDGE_OP_HDMI bridges, they can
skip the check in favour of performing it in drm_bridge_connector.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
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
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |  32 +--
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 269 +++++++++++++++++----
 drivers/gpu/drm/tests/drm_kunit_edid.h             | 102 ++++++++
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |   5 +-
 include/drm/display/drm_hdmi_state_helper.h        |   4 +
 9 files changed, 371 insertions(+), 94 deletions(-)
---
base-commit: d80b5c5b9be6b2e1cdeaaeaa8259523b63cae292
change-id: 20241018-hdmi-mode-valid-aaec4428501c

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


