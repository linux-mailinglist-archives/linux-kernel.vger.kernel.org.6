Return-Path: <linux-kernel+bounces-182973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A6F8C925D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 23:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F2DF2815E9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 21:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691C36BB45;
	Sat, 18 May 2024 21:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X//FxtD4"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157632BB10
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 21:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716066727; cv=none; b=L2YA90rf4e1vS2IObvfcnct407xDTUxV5WJJxeQJUxCTmh05kEfosd5F9t1HchtBfc75UEW7To1ER3bdIMmpMe+I3s7q/NNQTNYLHeA+SeVJIJTFBZjTw1Nw0VnmlXWBex58NVZP1dRUkwBOp0x9h77qkLqFBTgdMWmuXlJVv9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716066727; c=relaxed/simple;
	bh=+uZzQB7WVl3n84H+P2wCbxcNAbvav1A3aRWohUfEHSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUViTgRUswBKiAznD/Qzv8Z4rCRhRd2mam6tfxwL2ZHbLIQWZzNGvCuleiGq1D7wSsBZGBxsHCAptYOPPNAJ3XlvJ7+lAOvXITgyCqOooQn27myh2AaDOpgSAxuHQE7v9Rx23MjlRsJliY0+77hXV2y7WC3sV31eT0O6Vm2iCNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X//FxtD4; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e716e302d8so9070411fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 14:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716066724; x=1716671524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LaAmsr6IbfLWHWEKclaaIPD9AP5Zg/0Ttt/N0I0x4E=;
        b=X//FxtD4nREU+hELxXqvAiiBbBrnsgnNh3BVD0w/GYNh3XDcF5rKONBmLJMBbVG4Jm
         6Ewplgz7ISJZKFsMYCImociPhMP8bB2IqG6mxkLzhWKdWzeTwgxzSUiIlvB/dFT7ZyFr
         RCfm64UPhNP/Aq9ityC2VHbbsb/gsamihhs2k/a8TbSg0gyiELGQu0AcmHXvK3MdRp+W
         ceCx/77brWDf1LCsxvwFTeeIux1k86hodu3mzo4p15YfMqLuYUHYXcwAytim5M6R9RsL
         8PAQcD+z4o/0VpkijDxDbO0V+73pIURgcyDzkN/ad4ruq9sHElW2hwD3Sl5sVKIfjdqQ
         H/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716066724; x=1716671524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6LaAmsr6IbfLWHWEKclaaIPD9AP5Zg/0Ttt/N0I0x4E=;
        b=EceSrvGJVuLdJ4j8DoCFNdZhhBdULm1LgB0S9u+EiNsFOaemJAa4QH89R9Tp8hpjaN
         D+HsWDBYVITLzDgiqqpgEX9KPIs1CAJAD/fDMo5Gc1IkH0FbHz1/4CtS18b3qn2Uhyk4
         /ybpwsbHc+M2Ao6BnVKHJI3PVr3Nj1KY+Xx7zYADsExuFiEUhm5Qlt3fDe9jpe7w7wTF
         UMM32Fi/kRRD1RnlSdcTaoIAK9vvBhV6miXpSGkhFUgTs/nVhveeBc9GdSkQFH+amXR5
         PLAgl2fmSkzk93Rcz20bPTch7wa7AD/aJlh3K/pUfHlm1A/PGZ2kr+4wIjur18Exoxx+
         lyVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNrskNx3jUyBdnMVywgCRYo3vlNX4aJlN6W1v+3mcXsK3bAuMMhkNtz8ikut7LHLlCM01r5oRHAh/Rp4s2H51rzQHdGGJNEeC9jmGT
X-Gm-Message-State: AOJu0Yz43uhIvzDqcNQ/qO07UXT5P8fe+u/vvjcmaF/15S5UFCJyhLYO
	lJWZmWs2FOSewTB5TzwMf4gx5XH8hlJv5b/+A0ofe7ANxKfSKnzZ/Cpjn9jaSBA=
X-Google-Smtp-Source: AGHT+IH2pXhxB9mDHw2Rl92k7GN8nvvr1DxEDU6XaMXuGmC+B9Bmnitesxw7rLcLqh6c221chfar1A==
X-Received: by 2002:a2e:91ce:0:b0:2df:1e3e:327f with SMTP id 38308e7fff4ca-2e52039bcb3mr173818671fa.38.1716066724409;
        Sat, 18 May 2024 14:12:04 -0700 (PDT)
Received: from krzk-bin.. ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c323d3asm13151340a12.90.2024.05.18.14.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 14:12:03 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	MandyJH Liu <mandyjh.liu@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] arm64: dts: mediatek: mt8365: use a specific SCPSYS compatible
Date: Sat, 18 May 2024 23:11:57 +0200
Message-ID: <20240518211159.142920-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240518211159.142920-1-krzysztof.kozlowski@linaro.org>
References: <20240518211159.142920-1-krzysztof.kozlowski@linaro.org>
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

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 24581f7410aa..d3da5a22c2d2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -300,7 +300,7 @@ syscfg_pctl: syscfg-pctl@10005000 {
 		};
 
 		scpsys: syscon@10006000 {
-			compatible = "mediatek,mt8365-syscfg", "syscon", "simple-mfd";
+			compatible = "mediatek,mt8365-scpsys", "syscon", "simple-mfd";
 			reg = <0 0x10006000 0 0x1000>;
 			#power-domain-cells = <1>;
 
-- 
2.43.0


