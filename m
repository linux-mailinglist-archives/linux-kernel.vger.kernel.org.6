Return-Path: <linux-kernel+bounces-563110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF4FA63716
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 19:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CBA73A7717
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 18:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED711E1DF0;
	Sun, 16 Mar 2025 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXpm4HuI"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533BA1F4170;
	Sun, 16 Mar 2025 18:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742151413; cv=none; b=YXUFKoUW+Z3FFMKENVuWq8xWbaB0ydqu1/ObCRXZW04cDRKEitIIofjQwQ5Wx2xPqbuVGD46CtYVMNeSQf0XMA3/gBJ4N5E3zogSlg8gDfyYJ2zvmrKdJeD/RB4zQJcKNpTvaKyw7bbJzOaWfm3L0g8VsPfh7Bq8GmLKIm1K8/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742151413; c=relaxed/simple;
	bh=gJCXdAP5WKpnMY36ih9CkYJ7JDM2XKjyt33TAw9Xm3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4wpjykqGNw6ouj6fLr60F0DypZdhrbZtqWqgnplueZM+GeqIUyGGltknEdb5XaNWbJw2Eep0HWed1P8vmioOhgW3+oJhOUS5VMNqlqSh3UUTo+Nk9cabFu7CeHqWMcfonx1P27jh9Z+c3Yjq7PrgOj1mV9s9eXTE4OnwSo+/Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXpm4HuI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d0618746bso9907795e9.2;
        Sun, 16 Mar 2025 11:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742151409; x=1742756209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byzeZ9g+q+OgKNQAbtO6VbDB8pMI2PIP6vw/GOpDXCs=;
        b=jXpm4HuI9l9r29edXYSRg3AMOF9hjYKPD4eCQuTORL5zardKUWuPnzFkIn1q99ugsm
         +xoxpGTDyxynr6LSu0h5JM5Qlp1OKISs8RrhmOrCQtQ7Mt5aP6hLSKaIZowMwwfcpgOJ
         3vZy9lYUs/UL29QqVD7ftF/th7uCW8EUEEP5HBbGnNfPnswAuuB7gI7+l6f6F/QGg1dT
         dh13CUv8ICYZyerc9k4t4ud5u4Qo90XTczOfBsPVCpNoLX+i3l9+8UPiNtgx17Fh+P/I
         P6UAeiTTPRCFtWPUIpq7k8YqmnRN2lOKcTnoGcvxdBXxOSKJ+K4TSJBjaVfYs+qrqK/Y
         QHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742151409; x=1742756209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=byzeZ9g+q+OgKNQAbtO6VbDB8pMI2PIP6vw/GOpDXCs=;
        b=H326bkXs/Q+d173UpJqGxhEHzYBZWWYZwLvdrCym1FLH8RMF5ZS1/NTFTWugfJVphZ
         6IOLK0+8TUwmLIAud+VnqE4QMIUmtiJD7Aco5tX5sWYrbUhi0VocukeWdsuzQu777ZzH
         xUBSyeKii1W6EwnfqS2oq/pgFFXYZ3i8mmPzqAIUMIRQm0SrlTEpcc/TsVIFmk+7dRPH
         1BYLYV17KZ+V72SWCBKip3sUrTsJPxMTPoMj6FBU4fA40M4uZqVm5CvBBBrF/RJKBedQ
         TXnmspwS7JRGfEUhqlhvStM6wLwzwr0CJKg6Y6T6tHGN5J5lFnBJC7Cxy7c2LGwaoLaP
         pJmw==
X-Forwarded-Encrypted: i=1; AJvYcCVoeRDlhXMR7ildjRy4dC3tBAxMMrbio5M1dHjIdfPoTnyKhqb55cQmqFhHwiHllm2jQuI+c7hY6kG5kB5r@vger.kernel.org, AJvYcCVxQMAeP4MAqO0eUulCKyZtLoauv/77DeylUkos+DgWSVs7042kdFLOV6nob7eVgcJ/tz4h9wuH/mJt@vger.kernel.org
X-Gm-Message-State: AOJu0YxLLLbHhxk++/fMe08wTFUakWvtGk5IWeE5g4YujraXwYiUBRsC
	vBOkdVZYOUrBdCRvMY8eLxjKDFKRt53/v6oOL957q2cy0SUJKbLA
X-Gm-Gg: ASbGnctY3rR/PcYLwGRUYUTQl4Pjsz/fphM9K80VMCW0hSsEN4ddhZD8allKXlo94Wv
	qdlVXYvRUujc5zRRcbnpWqEJAm85LQj/ns2qNZT/jJycUZEkuxMhlrkk0l9DXIVQNgDA6FYKytd
	Wx6vCRPrscbFy4QSvfs4x+JzvZoow3X0ssBBUlEkYyr3i9Bdq9cBsVXZtfnu4deENWCO7ivSMPw
	fpdPJc3YjgE69w+TeCE3DyBZLPSCCpz+Pm7948oe1F6TocdICe4qVhVFT2ht/nKTamJAhpPtmyV
	et8kWfopi4PSBzDk20kSE/jEVzurvp8Gi/Mg8JdL+yZ4xx5KXjQktRTbeA==
X-Google-Smtp-Source: AGHT+IHyIAsL2flJepwd1QARIIgbCY/AczwoRosR63EIuqAqBvEyZG+kPa3KUxlGVA7o4JyQtrlAcA==
X-Received: by 2002:a05:600c:3c8b:b0:43d:94:cfe6 with SMTP id 5b1f17b1804b1-43d1ecc7b28mr110788435e9.16.1742151408488;
        Sun, 16 Mar 2025 11:56:48 -0700 (PDT)
Received: from giga-mm.. ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffb6292sm84692335e9.1.2025.03.16.11.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 11:56:48 -0700 (PDT)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: sophgo@lists.linux.dev,
	soc@lists.linux.dev
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jisheng Zhang <jszhang@kernel.org>,
	Haylen Chu <heylenay@outlook.com>,
	Chao Wei <chao.wei@sophgo.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 5/7] arm64: dts: sophgo: Add Duo Module 01 Evaluation Board
Date: Sun, 16 Mar 2025 19:56:35 +0100
Message-ID: <20250316185640.3750873-6-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316185640.3750873-1-alexander.sverdlin@gmail.com>
References: <20250316185640.3750873-1-alexander.sverdlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Duo Module 01 Evaluation Board contains Sophgo Duo Module 01
SMD SoM, Ethernet+USB switch, microSD slot, etc...
Add only support for UART0 (console) and microSD slot.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
Changelog:
v5:
v4:
v3:
v2:
- sorted all nodes according to DT coding style;
- added "compatible" property;
- renamed the new .dts not to use underscores;
- added status = "okay" instead of deleting it;

 arch/arm64/boot/dts/Makefile                  |  1 +
 arch/arm64/boot/dts/sophgo/Makefile           |  2 ++
 .../sophgo/sg2000-milkv-duo-module-01-evb.dts | 31 +++++++++++++++++++
 3 files changed, 34 insertions(+)
 create mode 100644 arch/arm64/boot/dts/sophgo/Makefile
 create mode 100644 arch/arm64/boot/dts/sophgo/sg2000-milkv-duo-module-01-evb.dts

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 79b73a21ddc2..3a32b157ac8c 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -28,6 +28,7 @@ subdir-y += realtek
 subdir-y += renesas
 subdir-y += rockchip
 subdir-y += socionext
+subdir-y += sophgo
 subdir-y += sprd
 subdir-y += st
 subdir-y += synaptics
diff --git a/arch/arm64/boot/dts/sophgo/Makefile b/arch/arm64/boot/dts/sophgo/Makefile
new file mode 100644
index 000000000000..94f52cd7d994
--- /dev/null
+++ b/arch/arm64/boot/dts/sophgo/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_SOPHGO) += sg2000-milkv-duo-module-01-evb.dtb
diff --git a/arch/arm64/boot/dts/sophgo/sg2000-milkv-duo-module-01-evb.dts b/arch/arm64/boot/dts/sophgo/sg2000-milkv-duo-module-01-evb.dts
new file mode 100644
index 000000000000..b1f8a5787861
--- /dev/null
+++ b/arch/arm64/boot/dts/sophgo/sg2000-milkv-duo-module-01-evb.dts
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+/dts-v1/;
+
+#include "sg2000-milkv-duo-module-01.dtsi"
+
+/ {
+	model = "Milk-V Duo Module 01 Evaluation Board";
+	compatible = "milkv,duo-module-01-evb", "milkv,duo-module-01", "sophgo,sg2000";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	pinctrl-0 = <&uart0_cfg>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&sdhci0 {
+	bus-width = <4>;
+	no-1-8-v;
+	no-mmc;
+	no-sdio;
+	disable-wp;
+	pinctrl-0 = <&sdhci0_cfg>;
+	pinctrl-names = "default";
+	status = "okay";
+};
-- 
2.48.1


