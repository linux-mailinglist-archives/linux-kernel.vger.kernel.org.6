Return-Path: <linux-kernel+bounces-576802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA81A714AB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36D6B178274
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386591B4139;
	Wed, 26 Mar 2025 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IT6INH7l"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67581BEF87
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984405; cv=none; b=sIMIqVpt6nPZg4+56X9DyVRJhQpijoophpZaznzKXzuWEzL6P2hlZ4jFworXQ9wMh1NPYiTLuQsHaVVL42pJond9y9M6vCvw2vQsyLZykS0ATxaris8NbpbsPNDRzfKJyH53CMuJmVA8bkl3JUOQNPLjtGOjG0m3iNfCVugtSwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984405; c=relaxed/simple;
	bh=YwDJVq02TOowWFPqiY54kVfZ8/K6L4M+Y6kDYiCoe7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k/kxZqdjMfYJVeLZiG3qlJza1Ss868XtWCVvFmAl/2ut5/2v4myPgeFbbu/snodN+cIP+B8EWS1gi0nMvmXJ15qqbknIfZI2U4eTBxyByZwrXtH34oFBH5jv/vEckr7qG4NWXDDUq3Ra5FMrJwFZMoKfyPdY43BQDjpnKUf517M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IT6INH7l; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742984402;
	bh=YwDJVq02TOowWFPqiY54kVfZ8/K6L4M+Y6kDYiCoe7A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IT6INH7l+9NWFFa/WJlXKoFFyYRXEANCtn+XKUUQvMfE9nhWuCkkuytA/Ly2M34lw
	 DI3xq6NvoyInLoVZo3ceNvnhJHtR5X6PX1MxsMAecQO6Bq+r45wlIoM4/FbXchqHCx
	 rN3dErhYe98o5AVXdsEXw1tdF+tNiVxgM24gnelpn9Kpe50Kz1e3S8Y8Esd+FqSAKr
	 P9NokjkFjOBdErmPGmffZ2f6SeS7LZ8thx5SvsG6G8wdqWmBwg+f+lo9bk7eqduDIC
	 Z4rnthr3ttPeFGhbtdWUCp/Q6K3ymmBc2dpC7XFSBLsBU6w0hvKk051NfWDTzP8fLv
	 e4XCsHgwcBOHA==
Received: from localhost (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id E854F17E0FDB;
	Wed, 26 Mar 2025 11:20:01 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 26 Mar 2025 12:19:53 +0200
Subject: [PATCH v3 04/15] drm/connector: hdmi: Add missing bpc debug info
 to hdmi_try_format_bpc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-hdmi-conn-yuv-v3-4-294d3ebbb4b2@collabora.com>
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

The very first debug message in hdmi_try_format_bpc() is incomplete, as
it doesn't provide the given bpc in addition to the tried format.

Add the missing debug information and drop the now redundant message
from hdmi_compute_config().

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index a0cb3163f457635cf27e53b009bd83f85eee9336..f54eb5c594cddbd67dfacb5e06d54e9ce7851013 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -578,8 +578,9 @@ hdmi_try_format_bpc(const struct drm_connector *connector,
 	struct drm_device *dev = connector->dev;
 	int ret;
 
-	drm_dbg_kms(dev, "Trying %s output format\n",
-		    drm_hdmi_connector_get_output_format_name(fmt));
+	drm_dbg_kms(dev, "Trying %s output format with %u bpc\n",
+		    drm_hdmi_connector_get_output_format_name(fmt),
+		    bpc);
 
 	if (!sink_supports_format_bpc(connector, info, mode, fmt, bpc)) {
 		drm_dbg_kms(dev, "%s output format not supported with %u bpc\n",
@@ -638,8 +639,6 @@ hdmi_compute_config(const struct drm_connector *connector,
 	int ret;
 
 	for (bpc = max_bpc; bpc >= 8; bpc -= 2) {
-		drm_dbg_kms(dev, "Trying with a %d bpc output\n", bpc);
-
 		ret = hdmi_compute_format(connector, conn_state, mode, bpc);
 		if (ret)
 			continue;

-- 
2.49.0


