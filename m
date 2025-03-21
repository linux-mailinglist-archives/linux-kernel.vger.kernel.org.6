Return-Path: <linux-kernel+bounces-571441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 907FAA6BD41
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD943B061D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FDB1DACB1;
	Fri, 21 Mar 2025 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gAgsI+Ml"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923531D5AD4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567780; cv=none; b=avIFXUzy566+a5Cd1GtO1HXWVFf1w9DVrbRtuwdm26oQQ0i2YVS/tJNhfr0rSgx85ggDWvg/JrBPkhQpb4s0tyjakzTF0w1LynDlHuMmAm1uuFs8ClqOyoe4SWigNB9/iRELdwDyH1Xx/2s/rp7xgREz9LuTRkyLF41kWDQzkjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567780; c=relaxed/simple;
	bh=3tfB7n6h6FyjzlUtea67REfTN8UJaPakhNxFywAX3RE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Nzb56Gy949r02nL7maRRost61PoXGPwTFiAE82qT3IJ3clBPNVpLtrICooJYPvmROmTi760OtgjDtxCnRjgKbKxGxm2U4X0EM4HRMu+RSd7iO0yaCEDo6M3sIlBTNV8dCiXFwouoxzD7N7nRppXyh31PSkr3qCrki7ZNF9d8iBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gAgsI+Ml; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso13077345e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742567777; x=1743172577; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ra/8DYijPPPXyKfJwTLkvfoC8/C3kF5QcCpYx+TRQN4=;
        b=gAgsI+MldgL6BzP8q/MVf5j2hAX1Ju7qvQqmSJqGeUxb1RNOza1VfIeq1vUbPXwAwY
         3HGjWPrJZpc/uGkyR2pAQzR89QwaqjEX6cYcY5BBGlo2MFCyayrrNSkccst010KeL6xj
         CtJqkEKapG0Vwbu+Lm7KeHaTCMf1nLzVIzNClWiBAKH43ZhginSjtrbDYJps4juKBFFI
         Gwj2engaRBsxyPehZq2371o4zocX+/nhpIRf7O4JxmE0rGrxMir9STw6oSdwBqXSqPjC
         cAk097QBBzUi1F0oOOs5iGfHXkZ4nccONfKSgst4Zukn6SzXDuBPYCElVc8QNURwcz7e
         UvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567777; x=1743172577;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ra/8DYijPPPXyKfJwTLkvfoC8/C3kF5QcCpYx+TRQN4=;
        b=jWX7+BHDr6sJG95Clkrnbme2B1BZ8FjIBDFe4h5xodeTTIC7nKXBDLDduY8uDlHuU+
         JpnzTLJixO2fKFIeS08aMmslZyAEQfmA1j3MjJGjM6Mqjkza6txd6nr4sE1XsnGtHXul
         lEdJtPgHY5vr8wRFUdXCc9ZvYH/l9ww4M27HDQ0PmBkB9vmd4yVTmFIQTfEqpiZJ05kJ
         183WPsbxaLF1ZF18gAG0CioJL/W14YRV8IveFQG4iXBOQZjH/RJDzFu4F1MgCk6qt1d8
         U/OFe2PSvuMNqalJJvcxdBqcRZUy8GXtdiNKR3zwkmJ9UUxpUlINEndAh9Cnj0aSyM15
         FNBA==
X-Forwarded-Encrypted: i=1; AJvYcCVREEJLstSy8d4Bej4vCPQobbLMGmsuZZ7uFGRyEOsFDbAsMr3dh/uK3s9y2m5DGTKA1tcsd0wxV00VOW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyljbFJAXUZP021CRAzYJMA3jZAWQGsS/silccd13BnMrnqmyXB
	kGbjamZh9fIKG3ONtI+fnUatnsnVeRHyaKcjFV6fd1zXafzJCUR+AuZCYSzZM6E=
X-Gm-Gg: ASbGncvVT4viNjTMkAugwk+DB688TIy4WbB7DuVZuJf8cEEoQwCo3D2VifoI6dGI8E9
	QcQdIBV+dUm2/GIbJNvI8zwdYCntc6SysYnuMwfONe/Ea1Gdg6ntCs2JRAImuXGMz2+zTIg89fu
	KkIK3YSqasfAgMsKLBebKMpyYPpPEtmYPA0Y9vsrdagJSwC5NsonRjoUPPaOoU60Q9aEIZSbBFS
	GeDgT48NK54TuPEyRsD/Vp/c0CdACLzD4/KwWSRHSuhiLCrH/3JfDTsH42MRpbgblnNKu9gtcFz
	uG1aqvb9zFT19sU6qowL+VkHd2datPYyNjYE/iaAbnkxDKVtuA==
X-Google-Smtp-Source: AGHT+IEBLRuGXXY3Hg/ewdBvYCF4zvDlD21Rbhn+1Z3hKO681e8YV9SPfJqpV9SZgDhIe4keKF4QkQ==
X-Received: by 2002:a05:600c:8719:b0:43d:53c:1ad6 with SMTP id 5b1f17b1804b1-43d50a4ae7dmr28254255e9.26.1742567776837;
        Fri, 21 Mar 2025 07:36:16 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d4fceafacsm29121045e9.6.2025.03.21.07.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:36:16 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:36:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] phy: rockchip-samsung-dcphy: Add missing assignment
Message-ID: <e64265a4-9543-4728-a49f-ea910fccef7c@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "ret = " was accidentally dropped so the error handling doesn't work.

Fixes: b2a1a2ae7818 ("phy: rockchip: Add Samsung MIPI D-/C-PHY driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c b/drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c
index 08c78c1bafc9..28a052e17366 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c
@@ -1653,7 +1653,7 @@ static __maybe_unused int samsung_mipi_dcphy_runtime_resume(struct device *dev)
 		return ret;
 	}
 
-	clk_prepare_enable(samsung->ref_clk);
+	ret = clk_prepare_enable(samsung->ref_clk);
 	if (ret) {
 		dev_err(samsung->dev, "Failed to enable reference clock, %d\n", ret);
 		clk_disable_unprepare(samsung->pclk);
-- 
2.47.2


