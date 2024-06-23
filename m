Return-Path: <linux-kernel+bounces-225941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4756C9137ED
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 07:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED958283B04
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 05:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED33225CF;
	Sun, 23 Jun 2024 05:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x9/qoS0O"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FE320E3
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 05:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719121222; cv=none; b=eZgqGHHst4ji2eTwAegt4InK6NWxiREopwGL1prEXiIIMCKgUyZhIBeERsvjZmjEgh+kH0kgcx1BHmMu34daBbEGKEksDOa+rAqeEiBa5wrgzAGBycbExGv4Pq0TYWmfJeGW8Ys+7PJa+l6J9d6kDOWokhgnYwOCgapzuPBgwt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719121222; c=relaxed/simple;
	bh=x3zgeMUTwoUy9QgsxTnuE+bkVAeAn87c0VbBknwvLvo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OeL12Es1uomR3ZRcknjcd3rtC67geYYuGO4e5dWVZMdksykusUf6WsaWPYJNRv0CyLgihMtHR2GES3g6ov93h3cjnUHZnkdnMw0gwTsmckkp+ktKXiNsoBzEBPLeFsN30/4RzLmi1mgvyoyYpyh+FlZ3oQAvk+0Dgw+qIKnZU4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x9/qoS0O; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ec1e5505abso35947631fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 22:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719121219; x=1719726019; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8gsboRjLNvP365oqxS3SRWYp46DTNXjyQa5IQ3IG07o=;
        b=x9/qoS0OmiESev1DrfNn0smt9dyYkmUHwvx5ffZUdX9BC05hjRViYJA1iqTtU9wVNj
         zFaT/d8zK//H4vkebE+O+pXhxAeoub6gc1x6ecl69oYyUlY/kuRXov3u+QJCxbyPtOq4
         VXO0U1fFrsu1cGL6cVHRlf+u44k5omEKCplpz8gRgQOHxh9dZgGCh1zzbkD8REKtHW8h
         Ij0OCCPfN/9U6P0o+8cK/+66jbW31Hgo9HD5uxocwRuHSaiV8acn32sXDRSJT4L9/Pmj
         t4WOlBQTIl9+3E8SWKWbRrM2CbCtvSFSoFsFcFDxe4OdG1uYPULutvMGom8bs/su8bZz
         uY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719121219; x=1719726019;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8gsboRjLNvP365oqxS3SRWYp46DTNXjyQa5IQ3IG07o=;
        b=afvXMnqypaW/icQTZeupIUDMqWFtQyAK0XGeGWPDSEM8AcPBrv9HDyBucjKTbJ/vlO
         bwU1cbWRKb5lqTjGw5/dY969MLzwgLinR4BotG0P1QHKpzStYddouUWYfzB+mXRtp8p+
         jSzpmqjzN/z+vjEJUmeJpOgFzLhlUGF4GWu52Bi1qhV4Kb7Ba+jBcoimcQH9pWBKvWYi
         nQK0IC8/exz1av++iHUI4STkmG31pUujjd2hoX55wXEHhFwfbgVcLNx2WrH1dop2ejyB
         tKel4K9Ozjy8YBH2Eh6e9Gkd9cU/sq5m89o/Y42Y7RGr3als29eg4qRG5Avfj8UoM5wD
         iZKw==
X-Forwarded-Encrypted: i=1; AJvYcCVOkpvQ1Gw2ciig8H1MMnJdyc6EYrHWEXEmpdS9LQqx+Tyn71VM4ImkPMbl19/G/ftQlYwGAUayzJ2i6WOPdTRNM6Q2won+wpCYaJWC
X-Gm-Message-State: AOJu0YzQi8gb6BnwrUIQif42SOKpXhnmTFBMyMNssp+e75GjbtLz6LQY
	KuYf/X54YwQ5SDpsoaHwauwYj2So05TeSs1wbbaAkaOSKjGl/RWmppKEh0eNYCc=
X-Google-Smtp-Source: AGHT+IH5bFasAMzG10xpgyO+i11yH1ExZrFAHzShjvIIzPkIswWRS/NjOB/xAMV9oDfsLvEVFOl0/w==
X-Received: by 2002:a05:6512:3b95:b0:52c:d5ce:16f with SMTP id 2adb3069b0e04-52cdf348135mr1031235e87.19.1719121218828;
        Sat, 22 Jun 2024 22:40:18 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd63bcd32sm659696e87.65.2024.06.22.22.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 22:40:18 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 0/2] drm: fix two issues related to HDMI Connector
 implementation
Date: Sun, 23 Jun 2024 08:40:11 +0300
Message-Id: <20240623-drm-bridge-connector-fix-hdmi-reset-v2-0-8590d44912ce@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADu1d2YC/5WNSw6CMBCGr0Jm7ZhSkIAr72FY1HaASaQ1U0I0h
 Ls7cgOX3//cIJMwZbgWGwitnDlFBXsqwE8ujoQclMEaW5vGVhhkxodwUMenGMkvSXDgN05hZhT
 KtKDx1DZuMJfKOdCll5Amjpd7rzxx1tbnOF3Ln/rf/lqiwbqkru3q4AP525Ojk3ROMkK/7/sX9
 6ErpNcAAAA=
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1267;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=x3zgeMUTwoUy9QgsxTnuE+bkVAeAn87c0VbBknwvLvo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmd7VBXUml0sqm6bcf7Rq40RxW7g1MXSd+b4MAH
 fNki5/F/kaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZne1QQAKCRCLPIo+Aiko
 1ZPZCACLQUaputyh1cxkGrc4CMFkKMrm+u6ACOXjAd0JE0g+8Xc1ERNFtsSlvdaot4QjhZszF5k
 OGXu7Wmew4TyW5qT3B+oVMqTeQim7z+xzDV5BqGxYlxcKtRlyqDjvhcyoPAvyPusxN75qzpJqeQ
 DcYf/LPLlLESejoQy1MUvfvxF9+G8Jc6ejhD5I/xGOgCUPvWBX/rJDy77Dv8SLllNjQnKYU9i/f
 ykV4hq623Y8DRUxGoQp4VGWKMQQX+gq2TA2JqJ/w4IXTlJKVL5T7+Z1fyWBCqM2JCU+qLdvle2p
 bZeYLdDhes+ZGEa2IOyrpXYKeC5kAMbPEtyd1CBeyD7pnqRE
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Running IGT tests on Qualcomm Dragonboard820c uncovered two issues with
the HDMI Connector implementation and with its integration into the
drm_bridge_connector. Fix those issues.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v2:
- Actually pass the flags to drm_property_create_range().
- Link to v1: https://lore.kernel.org/r/20240623-drm-bridge-connector-fix-hdmi-reset-v1-0-41e9894dcdec@linaro.org

---
Dmitry Baryshkov (2):
      drm/bridge-connector: reset the HDMI connector state
      drm/connector: automatically set immutable flag for max_bpc property

 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 21 ---------------------
 drivers/gpu/drm/drm_atomic_state_helper.c       | 21 +++++++++++++++++++++
 drivers/gpu/drm/drm_bridge_connector.c          | 13 ++++++++++++-
 drivers/gpu/drm/drm_connector.c                 |  7 ++++++-
 include/drm/display/drm_hdmi_state_helper.h     |  3 ---
 include/drm/drm_atomic_state_helper.h           |  2 ++
 6 files changed, 41 insertions(+), 26 deletions(-)
---
base-commit: 2102cb0d050d34d50b9642a3a50861787527e922
change-id: 20240623-drm-bridge-connector-fix-hdmi-reset-0ce86af053aa

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


