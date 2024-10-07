Return-Path: <linux-kernel+bounces-353368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ADF992CF0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF940B22F6C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AB01D4354;
	Mon,  7 Oct 2024 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="y660Vn8T"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFD8320B
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307013; cv=none; b=deWswxoQMq0qlRBKYEyT7i5nZqLm6ZmowgG5y1qSSdP+zItSDqncyneTooqLSYCpTMeD7WfuDMpN3KcktEYhPb9+tvnMFpzuD0xsP39O2jAW+liwyMPhtw9OxSdwPXiJjlQvgKFlFE0JYgUo5cIhJtr5DHmgKHI21tSYD0Ss3yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307013; c=relaxed/simple;
	bh=OcYuo83U2iRwCpYhaFW8wDpfY57aiwrGoCMgI1DeJwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gfgx9i9ev0RcQ5zAe/jAeQuIsssey2Qv5i86NIwrGAlIGqxejaQLVwd1AXrDptkZsDXvZFcxjVDNdfKVSyFW5xgo6G9hVEYlT3qBXG679iPBworMvHUbb7px0zFD2v4tNyWnTLPyDwkEONHSWff4raoSSbti83Q+JGMyYf+Mv9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=y660Vn8T; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42ca6ba750eso27570845e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 06:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728307010; x=1728911810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2xJ2YFkWfoe18Mjx4VFZ0GmwDt9WkCYa7a9JNvVutAI=;
        b=y660Vn8TF1N8RN7VNvfYjsefWwuMFay3yXawBOTqUWFEx0Id6hTU12M2AJIOqzx/TO
         +4pzycIJTYb5ETYUhp+kRQGokwjcNO9f6XuN0J4NZPnuSTwLFAq1GTbUJ0dniyG/jENF
         w+LRvARU6OF+GgtxI1XGAglQK+Q57pbpmsM0UKD1rElspWWr/zk960ENodyUwcYkeoC3
         WW+qNuzn4WQ8JA/HpCmDBZekH/cxZCVVBI5f4optbo7zF21UBznwZa5aOJNnftCUKZvt
         w1giQ/9HzwdZIYRnULgxZDd1NV6shyTGZYH7EanvWg2JkkF9U3qLewhiwtOXwO7BxLTV
         wPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728307010; x=1728911810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2xJ2YFkWfoe18Mjx4VFZ0GmwDt9WkCYa7a9JNvVutAI=;
        b=DzihJXUOWffzUk5bUd+oDZ6e1J9zz7dQuJNWOWTUeeZ/gs+280z0oFu8pDp47E8lQM
         HIaK6nRD2HZE2ibUiR3SXcIMzEZzUetxrZjdQR2RojTVHthZtFviLABxJCNzTHiWRf8C
         ZSb/1TUplU2AVbPI3x13Z9QYY9P+VEZJySPOffobXfd+vVvPHAAWx5fR4g97MNWATkGe
         L0aOwBE00V9VPON5+659x+KbJjE8tLYRS8FjNRaOysVTAN3op7TiVacZtf2hfuPiChuQ
         Zinoyb50JUcKdYulTl+4uHxBo1K7KNO6/ilUqMN71oEiiZQg2LbTvZm6aIRJ4nSiRTAm
         rlzw==
X-Forwarded-Encrypted: i=1; AJvYcCVlSoZsTxsNF2zgYsTHY11SgyO9IUb/dbvcbQtbjCAWVKjqcUM3T0o3mV2h/VvWJqj0YcYEopAejxzhih0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwve1QeqCFATK5AnJmzeyS/ksF1jJL0UMBtsMfR+cws2ggm4Z3
	CcyPYn1GDQRvRZS6Q82eL1f2YN3+F/je/4GrbPEXk4kCXcmyP4aFYjst6ELkR7U=
X-Google-Smtp-Source: AGHT+IFCxIu22KVn102zI/v0p4tBA3WyzTx0G+ILqzEftEQiZFlR0gzu/jBnsdN6zjbqWia8kun3jQ==
X-Received: by 2002:a7b:c5c3:0:b0:426:64c1:8388 with SMTP id 5b1f17b1804b1-42f892fd471mr57225385e9.17.1728307009843;
        Mon, 07 Oct 2024 06:16:49 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6100:637:cbe9:f3bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b1d672sm92484155e9.28.2024.10.07.06.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:16:47 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] wifi: brcmfmac: of: use devm_clk_get_optional_enabled_with_rate()
Date: Mon,  7 Oct 2024 15:16:39 +0200
Message-ID: <20241007131639.98358-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Fold the separate clk_set_rate() call into the clock getter.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
index b90e23bb9366..ae98e371dbfd 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
@@ -116,12 +116,11 @@ int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		of_node_put(root);
 	}
 
-	clk = devm_clk_get_optional_enabled(dev, "lpo");
+	clk = devm_clk_get_optional_enabled_with_rate(dev, "lpo", 32768);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
 	brcmf_dbg(INFO, "%s LPO clock\n", clk ? "enable" : "no");
-	clk_set_rate(clk, 32768);
 
 	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
 		return 0;
-- 
2.43.0


