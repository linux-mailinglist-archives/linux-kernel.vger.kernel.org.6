Return-Path: <linux-kernel+bounces-518119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6145FA38A31
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D54B18943C2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BD6226863;
	Mon, 17 Feb 2025 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/0iGRRS"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AC72253E3;
	Mon, 17 Feb 2025 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739811646; cv=none; b=Kkl9lqLsD7roxAR9cABYGIERnmlgj122AZyo9+dYQeU7aUlk2LN0l+zHBNGJ65GSO/103muLvZqF+2G6MzMmbB6lhl+pH0s8iosXF6dL+bT+PzJtG/DtzPvTel31fWwY0EFZ0iD1jQNajHAXFfpHcXSAL7iR7hRbFGXDhCw0CRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739811646; c=relaxed/simple;
	bh=/JSzwAdIp+loq6hHEIIXja0myTWKXKsrmFl5+HQIkBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NQG+SXBhSK0+4pYuQdFbYTBRmDkVtn/vW4/L7ci4WHqs9ZbE+lsMB380ZmBZjvp+gbkXP04zuPMWhnKHpimng4kEIkbIH4f3nKzfU3pQSfxVpiz5o2Vnt0F7LbDyHLMKygksuDEX2gL0sQl+CTNOeRwsChuKSJDJGlCXCciaL7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/0iGRRS; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e050b1491eso2441171a12.0;
        Mon, 17 Feb 2025 09:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739811642; x=1740416442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rLmL0UWh2UzlPfOvcpQnJu8m6y3UesOtRIguVui1r2A=;
        b=e/0iGRRS18t4XNrSw1QPrrH7w+tk6Kp4CByQffEEu0foj9o9Or1nbESG4PdAtmUfNn
         p1BBZRAz2BrIhHfVzP+3WGJVWWC1tc7GxIr/CNFtSQOJD7kM1IhjTs9V+p4chVKaMIaY
         A83b/m6kET3XDpSfZIFpsPR5RopwdO1GryNVlfTAcFErKCcFWwKkAAvOkQu+PZ1Lbnuj
         tvVjg4J1PcFwkqG9g/XwHn8cOodCVIWYOCfXRF4zJsxRszXvXGwHY9NP4T5hyBlxyIEm
         0Yq28ExkR5+dKu7WUodL0+ca/IiQpUdvoLSHnPxb+EfcIlwxHcIcMmtusRiyJ1Qq+k7z
         KfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739811642; x=1740416442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLmL0UWh2UzlPfOvcpQnJu8m6y3UesOtRIguVui1r2A=;
        b=SRj3bYqJvMwjCV+i/ucXyY3wcceNYHP0wOhVns/515eJofWAyx1K5PbX5kAtV9cbIs
         QJ7JOk0q7Rc+7dXpo5TVDJTckctn8jld/Yr3GcEH5U+TqbByGRYjElC2Xtm3KjFQoE0D
         ZYLjpvmLH2mYkT6rdXdhVKCbvf15x2rmYvS3gjWKAsC7vIo8t7nRPWMjF0MHwShms1QL
         T/oqXfTuqdkOfwHg8bGddvcWPucB4uldXpW44/WUk83a8CVx35J3S4aPFQIEcbPINixI
         UkK0FgR9e6GgPAzL8xQ48tW5ufj6rNRFndG/mTIS11KJqZciXTaIi6mm1ZaAwxqRu7LU
         V6Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUAuJxpDEm5KWXWKJzKgL6xP8/Ji48LP2e9kOTgcd5vfpW9IpalhZDvLlYWM7p7dO1ZP7A4tSjumuHY@vger.kernel.org, AJvYcCVaTJC1828P0PY1Jeq0KPFp5j5IRIAlVckIr21qTg8eik2xwo/ELAXZvJ7U6EUWrO0jNCV77jrlIhU3GkUU@vger.kernel.org, AJvYcCXqdweNPfKTmmfZUKmUTTeCDhypHzZFLDMj2TsW/YUmtTWQvmnV7BMJLsB+E8IA8tn9QnB7qxyrtSGz@vger.kernel.org
X-Gm-Message-State: AOJu0YzgCwiusE7lmFF0X1LUBn2usFAsQTLne5ACFBts+rkClRcEi+DT
	FZP7fxctxdu1T7HQJVIwsTJgvODSn8LGuF5o1W4y8cjiSGPMCwfO
X-Gm-Gg: ASbGnctVuq2zRNHGdzFaho6FffGyf10Paif5yqubP0UeT+QQYQgmNTkH08HcqLj00ih
	8gXNLA7aS8ixUg+67CPVYGx5D/m/USxfCGEen47NOf2vzdzXHxB2KAytw9RV4DM3yLTB/Bzcjka
	4BTMEQeEO8mWlaeSOvW40J/SkRXj/3vgTsQtUZDsbZiAeJMp4rG0cPvNJl+pNtPyEadD1rxiuu4
	43TZvrlKxACJIPQIsdjnl83ZvcB/iHJOL4/DTCqaHqL97VnbT8ZRjWK4TjpbfpIW1ZrrNTlr4Pp
	NqbhYb0p+xfYtBNFInELur5f+rmhkKeorT9bnVBcmwMMjwRYF/dSVA==
X-Google-Smtp-Source: AGHT+IEQjpAvGijd0ctj4hjtd2+w3lCuwj9m7YB2SsgjG2XRGOIZCHqfT/+w91RWWa9Hip9qD8kxRA==
X-Received: by 2002:a17:907:60d6:b0:ab6:ed8a:3c14 with SMTP id a640c23a62f3a-abb70c8e70emr1013316166b.27.1739811642166;
        Mon, 17 Feb 2025 09:00:42 -0800 (PST)
Received: from playground.localdomain ([82.79.237.175])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53376aa2sm920570766b.103.2025.02.17.09.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 09:00:41 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Marek Vasut <marex@denx.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] clk: imx8mp: fix parents of AUDIOMIX DSP/OCRAM_A
Date: Mon, 17 Feb 2025 11:57:14 -0500
Message-Id: <20250217165718.74619-1-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Correct the parent of the AUDIOMIX DSP and OCRAM_A clock gates by setting
it to AUDIO_AXI_CLK_ROOT, instead of AUDIO_AHB_CLK_ROOT. Additionally, set
the frequency of AUDIO_AXI_CLK_ROOT to 800MHz instead of the current
400MHz.

Laurentiu Mihalcea (4):
  dt-bindings: clock: imx8mp: add axi clock
  clk: clk-imx8mp-audiomix: fix dsp/ocram_a clock parents
  arm64: dts: imx8mp: add AUDIO_AXI_CLK_ROOT to AUDIOMIX block
  arm64: dts: imx8mp: change AUDIO_AXI_CLK_ROOT freq. to 800MHz

 .../devicetree/bindings/clock/imx8mp-audiomix.yaml     | 10 ++++++----
 arch/arm64/boot/dts/freescale/imx8mp.dtsi              |  7 ++++---
 drivers/clk/imx/clk-imx8mp-audiomix.c                  |  6 +++---
 3 files changed, 13 insertions(+), 10 deletions(-)

-- 
2.34.1


