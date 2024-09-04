Return-Path: <linux-kernel+bounces-314622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A3596B5E5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A48F1F228E1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67941D04B2;
	Wed,  4 Sep 2024 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TgZu5xSF"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D171D0497
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440469; cv=none; b=bYAEdcd9Ixo7SQyL9T2caX/Jc9UZub524wBplJgHmYM83lfrYegtAkx7aCVrAcGa9J6UDNV6Y0kb+ZC7oT6B6R0tMTExWLQG0w+RicUblSN//MpL21mDENMV7rDEVsBWlcYuCIeSZTyydHkeiIRuL3VqHOQ8qsepFiACy4MbbCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440469; c=relaxed/simple;
	bh=TETkVZ+20vH6yp0NjKmhwjdtI4t+kdGs8b4C7PTUYyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mneRjjtgyHqBinfk90Q+8k476PBwb02S6G9T0P1NuzMEzEBdDOKpdSDp1NsshwNxR4m14pA96teBr9m93EbjKypAwSlusLLJrLdukl8JuGbcV7ibdVtKem2Cz1EvjLoc5SS3qXBgp6R82+WMVYiymVQuTkOIZYsK8l8vPYQMSgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TgZu5xSF; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71434174201so5171668b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 02:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725440467; x=1726045267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBItDi4n14IYuM9iuwfGhl3IjynLmMqAt1J2tlAZIYM=;
        b=TgZu5xSFoaaEDs2wdJ0y9EDpKJDt6H7iAIl0bLwVn+HDI4FD4eRvZpj3yaYNfw4vh4
         XW9OMs9BzgnAy3g4SRPho3gKJejgrxdct+E9FcMnwhW3P48ZWHAmRIwHaNcDI79MNLrd
         ngmCYaLoonK3CPzp7aSVzu+Us6FaAwVwOZYCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725440467; x=1726045267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBItDi4n14IYuM9iuwfGhl3IjynLmMqAt1J2tlAZIYM=;
        b=FtToxJ7sVO/9MU8oIyvZrz1nx88dwc7yXR1kX19IH/PGa/+LYFSDNibbYfOFGRwzAR
         kiAzv7zzYgwByU85q6ILX7CDo+X9TOog9mjCboJrxewtdz6VYoj1CuoyqjJ31gfUlX2v
         xDORxVPsHNpilOo0b5jwMUyHbL7kG6Oxc9gyTmvPWmmLi/+kxnLFu851N9MS0zaFmN+D
         JnvfgkGRwl7Pyz9eAdBwux1HTV1GIpLxaLxGfGq459UF3AX8S6SsMrvFVEJOpZE/tpVt
         QKSLxRRt+bVonRtRPpNhBQjsMGEG0AsVgrzrVsd72p0tsqb2lJ5fCSuAc8hANhZsEoIl
         c+FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRJ8//eoOnPoVa+CZjnX9rxqylha2hrXPGQDz5zTjHsotxyJx6vrTSaVYiXv08fmkxpk/kJv2yeA9Qu+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqKLf6xQ/6KsCotspoHSmHl8B7PwnUH2uuimtgz9iuR3V4QN+0
	K3rOuLYgEzXpqS7pfDWlG7FQ7gL7XbML2oXawTjOuTE8DjcDO994Qg8P/tt0AhAND1e9DDEv1dE
	=
X-Google-Smtp-Source: AGHT+IH2qucxlwAjWUMwLjsKdIgEfhg67bYq6GG+aNowoHtwaNabhMzLvVoNZUyf17AzUzRmQ7DIlg==
X-Received: by 2002:a05:6a00:9282:b0:704:2563:5079 with SMTP id d2e1a72fcca58-7173d0069b0mr16668781b3a.27.1725440466605;
        Wed, 04 Sep 2024 02:01:06 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:83fc:5c8e:13bd:d165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-717785b5183sm1153279b3a.197.2024.09.04.02.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 02:01:06 -0700 (PDT)
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
Subject: [PATCH v6 12/12] arm64: dts: mediatek: mt8173-elm-hana: Mark touchscreens and trackpads as fail
Date: Wed,  4 Sep 2024 17:00:14 +0800
Message-ID: <20240904090016.2841572-13-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240904090016.2841572-1-wenst@chromium.org>
References: <20240904090016.2841572-1-wenst@chromium.org>
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
2.46.0.469.g59c65b2a67-goog


