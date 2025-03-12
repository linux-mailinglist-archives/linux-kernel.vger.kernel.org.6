Return-Path: <linux-kernel+bounces-558031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F06BFA5E0B3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB8816CD3D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2165A253341;
	Wed, 12 Mar 2025 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="gI1MU/Xh"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C92252907
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794084; cv=none; b=Uyg57VXJWWXIfClPTcFR1kxNya/lnT0GpcsGoLE2ySj4wvy/IrxsM+m0lJREDVAk6+kT3uvPbCGJK4ANknblZvkkaMLxsHe36fm6AjEr1DHYc07hmAfnvMLX2Kmc9Q8bK544qNYKoJazQ5OXeQbNmb+o/HK3Qq0b5aFGVckJsbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794084; c=relaxed/simple;
	bh=NvOj63iDeDitCrKOmbOlDjgIJlVXvpdI31+1URewXDA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k2IB2h5ERhGg9upsa7uXTforzoI7Dn4MmeZL7dSawbnH3jF06sM0M8nL3d5NM0SC95Vb/aTON17HR2irGx4VXHZvzYupcNFJ3Y6nuRS2YPD5fY5XuraCyYHC2DCgKu5j1h2kuu1OU/Mote7Ph5XShnbRLfB+Xq6SugM4H3eeghc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=gI1MU/Xh; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cf848528aso31685575e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 08:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1741794080; x=1742398880; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OfUT6kCFSXIkCrrgruX0eG+NMoJfpuEuW5DgyO4JO2I=;
        b=gI1MU/XhwXP17S8BDmFqdW6Edp9PZb4BxMU749ip1oiPmas6tGcveZ2WfH4BB15ngT
         MODSiRR1wS9HCU3bxP17PzfU8QDlIgxEBtmmQ1DGflmOWNKOLu5mvD4nN54Cjku69dfQ
         lBGxxRAUOfKYqb2yaVYja/imp5qx7B7cMWR6801+t1zvHBF67Ucv4SCr1TRO8pjjonmu
         FN3ZmDH3tqxX/gqHW+HEKU45qhzV/mwA4+rsUD+meMR1fHYgfNVxN5JAn02MQnpuzWRR
         iEs5BbUul6w3kStYhU7phEyT3j/wnT6Fpe+fraD42IayzmLTz07nKF558Rs0j4THrMfm
         7pHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741794080; x=1742398880;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OfUT6kCFSXIkCrrgruX0eG+NMoJfpuEuW5DgyO4JO2I=;
        b=gA44nAJqanCG4N5fmww8WMluChp39zeHRmP1f/2iKnQLlA98owdFeckGVPMjUnd4YG
         3pMu3qdqhLtU/SxoiyzmnwOGK6NjQqACPk7gVoGjN4vmkbv9kw9bnVL68x2tqeEZMENK
         6EOjc5uqp4OeJjE1THUXQm7bVru/2RcvH+rj9yp/YQ8xnbRVw4oyuLqkdLxnAznKTgn6
         S/BrbvcWUJT0mhpW1vlllPCQB/UBrGWzee3N8c8zE+E3QamsvanytbRjYKGA4DXz1U7n
         utPfAI03ewlCcwQPUha4ju7LiwSQa48DxNrjZeY+VlHcoOtvfiuNI3sly11w+wrhysm/
         V1xA==
X-Forwarded-Encrypted: i=1; AJvYcCXFuAHYDb+lNKF6uMmPrlJZzj93o3ODWT5p6XRRA4hPpBpwEWu+rxbRCuLMHigMJOOv4KddovMHmjrwc6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw09+/ON0pRnTH43fFdB7WC9iRVAhediU2O+0ADHj6gSknNIqye
	M0Vu/3VEJA7W/YNs7ROh7WmGjYjfkb36SAy03QxNNVYKLTOmBqjItmT4KUcOSYK5NJeL/L9J0g7
	aHXQ=
X-Gm-Gg: ASbGncvYZD/PAdebcvDAGZmlWaRdvGEh8HVdyGc/Hfani44NgqmzzegTDgHy3G3/HYM
	uqvhVwgYLnyk++L1SHg9hFsNmfbPqV+mSc91RUjrBxHtwH+BymNO+PnLpzY1lcq0dq8h+N9WCP+
	2msNjNsmclMLT+y+uL4iMOl8PM6A6sjKvQqeJBjDL9prRZcSKKBHLAvlNJrn410rdWCQYFrXZ1f
	GnUy7bXYtUN1WSBMxJ/5PyPCVSDa6iL+pukNepplJni6Oermrvl6tFYJM+P31i8W0ub8HzReKyL
	CH846aj9Q78XXxSU+0yM8wD37EqlqhPbWQ==
X-Google-Smtp-Source: AGHT+IENCzZL+aT1XOXTb96mtylvqWlPttqLP4HGjDO8fHEAP0SFs7XnK2I1EcdWPZg6cleMtlKkqg==
X-Received: by 2002:a05:600c:3143:b0:43c:ec0a:ddfd with SMTP id 5b1f17b1804b1-43d01bd2182mr84819235e9.6.1741794080259;
        Wed, 12 Mar 2025 08:41:20 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a78bdbfsm24374915e9.25.2025.03.12.08.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 08:41:19 -0700 (PDT)
From: David Turner <david.turner@raspberrypi.com>
Subject: [PATCH v3 0/2] drm/vc4: hdmi: Add jack detection to HDMI audio
 driver
Date: Wed, 12 Mar 2025 15:40:54 +0000
Message-Id: <20250312-vc4_hotplug-v3-0-d75878677de8@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAar0WcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0Mj3bJkk/iM/JKCnNJ0XePEVJNUcwtjEwuTRCWgjoKi1LTMCrBp0bG
 1tQDa1TmoXQAAAA==
X-Change-ID: 20250312-vc4_hotplug-3ae4e783484a
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 David Turner <david.turner@raspberrypi.com>, 
 Stefan Wahren <wahrenst@gmx.net>
X-Mailer: b4 0.14.2

This series enables jack detection for HDMI audio on vc4 devices.  This
means that userspace audio applications can detect when HDMI devices are
connected or disconnected, for example to play/pause or switch to
another audio device.

Changes in V3:
- Update comment on drm_atomic_helper_connector_hdmi_hotplug() to
  clarify that it must be called for disconnets too

Changes in V2:
- split initial patch into fix and jack detection feature as
  suggested by Dmitry

Signed-off-by: David Turner <david.turner@raspberrypi.com>
---
David Turner (1):
      drm/vc4: hdmi: Add jack detection to HDMI audio driver

Stefan Wahren (1):
      drm/vc4: hdmi: Call HDMI hotplug helper on disconnect

 drivers/gpu/drm/display/drm_hdmi_state_helper.c |  3 ++-
 drivers/gpu/drm/vc4/vc4_hdmi.c                  | 22 ++++++++++++++++++++--
 drivers/gpu/drm/vc4/vc4_hdmi.h                  |  7 +++++++
 3 files changed, 29 insertions(+), 3 deletions(-)
---
base-commit: eff0347e7c228335e9ff64aaf02c66957803af6a
change-id: 20250312-vc4_hotplug-3ae4e783484a

Best regards,
-- 
David Turner <david.turner@raspberrypi.com>


