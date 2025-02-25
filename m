Return-Path: <linux-kernel+bounces-532612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585E5A44FF5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2604A7AC51F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135EC2153CF;
	Tue, 25 Feb 2025 22:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HT53tQ8P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5806214236
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522184; cv=none; b=bQio0sq7M3FHIkWcnZanUJP9wtO1bjs1NJDJyCsDekjlW1sYJMxxkEpnyZDCK14GICgkbDzcsri8ftq6QDd6NWfL77ciGOQctOItZFMXLd0BzKMlzEKXWMoMqc/8wPCBjuPjq9S6r7uS7CK46ZY6KHYAe75xNHn3uYCWP3ImypI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522184; c=relaxed/simple;
	bh=VFSuHepnxZoSShTFjm4YohjW2HXTZolH4g28Xw0ynNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SSyhjATc4w0oCYJknQdjDUF9jp9DtoE0lkj1ZkGtZ3+EY543nCZfZuJCuI2CZf1vq2oSFwggRtqMRpIcwGiGHjtp36Jm/YsDRhXDtgSLjsIkuibWPSS6GEVQ8CW6D8odpemyalI7Q3hEg6mj+Z20dA8Icl3rNrJIIGhzDHUzb7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HT53tQ8P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740522182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CH6R1sRzoxk/zUj3ZtopK4VmGCk3VSDBS0lfMMrku4I=;
	b=HT53tQ8P5wAi5PDUhM50ERNZH9NA718Bke0z5QlMq/kb1xOdBK0jQwB6Fy4GFWOJyW/35D
	R+sAJBIsH2prz6BwhoyRkqwWV14cyfV46OczKlNOUhDxXuI8/bvub6YFIIk/wAsgJalYDW
	rryooHLAHJ4YhGBpikYbDwzuXXOZe3M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-xpwQHhb6P_6e_yD960qTxg-1; Tue,
 25 Feb 2025 17:22:57 -0500
X-MC-Unique: xpwQHhb6P_6e_yD960qTxg-1
X-Mimecast-MFC-AGG-ID: xpwQHhb6P_6e_yD960qTxg_1740522171
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0277818D95E0;
	Tue, 25 Feb 2025 22:22:51 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.79])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2CB631800357;
	Tue, 25 Feb 2025 22:22:42 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Tue, 25 Feb 2025 17:20:52 -0500
Subject: [PATCH RESEND 11/12] drm/vc4: move to
 devm_platform_ioremap_resource() usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250225-memory-drm-misc-next-v1-11-9d0e8761107a@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740522045; l=4241;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=VFSuHepnxZoSShTFjm4YohjW2HXTZolH4g28Xw0ynNs=;
 b=xiZV8EMfZ5miDBHBnqwjMdewqD2zKa22IfVa9PC4bQSOdgJnL3WWzgYHVtbMto4V4f+506Ys9
 UoHhl7v4372DFpdff/bjSqVoZg+52n2/DXSVo9lkSmWoFeNXzSGd4/5
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Replace platform_get_resource_byname + devm_ioremap_resource
with just devm_platform_ioremap_resource()

Used Coccinelle to do this change. SmPl patch:
//rule s/(devm_)platform_get_resource_byname +
//(devm_)ioremap/devm_platform_ioremap_resource.
@rule_3@
identifier res;
expression ioremap;
identifier pdev;
constant mem;
expression name;
@@
-struct resource *res;
<+...
-res = platform_get_resource_byname(pdev,mem,name);
<...
-if (!res) {
-...
-}
...>
-ioremap = devm_ioremap(...);
+ioremap = devm_platform_ioremap_resource_byname(pdev,name);
...+>

v2: Change the SmPl patch to work on multiple occurences of
the pattern. This also fixes the compilation error.

v3: Do not convert "hd" resource to follow the rest of the
refactor. (Maxime)

v4: fix compiler error

Cc: Maxime Ripard <mripard@kernel.org>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Maíra Canal <mcanal@igalia.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 53 ++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index e878eddc9c3f669f29b098d892baa463446617ef..d20e5c53ba75d43a6f478cf7ab837a0878f68ab2 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -2926,15 +2926,16 @@ static int vc5_hdmi_init_resources(struct drm_device *drm,
 	struct resource *res;
 	int ret;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hdmi");
-	if (!res)
-		return -ENODEV;
-
-	vc4_hdmi->hdmicore_regs = devm_ioremap(dev, res->start,
-					       resource_size(res));
+	vc4_hdmi->hdmicore_regs = devm_platform_ioremap_resource_byname(pdev,
+									"hdmi");
 	if (!vc4_hdmi->hdmicore_regs)
 		return -ENOMEM;
 
+	/* This is shared between both HDMI controllers. Cannot
+	 * claim for both instances. Lets not convert to using
+	 * devm_platform_ioremap_resource_byname() like
+	 * the rest
+	 */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hd");
 	if (!res)
 		return -ENODEV;
@@ -2943,51 +2944,33 @@ static int vc5_hdmi_init_resources(struct drm_device *drm,
 	if (!vc4_hdmi->hd_regs)
 		return -ENOMEM;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cec");
-	if (!res)
-		return -ENODEV;
-
-	vc4_hdmi->cec_regs = devm_ioremap(dev, res->start, resource_size(res));
+	vc4_hdmi->cec_regs = devm_platform_ioremap_resource_byname(pdev,
+								   "cec");
 	if (!vc4_hdmi->cec_regs)
 		return -ENOMEM;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "csc");
-	if (!res)
-		return -ENODEV;
-
-	vc4_hdmi->csc_regs = devm_ioremap(dev, res->start, resource_size(res));
+	vc4_hdmi->csc_regs = devm_platform_ioremap_resource_byname(pdev,
+								   "csc");
 	if (!vc4_hdmi->csc_regs)
 		return -ENOMEM;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dvp");
-	if (!res)
-		return -ENODEV;
-
-	vc4_hdmi->dvp_regs = devm_ioremap(dev, res->start, resource_size(res));
+	vc4_hdmi->dvp_regs = devm_platform_ioremap_resource_byname(pdev,
+								   "dvp");
 	if (!vc4_hdmi->dvp_regs)
 		return -ENOMEM;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
-	if (!res)
-		return -ENODEV;
+	vc4_hdmi->phy_regs = devm_platform_ioremap_resource_byname(pdev,
+								   "phy");
 
-	vc4_hdmi->phy_regs = devm_ioremap(dev, res->start, resource_size(res));
 	if (!vc4_hdmi->phy_regs)
 		return -ENOMEM;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "packet");
-	if (!res)
-		return -ENODEV;
-
-	vc4_hdmi->ram_regs = devm_ioremap(dev, res->start, resource_size(res));
+	vc4_hdmi->ram_regs = devm_platform_ioremap_resource_byname(pdev,
+								   "packet");
 	if (!vc4_hdmi->ram_regs)
 		return -ENOMEM;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rm");
-	if (!res)
-		return -ENODEV;
-
-	vc4_hdmi->rm_regs = devm_ioremap(dev, res->start, resource_size(res));
+	vc4_hdmi->rm_regs = devm_platform_ioremap_resource_byname(pdev, "rm");
 	if (!vc4_hdmi->rm_regs)
 		return -ENOMEM;
 

-- 
2.48.1


