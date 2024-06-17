Return-Path: <linux-kernel+bounces-218140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D9190B9AD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C487287A25
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64D2199239;
	Mon, 17 Jun 2024 18:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duVMtgfB"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1345E199220;
	Mon, 17 Jun 2024 18:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648986; cv=none; b=XqLoPLboKc+e5Bv0AusFagFGPGradgcHMhR0Bb6tqsiJe2wrEgdFSd/NXxMEp6Q39waJXuoGMegSgzib2KbqSQOmF50eHjSordSERtLJpofezWbnLxPI2QSYpisqQ0d76cDYxzGgXx2Dn7jTpsDwJkUGEsO0UtMho3lAlgjm4To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648986; c=relaxed/simple;
	bh=Lw6cvt6e5TFSBzp/kko3I8KOLayecFMagWIlbMmvaMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aOmbuRSdV9mE30kjU2gLpf6g7583Cwo1iUOzZK2qgp/CO0urdjEMhUowvYRuOvM7SmhGYrO6bNcj11FMfpjmo0ylxeuJlZ+PMZhTRs7lfsozAmBc1uQSuLU3ZAg64Bic3B+Yg+Xw9kOvp79YtZCOT3YsQZxRaCsVvJzOwJfbnS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duVMtgfB; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so83419131fa.0;
        Mon, 17 Jun 2024 11:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718648983; x=1719253783; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdw9hr2E9oUOwrjNMHx+TgoMIxb4y1m0pUnscfpkFu0=;
        b=duVMtgfB7Lfd1LOxz9Uay9Kb10Sm71Zd/mx7L9IhhpCGHKZEy3yoMcKr4taxfB+SnO
         jpH5/LRW3YecMgKvUGwHJMZvrAHpeM2Q4EQELqAKyOAAgOfhoGj6n+Le88Imy5lb86Un
         tpChdojAV6dEzPS+yn6ou7DLup2UR1Zk+UQUl8bSJXTlQ/uzZO/0FFIBkGEs72q3FlRQ
         cAbGAWL9EgWKWnYcdibC1uqqG5Bi4ZlrGTFh6sJCdc5Esnyx7IWg3zpOpszrhMjWuiag
         Q4Fqsg+3Oqc9igAFg0YOcwdBHOsXHbotCy1CqkCEzok07GA8jLFCXTap07QROu/c5X/3
         Ek1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718648983; x=1719253783;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdw9hr2E9oUOwrjNMHx+TgoMIxb4y1m0pUnscfpkFu0=;
        b=uzOusDg6UONuRgPAE41bt1V/zLhORhtGw1NBrvqCjet1RPMllWwWJBS2okYqodgQeb
         KvV8cpkeN4F61yH05qiScjTLOibpaNzz6WYOEbpz4ziVOXBiAxiE4nJinsdoP7efVlLa
         aHtBQUC/UmCi1VgQZmoT4G705ZSoXmhD1eFrZc2jd/4ZSwF2VwtRtR7H5fLSYlANFcC7
         H7pLV/sCIJ1MVtOXBSbrep+92a2KfISqPNVJLka/biIIb3tf9fLHgqg68ecz0R+3NPwG
         PkffUW7yznEN5VL0vyid/nQR3Gya16vG0ek0n2oaa2aP7vM+W5SPbQE7a7GZaqczE1wg
         gicA==
X-Forwarded-Encrypted: i=1; AJvYcCXTKFQbMgsVu68abfLch2or8cXIEUtWslV3KPwfIdehXrtbk0/wwDpLyeM93aLWzyo4nxwiWy6/m+X/zeGJbvQl85AZHj1sPsW9gsPIO+6wVh9rc1CO9D+G+Oy9BLxkPPH4bpaLp4TDFg==
X-Gm-Message-State: AOJu0Yw7tnK627QnlqLMY9nnW1fxBSFvf6dm/5NMbR9NNo3H+UQeEpTV
	U4kcxFept4y8DY/ylU7NqpJxeBBvy0j24LDuz1QMAgjecEzJWkEk
X-Google-Smtp-Source: AGHT+IFmxp/6V4QXIWhNMCK24m/K84kyHPGSSNIJ/eXuISr4o3JyAQAFAvwChhtA+6vFzZy1ZH4S/A==
X-Received: by 2002:a19:690b:0:b0:52c:8304:db31 with SMTP id 2adb3069b0e04-52ca6e67c17mr7849875e87.27.1718648983021;
        Mon, 17 Jun 2024 11:29:43 -0700 (PDT)
Received: from latitude-fedora.lan ([2001:8f8:183b:6864::d35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f8a6e58bdsm115397666b.187.2024.06.17.11.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 11:29:42 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 17 Jun 2024 22:28:55 +0400
Subject: [PATCH v5 5/8] arm64: dts: rockchip: Add CPU/memory regulator
 coupling for RK3588
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-rk-dts-additions-v5-5-c1f5f3267f1e@gmail.com>
References: <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com>
In-Reply-To: <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718648960; l=5927;
 i=alchark@gmail.com; s=20240125; h=from:subject:message-id;
 bh=Lw6cvt6e5TFSBzp/kko3I8KOLayecFMagWIlbMmvaMY=;
 b=QfA4GQWUTiwN1V7Ur5GD7HfKSzVBRXt2ENXTozT4AWKRGyFMO65b44VPlh7M5224KRGomKrcV
 mNfqhWvuQV0A8KZRhS8g0xLKAmrJjAr0Sin1g6LNQ3ywZ88nhRUBecG
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=xRO8VeD3J5jhwe0za0aHt2LDumQr8cm0Ls7Jz3YGimk=

RK3588 chips allow for their CPU cores to be powered by a different
supply vs. their corresponding memory interfaces, and two of the
boards currently upstream do that (EVB1 and QuartzPro64).

The voltage of the memory interface though has to match that of the
CPU cores that use it, which downstream kernels achieve by the means
of a custom cpufreq driver which adjusts both at the same time.

It seems that regulator coupling is a more appropriate generic
interface for it, so this patch introduces coupling to affected
device trees to ensure that memory interface voltage is also updated
whenever cpufreq switches between CPU OPPs.

Note that other boards, such as Radxa Rock 5B, define both the CPU
and memory interface regulators as aliases to the same DT node, so
this doesn't apply there.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts    | 12 ++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
index 7c3696a3ad3a..00f660d50127 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
@@ -878,6 +878,8 @@ regulators {
 			vdd_cpu_big1_s0: dcdc-reg1 {
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_big1_mem_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <550000>;
 				regulator-max-microvolt = <1050000>;
 				regulator-ramp-delay = <12500>;
@@ -890,6 +892,8 @@ regulator-state-mem {
 			vdd_cpu_big0_s0: dcdc-reg2 {
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_big0_mem_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <550000>;
 				regulator-max-microvolt = <1050000>;
 				regulator-ramp-delay = <12500>;
@@ -902,6 +906,8 @@ regulator-state-mem {
 			vdd_cpu_lit_s0: dcdc-reg3 {
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_lit_mem_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <550000>;
 				regulator-max-microvolt = <950000>;
 				regulator-ramp-delay = <12500>;
@@ -926,6 +932,8 @@ regulator-state-mem {
 			vdd_cpu_big1_mem_s0: dcdc-reg5 {
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_big1_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <675000>;
 				regulator-max-microvolt = <1050000>;
 				regulator-ramp-delay = <12500>;
@@ -939,6 +947,8 @@ regulator-state-mem {
 			vdd_cpu_big0_mem_s0: dcdc-reg6 {
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_big0_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <675000>;
 				regulator-max-microvolt = <1050000>;
 				regulator-ramp-delay = <12500>;
@@ -963,6 +973,8 @@ regulator-state-mem {
 			vdd_cpu_lit_mem_s0: dcdc-reg8 {
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_lit_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <675000>;
 				regulator-max-microvolt = <950000>;
 				regulator-ramp-delay = <12500>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts b/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
index b4f22d95ac0e..baeb08d665c7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
@@ -832,6 +832,8 @@ vdd_cpu_big1_s0: dcdc-reg1 {
 				regulator-name = "vdd_cpu_big1_s0";
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_big1_mem_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <550000>;
 				regulator-max-microvolt = <1050000>;
 				regulator-ramp-delay = <12500>;
@@ -845,6 +847,8 @@ vdd_cpu_big0_s0: dcdc-reg2 {
 				regulator-name = "vdd_cpu_big0_s0";
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_big0_mem_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <550000>;
 				regulator-max-microvolt = <1050000>;
 				regulator-ramp-delay = <12500>;
@@ -858,6 +862,8 @@ vdd_cpu_lit_s0: dcdc-reg3 {
 				regulator-name = "vdd_cpu_lit_s0";
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_lit_mem_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <550000>;
 				regulator-max-microvolt = <950000>;
 				regulator-ramp-delay = <12500>;
@@ -884,6 +890,8 @@ vdd_cpu_big1_mem_s0: dcdc-reg5 {
 				regulator-name = "vdd_cpu_big1_mem_s0";
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_big1_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <675000>;
 				regulator-max-microvolt = <1050000>;
 				regulator-ramp-delay = <12500>;
@@ -898,6 +906,8 @@ vdd_cpu_big0_mem_s0: dcdc-reg6 {
 				regulator-name = "vdd_cpu_big0_mem_s0";
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_big0_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <675000>;
 				regulator-max-microvolt = <1050000>;
 				regulator-ramp-delay = <12500>;
@@ -924,6 +934,8 @@ vdd_cpu_lit_mem_s0: dcdc-reg8 {
 				regulator-name = "vdd_cpu_lit_mem_s0";
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_lit_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <675000>;
 				regulator-max-microvolt = <950000>;
 				regulator-ramp-delay = <12500>;

-- 
2.45.2


