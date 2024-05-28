Return-Path: <linux-kernel+bounces-193059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E1D8D2647
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07F061C25BE3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC35F180A87;
	Tue, 28 May 2024 20:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JV7oX54l"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7554B17F39B
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 20:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716929027; cv=none; b=pv0Ga7FJtUOCEPs+MPf9kxZ/RtC59gOQMnS0MxAh2wwkQBYvWdpDLuP4pqZD2CeI1fXU7ZeO0dmTKVfH+CcZ2qew/2a5BhbWf8EnTy0UtTcM+E/czMml2K+6IM3ZfySin2mi6yF2KaeE7pOCwTyLlkBu560hNaBOBm1WlzaXo4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716929027; c=relaxed/simple;
	bh=rRrgn9wRVOiElWPDaUjrdPE8GcJ80QnHEQvUPT4yYv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RTw4P4+CvZZaxsYdf3r7FJzZeN/3s7F+bOpQVA/dBBx3cCkow4C3WwM3RRbxS4Y2FTnbxRbmikPak7dO0r0cFS15r7aYSNy9VYcHGGoxejegklo3F1SqV32HKc2f3LLhsaL6aXduKzU8QfxBmhMA0Y7Dtr42FW4CroyCtInxWIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JV7oX54l; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52a54d664e3so141604e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716929023; x=1717533823; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X52tPGcJvxkBvOLIf8hl45B+JUSUGh3EW6f1yVnQtag=;
        b=JV7oX54lfTDDeX/QFYuoMLpeGRpO/g0Xt+kUD8Xjx+x5QlNmXxmbtzA/8bBP8Bybvh
         mZd0/ZZLVZKYc/ZV9q0bcLx/MwwwTBHRKaHRtBfpGtJTDxjpS55sZHW+F4AwzgNFwoME
         a0O1PLgAFijdidQaqpvfcZCxo8VHmVSYAyLMD0jsgrQosYtpmByMIfLZoc6TcYhTJwgk
         oNGwbpyaqD/GCmw4ntR2k4or3z/xTLGLZA/eteCufJEZI+UAKMYupV+SH2K7cyQuQMXs
         Fhevf+wZZ8EJHATtobjdwZzcUjiNsP2qovio5IZsfG7f4cSdks2HUlv7n6H4aPER5Xzo
         OtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716929023; x=1717533823;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X52tPGcJvxkBvOLIf8hl45B+JUSUGh3EW6f1yVnQtag=;
        b=Ay1DGDIzKtx/bq/R4eSUjVTyYXdbJo5vFrM7dsz1E4wYWkxO5OzN7ZzbHS5zvVjscP
         /vOgbZsnjQ1lPUseuWkc2Dfh+5BILJbVXqZdxipgSPy0HB4owiEKIg3I6QYAaI84eVvH
         VdhmEiFK9W7QlExkNyFk7lRs+e2Kad3+ICC4A4UzQNKrt288tiywpoNyVxgHT9iuI/c1
         Ar2R9cCEkC5+GszJ3pZowZ7rWa29He6M4gNYfnkcQdVJhkND5vhjerOL/13fCr/5Oav2
         H3nGTLcHTghuG9cm0uk9IpCC+5E6LiwdvKrkZmLHILfDbIJn57Mhc1Di1PRShZgU1EsS
         nb4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdfRJ7/IT1U9+naaCo8kwxOHE+TNBp6ubrQoleUTItT7EGoh1boI/qaKrlN/d9Z0W4WJZDfINwFbuP2o/5p/vsWeJDsWRuaYBew6X0
X-Gm-Message-State: AOJu0Ywn+rySZGm6/lGaYNzLG8+asfcR4QHD2YzoVEcIx+xTn4ZksSUO
	n3lXOTKokEuYoaQWFOISp4LgLgNZUxr+9AoEs5vSRIEFBx5iuYUieP623FRQ3eA=
X-Google-Smtp-Source: AGHT+IFbe7p+EQIzfqeq4PnVAxbgwkiu5PKPhypWn5tjT3BDKPkFXa8mSbXVwmAVy/Oaom36iOg8qg==
X-Received: by 2002:a05:6512:314e:b0:523:8a14:9149 with SMTP id 2adb3069b0e04-529645e312dmr7316650e87.21.1716929023660;
        Tue, 28 May 2024 13:43:43 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5297066b885sm1095493e87.127.2024.05.28.13.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 13:43:43 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 28 May 2024 23:43:28 +0300
Subject: [PATCH 10/10] arm64: dts: qcom: ipq8074: fix GCC node name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-qcom-gdscs-v1-10-03cf1b102a4f@linaro.org>
References: <20240528-qcom-gdscs-v1-0-03cf1b102a4f@linaro.org>
In-Reply-To: <20240528-qcom-gdscs-v1-0-03cf1b102a4f@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Robert Marko <robimarko@gmail.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=737;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=rRrgn9wRVOiElWPDaUjrdPE8GcJ80QnHEQvUPT4yYv8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmVkH2KRsWKznmCO9vE6RpVa9F28gHt5jZW2nn/
 CMHYqvZmUqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlZB9gAKCRCLPIo+Aiko
 1aMZB/9tb42U5p+S9rDmbixA82N1gxWgZqdAzkzsHKOfMFWqAAZJsotTgQbXdtIPfZt3Q2yQRIM
 PZ/DvL0YdHIaeSTCPx/SbMsoCrRhyw6YxO7liHOhxm0Erm1/UGrolq0wIm8vIy49ihWjGzw9jLG
 0edH58DmLi2AmBpE1K3+py9Qnj4dtTvCPknKDanjMFS9ZB3UPdiGXMIdPPdgUqQqQBPAhqP/3oy
 xTndqqBNmGSMddfCMGhp+4gmtr383Cammm5ocoJEiv153l0dWCJzj+6JAVBcNvYLqJe4/FPgqkX
 aWfGGlXh0SOp2uHS+fsHgy9AnUMlqDq1ZVGfbiB7s25ystlt
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Device nodes should have generic names. Use 'clock-controller@' as a GCC
node name instead of a non-generic 'gcc@'.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 5d42de829e75..27cf8d50f254 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -363,7 +363,7 @@ qpic_pins: qpic-state {
 			};
 		};
 
-		gcc: gcc@1800000 {
+		gcc: clock-controller@1800000 {
 			compatible = "qcom,gcc-ipq8074";
 			reg = <0x01800000 0x80000>;
 			clocks = <&xo>,

-- 
2.39.2


