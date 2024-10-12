Return-Path: <linux-kernel+bounces-362139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDF399B180
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFAE41C2253A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06931474A7;
	Sat, 12 Oct 2024 07:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMi7Hk2A"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6EE13D50A
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 07:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728717601; cv=none; b=h6Ig5pJ15HnnwPfoPE1sM3K5C5u/x8tn88Ji/kXuSxp5rp0SF955v26Gy7M0Z0hHlzX5npNehhAg6MXL+kynMdOPj9gUSrSRBRTVIORTHwpsoESO64T96KL8/T4LJCmvxHemnNicu9wXyYma5+qJKv9Y2RQFhivXjVfOKZwqLM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728717601; c=relaxed/simple;
	bh=NQM+xKqLTytj/SwpdEdRSRqK2+IrXB9RWOud85bANfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARZrcBipDDJYtDRWrsDFszoQwSfmOSzcjmCYJxmfuRdh30z3HXugj3SIxyhlzj7SyvCUGIDwdtf4lzk39wQ/d6qfJ4Jtzm5WaZOc6Fz3B4UYSZrUsnWbwgKhyQN1WdBYCOGMMY9HEUADCNeqjZzR9XIgPBGpxETmSRgdjSVhLZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMi7Hk2A; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso1991169a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 00:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728717599; x=1729322399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tveNarpSwjlEhM4Qolz0xMrvg/75/UUwTA0pqhWJ0Mw=;
        b=XMi7Hk2Ab88kTmfW9kDZ+xLFIyf9NTvYBEBSERifoy78O/zajzsD/B2Y8CRjMyzlBW
         NCf5YSOFw175CuGW081lLWhhyvqWhZdL4wIuqCcE3XQgerrRLHNMi8hH378HRIAglxFv
         x8d8DJWz4DFQk5cg2zX3CetRJ3X9nKb75HYunEE3ZhJYd68tYOfQKOt+hbBeQve8IpPO
         LEFnOVz1LnE9V/Dq7pg71slxkbgSUX2cc88qB3zUHtAt2j8aFn9Rrd5PY8mNI2EfPKu5
         FkFZKi13CtxVI+gh/k90ql94LNO3A/LNeXiebnnumbUeOXSTZHiK+CaMfegd2IbEEnIa
         hwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728717599; x=1729322399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tveNarpSwjlEhM4Qolz0xMrvg/75/UUwTA0pqhWJ0Mw=;
        b=Udy40cx/H77537PcRjiOAdrPJBvUaqwucoNFQ1l3h36RFx4hUe2aYhaZOBYEKHjzoV
         ooI4Zrw2q+B6wjrQDewz7GDalvthoFYBeTNTjCC+EVhTrJcL7+SE3NHCNc2iYBKaDxxw
         U8Y8CtAMvJ7CGRlOFQ1bAeq2P5HQmBW9OrhDJrFoEc8ksmyb5a2AHzsDXQ5KP1aBwuHr
         4DtG4KRnCEk+6lrpArBpQZ7fhmYwz+G7MKF/znDfBLxtfBDXw5ZPzlUIR0J5daMYYOIY
         F/toK5wt2ivxECG/XMcMHnDQvV15rChR2vdobi7UrddkPq8DGFpgmdhLWxjgWbHy7S54
         UTtw==
X-Forwarded-Encrypted: i=1; AJvYcCUmicd472pTZA/4EuaYfp/2t3bPnYxTnIaKFXhoHV9eepmxoHAbUQx6reCjXNiNgVkGp9x6enjEoxgphGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4bK/GCZKMjQGN5BAFhdB7ZJtRgseTUOr59znX3JSSx0/O5mD9
	ivTkw9/Z8NSviVw6nw3Nld5FjcpSbmi+0vmb3/wQ4iHf6wIqXNEP
X-Google-Smtp-Source: AGHT+IHa+OOul8kkfcVe5xb551ye568I+GFpxdHlOz9EhP0OrqwzuVKv5lNmoyUlXuqKze6HkNM1TQ==
X-Received: by 2002:a05:6a21:6e4b:b0:1cf:e5e4:d225 with SMTP id adf61e73a8af0-1d8bcfaa171mr6538150637.37.1728717599290;
        Sat, 12 Oct 2024 00:19:59 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aaba171sm3664620b3a.161.2024.10.12.00.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 00:19:59 -0700 (PDT)
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
Subject: [PATCH v3 5/6] phy: rockchip-pcie: Refactor mutex handling in rockchip_pcie_phy_power_on()
Date: Sat, 12 Oct 2024 12:49:07 +0530
Message-ID: <20241012071919.3726-6-linux.amoon@gmail.com>
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

Refactor the mutex handling in the rockchip_pcie_phy_power_on() function to
improve code readability and maintainability. The goto statement has
been removed, and the mutex_unlock call is now directly within the
conditional block.

Return the result of reset_control_deassert() or regmap_read_poll_timeout()
function, with 0 indicating success and an error code indicating failure.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3: New patch.
---
 drivers/phy/rockchip/phy-rockchip-pcie.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
index c84a3c209315..6dd014625226 100644
--- a/drivers/phy/rockchip/phy-rockchip-pcie.c
+++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
@@ -163,13 +163,17 @@ static int rockchip_pcie_phy_power_on(struct phy *phy)
 
 	mutex_lock(&rk_phy->pcie_mutex);
 
-	if (rk_phy->pwr_cnt++)
-		goto err_out;
+	if (rk_phy->pwr_cnt++) {
+		mutex_unlock(&rk_phy->pcie_mutex);
+		return 0;
+	}
 
 	err = reset_control_deassert(rk_phy->phy_rst);
 	if (err) {
 		dev_err(&phy->dev, "deassert phy_rst err %d\n", err);
-		goto err_pwr_cnt;
+		rk_phy->pwr_cnt--;
+		mutex_unlock(&rk_phy->pcie_mutex);
+		return err;
 	}
 
 	regmap_write(rk_phy->reg_base, rk_phy->phy_data->pcie_conf,
@@ -226,13 +230,11 @@ static int rockchip_pcie_phy_power_on(struct phy *phy)
 		goto err_pll_lock;
 	}
 
-err_out:
 	mutex_unlock(&rk_phy->pcie_mutex);
-	return 0;
+	return err;
 
 err_pll_lock:
 	reset_control_assert(rk_phy->phy_rst);
-err_pwr_cnt:
 	rk_phy->pwr_cnt--;
 	mutex_unlock(&rk_phy->pcie_mutex);
 	return err;
-- 
2.44.0


