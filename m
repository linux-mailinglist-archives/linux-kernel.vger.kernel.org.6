Return-Path: <linux-kernel+bounces-279246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1AE94BAE7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C301F23168
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E57418A926;
	Thu,  8 Aug 2024 10:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JpqZwvxn"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A108618A6A8
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 10:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723112886; cv=none; b=aa2bOFWG+4yz9dH3zkNMdYW57Cg0WF62fYiaCp061Z55t+V7qLqC1bfwkpPhzrjLK08MhrKheXbyw7tKcEmd8thnBf3QqTeKA2QikFJFnkpGEcOaJidhXkxtgC2MZPchYBbJ9V+8119V2DijBJheFS083h8Kf3XRrx0NvK/zd4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723112886; c=relaxed/simple;
	bh=NerWYmC0Zj/71XZg9G0jYL5bD9JcYGXHp2BwBzjd9Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCDctuK9pDv4iBsltbTL1dmui3wQhA6oTL6XUxrvTWngqUYeEvA3QdzoU6CjtoVj+OZ/FBe7o5LNTL8vxPvpCgSKSFO8KQRa+ErfTx2QWzNDCvY61pid5mZzV5ibk18h5eIq90x+3c8q13VbblH47zbgDQQS/wyPHwa0er4ZHIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JpqZwvxn; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-428ec6c190eso5824935e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 03:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723112883; x=1723717683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLs1XU+vYdzxst2Jx1X+lCyMt00FFZC6iTK2ta7VGO4=;
        b=JpqZwvxntCdAb0zqi2i0MXVu0XNzZHFscfImLAM7wN2Uh1+PYECpJEOAqRbY+Rpz61
         oarJFArD8nqOxQc/Cc6L6a0ctDoBE6hUrLuHUz3pYUZ1Bba3ffSR9aybOj53Yaph0kl8
         2KPg45ktyiXU74ZwxbcCifLiEiKjN50nuZR38f3mJGRWNqNjU6zPSIaOk8WCTb7JqWeJ
         qnDjoWrdeCOSsVB0LFyGDz4Hu8NlARh3GcyWKmx1+9H2a34mUy2nbVzFaB0z2ncV75hr
         62U8jtcCWuDUhAuWhynWRaepfOMCfdFyWErv9r0YTmpyv6wm1LwuSMxS9UNnepOi+/Vg
         iybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723112883; x=1723717683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLs1XU+vYdzxst2Jx1X+lCyMt00FFZC6iTK2ta7VGO4=;
        b=dQXoJyDs3u8q7Z+06YFfJpIauKtHo75ItA7mUboymoDVknPsy+d+XvekJMr1RMUmX0
         jPij2xbT8SXP4hMw2BKGsryIkwnzm4gMqOgcoeQhTLVVYsPNWsDmL8dWPF32lMBUKWv/
         0t+bat6MOeaqiZa3mMJihL+dLdjrimkqvhywqxryUCq4iLBr9yy9TXrJRtmyqoJ3PfVB
         2c0T3bv4LJ0yj/Fvaiai+Gd5NeFPxTa1TjtPNEsCWs1wTiRoXMNwqKTZjHL2YOdmrFEf
         xtEvBxgtUNIM3EquKutHPSolksyuprOxo0fP0Uwp0mJxcIr2G5Tuieq3tQai/14+xLPp
         IMZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+7hK7iQXamiXIEsOEj4zObpfYoT5xLuKEveS1ix/GijCmYVBva2B4WGUDjI+IeCeqBzTl4vTXCrdlQrADVywwrzao6iDL1DHfqDV2
X-Gm-Message-State: AOJu0Ywwf5fz3obpJn+dA/9ablvGOd6bH4qnd6hwXbch4rvZsgYNeSpg
	dttutPWZZSOADJNUBnOTn3JgRkM050CdXlY18FrTW15mkaq7VCOvzeSyrBke0Qk=
X-Google-Smtp-Source: AGHT+IH4wfvzwM4fkXArLZT1sNL9MljhNrH8VOMDF+lOosNHTQhMGAQbXMHkxibOYzjGWqC9kpdcsQ==
X-Received: by 2002:adf:e6c1:0:b0:368:72c6:99c3 with SMTP id ffacd0b85a97d-36d2754b2abmr858636f8f.14.1723112882782;
        Thu, 08 Aug 2024 03:28:02 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:ae7:4e79:8821:15db])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-36d27208c98sm1454596f8f.75.2024.08.08.03.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 03:28:02 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v3 2/9] reset: amlogic: use generic data matching function
Date: Thu,  8 Aug 2024 12:27:32 +0200
Message-ID: <20240808102742.4095904-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240808102742.4095904-1-jbrunet@baylibre.com>
References: <20240808102742.4095904-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

There is no need to use the DT specific function to get
matching data, use the generic one instead

Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/reset-meson.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index b47431a21b86..820905779acd 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -128,7 +128,7 @@ static int meson_reset_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	data->param = of_device_get_match_data(dev);
+	data->param = device_get_match_data(dev);
 	if (!data->param)
 		return -ENODEV;
 
-- 
2.43.0


