Return-Path: <linux-kernel+bounces-558743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E3EA5EA6B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 05:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A1AC1894895
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 04:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C24139D0A;
	Thu, 13 Mar 2025 04:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SX4lGM0M"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95972E339B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 04:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741838950; cv=none; b=c7dvdcCs6aQSpW2vttnaFT7bHMwS5INm4MCptcYCqJpUBaM16oT2vQ7Z/4/8fbbXMrgFpVk1EtruZVAQPrdrLifYqnJu97sGmhOtcjJDTdT2VJO+x3tDBhdjMgTfOcweGcLuDHiel3lievYgnGSj7TaPdyag2LbuxRwYjxG115o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741838950; c=relaxed/simple;
	bh=j7zpBJEhB8SicI9BKDz1KSrdQOhg5JL4HopKFTPur5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ddf4UEub54CYslwfjUIi7lVDL0R3fjRMHB7diSj1fXhuM/CBeCf4C1Rt/YbpUBAuIC0NtZSNIJzqK00pWZYaDyhGGjsFO7TGCufomoWDUjhSU394z5keg8ckdrjDSYLBoOoFjd3lNdFueHByns7P2gYwDLICMODJ9l4rsYACaWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SX4lGM0M; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741838946;
	bh=j7zpBJEhB8SicI9BKDz1KSrdQOhg5JL4HopKFTPur5k=;
	h=From:To:Cc:Subject:Date:From;
	b=SX4lGM0MJqbfxx/mmhRW/n7CDZtvZE7XoQBSAsi7njweboGy54o2bj3TW1FZSnXb1
	 VqOdVU5io0S7jhRC6EjGGIZR7FWHaohcv6kOeFGKwoeW97j64l1lt+Mcmm4XRnsZre
	 H86YgGn8p64XJlpt30ggZ4qMRlyKnuxg0TuM9cqIaQ17iSHHqYffjgK9WTz70LupPd
	 oeu0zu9ysPLG1JM+ISSmuPoa8hpXWENiyrIvZ5MnBRzR48J7MjJv0ZpMAc6tYaREqc
	 MSBJ2rMh+XcQwHHOC76pnLhX1GpwN2WmIrxH6/FTqvgRknBKV88aOctfb/3sjOyTjZ
	 vpADPxWWOmW5g==
Received: from debian.. (unknown [171.76.87.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0CE6417E023F;
	Thu, 13 Mar 2025 05:09:01 +0100 (CET)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: chunkuang.hu@kernel.org,
	p.zabel@pengutronix.de,
	nfraprado@collabora.com,
	angelogioacchino.delregno@collabora.com,
	krzk@kernel.org,
	daniels@collabora.com,
	airlied@gmail.com,
	simona.vetter@ffwll.ch,
	arnd@kernel.org,
	ck.hu@mediatek.com,
	laura.nao@collabora.com,
	matthias.bgg@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	lumag@kernel.org,
	ville.syrjala@linux.intel.com,
	jani.nikula@intel.com,
	arnd@arndb.de,
	geert+renesas@glider.be,
	wenst@chromium.org,
	linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] arm64: defconfig: mediatek: enable PHY drivers
Date: Thu, 13 Mar 2025 09:38:24 +0530
Message-ID: <20250313040855.62259-1-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mediatek display driver fails to probe on mt8173-elm-hana and
mt8183-kukui-jacuzzi-juniper-sku16 in v6.14-rc4 due to missing PHY
configurations.

Commit [1] stopped selecting the MediaTek PHY drivers, requiring them
to be explicitly enabled in defconfig.

Enable the following PHY drivers for MediaTek platforms:
- CONFIG_PHY_MTK_HDMI=m for HDMI display
- CONFIG_PHY_MTK_MIPI_DSI=m for DSI display
- CONFIG_PHY_MTK_DP=m for DP display

[1] commit 924d66011f24 ("drm/mediatek: stop selecting foreign drivers")

Fixes: 924d66011f24 ("drm/mediatek: stop selecting foreign drivers")
Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - Include board details in the commit message.  
  - Sort newly added PHY configs in defconfig.

v3:
  - Use defconfig/savedefconfig to get the correct configs ordering.
  - Removed PHY_MTK_XSPHY since it is not required for probing display driver.
  - Add the commit details which deselected the MediaTek PHY drivers and
    added a Fixes tag.
  - Enabled CONFIG_PHY_MTK_DP, which was previously deselected.

---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 1f25423de383..fa8ee7070b37 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1573,6 +1573,9 @@ CONFIG_PHY_HISTB_COMBPHY=y
 CONFIG_PHY_HISI_INNO_USB2=y
 CONFIG_PHY_MVEBU_CP110_COMPHY=y
 CONFIG_PHY_MTK_TPHY=y
+CONFIG_PHY_MTK_HDMI=m
+CONFIG_PHY_MTK_MIPI_DSI=m
+CONFIG_PHY_MTK_DP=m
 CONFIG_PHY_QCOM_EDP=m
 CONFIG_PHY_QCOM_PCIE2=m
 CONFIG_PHY_QCOM_QMP=m
-- 
2.47.2


