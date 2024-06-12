Return-Path: <linux-kernel+bounces-211258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BA3904F2F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C089A1F2707B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C99416DEDF;
	Wed, 12 Jun 2024 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JYeHG7YJ"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D72616DEB9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718184273; cv=none; b=HNQuPutJLmFfIGfS3S/ijke+0qf9C/UChtBKbwp24NWmjOREL8WOZqotmTCegARo7VJcKGBKrxdg+LwjfFkoK+mNKT5MJJJ0L7hUbm0TEaa2MvlaKM1gnf5uDBnPPRQ+TkhMhMuJTKDCFnp3AEeQbrT/zUT4+Vh0gZ0mYilypsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718184273; c=relaxed/simple;
	bh=/YmAORbO3+x2lQ89cPlqc8Ys60h2WO17kQvYvC6EUd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDkU0/tRshpnaRMzsuEM7/toEmXxhOvSzbGSaTuuZBA0e2MB+4HOn4yUdCSQq1brv1uoV6m33HJn0y3wNS5yqvXFooQ6/1s99YOqkT6fPpB26av8PwuFglrOakmulE0TopXuYLF68DbCdLLq1EvZVfWeJu9E7QH5bzqcnAnE0JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JYeHG7YJ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52bbdc237f0so2588598e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 02:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718184270; x=1718789070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfH51kBtOmvN/SbHgLsWaCNr0Bu/Fg6um6oRQlR7oHY=;
        b=JYeHG7YJjxA9XXiVI5+d7Dgip5bHXF+8A3Lt4FtmfAHSyltDKSkvOFmXmAAKBcUE4Y
         EKUPCYAAEPPlnX6SRr0wAJKL7YVPeeQs2/Z2fCm6FEyug85WFBKC6a84OGoT9nLRxxoy
         90IDi3G7tUSN3PgVXpAVQMOEEtM73HgE+qGkHxx2xRjHS4yfUSTamz8cCiPuOvQPxJSS
         s0GqhLbZa4WD9B7PVBuSAPGsKuTJYHjrph74YuE/y9zdf7q4gcGcdpO7k3yYtXEsdA1z
         HLTtxx11Y6S5OG3SwuYIDFYSoi3hazp2/rfzEk402EiOwb038bMPKMQSye+azsb2VUVN
         0NmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718184270; x=1718789070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfH51kBtOmvN/SbHgLsWaCNr0Bu/Fg6um6oRQlR7oHY=;
        b=uXZUMEVokHi5Mjv6H8GfcFi5jXfNrrur9NzNBn7sBF+HFHfBj8r/vhfd+wP5lukcOn
         ApfLwxLXS+6KImzEtFaKWKHV8WAgqQy0QiXthuBXkPifN83FJAlJdrfIjMnlL8wUszUF
         txVNW5Uxl4efQvNcywZWINIwxXOCkUMchFgzV4kzkkiAH4LB2eD9WeSjuu/+v+FVgWmG
         9mJyIEDWUrPpWlhEE31PKd3fsxLwkkfCC0IUo+y2bszZiFVNnxmhiI1S49mJvg5nAaNs
         IEwoJ3OY8SgKzHA3+AP3Kd1YYgqt3rlQ+0D7SAe4hsKGpbH66zZgwUvZAPDd6d6XXF+T
         SZqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKUxEMD2cPa3ogG2vOLAkQAuJMQzQWoCScJuYmc1u0gQ3eJ3lL070eSQT4bOtTSyuZubw8rLUUWI+wyaGL0+NPRsljY9PVSeJdz9GN
X-Gm-Message-State: AOJu0YxHzw3vYFCbFplgkDeeRJq/F1gkfXU1/gr92jiah2lVA50xL59Z
	ZZnq5zQhUWt6N0fAavX7IWK5SCuQVDFkzkMSL1enKl9SrYuYd4gD93DrbUAw/M0=
X-Google-Smtp-Source: AGHT+IEF/QjW1JAYelI47//kT/YeUyUvmkw2ZBd8t575ZCaGqY/UKt62km1JBl3qUL4DuZNV4IphVA==
X-Received: by 2002:ac2:4341:0:b0:52c:8a15:3c01 with SMTP id 2adb3069b0e04-52c9a3dfab4mr923248e87.40.1718184269730;
        Wed, 12 Jun 2024 02:24:29 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52c82faf1b7sm1623806e87.130.2024.06.12.02.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 02:24:29 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/3] arm64: dts: mediatek: mt8173-elm: drop PMIC's syscon node
Date: Wed, 12 Jun 2024 11:24:21 +0200
Message-ID: <20240612092421.52917-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240612092421.52917-1-krzysztof.kozlowski@linaro.org>
References: <20240612092421.52917-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to AngeloGioacchino Del Regno, the syscon node in PMIC is
neither needed nor used.  It looks like a solution to expose some of the
registers of PMIC.

Drop it to solve also incorrect number of entries in the "reg" property
and fix dtbs_check warning:

  mt8173-elm.dtb: syscon@c000: reg: [[0, 49152], [0, 264]] is too long

Link: https://lore.kernel.org/all/671a4b1e-3d95-438c-beae-d967e0ad1c77@collabora.com/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Drop the node as suggested.
---
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index 6d962d437e02..b4d85147b77b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -1134,12 +1134,6 @@ mt6397_vibr_reg: ldo_vibr {
 		rtc: mt6397rtc {
 			compatible = "mediatek,mt6397-rtc";
 		};
-
-		syscfg_pctl_pmic: syscon@c000 {
-			compatible = "mediatek,mt6397-pctl-pmic-syscfg",
-				     "syscon";
-			reg = <0 0x0000c000 0 0x0108>;
-		};
 	};
 };
 
-- 
2.43.0


