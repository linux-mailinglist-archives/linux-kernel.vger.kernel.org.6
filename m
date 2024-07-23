Return-Path: <linux-kernel+bounces-259842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B6A939E10
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67282B207B4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA36D14E2F6;
	Tue, 23 Jul 2024 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="REPUFA21"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F14D14D2B2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 09:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721727534; cv=none; b=Q/+O83mwyBmseIEiUWhR9DAlyj2y0zRYx+TvWffVVV1gW4po6v8nS4oeucx3WcE1XuZfYHc9f5MbF7cYN4qKEe47UTFr5QGKuakyzOxLvUKyWRqwbEoyha9vhS3W0lb4CKVrEwfteadVQR7jnXpkdIA8gF06Qk/MVJiOtIcw1QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721727534; c=relaxed/simple;
	bh=e/0jMCa++DLbHmnunUAXrgdmmxCkDTeW25Xm1qbPIz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SN78eYyqw3OWYX8gY57ssOIlkcoa/qOeODWs5UI1yu3/swwVyyjMKBxZqUBX2W10fNopceruj5Q2q+GMrgg1mbYvEpQpS12Ek+v/ZtgoLmdhp1jdbjxE9SN2aN1TpMKkgpv1OYzj7sdfG1D8tA0vf4sqApDj3AZsIRFBSNATk8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=REPUFA21; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3685a564bafso2513143f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 02:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721727531; x=1722332331; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ytuLcllwfeS5v01XMk2Klima2mg+93cPfjdEtcGTJo=;
        b=REPUFA215MBYWXq+fk0pay4oFSUxw2tYxzUJSGWd94/kQH8Yo3O8VUkD85sS7aBl0C
         Pwy4xOAdfYBv3FA+r+/L9k0RJFbpskzAoARvSmoyljmgXKuOybLweX3eZB/Ig2xWl32S
         eEr3xRj8TiTbxtRIaolvAuWzQMCnUsjnlImneWc30M/X8B9L8xq7fSkBCnQixh4XbTzr
         5KD3BnOCYvpmaFZmi4WQimi7cdBSb2LIDioylPnKZ/DwOsWL2jFzGD6Q44Zp4rJo7tZ0
         FFCx/AB1KcqsnKby6jpMQ/PZP0nCi8HVyfuZMUCdOQbUjOQIpj0/1vjWO3pWRwy5f+8H
         Sfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721727531; x=1722332331;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ytuLcllwfeS5v01XMk2Klima2mg+93cPfjdEtcGTJo=;
        b=UskGXSPSmaCIPIhCqIts+ftWMYRkKsMdeyCjViiSPolRg0upewLaaMSPdenpTenoIO
         GZCLqcoE3Sh5iy03sE7TZh7tay+Z0q7hz9+Fdsxfi14TkegU9Y+BhPXOVs9yTE2Dwwap
         wyTQIeT/86DkZYNWr3Kl+04tAufM1vGXSX70XacOXzQ1j5Oa557KewAGJt/k8uVCHz0V
         NqOfqjaTyPz+Nw6OgKpBeIYZR26FGdwlC42ro+bSfBQHr7MRlkrD8afSoMUoa6eMQCAN
         EKEu38be0mo3h7lCvJy9nS29vGF+UpxcR5Q6nVQvaodFaQtuROBFb2amsgMYFfKe7kki
         VM+A==
X-Forwarded-Encrypted: i=1; AJvYcCWBBUMH57FvyLyQieWSmMmXJSVhsSzvwDBQOzRdbtaRYzZeEajpNy51YvpJeBAPg6KXMvH5x/YR83qBLwEXmF9+8q4Kx0bQueAmsxBm
X-Gm-Message-State: AOJu0YxTnJB2O6U95LCqcg7iQPX8wdc8CvfLfRyqW38C7haANHV15eKE
	0oEsRGmRb/OL1yyZarM8us2LJzQRwI3PaijHdgeLT7yxPmz4CDIwhtm7c4/cSwo=
X-Google-Smtp-Source: AGHT+IEPtXxWNZpeIneH4FaHIvfKO2AosmFbIUwDfO+3AnwbsZcQZDtq/C+WKgMsiRJ+VbHsogPiAg==
X-Received: by 2002:adf:e789:0:b0:368:79c6:8845 with SMTP id ffacd0b85a97d-369bb2db8camr6749526f8f.56.1721727531441;
        Tue, 23 Jul 2024 02:38:51 -0700 (PDT)
Received: from [192.168.1.191] ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36878694637sm10953345f8f.56.2024.07.23.02.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 02:38:50 -0700 (PDT)
From: Rayyan Ansari <rayyan.ansari@linaro.org>
Date: Tue, 23 Jul 2024 10:38:50 +0100
Subject: [PATCH v2 2/3] arm64: dts: qcom: pmi8950: Remove address from lpg
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-pmic-bindings-v2-2-e1cd614f8c4a@linaro.org>
References: <20240723-pmic-bindings-v2-0-e1cd614f8c4a@linaro.org>
In-Reply-To: <20240723-pmic-bindings-v2-0-e1cd614f8c4a@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Rayyan Ansari <rayyan.ansari@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=736;
 i=rayyan.ansari@linaro.org; h=from:subject:message-id;
 bh=e/0jMCa++DLbHmnunUAXrgdmmxCkDTeW25Xm1qbPIz0=;
 b=owGbwMvMwCXmtuJiX/SRuS2Mp9WSGNLmV2nm8JzyP6u7dcqpkg3Tt59qVHjvvvvmQ63VL5xNu
 aYzawZP6ihlYRDjYpAVU2Q53PRlzevtTkJXtledgpnDygQyhIGLUwAmYmXJ8Fey6sSiXwdMzsxe
 I+rtxbT2m7ahyN2ls3fkN72c+FF94swcht+svhMby9k9K0O5595N9DUSL9h6U7TzWTFbV2OPxun
 LizkB
X-Developer-Key: i=rayyan.ansari@linaro.org; a=openpgp;
 fpr=C382F4ACEBB74212D4B77ACA46A8D18E5BC49D84

Remove the address in both the reg property and node name to adhere to
the bindings.

Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
---
 arch/arm64/boot/dts/qcom/pmi8950.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pmi8950.dtsi b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
index b4822cb17a37..4aff437263a2 100644
--- a/arch/arm64/boot/dts/qcom/pmi8950.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
@@ -84,9 +84,8 @@ pmic@3 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		pmi8950_pwm: pwm@b000 {
+		pmi8950_pwm: pwm {
 			compatible = "qcom,pmi8950-pwm";
-			reg = <0xb000 0x100>;
 			#pwm-cells = <2>;
 
 			status = "disabled";

-- 
2.45.2


