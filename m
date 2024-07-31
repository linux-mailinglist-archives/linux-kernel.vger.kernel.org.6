Return-Path: <linux-kernel+bounces-269718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D56A943622
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAEAA1F23472
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02E6446A1;
	Wed, 31 Jul 2024 19:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOor4D1V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A223168499;
	Wed, 31 Jul 2024 19:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722453226; cv=none; b=axJMIUBNfOSy96VTPNJRx1JNKqUgdqwMxEzUt2MN+thnMuOOV5ZE8uHYNvGeMX0CXTxIkhnoXkHIDZwmlRTlhfLUmla1NmvziC3z2rbyzUiq/BfO49eorOvZAVhvixCOvhiakaidGxCxHUe1x0FqwFX4pqjihx49and+mN68s5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722453226; c=relaxed/simple;
	bh=T3/ZGvRIcdVcWhXLfnt/8UVdJ+xNtaUxWIZV3H2kVCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ty45vITlLAjaQ6iztfZu+tufLcfHJEx8YhkUmTrRU8pXZM4cEkAWGBYV+TvNSpAkn++Q5RROBOitPikgfrCVve7fOKtC2KwAhQYx71sG9Dn2KHl6/XYt9Wh5ayyjb0TcZ0K6KkZROOfG+Gb723MPAStRUePAWIg7/RjdDPT2RkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOor4D1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFD1C4AF09;
	Wed, 31 Jul 2024 19:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722453225;
	bh=T3/ZGvRIcdVcWhXLfnt/8UVdJ+xNtaUxWIZV3H2kVCU=;
	h=From:To:Cc:Subject:Date:From;
	b=LOor4D1VhBJFEasQ3A3MIR41sQ3gAixx0q7gkAZoxz6dhbSh+FNnKmWWGPcc946ls
	 WHzzefQBiHjcAUg51BiB7Bmuc3R1Q31+qo7Z/CZGhbIGHgWh05sS/kQSJS1hc1EvnO
	 EevmIBr3f/WsP+VsD3TmCqaNmZMVGN4DQqnmQU8XXayeXDP4PUrjtT6swKnT3zU0aj
	 Jx8ru+JZvB3LX09nTTVkDmrtPti9Eid4TVxqg1iqxwwEYPntWG+vytKjARuYaLR5jQ
	 NrEh6L7Uh98TIZKtkoWIXQcYXq8ImHzEXVkvsNDmPr+HO1u83boiFYN+PDwSOSykKS
	 K1Rb8panMCDWA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-remoteproc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] remoteproc: Use of_property_present()
Date: Wed, 31 Jul 2024 13:12:45 -0600
Message-ID: <20240731191312.1710417-7-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of_property_present() to test for property presence rather than
of_(find|get)_property(). This is part of a larger effort to remove
callers of of_find_property() and similar functions. of_find_property()
leaks the DT struct property and data pointers which is a problem for
dynamically allocated nodes which may be freed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/remoteproc/imx_dsp_rproc.c      | 2 +-
 drivers/remoteproc/imx_rproc.c          | 2 +-
 drivers/remoteproc/xlnx_r5_remoteproc.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index 087506e21508..376187ad5754 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -509,7 +509,7 @@ static int imx_dsp_rproc_mbox_alloc(struct imx_dsp_rproc *priv)
 	struct mbox_client *cl;
 	int ret;
 
-	if (!of_get_property(dev->of_node, "mbox-names", NULL))
+	if (!of_property_present(dev->of_node, "mbox-names"))
 		return 0;
 
 	cl = &priv->cl;
diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 144c8e9a642e..8d7ecc809c67 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -807,7 +807,7 @@ static int imx_rproc_xtr_mbox_init(struct rproc *rproc)
 	if (priv->tx_ch && priv->rx_ch)
 		return 0;
 
-	if (!of_get_property(dev->of_node, "mbox-names", NULL))
+	if (!of_property_present(dev->of_node, "mbox-names"))
 		return 0;
 
 	cl = &priv->cl;
diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index 596f3ffb8935..2cea97c746fd 100644
--- a/drivers/remoteproc/xlnx_r5_remoteproc.c
+++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
@@ -1059,7 +1059,7 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
 	r5_core = cluster->r5_cores[0];
 
 	/* Maintain backward compatibility for zynqmp by using hardcode TCM address. */
-	if (of_find_property(r5_core->np, "reg", NULL))
+	if (of_property_present(r5_core->np, "reg"))
 		ret = zynqmp_r5_get_tcm_node_from_dt(cluster);
 	else if (device_is_compatible(dev, "xlnx,zynqmp-r5fss"))
 		ret = zynqmp_r5_get_tcm_node(cluster);
@@ -1086,7 +1086,7 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
 			return ret;
 		}
 
-		if (of_find_property(dev_of_node(dev), "xlnx,tcm-mode", NULL) ||
+		if (of_property_present(dev_of_node(dev), "xlnx,tcm-mode") ||
 		    device_is_compatible(dev, "xlnx,zynqmp-r5fss")) {
 			ret = zynqmp_pm_set_tcm_config(r5_core->pm_domain_id,
 						       tcm_mode);
@@ -1147,7 +1147,7 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
 		return -EINVAL;
 	}
 
-	if (of_find_property(dev_node, "xlnx,tcm-mode", NULL)) {
+	if (of_property_present(dev_node, "xlnx,tcm-mode")) {
 		ret = of_property_read_u32(dev_node, "xlnx,tcm-mode", (u32 *)&tcm_mode);
 		if (ret)
 			return ret;
-- 
2.43.0


