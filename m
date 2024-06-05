Return-Path: <linux-kernel+bounces-203224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D268FD80A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C968D1C21B21
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4FF1607BC;
	Wed,  5 Jun 2024 21:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KB9Z9poR"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006B215FA66;
	Wed,  5 Jun 2024 21:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717621257; cv=none; b=tyRGwRqivE6c9koDVP8Pg9zeXpGpkBy0aKevoOTEtPFLySUL9LdH8YRm+wyEZD0395jGvBWzSL6y4f5AGUBxkRs2j0bCYVoRcfilpSf800siY1ZznUx5q63ROh0MbFQ+o0u9wHJe/tpzaDbxBNEo+VkfyOI3RQWhgNBtpIsWUZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717621257; c=relaxed/simple;
	bh=XbbvUFHICWvu13gNhRXL0Fye9J8RtUmvNrF/SgzD6jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9LlInl5QLhu1Br8UpmHm2lb7uA3C94ZGvh+tlLV6d3tUjHS+lq/8VVgT9bB4fFrwTb9qFrWGWYMZpRyrjx6wW8IpgCa9QdxRl7b4PIU0ig5ZgOVd4X7SEvErkX2cE3jWKLbUSSei7H8ctFgs3w+EnJck1Km8fA1R++JzAiUzuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KB9Z9poR; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-354f14bd80cso214307f8f.1;
        Wed, 05 Jun 2024 14:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717621254; x=1718226054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhHtvxGUyohTCTNa+GzFt+gMuFh5QKejQOFzumSpgUQ=;
        b=KB9Z9poRg/PsZYJS60eqXIJSG98xhGjfSqUf58xWugUvYWtu8aU1uXB8axgSRjdl4L
         k7mUCXLiAe3vky+1ec2KxLkTQP3/gcpnvQ/JCoJQ9U+1ju+IIJQzgioWwbEp67wBSQ29
         Qwd7lcm7vAgbz8MYTTuvHHAoghjUBiz2YB+WjmYW5N/Qc4jmvjMwcczFTPfNw4Pzlr/I
         gt9RJC7bjRC8b3MCNDl7CC9SUV3D/R50gez8DL0qfzakRzH46UWJWH/2X0a9Ct6hq+we
         V8m/jWgJAYdXvFSodOxUUEc2BTcTwAFXXY7lR2i6HQNFaslnSaLIT29A4kdahhWXWDlp
         WkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717621254; x=1718226054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhHtvxGUyohTCTNa+GzFt+gMuFh5QKejQOFzumSpgUQ=;
        b=nyktjPKQDQgWoAjw+j1tIhH5DXrnVI9h6QOeRlXHVHjHgqOlbSxoVT99UmLxCRfwvS
         VR33XLqb7d5elowCsLMWrEh5EnUcVjgFcE5SG+ulUcyrcyXdSfyoDJC8gnP/8DTv/Hh6
         ktQuleQN49zS5gQ3cT9O1Ckq9wFKBKwZdryKTMxT2n0IuvdtmbmOkRNeLaUsoesgsWJV
         UOyKgyc0QJ6rA5fU6CkhcU6tGs3VClrTwfvpwVwGeVewEdaJMr3VH5VVUq9nnX3v2SrB
         WNk50crgpv3Bw0EAenITunz+rw9mVbuJvDdXz1xdxUKtqB/szhhO79Cb6vXEYoWCNKWu
         0OYw==
X-Forwarded-Encrypted: i=1; AJvYcCWOAq6MqDRzBDyjZaOEqzPLvc98p3XmOXsNScxoMliYtD0NdVpY6aW+u0B73OptkbZxtBd5W5W4KB553G51mi+iiRAq2zKMiDuSCaV4wqBtFFCVd0UGf68Ip4HPioG0CWu37qX7dG5nE5r39vVS5+dOhklX9/g6OzTSip1HwoLtU64I6Q==
X-Gm-Message-State: AOJu0Yzt+VVj0sTYy0cvyzAuA5Sb4ZfNiWpnuyOWZGucRWdMmiLngZ5T
	FIqNoMdU6xMvw0n4LVS+LHm43TIn2rN7K13C7/OPTE1XwFg57is=
X-Google-Smtp-Source: AGHT+IH/ErPZA9UlMKsmZDV/X1wnV/PWz8EhOEK3XFrFUKLnJNMrmKCwpJ2Mt6rxai/f8/VEUq6zvA==
X-Received: by 2002:a05:6000:1884:b0:35c:1961:899d with SMTP id ffacd0b85a97d-35e840754camr3384746f8f.27.1717621254251;
        Wed, 05 Jun 2024 14:00:54 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:5211:58fe:dfef:c48c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0d77sm15955721f8f.5.2024.06.05.14.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 14:00:53 -0700 (PDT)
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
Subject: [PATCH v2 5/5 RESEND] ARM: dts: rockchip: Add SFC for RK3128
Date: Wed,  5 Jun 2024 23:00:49 +0200
Message-ID: <20240605210049.232284-6-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240605210049.232284-1-knaerzche@gmail.com>
References: <20240605210049.232284-1-knaerzche@gmail.com>
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
changes since v1:
 - none

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


