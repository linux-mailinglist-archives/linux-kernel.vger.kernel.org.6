Return-Path: <linux-kernel+bounces-534452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7A0A466F8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968803B15F9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B9E223316;
	Wed, 26 Feb 2025 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R44ebBig"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E291224B16;
	Wed, 26 Feb 2025 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588411; cv=none; b=O41sxXwOSBlffAsUX5ZXDRI9sFt2mUD6cJ+8Kb+UWOtdHcmgZaHi0F/OWgPunRuuj0YKYtUNl39CxQdEDYgZFFizDmVbThBZMz79OS6H57a+04p4Zz7ihQv2dQndIkxXkuPQukP0L4xBEm9fP5SB4a9T8P761eV8eMbCVOvxc2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588411; c=relaxed/simple;
	bh=aGMEv09mgvOMWn0LVWhHooUpN8dKT5EsPlQPTtFVSQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UJ4cwdUmjxak5Z7VH0RPUCvcEYk0hFz9yrBVgvw6lB3fy73VcLS476eoJZu3Z6mHz8/tt3mvAzB2m/nqVxlCeb/s9Eq1rF90lXf+oHvFAGDOEp+AjmcIjhFHnn/0kLPv6abJwrtk7gbXCfjudNubRb2jnA5ZW7vFlupPNNkouGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R44ebBig; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f6287649eso5536013f8f.3;
        Wed, 26 Feb 2025 08:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740588408; x=1741193208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3oJX0NNej/zcXG8s4cxQRhfNdLEwQ8bXLo+d66KAIA=;
        b=R44ebBigpVfX8KciFNlfR++cTU5fKgLe4d4ghiurc5XnahZbdWKOaYsv+wGWz3xkbz
         30j2qCcY11q3pyZkUXycj1Y/BFuYow1kkxuYfSBTRj6EIJw+hoWpV6jOhbJRuWIptvJH
         K/ZZiGYoKkKDQ4Bz/detVFR3KESXvF8lbrGnGK2arOVhJg//RHPYoCHM7pbLo/kV3r+u
         MIGd784518ysqf5FLDKiMcCt5f1OpyG9hRWEsn14/iTE9o1BF/uIgV0RgFvYfzN9B/c/
         Fte5/B58/ulBk66bgIUswX9+16iNbIhojj0HmFtInXwI/iT2oMvDovyVnRu/EatWt4G3
         JisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740588408; x=1741193208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3oJX0NNej/zcXG8s4cxQRhfNdLEwQ8bXLo+d66KAIA=;
        b=PSu1KJdmbs0gHuuzmKtk8Gv2QGIPIwOQujhhHC6yws2bNVl8f19zE4s0DGwIJSIvZI
         RRdXGld4P/7iOF0yKkpanxfUN8SJIv38n3GdHxsG3nP9htyVTVIHdwhTXHrPQsFVwOIm
         32c5a0Ntauue7uowtUB77HNVmqvGf40mM/pHX7OoqXxj8UlA6p/891fVreeEp5Q1v0LK
         hVE2XVbVzKOpf5uBeMdo29EqfboUFrunQRdrahOZ0zzM4qzBzZgeVK16Fho2bXh7Tq1M
         YEcgARtriSZ8Mbet4DHDzhG8SaqqqsxIPfvHfIHUc5sRV1CJQ1lGFhIYSMiHeGpXL6Sy
         efbw==
X-Forwarded-Encrypted: i=1; AJvYcCVD5lR0i6i5MGirY8NMBq64jlQcPCdmSeul470pbdyh8e62Cdo8flO3pgVXIb0zUqtigJDqbQt2wp0ClUtv@vger.kernel.org, AJvYcCVe9oHgpnXp1B1rzSwMACQ62fe3vj/xGAJRfPcXOhH49O8UCf33QUXuejgrFf+0YFDGNJR5mQuNmi0e@vger.kernel.org, AJvYcCWRSkKt/tIZxwfQ8b4FeGc3IzDXluQTnmTyPS/WT6jE3VISBWUAATES7svO8aXXuk4UmG8eEe8OzRZF@vger.kernel.org
X-Gm-Message-State: AOJu0YyTC3BCb5xdMHrxmJI4rrA/Z+Ns7cj1+1/Iv6LmGRnN1Go+MFIo
	RGWOTWmPNd2zACnKo++SwTeifhqAZ7fSGs6M9479/6K81hUT824R
X-Gm-Gg: ASbGncukW0Tfu5MVUR6u+t3/98HFfj35ELo0Xt6/ORSHKzJS/BblCTqHQZafIThAKaE
	wQNb6pIw8EKQgr5gMlJUgoqvP0fn9fJZARwcQCp90FB1r0JCmCm2gVH9eyFX99lXlV7TwDxcER0
	d0E1caNB904sXfqe3BMrT/gjRNo8aUIaVZjwXurIUUt60CTJXI+OXBEU/rWEoyzq/U8PEVmcKTq
	FQ1UftoYoYAyBTu8eSHaTJG6+uP1kB5dL24gOWtsTFd4hPn50STE1I/GXbH0mHdb+fKTfeY3Eta
	lvW/BDJApmDR9fGOBQcnjI0lUYIP8+ag9zLtRTiRahbqJxCoi5Hb78XWHfHMtvvh
X-Google-Smtp-Source: AGHT+IH9PirezPUvo0SDYj6S58hBwzBVZ6Rl2C7V0n1gZp808ZMU/3QJOgAnoayYRlZbNnJBn4E/gQ==
X-Received: by 2002:a5d:6c61:0:b0:390:d76b:fbbf with SMTP id ffacd0b85a97d-390d76bfef9mr1679150f8f.4.1740588407321;
        Wed, 26 Feb 2025 08:46:47 -0800 (PST)
Received: from playground.localdomain ([188.25.208.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8e7165sm6200215f8f.73.2025.02.26.08.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 08:46:47 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Marek Vasut <marex@denx.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Adam Ford <aford173@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] arm64: dts: imx8mp: change AUDIO_AXI_CLK_ROOT freq. to 800MHz
Date: Wed, 26 Feb 2025 11:45:13 -0500
Message-Id: <20250226164513.33822-5-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226164513.33822-1-laurentiumihalcea111@gmail.com>
References: <20250226164513.33822-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

AUDIO_AXI_CLK_ROOT can't run at currently requested 600MHz w/ its parent
SYS_PLL1 configured at 800MHz. Configure it to run at 800MHz as some
applications running on the DSP expect the core to run at this frequency
anyways. This change also affects the AUDIOMIX NoC.

Fixes: b739681b3f8b ("arm64: dts: imx8mp: Fix SDMA2/3 clocks")
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 86c3055789ba..54147bce3b83 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -834,7 +834,7 @@ pgc_audio: power-domain@5 {
 						assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>,
 									 <&clk IMX8MP_SYS_PLL1_800M>;
 						assigned-clock-rates = <400000000>,
-								       <600000000>;
+								       <800000000>;
 					};
 
 					pgc_gpu2d: power-domain@6 {
-- 
2.34.1


