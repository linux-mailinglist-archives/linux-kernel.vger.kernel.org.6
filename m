Return-Path: <linux-kernel+bounces-429627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5559E2276
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0D62B31D41
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE331F4283;
	Tue,  3 Dec 2024 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ioZjjVtK"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5401CF8B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733235188; cv=none; b=hByjQDQzPyTJCiGilzuZeYoSqL+KR0JDCeDcaqR3sL9wTkFIVh8L92R6TP1ElNGfmwvIbKi80iFZ4pZYouW6aWV/ehLyH0jSU8CyifZBr/V+xtjm9LMDtSw14HIW2T4M3Dexx8kBJzqUy7r/CGPdL4sfdwQlCGOq56RJA1UOkWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733235188; c=relaxed/simple;
	bh=0bxsI4AI0INR0NHt3W9lttgxcRuou29i0QWVno7TzYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rshghc3nDK+YD8MUsJyWoJaLL7NAwLsjKLnYx63tBFXFVw863r9l4FYDPiohf4Cu33XPsyDX0nPGwh0b2GUmzj/hZwKdS/5LVNcsJ5ksJ+/CDdPxICONxhyl6CTEKrmSfinLsEU8iZ4Ey3LWXcC+YcbRQCQM1TPWwXuxt84LgJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ioZjjVtK; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso53321381fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 06:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733235184; x=1733839984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TRfctHU36B//m/17IuCPJ4O8WijMI9yeHi6VQvqDOh4=;
        b=ioZjjVtKXfgJ4lLOUluY+kKIM26dAJuZBpoxy4tQb8NdApDs36Sv4iDIPAkEZOEFAJ
         3oOau/dPnn2XK4VKL/lg2bGM7VBoqWFM4mktr5OKAOTNGxrS4pRP4MhcC22y0hJF+pBX
         gwdpNTcmv6nROzfisbjKg2NwuvSiTsOCEpvpIToRmd/fvfpJb/3are+3Bk8nBOEHBXyO
         l7UpjGJBYM3pjKweMWGK5LbxoeGWtQFrYR49D0ivmMRpCqxCdySOq15WlgZak4JB9IIm
         uM/PaS2HMqwNLDi7+rrMA2Dw4lUC3gDoSPjT5y1vYllzqZcDvNnThhs97NG1UbCnhMgU
         gWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733235184; x=1733839984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TRfctHU36B//m/17IuCPJ4O8WijMI9yeHi6VQvqDOh4=;
        b=uq8x6L89gW1lQm9bHGN0I4i4qYfa0FEjReeVBPgszxEyInQz5PkfFnFhu0kT3dlttM
         m5OzDuJxpu3K4UX1Uea7uJBFNkSwDnTyK8XC/wbS4nYcgfCRF+9pjDtkUkZzSZoNdB07
         0YwbjxM2g8jz1Kxqu8rKHdVa7XwovfI34cinjbr1+Fw1s0i6zbSe9Lb5gaP5oz2X05qb
         jgx/3mPFjCSYj5Fb3SGJ5r1d49ricDfn+xRjUHXR6VY276DXNBLofHL0Zqv3RIDozMgM
         fJqoGnk/LPw0mh7S/wTxWjiV1uhlkyFuMrEqz8Cy2mJoOpedhIpA8QQNH3HYUDzg0pmf
         d3FA==
X-Forwarded-Encrypted: i=1; AJvYcCUO5yJniOfGZZJ/X4Be83rx2a60UuD8V3P5WsQnXZ9udC6BJEeAJ8IQMTL9AP4XIlymty+2dQ96zmMfs30=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtBSuXfiIBr69dUM//zxllElmasR1/azJY4FxAtx0e7iAOaVAR
	SC2sHHPCVHp0RJQzIMi8DygvV5G68hDeg/coDwmpY1faW7smhHeWlwX3mjfL+Uc=
X-Gm-Gg: ASbGncvosscItM7KLXU0nfG16IQVsNo5u4MNnwzQyhIOV9tn1bxT5x3VbiipvNBH2Ik
	MiJvd/t7LqjsyXMVRGK1lpyE64NIdgx00QMfaR7DtIGbxJqCGCM2GnmSKtC4vDrQXVNvMgww/X1
	8x6BdWCiLZDC73me/ZWAeF73Hd5X/hI1LhxPEKmom2gJK1AWK1XLp7WRbBxo2xQwSHCob4YPGBD
	v7nyqdKiC+QtVeFvvq4xTYBbRCcWwhRqVeImiH9ocELgAtQ1hLSJrJIBGP7oIkH2kMVXDvvHr5s
	g3tiB7J2/bmgeQ==
X-Google-Smtp-Source: AGHT+IGYkErt1vzCnl/QEMxSdD5HS1d3h+rMe7TWGlIe+ZMd9qjpsDjoipmrdzvNvya4uf+aC0BgJg==
X-Received: by 2002:a05:6512:81:b0:53e:12c3:a29 with SMTP id 2adb3069b0e04-53e12c30a8fmr899530e87.19.1733235183565;
        Tue, 03 Dec 2024 06:13:03 -0800 (PST)
Received: from brgl-uxlite.home (217.97.33.231.ipv4.supernova.orange.pl. [217.97.33.231])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6431229sm1860857e87.7.2024.12.03.06.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:13:03 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFT PATCH] Revert "power: sequencing: request the WLAN enable GPIO as-is"
Date: Tue,  3 Dec 2024 15:12:51 +0100
Message-ID: <20241203141251.11735-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This reverts commit a9aaf1ff88a8cb99a1335c9eb76de637f0cf8c10.

With the changes recently merged into the PCI/pwrctrl/ we now have
correct ordering between the pwrseq provider and the PCI-pwrctrl
consumers. With that, the pwrseq WCN driver no longer needs to leave the
GPIO state as-is and we can remove the workaround.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index 682a9beac69eb..bb8c47280b7bc 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -379,7 +379,7 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
 				     "Failed to get the Bluetooth enable GPIO\n");
 
 	ctx->wlan_gpio = devm_gpiod_get_optional(dev, "wlan-enable",
-						 GPIOD_ASIS);
+						 GPIOD_OUT_LOW);
 	if (IS_ERR(ctx->wlan_gpio))
 		return dev_err_probe(dev, PTR_ERR(ctx->wlan_gpio),
 				     "Failed to get the WLAN enable GPIO\n");
-- 
2.30.2


