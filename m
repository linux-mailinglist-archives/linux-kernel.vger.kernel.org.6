Return-Path: <linux-kernel+bounces-325870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80052975F47
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFFA81F240D6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B811714C4;
	Thu, 12 Sep 2024 02:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieF4X4j9"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A05156F5D;
	Thu, 12 Sep 2024 02:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726109547; cv=none; b=qVvD6/RWVuq81rA+zEapekoKAWsjQ8XEM2BKjKMd6Zpm/fhWZdcJS/Nsup99/urY7Opt2GcLUH9+jY7AbRisvSE38BntvWrWgQgnyBn7KZ8JyvZlXg/Tt9U/pxl258AdaRi1q9k0pCJSGpCwXZz2rfLXBgismu74/hkDdi4Wq30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726109547; c=relaxed/simple;
	bh=hQu4H95TEw4lqRy24mfnmeSorE9NQ6G7QEL/EgKkUEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QNVDFLTkkpvKxACi588j+H/fCqtLSqhHy5PTAjYzWyLDe09K1qlgBtxwteNWRd02HkEGX+f1H09Cy2Ndl5FNp+DSLx/W/iG5sF6W/utd674eszzUHCYBXOyONWeutcK9gcE7/hxpERA74h/O4zhErK5G6Cq0SNr38q9gyTv6KZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieF4X4j9; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7d50b3a924bso196652a12.0;
        Wed, 11 Sep 2024 19:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726109544; x=1726714344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbhfTGrSMvC/tgmYMhKvFdZrItzTEJ4tenHm4R5TGCQ=;
        b=ieF4X4j9WcBt3rlKipHb8AQomB0h6ooWprMyQgRaVq2bCFxz6hpr8FpCf58rilc3ni
         JB1MqNNbDVSN8WRpva7ptZUu1or9uZfEpS9WjDw0s/Cvqyxmn4B7TGONsDujieAJNsFl
         1ofMeE+aHel9AyQG/EOKLracxfkAfLtVHph9PG5k3ZFHOFcFANCODVluf6OFI2vC1/19
         EGjtPSUYZuaxfcDcQqG1iEXXGJAjK7ogN++RSaQHkXYx4bW1KdPB+VFf1guD4DPrVMek
         8t3upoPj7MPze8N+VqhTBFZgNACOCFj7Ggh3balORmslz2qR35dqpBWECwsErqdUIRGH
         bCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726109544; x=1726714344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbhfTGrSMvC/tgmYMhKvFdZrItzTEJ4tenHm4R5TGCQ=;
        b=ogNO3D29X9SsMr8aFaBuu6X7ahyNin0AaCmfmH7ZMPjoXmiZgWEA3FfO9oQTdWEo7G
         DDjgh3ryealDAQrOcGr7ASuodGpgopXfhE/s67Jxxzor7R8xd10ElaE8urD1a8XPZK4X
         ZK5oZVMrUVR+baylRG7XC/r4cFPZHT6gHOmVySPy/mrOdyVcH7KZcZVh922rJ2rEouBG
         4C5RqymbzcF8MxFZIIsPIkuMp2p8xfkOzHFSUBptFiBieQfHFXVqUueuBJ80C8LytRCa
         34zjuZE4PqCb3ZSZwdbRiDp/MC1DCAGvfJvV3p3to7zU6OZUZLATJfu15QpePBCeLYvM
         PbEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/FJzQyAHGSHg5XUcfIQ6Uf1Wt/3r3zrfyjOCuDOg8sCVnceigsMXFR6rMgexJJGL+UdPQ24ku/6eo4WFb@vger.kernel.org, AJvYcCWkVPnnVn3s64Ao1+D4PZvmc6iHI1tTLXpjh7L6RT3ILa6eRvvmNJdCiWAfEHICLYQkr9lKoXIlR9Qw@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7DV8uT+aMkSLgul3tj4nPFjYM594iyI1MFZAkOirDBR1CUy2z
	lbf06Om+PlFsl0K9zSqnLyVg5DUYX1V/8kIs75rgHMzxSVcnhqYy
X-Google-Smtp-Source: AGHT+IF8HeK6/BQhqecMhAqWlKM4X8CDT4o85XrqfS2zkOCm7oxs5tX2NJUPbSqU54VIZ5nGAuvpIg==
X-Received: by 2002:a05:6a20:d50c:b0:1cf:2513:89f6 with SMTP id adf61e73a8af0-1cf76239981mr1446471637.41.1726109544283;
        Wed, 11 Sep 2024 19:52:24 -0700 (PDT)
Received: from luna.turtle.lan ([2601:1c2:c184:dc00::315])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fbbf877sm569023a12.50.2024.09.11.19.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 19:52:23 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ondrej Jirman <megi@xff.cz>,
	Chris Morgan <macromorgan@hotmail.com>,
	Alex Zhao <zzc@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Jing Luo <jing@jing.rocks>,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Daniel=20Kukie=C5=82a?= <daniel@kukiela.pl>,
	Joshua Riek <jjriek@verizon.net>,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 5/5] arm64: dts: rockchip: Enable GPU on Turing RK1
Date: Wed, 11 Sep 2024 19:50:34 -0700
Message-ID: <20240912025034.180233-6-CFSworks@gmail.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240912025034.180233-1-CFSworks@gmail.com>
References: <20240912025034.180233-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the Mali GPU in the Turing RK1.

This patch also sets the external GPU voltage regulator in the RK806-1
to "always-on" because it is necessary for this regulator to be active
when enabling the GPU power domain or the kernel will fail with:

rockchip-pm-domain fd8d8000.power-management:power-controller: \
    failed to set domain 'gpu', val=0
rockchip-pm-domain fd8d8000.power-management:power-controller: \
    failed to get ack on domain 'gpu', val=0x1bffff

...followed by a panic when it attempts to access unavailable QoS
registers.

Since there is currently no `domain-supply` or similar to express this
dependency, the only way to ensure that the regulator is never off when
the GPU power domain is brought up is to ensure that the regulator is
never off.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>

---

Hi list,

This particular patch will probably need to be revisited once something
like [1] lands. I'm completely unable to get the GPU up and running
without some kind of solution to the power dependency issue, but it's
possible that this is because I'm just particularly unlucky in the
timing department.

Cheers,
Sam

[1]: https://lore.kernel.org/lkml/20240910180530.47194-7-sebastian.reichel@collabora.com/T/
---
 .../boot/dts/rockchip/rk3588-turing-rk1.dtsi     | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
index 6036c4fe6727..dedfb9ede4a3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
@@ -116,6 +116,11 @@ &gmac1_rgmii_clk
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&vdd_gpu_s0>;
+	status = "okay";
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0m2_xfer>;
@@ -386,6 +391,17 @@ rk806_dvs3_null: dvs3-null-pins {
 
 		regulators {
 			vdd_gpu_s0: vdd_gpu_mem_s0: dcdc-reg1 {
+				/*
+				 * RK3588's GPU power domain cannot be enabled
+				 * without this regulator active, but it
+				 * doesn't have to be on when the GPU PD is
+				 * disabled.  Because the PD binding does not
+				 * currently allow us to express this
+				 * relationship, we have no choice but to do
+				 * this instead:
+				 */
+				regulator-always-on;
+
 				regulator-boot-on;
 				regulator-min-microvolt = <550000>;
 				regulator-max-microvolt = <950000>;
-- 
2.44.2


