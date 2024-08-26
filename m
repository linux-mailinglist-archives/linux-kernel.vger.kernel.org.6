Return-Path: <linux-kernel+bounces-300769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0571495E819
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 07:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F74281892
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 05:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1837F484;
	Mon, 26 Aug 2024 05:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lq0lJSvk"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859FC443D
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 05:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724651388; cv=none; b=qEb7cQf8GAQCXZe6v7YdOm7mGteZy8zrBFmhDkAcvpnIXZJoXQaHGvKnJyFNSFKjYwy72lo8wTlUYgOD5uFMp0S5THRL646AiNW2DGRo1JOH405HYChHx2z4DJ+OA4WS5lcluntEVdOAdkNYezaHc6epiMJbRWboudE1d6GqdOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724651388; c=relaxed/simple;
	bh=lxJPMcSQgzH6IWaICm8CbsLqpI8iVhJSZfoU/F0D6rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewKIFVwooGD1X83JTcA9ilKKQXRmnzr1ZoWQ6nj6k7P8vDFizzXbK0VSln8NWYISGHZ12jfa1s1Q/t5RuWmfTwzbESsZPjRtgWqUqGWbe7khapCWSjp8UIua9yUrxCQsoFm7CLVVGtKpLEhYBGXEfgr8Gt9TYXhaa+S3DPoRviY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lq0lJSvk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42803adb420so4831435e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 22:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724651385; x=1725256185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MR544WKpOrPO2hZEA827PkxB0Gw4Fd6mIICwFvWkUJc=;
        b=Lq0lJSvkVfddV6sMpoKoGivFTLexiKDUF7I35XK4nn3seUQiHy01IFt4vkZGhoTGHT
         kkb0my0OP4iYd6feSjObwUELDdpxojqI6jyHzvOmF6uZyxcqcfHUm62ig8c1h4IuiZvI
         IFi+JEis8PIldQ95N4LVaZv/8WrCFQplrgC2O+5cjGE43nGMIdsup/SL/KEID9XD+fYl
         fs2kuyKR6E4ubsxj3Vp3ADpRABwXwDk8UfawDIUvdBqqABbilcCk+bGxW2kA7gkhmHUK
         obIEYgCuviELAf1fVXEUE7czvYBF6gufNgvqU9uEboiEN6TL8cdQAP0Lj7DjYIARiMyK
         7UiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724651385; x=1725256185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MR544WKpOrPO2hZEA827PkxB0Gw4Fd6mIICwFvWkUJc=;
        b=HqVkU/+HELG0EY6izUOQCaYwYsDB061/wvBUaOQW5s95IxPUwfRaULTaemS2eczcVo
         gT7AgawUSygi+jvT2hFFyKyB0ltneO48d3uKYER7UuW3eHKIIr9g9MlPNfp3TWC+n4YU
         UVYGoRg61Ap6Syirn5Hz5D867Czn8PNuCRiXTeuE/jzD/8MoP3SJlGU6FDABfwqdZS+0
         F6gO37i25JHPrXry+uMGkq2EJ4hMoLBXFyr+VO1QIw5x0MlUsao/DgLaOIHySX3IxU18
         R0DHOSVCpiV6A6IjcrIRgGQ8uaH3Yur6wWHz61AJaQR88G0DmQobUEbBuJoXDk2OZ1ld
         JLHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0P3IcquKiqU+9C7hREZT+ppZWHR9jhv0OZDh/yHsmovxQmMqjhgvrKSOdb2A7wX6MixrCpC7vSV0SJ8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQXO9QZ2TnYmnlUIzACJzOR86B0B3Z0VPFpl1+Y9qsEIssJYYJ
	nR6X3Z6EtOSGol1upYfMQeioaREVtjkRZ8UvYwTo+jjsQWAKe7rgjqFC/mZdVrs=
X-Google-Smtp-Source: AGHT+IEecqCwvbndqp+gcmElYdt1+EyzERIKZxtyAUJ5mLigfVv6d+/9h3V0MQ7J7rvWLhlJWRf9+Q==
X-Received: by 2002:a05:600c:1c1f:b0:427:9f71:16ba with SMTP id 5b1f17b1804b1-42acca112admr37662125e9.5.1724651384702;
        Sun, 25 Aug 2024 22:49:44 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abee8d1c9sm177632025e9.23.2024.08.25.22.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 22:49:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] bus: integrator-lm: fix OF node leak in probe()
Date: Mon, 26 Aug 2024 07:49:34 +0200
Message-ID: <20240826054934.10724-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240826054934.10724-1-krzysztof.kozlowski@linaro.org>
References: <20240826054934.10724-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver code is leaking OF node reference from of_find_matching_node() in
probe().

Fixes: ccea5e8a5918 ("bus: Add driver for Integrator/AP logic modules")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/bus/arm-integrator-lm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/arm-integrator-lm.c b/drivers/bus/arm-integrator-lm.c
index b715c8ab36e8..a65c79b08804 100644
--- a/drivers/bus/arm-integrator-lm.c
+++ b/drivers/bus/arm-integrator-lm.c
@@ -85,6 +85,7 @@ static int integrator_ap_lm_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 	map = syscon_node_to_regmap(syscon);
+	of_node_put(syscon);
 	if (IS_ERR(map)) {
 		dev_err(dev,
 			"could not find Integrator/AP system controller\n");
-- 
2.43.0


