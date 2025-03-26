Return-Path: <linux-kernel+bounces-576801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 825F0A714AC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31FE189BF24
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD4E1C8627;
	Wed, 26 Mar 2025 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Vlcs1Cpf"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFE11BC9E2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984405; cv=none; b=Jlcmqpj541WpcEFnf8NPRGagPxrgjhMnkyfk8+Bw/8V5E+bPvfkQ7RGAqsxBCWPNHrv5UsOrfTMJhf9OMywxPytYqH+cIT5JBy3/oLSOOgmvBIgIfCJ3IcHhEtJPagpn33DZjFzzQz1EQFexnBGlI9t+SXmUEQYAPrwedzMnKjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984405; c=relaxed/simple;
	bh=RlyWP2QsjTsHxaZYoCMc/KglO80bh7kVFpo7Z2MtuMo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=agtS/NL4WFqLVYWon4Tz9PV2zx1Iq5X5dXM+oSxzuQ5kRJBtpLBTC5xeicPRYbBSNNSj/xnt7taSbD2S1Ifma9p9umA9OCR30omgsTmzgtr5Tj6naqXcz214lCwTUsLtuXDOJ2ZdiML++89iemoCvU1aIn6fDF23YHU3lAmaLsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Vlcs1Cpf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742984401;
	bh=RlyWP2QsjTsHxaZYoCMc/KglO80bh7kVFpo7Z2MtuMo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Vlcs1CpfBqJUtdDhMaq01dyUGkIv7DZSGiqvg+D0L/iMm3d4FJ5DBVfLiCoS/wwkh
	 wQiPtDBpqoUZkaCuwjJJEvL3Yb0qI8Eflua6gDXADdeP/gp8tdgvnBq1uomeUaFawx
	 kQUZEGpjOaHch0JRlZNhY5owtDIbcl4B/VZ3VhFI8jXDzfyBYoG74h85TDo0/IxhOf
	 OCAi/xF4eNDSvZNJVzbsEk6lBKQHhR3bOCZRSPaihRHUj8j+7XGUT5q1Vqiw+Vt800
	 Yi/t1E8twT/jC/rU0As5lrb2OoXqA+WnY2YYxRTosELpLhkuX3ehzBCMli6HkV7dRG
	 W05y37dArFbPg==
Received: from localhost (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 237A317E0FCC;
	Wed, 26 Mar 2025 11:20:01 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 26 Mar 2025 12:19:52 +0200
Subject: [PATCH v3 03/15] drm/connector: hdmi: Improve debug message for
 supported format
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-hdmi-conn-yuv-v3-3-294d3ebbb4b2@collabora.com>
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

Add the missing 'bpc' string to the debug message indicating the
supported format identified within hdmi_try_format_bpc() helper.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index eb284032ea794838f333ce639243540fca91dbdb..a0cb3163f457635cf27e53b009bd83f85eee9336 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -596,7 +596,7 @@ hdmi_try_format_bpc(const struct drm_connector *connector,
 		return false;
 	}
 
-	drm_dbg_kms(dev, "%s output format supported with %u (TMDS char rate: %llu Hz)\n",
+	drm_dbg_kms(dev, "%s output format supported with %u bpc (TMDS char rate: %llu Hz)\n",
 		    drm_hdmi_connector_get_output_format_name(fmt),
 		    bpc, conn_state->hdmi.tmds_char_rate);
 

-- 
2.49.0


