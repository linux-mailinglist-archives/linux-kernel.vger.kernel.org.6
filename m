Return-Path: <linux-kernel+bounces-576810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D985DA714B6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE15D188E35D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B822A1E521B;
	Wed, 26 Mar 2025 10:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QZot1iL1"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1D21E1DF5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984415; cv=none; b=tpNK4QSyf9d+3rGvlbvFCvLRRkEzSusJrowpLqywGftFPJ2m1ZXFWrLTijiE8Rb2aEnBRk1fZqupEhyYLtsC5i6TeQfupBYm4Jb4NEkZ2wDS86ovy0siodaNx1xjnFxuHajnDntwYG+yw+yj2ekTBfOqN36NxTniKSDYYrS7P20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984415; c=relaxed/simple;
	bh=MaB98o554CFGNYLkXFYvFzYePL2MI+O6Ngqg2ShcBKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nnY2CXzLmQtLMrp0XcWr/5/PpiPEfVlS74i3Kaz87IK5qLBqLewPJsVJ+9Kex2pWEVi/0EYe/8h7zD3uAkresew6p/VubvM+EcdcNLGFLIkOGCxroKq3Vm5n6JtcyXC51Hwt5als3EQHhRtXF1KWUvnWDpzJQQn4HrTI750txB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QZot1iL1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742984411;
	bh=MaB98o554CFGNYLkXFYvFzYePL2MI+O6Ngqg2ShcBKM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QZot1iL1GK9/Bv3fh0MXIBSlfgx9wlgNLGrkSvFK5xbriL5z9icgJp4oU/dgA0Qfd
	 mUeCK1jvVFkkLIZpRH4wQ7WVYkfoZKvbJu5t5P1/q90dc3eRUV6N2gnSmap8ndRSYC
	 MdA0KsQwQpIJLxZZaIZ41Uc7lxdAY1gppt89/cSV50dvAG3JpCZe3tJbIa6BqMDDJG
	 CwHMznkhfPw+R8s644efVrJ1CzyeVD/7kjqYiIeG6z07awVmKzbKyNkHzGGJIV6OJc
	 29vnGF3eUeCbu0GNoOPOa1ZyXRIj0CowfUnTc2o5Ei1DOco5yXctmU6bhfGf8u+a/e
	 AMnTkWnZKLNsw==
Received: from localhost (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 8226A17E0E8D;
	Wed, 26 Mar 2025 11:20:11 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 26 Mar 2025 12:20:01 +0200
Subject: [PATCH v3 12/15] drm/tests: hdmi: Setup ycbcr_420_allowed before
 initializing connector
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-hdmi-conn-yuv-v3-12-294d3ebbb4b2@collabora.com>
References: <20250326-hdmi-conn-yuv-v3-0-294d3ebbb4b2@collabora.com>
In-Reply-To: <20250326-hdmi-conn-yuv-v3-0-294d3ebbb4b2@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Initializing HDMI connector via drmm_connector_hdmi_init() requires its
->ycbcr_420_allowed flag to be adjusted according to the supported
formats passed as function argument, prior to the actual invocation.

In order to allow providing test coverage for YUV420 modes, ensure the
flag is properly setup.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 1e32694041277a541f0f8941d9c35e8ca9264599..6897515189a0649a267196b246944efc92ace336 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -184,6 +184,8 @@ connector_hdmi_init_with_edid_funcs(struct kunit *test,
 	enc->possible_crtcs = drm_crtc_mask(priv->crtc);
 
 	conn = &priv->connector;
+	conn->ycbcr_420_allowed = !!(formats & BIT(HDMI_COLORSPACE_YUV420));
+
 	ret = drmm_connector_hdmi_init(drm, conn,
 				       "Vendor", "Product",
 				       &dummy_connector_funcs,

-- 
2.49.0


