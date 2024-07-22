Return-Path: <linux-kernel+bounces-258927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F27938E97
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 13:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D667D1C2119B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9A816D9B9;
	Mon, 22 Jul 2024 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vXFHiCQq"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F022316D32E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721649462; cv=none; b=NtGohfYAnhC2olmjRwSMKCL2LuJ2bmUr+aBWMBRxsZOpefKATWhMuzeI4zGrlgXxfmMP8u4+MWJPGDaeSKEYw4ANIHFhOTbu2Kk8aiVBKo5ftxWT51q6AgseiOnRrDaa1W9WV1vSIJCKOhSljV6Vzxi/tqpM/y44x4KrWwTv+QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721649462; c=relaxed/simple;
	bh=F1orDjEHJakOsOgrw2A5ldW8NfRAdatIOug2faLipeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k/kJBYEOMKRMDX3ngBcDGOhMMFNHB0c4aq/ZaEvEDast7jDDqwCBc6XfB/EkdYEycyXUguXxyDl7JZQKmQV+E730ebdq0kmZN2oDEzCmfJyG54ihOk/ThgAuUJhEvNpppQXq2TWu6v2n8Iwv19XC63iwNnb+JxG7VsCqOEKTtpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vXFHiCQq; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ef2fbf1d14so7378241fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 04:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721649458; x=1722254258; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Bjn7qNFQ5oOeozmGDZXaVGqpmfLng3wHRltiFh+ERI=;
        b=vXFHiCQqtl9qx0vrMmrTWehuPunAU+ZOzN/IsXmYdNYPrVSSMluN+NUo0bEJyGoLh3
         BGnPjvnoN84lEmIM3A3uTUs1TzpSg3+o9jhWR4n2NukuZwCDhdEywAL9whkSMJBr8eOI
         tC0WaBmq+nLV6LE/QIlcYADymVrpQJysn7/zpFh3oJUa68MMg9WrZuVnhF43ibTtrJYU
         hu3snAi2ks1s64iumesbw2UAp7lrmf1zxPS/7DvaXEyMZy4Exjusmy5cU1fhZKRcZWEX
         XVLbDPWbTBrrFH+FpD8SEGd0FSGf49Pva3nGLXTn7sseN4KLwKjNB4mQbfL8N0H+Ibv3
         30eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721649458; x=1722254258;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Bjn7qNFQ5oOeozmGDZXaVGqpmfLng3wHRltiFh+ERI=;
        b=ZdogblVcesv7L2b++BAa1ZzgKvdISh58t+qeoxPPk+/df+nw63NXr347qxH5Ci7HCl
         EOfP+OIGjwVMvN78jqB2kU85CJD38Fr20up4Cw9W+RCQL5SM2W6sdOYzDteTH0B1Q3bG
         h3wWZALd88kuOphYcEjnHr7dOzB3BJ5USlNBkmTMKfCUbxi+OVTN7Ayw4F90FByYMwz0
         KBBh9N+s61iHSgYKQprxv435bubuASMkp3mssdRAtoDJ4vWjFG3+U1ypCjGTuGMFlogl
         DzPSj9s6JCopv6PM6Dky0INhI9HEZ7rb47LiJLtpQUxhL6J79QEzUYD89pWpE9/t8SRR
         VBXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVejxkxlAr7U67S5G8qsbF7FIFZw5ZtSw+xCbeveaE6KE7LECNc3xnXDE1fXxax0PXJb+vkycXv79FVe4Tps2kvFWI5VKo60LDJnphW
X-Gm-Message-State: AOJu0Yz8L46e42Q5Gq/FSekpZMw7Kakna9/S3QXu4rM6WihGoQU8xv9t
	8TdQgBYMqn+DmCF36LhYMc7BOufDBHv9IpdaN8e4W09XMUvQIUWq7XvIVtftsnY=
X-Google-Smtp-Source: AGHT+IEoJZveHNlW6BoNfTUsmFUXMg26XuREkYO7fdjHYz/fVX6nh/0A4mt/R8GJDWyh/V3WgR7N8Q==
X-Received: by 2002:a05:651c:a05:b0:2ef:32b5:1de0 with SMTP id 38308e7fff4ca-2ef32b51f02mr8457431fa.7.1721649458166;
        Mon, 22 Jul 2024 04:57:38 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ef0fd10bffsm12449611fa.134.2024.07.22.04.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 04:57:37 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 22 Jul 2024 14:57:19 +0300
Subject: [PATCH 2/4] arm64: dts: qcom: msm8998-lenovo-miix-630: enable aDSP
 and SLPI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-miix630-support-v1-2-a6483cfe8674@linaro.org>
References: <20240722-miix630-support-v1-0-a6483cfe8674@linaro.org>
In-Reply-To: <20240722-miix630-support-v1-0-a6483cfe8674@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1010;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=F1orDjEHJakOsOgrw2A5ldW8NfRAdatIOug2faLipeo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmnkkv/zDr0Np1G1zO7lTZor58Ds5KUbRa4mpgu
 1UeoC3y0yqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZp5JLwAKCRCLPIo+Aiko
 1WhOCACyJP/TZvG3FLEBfAJjE7tosLyXoMHqaz+vums7JB+RZO3ieavZ+mIf/PQquevDTIKAjwH
 gDaC3uTBk/zGWos/Db0KM1L1GEVUaGUW2Tg0jYrroakplBTN21xECemZax8S2L6Vdahf+DKWG7w
 MDLWX6ux8a43vivWsKSNufnWCO25qsrrXah00aIh9RmIjBxpPrfG1Jye1LeElwMakZs9a7WjxNX
 bDB58k+wwonZojiCR2WVmUv7L2M855B8cNa4cfKRsVAXRUO7UeM0oQguK47Tri9E3J0RR4KReuy
 MMN4tFYytRgvyYA77fv0YIwU7xlp0F/LwujIFamJ+SSd9XkT
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Enable two other DSP instances on this platofm, aDSP and SLPI.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts b/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
index 118c55f5bcfd..f585bc8ba2ce 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
@@ -45,11 +45,21 @@ keyboard@3a {
 	};
 };
 
+&remoteproc_adsp {
+	firmware-name = "qcom/msm8998/LENOVO/81F1/qcadsp8998.mbn";
+	status = "okay";
+};
+
 &remoteproc_mss {
 	firmware-name = "qcom/msm8998/LENOVO/81F1/qcdsp1v28998.mbn",
 			"qcom/msm8998/LENOVO/81F1/qcdsp28998.mbn";
 };
 
+&remoteproc_slpi {
+	firmware-name = "qcom/msm8998/LENOVO/81F1/qcslpi8998.mbn";
+	status = "okay";
+};
+
 &sdhc2 {
 	cd-gpios = <&tlmm 95 GPIO_ACTIVE_HIGH>;
 };

-- 
2.39.2


