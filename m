Return-Path: <linux-kernel+bounces-384451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 266E79B2A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3441C21AE5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BC11B373B;
	Mon, 28 Oct 2024 08:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ebdtlP9V"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7771A2647
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730104079; cv=none; b=mA8R80GHXRL+MHrcV26kmEK3LocotBtKvrT3uzAsicncCDIbJhgXNHJI5N9QeEN/EMWgb9hgVmQ7IVUuZtogHbt2/F9cg91GNqpDeU82hHU9pkZeqOYUkNmzdAXuef9P99fOQcc4alDPBU8nAfK8+ExjRVr0EqTot8S3+L9njqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730104079; c=relaxed/simple;
	bh=HDqZu8uxgmXtRzu66gskW5so05dlOyOY3GbK8gYbC3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N5qJJogMKbjIKLSyM93PZPtJ/gFQ9sN3+3KYH+/cB1CkQCxEwh33tinj/LR868c9zlGwfoejSZmzQ7nYAZtaCeKgu9a7RlXSmeC7EdRuR8O9TanXudMsgnYvQU/MRKtTDGIjAFNfX1IxhrQVcwLInilB4dACa4B7CSUccLrXH+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ebdtlP9V; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7eae96e6624so2654474a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 01:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1730104076; x=1730708876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48dfn7mu6W2OgtVA3beq5tOxjI4KGJ1Pme7qMOmIz6I=;
        b=ebdtlP9VsYqp+6C1Hi/b/CFDfYShYA5cTXQlblGx3tB+bnzSbCtTA44Rd449SrYeGu
         CwFwlD3dGI6afkQdMbCZvHEjKBHTSS1seKkDzTFknbc6DKikHnADJNUfE/whTfCZ9jUg
         nSMal4kMfaoDoVgxkEORQO+FB1vJMUEN/YwQirNf2BypCMi/8XjuIGRVOsHCvtp3vCXw
         Hy3TxkUPf5mUgFKhMbxyRhLLBDko+1zUOXbEw6QRYnPWgCQDQ/JEt4Kq2J79+G9jHDic
         D2LY4jdv03oHTzmj9U1RNalxYXKglRke3DP16M1Remxc/9+zTzX7r4a0izorDimSNc71
         v0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730104076; x=1730708876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48dfn7mu6W2OgtVA3beq5tOxjI4KGJ1Pme7qMOmIz6I=;
        b=dbrIt97A3mW7eZ4eW8ycb4h+F41sBdNOrdttUAMQ2fQfTzsJyV4XZ8ztS2Fj8TIAeF
         kT7FAma+5hRyzJD1Ls7B8I2QKipHm5af/7pkzzt3PGPUya88GT7MRnFmEO8fFg6VQO3g
         KBvmkNjeZ4V8W1LACP9xgaNQR6dk757o5X2Xx2zMqvj5eHTyNcTTasAdnETz8KGwRj1E
         67mWEQroIgcl4HFu/8XjcfKdNbNof43GS3+WsSEnynbrD5euTod4CWF/fl8QfdaYhPRU
         Xf1z6+yhWVgm/R9PrhoDMwndmasytUOvkG5iBSWET7iIOuglZ2j0kSiS8wQ0kv8jDIsd
         5D/A==
X-Forwarded-Encrypted: i=1; AJvYcCV2BW+hzNvEBoCyeEuM5d5pc31WBJkPXusmLzcbxDJ5e3aVhLDvzGzu9fpND5X75Qdm/IxqrRjzcRkU6K4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxowrRVXwTIzit607zF2yZHQJhKJdljTosi2J+Jc+CYN6wpZCxR
	p+GsiN+oUZ+Ilw83+OhDev4S64xRFhPx9UIGZ7ydpSS3UWnknRxrnuILDjILeHU=
X-Google-Smtp-Source: AGHT+IE8wn9dwa54k3OBS56nEWQqTVNnYe9nbyioaN5RXlYbjJE50o6vpy5ntxzVz9U0L90dN0x4Gg==
X-Received: by 2002:a05:6a20:d809:b0:1d9:2659:5db1 with SMTP id adf61e73a8af0-1d9a83da862mr10079042637.19.1730104076321;
        Mon, 28 Oct 2024 01:27:56 -0700 (PDT)
Received: from localhost.localdomain ([2a11:3:200::401b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205791e451sm5195419b3a.24.2024.10.28.01.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 01:27:56 -0700 (PDT)
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
	Guodong Xu <guodong@riscstar.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [PATCH v7 2/5] riscv: dts: starfive: jh7110-common: move usb0 config to board dts
Date: Mon, 28 Oct 2024 16:25:50 +0800
Message-Id: <20241028082553.1989797-3-guodong@riscstar.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028082553.1989797-1-guodong@riscstar.com>
References: <20241028082553.1989797-1-guodong@riscstar.com>
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
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
v7: Add Emil's Reviewed-by
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


