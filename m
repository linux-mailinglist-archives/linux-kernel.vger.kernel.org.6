Return-Path: <linux-kernel+bounces-362140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6965099B181
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 701091C225ED
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF6214431B;
	Sat, 12 Oct 2024 07:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1duH1Iv"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0681C142E76
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 07:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728717606; cv=none; b=TE8lTofH8KT0g3DD6WpkQxD8/7M5auUIh5hYU7UGFeu4i2wUQ+RXurgOv4VlT68/8RmqtLdITpXvETd+lPTujiBgQQs/Qpg9daY0b+ipjjsH8dYfhSd737/gk5fwmjy1H5oRO4dNljfNVbjVx9AVuZxRCNePRLRlgbUQXhbKGM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728717606; c=relaxed/simple;
	bh=YmNKaUk7IoY1KZlZKWCDkN2t9kQL+UzmbogTz9W9Qec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2OZjPqHfGS7RfSgoDoc88/0RbkJwEbcuFZep521tPdCrFL+OaRePJUPYlRVd2qgzeRT2adP/UQ4LocAcgnmCHlMRy+tnSV2T3ME8ijSK67gj6jyfxvoFFhk3LwYqRAP0d0U1XJvWy1EAOJvH8qeoNOto613fkqiE0f8kPfTrys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1duH1Iv; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e1a715c72so2056821b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 00:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728717604; x=1729322404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ApDa1aMFJqfOVoyoGKBNzlcDrQSgxcYXTomesTpCDA=;
        b=K1duH1Ivn5XtEQiTHpPirsCJRDAW6G0aKWF8s82647lc08ZJkBuOkRxBbO9ZdU4m5p
         V8bBEdoK0hlpRSSwvhl48vDmlquQBuo9ssVtyhSRxyufs0Y87FI13U/Z5cIuctWAu0JR
         ohWohH3oeqsv0lYiuut1Gxb5LhrtFVmDIvaockUS4eeuwm4mqG4OylJc4lFkhKUxmTLm
         RvL9/C+goA3I9TkWpPfZ+c5JrqUtkDQ6Xv4Dpi8ZGVL9OEHYz1IUiAy8GLYQTHoNv6Bw
         NiL3IKg1gUzocayOPI9cpoI1sttKgmmErkjWmP33fTqb+ZKOYMD7eqFmoVu427EcIEyd
         Wx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728717604; x=1729322404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ApDa1aMFJqfOVoyoGKBNzlcDrQSgxcYXTomesTpCDA=;
        b=aaVM0o4xnv+3rV4HavjHTOe5yX7+j0C0nSNWugShiTsNrOS1pk4TxTgDuUpHn5gj4t
         1/UVApXv+iErnB3WF8mxBYysKO4NLOpGpL5/AC17rMgDm6MZuA2IFZ5J1Z/ofJCwPRZN
         cBoWj9fvk4DwGcrBT2KYZ98swXb76DcD+T5A7k4AZSHilzVflrypHrp6EkT0U6zhtDJL
         GXouXWjBQRCGPxuFVvPzIXnqQSKu5iJ5B0whhfT3RyeoIp3RzejN/cKxbdx4a5AHWU0X
         ecbI1LrNFQcZPEm3hNsoeh++fjTQB+JDINnAiZPZHb2iPNNA9P2R/dZb2eP/HNfaxmlJ
         AxJw==
X-Forwarded-Encrypted: i=1; AJvYcCVEamFlFShhlKY9W88Oy+u9V9gHn7Fp9rvqMungC6EpIAARLmaLTTAhro0Aq/pZJTI/bWjVGQXyFdYyV04=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ9yntXLGV9FcZ4NEii2jMayGW1joDeDb8VpbPaq0cKxxg2R5/
	7Q3zGNi2vpWlZRd/gLfgo+z9E41QpSgM/5bHSt3E9TQ8ioALVNwU
X-Google-Smtp-Source: AGHT+IFsw1Y6x7x4B49Cs5Sitm7AtWn/o4JBeTJPuqe7CDeq3DvEnDZYXFgGluNUXLU0iuQXhCPlsA==
X-Received: by 2002:a05:6a00:1390:b0:71e:ba5:821b with SMTP id d2e1a72fcca58-71e3806bfefmr7441120b3a.27.1728717604256;
        Sat, 12 Oct 2024 00:20:04 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aaba171sm3664620b3a.161.2024.10.12.00.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 00:20:03 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v3 6/6] phy: rockchip-pcie: Use guard notation when acquiring mutex
Date: Sat, 12 Oct 2024 12:49:08 +0530
Message-ID: <20241012071919.3726-7-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241012071919.3726-1-linux.amoon@gmail.com>
References: <20241012071919.3726-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using guard notation makes the code more compact and error handling
more robust by ensuring that mutexes are released in all code paths
when control leaves critical section.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3: New patch
---
 drivers/phy/rockchip/phy-rockchip-pcie.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
index 6dd014625226..bd44af36c67a 100644
--- a/drivers/phy/rockchip/phy-rockchip-pcie.c
+++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
@@ -124,7 +124,7 @@ static int rockchip_pcie_phy_power_off(struct phy *phy)
 	struct rockchip_pcie_phy *rk_phy = to_pcie_phy(inst);
 	int err = 0;
 
-	mutex_lock(&rk_phy->pcie_mutex);
+	guard(mutex)(&rk_phy->pcie_mutex);
 
 	regmap_write(rk_phy->reg_base,
 		     rk_phy->phy_data->pcie_laneoff,
@@ -133,7 +133,6 @@ static int rockchip_pcie_phy_power_off(struct phy *phy)
 				   PHY_LANE_IDLE_A_SHIFT + inst->index));
 
 	if (--rk_phy->pwr_cnt) {
-		mutex_unlock(&rk_phy->pcie_mutex);
 		return 0;
 	}
 
@@ -146,11 +145,9 @@ static int rockchip_pcie_phy_power_off(struct phy *phy)
 			     HIWORD_UPDATE(!PHY_LANE_IDLE_OFF,
 					   PHY_LANE_IDLE_MASK,
 					   PHY_LANE_IDLE_A_SHIFT + inst->index));
-		mutex_unlock(&rk_phy->pcie_mutex);
 		return err;
 	}
 
-	mutex_unlock(&rk_phy->pcie_mutex);
 	return err;
 }
 
@@ -161,10 +158,9 @@ static int rockchip_pcie_phy_power_on(struct phy *phy)
 	int err = 0;
 	u32 status;
 
-	mutex_lock(&rk_phy->pcie_mutex);
+	guard(mutex)(&rk_phy->pcie_mutex);
 
 	if (rk_phy->pwr_cnt++) {
-		mutex_unlock(&rk_phy->pcie_mutex);
 		return 0;
 	}
 
@@ -172,7 +168,6 @@ static int rockchip_pcie_phy_power_on(struct phy *phy)
 	if (err) {
 		dev_err(&phy->dev, "deassert phy_rst err %d\n", err);
 		rk_phy->pwr_cnt--;
-		mutex_unlock(&rk_phy->pcie_mutex);
 		return err;
 	}
 
@@ -230,13 +225,11 @@ static int rockchip_pcie_phy_power_on(struct phy *phy)
 		goto err_pll_lock;
 	}
 
-	mutex_unlock(&rk_phy->pcie_mutex);
 	return err;
 
 err_pll_lock:
 	reset_control_assert(rk_phy->phy_rst);
 	rk_phy->pwr_cnt--;
-	mutex_unlock(&rk_phy->pcie_mutex);
 	return err;
 }
 
@@ -246,10 +239,9 @@ static int rockchip_pcie_phy_init(struct phy *phy)
 	struct rockchip_pcie_phy *rk_phy = to_pcie_phy(inst);
 	int err = 0;
 
-	mutex_lock(&rk_phy->pcie_mutex);
+	guard(mutex)(&rk_phy->pcie_mutex);
 
 	if (rk_phy->init_cnt++) {
-		mutex_unlock(&rk_phy->pcie_mutex);
 		return 0;
 	}
 
@@ -257,11 +249,9 @@ static int rockchip_pcie_phy_init(struct phy *phy)
 	if (err) {
 		dev_err(&phy->dev, "assert phy_rst err %d\n", err);
 		rk_phy->init_cnt--;
-		mutex_unlock(&rk_phy->pcie_mutex);
 		return err;
 	}
 
-	mutex_unlock(&rk_phy->pcie_mutex);
 	return err;
 }
 
@@ -270,13 +260,12 @@ static int rockchip_pcie_phy_exit(struct phy *phy)
 	struct phy_pcie_instance *inst = phy_get_drvdata(phy);
 	struct rockchip_pcie_phy *rk_phy = to_pcie_phy(inst);
 
-	mutex_lock(&rk_phy->pcie_mutex);
+	guard(mutex)(&rk_phy->pcie_mutex);
 
 	if (--rk_phy->init_cnt)
 		goto err_init_cnt;
 
 err_init_cnt:
-	mutex_unlock(&rk_phy->pcie_mutex);
 	return 0;
 }
 
-- 
2.44.0


