Return-Path: <linux-kernel+bounces-324667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC545974F7B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F24F1C21BCF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715BC183CCA;
	Wed, 11 Sep 2024 10:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ni6r4bXI"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7DF13D50B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726049993; cv=none; b=sTt165kQlugRaVKzkBcRZOO618iMJg8bgijDJv8a22prDMwYjzDqbQ+BjyC9qNh7ScLShnNZWDTZSJoOYP8if3OmwbqpwP6ESLGTEmF/6HVvXMDquDS2SlIQ926P9Pgi10VJA87BXfJ7rel4ORvjFyg7oBrXXXR3E9k7+lf2uzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726049993; c=relaxed/simple;
	bh=OqK+HbSsS8hmYcqIM5kaII8QKWBrnywz714GdwwsvWU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Xpbpey02k2ihJOIY6QkRGrq6Q0iEjnkSMuPopkzvoy7o1dYE02dIq8ZO1e8B2BPmyLUCk7wCBW8FOSdbh3HoqfjN/a7KPc7U0l7FOMNYWGo4cGGaUSyhfBj4MTzPJrKeH8dvP2YxFKz8by3hDpIRxpbflGvFNHwN8CbtLMbtw/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ni6r4bXI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cb60aff1eso32967115e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726049990; x=1726654790; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=96yG8AVdNMxnIxnB94qu7RH+H08O/gbR0qIlFpmUYlA=;
        b=ni6r4bXIxtAPJQsLACrJ//6rKaaxJ1Rh/RvBzCBlECXuhphLfJoQbkBbYCTt5GT022
         KuiNAEI4Q+vIC+W7I1bvwPR6i/HZes7nYO2raviGOClKcRFn1u1pDJNeyJ798FooiuFy
         /Cqe0wkBzS/XrH85FoPpDcB01yuTgjk+/mhoktW0C48drjVNX+JcePuLUX6VOHAlDmKh
         eaj0N7YoGYzQk+8pAFy8HVI/vnbuy6O3vQY7COoxVEk64V7wFWxAYhv8a+LM/FqIGqBE
         3XDRUD6bBuEcbD4j7WONE/ykHHhisaiU3wux+SB/qAPp1/w9LEz7M7FlyPZar8JrQUKo
         lorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726049990; x=1726654790;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96yG8AVdNMxnIxnB94qu7RH+H08O/gbR0qIlFpmUYlA=;
        b=lu1Npfbk2+MyKDPhMBo7U5XSiYWPbClwCki9iu1hSasSIx0N8EPVoN9HJg7yeqSQZW
         xel3afLjtrLxKtRouDzhCZDHIYtU63i+/LjIwVE81zXbANe6f5jQRFxa+0BbY64xxnt9
         SGDBKJH+asZ+psVmsvB/ycZkzArfVXNcr3EhDjynGAF++R7HO6+ogfGT4+AMBklZu1CC
         GqxWBudA9lc1AERzVpDT7Pzu3tCrjjoNNma+8J1pMNcYbNB5kqKf97aKv4iu1gEucyOm
         XxEVNEJmsXEzFJ4wQKYHlPCXcfukRfRn2RC0JvJPqpAW5alO/QP3L1ZZ4odfNQpFkUKO
         MiuA==
X-Forwarded-Encrypted: i=1; AJvYcCWqE+9xx4qLWiiVbCeJAhs8ri3wq2BrYnlzCxa7VLVSUxZABdBfR+ULkpQIoxYgxMiH/azVj/CGt8v98UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE+0VCC5hFiEni5q4nQsFBC37ZHoCt8+2AwUeAZKUrcfVaaf1x
	QzlGke4xofNOS+VZG9ZGyozGlt/Rh5lmlmTK+OBlT9IB5V12in1kjZ2Rxph5nWM=
X-Google-Smtp-Source: AGHT+IGUEoYNc2uH+Pzfak4B0Re3ZMX0OoC0u9RYXxjoFLGmJ+QwQ+RGYpN4oOCUwO+jHbqfz9ocEw==
X-Received: by 2002:a05:600c:1c8f:b0:42c:b55f:f7c with SMTP id 5b1f17b1804b1-42cb55f1796mr85979435e9.15.1726049989838;
        Wed, 11 Sep 2024 03:19:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb21a4esm139349125e9.7.2024.09.11.03.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 03:19:49 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/7] ARM: dts: amlogic: first easy dtbs fixes
Date: Wed, 11 Sep 2024 12:19:39 +0200
Message-Id: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-0-feaabb45916b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALxu4WYC/x2MywrCMBAAf6Xs2YUmlmL9FfGQxxoXzIPdVoTSf
 zd6GoaB2UFJmBSuww5Cb1aupYs5DRCeriRCjt3BjnYaF2NwrY0Duvyq6UfJZ4tb01XIZfRcIpe
 k+OAPKc5LnO3kLz6ECP3YhP6hD2/34/gCyjNpf30AAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1693;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=OqK+HbSsS8hmYcqIM5kaII8QKWBrnywz714GdwwsvWU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4W7BMOfnppkPWxzVr27CrXWQZxnOP+Gnl9e2a2gq
 erHIAO6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuFuwQAKCRB33NvayMhJ0b7YEA
 CmT8GPtKRzmiHJ1fU/1R3hZUPqGIpQSy6HU06jGirrI0Y3DpvU0KS/PTbHbykDNOprNvyVCtmF6BXq
 oHrNWPqHX7nStU+dSnSCiY8q5xdJrSL/rMVkDcqdvuJDG94LNZ+oQ0Wkj6IE9aaZN3LeOUVnE0FZwY
 1363K/V23g75Ee6HwfAXvNC6n55+7+sv1e8jyfMFt5mMcor1PpHZ1TkAcY+h2vyiPFXfjr+GAIrSTF
 OyUlB3Ob3At1KGT0Cx5eiDq3mh7hbaDL/SBiaZ6JYkH7xfMpf/GCmbCZsgUGBmb9llAc/dRSpbMk9K
 vsDJYNhnMNNK4bUkZq67pFBKEL2vlZzVXQcxwpM16pJcUQTy3bE1tgcTO0H/Di0xfscOruH8ixwtk7
 IfDbd/ExooDiYK5qDRpBfomlskDOBQUrtdcdzv7o4pvGhWBjUchBWY4fyhediQgBuC4kdROfOrJZZG
 z67lWbr53AElnYf1Q2wWkIkqv9ykyObzFcNGjDY+Z9J723lA45jt9HKZkT5UUjSKbTr7asP4K496hB
 A5N+To5KmsrDZEuP3MaFpTh2Zzm14PpROzLT+dp+9pDzBJnAXET4YCYSvomURzl8wesDl8Yj7Wcl0A
 ndi80bkrl1/xQTyXMCcbvh5gTprfSAdVcNO4gsAYE/qkxHJrSKDBZrYQ8BZA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

This is the easy fixes to start and fully document the ARM Amlogic
Device Trees, remaining work includes:
- ethmac with required phy-mode/clocks/clock-names
- amlogic,meson-hhi-sysctrl
- amlogic,meson8-clkc
- pinctrl: Unevaluated properties are not allowed ('reg', 'reg' were unexpected)
- bank@80b0:gpio-line-names is too short
- realtek,rt5640

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (7):
      ARM: dts: amlogic: meson6: fix clk81 node name
      ARM: dts: amlogic: meson8: fix soc thermal-zone node name
      ARM: dts: amlogic: meson8: fix ao_arc_sram node name
      ARM: dts: amlogic: meson6: delete undocumented nodes
      ARM: dts: amlogic: meson8b-odroidc1: fix invalid reset-gpio
      ARM: dts: amlogic: fix /memory node name
      ARM: dts: amlogic: meson8: use correct pinctrl bank node name

 arch/arm/boot/dts/amlogic/meson6-atv1200.dts      |  2 +-
 arch/arm/boot/dts/amlogic/meson6.dtsi             | 18 +++++++++++++++++-
 arch/arm/boot/dts/amlogic/meson8-minix-neo-x8.dts |  2 +-
 arch/arm/boot/dts/amlogic/meson8.dtsi             |  8 ++++----
 arch/arm/boot/dts/amlogic/meson8b-ec100.dts       |  2 +-
 arch/arm/boot/dts/amlogic/meson8b-mxq.dts         |  2 +-
 arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts    |  4 ++--
 arch/arm/boot/dts/amlogic/meson8b.dtsi            |  8 ++++----
 arch/arm/boot/dts/amlogic/meson8m2-mxiii-plus.dts |  2 +-
 9 files changed, 32 insertions(+), 16 deletions(-)
---
base-commit: 100cc857359b5d731407d1038f7e76cd0e871d94
change-id: 20240911-topic-amlogic-arm32-upstream-bindings-fixes-69d624b8bccd

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


