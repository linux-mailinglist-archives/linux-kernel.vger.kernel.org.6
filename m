Return-Path: <linux-kernel+bounces-532601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 928B3A44FC5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81FE517E76F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE9521322B;
	Tue, 25 Feb 2025 22:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YRUBV/DH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F612139A1
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522110; cv=none; b=e74xO0MOwvVSKYF1ppD7KDSq+Nevj/Z05c5Q5YDg4ygerURKqqTd7MVjje/8apuXRHJn1vacldpXCz5R+L1UMO55VFMtnpNOZnYd0V67RbAUiMuQb3rTP9Fs5q9cSMUa05FjMSsqU21xnGNtF2dEDzf4E0JmKxhSIP5o68kRFRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522110; c=relaxed/simple;
	bh=oMnZPC9HfrwqOolnznL0vrEyroxHYMcgs+Plnnla5aQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ESAUBrXXraaJD5+jHwQNSOu7LaCJguL4cjIEDNw+TRWBfPSu+lV5zciU7x4ijFOYF2xu1q5Z0Fg3stNv34K/BOq8O0mooEKnzv5VoOZVYdk2qK8AgXP1dCVwo515MdkiPjNzUPcOBfl0LbkDMwCI0/vySgSQA5oqJOwzGMJ4cu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YRUBV/DH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740522107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LQce4qpcRmddUf2QLSsjxR1D9l6diq/uQYF6rsz7TN8=;
	b=YRUBV/DHAim9e93KuOzpmdlUamQaW0Lj/BYHciKVwXNogF44b/s/IjK2dvg4129seNKXSj
	vSnj6dVnoR7rwDmeRxoM29OFfUpGnANl5LWHvz2VxSnwiQtax/PsNbcMu+hE1L0WzCgTCY
	DjpErFzrTboVV4YKwS7AxTH3wn9VgPk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-Mmr7GP-rMsSDl_6YKU-5ew-1; Tue,
 25 Feb 2025 17:21:41 -0500
X-MC-Unique: Mmr7GP-rMsSDl_6YKU-5ew-1
X-Mimecast-MFC-AGG-ID: Mmr7GP-rMsSDl_6YKU-5ew_1740522095
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5130618EB2C9;
	Tue, 25 Feb 2025 22:21:34 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.79])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 054BF1800368;
	Tue, 25 Feb 2025 22:21:23 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Tue, 25 Feb 2025 17:20:44 -0500
Subject: [PATCH RESEND 03/12] drm/hisilicon: move to
 devm_platform_ioremap_resource() usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-memory-drm-misc-next-v1-3-9d0e8761107a@redhat.com>
References: <20250225-memory-drm-misc-next-v1-0-9d0e8761107a@redhat.com>
In-Reply-To: <20250225-memory-drm-misc-next-v1-0-9d0e8761107a@redhat.com>
To: Joel Stanley <joel@jms.id.au>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
 Xinliang Liu <xinliang.liu@linaro.org>, Tian Tao <tiantao6@hisilicon.com>, 
 Xinwei Kong <kong.kongxinwei@hisilicon.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Marek Vasut <marex@denx.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Philippe Cornu <philippe.cornu@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Alexey Brodkin <abrodkin@synopsys.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-aspeed@lists.ozlabs.org, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, imx@lists.linux.dev, 
 linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org, 
 linux-doc@vger.kernel.org, Anusha Srivatsa <asrivats@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740522045; l=2968;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=oMnZPC9HfrwqOolnznL0vrEyroxHYMcgs+Plnnla5aQ=;
 b=ruvyJhsj+Q6O7BkE9kpuQEM0Z7yBhMViu0Boc2FhfQnAPW9Bxnsy4Z0JMzsfaClpRusd7q+jQ
 ehspHYptTk5BLbAm3jEAoitZVfoKaaumjLnabn+h6illuRMQ/A4kXnH
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Replace platform_get_resource + devm_ioremap_resource
with just devm_platform_ioremap_resource()

Used Coccinelle to do this change. SmPl patch:
@rule_1@
identifier res;
expression ioremap_res;
identifier pdev;
@@
-struct resource *res;
...
-res = platform_get_resource(pdev,...);
-ioremap_res = devm_ioremap_resource(...);
+ioremap_res = devm_platform_ioremap_resource(pdev,0);

Cc: Xinliang Liu <xinliang.liu@linaro.org>
Cc: Tian Tao <tiantao6@hisilicon.com>
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Yongqin Liu <yongqin.liu@linaro.org>
Cc: John Stultz <jstultz@google.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c    | 4 +---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
index 2eea9fb0e76bf3ead8f5914e6ebb65b5b3603b9a..e80debdc41763357cb2cf321205c0dfac80a911e 100644
--- a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
+++ b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
@@ -825,7 +825,6 @@ static const struct component_ops dsi_ops = {
 static int dsi_parse_dt(struct platform_device *pdev, struct dw_dsi *dsi)
 {
 	struct dsi_hw_ctx *ctx = dsi->ctx;
-	struct resource *res;
 
 	ctx->pclk = devm_clk_get(&pdev->dev, "pclk");
 	if (IS_ERR(ctx->pclk)) {
@@ -833,8 +832,7 @@ static int dsi_parse_dt(struct platform_device *pdev, struct dw_dsi *dsi)
 		return PTR_ERR(ctx->pclk);
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ctx->base = devm_ioremap_resource(&pdev->dev, res);
+	ctx->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ctx->base)) {
 		DRM_ERROR("failed to remap dsi io region\n");
 		return PTR_ERR(ctx->base);
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 2eb49177ac42bc6dba692328cca5c99d5925041c..45c4eb008ad5d639340f769ad022d186ec454722 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -844,7 +844,6 @@ static struct drm_plane_funcs ade_plane_funcs = {
 static void *ade_hw_ctx_alloc(struct platform_device *pdev,
 			      struct drm_crtc *crtc)
 {
-	struct resource *res;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = pdev->dev.of_node;
 	struct ade_hw_ctx *ctx = NULL;
@@ -856,8 +855,7 @@ static void *ade_hw_ctx_alloc(struct platform_device *pdev,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ctx->base = devm_ioremap_resource(dev, res);
+	ctx->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ctx->base)) {
 		DRM_ERROR("failed to remap ade io base\n");
 		return ERR_PTR(-EIO);

-- 
2.48.1


