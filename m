Return-Path: <linux-kernel+bounces-528386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E103A41725
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC7718955D0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730DA19C54A;
	Mon, 24 Feb 2025 08:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="T3UEkpdA"
Received: from mail-m3293.qiye.163.com (mail-m3293.qiye.163.com [220.197.32.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D8B19259E;
	Mon, 24 Feb 2025 08:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740385174; cv=none; b=mRUGDu3gWDGDsgUn6c2kckA1TdRxEWWrgZl/PZBLB6n5qPcS2uhPbnUB1jlWrh4TE+P8Et56SrMcNXs4IDpNqQY0IvonqhNV55MTkdAF3rxJNGEZgpbTPxH9yXOGF6PWWZr7d/cjyI1B+nXpTrgOJ3fylylhBiYZnuPyAxKzQhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740385174; c=relaxed/simple;
	bh=j2EcA4m7K6OKbcw7uZX9rdjrvsLTZrZPasQT6/3B9Q8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MxvrUV8b1DkNSDo7ZnUHF/BgDZ2kgdYD2S1SNNvvrDxGJFr4wBLwX9qR/0LbG7i6rI1i95eMkFEVWoDLwBBgdN9vP8ug9S5LM/p5GEeAJHDi2w2gT9/aWEH00BZhmsqrBu1qTZexs0mMbQ31AASn+r/KySnOoGfu239GFrSEv50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=T3UEkpdA; arc=none smtp.client-ip=220.197.32.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id bfd2880b;
	Mon, 24 Feb 2025 16:14:14 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: heiko@sntech.de
Cc: andy.yan@rock-chips.com,
	hjc@rock-chips.com,
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
Subject: [PATCH v7 09/15] drm/bridge: analogix_dp: Add support to get panel from the DP AUX bus
Date: Mon, 24 Feb 2025 16:13:19 +0800
Message-Id: <20250224081325.96724-10-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224081325.96724-1-damon.ding@rock-chips.com>
References: <20250224081325.96724-1-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhlJHlYaTU4aQk4aGB9CGBlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a953705609803a3kunmbfd2880b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ngg6Sgw4MzIRKxM#TTMuER9P
	LQlPCRJVSlVKTE9LSENPQ05NSE5JVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISEpCNwY+
DKIM-Signature:a=rsa-sha256;
	b=T3UEkpdAbGm7kh+n3qx6jCa3hmnwmVtTNzQUWFa5QCUiKZqTtQ+jGlbD8c0cSwCzwnMyO2lKL9XOzqcyKcBJsTbdLuY16/EBfBMUrTDGQ2dFlYdDpf/Yiv7l7ARZBNGO3twnp4mfFbcunqxkoMJ72D26sBjMRkiZZE8SJsYJqVg=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=yKmmC0FAmuHo2ApK+YOW/Mu6kt3fsY4kEk5spr9VvRU=;
	h=date:mime-version:subject:message-id:from;

The main modification is moving the DP AUX initialization from function
analogix_dp_bind() to analogix_dp_probe(). In order to get the EDID of
eDP panel during probing, it is also needed to advance PM operations to
ensure that eDP controller and phy are prepared for AUX transmission.

Additionally, add support for &drm_dp_aux.wait_hpd_asserted() to help
confirm the HPD state before doing AUX transfers.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

---

Changes in v4:
- Use done_probing() to call drm_of_find_panel_or_bridge() and
  component_add() when getting panel from the DP AUX bus

Changes in v5:
- Advance PM operations to make eDP AUX work well

Changes in v6:
- Use devm_pm_runtime_enable() instead of devm_add_action_or_reset()
- Add a new function analogix_dp_remove() to ensure symmetry for PM
  operations

Changes in v7:
- Fix the misspelling of word 'operations' in commit message
- Remove the check related to CONFIG_PM
- Remove the unnecessary call to pm_runtime_dont_use_autosuspend() if
  devm_pm_runtime_enable() fails
- Remove unnecessary function analogix_dp_remove()
- Add new function analogix_dpaux_wait_hpd_asserted()
---
 .../drm/bridge/analogix/analogix_dp_core.c    | 37 ++++++++++++++-----
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index a57e06d303a1..ff81c37dbe1d 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1548,6 +1548,22 @@ static ssize_t analogix_dpaux_transfer(struct drm_dp_aux *aux,
 	return ret;
 }
 
+static int analogix_dpaux_wait_hpd_asserted(struct drm_dp_aux *aux, unsigned long wait_us)
+{
+	struct analogix_dp_device *dp = to_dp(aux);
+	int val;
+	int ret;
+
+	pm_runtime_get_sync(dp->dev);
+
+	ret = readx_poll_timeout(analogix_dp_detect_hpd, dp, val, !val, wait_us / 100, wait_us);
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
@@ -1653,6 +1669,18 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
 		return ERR_PTR(ret);
 	}
 
+	dp->aux.name = "DP-AUX";
+	dp->aux.transfer = analogix_dpaux_transfer;
+	dp->aux.wait_hpd_asserted = analogix_dpaux_wait_hpd_asserted;
+	dp->aux.dev = dp->dev;
+	drm_dp_aux_init(&dp->aux);
+
+	pm_runtime_use_autosuspend(dp->dev);
+	pm_runtime_set_autosuspend_delay(dp->dev, 100);
+	ret = devm_pm_runtime_enable(dp->dev);
+	if (ret)
+		return ERR_PTR(ret);
+
 	return dp;
 }
 EXPORT_SYMBOL_GPL(analogix_dp_probe);
@@ -1699,15 +1727,6 @@ int analogix_dp_bind(struct analogix_dp_device *dp, struct drm_device *drm_dev)
 	dp->drm_dev = drm_dev;
 	dp->encoder = dp->plat_data->encoder;
 
-	pm_runtime_use_autosuspend(dp->dev);
-	pm_runtime_set_autosuspend_delay(dp->dev, 100);
-	ret = devm_pm_runtime_enable(dp->dev);
-	if (ret)
-		return ret;
-
-	dp->aux.name = "DP-AUX";
-	dp->aux.transfer = analogix_dpaux_transfer;
-	dp->aux.dev = dp->dev;
 	dp->aux.drm_dev = drm_dev;
 
 	ret = drm_dp_aux_register(&dp->aux);
-- 
2.34.1


