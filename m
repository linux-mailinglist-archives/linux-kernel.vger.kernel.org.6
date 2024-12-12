Return-Path: <linux-kernel+bounces-442438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAAB9EDCC4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 01:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A281A283736
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FD314B06C;
	Thu, 12 Dec 2024 00:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XtSIV5AP"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383211632EF
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733964474; cv=none; b=rt3UkP47Dc53yC2vGOXU7hwrZbFLUX59efjFJ5ppbi4Rmm3B7fuLSKdAggDEM7u2GnwptnX+lDk/545V4yXQobzGEbuExoruTp+MuFg+Jh49YvDrrRmmZp4sxd+FsrIvpfURyCQcaFSbG7QK0ACDKsitKVxPlBxKF8VDvubyUcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733964474; c=relaxed/simple;
	bh=onN/fyaI2B+gXcyjb4glosU8R39A7qsREEgJ/i/7DUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkP7vGKnKFg1Nvavjo8zKbrQgAAgiWVicdBg/EAQY/1Guqw7ysGMb0IPjpfEVjS6yvD7aAmYyaIreW0XKIJztbVctvjjXxv+UL45BGOV8SBObGdd0flGgh7IBP2NxVrckz0610l/uzeBkDJxuM05HObXBc4cgeiH3wFvEOTEe5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XtSIV5AP; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso8554f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733964470; x=1734569270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rV+oSHxMzB7djaacyAb6Ozy1okMulrrztHmf2SfoQUo=;
        b=XtSIV5APpS0KNQLd44M8RpH6wVTqlpX6nCyxqyxrWI9GDzuP01dcSinh/F6cz5gt74
         qFMM9ggeBmCvercGLD7oXBMZez6h+lL56lTMQiGQvVnymR/xn4Hvros81Q5N/Rdv3bK1
         fRuMceHnlmphdITh2vtJ5hspMYP/eK3zAgGb1/PwsEUeRALgzeSiatJw0+P3G1lFhH5r
         7ES+eItG9x/BCKLuVQ6U7Bn5Dmu2Gy3EN87CtuJ2PEZIobEcCznwX3LBbNuKegAyGpWz
         8+I9zYwokrLAfkCGV7/Y6bdVLPbW4f8v8L0L4bzRjv29wrd0pR2rzhgcxooq3hL6TQMC
         kIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733964470; x=1734569270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rV+oSHxMzB7djaacyAb6Ozy1okMulrrztHmf2SfoQUo=;
        b=s4C/bhoXTnwxpv0GyJCZ2VuqQthQGKhRs9gQyKxPDcXBs8IZEhkpCWZmUDOBmQol1f
         ca+G2wVBSTldb7f9hPdpjfiYKBrRo9m3pS4A3DmzxMEbrP6CQ4Ug9ojoEMCR76rmcFZj
         rU2KEl+btgHBha7nU5x7CRDTVzgYB6wC6Sgow6EqW9Rbu2gZiCQaxaLmNoGvaXcIARHn
         lsFxLJwIjONTVpB5XQhroGRh8MCshARBMcWVhPtW2bcsjPUe/n/S6rr2Qo3ksM7DScaX
         PvrPykcF/toM05iNZWN9w+zf2qpFLXmlqH7tqDfV+C7pqwHqZ6oOcrbqvHxe6XA/PwAA
         tP5A==
X-Forwarded-Encrypted: i=1; AJvYcCX7A9XNNDSXqaOZvNi7UvhRYL7DNpiHXCPCG93hOZNGVPowcO9xRxn5Npm5Wmur5b5lYmC4nlM+qHqETQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YykdJ+PZIpSMPpL6a1HjhSfJ6gnREhjQSAZuko8knYhhlqJP6IT
	R5gkHhN4Xg3MAVO4/8Xozu+aQR6ZyMSMFj33JhI6kdJchbsh8X7sYNVYK9ysFb0=
X-Gm-Gg: ASbGncvQk6Ie5p9wlmfDfwVgQvDwjrhL7pLZUFaCxd4yPbBclJfukBfRZ+Bk3xXqp7u
	3RNGMs17DRDfqsbbAisLYd+PKmkurVyCzdE7jpA674/UdYEOBxySM95xDKTqVx3FfnQlF3cFmeL
	13/I3kIzeg2/JuBWFVhV3jFdItbnDeO+yC9AyxyXVK5l167c3IemRlwpiCPHHdl8BCRDGCY4812
	s13Z/JxR0mMVNRZApdqRnKVm3f9jILmOeMworAZghhWHkg73NW6McP2dCt3Zrm6iKGl2NGg
X-Google-Smtp-Source: AGHT+IFAk1Y8qy4yabp5VFqeN0qshO4/4jp4s6LgayFE/Znd6/U/Ng+pprV0dDY9YOcoyY0cS9nP0g==
X-Received: by 2002:a5d:6da4:0:b0:385:e0ea:d4ef with SMTP id ffacd0b85a97d-3864cea1edcmr3389698f8f.58.1733964470591;
        Wed, 11 Dec 2024 16:47:50 -0800 (PST)
Received: from localhost.localdomain ([2.222.231.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824a4ef4sm2459660f8f.39.2024.12.11.16.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 16:47:49 -0800 (PST)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: broonie@kernel.org,
	konradybcio@kernel.org,
	konrad.dybcio@oss.qualcomm.com,
	andersson@kernel.org,
	srinivas.kandagatla@linaro.org
Cc: tiwai@suse.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dmitry.baryshkov@linaro.org,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/14] arm64: dts: qcom: qrb4210-rb2: enable wsa881x amplifier
Date: Thu, 12 Dec 2024 00:47:23 +0000
Message-ID: <20241212004727.2903846-11-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212004727.2903846-1-alexey.klimov@linaro.org>
References: <20241212004727.2903846-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One WSA881X amplifier is connected on QRB4210 RB2 board
hence only mono speaker is supported. This amplifier is set
to work in analog mode only. Also add required powerdown
pin/gpio.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index 6217bc6e6282..827ce5f7adfb 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -264,6 +264,24 @@ zap-shader {
 	};
 };
 
+&i2c1 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	wsa881x: amplifier@f {
+		compatible = "qcom,wsa8815";
+		reg = <0x0f>;
+		pinctrl-0 = <&wsa_en_active>;
+		pinctrl-names = "default";
+		clocks = <&q6afecc LPASS_CLK_ID_MCLK_2 LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+		powerdown-gpios = <&lpass_tlmm 16 GPIO_ACTIVE_LOW>;
+		mclk-gpios = <&lpass_tlmm 18 GPIO_ACTIVE_HIGH>;
+		sound-name-prefix = "SpkrMono";
+		#sound-dai-cells = <0>;
+		#thermal-sensor-cells = <0>;
+	};
+};
+
 &i2c2_gpio {
 	clock-frequency = <400000>;
 	status = "okay";
@@ -730,6 +748,14 @@ wcd_reset_n: wcd-reset-n-state {
 		drive-strength = <16>;
 		output-high;
 	};
+
+	wsa_en_active: wsa-en-active-state {
+		pins = "gpio106";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+		output-high;
+	};
 };
 
 &uart3 {
-- 
2.45.2


