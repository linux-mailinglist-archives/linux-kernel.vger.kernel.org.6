Return-Path: <linux-kernel+bounces-576805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B203A714AD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F80D3B95A8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106181B9831;
	Wed, 26 Mar 2025 10:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EgG127FC"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE561C7015
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984409; cv=none; b=jirWU/zU3+Om+L7ObtNX1eEWtgFlQK+x2tcH4ABC+hkKsOheLUxrMn3vhKM1rrY5rlaKRA4bHxgTUPqufyWxp2wGWUOAoWVDcx1IBcaZb/5uOlrwxe2KVtlNRoF/xXLRVpLAoqKs5kL75AsLyjrZChFhMajN/dv8+gXayHhmDJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984409; c=relaxed/simple;
	bh=kWYvxqjKorV2NXGSW+7sreFvakOrQdavOIvZdsoGzbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cHsDEtMw3R4SfjyRSie8Jwo6XhgJnQ2zmVk1Ow/+sHkobZOYGKhWg50h8HPt39qMNb8Q5Ne7t3qr1i0ZKzxWk8kylZ0h2LCvNrgo+e0MyMo+CZe/RE92PHGzxdhiExeonJJsPqX8O0jjmVSnAQ8a8rBfATfWlxGqTLUx2SfR13c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EgG127FC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742984405;
	bh=kWYvxqjKorV2NXGSW+7sreFvakOrQdavOIvZdsoGzbo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EgG127FC9lgj/sxZa/b/xS6vEnHEOjjXci2q1HlF+HA9b7ZOPJnvS/+wgapN++Vul
	 LWe7beitKH91r+WN0oq9BBw8X2y0Ng3GAN6tYb7EEKCvM0WgaJe/C7AbhH7EFkcwpp
	 BUmbvmez2o6svAIQe+WgxjK0mZY5lBlUzaaCKsjhfggZI2DgvAST8ijKIcEgXyHAYw
	 EaWSUHO34NadBdMPQFo3T5u6BqTlx4O5sVsTR5g+77NWJyyb6yLoc1+iln4IFuwUE5
	 SVPwS9Z9IdVHNJijBl7wNXbpn6BHWGXXZu9qZ/pbXUy1mg8EX523yVeZhaH7BcGa3e
	 Yrbmz3VNSY63Q==
Received: from localhost (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 5641D17E0B9D;
	Wed, 26 Mar 2025 11:20:05 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 26 Mar 2025 12:19:56 +0200
Subject: [PATCH v3 07/15] drm/connector: hdmi: Use YUV420 output format as
 an RGB fallback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-hdmi-conn-yuv-v3-7-294d3ebbb4b2@collabora.com>
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

Try to make use of YUV420 when computing the best output format and
RGB cannot be supported for any of the available color depths.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index 6de0abb15ecb36fd4eb98725e2a3835e5e0db134..3859600c6af4a79f30858adfc9f9a710dfe561a5 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -650,7 +650,17 @@ hdmi_compute_config(const struct drm_connector *connector,
 
 	ret = hdmi_compute_format_bpc(connector, conn_state, mode, max_bpc,
 				      HDMI_COLORSPACE_RGB);
+	if (!ret)
+		return 0;
 
+	if (!connector->ycbcr_420_allowed) {
+		drm_dbg_kms(connector->dev,
+			    "YUV420 output format not allowed for connector.\n");
+		return -EINVAL;
+	}
+
+	ret = hdmi_compute_format_bpc(connector, conn_state, mode, max_bpc,
+				      HDMI_COLORSPACE_YUV420);
 	return ret;
 }
 

-- 
2.49.0


