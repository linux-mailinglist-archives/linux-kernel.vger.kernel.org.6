Return-Path: <linux-kernel+bounces-203206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A538E8FD7DE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A24B1F252E4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC89F15FD04;
	Wed,  5 Jun 2024 20:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X55v9jYn"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F78415F3F0;
	Wed,  5 Jun 2024 20:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717620738; cv=none; b=IJR+jI+rXZdZ0FOJpxTsdi1xUgwGntoih80RLUrwppAKswywCzmM0Mo+Fvghzqz0Rby2gqjroEsi3AgabT8CgLZPwhiZu4IsZskMrTVdC2dcbqJhgL1zePq8Mwfvaqf3c7UtQI/rg+ZdtD2fyU3KnCdtjkVwoMHj7RfKHR0FNDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717620738; c=relaxed/simple;
	bh=AQXObQDUzMQES1hvJtdiEAsAUh5MhWHJcqhhTYjm7jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJGbs/sB3JPM5KDwxL0taNgaTKO+UCzGxSUC3xE+tDDZLIZ5SmoENaQPpFKYju/VCa/oLUFEVjnDpvhz+RuApSmV8/LLIIh72B+WqTuhDPbGcCEZ+64wNDLjSSWRNNFhDV5Y/6sT4Oowh9a+bWST5YgQOW5Vb6lzA/HXQl1tXUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X55v9jYn; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a68c5524086so27359966b.3;
        Wed, 05 Jun 2024 13:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717620735; x=1718225535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSnrzfQSI7FFWe4M7p38YadUmYRLzv+fLcrRvYhlfvQ=;
        b=X55v9jYn/U4VqqnvR31mAsZqOPeRe7nH2Yo2pc3VFZSEIZF27mZmYk9CVPsapKDwvY
         2oODrOFGUUztNtnTN9FYxZF90CD7OwbK6aUAHQYVjY4OaFh4n1FJbDb9e+3ox0cKJaLU
         zHN4QqVUWDap/Y7OxuUytWGadJgN7+DV0Y9Xq8/GLIpYM8BFxxVzj1jgirwXm3XoR0ct
         2tfh80YLQGcS36GvEcSqxM/kzXasQIGTXkJ/O1KX7y/beLlcIZE8dsLX8wUVEYbWkgch
         Y+vE4Z4PylQH/1Ca9gLQtuZpqPnFJnXJ80AbmWxbcNZP8pWq8pZgVQRpiQP02GnxXURM
         PdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717620735; x=1718225535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSnrzfQSI7FFWe4M7p38YadUmYRLzv+fLcrRvYhlfvQ=;
        b=j4+cyIkB0qJ5V1LWHCAUIYxn96cPaqlAmwG7EvsmLTPJCYdHJHPtFDG5/TlK2a5M/e
         OfpXN0HVuUuQCtECjf7i7ebVncFdihunpiCf2YCWOFRiQT0aPHOZr3K19JyR700o0zNy
         J4Vb9Rnpcgv9ysTInXxWPGoc1AbWjpbVXAjYSRLir73ElX9vD82RUwRZ76xbO87YkfZf
         Nxh8pP3zHjSxCu9WoDud4Lp77WqT8JxT8/6Y4eQYVeauXgw5SqRdzcRcFSx8RUuOBxA6
         Q4BCre2ZUF0ERPHWMRznayJP4x8kvvNXCKTAGcBiCCP2gU7Uv49HAtiBE1KporcEAgUm
         +rgA==
X-Forwarded-Encrypted: i=1; AJvYcCWMejT+DpBjlNa82g5dOElWScKT+5Jdmr8pB8Tjuz02dW7/pGM91D94xrEgGy3zsSl7Vp7kP4PGYMB4ouhT2fch4lv+7/4ihFR2wBW/gxXqBDmPh11y1v8xIWQlO7KAdcc1WcC49CLYmlL3Wd0yNv9bv/R0vlnZwAJmSIdDkMjF3aUTng==
X-Gm-Message-State: AOJu0YwPiyYcwckgIKx/JOpHX0J18X0TLHA4XxMtxeGM83p2OQ9Fzek2
	embyirMU19zc0u8Z7pLshSaR6cQeERlTOAaYROf84Z2+pzRql/E=
X-Google-Smtp-Source: AGHT+IG14C4lSL+BhQzWiuSl+VxUO7QhT+hrjfkE58eBpjAdO85Xvli+57deBqfwo6LwhRefFCQAIw==
X-Received: by 2002:a17:906:ca57:b0:a68:eacd:2b38 with SMTP id a640c23a62f3a-a699f663ffdmr240503266b.23.1717620734864;
        Wed, 05 Jun 2024 13:52:14 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:5211:58fe:dfef:c48c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c71bb5affsm72265866b.147.2024.06.05.13.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 13:52:14 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 5/5] ARM: dts: rockchip: Add SFC for RK3128
Date: Wed,  5 Jun 2024 22:52:03 +0200
Message-ID: <20240605205209.232005-5-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240605205209.232005-1-knaerzche@gmail.com>
References: <20240605205209.232005-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Serial Flash Controller and it's pincontrols.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3128.dtsi | 35 ++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index a7ab0904564f..22e2a35dedb1 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -399,6 +399,15 @@ usb_host_ohci: usb@101e0000 {
 		status = "disabled";
 	};
 
+	sfc: spi@1020c000 {
+		compatible = "rockchip,sfc";
+		reg = <0x1020c000 0x8000>;
+		interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_SFC>, <&cru HCLK_SFC>;
+		clock-names = "clk_sfc", "hclk_sfc";
+		status = "disabled";
+	};
+
 	sdmmc: mmc@10214000 {
 		compatible = "rockchip,rk3128-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x10214000 0x4000>;
@@ -1155,6 +1164,32 @@ sdmmc_bus4: sdmmc-bus4 {
 			};
 		};
 
+		sfc {
+			sfc_bus2: sfc-bus2 {
+				rockchip,pins = <1 RK_PD0 3 &pcfg_pull_default>,
+						<1 RK_PD1 3 &pcfg_pull_default>;
+			};
+
+			sfc_bus4: sfc-bus4 {
+				rockchip,pins = <1 RK_PD0 3 &pcfg_pull_default>,
+						<1 RK_PD1 3 &pcfg_pull_default>,
+						<1 RK_PD2 3 &pcfg_pull_default>,
+						<1 RK_PD3 3 &pcfg_pull_default>;
+			};
+
+			sfc_clk: sfc-clk {
+				rockchip,pins = <2 RK_PA4 3 &pcfg_pull_none>;
+			};
+
+			sfc_cs0: sfc-cs0 {
+				rockchip,pins = <2 RK_PA2 3 &pcfg_pull_default>;
+			};
+
+			sfc_cs1: sfc-cs1 {
+				rockchip,pins = <2 RK_PA3 3 &pcfg_pull_default>;
+			};
+		};
+
 		spdif {
 			spdif_tx: spdif-tx {
 				rockchip,pins = <3 RK_PD3 1 &pcfg_pull_none>;
-- 
2.45.2


