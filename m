Return-Path: <linux-kernel+bounces-429456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B019E1E21
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96E84B3CDC0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BD21EE005;
	Tue,  3 Dec 2024 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zf9mUE6q"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D958D1E8834
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229632; cv=none; b=jFhe9oZBFZxwk+VJm/V0ReZfsELGdKSc6xAdyjCe1ToiIrYVYSvxMZ7TYA0l2jYj42XupoJsv1DkmuAOuCTyRQQhcQthp0lWHMbkga+7gBZCjPVX9PcrIBpIYKFOGX1kGVGIG9gRMkKR9f9puYUPs4ifaYLDARupUiERkCUQeSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229632; c=relaxed/simple;
	bh=MeivqaG+kYdxtEaOxl3RjvFIax6Vzjmq5wL7Dtno7yc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CpPYoH/CKk/iTG2JvVLbCJfHEnW109zF1xHWhR1IBXESp2xg9a0CggxB46ahWzWlvf3aYvAq6SaDDOOTMxFoty7kG4QEWNWlXVhx9lg61GCOQoAIhc7cr5QtEBg9DgI9Vamge0dyVOxxxaeWtRTY2NNR58s518vSi9WvQUzM9L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zf9mUE6q; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9e8522445dso775863166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 04:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733229628; x=1733834428; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A0SZ3/Zuy8g3IadhgXaPB8LqQDO37Mo3P8H3ntaK+Bw=;
        b=Zf9mUE6qpPYuvcUjP1R8BFWlRgL+D95iIwQv2hjcHb4X9B2iJ1GULYi+619BqpQ/q5
         A0rIe1r9Hhzll7OxKFjubaakp21BcLgr/46Xdmid1YxGo54R2AJo4Z2csqJyoSKRndKI
         fZzgRmtwytM/8//OcjgnyfdH/oHHPmYQY4LWXmAVHjwcWY8dABpKalNy32354fBv2/Wd
         5kKKkZkM055bXGap3csfFsQNDztMDp4lcUZdWnimcuEWuMr+cdnMg2UhfCkLGiEtUm0n
         NLI2jtqiIrFZn82EGyC3BcW7spCJ38NJqWnlMVrYn9wCWJ2H4Zv56/N/Cd3BcWhjTdu1
         ZvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733229628; x=1733834428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0SZ3/Zuy8g3IadhgXaPB8LqQDO37Mo3P8H3ntaK+Bw=;
        b=jlIQDaV58vH8iafgCRcpmm9UdTU9CD5Tia+NrFuyfph7DuuH7v2KfSO49g2Rn2UDK/
         ba5c31YGYc5tAnuH0bamE3HHIRwL2qQ/B/bcaj0s0K5gEE7gZtqrigyiEHxCVZ4+ZFDo
         UwjN2LyRO0fV2MN2mZjeuUxwRFMxaUmkRJzK1gaxWO/AwhGzko6Nko0Ol54wRsxC8xPX
         yx/Z1jnUlytKVOm2yNuYW0+Wf2GFQ8FyMDkYjJP/bSQ0UHdw7Ye5udpHVWDegNdutCzO
         q49WUyclnn/ovRDp3XIy6rAtaPm331RtL/Kktr0Upy0TrNZ3s+gXWg0kXU6IUQGc4diO
         QMrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTPgiV+DNMcZATyLVNgn8DUv2ylZh3/TWSJdsWwEkLPc3Zqq947Tsa2CQVT/uXEpcQ6Fxj7vLTvXC0rSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrgxkYvSIINBRoTGdsi2xzc9HXWGi8j34NoRGPjrMIfk63vuf1
	t++SVY7VQqXV+zeg3rydtHFtzZCMNbEcmfMoAnOfRq+GIWoN3Pco2eyyBqKh238=
X-Gm-Gg: ASbGncv6bB8CyOLTzbgutE1mSrbiVTYMeMMbzdgJefWYUz+HLLJ7clsfsLcE1iSKnPw
	FpQzEgLaw2arG3YiAuccRrDP7ahyI8Zgm0jZ5v+AqqaSEZXN71AUDQL2MJ2gWXYonzNc01/ZqEV
	lpolA+zzBGtrtXI8SV5+fA1nKOTUlsmvX8WYSexA4UkmMITYBkuziJEPLaTAvl7+DU37REUucLX
	Sp8vD7LJBpXriXFBwcQOAZuFvzMOhAizpp3WdbVL9DUR3kwcix6pJaRuqQCR/h/pVHSKfm0HpnY
	xtVMHLrVWlEMklVbnD9+4nzgYwLSlZvRaA==
X-Google-Smtp-Source: AGHT+IEtOgF5+Pd8GQXG5yAk2/ZT7iTApOoCMzUviVqMUPCGmvDJSENPWZg/xy3RM4OpVosidZ2alA==
X-Received: by 2002:a17:906:31c7:b0:aa5:3c28:e0ae with SMTP id a640c23a62f3a-aa5f7d1b599mr200040266b.15.1733229628143;
        Tue, 03 Dec 2024 04:40:28 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5998e6a4csm616809466b.106.2024.12.03.04.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 04:40:27 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 03 Dec 2024 12:40:28 +0000
Subject: [PATCH v2 5/5] arm64: dts: exynos: gs101-oriole: add pd-disable
 and typec-power-opmode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241203-gs101-phy-lanes-orientation-dts-v2-5-1412783a6b01@linaro.org>
References: <20241203-gs101-phy-lanes-orientation-dts-v2-0-1412783a6b01@linaro.org>
In-Reply-To: <20241203-gs101-phy-lanes-orientation-dts-v2-0-1412783a6b01@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, 
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

When the serial console is enabled, we need to disable power delivery
since serial uses the SBU1/2 pins and appears to confuse the TCPCI,
resulting in endless interrupts.

For now, change the DT such that the serial console continues working.

Note1: We can not have both typec-power-opmode and
new-source-frs-typec-current active at the same time, as otherwise DT
binding checks complain.

Note2: When using a downstream DT, the Pixel boot-loader will modify
the DT accordingly before boot, but for this upstream DT it doesn't
know where to find the TCPCI node. The intention is for this commit to
be reverted once an updated Pixel boot-loader becomes available.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101-oriole.dts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
index a5cbf1e10c7b..e58881c61d53 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
+++ b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
@@ -107,7 +107,6 @@ connector {
 			self-powered;
 			try-power-role = "sink";
 			op-sink-microwatt = <2600000>;
-			new-source-frs-typec-current = <FRS_5V_1P5A>;
 			slow-charger-loop;
 			/*
 			 * max77759 operating in reverse boost mode (0xA) can
@@ -146,6 +145,12 @@ VDO_DFP(DFP_VDO_VER1_1,
 						0, 0, 0x18d1)
 					VDO_CERT(0x0)
 					VDO_PRODUCT(0x4ee1, 0x0)>;
+			/*
+			 * Until bootloader is updated to set those two when
+			 * console is enabled, we disable PD here.
+			 */
+			pd-disable;
+			typec-power-opmode = "default";
 
 			ports {
 				#address-cells = <1>;

-- 
2.47.0.338.g60cca15819-goog


