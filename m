Return-Path: <linux-kernel+bounces-211257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9240E904F2D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469B91F26787
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD8416DEC2;
	Wed, 12 Jun 2024 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DArmuAIo"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE21B3EA6C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718184271; cv=none; b=NhLCuSC7F91tT1VhcrKmUpnQ2hPDd6PG2Dbeqbldp7VX+3Kupb7B4M1rOiz3rMLZ2dSE5gFLKEI2HmVHr/LLZ5uPtux77+EUJn+PIubzh1G4DKr46RxOy6X/4r5dzttweoO9ksj8S2v0Mvpj8ApDuQtsw4KFjn6zJhEUwNlMCJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718184271; c=relaxed/simple;
	bh=8Ud6fGyLiqk5aftCZdB6sBI3JnC6FlrDjb+mJrMNjPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tjk/nXbLUUoYD2B8ELI+o+2GQZlPmfdpLDzsXOSzYPRJTQ5uv/6pLzd6fg9UKVe8zp84Lnm5g2Al0ZTe2zzLACWENaWV/2rYgDvnTTQz7XeCyLvRRMy9YWeFbd8Nov/Q8Ppdzr7Onp32GUo1CItEIw8zzfpKdVxwTRx1JTWJe/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DArmuAIo; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52c815e8e9eso4001692e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 02:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718184268; x=1718789068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVq/XPrdWmMMBpDrtjBL0lbuC27j39fwjqCGgq7/OIc=;
        b=DArmuAIoKhkuBQRHVEmHdcrux1nbFk+ZjRh9qbRlxhM5GVNnmRK6mkThF3AYf0KGNO
         gVv5u5+s0JYi9NbJoTJG3yEXzEqNEqVGPQEXFxVU4r7tCbLnudNifehuoN1JmCgIQAWd
         o/pq88dzYIaQr6hh1vNJiYW50hsqJzH94AN6kjLMpNuyJwkWTXAWnDSoXff7Dk20KN+D
         66IISPQUrgl+sVPSpjMKAX6OPkLZ+3fEMC0WEe63R62KFL7mN/Ke3ptIn+CwnY0Pymla
         19gBGDYU6+A9rOgX6faj6ooNMGNwmL0rYw8cB86rGM1sSkvilTZ87qaXwqOFszU2WWFQ
         amdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718184268; x=1718789068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVq/XPrdWmMMBpDrtjBL0lbuC27j39fwjqCGgq7/OIc=;
        b=R9uEcI4f85RFq3TUNkYEDIdaP2OkqjbQjCK6IbQnbHfhpJCm5slU1/Zd+X8IpyS9An
         9JzbRV4Oa42HIYqqO0LaZUSdPyS3YwB7jufwPPBoG1O6oFYfewu6wf5TQIwINrhRMNZU
         ZkVGhmDfHQAUZNnvFzHg/Xxbr/PrJoDUitzN9QeN46r2R3y2Ddunbuh5dKV8XHI01w4m
         JXOUyvGX4jTsGvTq7PXp8ZnYmi/NhlM3tO0mpMOh8wY1DhcFE9ai1Hp41KbGrjsNCvkI
         p49BP4gPJkKI+ueUvnXrWt7LX30Cxpyu09gn+FSqNGTJD92Kk1qGGBIUS02xfCsnWeSp
         914w==
X-Forwarded-Encrypted: i=1; AJvYcCVCVV2Ppu9GZhn37BkAh5hRsE8Mmqo+1YqObQYhDc9iRwnfmQDdsWwD1R4aNuGx8nn6m6PmzP2cy0nAZ0AwQMvEgsGS7NFXzYk+9n58
X-Gm-Message-State: AOJu0Yzefved31YqRRpkLpkJZfIs66N8637C7PWfjosFljcBMkaawPqA
	ezgKLS2XXn5iReChvXeHqZ2zJsj5DVVXlcmiYagObVndn32IZnrJtNUX29f8yErpB4iusL83o/r
	X
X-Google-Smtp-Source: AGHT+IEfFP6e6pTW+1khTsjjkkVQ9dhYQOSP5hhhyY4gGwO6/jsKLIdG1CzNbeFE/N/FoWTmcrjwPw==
X-Received: by 2002:a05:6512:401c:b0:52c:910b:9c87 with SMTP id 2adb3069b0e04-52c9a3df0f2mr896236e87.36.1718184267973;
        Wed, 12 Jun 2024 02:24:27 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52c82faf1b7sm1623806e87.130.2024.06.12.02.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 02:24:27 -0700 (PDT)
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
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v2 2/3] arm64: dts: mediatek: mt8365: use a specific SCPSYS compatible
Date: Wed, 12 Jun 2024 11:24:20 +0200
Message-ID: <20240612092421.52917-2-krzysztof.kozlowski@linaro.org>
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

SoCs should use dedicated compatibles for each of their syscon nodes to
precisely describe the block.  Using an incorrect compatible does not
allow to properly match/validate children of the syscon device.  Replace
SYSCFG compatible, which does not have children, with a new dedicated
one for SCPSYS block.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Tested-by: Alexandre Mergnat <amergnat@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Tags
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 455c2ae3b30a..eb449bfa8803 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -300,7 +300,7 @@ syscfg_pctl: syscfg-pctl@10005000 {
 		};
 
 		scpsys: syscon@10006000 {
-			compatible = "mediatek,mt8365-syscfg", "syscon", "simple-mfd";
+			compatible = "mediatek,mt8365-scpsys", "syscon", "simple-mfd";
 			reg = <0 0x10006000 0 0x1000>;
 
 			/* System Power Manager */
-- 
2.43.0


