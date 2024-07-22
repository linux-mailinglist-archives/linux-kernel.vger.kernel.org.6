Return-Path: <linux-kernel+bounces-258929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD941938E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 13:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 400D7B211D1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7AE16DC04;
	Mon, 22 Jul 2024 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aArrBnZo"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F0116D4DA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721649463; cv=none; b=oFeiztzi+8KAzFC12ekOZC2ZNxgsnpiIHL8RBGzCM6U2hDBtmbDWdFh6/jqfF+mdWGU2l+xAUvxDCa8wMhujW3scgfpaeSUADgN+UMWyQDI4CCraf3L9FeeuEcS4zf9Vg/4bnZ2QMfidGJ3BIqu7v8ml0Z5P+3gJENQDxPY7yUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721649463; c=relaxed/simple;
	bh=TVA5iDz4vhPZfTCtMOCIDSxjofuZeK4umEsrUAFB8fI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ax/k7z9njLSmgIjkacSz5APGRT2N6/NkpZF99MTLLFa43aSV5WAiiHNDf3/crhl6CHfyjcSUTxJD/jll3k2YeC5SIoFmUuElrolk7Q+3KOXZVp4kmEqiz9DCtPmitgL5jORh9oXe7ZYrTF9bA/NyC7EuWmxmZMpEKcEiKZ9wDFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aArrBnZo; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eea8ea8bb0so72247691fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 04:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721649460; x=1722254260; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADJBSEjOH+Qk6LiwSQ4vw+VA93bzd1Yz6Ubhzq0lJlU=;
        b=aArrBnZoc1hpFiyPJ0sKxiJZarj28yPP25KzfFkgmsXsh7IsmJYrM+IszK1RKZYr+o
         AzScIyoqe4vUpNQrk9vzD8Y6hmNpFqgRbCipEeV2m1RzDu4Q1XLhOqxG2m7QM1uYx2s9
         6OEPZ+wZsL1EZtr3pxkeIQLiImC4vjC8Db/hM5eYQ6MIKc/uUac9UHMT+UNnW0xpouQD
         6v/pdPM1b/rBmel23QmD3Ybai1I9FlP5s9e3ow+LUyy7yvX30eFTYr44ZvuTNIVEVO0d
         aYjFtl5U63EHwXFL4p6a/A+pshIEmgnoqFRL/2QmqjiaFa1LYPRBfuATi3JoTKUvrkzM
         OJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721649460; x=1722254260;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADJBSEjOH+Qk6LiwSQ4vw+VA93bzd1Yz6Ubhzq0lJlU=;
        b=fz5Amf/8KzrLGdGLOJkcJE/uRPanqUg2TBzvUujIhzN5wKtsb5u2ymCEefgpQBB+B+
         rAnUvs+kJo0GKZ+bbhshbXKqgECZNcH01lEV+yUmAEYf7HgNYfTJUXI3JrLWtOgw7XIS
         bgRzToB83q28WLrEi0H1fMoc8y/RokeaaTy7MjcdYMBqwZP4hgFPi5o/TdJvgYs0cEDw
         XqFoWtKnt8bg50Jc05iTJQjguOFT1+uMVA/vdAqJpC99zGJYoUOIP7kEWetHX1gcEFab
         GGPG6h9aRKr9rMKs5ej00/0zjp0SAbYca6TvToDPTG8+1ycPT4Jc/+gOOMJLA51zSGP9
         aEUw==
X-Forwarded-Encrypted: i=1; AJvYcCWBKS9tyXEnIwXVSTjWxw8U+NSY/VPTi4Yo4jlzg/wxMt4iO2oy3Iq8GCOE2tJx6sDDp+LgNyANvVnlJyI+tksdC9iqS5qWpwM2xdf+
X-Gm-Message-State: AOJu0YzgZAttFnewhF8f47TGlHTgKQPwlYYLgo3jAFDh4d8KMSEeZmxw
	eUTsc1YSQzb1/Kc1Ar1sADfg8HiZGuE6Vp0tlIBF1033uGWEfvB1QWIat+vHGiw=
X-Google-Smtp-Source: AGHT+IEF/cdIHk+JfiILx4OtjTwZodyr63Ix2pmkn+A9wQKQP7lJ7NSN1iMBgU1bHdBbjmiiUtO4sQ==
X-Received: by 2002:a2e:90d1:0:b0:2ef:32bb:5368 with SMTP id 38308e7fff4ca-2ef32bb5806mr17916891fa.11.1721649459847;
        Mon, 22 Jul 2024 04:57:39 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ef0fd10bffsm12449611fa.134.2024.07.22.04.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 04:57:39 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 22 Jul 2024 14:57:21 +0300
Subject: [PATCH 4/4] arm64: dts: qcom: msm8998-clamshell: enable
 resin/VolDown
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-miix630-support-v1-4-a6483cfe8674@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=681;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=TVA5iDz4vhPZfTCtMOCIDSxjofuZeK4umEsrUAFB8fI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmnkkv3DVObavWjjq7QKMiHR4ZVNZYQ6EJmzq29
 wKJoKJB7aKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZp5JLwAKCRCLPIo+Aiko
 1fgLB/492GA0uy+LDnhQKSnMLTFxskDg+jgojfvRoyWutBEPmV6xKy9NuMNwBbyu9q5qdyi1n81
 zyCoh49Zop0GWEzQk4V906ZPFdzdMkxASp7n0l9vBo+QD3n5ynGT1mKPq8fcWlAdaM7AhxQf/8n
 EH/eSOsfq6cbtjzzR47ihhvbj5TBGTe+8YDEzw6E45pes0ifteOb4JrfvwuuqP0F5f7GsXkxpfD
 1bEiGQnfvPvAX4jd8GK3pOOi3d8pBiJsYbYrL/iOB4hWsY53EOo4Sodf8jTSoH4N40AjaoPs3w/
 hyQ9ipEu7cEUNAbDhuwtwmvTdRfC0Fle69R2mB2dY3REFkDO
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Let resin device generate the VolumeDown key.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
index 3b7172aa4037..75958c4013b4 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
@@ -128,6 +128,11 @@ pm8005_s1: s1 { /* VDD_GFX supply */
 	};
 };
 
+&pm8998_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
 &qusb2phy {
 	status = "okay";
 

-- 
2.39.2


