Return-Path: <linux-kernel+bounces-545602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B087A4EF22
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BC4A170AAA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842222780EC;
	Tue,  4 Mar 2025 21:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSeSGW03"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700822777FB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 21:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122404; cv=none; b=H6UgQx10INVugyEUnz6EHV97/wHaXeZcKkSnJ77vCKhdJMyIMYb7VCv61tHVyZk0p1Zw1KAnjC73kNAuGVUYoeSbiUuTMMuOUorRnklIOUVS5dkDgZIX6o7TTR+xBxSzr4DsJXRyShLTYxVxj7+EgwzieLc9QifkiUKbEAofoI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122404; c=relaxed/simple;
	bh=/1uyauwGTyarRS5zbo7VigxpNs57qz5tT34D8A+G7fo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LLc6BnYDWiC6EkJJoc8vR4oPzskTxtQg5hVxdM4rYqL9CIe3hck20wY4ukvIGpY3sXQmyEGqWr1DQ2GDg2HjqkHED+wWyEbow4lGZi2UTy+RTydRbmARqxWSatfspvJyUX0AUkd5mb3+2cjM23c/IooIUP6WjGpAYmYpSR1zDV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dSeSGW03; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741122402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MO1oDsAGx4BA8WWOCDr9myR5I52bhpUx7oLdchtJUhA=;
	b=dSeSGW03BPjW5/vtYMU0oIk94KYuBPgx6zcPJL8/2rDTGLH5/PFpiwyDPNEu2/MiSZak9p
	Xp++U3mR6SRgGNW+ZU0h1Rwq3wdod/VLZk55rFysf7/2lI6WrhILR2bKcDvdfar2DVkN87
	ydmDFSOlyf4qknwYOHD1hs/6ptNEU10=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-bXja5sp3M1KshUiRQ4-eaw-1; Tue,
 04 Mar 2025 16:06:38 -0500
X-MC-Unique: bXja5sp3M1KshUiRQ4-eaw-1
X-Mimecast-MFC-AGG-ID: bXja5sp3M1KshUiRQ4-eaw_1741122394
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF5F5180098B;
	Tue,  4 Mar 2025 21:06:33 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.107])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4D8B81800361;
	Tue,  4 Mar 2025 21:06:27 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Tue, 04 Mar 2025 16:05:36 -0500
Subject: [PATCH v5 6/7] drm/tegra: move to devm_platform_ioremap_resource()
 usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-mem-fixes-v1-6-fb3dab8d901f@redhat.com>
References: <20250304-mem-fixes-v1-0-fb3dab8d901f@redhat.com>
In-Reply-To: <20250304-mem-fixes-v1-0-fb3dab8d901f@redhat.com>
To: Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Xinliang Liu <xinliang.liu@linaro.org>, Tian Tao <tiantao6@hisilicon.com>, 
 Xinwei Kong <kong.kongxinwei@hisilicon.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>, 
 Marek Vasut <marex@denx.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-tegra@vger.kernel.org, linux-doc@vger.kernel.org, 
 Anusha Srivatsa <asrivats@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741122340; l=1560;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=/1uyauwGTyarRS5zbo7VigxpNs57qz5tT34D8A+G7fo=;
 b=iOHYkEofhz7g9PAkjQS/oPydE4OY11I24guknaXWtgIJGT0Hu6eIxQuqc/nqFl3SLCuPDTj4P
 uGEGQF4mNSBAi6wNhTvjhD1i8NY46NNANbT1yyugwJIcBrmfMVmAeKV
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

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/tegra/dsi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index 9bb077558167293c8e47ca9578cef13172b0b22f..b5089b7722676cfaee5d28216af4ae706a47f895 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1564,7 +1564,6 @@ static int tegra_dsi_ganged_probe(struct tegra_dsi *dsi)
 static int tegra_dsi_probe(struct platform_device *pdev)
 {
 	struct tegra_dsi *dsi;
-	struct resource *regs;
 	int err;
 
 	dsi = devm_kzalloc(&pdev->dev, sizeof(*dsi), GFP_KERNEL);
@@ -1636,8 +1635,7 @@ static int tegra_dsi_probe(struct platform_device *pdev)
 		goto remove;
 	}
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dsi->regs = devm_ioremap_resource(&pdev->dev, regs);
+	dsi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dsi->regs)) {
 		err = PTR_ERR(dsi->regs);
 		goto remove;

-- 
2.48.1


