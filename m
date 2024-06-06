Return-Path: <linux-kernel+bounces-203869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D788FE178
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A9A1B25656
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C5813DBA8;
	Thu,  6 Jun 2024 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zrJkE1KP"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E778613CA8A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663702; cv=none; b=dSwtLc8lYjMreYsmEgZQPmDCneAafmqEKaZ2wKKSJ6oUcQnp0a2UGFFNwYG83xy1NeL7LkrC+d8lOUz0CcX6CnBQl8f6y0gvAjwQGoDhp6RFojaUVsiGyS7FAx//A9tZyxXMMPeKNbg1GqW4JSVyr4LQyzzujWoL98oU1cBCrpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663702; c=relaxed/simple;
	bh=ZbE2vLa8S9lvPjkvME7nqfkOHEOptRs807yC/TclS54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sT1iVERPc668RQDFW/1RRR3+T3eJoxIAWv/ua/PruvXdbwXPw2NXvkK7ODC7c87k/oi75nzzPY8qJDSUZYHhHSr1XQ0UFBbd10RKqBKvKf0f7dXr0GbTApMPSyR861vFbjd+GdpBVlQZdXMzkG5D05PAuCMHAozAxKRqDKQ7Vqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zrJkE1KP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4215c65dca2so4814065e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717663699; x=1718268499; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I11GCmwbwTQWJnggMYRy+IvcpltjoVwOcfxWgF2WTsg=;
        b=zrJkE1KP7NvahIGuAFzHp7IxVfW28ZjWgBGPJN0+B88M0RXeXVU91MdmgHkxfEx8ym
         qf4flctpOP2IBpJoRXTDHPg20Af5kew7IFLhO4jkXZ5hYQfev1xXu5ZXAi8Jvy4CjVf3
         tezQ0v64Y8Uazxs7Tf6oxHixW5YORDwXNP7Z9iuwTPN19t4rIA4DfPIIbb2+97uCyOpn
         SjMzMPL4Hy6xzSHcCmYjtroL+EBnWmySLChSmptKY3oVlhGPyCG6rGHNJGh/nfuCXLdq
         6cHEGIBpGbne/xbzJ1F4Qhx3nGgoIj2XmCboKLMLk1XFeg4RNQ1L4/jaXA2/Oz9MHnuM
         /t7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717663699; x=1718268499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I11GCmwbwTQWJnggMYRy+IvcpltjoVwOcfxWgF2WTsg=;
        b=sShVvB2mM++/r7Zl5PlJXHAFoWrbeUYq2R2LcDUyQ/IDMTywThrEWCtUSkZizkGZzx
         ZNENJgXvDHI4GC2S1wC6nfxOggvRfLJwc68/uSFHhFlppUwTxAZsVnkmQ2yDBYsRppQd
         N9sMZ4mlefvVPAarS6w/m64bZpFUeluKuhKetyQztBMu5MTg/IPv7r/fqgL4+2d+5Obe
         RH/AzyIIW8ayM7VxbVgpHzzqVO50a0JKRXWVNXdt8pIvzPY9cbuQmUlGPyfMEnBr/D0c
         MpsLJwEBBdgoGmqrNjH4WvQ30Hj9HwurF4VlwFunr+YkNqO1gWpyQqTJeJArAJ8OzScg
         qvxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3JalvQS1zSqzObdoX8IotWnU+NbhqmLsXrptpwII5yH8Afd6dR0I5a7AemTuBceSTjd2v4rKkk9qlJzvWiUvGkNafyvNEcmGGL8F7
X-Gm-Message-State: AOJu0Yz1weKVjuCHU9rkIY7cwS7KTVl9/boXT+PCw70UiB/gr8GFa1Xz
	IbefAza3vZ5A7SKvk7fIhXII2J+Fvs85gthycIOYEUl1v3nBqJgxfowH5MrhmMNrT4jLT7WZApN
	5
X-Google-Smtp-Source: AGHT+IHXNskKx96eAveDBrVtdYp/2X22ILbdY24ts/HP9hnKmVYhMiCzDPYXHNWBqE8KmW8CLvFx1Q==
X-Received: by 2002:a05:600c:b85:b0:421:2edb:d207 with SMTP id 5b1f17b1804b1-4215632eb27mr45552835e9.28.1717663699425;
        Thu, 06 Jun 2024 01:48:19 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2c690dsm14227445e9.34.2024.06.06.01.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:48:19 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 06 Jun 2024 10:48:11 +0200
Subject: [PATCH 04/12] arm64: dts: amlogic: sm1: fix tdm audio-controller
 clock order
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-topic-amlogic-upstream-bindings-fixes-dts-v1-4-62e812729541@linaro.org>
References: <20240606-topic-amlogic-upstream-bindings-fixes-dts-v1-0-62e812729541@linaro.org>
In-Reply-To: <20240606-topic-amlogic-upstream-bindings-fixes-dts-v1-0-62e812729541@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3425;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ZbE2vLa8S9lvPjkvME7nqfkOHEOptRs807yC/TclS54=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmYXfLxLYrVWx88kK9rLfSbTE4DHKxGZePo9EX4BNc
 N8QPGlOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZmF3ywAKCRB33NvayMhJ0TaFD/
 0VbGVTEtlallTWLLyKR/zCiWlQXmvjToJXlCheIxQSQKdLvSRWDv85LNyDUkPmOXq1gBwHNai3/is8
 tTgsWatCbxKm2V5r8Hwoy5Tm6zm6+P4V7uxCMP3W7TrdNRS7SKW/bqBvAtaSviLlKBRAjqOimEl7x1
 trIJfw86VACmLRWuRQx7RcQ5wChwIMu+DUy0ejeUFCUuZUk0PacElcQjxKy4i+TA9o/9Dm3/R/As10
 umrNj9LUtdfxio+TNIYY/ZT9K3MzkZZs1LlM+cYZB+vBd8UuEiHnaW26PnQOo5utjN233REotdKIyl
 tioawwMea5ZtMM3qO6/H2b+vR1mBosVpFrMqYoOatoaxJaJIdvB5eGO+qFPko4cMxD6CMNxZJmahBg
 Y25CKAppqTP19cFPExsKzsjLYCiRgirQQ2cDdcbvGmXHIIle7tctYQQVMBOil1YYapNaa3kGZBoSk3
 emnjlBFDWRYlfYrD/4O23UNsiP6R4v4yNK31kojoOYRWSOq9qDs446jXWY8MRxb/mDUugJtyeKoqwN
 pvZYppHURcF+4bP92sutL0C0ZkpJmnn81WlIfmw9VuNVifBbOroxVOZqL2Rn6MZI+38/vZMi2Rxtx6
 d/GGsFPQ5aDK2NBUKLqCBYpVEgArqtSuyCrcouu5KhuK8yLUWWpAPvPMORFQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Fix the clock order in the tdm audio-controller nodes,
this fixes the following errors:

audio-controller-0: clock-names:0: 'sclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
audio-controller-0: clock-names:1: 'lrclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
audio-controller-0: clock-names:2: 'mclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
audio-controller-1: clock-names:0: 'sclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
audio-controller-1: clock-names:1: 'lrclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
audio-controller-1: clock-names:2: 'mclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
audio-controller-2: clock-names:0: 'sclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
audio-controller-2: clock-names:1: 'lrclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
audio-controller-2: clock-names:2: 'mclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
index 643f94d9d08e..6822c2f3cfed 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
@@ -17,10 +17,10 @@ tdmif_a: audio-controller-0 {
 		compatible = "amlogic,axg-tdm-iface";
 		#sound-dai-cells = <0>;
 		sound-name-prefix = "TDM_A";
-		clocks = <&clkc_audio AUD_CLKID_MST_A_MCLK>,
-			 <&clkc_audio AUD_CLKID_MST_A_SCLK>,
-			 <&clkc_audio AUD_CLKID_MST_A_LRCLK>;
-		clock-names = "mclk", "sclk", "lrclk";
+		clocks = <&clkc_audio AUD_CLKID_MST_A_SCLK>,
+			 <&clkc_audio AUD_CLKID_MST_A_LRCLK>,
+			 <&clkc_audio AUD_CLKID_MST_A_MCLK>;
+		clock-names = "sclk", "lrclk", "mclk";
 		status = "disabled";
 	};
 
@@ -28,10 +28,10 @@ tdmif_b: audio-controller-1 {
 		compatible = "amlogic,axg-tdm-iface";
 		#sound-dai-cells = <0>;
 		sound-name-prefix = "TDM_B";
-		clocks = <&clkc_audio AUD_CLKID_MST_B_MCLK>,
-			 <&clkc_audio AUD_CLKID_MST_B_SCLK>,
-			 <&clkc_audio AUD_CLKID_MST_B_LRCLK>;
-		clock-names = "mclk", "sclk", "lrclk";
+		clocks = <&clkc_audio AUD_CLKID_MST_B_SCLK>,
+			 <&clkc_audio AUD_CLKID_MST_B_LRCLK>,
+			 <&clkc_audio AUD_CLKID_MST_B_MCLK>;
+		clock-names = "sclk", "lrclk", "mclk";
 		status = "disabled";
 	};
 
@@ -39,10 +39,10 @@ tdmif_c: audio-controller-2 {
 		compatible = "amlogic,axg-tdm-iface";
 		#sound-dai-cells = <0>;
 		sound-name-prefix = "TDM_C";
-		clocks = <&clkc_audio AUD_CLKID_MST_C_MCLK>,
-			 <&clkc_audio AUD_CLKID_MST_C_SCLK>,
-			 <&clkc_audio AUD_CLKID_MST_C_LRCLK>;
-		clock-names = "mclk", "sclk", "lrclk";
+		clocks = <&clkc_audio AUD_CLKID_MST_C_SCLK>,
+			 <&clkc_audio AUD_CLKID_MST_C_LRCLK>,
+			 <&clkc_audio AUD_CLKID_MST_C_MCLK>;
+		clock-names = "sclk", "lrclk", "mclk";
 		status = "disabled";
 	};
 

-- 
2.34.1


