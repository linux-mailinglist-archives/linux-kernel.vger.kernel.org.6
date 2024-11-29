Return-Path: <linux-kernel+bounces-426008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F959DEDB6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E4716368F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 00:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD52918A6C0;
	Sat, 30 Nov 2024 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GkX25JLP"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD951E487
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 00:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732924834; cv=none; b=eZFhZjjz2uMd6PVCvzxpS2wJAUVa3HxlNtzxu8XMkpy/zL9HQ8BVXroeA4wwv2Lsw2E2oQs3UmQm13oAzSiGpxMdnKgYuB9Z16TFioJQSR8ZGS2jb3x1lKpARFfp1XVKD4EEaPIotv25wzXk35L96wjBHch2OFVDkrnUE8kOQ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732924834; c=relaxed/simple;
	bh=W1HibQ9xsma1KDzi+AGd4o9sDlBpPQXYOQNxed481Qo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p0ICI3BpWfDTxi5s4KlSUzAl3gg+mMYroaJNUMq61wiH9SyoSdDK73Qlx+KdQ/Hqy4OS6yBe7B9fGE9+o+7/ciqJDwG2NO44B272FdQcpTeueqcngIZ/LRXuMWcr7HQd1DWUQOigKmogewWD1i9wKrEopO8D42Q+Uq8rN9Agbwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GkX25JLP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732924830;
	bh=W1HibQ9xsma1KDzi+AGd4o9sDlBpPQXYOQNxed481Qo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GkX25JLPmMRvOOprAk5gVhykgnZzKZD3+xks198uHojL70Ut6HT0ykC8Fzm4kpZeF
	 LwoflTJVZKgPJRlFtpO8ouQ0gtKBbP1JAkd/g9reidbcl9qJRHj3Plb+O2zalZYNGM
	 XixodShsOK4IV6fOjpSDi/oQ5QscigeNthP2+XC+RjCKuE90lTPctVDSyP15ums0eU
	 ThX0CwYjklQxEvrDTYEmKtf605A2kBZtRVO6v4N5kTNhNaDCrJSXcKs4Lwq+wOCVak
	 xJSqoffdXYFii5o1s/YRAYqfkfgtUnD/emOJJNW/ri1dB9+yVrHsQdMb13/V1jSb+4
	 mP5FiS9Y97t8w==
Received: from localhost (unknown [86.120.21.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8436E17E0E6C;
	Sat, 30 Nov 2024 01:00:30 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 30 Nov 2024 01:56:32 +0200
Subject: [PATCH 1/3] drm/connector: hdmi: Evaluate limited range after
 computing format
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-hdmi-conn-yuv-v1-1-254279a08671@collabora.com>
References: <20241130-hdmi-conn-yuv-v1-0-254279a08671@collabora.com>
In-Reply-To: <20241130-hdmi-conn-yuv-v1-0-254279a08671@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Evaluating the requirement to use a limited RGB quantization range
involves a verification of the output format, among others, but this is
currently performed before actually computing the format, hence relying
on the old connector state.

Move the call to hdmi_is_limited_range() after hdmi_compute_config() to
ensure the verification is done on the updated output format.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index feb7a3a759811aed70c679be8704072093e2a79b..0cbcee7e77cd8dff387044487ce28ee5748f5587 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -494,12 +494,12 @@ int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
 		connector_state_get_mode(new_conn_state);
 	int ret;
 
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
2.47.0


