Return-Path: <linux-kernel+bounces-393103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043709B9BE0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 02:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B591C211A9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A11C53389;
	Sat,  2 Nov 2024 01:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7fACzWj"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B79146D7F;
	Sat,  2 Nov 2024 01:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730509858; cv=none; b=DC/pzm/imqQCZAL46IFq5c+goQ9p+gYo9I+wuSfiherpzgMImjq82pll23tuxLIwC0kIjb+IdAR0LL0UZx8Bi0jDFg9Zyt0GtXPmoKterFq7iqBmatKLftdFCHhx1VlpXiQpDA5Iaf/ca3uKao9IeSq4e2inFxwtXZcpctqci44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730509858; c=relaxed/simple;
	bh=AEq7qjLHJCvyNxWhUpmqMZ/nrTrCzFGoFB0eYGKsCwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtlBgynWn0+29/7bWAxFSxecj1SmXlFG6d1UXuWdAPn2B8COjvRZoLz6n9s/chvH5EgbA86Fd7B7ibaDHgZHpMWdfXzoKPEcAc2K1/sSxgT9A3BckQzoHE+1zLWuV7tHVAACmVNpxFppyqIehOfUQrh5J1Sfm+CbLH4nOq6kW64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7fACzWj; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7206304f93aso2382714b3a.0;
        Fri, 01 Nov 2024 18:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730509856; x=1731114656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2meNdNC9JbNEg9CNY+T8XUwE3GU9HHBANjwUjn+JKM=;
        b=R7fACzWjYC4UDxZTgnRWzZf4OXo3IP0DKnyMk/oMJ9TPpMNSivewVvbIvAL8dganH0
         QHJeeeRuXVaZGvxXwdFPyPgdXni+FAOpU+nV4/8I5tXYtb7t3zGMQbz2hKTYZCsFA2gv
         EJjk4ILcCF57/H7jDICkd7UwQSD4VlEmc3UibufRQVAlrM9Q7iM+KBGFW6vwEu4BC8yn
         ClJWE8PqR91Po36BYkUy0NVtIrCh3X0sa2wMVjGT9Sc/xIUsh9ZZ/G4BwAeWL1tFq9Ui
         AXNv4mid/ZuryFslY7L5zvHQ2lkmLxzqAJD4Vp6QQlhqL1E4UohSSUF631ZucE5UCD17
         /yBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730509856; x=1731114656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2meNdNC9JbNEg9CNY+T8XUwE3GU9HHBANjwUjn+JKM=;
        b=F2s2i9vHc3gH9ptD6Jt2Ww+hYeycr8SyNvmGt4Xg8smzDpSKCM+HByG37YCZcs8Lr3
         fHdCnxbVUGW9eMqiHjJpqcz7iyA1W632dUCXtOhPFSyxH7c5FG0iYtSJiZKJ7YNoMxfM
         gzb9wA1JqtRm5jrSKM/WqU8P08SeHKOR2kOPXe9SP9MCc8Nk3SS3Wv1zuw/32zFv+h6p
         IVXEMWGaGtrd0+an/4HSvTqmm3Ifhblf+DeGc062mTfqQ1xoJbxxRVTsPeksUqT+GucY
         7TL+OEA12IL2BFAgwurSxmKCoig+BE0ZvzP7KsqNWT085Iw0ejr1rwTJEtwP1SF48STD
         5sFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB6Tqvs+GeD4AUhxY/rKBv0azLbBSBOMCMqLPdz2UBnZUxpKmexqhILhngC2dbBh2ALPB06mJ+3AiC@vger.kernel.org, AJvYcCXK+cDB+ppWbvM+XNL7zSURjSoSL2nU0P9g+OiffVQIl+d0YbP8r8HuUqhzhmUKhdntKQAKzr+68BCvrMtU@vger.kernel.org
X-Gm-Message-State: AOJu0YxsSrmmJ5HSSQOag39rAA1gLcVEArU2q+ClikGaFCrdcFjMOhQ/
	1zDssVKxyoOlIfNQDN4TAu1WQZovdAm/JW5rqyIauZmaWQfuvB0K
X-Google-Smtp-Source: AGHT+IGxdnfrx47g/LZ7T+6oqNBJtwK+PMWIFgWDkDKm2ZX/SIaMJYPZuuMXhsYUbAyQMTodyNm10g==
X-Received: by 2002:a05:6a00:170d:b0:71d:ea77:e954 with SMTP id d2e1a72fcca58-720c990b4e5mr7496090b3a.14.1730509855393;
        Fri, 01 Nov 2024 18:10:55 -0700 (PDT)
Received: from localhost.localdomain ([49.130.42.137])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-720bc2c38adsm3287708b3a.133.2024.11.01.18.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 18:10:55 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v2 06/10] arm64: dts: apple: s8000: Add PMGR nodes
Date: Sat,  2 Nov 2024 09:08:28 +0800
Message-ID: <20241102011004.59339-7-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102011004.59339-1-towinchenmi@gmail.com>
References: <20241102011004.59339-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the two PMGR nodes and all known power state subnodes. Since
there are a large number of them, let's put them in a separate file to
include.

Acked-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/s8000-pmgr.dtsi  | 757 +++++++++++++++++++++
 arch/arm64/boot/dts/apple/s8000.dtsi       |  22 +
 arch/arm64/boot/dts/apple/s800x-6s.dtsi    |   4 +
 arch/arm64/boot/dts/apple/s800x-ipad5.dtsi |   4 +
 arch/arm64/boot/dts/apple/s800x-se.dtsi    |   4 +
 5 files changed, 791 insertions(+)
 create mode 100644 arch/arm64/boot/dts/apple/s8000-pmgr.dtsi

diff --git a/arch/arm64/boot/dts/apple/s8000-pmgr.dtsi b/arch/arm64/boot/dts/apple/s8000-pmgr.dtsi
new file mode 100644
index 000000000000..196b8e745a95
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8000-pmgr.dtsi
@@ -0,0 +1,757 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * PMGR Power domains for the Apple S8000/3 "A9" SoC
+ *
+ * Copyright (c) 2024 Nick Chan <towinchenmi@gmail.com>
+ */
+
+&pmgr {
+	ps_cpu0: power-controller@80000 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cpu0";
+		apple,always-on; /* Core device */
+	};
+
+	ps_cpu1: power-controller@80008 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cpu1";
+		apple,always-on; /* Core device */
+	};
+
+	ps_cpm: power-controller@80040 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80040 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cpm";
+		apple,always-on; /* Core device */
+	};
+
+	ps_sio_busif: power-controller@80150 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80150 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio_busif";
+	};
+
+	ps_sio_p: power-controller@80158 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80158 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio_p";
+		power-domains = <&ps_sio_busif>;
+	};
+
+	ps_sbr: power-controller@80100 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80100 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sbr";
+		apple,always-on; /* Apple fabric, critical block */
+	};
+
+	ps_aic: power-controller@80108 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80108 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aic";
+		apple,always-on; /* Core device */
+	};
+
+	ps_dwi: power-controller@80110 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80110 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dwi";
+	};
+
+	ps_gpio: power-controller@80118 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80118 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "gpio";
+	};
+
+	ps_pms: power-controller@80120 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80120 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms";
+		apple,always-on; /* Core device */
+	};
+
+	ps_pcie_ref: power-controller@80148 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80148 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pcie_ref";
+	};
+
+	ps_mca0: power-controller@80168 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80168 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mca1: power-controller@80170 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80170 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca1";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mca2: power-controller@80178 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80178 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca2";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mca3: power-controller@80180 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80180 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca3";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mca4: power-controller@80188 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80188 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca4";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_pwm0: power-controller@80190 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80190 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pwm0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_i2c0: power-controller@80198 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80198 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_i2c1: power-controller@801a0 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c1";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_i2c2: power-controller@801a8 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c2";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_i2c3: power-controller@801b0 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c3";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_spi0: power-controller@801b8 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_spi1: power-controller@801c0 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi1";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_spi2: power-controller@801c8 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi2";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_spi3: power-controller@801d0 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi3";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart0: power-controller@801d8 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart1: power-controller@801e0 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart1";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart2: power-controller@801e8 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart2";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart3: power-controller@801f0 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart3";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart4: power-controller@801f8 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart4";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_sio: power-controller@80160 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80160 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio";
+		power-domains = <&ps_sio_p>;
+		apple,always-on; /* Core device */
+	};
+
+	ps_hsic0_phy: power-controller@80128 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80128 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "hsic0_phy";
+		power-domains = <&ps_usb2host1>;
+	};
+
+	ps_hsic1_phy: power-controller@80130 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80130 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "hsic1_phy";
+		power-domains = <&ps_usb2host2>;
+	};
+
+	ps_isp_sens0: power-controller@80138 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80138 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_sens0";
+	};
+
+	ps_isp_sens1: power-controller@80140 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80140 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_sens1";
+	};
+
+	ps_usb: power-controller@80250 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80250 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb";
+	};
+
+	ps_usbctrl: power-controller@80258 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80258 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usbctrl";
+		power-domains = <&ps_usb>;
+	};
+
+	ps_usb2host0: power-controller@80260 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80260 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb2host0";
+		power-domains = <&ps_usbctrl>;
+	};
+
+	ps_usb2host1: power-controller@80270 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80270 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb2host1";
+		power-domains = <&ps_usbctrl>;
+	};
+
+	ps_usb2host2: power-controller@80280 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80280 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb2host2";
+		power-domains = <&ps_usbctrl>;
+	};
+
+	ps_rtmux: power-controller@802a8 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "rtmux";
+	};
+
+	ps_media: power-controller@802d0 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "media";
+	};
+
+	ps_isp: power-controller@802c8 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp";
+		power-domains = <&ps_rtmux>;
+	};
+
+	ps_msr: power-controller@802e0 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "msr";
+		power-domains = <&ps_media>;
+	};
+
+	ps_jpg: power-controller@802d8 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "jpg";
+		power-domains = <&ps_media>;
+	};
+
+	ps_disp0: power-controller@802b0 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp0";
+		power-domains = <&ps_rtmux>;
+	};
+
+	ps_pmp: power-controller@802e8 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pmp";
+	};
+
+	ps_pms_sram: power-controller@802f0 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_sram";
+	};
+
+	ps_uart5: power-controller@80200 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80200 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart5";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart6: power-controller@80208 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80208 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart6";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart7: power-controller@80210 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80210 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart7";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart8: power-controller@80218 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80218 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart8";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_aes0: power-controller@80220 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80220 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aes0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mcc: power-controller@80228 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80228 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mcc";
+		apple,always-on; /* Memory cache controller */
+	};
+
+	ps_dcs0: power-controller@80230 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80230 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs0";
+		apple,always-on; /* LPDDR4 interface */
+	};
+
+	ps_dcs1: power-controller@80238 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80238 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs1";
+		apple,always-on; /* LPDDR4 interface */
+	};
+
+	ps_dcs2: power-controller@80240 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80240 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs2";
+		apple,always-on; /* LPDDR4 interface */
+	};
+
+	ps_dcs3: power-controller@80248 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80248 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs3";
+		apple,always-on; /* LPDDR4 interface */
+	};
+
+	ps_usb2host0_ohci: power-controller@80268 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80268 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb2host0_ohci";
+		power-domains = <&ps_usb2host0>;
+	};
+
+	ps_usb2host1_ohci: power-controller@80278 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80278 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb2host1_ohci";
+		power-domains = <&ps_usb2host1>;
+	};
+
+	ps_usb2host2_ohci: power-controller@80288 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80288 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb2host2_ohci";
+		power-domains = <&ps_usb2host2>;
+	};
+
+	ps_usbotg: power-controller@80290 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80290 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usbotg";
+		power-domains = <&ps_usbctrl>;
+	};
+
+	ps_smx: power-controller@80298 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80298 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "smx";
+		apple,always-on; /* Apple fabric, critical block */
+	};
+
+	ps_sf: power-controller@802a0 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sf";
+		apple,always-on; /* Apple fabric, critical block */
+	};
+
+	ps_mipi_dsi: power-controller@802b8 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mipi_dsi";
+		power-domains = <&ps_rtmux>;
+	};
+
+	ps_dp: power-controller@802c0 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dp";
+		power-domains = <&ps_disp0>;
+	};
+
+	ps_vdec: power-controller@802f8 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "vdec";
+		power-domains = <&ps_media>;
+	};
+
+	ps_venc: power-controller@80308 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80308 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc";
+		power-domains = <&ps_media>;
+	};
+
+	ps_pcie: power-controller@80310 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80310 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pcie";
+	};
+
+	ps_pcie_aux: power-controller@80318 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80318 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pcie_aux";
+	};
+
+	ps_pcie_link0: power-controller@80320 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80320 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pcie_link0";
+		power-domains = <&ps_pcie>;
+	};
+
+	ps_pcie_link1: power-controller@80328 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80328 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pcie_link1";
+		power-domains = <&ps_pcie>;
+	};
+
+	ps_pcie_link2: power-controller@80330 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80330 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pcie_link2";
+		power-domains = <&ps_pcie>;
+	};
+
+	ps_pcie_link3: power-controller@80338 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80338 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pcie_link3";
+		power-domains = <&ps_pcie>;
+	};
+
+	ps_gfx: power-controller@80340 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80340 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "gfx";
+	};
+
+	ps_sep: power-controller@80400 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80400 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sep";
+		apple,always-on; /* Locked on */
+	};
+
+	ps_venc_pipe: power-controller@88000 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x88000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_pipe";
+		power-domains = <&ps_venc>;
+	};
+
+	ps_venc_me0: power-controller@88008 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x88008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_me0";
+	};
+
+	ps_venc_me1: power-controller@88010 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x88010 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_me1";
+	};
+};
+
+&pmgr_mini {
+	ps_aop: power-controller@80000 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aop";
+		power-domains = <&ps_aop_busif &ps_aop_cpu &ps_aop_filter>;
+		apple,always-on; /* Always on processor */
+	};
+
+	ps_debug: power-controller@80008 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "debug";
+	};
+
+	ps_aop_gpio: power-controller@80010 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80010 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aop_gpio";
+		power-domains = <&ps_aop>;
+	};
+
+	ps_aop_cpu: power-controller@80040 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80040 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aop_cpu";
+	};
+
+	ps_aop_filter: power-controller@80048 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80048 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aop_filter";
+	};
+
+	ps_aop_busif: power-controller@80050 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80050 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aop_busif";
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/s8000.dtsi b/arch/arm64/boot/dts/apple/s8000.dtsi
index 6e9046ea106c..84d6b4939ac4 100644
--- a/arch/arm64/boot/dts/apple/s8000.dtsi
+++ b/arch/arm64/boot/dts/apple/s8000.dtsi
@@ -61,19 +61,30 @@ serial0: serial@20a0c0000 {
 			/* Use the bootloader-enabled clocks for now. */
 			clocks = <&clkref>, <&clkref>;
 			clock-names = "uart", "clk_uart_baud0";
+			power-domains = <&ps_uart0>;
 			status = "disabled";
 		};
 
+		pmgr: power-management@20e000000 {
+			compatible = "apple,s8000-pmgr", "apple,pmgr", "syscon", "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			reg = <0x2 0xe000000 0 0x8c000>;
+		};
+
 		aic: interrupt-controller@20e100000 {
 			compatible = "apple,s8000-aic", "apple,aic";
 			reg = <0x2 0x0e100000 0x0 0x100000>;
 			#interrupt-cells = <3>;
 			interrupt-controller;
+			power-domains = <&ps_aic>;
 		};
 
 		pinctrl_ap: pinctrl@20f100000 {
 			compatible = "apple,s8000-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x0f100000 0x0 0x100000>;
+			power-domains = <&ps_gpio>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -95,6 +106,7 @@ pinctrl_ap: pinctrl@20f100000 {
 		pinctrl_aop: pinctrl@2100f0000 {
 			compatible = "apple,s8000-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x100f0000 0x0 0x100000>;
+			power-domains = <&ps_aop_gpio>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -113,6 +125,14 @@ pinctrl_aop: pinctrl@2100f0000 {
 				     <AIC_IRQ 119 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		pmgr_mini: power-management@210200000 {
+			compatible = "apple,s8000-pmgr", "apple,pmgr", "syscon", "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			reg = <0x2 0x10200000 0 0x84000>;
+		};
+
 		wdt: watchdog@2102b0000 {
 			compatible = "apple,s8000-wdt", "apple,wdt";
 			reg = <0x2 0x102b0000 0x0 0x4000>;
@@ -132,6 +152,8 @@ timer {
 	};
 };
 
+#include "s8000-pmgr.dtsi"
+
 /*
  * The A9 was made by two separate fabs on two different process
  * nodes: Samsung made the S8000 (APL0898) on 14nm and TSMC made
diff --git a/arch/arm64/boot/dts/apple/s800x-6s.dtsi b/arch/arm64/boot/dts/apple/s800x-6s.dtsi
index 49b04db310c6..1dcf80cc2920 100644
--- a/arch/arm64/boot/dts/apple/s800x-6s.dtsi
+++ b/arch/arm64/boot/dts/apple/s800x-6s.dtsi
@@ -47,3 +47,7 @@ switch-mute {
 		};
 	};
 };
+
+&framebuffer0 {
+	power-domains = <&ps_disp0 &ps_mipi_dsi>;
+};
diff --git a/arch/arm64/boot/dts/apple/s800x-ipad5.dtsi b/arch/arm64/boot/dts/apple/s800x-ipad5.dtsi
index 32570ed3cdf0..c1701e81f0c1 100644
--- a/arch/arm64/boot/dts/apple/s800x-ipad5.dtsi
+++ b/arch/arm64/boot/dts/apple/s800x-ipad5.dtsi
@@ -41,3 +41,7 @@ button-volup {
 		};
 	};
 };
+
+&framebuffer0 {
+	power-domains = <&ps_disp0 &ps_dp>;
+};
diff --git a/arch/arm64/boot/dts/apple/s800x-se.dtsi b/arch/arm64/boot/dts/apple/s800x-se.dtsi
index a1a5690e8371..deb7c7cc90f6 100644
--- a/arch/arm64/boot/dts/apple/s800x-se.dtsi
+++ b/arch/arm64/boot/dts/apple/s800x-se.dtsi
@@ -47,3 +47,7 @@ switch-mute {
 		};
 	};
 };
+
+&framebuffer0 {
+	power-domains = <&ps_disp0 &ps_mipi_dsi>;
+};
-- 
2.47.0


