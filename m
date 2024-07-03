Return-Path: <linux-kernel+bounces-239232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B24C1925833
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3DFF1C216B7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2989E158853;
	Wed,  3 Jul 2024 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ABEd6ojx"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A56173347
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001786; cv=none; b=aFItJI4ilJNKx0vL+XSjVffmGVSq96hr2mOjENwsIEMizBsbz+eC/vLSXttFum1G3B3HJRWMIu9/C79dJ6CjiUN0JJsyJqKbsV9jXckPlL8xBtR04cXQDpPRmhuQ6yhvaH1jMil2SzmDXC2dflAn5tuCtpVomvdg0ZwyN96FdRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001786; c=relaxed/simple;
	bh=Ya6oXVz+9PSgSZgNYuY4CHXoSmhTuQFovgLfaTWUMXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bGiFhApQGhFRG8Y+8MfEb3FIGE5SkF3vmhtFsOXYLdwqQgm3joF6lVRmtEno6Tk8wbgv2E1mOo0BEGqelsBuyVzqqw/I+XR0BCkFWK34bdJkcYLYLC1KMBDHGk4yCd48a7FY9oW849cEH4JTHX0RZAvvHZi22VlAtUGkUJT5fc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ABEd6ojx; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a72459d8d6aso537489066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 03:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720001783; x=1720606583; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWGT3G4dbfhnZE1xyRO5OpmfX9c0autS1uaNaBcB/Mc=;
        b=ABEd6ojxnGq1t5if32foTlCyG/EmlWyyx++Safo1mr7aGbSsUr3QZbYa92/A2ZmZeg
         eo8nlPvBIJT3rRLcXUZpWhIQLvf39mB+v95I7o+lFfzDSygke968UsaTYflTGgWAklBd
         BLaHNyD+FPMPA+I9Jblp4fSumweCh0PNMFKMxSN/DE6XIOkPOn2egtJ6qfOw6TGO8iSW
         lV+qLz9rtZZAI4hsuST7vrvSM/9gLwWJUq57E4H6ktpFVSf40MRirRFkOgGv1Wm4niQN
         DYzHIC9DMtnMRsr7kMXhI9LV3CDrXKHSqx3Ia1MvB+vDdALiuHSnG46sKl2p+u8xEKvK
         w/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720001783; x=1720606583;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWGT3G4dbfhnZE1xyRO5OpmfX9c0autS1uaNaBcB/Mc=;
        b=kjdNTS5ZBXveJ5+35AAjLLXpnjrchi78We9R8WXpD01g2Epf74Nu0cCHUtlionuCs0
         O1K6jBfPc/9G3Holh4Wd1wJX1TrD243EJFNOK6Y5ajubpD037A+FdyOsx28OUA6p8dck
         88/5ZXQXQtaWo7YbXHnoFHvlxH44kC8tnN4AIb/6r8SSRGoiLtLGTDMJYNhfVdSX7oFF
         nMuIySRP1XNzwerAxf1AZEvAVz98u70jN64GynYhA+HBLtkoIRmRKr8k5avLUjdH814s
         YbOCWDffo2PKIbUVSVWf3DqB4HAGBFGJmflYIbSq+pfnDkn6cvUiwtSQ35XptOmMlEqC
         FMSg==
X-Forwarded-Encrypted: i=1; AJvYcCUmcSB8JP5Y7ognEsbQYUmxUkTct+FxaPJhvUtmnZGJlHmt7ms4PJB2CNxFuMfE9Sq2nRRn1zrkFtUlOLYiBbOxkMWHDSNW4PwdPf9C
X-Gm-Message-State: AOJu0Yz/m0LmLgyP6V6XYEsxizc5LiKW/UP9HA60BJIBZzhuoOU2gO9D
	h9q5D79XUz/+ePaiTubJwGGCSwkamnmNJB26mPVSb3I8o6crk28eCyQJ+th6v3pdSRAnh3DqApI
	/d+E=
X-Google-Smtp-Source: AGHT+IHeLDjC6kF6SJTtMZmIDChVrcMjHv7cKLOslnjJZSeDu4JK3THQHeWo35I65yYU6QzYBGe/2g==
X-Received: by 2002:a17:906:d78a:b0:a72:797f:cf6b with SMTP id a640c23a62f3a-a751441a667mr684555566b.14.1720001783179;
        Wed, 03 Jul 2024 03:16:23 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab06565csm494291466b.103.2024.07.03.03.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 03:16:22 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 03 Jul 2024 12:16:01 +0200
Subject: [PATCH 9/9] soundwire: debugfs: simplify with cleanup.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-soundwire-cleanup-h-v1-9-24fa0dbb948f@linaro.org>
References: <20240703-soundwire-cleanup-h-v1-0-24fa0dbb948f@linaro.org>
In-Reply-To: <20240703-soundwire-cleanup-h-v1-0-24fa0dbb948f@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Sanyog Kale <sanyog.r.kale@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1466;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Ya6oXVz+9PSgSZgNYuY4CHXoSmhTuQFovgLfaTWUMXo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmhSTppdI1vWEUj6KaRTVA6Zs6vstWpcqLtIv+K
 waN3oowU8eJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZoUk6QAKCRDBN2bmhouD
 1zl7D/wMjbC9AmoPa2axlSVFNvUY7r8vuhRS+DbdDe8mpxB8IgQ0rJLwE79UYI6y2V+XB1M/OUr
 pnpEjT8oO1ReWJZ7Vsjj4afpKFwsE7rVsA1vaY5u2WQ/BH6ffgbqTLnywnI21WzG3sYV+/2WUoR
 uqOFoBoKwJqpP/J/lHojAT3lzh3sYmONwr566zGBEwdZ1C2YFYdxFOShtYoMPMNuURyykRGZqBo
 AMof/wpz5ye4HhCObCYiLgWzf8WpN20aEWB3Uu7UOBSkZEh9Ulv2uSmI7Mpz1QUvZbJi7g8jclU
 NChJjptEkFASqpAR9Yn+tB5jTjLVI3/WGRwjQz7kpdzjZgLpGRillyKU2tW22cowqWjJa3m2Ms0
 Ko7JZSxhpB4nM1uToQq4mAA1wBLeekdT++gZHXbysR1hhlo/RlvMaIyA0NuC6sSVXI2alJRACCZ
 4PablAUl2DVblPVLf87ps+coOxUZxvTwnOys1tGN2SpR2ezfB8U7AdZZw/OPFeoTH0Er8tsSne/
 qvPYHgo3Ik/5cHU4OPozojj08uYxsh/xLgB8p4zPNqjgxt6GemeS95mJalFykAgOI6Ln+Xn2VYH
 M+Nt0CLbW5HwF3zwMFn7TP6+lGun/GtytwDffA6VKIpcsqdfQXle0rWej35Jbv+t/TRV4vPP49Z
 cyYnyniEZZzVm0A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Allocate the memory with scoped/cleanup.h to reduce error handling and
make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soundwire/debugfs.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
index 6d253d69871d..c30f571934ee 100644
--- a/drivers/soundwire/debugfs.c
+++ b/drivers/soundwire/debugfs.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // Copyright(c) 2017-2019 Intel Corporation.
 
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/debugfs.h>
 #include <linux/firmware.h>
@@ -49,18 +50,16 @@ static ssize_t sdw_sprintf(struct sdw_slave *slave,
 static int sdw_slave_reg_show(struct seq_file *s_file, void *data)
 {
 	struct sdw_slave *slave = s_file->private;
-	char *buf;
 	ssize_t ret;
 	int i, j;
 
-	buf = kzalloc(RD_BUF, GFP_KERNEL);
+	char *buf __free(kfree) = kzalloc(RD_BUF, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
 	ret = pm_runtime_get_sync(&slave->dev);
 	if (ret < 0 && ret != -EACCES) {
 		pm_runtime_put_noidle(&slave->dev);
-		kfree(buf);
 		return ret;
 	}
 
@@ -132,8 +131,6 @@ static int sdw_slave_reg_show(struct seq_file *s_file, void *data)
 	pm_runtime_mark_last_busy(&slave->dev);
 	pm_runtime_put(&slave->dev);
 
-	kfree(buf);
-
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(sdw_slave_reg);

-- 
2.43.0


