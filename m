Return-Path: <linux-kernel+bounces-300514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3CD95E4A5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 20:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9F61C20950
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 18:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A5015B562;
	Sun, 25 Aug 2024 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M8b9ytw3"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1F68C07
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724609152; cv=none; b=U51zRihlr0nEVKA8iiJQyjOCzK64/gXNbnqG7jO8yDA+Dpe0f+Q219a+YHw8gymS9Va2RFLf6WVpa18LKMJm51LI7AhzJEHCIATpKa0E6+iFaEKIywEs5RQY3mdeGqY6qsAwGQ4WOx4cuL2PZA/ruTxCuBk3V/a73kQ1KsBFx0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724609152; c=relaxed/simple;
	bh=LJWD5cjLfcvI40Ci+Z5t/UhfXs3V4IqTFTPAUwn80lA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=f2gXZiiTBxYRRNwdPaotRf5elfOL4SlcPUO1PXpE2GRJHD98UZ1jqg+PcHl6rdwEAWaxZKsG38kSkeMp/RQRyQU+4sI+3owP5JxkKQdEEdgZOHRZEQaPkiwvk4jr6Vp0AJRMmNrPQr+B8M8qEmNXvxTrLh4zwuJvfytzKflTMzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M8b9ytw3; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-371a939dab9so511191f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 11:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724609150; x=1725213950; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JydotQLE8NcEmGdi6bR2mk1j+jVATNkPy6mshwtvk+M=;
        b=M8b9ytw3ZbEQlfxzcJM5F/ARpgNE05jc7cBAn6eEu0qnqJ8ahZW8CpzTU6kMECw0pp
         qym4yYQzaurHya6eI/2P9/aY+TCxwpu7IxIxbFIgYuvcD9nT9J+AoxWMpZn5udy1AJUg
         Av6pf+FjUDJsTf32CIj6gBLQ9tvN7kwz8Ah2f0MIbc6KdneKYQFYm8x+chdgbGabF8Il
         /+fDtYrskr2bEYz/AOoza5rE/uSJMjSdenwLqd9ynEMlofgmBVrCNQ/OcX2ArBNUYSio
         HcBeL6s/q8wa8FnTNZwPnblke2eff3baCOQd2CDx1rFKW5rMOqOhNvgm14Zvn0kj6Cgp
         EZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724609150; x=1725213950;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JydotQLE8NcEmGdi6bR2mk1j+jVATNkPy6mshwtvk+M=;
        b=UUJMHTzb0JznLoerGYk8VrLJDzAZFHAhGESLcvxMEf8WgbZ5kQYrWrUNoJZwBRnbDR
         chp3VDqgyExCaVLBWPPw2E4jxA5RMt5vv605k5c4d/t2juTRJR84is0gIuFFswufJ2QB
         aJAIFPy6+E+jq4zExCXEiEamdEDaujvcbzcTRtsRC+sT3R1VR0713XQeCgBjWVK1VjK9
         wNFMm6TQK3dZ5penvNx4jOp0Fz951NN2feFKAHFeNfqM5jzOTxL4Z3NyeCb6lYiEiH2u
         EGGkZVvQerit0OB1u5IEWHHCQTQlb7x408i3vaDsSxfH53Z7Sks0ctf63sXzKcZAioxS
         A7gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg1h2VLK1r87WC8cEqhmasoj/uuu4umd6yLOXEz6yl+mcZ5CiU+4cPgjjF+VOlCAADTromEp5MKp6zdwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzso6wfIOExRq+P5+Ljl7uf8cWlkWLfSzLjfnolE+LmKwpbb73c
	LM81dADdRtQiwQPFUaIdylbeK4QorSDc3gqymEiLbQyZLQjwLO7gLDNoyb+7egQ=
X-Google-Smtp-Source: AGHT+IHdpS7K2bNJA2sKTBWBRGd1lUhDyRx7b7buaWzFAqTspCw0ycRlWL48DMa129b1eaCLq+UiVw==
X-Received: by 2002:a5d:5f48:0:b0:35f:2584:76e9 with SMTP id ffacd0b85a97d-37311852317mr3445728f8f.2.1724609149547;
        Sun, 25 Aug 2024 11:05:49 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37311dca113sm6438736f8f.16.2024.08.25.11.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 11:05:48 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/4] soc: versatile: fixes and compile test
Date: Sun, 25 Aug 2024 20:05:21 +0200
Message-Id: <20240825-soc-dev-fixes-v1-0-ff4b35abed83@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGFyy2YC/x3LQQ5AMBBG4avIrE1SRZSriAX1YzYlnUQkjbtrL
 L+8vESKKFAaikQRt6icIaMqC/LHHHawrNlkjW2Msy3r6XnFzZs8UIY3zvULXN31lJ8r4g95Gaf
 3/QAnzoXjXwAAAA==
To: Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=874;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=LJWD5cjLfcvI40Ci+Z5t/UhfXs3V4IqTFTPAUwn80lA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmy3J1y1cAVfrpP2ehO5uXANH0zwCds6NAmKP8d
 8G2tNliVJSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZstydQAKCRDBN2bmhouD
 13+0D/4qW/balWzJ4RewENfM1PpseBCi1Aqc7MrPSRFFV7ixcBm42pxUyXL+R854LBZOkHmzEUr
 jegiIj5tPnqhze97XEjM/35mx55ZZ0v+/VksJh0mxJ6ME2birpFKkpv5hFXLINpRDSPOEBGPfG2
 VVBA9t2nN0gbcRVQ/3v4lFbOIW46RG62xPnHCRweFBDOU8Bopg/XIuXDj/00pALgD6ABTiA7vIQ
 iMMKMrieAyXPsIsGY4PTeMhGbnj0LT1EEift8eXig6hqw55ytqJFWtHJC6NmY+XR4hw1hP3vqXm
 mFoYVkvmO8c6DlJWa0YAHll9+Awhfnx48bDGlWEujuVzHHDLkq2C0Mm2kSgZ1WanFaD9RpX++l+
 BuFg8Hqzva/Kpa08F6bJHpX9MtIPS6KM2W2pFhTV/7qQxvlnE6dupgxEF3iG2krds2UL1aLgREW
 kD4U1g9xTf6ITbRspbnYhag2Dv7awiGQyG/eIXJ+9EmCTNJadpQGhoZYviTuygvfal9zU6FpMF7
 VAGb35ZqrMuLy/pzkZsSxkVZal+MMphnKzg7nyWpDqAEWQqSNLG733/qcz/fzyo6AOtYqxyUBPs
 VqvB1q8H6ybSvrvz5/m3D/fFkGIq0CU60nU4xoKJs3QxsAtizOGx8QY9Jtq/wWzqYQgu88LLHkt
 mS/Zl+eIQ3E6yPg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

Three fixes for unbinding and error paths.  Enable also compile testing
as cherry on top.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (4):
      soc: versatile: integrator: fix OF node leak in probe() error path
      soc: versatile: realview: fix memory leak during device remove
      soc: versatile: realview: fix soc_dev leak during device remove
      soc: versatile: enable compile testing

 drivers/soc/Makefile                   |  2 +-
 drivers/soc/versatile/Kconfig          |  4 ++--
 drivers/soc/versatile/soc-integrator.c |  1 +
 drivers/soc/versatile/soc-realview.c   | 20 ++++++++++++++++----
 4 files changed, 20 insertions(+), 7 deletions(-)
---
base-commit: 80a76294855640056006e29988f99d46438dcd2b
change-id: 20240825-soc-dev-fixes-ec0889be8379

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


