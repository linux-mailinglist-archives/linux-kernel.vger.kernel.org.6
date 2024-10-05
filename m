Return-Path: <linux-kernel+bounces-352181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DF3991B55
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 01:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF45FB21C60
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 23:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04EE165EEF;
	Sat,  5 Oct 2024 23:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="p5phPjBt"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBCB153BF6
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728170436; cv=none; b=aKBi8vDz2WSDXqVGpwKZYbYiMliO1ZS2Dy8U/fOu+vx7He/Ic4oLiGbIS5i3jVwNEYvpCa5dWX5sfywqh6kbPy9Uq7N37nU10VQq3DO9PDVoeocOMhBOC85U+IylCdS/anWSCD+cwtBnK8qnKAmz/mYUovmjQ0QLaM/WqsMtsQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728170436; c=relaxed/simple;
	bh=dv8sjAXRt1sF0KaQtPUOFnaTZMYFTu+8gvQ0tDraw2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HnIBKSEimiD4JsK20DWHwqvhs7rC4Q/Hh0Snmo/VlQHwjYoAwsbJH8bHaHkge9bLLRKPHZyykoZZne4tq43zev6bVV7EE8JcdTHuZs/uH48EdW3/uGc3su8iMV3fZIBs+oxqNMvLgBXPQZDXP7dg/CAjrfvzD0Vbdxw/hQtmPLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=p5phPjBt; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=1h47U4zkbB08oY79MxXtGdDxBtjrp6bmxDnN35wvcb0=; b=p5phPjBtFWo522gD
	LBdchIyrq1e3kjxiLyceOPUE/75OQhFjjyZlyOJg2l7hJdErlWuJDKFUPa35fX0/axVgkeDJ/yU/e
	sR4vFp+spxAerSRmN7+vEMbcYX4XzZ9LMi6whhHcEPWO7n1xDadOgREDHYyWU0HtD5Cavz2nU7mX4
	lEaDbWrqH6jGQ+49nQN3fglVMVzv3yGS3sRm6a92cFXOPLZ8V4/hU5gFSTRdohtXl73I5qHbqH+6b
	cnQK/5Wu3VsaFEfP5iRWMnequEHG9nmqbyHrWanwSNLikl0nCjX6h/RODY0Ob3zhZGPsTqW2I3pQw
	ou5QGSLXRLHx5eWeFg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sxE4Q-009DYd-0c;
	Sat, 05 Oct 2024 23:20:18 +0000
From: linux@treblig.org
To: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] drm/bridge: cdns-mhdp8546: Remove unused functions
Date: Sun,  6 Oct 2024 00:20:17 +0100
Message-ID: <20241005232017.305217-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

cdns_mhdp_hdcp_set_lc() and cdns_mhdp_hdcp_set_public_key_param()
were added by commit
6a3608eae6d3 ("drm: bridge: cdns-mhdp8546: Enable HDCP")
but never used.

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../drm/bridge/cadence/cdns-mhdp8546-hdcp.c   | 28 -------------------
 .../drm/bridge/cadence/cdns-mhdp8546-hdcp.h   |  3 --
 2 files changed, 31 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c
index 31832ba4017f..42248f179b69 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c
@@ -500,34 +500,6 @@ static void cdns_mhdp_hdcp_prop_work(struct work_struct *work)
 	drm_modeset_unlock(&dev->mode_config.connection_mutex);
 }
 
-int cdns_mhdp_hdcp_set_lc(struct cdns_mhdp_device *mhdp, u8 *val)
-{
-	int ret;
-
-	mutex_lock(&mhdp->mbox_mutex);
-	ret = cdns_mhdp_secure_mailbox_send(mhdp, MB_MODULE_ID_HDCP_GENERAL,
-					    HDCP_GENERAL_SET_LC_128,
-					    16, val);
-	mutex_unlock(&mhdp->mbox_mutex);
-
-	return ret;
-}
-
-int
-cdns_mhdp_hdcp_set_public_key_param(struct cdns_mhdp_device *mhdp,
-				    struct cdns_hdcp_tx_public_key_param *val)
-{
-	int ret;
-
-	mutex_lock(&mhdp->mbox_mutex);
-	ret = cdns_mhdp_secure_mailbox_send(mhdp, MB_MODULE_ID_HDCP_TX,
-					    HDCP2X_TX_SET_PUBLIC_KEY_PARAMS,
-					    sizeof(*val), (u8 *)val);
-	mutex_unlock(&mhdp->mbox_mutex);
-
-	return ret;
-}
-
 int cdns_mhdp_hdcp_enable(struct cdns_mhdp_device *mhdp, u8 content_type)
 {
 	int ret;
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.h b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.h
index 334c0b8b0d4f..3b6ec9c3a8d8 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.h
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.h
@@ -82,9 +82,6 @@ struct cdns_hdcp_tx_public_key_param {
 	u8 E[DLP_E];
 };
 
-int cdns_mhdp_hdcp_set_public_key_param(struct cdns_mhdp_device *mhdp,
-					struct cdns_hdcp_tx_public_key_param *val);
-int cdns_mhdp_hdcp_set_lc(struct cdns_mhdp_device *mhdp, u8 *val);
 int cdns_mhdp_hdcp_enable(struct cdns_mhdp_device *mhdp, u8 content_type);
 int cdns_mhdp_hdcp_disable(struct cdns_mhdp_device *mhdp);
 void cdns_mhdp_hdcp_init(struct cdns_mhdp_device *mhdp);
-- 
2.46.2


