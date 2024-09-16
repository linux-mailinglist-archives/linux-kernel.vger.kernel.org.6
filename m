Return-Path: <linux-kernel+bounces-330313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B22979C78
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 197D7B2391E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7110413DDDF;
	Mon, 16 Sep 2024 08:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p6WYta3l"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072444E1CA
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 08:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726474127; cv=none; b=p80gRHqPXV6Y1PW+c0vnUEtVHlbMtkCe7Ytl00X4GxyPj/X5C/PLLxTOnLJ8QH9S21V5IT/RojAN0w41Y3KlUNmL6tj2CFzj2O1+7xlpT6uQwPui5Cahi2phxmVzh6VB9Tm4GjMrdYKGFl2P9oQRGFT+E2lBeBiJUbVY4zNk1Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726474127; c=relaxed/simple;
	bh=pMewlYYDF9agGKPA3HCGL/qAhfwWWF/OUrcnBP2XiME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PuVvh03jlNauCQ3kuCIjxvI6pzy+KOnJ1jPegtP99aEKrotU1cg3sbspEnmK4J85Q/332knIIoSCTBqAMGAHmMVzKxzMObObS9YxtgEMizLHl+YdntHz495c+nA1U0KH4D71wEEHapKma2qHt9URNNx0DUfx9Ojm9nw3imKgIb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p6WYta3l; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53654e2ed93so4440448e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 01:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726474124; x=1727078924; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6rsbSiyM71mODHTPu9JLHGloK45uN6FAOdQl+nPVppY=;
        b=p6WYta3lvS7ta3syvCSoX6ocWh7km/81djgnx4IziQlwrCC6nqrEQiO2uD1n4Ka/fy
         1+BoIhNCA60AfW90HKv/TrZL5fkdEoZBg20ddayr6k3sg03OkiIWjNTS8TP3CZBRaHTY
         CsY4OjcyIkhJOv3N+JtchMGXcfUoRcVsOWgByPjYhda8Mnr5bX64zmLthK1Wd1EfgLUB
         aChhmytIjnNhEOKMOt15NIc4UlbC1jLy/uYCR1acNoaayyFFG4tgfhjzVfdnvpc5rHdf
         5hM0skLg5FKKhvGfQjw8lT+z81GHbBqNpnEMKDtXVCDRzMBso+zMJGsuzmEdDafnHm+y
         lmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726474124; x=1727078924;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rsbSiyM71mODHTPu9JLHGloK45uN6FAOdQl+nPVppY=;
        b=Z6bHqdZC0u6y0Uq7MUUYDIWt+ScvcwpVhvrVmS93yVA3NFWJKQe/dv+Pwo7tTfCsFy
         VWa7RjLmDreBdgWTOJq81LLThRTe6lDrqKlByiachgZBQQM3R7d2pZLng3+PehSkmywT
         Rl0AUSB9NgpIbhBLrY/mGrBo9t0EQve1RlyOLRLvgSpHED5UQLJQG6vVLc7IJn35qjP0
         Tom5kROTKSHC9ZAG0ULUFi0iXcUsgQAO3WRyMCFcYP4yBQ6rGg0cqSrKM1XT7TNWQ8EZ
         1myHCw4ZTdgp+wlPvlpaQdAmzT/R6NxrqtOn4XfxA77D5wxcch/jDpnaj7zv58/gwsFm
         v0Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWQFzdD7wc2m1c5c1UeMRw29eSX3bgF00296KCkEQk2ciygGHtPua1zDrtXENYClNEo3/PAqaJtWeQr1l0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4CoZOpTOBajRN2huOK1YRx50yu0vLkNzk3qIkjYkgv3MTG9Dm
	yQag+FwOiWwvU56frDggwQ0PvzZJseFntZUMrTQoIVHG7mTjh/AFmMElkryt3uE=
X-Google-Smtp-Source: AGHT+IGeYYiQmn4lHzDy++xVLZnjV4G+rnbzuhYdFOi1c7P53YevUahnkDAMBRV3H21walWQwmZ2Tw==
X-Received: by 2002:a05:6512:1153:b0:533:466d:698c with SMTP id 2adb3069b0e04-53678feb525mr7075144e87.39.1726474123083;
        Mon, 16 Sep 2024 01:08:43 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da22b900esm69309465e9.1.2024.09.16.01.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 01:08:42 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 16 Sep 2024 10:08:30 +0200
Subject: [PATCH v2 01/11] ARM: dts: amlogic: meson6: fix clk81 node name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-1-0b20ed4f0571@linaro.org>
References: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-0-0b20ed4f0571@linaro.org>
In-Reply-To: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-0-0b20ed4f0571@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=885;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=pMewlYYDF9agGKPA3HCGL/qAhfwWWF/OUrcnBP2XiME=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm5+eEEKe9s41rFo1BlQuTVP892PJvMrTQAUrZfwSF
 twdCR0qJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZufnhAAKCRB33NvayMhJ0YhED/
 4vq3I8WXmal1J7yJ1RWWrrAYi2MRPxMzaGUvDUIq/Bt3h1NWlxmRXp7ZaVBIDUGPxM4uHpf3CvcoYL
 uIm8KhjU1AhLwlAEr+P4V6Y/CsbfvkhQU9SYSzmHUeLcfQn4PBrVIBOyx+ewE0ph/X6seeDwIt/2ny
 0ZPSDtSjBAxPtXkwoJlwj2Ap4HLbPt5J8ADYYU5dxARsai5bL2DIhIAwOY3vLdFUVQBR8r+uDI5+ds
 gbmzxrSAJM/mQljVCYZx/mEvEstnOt+lGQzoKqZzgwxTwzfxLZSkZ0+l60iJdLPTXwF9BpUZcQQgdP
 yy+pQCBXX8dbISkmeAFzwtyS493SOhIdkIgxR/8vQX0fdPSe/A7nxO1SCTx6qlkuwYKTkVpPyQ5htv
 YZJNTRaWRugVWJQ0E60YkuLmTCpSQtns+07Cut7gBKUPtdTDIesfwmoDGtc7g0R60Fd3Z2pJAqJ7/o
 q5oHlmZdDEBTCZyM1YdRu+0iWI5tBsMEYampbTzKVChIAlgBUn3bydhYDrBPk9DMZ+0KjNoidhFDGz
 anzJ8LUYJWMPTwrZA5oQeDnm9vWeu9Yo1O6nH3DabLSEdGu3ACmhEfYf8bo8izntm58dkp5TZngW2s
 8OmL1nxVqVtj1elkM37AG9Jiov5L6PaoRlzZJ4eswEVnVo7c1T2/8wHdtfkw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Use the proper node name, fixing:
arch/arm/boot/dts/amlogic/meson6-atv1200.dtb: /: clk@0: 'anyOf' conditional failed, one must be fixed:
	'reg' is a required property
	'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml#

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/boot/dts/amlogic/meson6.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/amlogic/meson6.dtsi b/arch/arm/boot/dts/amlogic/meson6.dtsi
index 4716030a48d0..1c4ea7266f66 100644
--- a/arch/arm/boot/dts/amlogic/meson6.dtsi
+++ b/arch/arm/boot/dts/amlogic/meson6.dtsi
@@ -36,7 +36,7 @@ apb2: bus@d0000000 {
 		ranges = <0x0 0xd0000000 0x40000>;
 	};
 
-	clk81: clk@0 {
+	clk81: clk81 {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <200000000>;

-- 
2.34.1


