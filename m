Return-Path: <linux-kernel+bounces-330318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AE8979C82
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A11D1B22CD6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6ECF1494A0;
	Mon, 16 Sep 2024 08:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XGkzNBCt"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0122F140E4D
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726474131; cv=none; b=MQVV/tH4GTXpXzk5fC6TO5UIYcRoLhRvG4kmgW78UqMmnp4IzIBEThP+eO9EBUFlKrNAnvOSXvg5d5rygVokXC5YxtwUoOVqIi+10q0Y8psoJslNO7XbGZhK7hGEYUi3djOq07fN1osM6DvoXNkt7boQ7Ikg98/P2UKG+5RJiHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726474131; c=relaxed/simple;
	bh=k9f3zeZNf22hhWbxdNbW9N9SNlPMvy1DbsfTCeBd+r0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lxfJknZGYWPfoUuA63efhbdMSUeeeemoNIEc+tVRAUpP+lp5H44HRzi9PzVG4EWfJBEm5tDYOCmqiw3cpg4dbCx/oWg4EMql0UGoeQJDSoCCGJj2hyvDLaKCYYLGFrrZ10a8m1TT3TdKszyzZ35jzCH0izxtSJS+0lk93gChtq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XGkzNBCt; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cba8340beso31874595e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 01:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726474128; x=1727078928; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gyrG/39yIquvbCmBYVx9eiuBKuujGgooJBfHN3TrPfQ=;
        b=XGkzNBCtsTXmSn1VZ3aRvsbaHLUD4Z1Zfd77zrcX22blCeZ5A8MFu12lPcxFoJSAWu
         WUvk6TlbErQ1+Epo5NRIEeRmHzYmBRP2pPmbLrRRCU0ziwzTsHR30UFT/stNSaOz8wIa
         QIofhsIDfsJu3JyrP7GGRbAYvjUUKbYdKszkyEYgo0mUcECFa+lg0keEldH/qYIja7GL
         T67D9cKXKwpKaI5lrUVoOb4QzcYnyWGy04kJ0YrP01SoRSscNiFNuB11aENoah5PYsaj
         7sWIyiGiv8bAGHNi2Wb4vQkPxjBgsvoEq+OXukGR/tWdWrR6c3tlMCKkKsPcLUanv8xv
         mLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726474128; x=1727078928;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyrG/39yIquvbCmBYVx9eiuBKuujGgooJBfHN3TrPfQ=;
        b=M1eOmABe24FblC9WJjGl996acwzwlW0KK6DQM2ba8wplgfa7LTfubOLtkiKuWoL77i
         eXAbverlu1gBqSpQqyPupHQjHPWFMWbqdhZjeeuYOJ/NCM+KJw46y8PmZCMG/zFgKRfR
         Ofp0T0mLL1/6w5i0nwYxLVmkaViodAG8/0wptGgL+mH46JEcFE/79qQTbnQxeYgiJ7hs
         FR0y6TWY6XDEEXUC39H1bQBKRzAJQifuNEhsp854epmXBTdw+Rw0SiPcJlxcXMWqG0qd
         ldPCB0o9QmLqQO0phTXN0nw2Qk6plH6pxAk3XrIRO6m8X+bMMpZirbd0kdc8UQWJWg20
         BTtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlO00od/0tPjxeRZBVUtUcgQKf83Z5oC3CDmTRHYk66TKg8bI3k2oQtSP5CWN4Y/8ErZPxUahTXzY1DEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu0AF17EDQujm+AU3cL0Hg46D631v5d1ZsxGTPQSCSN6QIr0fH
	7fDsiNu1sghTLGTFZt1pjWn7hhiyyAXbGyXI9oRb0ayfmlJaoY4nf8LaCj95SlI=
X-Google-Smtp-Source: AGHT+IHGmppS4PFg1Xsjs8QMIiLiYyfR0ofoHSGknvjx6ulr/GPZF9iZovUAobPsZPzBZ9UTs/nMAQ==
X-Received: by 2002:a05:600c:4f08:b0:42c:b54c:a6d7 with SMTP id 5b1f17b1804b1-42cbde1a7b6mr129698535e9.14.1726474128120;
        Mon, 16 Sep 2024 01:08:48 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da22b900esm69309465e9.1.2024.09.16.01.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 01:08:47 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 16 Sep 2024 10:08:35 +0200
Subject: [PATCH v2 06/11] ARM: dts: amlogic: fix /memory node name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-6-0b20ed4f0571@linaro.org>
References: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-0-0b20ed4f0571@linaro.org>
In-Reply-To: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-0-0b20ed4f0571@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2754;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=k9f3zeZNf22hhWbxdNbW9N9SNlPMvy1DbsfTCeBd+r0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm5+eG2bxlIrKdJ79EiteVP5xs4/qQ/mQodteKiqmv
 yVeXHP2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZufnhgAKCRB33NvayMhJ0S+VD/
 4hdSKVD77LSfV67vgBCvXvn7j+lCOKAzjTAh+gwy61FrFuOIL1G+NsN1L1i2QUlk2FXocQv/62qYYA
 hZ3zV9OnqsYJsgyrTeURzrNboDZX2PZhrZEEhxat//Cc04R5jT9yyuIAE7boadg0B/QBpa28Zq6SiT
 Bi/ceaJCC6eiK6bBhYcR1q5O0Gg4xb0in7sotEhKXJtxTZzEAm01R1s6lmYAAtj/aQg6dmnOy4olan
 4ZvR7E5QdeWoujOyC5nDN78z36zKIwmmfeYkHjzfYsWXo/tKxPI8ZH7fnENwuB1ScsoNgKhPNtUcxj
 dATbs9VkpQjyfDGP6z1cp7Fj9Xl3o3Mn+B49FRVIFM55k7OS51bPXmj9TqON/2Ws/nczIbFsDDzHPV
 WaMOQhvMTUzfWUBZKTsge1XleqAVPBg8D148QIT3F53pQSLGxbviDyTo2K0LACF8gkEHTnCNKMpnnc
 d3Mv72rsIwPthTvybHUusEjCVGGq2/oGk9P731Nultyst3D2xR0c2qjvt1h+ll/Gm8Ks8qrwdiU3OP
 nadxv1UeLGduq+JBUiJAjgLbTe192vhZ+LQPADV2FaFlhAYUD4Die/RtqAc2UDCGHQVeJmVsyhP6Is
 h/5vMp0b8PXp87FuuNLLF/AZgac0cdfnB78VVH7jgwW7u7eZvdsc/b99Vqag==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Use proper address in /memory node name, fixing:
/: memory: False schema does not allow {'device_type': ['memory'], 'reg': [[1073741824, 2147483648]]}

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/boot/dts/amlogic/meson8-minix-neo-x8.dts | 2 +-
 arch/arm/boot/dts/amlogic/meson8b-ec100.dts       | 2 +-
 arch/arm/boot/dts/amlogic/meson8b-mxq.dts         | 2 +-
 arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts    | 2 +-
 arch/arm/boot/dts/amlogic/meson8m2-mxiii-plus.dts | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/amlogic/meson8-minix-neo-x8.dts b/arch/arm/boot/dts/amlogic/meson8-minix-neo-x8.dts
index c6d1c5a8a3bf..b97531000d55 100644
--- a/arch/arm/boot/dts/amlogic/meson8-minix-neo-x8.dts
+++ b/arch/arm/boot/dts/amlogic/meson8-minix-neo-x8.dts
@@ -19,7 +19,7 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@40000000 {
 		device_type = "memory";
 		reg = <0x40000000 0x80000000>;
 	};
diff --git a/arch/arm/boot/dts/amlogic/meson8b-ec100.dts b/arch/arm/boot/dts/amlogic/meson8b-ec100.dts
index 49890eb12781..36fc3e15ee9f 100644
--- a/arch/arm/boot/dts/amlogic/meson8b-ec100.dts
+++ b/arch/arm/boot/dts/amlogic/meson8b-ec100.dts
@@ -22,7 +22,7 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@40000000 {
 		device_type = "memory";
 		reg = <0x40000000 0x40000000>;
 	};
diff --git a/arch/arm/boot/dts/amlogic/meson8b-mxq.dts b/arch/arm/boot/dts/amlogic/meson8b-mxq.dts
index 7adedd3258c3..fb28cb330f17 100644
--- a/arch/arm/boot/dts/amlogic/meson8b-mxq.dts
+++ b/arch/arm/boot/dts/amlogic/meson8b-mxq.dts
@@ -22,7 +22,7 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@40000000 {
 		device_type = "memory";
 		reg = <0x40000000 0x40000000>;
 	};
diff --git a/arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts b/arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts
index 962bbe3337db..2aa012f38a3b 100644
--- a/arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts
@@ -22,7 +22,7 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@40000000 {
 		device_type = "memory";
 		reg = <0x40000000 0x40000000>;
 	};
diff --git a/arch/arm/boot/dts/amlogic/meson8m2-mxiii-plus.dts b/arch/arm/boot/dts/amlogic/meson8m2-mxiii-plus.dts
index aa4d4bf70629..08aa661e17ad 100644
--- a/arch/arm/boot/dts/amlogic/meson8m2-mxiii-plus.dts
+++ b/arch/arm/boot/dts/amlogic/meson8m2-mxiii-plus.dts
@@ -26,7 +26,7 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@40000000 {
 		device_type = "memory";
 		reg = <0x40000000 0x80000000>;
 	};

-- 
2.34.1


