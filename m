Return-Path: <linux-kernel+bounces-402815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 322439C2D13
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 13:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594B81F21D53
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 12:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFD1155726;
	Sat,  9 Nov 2024 12:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z0Z3hcyz"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725761BC3F
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731155718; cv=none; b=llq00czbSce6YqWn3SJZLeYFZa3pK8NtdST6fMwX4l04f8A8RQ8Trc+yRKDEEduc4/AEQ/eij5RoHYrdFxgpfgqH8fUQR2XoY3w2eaLTtdbqy2qRTPq0exaAzBjb0t06YxLyPrTS4UyPzSDyjJXPCWBxJnx4QWqZm/qeE2Q0xHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731155718; c=relaxed/simple;
	bh=2fV2XD25ut5vTGewFjeEo8rNWtU13M/szPG8t2HvEoA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q+o4BwuJLqdX/UMqNNy0iOokWIrvCLh0FKsBSkxWvxcjKvnDexKkitW7Q7BCZYSDxd4TPzNIFO3D4d0IKYWh2DN+Kru8vGJ3HH75NUONZk0FaHA2w+TjluOkkfLCOKkfCqXtJit/Tv6JFrrExjk5hCsvpwb8dF3/eRHhItu6WCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z0Z3hcyz; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e5c15fd3so3108675e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 04:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731155714; x=1731760514; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7v2ALFBdYjyZ6sFyb9Y/ee0T/VtMhjtKVZbW5icBGMM=;
        b=Z0Z3hcyzzmhZ+SI8crhNRddukyL8ku/5l9o84LfcSIAcCWgdAvQrN+QdJe+Ty+YBrj
         ooxnZbDqYFzH9iYEzZ5K2lv39n50OJR97D4WN6Zt8H21I4MRskQNPjsZuE20pEM/P2VJ
         i1fAWgq+/o/OxUJJOH9VjwC4qcFtHR2Ytl+zdO55OJ1awZguFtg7kz+wW6gpoxYO+Z8S
         XYkstMfRN/MsTTRyKgquD3LBngqglucDJGwU5MHe+yA/ja3Ljfq/+7xLt9pbzwdR1FUv
         IIJnzevB9dU/LiKz6q0ZQNIvtG1lvl1G1MuhuXXX7+G0Q0Tg2HzFabAJjOj9EF+XQ1xj
         xSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731155714; x=1731760514;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7v2ALFBdYjyZ6sFyb9Y/ee0T/VtMhjtKVZbW5icBGMM=;
        b=guLdMvYGPtHpkEZRowX/NZ77ByN/h7vT2ELBTj0X9/Fap6nyntnu5B7ZRrK6mMHl6V
         xScSh8BEbVWaF/jDAUQLgIP8BRWzbN5N+iyW1NuPwVD6Neb5XA4xzsKC3UGf93Z+M+4Y
         PllU8D1oYdTG3Pk18W7Erzcis8pPnsYnJHMTN+Wt7ZzSNgoEJkuz2D4AyJ/iHqxhHbku
         x39gb+/uIJSS4ztEGY42S1bC23aNDZmTu7qAt+OF5vJbEILhxO4FvSQloj3n1d0xPv6W
         Cq3IwAiG0wYllgIrCL/lHuKbxF0q/5kSPYygX9GCjy68FalGqwv5Pmuj2nlszwtxTj+d
         tVww==
X-Forwarded-Encrypted: i=1; AJvYcCWlQ2KQoEYtC2sQhcQd+imbSiYY/kNghKfR205kNEUk4OAj08XMgfQq4gcja7CzZlyYH6D3eaKF7ng+Scs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ87HNMWcXfoV4BxL6mwnDrzblhQG/86O3D+opr4pHasYD5d/d
	kP/g4Mg5iBXLKU7T51V6yqTxaFVnpOxSZYdutkvnprRIp8kt9t3Obcc5ozKmJuI=
X-Google-Smtp-Source: AGHT+IFSDYeqaLjyC9aeiFIrpSqYeLJzWS5ech99oMz9O52R0aPaOJVtYR5urSo+K9hUQ7SDK0W5Xg==
X-Received: by 2002:a05:6512:3e01:b0:539:eb82:d45b with SMTP id 2adb3069b0e04-53d862f817cmr2360079e87.56.1731155714283;
        Sat, 09 Nov 2024 04:35:14 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826784dbsm922899e87.15.2024.11.09.04.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 04:35:12 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v3 0/7] drm/display: hdmi: add
 drm_hdmi_connector_mode_valid()
Date: Sat, 09 Nov 2024 14:35:04 +0200
Message-Id: <20241109-hdmi-mode-valid-v3-0-5348c2368076@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPhWL2cC/3XNQQrCMBCF4auUWRtJYmyjK+8hLoZm0g60jSQSl
 NK7m3YjIi7/B/PNDIkiU4JzNUOkzInDVOKwq6DtcepIsCsNWmqjpLKidyOLMTgSGQd2ApFaY7Q
 9StVCubpH8vzcxOutdM/pEeJre5DVuv63shJS1GROSMZK5ZvLwBPGsA+xgxXL+gMU4RfQBcDaN
 NY7LT3WX8CyLG+YQFG18AAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2383;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=2fV2XD25ut5vTGewFjeEo8rNWtU13M/szPG8t2HvEoA=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ7p+2L/f+UEK3NVbN5T87r6we4/e+47HjzdUh8R2Rpl41
 ljN4GDpZDRmYWDkYpAVU2TxKWiZGrMpOezDjqn1MINYmUCmMHBxCsBEdvey/6/rZXqxJ3yT/vWl
 Sal9CQ/l8xMDBRcJZ5ncmPFSXl466RQ7E+uc5Su+3jC8paB2oMG53dq2ZHosq1ZdfGqNw4Td+k+
 bNzz1LtvQmHu23k3xn9mEIwcPa7K1c9427l1rm6Cxt6NZTvi8s9eEWhfFtqjtbRYXhTIu8SjpVt
 X831v+8Wx7hHTM4Q07L7h/Snf4fO7197Y7+mdstb2vq27hCvZV2ePNt+F/2qInFieUeXf1shzp8
 0+3ilfZ+ND/Uuk82+PTt4QVaHtJKkrcLDdMWl7AsmhRLutHLpbpJt/ZFx9w+5C8yNs44MwXnomv
 FDYovd7jWd4Sa7WvkZlnoa99vvoFtgqbn5YKyQ8TQzgB
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Several HDMI drivers have common code pice in the .mode_valid function
that validates RGB / 8bpc rate using the TMDS char rate callbacks.

Move this code piece to the common helper and remove the need to perform
this check manually. In case of DRM_BRIDGE_OP_HDMI bridges, they can
skip the check in favour of performing it in drm_bridge_connector.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
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
Dmitry Baryshkov (7):
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
 drivers/gpu/drm/display/drm_hdmi_state_helper.c    |  21 +++
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |  32 +---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 181 ++++++++++++++++++++-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |   4 +-
 include/drm/display/drm_hdmi_state_helper.h        |   4 +
 8 files changed, 228 insertions(+), 46 deletions(-)
---
base-commit: 929beafbe7acce3267c06115e13e03ff6e50548a
change-id: 20241018-hdmi-mode-valid-aaec4428501c

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


