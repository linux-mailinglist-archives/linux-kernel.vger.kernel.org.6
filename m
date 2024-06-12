Return-Path: <linux-kernel+bounces-211256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 715C5904F2A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23AC61F249B8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505E416D9DD;
	Wed, 12 Jun 2024 09:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qQRPbVTt"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DC316D9CF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718184269; cv=none; b=GFrfOD+lZTLPTMmvzI3DTMj4tCb1nX6RWRTZGnmNB33U40DUEILhym4e6EdpHLufWFpXB4QPfadFsqinp3jyZMB79+yQp6fD+AMHkhHv9wYiMdvm8eiM+BtfSM+se1w5/aHP24pHt+zPkwTgiIPtrqz038DeIh1ad5RDsPvdkoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718184269; c=relaxed/simple;
	bh=F5iIiWNQaxmakp3x8MsUA88qNRzfzIm/B4zfOmd6TmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jh5hBkCgQzeSBRXH8B2HeSFMkqLpYjmT9fomAhrrV90yro+QtucgJI/GcXZZF3lyfBDAdso0e6Sg1stua9fkWKjmGx6qnqlHXdJ6+n9V1WeADmvoPrbapJw+eJxGznkeNWQpp+5YDRQ5ee5thNdE1k4blxmygurpkf6D2+Aqlkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qQRPbVTt; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52c819f6146so2517965e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 02:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718184266; x=1718789066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gTijVW/c0PheiETrLzEjcgWKlXvandGPfKwnTsYZzSY=;
        b=qQRPbVTtutMDZqpgZ0Cvtw1XfDbR6n++7JyJH55s9FSNFM/K+64HrOtR9YD5XSnG3H
         c3wvWBaqPgSqe8Ib27+toobXDPm9WBybUtH9Jg61QOh7BfQ4sXWWhbanaGLkXjs+FJX/
         i5NYOouA6ZSc4zKothaK3ex9WtvkuH4EkAsO5vC7WddxYVNue78IY8Vg7Ipsw0RBn7t8
         HQwKW1gh6Tzk5Lq7U5cZClJR/yJiUvV2PBEtH8oO0Pc9wDFd2Nk5GvyTsnIcshFgNlUk
         /r+VzyFt3Iretm3lscAxgBho+a9dHpLB5M0EOa5hWAwN3sSIOmXbtEyp/wiAGc3vhMNr
         7BbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718184266; x=1718789066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTijVW/c0PheiETrLzEjcgWKlXvandGPfKwnTsYZzSY=;
        b=K6XLldcM157Ft6PzjgyuN7hDtbqVg0ybbBaXukJxfyD9JQJPT/yPX6L6xuACmDUPtI
         4G4q4tdaIR57DFpWsX9EkDXQuOQKwv9Q+IFI5yheoyGbQyrYMR8tvZl41Azz5CWe8Rfy
         8iNDLM0xdpwwKC8LCNVlY1bsVCtrInyL0SjwDMXXbzGt4SgKH+5mGjYMRr3JmEHaccu7
         +VXRwh/JU+TXPbm6vWEXS3o5Y8qOkKGfeLL2V6AOyXzYrvoAdX0hjrh8gNcH5LI/s9c4
         L4URsZPbsMC505X6a7eTj0ELm2RTxWQZuaKGFoJp2KoeMN/9jfUX8Z/xa7JiJhGDrEhS
         Ja2g==
X-Forwarded-Encrypted: i=1; AJvYcCXgiURU2CyU9ca5cCJLgeKU8RO/Q0xIiDWkZhVcZD3AaeYtcQgI8GLOUCrLxJOENFI3vCL03bXsif7HfzmpHc3P8sJmDTv9CezdzJaa
X-Gm-Message-State: AOJu0YzWH2503kIDM30MQgONGr+ZNFqsZQFh7qaB//m9VzwLfIILVwRC
	rYUgw5NQIC9U6ULJuf5YSWg7snu0h0WhVjbVfWxf5ABe01CSH4xKVrUfC/DA3/Q=
X-Google-Smtp-Source: AGHT+IFqaCEnIiWKhTWBfjOSEjjiN9fP7XZI9ln5o7b24/sAj4EADCaVdyrAYctm8l1H4IcbPLFHgg==
X-Received: by 2002:a05:6512:1245:b0:52c:95d1:87ae with SMTP id 2adb3069b0e04-52c9a3b7bffmr1099334e87.12.1718184265932;
        Wed, 12 Jun 2024 02:24:25 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52c82faf1b7sm1623806e87.130.2024.06.12.02.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 02:24:25 -0700 (PDT)
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
Subject: [PATCH v2 1/3] arm64: dts: mediatek: mt8365: drop incorrect power-domain-cells
Date: Wed, 12 Jun 2024 11:24:19 +0200
Message-ID: <20240612092421.52917-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The top SCPSYS node is not a power domain provider.  It's child
"power-controller" is instead.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Reverse patches.
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 24581f7410aa..455c2ae3b30a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -302,7 +302,6 @@ syscfg_pctl: syscfg-pctl@10005000 {
 		scpsys: syscon@10006000 {
 			compatible = "mediatek,mt8365-syscfg", "syscon", "simple-mfd";
 			reg = <0 0x10006000 0 0x1000>;
-			#power-domain-cells = <1>;
 
 			/* System Power Manager */
 			spm: power-controller {
-- 
2.43.0


