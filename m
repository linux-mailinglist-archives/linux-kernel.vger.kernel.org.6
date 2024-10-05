Return-Path: <linux-kernel+bounces-352150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F82991AB7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 22:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D2521F230EE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E2415C120;
	Sat,  5 Oct 2024 20:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDUZZyWP"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04D618E1F;
	Sat,  5 Oct 2024 20:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728160825; cv=none; b=Kfspc82exJ9NColpxDlO4KOj+SMzyabBX4E1WtFhDyWyV7kbtKAj5EJY7PPID91wNzB3nC/I80A1tbFcbzvpTJbauThvolw5jA2L/qaBAcsKotJ9wNpOzUYnppl/V8V7Scixjw1buWdU87R3iP2WJ5mKqyvrLuwApF3q3IHe32s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728160825; c=relaxed/simple;
	bh=8efZH2ekb4JeO+8WdYnc9uz42bGBqroz9N/a2tc+Sd0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eEGBb37sQUMJ1s2TPqopnCQjCGvNdpD1B8JHrRn59A8HzEMCXkIuFYAYiCNN5mD9VE9MJSKnsa7a6MOuLywvkHanxT7n4gMISlhQlIQb0TnKB0nObhLlJ5JCg0RaqieM12k0/WKgYS8pzsASACQhCAvLDhdlUGLAoIIhLaiHZF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDUZZyWP; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c8e8d65709so86413a12.2;
        Sat, 05 Oct 2024 13:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728160816; x=1728765616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l8lRxBTrqpy1Lx106ry4t6CK+D629kYBOWj0GlEen5I=;
        b=EDUZZyWPXuVcYfcVxeyVZMTt2aGMo36MhrE/wkXQ44qKnM/w3Yco7oSTV3HP3RqBWJ
         JmchfGwaNCh0PR4i/SybEEURLEH5YpQ8/kvskm433q7Rf/4bnVaRjtZyHC8DvsRs6U3u
         jX5VQg1iXX6tCzzDPdzGDCAMarfAw4DvHOQ6RNcpkPlpVSzU6lD6l6GZRYVx/4yCRZi2
         UsrnZ7jq+9tk6WvPioLXNxQ2XgXHosPoNI3VsagMv3BJy9Q7evuElHFCAxjiwIU5HN/k
         kkFadJYAPVVd7uZtk7LpFI3LzfwAkLvIdu/3cvuO2pej9fsJxqYtFRCeSC5TIXoxH4A/
         HlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728160816; x=1728765616;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8lRxBTrqpy1Lx106ry4t6CK+D629kYBOWj0GlEen5I=;
        b=jDvPs6fianTOF0g9Ckh1JmeGCNyjlOq3SQC5dcH44k91m7L8CK8U/K+VRSUMoi03YL
         Ummz1o6FQgVc55MxSGePIEBpRF9SpYnZoyw1vGLz7sezl1+St8DsseT7PbZdOeCZzP26
         Q/D122dD9btGg7+xX3qgTqOnzsFK576HQXNJQz2LtWEduUsPFxqoARAJ/JjUlo+Z7Yth
         OeTN+0yOQDxocEBnenwp5TORj6ogIgTCvfOPEgBjwvaMRE8S+iTwFUdEZyRf34bfA36R
         mqiqXeJ2KaCP6PNeZnlUZHyVCROQQbvq4pzOU+/X87cNAp2aNJ//XcSvP6ErkpcIdP8l
         Bf3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnlVLTkNXEwEPU9rrxK7QMW1ZvKPDCzC6p4gzvPGLU9zu+T/mUnwcnkWXXQYuEZ8Kmcbx+WvgjP5HVOWkb@vger.kernel.org, AJvYcCX1jaexY/yBdx7nSmQ3dOKcUUvShTskZTeUHI0Og9lILVYN8TnmYPbwxbW2OZoQbZwcnE828fvOj19K@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0RVvxoSpn7OGEr9wUUwyhGwm4XohNKtHtp1y43Xg3Q5naREjG
	8iFRzmWMJajvpp+w69ZIQY9abnWvm3b45Fd6OvNrUfxvI1MGHfMhDn2buA==
X-Google-Smtp-Source: AGHT+IEfSddV7njsxH21FN7A9m00iavZ7y9x48mnHRkz42h8US1Q/puIRC2CLQ+yMssbyJZBNes5vA==
X-Received: by 2002:a05:6402:3507:b0:5c8:8381:c0f9 with SMTP id 4fb4d7f45d1cf-5c8d2d00bc2mr2455165a12.2.1728160815148;
        Sat, 05 Oct 2024 13:40:15 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983? ([2a02:a449:4071:1:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05c119esm1397166a12.55.2024.10.05.13.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 13:40:14 -0700 (PDT)
Message-ID: <0ae40493-93e9-40cd-9ca9-990ae064f21a@gmail.com>
Date: Sat, 5 Oct 2024 22:40:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 2/2] arm64: dts: rockchip: fix nodename regulators
To: heiko@sntech.de
Cc: robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cfc3cfe1-086b-48f1-9b89-f17c9391d3cc@gmail.com>
Content-Language: en-US
In-Reply-To: <cfc3cfe1-086b-48f1-9b89-f17c9391d3cc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The nodename for fixed-regulators has changed to
pattern: '^regulator(-[0-9]+v[0-9]+|-[0-9a-z-]+)?$'

Fix all Rockchip DT regulator nodenames.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

regulator: dt-bindings: fixed-regulator: Add a preferred node name
https://lore.kernel.org/r/20240426215147.3138211-1-robh@kernel.org
---
 .../dts/rockchip/px30-engicam-common.dtsi     |  4 +--
 arch/arm64/boot/dts/rockchip/px30-evb.dts     |  2 +-
 .../dts/rockchip/px30-firefly-jd4-core-mb.dts |  4 +--
 .../dts/rockchip/px30-firefly-jd4-core.dtsi   |  2 +-
 .../dts/rockchip/px30-ringneck-haikou.dts     | 10 +++----
 .../boot/dts/rockchip/px30-ringneck.dtsi      |  2 +-
 arch/arm64/boot/dts/rockchip/rk3308-evb.dts   | 20 ++++++-------
 .../arm64/boot/dts/rockchip/rk3308-roc-cc.dts | 12 ++++----
 .../boot/dts/rockchip/rk3308-rock-pi-s.dts    | 14 +++++-----
 .../boot/dts/rockchip/rk3318-a95x-z2.dts      | 12 ++++----
 .../dts/rockchip/rk3326-anbernic-rg351m.dtsi  |  2 +-
 .../dts/rockchip/rk3326-gameforce-chi.dts     |  2 +-
 .../boot/dts/rockchip/rk3326-odroid-go.dtsi   |  4 +--
 arch/arm64/boot/dts/rockchip/rk3328-a1.dts    |  4 +--
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts   |  8 +++---
 .../boot/dts/rockchip/rk3328-nanopi-r2s.dts   |  8 +++---
 .../dts/rockchip/rk3328-orangepi-r1-plus.dts  |  6 ++--
 .../arm64/boot/dts/rockchip/rk3328-roc-cc.dts | 12 ++++----
 .../boot/dts/rockchip/rk3328-rock-pi-e.dts    |  8 +++---
 .../arm64/boot/dts/rockchip/rk3328-rock64.dts |  6 ++--
 arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi  |  6 ++--
 .../boot/dts/rockchip/rk3368-geekbox.dts      |  2 +-
 .../boot/dts/rockchip/rk3368-lba3368.dts      | 14 +++++-----
 .../boot/dts/rockchip/rk3368-lion-haikou.dts  |  6 ++--
 arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi |  2 +-
 .../dts/rockchip/rk3368-orion-r68-meta.dts    | 18 ++++++------
 .../boot/dts/rockchip/rk3368-px5-evb.dts      |  2 +-
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts   | 14 +++++-----
 .../boot/dts/rockchip/rk3399-eaidk-610.dts    | 16 +++++------
 arch/arm64/boot/dts/rockchip/rk3399-evb.dts   | 12 ++++----
 .../boot/dts/rockchip/rk3399-firefly.dts      | 16 +++++------
 .../dts/rockchip/rk3399-gru-chromebook.dtsi   | 22 +++++++--------
 .../boot/dts/rockchip/rk3399-gru-kevin.dts    |  4 +--
 .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi | 20 ++++++-------
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  | 20 ++++++-------
 .../boot/dts/rockchip/rk3399-hugsun-x99.dts   | 18 ++++++------
 .../boot/dts/rockchip/rk3399-khadas-edge.dtsi | 14 +++++-----
 .../dts/rockchip/rk3399-kobol-helios64.dts    | 28 +++++++++----------
 .../boot/dts/rockchip/rk3399-leez-p710.dts    | 14 +++++-----
 .../boot/dts/rockchip/rk3399-nanopc-t4.dts    |  4 +--
 .../boot/dts/rockchip/rk3399-nanopi-m4.dts    |  8 +++---
 .../boot/dts/rockchip/rk3399-nanopi-neo4.dts  |  6 ++--
 .../boot/dts/rockchip/rk3399-nanopi-r4s.dts   |  2 +-
 .../boot/dts/rockchip/rk3399-nanopi4.dtsi     | 14 +++++-----
 .../boot/dts/rockchip/rk3399-orangepi.dts     | 16 +++++------
 .../boot/dts/rockchip/rk3399-pinebook-pro.dts | 26 ++++++++---------
 .../dts/rockchip/rk3399-pinephone-pro.dts     | 12 ++++----
 .../boot/dts/rockchip/rk3399-puma-haikou.dts  | 12 ++++----
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 14 +++++-----
 .../dts/rockchip/rk3399-roc-pc-mezzanine.dts  |  6 ++--
 .../boot/dts/rockchip/rk3399-roc-pc-plus.dts  |  2 +-
 .../boot/dts/rockchip/rk3399-roc-pc.dtsi      | 20 ++++++-------
 .../boot/dts/rockchip/rk3399-rock-4c-plus.dts | 12 ++++----
 .../boot/dts/rockchip/rk3399-rock-pi-4.dtsi   | 18 ++++++------
 .../boot/dts/rockchip/rk3399-rock960.dtsi     | 14 +++++-----
 .../boot/dts/rockchip/rk3399-rockpro64.dtsi   | 22 +++++++--------
 .../boot/dts/rockchip/rk3399-sapphire.dtsi    | 16 +++++------
 .../dts/rockchip/rk3399pro-vmarc-som.dtsi     |  2 +-
 .../boot/dts/rockchip/rk3566-lubancat-1.dts   | 12 ++++----
 .../boot/dts/rockchip/rk3566-pinenote.dtsi    | 14 +++++-----
 .../boot/dts/rockchip/rk3566-pinetab2.dtsi    | 18 ++++++------
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 18 ++++++------
 .../boot/dts/rockchip/rk3566-quartz64-b.dts   | 12 ++++----
 .../boot/dts/rockchip/rk3566-radxa-cm3-io.dts |  6 ++--
 .../boot/dts/rockchip/rk3566-radxa-cm3.dtsi   |  8 +++---
 .../arm64/boot/dts/rockchip/rk3566-roc-pc.dts | 12 ++++----
 .../boot/dts/rockchip/rk3566-rock-3c.dts      | 16 +++++------
 .../dts/rockchip/rk3566-soquartz-blade.dts    |  6 ++--
 .../boot/dts/rockchip/rk3566-soquartz-cm4.dts |  6 ++--
 .../dts/rockchip/rk3566-soquartz-model-a.dts  | 10 +++----
 .../boot/dts/rockchip/rk3566-soquartz.dtsi    |  6 ++--
 .../boot/dts/rockchip/rk3568-bpi-r2-pro.dts   | 22 +++++++--------
 .../boot/dts/rockchip/rk3568-evb1-v10.dts     | 16 +++++------
 .../dts/rockchip/rk3568-fastrhino-r66s.dtsi   | 10 +++----
 .../boot/dts/rockchip/rk3568-lubancat-2.dts   | 16 +++++------
 .../boot/dts/rockchip/rk3568-nanopi-r5s.dtsi  | 18 ++++++------
 .../boot/dts/rockchip/rk3568-odroid-m1.dts    | 12 ++++----
 .../boot/dts/rockchip/rk3568-radxa-cm3i.dtsi  | 10 +++----
 .../boot/dts/rockchip/rk3568-radxa-e25.dts    | 10 +++----
 .../arm64/boot/dts/rockchip/rk3568-roc-pc.dts | 18 ++++++------
 .../boot/dts/rockchip/rk3568-rock-3a.dts      | 26 ++++++++---------
 .../dts/rockchip/rk3568-wolfvision-pf5.dts    | 12 ++++----
 .../boot/dts/rockchip/rk3588-armsom-lm7.dtsi  |  4 +--
 .../boot/dts/rockchip/rk3588-armsom-sige7.dts | 10 +++----
 .../boot/dts/rockchip/rk3588-armsom-w3.dts    |  8 +++---
 .../dts/rockchip/rk3588-coolpi-cm5-evb.dts    | 12 ++++----
 .../rockchip/rk3588-coolpi-cm5-genbook.dts    | 14 +++++-----
 .../boot/dts/rockchip/rk3588-coolpi-cm5.dtsi  |  8 +++---
 .../rockchip/rk3588-edgeble-neu6a-common.dtsi |  6 ++--
 .../dts/rockchip/rk3588-edgeble-neu6a-io.dtsi |  8 +++---
 .../boot/dts/rockchip/rk3588-evb1-v10.dts     | 22 +++++++--------
 .../boot/dts/rockchip/rk3588-fet3588-c.dtsi   | 12 ++++----
 .../arm64/boot/dts/rockchip/rk3588-jaguar.dts | 20 ++++++-------
 .../dts/rockchip/rk3588-nanopc-t6-lts.dts     |  2 +-
 .../boot/dts/rockchip/rk3588-nanopc-t6.dts    |  2 +-
 .../boot/dts/rockchip/rk3588-nanopc-t6.dtsi   | 18 ++++++------
 .../boot/dts/rockchip/rk3588-ok3588-c.dts     | 14 +++++-----
 .../dts/rockchip/rk3588-orangepi-5-plus.dts   | 10 +++----
 .../boot/dts/rockchip/rk3588-quartzpro64.dts  | 14 +++++-----
 .../boot/dts/rockchip/rk3588-rock-5b.dts      | 12 ++++----
 .../boot/dts/rockchip/rk3588-tiger-haikou.dts | 14 +++++-----
 .../arm64/boot/dts/rockchip/rk3588-tiger.dtsi |  6 ++--
 .../boot/dts/rockchip/rk3588-toybrick-x0.dts  | 20 ++++++-------
 .../boot/dts/rockchip/rk3588-turing-rk1.dtsi  |  6 ++--
 .../boot/dts/rockchip/rk3588s-coolpi-4b.dts   | 20 ++++++-------
 .../dts/rockchip/rk3588s-gameforce-ace.dts    | 10 +++----
 .../dts/rockchip/rk3588s-indiedroid-nova.dts  | 12 ++++----
 .../dts/rockchip/rk3588s-khadas-edge2.dts     | 10 +++----
 .../boot/dts/rockchip/rk3588s-nanopi-r6s.dts  | 16 +++++------
 .../boot/dts/rockchip/rk3588s-orangepi-5.dts  |  8 +++---
 .../boot/dts/rockchip/rk3588s-rock-5a.dts     | 12 ++++----
 111 files changed, 630 insertions(+), 630 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi b/arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi
index 5b4e22385165..1edfd643b25a 100644
--- a/arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi
@@ -12,7 +12,7 @@ aliases {
 		mmc2 = &sdio;
 	};

-	vcc5v0_sys: vcc5v0-sys {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";	/* +5V */
 		regulator-always-on;
@@ -42,7 +42,7 @@ vcc3v3_btreg: vcc3v3-btreg {
 		states = <3300000 0x0>;
 	};

-	vcc3v3_rf_aux_mod: vcc3v3-rf-aux-mod {
+	vcc3v3_rf_aux_mod: regulator-vcc3v3-rf-aux-mod {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_rf_aux_mod";
 		regulator-min-microvolt = <3300000>;
diff --git a/arch/arm64/boot/dts/rockchip/px30-evb.dts b/arch/arm64/boot/dts/rockchip/px30-evb.dts
index 0a90a88fc664..2d190cbfe1f0 100644
--- a/arch/arm64/boot/dts/rockchip/px30-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-evb.dts
@@ -89,7 +89,7 @@ sdio_pwrseq: sdio-pwrseq {
 		reset-gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>; /* GPIO3_A4 */
 	};

-	vcc5v0_sys: vccsys {
+	vcc5v0_sys: regulator-vccsys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/px30-firefly-jd4-core-mb.dts b/arch/arm64/boot/dts/rockchip/px30-firefly-jd4-core-mb.dts
index d03e6aef54dc..5e3c10d825a0 100644
--- a/arch/arm64/boot/dts/rockchip/px30-firefly-jd4-core-mb.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-firefly-jd4-core-mb.dts
@@ -24,7 +24,7 @@ chosen {
 		stdout-path = "serial2:115200n8";
 	};

-	dc_12v: dc-12v-regulator {
+	dc_12v: regulator-dc-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "dc_12v";
 		regulator-always-on;
@@ -85,7 +85,7 @@ sdio_pwrseq: sdio-pwrseq {
 		reset-gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>; /* GPIO3_A4 */
 	};

-	vcc5v0_baseboard: vcc5v0-baseboard-regulator {
+	vcc5v0_baseboard: regulator-vcc5v0-baseboard {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_baseboard";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/px30-firefly-jd4-core.dtsi b/arch/arm64/boot/dts/rockchip/px30-firefly-jd4-core.dtsi
index f18d7eb9a9c7..848d0d0b0784 100644
--- a/arch/arm64/boot/dts/rockchip/px30-firefly-jd4-core.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-firefly-jd4-core.dtsi
@@ -17,7 +17,7 @@ emmc_pwrseq: emmc-pwrseq {
 		reset-gpios = <&gpio1 RK_PB3 GPIO_ACTIVE_HIGH>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
index ae398acdcf45..e4517f47d519 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
@@ -90,7 +90,7 @@ sgtl5000_clk: sgtl5000-oscillator {
 		clock-frequency = <24576000>;
 	};

-	dc_12v: dc-12v-regulator {
+	dc_12v: regulator-dc-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "dc_12v";
 		regulator-always-on;
@@ -99,7 +99,7 @@ dc_12v: dc-12v-regulator {
 		regulator-max-microvolt = <12000000>;
 	};

-	vcc3v3_baseboard: vcc3v3-baseboard-regulator {
+	vcc3v3_baseboard: regulator-vcc3v3-baseboard {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_baseboard";
 		regulator-always-on;
@@ -109,7 +109,7 @@ vcc3v3_baseboard: vcc3v3-baseboard-regulator {
 		vin-supply = <&dc_12v>;
 	};

-	vcc5v0_baseboard: vcc5v0-baseboard-regulator {
+	vcc5v0_baseboard: regulator-vcc5v0-baseboard {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_baseboard";
 		regulator-always-on;
@@ -119,7 +119,7 @@ vcc5v0_baseboard: vcc5v0-baseboard-regulator {
 		vin-supply = <&dc_12v>;
 	};

-	vdda_codec: vdda-codec-regulator {
+	vdda_codec: regulator-vdda-codec {
 		compatible = "regulator-fixed";
 		regulator-name = "vdda_codec";
 		regulator-boot-on;
@@ -128,7 +128,7 @@ vdda_codec: vdda-codec-regulator {
 		vin-supply = <&vcc5v0_baseboard>;
 	};

-	vddd_codec: vddd-codec-regulator {
+	vddd_codec: regulator-vddd-codec {
 		compatible = "regulator-fixed";
 		regulator-name = "vddd_codec";
 		regulator-boot-on;
diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
index 06ef40d292bf..cc42b4b73093 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
@@ -43,7 +43,7 @@ module_led: led-0 {
 		};
 	};

-	vcc5v0_sys: vccsys-regulator {
+	vcc5v0_sys: regulator-vccsys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3308-evb.dts b/arch/arm64/boot/dts/rockchip/rk3308-evb.dts
index 184b84fdde07..3f1aafe2dc13 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3308-evb.dts
@@ -84,7 +84,7 @@ key-power {
 		};
 	};

-	vcc12v_dcin: vcc12v-dcin {
+	vcc12v_dcin: regulator-vcc12v-dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
 		regulator-min-microvolt = <12000000>;
@@ -93,7 +93,7 @@ vcc12v_dcin: vcc12v-dcin {
 		regulator-boot-on;
 	};

-	vcc5v0_sys: vcc5v0-sys {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-min-microvolt = <5000000>;
@@ -103,7 +103,7 @@ vcc5v0_sys: vcc5v0-sys {
 		vin-supply = <&vcc12v_dcin>;
 	};

-	vccio_sdio: vcc_1v8: vcc-1v8 {
+	vccio_sdio: vcc_1v8: regulator-vcc-1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_1v8";
 		regulator-min-microvolt = <1800000>;
@@ -113,7 +113,7 @@ vccio_sdio: vcc_1v8: vcc-1v8 {
 		vin-supply = <&vcc_io>;
 	};

-	vcc_ddr: vcc-ddr {
+	vcc_ddr: regulator-vcc-ddr {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_ddr";
 		regulator-min-microvolt = <1500000>;
@@ -123,7 +123,7 @@ vcc_ddr: vcc-ddr {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc_io: vcc-io {
+	vcc_io: regulator-vcc-io {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_io";
 		regulator-min-microvolt = <3300000>;
@@ -133,7 +133,7 @@ vcc_io: vcc-io {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vccio_flash: vccio-flash {
+	vccio_flash: regulator-vccio-flash {
 		compatible = "regulator-fixed";
 		regulator-name = "vccio_flash";
 		regulator-min-microvolt = <3300000>;
@@ -143,7 +143,7 @@ vccio_flash: vccio-flash {
 		vin-supply = <&vcc_io>;
 	};

-	vcc5v0_host: vcc5v0-host {
+	vcc5v0_host: regulator-vcc5v0-host {
 		compatible = "regulator-fixed";
 		gpio = <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
@@ -153,7 +153,7 @@ vcc5v0_host: vcc5v0-host {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vdd_core: vdd-core {
+	vdd_core: regulator-vdd-core {
 		compatible = "pwm-regulator";
 		pwms = <&pwm0 0 5000 1>;
 		regulator-name = "vdd_core";
@@ -165,7 +165,7 @@ vdd_core: vdd-core {
 		pwm-supply = <&vcc5v0_sys>;
 	};

-	vdd_log: vdd-log {
+	vdd_log: regulator-vdd-log {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_log";
 		regulator-min-microvolt = <1050000>;
@@ -175,7 +175,7 @@ vdd_log: vdd-log {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vdd_1v0: vdd-1v0 {
+	vdd_1v0: regulator-vdd-1v0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_1v0";
 		regulator-min-microvolt = <1000000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts b/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
index 9232357f4fec..63f9e59d5b2c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
@@ -49,7 +49,7 @@ user_led: led-1 {
 		};
 	};

-	typec_vcc5v: typec-vcc5v {
+	typec_vcc5v: regulator-typec-vcc5v {
 		compatible = "regulator-fixed";
 		regulator-name = "typec_vcc5v";
 		regulator-min-microvolt = <5000000>;
@@ -58,7 +58,7 @@ typec_vcc5v: typec-vcc5v {
 		regulator-boot-on;
 	};

-	vcc5v0_sys: vcc5v0-sys {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-min-microvolt = <5000000>;
@@ -68,7 +68,7 @@ vcc5v0_sys: vcc5v0-sys {
 		vin-supply = <&typec_vcc5v>;
 	};

-	vcc_io: vcc-io {
+	vcc_io: regulator-vcc-io {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_io";
 		regulator-min-microvolt = <3300000>;
@@ -89,7 +89,7 @@ vcc_sdmmc: vcc-sdmmc {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc_sd: vcc-sd {
+	vcc_sd: regulator-vcc-sd {
 		compatible = "regulator-fixed";
 		gpio = <&gpio4 RK_PD6 GPIO_ACTIVE_LOW>;
 		regulator-name = "vcc_sd";
@@ -100,7 +100,7 @@ vcc_sd: vcc-sd {
 		vin-supply = <&vcc_io>;
 	};

-	vdd_core: vdd-core {
+	vdd_core: regulator-vdd-core {
 		compatible = "pwm-regulator";
 		pwms = <&pwm0 0 5000 1>;
 		regulator-name = "vdd_core";
@@ -112,7 +112,7 @@ vdd_core: vdd-core {
 		pwm-supply = <&vcc5v0_sys>;
 	};

-	vdd_log: vdd-log {
+	vdd_log: regulator-vdd-log {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_log";
 		regulator-min-microvolt = <1050000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts b/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
index 62d18ca769a1..7a32972bc249 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
@@ -55,7 +55,7 @@ sdio_pwrseq: sdio-pwrseq {
 		reset-gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
 	};

-	vcc_1v8: vcc-1v8 {
+	vcc_1v8: regulator-vcc-1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_1v8";
 		regulator-always-on;
@@ -65,7 +65,7 @@ vcc_1v8: vcc-1v8 {
 		vin-supply = <&vcc_io>;
 	};

-	vcc_io: vcc-io {
+	vcc_io: regulator-vcc-io {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_io";
 		regulator-always-on;
@@ -75,7 +75,7 @@ vcc_io: vcc-io {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc_ddr: vcc-ddr {
+	vcc_ddr: regulator-vcc-ddr {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_ddr";
 		regulator-always-on;
@@ -85,7 +85,7 @@ vcc_ddr: vcc-ddr {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_otg: vcc5v0-otg {
+	vcc5v0_otg: regulator-vcc5v0-otg {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
@@ -96,7 +96,7 @@ vcc5v0_otg: vcc5v0-otg {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_sys: vcc5v0-sys {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -105,7 +105,7 @@ vcc5v0_sys: vcc5v0-sys {
 		regulator-max-microvolt = <5000000>;
 	};

-	vdd_core: vdd-core {
+	vdd_core: regulator-vdd-core {
 		compatible = "pwm-regulator";
 		pwms = <&pwm0 0 5000 1>;
 		pwm-supply = <&vcc5v0_sys>;
@@ -117,7 +117,7 @@ vdd_core: vdd-core {
 		regulator-boot-on;
 	};

-	vdd_log: vdd-log {
+	vdd_log: regulator-vdd-log {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_log";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts b/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
index c7b1862fca6a..a94114fb7cc1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
@@ -78,7 +78,7 @@ spdif_out: spdif-out {
 	};

 	/* Power tree */
-	vccio_1v8: vccio-1v8-regulator {
+	vccio_1v8: regulator-vccio-1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "vccio_1v8";
 		regulator-min-microvolt = <1800000>;
@@ -86,7 +86,7 @@ vccio_1v8: vccio-1v8-regulator {
 		regulator-always-on;
 	};

-	vccio_3v3: vccio-3v3-regulator {
+	vccio_3v3: regulator-vccio-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vccio_3v3";
 		regulator-min-microvolt = <3300000>;
@@ -94,7 +94,7 @@ vccio_3v3: vccio-3v3-regulator {
 		regulator-always-on;
 	};

-	vcc_otg_vbus: otg-vbus-regulator {
+	vcc_otg_vbus: regulator-otg-vbus {
 		compatible = "regulator-fixed";
 		gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
 		pinctrl-0 = <&otg_vbus_drv>;
@@ -105,7 +105,7 @@ vcc_otg_vbus: otg-vbus-regulator {
 		enable-active-high;
 	};

-	vcc_sd: sdmmc-regulator {
+	vcc_sd: regulator-sdmmc {
 		compatible = "regulator-fixed";
 		gpio = <&gpio0 RK_PD6 GPIO_ACTIVE_LOW>;
 		pinctrl-0 = <&sdmmc0m1_pin>;
@@ -116,7 +116,7 @@ vcc_sd: sdmmc-regulator {
 		vin-supply = <&vccio_3v3>;
 	};

-	vdd_arm: vdd-arm {
+	vdd_arm: regulator-vdd-arm {
 		compatible = "pwm-regulator";
 		pwms = <&pwm0 0 5000 1>;
 		regulator-name = "vdd_arm";
@@ -127,7 +127,7 @@ vdd_arm: vdd-arm {
 		regulator-boot-on;
 	};

-	vdd_log: vdd-log {
+	vdd_log: regulator-vdd-log {
 		compatible = "pwm-regulator";
 		pwms = <&pwm1 0 5000 1>;
 		regulator-name = "vdd_log";
diff --git a/arch/arm64/boot/dts/rockchip/rk3326-anbernic-rg351m.dtsi b/arch/arm64/boot/dts/rockchip/rk3326-anbernic-rg351m.dtsi
index b6d041dbed94..79c28b34ba2c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3326-anbernic-rg351m.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3326-anbernic-rg351m.dtsi
@@ -70,7 +70,7 @@ simple-audio-card,cpu {
 		};
 	};

-	vccsys: vccsys {
+	vccsys: regulator-vccsys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v8_sys";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3326-gameforce-chi.dts b/arch/arm64/boot/dts/rockchip/rk3326-gameforce-chi.dts
index 579261b3a474..738ff555d3ee 100644
--- a/arch/arm64/boot/dts/rockchip/rk3326-gameforce-chi.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3326-gameforce-chi.dts
@@ -292,7 +292,7 @@ sdio_pwrseq: sdio-pwrseq {
 		reset-gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
 	};

-	vccsys: vccsys-regulator {
+	vccsys: regulator-vccsys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v8_sys";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go.dtsi b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go.dtsi
index 80fc53c807a4..7ec152a405c6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go.dtsi
@@ -165,7 +165,7 @@ simple-audio-card,cpu {
 		};
 	};

-	vccsys: vccsys {
+	vccsys: regulator-vccsys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v8_sys";
 		regulator-always-on;
@@ -173,7 +173,7 @@ vccsys: vccsys {
 		regulator-max-microvolt = <3800000>;
 	};

-	vcc_host: vcc_host {
+	vcc_host: regulator-vcc-host {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_host";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-a1.dts b/arch/arm64/boot/dts/rockchip/rk3328-a1.dts
index 824183e515da..e2d3e925bab3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-a1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-a1.dts
@@ -36,7 +36,7 @@ gmac_clkin: external-gmac-clock {
 		#clock-cells = <0>;
 	};

-	vcc_host_5v: usb3-current-switch {
+	vcc_host_5v: regulator-usb3-current-switch {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PA0 GPIO_ACTIVE_HIGH>;
@@ -46,7 +46,7 @@ vcc_host_5v: usb3-current-switch {
 		vin-supply = <&vcc_sys>;
 	};

-	vcc_sys: vcc-sys {
+	vcc_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
index 1eef5504445f..b1ed080aa928 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
@@ -21,7 +21,7 @@ chosen {
 		stdout-path = "serial2:1500000n8";
 	};

-	dc_12v: dc-12v {
+	dc_12v: regulator-dc-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "dc_12v";
 		regulator-always-on;
@@ -44,7 +44,7 @@ sdio_pwrseq: sdio-pwrseq {
 		reset-gpios = <&gpio1 18 GPIO_ACTIVE_LOW>;
 	};

-	vcc_sd: sdmmc-regulator {
+	vcc_sd: regulator-sdmmc {
 		compatible = "regulator-fixed";
 		gpio = <&gpio0 30 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
@@ -55,7 +55,7 @@ vcc_sd: sdmmc-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	vcc_sys: vcc-sys {
+	vcc_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-always-on;
@@ -65,7 +65,7 @@ vcc_sys: vcc-sys {
 		vin-supply = <&dc_12v>;
 	};

-	vcc_phy: vcc-phy-regulator {
+	vcc_phy: regulator-vcc-phy {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_phy";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
index a4399da7d8b1..d8d6e1fbcaa3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
@@ -65,7 +65,7 @@ wan_led: led-2 {
 		};
 	};

-	vcc_io_sdio: sdmmcio-regulator {
+	vcc_io_sdio: regulator-sdmmcio {
 		compatible = "regulator-gpio";
 		enable-active-high;
 		gpios = <&gpio1 RK_PD4 GPIO_ACTIVE_HIGH>;
@@ -83,7 +83,7 @@ vcc_io_sdio: sdmmcio-regulator {
 		vin-supply = <&vcc_io_33>;
 	};

-	vcc_sd: sdmmc-regulator {
+	vcc_sd: regulator-sdmmc {
 		compatible = "regulator-fixed";
 		gpio = <&gpio0 RK_PD6 GPIO_ACTIVE_LOW>;
 		pinctrl-0 = <&sdmmc0m1_pin>;
@@ -95,7 +95,7 @@ vcc_sd: sdmmc-regulator {
 		vin-supply = <&vcc_io_33>;
 	};

-	vdd_5v: vdd-5v {
+	vdd_5v: regulator-vdd-5v {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_5v";
 		regulator-always-on;
@@ -104,7 +104,7 @@ vdd_5v: vdd-5v {
 		regulator-max-microvolt = <5000000>;
 	};

-	vdd_5v_lan: vdd-5v-lan {
+	vdd_5v_lan: regulator-vdd-5v-lan {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio2 RK_PC6 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
index f20662929c77..c93c1a5af136 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
@@ -56,7 +56,7 @@ led-2 {
 		};
 	};

-	vcc_sd: sdmmc-regulator {
+	vcc_sd: regulator-sdmmc {
 		compatible = "regulator-fixed";
 		gpio = <&gpio0 RK_PD6 GPIO_ACTIVE_LOW>;
 		pinctrl-0 = <&sdmmc0m1_pin>;
@@ -66,7 +66,7 @@ vcc_sd: sdmmc-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	vcc_sys: vcc-sys-regulator {
+	vcc_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-always-on;
@@ -75,7 +75,7 @@ vcc_sys: vcc-sys-regulator {
 		regulator-max-microvolt = <5000000>;
 	};

-	vdd_5v_lan: vdd-5v-lan-regulator {
+	vdd_5v_lan: regulator-vdd-5v-lan {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio2 RK_PC6 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
index 414897a57e75..8e4c02de7680 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
@@ -27,7 +27,7 @@ gmac_clkin: external-gmac-clock {
 		#clock-cells = <0>;
 	};

-	dc_12v: dc-12v {
+	dc_12v: regulator-dc-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "dc_12v";
 		regulator-always-on;
@@ -36,7 +36,7 @@ dc_12v: dc-12v {
 		regulator-max-microvolt = <12000000>;
 	};

-	vcc_sd: sdmmc-regulator {
+	vcc_sd: regulator-sdmmc {
 		compatible = "regulator-fixed";
 		gpio = <&gpio0 RK_PD6 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
@@ -48,7 +48,7 @@ vcc_sd: sdmmc-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	vcc_sdio: sdmmcio-regulator {
+	vcc_sdio: regulator-sdmmcio {
 		compatible = "regulator-gpio";
 		gpios = <&grf_gpio 0 GPIO_ACTIVE_HIGH>;
 		states = <1800000 0x1>,
@@ -61,7 +61,7 @@ vcc_sdio: sdmmcio-regulator {
 		vin-supply = <&vcc_sys>;
 	};

-	vcc_host1_5v: vcc_otg_5v: vcc-host1-5v-regulator {
+	vcc_host1_5v: vcc_otg_5v: regulator-vcc-host1-5v {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
@@ -72,7 +72,7 @@ vcc_host1_5v: vcc_otg_5v: vcc-host1-5v-regulator {
 		vin-supply = <&vcc_sys>;
 	};

-	vcc_sys: vcc-sys {
+	vcc_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-always-on;
@@ -82,7 +82,7 @@ vcc_sys: vcc-sys {
 		vin-supply = <&dc_12v>;
 	};

-	vcc_phy: vcc-phy-regulator {
+	vcc_phy: regulator-vcc-phy {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_phy";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
index 3e08e2fd0a78..dda97cab9bcd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
@@ -64,7 +64,7 @@ led-0 {
 		};
 	};

-	vcc_sd: sdmmc-regulator {
+	vcc_sd: regulator-sdmmc {
 		compatible = "regulator-fixed";
 		gpio = <&gpio0 RK_PD6 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
@@ -74,7 +74,7 @@ vcc_sd: sdmmc-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	vcc_host_5v: vcc-host-5v-regulator {
+	vcc_host_5v: regulator-vcc-host-5v {
 		compatible = "regulator-fixed";
 		gpio = <&gpio3 RK_PA7 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
@@ -86,7 +86,7 @@ vcc_host_5v: vcc-host-5v-regulator {
 		vin-supply = <&vcc_sys>;
 	};

-	vcc_sys: vcc-sys {
+	vcc_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-always-on;
@@ -95,7 +95,7 @@ vcc_sys: vcc-sys {
 		regulator-max-microvolt = <5000000>;
 	};

-	vcc_wifi: vcc-wifi-regulator {
+	vcc_wifi: regulator-vcc-wifi {
 		compatible = "regulator-fixed";
 		gpio = <&gpio0 RK_PA0 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 90fef766f3ae..770fe4ba5953 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -27,7 +27,7 @@ gmac_clkin: external-gmac-clock {
 		#clock-cells = <0>;
 	};

-	vcc_sd: sdmmc-regulator {
+	vcc_sd: regulator-sdmmc {
 		compatible = "regulator-fixed";
 		gpio = <&gpio0 RK_PD6 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
@@ -39,7 +39,7 @@ vcc_sd: sdmmc-regulator {
 	};

 	/* Common enable line for all of the rails mentioned in the labels */
-	vcc_host_5v: vcc_host1_5v: vcc_otg_5v: vcc-host-5v-regulator {
+	vcc_host_5v: vcc_host1_5v: vcc_otg_5v: regulator-vcc-host-5v {
 		compatible = "regulator-fixed";
 		gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
@@ -50,7 +50,7 @@ vcc_host_5v: vcc_host1_5v: vcc_otg_5v: vcc-host-5v-regulator {
 		vin-supply = <&vcc_sys>;
 	};

-	vcc_sys: vcc-sys {
+	vcc_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi b/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
index e5c0dbf794ae..8662494a44d5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
@@ -85,7 +85,7 @@ key-power {
 	};

 	/* supplies both host and otg */
-	vcc_host: vcc-host-regulator {
+	vcc_host: regulator-vcc-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
@@ -97,7 +97,7 @@ vcc_host: vcc-host-regulator {
 		vin-supply = <&vcc_sys>;
 	};

-	vcc_lan: vcc-lan-regulator {
+	vcc_lan: regulator-vcc-lan {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_lan";
 		regulator-min-microvolt = <3300000>;
@@ -107,7 +107,7 @@ vcc_lan: vcc-lan-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	vcc_sys: vcc-sys-regulator {
+	vcc_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
index 029b8e22e709..9ef8c85e0da2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
@@ -68,7 +68,7 @@ red_led: led-1 {
 		};
 	};

-	vcc_sys: vcc-sys-regulator {
+	vcc_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-lba3368.dts b/arch/arm64/boot/dts/rockchip/rk3368-lba3368.dts
index e0cc4da7f392..7474721e5f8d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-lba3368.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-lba3368.dts
@@ -64,7 +64,7 @@ analog-sound {
 		pinctrl-0 = <&hp_det>;
 	};

-	dc_12v: dc-12v-regulator {
+	dc_12v: regulator-dc-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "dc_12v";
 		regulator-min-microvolt = <12000000>;
@@ -80,7 +80,7 @@ ext_gmac: gmac-clk {
 		#clock-cells = <0>;
 	};

-	hub_avdd: hub-avdd-regulator {
+	hub_avdd: regulator-hub-avdd {
 		compatible = "regulator-fixed";
 		regulator-name = "hub_avdd";
 		regulator-min-microvolt = <3300000>;
@@ -111,7 +111,7 @@ sdio_pwrseq: sdio-pwrseq {
 		pinctrl-0 = <&wifi_reg_on>;
 	};

-	vcc_host: vcc-host-regulator {
+	vcc_host: regulator-vcc-host {
 		compatible = "regulator-fixed";
 		gpio = <&gpio3 RK_PC1 GPIO_ACTIVE_HIGH>;
 		regulator-name = "vcc_host";
@@ -124,7 +124,7 @@ vcc_host: vcc-host-regulator {
 		regulator-always-on;
 	};

-	vcc_lan: vcc-lan-regulator {
+	vcc_lan: regulator-vcc-lan {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_lan";
 		regulator-min-microvolt = <3300000>;
@@ -133,7 +133,7 @@ vcc_lan: vcc-lan-regulator {
 		regulator-always-on;
 	};

-	vcc_otg: vcc-otg-regulator {
+	vcc_otg: regulator-vcc-otg {
 		compatible = "regulator-fixed";
 		gpio = <&gpio0 RK_PC1 GPIO_ACTIVE_HIGH>;
 		regulator-name = "vcc_otg";
@@ -146,7 +146,7 @@ vcc_otg: vcc-otg-regulator {
 		regulator-always-on;
 	};

-	vcc_sys: vcc-sys-regulator {
+	vcc_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-min-microvolt = <5000000>;
@@ -156,7 +156,7 @@ vcc_sys: vcc-sys-regulator {
 		regulator-boot-on;
 	};

-	vdd10_usb: vdd10-usb-regulator {
+	vdd10_usb: regulator-vdd10-usb {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd10_usb";
 		regulator-min-microvolt = <1000000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts
index cae01d35b93d..ab70ee5f561a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts
@@ -38,7 +38,7 @@ sd_card_led: led-3 {
 		};
 	};

-	dc_12v: dc-12v {
+	dc_12v: regulator-dc-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "dc_12v";
 		regulator-always-on;
@@ -47,7 +47,7 @@ dc_12v: dc-12v {
 		regulator-max-microvolt = <12000000>;
 	};

-	vcc3v3_baseboard: vcc3v3-baseboard {
+	vcc3v3_baseboard: regulator-vcc3v3-baseboard {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_baseboard";
 		regulator-always-on;
@@ -57,7 +57,7 @@ vcc3v3_baseboard: vcc3v3-baseboard {
 		vin-supply = <&dc_12v>;
 	};

-	vcc5v0_otg: vcc5v0-otg-regulator {
+	vcc5v0_otg: regulator-vcc5v0-otg {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PD4 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi b/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
index 8ac8acf4082d..c75f42a29f86 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
@@ -97,7 +97,7 @@ module_led2: led-2 {
 		};
 	};

-	vcc_sys: vcc-sys-regulator {
+	vcc_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts b/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
index 23ae2d9de382..abef858e7cea 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
@@ -73,7 +73,7 @@ blue_led: led-1 {
 		};
 	};

-	vcc_18: vcc18-regulator {
+	vcc_18: regulator-vcc18 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_18";
 		regulator-min-microvolt = <1800000>;
@@ -84,7 +84,7 @@ vcc_18: vcc18-regulator {
 	};

 	/* supplies both host and otg */
-	vcc_host: vcc-host-regulator {
+	vcc_host: regulator-vcc-host {
 		compatible = "regulator-fixed";
 		gpio = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
@@ -95,7 +95,7 @@ vcc_host: vcc-host-regulator {
 		vin-supply = <&vcc_sys>;
 	};

-	vcc_io: vcc-io-regulator {
+	vcc_io: regulator-vcc-io {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_io";
 		regulator-min-microvolt = <3300000>;
@@ -105,7 +105,7 @@ vcc_io: vcc-io-regulator {
 		vin-supply = <&vcc_sys>;
 	};

-	vcc_lan: vcc-lan-regulator {
+	vcc_lan: regulator-vcc-lan {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_lan";
 		regulator-min-microvolt = <3300000>;
@@ -115,7 +115,7 @@ vcc_lan: vcc-lan-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	vcc_sd: vcc-sd-regulator {
+	vcc_sd: regulator-vcc-sd {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sd";
 		gpio = <&gpio3 RK_PB3 GPIO_ACTIVE_LOW>;
@@ -124,7 +124,7 @@ vcc_sd: vcc-sd-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	vcc_sys: vcc-sys-regulator {
+	vcc_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-min-microvolt = <5000000>;
@@ -133,7 +133,7 @@ vcc_sys: vcc-sys-regulator {
 		regulator-boot-on;
 	};

-	vccio_sd: vcc-io-sd-regulator {
+	vccio_sd: regulator-vcc-io-sd {
 		compatible = "regulator-fixed";
 		regulator-name = "vccio_sd";
 		regulator-min-microvolt = <1800000>;
@@ -143,7 +143,7 @@ vccio_sd: vcc-io-sd-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	vccio_wl: vccio-wl-regulator {
+	vccio_wl: regulator-vccio-wl {
 		compatible = "regulator-fixed";
 		regulator-name = "vccio_wl";
 		regulator-min-microvolt = <3300000>;
@@ -153,7 +153,7 @@ vccio_wl: vccio-wl-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	vdd_10: vdd-10-regulator {
+	vdd_10: regulator-vdd-10 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_10";
 		regulator-min-microvolt = <1000000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts b/arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts
index 29df84b81552..68dcf8828edf 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts
@@ -38,7 +38,7 @@ key-power {
 		};
 	};

-	vcc_sys: vcc-sys-regulator {
+	vcc_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
index 7f14206d53c3..b73100c6d182 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
@@ -79,7 +79,7 @@ sdio_pwrseq: sdio-pwrseq {
 			<&gpio3 RK_PA4 GPIO_ACTIVE_LOW>;
 	};

-	vcc_18: vcc18-regulator {
+	vcc_18: regulator-vcc18 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_18";
 		regulator-min-microvolt = <1800000>;
@@ -90,7 +90,7 @@ vcc_18: vcc18-regulator {
 	};

 	/* supplies both host and otg */
-	vcc_host: vcc-host-regulator {
+	vcc_host: regulator-vcc-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
@@ -102,7 +102,7 @@ vcc_host: vcc-host-regulator {
 		vin-supply = <&vcc_sys>;
 	};

-	vcc_io: vcc-io-regulator {
+	vcc_io: regulator-vcc-io {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_io";
 		regulator-min-microvolt = <3300000>;
@@ -112,7 +112,7 @@ vcc_io: vcc-io-regulator {
 		vin-supply = <&vcc_sys>;
 	};

-	vcc_lan: vcc-lan-regulator {
+	vcc_lan: regulator-vcc-lan {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_lan";
 		regulator-min-microvolt = <3300000>;
@@ -122,7 +122,7 @@ vcc_lan: vcc-lan-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	vcc_sys: vcc-sys-regulator {
+	vcc_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-min-microvolt = <5000000>;
@@ -131,7 +131,7 @@ vcc_sys: vcc-sys-regulator {
 		regulator-boot-on;
 	};

-	vccio_wl: vccio-wl-regulator {
+	vccio_wl: regulator-vccio-wl {
 		compatible = "regulator-fixed";
 		regulator-name = "vccio_wl";
 		regulator-min-microvolt = <3300000>;
@@ -141,7 +141,7 @@ vccio_wl: vccio-wl-regulator {
 		vin-supply = <&vcc_io>;
 	};

-	vdd_10: vdd-10-regulator {
+	vdd_10: regulator-vdd-10 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_10";
 		regulator-min-microvolt = <1000000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts b/arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts
index 4feb78797982..e26e76ec6e10 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts
@@ -66,7 +66,7 @@ clkin_gmac: external-gmac-clock {
 		#clock-cells = <0>;
 	};

-	dc_12v: dc-12v {
+	dc_12v: regulator-dc-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "dc_12v";
 		regulator-always-on;
@@ -168,7 +168,7 @@ sdio_pwrseq: sdio-pwrseq {
 	};

 	/* switched by pmic_sleep */
-	vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
+	vcc1v8_s3: vcca1v8_s3: regulator-vcc1v8-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc1v8_s3";
 		regulator-always-on;
@@ -178,7 +178,7 @@ vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
 		vin-supply = <&vcc_1v8>;
 	};

-	vcc3v3_sys: vcc3v3-sys {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-always-on;
@@ -188,7 +188,7 @@ vcc3v3_sys: vcc3v3-sys {
 		vin-supply = <&dc_12v>;
 	};

-	vcc5v0_sys: vcc5v0-sys {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -199,7 +199,7 @@ vcc5v0_sys: vcc5v0-sys {
 	};

 	/* For USB3.0 Port1/2 */
-	vcc5v0_host1: vcc5v0-host1-regulator {
+	vcc5v0_host1: regulator-vcc5v0-host1 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
@@ -211,7 +211,7 @@ vcc5v0_host1: vcc5v0-host1-regulator {
 	};

 	/* For USB2.0 Port1/2 */
-	vcc5v0_host3: vcc5v0-host3-regulator {
+	vcc5v0_host3: regulator-vcc5v0-host3 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PB0 GPIO_ACTIVE_HIGH>;
@@ -222,7 +222,7 @@ vcc5v0_host3: vcc5v0-host3-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_typec: vcc5v0-typec-regulator {
+	vcc5v0_typec: regulator-vcc5v0-typec {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PC5 GPIO_ACTIVE_HIGH>;
@@ -233,7 +233,7 @@ vcc5v0_typec: vcc5v0-typec-regulator {
 		vin-supply = <&vcc3v3_sys>;
 	};

-	vdd_log: vdd-log {
+	vdd_log: regulator-vdd-log {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_log";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
index 54e67d2dac09..e32763c072ad 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
@@ -75,7 +75,7 @@ clkin_gmac: external-gmac-clock {
 		#clock-cells = <0>;
 	};

-	vdd_center: vdd-center {
+	vdd_center: regulator-vdd-center {
 		compatible = "pwm-regulator";
 		pwms = <&pwm3 0 25000 0>;
 		regulator-name = "vdd_center";
@@ -86,7 +86,7 @@ vdd_center: vdd-center {
 		status = "okay";
 	};

-	vcc3v3_sys: vcc3v3-sys {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-always-on;
@@ -95,7 +95,7 @@ vcc3v3_sys: vcc3v3-sys {
 		regulator-max-microvolt = <3300000>;
 	};

-	vcc5v0_sys: vcc5v0-sys {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -104,7 +104,7 @@ vcc5v0_sys: vcc5v0-sys {
 		regulator-max-microvolt = <5000000>;
 	};

-	vcc5v0_host: vcc5v0-host-regulator {
+	vcc5v0_host: regulator-vcc5v0-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PD1 GPIO_ACTIVE_HIGH>;
@@ -114,14 +114,14 @@ vcc5v0_host: vcc5v0-host-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc_phy: vcc-phy-regulator {
+	vcc_phy: regulator-vcc-phy {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_phy";
 		regulator-always-on;
 		regulator-boot-on;
 	};

-	vcc_phy: vcc-phy-regulator {
+	vcc_phy: regulator-vcc-phy {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_phy";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
index f4491317a1b0..f6492da8e864 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
@@ -72,7 +72,7 @@ clkin_gmac: external-gmac-clock {
 		#clock-cells = <0>;
 	};

-	dc_12v: dc-12v {
+	dc_12v: regulator-dc-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "dc_12v";
 		regulator-always-on;
@@ -178,7 +178,7 @@ dit_p0_0: endpoint {
 	};

 	/* switched by pmic_sleep */
-	vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
+	vcc1v8_s3: vcca1v8_s3: regulator-vcc1v8-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc1v8_s3";
 		regulator-always-on;
@@ -188,7 +188,7 @@ vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
 		vin-supply = <&vcc_1v8>;
 	};

-	vcc3v3_pcie: vcc3v3-pcie-regulator {
+	vcc3v3_pcie: regulator-vcc3v3-pcie {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;
@@ -200,7 +200,7 @@ vcc3v3_pcie: vcc3v3-pcie-regulator {
 		vin-supply = <&dc_12v>;
 	};

-	vcc3v3_sys: vcc3v3-sys {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-always-on;
@@ -211,7 +211,7 @@ vcc3v3_sys: vcc3v3-sys {
 	};

 	/* Actually 3 regulators (host0, 1, 2) controlled by the same gpio */
-	vcc5v0_host: vcc5v0-host-regulator {
+	vcc5v0_host: regulator-vcc5v0-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
@@ -222,7 +222,7 @@ vcc5v0_host: vcc5v0-host-regulator {
 		vin-supply = <&vcc_sys>;
 	};

-	vcc5v0_typec: vcc5v0-typec-regulator {
+	vcc5v0_typec: regulator-vcc5v0-typec {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 RK_PA3 GPIO_ACTIVE_HIGH>;
@@ -233,7 +233,7 @@ vcc5v0_typec: vcc5v0-typec-regulator {
 		vin-supply = <&vcc_sys>;
 	};

-	vcc_sys: vcc-sys {
+	vcc_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-always-on;
@@ -243,7 +243,7 @@ vcc_sys: vcc-sys {
 		vin-supply = <&dc_12v>;
 	};

-	vdd_log: vdd-log {
+	vdd_log: regulator-vdd-log {
 		compatible = "pwm-regulator";
 		pwms = <&pwm2 0 25000 1>;
 		pwm-supply = <&vcc_sys>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
index cacbad35cfc8..988e6ca32fac 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
@@ -8,7 +8,7 @@
 #include "rk3399-gru.dtsi"

 / {
-	pp900_ap: pp900-ap {
+	pp900_ap: regulator-pp900-ap {
 		compatible = "regulator-fixed";
 		regulator-name = "pp900_ap";

@@ -29,7 +29,7 @@ pp900_usb: pp900-ap {
 	pp900_pcie: pp900-ap {
 	};

-	pp3000: pp3000 {
+	pp3000: regulator-pp3000 {
 		compatible = "regulator-fixed";
 		regulator-name = "pp3000";
 		pinctrl-names = "default";
@@ -46,7 +46,7 @@ pp3000: pp3000 {
 		vin-supply = <&ppvar_sys>;
 	};

-	ppvar_centerlogic_pwm: ppvar-centerlogic-pwm {
+	ppvar_centerlogic_pwm: regulator-ppvar-centerlogic-pwm {
 		compatible = "pwm-regulator";
 		regulator-name = "ppvar_centerlogic_pwm";

@@ -78,7 +78,7 @@ ppvar_centerlogic: ppvar-centerlogic {
 	};

 	/* Schematics call this PPVAR even though it's fixed */
-	ppvar_logic: ppvar-logic {
+	ppvar_logic: regulator-ppvar-logic {
 		compatible = "regulator-fixed";
 		regulator-name = "ppvar_logic";

@@ -91,7 +91,7 @@ ppvar_logic: ppvar-logic {
 		vin-supply = <&ppvar_sys>;
 	};

-	pp1800_audio: pp1800-audio {
+	pp1800_audio: regulator-pp1800-audio {
 		compatible = "regulator-fixed";
 		regulator-name = "pp1800_audio";
 		pinctrl-names = "default";
@@ -107,7 +107,7 @@ pp1800_audio: pp1800-audio {
 	};

 	/* gpio is shared with pp3300_wifi_bt */
-	pp1800_pcie: pp1800-pcie {
+	pp1800_pcie: regulator-pp1800-pcie {
 		compatible = "regulator-fixed";
 		regulator-name = "pp1800_pcie";
 		pinctrl-names = "default";
@@ -129,7 +129,7 @@ pp1800_pcie: pp1800-pcie {
 	pp3000_ap: pp3000_emmc: pp3000 {
 	};

-	pp1500_ap_io: pp1500-ap-io {
+	pp1500_ap_io: regulator-pp1500-ap-io {
 		compatible = "regulator-fixed";
 		regulator-name = "pp1500_ap_io";
 		pinctrl-names = "default";
@@ -146,7 +146,7 @@ pp1500_ap_io: pp1500-ap-io {
 		vin-supply = <&pp1800>;
 	};

-	pp3300_disp: pp3300-disp {
+	pp3300_disp: regulator-pp3300-disp {
 		compatible = "regulator-fixed";
 		regulator-name = "pp3300_disp";
 		pinctrl-names = "default";
@@ -164,7 +164,7 @@ pp3300_usb: pp3300 {
 	};

 	/* gpio is shared with pp1800_pcie and pinctrl is set there */
-	pp3300_wifi_bt: pp3300-wifi-bt {
+	pp3300_wifi_bt: regulator-pp3300-wifi-bt {
 		compatible = "regulator-fixed";
 		regulator-name = "pp3300_wifi_bt";

@@ -180,7 +180,7 @@ pp3300_wifi_bt: pp3300-wifi-bt {
 	 * With some stretching of the imagination, we can call the 1.8V
 	 * regulator a supply.
 	 */
-	wlan_pd_n: wlan-pd-n {
+	wlan_pd_n: regulator-wlan-pd-n {
 		compatible = "regulator-fixed";
 		regulator-name = "wlan_pd_n";
 		pinctrl-names = "default";
@@ -550,7 +550,7 @@ &usbdrd_dwc3_1 {
 };

 &pinctrl {
-	discrete-regulators {
+	discretes {
 		pp1500_en: pp1500-en {
 			rockchip,pins = <0 RK_PB2 RK_FUNC_GPIO
 					 &pcfg_pull_none>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
index 2cc9b3386c16..7b907c80dd32 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
@@ -28,7 +28,7 @@ / {

 	/* Power tree */

-	p3_3v_dig: p3-3v-dig {
+	p3_3v_dig: regulator-p3-3v-dig {
 		compatible = "regulator-fixed";
 		regulator-name = "p3.3v_dig";
 		pinctrl-names = "default";
@@ -314,7 +314,7 @@ cpu1_dig_pdct_l: cpu1-dig-pdct-l {
 		};
 	};

-	discrete-regulators {
+	discretes {
 		cpu3_pen_pwr_en: cpu3-pen-pwr-en {
 			rockchip,pins = <4 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
index d5e035823eb5..19b23b438965 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
@@ -13,7 +13,7 @@ /{
 	/* Power tree */

 	/* ppvar_sys children, sorted by name */
-	pp1250_s3: pp1250-s3 {
+	pp1250_s3: regulator-pp1250-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "pp1250_s3";

@@ -26,7 +26,7 @@ pp1250_s3: pp1250-s3 {
 		vin-supply = <&ppvar_sys>;
 	};

-	pp1250_cam: pp1250-dvdd {
+	pp1250_cam: regulator-pp1250-dvdd {
 		compatible = "regulator-fixed";
 		regulator-name = "pp1250_dvdd";
 		pinctrl-names = "default";
@@ -42,7 +42,7 @@ pp1250_cam: pp1250-dvdd {
 		vin-supply = <&pp1250_s3>;
 	};

-	pp900_s0: pp900-s0 {
+	pp900_s0: regulator-pp900-s0 {
 		compatible = "regulator-fixed";
 		regulator-name = "pp900_s0";

@@ -55,7 +55,7 @@ pp900_s0: pp900-s0 {
 		vin-supply = <&ppvar_sys>;
 	};

-	ppvarn_lcd: ppvarn-lcd {
+	ppvarn_lcd: regulator-ppvarn-lcd {
 		compatible = "regulator-fixed";
 		regulator-name = "ppvarn_lcd";
 		pinctrl-names = "default";
@@ -66,7 +66,7 @@ ppvarn_lcd: ppvarn-lcd {
 		vin-supply = <&ppvar_sys>;
 	};

-	ppvarp_lcd: ppvarp-lcd {
+	ppvarp_lcd: regulator-ppvarp-lcd {
 		compatible = "regulator-fixed";
 		regulator-name = "ppvarp_lcd";
 		pinctrl-names = "default";
@@ -78,7 +78,7 @@ ppvarp_lcd: ppvarp-lcd {
 	};

 	/* pp1800 children, sorted by name */
-	pp900_s3: pp900-s3 {
+	pp900_s3: regulator-pp900-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "pp900_s3";

@@ -96,7 +96,7 @@ pp1800_s3: pp1800 {
 	};

 	/* pp3300 children, sorted by name */
-	pp2800_cam: pp2800-avdd {
+	pp2800_cam: regulator-pp2800-avdd {
 		compatible = "regulator-fixed";
 		regulator-name = "pp2800_avdd";
 		pinctrl-names = "default";
@@ -127,7 +127,7 @@ pp3300_s3: pp3300 {
 	 * the boot process it also enables its supply regulator bt_3v3,
 	 * which changes BT_EN to high.
 	 */
-	bt_3v3: bt-3v3 {
+	bt_3v3: regulator-bt-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "bt_3v3";
 		pinctrl-names = "default";
@@ -138,7 +138,7 @@ bt_3v3: bt-3v3 {
 		vin-supply = <&pp3300_s3>;
 	};

-	wlan_3v3: wlan-3v3 {
+	wlan_3v3: regulator-wlan-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "wlan_3v3";
 		pinctrl-names = "default";
@@ -833,7 +833,7 @@ pen_reset_l: pen-reset-l {
 		};
 	};

-	discrete-regulators {
+	discretes {
 		display_rst_l: display-rst-l {
 			rockchip,pins = <4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_down>;
 		};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 776c0eec04d7..6d9e60b01225 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -42,14 +42,14 @@ chosen {
 	 *   schematic.
 	 */

-	ppvar_sys: ppvar-sys {
+	ppvar_sys: regulator-ppvar-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "ppvar_sys";
 		regulator-always-on;
 		regulator-boot-on;
 	};

-	pp1200_lpddr: pp1200-lpddr {
+	pp1200_lpddr: regulator-pp1200-lpddr {
 		compatible = "regulator-fixed";
 		regulator-name = "pp1200_lpddr";

@@ -62,7 +62,7 @@ pp1200_lpddr: pp1200-lpddr {
 		vin-supply = <&ppvar_sys>;
 	};

-	pp1800: pp1800 {
+	pp1800: regulator-pp1800 {
 		compatible = "regulator-fixed";
 		regulator-name = "pp1800";

@@ -75,7 +75,7 @@ pp1800: pp1800 {
 		vin-supply = <&ppvar_sys>;
 	};

-	pp3300: pp3300 {
+	pp3300: regulator-pp3300 {
 		compatible = "regulator-fixed";
 		regulator-name = "pp3300";

@@ -88,7 +88,7 @@ pp3300: pp3300 {
 		vin-supply = <&ppvar_sys>;
 	};

-	pp5000: pp5000 {
+	pp5000: regulator-pp5000 {
 		compatible = "regulator-fixed";
 		regulator-name = "pp5000";

@@ -101,7 +101,7 @@ pp5000: pp5000 {
 		vin-supply = <&ppvar_sys>;
 	};

-	ppvar_bigcpu_pwm: ppvar-bigcpu-pwm {
+	ppvar_bigcpu_pwm: regulator-ppvar-bigcpu-pwm {
 		compatible = "pwm-regulator";
 		regulator-name = "ppvar_bigcpu_pwm";

@@ -130,7 +130,7 @@ ppvar_bigcpu: ppvar-bigcpu {
 		regulator-settling-time-up-us = <322>;
 	};

-	ppvar_litcpu_pwm: ppvar-litcpu-pwm {
+	ppvar_litcpu_pwm: regulator-ppvar-litcpu-pwm {
 		compatible = "pwm-regulator";
 		regulator-name = "ppvar_litcpu_pwm";

@@ -159,7 +159,7 @@ ppvar_litcpu: ppvar-litcpu {
 		regulator-settling-time-up-us = <384>;
 	};

-	ppvar_gpu_pwm: ppvar-gpu-pwm {
+	ppvar_gpu_pwm: regulator-ppvar-gpu-pwm {
 		compatible = "pwm-regulator";
 		regulator-name = "ppvar_gpu_pwm";

@@ -224,7 +224,7 @@ pp1800_pmu: pp1800 {
 	pp1800_usb: pp1800 {
 	};

-	pp3000_sd_slot: pp3000-sd-slot {
+	pp3000_sd_slot: regulator-pp3000-sd-slot {
 		compatible = "regulator-fixed";
 		regulator-name = "pp3000_sd_slot";
 		pinctrl-names = "default";
@@ -724,7 +724,7 @@ ec_ap_int_l: ec-ap-int-l {
 		};
 	};

-	discrete-regulators {
+	discretes {
 		sd_io_pwr_en: sd-io-pwr-en {
 			rockchip,pins = <2 RK_PA2 RK_FUNC_GPIO
 					 &pcfg_pull_none>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
index 5a02502d21cd..1555bac0405e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
@@ -27,7 +27,7 @@ clkin_gmac: external-gmac-clock {
 		#clock-cells = <0>;
 	};

-	dc_5v: dc-5v {
+	dc_5v: regulator-dc-5v {
 		compatible = "regulator-fixed";
 		regulator-name = "dc_5v";
 		regulator-always-on;
@@ -56,7 +56,7 @@ power_led: led-0 {
 		};
 	};

-	vcc_sys: vcc-sys {
+	vcc_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-min-microvolt = <5000000>;
@@ -65,14 +65,14 @@ vcc_sys: vcc-sys {
 		vin-supply = <&dc_5v>;
 	};

-	vcc_phy: vcc-phy-regulator {
+	vcc_phy: regulator-vcc-phy {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_phy";
 		regulator-always-on;
 		regulator-boot-on;
 	};

-	vcc1v8_s0: vcc1v8-s0 {
+	vcc1v8_s0: regulator-vcc1v8-s0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc1v8_s0";
 		regulator-min-microvolt = <1800000>;
@@ -80,7 +80,7 @@ vcc1v8_s0: vcc1v8-s0 {
 		regulator-always-on;
 	};

-	vcc3v3_sys: vcc3v3-sys {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-min-microvolt = <3300000>;
@@ -89,7 +89,7 @@ vcc3v3_sys: vcc3v3-sys {
 		vin-supply = <&vcc_sys>;
 	};

-	vcc5v0_host: vcc5v0-host-regulator {
+	vcc5v0_host: regulator-vcc5v0-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;
@@ -99,7 +99,7 @@ vcc5v0_host: vcc5v0-host-regulator {
 		regulator-always-on;
 	};

-	vcc5v0_typec: vcc5v0-typec-regulator {
+	vcc5v0_typec: regulator-vcc5v0-typec {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 RK_PA3 GPIO_ACTIVE_HIGH>;
@@ -110,7 +110,7 @@ vcc5v0_typec: vcc5v0-typec-regulator {
 		vin-supply = <&vcc5v0_usb>;
 	};

-	vcc5v0_usb: vcc5v0-usb {
+	vcc5v0_usb: regulator-vcc5v0-usb {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb";
 		regulator-always-on;
@@ -120,7 +120,7 @@ vcc5v0_usb: vcc5v0-usb {
 		vin-supply = <&dc_5v>;
 	};

-	vdd_log: vdd-log {
+	vdd_log: regulator-vdd-log {
 		compatible = "pwm-regulator";
 		pwms = <&pwm2 0 25000 1>;
 		pwm-supply = <&vcc_sys>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
index c772985ae4e5..1ed0b3621500 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
@@ -45,7 +45,7 @@ sdio_pwrseq: sdio-pwrseq {
 	};

 	/* switched by pmic_sleep */
-	vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
+	vcc1v8_s3: vcca1v8_s3: regulator-vcc1v8-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc1v8_s3";
 		regulator-always-on;
@@ -55,7 +55,7 @@ vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
 		vin-supply = <&vcc_1v8>;
 	};

-	vcc3v3_pcie: vcc3v3-pcie-regulator {
+	vcc3v3_pcie: regulator-vcc3v3-pcie {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_pcie";
 		regulator-always-on;
@@ -66,7 +66,7 @@ vcc3v3_pcie: vcc3v3-pcie-regulator {
 	};

 	/* Actually 3 regulators (host0, 1, 2) controlled by the same gpio */
-	vcc5v0_host: vcc5v0-host-regulator {
+	vcc5v0_host: regulator-vcc5v0-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PD1 GPIO_ACTIVE_HIGH>;
@@ -77,7 +77,7 @@ vcc5v0_host: vcc5v0-host-regulator {
 		vin-supply = <&vsys_5v0>;
 	};

-	vdd_log: vdd-log {
+	vdd_log: regulator-vdd-log {
 		compatible = "pwm-regulator";
 		pwms = <&pwm2 0 25000 1>;
 		pwm-supply = <&vsys_3v3>;
@@ -88,14 +88,14 @@ vdd_log: vdd-log {
 		regulator-max-microvolt = <1400000>;
 	};

-	vsys: vsys {
+	vsys: regulator-vsys {
 		compatible = "regulator-fixed";
 		regulator-name = "vsys";
 		regulator-always-on;
 		regulator-boot-on;
 	};

-	vsys_3v3: vsys-3v3 {
+	vsys_3v3: regulator-vsys-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vsys_3v3";
 		regulator-always-on;
@@ -105,7 +105,7 @@ vsys_3v3: vsys-3v3 {
 		vin-supply = <&vsys>;
 	};

-	vsys_5v0: vsys-5v0 {
+	vsys_5v0: regulator-vsys-5v0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vsys_5v0";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
index b0c1fb0b704e..754f5bd82a22 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
@@ -23,7 +23,7 @@ aliases {
 		mmc1 = &sdhci;
 	};

-	avdd_0v9_s0: avdd-0v9-s0 {
+	avdd_0v9_s0: regulator-avdd-0v9-s0 {
 		compatible = "regulator-fixed";
 		regulator-name = "avdd_0v9_s0";
 		regulator-always-on;
@@ -33,7 +33,7 @@ avdd_0v9_s0: avdd-0v9-s0 {
 		vin-supply = <&vcc1v8_sys_s3>;
 	};

-	avdd_1v8_s0: avdd-1v8-s0 {
+	avdd_1v8_s0: regulator-avdd-1v8-s0 {
 		compatible = "regulator-fixed";
 		regulator-name = "avdd_1v8_s0";
 		regulator-always-on;
@@ -86,7 +86,7 @@ led-1 {
 		};
 	};

-	hdd_a_power: hdd-a-power {
+	hdd_a_power: regulator-hdd-a-power {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
@@ -98,7 +98,7 @@ hdd_a_power: hdd-a-power {
 		startup-delay-us = <2000000>;
 	};

-	hdd_b_power: hdd-b-power {
+	hdd_b_power: regulator-hdd-b-power {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 RK_PA1 GPIO_ACTIVE_HIGH>;
@@ -110,7 +110,7 @@ hdd_b_power: hdd-b-power {
 		startup-delay-us = <2000000>;
 	};

-	pcie_power: pcie-power {
+	pcie_power: regulator-pcie-power {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 RK_PD0 GPIO_ACTIVE_HIGH>;
@@ -122,7 +122,7 @@ pcie_power: pcie-power {
 		vin-supply = <&vcc5v0_perdev>;
 	};

-	usblan_power: usblan-power {
+	usblan_power: regulator-usblan-power {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 RK_PC7 GPIO_ACTIVE_HIGH>;
@@ -134,7 +134,7 @@ usblan_power: usblan-power {
 		vin-supply = <&vcc5v0_usb>;
 	};

-	vcc1v8_sys_s0: vcc1v8-sys-s0 {
+	vcc1v8_sys_s0: regulator-vcc1v8-sys-s0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc1v8_sys_s0";
 		regulator-always-on;
@@ -144,7 +144,7 @@ vcc1v8_sys_s0: vcc1v8-sys-s0 {
 		vin-supply = <&vcc1v8_sys_s3>;
 	};

-	vcc3v0_sd: vcc3v0-sd {
+	vcc3v0_sd: regulator-vcc3v0-sd {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
@@ -157,7 +157,7 @@ vcc3v0_sd: vcc3v0-sd {
 		vin-supply = <&vcc3v3_sys_s3>;
 	};

-	vcc3v3_sys_s3: vcc_lan: vcc3v3-sys-s3 {
+	vcc3v3_sys_s3: vcc_lan: regulator-vcc3v3-sys-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys_s3";
 		regulator-always-on;
@@ -171,7 +171,7 @@ regulator-state-mem {
 		};
 	};

-	vcc5v0_perdev: vcc5v0-perdev {
+	vcc5v0_perdev: regulator-vcc5v0-perdev {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_perdev";
 		regulator-always-on;
@@ -181,7 +181,7 @@ vcc5v0_perdev: vcc5v0-perdev {
 		vin-supply = <&vcc12v_dcin_bkup>;
 	};

-	vcc5v0_sys: vcc5v0-sys {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -195,7 +195,7 @@ regulator-state-mem {
 		};
 	};

-	vcc5v0_usb: vcc5v0-usb {
+	vcc5v0_usb: regulator-vcc5v0-usb {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 RK_PC6 GPIO_ACTIVE_HIGH>;
@@ -209,7 +209,7 @@ vcc5v0_usb: vcc5v0-usb {
 		vin-supply = <&vcc5v0_perdev>;
 	};

-	vcc12v_dcin: vcc12v-dcin {
+	vcc12v_dcin: regulator-vcc12v-dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
 		regulator-always-on;
@@ -218,7 +218,7 @@ vcc12v_dcin: vcc12v-dcin {
 		regulator-max-microvolt = <12000000>;
 	};

-	vcc12v_dcin_bkup: vcc12v-dcin-bkup {
+	vcc12v_dcin_bkup: regulator-vcc12v-dcin-bkup {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin_bkup";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts b/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
index f12b1eb00575..57702e30b5d3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
@@ -40,7 +40,7 @@ sdio_pwrseq: sdio-pwrseq {
 		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
 	};

-	dc5v_adp: dc5v-adp {
+	dc5v_adp: regulator-dc5v-adp {
 		compatible = "regulator-fixed";
 		regulator-name = "dc5v_adapter";
 		regulator-always-on;
@@ -49,7 +49,7 @@ dc5v_adp: dc5v-adp {
 		regulator-max-microvolt = <5000000>;
 	};

-	vcc3v3_lan: vcc3v3-lan {
+	vcc3v3_lan: regulator-vcc3v3-lan {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_lan";
 		regulator-always-on;
@@ -59,7 +59,7 @@ vcc3v3_lan: vcc3v3-lan {
 		vin-supply = <&vcc3v3_sys>;
 	};

-	vcc3v3_sys: vcc3v3-sys {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-always-on;
@@ -69,7 +69,7 @@ vcc3v3_sys: vcc3v3-sys {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_host0: vcc5v0_host1: vcc5v0-host {
+	vcc5v0_host0: vcc5v0_host1: regulator-vcc5v0-host {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_host";
 		regulator-boot-on;
@@ -79,7 +79,7 @@ vcc5v0_host0: vcc5v0_host1: vcc5v0-host {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_host3: vcc5v0-host3 {
+	vcc5v0_host3: regulator-vcc5v0-host3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_host3";
 		enable-active-high;
@@ -90,7 +90,7 @@ vcc5v0_host3: vcc5v0-host3 {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_sys: vcc5v0-sys {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -100,7 +100,7 @@ vcc5v0_sys: vcc5v0-sys {
 		vin-supply = <&dc5v_adp>;
 	};

-	vdd_log: vdd-log {
+	vdd_log: regulator-vdd-log {
 		compatible = "pwm-regulator";
 		pwms = <&pwm2 0 25000 1>;
 		pwm-supply = <&vcc5v0_sys>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
index 3bf8f959e42c..e5fc05cc64bd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
@@ -15,7 +15,7 @@ / {
 	model = "FriendlyElec NanoPC-T4";
 	compatible = "friendlyarm,nanopc-t4", "rockchip,rk3399";

-	vcc12v0_sys: vcc12v0-sys {
+	vcc12v0_sys: regulator-vcc12v0-sys {
 		compatible = "regulator-fixed";
 		regulator-always-on;
 		regulator-boot-on;
@@ -24,7 +24,7 @@ vcc12v0_sys: vcc12v0-sys {
 		regulator-name = "vcc12v0_sys";
 	};

-	vcc5v0_host0: vcc5v0-host0 {
+	vcc5v0_host0: regulator-vcc5v0-host0 {
 		compatible = "regulator-fixed";
 		regulator-always-on;
 		regulator-boot-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts
index 60358ab8c7df..04860a19937b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts
@@ -16,14 +16,14 @@ / {
 	model = "FriendlyElec NanoPi M4";
 	compatible = "friendlyarm,nanopi-m4", "rockchip,rk3399";

-	vdd_5v: vdd-5v {
+	vdd_5v: regulator-vdd-5v {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_5v";
 		regulator-always-on;
 		regulator-boot-on;
 	};

-	vcc5v0_core: vcc5v0-core {
+	vcc5v0_core: regulator-vcc5v0-core {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_core";
 		regulator-always-on;
@@ -31,7 +31,7 @@ vcc5v0_core: vcc5v0-core {
 		vin-supply = <&vdd_5v>;
 	};

-	vcc5v0_usb1: vcc5v0-usb1 {
+	vcc5v0_usb1: regulator-vcc5v0-usb1 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb1";
 		regulator-always-on;
@@ -39,7 +39,7 @@ vcc5v0_usb1: vcc5v0-usb1 {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_usb2: vcc5v0-usb2 {
+	vcc5v0_usb2: regulator-vcc5v0-usb2 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb2";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-neo4.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-neo4.dts
index 195410b089b9..3ae645edeb62 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-neo4.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-neo4.dts
@@ -12,14 +12,14 @@ / {
 	model = "FriendlyARM NanoPi NEO4";
 	compatible = "friendlyarm,nanopi-neo4", "rockchip,rk3399";

-	vdd_5v: vdd-5v {
+	vdd_5v: regulator-vdd-5v {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_5v";
 		regulator-always-on;
 		regulator-boot-on;
 	};

-	vcc5v0_core: vcc5v0-core {
+	vcc5v0_core: regulator-vcc5v0-core {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_core";
 		regulator-always-on;
@@ -27,7 +27,7 @@ vcc5v0_core: vcc5v0-core {
 		vin-supply = <&vdd_5v>;
 	};

-	vcc5v0_usb1: vcc5v0-usb1 {
+	vcc5v0_usb1: regulator-vcc5v0-usb1 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb1";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
index fe5b52610010..647c989c1240 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
@@ -56,7 +56,7 @@ key-reset {
 		};
 	};

-	vdd_5v: vdd-5v {
+	vdd_5v: regulator-vdd-5v {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_5v";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
index 7debc4a1b5fa..f4ee875b6095 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
@@ -34,7 +34,7 @@ clkin_gmac: external-gmac-clock {
 		#clock-cells = <0>;
 	};

-	vcc3v3_sys: vcc3v3-sys {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-always-on;
 		regulator-boot-on;
@@ -43,7 +43,7 @@ vcc3v3_sys: vcc3v3-sys {
 		regulator-name = "vcc3v3_sys";
 	};

-	vcc5v0_sys: vcc5v0-sys {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-always-on;
 		regulator-boot-on;
@@ -54,7 +54,7 @@ vcc5v0_sys: vcc5v0-sys {
 	};

 	/* switched by pmic_sleep */
-	vcc1v8_s3: vcc1v8-s3 {
+	vcc1v8_s3: regulator-vcc1v8-s3 {
 		compatible = "regulator-fixed";
 		regulator-always-on;
 		regulator-boot-on;
@@ -64,7 +64,7 @@ vcc1v8_s3: vcc1v8-s3 {
 		vin-supply = <&vcc_1v8>;
 	};

-	vcc3v0_sd: vcc3v0-sd {
+	vcc3v0_sd: regulator-vcc3v0-sd {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
@@ -81,7 +81,7 @@ vcc3v0_sd: vcc3v0-sd {
 	 * Really, this is supplied by vcc_1v8, and vcc1v8_s3 only
 	 * drives the enable pin, but we can't quite model that.
 	 */
-	vcca0v9_s3: vcca0v9-s3 {
+	vcca0v9_s3: regulator-vcca0v9-s3 {
 		compatible = "regulator-fixed";
 		regulator-min-microvolt = <900000>;
 		regulator-max-microvolt = <900000>;
@@ -90,7 +90,7 @@ vcca0v9_s3: vcca0v9-s3 {
 	};

 	/* As above, actually supplied by vcc3v3_sys */
-	vcca1v8_s3: vcca1v8-s3 {
+	vcca1v8_s3: regulator-vcca1v8-s3 {
 		compatible = "regulator-fixed";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
@@ -98,7 +98,7 @@ vcca1v8_s3: vcca1v8-s3 {
 		vin-supply = <&vcc1v8_s3>;
 	};

-	vbus_typec: vbus-typec {
+	vbus_typec: regulator-vbus-typec {
 		compatible = "regulator-fixed";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
index 07ec33f3f55f..0731377f7855 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
@@ -65,7 +65,7 @@ button-menu {
 		};
 	};

-	dc_12v: dc-12v {
+	dc_12v: regulator-dc-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "dc_12v";
 		regulator-always-on;
@@ -100,7 +100,7 @@ sdio_pwrseq: sdio-pwrseq {
 	};

 	/* switched by pmic_sleep */
-	vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
+	vcc1v8_s3: vcca1v8_s3: regulator-vcc1v8-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc1v8_s3";
 		regulator-always-on;
@@ -110,7 +110,7 @@ vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
 		vin-supply = <&vcc_1v8>;
 	};

-	vcc3v0_sd: vcc3v0-sd {
+	vcc3v0_sd: regulator-vcc3v0-sd {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
@@ -123,7 +123,7 @@ vcc3v0_sd: vcc3v0-sd {
 		vin-supply = <&vcc3v3_sys>;
 	};

-	vcc3v3_sys: vcc3v3-sys {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-always-on;
@@ -133,7 +133,7 @@ vcc3v3_sys: vcc3v3-sys {
 		vin-supply = <&vcc_sys>;
 	};

-	vcc5v0_host: vcc5v0-host-regulator {
+	vcc5v0_host: regulator-vcc5v0-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PD1 GPIO_ACTIVE_HIGH>;
@@ -144,7 +144,7 @@ vcc5v0_host: vcc5v0-host-regulator {
 		vin-supply = <&vcc_sys>;
 	};

-	vbus_typec: vbus-typec-regulator {
+	vbus_typec: regulator-vbus-typec {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 RK_PA3 GPIO_ACTIVE_HIGH>;
@@ -154,7 +154,7 @@ vbus_typec: vbus-typec-regulator {
 		vin-supply = <&vcc_sys>;
 	};

-	vcc_sys: vcc-sys {
+	vcc_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-always-on;
@@ -164,7 +164,7 @@ vcc_sys: vcc-sys {
 		vin-supply = <&dc_12v>;
 	};

-	vdd_log: vdd-log {
+	vdd_log: regulator-vdd-log {
 		compatible = "pwm-regulator";
 		pwms = <&pwm2 0 25000 1>;
 		pwm-supply = <&vcc_sys>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
index a5a7e374bc59..af749f222b14 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
@@ -172,7 +172,7 @@ speaker_amp: speaker-amplifier {

 	/* Power tree */
 	/* Root power source */
-	vcc_sysin: vcc-sysin {
+	vcc_sysin: regulator-vcc-sysin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sysin";
 		regulator-always-on;
@@ -181,7 +181,7 @@ vcc_sysin: vcc-sysin {

 	/* Regulators supplied by vcc_sysin */
 	/* LCD backlight supply */
-	vcc_12v: vcc-12v {
+	vcc_12v: regulator-vcc-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_12v";
 		regulator-always-on;
@@ -196,7 +196,7 @@ regulator-state-mem {
 	};

 	/* Main 3.3 V supply */
-	vcc3v3_sys: wifi_bat: vcc3v3-sys {
+	vcc3v3_sys: wifi_bat: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-always-on;
@@ -211,7 +211,7 @@ regulator-state-mem {
 	};

 	/* 5 V USB power supply */
-	vcc5v0_usb: pa_5v: vcc5v0-usb-regulator {
+	vcc5v0_usb: pa_5v: regulator-vcc5v0-usb {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>;
@@ -229,7 +229,7 @@ regulator-state-mem {
 	};

 	/* RK3399 logic supply */
-	vdd_log: vdd-log {
+	vdd_log: regulator-vdd-log {
 		compatible = "pwm-regulator";
 		pwms = <&pwm2 0 25000 1>;
 		pwm-supply = <&vcc_sysin>;
@@ -246,7 +246,7 @@ regulator-state-mem {

 	/* Regulators supplied by vcc3v3_sys */
 	/* 0.9 V supply, always on */
-	vcc_0v9: vcc-0v9 {
+	vcc_0v9: regulator-vcc-0v9 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_0v9";
 		regulator-always-on;
@@ -257,7 +257,7 @@ vcc_0v9: vcc-0v9 {
 	};

 	/* S3 1.8 V supply, switched by vcc1v8_s3 */
-	vcca1v8_s3: vcc1v8-s3 {
+	vcca1v8_s3: regulator-vcc1v8-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcca1v8_s3";
 		regulator-always-on;
@@ -268,7 +268,7 @@ vcca1v8_s3: vcc1v8-s3 {
 	};

 	/* micro SD card power */
-	vcc3v0_sd: vcc3v0-sd {
+	vcc3v0_sd: regulator-vcc3v0-sd {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
@@ -286,7 +286,7 @@ regulator-state-mem {
 	};

 	/* LCD panel power, called VCC3V3_S0 in schematic */
-	vcc3v3_panel: vcc3v3-panel {
+	vcc3v3_panel: regulator-vcc3v3-panel {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 RK_PC6 GPIO_ACTIVE_HIGH>;
@@ -305,7 +305,7 @@ regulator-state-mem {
 	};

 	/* M.2 adapter power, switched by vcc1v8_s3 */
-	vcc3v3_ssd: vcc3v3-ssd {
+	vcc3v3_ssd: regulator-vcc3v3-ssd {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_ssd";
 		regulator-min-microvolt = <3300000>;
@@ -315,7 +315,7 @@ vcc3v3_ssd: vcc3v3-ssd {

 	/* Regulators supplied by vcc5v0_usb */
 	/* USB 3 port power supply regulator  */
-	vcc5v0_otg: vcc5v0-otg {
+	vcc5v0_otg: regulator-vcc5v0-otg {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;
@@ -334,7 +334,7 @@ regulator-state-mem {

 	/* Regulators supplied by vcc5v0_usb */
 	/* Type C port power supply regulator */
-	vbus_5vout: vbus_typec: vbus-5vout {
+	vbus_5vout: vbus_typec: regulator-vbus-5vout {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 RK_PA3 GPIO_ACTIVE_HIGH>;
@@ -352,7 +352,7 @@ regulator-state-mem {

 	/* Regulators supplied by vcc_1v8 */
 	/* Primary 0.9 V LDO */
-	vcca0v9_s3: vcca0v9-s3 {
+	vcca0v9_s3: regulator-vcca0v9-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc0v9_s3";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index 1a44582a49fb..fe0c41299dc6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -97,14 +97,14 @@ multi-led {
 		leds = <&led_red>, <&led_green>, <&led_blue>;
 	};

-	vcc_sys: vcc-sys-regulator {
+	vcc_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-always-on;
 		regulator-boot-on;
 	};

-	vcc3v3_sys: vcc3v3-sys-regulator {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-always-on;
@@ -114,7 +114,7 @@ vcc3v3_sys: vcc3v3-sys-regulator {
 		vin-supply = <&vcc_sys>;
 	};

-	vcca1v8_s3: vcc1v8-s3-regulator {
+	vcca1v8_s3: regulator-vcc1v8-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcca1v8_s3";
 		regulator-min-microvolt = <1800000>;
@@ -124,7 +124,7 @@ vcca1v8_s3: vcc1v8-s3-regulator {
 		regulator-boot-on;
 	};

-	vcc1v8_codec: vcc1v8-codec-regulator {
+	vcc1v8_codec: regulator-vcc1v8-codec {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio3 RK_PA4 GPIO_ACTIVE_HIGH>;
@@ -158,7 +158,7 @@ wifi_pwrseq: sdio-wifi-pwrseq {
 	};

 	/* MIPI DSI panel 1.8v supply */
-	vcc1v8_lcd: vcc1v8-lcd {
+	vcc1v8_lcd: regulator-vcc1v8-lcd {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		regulator-name = "vcc1v8_lcd";
@@ -170,7 +170,7 @@ vcc1v8_lcd: vcc1v8-lcd {
 	};

 	/* MIPI DSI panel 2.8v supply */
-	vcc2v8_lcd: vcc2v8-lcd {
+	vcc2v8_lcd: regulator-vcc2v8-lcd {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		regulator-name = "vcc2v8_lcd";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
index c04bb98a45e5..947bbd62a6b0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
@@ -91,7 +91,7 @@ sgtl5000_clk: sgtl5000-oscillator  {
 			clock-frequency = <24576000>;
 	};

-	dc_12v: dc-12v {
+	dc_12v: regulator-dc-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "dc_12v";
 		regulator-always-on;
@@ -100,7 +100,7 @@ dc_12v: dc-12v {
 		regulator-max-microvolt = <12000000>;
 	};

-	vcc3v3_baseboard: vcc3v3-baseboard {
+	vcc3v3_baseboard: regulator-vcc3v3-baseboard {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_baseboard";
 		regulator-always-on;
@@ -110,7 +110,7 @@ vcc3v3_baseboard: vcc3v3-baseboard {
 		vin-supply = <&dc_12v>;
 	};

-	vcc5v0_baseboard: vcc5v0-baseboard {
+	vcc5v0_baseboard: regulator-vcc5v0-baseboard {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_baseboard";
 		regulator-always-on;
@@ -120,7 +120,7 @@ vcc5v0_baseboard: vcc5v0-baseboard {
 		vin-supply = <&dc_12v>;
 	};

-	vcc5v0_otg: vcc5v0-otg-regulator {
+	vcc5v0_otg: regulator-vcc5v0-otg {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
@@ -130,7 +130,7 @@ vcc5v0_otg: vcc5v0-otg-regulator {
 		regulator-always-on;
 	};

-	vdda_codec: vdda-codec {
+	vdda_codec: regulator-vdda-codec {
 		compatible = "regulator-fixed";
 		regulator-name = "vdda_codec";
 		regulator-boot-on;
@@ -139,7 +139,7 @@ vdda_codec: vdda-codec {
 		vin-supply = <&vcc5v0_baseboard>;
 	};

-	vddd_codec: vddd-codec {
+	vddd_codec: regulator-vddd-codec {
 		compatible = "regulator-fixed";
 		regulator-name = "vddd_codec";
 		regulator-boot-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index ce4be12c5f37..8f92152a5e3b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -40,7 +40,7 @@ clkin_gmac: external-gmac-clock {
 		#clock-cells = <0>;
 	};

-	vcc1v2_phy: vcc1v2-phy {
+	vcc1v2_phy: regulator-vcc1v2-phy {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc1v2_phy";
 		regulator-always-on;
@@ -50,7 +50,7 @@ vcc1v2_phy: vcc1v2-phy {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc3v3_sys: vcc3v3-sys {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-always-on;
@@ -60,7 +60,7 @@ vcc3v3_sys: vcc3v3-sys {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_host: vcc5v0-host-regulator {
+	vcc5v0_host: regulator-vcc5v0-host {
 		compatible = "regulator-fixed";
 		gpio = <&gpio4 RK_PA3 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
@@ -70,7 +70,7 @@ vcc5v0_host: vcc5v0-host-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_sys: vcc5v0-sys {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -79,7 +79,7 @@ vcc5v0_sys: vcc5v0-sys {
 		regulator-max-microvolt = <5000000>;
 	};

-	vcca_0v9: vcca-0v9-regulator {
+	vcca_0v9: regulator-vcca-0v9 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcca_0v9";
 		regulator-always-on;
@@ -89,7 +89,7 @@ vcca_0v9: vcca-0v9-regulator {
 		vin-supply = <&vcc_1v8>;
 	};

-	vcca_1v8: vcca-1v8-regulator {
+	vcca_1v8: regulator-vcca-1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcca_1v8";
 		regulator-always-on;
@@ -99,7 +99,7 @@ vcca_1v8: vcca-1v8-regulator {
 		vin-supply = <&vcc3v3_sys>;
 	};

-	vdd_log: vdd-log {
+	vdd_log: regulator-vdd-log {
 		compatible = "pwm-regulator";
 		pwms = <&pwm2 0 25000 1>;
 		pwm-supply = <&vcc5v0_sys>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts
index 9447c8724b65..ce057e2db242 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts
@@ -16,7 +16,7 @@ aliases {
 	};

 	/* MP8009 PoE PD */
-	poe_12v: poe-12v {
+	poe_12v: regulator-poe-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "poe_12v";
 		regulator-always-on;
@@ -25,7 +25,7 @@ poe_12v: poe-12v {
 		regulator-max-microvolt = <12000000>;
 	};

-	vcc3v3_ngff: vcc3v3-ngff {
+	vcc3v3_ngff: regulator-vcc3v3-ngff {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_ngff";
 		enable-active-high;
@@ -39,7 +39,7 @@ vcc3v3_ngff: vcc3v3-ngff {
 		vin-supply = <&sys_12v>;
 	};

-	vcc3v3_pcie: vcc3v3-pcie {
+	vcc3v3_pcie: regulator-vcc3v3-pcie {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_pcie";
 		enable-active-high;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts
index 7ba1c28f70a9..d53a7bb2d39c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts
@@ -26,7 +26,7 @@ / {
 	model = "Firefly ROC-RK3399-PC-PLUS Board";
 	compatible = "firefly,roc-rk3399-pc-plus", "rockchip,rk3399";

-	dc_12v: dc-12v {
+	dc_12v: regulator-dc-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "dc_12v";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
index d95b1cde1fc3..8a6f226471f7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
@@ -113,7 +113,7 @@ sdio_pwrseq: sdio-pwrseq {
 		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
 	};

-	vcc_vbus_typec0: vcc-vbus-typec0 {
+	vcc_vbus_typec0: regulator-vcc-vbus-typec0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_vbus_typec0";
 		regulator-always-on;
@@ -122,7 +122,7 @@ vcc_vbus_typec0: vcc-vbus-typec0 {
 		regulator-max-microvolt = <5000000>;
 	};

-	sys_12v: sys-12v {
+	sys_12v: regulator-sys-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "sys_12v";
 		regulator-always-on;
@@ -131,7 +131,7 @@ sys_12v: sys-12v {
 	};

 	/* switched by pmic_sleep */
-	vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
+	vcc1v8_s3: vcca1v8_s3: regulator-vcc1v8-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc1v8_s3";
 		regulator-always-on;
@@ -141,7 +141,7 @@ vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
 		vin-supply = <&vcc_1v8>;
 	};

-	vcc3v0_sd: vcc3v0-sd {
+	vcc3v0_sd: regulator-vcc3v0-sd {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PD6 GPIO_ACTIVE_HIGH>;
@@ -154,7 +154,7 @@ vcc3v0_sd: vcc3v0-sd {
 		vin-supply = <&vcc3v3_sys>;
 	};

-	vcc3v3_sys: vcc3v3-sys {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-always-on;
@@ -164,7 +164,7 @@ vcc3v3_sys: vcc3v3-sys {
 		vin-supply = <&sys_12v>;
 	};

-	vcca_0v9: vcca-0v9 {
+	vcca_0v9: regulator-vcca-0v9 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcca_0v9";
 		regulator-always-on;
@@ -175,7 +175,7 @@ vcca_0v9: vcca-0v9 {
 	};

 	/* Actually 3 regulators (host0, 1, 2) controlled by the same gpio */
-	vcc5v0_host: vcc5v0-host-regulator {
+	vcc5v0_host: regulator-vcc5v0-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
@@ -185,7 +185,7 @@ vcc5v0_host: vcc5v0-host-regulator {
 		vin-supply = <&vcc_sys>;
 	};

-	vcc_vbus_typec1: vcc-vbus-typec1 {
+	vcc_vbus_typec1: regulator-vcc-vbus-typec1 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>;
@@ -196,7 +196,7 @@ vcc_vbus_typec1: vcc-vbus-typec1 {
 		vin-supply = <&vcc_sys>;
 	};

-	vcc_sys: vcc-sys {
+	vcc_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio2 RK_PA6 GPIO_ACTIVE_HIGH>;
@@ -209,7 +209,7 @@ vcc_sys: vcc-sys {
 		vin-supply = <&sys_12v>;
 	};

-	vdd_log: vdd-log {
+	vdd_log: regulator-vdd-log {
 		compatible = "pwm-regulator";
 		pwms = <&pwm2 0 25000 1>;
 		regulator-name = "vdd_log";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts
index 475d57f64d58..efd50457e290 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts
@@ -76,7 +76,7 @@ sdio_pwrseq: sdio-pwrseq {
 		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
 	};

-	vcc_3v3: vcc-3v3-regulator {
+	vcc_3v3: regulator-vcc-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_3v3";
 		regulator-always-on;
@@ -86,7 +86,7 @@ vcc_3v3: vcc-3v3-regulator {
 		vin-supply = <&vcc3v3_sys>;
 	};

-	vcc3v3_phy1: vcc3v3-phy1-regulator {
+	vcc3v3_phy1: regulator-vcc3v3-phy1 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_phy1";
 		regulator-always-on;
@@ -96,7 +96,7 @@ vcc3v3_phy1: vcc3v3-phy1-regulator {
 		vin-supply = <&vcc_3v3>;
 	};

-	vcc5v0_host1: vcc5v0-host-regulator {
+	vcc5v0_host1: regulator-vcc5v0-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio3 RK_PD6 GPIO_ACTIVE_HIGH>;
@@ -108,7 +108,7 @@ vcc5v0_host1: vcc5v0-host-regulator {
 		vin-supply = <&vcc5v0_host0_s0>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -117,7 +117,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		regulator-max-microvolt = <5000000>;
 	};

-	vcc5v0_typec: vcc5v0-typec-regulator {
+	vcc5v0_typec: regulator-vcc5v0-typec {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 RK_PA3 GPIO_ACTIVE_HIGH>;
@@ -129,7 +129,7 @@ vcc5v0_typec: vcc5v0-typec-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vdd_log: vdd-log-regulator {
+	vdd_log: regulator-vdd-log {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_log";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
index 9666504cd1c1..3e5a6121abf7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
@@ -72,7 +72,7 @@ dit_p0_0: endpoint {
 		};
 	};

-	vbus_typec: vbus-typec-regulator {
+	vbus_typec: regulator-vbus-typec {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 RK_PA3 GPIO_ACTIVE_HIGH>;
@@ -83,7 +83,7 @@ vbus_typec: vbus-typec-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc12v_dcin: dc-12v {
+	vcc12v_dcin: regulator-dc-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
 		regulator-always-on;
@@ -92,7 +92,7 @@ vcc12v_dcin: dc-12v {
 		regulator-max-microvolt = <12000000>;
 	};

-	vcc3v3_lan: vcc3v3-lan-regulator {
+	vcc3v3_lan: regulator-vcc3v3-lan {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_lan";
 		regulator-always-on;
@@ -102,7 +102,7 @@ vcc3v3_lan: vcc3v3-lan-regulator {
 		vin-supply = <&vcc3v3_sys>;
 	};

-	vcc3v3_pcie: vcc3v3-pcie-regulator {
+	vcc3v3_pcie: regulator-vcc3v3-pcie {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio2 RK_PD2 GPIO_ACTIVE_HIGH>;
@@ -114,7 +114,7 @@ vcc3v3_pcie: vcc3v3-pcie-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc3v3_sys: vcc3v3-sys {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-always-on;
@@ -124,7 +124,7 @@ vcc3v3_sys: vcc3v3-sys {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_host: vcc5v0-host-regulator {
+	vcc5v0_host: regulator-vcc5v0-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PD1 GPIO_ACTIVE_HIGH>;
@@ -135,7 +135,7 @@ vcc5v0_host: vcc5v0-host-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_sys: vcc-sys {
+	vcc5v0_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -145,7 +145,7 @@ vcc5v0_sys: vcc-sys {
 		vin-supply = <&vcc12v_dcin>;
 	};

-	vcc_0v9: vcc-0v9 {
+	vcc_0v9: regulator-vcc-0v9 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_0v9";
 		regulator-always-on;
@@ -155,7 +155,7 @@ vcc_0v9: vcc-0v9 {
 		vin-supply = <&vcc3v3_sys>;
 	};

-	vdd_log: vdd-log {
+	vdd_log: regulator-vdd-log {
 		compatible = "pwm-regulator";
 		pwms = <&pwm2 0 25000 1>;
 		pwm-supply = <&vcc5v0_sys>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
index 8146f870d2bd..433db7de4458 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
@@ -24,7 +24,7 @@ sdio_pwrseq: sdio-pwrseq {
 		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
 	};

-	vcc12v_dcin: vcc12v-dcin {
+	vcc12v_dcin: regulator-vcc12v-dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
 		regulator-min-microvolt = <12000000>;
@@ -33,7 +33,7 @@ vcc12v_dcin: vcc12v-dcin {
 		regulator-boot-on;
 	};

-	vcc1v8_s0: vcc1v8-s0 {
+	vcc1v8_s0: regulator-vcc1v8-s0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc1v8_s0";
 		regulator-min-microvolt = <1800000>;
@@ -41,7 +41,7 @@ vcc1v8_s0: vcc1v8-s0 {
 		regulator-always-on;
 	};

-	vcc5v0_sys: vcc5v0-sys {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-min-microvolt = <5000000>;
@@ -50,7 +50,7 @@ vcc5v0_sys: vcc5v0-sys {
 		vin-supply = <&vcc12v_dcin>;
 	};

-	vcc3v3_sys: vcc3v3-sys {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-min-microvolt = <3300000>;
@@ -59,7 +59,7 @@ vcc3v3_sys: vcc3v3-sys {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc3v3_pcie: vcc3v3-pcie-regulator {
+	vcc3v3_pcie: regulator-vcc3v3-pcie {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		pinctrl-names = "default";
@@ -71,7 +71,7 @@ vcc3v3_pcie: vcc3v3-pcie-regulator {
 		vin-supply = <&vcc3v3_sys>;
 	};

-	vcc5v0_host: vcc5v0-host-regulator {
+	vcc5v0_host: regulator-vcc5v0-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		pinctrl-names = "default";
@@ -83,7 +83,7 @@ vcc5v0_host: vcc5v0-host-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc_0v9: vcc-0v9 {
+	vcc_0v9: regulator-vcc-0v9 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_0v9";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
index 11d99d8b34a2..6fb6d9b32e4d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
@@ -116,7 +116,7 @@ dit_p0_0: endpoint {
 		};
 	};

-	avdd: avdd-regulator {
+	avdd: regulator-avdd {
 		compatible = "regulator-fixed";
 		regulator-name = "avdd";
 		regulator-min-microvolt = <11000000>;
@@ -124,7 +124,7 @@ avdd: avdd-regulator {
 		vin-supply = <&vcc3v3_s0>;
 	};

-	vcc12v_dcin: vcc12v-dcin {
+	vcc12v_dcin: regulator-vcc12v-dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
 		regulator-always-on;
@@ -134,7 +134,7 @@ vcc12v_dcin: vcc12v-dcin {
 	};

 	/* switched by pmic_sleep */
-	vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
+	vcc1v8_s3: vcca1v8_s3: regulator-vcc1v8-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc1v8_s3";
 		regulator-always-on;
@@ -145,7 +145,7 @@ vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
 	};

 	/* micro SD card power */
-	vcc3v0_sd: vcc3v0-sd {
+	vcc3v0_sd: regulator-vcc3v0-sd {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
@@ -162,7 +162,7 @@ regulator-state-mem {
 		};
 	};

-	vcc3v3_pcie: vcc3v3-pcie-regulator {
+	vcc3v3_pcie: regulator-vcc3v3-pcie {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 RK_PD0 GPIO_ACTIVE_HIGH>;
@@ -174,7 +174,7 @@ vcc3v3_pcie: vcc3v3-pcie-regulator {
 		vin-supply = <&vcc12v_dcin>;
 	};

-	vcc3v3_sys: vcc3v3-sys {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-always-on;
@@ -185,7 +185,7 @@ vcc3v3_sys: vcc3v3-sys {
 	};

 	/* Actually 3 regulators (host0, 1, 2) controlled by the same gpio */
-	vcc5v0_host: vcc5v0-host-regulator {
+	vcc5v0_host: regulator-vcc5v0-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;
@@ -196,7 +196,7 @@ vcc5v0_host: vcc5v0-host-regulator {
 		vin-supply = <&vcc5v0_usb>;
 	};

-	vcc5v0_typec: vcc5v0-typec-regulator {
+	vcc5v0_typec: regulator-vcc5v0-typec {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 RK_PA3 GPIO_ACTIVE_HIGH>;
@@ -207,7 +207,7 @@ vcc5v0_typec: vcc5v0-typec-regulator {
 		vin-supply = <&vcc5v0_usb>;
 	};

-	vcc5v0_sys: vcc5v0-sys {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -217,7 +217,7 @@ vcc5v0_sys: vcc5v0-sys {
 		vin-supply = <&vcc12v_dcin>;
 	};

-	vcc5v0_usb: vcc5v0-usb {
+	vcc5v0_usb: regulator-vcc5v0-usb {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb";
 		regulator-always-on;
@@ -227,7 +227,7 @@ vcc5v0_usb: vcc5v0-usb {
 		vin-supply = <&vcc12v_dcin>;
 	};

-	vdd_log: vdd-log {
+	vdd_log: regulator-vdd-log {
 		compatible = "pwm-regulator";
 		pwms = <&pwm2 0 25000 1>;
 		pwm-supply = <&vcc5v0_sys>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
index 31832aae9ab6..874f1f31d321 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
@@ -27,7 +27,7 @@ clkin_gmac: external-gmac-clock {
 		#clock-cells = <0>;
 	};

-	dc_12v: dc-12v {
+	dc_12v: regulator-dc-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "dc_12v";
 		regulator-always-on;
@@ -66,7 +66,7 @@ key-power {
 	};

 	/* switched by pmic_sleep */
-	vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
+	vcc1v8_s3: vcca1v8_s3: regulator-vcc1v8-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc1v8_s3";
 		regulator-always-on;
@@ -76,7 +76,7 @@ vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
 		vin-supply = <&vcc_1v8>;
 	};

-	vcc3v0_sd: vcc3v0-sd {
+	vcc3v0_sd: regulator-vcc3v0-sd {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
@@ -89,7 +89,7 @@ vcc3v0_sd: vcc3v0-sd {
 		vin-supply = <&vcc3v3_sys>;
 	};

-	vcc3v3_sys: vcc3v3-sys {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-always-on;
@@ -99,7 +99,7 @@ vcc3v3_sys: vcc3v3-sys {
 		vin-supply = <&vcc_sys>;
 	};

-	vcc5v0_host: vcc5v0-host-regulator {
+	vcc5v0_host: regulator-vcc5v0-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PD1 GPIO_ACTIVE_HIGH>;
@@ -110,7 +110,7 @@ vcc5v0_host: vcc5v0-host-regulator {
 		vin-supply = <&vcc_sys>;
 	};

-	vcc5v0_typec0: vcc5v0-typec0-regulator {
+	vcc5v0_typec0: regulator-vcc5v0-typec0 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio2 RK_PA0 GPIO_ACTIVE_HIGH>;
@@ -120,7 +120,7 @@ vcc5v0_typec0: vcc5v0-typec0-regulator {
 		vin-supply = <&vcc_sys>;
 	};

-	vcc_sys: vcc-sys {
+	vcc_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-always-on;
@@ -130,7 +130,7 @@ vcc_sys: vcc-sys {
 		vin-supply = <&dc_12v>;
 	};

-	vdd_log: vdd-log {
+	vdd_log: regulator-vdd-log {
 		compatible = "pwm-regulator";
 		pwms = <&pwm2 0 25000 1>;
 		pwm-supply = <&vcc_sys>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
index 8823c924dc1d..888a08d1e737 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
@@ -18,7 +18,7 @@ aliases {
 		mmc1 = &sdmmc;
 	};

-	vcc3v3_pcie: vcc-pcie-regulator {
+	vcc3v3_pcie: regulator-vcc-pcie {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PD4 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts b/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts
index c1194d1e438d..4207f3ae8ffa 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts
@@ -52,7 +52,7 @@ sys_led: sys-led {
 		};
 	};

-	usb_5v: usb-5v-regulator {
+	usb_5v: regulator-usb-5v {
 		compatible = "regulator-fixed";
 		regulator-name = "usb_5v";
 		regulator-always-on;
@@ -61,7 +61,7 @@ usb_5v: usb-5v-regulator {
 		regulator-max-microvolt = <5000000>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -71,7 +71,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		vin-supply = <&usb_5v>;
 	};

-	vcc3v3_sys: vcc3v3-sys-regulator {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-always-on;
@@ -81,7 +81,7 @@ vcc3v3_sys: vcc3v3-sys-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc3v3_pcie: vcc3v3-pcie-regulator {
+	vcc3v3_pcie: regulator-vcc3v3-pcie {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_pcie";
 		regulator-min-microvolt = <3300000>;
@@ -92,7 +92,7 @@ vcc3v3_pcie: vcc3v3-pcie-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_usb20_host: vcc5v0-usb20-host-regulator {
+	vcc5v0_usb20_host: regulator-vcc5v0-usb20-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio2 RK_PB6 GPIO_ACTIVE_HIGH>;
@@ -102,7 +102,7 @@ vcc5v0_usb20_host: vcc5v0-usb20-host-regulator {
 		regulator-always-on;
 	};

-	vcc5v0_usb30_host: vcc5v0-usb30-host-regulator {
+	vcc5v0_usb30_host: regulator-vcc5v0-usb30-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio2 RK_PB5 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
index ae2536c65a83..1df8572fbbf3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
@@ -129,7 +129,7 @@ link1_codec: codec {
 		};
 	};

-	vbat_4g: vbat-4g {
+	vbat_4g: regulator-vbat-4g {
 		compatible = "regulator-fixed";
 		regulator-name = "vbat_4g";
 		regulator-min-microvolt = <3800000>;
@@ -138,7 +138,7 @@ vbat_4g: vbat-4g {
 		vin-supply = <&vbat_4g_en>;
 	};

-	vcc_1v8: vcc-1v8 {
+	vcc_1v8: regulator-vcc-1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_1v8";
 		regulator-always-on;
@@ -148,7 +148,7 @@ vcc_1v8: vcc-1v8 {
 		vin-supply = <&vcc_1v8_en>;
 	};

-	vcc_bat: vcc-bat {
+	vcc_bat: regulator-vcc-bat {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_bat";
 		regulator-always-on;
@@ -156,7 +156,7 @@ vcc_bat: vcc-bat {
 		regulator-max-microvolt = <3800000>;
 	};

-	vcc_hall_3v3: vcc-hall-3v3 {
+	vcc_hall_3v3: regulator-vcc-hall-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_hall_3v3";
 		regulator-always-on;
@@ -165,7 +165,7 @@ vcc_hall_3v3: vcc-hall-3v3 {
 		vin-supply = <&vcc_sys>;
 	};

-	vcc_sys: vcc-sys {
+	vcc_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-always-on;
@@ -174,7 +174,7 @@ vcc_sys: vcc-sys {
 		vin-supply = <&vcc_bat>;
 	};

-	vcc_wl: vcc-wl {
+	vcc_wl: regulator-vcc-wl {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PA0 GPIO_ACTIVE_HIGH>;
@@ -186,7 +186,7 @@ vcc_wl: vcc-wl {
 		vin-supply = <&vcc_bat>;
 	};

-	vdda_0v9: vdda-0v9 {
+	vdda_0v9: regulator-vdda-0v9 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdda_0v9";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi
index db40281eafbe..888524cd2d04 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi
@@ -143,7 +143,7 @@ speaker_amp: speaker-amplifier {
 		VCC-supply = <&vcc_bat>;
 	};

-	vcc_3v3: vcc-3v3-regulator {
+	vcc_3v3: regulator-vcc-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_3v3";
 		regulator-always-on;
@@ -153,7 +153,7 @@ vcc_3v3: vcc-3v3-regulator {
 		vin-supply = <&vcc3v3_sys>;
 	};

-	vcc3v3_minipcie: vcc3v3-minipcie-regulator {
+	vcc3v3_minipcie: regulator-vcc3v3-minipcie {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PC3 GPIO_ACTIVE_HIGH>;
@@ -165,7 +165,7 @@ vcc3v3_minipcie: vcc3v3-minipcie-regulator {
 		vin-supply = <&vcc_sys>;
 	};

-	vcc3v3_sd: vcc3v3-sd-regulator {
+	vcc3v3_sd: regulator-vcc3v3-sd {
 		compatible = "regulator-fixed";
 		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
@@ -176,7 +176,7 @@ vcc3v3_sd: vcc3v3-sd-regulator {
 		vin-supply = <&vcc3v3_sys>;
 	};

-	vcc5v0_flashled: vcc5v0-flashled-regulator {
+	vcc5v0_flashled: regulator-vcc5v0-flashled {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
@@ -188,7 +188,7 @@ vcc5v0_flashled: vcc5v0-flashled-regulator {
 		vin-supply = <&vcc5v_midu>;
 	};

-	vcc5v0_usb_host0: vcc5v0-usb-host0-regulator {
+	vcc5v0_usb_host0: regulator-vcc5v0-usb-host0 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PC4 GPIO_ACTIVE_HIGH>;
@@ -200,7 +200,7 @@ vcc5v0_usb_host0: vcc5v0-usb-host0-regulator {
 		vin-supply = <&vcc5v_midu>;
 	};

-	vcc5v0_usb_host2: vcc5v0-usb-host2-regulator {
+	vcc5v0_usb_host2: regulator-vcc5v0-usb-host2 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PC5 GPIO_ACTIVE_HIGH>;
@@ -212,14 +212,14 @@ vcc5v0_usb_host2: vcc5v0-usb-host2-regulator {
 		vin-supply = <&vcc5v_midu>;
 	};

-	vcc_bat: vcc-bat-regulator {
+	vcc_bat: regulator-vcc-bat {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_bat";
 		regulator-always-on;
 		regulator-boot-on;
 	};

-	vcc_sys: vcc-sys-regulator {
+	vcc_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-always-on;
@@ -227,7 +227,7 @@ vcc_sys: vcc-sys-regulator {
 		vin-supply = <&vcc_bat>;
 	};

-	vdd1v2_dvp: vdd1v2-dvp-regulator {
+	vdd1v2_dvp: regulator-vdd1v2-dvp {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd1v2_dvp";
 		regulator-min-microvolt = <1200000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index 37a1303d9a34..95ed3567a0e4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -117,7 +117,7 @@ simple-audio-card,codec {
 		};
 	};

-	vcc12v_dcin: vcc12v_dcin {
+	vcc12v_dcin: regulator-vcc12v-dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
 		regulator-always-on;
@@ -130,7 +130,7 @@ vcc12v_dcin: vcc12v_dcin {
 	 * With no battery attached, also feeds vcc_bat+
 	 * via ON/OFF_BAT jumper
 	 */
-	vbus: vbus {
+	vbus: regulator-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "vbus";
 		regulator-always-on;
@@ -140,7 +140,7 @@ vbus: vbus {
 		vin-supply = <&vcc12v_dcin>;
 	};

-	vcc3v3_pcie_p: vcc3v3-pcie-p-regulator {
+	vcc3v3_pcie_p: regulator-vcc3v3-pcie-p {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PC6 GPIO_ACTIVE_HIGH>;
@@ -152,7 +152,7 @@ vcc3v3_pcie_p: vcc3v3-pcie-p-regulator {
 		vin-supply = <&vcc_3v3>;
 	};

-	vcc5v0_usb: vcc5v0_usb {
+	vcc5v0_usb: regulator-vcc5v0-usb {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb";
 		regulator-always-on;
@@ -166,7 +166,7 @@ vcc5v0_usb: vcc5v0_usb {
 	 * the host ports are sourced from vcc5v0_usb
 	 * the otg port is sourced from vcc5v0_midu
 	 */
-	vcc5v0_usb20_host: vcc5v0_usb20_host {
+	vcc5v0_usb20_host: regulator-vcc5v0-usb20-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
@@ -178,7 +178,7 @@ vcc5v0_usb20_host: vcc5v0_usb20_host {
 		vin-supply = <&vcc5v0_usb>;
 	};

-	vcc5v0_usb20_otg: vcc5v0_usb20_otg {
+	vcc5v0_usb20_otg: regulator-vcc5v0-usb20-otg {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
@@ -188,7 +188,7 @@ vcc5v0_usb20_otg: vcc5v0_usb20_otg {
 		vin-supply = <&dcdc_boost>;
 	};

-	vcc3v3_sd: vcc3v3_sd {
+	vcc3v3_sd: regulator-vcc3v3-sd {
 		compatible = "regulator-fixed";
 		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
@@ -201,7 +201,7 @@ vcc3v3_sd: vcc3v3_sd {
 	};

 	/* sourced from vbus and vcc_bat+ via rk817 sw5 */
-	vcc_sys: vcc_sys {
+	vcc_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-always-on;
@@ -212,7 +212,7 @@ vcc_sys: vcc_sys {
 	};

 	/* sourced from vcc_sys, sdio module operates internally at 3.3v */
-	vcc_wl: vcc_wl {
+	vcc_wl: regulator-vcc-wl {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_wl";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
index c164074ddf54..e76cad80ce86 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
@@ -81,7 +81,7 @@ sdio_pwrseq: sdio-pwrseq {
 		power-off-delay-us = <5000000>;
 	};

-	vcc3v3_pcie_p: vcc3v3-pcie-p-regulator {
+	vcc3v3_pcie_p: regulator-vcc3v3-pcie-p {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
@@ -93,7 +93,7 @@ vcc3v3_pcie_p: vcc3v3-pcie-p-regulator {
 		vin-supply = <&vcc_3v3>;
 	};

-	vcc5v0_in: vcc5v0-in-regulator {
+	vcc5v0_in: regulator-vcc5v0-in {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_in";
 		regulator-always-on;
@@ -102,7 +102,7 @@ vcc5v0_in: vcc5v0-in-regulator {
 		regulator-max-microvolt = <5000000>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -112,7 +112,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		vin-supply = <&vcc5v0_in>;
 	};

-	vcc3v3_sys: vcc3v3-sys-regulator {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-min-microvolt = <3300000>;
@@ -121,7 +121,7 @@ vcc3v3_sys: vcc3v3-sys-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_usb30_host: vcc5v0-usb30-host-regulator {
+	vcc5v0_usb30_host: regulator-vcc5v0-usb30-host {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb30_host";
 		enable-active-high;
@@ -134,7 +134,7 @@ vcc5v0_usb30_host: vcc5v0-usb30-host-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_usb_otg: vcc5v0-usb-otg-regulator {
+	vcc5v0_usb_otg: regulator-vcc5v0-usb-otg {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb_otg";
 		enable-active-high;
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3-io.dts b/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3-io.dts
index 3ae24e39450a..b5b253f04cdf 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3-io.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3-io.dts
@@ -53,7 +53,7 @@ led-1 {
 		};
 	};

-	vcc5v0_usb30: vcc5v0-usb30-regulator {
+	vcc5v0_usb30: regulator-vcc5v0-usb30 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb30";
 		enable-active-high;
@@ -66,7 +66,7 @@ vcc5v0_usb30: vcc5v0-usb30-regulator {
 		vin-supply = <&vcc_sys>;
 	};

-	vcca1v8_image: vcca1v8-image-regulator {
+	vcca1v8_image: regulator-vcca1v8-image {
 		compatible = "regulator-fixed";
 		regulator-name = "vcca1v8_image";
 		regulator-always-on;
@@ -76,7 +76,7 @@ vcca1v8_image: vcca1v8-image-regulator {
 		vin-supply = <&vcc_1v8_p>;
 	};

-	vdda0v9_image: vdda0v9-image-regulator {
+	vdda0v9_image: regulator-vdda0v9-image {
 		compatible = "regulator-fixed";
 		regulator-name = "vcca0v9_image";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi
index 45de2630bb50..d9d19e4eed86 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi
@@ -28,7 +28,7 @@ led-0 {
 		};
 	};

-	vcc_sys: vcc-sys-regulator {
+	vcc_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-always-on;
@@ -37,7 +37,7 @@ vcc_sys: vcc-sys-regulator {
 		regulator-max-microvolt = <5000000>;
 	};

-	vcc_1v8: vcc-1v8-regulator {
+	vcc_1v8: regulator-vcc-1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_1v8";
 		regulator-always-on;
@@ -47,7 +47,7 @@ vcc_1v8: vcc-1v8-regulator {
 		vin-supply = <&vcc_1v8_p>;
 	};

-	vcc_3v3: vcc-3v3-regulator {
+	vcc_3v3: regulator-vcc-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_3v3";
 		regulator-always-on;
@@ -57,7 +57,7 @@ vcc_3v3: vcc-3v3-regulator {
 		vin-supply = <&vcc3v3_sys>;
 	};

-	vcca_1v8: vcca-1v8-regulator {
+	vcca_1v8: regulator-vcca-1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcca_1v8";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3566-roc-pc.dts
index 67e7801bd489..bb5d5d29b880 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-roc-pc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-roc-pc.dts
@@ -80,7 +80,7 @@ sdio_pwrseq: sdio-pwrseq {
 		reset-gpios = <&gpio2 RK_PB1 GPIO_ACTIVE_LOW>;
 	};

-	usb_5v: usb-5v-regulator {
+	usb_5v: regulator-usb-5v {
 		compatible = "regulator-fixed";
 		regulator-name = "usb_5v";
 		regulator-always-on;
@@ -89,7 +89,7 @@ usb_5v: usb-5v-regulator {
 		regulator-max-microvolt = <5000000>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -99,7 +99,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		vin-supply = <&usb_5v>;
 	};

-	vcc3v3_pcie: vcc3v3-pcie-regulator {
+	vcc3v3_pcie: regulator-vcc3v3-pcie {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PC4 GPIO_ACTIVE_HIGH>;
@@ -111,7 +111,7 @@ vcc3v3_pcie: vcc3v3-pcie-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc3v3_sys: vcc3v3-sys-regulator {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-min-microvolt = <3300000>;
@@ -120,7 +120,7 @@ vcc3v3_sys: vcc3v3-sys-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_usb30_host: vcc5v0-usb30-host-regulator {
+	vcc5v0_usb30_host: regulator-vcc5v0-usb30-host {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb30_host";
 		enable-active-high;
@@ -133,7 +133,7 @@ vcc5v0_usb30_host: vcc5v0-usb30-host-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_usb_otg: vcc5v0-usb-otg-regulator {
+	vcc5v0_usb_otg: regulator-vcc5v0-usb-otg {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb_otg";
 		enable-active-high;
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts b/arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts
index f2cc086e5001..dd90d6df289f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts
@@ -64,7 +64,7 @@ sdio_pwrseq: sdio-pwrseq {
 		reset-gpios = <&gpio0 RK_PC0 GPIO_ACTIVE_LOW>;
 	};

-	vcc5v_dcin: vcc5v-dcin-regulator {
+	vcc5v_dcin: regulator-vcc5v-dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v_dcin";
 		regulator-always-on;
@@ -73,7 +73,7 @@ vcc5v_dcin: vcc5v-dcin-regulator {
 		regulator-max-microvolt = <5000000>;
 	};

-	vcc3v3_pcie: vcc3v3-pcie-regulator {
+	vcc3v3_pcie: regulator-vcc3v3-pcie {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
@@ -85,7 +85,7 @@ vcc3v3_pcie: vcc3v3-pcie-regulator {
 		vin-supply = <&vcc3v3_sys>;
 	};

-	vcc3v3_sys: vcc3v3-sys-regulator {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-always-on;
@@ -95,7 +95,7 @@ vcc3v3_sys: vcc3v3-sys-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -105,7 +105,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		vin-supply = <&vcc5v_dcin>;
 	};

-	vcc5v0_usb30_host: vcc5v0-usb30-host-regulator {
+	vcc5v0_usb30_host: regulator-vcc5v0-usb30-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
@@ -117,7 +117,7 @@ vcc5v0_usb30_host: vcc5v0-usb30-host-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_usb_otg: vcc5v0-usb-otg-regulator {
+	vcc5v0_usb_otg: regulator-vcc5v0-usb-otg {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PC6 GPIO_ACTIVE_HIGH>;
@@ -129,7 +129,7 @@ vcc5v0_usb_otg: vcc5v0-usb-otg-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc_cam: vcc-cam-regulator {
+	vcc_cam: regulator-vcc-cam {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PC4 GPIO_ACTIVE_HIGH>;
@@ -145,7 +145,7 @@ regulator-state-mem {
 		};
 	};

-	vcc_mipi: vcc-mipi-regulator {
+	vcc_mipi: regulator-vcc-mipi {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PC7 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-blade.dts b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-blade.dts
index fdbb4a6a19d8..b64d0c957ef6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-blade.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-blade.dts
@@ -18,7 +18,7 @@ aliases {
 	};

 	/* labeled VCC3V0_SD in schematic to not conflict with PMIC regulator */
-	vcc3v0_sd: vcc3v0-sd-regulator {
+	vcc3v0_sd: regulator-vcc3v0-sd {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v0_sd";
 		regulator-always-on;
@@ -29,7 +29,7 @@ vcc3v0_sd: vcc3v0-sd-regulator {
 	};

 	/* labeled VCC_SSD in schematic */
-	vcc3v3_pcie_p: vcc3v3-pcie-regulator {
+	vcc3v3_pcie_p: regulator-vcc3v3-pcie {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_pcie_p";
 		regulator-always-on;
@@ -39,7 +39,7 @@ vcc3v3_pcie_p: vcc3v3-pcie-regulator {
 		vin-supply = <&vbus>;
 	};

-	vcc5v_dcin: vcc5v-dcin-regulator {
+	vcc5v_dcin: regulator-vcc5v-dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v_dcin";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
index 2b6f0df477b6..38155316846d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
@@ -13,7 +13,7 @@ aliases {
 	};

 	/* labeled +12v in schematic */
-	vcc12v_dcin: vcc12v-dcin-regulator {
+	vcc12v_dcin: regulator-vcc12v-dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
 		regulator-always-on;
@@ -23,7 +23,7 @@ vcc12v_dcin: vcc12v-dcin-regulator {
 	};

 	/* labeled +5v in schematic */
-	vcc_5v: vcc-5v-regulator {
+	vcc_5v: regulator-vcc-5v {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_5v";
 		regulator-always-on;
@@ -33,7 +33,7 @@ vcc_5v: vcc-5v-regulator {
 		vin-supply = <&vcc12v_dcin>;
 	};

-	vcc_sd_pwr: vcc-sd-pwr-regulator {
+	vcc_sd_pwr: regulator-vcc-sd-pwr {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sd_pwr";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-model-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-model-a.dts
index 9a6a63277c3d..2e130eef54df 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-model-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-model-a.dts
@@ -13,7 +13,7 @@ aliases {
 	};

 	/* labeled DCIN_12V in schematic */
-	vcc12v_dcin: vcc12v-dcin-regulator {
+	vcc12v_dcin: regulator-vcc12v-dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
 		regulator-always-on;
@@ -22,7 +22,7 @@ vcc12v_dcin: vcc12v-dcin-regulator {
 		regulator-max-microvolt = <12000000>;
 	};

-	vcc5v0_usb: vcc5v0-usb-regulator {
+	vcc5v0_usb: regulator-vcc5v0-usb {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb";
 		regulator-always-on;
@@ -36,7 +36,7 @@ vcc5v0_usb: vcc5v0-usb-regulator {
 	 * Labelled VCC3V0_SD in schematic to not conflict with PMIC
 	 * regulator, it's 3.3v in actuality
 	 */
-	vcc3v0_sd: vcc3v0-sd-regulator {
+	vcc3v0_sd: regulator-vcc3v0-sd {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v0_sd";
 		regulator-always-on;
@@ -46,7 +46,7 @@ vcc3v0_sd: vcc3v0-sd-regulator {
 		vin-supply = <&vcc3v3_sys>;
 	};

-	vcc3v3_pcie: vcc3v3-pcie-regulator {
+	vcc3v3_pcie: regulator-vcc3v3-pcie {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_pcie";
 		regulator-always-on;
@@ -56,7 +56,7 @@ vcc3v3_pcie: vcc3v3-pcie-regulator {
 		vin-supply = <&vcc12v_dcin>;
 	};

-	vcc12v_pcie: vcc12v-pcie-regulator {
+	vcc12v_pcie: regulator-vcc12v-pcie {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_pcie";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
index e42c474ef4ad..7699f6e90ed7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
@@ -74,7 +74,7 @@ sdio_pwrseq: sdio-pwrseq {
 		reset-gpios = <&gpio2 RK_PC2 GPIO_ACTIVE_LOW>;
 	};

-	vbus: vbus-regulator {
+	vbus: regulator-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "vbus";
 		regulator-always-on;
@@ -84,7 +84,7 @@ vbus: vbus-regulator {
 	};

 	/* sourced from vbus, vbus is provided by the carrier board */
-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -94,7 +94,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		vin-supply = <&vbus>;
 	};

-	vcc3v3_sys: vcc3v3-sys-regulator {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
index c87fad2c34cb..9e4d36ff77a7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
@@ -46,7 +46,7 @@ green_led: led-1 {
 		};
 	};

-	dc_12v: dc-12v-regulator {
+	dc_12v: regulator-dc-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "dc_12v";
 		regulator-always-on;
@@ -73,7 +73,7 @@ ir-receiver {
 		pinctrl-0 = <&ir_receiver_pin>;
 	};

-	vcc3v3_sys: vcc3v3-sys-regulator {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-always-on;
@@ -83,7 +83,7 @@ vcc3v3_sys: vcc3v3-sys-regulator {
 		vin-supply = <&dc_12v>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -93,7 +93,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		vin-supply = <&dc_12v>;
 	};

-	pcie30_avdd0v9: pcie30-avdd0v9-regulator {
+	pcie30_avdd0v9: regulator-pcie30-avdd0v9 {
 		compatible = "regulator-fixed";
 		regulator-name = "pcie30_avdd0v9";
 		regulator-always-on;
@@ -103,7 +103,7 @@ pcie30_avdd0v9: pcie30-avdd0v9-regulator {
 		vin-supply = <&vcc3v3_sys>;
 	};

-	pcie30_avdd1v8: pcie30-avdd1v8-regulator {
+	pcie30_avdd1v8: regulator-pcie30-avdd1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "pcie30_avdd1v8";
 		regulator-always-on;
@@ -114,7 +114,7 @@ pcie30_avdd1v8: pcie30-avdd1v8-regulator {
 	};

 	/* pi6c pcie clock generator feeds both ports */
-	vcc3v3_pi6c_05: vcc3v3-pi6c-05-regulator {
+	vcc3v3_pi6c_05: regulator-vcc3v3-pi6c-05 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_pcie";
 		regulator-min-microvolt = <3300000>;
@@ -126,7 +126,7 @@ vcc3v3_pi6c_05: vcc3v3-pi6c-05-regulator {
 	};

 	/* actually fed by vcc3v3_sys, dependent on pi6c clock generator */
-	vcc3v3_minipcie: vcc3v3-minipcie-regulator {
+	vcc3v3_minipcie: regulator-vcc3v3-minipcie {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_minipcie";
 		regulator-min-microvolt = <3300000>;
@@ -140,7 +140,7 @@ vcc3v3_minipcie: vcc3v3-minipcie-regulator {
 	};

 	/* actually fed by vcc3v3_sys, dependent on pi6c clock generator */
-	vcc3v3_ngff: vcc3v3-ngff-regulator {
+	vcc3v3_ngff: regulator-vcc3v3-ngff {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_ngff";
 		regulator-min-microvolt = <3300000>;
@@ -153,7 +153,7 @@ vcc3v3_ngff: vcc3v3-ngff-regulator {
 		vin-supply = <&vcc3v3_pi6c_05>;
 	};

-	vcc5v0_usb: vcc5v0-usb-regulator {
+	vcc5v0_usb: regulator-vcc5v0-usb {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb";
 		regulator-always-on;
@@ -163,7 +163,7 @@ vcc5v0_usb: vcc5v0-usb-regulator {
 		vin-supply = <&dc_12v>;
 	};

-	vcc5v0_usb_host: vcc5v0-usb-host-regulator {
+	vcc5v0_usb_host: regulator-vcc5v0-usb-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
@@ -175,7 +175,7 @@ vcc5v0_usb_host: vcc5v0-usb-host-regulator {
 		vin-supply = <&vcc5v0_usb>;
 	};

-	vcc5v0_usb_otg: vcc5v0-usb-otg-regulator {
+	vcc5v0_usb_otg: regulator-vcc5v0-usb-otg {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
index 8c3ab07d3807..298a8bd7dc2e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
@@ -26,7 +26,7 @@ chosen: chosen {
 		stdout-path = "serial2:1500000n8";
 	};

-	dc_12v: dc-12v {
+	dc_12v: regulator-dc-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "dc_12v";
 		regulator-always-on;
@@ -73,7 +73,7 @@ simple-audio-card,codec {
 		};
 	};

-	vcc3v3_sys: vcc3v3-sys {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-always-on;
@@ -83,7 +83,7 @@ vcc3v3_sys: vcc3v3-sys {
 		vin-supply = <&dc_12v>;
 	};

-	vcc5v0_sys: vcc5v0-sys {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -93,7 +93,7 @@ vcc5v0_sys: vcc5v0-sys {
 		vin-supply = <&dc_12v>;
 	};

-	vcc5v0_usb: vcc5v0-usb {
+	vcc5v0_usb: regulator-vcc5v0-usb {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb";
 		regulator-always-on;
@@ -103,7 +103,7 @@ vcc5v0_usb: vcc5v0-usb {
 		vin-supply = <&dc_12v>;
 	};

-	vcc5v0_usb_host: vcc5v0-usb-host {
+	vcc5v0_usb_host: regulator-vcc5v0-usb-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
@@ -115,7 +115,7 @@ vcc5v0_usb_host: vcc5v0-usb-host {
 		vin-supply = <&vcc5v0_usb>;
 	};

-	vcc5v0_usb_otg: vcc5v0-usb-otg {
+	vcc5v0_usb_otg: regulator-vcc5v0-usb-otg {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
@@ -127,7 +127,7 @@ vcc5v0_usb_otg: vcc5v0-usb-otg {
 		vin-supply = <&vcc5v0_usb>;
 	};

-	vcc3v3_lcd0_n: vcc3v3-lcd0-n {
+	vcc3v3_lcd0_n: regulator-vcc3v3-lcd0-n {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_lcd0_n";
 		regulator-min-microvolt = <3300000>;
@@ -143,7 +143,7 @@ regulator-state-mem {
 		};
 	};

-	vcc3v3_lcd1_n: vcc3v3-lcd1-n {
+	vcc3v3_lcd1_n: regulator-vcc3v3-lcd1-n {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_lcd1_n";
 		regulator-min-microvolt = <3300000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
index 25c49bdbadbc..b66a351b914c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
@@ -39,7 +39,7 @@ status_led: led-status {
 		};
 	};

-	vcc12v_dcin: vcc12v-dcin-regulator {
+	vcc12v_dcin: regulator-vcc12v-dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
 		regulator-always-on;
@@ -48,7 +48,7 @@ vcc12v_dcin: vcc12v-dcin-regulator {
 		regulator-max-microvolt = <12000000>;
 	};

-	vcc3v3_pcie: vcc3v3-pcie-regulator {
+	vcc3v3_pcie: regulator-vcc3v3-pcie {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_pcie";
 		regulator-always-on;
@@ -58,7 +58,7 @@ vcc3v3_pcie: vcc3v3-pcie-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc3v3_sys: vcc3v3-sys-regulator {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-always-on;
@@ -68,7 +68,7 @@ vcc3v3_sys: vcc3v3-sys-regulator {
 		vin-supply = <&vcc12v_dcin>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -78,7 +78,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		vin-supply = <&vcc12v_dcin>;
 	};

-	vcc5v0_usb_otg: vcc5v0-usb-otg-regulator {
+	vcc5v0_usb_otg: regulator-vcc5v0-usb-otg {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dts b/arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dts
index a3112d5df200..9c6209a64ce6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dts
@@ -51,7 +51,7 @@ hdmi_con_in: endpoint {
 		};
 	};

-	dc_5v: dc-5v-regulator {
+	dc_5v: regulator-dc-5v {
 		compatible = "regulator-fixed";
 		regulator-name = "dc_5v";
 		regulator-always-on;
@@ -60,7 +60,7 @@ dc_5v: dc-5v-regulator {
 		regulator-max-microvolt = <5000000>;
 	};

-	vcc3v3_sys: vcc3v3-sys-regulator {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-always-on;
@@ -70,7 +70,7 @@ vcc3v3_sys: vcc3v3-sys-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -80,7 +80,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		vin-supply = <&dc_5v>;
 	};

-	vcc3v3_m2_pcie: vcc3v3-m2-pcie-regulator {
+	vcc3v3_m2_pcie: regulator-vcc3v3-m2-pcie {
 		compatible = "regulator-fixed";
 		regulator-name = "m2_pcie_3v3";
 		enable-active-high;
@@ -93,7 +93,7 @@ vcc3v3_m2_pcie: vcc3v3-m2-pcie-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc3v3_mini_pcie: vcc3v3-mini-pcie-regulator {
+	vcc3v3_mini_pcie: regulator-vcc3v3-mini-pcie {
 		compatible = "regulator-fixed";
 		regulator-name = "minipcie_3v3";
 		enable-active-high;
@@ -106,7 +106,7 @@ vcc3v3_mini_pcie: vcc3v3-mini-pcie-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_usb20_host: vcc5v0-usb20-host-regulator {
+	vcc5v0_usb20_host: regulator-vcc5v0-usb20-host {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb20_host";
 		enable-active-high;
@@ -115,7 +115,7 @@ vcc5v0_usb20_host: vcc5v0-usb20-host-regulator {
 		pinctrl-names = "default";
 	};

-	vcc5v0_usb30_host: vcc5v0-usb30-host-regulator {
+	vcc5v0_usb30_host: regulator-vcc5v0-usb30-host {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb30_host";
 		enable-active-high;
@@ -124,7 +124,7 @@ vcc5v0_usb30_host: vcc5v0-usb30-host-regulator {
 		pinctrl-names = "default";
 	};

-	vcc5v0_otg_vbus: vcc5v0-otg-vbus-regulator {
+	vcc5v0_otg_vbus: regulator-vcc5v0-otg-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_otg_vbus";
 		enable-active-high;
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi
index 93189f830640..fff654905887 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi
@@ -35,7 +35,7 @@ hdmi_con_in: endpoint {
 		};
 	};

-	vdd_usbc: vdd-usbc-regulator {
+	vdd_usbc: regulator-vdd-usbc {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_usbc";
 		regulator-always-on;
@@ -44,7 +44,7 @@ vdd_usbc: vdd-usbc-regulator {
 		regulator-max-microvolt = <5000000>;
 	};

-	vcc3v3_sys: vcc3v3-sys-regulator {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-always-on;
@@ -54,7 +54,7 @@ vcc3v3_sys: vcc3v3-sys-regulator {
 		vin-supply = <&vdd_usbc>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -64,7 +64,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		vin-supply = <&vdd_usbc>;
 	};

-	vcc3v3_pcie: vcc3v3-pcie-regulator {
+	vcc3v3_pcie: regulator-vcc3v3-pcie {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_pcie";
 		regulator-min-microvolt = <3300000>;
@@ -75,7 +75,7 @@ vcc3v3_pcie: vcc3v3-pcie-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_usb: vcc5v0-usb-regulator {
+	vcc5v0_usb: regulator-vcc5v0-usb {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb";
 		regulator-always-on;
@@ -85,7 +85,7 @@ vcc5v0_usb: vcc5v0-usb-regulator {
 		vin-supply = <&vdd_usbc>;
 	};

-	vcc5v0_usb_host: vcc5v0-usb-host-regulator {
+	vcc5v0_usb_host: regulator-vcc5v0-usb-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
@@ -99,7 +99,7 @@ vcc5v0_usb_host: vcc5v0-usb-host-regulator {
 		vin-supply = <&vcc5v0_usb>;
 	};

-	vcc5v0_usb_otg: vcc5v0-usb-otg-regulator {
+	vcc5v0_usb_otg: regulator-vcc5v0-usb-otg {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
@@ -111,7 +111,7 @@ vcc5v0_usb_otg: vcc5v0-usb-otg-regulator {
 		vin-supply = <&vcc5v0_usb>;
 	};

-	pcie30_avdd0v9: pcie30-avdd0v9-regulator {
+	pcie30_avdd0v9: regulator-pcie30-avdd0v9 {
 		compatible = "regulator-fixed";
 		regulator-name = "pcie30_avdd0v9";
 		regulator-always-on;
@@ -121,7 +121,7 @@ pcie30_avdd0v9: pcie30-avdd0v9-regulator {
 		vin-supply = <&vcc3v3_sys>;
 	};

-	pcie30_avdd1v8: pcie30-avdd1v8-regulator {
+	pcie30_avdd1v8: regulator-pcie30-avdd1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "pcie30_avdd1v8";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
index 6a02db4f073f..b420d76b268f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
@@ -29,7 +29,7 @@ chosen {
 		stdout-path = "serial2:1500000n8";
 	};

-	dc_12v: dc-12v-regulator {
+	dc_12v: regulator-dc-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "dc_12v";
 		regulator-always-on;
@@ -103,7 +103,7 @@ simple-audio-card,codec {
 		};
 	};

-	vcc3v3_pcie: vcc3v3-pcie-regulator {
+	vcc3v3_pcie: regulator-vcc3v3-pcie {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_pcie";
 		enable-active-high;
@@ -116,7 +116,7 @@ vcc3v3_pcie: vcc3v3-pcie-regulator {
 		vin-supply = <&vcc3v3_sys>;
 	};

-	vcc3v3_sys: vcc3v3-sys-regulator {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-always-on;
@@ -126,7 +126,7 @@ vcc3v3_sys: vcc3v3-sys-regulator {
 		vin-supply = <&dc_12v>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -136,7 +136,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		vin-supply = <&dc_12v>;
 	};

-	vcc5v0_usb_host: vcc5v0-usb-host-regulator {
+	vcc5v0_usb_host: regulator-vcc5v0-usb-host {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb_host";
 		enable-active-high;
@@ -148,7 +148,7 @@ vcc5v0_usb_host: vcc5v0-usb-host-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_usb_otg: vcc5v0-usb-otg-regulator {
+	vcc5v0_usb_otg: regulator-vcc5v0-usb-otg {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb_otg";
 		enable-active-high;
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-radxa-cm3i.dtsi b/arch/arm64/boot/dts/rockchip/rk3568-radxa-cm3i.dtsi
index 19d309654bdb..ab6122cc6389 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-radxa-cm3i.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568-radxa-cm3i.dtsi
@@ -29,7 +29,7 @@ led_user: led-0 {
 		};
 	};

-	pcie30_avdd0v9: pcie30-avdd0v9-regulator {
+	pcie30_avdd0v9: regulator-pcie30-avdd0v9 {
 		compatible = "regulator-fixed";
 		regulator-name = "pcie30_avdd0v9";
 		regulator-always-on;
@@ -39,7 +39,7 @@ pcie30_avdd0v9: pcie30-avdd0v9-regulator {
 		vin-supply = <&vcc3v3_sys>;
 	};

-	pcie30_avdd1v8: pcie30-avdd1v8-regulator {
+	pcie30_avdd1v8: regulator-pcie30-avdd1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "pcie30_avdd1v8";
 		regulator-always-on;
@@ -49,7 +49,7 @@ pcie30_avdd1v8: pcie30-avdd1v8-regulator {
 		vin-supply = <&vcc3v3_sys>;
 	};

-	vcc3v3_sys: vcc3v3-sys-regulator {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-always-on;
@@ -59,7 +59,7 @@ vcc3v3_sys: vcc3v3-sys-regulator {
 		vin-supply = <&vcc5v_input>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -70,7 +70,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 	};

 	/* labeled +5v_input in schematic */
-	vcc5v_input: vcc5v-input-regulator {
+	vcc5v_input: regulator-vcc5v-input {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v_input";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts b/arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts
index 01aec2643cc9..1aa3b97e4fd5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts
@@ -36,7 +36,7 @@ led-blue {
 		};
 	};

-	vbus_typec: vbus-typec-regulator {
+	vbus_typec: regulator-vbus-typec {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
@@ -51,7 +51,7 @@ vbus_typec: vbus-typec-regulator {
 	/* actually fed by vcc5v0_sys, dependent
 	 * on pi6c clock generator
 	 */
-	vcc3v3_minipcie: vcc3v3-minipcie-regulator {
+	vcc3v3_minipcie: regulator-vcc3v3-minipcie {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio3 RK_PA7 GPIO_ACTIVE_HIGH>;
@@ -63,7 +63,7 @@ vcc3v3_minipcie: vcc3v3-minipcie-regulator {
 		vin-supply = <&vcc3v3_pi6c_05>;
 	};

-	vcc3v3_ngff: vcc3v3-ngff-regulator {
+	vcc3v3_ngff: regulator-vcc3v3-ngff {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PD6 GPIO_ACTIVE_HIGH>;
@@ -75,7 +75,7 @@ vcc3v3_ngff: vcc3v3-ngff-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc3v3_pcie30x1: vcc3v3-pcie30x1-regulator {
+	vcc3v3_pcie30x1: regulator-vcc3v3-pcie30x1 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
@@ -87,7 +87,7 @@ vcc3v3_pcie30x1: vcc3v3-pcie30x1-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc3v3_pi6c_05: vcc3v3-pi6c-05-regulator {
+	vcc3v3_pi6c_05: regulator-vcc3v3-pi6c-05 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpios = <&gpio0 RK_PC7 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3568-roc-pc.dts
index e333449ead04..68966557ac3d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-roc-pc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-roc-pc.dts
@@ -25,7 +25,7 @@ chosen: chosen {
 		stdout-path = "serial2:1500000n8";
 	};

-	dc_12v: dc-12v-regulator {
+	dc_12v: regulator-dc-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "dc_12v";
 		regulator-always-on;
@@ -73,7 +73,7 @@ hdmi_con_in: endpoint {
 		};
 	};

-	pcie30_avdd0v9: pcie30-avdd0v9-regulator {
+	pcie30_avdd0v9: regulator-pcie30-avdd0v9 {
 		compatible = "regulator-fixed";
 		regulator-name = "pcie30_avdd0v9";
 		regulator-always-on;
@@ -83,7 +83,7 @@ pcie30_avdd0v9: pcie30-avdd0v9-regulator {
 		vin-supply = <&vcc3v3_sys>;
 	};

-	pcie30_avdd1v8: pcie30-avdd1v8-regulator {
+	pcie30_avdd1v8: regulator-pcie30-avdd1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "pcie30_avdd1v8";
 		regulator-always-on;
@@ -93,7 +93,7 @@ pcie30_avdd1v8: pcie30-avdd1v8-regulator {
 		vin-supply = <&vcc3v3_sys>;
 	};

-	vcc3v3_sys: vcc3v3-sys-regulator {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-always-on;
@@ -103,7 +103,7 @@ vcc3v3_sys: vcc3v3-sys-regulator {
 		vin-supply = <&dc_12v>;
 	};

-	vcc3v3_pcie: vcc3v3-pcie-regulator {
+	vcc3v3_pcie: regulator-vcc3v3-pcie {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_pcie";
 		enable-active-high;
@@ -116,7 +116,7 @@ vcc3v3_pcie: vcc3v3-pcie-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -126,7 +126,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		vin-supply = <&dc_12v>;
 	};

-	vcc5v0_usb: vcc5v0-usb-regulator {
+	vcc5v0_usb: regulator-vcc5v0-usb {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb";
 		regulator-always-on;
@@ -136,7 +136,7 @@ vcc5v0_usb: vcc5v0-usb-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_host: vcc5v0-host-regulator {
+	vcc5v0_host: regulator-vcc5v0-host {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_host";
 		enable-active-high;
@@ -147,7 +147,7 @@ vcc5v0_host: vcc5v0-host-regulator {
 		vin-supply = <&vcc5v0_usb>;
 	};

-	vcc5v0_otg: vcc5v0-otg-regulator {
+	vcc5v0_otg: regulator-vcc5v0-otg {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_otg";
 		enable-active-high;
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index 59f1403b4fa5..25b8f588cf86 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -79,14 +79,14 @@ sdio_pwrseq: sdio-pwrseq {
 		reset-gpios = <&gpio3 RK_PD4 GPIO_ACTIVE_LOW>;
 	};

-	vcc12v_dcin: vcc12v-dcin-regulator {
+	vcc12v_dcin: regulator-vcc12v-dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
 		regulator-always-on;
 		regulator-boot-on;
 	};

-	pcie30_avdd0v9: pcie30-avdd0v9-regulator {
+	pcie30_avdd0v9: regulator-pcie30-avdd0v9 {
 		compatible = "regulator-fixed";
 		regulator-name = "pcie30_avdd0v9";
 		regulator-always-on;
@@ -96,7 +96,7 @@ pcie30_avdd0v9: pcie30-avdd0v9-regulator {
 		vin-supply = <&vcc3v3_sys>;
 	};

-	pcie30_avdd1v8: pcie30-avdd1v8-regulator {
+	pcie30_avdd1v8: regulator-pcie30-avdd1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "pcie30_avdd1v8";
 		regulator-always-on;
@@ -107,7 +107,7 @@ pcie30_avdd1v8: pcie30-avdd1v8-regulator {
 	};

 	/* pi6c pcie clock generator */
-	vcc3v3_pi6c_03: vcc3v3-pi6c-03-regulator {
+	vcc3v3_pi6c_03: regulator-vcc3v3-pi6c-03 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_pi6c_03";
 		regulator-always-on;
@@ -117,7 +117,7 @@ vcc3v3_pi6c_03: vcc3v3-pi6c-03-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc3v3_pcie: vcc3v3-pcie-regulator {
+	vcc3v3_pcie: regulator-vcc3v3-pcie {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpios = <&gpio0 RK_PD4 GPIO_ACTIVE_HIGH>;
@@ -129,7 +129,7 @@ vcc3v3_pcie: vcc3v3-pcie-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc3v3_sys: vcc3v3-sys-regulator {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-always-on;
@@ -139,7 +139,7 @@ vcc3v3_sys: vcc3v3-sys-regulator {
 		vin-supply = <&vcc12v_dcin>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -149,7 +149,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		vin-supply = <&vcc12v_dcin>;
 	};

-	vcc5v0_usb: vcc5v0-usb-regulator {
+	vcc5v0_usb: regulator-vcc5v0-usb {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb";
 		regulator-always-on;
@@ -159,7 +159,7 @@ vcc5v0_usb: vcc5v0-usb-regulator {
 		vin-supply = <&vcc12v_dcin>;
 	};

-	vcc5v0_usb_host: vcc5v0-usb-host-regulator {
+	vcc5v0_usb_host: regulator-vcc5v0-usb-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
@@ -171,7 +171,7 @@ vcc5v0_usb_host: vcc5v0-usb-host-regulator {
 		vin-supply = <&vcc5v0_usb>;
 	};

-	vcc5v0_usb_hub: vcc5v0-usb-hub-regulator {
+	vcc5v0_usb_hub: regulator-vcc5v0-usb-hub {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
@@ -182,7 +182,7 @@ vcc5v0_usb_hub: vcc5v0-usb-hub-regulator {
 		vin-supply = <&vcc5v0_usb>;
 	};

-	vcc5v0_usb_otg: vcc5v0-usb-otg-regulator {
+	vcc5v0_usb_otg: regulator-vcc5v0-usb-otg {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
@@ -194,7 +194,7 @@ vcc5v0_usb_otg: vcc5v0-usb-otg-regulator {
 		vin-supply = <&vcc5v0_usb>;
 	};

-	vcc_cam: vcc-cam-regulator {
+	vcc_cam: regulator-vcc-cam {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 RK_PB1 GPIO_ACTIVE_HIGH>;
@@ -210,7 +210,7 @@ regulator-state-mem {
 		};
 	};

-	vcc_mipi: vcc-mipi-regulator {
+	vcc_mipi: regulator-vcc-mipi {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio3 RK_PC0 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5.dts b/arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5.dts
index 170b14f92f51..a7610fde93d6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5.dts
@@ -39,7 +39,7 @@ hdmi_tx_in: endpoint {
 		};
 	};

-	hdmi_tx_5v: hdmi-tx-5v-regulator {
+	hdmi_tx_5v: regulator-hdmi-tx-5v {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PC5 GPIO_ACTIVE_HIGH>;
@@ -70,7 +70,7 @@ simple-audio-card,codec {
 		};
 	};

-	vcc12v_cam: vcc12v-cam-regulator {
+	vcc12v_cam: regulator-vcc12v-cam {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio2 RK_PD1 GPIO_ACTIVE_HIGH>;
@@ -82,7 +82,7 @@ vcc12v_cam: vcc12v-cam-regulator {
 		vin-supply = <&vcc12v_in>;
 	};

-	vcc12v_in: vcc12v-in-regulator {
+	vcc12v_in: regulator-vcc12v-in {
 		compatible = "regulator-fixed";
 		regulator-name = "12v_in";
 		regulator-always-on;
@@ -91,7 +91,7 @@ vcc12v_in: vcc12v-in-regulator {
 		regulator-max-microvolt = <12000000>;
 	};

-	vcc3v8_cam: vcc3v8-cam-regulator {
+	vcc3v8_cam: regulator-vcc3v8-cam {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PC3 GPIO_ACTIVE_HIGH>;
@@ -103,7 +103,7 @@ vcc3v8_cam: vcc3v8-cam-regulator {
 		vin-supply = <&vcc5v_in>;
 	};

-	vcc3v3_sys: vcc3v3-sys-regulator {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "3v3_sys";
 		regulator-always-on;
@@ -113,7 +113,7 @@ vcc3v3_sys: vcc3v3-sys-regulator {
 		vin-supply = <&vcc5v_in>;
 	};

-	vcc5v_in: vcc5v-in-regulator {
+	vcc5v_in: regulator-vcc5v-in {
 		compatible = "regulator-fixed";
 		regulator-name = "5v_in";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-armsom-lm7.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-armsom-lm7.dtsi
index d221efd6115e..a3138d2d384c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-armsom-lm7.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-armsom-lm7.dtsi
@@ -17,7 +17,7 @@ chosen {
 		stdout-path = "serial2:1500000n8";
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -26,7 +26,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		regulator-max-microvolt = <5000000>;
 	};

-	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
+	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_1v1_nldo_s3";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts b/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts
index c667704ba985..349ca36fb7b6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts
@@ -61,7 +61,7 @@ fan: pwm-fan {
 		#cooling-cells = <2>;
 	};

-	vcc3v3_pcie2x1l2: vcc3v3-pcie2x1l2-regulator {
+	vcc3v3_pcie2x1l2: regulator-vcc3v3-pcie2x1l2 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_pcie2x1l2";
 		regulator-min-microvolt = <3300000>;
@@ -70,7 +70,7 @@ vcc3v3_pcie2x1l2: vcc3v3-pcie2x1l2-regulator {
 		vin-supply = <&vcc_3v3_s3>;
 	};

-	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
+	vcc3v3_pcie30: regulator-vcc3v3-pcie30 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpios = <&gpio1 RK_PA4 GPIO_ACTIVE_HIGH>;
@@ -81,7 +81,7 @@ vcc3v3_pcie30: vcc3v3-pcie30-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_host: vcc5v0-host-regulator {
+	vcc5v0_host: regulator-vcc5v0-host {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_host";
 		regulator-boot-on;
@@ -95,7 +95,7 @@ vcc5v0_host: vcc5v0-host-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -104,7 +104,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		regulator-max-microvolt = <5000000>;
 	};

-	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
+	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_1v1_nldo_s3";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-armsom-w3.dts b/arch/arm64/boot/dts/rockchip/rk3588-armsom-w3.dts
index 12abbab9eea4..779cd1b1798c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-armsom-w3.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-armsom-w3.dts
@@ -74,7 +74,7 @@ rfkill-bt {
 		shutdown-gpios = <&gpio3 RK_PD5 GPIO_ACTIVE_HIGH>;
 	};

-	vcc3v3_pcie2x1l0: vcc3v3-pcie2x1l0-regulator {
+	vcc3v3_pcie2x1l0: regulator-vcc3v3-pcie2x1l0 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpios = <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
@@ -89,7 +89,7 @@ vcc3v3_pcie2x1l0: vcc3v3-pcie2x1l0-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc3v3_pcie2x1l2: vcc3v3-pcie2x1l2-regulator {
+	vcc3v3_pcie2x1l2: regulator-vcc3v3-pcie2x1l2 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_pcie2x1l2";
 		regulator-min-microvolt = <3300000>;
@@ -98,7 +98,7 @@ vcc3v3_pcie2x1l2: vcc3v3-pcie2x1l2-regulator {
 		vin-supply = <&vcc_3v3_s3>;
 	};

-	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
+	vcc3v3_pcie30: regulator-vcc3v3-pcie30 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpios = <&gpio1 RK_PA4 GPIO_ACTIVE_HIGH>;
@@ -111,7 +111,7 @@ vcc3v3_pcie30: vcc3v3-pcie30-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_host: vcc5v0-host-regulator {
+	vcc5v0_host: regulator-vcc5v0-host {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_host";
 		regulator-boot-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts
index a4946cdc3bb3..2d27b50184a6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts
@@ -33,7 +33,7 @@ green_led: led-0 {
 		};
 	};

-	vcc12v_dcin: vcc12v-dcin-regulator {
+	vcc12v_dcin: regulator-vcc12v-dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
 		regulator-always-on;
@@ -42,7 +42,7 @@ vcc12v_dcin: vcc12v-dcin-regulator {
 		regulator-max-microvolt = <12000000>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -52,7 +52,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		vin-supply = <&vcc12v_dcin>;
 	};

-	vcc3v3_sys: vcc3v3-sys-regulator {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-always-on;
@@ -62,7 +62,7 @@ vcc3v3_sys: vcc3v3-sys-regulator {
 		vin-supply = <&vcc12v_dcin>;
 	};

-	vcc3v3_lcd: vcc3v3-lcd-regulator {
+	vcc3v3_lcd: regulator-vcc3v3-lcd {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_lcd";
 		enable-active-high;
@@ -72,7 +72,7 @@ vcc3v3_lcd: vcc3v3-lcd-regulator {
 		vin-supply = <&vcc3v3_sys>;
 	};

-	vcc5v0_usb_host1: vcc5v0_usb_host2: vcc5v0-usb-host-regulator {
+	vcc5v0_usb_host1: vcc5v0_usb_host2: regulator-vcc5v0-usb-host {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_host";
 		regulator-boot-on;
@@ -86,7 +86,7 @@ vcc5v0_usb_host1: vcc5v0_usb_host2: vcc5v0-usb-host-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_usb30_otg: vcc5v0-usb30-otg-regulator {
+	vcc5v0_usb30_otg: regulator-vcc5v0-usb30-otg {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_otg";
 		regulator-boot-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dts b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dts
index 6418286efe40..1e6db2f2f4af 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dts
@@ -58,7 +58,7 @@ charging_red: led-2 {
 		};
 	};

-	vcc12v_dcin: vcc12v-dcin-regulator {
+	vcc12v_dcin: regulator-vcc12v-dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
 		regulator-always-on;
@@ -67,7 +67,7 @@ vcc12v_dcin: vcc12v-dcin-regulator {
 		regulator-max-microvolt = <12000000>;
 	};

-	vcc_sys: vcc-sys-regulator {
+	vcc_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-always-on;
@@ -77,7 +77,7 @@ vcc_sys: vcc-sys-regulator {
 		vin-supply = <&vcc12v_dcin>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -87,7 +87,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		vin-supply = <&vcc_sys>;
 	};

-	vcc3v3_sys: vcc3v3-sys-regulator {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-always-on;
@@ -97,7 +97,7 @@ vcc3v3_sys: vcc3v3-sys-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc3v3_lcd: vcc3v3-lcd-regulator {
+	vcc3v3_lcd: regulator-vcc3v3-lcd {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_lcd";
 		enable-active-high;
@@ -107,7 +107,7 @@ vcc3v3_lcd: vcc3v3-lcd-regulator {
 		vin-supply = <&vcc3v3_sys>;
 	};

-	vcc5v0_usb: vcc5v0-usb-regulator {
+	vcc5v0_usb: regulator-vcc5v0-usb {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb";
 		regulator-boot-on;
@@ -121,7 +121,7 @@ vcc5v0_usb: vcc5v0-usb-regulator {
 		vin-supply = <&vcc_sys>;
 	};

-	vcc5v0_usb_host0: vcc5v0_usb30_host: vcc5v0-usb-host-regulator {
+	vcc5v0_usb_host0: vcc5v0_usb30_host: regulator-vcc5v0-usb-host {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_host";
 		regulator-boot-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi
index fde8b228f2c7..71ed680621b8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi
@@ -36,7 +36,7 @@ chosen {
 		stdout-path = "serial2:1500000n8";
 	};

-	avdd0v85_pcie20: avdd0v85-pcie20-regulator {
+	avdd0v85_pcie20: regulator-avdd0v85-pcie20 {
 		compatible = "regulator-fixed";
 		regulator-name = "avdd0v85_pcie20";
 		regulator-boot-on;
@@ -46,7 +46,7 @@ avdd0v85_pcie20: avdd0v85-pcie20-regulator {
 		vin-supply = <&vdd_0v85_s0>;
 	};

-	avdd1v8_pcie20: avdd1v8-pcie20-regulator {
+	avdd1v8_pcie20: regulator-avdd1v8-pcie20 {
 		compatible = "regulator-fixed";
 		regulator-name = "avdd1v8_pcie20";
 		regulator-boot-on;
@@ -56,7 +56,7 @@ avdd1v8_pcie20: avdd1v8-pcie20-regulator {
 		vin-supply = <&avcc_1v8_s0>;
 	};

-	avdd0v75_pcie30: avdd0v75-pcie30-regulator {
+	avdd0v75_pcie30: regulator-avdd0v75-pcie30 {
 		compatible = "regulator-fixed";
 		regulator-name = "avdd0v75_pcie30";
 		regulator-boot-on;
@@ -66,7 +66,7 @@ avdd0v75_pcie30: avdd0v75-pcie30-regulator {
 		vin-supply = <&avdd_0v75_s0>;
 	};

-	pcie30_avdd1v8: avdd1v8-pcie30-regulator {
+	pcie30_avdd1v8: regulator-avdd1v8-pcie30 {
 		compatible = "regulator-fixed";
 		regulator-name = "pcie30_avdd1v8";
 		regulator-boot-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-common.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-common.dtsi
index 03fd193be253..5e72d0eff0e0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-common.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-common.dtsi
@@ -24,7 +24,7 @@ led_user: led-0 {
 		};
 	};

-	vcc12v_dcin: vcc12v-dcin-regulator {
+	vcc12v_dcin: regulator-vcc12v-dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
 		regulator-always-on;
@@ -33,7 +33,7 @@ vcc12v_dcin: vcc12v-dcin-regulator {
 		regulator-max-microvolt = <12000000>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -43,7 +43,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		vin-supply = <&vcc12v_dcin>;
 	};

-	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
+	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_1v1_nldo_s3";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-io.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-io.dtsi
index 7b1317898358..05ae9bdcfbbd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-io.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-io.dtsi
@@ -10,7 +10,7 @@ chosen {
 		stdout-path = "serial2:1500000n8";
 	};

-	vcc3v3_pcie2x1l0: vcc3v3-pcie2x1l0-regulator {
+	vcc3v3_pcie2x1l0: regulator-vcc3v3-pcie2x1l0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_pcie2x1l0";
 		regulator-min-microvolt = <3300000>;
@@ -19,7 +19,7 @@ vcc3v3_pcie2x1l0: vcc3v3-pcie2x1l0-regulator {
 		vin-supply = <&vcc_3v3_s3>;
 	};

-	vcc3v3_pcie3x2: vcc3v3-pcie3x2-regulator {
+	vcc3v3_pcie3x2: regulator-vcc3v3-pcie3x2 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpios = <&gpio2 RK_PC4 GPIO_ACTIVE_HIGH>; /* PCIE_4G_PWEN */
@@ -32,7 +32,7 @@ vcc3v3_pcie3x2: vcc3v3-pcie3x2-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc3v3_pcie3x4: vcc3v3-pcie3x4-regulator {
+	vcc3v3_pcie3x4: regulator-vcc3v3-pcie3x4 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpios = <&gpio2 RK_PC5 GPIO_ACTIVE_HIGH>; /* PCIE30x4_PWREN_H */
@@ -45,7 +45,7 @@ vcc3v3_pcie3x4: vcc3v3-pcie3x4-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_host: vcc5v0-host-regulator {
+	vcc5v0_host: regulator-vcc5v0-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio3 RK_PC7 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
index 00f660d50127..3feefa86226c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
@@ -120,7 +120,7 @@ backlight: backlight {
 		pwms = <&pwm2 0 25000 0>;
 	};

-	pcie20_avdd0v85: pcie20-avdd0v85-regulator {
+	pcie20_avdd0v85: regulator-pcie20-avdd0v85 {
 		compatible = "regulator-fixed";
 		regulator-name = "pcie20_avdd0v85";
 		regulator-always-on;
@@ -130,7 +130,7 @@ pcie20_avdd0v85: pcie20-avdd0v85-regulator {
 		vin-supply = <&avdd_0v85_s0>;
 	};

-	pcie20_avdd1v8: pcie20-avdd1v8-regulator {
+	pcie20_avdd1v8: regulator-pcie20-avdd1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "pcie20_avdd1v8";
 		regulator-always-on;
@@ -140,7 +140,7 @@ pcie20_avdd1v8: pcie20-avdd1v8-regulator {
 		vin-supply = <&avcc_1v8_s0>;
 	};

-	pcie30_avdd0v75: pcie30-avdd0v75-regulator {
+	pcie30_avdd0v75: regulator-pcie30-avdd0v75 {
 		compatible = "regulator-fixed";
 		regulator-name = "pcie30_avdd0v75";
 		regulator-always-on;
@@ -150,7 +150,7 @@ pcie30_avdd0v75: pcie30-avdd0v75-regulator {
 		vin-supply = <&avdd_0v75_s0>;
 	};

-	pcie30_avdd1v8: pcie30-avdd1v8-regulator {
+	pcie30_avdd1v8: regulator-pcie30-avdd1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "pcie30_avdd1v8";
 		regulator-always-on;
@@ -160,7 +160,7 @@ pcie30_avdd1v8: pcie30-avdd1v8-regulator {
 		vin-supply = <&avcc_1v8_s0>;
 	};

-	vbus5v0_typec: vbus5v0-typec-regulator {
+	vbus5v0_typec: regulator-vbus5v0-typec {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PD0 GPIO_ACTIVE_HIGH>;
@@ -172,7 +172,7 @@ vbus5v0_typec: vbus5v0-typec-regulator {
 		vin-supply = <&vcc5v0_usb>;
 	};

-	vcc12v_dcin: vcc12v-dcin-regulator {
+	vcc12v_dcin: regulator-vcc12v-dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
 		regulator-always-on;
@@ -181,7 +181,7 @@ vcc12v_dcin: vcc12v-dcin-regulator {
 		regulator-max-microvolt = <12000000>;
 	};

-	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
+	vcc3v3_pcie30: regulator-vcc3v3-pcie30 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_pcie30";
 		regulator-min-microvolt = <3300000>;
@@ -194,7 +194,7 @@ vcc3v3_pcie30: vcc3v3-pcie30-regulator {
 		pinctrl-0 = <&vcc3v3_pcie30_en>;
 	};

-	vcc5v0_host: vcc5v0-host-regulator {
+	vcc5v0_host: regulator-vcc5v0-host {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_host";
 		regulator-boot-on;
@@ -208,7 +208,7 @@ vcc5v0_host: vcc5v0-host-regulator {
 		vin-supply = <&vcc5v0_usb>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -218,7 +218,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		vin-supply = <&vcc12v_dcin>;
 	};

-	vcc5v0_usbdcin: vcc5v0-usbdcin-regulator {
+	vcc5v0_usbdcin: regulator-vcc5v0-usbdcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usbdcin";
 		regulator-always-on;
@@ -228,7 +228,7 @@ vcc5v0_usbdcin: vcc5v0-usbdcin-regulator {
 		vin-supply = <&vcc12v_dcin>;
 	};

-	vcc5v0_usb: vcc5v0-usb-regulator {
+	vcc5v0_usb: regulator-vcc5v0-usb {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-fet3588-c.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-fet3588-c.dtsi
index 47e64d547ea9..390051317389 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-fet3588-c.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-fet3588-c.dtsi
@@ -29,7 +29,7 @@ io-led {
 		};
 	};

-	pcie20_avdd0v85: pcie20-avdd0v85-regulator {
+	pcie20_avdd0v85: regulator-pcie20-avdd0v85 {
 		compatible = "regulator-fixed";
 		regulator-name = "pcie20_avdd0v85";
 		regulator-always-on;
@@ -39,7 +39,7 @@ pcie20_avdd0v85: pcie20-avdd0v85-regulator {
 		vin-supply = <&vdd_0v85_s0>;
 	};

-	pcie20_avdd1v8: pcie20-avdd1v8-regulator {
+	pcie20_avdd1v8: regulator-pcie20-avdd1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "pcie20_avdd1v8";
 		regulator-always-on;
@@ -49,7 +49,7 @@ pcie20_avdd1v8: pcie20-avdd1v8-regulator {
 		vin-supply = <&avcc_1v8_s0>;
 	};

-	pcie30_avdd0v75: pcie30-avdd0v75-regulator {
+	pcie30_avdd0v75: regulator-pcie30-avdd0v75 {
 		compatible = "regulator-fixed";
 		regulator-name = "pcie30_avdd0v75";
 		regulator-always-on;
@@ -59,7 +59,7 @@ pcie30_avdd0v75: pcie30-avdd0v75-regulator {
 		vin-supply = <&avdd_0v75_s0>;
 	};

-	pcie30_avdd1v8: pcie30-avdd1v8-regulator {
+	pcie30_avdd1v8: regulator-pcie30-avdd1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "pcie30_avdd1v8";
 		regulator-always-on;
@@ -69,7 +69,7 @@ pcie30_avdd1v8: pcie30-avdd1v8-regulator {
 		vin-supply = <&avcc_1v8_s0>;
 	};

-	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
+	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_1v1_nldo_s3";
 		regulator-always-on;
@@ -79,7 +79,7 @@ vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc4v0_sys: vcc4v0-sys-regulator {
+	vcc4v0_sys: regulator-vcc4v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc4v0_sys";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
index 56f87a603581..73deb59ebf9e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
@@ -43,7 +43,7 @@ chosen {
 	};

 	/* DCIN is 12-24V but standard is 12V */
-	dc_12v: dc-12v-regulator {
+	dc_12v: regulator-dc-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "dc_12v";
 		regulator-always-on;
@@ -99,7 +99,7 @@ pps {
 		gpios = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
 	};

-	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
+	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_1v1_nldo_s3";
 		regulator-always-on;
@@ -109,7 +109,7 @@ vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc_1v2_s3: vcc-1v2-s3-regulator {
+	vcc_1v2_s3: regulator-vcc-1v2-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_1v2_s3";
 		regulator-always-on;
@@ -120,7 +120,7 @@ vcc_1v2_s3: vcc-1v2-s3-regulator {
 	};

 	/* Exposed on P14 and P15 */
-	vcc_2v8_s3: vcc-2v8-s3-regulator {
+	vcc_2v8_s3: regulator-vcc-2v8-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_2v8_s3";
 		regulator-always-on;
@@ -130,7 +130,7 @@ vcc_2v8_s3: vcc-2v8-s3-regulator {
 		vin-supply = <&vcc_3v3_s3>;
 	};

-	vcc_5v0_usb_a: vcc-5v0-usb-a-regulator {
+	vcc_5v0_usb_a: regulator-vcc-5v0-usb-a {
 		compatible = "regulator-fixed";
 		regulator-name = "usb_a_vcc";
 		regulator-min-microvolt = <5000000>;
@@ -140,7 +140,7 @@ vcc_5v0_usb_a: vcc-5v0-usb-a-regulator {
 		enable-active-high;
 	};

-	vcc_5v0_usb_c1: vcc-5v0-usb-c1-regulator {
+	vcc_5v0_usb_c1: regulator-vcc-5v0-usb-c1 {
 		compatible = "regulator-fixed";
 		regulator-name = "5v_usbc1";
 		regulator-min-microvolt = <5000000>;
@@ -150,7 +150,7 @@ vcc_5v0_usb_c1: vcc-5v0-usb-c1-regulator {
 		enable-active-high;
 	};

-	vcc_5v0_usb_c2: vcc-5v0-usb-c2-regulator {
+	vcc_5v0_usb_c2: regulator-vcc-5v0-usb-c2 {
 		compatible = "regulator-fixed";
 		regulator-name = "5v_usbc2";
 		regulator-min-microvolt = <5000000>;
@@ -160,7 +160,7 @@ vcc_5v0_usb_c2: vcc-5v0-usb-c2-regulator {
 		enable-active-high;
 	};

-	vcc3v3_mdot2: vcc3v3-mdot2-regulator {
+	vcc3v3_mdot2: regulator-vcc3v3-mdot2 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_mdot2";
 		regulator-always-on;
@@ -170,7 +170,7 @@ vcc3v3_mdot2: vcc3v3-mdot2-regulator {
 		vin-supply = <&dc_12v>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -180,7 +180,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		vin-supply = <&dc_12v>;
 	};

-	vcc5v0_usb: vcc5v0-usb-regulator {
+	vcc5v0_usb: regulator-vcc5v0-usb {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6-lts.dts b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6-lts.dts
index 2d92bbb4027d..ff855064be08 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6-lts.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6-lts.dts
@@ -15,7 +15,7 @@ / {
 	compatible = "friendlyarm,nanopc-t6-lts", "rockchip,rk3588";

 	/* provide power for on-board USB 2.0 hub */
-	vcc5v0_usb20_host: vcc5v0-usb20-host-regulator {
+	vcc5v0_usb20_host: regulator-vcc5v0-usb20-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 RK_PA4 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
index 92321c1d3ff1..40290a81bb9d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
@@ -14,7 +14,7 @@ / {
 	model = "FriendlyElec NanoPC-T6";
 	compatible = "friendlyarm,nanopc-t6", "rockchip,rk3588";

-	vdd_4g_3v3: vdd-4g-3v3-regulator {
+	vdd_4g_3v3: regulator-vdd-4g-3v3 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PC6 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
index fc131789b4c3..0cc0fc9a43cb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
@@ -94,7 +94,7 @@ simple-audio-card,codec {
 		};
 	};

-	vcc12v_dcin: vcc12v-dcin-regulator {
+	vcc12v_dcin: regulator-vcc12v-dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
 		regulator-always-on;
@@ -104,7 +104,7 @@ vcc12v_dcin: vcc12v-dcin-regulator {
 	};

 	/* vcc5v0_sys powers peripherals */
-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -115,7 +115,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 	};

 	/* vcc4v0_sys powers the RK806, RK860's */
-	vcc4v0_sys: vcc4v0-sys-regulator {
+	vcc4v0_sys: regulator-vcc4v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc4v0_sys";
 		regulator-always-on;
@@ -125,7 +125,7 @@ vcc4v0_sys: vcc4v0-sys-regulator {
 		vin-supply = <&vcc12v_dcin>;
 	};

-	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
+	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc-1v1-nldo-s3";
 		regulator-always-on;
@@ -135,7 +135,7 @@ vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
 		vin-supply = <&vcc4v0_sys>;
 	};

-	vcc_3v3_pcie20: vcc3v3-pcie20-regulator {
+	vcc_3v3_pcie20: regulator-vcc3v3-pcie20 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_3v3_pcie20";
 		regulator-always-on;
@@ -145,7 +145,7 @@ vcc_3v3_pcie20: vcc3v3-pcie20-regulator {
 		vin-supply = <&vcc_3v3_s3>;
 	};

-	vbus5v0_typec: vbus5v0-typec-regulator {
+	vbus5v0_typec: regulator-vbus5v0-typec {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
@@ -159,7 +159,7 @@ vbus5v0_typec: vbus5v0-typec-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc3v3_pcie2x1l0: vcc3v3-pcie2x1l0-regulator {
+	vcc3v3_pcie2x1l0: regulator-vcc3v3-pcie2x1l0 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PC2 GPIO_ACTIVE_HIGH>;
@@ -171,7 +171,7 @@ vcc3v3_pcie2x1l0: vcc3v3-pcie2x1l0-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
+	vcc3v3_pcie30: regulator-vcc3v3-pcie30 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpios = <&gpio2 RK_PC5 GPIO_ACTIVE_HIGH>;
@@ -183,7 +183,7 @@ vcc3v3_pcie30: vcc3v3-pcie30-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc3v3_sd_s0: vcc3v3-sd-s0-regulator {
+	vcc3v3_sd_s0: regulator-vcc3v3-sd-s0 {
 		compatible = "regulator-fixed";
 		gpio = <&gpio4 RK_PA5 GPIO_ACTIVE_LOW>;
 		regulator-boot-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts b/arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts
index c2a08bdf09e8..9b48267ecfed 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts
@@ -100,7 +100,7 @@ masterdai: simple-audio-card,codec {
 		};
 	};

-	vcc12v_dcin: vcc12v-dcin-regulator {
+	vcc12v_dcin: regulator-vcc12v-dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
 		regulator-always-on;
@@ -109,7 +109,7 @@ vcc12v_dcin: vcc12v-dcin-regulator {
 		regulator-max-microvolt = <12000000>;
 	};

-	vcc1v8_sys: vcc1v8-sys-regulator {
+	vcc1v8_sys: regulator-vcc1v8-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc1v8_sys";
 		regulator-always-on;
@@ -119,7 +119,7 @@ vcc1v8_sys: vcc1v8-sys-regulator {
 		vin-supply = <&vcc3v3_sys>;
 	};

-	vcc3v3_pcie2x1l0: vcc3v3-pcie2x1l0-regulator {
+	vcc3v3_pcie2x1l0: regulator-vcc3v3-pcie2x1l0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_pcie2x1l0";
 		regulator-min-microvolt = <3300000>;
@@ -128,7 +128,7 @@ vcc3v3_pcie2x1l0: vcc3v3-pcie2x1l0-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc3v3_pcie2x1l2: vcc3v3-pcie2x1l2-regulator {
+	vcc3v3_pcie2x1l2: regulator-vcc3v3-pcie2x1l2 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_pcie2x1l2";
 		regulator-min-microvolt = <3300000>;
@@ -137,7 +137,7 @@ vcc3v3_pcie2x1l2: vcc3v3-pcie2x1l2-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc3v3_pcie30: vcc3v3_pcie30-regulator {
+	vcc3v3_pcie30: regulator-vcc3v3_pcie30 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_pcie30";
 		regulator-always-on;
@@ -147,7 +147,7 @@ vcc3v3_pcie30: vcc3v3_pcie30-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc3v3_sys: vcc3v3-sys-regulator {
+	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-always-on;
@@ -157,7 +157,7 @@ vcc3v3_sys: vcc3v3-sys-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
index f8cbed3e2065..918f1b162221 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
@@ -165,7 +165,7 @@ daicodec: simple-audio-card,codec {
 		};
 	};

-	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
+	vcc3v3_pcie30: regulator-vcc3v3-pcie30 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpios = <&gpio2 RK_PB6 GPIO_ACTIVE_HIGH>;
@@ -176,7 +176,7 @@ vcc3v3_pcie30: vcc3v3-pcie30-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc3v3_pcie_eth: vcc3v3-pcie-eth-regulator {
+	vcc3v3_pcie_eth: regulator-vcc3v3-pcie-eth {
 		compatible = "regulator-fixed";
 		gpios = <&gpio3 RK_PB4 GPIO_ACTIVE_LOW>;
 		regulator-name = "vcc3v3_pcie_eth";
@@ -186,7 +186,7 @@ vcc3v3_pcie_eth: vcc3v3-pcie-eth-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc3v3_wf: vcc3v3-wf-regulator {
+	vcc3v3_wf: regulator-vcc3v3-wf {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpios = <&gpio2 RK_PC5 GPIO_ACTIVE_HIGH>;
@@ -197,7 +197,7 @@ vcc3v3_wf: vcc3v3-wf-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -206,7 +206,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		regulator-max-microvolt = <5000000>;
 	};

-	vcc5v0_usb20: vcc5v0-usb20-regulator {
+	vcc5v0_usb20: regulator-vcc5v0-usb20 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts b/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
index e4a20cda65ed..0668a3ed4354 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
@@ -149,7 +149,7 @@ daicodec: simple-audio-card,codec {
 		};
 	};

-	vcc12v_dcin: vcc12v-dcin-regulator {
+	vcc12v_dcin: regulator-vcc12v-dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
 		regulator-always-on;
@@ -158,7 +158,7 @@ vcc12v_dcin: vcc12v-dcin-regulator {
 		regulator-max-microvolt = <12000000>;
 	};

-	vcc3v3_bt: vcc3v3-bt-regulator {
+	vcc3v3_bt: regulator-vcc3v3-bt {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpios = <&gpio3 RK_PA6 GPIO_ACTIVE_HIGH>;
@@ -169,7 +169,7 @@ vcc3v3_bt: vcc3v3-bt-regulator {
 		vin-supply = <&vcc_3v3_s0>;
 	};

-	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
+	vcc3v3_pcie30: regulator-vcc3v3-pcie30 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpios = <&gpio3 RK_PC3 GPIO_ACTIVE_HIGH>;
@@ -180,7 +180,7 @@ vcc3v3_pcie30: vcc3v3-pcie30-regulator {
 		vin-supply = <&vcc12v_dcin>;
 	};

-	vcc3v3_wf: vcc3v3-wf-regulator {
+	vcc3v3_wf: regulator-vcc3v3-wf {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpios = <&gpio3 RK_PB1 GPIO_ACTIVE_HIGH>;
@@ -191,7 +191,7 @@ vcc3v3_wf: vcc3v3-wf-regulator {
 		vin-supply = <&vcc_3v3_s0>;
 	};

-	vcc4v0_sys: vcc4v0-sys-regulator {
+	vcc4v0_sys: regulator-vcc4v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc4v0_sys";
 		regulator-always-on;
@@ -201,7 +201,7 @@ vcc4v0_sys: vcc4v0-sys-regulator {
 		vin-supply = <&vcc12v_dcin>;
 	};

-	vcc5v0_host: vcc5v0-host-regulator {
+	vcc5v0_host: regulator-vcc5v0-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
@@ -215,7 +215,7 @@ vcc5v0_host: vcc5v0-host-regulator {
 		vin-supply = <&vcc5v0_usb>;
 	};

-	vcc5v0_usb: vcc5v0-usb-regulator {
+	vcc5v0_usb: regulator-vcc5v0-usb {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 6bd06e46a101..0c455bd21236 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -72,7 +72,7 @@ rfkill-bt {
 		shutdown-gpios = <&gpio3 RK_PD5 GPIO_ACTIVE_HIGH>;
 	};

-	vcc3v3_pcie2x1l0: vcc3v3-pcie2x1l0-regulator {
+	vcc3v3_pcie2x1l0: regulator-vcc3v3-pcie2x1l0 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpios = <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
@@ -87,7 +87,7 @@ vcc3v3_pcie2x1l0: vcc3v3-pcie2x1l0-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc3v3_pcie2x1l2: vcc3v3-pcie2x1l2-regulator {
+	vcc3v3_pcie2x1l2: regulator-vcc3v3-pcie2x1l2 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_pcie2x1l2";
 		regulator-min-microvolt = <3300000>;
@@ -96,7 +96,7 @@ vcc3v3_pcie2x1l2: vcc3v3-pcie2x1l2-regulator {
 		vin-supply = <&vcc_3v3_s3>;
 	};

-	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
+	vcc3v3_pcie30: regulator-vcc3v3-pcie30 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpios = <&gpio1 RK_PA4 GPIO_ACTIVE_HIGH>;
@@ -109,7 +109,7 @@ vcc3v3_pcie30: vcc3v3-pcie30-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_host: vcc5v0-host-regulator {
+	vcc5v0_host: regulator-vcc5v0-host {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_host";
 		regulator-boot-on;
@@ -123,7 +123,7 @@ vcc5v0_host: vcc5v0-host-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -132,7 +132,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		regulator-max-microvolt = <5000000>;
 	};

-	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
+	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_1v1_nldo_s3";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
index e4b7a0a4444b..e737586ca4cf 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
@@ -20,7 +20,7 @@ chosen {
 		stdout-path = "serial2:115200n8";
 	};

-	dc_12v: dc-12v-regulator {
+	dc_12v: regulator-dc-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "dc_12v";
 		regulator-always-on;
@@ -84,7 +84,7 @@ sgtl5000_clk: sgtl5000-oscillator  {
 		clock-frequency = <24576000>;
 	};

-	vcc3v3_baseboard: vcc3v3-baseboard-regulator {
+	vcc3v3_baseboard: regulator-vcc3v3-baseboard {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_baseboard";
 		regulator-always-on;
@@ -94,7 +94,7 @@ vcc3v3_baseboard: vcc3v3-baseboard-regulator {
 		vin-supply = <&dc_12v>;
 	};

-	vcc3v3_low_noise: vcc3v3-low-noise-regulator {
+	vcc3v3_low_noise: regulator-vcc3v3-low-noise {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_low_noise";
 		regulator-boot-on;
@@ -103,7 +103,7 @@ vcc3v3_low_noise: vcc3v3-low-noise-regulator {
 		vin-supply = <&vcc5v0_usb>;
 	};

-	vcc5v0_baseboard: vcc5v0-baseboard-regulator {
+	vcc5v0_baseboard: regulator-vcc5v0-baseboard {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_baseboard";
 		regulator-always-on;
@@ -113,7 +113,7 @@ vcc5v0_baseboard: vcc5v0-baseboard-regulator {
 		vin-supply = <&dc_12v>;
 	};

-	vcc5v0_otg: vcc5v0-otg-regulator {
+	vcc5v0_otg: regulator-vcc5v0-otg {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>;
@@ -123,7 +123,7 @@ vcc5v0_otg: vcc5v0-otg-regulator {
 		regulator-always-on;
 	};

-	vcc5v0_usb: vcc5v0-usb-regulator {
+	vcc5v0_usb: regulator-vcc5v0-usb {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb";
 		regulator-always-on;
@@ -133,7 +133,7 @@ vcc5v0_usb: vcc5v0-usb-regulator {
 		vin-supply = <&dc_12v>;
 	};

-	vddd_audio_1v6: vddd-audio-1v6-regulator {
+	vddd_audio_1v6: regulator-vddd-audio-1v6 {
 		compatible = "regulator-fixed";
 		regulator-name = "vddd_audio_1v6";
 		regulator-boot-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
index a02f1178c60c..bff2316828eb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
@@ -65,7 +65,7 @@ pcie_refclk: pcie-refclk-clock {
 		enable-gpios = <&gpio4 RK_PB4 GPIO_ACTIVE_HIGH>; /* PCIE30X4_CLKREQN_M1_L */
 	};

-	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
+	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_1v1_nldo_s3";
 		regulator-always-on;
@@ -75,7 +75,7 @@ vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc_1v2_s3: vcc-1v2-s3-regulator {
+	vcc_1v2_s3: regulator-vcc-1v2-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_1v2_s3";
 		regulator-always-on;
@@ -85,7 +85,7 @@ vcc_1v2_s3: vcc-1v2-s3-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-toybrick-x0.dts b/arch/arm64/boot/dts/rockchip/rk3588-toybrick-x0.dts
index d0021524e7f9..9a31eaee016d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-toybrick-x0.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-toybrick-x0.dts
@@ -61,7 +61,7 @@ backlight: backlight {
 		pwms = <&pwm2 0 25000 0>;
 	};

-	pcie20_avdd0v85: pcie20-avdd0v85-regulator {
+	pcie20_avdd0v85: regulator-pcie20-avdd0v85 {
 		compatible = "regulator-fixed";
 		regulator-name = "pcie20_avdd0v85";
 		regulator-always-on;
@@ -71,7 +71,7 @@ pcie20_avdd0v85: pcie20-avdd0v85-regulator {
 		vin-supply = <&vdd_0v85_s0>;
 	};

-	pcie20_avdd1v8: pcie20-avdd1v8-regulator {
+	pcie20_avdd1v8: regulator-pcie20-avdd1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "pcie20_avdd1v8";
 		regulator-always-on;
@@ -81,7 +81,7 @@ pcie20_avdd1v8: pcie20-avdd1v8-regulator {
 		vin-supply = <&avcc_1v8_s0>;
 	};

-	pcie30_avdd0v75: pcie30-avdd0v75-regulator {
+	pcie30_avdd0v75: regulator-pcie30-avdd0v75 {
 		compatible = "regulator-fixed";
 		regulator-name = "pcie30_avdd0v75";
 		regulator-always-on;
@@ -91,7 +91,7 @@ pcie30_avdd0v75: pcie30-avdd0v75-regulator {
 		vin-supply = <&avdd_0v75_s0>;
 	};

-	pcie30_avdd1v8: pcie30-avdd1v8-regulator {
+	pcie30_avdd1v8: regulator-pcie30-avdd1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "pcie30_avdd1v8";
 		regulator-always-on;
@@ -101,7 +101,7 @@ pcie30_avdd1v8: pcie30-avdd1v8-regulator {
 		vin-supply = <&avcc_1v8_s0>;
 	};

-	vcc12v_dcin: vcc12v-dcin-regulator {
+	vcc12v_dcin: regulator-vcc12v-dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
 		regulator-always-on;
@@ -110,7 +110,7 @@ vcc12v_dcin: vcc12v-dcin-regulator {
 		regulator-max-microvolt = <12000000>;
 	};

-	vcc5v0_host: vcc5v0-host-regulator {
+	vcc5v0_host: regulator-vcc5v0-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
@@ -124,7 +124,7 @@ vcc5v0_host: vcc5v0-host-regulator {
 		vin-supply = <&vcc5v0_usb>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -134,7 +134,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		vin-supply = <&vcc12v_dcin>;
 	};

-	vcc5v0_usbdcin: vcc5v0-usbdcin-regulator {
+	vcc5v0_usbdcin: regulator-vcc5v0-usbdcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usbdcin";
 		regulator-always-on;
@@ -144,7 +144,7 @@ vcc5v0_usbdcin: vcc5v0-usbdcin-regulator {
 		vin-supply = <&vcc12v_dcin>;
 	};

-	vcc5v0_usb: vcc5v0-usb-regulator {
+	vcc5v0_usb: regulator-vcc5v0-usb {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb";
 		regulator-always-on;
@@ -154,7 +154,7 @@ vcc5v0_usb: vcc5v0-usb-regulator {
 		vin-supply = <&vcc5v0_usbdcin>;
 	};

-	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
+	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_1v1_nldo_s3";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
index 8018442d79fe..6bc46734cc14 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
@@ -33,7 +33,7 @@ fan: pwm-fan {
 		#cooling-cells = <2>;
 	};

-	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
+	vcc3v3_pcie30: regulator-vcc3v3-pcie30 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_pcie30";
 		regulator-min-microvolt = <3300000>;
@@ -45,7 +45,7 @@ vcc3v3_pcie30: vcc3v3-pcie30-regulator {
 		startup-delay-us = <5000>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -54,7 +54,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		regulator-max-microvolt = <5000000>;
 	};

-	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
+	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_1v1_nldo_s3";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
index 074c316a9a69..86c9f1737349 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
@@ -75,7 +75,7 @@ sdio_pwrseq: sdio-pwrseq {
 		reset-gpios = <&gpio0 RK_PC7 GPIO_ACTIVE_LOW>;
 	};

-	vcc12v_dcin: vcc12v-dcin-regulator {
+	vcc12v_dcin: regulator-vcc12v-dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
 		regulator-always-on;
@@ -84,7 +84,7 @@ vcc12v_dcin: vcc12v-dcin-regulator {
 		regulator-max-microvolt = <12000000>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -94,7 +94,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		vin-supply = <&vcc12v_dcin>;
 	};

-	vcc5v0_usbdcin: vcc5v0-usbdcin-regulator {
+	vcc5v0_usbdcin: regulator-vcc5v0-usbdcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usbdcin";
 		regulator-always-on;
@@ -104,7 +104,7 @@ vcc5v0_usbdcin: vcc5v0-usbdcin-regulator {
 		vin-supply = <&vcc12v_dcin>;
 	};

-	vcc5v0_usb: vcc5v0-usb-regulator {
+	vcc5v0_usb: regulator-vcc5v0-usb {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb";
 		regulator-always-on;
@@ -114,7 +114,7 @@ vcc5v0_usb: vcc5v0-usb-regulator {
 		vin-supply = <&vcc5v0_usbdcin>;
 	};

-	avdd0v85_pcie20: avdd0v85-pcie20-regulator {
+	avdd0v85_pcie20: regulator-avdd0v85-pcie20 {
 		compatible = "regulator-fixed";
 		regulator-name = "avdd0v85_pcie20";
 		regulator-boot-on;
@@ -124,7 +124,7 @@ avdd0v85_pcie20: avdd0v85-pcie20-regulator {
 		vin-supply = <&vdd_0v85_s0>;
 	};

-	avdd1v8_pcie20: avdd1v8-pcie20-regulator {
+	avdd1v8_pcie20: regulator-avdd1v8-pcie20 {
 		compatible = "regulator-fixed";
 		regulator-name = "avdd1v8_pcie20";
 		regulator-boot-on;
@@ -134,7 +134,7 @@ avdd1v8_pcie20: avdd1v8-pcie20-regulator {
 		vin-supply = <&avcc_1v8_s0>;
 	};

-	vcc3v3_mipi: vcc3v3-mipi-regulator {
+	vcc3v3_mipi: regulator-vcc3v3-mipi {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio3 RK_PC2 GPIO_ACTIVE_HIGH>;
@@ -144,7 +144,7 @@ vcc3v3_mipi: vcc3v3-mipi-regulator {
 		vin-supply = <&vcc_3v3_s3>;
 	};

-	vcc5v0_host: vcc5v0-host-regulator {
+	vcc5v0_host: regulator-vcc5v0-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio3 RK_PC0 GPIO_ACTIVE_HIGH>;
@@ -158,7 +158,7 @@ vcc5v0_host: vcc5v0-host-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_otg: vcc5v0-otg-regulator {
+	vcc5v0_otg: regulator-vcc5v0-otg {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio3 RK_PC1 GPIO_ACTIVE_HIGH>;
@@ -172,7 +172,7 @@ vcc5v0_otg: vcc5v0-otg-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
+	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_1v1_nldo_s3";
 		regulator-always-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts b/arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts
index 467f69594089..902bd390df3b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts
@@ -346,7 +346,7 @@ amp_speaker: speaker-amplifier {
 		VCC-supply = <&vcc5v0_spk>;
 	};

-	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
+	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
 		compatible = "regulator-fixed";
 		regulator-always-on;
 		regulator-boot-on;
@@ -356,7 +356,7 @@ vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc3v3_lcd0_n: vcc3v3-lcd0-n-regulator {
+	vcc3v3_lcd0_n: regulator-vcc3v3-lcd0-n {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PA7 GPIO_ACTIVE_HIGH>;
@@ -371,7 +371,7 @@ regulator-state-mem {
 		};
 	};

-	vcc_3v3_sd_s0: vcc-3v3-sd-s0-regulator {
+	vcc_3v3_sd_s0: regulator-vcc-3v3-sd-s0 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PB4 GPIO_ACTIVE_HIGH>;
@@ -383,7 +383,7 @@ vcc_3v3_sd_s0: vcc-3v3-sd-s0-regulator {
 		vin-supply = <&vcc_3v3_s3>;
 	};

-	vcc5v0_spk: vcc5v0-spk-regulator {
+	vcc5v0_spk: regulator-vcc5v0-spk {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
@@ -398,7 +398,7 @@ regulator-state-mem {
 		};
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-always-on;
 		regulator-boot-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts b/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
index d8c50fdcca3b..7f317d217c8a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
@@ -71,7 +71,7 @@ sound {
 		dais = <&i2s0_8ch_p0>;
 	};

-	vbus5v0_typec: vbus5v0-typec-regulator {
+	vbus5v0_typec: regulator-vbus5v0-typec {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
@@ -83,7 +83,7 @@ vbus5v0_typec: vbus5v0-typec-regulator {
 		vin-supply = <&vcc5v0_usb>;
 	};

-	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
+	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
 		compatible = "regulator-fixed";
 		regulator-always-on;
 		regulator-boot-on;
@@ -94,7 +94,7 @@ vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
 	};

 	/* Regulator is enabled whenever vcc_1v8_s0 is above 1.6v */
-	vcc_3v3_s0: vcc-3v3-s0-regulator {
+	vcc_3v3_s0: regulator-vcc-3v3-s0 {
 		compatible = "regulator-fixed";
 		regulator-always-on;
 		regulator-boot-on;
@@ -108,7 +108,7 @@ regulator-state-mem {
 		};
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-always-on;
 		regulator-boot-on;
@@ -117,7 +117,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		regulator-name = "vcc5v0_sys";
 	};

-	vcc5v0_usb: vcc5v0-usb-regulator {
+	vcc5v0_usb: regulator-vcc5v0-usb {
 		compatible = "regulator-fixed";
 		regulator-always-on;
 		regulator-boot-on;
@@ -127,7 +127,7 @@ vcc5v0_usb: vcc5v0-usb-regulator {
 		vin-supply = <&vcc5v0_usbdcin>;
 	};

-	vcc5v0_usbdcin: vcc5v0-usbdcin-regulator {
+	vcc5v0_usbdcin: regulator-vcc5v0-usbdcin {
 		compatible = "regulator-fixed";
 		regulator-always-on;
 		regulator-boot-on;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index b80a552dad88..ac48e7fd3923 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
@@ -76,7 +76,7 @@ blue_led: led-2 {
 		};
 	};

-	vcc3v3_pcie_wl: vcc3v3-pcie-wl-regulator {
+	vcc3v3_pcie_wl: regulator-vcc3v3-pcie-wl {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_HIGH>;
@@ -89,7 +89,7 @@ vcc3v3_pcie_wl: vcc3v3-pcie-wl-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_host: vcc5v0-host-regulator {
+	vcc5v0_host: regulator-vcc5v0-host {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_host";
 		regulator-boot-on;
@@ -103,7 +103,7 @@ vcc5v0_host: vcc5v0-host-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -112,7 +112,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		regulator-max-microvolt = <5000000>;
 	};

-	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
+	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_1v1_nldo_s3";
 		regulator-always-on;
@@ -122,7 +122,7 @@ vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vdd_3v3_sd: vdd-3v3-sd-regulator {
+	vdd_3v3_sd: regulator-vdd-3v3-sd {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_3v3_sd";
 		gpios = <&gpio1 RK_PB6 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
index 4fa644ae510c..e325813a2ab9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
@@ -81,7 +81,7 @@ lan2_led: led-3 {
 		};
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -90,7 +90,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		regulator-max-microvolt = <5000000>;
 	};

-	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
+	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_1v1_nldo_s3";
 		regulator-always-on;
@@ -100,7 +100,7 @@ vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc_3v3_s0: vcc-3v3-s0-regulator {
+	vcc_3v3_s0: regulator-vcc-3v3-s0 {
 		compatible = "regulator-fixed";
 		regulator-always-on;
 		regulator-boot-on;
@@ -110,7 +110,7 @@ vcc_3v3_s0: vcc-3v3-s0-regulator {
 		vin-supply = <&vcc_3v3_s3>;
 	};

-	vcc_3v3_sd_s0: vcc-3v3-sd-s0-regulator {
+	vcc_3v3_sd_s0: regulator-vcc-3v3-sd-s0 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpios = <&gpio4 RK_PB4 GPIO_ACTIVE_HIGH>;
@@ -123,7 +123,7 @@ vcc_3v3_sd_s0: vcc-3v3-sd-s0-regulator {
 		vin-supply = <&vcc_3v3_s3>;
 	};

-	vcc_3v3_pcie20: vcc3v3-pcie20-regulator {
+	vcc_3v3_pcie20: regulator-vcc3v3-pcie20 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_3v3_pcie20";
 		regulator-always-on;
@@ -133,7 +133,7 @@ vcc_3v3_pcie20: vcc3v3-pcie20-regulator {
 		vin-supply = <&vcc_3v3_s3>;
 	};

-	vcc5v0_usb: vcc5v0-usb-regulator {
+	vcc5v0_usb: regulator-vcc5v0-usb {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb";
 		regulator-always-on;
@@ -143,7 +143,7 @@ vcc5v0_usb: vcc5v0-usb-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_usb_otg0: vcc5v0-usb-otg0-regulator {
+	vcc5v0_usb_otg0: regulator-vcc5v0-usb-otg0 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpios = <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
@@ -155,7 +155,7 @@ vcc5v0_usb_otg0: vcc5v0-usb-otg0-regulator {
 		vin-supply = <&vcc5v0_usb>;
 	};

-	vcc5v0_host_20: vcc5v0-host-20-regulator {
+	vcc5v0_host_20: regulator-vcc5v0-host-20 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpios = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
index feea6b20a6bf..99bb7bca10ff 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
@@ -48,7 +48,7 @@ led-1 {
 		};
 	};

-	vbus_typec: vbus-typec-regulator {
+	vbus_typec: regulator-vbus-typec {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio3 RK_PC0 GPIO_ACTIVE_HIGH>;
@@ -60,7 +60,7 @@ vbus_typec: vbus-typec-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -69,7 +69,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		regulator-max-microvolt = <5000000>;
 	};

-	vcc_3v3_sd_s0: vcc-3v3-sd-s0-regulator {
+	vcc_3v3_sd_s0: regulator-vcc-3v3-sd-s0 {
 		compatible = "regulator-fixed";
 		enable-active-low;
 		gpios = <&gpio4 RK_PB5 GPIO_ACTIVE_LOW>;
@@ -80,7 +80,7 @@ vcc_3v3_sd_s0: vcc-3v3-sd-s0-regulator {
 		vin-supply = <&vcc_3v3_s3>;
 	};

-	vcc3v3_pcie20: vcc3v3-pcie20-regulator {
+	vcc3v3_pcie20: regulator-vcc3v3-pcie20 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpios = <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
index 87fce8d9a964..94fea80ee34e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
@@ -56,7 +56,7 @@ fan: pwm-fan {
 		#cooling-cells = <2>;
 	};

-	vcc12v_dcin: vcc12v-dcin-regulator {
+	vcc12v_dcin: regulator-vcc12v-dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
 		regulator-always-on;
@@ -65,7 +65,7 @@ vcc12v_dcin: vcc12v-dcin-regulator {
 		regulator-max-microvolt = <12000000>;
 	};

-	vcc3v3_wf: vcc3v3-wf-regulator {
+	vcc3v3_wf: regulator-vcc3v3-wf {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_wf";
 		regulator-min-microvolt = <3300000>;
@@ -77,7 +77,7 @@ vcc3v3_wf: vcc3v3-wf-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_host: vcc5v0-host-regulator {
+	vcc5v0_host: regulator-vcc5v0-host {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_host";
 		regulator-boot-on;
@@ -91,7 +91,7 @@ vcc5v0_host: vcc5v0-host-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc5v0_sys: vcc5v0-sys-regulator {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -101,7 +101,7 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		vin-supply = <&vcc12v_dcin>;
 	};

-	vcc_5v0: vcc-5v0-regulator {
+	vcc_5v0: regulator-vcc-5v0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_5v0";
 		regulator-min-microvolt = <5000000>;
@@ -115,7 +115,7 @@ vcc_5v0: vcc-5v0-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};

-	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
+	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_1v1_nldo_s3";
 		regulator-always-on;
--
2.39.2


