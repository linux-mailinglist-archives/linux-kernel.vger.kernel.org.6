Return-Path: <linux-kernel+bounces-218494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2525890C093
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11A41F219C1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1247D401;
	Tue, 18 Jun 2024 00:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rq2edSdo"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C2B1CFA8
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718671071; cv=none; b=j39tjvBAsHgL7BO7W4wydTBeGrfm9g5DmoS/FC3V025OkOZ36l0JsBhZ9FzmwvDUHzGZaqPSwgGcM6tCiTEfJtFf9p3ZJqn2sgmj9Po7yGRirUV+/n4dtZS3vMQJlU1Wnjq3n40SL3jz3DUaBmm71lzrT1yRTG2YCfMIlV/HmQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718671071; c=relaxed/simple;
	bh=idQsCXTRSpteqMQ/ApU8QqN2v+CejLFr+G+P9eZMvmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fj6ek5NgpgbakKMFwv1JJXo9a2wwG5YBdf0NZzzUISSdV/SIjew/65NP88UIfS37Bid2pYTOWfF6aFDptKyxzr0vgT0WvDcQlIKNepNuR3afwXqR3PM8gB7WyRH409xlGgoCWE7BtqOOCBDEfm/3PfzT916n9aPaSu1TOKcmsQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rq2edSdo; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5bad217c51aso2685821eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718671069; x=1719275869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/EO8T5rRTkiZ8LbuFbhP2DGGAGyuLlPjhaKm+CoFdc=;
        b=Rq2edSdoPiP/PVPV51jRdJNi/JGzv7NjujvKFSAc+VlJ+kg6PifKAO8X2a9+FyTjhi
         4x6OQFQ5qCmlFBdwTeR9ItFl/tLIW+liY7bmPnCtja4v9HyPwVukt3tUPInsORSB+OAV
         44rBSezwB+ijG2u7TWIMczkBlCJb+ecQ+T9bcgP7PG5btvUsOYqjqmQ1UH8japLMmIRL
         CA1hSYfdiqfUd6HYLBTOsCfhhQHy3XScL0YXmbMtiqjtHp33Yg56dLLVj8WIRTrrQHNi
         65Kj/dOkycuJp62P4sAaJIBrYwzb9ucdrSN2PIVCs+Rwz7/ejZqZ8OeFkMHwgwbIPoqQ
         sj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718671069; x=1719275869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/EO8T5rRTkiZ8LbuFbhP2DGGAGyuLlPjhaKm+CoFdc=;
        b=gzvxiuplt1OjiCgX8dT+GxrmrtC+Kx69FRYU1xGL2V5VLAJsFl/ldfGfkHw6IsuVvZ
         WWpWfptLj9o7emdTSI0ZOqQJlmTd/9VGQUm/1imBxsa0DWiFzL2TTTsY3sjeK4OqdQ8u
         cO23Huvk6jR3sP4+uZ1zpQDfw3ED8CZ/Jc5Esex5Jnb/NDhKq3ll+KMAiujHlnbBZ31j
         MI216QAiQlxgLH8XRQN0tFQ16AIgIn4hG0m2RZppH8UUWJg50rfak/KUcEBceZ3NTvy4
         p1o7lz4lzLQPZhXx+inaw6xWUhLu7PttunwGL8iUxFr5AR1+/wb4tQCqZJtWzdeYLpAU
         SCeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXux34ioRLpKb05jlOgKiy1HgdUAK7+rNHk+BbUGrTE/ilAuSRiJ43S8B4XOzV1xI6XjUOjmxV16z7xpoi2UEeoEN5w0Bb/GpxPFes9
X-Gm-Message-State: AOJu0YzxvFmNsCZvukPSbuXcVX9pIuVbhRejFqz5wS6whBwlQ5I2+wcx
	HGLNf6/QhI34naQt9w2Hg8MIw/vAzhOFWNxOtqnyPRYiVWPo5zQZbdOxnMYGBcE=
X-Google-Smtp-Source: AGHT+IEcoB3JmFJ9IpjpkDLM0gXNp4DcLepn0oB2jv35HwAPRgPQt+5YDdLNa1XcS8JrDiT3nZnRlg==
X-Received: by 2002:a4a:7651:0:b0:5bd:c2b0:f599 with SMTP id 006d021491bc7-5bdc2b0f7d3mr5945744eaf.9.1718671068698;
        Mon, 17 Jun 2024 17:37:48 -0700 (PDT)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd5e19a4e7sm1320770eaf.20.2024.06.17.17.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 17:37:48 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] arm64: dts: exynos850: Enable TRNG
Date: Mon, 17 Jun 2024 19:37:43 -0500
Message-Id: <20240618003743.2975-8-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618003743.2975-1-semen.protsenko@linaro.org>
References: <20240618003743.2975-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add True Random Number Generator (TRNG) node to Exynos850 SoC dtsi.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynos850.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi b/arch/arm64/boot/dts/exynos/exynos850.dtsi
index 0706c8534ceb..f1c8b4613cbc 100644
--- a/arch/arm64/boot/dts/exynos/exynos850.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
@@ -416,6 +416,14 @@ pinctrl_core: pinctrl@12070000 {
 			interrupts = <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		trng: rng@12081400 {
+			compatible = "samsung,exynos850-trng";
+			reg = <0x12081400 0x100>;
+			clocks = <&cmu_core CLK_GOUT_SSS_ACLK>,
+				 <&cmu_core CLK_GOUT_SSS_PCLK>;
+			clock-names = "secss", "pclk";
+		};
+
 		pinctrl_hsi: pinctrl@13430000 {
 			compatible = "samsung,exynos850-pinctrl";
 			reg = <0x13430000 0x1000>;
-- 
2.39.2


