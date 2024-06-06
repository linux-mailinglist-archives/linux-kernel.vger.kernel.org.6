Return-Path: <linux-kernel+bounces-204450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A45D18FEF5B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1198BB241BC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADFD197A68;
	Thu,  6 Jun 2024 14:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qsrVF80r"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653D9196D99
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683870; cv=none; b=dEddIgPOlmk+itfImaDo1k+dp+EHMtTOlUm7lhwJ5rqevxQUlKoLr5SXkowdIHTrwPfAOBA7uNXml61z+tkEHR81vwVp3U3txFJLfZmHgZPTrm/sgYxUZsuEI+siEv0ZqWCZI7Au4FoHS0l/4Ua4IwnLNsV1YnfLeHpKvJa876U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683870; c=relaxed/simple;
	bh=dxFGGhzrS7LrLExlJB0Xcypo/XjMKtA9vb1gGePZ7dE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=keyjKQy/75O1GnydUC7KM1qoYyoQZgDtXMgsYk3UZFpXD8Vtk6E+cWd2U5869Hjfrsh2nalK4I2bSDXRxI+r5ZFrFYrzpnIAq1esovsXIIf2IMmbJGHVVXcHQ8x9ikEiTK3wBquOQhEU5Hm6rVJHyyAuaP+s6VokNyHn/kaX650=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qsrVF80r; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52962423ed8so1258431e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 07:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717683868; x=1718288668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s0R2FTqs9h57UOEpdGtqZQ+WmWHV210ccwRY3/zwf0g=;
        b=qsrVF80rCPEFZznlSUlCbhZn1Z4VCAEV8jySdl9wNaHolJRwkEDIP7wIV0XjE9YIS+
         CgQcTr6C+e60KKYRypTvWdqhEBO/0cwuOZg9OkeyjD9mao4wTyTVxZk2j+MBhA/YHoI3
         bVEBpr6JfjNXED57BcQwiGLqAZXd7f2Yzv+R0YO0giATtA8//AVpuODKaL3ksgd1Lc9Y
         gu0Zbsf/liwc/kozAycb/HPT0d9xu4ZC2w6mMAW4rZPg+hr3tP8c7C3tSg8q9vKMHPX9
         J5BcmLTuEKXcLAZsu6pOL9m2Plw5QT80cknHl1xtcOSIhVyqqrd8MdW/JetSv+QmhK4j
         QFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717683868; x=1718288668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0R2FTqs9h57UOEpdGtqZQ+WmWHV210ccwRY3/zwf0g=;
        b=C0CclNJg8Z//IamW5y/vaGcTQioHgJqNJi4I4Za/rdfQJm7WqWxqq3FDEOo4DgidBG
         R+Gg6PaxsqvEbEVfffIzGUL11OEK4PsZS6Hij/C+4mRWgEEQ+PB4S2LDIQ+P11jmcHJH
         h5RQ/aS1zBUbmRPaXxp6RnQTcI8C4lAd196ZxmVNmU1wNQ0nSw2pnf15yUN4lvgkRQeC
         +/7dOGg50Ra5cqDAGaLCUlKS4PutUU7G1Roz/zmY/QXraqO4NG015RrKD7G4DwHpQ23/
         ITcXzOXuNOq1YPa3ul/30u4uNvw0l+9VvZKhUxe+dzlUtgfoHoPoaL4p8bKkiTQ6BET3
         t3tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwOBTSPKiuVsgsunHakBpSmiyo8oW+LUeMCzrbBXFnLbOXDogpbRpo6yEiC/Hxy52HsDz+Ozc9m4gS7FyYgn4zWIHa61iJqyv7Dc3w
X-Gm-Message-State: AOJu0YwS7nl+bqG0h3wS6YVVWpR4DYfg+qFe/TEMCJd44AoqRasRQceV
	i0me1Sv+WLwDeGITu7/US+Icpaiwg0ojC9uAyEw7Owdcj2m4/D4Ecnub8pJPcfQ=
X-Google-Smtp-Source: AGHT+IF2Y2cO7geMFPXXxqbIXWUwXl2dSb3X6DXNOt4MeEsT3SiqSkUR2bYkClLkKDNyX3YkIQLemA==
X-Received: by 2002:ac2:4906:0:b0:52b:79a5:517a with SMTP id 2adb3069b0e04-52bab4e5283mr3281219e87.33.1717683867645;
        Thu, 06 Jun 2024 07:24:27 -0700 (PDT)
Received: from krzk-bin.. ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb423ceeasm211659e87.185.2024.06.06.07.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:24:27 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Thomas Kopp <thomas.kopp@microchip.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next 1/3] can: hi311x: simplify with spi_get_device_match_data()
Date: Thu,  6 Jun 2024 16:24:22 +0200
Message-ID: <20240606142424.129709-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use spi_get_device_match_data() helper to simplify a bit the driver.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/can/spi/hi311x.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index e1b8533a602e..5d2c80f05611 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -830,7 +830,6 @@ static int hi3110_can_probe(struct spi_device *spi)
 	struct device *dev = &spi->dev;
 	struct net_device *net;
 	struct hi3110_priv *priv;
-	const void *match;
 	struct clk *clk;
 	u32 freq;
 	int ret;
@@ -874,11 +873,7 @@ static int hi3110_can_probe(struct spi_device *spi)
 		CAN_CTRLMODE_LISTENONLY |
 		CAN_CTRLMODE_BERR_REPORTING;
 
-	match = device_get_match_data(dev);
-	if (match)
-		priv->model = (enum hi3110_model)(uintptr_t)match;
-	else
-		priv->model = spi_get_device_id(spi)->driver_data;
+	priv->model = (enum hi3110_model)spi_get_device_match_data(spi);
 	priv->net = net;
 	priv->clk = clk;
 
-- 
2.43.0


