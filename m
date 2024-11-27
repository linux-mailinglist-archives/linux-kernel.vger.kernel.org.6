Return-Path: <linux-kernel+bounces-423369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E209DA69A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6079CB2B424
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA801EE03E;
	Wed, 27 Nov 2024 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kI4G/oGp"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5221EBA11
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 11:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732705304; cv=none; b=Ht2GxRqZYS5B7LZx1s/VrEKTUaa3Rxi+P7g7RAbtWNLQMas2Vwv8g6fyj5svbqQkcL9YRu0cW3rf0tS/8meebql8PnDLN6dehtUwgPsbfqo1jzK1pb/bhLmWXS97gAyW/AwXKPnhDbfhavcOSfsCYjT6IUE+MYevASTkhcm4Fmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732705304; c=relaxed/simple;
	bh=LYkr9r33Y5XKXLryrepschQpm2XBjm1H7bQnk6ENV30=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O9g5TOltj441WkAfrx8d/qsVObuqAnVH1l3slyAubO24eze/0zvexIW6N/poP/jXrGsq+FNujMZrS9aRDAsi7R0ztHuIAvJqjI8QITO34ZNoJz5AK8afMAFv2tfsRznU2de1agkz/2qg0m/FGWh87f3LqKSwhyiZTyiL2+6bPek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kI4G/oGp; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5ced377447bso8944892a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 03:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732705300; x=1733310100; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cBZr6b/b4WAms1NkzQ7R3CufwwQCxtnEtvUYSb5nf9M=;
        b=kI4G/oGpdd3nQMinjYs4IwQOVXqxFP7b4S9fakKeT1EN2p1X6TLXOzVb/tQZCd6ncR
         Rd5fCsaXUVngu7wJQ1x9SU4PMDB7PKhbSZkKYh9MOwkn8xxWvWEeuqQFGHomPm2AzNdn
         0pB9456I/YiEWbSW1GVFvZwwH2hRheiMfAMp3aDF785o5cUqYjaqfCxvfUqxsQhI1qbl
         LTWWIUsdKOvVS0hAifU0Om5JEoMEFwW9OCnRcbiPBgRhkAw3iuTs3fWuSBAfgeD3Wz1F
         mrzqW/D/Myi+d+U6fuWlOv78+LU6XOyf/5G715QgckKJ+o9lMhmyrBv5kTPoiin0y/Vj
         5JhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732705300; x=1733310100;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cBZr6b/b4WAms1NkzQ7R3CufwwQCxtnEtvUYSb5nf9M=;
        b=czwtqsUV041449vYuC+tYqGuAC7f+oAEQWcMmdecoFYPWsnabdMUdJitEPcTY7phZN
         BiTSyEYjNm0HDJrZWRFHo8Ltf7BPFmDHpFJIbZw4soH51YsBhgJeNB0pH3RVG90EgnWe
         YhW0XpnwTyBTy7isa71MyNj1lkkXe6TsRYYrkhZQsaB2C+YjzzQYeWnBUptpZxXvOa6D
         xwgr4FNK1wb0xxMy6ZMQ0xvBaF99EUSZrzF9VEh/FEc8m3MEg0L63vFPrK2qGaF1kTXo
         lYyn64p9miy+cp8WJ80vnTPV0Rp6myIjMJmd0It94Uik5jf39gzdbxRgL4iJLZfPQdAE
         PW1A==
X-Forwarded-Encrypted: i=1; AJvYcCU1e99MzdjkKRrSyxcz7Qm22q4RR0dXh89sSpXS2wukFHngs3Xu0RkaYDBuUSXT2Qn0jIytS1JboF5IZlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFo6mD1qL1I1Whpj3UxOK9vyYDqfIKimdMV/DAOIcKEzy95xGk
	I/jefedHnKSuEkmYKgQ2YpXCu/2L5ZDFLgyTvUe5fi5W2mEM0C6fqlYYm3BrK08=
X-Gm-Gg: ASbGncvqHmnGeEpnDW4b1+OZTOUjs9PRWWuCU0YSgS6dfjH0i/K9/taGs4Mo/9C7l8M
	GKlQV3sAXw4oib63XO6PEg2E+SqJD8LX7+oBSxWLLUPH0WT5cBtEmTFFnzo2JbiNlgvYg2+jBxy
	uI1Ot7I2ESvFkM1VHcSV1SZVm357cv8CjLcGqgvLesRAK/TxrFVWRuD/NYUTYsg4yi7EOa/msN1
	NyurWMZ5E7lgucBGd6Q13+FBh5bhDp+czY5EE6g8sA3HpZwxjwbURQHYGXKaii6MNP5WGtkXzrz
	j/3wzaMuHCiQPx3vFoVh8Tfckx3kBQnljA==
X-Google-Smtp-Source: AGHT+IG9LM9nsHo2L6pr+d8lMcVcqFeZ9vngEOtHUmqHJbBLX24wsz6VfzC5liy6xxjFk86MjURtsg==
X-Received: by 2002:a17:906:4ca:b0:aa5:b32:6966 with SMTP id a640c23a62f3a-aa581076b11mr207938666b.50.1732705300206;
        Wed, 27 Nov 2024 03:01:40 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b339612sm693762966b.84.2024.11.27.03.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 03:01:39 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH 0/6] Google Pixel 6 (oriole): TCPCI enablement & USB
 updates
Date: Wed, 27 Nov 2024 11:01:38 +0000
Message-Id: <20241127-gs101-phy-lanes-orientation-dts-v1-0-5222d8508b71@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABL8RmcC/x2NQQqDQAwAvyI5N2CCRepXpIewphooq2yWUhH/b
 vA4h5k5wLWYOgzNAUV/5rbmAHo0kBbJs6JNwcAtd0Tc4+zUEm7Ljl/J6riGnqvU8HCqji9J2nf
 CiZ8JorIV/dj/Pozv87wAXVvef3EAAAA=
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jagan Sridharan <badhri@google.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, 
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

Hi,

This series adds and enables the Maxim MAX77759 TCPCI for Google Pixel
6 (Oriole).

It relies on the bindings update proposed as part of
https://lore.kernel.org/r/20241127-gs101-phy-lanes-orientation-phy-v1-0-1b7fce24960b@linaro.org

With these patches, we allow the usb phy to detect usb cable
orientation, and we make it possible for the USB DWC3 core to enter
runtime suspend upon cable disconnect.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
André Draszik (6):
      arm64: defconfig: enable Maxim TCPCI driver
      dt-bindings: usb: max33359: add max77759 flavor
      arm64: dts: exynos: gs101: phy region for exynos5-usbdrd is larger
      arm64: dts: exynos: gs101: enable snps,dis_rxdet_inp3_quirk for DWC3
      arm64: dts: exynos: gs101-oriole: enable Maxim max77759 TCPCi
      arm64: dts: exynos: gs101-oriole: add pd-disable and typec-power-opmode

 .../devicetree/bindings/usb/maxim,max33359.yaml    |   8 +-
 arch/arm64/boot/dts/exynos/google/gs101-oriole.dts | 104 +++++++++++++++++++++
 arch/arm64/boot/dts/exynos/google/gs101.dtsi       |   3 +-
 arch/arm64/configs/defconfig                       |   1 +
 4 files changed, 113 insertions(+), 3 deletions(-)
---
base-commit: ed9a4ad6e5bd3a443e81446476718abebee47e82
change-id: 20241127-gs101-phy-lanes-orientation-dts-9ace74a2c25c

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


