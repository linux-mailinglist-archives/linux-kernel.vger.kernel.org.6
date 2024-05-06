Return-Path: <linux-kernel+bounces-169584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1506F8BCAD3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F751F22303
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4391B142E9A;
	Mon,  6 May 2024 09:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FU10+24E"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA281142E7D;
	Mon,  6 May 2024 09:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988239; cv=none; b=lj0qo6wFeJBjH1eHVKq7EYqAmGpXy09ka0Lqj8TQyhfdHq58tGuJ3GaVCu5yfvcge732P/bipyypAtD39AFu+QtG6iTu/9inuSV8xNH5AQEPf2GEFI1ccAB1Wt3LgFaMSmMq7UjYvzMwwXFFPm6q+1pr1qfotE0Hq1Mj8ZoQaU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988239; c=relaxed/simple;
	bh=lraF8Hbej6o/vzD2ibMl+sD1o6QIvu8qx6CUPylhTS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i6f3sbBWLW5S7hUUaDrRw2wr5eIOh56JCOb5k+f3PDoRnGLFl2YtpdjcqgD4s+M+cWERUhGHtPR8Bfk/kjWMS5PPcgfbwqn9uwO7f/aaXgRRoHfL1F7xysXGCLnRxzbrzWIW7RAUMHHF6RSAV4OFjAOzijqMgTKPVGkRY08fbbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FU10+24E; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59c5c9c6aeso220845866b.2;
        Mon, 06 May 2024 02:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714988236; x=1715593036; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6QUAJdxvdjJF0g4Iedvv3W5jbeIoEk4V3HwGZq9hD1M=;
        b=FU10+24EdRQaUWlbJrRxETS9FwTXW/ZuQxm8hcex2dF8C0rfUek3W1x8I+2PdAYK1j
         9cNVg2+4McxkHTG1EXbLnYUwCxiFll4PqFNtSCUqABgj5Iij8C51sPacJVdN/8EhtZV/
         TvKAX51txIUAA2u9CC8InN472si4LNWKVivl546JUxYTSz5I1K4filyoJ98PuWEVTc/0
         mLBtUENtkvL01TU7419ZVU4Zf8ryijLG3byYJl0fJd61I7wBpYSyRa+GBTnuxpKuhZ7M
         r0IgP/2XpnhdwIpYFLRZ5zGAJNSabEMF4I7brjqHLTesCJowk/DZyPVbq0Ett1kiqpPf
         JevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714988236; x=1715593036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QUAJdxvdjJF0g4Iedvv3W5jbeIoEk4V3HwGZq9hD1M=;
        b=AUXFMs36abF/OKRLG4xxGVto0PmRZ7g8pqImm0KCi1hBP+tSFqrYcwZlHYqolJCE1m
         seVKn8t9/yhxX1JZTcuacM5OJWv9OljvGpZkzdZQ8hkSsmNh+k5l0PYvF0Z89n0DblLt
         GCTxNwXIDHTRB+EOaeNrwh3p97izp3mLqB3CkBj/TsaAcB/OXO1FzH2SwtjjjOMyt54L
         NsoewkgccJqGreF36wm15zrHlO+Gn88s1E1GSTDEak66enyGbln5Dylhu/27x74gDLDa
         mRsmZbazodT4ByiJH1zJDAk51s8pcE244ZwnVRakyUFMGq6xBrUEexsEZte16j2xeJiK
         ckRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn+g496C6APZsfndVnQOX/kIhSkB3H75JJoXNHUrf1XDaYqBMD1SfnneWUfe97cDXx3MOe89XiDv0lYx6JNN2Z5pmUWxOryUHXJXRiGxTzmOuXeRnY2dwTU2P6/xN1GES1ncZS8dKczw==
X-Gm-Message-State: AOJu0YyYmTOi/emDZB9WPnSnmf7Fr7Y0Qify6bAFLjs5/nMlaGiu1gze
	OPB6t/xfCdZ+Oz/5AMEp7TyTYUhxuG80b7GyMhiYN/1ndiGahZ9M
X-Google-Smtp-Source: AGHT+IEpoDThqBrXD8AVnT5RjXcFvvech0tAE2sx6cAOPOuHnZuctTfwzvyaGhf+wUdbkeccEPLO0w==
X-Received: by 2002:a50:a699:0:b0:572:42ac:9b19 with SMTP id e25-20020a50a699000000b0057242ac9b19mr6652365edc.0.1714988236054;
        Mon, 06 May 2024 02:37:16 -0700 (PDT)
Received: from [172.30.32.119] ([2001:8f8:183b:f2c::d35])
        by smtp.gmail.com with ESMTPSA id f6-20020a056402160600b005722ce89ae2sm4983647edv.38.2024.05.06.02.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 02:37:15 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 06 May 2024 13:36:33 +0400
Subject: [PATCH v4 2/6] arm64: dts: rockchip: enable thermal management on
 all RK3588 boards
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-rk-dts-additions-v4-2-271023ddfd40@gmail.com>
References: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
In-Reply-To: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Dragan Simic <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Diederik de Haas <didi.debian@cknow.org>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714988224; l=4390;
 i=alchark@gmail.com; s=20240125; h=from:subject:message-id;
 bh=lraF8Hbej6o/vzD2ibMl+sD1o6QIvu8qx6CUPylhTS0=;
 b=L+SmgqiZUWX1QlD1lAl8Fvx6rg3te0i8Dfivs/4C85qKwq5x8IqH2l/yBUMfv+hG0SscnqBb5
 /rqtiXXtC+xCIsVzjy5l4iHbWTkC4rlKbTBgxQjs9K1pcoxUz13N3BS
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=xRO8VeD3J5jhwe0za0aHt2LDumQr8cm0Ls7Jz3YGimk=

This enables the on-chip thermal monitoring sensor (TSADC) on all
RK3588(s) boards that don't have it enabled yet. It provides temperature
monitoring for the SoC and emergency thermal shutdowns, and is thus
important to have in place before CPU DVFS is enabled, as high CPU
operating performance points can overheat the chip quickly in the
absence of thermal management.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts          | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-common.dtsi | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts              | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts              | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts               | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-toybrick-x0.dts           | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi           | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts              | 4 ++++
 8 files changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts b/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts
index 98c622b27647..c667704ba985 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts
@@ -673,6 +673,10 @@ regulator-state-mem {
 	};
 };
 
+&tsadc {
+	status = "okay";
+};
+
 &u2phy0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-common.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-common.dtsi
index 709d348cf06b..03fd193be253 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-common.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-common.dtsi
@@ -466,3 +466,7 @@ regulator-state-mem {
 		};
 	};
 };
+
+&tsadc {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
index 7be2190244ba..7c3696a3ad3a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
@@ -1131,6 +1131,10 @@ &sata0 {
 	status = "okay";
 };
 
+&tsadc {
+	status = "okay";
+};
+
 &u2phy0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts b/arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts
index 009566d881f3..230e630820b4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts
@@ -376,6 +376,10 @@ &sdmmc {
 	status = "okay";
 };
 
+&tsadc {
+	status = "okay";
+};
+
 &u2phy2 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index b8e15b76a8a6..21e96c212dd8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -742,6 +742,10 @@ regulator-state-mem {
 	};
 };
 
+&tsadc {
+	status = "okay";
+};
+
 &uart2 {
 	pinctrl-0 = <&uart2m0_xfer>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-toybrick-x0.dts b/arch/arm64/boot/dts/rockchip/rk3588-toybrick-x0.dts
index 9090c5c99f2a..d0021524e7f9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-toybrick-x0.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-toybrick-x0.dts
@@ -648,6 +648,10 @@ regulator-state-mem {
 	};
 };
 
+&tsadc {
+	status = "okay";
+};
+
 &u2phy2 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
index 6b9206ce4a03..77bcf0f6b028 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
@@ -601,6 +601,10 @@ regulator-state-mem {
 	};
 };
 
+&tsadc {
+	status = "okay";
+};
+
 &uart2 {
 	pinctrl-0 = <&uart2m0_xfer>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
index 8e2a07612d17..c671a61d3aef 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
@@ -697,6 +697,10 @@ regulator-state-mem {
 	};
 };
 
+&tsadc {
+	status = "okay";
+};
+
 &u2phy0 {
 	status = "okay";
 };

-- 
2.45.0


