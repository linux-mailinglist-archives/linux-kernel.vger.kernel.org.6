Return-Path: <linux-kernel+bounces-296985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 253C295B186
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963B61F2168A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6EF1865F9;
	Thu, 22 Aug 2024 09:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n0CPqB4X"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8937D185B7E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318459; cv=none; b=JiUhcuUx+qZXng4cbHtu5j5ASenA1EJAgiWSbPDu2fzQzCZcIQ74S44sSVzm+sfhtBAyDmCN6tRcyZCiGi/OB2KE2xgqqsCRBeHc/orPaC1Ny72174mrU/zjBEKOR/qS5HmYJS+SFT7OUWv6eL4J7ucLkdrC7dHb76Yh4M9oEtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318459; c=relaxed/simple;
	bh=KPKZx+o2UwLiNaiDemeY/MCCfCJXoZ6VeunQ3tP7UxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXkMJh9nTzwGEXveJ10v7cCwhqwrAVWR7gvzk7GvxFEfqC0CHawZ6yUsrK+XNDSN/ejYfs2/EEZ47id6l62WVMOgMyP+aoz1th059OPsZechyQLea1rIOw0FWOHnYoa/YwCJOGKVRLr5L5cfsPP51/mWQmNAI34efORQWZKxgks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n0CPqB4X; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7141b04e7b5so362171b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 02:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724318457; x=1724923257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0ZXsCUO90vlD45ZJO1I+QT/1oidv8iaRsna2l2Dubk=;
        b=n0CPqB4Xuvhg7W13cy97dJnxh0HwAyaWacv3xLpLC2/r5kr5P1l5iLCavXUhIIEB1I
         twt9Nao6GLLHerKxIYfFzFUneIdbZX+Ut5Lqc+yS18po3ldEKV/e9jEe9z55HqV4fbVp
         UmBU7pr8ttSOrBwUXW+tRlj/inWDn+cWUHRpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724318457; x=1724923257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0ZXsCUO90vlD45ZJO1I+QT/1oidv8iaRsna2l2Dubk=;
        b=ID7NG3xSOvU04/t4YodBchPPmDE9iWAyiTycT8nGGyLYGET6IepirITgKwpz1W7QnY
         o9FDjZC0g7nxi2Ribi/hMLcvfWGy7Senkn4m1kqhG3XwiLfnp2TEqG4o8QZjgNJrFwGc
         drH6B2zKA+MydoTxzfOVa30bbwRkJjgGL8WTks9aW3FZVo8YRvo07tlb+OENV+y8bJvX
         CUdJ1EkbQ+j66ZnaWEG9mZV5b6gsyKl95tVvkZCIWgfmNKiJaOH4pbyrxzg09Ry2heI+
         0Fa3fS/zBkGUHEk63HTZa+FjDU2XljhiQzbrfn5uBt9SOMs4z+hdxhiacGrorcJFytT+
         oJ7g==
X-Forwarded-Encrypted: i=1; AJvYcCXiKI2W+aWBa7xT7jJb/ya2NhxHaECdTSu+42q5KgDwZV1nU7pGcwSOYLsAZkXmurc/Jhpug6gRqIzx48k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsYfQ62HD0zukAt2+P1IAaOBKDBmHl6yPF6Lqm4pRhtj5/nycS
	eYqbuTkdLU8vF5EXZRMztPe/xx4YWysqBfFYtoQUQAziunIAYcIWr38HZMoBVg==
X-Google-Smtp-Source: AGHT+IGopbbojtmE4fS/IUOg0cpO0JEZHF2VnB3L6eDK3aI3tJHchVj0lRN1Md7MFI5PPKTGcEf3AQ==
X-Received: by 2002:a05:6a20:2d26:b0:1c6:fb07:381e with SMTP id adf61e73a8af0-1cad8180a2amr6660606637.44.1724318456919;
        Thu, 22 Aug 2024 02:20:56 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:8470:6a67:8877:ce2c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434335e69sm951398b3a.194.2024.08.22.02.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:20:56 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wolfram Sang <wsa@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	chrome-platform@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Johan Hovold <johan@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-i2c@vger.kernel.org
Subject: [PATCH v5 10/10] arm64: dts: mediatek: mt8173-elm-hana: Mark touchscreens and trackpads as fail
Date: Thu, 22 Aug 2024 17:20:03 +0800
Message-ID: <20240822092006.3134096-11-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <20240822092006.3134096-1-wenst@chromium.org>
References: <20240822092006.3134096-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of having them all available, mark them all as "fail-needs-probe"
and have the implementation try to probe which one is present.

Also remove the shared resource workaround by moving the pinctrl entry
for the trackpad interrupt line back into the individual trackpad nodes.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v4:
- Rebased

Changes since v3:
- Also remove second source workaround, i.e. move the interrupt line
  pinctrl entry from the i2c node back to the components.

Changes since v2:
- Drop class from status
---
 arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi | 13 +++++++++++++
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi      |  4 ++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
index 8d1cbc92bce3..251e084bf7de 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
@@ -14,6 +14,7 @@ touchscreen2: touchscreen@34 {
 		compatible = "melfas,mip4_ts";
 		reg = <0x34>;
 		interrupts-extended = <&pio 88 IRQ_TYPE_LEVEL_LOW>;
+		status = "fail-needs-probe";
 	};
 
 	/*
@@ -26,6 +27,7 @@ touchscreen3: touchscreen@20 {
 		reg = <0x20>;
 		hid-descr-addr = <0x0020>;
 		interrupts-extended = <&pio 88 IRQ_TYPE_LEVEL_LOW>;
+		status = "fail-needs-probe";
 	};
 
 	/* Lenovo Ideapad C330 uses G2Touch touchscreen as a 2nd source touchscreen */
@@ -47,9 +49,12 @@ &i2c4 {
 	trackpad2: trackpad@2c {
 		compatible = "hid-over-i2c";
 		interrupts-extended = <&pio 117 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&trackpad_irq>;
 		reg = <0x2c>;
 		hid-descr-addr = <0x0020>;
 		wakeup-source;
+		status = "fail-needs-probe";
 	};
 };
 
@@ -74,3 +79,11 @@ pins_wp {
 		};
 	};
 };
+
+&touchscreen {
+	status = "fail-needs-probe";
+};
+
+&trackpad {
+	status = "fail-needs-probe";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index b4d85147b77b..eee64461421f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -358,12 +358,12 @@ touchscreen: touchscreen@10 {
 &i2c4 {
 	clock-frequency = <400000>;
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&trackpad_irq>;
 
 	trackpad: trackpad@15 {
 		compatible = "elan,ekth3000";
 		interrupts-extended = <&pio 117 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&trackpad_irq>;
 		reg = <0x15>;
 		vcc-supply = <&mt6397_vgp6_reg>;
 		wakeup-source;
-- 
2.46.0.184.g6999bdac58-goog


