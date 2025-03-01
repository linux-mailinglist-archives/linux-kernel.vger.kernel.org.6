Return-Path: <linux-kernel+bounces-540054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8132A4AD04
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 18:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A713B7F80
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 17:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634961E2614;
	Sat,  1 Mar 2025 17:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CRmqjisa"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C264F41C63
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740849064; cv=none; b=fMPSuPENH4Qkrq985RY7aYxpe5rK6OIUhfxB0CWIxUIGlJADFipdWG+hR6ymuiUCMhx0NIRJ+54gJ7f2Bb4Fzr6iOaMT7Ylzg03A3sDmac32CoyU2nd+ZEfVmdmCb9ojIShQBWjvwUspmsHv+PotRuTa9B9Blc1376qvRCfP/0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740849064; c=relaxed/simple;
	bh=S5OuChTXe8RHWTOOd2rYoBZZVbvzR+cAiAR/WVy1ROk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Kpjjwn3Ty1BnM3UUNNUtOwlmkMf2qVdF0RqrkZVIkX7m1IAyECrDXUsZQtXSibgGyz0zJFmv/SE+KZmsn3nNZ3QEbNhzOgEiIiZA2HTFc40nNs8m6peC6s2ilzDH6ad+WpHFFHwXEswNP6uRCHnVMQ1WeiizzNmHzOMRsFxWeuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CRmqjisa; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5461a485a72so3261476e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 09:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740849061; x=1741453861; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gTSOh+6vc0fDAR7E7U91UFAeOUujh+ZpJVLlLuHs1jA=;
        b=CRmqjisa3KoXaJcq+cMXhGHgwjqsZcIEbsL0k7z8lntsBvOQu5xV/0M0oBKje3PQeM
         ZEsdh43e6BdAgsFV78LmSi/INTC1Tj2Pd8Z9xHLRYwsKhLfJ5h9AnpsVPPQ7T34elewB
         1BftGrvjFsVTHbGT8nb3joNnDq/IsqobGwPLsNoyp4s7BRSzDXQTnqMrUy1FyneCfJ+n
         fdp0Jw6hqTckbdHjoZ+VdA2D5+zx7gp5bZnIiCTSwWuiaQeG40jHz2TOMczXfHEdCHfn
         vEuIwDqd2ncFxMr7K4UUfmqbiBjaece+iSeSFtY5FYUn2/FRy7nuG+4MjB6oXh/wv2Oo
         bQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740849061; x=1741453861;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTSOh+6vc0fDAR7E7U91UFAeOUujh+ZpJVLlLuHs1jA=;
        b=GBuhnexn1nAlJPUkvEzX4GsmR6nXQeofGN65KQ/m53IcU7MeQpn7GdRP+lvoZmvGDZ
         rZ5u1JFUF6HvDNKgavz3Mi1bClfX279XP/7MQ3mQsqChBkgABeU3XZ+0ttQMo4F5WdSF
         w2fkHRWxrtGmyJwEf8DvkZRqVdl0bGUFSRQvwyF5C53NyeHWGs0GoaNe22AqvvzV1D5F
         H/mD7b/a6c5V/l63CzLBuBCZRiUInq2OlOSLmkBKW9Bej2UL/YqFSyclMMGgH+5OqC1J
         QnhQWwIPeRRREcW+WOiHu0rU6KaRJ7BtvjN0etlwFmdkKQTBZHDfoKf3IuqCvSRP9jZt
         UHCA==
X-Forwarded-Encrypted: i=1; AJvYcCU7UXGiWbiOdyH3Fy07iaotfRRa3iHaZrpqxhii8df8JIPy8YgmFX7uuxntBOqoblo/FQDcKlTJDFAWmTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuNT4ajngXV6inPKI/ck8cTywiD78DGti2tD0Tkz8hz81LaAYU
	fIpPa6iCt3VuBJED4AmN3tIsictCyZH06kDEckEWyy9FB1+PwgLqtSbcwLdTWU0=
X-Gm-Gg: ASbGncvBGh62+pUulnzpcniXLFxwF3ogbGNRzRVWaGBBhX7ub53e3tWBtcxgjSEVs2q
	riFK3KVhu2bhbBAUxuBZr0nuFP2AP32cJFE7AkwIZMpmKJpgDOAO1dMnEipGgASDz41u1our/jC
	PNv5KcFIbkO+RYQeO6kR7DrSVDomCzc6a66DwZRyyvJ6Qa7T8yKrRWCqZRlaz+c9ZilxC1v1tum
	ypSxn5JfKPqGT14qyytsyb+MlXHlxUewzWQ4MtSCvtPupJeZdwZ0fcMfGfbs1wrBhbt03thhUka
	k4GA4nBwWe3VWbE1C6UDwaqqqy+mwJzewjOGrHKzcduw1ikR1VFQ
X-Google-Smtp-Source: AGHT+IGjfTP3M1nC+JbXSe2IaduGP60EMXDnTNEYi01oiNBZO4gw8RM8QJ/UJEMcz87+6uNQsTJatw==
X-Received: by 2002:a05:6512:3f19:b0:545:c08:e17b with SMTP id 2adb3069b0e04-5494c328c3dmr2817722e87.23.1740849060798;
        Sat, 01 Mar 2025 09:11:00 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5494e52a47asm585313e87.152.2025.03.01.09.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 09:10:59 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v4 0/2] drm/bridge: reuse DRM HDMI Audio helpers for
 DisplayPort bridges
Date: Sat, 01 Mar 2025 19:10:54 +0200
Message-Id: <20250301-dp-hdmi-audio-v4-0-82739daf28cc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ4/w2cC/3XMQQ6CMBCF4auQrq2ZlkLAlfcwLlqmhUmUklaJh
 nB3CyuUuHwv+f6JRRvIRnbKJhbsSJF8n4Y6ZKzpdN9aTpg2kyALkFByHHiHd+L6ieS5KLB2aKw
 xtWPJDME6eq29yzXtjuLDh/eaH8Xy/iuNggOvtBZKVw2gwvONeh380YeWLalRbnn9y2XiokRTW
 uOkdG7H8w0XO54nrmQN4CBXRsEXn+f5AzSqXcopAQAA
X-Change-ID: 20250206-dp-hdmi-audio-15d9fdbebb9f
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 Hermes Wu <Hermes.wu@ite.com.tw>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2562;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=S5OuChTXe8RHWTOOd2rYoBZZVbvzR+cAiAR/WVy1ROk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnwz+hDFEtA8PzYi0XDQQscdSYGMSloFEiiE+wO
 wBuAM+tGneJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ8M/oQAKCRCLPIo+Aiko
 1RKbB/9yAM+aFQr7rcGvek4nWGz6fp6p7m+5TGAd3H10HnDGv9SrKPgyABE60xmFii+QLYK4YSz
 Y/CSGbOpBjMRJCSSmFnNa0Wm1hKX8luykI0PUe2DIbScy0lN4sV8fFWglwrYwqp1xyaD0yVR3F/
 foFeKAR8IFx9NmHQ6eK0AnFtzp0Wik6lp3vOAM0QoWdvp+F7k6I27b9MZCg3jTfe9sDj4eLfhuX
 JSkKgtxP5AkELE2kZ34NaMYvtgRE87EiifLrhbK6yTHml3V7NP916I6KAMrKVDUn87vylJiDPaP
 jIP3/ELrIcEaI3CpxIebsfg1aLyxcRXEW71TE7mBCPPoHL1+
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

A lot of DisplayPort bridges use HDMI Codec in order to provide audio
support. Present DRM HDMI Audio support has been written with the HDMI
and in particular DRM HDMI Connector framework support, however those
audio helpers can be easily reused for DisplayPort drivers too.

Patches by Hermes Wu that targeted implementing HDMI Audio support in
the iTE IT6506 driver pointed out the necessity of allowing one to use
generic audio helpers for DisplayPort drivers, as otherwise each driver
has to manually (and correctly) implement the get_eld() and plugged_cb
support.

Implement necessary integration in drm_bridge_connector and provide an
example implementation in the msm/dp driver.

The plan is to land core parts via the drm-misc-next tree and msm patch
via the msm-next tree.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v4:
- Rebased on linux-next, adding DRM_BRIDGE_OP_HDMI_AUDIO to Synopsys QP
  HDMI driver.
- Drop outdated comment regarding subconnector from the commit message.
- Link to v3: https://lore.kernel.org/r/20250219-dp-hdmi-audio-v3-0-42900f034b40@linaro.org

Changes in v3:
- Dropped DRM_BRIDGE_OP_DisplayPort, added DRM_BRIDGE_OP_HDMI_AUDIO
  (Laurent, Maxime)
- Dropped the subconnector patch (again)
- Link to v2: https://lore.kernel.org/r/20250209-dp-hdmi-audio-v2-0-16db6ebf22ff@linaro.org

Changes in v2:
- Added drm_connector_attach_dp_subconnector_property() patches
- Link to v1: https://lore.kernel.org/r/20250206-dp-hdmi-audio-v1-0-8aa14a8c0d4d@linaro.org

---
Dmitry Baryshkov (2):
      drm/bridge: split HDMI Audio from DRM_BRIDGE_OP_HDMI
      drm/msm/dp: reuse generic HDMI codec implementation

 drivers/gpu/drm/bridge/lontium-lt9611.c        |   2 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c   |   1 +
 drivers/gpu/drm/display/drm_bridge_connector.c |  59 +++++++----
 drivers/gpu/drm/msm/Kconfig                    |   1 +
 drivers/gpu/drm/msm/dp/dp_audio.c              | 131 +++----------------------
 drivers/gpu/drm/msm/dp/dp_audio.h              |  27 ++---
 drivers/gpu/drm/msm/dp/dp_display.c            |  28 +-----
 drivers/gpu/drm/msm/dp/dp_display.h            |   6 --
 drivers/gpu/drm/msm/dp/dp_drm.c                |   8 ++
 include/drm/drm_bridge.h                       |  23 ++++-
 10 files changed, 91 insertions(+), 195 deletions(-)
---
base-commit: 5299e75907dcd85c906bd58fb6226e72c36742fe
change-id: 20250206-dp-hdmi-audio-15d9fdbebb9f

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


