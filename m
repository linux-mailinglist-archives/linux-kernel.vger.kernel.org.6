Return-Path: <linux-kernel+bounces-515977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD27A36B7E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 03:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169B01881A62
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681A7156F5D;
	Sat, 15 Feb 2025 02:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oEL4Ke/+"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31A315199B
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 02:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739587408; cv=none; b=OV4wvNAWl377X0C3a7k4tnr5x47vHcRbV5Ew+djTZvtIX8zLhdEFclh7gTbXiCq+qpWCcHa8+GISR+eeE0BrC729xrAwVX6ZChPpk4THaecYQRNsKdgq2vvTE8VnSbVXXxG60J72az92NaqqSUhT+n6nlC1x4lDKrZwVqQy/dms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739587408; c=relaxed/simple;
	bh=9j/9FIaaWBBCwyXbC4atV4Cu86L4USLeemodl+MqRFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=T58BlWFNMNLxZ/ZFEqf9HWEhuLSpDeou9SpCXCUgJ4kXFYy/nFyw9JvM/9ZoP/Rr7proXsHn9ULU8iO5+DJuvlwaY6n12oAgen2qRqM237DDLc2SbqTh9WN7InEelNg8I8w8QWAv7sRT9Bni4whV+GU5HiQd8uYsghclQ+31LHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oEL4Ke/+; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30762598511so27448901fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 18:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739587405; x=1740192205; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KsytpkeDWch9OOUacWu/ahBywG5zzK36WOiur+uJ4is=;
        b=oEL4Ke/+0MmdCcg7/qGQrHy/NrpaBmxnpRQQw20FXXx6xrIlQZmn86+i7K60uLq7ul
         l1Yu+ARoq/zb5oLsNzi1V7YkSx0K1cksBcjRGiVHsXLEoOf9HZYX3i4YcnaGdXcU955/
         csrrf4eC54NbYdQGF5P7S6rj8P8mJrlqb87Cuuw5E9T0+XVudnLFdRF9DMsQRnDe2iI0
         NKUsjY7Z9uZDRxTNg5MnAqisoKyzj4FJqBdoQHaKqsk+2VBz035Euug/o66mK3ZtTXIV
         tV/PqCHdfFSOAm42UCs4tdhBI4z5Mtp9nIdJ+OT6Jy3X3AVTxRUASMUVUW6rpygf2PQm
         MA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739587405; x=1740192205;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KsytpkeDWch9OOUacWu/ahBywG5zzK36WOiur+uJ4is=;
        b=epQIo7K9aV1vdja1vqBN2bDMc9VrQSBGHvTVL6BdKSHA5R0kh80SaXb/y4uvgKGYOs
         tjsoEH2n9k+F+u2y1mIW6K6OZ+UFvwVMek/xcZRhcOhhjHZa/B9LNHF/Z80lhBNcb5v1
         vYKSIZv+Kk//ntg9CI2ofvHRZ8f+FX92CbWNDEAvFO6OaA0XVMbFVc/jbrTuvdUrh1p4
         DrkkDnC/IAZh4kEBKY4tZMWBrOa+d+nybEvlw3cLonGUGA2PrMk7HccHAZ9L9yKTIV3p
         0s/Pn7pb6zbqqOjnG4qRzA0yHBHdT9M3Pkgcn71mAP0FaErhe7VKd5INtJJH+ntETiiB
         Lg4g==
X-Forwarded-Encrypted: i=1; AJvYcCV8595c22Fi9MMjxy2zBJyA4pTwIgcT7JNtuVnqRtzSV/Fn1mbUIlEbUPw858xShSLjluQ4eOEuhmiWqLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YymxSQ1uR2pzmKkLKiKjJOkut0Z1QRsUuJi9426JOskzchbSKew
	b6x3RGxk4cK/MOLodsoRPK7+PELe0taHhhhCxsTQTSoNR5WVzDAnJbqEFGpArhA=
X-Gm-Gg: ASbGncvtG2FKGVP0BdjL6RFbdhaJhNaYAWTfgcnUMi25lt6PItaEQm34lqFtwLw0Kzj
	wEI3jxMSnUEPfMrmNkTsrXwZ3iWW/gd0pfgfXC4BHxAnD5Iolm67BkPbRnmHY+LQR3zU4ssNWTi
	kZaCHUAzimP1oik1XtoCxhtzamAgaKNROvXQBLxdhiLrPSv3duvk1qzGV5heMM+bVSgUcQ3mFLa
	w4XLFSxpgcoCKz7jikNzNqg9casOs3J5jPx2ZLhPw9aTenbfa4zXNNZMMvRMm2w7HQhIeenCJgz
	3FBXga73JZ4T6GrLdywVZv8=
X-Google-Smtp-Source: AGHT+IH7WIIVkhfGtPcFAsIIJsecPvX1Fe9bGVWlnqNjWhLb/C0tLsYzYgcbeTOXetDPY+4aKQlAwA==
X-Received: by 2002:a2e:9995:0:b0:308:fac7:9cc9 with SMTP id 38308e7fff4ca-30927a474acmr5962741fa.14.1739587404031;
        Fri, 14 Feb 2025 18:43:24 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3092937d001sm1242681fa.16.2025.02.14.18.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 18:43:22 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 15 Feb 2025 04:43:16 +0200
Subject: [PATCH] arm64: dts: qcom: sdm850-lenovo-yoga-c630: make SMMU
 non-DMA-coherent
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-yoga-dma-coherent-v1-1-2419ee184a81@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEP/r2cC/x3MQQqAIBBA0avErBsww4KuEi1ER5tFGmNEEd09a
 fkW/z9QSJgKTM0DQicXzqmiaxtwq02RkH01aKWN0p3BO0eLfrPo8kpC6UCy2pihV8GPHmq3CwW
 +/ue8vO8HOScBEWMAAAA=
X-Change-ID: 20250215-yoga-dma-coherent-ea255630fd7d
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Konrad Dybcio <quic_kdybcio@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1369;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=9j/9FIaaWBBCwyXbC4atV4Cu86L4USLeemodl+MqRFE=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ/r6/54dnr1tQv5Hi2KWSflPi8nUc/gW4ffS9DazC0vT5
 D3Pjsl0MhqzMDByMciKKbL4FLRMjdmUHPZhx9R6mEGsTCBTGLg4BWAiL4XY//AI2jNvkTrgP/ee
 CF93pnJNzAJtpdtKhVHWdyzM3121fv5/Wq3fv8zi2u2zU6qT79V/1n+mrNEpoPm7bdPR62FvfBJ
 K76Ue/fvg2SHujJpPwa5xLGZ2d1W1f7xwnzX39UX2r5rFQjrTLh7wTe7/It1d/kLlRc/Oxc2RyU
 oZH5tKlzQwmLVEFpYHldz3nFi/c4bfvfi5mnu1spdVRUnfKIm0edY+U4Zn0rNJeQL3d234s+3Lk
 amVTXoTD5z/5eGwQi7ARK9R2/7yZ97tJ5i+n6x1ST277WthxlRTgQ+mwXqN9wWlhUNeXmtTiZ3u
 UDnrV+SWemZ9FZmLGdGFG61XvPX5ZMCh1c/+4WGO/WZNAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The commit 6b31a9744b87 ("arm64: dts: qcom: sdm845: Affirm IDR0.CCTW on
apps_smmu") enabled dma-coherent property for the IOMMU device. This
works for some devices, like Qualcomm RB3 platform, but at the same time
it breaks booting on Lenovo Yoga C630 (most likely because of some TZ
differences). Disable DMA coherency for IOMMU on Lenove Yoga C630.

Fixes: 6b31a9744b87 ("arm64: dts: qcom: sdm845: Affirm IDR0.CCTW on apps_smmu")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index f18050848cd8892666015c8182971ff0567747b7..67a60ec33e8cf701a672696e7c7bd85120950441 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -342,6 +342,10 @@ vreg_lvs2a_1p8: lvs2 {
 	};
 };
 
+&apps_smmu {
+	/delete-property/ dma-coherent;
+};
+
 &cdsp_pas {
 	firmware-name = "qcom/sdm850/LENOVO/81JL/qccdsp850.mbn";
 	status = "okay";

---
base-commit: ed58d103e6da15a442ff87567898768dc3a66987
change-id: 20250215-yoga-dma-coherent-ea255630fd7d

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


