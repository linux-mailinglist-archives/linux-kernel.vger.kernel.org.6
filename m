Return-Path: <linux-kernel+bounces-423361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C859DA665
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBA6AB2391F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C781E22E6;
	Wed, 27 Nov 2024 10:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ujw/fRqS"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131621E0E07
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732705099; cv=none; b=GBV7tS9UGobkp4/Z1dsvyZQCqb2cTeuZfQOTg3W9NeaWxcc6FiBSehjWFaNzcGGpLeHx6UoE6MYkPCYa1voLyMLmxHf0NTlYnq0ur0BbnHfrqNKq1WqIriOaaLXCtnvr/5bkfBI/QolwgCsEwZ1Lz34FD++qA7r4MmC0cwITOac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732705099; c=relaxed/simple;
	bh=tKaJ8XmsgFD3GQxgQIZteM0dQdO1QVEogrJL/zBu9vw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FK6shknN/mlo++l57rZL/DrdNVdF8sPgEEEAMKWiB60lknytqaIUNooPXyX8vfEpDO6Gp2cXFzUjaoxdBwGJFApVXWdS3z8AHD4iNrZN8iizFUwyo+dpSQedPQZB4gDFti3BcfREqyt3GER9OF+5V6gfah4Sm/bXfk7IataNdxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ujw/fRqS; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ffc3f2b3a9so49035741fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732705095; x=1733309895; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w9Ja8bSv98C0dnIrT5U7vJcSaQnvSrF1zZ95Z+KMMq8=;
        b=Ujw/fRqSokWUTYujzyoPLG6nTy50DI2hXvfB/p3z7pdWNRpjEZsR5uERnSE5uJ9tDa
         3tDDiRsBNV12ceYCteeplalW7ZQ4sDGWQlTmSGJVb0W0KAShBIK7fdr+BF9GKL+WBx9x
         +GzXm6bxQcFNJcQnwLNFKTCKy0PzzOv0LvX7roufg+UE0LM0co64qIXxrwYybnxhedAh
         Rb9xZ7kXlQuC/JA/3eObN36b/9X5GWZgTzF1IerRldiLlX/BPfuwDqdO7I0fDJu3qFQO
         ANCuIw1zd9FRms5bAM+yguVJctxLJC/mWulb28TEw/V8DEOGCaYj8W5Aqwv7Fg+0dL7+
         IB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732705095; x=1733309895;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9Ja8bSv98C0dnIrT5U7vJcSaQnvSrF1zZ95Z+KMMq8=;
        b=hmqI23pVySTWqhKo6Pm0OPhw5YuSKOXBqH3qhHki31AfGGJfw9UAu6EwjkmA6wDw90
         DGRJV/H8umN/dRqCH1TMYlxaqhGP8NqAxdbj5ZN8RzB08a9ctU+KotKi/TSTSarASpud
         4MzdxzZS6k4os/7jvxIjuf3MlLhf/LPZlNdid283iFih5M8nPxFe/FxdmNPrkBgxL1qW
         yyX6vjaYCx8+v/fnavD95tnMqFPtv7fzcLl/nhSUAmAIYqn8Ueccoqa0OMduaF+fWS2E
         nycECZ1OM7YgQJ+LLqm2PY6XQdSLv+kt0mrkeFHt2fhGtfvIJwXbDBL1orEl46WAKEVG
         nCKw==
X-Forwarded-Encrypted: i=1; AJvYcCVgiABI9RobDqCSdT6v9MA+0YK5QtynL74e5auvbcMBqd69+w2J8YJUF5/0G3531gf+e6UdhQ23NueyiUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk9n3FAgBtz9RDH9pWD1copj2GYm/DXmm0gfDEQo4gK+dukGpD
	PEDgHdw6BFbXBIXjWC4OEVHnRhBEAmqYmLknq+Fsz3LTIiK7K+RaIA9dOrSQFP4=
X-Gm-Gg: ASbGncsiuo+Ukhfopy5xFTJl2KXUf+EFV2kMZkbTIzyJUvuaAPI6lH+5g2nYzE4DF6U
	DjlaR+14NjXVQpzTozKRsyZAc9ixg+72VhKkr7ixXxfX03+y9+FqTGgqK2kgMk6akEHlFnYLVyZ
	R17qgLcuHuIHS1StNVyZ0POkTNl9rPh+4ATKWsyzhOHgSF4zOE+qPYq9qnhjdiJira+Q5639sGE
	LRMuAwLEXB/jx/D+u5a159lFrFR9IQjgiCHV0pA8/YQSkznynrTJ+X48AuMSCkJVmBqQibGYYwJ
	U/jxcFkZKBOMhU3rUyrHKJui+aDv/72udQ==
X-Google-Smtp-Source: AGHT+IGFJqt4+X9+b9OZ9iJ+1uoSSp1Y782XmdGaTyXXLw7W9wq9YHlHSBg308ZxZ/fLYqnCqQPhog==
X-Received: by 2002:a05:651c:b24:b0:2ff:c4b2:496b with SMTP id 38308e7fff4ca-2ffd5fcc1c9mr16671261fa.7.1732705095196;
        Wed, 27 Nov 2024 02:58:15 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa54a6db906sm412183566b.41.2024.11.27.02.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 02:58:14 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 27 Nov 2024 10:58:16 +0000
Subject: [PATCH 6/9] phy: exynos5-usbdrd: gs101: ensure power is gated to
 SS phy in phy_exit()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241127-gs101-phy-lanes-orientation-phy-v1-6-1b7fce24960b@linaro.org>
References: <20241127-gs101-phy-lanes-orientation-phy-v1-0-1b7fce24960b@linaro.org>
In-Reply-To: <20241127-gs101-phy-lanes-orientation-phy-v1-0-1b7fce24960b@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, 
 kernel-team@android.com, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

We currently don't gate the power to the SS phy in phy_exit().

Shuffle the code slightly to ensure the power is gated to the SS phy as
well.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index 2a724d362c2d..c1ce6fdeef31 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -1296,14 +1296,17 @@ static int exynos5_usbdrd_gs101_phy_exit(struct phy *phy)
 	struct exynos5_usbdrd_phy *phy_drd = to_usbdrd_phy(inst);
 	int ret;
 
+	if (inst->phy_cfg->id == EXYNOS5_DRDPHY_UTMI) {
+		ret = exynos850_usbdrd_phy_exit(phy);
+		if (ret)
+			return ret;
+	}
+
+	exynos5_usbdrd_phy_isol(inst, true);
+
 	if (inst->phy_cfg->id != EXYNOS5_DRDPHY_UTMI)
 		return 0;
 
-	ret = exynos850_usbdrd_phy_exit(phy);
-	if (ret)
-		return ret;
-
-	exynos5_usbdrd_phy_isol(inst, true);
 	return regulator_bulk_disable(phy_drd->drv_data->n_regulators,
 				      phy_drd->regulators);
 }

-- 
2.47.0.338.g60cca15819-goog


