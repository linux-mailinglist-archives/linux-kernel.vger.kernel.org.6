Return-Path: <linux-kernel+bounces-555915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD26DA5BE4F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674D51897895
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330E62512E3;
	Tue, 11 Mar 2025 10:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BbFsu31j"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C7322F163
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741690683; cv=none; b=ZT/i+CW3XedEZQZ8qcHmHsya6RbKLVKQt0E4tBPbx66vR1j1Dkv204J/H5qdKpWV91WavaCih5gqZvi6puGrCxBoTgHjJG02X/tRGGK/pV1NIV7QUfIcokYClvZnLLZGIcOu7QZEONjJJkYWVhDbpJpdfZJu4hNWAKSPFycnJwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741690683; c=relaxed/simple;
	bh=eUTUFtS8Nktp9rKcRss9kYcMfJ0/9ybWHArlzdKrdNc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GG1jSN2Mm5CZ+ayAoNieQxNikyShssldWFITRFbDbucoCI3+/Pe92Q3+wLn5+iCBp0i2n6A4C869kw+2LSFARE3PlJT+mW2Ij1qUeYaMHZLRadOwo44uryZ4L1QXjMmlK5oyd3hfqoOgepRHkKJwWtYNEZHM1astjqM/Q74Gyag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BbFsu31j; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741690680;
	bh=eUTUFtS8Nktp9rKcRss9kYcMfJ0/9ybWHArlzdKrdNc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BbFsu31jQ4vmn8GMqW58a6I0NP47h+H8awJA0kLjeXJ5te3qAQ8lt+8WjsUPagYqW
	 G4J2KVxtCNu/Uo18UqWtsZj51x1Mbumznl/jInS3Jz/AIqR7gd6EmIKdwUxYLcDI6O
	 XJWaB74ni8N3oShohalM2DFetZgOE4kr32zzqBn/H0h6HRcacJoeXUZxMYypiSWBhy
	 Np63po1dfvaVASlaZEhEhnes9auIt9T/fb+WmUwVd6Saei+lbQC96lt5ejR40yz9D5
	 gvq4E96WCnyLUVXVwpI9hdQUqcMi5eC1i+KrpLiDgkScZhw4E7IU8WunQIEyOme5Dh
	 h1C+UrXS899kQ==
Received: from localhost (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id EB4C917E13A2;
	Tue, 11 Mar 2025 11:57:59 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 11 Mar 2025 12:57:33 +0200
Subject: [PATCH v2 1/7] drm/connector: hdmi: Evaluate limited range after
 computing format
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-hdmi-conn-yuv-v2-1-fbdb94f02562@collabora.com>
References: <20250311-hdmi-conn-yuv-v2-0-fbdb94f02562@collabora.com>
In-Reply-To: <20250311-hdmi-conn-yuv-v2-0-fbdb94f02562@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Evaluating the requirement to use a limited RGB quantization range
involves a verification of the output format, among others, but this is
currently performed before actually computing the format, hence relying
on the old connector state.

Move the call to hdmi_is_limited_range() after hdmi_compute_config() to
ensure the verification is done on the updated output format.

Fixes: 027d43590649 ("drm/connector: hdmi: Add RGB Quantization Range to the connector state")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index c205f37da1e12b11c384670db83e43613e031340..6bc96d5d1ab9115989e208d9899e16cd22254fb6 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -506,12 +506,12 @@ int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
 	if (!new_conn_state->crtc || !new_conn_state->best_encoder)
 		return 0;
 
-	new_conn_state->hdmi.is_limited_range = hdmi_is_limited_range(connector, new_conn_state);
-
 	ret = hdmi_compute_config(connector, new_conn_state, mode);
 	if (ret)
 		return ret;
 
+	new_conn_state->hdmi.is_limited_range = hdmi_is_limited_range(connector, new_conn_state);
+
 	ret = hdmi_generate_infoframes(connector, new_conn_state);
 	if (ret)
 		return ret;

-- 
2.48.1


