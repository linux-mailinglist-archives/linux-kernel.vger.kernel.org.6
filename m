Return-Path: <linux-kernel+bounces-253635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90564932422
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33F71C209BB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F721199396;
	Tue, 16 Jul 2024 10:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="BlLLwGcN"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FEB19A867
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 10:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721125858; cv=none; b=h+d0ntEGIiQuN0pwpJzECCA/4ZdaUwH3FkYO62zdwCtJtUean+HL89X+7fLqxod+z5FKjtJmBwNaV6iGPdmdAPkJzrs7Rx1GNIjk0B7IeZaguYtnF4GyfKQSBxCiMVKQs5JJsNN4YpJSGDRxZYbBfwpGv5TBq3O0e1nNoNMdOe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721125858; c=relaxed/simple;
	bh=JipNE+kqEQPBn7Jx4UqjRRUM4WXbboTrnyw0mDx93KA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WYtTceoiyIvwrYU+Tvh5mcz76FeAQPZSUmrmjCQvrHjUaAZ71DZBpQuHpWquhhaX3hkt6BDiMSmx4DEWc+CnMz0JJSsfOJkT2ZG12uNXz6HYRdQI9hhkgIwzE4ibHF+6fQ0Xzh961f/lhzqT4P24tjB8xCINEI39egBrpYxBZJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=BlLLwGcN; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52e9f863c46so5824506e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 03:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1721125854; x=1721730654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAXdKc5Z+02xSdGxMpcMXF7UJmX+WtkbTbyJ/hK50W0=;
        b=BlLLwGcN5mUmW7Fw/0UW6QIyETSGj7d8hXPmhMifppK3O4TM/M+3EpH4Y77Z91LIdG
         +QKUxlUrAU1YA41ly59IxsHMDk7eP90M+7f69/ecHBwsB6Aqz0N9jeGCcx139e7BY+vK
         CFV6zL3sUklGCCH2yqsmLI03eMQnthm68cm0vKDc8n5/X8yiQ017VilaZ84Ahuh/whCk
         lmuaCVmj3xW2dxeEBe4DZ1609eaQij4OkDnbuXC03PqtIfFpZunUDlG3AQaScWe0kAJp
         8XRUxU5xSZMA9SLEfRnf2g6fhQ/SDo3En9Vsftai6OcnphvLeGwg9TmRF77lQIiCphEY
         TtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721125854; x=1721730654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAXdKc5Z+02xSdGxMpcMXF7UJmX+WtkbTbyJ/hK50W0=;
        b=O6vp/JbVnRS3TI2JmQXpffd/B256+4WEULMl333yRSwcGIbx9mTXWewFe9zLULCuQs
         LE/UbknyfyR5gHOhyPGRFyRS9Sm2D3wC0zQc5Jn2axL0W8XBMh2tLs1tUM0ZJ9mY3VrB
         EDuTgWVzVMY+kIlJr0p5QuAJ0XEFyswhYtoG2O1ubGcbzc+yryBo7YV4VSvOTvDZ0P6X
         Q/s3BzmJwhVE80ZSRzKNo0NGUaW7cupXlCo5tiiFT5fOolzDO2z9kzLrJ38its0pIg12
         6i5X9uoMrc4XLX5dlAVurjvKr0KnWhEvwWKiIqxYrtgp1wSRgcFsAoWmkmkR7hyF20h4
         WxfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0zZe8Th+0CHjpGpQswrg0AvzkM30hI8M7AWaZ/iCntytLIZIAuQmJKxJjvST5129l+5huw6eY8p6iE3vTcJSvaE6/zLYrfbB2LqKa
X-Gm-Message-State: AOJu0YzRZEDjkdJ9Wh3e/HReikODiIlUjUneks0Pn/3wb5Bi4qT4MZy2
	R1+Iq0zP7aNu2uyLoxdiabvg7xGdGGgcMT87G8RAVDYn/uItNtyicWy6RH5V3Tg=
X-Google-Smtp-Source: AGHT+IFbkiHtNVlSjCVJf3cVxZfgoUXWPkU+uRJ0BzsW0f977HEVh4lCus0KUh+9d9jKXgqmMYtbgA==
X-Received: by 2002:a05:6512:3c8c:b0:52b:c025:859a with SMTP id 2adb3069b0e04-52edef1cc52mr1084908e87.2.1721125853907;
        Tue, 16 Jul 2024 03:30:53 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e77488sm121546145e9.9.2024.07.16.03.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 03:30:53 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: lee@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alexandre.belloni@bootlin.com,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 11/11] arm64: defconfig: Enable Renesas RTCA-3 flag
Date: Tue, 16 Jul 2024 13:30:25 +0300
Message-Id: <20240716103025.1198495-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240716103025.1198495-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240716103025.1198495-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Enable Renesas RTCA-3 flag for the Renesas RZ/G3S SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f35fd006bbbc..e90578659447 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1213,6 +1213,7 @@ CONFIG_RTC_DRV_IMX_SC=m
 CONFIG_RTC_DRV_MT6397=m
 CONFIG_RTC_DRV_XGENE=y
 CONFIG_RTC_DRV_TI_K3=m
+CONFIG_RTC_DRV_RENESAS_RTCA3=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_BCM2835=y
 CONFIG_DMA_SUN6I=m
-- 
2.39.2


