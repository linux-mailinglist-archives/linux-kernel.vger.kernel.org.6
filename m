Return-Path: <linux-kernel+bounces-338329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7059F985683
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B500285551
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD423189F2D;
	Wed, 25 Sep 2024 09:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="glgZyHQM"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E03E189904
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727257106; cv=none; b=jy66X1TzaqAp175SdzrNlYmZnrwymiujPwRcnOM3MF8XdIaMfNIu4ylblGEJSmXVK+SBZy1uO+L+8ITMe+EhK/QG5/GYez6z0F/hnsR6rsamjUb6cUIxBP36TyqlaZ7W4TQjM9fCklk18QM009hE7I5ZA2qtbGmF1v5ZWQlSf0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727257106; c=relaxed/simple;
	bh=WhI5h6+Oaya6VO4wDUKB3EPlqBbBw4m7Ij0TCkx1zLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quAnDVOwg4u9UbwuZn4IrMZoZ5dlBvS5QtGJSX6T79SHPIgzaFXng2BXOCuygxo3Ibmwnv9hAnx6SbLq/3rfXtuSEdNUdIoIWxDZ1cQtxKC1PHIMt5oczwxRFecXZ6/MOvKwiQlyD5GdlmqAmKO1dHKY+X7zkp2Gg6cRu5vL0K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=glgZyHQM; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-719b17b2da1so2752055b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 02:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727257103; x=1727861903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C76lYKqOaKFf1LWgw9jI+3gYXvFZ5Li6KGDavd2GlFk=;
        b=glgZyHQM06bdqPe8yc5wkAgYbELyBXO2l3ZJFsiIBX6155LevNXE9g/DUoRIsUmyif
         OipLRlXlwF3ZCNlQbUMp6cpH1ccrmEbjxupKUGS29WbQzRWvrJQIgYnFfseQsCpTGt0m
         imAm++SpUqKxFobHqJqT0w64lWV3zm3SSrilc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727257103; x=1727861903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C76lYKqOaKFf1LWgw9jI+3gYXvFZ5Li6KGDavd2GlFk=;
        b=t/1TbGQj/9CHRGIsI5Fzyi7BhUmOIQXIWH1u7iErTQMVDkUD5AhpuTMmsvvtDIMSl/
         Wkq8faMlnbeKF9cAdQQ4U6lIez9OBW47xhIi2JdrJyThbAKfoUWsxVr/K+f7F53Sar1N
         +khXX1TFMK2dcePXRMy5jp+qfajLmwPtXxvhubkfw6tqBXSZ+IsnX4INnS3JRFzQs1Ht
         8qYM8heuGw6WtC1OIUypfFQijD4U33+fUvia9A1I2fXqk92m45xjc8woQ1NFo5cWEHl7
         +BIe6qj7FxaquY/xYtW83BJ1ZsMuVQI3B1k8rP5nuRAWJMT0Z1EfTHWb1KEVdbN4MJ9c
         m4Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVPqOVJwvl//5ic0T5SMeXb59nwGaQZaEVxarcmRv78aLK/7to3ztjZ9Vn5bbXtnjFH1tWoiDHuNLRa9p0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/rRQkz1prddZ8mTMmMcbBr8LGvl4l5EpSw/ZfHT8MSeumQYXp
	ufqyCxPcxNqrCf0LfU85ZOvgutuX0nPeh6LE3rq5rUrvw9sh9MfJzLQ72CERWg==
X-Google-Smtp-Source: AGHT+IEIT60mHW/rWrUCbyRDTdBe2V8pmg+iP0bif2d5gdv8qwR5RMS+9ty2CUG5H+qVfEQgUwNthA==
X-Received: by 2002:a05:6a00:14c6:b0:718:ddd7:dc3b with SMTP id d2e1a72fcca58-71b0ac5aad9mr3130147b3a.21.1727257103023;
        Wed, 25 Sep 2024 02:38:23 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:2480:2c96:2b64:cdcb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc8347fesm2432789b3a.35.2024.09.25.02.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 02:38:22 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mark Brown <broonie@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Johan Hovold <johan@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v8 3/3] pmdomain: mediatek: Use OF-specific regulator API to get power domain supply
Date: Wed, 25 Sep 2024 17:38:06 +0800
Message-ID: <20240925093807.1026949-4-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
In-Reply-To: <20240925093807.1026949-1-wenst@chromium.org>
References: <20240925093807.1026949-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MediaTek power domain driver contains a hack that assigns the device
node of the power domain to the struct device of the power domain
controller in order to use the devres regulator API.

Now that there is a proper OF-specific regulator API, and even a devres
version, replace the hack with proper code.

This change is incompatible with incomplete device trees. Instead of
assigning the dummy regulator in cases where the power domain requires
a supply but the device tree does not provide one, the driver will just
error out. This will be seen on the MT8390 EVK, which is missing
supplies for the IMG_VCORE and CAM_VCORE domains. And likely all the
MediaTek EVBs, which have no power domain supplies specified. This is
however the correct behavior. If the power domain's supply is missing,
then it should not work. Relying on other parts of the system to keep
the unattached regulator enabled is likely to break in ways less easier
to understand.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v7:
- New patch

The other option is to follow what Rockchip will be doing: getting the
regulator supply upon first use / enable [1]. This will result in less
breakage: only the power domain that is missing its supplies will fail
to be attached.

[1] https://lore.kernel.org/all/20240919091834.83572-6-sebastian.reichel@collabora.com/
---
 drivers/pmdomain/mediatek/mtk-pm-domains.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index 88406e9ac63c..3580913f25d3 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -353,7 +353,6 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 {
 	const struct scpsys_domain_data *domain_data;
 	struct scpsys_domain *pd;
-	struct device_node *root_node = scpsys->dev->of_node;
 	struct device_node *smi_node;
 	struct property *prop;
 	const char *clk_name;
@@ -388,16 +387,7 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 	pd->scpsys = scpsys;
 
 	if (MTK_SCPD_CAPS(pd, MTK_SCPD_DOMAIN_SUPPLY)) {
-		/*
-		 * Find regulator in current power domain node.
-		 * devm_regulator_get() finds regulator in a node and its child
-		 * node, so set of_node to current power domain node then change
-		 * back to original node after regulator is found for current
-		 * power domain node.
-		 */
-		scpsys->dev->of_node = node;
-		pd->supply = devm_regulator_get(scpsys->dev, "domain");
-		scpsys->dev->of_node = root_node;
+		pd->supply = devm_of_regulator_get_optional(scpsys->dev, node, "domain");
 		if (IS_ERR(pd->supply))
 			return dev_err_cast_probe(scpsys->dev, pd->supply,
 				      "%pOF: failed to get power supply.\n",
-- 
2.46.0.792.g87dc391469-goog


