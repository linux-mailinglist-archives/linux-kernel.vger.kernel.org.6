Return-Path: <linux-kernel+bounces-180945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D548C7548
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57BE51F2461D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127A7145A09;
	Thu, 16 May 2024 11:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b="KJHUUIku"
Received: from mx.adeep.su (mx.adeep.su [185.250.0.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB871145A0B;
	Thu, 16 May 2024 11:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.250.0.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715859113; cv=none; b=o9e7X0oyDvHL+E9Etps9pHC1g4MzNAgy7gF/GWVA+AR5aCt1AdrOE92uoHuMpL085BIrGeTH7iFCKnQ+HSxOarHDcMaEb5N+k0Dzxv2ZzpOT3iAd1MEUXMXgdVBEGeNz2z/X1vItonnzrRIjCqjV73HIMH8XIZ5TMRCPA81ofHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715859113; c=relaxed/simple;
	bh=M+mo9Y0CHfPVQLKoZETkdBfevQ2LMWQyIi/HAshdRT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMHjfDDarPCkTX9jk+yeXdbA3n+/jIY+SGnngDEYF5kcttHz6zec4Z7G+GqtezWHQD6wsHn8XcPDaGj2VItc1b4xoP3leUycY56KrplGtGzFhyp0aGJGzUJD9bLT8/+Y9v7N26PCrMrrV0lmZkVZ8G/6FHWbQiJf7v8bg0xW+Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in; spf=pass smtp.mailfrom=lexina.in; dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b=KJHUUIku; arc=none smtp.client-ip=185.250.0.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2AC6D181D4E;
	Thu, 16 May 2024 14:31:47 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1715859107; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=+UBrzMeNJuIEWIdnDs+QZQBlvEK3sk7AsllHTSelVpQ=;
	b=KJHUUIkuFggKkNXicjirmIFtaVHZGg5FPC2mBRdnou0pM5QdihSvTlOe8YW0FcZwjVAQPP
	uv+IsQ+vuUVRY3KiCo6js/RSRadNtAApvmKu0QD5aLQWdYGDZjNs+s3rm+ka5rUbZf0wLU
	0ZZk+OFqJ7CSlJ53AWX3zoCz+fGfvWfNuuII/8Tx/QZW+Hx/1UWQsQjrFhyWoaQqizBVJp
	DeYgYrLLh6XG8TGLwNNzMLySYxZA7jb1t5iCdgxgHgRK85Gz+dyMNHEvERNFvOGPQM+uoL
	kjnLrDkwJj2yXe046L+haIZnwjfHgRR8qm32VCce8f7SKtJXYe97oXDujyf1Ig==
From: Viacheslav Bocharov <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v4 4/4] arm64: dts: meson: add dts links to secure-monitor for soc driver in a1, axg, gx, g12
Date: Thu, 16 May 2024 14:26:51 +0300
Message-ID: <20240516112849.3803674-8-adeep@lexina.in>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240516112849.3803674-2-adeep@lexina.in>
References: <20240516112849.3803674-2-adeep@lexina.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add links to secure-monitor in soc driver section for A1, AXG, GX, G12
Amlogic family for use with meson-socinfo-sm driver.

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi         | 1 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi        | 1 +
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 1 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi         | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index c03e207ea6c5..d47f056117fc 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -407,6 +407,7 @@ hwrng: rng@5118 {
 			sec_AO: ao-secure@5a20 {
 				compatible = "amlogic,meson-gx-ao-secure", "syscon";
 				reg = <0x0 0x5a20 0x0 0x140>;
+				secure-monitor = <&sm>;
 				amlogic,has-chip-id;
 			};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 6d12b760b90f..45791ec6694a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1689,6 +1689,7 @@ mux {
 			sec_AO: ao-secure@140 {
 				compatible = "amlogic,meson-gx-ao-secure", "syscon";
 				reg = <0x0 0x140 0x0 0x140>;
+				secure-monitor = <&sm>;
 				amlogic,has-chip-id;
 			};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 9d5eab6595d0..a8c1c72543b7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -2026,6 +2026,7 @@ cec_AO: cec@100 {
 			sec_AO: ao-secure@140 {
 				compatible = "amlogic,meson-gx-ao-secure", "syscon";
 				reg = <0x0 0x140 0x0 0x140>;
+				secure-monitor = <&sm>;
 				amlogic,has-chip-id;
 			};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 2673f0dbafe7..656e08b3d872 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -471,6 +471,7 @@ cec_AO: cec@100 {
 			sec_AO: ao-secure@140 {
 				compatible = "amlogic,meson-gx-ao-secure", "syscon";
 				reg = <0x0 0x140 0x0 0x140>;
+				secure-monitor = <&sm>;
 				amlogic,has-chip-id;
 			};
 
-- 
2.43.2


