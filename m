Return-Path: <linux-kernel+bounces-198198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 472AD8D74C7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 12:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EEFF1C20F2A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 10:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB2A376E6;
	Sun,  2 Jun 2024 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TIolOa7h"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D78525745
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 10:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717325244; cv=none; b=W6ofgFpJ1ig3E3Mc+bs5X+re2kTy6S4itehVUtvPyowE4jJ8fTbEgL9zE3nUZVZ7GtQQI/wO4c3MLmP+HAWNsgm95V+136kmENZOSypb6cSLuaniZFyzyPowbyy8FZrCF7vDoW3EhjyueXNYjrkqHPd8INc4a+wFt4vrha9eFao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717325244; c=relaxed/simple;
	bh=1/+2llMpQdP/3+o/5wjiyOWh74XNKa5CnOfSFGvFbOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dv5Mw51sA1mFAH7uxgfMSiRe6VIHAPFrYnS5rvW+xQs2x43jx/LNX7bKyB4s5q2hPItaJrAGAiRuXb5zuJA9W07PrIRkMn7Bj2qD7p5KUhUbI1sB3znDjTXkcLp2R4F1SR1xJLRE+gvJCU9/+GyLmrXJakV+/7OWHwuniBGthoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TIolOa7h; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52b82d57963so3245549e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 03:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717325241; x=1717930041; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4+cEYgp87ni0KKsYzhCn64iTe9kQ3eMZgy4fJLAApoU=;
        b=TIolOa7hwJQX8j3+/SvMqH07J7w+fU8IZoUUlGLpE05BcqwfgV29twiLCFWri3g/VK
         t+0BGk4+PHv5EN+LdqOgQrsRszJkM/U/3KnAEKyZY/PLPG9zbd/HpjkdqOjIsQ1R+ZJi
         /LHY5OhVul78v1ib8/Bbtbgpvrxg2/8Uk6OT2dDndXnDirLxZNcr0TQyJjDnHk5fsTz4
         7rN1lUbGyRvIbA+G2yXYgIfOkKtDz5ilOmmNTWA1A24XDaRBoyKdr1dfOGEgZ/7ps8UR
         Xp769/1LGWWClxGWY40X7fgbfr7F0Q2NssHZSQYeZtpVJ1yj5du6PD6wWNEgORsaCLpE
         5Gtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717325241; x=1717930041;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4+cEYgp87ni0KKsYzhCn64iTe9kQ3eMZgy4fJLAApoU=;
        b=VCdXKnCAcmum6g3/N5QDcngwKtHouu4SvHQfD6S6Ot70/4P9ZJvBTSYH3JYuOgAUyt
         wRBQR9lDP/Ew0sSrsQNEN8WEAf8vxcs3YzXvPuJNZoqIAfGWsdhuXZ2DvVSjQKBToc+R
         XSNMA7LkKDwZyJyatWMkrXWueQ0ZdAxjV75yT/zSo5a1+qTcajnMipfiGWGbypK5Wlde
         ZY4Dvfz+RNRdAMXNjSiY2pzCO6C7ZMQ18V8fnv6d9NZLF9JqXFmij6VwT6EXfNYIXzsK
         L7WUNIg04rgZRS4zN0bGkhXSeQwMRm+e8GvNqRkrWq85sMClLiq6Mey8pYV0/0hZhxYM
         naUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKXp2fmpvsUL1kj2Z0w4l1SePbJMahUkNhJML0r8DuumJ/+P55+qtfiuOWDQGJ0Hzl3RjypjVX6pO9AX+zKzxMyDDg3yBNpLQEMgKm
X-Gm-Message-State: AOJu0Yw/bOoWzQTbLIy1GeZMx6ZRr0XEBZDtHUsvMerT+u0ir3162E54
	pzkbRGEBAPl12PjPVS2uA+N7WSeEkmckWPJoicSaUJwtyV5b44pEd8QS7/w98F8=
X-Google-Smtp-Source: AGHT+IGozxv1VWYFsf9D8aRKbHwKqmUaoTabG0HYVCxenmdRvpAZjxLWQ7YD8mdajF0g2zEAaACOPA==
X-Received: by 2002:a05:6512:39c5:b0:516:cc2d:f6a1 with SMTP id 2adb3069b0e04-52b896dc4f6mr5799698e87.51.1717325241201;
        Sun, 02 Jun 2024 03:47:21 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d3f327sm925261e87.97.2024.06.02.03.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 03:47:20 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 02 Jun 2024 13:47:20 +0300
Subject: [PATCH] ARM: imx_v6_v6_defconfig: enable DRM_SII902X and
 DRM_DISPLAY_CONNECTOR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240602-imx-sii902x-defconfig-v1-1-71a6c382b422@linaro.org>
X-B4-Tracking: v=1; b=H4sIALdNXGYC/x3MywqDMBBG4VcJs3ZgjCVWX0W68DKx/8IoCZSA5
 N0NXX6Lc25KGqGJRnNT1B8SzlDRNobW7xx2ZWzVZMW+xIllHJkTMIjNvKlfz+Cxc++k9255dzI
 4qu0V1SP/v9OnlAd6ZWsoZwAAAA==
To: Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=991;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=1/+2llMpQdP/3+o/5wjiyOWh74XNKa5CnOfSFGvFbOE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmXE24oJTSygDI0XRWsAL8mENsW+cDFmr+XKazP
 qHwJcelldmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlxNuAAKCRCLPIo+Aiko
 1bGEB/9Q2zDWKpIlKO9dqdQAohnRKBlkPWRUjQ4r0mBQXYfoqqDLv8zgLmKR9alSGDOBauYlkDh
 jQ1CF4GUaKtSz/QRvJ8YzecuYumFXc2k5M2Zs4WQHhvKL6XHKej+DQFpX3wlGzcM1us1EuSyJxT
 mqDOD+1DSyaG7rS2dmbOijObFKyjH6bH8qJMi9ACg30wV5IHwcZfOPec4JlF5ZP3gsyusIeKxxB
 20UST1x7y2tjfWy7IX3YLDJzy5zuKjYXmwGuIFcr5X/+O38bJa3BVRpQiK27U/vSLDhaTdUsxst
 J/tuTq4nAX8Btn2ZM1v7pFM/Jwt8izNMd5NcEtZ4FcEZMydD
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Enable the LVDS-to-HDMI bridge and the HDMI display connector drivers
used on the iMX53 board with the HDMI mezzanine.

Cc: Chris Healy <cphealy@gmail.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index cf2480dce285..b6a2d0689cb6 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -282,6 +282,8 @@ CONFIG_DRM_PANEL_LVDS=y
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_PANEL_EDP=y
 CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
+CONFIG_DRM_DISPLAY_CONNECTOR=y
+CONFIG_DRM_SII902X=y
 CONFIG_DRM_TI_TFP410=y
 CONFIG_DRM_DW_HDMI_AHB_AUDIO=m
 CONFIG_DRM_DW_HDMI_CEC=y

---
base-commit: 0e1980c40b6edfa68b6acf926bab22448a6e40c9
change-id: 20240602-imx-sii902x-defconfig-7607f6b83096

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


