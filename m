Return-Path: <linux-kernel+bounces-202833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 128608FD1A9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B0D28317D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E77939AC3;
	Wed,  5 Jun 2024 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tIAgY132"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB34019D88A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601428; cv=none; b=ekoEdAtXDzKCj4Hm15jUJtyNeiD05AIjcxsXkn39h/88UJz8KnR9TNgDBBxaAEub+X8CJuNDIuqSVhYWBQaLR17KElTzpgIrAxS6fQpn0LiQtz6VDCIuK2XD/MpFxDNRnjKqSCnr09s5y+ok0T4PSEK5Gp6yrOzM+TWZDpTCtQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601428; c=relaxed/simple;
	bh=iIKb8ImpcFM7FLCF2b3wsKc32YMxOrtwphavIe6/i/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCpMGnUMpHZHZc12lU9Tsh9SXAnB1xRcEUJm3MgBcrT5JwqrfSXTXRA4LiduR/tvEA7Myj+lIW4GbkT+IGiJEFR15h+6khc8F0NXRCs2OxMdx5fGn35pMJinGKOFbWCm9jUP6N8gRw5bijINYgsiwGiT4KdBUqit0ydhsd70D/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tIAgY132; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-35e573c0334so640768f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 08:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717601425; x=1718206225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hap7oZQjiXolWb0TG4x/8PIYUXhCowcxT4O2Z37q7bE=;
        b=tIAgY132Mefpv4Iv4gVulmXrkYiXRuwUjIKX5gSBnx4NrZego8KgJJK2tuRLE8kNvY
         a/AoWCeyK+XBnnFoepLmMYXFKskPwkYpK+BH/SQYCKYXdgosSvx2VQU7arNXehPRxTFv
         lGtUpVr1XO9h7EfB5pWltZLdnYkCCjO/mnCjIaonWOranAHixUGAqYuWHgq9FV6Pm0qX
         l7d8/mIIew90thE2WflK9beXkhesMuBcpq7QimDHw5pzY7v+MTjwrqyuLIyHQudeWiXJ
         94P0p96MxbNa6cF4UeMF5mjFx4xXcpO40UYyaL2GUHvo5UxsgsfzDYlOoF2jsgY45fCV
         FUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717601425; x=1718206225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hap7oZQjiXolWb0TG4x/8PIYUXhCowcxT4O2Z37q7bE=;
        b=bBPdmb60eVRcTBfe5jd+BRx8h8pOpmtk3GfyZIuXxnufofgltdLqwQ5qxgSq1gba3a
         ICWOzvwjHTy1+aZX0MMTKnZJcqYd/iTiyZph7NRqe9ra9vBSMdjHX2UQ3zpmQhz399Aq
         Tx3ner5c0n2M4ujkeNEDzifCYOLqMlouqiQsdsaP6cIYXjghq5uK/lwBlAgSfLfhliUC
         IhvCp4ia2LZP8M/ZuSzDQ43FzyyS9Xe18M+AUhFitYn51i2NZ/YDi4kHIzeIy4KVl+OA
         f3A/L8YfmRTW6cVUS/XCzSMDITmIpoUSWq1smCTktrguLiB12wqhI/BsAOms0udrBVsL
         wiZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxSNjvktSDcTta1tewB80Dz6F765cpcYXR9tY6K1alDkq+60FMjfN9C3NsryzWZWNnpitEmv5syEabUTphEqJMcJ0By8RTwDHFB7Fn
X-Gm-Message-State: AOJu0Yz0ff1TcpGnaXGkJCkPnYn+OwgCIlbKjtIZCRUhwnLGuGuOxkWe
	57SeGFMI5G24zvv0O6GY3ASmVIzXYSLBE1O0yEDbSiEGYr03QwCcJ7wRD+fpiP0=
X-Google-Smtp-Source: AGHT+IHsc8jn6cblWRS8ZJs0k550/fR3mhgoGD0nh+Eg1QnzR+/NhFWfH0bnt6e5vLPUxqVfuXLe3A==
X-Received: by 2002:adf:e512:0:b0:35e:60e6:c8a6 with SMTP id ffacd0b85a97d-35ef0c73ffemr10926f8f.6.1717601425363;
        Wed, 05 Jun 2024 08:30:25 -0700 (PDT)
Received: from krzk-bin.. ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215814e7cbsm26222295e9.39.2024.06.05.08.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 08:30:24 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] arm64: dts: ls208xa: use defines for timer interrupts
Date: Wed,  5 Jun 2024 17:30:19 +0200
Message-ID: <20240605153020.104717-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605153020.104717-1-krzysztof.kozlowski@linaro.org>
References: <20240605153020.104717-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace hard-coded interrupt parts (GIC, flags) with standard defines
for readability.  No changes in resulting DTBs.  The comment was saying
interrupt was active low, but the actual used value was active high, so
assume that the code, not the comment, is correct.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index cc305e629bdc..040a48c88fab 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -241,10 +241,10 @@ map0 {
 
 	timer: timer {
 		compatible = "arm,armv8-timer";
-		interrupts = <1 13 4>, /* Physical Secure PPI, active-low */
-			     <1 14 4>, /* Physical Non-Secure PPI, active-low */
-			     <1 11 4>, /* Virtual PPI, active-low */
-			     <1 10 4>; /* Hypervisor PPI, active-low */
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>, /* Physical Secure PPI */
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>, /* Physical Non-Secure PPI */
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>, /* Virtual PPI */
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>; /* Hypervisor PPI */
 	};
 
 	psci {
-- 
2.43.0


