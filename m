Return-Path: <linux-kernel+bounces-383677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3833B9B1EF8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0CB281C62
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE4C16ABC6;
	Sun, 27 Oct 2024 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="3QoU2oWL"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C044168497
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730040385; cv=none; b=qVBJ/ISqNzE7+2+Cku25WCr6EVbfDyd+kZeQzbi1+sP9KYrHFGUi5V1G92TBEkLOUgmKQluoc0Xyybpx02DdJN/3aR5OnpXl56P0ku3BV87tW3566h1PeMdMv1rXwqLwTjQE+rTmBNHE89GA9ddgWEuyji4BkNDy1Wdkm3Zf05k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730040385; c=relaxed/simple;
	bh=IvkSHNImVaQCQIC/kJU65HoJni0fwLvPfRerPS4MTio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SH4hw/+E7mRo18KiFXRNHeoEp8VQ7aEze8tE64Kc48x88bOcvOZCMhk4ypNh1LyU9v6/pyxISxWAfRWFbbMiAbJWbFPn2T95kKL0cFhBuRkkDPC5IpWKigjRtEBEQvWu3qDbnsj4+fY7SMPMItpIU+KpOQqTYALH+6jYSTIFlRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=3QoU2oWL; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e5a1c9071so2622193b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 07:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1730040383; x=1730645183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=paImQxICJubDh0CB6JnawmhEoOa3+oPQD0jlOQSWPcA=;
        b=3QoU2oWL3U4gMEbCKssCVxGjqfArZyAKoOne40MyM+t99XAGXKRSbDS4T15imBs6eO
         jf6BfKDXtHM62TxE/oIyNffPDAdmG1WPZJylJFJadrocmtn0grjPbtxZQkDCYYK47QdD
         U33fKXXbyQf2LdiClRxtgla/56XeN0T5HKaXNAl2rOALdP+hjE0/2DX9YveUZXWKOKzu
         CcZhHqnXwfEhFLswWjaY48mBAOu+K+99mTN8KKRBVtOlUr2H3chFraBRBrsjsCLiOxiK
         Jk5KBaBDL49bnE3NC8Bz4A0jCH0beEr280ySyCwmzx1Q1GmX2KH71L6WfoOpUhI+dVAh
         Wzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730040383; x=1730645183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=paImQxICJubDh0CB6JnawmhEoOa3+oPQD0jlOQSWPcA=;
        b=iJXhja/yAjx+KGsbR19Ug8OajdmsG4t1PAmSucXC1TMgAkBGlwrl3CqyE0J0RDNaY5
         rYJpX2EZ/1k6B36e/r4SLe+ZcbXEpQ1IR4TBZ/8oIqeK93OK2lfsvOMgUCZhNUiUbm0p
         1HHi1qUdAefZxgb1ZkDgk0EfeMdR2a67kv7P5YddKYJ+ExfUVm6WphgvPaoyJYpEpe3N
         WSHAgNuDz1o9crDKgDBRvkBDenZgoaHp7ep6SeL2BiV/Kl8mMRbsUZwjgXlN7s0hb1Vj
         3whqdRqEiFyU+pRARJF/xNL/sdBH9+JyRKNoygzemMI0cKFqWpVy5W+dSDlhVyQ8HPww
         lbmg==
X-Forwarded-Encrypted: i=1; AJvYcCVCwOUdXnUgZcsyg+26g7hZBDQlzRuP1pFMszqZhErz778+FS9iL2dNuZQ12gUPkKyhhul3UtxvXB4YMGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1UAY6SFIZyc095awXQP//Wn8c3v9SjQqcCINkr2GDLKtjLSj/
	8iisD0aN4syQDQCIobRYEvXwyZejovcQfFv/CeOJgS+x/ltsgKBV5jjwkwLsBL0=
X-Google-Smtp-Source: AGHT+IGrHBHy42UGfdOw8ol8FwKHGgUjeMbRosfEWH1RC9fjIGT2l+bD0MYKbWWAyathH6jUocCy/A==
X-Received: by 2002:a05:6a00:a1d:b0:71e:587d:f268 with SMTP id d2e1a72fcca58-72062f4be8fmr8205821b3a.4.1730040382835;
        Sun, 27 Oct 2024 07:46:22 -0700 (PDT)
Received: from localhost.localdomain ([2a11:3:200::401b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0cb06sm4065110b3a.115.2024.10.27.07.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 07:46:22 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	rafal@milecki.pl,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Michael Zhu <michael.zhu@starfivetech.com>,
	Drew Fustini <drew@beagleboard.org>,
	Alexandru Stan <ams@frame.work>,
	Daniel Schaefer <dhs@frame.work>,
	Sandie Cao <sandie.cao@deepcomputing.io>,
	Yuning Liang <yuning.liang@deepcomputing.io>,
	Huiming Qiu <huiming.qiu@deepcomputing.io>,
	Alex Elder <elder@riscstar.com>,
	linux@frame.work,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guodong Xu <guodong@riscstar.com>
Subject: [PATCH v6 2/5] riscv: dts: starfive: jh7110-common: move usb0 config to board dts
Date: Sun, 27 Oct 2024 22:44:45 +0800
Message-Id: <20241027144448.1813611-3-guodong@riscstar.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241027144448.1813611-1-guodong@riscstar.com>
References: <20241027144448.1813611-1-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The JH7110 USB0 can operate as a dual-role USB device.  Different
boards can have different configuration.

For all current boards this device operates in peripheral mode, but
on a new board this operates in host mode.  This property will no
longer be common, so define the "dr_mode" property in the board files
rather than in the common DTSI file.

Signed-off-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v6: New patch

 arch/riscv/boot/dts/starfive/jh7110-common.dtsi              | 5 -----
 arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts           | 5 +++++
 arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts        | 5 +++++
 .../boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi      | 5 +++++
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
index 9e77f79ec162..87ea81e9fed4 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
@@ -637,11 +637,6 @@ &uart0 {
 	status = "okay";
 };
 
-&usb0 {
-	dr_mode = "peripheral";
-	status = "okay";
-};
-
 &U74_1 {
 	cpu-supply = <&vdd_cpu>;
 };
diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
index 66ad3eb2fd66..0d248b671d4b 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
@@ -52,3 +52,8 @@ &pwmdac {
 &spi0 {
 	status = "okay";
 };
+
+&usb0 {
+	dr_mode = "peripheral";
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
index dbc8612b8464..d5180c67ac55 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
@@ -80,3 +80,8 @@ &pwmdac {
 &spi0 {
 	status = "okay";
 };
+
+&usb0 {
+	dr_mode = "peripheral";
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index ef93a394bb2f..5f14afb2c24d 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -60,3 +60,8 @@ &pwmdac {
 &spi0 {
 	status = "okay";
 };
+
+&usb0 {
+	dr_mode = "peripheral";
+	status = "okay";
+};
-- 
2.34.1


