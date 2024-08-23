Return-Path: <linux-kernel+bounces-299684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0D595D89F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19EF01C2190F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 21:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADF71C8225;
	Fri, 23 Aug 2024 21:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KJQmm6eV"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F4D1953BA
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 21:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724449365; cv=none; b=azjSgwEl71poo3LKvgmp3ylrWa6Sh9aiCEle10GXUiThYkW8R92ZLmVJADWZhFxRcgsB7LFhHV55k3jNEaUeo+z54MwIgDgoeIMH6igEKHucD88da+YfubEk65dvdlPh7dKKJwzm9oSqaGpDxYU1EVYtHzo+6egEFt/LueT3/qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724449365; c=relaxed/simple;
	bh=XSXJzOwEhN3LBd9q7srfwXbleUbDiNHKgOWgEYrFn0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WTYSL0K6WIEKplUatF4DTzyg9dz+mUrIIGRe001K0+8nEb+cAidnttqdLH5IEwfYrESAI9ic/zPpx+UE0iZawVURaLMyftSV1aJ0AnN3vOQp0hpI3Pv/vutFqpNXPlJtzZtVQNUb/QRPtPx8dgdSq/dQdwryM4iMqFa0daRTFBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KJQmm6eV; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-201f2b7fe0dso23966145ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 14:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724449363; x=1725054163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AjvArJdA06PbNXPgnOry3Qq7eKu1y9KpKSsxjlMv9Wc=;
        b=KJQmm6eVhwVEQZ8DNVvsahDCtoCCXSaAKsahqI3S/FiBwuDAEMF/4x7Q5ACmNUF4g/
         gCbNNyEB6VS9ixV6LMexTg7UtYDX5YWpdTfBXIccYPUs8uqPB9Jse1BUQ0bLRdRGZfNQ
         rdJRE/bxShPiJHia4hsDRkd1ZP80pJ3oTdOuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724449363; x=1725054163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AjvArJdA06PbNXPgnOry3Qq7eKu1y9KpKSsxjlMv9Wc=;
        b=vitYKa2oy2wXGOpaIPzJM8cJMZsH1Y82uCHKOJeD2FZO/n3CVmMfaGL1ogCPbvZNKT
         tsMtyoP9jXkdMbECfoS7/ncbbXEYrMzgJFLNplvJ2z4i2teUoYPGkuhUVZoRET3yFCL6
         RCYZKmxDYCrXRbkVJ/2CMFWttoKaTprlqqdXqrkn3xG43SHXxUtMdil/PdLovXVmkkFd
         1PRdmYK/LIYXlIyURq2Bt2KeznesRH58bmuQrFhJeiefyyPRt24TxxQvvukzTWC9qlKp
         tN+CiHBXqb25pkkdRJeG1J770zJSq/qTJjFtNGIWHOl51ZWJKgiTtWcD/QtHQi974nAr
         aeVA==
X-Forwarded-Encrypted: i=1; AJvYcCX9IipWuEUOy/sUl21e86c59+LeqzK33V961l0dreHbeKgpl3fM+4rdcr3mHd/UTZVdZd72Qz+i4Zo9hec=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWB7sAFCFzcktth4RTfktlh58lZNm2c+rLLBaxFdT2M4lGs/eo
	SIBkj2WQRuJO0kwHGm1LuXwKinSqvwqCBZa5MmZperf7drvj2BuQC4jAuuiqQA==
X-Google-Smtp-Source: AGHT+IGx6tc8HURRUBmfNKOOVhPbKyAJLPo58Lxm+iRK79rRI6Fo2cVzD+Gs5a92IWu63jXL+kWA/Q==
X-Received: by 2002:a17:903:22c1:b0:1fb:7c7f:6458 with SMTP id d9443c01a7336-2039e4b4bcemr38350745ad.32.1724449363238;
        Fri, 23 Aug 2024 14:42:43 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:9d43:7af7:9970:8219])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2038560975csm32500335ad.194.2024.08.23.14.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 14:42:42 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Mark Brown <broonie@kernel.org>
Cc: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Brian Norris <briannorris@chromium.org>,
	stable@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	Jon Lin <jon.lin@rock-chips.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-spi@vger.kernel.org,
	shengfei Xu <xsf@rock-chips.com>
Subject: [PATCH] spi: rockchip: Resolve unbalanced runtime PM / system PM handling
Date: Fri, 23 Aug 2024 14:41:56 -0700
Message-ID: <20240823214235.1718769-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit e882575efc77 ("spi: rockchip: Suspend and resume the bus during
NOIRQ_SYSTEM_SLEEP_PM ops") stopped respecting runtime PM status and
simply disabled clocks unconditionally when suspending the system. This
causes problems when the device is already runtime suspended when we go
to sleep -- in which case we double-disable clocks and produce a
WARNing.

Switch back to pm_runtime_force_{suspend,resume}(), because that still
seems like the right thing to do, and the aforementioned commit makes no
explanation why it stopped using it.

Also, refactor some of the resume() error handling, because it's not
actually a good idea to re-disable clocks on failure.

Fixes: e882575efc77 ("spi: rockchip: Suspend and resume the bus during NOIRQ_SYSTEM_SLEEP_PM ops")
Cc: <stable@vger.kernel.org>
Reported-by: "Ondřej Jirman" <megi@xff.cz>
Closes: https://lore.kernel.org/lkml/20220621154218.sau54jeij4bunf56@core/
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/spi/spi-rockchip.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index e1ecd96c7858..f30af4316b8b 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -951,8 +951,11 @@ static int rockchip_spi_suspend(struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	clk_disable_unprepare(rs->spiclk);
-	clk_disable_unprepare(rs->apb_pclk);
+	ret = pm_runtime_force_suspend(dev);
+	if (ret < 0) {
+		spi_controller_resume(ctlr);
+		return ret;
+	}
 
 	pinctrl_pm_select_sleep_state(dev);
 
@@ -967,21 +970,11 @@ static int rockchip_spi_resume(struct device *dev)
 
 	pinctrl_pm_select_default_state(dev);
 
-	ret = clk_prepare_enable(rs->apb_pclk);
+	ret = pm_runtime_force_resume(dev);
 	if (ret < 0)
 		return ret;
 
-	ret = clk_prepare_enable(rs->spiclk);
-	if (ret < 0)
-		clk_disable_unprepare(rs->apb_pclk);
-
-	ret = spi_controller_resume(ctlr);
-	if (ret < 0) {
-		clk_disable_unprepare(rs->spiclk);
-		clk_disable_unprepare(rs->apb_pclk);
-	}
-
-	return 0;
+	return spi_controller_resume(ctlr);
 }
 #endif /* CONFIG_PM_SLEEP */
 
-- 
2.46.0.295.g3b9ea8a38a-goog


