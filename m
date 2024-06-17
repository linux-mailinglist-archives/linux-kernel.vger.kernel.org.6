Return-Path: <linux-kernel+bounces-218137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 406C690B9A9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BA241C22CF3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C04D198E80;
	Mon, 17 Jun 2024 18:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/DcRNKU"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC06198A2C;
	Mon, 17 Jun 2024 18:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648974; cv=none; b=hV5pK+nJi36YRxJ94U6KqJM4LqFFC0kDiWq2aNrbu/kJhcg/c7GJnmtj/gbGsFGY34/8FJ1FUYJqv35q5xjXTJsJXef9pMAr8CA/Iq3g6NeUR4ol3pM7IeOWLlf14L5mHdfW/FNGVhDXqwf80ET8IbJTx0M9uIbN1zRihSp4IeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648974; c=relaxed/simple;
	bh=GLoGqcAXYJtVZt3gd8x4dkalr9Ohm0Jc46GDbBCQXL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZZwdUXQlb/dSddnE6bNXbwQHKDoup8n16scJBlGMAYKSy8juJIab7EnzjiZRqasiJRfP2XJ6wS8C3PQoJ+0P3ZWamP1TWMPGu5SyZ1dsmIeABZjWhbuWvi+rAI5i1TXGsEbJW9P4e5DtPXU0nsX7wBED3lQxSYLXBBYx4hcVspc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/DcRNKU; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso540003266b.0;
        Mon, 17 Jun 2024 11:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718648971; x=1719253771; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nVonfiq4f59IHUKUAX8AnKpc2cNQELA1mct+qJNl1Vw=;
        b=X/DcRNKUZstWQ/yL/tAUFvOLSvmlV9oGbK+9ASqU/TZ9WM19A0T6w7GCpLK9yroP5h
         H4jUzUpYhn2LeV5shsAOQuLlj8wchtiMUimq0t+UPqRaJDFJZzWTpSLPYJfP9/L4bDWB
         3fEmpwk9vWqbswKD1c2tK554Yv6sJXs9q1xaU1EUooVX901D30p0tYHSr3gBDPIsyexG
         4KOrCQArp1O/7nvqB1Bty/FAuOjtCFtJu+Up6yvRywo2aDNiu/syUa3TdDw7rKjmgymc
         oeX216rCPEKeJq0p2J8f4UDrgZgenjLHv+rWctU2U3f/3CKlPuZ/0gaz16mTxWFfHdtd
         bV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718648971; x=1719253771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVonfiq4f59IHUKUAX8AnKpc2cNQELA1mct+qJNl1Vw=;
        b=gWh7D13nW9f7auTN/HgwRh1NrpoYJh5hcKJOBAS1e3s/dPtkv98yxEMEvGg6rhFvRr
         gsxIJe9VPAYnGeqJz/XoFA5kSPOuooVbi+XcH9Ty1+cbDVoc5RxvfRQ0yOLwLXbYwZv/
         89qM0ABhiO8cWyAIsLwqGSGI8NeyCcPb65PES8XGvdn7by0SywYEbEEHoDmbJciwwC/0
         3K+Dwcb74kFwhgz3qVOpf6jhCWBIlLVFtNwd9cg2ORepr2o+/pLwzv+MgUiHeWso+Dkk
         rcd6zezWQQXjZbTpfqmnWMfH23tjVcjVqVTHT/MZ7DlmcuHqGJMehbPgKLWFAOgTDNYM
         bzBw==
X-Forwarded-Encrypted: i=1; AJvYcCWA/0lfLJsVT8JtKWnqhTouIN1AOdKYU8h7ju0CPtZNUKAQuZ7U717dqhdCzfumZ6Xy+Z0Gcrm16c+lf+n3byOlXidFRXelvOptaSc4rUKojn+vrOlbMVxuFH+ITdExlqBooswoizQyeA==
X-Gm-Message-State: AOJu0YxG+1U5QfH6f9TijBls/NXe+/qUkwYK4yohmHrJfv6lbTPD/eUK
	H8x6/qaAdF/QkIiFAIA1lLILRJ6IhW86neAqbzz2I+unzc1aqwUw
X-Google-Smtp-Source: AGHT+IGvPp2igZrxUodZ9RzzYGZfSWNMZ2rzakrVZ7pVDh231IomqTQnvW9THxLEd9ZKvJIiM6mMlQ==
X-Received: by 2002:a17:906:a20a:b0:a6f:27e2:812c with SMTP id a640c23a62f3a-a6f60d20ec2mr656510666b.22.1718648971388;
        Mon, 17 Jun 2024 11:29:31 -0700 (PDT)
Received: from latitude-fedora.lan ([2001:8f8:183b:6864::d35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f8a6e58bdsm115397666b.187.2024.06.17.11.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 11:29:31 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 17 Jun 2024 22:28:52 +0400
Subject: [PATCH v5 2/8] arm64: dts: rockchip: enable thermal management on
 all RK3588 boards
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-rk-dts-additions-v5-2-c1f5f3267f1e@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718648960; l=4390;
 i=alchark@gmail.com; s=20240125; h=from:subject:message-id;
 bh=GLoGqcAXYJtVZt3gd8x4dkalr9Ohm0Jc46GDbBCQXL8=;
 b=AANNJutcxjEk0OT/3bKc+ECgHkNcB0/TnaPQghhnxpHUZnLdd/9VW8l4besJnSFB7Ck3IE/5H
 8+a24TQ9dkMA4pGhjkN66HooFFAmJHXNSPYT7agM+Yma6JTmTLMlGHH
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
index 4e2bf4eaef2b..afcc38a5bed8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -749,6 +749,10 @@ regulator-state-mem {
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
2.45.2


