Return-Path: <linux-kernel+bounces-554120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E48A59339
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9185A3A6C19
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832FB226D1A;
	Mon, 10 Mar 2025 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Mt07XzW9"
Received: from mail-m49209.qiye.163.com (mail-m49209.qiye.163.com [45.254.49.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5C2225403
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741607869; cv=none; b=FKTQF+6rjWklzAtP1J9NuVAOHvClz4QSo+CkVVHA7gwZsAto49qQF4163iFkBuZLD4ABD4GXV/YI+Kcvc1cTGLCJfut1KAv1YYXPAnZk/MlrXcb8YhuEmP0PN6YgknNVtHDKtuXvuT2P2OshRvwS9MOyzf718N2xORyOqXiWf0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741607869; c=relaxed/simple;
	bh=TYe3xrGfI+KEZAuyZkB1/CZgZPIVN3GYQKn1jtaT7jc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KQtjAKL9vXSccTufM94TT0bmzOQmnIhqga2RgJGVVuEzcAYbxksnHEVwUuOMDGbvFB2pJdeDZqGHOiMLIaOoAGqOw3gR31m1Y87kPRi8JnKFy6iFCNZhAUrlPaj3ty1A3Q1+whSLerMAn3ARKDwlB+pkj2fxix/wdAqQyuJGeS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Mt07XzW9; arc=none smtp.client-ip=45.254.49.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id dc188280;
	Mon, 10 Mar 2025 18:42:15 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: heiko@sntech.de
Cc: andy.yan@rock-chips.com,
	hjc@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	dmitry.baryshkov@linaro.org,
	dianders@chromium.org,
	sebastian.reichel@collabora.com,
	cristian.ciocaltea@collabora.com,
	boris.brezillon@collabora.com,
	l.stach@pengutronix.de,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v8 07/13] drm/bridge: analogix_dp: Add support for &drm_dp_aux.wait_hpd_asserted()
Date: Mon, 10 Mar 2025 18:41:08 +0800
Message-Id: <20250310104114.2608063-8-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310104114.2608063-1-damon.ding@rock-chips.com>
References: <20250310104114.2608063-1-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0IeSVZCQ0IeSU1DS04YH0tWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
X-HM-Tid: 0a957fa5eccb03a3kunmdc188280
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NSo6ASo*VjJJTSMXIzlIPSM3
	EkwwCzVVSlVKTE9KTUtISEhMT0NCVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKTk9CNwY+
DKIM-Signature:a=rsa-sha256;
	b=Mt07XzW9yyoQKwh7HWb8UUDlKK48215FQ8+zwOAvEjW/6i2X8B7LTNSNDWp2a4oUrRRdd7nRYUE47XZlU2LToe9susyb7WRcMe6vZyMQ1NONQwAwRRVfB6d5TZiNMmmtHsTOAEIl/qP5dTJyuvU2w4WFwA2FV2eWQzqK6ofRiA0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=C5wB+9893I7lZTyFWnjEKSPI75uW0Q31vE5+3MAp5eA=;
	h=date:mime-version:subject:message-id:from;

Add analogix_dpaux_wait_hpd_asserted() to help confirm the HPD state
before doing AUX transfers.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
---
 .../drm/bridge/analogix/analogix_dp_core.c    | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 2b76a9cf3bcb..b7e143b3ff75 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1548,6 +1548,26 @@ static ssize_t analogix_dpaux_transfer(struct drm_dp_aux *aux,
 	return ret;
 }
 
+static int analogix_dpaux_wait_hpd_asserted(struct drm_dp_aux *aux, unsigned long wait_us)
+{
+	struct analogix_dp_device *dp = to_dp(aux);
+	int val;
+	int ret;
+
+	if (dp->force_hpd)
+		return 0;
+
+	pm_runtime_get_sync(dp->dev);
+
+	ret = readx_poll_timeout(analogix_dp_get_plug_in_status, dp, val, !val,
+				 wait_us / 100, wait_us);
+
+	pm_runtime_mark_last_busy(dp->dev);
+	pm_runtime_put_autosuspend(dp->dev);
+
+	return ret;
+}
+
 struct analogix_dp_device *
 analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
 {
@@ -1652,6 +1672,7 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
 
 	dp->aux.name = "DP-AUX";
 	dp->aux.transfer = analogix_dpaux_transfer;
+	dp->aux.wait_hpd_asserted = analogix_dpaux_wait_hpd_asserted;
 	dp->aux.dev = dp->dev;
 	drm_dp_aux_init(&dp->aux);
 
-- 
2.34.1


