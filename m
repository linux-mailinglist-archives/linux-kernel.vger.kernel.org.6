Return-Path: <linux-kernel+bounces-557208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E73F9A5D510
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 05:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BD76177279
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 04:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989FD1A00E7;
	Wed, 12 Mar 2025 04:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MVU8lvmu"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA844431
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 04:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741753203; cv=none; b=fU2NdwpH+Hz+9gxuKQBmFQ1EgBYLN5++6QR8tl4nUiZ/uHdjvvkHTUnRDXOMxq9nhicDM2LVk8t/UVomIO2MTYRTv46ftPrcUxQGieY9M0BLOGI4HrJxEP9zjiGFYXkAFjEGiqJdMa9SIUHwsjguZ1oLcdxlVZi2YZ3vsRMpitE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741753203; c=relaxed/simple;
	bh=Op82FnMA6ZPl41SuqG45nSPyrCAYqZpLWkb4fvJiVFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i4LIhuq0lzekvNt0kL5fG+RahK5MQILrMoeNCcqLQHmcDfC/csUAyJ/kP+EjjIuqH0sbyYzMdqASfgs04rHl7NbpDy8bl8pZPaBpZm2PhI+ZnRPBiPv5r6BvtxCeD2P9/02Pj9ZMlmyCbApeB9g31KeAzsPyFIpvFBQFnpS4NvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MVU8lvmu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741753199;
	bh=Op82FnMA6ZPl41SuqG45nSPyrCAYqZpLWkb4fvJiVFY=;
	h=From:To:Cc:Subject:Date:From;
	b=MVU8lvmuywj2g9NPj5JTqM7VeNcV/IjOzcy3gM6He9cqODaXdC4BGprosVhZV50UO
	 JEOMFzVUR5IxM/LOqMKt1ymBPzV3ew/f6cDr+lsqI4EerKruGY7mBSIah5xHcb1A30
	 Hzv6xcGW0zOxT8KGznUx8qASyCwA14KfoK1gZ941IYqmaQs2f0Xw5cAoVprXYw3gU0
	 inIjvAGOSByxaEm7b5i4+aNBJsMa6lNlOsGXaP+p1iBylh7Ia4KnHb4PBPso+YYdlo
	 htSmeAZqTLcC6zbIuKQjW9+kylkFG8SepQ+Fro3GDASUlNebF3nq+yq38Gi0bFtypI
	 jJ3qtdwGZXOaw==
Received: from localhost.localdomain (unknown [171.76.87.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CE33717E0CA6;
	Wed, 12 Mar 2025 05:19:56 +0100 (CET)
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
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: defconfig: mediatek: enable PHY drivers
Date: Wed, 12 Mar 2025 09:49:26 +0530
Message-ID: <20250312041943.25676-1-vignesh.raman@collabora.com>
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

Enable the following PHY drivers for MediaTek platforms:
- CONFIG_PHY_MTK_HDMI=m for HDMI display
- CONFIG_PHY_MTK_MIPI_DSI=m for DSI display
- CONFIG_PHY_MTK_XSPHY=m for USB

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - Include board details in the commit message.  
  - Sort newly added PHY configs in defconfig.

---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 1f25423de383..87e8cbd3fd26 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1572,7 +1572,10 @@ CONFIG_PHY_HI6220_USB=y
 CONFIG_PHY_HISTB_COMBPHY=y
 CONFIG_PHY_HISI_INNO_USB2=y
 CONFIG_PHY_MVEBU_CP110_COMPHY=y
+CONFIG_PHY_MTK_HDMI=m
+CONFIG_PHY_MTK_MIPI_DSI=m
 CONFIG_PHY_MTK_TPHY=y
+CONFIG_PHY_MTK_XSPHY=m
 CONFIG_PHY_QCOM_EDP=m
 CONFIG_PHY_QCOM_PCIE2=m
 CONFIG_PHY_QCOM_QMP=m
-- 
2.47.2


