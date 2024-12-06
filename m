Return-Path: <linux-kernel+bounces-434753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD459E6AB7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D812B1881BDC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7FF1F03DD;
	Fri,  6 Dec 2024 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HNhRRJ3O"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145021E130F
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 09:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478196; cv=none; b=KNtbkxG2MTjUnDVGCOkXAiWItLNFrfVGKsw+MkQiWc20DhT+8UdkA7Rp5fcQq3SW6PeDz40Yivuvs5i7q75cKoz8wyyii0PGrHr/tJL+vnBoTf9cD7VNOitJUA2UNXhUWirFgKL5ef9ywpF2PbyNRs4kUz8MUPcSB+qK+QIi848=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478196; c=relaxed/simple;
	bh=/vOUm2QLF9KTC3t0lXMssols8AsbLs9YQ26k7XYzTjU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d2GGhpAP9REGpdzJWqfXoEfQjfFMA+Po6uBiWzavnQBhe+en4LY5boqrfIcIWwiscpMMWP3su4UiqaJBoYxKi+EU5fP/MQeYRJzTXEZhtCZnToscRWjDy+w9v4F0daB80mgtC6TCybbBp55EnYllQybXsItcNINeY/wVxUefGsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HNhRRJ3O; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3001d009633so17069101fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 01:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733478193; x=1734082993; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=18q4gQOuDIplzBrBAcJFu0OAO0g8UI+mX4z+LvhVWHM=;
        b=HNhRRJ3OuxUojmL0Vd623RrIL1XUH4gsKAAkF83lx8+PI1ZZnon5VSEDF6EPJj9vPg
         2KGKu6pZgS8vNdx1QMfc5isdwRRxuq2OYvFaK59IThkkg/NDTc9Y06jK/gpDqFL2EK/q
         9L18d+aeM6FiH5xRutp0g9sBtoNM7/wpxZJ5WsibtLPDboJ5j7cARJtqTmRlYjqHeB4R
         dY7qgXKmB1+b1YavEzKLb5QJHRSqUHkL/peZQbHkP1eMGAkUIDfXoht0QGpPziEmljig
         mC1mPbMP77O2Unp9Q+81z+PmkBBnKiqwMOHEXDeYR8XT2PfZkYzOl/f8qn7FQoYfZMZO
         ZIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733478193; x=1734082993;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18q4gQOuDIplzBrBAcJFu0OAO0g8UI+mX4z+LvhVWHM=;
        b=TTxe+m3qDp1jf7V+IPIPOyyeaXyDdPgkG/G+U9ZK5jYMX5IdzJHjroo0bPJIqnDtCB
         PgAYqYy7ezrRvCDDCx2Ow9YTb2U72UYh3/Y6mYQhtU3gzkfKAah1LuMySwscIfQKXmdR
         CFDKzwyGV/4zmBVNEv7IhK4mzSFC6Ec098f7kz4i22RwzIn5beKuGjbpbNAP6VADFGo/
         5ZG4+NwIwwLB1/LdtCmFjaxKBh88qvuqvV85472SsQWDCCMICOgrzd9oYimPxu9mmV8u
         EX+04cMN6hUg/X/f/9prZ88y4ZwMMbLa06SvdWMSisdSGlWLILKqAaDdHa1QEojx0tEt
         Um/g==
X-Forwarded-Encrypted: i=1; AJvYcCWJ4SeQWCQWHEbKP0ylJiA4R3CeOPOpRK5Qwwq9zi580t+uLuYNYVZzIzgTcFh54S8VRqv5LidGR5ZEMX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+QhVWX38RR6yL1N5Gkbn1kIduUoo9HIYW+IOcW6KKi5b99wVg
	H/RSifZqTiEOOVLdKAvytWjYZsoIe2n6RUgHI4T2lX7fRM/PZDWrAcAOwBl+eo8=
X-Gm-Gg: ASbGnctmkcVH2E8kdcLJPyeVMFC3zUOwcrXGZi8Hce1fb940OAQCLdjzFhPK+VyTu6V
	LrxHovLlYhBHZgp+WqitIq+m21C1+QLt5g/1QNV0NoAxAqmMDwcOqZU7eihV6Fjr1TlslAJIvvN
	ocbSD+2lruND4TX4E0JYAImkfqNYS7zAyVeqOy5WTTa3k0FSlzmSo/TTs87REwh02ma5A8U25zA
	gILCRO8encIHr8PDEugGBZJy32I9IPXtdFAg24F2aJQ2FVE75Sq/mGW5w==
X-Google-Smtp-Source: AGHT+IFlB2fuiknxBNErzknuRXx+qDTK7wodKTCgdmP8ceAx91Mtj3NnTnnSwVI5/Dq661IKM0tfTg==
X-Received: by 2002:a05:651c:b2b:b0:2ff:a5cc:3ede with SMTP id 38308e7fff4ca-3002f8aaa07mr7238681fa.6.1733478193192;
        Fri, 06 Dec 2024 01:43:13 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020db3805sm4128441fa.50.2024.12.06.01.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 01:43:11 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 00/10] drm/connector: add eld_mutex to protect
 connector->eld
Date: Fri, 06 Dec 2024 11:43:03 +0200
Message-Id: <20241206-drm-connector-eld-mutex-v2-0-c9bce1ee8bea@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACfHUmcC/4WNQQqDMBBFryKz7pQkGrFd9R7FRRqnOqBJmVixi
 Hdv6gW6+fA+vP83SCRMCa7FBkILJ44hgzkV4AcXekLuMoNRptJGaexkQh9DID9HQRo7nN4zrdi
 48uJKSzkayPZL6MnrsXxvMw+csvA5jhb9a/9vLhoVPpytXW0r61V5Gzk4iecoPbT7vn8BhEyW3
 L8AAAA=
X-Change-ID: 20241201-drm-connector-eld-mutex-8a39a35e9a38
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Phong LE <ple@baylibre.com>, Inki Dae <inki.dae@samsung.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, Jani Nikula <jani.nikula@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2527;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=/vOUm2QLF9KTC3t0lXMssols8AsbLs9YQ26k7XYzTjU=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ3rQcV3/Ndz5pfcma9y/9rZALvb68aKcpQ1RgqeV82p+B
 oaVTIjoZDRmYWDkYpAVU2TxKWiZGrMpOezDjqn1MINYmUCmMHBxCsBEgtvZ/4c9Sqg0ZWr8pqe2
 fkq46C7R7Ij/0hcTXiY8DPrrL7Y/pKL1lvoDK/6HR5alBc0X5Ggz2Jz+bc2f84dlrj4WyjdgnWI
 wLbFsz9v5a1Qdd3iu2stq0ikxlfHztWlGzrHikix2G1iPKsfWnA19s5yxeH1g4QWnF1wa67bc0Z
 KN/LzKudOiv9Ul7W3Zs1sxt00qVB30ruomiS5ayfXM2/NSZuebD+aiptZpF8y0chTMFWd1ly3hW
 Oa6Q+X9pN3MPZPsw/tUuRV2S6WV6Glarp3s9r7EQOPWjoXzwnaJ/c46NqWN4Ujq5JZGX/uZbXkt
 E06rZAWXfTi43uT3vvWcH0J27OkpUHvg2uXdmTT5GNNUAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The connector->eld is accessed by the .get_eld() callback. This access
can collide with the drm_edid_to_eld() updating the data at the same
time. Add drm_connector.eld_mutex to protect the data from concurrenct
access.

The individual drivers were just compile tested. I propose to merge the
drm_connector and bridge drivers through drm-misc, allowing other
maintainers either to ack merging through drm-misc or merging the
drm-misc into their tree and then picking up correcponding patch.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v2:
- Also take the mutex in clear_eld() (Jani)
- Rebased on top of linux-next + drm-misc-next to solve build error
- Link to v1: https://lore.kernel.org/r/20241201-drm-connector-eld-mutex-v1-0-ba56a6545c03@linaro.org

---
Dmitry Baryshkov (10):
      drm/connector: add mutex to protect ELD from concurrent access
      drm/bridge: anx7625: use eld_mutex to protect access to connector->eld
      drm/bridge: ite-it66121: use eld_mutex to protect access to connector->eld
      drm/amd/display: use eld_mutex to protect access to connector->eld
      drm/exynos: hdmi: use eld_mutex to protect access to connector->eld
      drm/i915/audio: use eld_mutex to protect access to connector->eld
      drm/msm/dp: use eld_mutex to protect access to connector->eld
      drm/radeon: use eld_mutex to protect access to connector->eld
      drm/sti: hdmi: use eld_mutex to protect access to connector->eld
      drm/vc4: hdmi: use eld_mutex to protect access to connector->eld

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 drivers/gpu/drm/bridge/analogix/anx7625.c         | 2 ++
 drivers/gpu/drm/bridge/ite-it66121.c              | 2 ++
 drivers/gpu/drm/drm_connector.c                   | 1 +
 drivers/gpu/drm/drm_edid.c                        | 6 ++++++
 drivers/gpu/drm/exynos/exynos_hdmi.c              | 2 ++
 drivers/gpu/drm/i915/display/intel_audio.c        | 3 +++
 drivers/gpu/drm/msm/dp/dp_audio.c                 | 2 ++
 drivers/gpu/drm/radeon/radeon_audio.c             | 2 ++
 drivers/gpu/drm/sti/sti_hdmi.c                    | 2 ++
 drivers/gpu/drm/vc4/vc4_hdmi.c                    | 4 ++--
 include/drm/drm_connector.h                       | 5 ++++-
 12 files changed, 30 insertions(+), 3 deletions(-)
---
base-commit: 84e541b1e58e04d808e1bb13ef566ffbe87aa89b
change-id: 20241201-drm-connector-eld-mutex-8a39a35e9a38

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


