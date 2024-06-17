Return-Path: <linux-kernel+bounces-217298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E05FF90ADF1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C7228519C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EEC195B0B;
	Mon, 17 Jun 2024 12:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYWH5srg"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42903195960;
	Mon, 17 Jun 2024 12:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718627343; cv=none; b=liIpbbYmurgrMRZdDR/kAhM2rEwnaNwDmsA7EDEJkduKdgeJDR4iRS4l0z2xJ5B2vp4+OYRpGEgpxW+LXekRIRfqD8bDshOHpJ/iTEKd4kMCJqgaXJ95J5Yf8Gz3HTEgHDHu2uzYIKLWixYdM0+e0tFf9WBVFtppfszea+N98V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718627343; c=relaxed/simple;
	bh=t6vDfDP0WnUDhtsCtioJQdhwXB9x1/6tdEwfQb8gr7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qob0WPe6S1ZP3T55ggBR767/En5M2cJCevYaxalnXmiQg3ksMsMWE6Kt03+4/1LgPhyOuTSb7AUjdpH4+taVQLL59b+Y0OfxTIpRHM09cYBRYAMnI0zxNqI+UO0T0EDgylAUCEX+sQxKiymbzvcWISvabZtGkSVHoS998my2Xo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYWH5srg; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f70131063cso33301015ad.2;
        Mon, 17 Jun 2024 05:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718627341; x=1719232141; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENjQGXVG6zrSf3b2hbLXRZe8ZGThnN5eIJS2xnyzsB0=;
        b=SYWH5srgXFYE5gFM2LmftuZ0IqYb5wAwt2cnk3pgNRs59mFjPvIEpIrEbGY1u5lUhT
         kgJS8KPV4Ni4VppMVTZV0MRZhB2FLtYdgaqtS7IkJ3TDepS+/ibv9SGf3vlmtu3mvhbR
         wfsUQ5Zweb4Er5YosIhkK42iJI5cZ4RcbgHF126IjmLTTpEQ3BO+xQnTNWzUutR/qhzj
         GFy3otCHDTnn1E43sYyqFbMWB8+yYe2wtYpSztHWUabUtOYafXtW7ERGbvH1xMbkzNV4
         2hZ6uBgF2NF0sdORKs4n5Up8Vquc4Nznec1vHp6GwIfYLzJEe9deglEndL9Ja4pqIWwP
         B6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718627341; x=1719232141;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENjQGXVG6zrSf3b2hbLXRZe8ZGThnN5eIJS2xnyzsB0=;
        b=D+sWmj/X3oIoRox3DvyD2ZHb4/RahzqwIOuyEO9XE3U/lG3JjkHQZX2XILO6FxxslQ
         o1qsRUmB3gNsctTZvhjr+xfpa/dDv4LQNRvte+yhs3SWFeVRAQpLPf6JnT39aZBONCcm
         ulcUbiihjTolKP7ekxuhibO4UHMM6Tct/7suFIImka3wwlQWQTS8a7Cc9O0kt/z2SqjM
         whOw/QJpbJb2vTNdJqAcog7WtT2cdcuVyPuLc77OzyVZF+5qYU+g+kGiX5IGGtyKEjYf
         2Ec4Zb+/0arxaZes6sk74R87m8FohuG2mPoKtSMg1DP6685xKbh/T5ktfH81I7TSXo1F
         mXfA==
X-Forwarded-Encrypted: i=1; AJvYcCVJIVvuLxlYvSpz5Qh8S6yMvEoAyqb2WcjXru32Oad6jKElOBeN8NXgdWHFudBayNAHuvf54T5Ik5PR5lQBO7Ruvuxa8uq8hKt43uhgmdp0Rz3TbXjNWNNYX1k2IYO8r8T0HHzdRGA/Wg==
X-Gm-Message-State: AOJu0YwlMYOF8UPtxUJdId4Vl14kaq038UGac9lxfyz9oQ+mupezVjx2
	cArjW1Pu+wKI7HtBe69vRGOUgA2Di7ERxFG0s69RSV0nke/HgwwF
X-Google-Smtp-Source: AGHT+IEWH8YEfcqZ8aCC3vP7Rg2A553aHXTV4DlDBjWWBoYM1LboDHCiNYBz/dVm4EElj9SYzXAh3g==
X-Received: by 2002:a17:902:da8c:b0:1f6:f521:ff88 with SMTP id d9443c01a7336-1f8626d28aemr106670315ad.23.1718627341562;
        Mon, 17 Jun 2024 05:29:01 -0700 (PDT)
Received: from localhost ([103.139.191.219])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1f855f5e21bsm76214255ad.307.2024.06.17.05.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 05:29:01 -0700 (PDT)
From: Kartik Agarwala <agarwala.kartik@gmail.com>
Date: Mon, 17 Jun 2024 17:58:25 +0530
Subject: [PATCH v2 2/3] arm64: dts: mediatek: Add missing Avdd-supply
 property for mt6358codec
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-mt6358-v2-2-5d9f0e99941e@gmail.com>
References: <20240617-mt6358-v2-0-5d9f0e99941e@gmail.com>
In-Reply-To: <20240617-mt6358-v2-0-5d9f0e99941e@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Kartik Agarwala <agarwala.kartik@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1155;
 i=agarwala.kartik@gmail.com; h=from:subject:message-id;
 bh=t6vDfDP0WnUDhtsCtioJQdhwXB9x1/6tdEwfQb8gr7w=;
 b=owEBbQKS/ZANAwAKAXiEk+OPlULqAcsmYgBmcCvz/vyTIuqPsDiI00NxTqHBkb/5udifcp2ZL
 wZL5ej26gKJAjMEAAEKAB0WIQSJkbnrkCGnamD0k/R4hJPjj5VC6gUCZnAr8wAKCRB4hJPjj5VC
 6gycD/9OEGDj6BiFMD4zkN23OdiwvprN+ma57OcLYu0JEd/8tqvWJE9S9c6imQOB5Cpl1q31bKi
 MYrtHTMQwDaJXW0toYFEERMcFWRUolnSjhpIMlSpek3CKY4slBJJxOUjHXqh882LMhJ1fXBCDP7
 XZSZz7Ffi/jR+7wp9zieGNBUVOygsEa39n61nS89tB3u02RE5IFS+amViuBdO3K7r2ApFcY2VQ2
 L9WqKs23VhYzomo+EsUwbJZUzy5kBZe0jAmhv6jE7OGkffLU1l4H0v/w1t6PsVGeQH/kKiQMU2C
 zl5iXQowjLBDzbwDEgIf7ACVxRggnB5ASROiSewlcAdWSdiRPenPafjAXfvjM9+j3NAAsy/I2ow
 cwGw6+wbM+7QSgl2jg6a4RIpL3A4dzLkGAAkoRyO4aBfpD32C++SQQMIlEPL+d+RqOCrIOf0tsN
 FnQh0gSbnxte3XlqjYhKiKIlNTp870JERD9mj2Sa/kOD3tuEVlQZl1LmWLPy2+tYrQI+5n+qTCb
 HAWccxWELQFFEaSIYTo4YJWyG789X3A7dhd3NTMBcy0dV2bCIPDHITbhvBgtLwi4oADgvU+EQwS
 dfaN0e9rt4WfCfYmKp5828VwBUf01h9HxeHrN1+ZTeyCsj1uOidhBrqpyXsdVnc/Pod/tXtPeKY
 V1+khP8cdR2wrSg==
X-Developer-Key: i=agarwala.kartik@gmail.com; a=openpgp;
 fpr=8991B9EB9021A76A60F493F4788493E38F9542EA

Avdd-supply property is a required property for the mt6358codec.
---
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts     | 4 ++++
 arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
index 681deddff..241dc210d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
@@ -154,6 +154,10 @@ &mt6358_vsram_gpu_reg {
 	regulator-coupled-max-spread = <100000>;
 };
 
+&mt6358codec {
+	Avdd-supply = <&mt6358_vaud28_reg>;
+};
+
 &pio {
 	i2c_pins_0: i2c0 {
 		pins_i2c {
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
index 333c516af..b3c988e3c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
@@ -191,6 +191,10 @@ &mt6358_vsram_gpu_reg {
 	regulator-coupled-max-spread = <100000>;
 };
 
+&mt6358codec {
+	Avdd-supply = <&mt6358_vaud28_reg>;
+};
+
 &pio {
 	i2c_pins_0: i2c0 {
 		pins_i2c {

-- 
2.34.1


