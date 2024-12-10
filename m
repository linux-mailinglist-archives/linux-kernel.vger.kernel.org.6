Return-Path: <linux-kernel+bounces-440043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3459EB7DC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38CBD16471D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9365A241F50;
	Tue, 10 Dec 2024 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="AB4H3d2Q"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762A2240379
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850655; cv=none; b=hvTGAChsQBw9x15R86mUzNzURsQW3SuMM2dnYcNb9YgBHNOVWz2pmQOa1kq7/vHzTjSFEpxxtowmqLq2+ag6QwsQ1kIUg+BoVkjNXp8Ox5aUWvoX/bcHO2hxFINOPuf5I/J5hOz50Wi8Q8nfbfZ0ENCoeypT8c734ewdan2kWR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850655; c=relaxed/simple;
	bh=8/PHs3hergaZwLujvAzPGvYQcQ9nR8hOIaSM9/vOn8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YWfo9E8EkLhjxRpXfag5xiuMa139JX3Mw/dij3g6JcF25X3NgriJzdFt/woANR7m9JdL5VdN3oEvum3j1wehGOUGAb1xEAuw/iSxRL97Sgc1njFKmkzbYiJXjLjFkDoHvzQqSWKqNX+J9Gcz4qkYjrXAM3at1s0LtsNHgxYfRw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=AB4H3d2Q; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d41848901bso2977716a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733850652; x=1734455452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbnqkT50sIwhXb4LpARwC8AegnQU36VT8IZg+EnVYck=;
        b=AB4H3d2QmUUS7e0l4duXv68N8unNjDfzowPK79rCaei43hqMG8q9H+JmheBZpZR13I
         cy5iLp3kSzVQkUO7hAJbBId9puM5t7FmqfmFBW0sQJBJMKPb6dkHuclCTxZ+57s/oouE
         5Bf/fgWgse2itV+sGrhoasJRF9LkS8c3kphy6c/Kc5IPEvKmoBTFElm/ULy/iXRmf373
         eltyS14NbO2FraEGaudz8kYcXt47zoAEfCfRbVcgQf2pXj6kYMjfqPgBdM///rh+47+8
         DBwArM7E9dBiARrBhbe8lH1a/q8Vb3zltrS0r6qxvFOYp81GAXzTJVttJ00qG4bI4MZr
         H0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733850652; x=1734455452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbnqkT50sIwhXb4LpARwC8AegnQU36VT8IZg+EnVYck=;
        b=TJllEg67HKT12+PMFbw9y756cqIk/E+2nvGYROojMzc/lNqGOctNmKsZd07PjjB1/w
         DgpDDw2Codg32BYvlenoR8J1VJK5cDlICjDtf1emQv11mwpOD4HaFybgkiNndkbYW6kh
         bthb+fAhK4LtjX7+gSPoPIz7li0wh0SQ8bualynIXFvU5pm7/dQ9e6UT337QnGrs5gsa
         WNMwcvPdy/xSNDdenMEkH0lN1fMvPCaE/jVNWIUTxysESe7y0X+2iUIcHkIsQyPatDBl
         1WK25/7FWtTdT5Hq3v2oPUe6f08UOVZ59XZsVK6keeP2bnNLsBme5mVa1EVM46Oz/oRK
         ovWA==
X-Forwarded-Encrypted: i=1; AJvYcCVgK0BFYYx4CiFbC01+PnLoyzOHga/R9y0J5ouwXbc1P2MTrp/DfWwXtkMfZshQtIjuZIwAHQmJcA7Tjlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWT39VAtw00IcXGayvHUkn662C7ygzWRXZvHDHUZ8DhAvHSBC+
	8SX+KFhE2W2aI740hk1BaJZGwiZ4+PLiBZRwsKFUtlXD0hZPw0YplP55k9iwvV0=
X-Gm-Gg: ASbGncsUFeP28y5az+5Z8sR4FaDYmplzNmedmhOvj242Mz7d39XKkrkx7Xey09BxaCN
	CCsdZxvst4bPTAa1i7r0W78xOqzQtCRjoXfHkwNvfApKNlIipodG9PuZEiJyprJXPvjx04RQmZT
	cJ7Pxn9C95ZvPseG84x497Dr/U1u0SSFnw4uQ1SljbnMN+wgOK7a2//0uFpt6CXNfJntaa/r/V+
	uICW0L+m3qM6B0k+aXj6s/swC52Yd0PmJDRfIeUC3EdrGXH6MSddAvu2DsZSB5qUhUTaDTgZlUw
	subOWkdbZU8=
X-Google-Smtp-Source: AGHT+IGhOq0ISs6UITM0F+o/rYn/y64cloP1K9d/mnU2rOj31uCI1nueqLaUR3TcQZ6R+M3PsUDCEA==
X-Received: by 2002:a05:6402:4308:b0:5d0:e9a8:4c96 with SMTP id 4fb4d7f45d1cf-5d41e2b4a25mr4157459a12.9.1733850651848;
        Tue, 10 Dec 2024 09:10:51 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3e7936581sm4853124a12.56.2024.12.10.09.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:10:51 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh+dt@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	magnus.damm@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	p.zabel@pengutronix.de,
	biju.das.jz@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 20/24] arm64: dts: renesas: r9a08g045: Add SSI nodes
Date: Tue, 10 Dec 2024 19:09:49 +0200
Message-Id: <20241210170953.2936724-21-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241210170953.2936724-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241210170953.2936724-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add DT nodes for the SSI IPs available on the Renesas RZ/G3S SoC. Along
with it external audio clocks were added. Board device tree could use it
and update the frequencies.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- s/audio-clk1/audio1-clk
- s/audio-clk2/audio2-clk
- dropped status for the audio clock nodes
- collected tags

Changes in v3:
- none

Changes in v2:
- none

 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 94 ++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index be8a0a768c65..0e06a4b96c64 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -14,6 +14,20 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	audio_clk1: audio1-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by boards that provide it. */
+		clock-frequency = <0>;
+	};
+
+	audio_clk2: audio2-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by boards that provide it. */
+		clock-frequency = <0>;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -187,6 +201,86 @@ i2c3: i2c@10090c00 {
 			status = "disabled";
 		};
 
+		ssi0: ssi@100a8000 {
+			compatible = "renesas,r9a08g045-ssi",
+				     "renesas,rz-ssi";
+			reg = <0 0x100a8000 0 0x400>;
+			interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 241 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 242 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx";
+			clocks = <&cpg CPG_MOD R9A08G045_SSI0_PCLK2>,
+				 <&cpg CPG_MOD R9A08G045_SSI0_PCLK_SFR>,
+				 <&audio_clk1>, <&audio_clk2>;
+			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
+			resets = <&cpg R9A08G045_SSI0_RST_M2_REG>;
+			dmas = <&dmac 0x2665>, <&dmac 0x2666>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
+		ssi1: ssi@100a8400 {
+			compatible = "renesas,r9a08g045-ssi",
+				     "renesas,rz-ssi";
+			reg = <0 0x100a8400 0 0x400>;
+			interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 244 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 245 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx";
+			clocks = <&cpg CPG_MOD R9A08G045_SSI1_PCLK2>,
+				 <&cpg CPG_MOD R9A08G045_SSI1_PCLK_SFR>,
+				 <&audio_clk1>, <&audio_clk2>;
+			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
+			resets = <&cpg R9A08G045_SSI1_RST_M2_REG>;
+			dmas = <&dmac 0x2669>, <&dmac 0x266a>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
+		ssi2: ssi@100a8800 {
+			compatible = "renesas,r9a08g045-ssi",
+				     "renesas,rz-ssi";
+			reg = <0 0x100a8800 0 0x400>;
+			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 247 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 248 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx";
+			clocks = <&cpg CPG_MOD R9A08G045_SSI2_PCLK2>,
+				 <&cpg CPG_MOD R9A08G045_SSI2_PCLK_SFR>,
+				 <&audio_clk1>, <&audio_clk2>;
+			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
+			resets = <&cpg R9A08G045_SSI2_RST_M2_REG>;
+			dmas = <&dmac 0x266d>, <&dmac 0x266e>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
+		ssi3: ssi@100a8c00 {
+			compatible = "renesas,r9a08g045-ssi",
+				     "renesas,rz-ssi";
+			reg = <0 0x100a8c00 0 0x400>;
+			interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 250 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 251 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx";
+			clocks = <&cpg CPG_MOD R9A08G045_SSI3_PCLK2>,
+				 <&cpg CPG_MOD R9A08G045_SSI3_PCLK_SFR>,
+				 <&audio_clk1>, <&audio_clk2>;
+			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
+			resets = <&cpg R9A08G045_SSI3_RST_M2_REG>;
+			dmas = <&dmac 0x2671>, <&dmac 0x2672>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
 		cpg: clock-controller@11010000 {
 			compatible = "renesas,r9a08g045-cpg";
 			reg = <0 0x11010000 0 0x10000>;
-- 
2.39.2


