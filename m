Return-Path: <linux-kernel+bounces-573656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 202F4A6DA49
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98182166273
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4351A25EF99;
	Mon, 24 Mar 2025 12:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hNM/vz+m"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE72802
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742820674; cv=none; b=CBRjVmMcx9nQlrXzrWHKCOFiLIm1hnImPFUSbvPrBwpCBWAGd5tNeq1SeafjkQukKGNC0+AwIDgQqVV7VHW7JS+8mKsTfEQbgMJw2YrcCGP+3dYhs8Xp7Vfj/krrhTnb5ja7cCJXeYZvcjz4217aL0oCHnYVNuu0Pk9W29WM0Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742820674; c=relaxed/simple;
	bh=lLfOSLdPa8J+gvx3KKdoc/YPg+4C/zjDSCX0M4dlUMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mfeun3AbtuUEQrPWTVewcO9TeB0eQP3ysl2PKqcy/jAmYufPd7LD7SQEHvhK/bmIXF473W0deA1/p7wD4SxT1LXS1hxvJbUyxS2L8S4IbFYaXdu0AyU2QWQOJmQUTZfv637Nd7OZXK83RoOUyCoQ8K5x4r7BV8w5Gi5+Lygxx5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hNM/vz+m; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39123ad8a9fso274175f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 05:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742820670; x=1743425470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNkO323fCDGziIQ+TCe0Bh3YOcfzf6+FAg8ZnvrxNgo=;
        b=hNM/vz+msgezokXpBQ1kH+3Ah+TuC4TN6SZHIftY+NXZ8EXuTyNJvK9k50XfQnYVm4
         qipw3v2YxEnNXJP4hJXqvUyq/Rua3QeyTijVgcJAOwJijFvSHlyvRmXKnSTdWRK0ezze
         jaPasXgPCGRaZmyWJLGnwVZ1PsubCkZLfrXV/+h5/8aR3hHtQ3MevswxgV6DN3E9eBXW
         cGk+gsBMxPYP3PF2/LqvHoYEW39E+LKcpHVEu0yqC69ek9PQ2ZbC6GMM6a61Lx+OTvOE
         TopHcdwJhhTTkhNSPBD2nwNVCbP4ZbQxJ8qI+dZk5sRdgBK6oD2ajpMrBQiBLCFBCG64
         SOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742820670; x=1743425470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZNkO323fCDGziIQ+TCe0Bh3YOcfzf6+FAg8ZnvrxNgo=;
        b=RwQFaKHpdqwBb8RqYxmew5yuIfiSRvdAuwcrGZz4gxQaZH0xLuhe99V/0WGreh6yEm
         LRo9Ly8685Il6/dr4emNGuijdAcgaX0D31fEa3KIdDxozwGilwsxbp/Z2Fe/sIPANVsJ
         CQgbaG+aBC/kNG+UxcOWVIMof4B4m1ptemwzC80oA0z7WE+FZSZtwJ6b4CFrzicLHVcq
         8OOg+6Knu9g8zkrDTVpY1v44HtIjquQWdTf1rgTCvA58SsAKjSR31DOGiG8cOIBNdvpp
         6FQdGA28BfG/87g2IgLOZCGAGAdNZBwtCP2IgaPudyPboGk30u2rbOpmIGc/LSHkMMzr
         oZtg==
X-Forwarded-Encrypted: i=1; AJvYcCXtRoI14FOw4FGxKHyEGbmSgJYfVEkE2eKHuQ/wtx6IezNL/LEMgcZ4cWsx3OWzMdw3XygJT7PxgIKfk+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc2rK1yqio7zgmJ/j3Slvf5V4hZc+5hwhBsJpa9oi/88RyUFpw
	LieLs0WlyejHI50zvfZNwzBm2JJpjdoakgYJNdgkaxwDwUl6O3gKyam9xBpX6k8=
X-Gm-Gg: ASbGnctfx5UPihZUfRijTtgNoh0NvKW//9/0gKyDhrk6zmk/W1zNymtMyiEBbKKf2zx
	kz/buRAcgQ0zmuv5PsLxSLtLW3EucRFCM/owhk9n/zpAkGbhSzoGwhZxCbURyA697l8ZaT5NiT0
	0eZQJTT32nufhxULpX+3GS3yz4eL8Omw6BSjhUeLgpZ5Rrge3UIYSj3XxPEfls2e29Cppng2HP1
	u3z11kjzySslK+b3Z5Zz8f0nvN5vZNFy8R6lkwYPOL5HFhYYNItCEOWx9i9dqjIlpkBy3S0xzos
	j466ZRNAky6voQLB9KO4GBj8Mi/QlEYKj8JfJKOyBbRlY6PUC9xQHuHwBg==
X-Google-Smtp-Source: AGHT+IEQndIp5eFpgd1dTDP4lH7gXczSBzoAyRnBiPmFPk1TMdz1z67MW7mzStpV92IOyZshhOAyYg==
X-Received: by 2002:a05:6000:1a87:b0:38e:48a6:280f with SMTP id ffacd0b85a97d-3997f9406bamr4947758f8f.9.1742820669984;
        Mon, 24 Mar 2025 05:51:09 -0700 (PDT)
Received: from krzk-bin.. ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b517csm11117180f8f.51.2025.03.24.05.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 05:51:09 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sean Wang <sean.wang@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Teng <andy.teng@mediatek.com>,
	linux-mediatek@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: pinctrl: mediatek: Drop unrelated nodes from DTS example
Date: Mon, 24 Mar 2025 13:51:04 +0100
Message-ID: <20250324125105.81774-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Binding example should not contain other nodes, e.g. consumers of
pinctrl of, because this is completely redundant and adds unnecessary
bloat.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml      | 10 ----------
 .../bindings/pinctrl/mediatek,mt6779-pinctrl.yaml      |  5 -----
 2 files changed, 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
index bccff08a5ba3..5f2808212f39 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
@@ -136,16 +136,6 @@ examples:
         #address-cells = <2>;
         #size-cells = <2>;
 
-        syscfg_pctl_a: syscfg-pctl-a@10005000 {
-          compatible = "mediatek,mt8135-pctl-a-syscfg", "syscon";
-          reg = <0 0x10005000 0 0x1000>;
-        };
-
-        syscfg_pctl_b: syscfg-pctl-b@1020c020 {
-          compatible = "mediatek,mt8135-pctl-b-syscfg", "syscon";
-          reg = <0 0x1020C020 0 0x1000>;
-        };
-
         pinctrl@1c20800 {
           compatible = "mediatek,mt8135-pinctrl";
           reg = <0 0x1000B000 0 0x1000>;
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
index 3bbc00df5548..f4bab7a132d3 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
@@ -245,9 +245,4 @@ examples:
                 };
             };
         };
-
-        mmc0 {
-           pinctrl-0 = <&mmc0_pins_default>;
-           pinctrl-names = "default";
-        };
     };
-- 
2.43.0


