Return-Path: <linux-kernel+bounces-439140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 017B09EAB57
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE58F168B67
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C19231CA0;
	Tue, 10 Dec 2024 09:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k3wzcoUg"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A6C230D10
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733821677; cv=none; b=MOT6xExSzA+njMuTowtYtgYGnvzFLLvvgQX0UisOj8WDtlPeGh2ihcmLAq5F8mYuqTYUtgv6RNwvaXUEPf82s7WQFqUTasFxP6Njh/aHAdcjitrLHn10lLNKdAnWYso4wCC6lTWg8ipdkxLngPoKXQuxqvyGuDYh8BCDbdvFItI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733821677; c=relaxed/simple;
	bh=Q9J6ApvGJ3m2pNcYcuR9E8HDVhiYaZFxTYOCAn6nn6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GXeTp1hulCrEHuX2jwnh+I6VtDmxXGos1iXx/A8+Q7W6W+RXskPKLyhFuwIHE6TiuI3+d1lBJ4CoyiwTLujnP5dMdfKj+9ADVM22fj9j4546ctGGRxKsgTCK/c8ZCGQo5ditU/i6OKAxLilh5dQKnb9GqP++ngaY1RpCrg7h+rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k3wzcoUg; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa6413fc7c5so521646266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733821674; x=1734426474; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QqyY/novBaYmiIZ/gk/w5WoFp3bfM2ml4pcz/sRVAQg=;
        b=k3wzcoUgV8Ph1iq8vBpoSFbqlBD1vDvcBArPuKKe0hvrQOsDVEdhhBh4yYyeC9USf2
         c/PoyDLb40b6RKu7eUIOPTcQ478klSICeG6So+sB7YmKyqL8Em0rI9D5TxOPmzSa/OeL
         ZWEheL83f6qvKLcX6mC+u5Onnw5Tjw4izM2vYAUAjmfGTQTyMn1cKGcVgebS/BAmgqn0
         1IFh5De9FFsyMLpGFUrO6sw/FfhNnx4QeDTnLCLQcX8sKCKj2/hPxB5GFPHStsu5oiXX
         FKC1a+Ki5UoyyNe9jfOC0JdP1o686FYbiBYaBKml2Zb/bpQUx54jMQvW47EguRtXlMrQ
         uHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733821674; x=1734426474;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqyY/novBaYmiIZ/gk/w5WoFp3bfM2ml4pcz/sRVAQg=;
        b=xGgvc4ix/qiKhLCr3vA2o6ysX/EDcHn9+SQM8FvP+akVqT00/JhANSUV0sW9s7s+Ek
         NOj3dsDKKBg5Z4CWXn/sLcX49UcJPUKw+Gjcyfc08qIIcx7L9DFzHFsP4LzcSjNcrpiJ
         WngfzLCCE0lBle42P8jq+YLtTmTfFTSM5u6eQx5WXRAPYAlSB7r0TjU7HwDhLrqkT+P4
         OGT9LhuUlTpwnnUX/Z8wNWjC4WPFMQ9aczG9RSqoa1MEfr5yqyV5Sg6hyYLPwhSSSgAW
         SQM/56x2br7bZv9CEDcykZr+aYMhLOa+RFI1hFKRLw2TLarAR7PwuxnNvLg/ww1sLri5
         ClPA==
X-Forwarded-Encrypted: i=1; AJvYcCXLhD0ZYLQprsfy/FQEp/DpW+3DcFgfdxod1aNbo+W0o3bet+Gd84lIIhsIIKpV66fa7f+MQT9KyaUBXqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx528B+U2ourFZhW+ICNDUjgr16IRyY8aSKuBxaEbJd4YuWUfjG
	zS+hWTTbmttR/uZMM6CmJQ876DBU6c6qFZsLBVPC6BLk9S2UF2W29innpGEqj6E=
X-Gm-Gg: ASbGncsd0IlWrq8dsLduLlIqCdB7UAhSyKkPwWqpBEEfhxrZaFjMT7bU8w78nQbJbOn
	Cv0SYEtWTQJK3tqKBhzbS1pfp+djtP3ToDVBpTA/PqE/Ch20Y0Z+SclC1+Nc0nDJ8qEshpohUi8
	nhlkTzsvceQRIaK61N2lLvyXQFf18FbE8zM6Su1vzpIr6Eh3ReuB5t7Js5oQmLCLRH/D78XTprJ
	RGaBHc717rN6GfYjcKVcmLBRUz8uQksjXmL/OxwW/fJtQdU3VQ9s4MiQ/16ZOp9XVI=
X-Google-Smtp-Source: AGHT+IEO+SnGr053M7x/sOumkjJv+KCyijsrHs22rOmS2ZdHD1mD4epFF06VN2VxwQHFi43e8/A2Ow==
X-Received: by 2002:a05:6402:2551:b0:5d2:7270:6128 with SMTP id 4fb4d7f45d1cf-5d4185d6098mr9372216a12.25.1733821674326;
        Tue, 10 Dec 2024 01:07:54 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef40:6709:8d26:5167:3c1d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa699618041sm173148066b.81.2024.12.10.01.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:07:53 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Tue, 10 Dec 2024 10:07:32 +0100
Subject: [PATCH 1/8] arm64: dts: qcom: x1e001de-devkit: Fix USB QMP PHY
 supplies
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-x1e80100-usb-qmp-supply-fix-v1-1-0adda5d30bbd@linaro.org>
References: <20241210-x1e80100-usb-qmp-supply-fix-v1-0-0adda5d30bbd@linaro.org>
In-Reply-To: <20241210-x1e80100-usb-qmp-supply-fix-v1-0-0adda5d30bbd@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Marc Zyngier <maz@kernel.org>, Xilin Wu <wuxilin123@gmail.com>, 
 Abel Vesa <abel.vesa@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Aleksandrs Vinarskis <alex.vinarskis@gmail.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
X-Mailer: b4 0.14.2

On the X1E80100 CRD, &vreg_l3e_1p2 only powers &usb_mp_qmpphy0/1
(i.e. USBSS_3 and USBSS_4). The QMP PHYs for USB_0, USB_1 and USB_2
are actually powered by &vreg_l2j_1p2.

Since x1e001de-devkit mostly just mirrors the power supplies from the
x1e80100-crd device tree, assume that the fix also applies here.

Cc: stable@vger.kernel.org
Fixes: 7b8a31e82b87 ("arm64: dts: qcom: Add X1E001DE Snapdragon Devkit for Windows")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
index c9db6298d528ed505bae08e91bf4da02faef7d76..8eb80ecd36990ee39005bfd583e0b3e331de5374 100644
--- a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
+++ b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
@@ -1255,7 +1255,7 @@ &usb_1_ss0_hsphy {
 };
 
 &usb_1_ss0_qmpphy {
-	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-phy-supply = <&vreg_l2j_1p2>;
 	vdda-pll-supply = <&vreg_l1j_0p8>;
 
 	status = "okay";
@@ -1288,7 +1288,7 @@ &usb_1_ss1_hsphy {
 };
 
 &usb_1_ss1_qmpphy {
-	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-phy-supply = <&vreg_l2j_1p2>;
 	vdda-pll-supply = <&vreg_l2d_0p9>;
 
 	status = "okay";
@@ -1320,7 +1320,7 @@ &usb_1_ss2_hsphy {
 };
 
 &usb_1_ss2_qmpphy {
-	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-phy-supply = <&vreg_l2j_1p2>;
 	vdda-pll-supply = <&vreg_l2d_0p9>;
 
 	status = "okay";

-- 
2.47.0


