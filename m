Return-Path: <linux-kernel+bounces-512921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A102A33F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A49188BEB1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93562221572;
	Thu, 13 Feb 2025 12:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mhozXbqv"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496DC21D3F7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739450238; cv=none; b=D48TCi3MCGKq9pi7hJPHxnIsVGtKDxYCvxfdViBuOypp/a5btrXQBuByBGi+X+B0N7ngQd4I0s1JjjJtF4zNNFCmXwPhg+bid5ZItXiXpG3FNHr2YnCKQu0P9hUZsNCOKLTqT+Sq4N96S1uSiztmBLhLzBQwC+1KIsPJ963HzMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739450238; c=relaxed/simple;
	bh=fW7sAMZGzRYFL3koODOtSKxG2i5kLbxepRPq763TAis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uzh6+QQ6aYUpcwb3O3CpipKn/d+3CQbfM9jJEBsjHDpT5XURhL9bDAxcUY1QNVpHoi5/BClaVNgXvXmlTCgEW101pm4ABy3CtImKBgxC9A+K4C6htCJBACwMacHBOEyWyxPjfgi5MLm964Yaa3VYOCRVEYSyh7c1+pOQLJvu36E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mhozXbqv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-438a39e659cso5682325e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 04:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739450233; x=1740055033; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7TJDPbYKYTh8WSIk+sYTlBV8pwulu5n/wnEdfyFCUrI=;
        b=mhozXbqvvMzdCLQqxFj+58mnr1s/1m5HGlN4V7bbQK/nRrf8H2WM7FfaDunJpUsWon
         z9rTuo+NlacAOg/ilr1m3L+KK4Loc7HopJms4QABqx1jNT29Li1bQ3XnvbuN2jVKvdQ+
         16TXEvCufIDNmLy4qiGKVbgb4txhi5+vIpYNpcNwxvtrR+fDQAsnANbJCYmcjXhTF8vG
         T2rah8ZAtfq2ftzJMxYQghOlIH0arL4YOMgHDvSAK40xY2wTA/o+miqmlyBYeOOLYj6b
         9/KUbEwt+chalqSqe1jqd8F7zBq0t8XA1GwR/UrbzQ/6b66qhvO/l+pKDTaQgRVmSdME
         wQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739450233; x=1740055033;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7TJDPbYKYTh8WSIk+sYTlBV8pwulu5n/wnEdfyFCUrI=;
        b=c4MRx9+OeF/v2c+i8lz/S1p5EvG/W3M3KzpIYgKA5ZP+il4wLdFmZ6iykBceKO2swp
         p6tzKfyijkOuvjXXwtiVcLUtW13FpgkEeo93W9Oxo5Ocl3XhFSzypWuXq/jRYoCmZK6o
         9mD+wPMKf+jeowevbEk0va/V3M0LfP+EofnTMiAVaax5Ww+yzbquwE7rmwnOCl0gdF3z
         XCCEPT7vGgkI2jxPqD7oQnJFFBboeO150U+WoIEr4O0EW/AiXvJ5B3GOnfP5ABQSBw91
         ZWIqNld9hO046muhUHIn1ditUTD5NME8WTBBk6MiAMUS/zhMtsRL2hRbUX8WNiZn4zrH
         ByBA==
X-Forwarded-Encrypted: i=1; AJvYcCX8xjrss17pvD1e5ijLm4RSGyeJHg7nHb3LhlHslhwQZEt4hwY2OtXgRpGXX1pMZ4yAlIlIDuijutSfV+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5P8T8c5h19acZ6OrLGD2hCB8KBzxmIYAtq4/0aqu3OMP4ROD+
	tJjNXFbPBjUFcCJjA0aRkXIUwxMJNIzzzs/cDjhlGViHB0l3Jcp8DhdUbsNkADI=
X-Gm-Gg: ASbGncsjLdYzDykYM8DuHJW6iqnQswwrADm9ppaiazVjQ8s5m6bYR5kPosyw/4npiEo
	bmAQfUcsgLURbZ2zFV+j2LUgSze7Fw20B3oYKtx/A4XRHHw0c44V7X6eN5TgE4zab5RbsgqLap0
	Dfty+xwwDPcxRkJKOKMquNCzheDA5n6zg3iLS8iL3Fl/tOrIBqItszJwrO+ovMpOTyXtyfkGUaW
	fcfApL703ScQ9yAS6juzw6/sbvhapyJcErdo+5HZDEG91C0diy586IFbG5P0QA4AHUtmpnVx3oT
	EcGci4qZq01radg=
X-Google-Smtp-Source: AGHT+IHCnSIDPuuaeLeVFJyMSspPK+FKiAXgRR0sKtkEv2sUasQGTaTDJbYx14VE6LnD8+r1DExYHA==
X-Received: by 2002:a05:600c:1603:b0:439:6003:8ac1 with SMTP id 5b1f17b1804b1-43960038b11mr34177115e9.28.1739450233560;
        Thu, 13 Feb 2025 04:37:13 -0800 (PST)
Received: from [127.0.1.1] ([86.123.96.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1aa741sm47161495e9.31.2025.02.13.04.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 04:37:12 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 13 Feb 2025 14:37:05 +0200
Subject: [PATCH] dt-bindings: crypto: qcom-qce: Document the X1E80100
 crypto engine
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-dt-bindings-qcom-qce-x1e80100-v1-1-d17ef73a1c12@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHDnrWcC/x3MQQqDMBBA0avIrB2YSQmmvUpxYcwkzqKxTaQI4
 t0Nbj68zT+gSlGp8OoOKPLXqmtu4L6DeZlyEtTQDIaMJcMPDBt6zUFzqvib10+L4M7iiImQ3HO
 YODrrvYX2+BaJut//93ieFwxE/ChvAAAA
X-Change-ID: 20250213-dt-bindings-qcom-qce-x1e80100-0897a1f85bb5
To: Thara Gopinath <thara.gopinath@gmail.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=976; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=fW7sAMZGzRYFL3koODOtSKxG2i5kLbxepRPq763TAis=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnredzuhOx0PfCHwYpuKRbzHl5QJnhG8uSM+zpk
 K3xJEniYsWJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ63ncwAKCRAbX0TJAJUV
 VpNYEADGwFG5I95EljWZkGby8HB2fYaHTw0zMFf0IZ7940Kn+aCEECtUQY4sOe15R6q5ez+TmaD
 b9LpSCttPVAnoK+e4WDvZkYyZRGJdBPyxZTff9raXGpDR2/LptFnyAw6xbJjKPB8clDX5rQzSBr
 w+bGpGaPGk5zwkkIxwUWqPfMqXibCLadauy9r7dCxylQf/lasQIN9wDaS/dPzGjkSfi6It28Qms
 h+rk24sxs6iUigfti3scl0YCV26SPMAu3dJbDH1JW6OLJTDE7lS8R/mB4hk4HCZp/xdrP/jXxjB
 d1JJ+4n0rffwqNFf/AxoFBdqUWC1mRoajBtrZWgJPs0MP9rrVrwOCNC0510j78AFPoQG3iByleW
 gG2ld8ITyJcicpBdGjvHPvEYO5QcYJx0xVlexhPSBTJptWTo3Lf97bmC8FHT699R47A/buvRfr/
 aSY2xu8/bWToRhUCc9UGBTi5CsGKMFhHvoHe3sJ7F3d33eirQPTJomrAeuU044bKpSbXeYCPE+/
 fCmB7Uu7xOhXHyu0iJJqupevlfMlb/l9m4LekvtpO5QaXj7LbCGLdbhueiBP1TcLLt2pe/yD2R2
 N82iPVR7+ycDuXnwyQRje8heY1VtxmN61+FqoFgCVm8nEq2XJbZSsYSmU2HdbXI51/Equ6ArtHJ
 FFp49f6WbXc5fmg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Document the crypto engine on the X1E80100 Platform.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
index 3ed56d9d378e38a7ed3f5cd606c4dc20955194f0..3f35122f7873c2f822772e091cf61814bddfb892 100644
--- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
@@ -55,6 +55,7 @@ properties:
               - qcom,sm8550-qce
               - qcom,sm8650-qce
               - qcom,sm8750-qce
+              - qcom,x1e80100-qce
           - const: qcom,sm8150-qce
           - const: qcom,qce
 

---
base-commit: 7b7a883c7f4de1ee5040bd1c32aabaafde54d209
change-id: 20250213-dt-bindings-qcom-qce-x1e80100-0897a1f85bb5

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


