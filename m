Return-Path: <linux-kernel+bounces-195662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5BD8D4FF4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 18:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3BD282E98
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09CF405F7;
	Thu, 30 May 2024 16:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SVUdQoQe"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F8A2E84E
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 16:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717086961; cv=none; b=pKqRfYR+GAz8Cb+ySvq/1U+KQR0Mv7AbHZyegkH8ysONAPeRU5pVGYjTetUTJ8sov3gLsH/E/fwH6X5vqQr0wsKN//+/UMJDn2SO+UUc/vfHFfeZORycjgDlrWrQxgypzi1YXGQuRhC2hstlfic2bwFwGEwodlArp/Xjsx+3NiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717086961; c=relaxed/simple;
	bh=LEI8NB2yoyJhYOmR3mpKn79Gg22AlJ9hDGKnYrecM28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OOeRrPaMuff7AxutiA0N5nfSzqWG8ejg3apILjmgmTofOS2dyUkp2xWF0VgRLwp853snDzmqIg55G0oLOs9V1j/FnZbJTigWNWq1HlaNpXev5RrLltiPJyiyy/YuFeKckJBnF8FT//5rxVaVrhc8UhcVrcQP0nwrlFw+ai37fXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SVUdQoQe; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso1750661a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717086957; x=1717691757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NwoUKZh6fnUPJSb5Qldq0gQl9yODeDTa7DK/f4E4vZk=;
        b=SVUdQoQe++KjqmC4XwGOlZM7s3kpfdZTb1vOrMQn69ftTAyjIt+/bLE4sU3NZJPOyU
         ajmUF1t5J4q6ieMHEPCxC6l93sQAO3NHW+9jnBGS8J38rolzjbWQhEV/m1gesSbQNW6c
         gia226bYi0/yuxMgMtwAi/GI+zETvgJlGOO+qIEC+QtQRFNacoioSewnlzZzLYXjaADK
         miGu8PA5s+Io38+9z3wBK9NmT9qv+LNx87HRiBrBNtV6RVAtlAi7K5mppIXemN8KN2te
         7Lz6dM6s9fHxYvYoO9Ll5Y+NqC2y6G7Vakl8Apn2+M5WfYnxZLAsxrmwt7zz/py4FcTk
         ufyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717086957; x=1717691757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwoUKZh6fnUPJSb5Qldq0gQl9yODeDTa7DK/f4E4vZk=;
        b=s4EMyb0COYmMCQ9FiPE/jUgYIR5G3p1Dr7COdET7D3YOIWMmUmT1p3grXwwLaz5rX/
         TuqGX2QBHpXnW8G01WuK1lMKgrviwBYon66tmDPJV3nnp5QLvJGsEbNBtg57Fs3Fyt7k
         C1aROm0xDj07W5dy8OY5DAj0z1fJfir/FM8z7svtAMw0ALjYEAx2q6vO+BP9cN4WFHlm
         bABWr8fzhMa9WIsDOYJPItf+aI/Awg/8CD5kz0VDPX6JYxytq/H9FnNeNphfZZ25hHDV
         VdBAyyi3oC63bdn6hTbHR+8ZlHqcdPQSVBNMk97TsJW27+DzBZ55ndBEkXPDcDoREC6u
         DGQA==
X-Forwarded-Encrypted: i=1; AJvYcCWBTwOvWQdjAHGyN75BweX5mK3/eFF5V1vVdJWiO1aFFEPrhw0WGogmf8gdB9iQhwOsd3wi1KOakhcs4q8WVSb3XBQ+eYiK4JhIxA7+
X-Gm-Message-State: AOJu0Yznb8Q2Ap+3J2yW/Wqkrw2nlsf69bbDrXG6AeTz/54S4qhQgOFl
	JFFe9ZG2zaRa9VDfn+fp1H6xS5M132aDKXiKVmB+i6/Je7QYGJj59icJAsBtgUAb7mnhYwi8q8e
	h
X-Google-Smtp-Source: AGHT+IGW3SMB6gAER0sbhRX95NMbuzy/Ew/Tchj0cRc2PxFEi/EKlQzcz1l+B7+tnmoW+SwqD/pNzA==
X-Received: by 2002:a50:8adc:0:b0:578:57f6:499d with SMTP id 4fb4d7f45d1cf-57a19f6ccf5mr2042134a12.12.1717086957068;
        Thu, 30 May 2024 09:35:57 -0700 (PDT)
Received: from [127.0.1.1] ([188.27.161.69])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a10670df6sm1888885a12.69.2024.05.30.09.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 09:35:56 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 30 May 2024 19:35:46 +0300
Subject: [PATCH 2/2] arm64: dts: qcom: x1e80100-qcp: Fix USB PHYs
 regulators
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-x1e80100-dts-fix-usb-phy-supplies-v1-2-6eb72a546227@linaro.org>
References: <20240530-x1e80100-dts-fix-usb-phy-supplies-v1-0-6eb72a546227@linaro.org>
In-Reply-To: <20240530-x1e80100-dts-fix-usb-phy-supplies-v1-0-6eb72a546227@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Sibi Sankar <quic_sibis@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1782; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=LEI8NB2yoyJhYOmR3mpKn79Gg22AlJ9hDGKnYrecM28=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmWKrnTCVOTWrXG13R48OpeoqH187zP5VUETgU1
 Zckz68tZvGJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZliq5wAKCRAbX0TJAJUV
 Vn3YEACDJZfEf5Ph+48/LzUelRz6qqDQmU4vbhrHbOxmUZVk3ea24oIQfHerU3Rlef1Hnbvtn2Y
 OfFSqycHczQAv7VpUbLtFlLHIZMUzDmRdpLhBxuDwDo04I0Lmwyy+4Fw8MK0b5hHxr3Uv6/nPJ5
 Ui2LlFJmfLUSgxmrwD8MTRypc/SluJiNQY4RLFaWgJtNym+4knzs18t0B6YDG5gIfNWyXP1XgIQ
 D6yTHoQM3IWDyWiqfyJfPXgMTotDDfBvps6Nex7xmEBuPKTDamIExH14z5QI33XFYOoOXisyZW/
 gD+XjF62ErlxjbaKkH4vOq9k99r43awKT/vAbPvkYWc+Ryap+JdYe8EKnJ8Z1NlN7Q+nL1aLclx
 858Wuue7cuK0YLC9hsS6Vch2jA7KZlcT7Fhv+q2TJc6qj2O1tQ/zlfbyLTu2vDBIbkgoLCQI4fb
 cYg878NV9SCj9DxHZsygOn8WUovTRe8pkJ8kZFEX30w2TKSHiNhZm9vnk2I/l5EAHXgc3c22oiX
 13SyhAi0RcwR30cRMsa1isMSou/PGMvTMOpgYD7K0eYjc7AtHnVRrtvkuFplQ6jCK81GWZbYRMn
 8wblFaDvOZm5E5mnpEipDQMux8qUunCHqf7bcwoOwP5XzSBg0LKLzkVUh+lt0RTWYkGHdlx2gjh
 MSW9dnIA9LYvD4A==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The 1.2v HS PHY shared regulator is actually LDO2 from PM8550ve id J.
Also add the missing supplies to QMP PHYs.

Fixes: 22b82135c02d ("arm64: dts: qcom: x1e80100-qcp: Enable more support")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
index 3de7565dda19..f4b47e6b3a2f 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
@@ -537,7 +537,7 @@ &uart21 {
 
 &usb_1_ss0_hsphy {
 	vdd-supply = <&vreg_l2e_0p8>;
-	vdda12-supply = <&vreg_l3e_1p2>;
+	vdda12-supply = <&vreg_l2j_1p2>;
 
 	phys = <&smb2360_0_eusb2_repeater>;
 
@@ -545,6 +545,9 @@ &usb_1_ss0_hsphy {
 };
 
 &usb_1_ss0_qmpphy {
+	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-pll-supply = <&vreg_l1j_0p8>;
+
 	status = "okay";
 };
 
@@ -558,7 +561,7 @@ &usb_1_ss0_dwc3 {
 
 &usb_1_ss1_hsphy {
 	vdd-supply = <&vreg_l2e_0p8>;
-	vdda12-supply = <&vreg_l3e_1p2>;
+	vdda12-supply = <&vreg_l2j_1p2>;
 
 	phys = <&smb2360_1_eusb2_repeater>;
 
@@ -566,6 +569,9 @@ &usb_1_ss1_hsphy {
 };
 
 &usb_1_ss1_qmpphy {
+	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-pll-supply = <&vreg_l2d_0p9>;
+
 	status = "okay";
 };
 
@@ -579,7 +585,7 @@ &usb_1_ss1_dwc3 {
 
 &usb_1_ss2_hsphy {
 	vdd-supply = <&vreg_l2e_0p8>;
-	vdda12-supply = <&vreg_l3e_1p2>;
+	vdda12-supply = <&vreg_l2j_1p2>;
 
 	phys = <&smb2360_2_eusb2_repeater>;
 
@@ -587,6 +593,9 @@ &usb_1_ss2_hsphy {
 };
 
 &usb_1_ss2_qmpphy {
+	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-pll-supply = <&vreg_l2d_0p9>;
+
 	status = "okay";
 };
 

-- 
2.34.1


