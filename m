Return-Path: <linux-kernel+bounces-362138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF03499B17F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9122C1F2210A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062B6146A73;
	Sat, 12 Oct 2024 07:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abQkmSzM"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122F513D50A
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728717596; cv=none; b=u5meJpumTEDkC9i485pcOMxQmnfo5VMN//Ds/M4ILF2rBQgsmsQX+QjeVam/VHvltY8ZNPPqxYXgQ4i0hbuItB9n4pUYe+bHKNgukZwDuzKokGFDBZQ5RmCVXdDd4GIEs07zqW4z/YcyMXi2jwqoMb2KYZV1XNQM5Igzmu17wYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728717596; c=relaxed/simple;
	bh=9sOCsYd8FuD1db4bG2wZTrCV0DHzZtqtGuhIk3xlfMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0iCIVeGD1PNQnb0DMHvolgny+YZ30wT8vFkD9yH3kklg/1XxhdYGqJ0pjUz8OVm9o0uCx1jg6TYsTFyfcAvxj5lttGeAuutrjpA+5883NIv6wkxg+Sh43zfuouSKQBpkiHomQX2yeo/K3h+wsSDYu1po4ddd/QI0PtFQnhOA3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abQkmSzM; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71df04d3cd1so2359895b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 00:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728717594; x=1729322394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97G2TijBo7TJKDwdLKVOfvTHrYI49lDUOlitVvXkVUE=;
        b=abQkmSzMJoHPUEnud/mJlqv7JHD2LHlXXcvWZzu8Eg96lOVPzS3YOahbMwrkdD5QxE
         ClHeqRgdwbMf/OZhy+yAx/eKYs0clV7eca+wk3JxQMjdaHHfI/HqF4n/EdR9YVQIa+O/
         ZKVOq8JHQ8e21yAhBR9HfO8DWdJmSkGaePJhOBTMeoRwityd5Rw/jYJuvRaFU0JmzMy1
         BuxKFNkXZX4PQ4KqDMEtSHjrD025ozFvfL5Cakh6NlrOZZyI95RUw+kix8ODIlWn/thX
         l0MeothT4h0TcAcy+VyT5NfBtAlCQhU2y0/QAPvhLu+zxR6ghZi+XYiqkG14fCvVf78A
         g2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728717594; x=1729322394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97G2TijBo7TJKDwdLKVOfvTHrYI49lDUOlitVvXkVUE=;
        b=cAH0sffsol1OEyF2EqCrInE6y16sin9NbzanTbGKxaAa1kCM2iSkIRc+PrnMOOyINI
         mXK9HlYYfNs2a4UdINQCvcQi6rABV1D5+52sjuAV6Z6di8/ay3WIgR5+MT/8PjTnFT/h
         vXecSAUheXa8P5GWXYEQsMRm+hIseSZZrf96BGpxQJJt3tNlA/0EczUuKR9zubXCJ4Yv
         IO1soInhc/J5Ymc1VNvKXuBj7KE1tvcPjeji5Kgaa5+Ezgmmwiu7GQLJMWMTNPJkQWMB
         DL7VCd8QPbwzqDHVtnb4GPdcYkkDRYtDc3acTNw2FloVZIWsjeCn2yr5Fw5uMdcmKWgN
         4IQg==
X-Forwarded-Encrypted: i=1; AJvYcCU3War2W/cQdIO6IrrpAc3MWGuiE+CwJqvfYtsPjbtk3+6DoSMmA9IIoIfonisOZBWmJ7lgj70jDnwEqW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoP1oucf9Pg8lYzMWFtSenDQNl6UgDgh8tfoBcl5uBVvMz5Das
	uxTcIo+y5fGrYrCyvYcWEa1Sghi/mXdL1bW2Eoj9yEptfU/FhdMZ
X-Google-Smtp-Source: AGHT+IGQCNKpLK6KUs8VSkaJ0d7emmgc4XI8SJDHYeYoaej9YcBG4bftnc4g9GOFwvVQAzJ0Rkljkw==
X-Received: by 2002:a05:6a00:189a:b0:71e:4655:59ce with SMTP id d2e1a72fcca58-71e4c03044cmr3762274b3a.0.1728717594320;
        Sat, 12 Oct 2024 00:19:54 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aaba171sm3664620b3a.161.2024.10.12.00.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 00:19:54 -0700 (PDT)
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
Subject: [PATCH v3 4/6] phy: rockchip-pcie: Refactor mutex handling in rockchip_pcie_phy_power_off()
Date: Sat, 12 Oct 2024 12:49:06 +0530
Message-ID: <20241012071919.3726-5-linux.amoon@gmail.com>
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

Refactor the mutex handling in the rockchip_pcie_phy_power_off() function
to improve code readability and maintainability. The goto statement has
been removed, and the mutex_unlock call is now directly within the
conditional block.

Return the result of reset_control_assert() function, with 0 indicating
success and an error code indicating failure

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3: New patch.
---
 drivers/phy/rockchip/phy-rockchip-pcie.c | 26 +++++++++++-------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
index e60f24b0b363..c84a3c209315 100644
--- a/drivers/phy/rockchip/phy-rockchip-pcie.c
+++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
@@ -132,26 +132,24 @@ static int rockchip_pcie_phy_power_off(struct phy *phy)
 				   PHY_LANE_IDLE_MASK,
 				   PHY_LANE_IDLE_A_SHIFT + inst->index));
 
-	if (--rk_phy->pwr_cnt)
-		goto err_out;
+	if (--rk_phy->pwr_cnt) {
+		mutex_unlock(&rk_phy->pcie_mutex);
+		return 0;
+	}
 
 	err = reset_control_assert(rk_phy->phy_rst);
 	if (err) {
 		dev_err(&phy->dev, "assert phy_rst err %d\n", err);
-		goto err_restore;
+		rk_phy->pwr_cnt++;
+		regmap_write(rk_phy->reg_base,
+			     rk_phy->phy_data->pcie_laneoff,
+			     HIWORD_UPDATE(!PHY_LANE_IDLE_OFF,
+					   PHY_LANE_IDLE_MASK,
+					   PHY_LANE_IDLE_A_SHIFT + inst->index));
+		mutex_unlock(&rk_phy->pcie_mutex);
+		return err;
 	}
 
-err_out:
-	mutex_unlock(&rk_phy->pcie_mutex);
-	return 0;
-
-err_restore:
-	rk_phy->pwr_cnt++;
-	regmap_write(rk_phy->reg_base,
-		     rk_phy->phy_data->pcie_laneoff,
-		     HIWORD_UPDATE(!PHY_LANE_IDLE_OFF,
-				   PHY_LANE_IDLE_MASK,
-				   PHY_LANE_IDLE_A_SHIFT + inst->index));
 	mutex_unlock(&rk_phy->pcie_mutex);
 	return err;
 }
-- 
2.44.0


