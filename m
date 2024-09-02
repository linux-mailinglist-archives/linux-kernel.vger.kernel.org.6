Return-Path: <linux-kernel+bounces-311361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA9D968807
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBCC21F230AC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4F920126A;
	Mon,  2 Sep 2024 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="upiNhHVm"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E608C205E3E
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281734; cv=none; b=DHJ2+7QMyYaRSeXK8JNb/TiJwPko+vR4mRcuA1OeWgfJgiYfXxjO4xA915XQhqjrsJEIKw1YFySBRcUds4/Cu8hr2PUkZ0JXo06tLdIiZOM+LFXnBCpakY9b7bRv8bUi6sRwzDZ6rbrxfO2z0ep21itA7AWo/xM2QIxbbdV2aq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281734; c=relaxed/simple;
	bh=qg6jt9MB+B131NPyTV8hIhIdOfA+4/yE1zt+6tTUB2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lS3NQ4NlcmCHSF5flEsFE5gxaCcoIU9am72F3+fW9xNQrxQ4vLX1N0dppCbejNAZC3w90QwM1f/ClAPiMTbR7uOJ+lziA0OLD+wl4TYnfzJrMd2yx+ZFtqg3h/lKjFBTQq6ndP4jF43ryVepMORNiRSVHIj7HfNtK5xfZ0lT52o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=upiNhHVm; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5d5eec95a74so2584457eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 05:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1725281730; x=1725886530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0Faiv4F2b7xddh+q/SgeKMN+zpFMJWyEspVvW6ZQ24=;
        b=upiNhHVmsqcurzK4km6LbHdcvPbihf7ybUubq4JwXe4yRwRSOYuIRPtha25LA2nPLm
         jKS8PIg/xwWilmmSSsNViwpZLhPAehcZF3fts9iKCuFEkPzES77vNtZC8XjybGesqGIB
         S9KiL+7LQDGf+3oD5PM1JKIZHDsqC7CHQ9KignwI5969GqYY/szjFO9D1+uIw9SjjH6a
         1gD8yZmNCz5HqYkR+ee6wrPD/FfDJrbn1RW0diPket0JoBW2+swJoSCr0iLrDBEVqP/z
         5ygHI/z4DOHOFSzuhO+EGIx0GssCAPRmg8dHskQ33u7UdzD5l6rLuZMbKY5i3h3T/nCl
         a+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725281730; x=1725886530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0Faiv4F2b7xddh+q/SgeKMN+zpFMJWyEspVvW6ZQ24=;
        b=Fe8X8yOq4gu0VVgV6kCU3vpUBq/3WV6/cyZeGIyqCa6nlDU6sa+IqtfBeO2G7aXErn
         K0jH0TTQoO9A33Hk3Y8RBiVf9Q8Z9lIzzUEjB1tFneP9e406poq2tMwTS5owBIF575/5
         Yh7ihC9D1M8rwyWabOO/eyQ29Aeyws1kTxT/JNTYJjGazLWnkNtHEqxP4vKVm3XSxuI9
         QqJgvHRf4YPDS32PFUlzS12iV0NhxIGpEBVCvOKKVJitFAhNt4o3KpdlNoYXmkVPF1vj
         jZskvR5mkMCKHjf2nn14SLHLDwm5qzbmM0Qvh81Vowu3NaRQMWb8jgelkpi7p0bAus6e
         xphw==
X-Forwarded-Encrypted: i=1; AJvYcCXpMejJez54WTMIIhTWsanVcLGu6PTZK9SWV8aQ4QfJRi7IKMC+KE+WYTThBoP9GVD+vE9YiEt0gQ95Eiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsiXH/8RkOB4MtdAXgPk6r8Rq3EsLv614380nCnovzgFJqhIvf
	XyKeHU0cUlShYnmgMRK3ir7IzQeJ/FfuisRNFRsc2qlcpH9v3/fVtc4hp0XGykI=
X-Google-Smtp-Source: AGHT+IHcyi5vydx/746M7d/6GECMdUfXDrDrYYfqq5lidYij9QZorwhlIY/Tue65yXeXflEc7ebS2A==
X-Received: by 2002:a05:6871:e264:b0:270:4dbb:195a with SMTP id 586e51a60fabf-277900c729cmr14372566fac.15.1725281730271;
        Mon, 02 Sep 2024 05:55:30 -0700 (PDT)
Received: from zjn.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a99eesm6773955b3a.50.2024.09.02.05.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 05:55:29 -0700 (PDT)
From: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
To: angelogioacchino.delregno@collabora.com,
	matthias.bgg@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	knoxchiou@google.com,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
Subject: [PATCH v1 2/2] arm64: dts: mediatek: Add MT8186 Ponyta Chromebooks
Date: Mon,  2 Sep 2024 20:55:02 +0800
Message-Id: <20240902125502.1844374-3-cengjianeng@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902125502.1844374-1-cengjianeng@huaqin.corp-partner.google.com>
References: <20240902125502.1844374-1-cengjianeng@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MT8186 ponyta, known as huaqin custom lable, is a
MT8186 based laptop. It is based on the "corsola" design.
It includes LTE, touchpad combinations.

Signed-off-by: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
---
 arch/arm64/boot/dts/mediatek/Makefile         |  2 +
 .../mediatek/mt8186-corsola-ponyta-sku0.dts   | 24 ++++++++++
 .../mediatek/mt8186-corsola-ponyta-sku1.dts   | 27 ++++++++++++
 .../dts/mediatek/mt8186-corsola-ponyta.dtsi   | 44 +++++++++++++++++++
 4 files changed, 97 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 8fd7b2bb7a15..4ad3cd200ec5 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -58,6 +58,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393216.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393217.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393218.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-ponyta-rev2-sku0.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-ponyta-rev2-sku1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-rusty-sku196608.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-steelix-sku131072.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-steelix-sku131073.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dts
new file mode 100644
index 000000000000..87e8368189d9
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2023 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola-ponyta.dtsi"
+
+/ {
+	model = "Google Ponyta sku0/unprovisioned board";
+	compatible = "google,ponyta-sku0", "google,ponyta-sku2147483647",
+		     "google,ponyta", "mediatek,mt8186";
+};
+
+&i2c2 {
+	touchpad@2c {
+		compatible = "hid-over-i2c";
+		reg = <0x2c>;
+		hid-descr-addr = <0x20>;
+		interrupts-extended = <&pio 11 IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&pp3300_s3>;
+		wakeup-source;
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dts
new file mode 100644
index 000000000000..203ee109bbf7
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dts
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2023 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola-ponyta.dtsi"
+
+/ {
+	model = "Google Ponyta sku1 board";
+	compatible = "google,ponyta-sku1", "google,ponyta", "mediatek,mt8186";
+};
+
+&i2c2 {
+	touchpad@15 {
+		compatible = "elan,ekth3000";
+		reg = <0x15>;
+		interrupt-parent = <&pio>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&pp3300_s3>;
+		wakeup-source;
+	};
+};
+
+&usb_c1 {
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta.dtsi
new file mode 100644
index 000000000000..59594022331e
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta.dtsi
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2023 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola-steelix.dtsi"
+
+&keyboard_controller {
+	function-row-physmap = <
+		MATRIX_KEY(0x00, 0x02, 0)	/* T1 */
+		MATRIX_KEY(0x03, 0x02, 0)	/* T2 */
+		MATRIX_KEY(0x02, 0x02, 0)	/* T3 */
+		MATRIX_KEY(0x01, 0x02, 0)	/* T4 */
+		MATRIX_KEY(0x03, 0x04, 0)	/* T5 */
+		MATRIX_KEY(0x02, 0x04, 0)	/* T6 */
+		MATRIX_KEY(0x01, 0x04, 0)	/* T7 */
+		MATRIX_KEY(0x00, 0x04, 0)	/* T8 */
+		MATRIX_KEY(0x00, 0x01, 0)	/* T9 */
+		MATRIX_KEY(0x02, 0x09, 0)	/* T10 */
+		MATRIX_KEY(0x01, 0x09, 0)	/* T11 */
+		MATRIX_KEY(0x01, 0x05, 0)	/* T12 */
+	>;
+
+	linux,keymap = <
+		CROS_STD_MAIN_KEYMAP
+		MATRIX_KEY(0x00, 0x02, KEY_BACK)
+		MATRIX_KEY(0x03, 0x02, KEY_REFRESH)
+		MATRIX_KEY(0x02, 0x02, KEY_ZOOM)
+		MATRIX_KEY(0x01, 0x02, KEY_SCALE)
+		MATRIX_KEY(0x03, 0x04, KEY_SYSRQ)
+		MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSDOWN)
+		MATRIX_KEY(0x01, 0x04, KEY_BRIGHTNESSUP)
+		MATRIX_KEY(0x00, 0x04, KEY_PLAYPAUSE)
+		MATRIX_KEY(0x00, 0x01, KEY_MICMUTE)
+		MATRIX_KEY(0x02, 0x09, KEY_MUTE)
+		MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)
+		MATRIX_KEY(0x01, 0x05, KEY_VOLUMEUP)
+	>;
+};
+
+&mt6366codec {
+	mediatek,dmic-mode = <1>; /* one-wire */
+};
-- 
2.34.1


