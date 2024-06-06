Return-Path: <linux-kernel+bounces-204122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FB78FE480
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B161C23EEC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE917195388;
	Thu,  6 Jun 2024 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LUHKA9oI"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B29194C7F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 10:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717670531; cv=none; b=a9wZBhODdXfzM/KBKLmos5M3+0zJb+IaiuHHECe1SRLijn1U948uPmoi2MjdG2LZ0IZ/yS3GuqiRNhMbz9IArTR3iIJ3me1AHIFjDHJPNYljXRexorXsvmC+9M3yY4kb2vxrATe85uryrxIBDye19Yj//EBOWshrKo/jD9sTjrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717670531; c=relaxed/simple;
	bh=An0xem+v30MD+yvMR7Xg9gPbSXxhWMS6dug6ZfUDI84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nerUFFQuIMI8Q4ufo/Mo6CBNKGcpw/pVXZuh9B/FmXv3PS5l4h9e8d2r+M7KK0jzDsQFRkCdcEzhcu+rHktKvCeb1a7edp5lvg2Ma6o8hODG0nAyrJV4YsW+JXT3Ks6oGZuq+APdZ7fnvqgGdEZmSEp2dvaoUWGpmrta10XL1hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LUHKA9oI; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a4d7ba501so844409a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 03:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717670528; x=1718275328; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zpeFn017Q1U5L13CH6jXgmUXbUUD3PoX+619nEqpGTA=;
        b=LUHKA9oIaicM7K0hiWOGC1CugzH6mCTGAdPPXV3tYYuMJNoju4PEoVJD9twFhzXs13
         n1kXU6kqA6HgUvEOCMGF66woEzWfIYtjUeRZIa64A1vGy3qxFTR2CHM1F1jV30zPqF7Q
         7M0mZMrPiuxVg0nsUGpvO+vToLWQ7GBKsqB3Q0E4HwfJ1PaYJEcOAmC41yc7+HgoIVg6
         VGYOKH4hHyeZht8opL0pZDl6T7W7Q5GHw0mwJtKrG/rL4Jpo1ErSeycsAfYZgkMu1Jpj
         U1PfdOBl2cD6DKxyk9SSLkMFQUMJUBJw7nVsFOHuzqO1cu5WeVzppskawLF0LJGSc5NI
         xxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717670528; x=1718275328;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpeFn017Q1U5L13CH6jXgmUXbUUD3PoX+619nEqpGTA=;
        b=vrITZyhzELaCwDz0ieZz+SD7tWJ/Wn/IJAPSCuOoA8a3ExwYnBsd/TGMm1UaM1GaEC
         PQ3QwwWqigJjwZNmPwGtEtRgJzzqeCz+Q2PC1FHOosMELVQp7iCaGT3kbCBbk7IJgdjH
         OkL2rRH+pbyyOijKHNhoG9MTnVBJhRlmi/vvLhxAcSXc6U8ID6Ye+mwuqYRbyMXOpcr/
         oAh3g8or2kuZyMMwAWt85wDTjQB2Ga8F8pzIegKviS9pV5Vf05Hmq/3AdtTHdzck5XGg
         JuFWWKMleZYiJQi/ZFBZGNRnoUnNw/c4dzM6zbZaCNO3qPbvVWGwYRsVcwMJqOHfEY6h
         gVrA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ71FTT3io8PXhCiic1c5uLUGLC2HZ/RXYxGgKv4g+jTm8Zsam8+uMfeG7+6E61DE+VZ9JgBzcmHzxGkGzRmU3MzLzlApCmHt0bPM6
X-Gm-Message-State: AOJu0Yz8gtVaKQqEEX9MEQo/aK9h5qT3Qmb1wSfGDvMd5iUAd+3vcdKi
	YBjMgOFA7XQB6ioOsvMaQ0BhpMSZciHVMWnLVaJ++9asBxy3ZB0yjVQIRd7R2JI=
X-Google-Smtp-Source: AGHT+IESr0UJZW1T4o91KuIYjr/YU+ee5zsNo/9ERPhUt96slwRCDf/E7Eh9toC1vZ8SzclAV76fzA==
X-Received: by 2002:a50:c2d1:0:b0:57a:2abb:9e82 with SMTP id 4fb4d7f45d1cf-57a8bcb743fmr2570169a12.41.1717670527721;
        Thu, 06 Jun 2024 03:42:07 -0700 (PDT)
Received: from [127.0.1.1] ([188.27.161.69])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae0cc36bsm871477a12.26.2024.06.06.03.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 03:42:06 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 06 Jun 2024 13:41:52 +0300
Subject: [PATCH v2 1/3] arm64: dts: qcom: x1e80100: Add remote endpoints
 between PHYs and DPs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-x1e80100-dts-pmic-glink-v2-1-972c902e3e6b@linaro.org>
References: <20240606-x1e80100-dts-pmic-glink-v2-0-972c902e3e6b@linaro.org>
In-Reply-To: <20240606-x1e80100-dts-pmic-glink-v2-0-972c902e3e6b@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1541; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=An0xem+v30MD+yvMR7Xg9gPbSXxhWMS6dug6ZfUDI84=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmYZJ5gMK61+359XUpvb5WAC4wQf4rQ8N7/b3P+
 pDqmHeepLuJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZmGSeQAKCRAbX0TJAJUV
 Vk6/D/9/eiFaSp26mKepaWqP3uUxe5Zl/lyYYuEtR/tZvF7ZFd3l1699gsxh8P4RRmBi/bsihze
 +cD2bhs+GSJMVREvXN8cb5Tm4wUh2rJBDSAiDnyfhOE5IR8zQbxblHXVkXOzHHeTH+3AP+d9VBm
 9eA74BXBCc0nJJCWRU7A37foJl89n+WuCrdsEmkbqoO4DPoc9Hwa4k7y42nfkHhgH8qKKzoznpV
 KLOsUtLJtaNbf6ieWPp7sGWr0zCUv/0mVDD5I4PFvBI3flROcu9PiesAtzwBTMotxqQGis5o7OV
 i7xVZLhqPPo/EUWEasaZWEWKbQa/Ty+QXhY4uoCROe6QEtWoS0pMXBi4PTbrZ64M0WmKNMywD8Y
 YRJ5VKAWlPsD45Fh4H5pAsro2/nTJRX6yqEsqm0XYI+mHpqRL2pWYlWFauiZsYiIUEFgJEW+b2w
 ZywO7bjZJH4bLqgWCFzZd33AchYTYkPriGmYvPT2jUc59aw3ysNBDKsYqPl71rFTyYvTLpC1S3G
 gowMl/TuQFLgcebD4eFhwEsht1bZFMhfOaM4OahvPh4MQ9b062r8YimebUbmvFdHlaoUb7cZEYe
 UEWvp6Hb4lr4H8j5LnFFWrCyBUgVcPxDSJX+m+j1stkdTDyo/qULEp8YcwosdGIMTu065Lr1R+1
 5bDgY04xhTpzFQw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Describe the port/endpoints graph between the USB/DP combo PHYs and their
corresponding DP controllers.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index cf8d8d5b1870..e275a2a04add 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -2567,6 +2567,7 @@ port@2 {
 					reg = <2>;
 
 					usb_1_ss0_qmpphy_dp_in: endpoint {
+						remote-endpoint = <&mdss_dp0_out>;
 					};
 				};
 			};
@@ -2634,6 +2635,7 @@ port@2 {
 					reg = <2>;
 
 					usb_1_ss1_qmpphy_dp_in: endpoint {
+						remote-endpoint = <&mdss_dp1_out>;
 					};
 				};
 			};
@@ -2701,6 +2703,7 @@ port@2 {
 					reg = <2>;
 
 					usb_1_ss2_qmpphy_dp_in: endpoint {
+						remote-endpoint = <&mdss_dp2_out>;
 					};
 				};
 			};
@@ -3993,6 +3996,7 @@ port@1 {
 						reg = <1>;
 
 						mdss_dp0_out: endpoint {
+							remote-endpoint = <&usb_1_ss0_qmpphy_dp_in>;
 						};
 					};
 				};
@@ -4075,6 +4079,7 @@ port@1 {
 						reg = <1>;
 
 						mdss_dp1_out: endpoint {
+							remote-endpoint = <&usb_1_ss1_qmpphy_dp_in>;
 						};
 					};
 				};
@@ -4154,6 +4159,10 @@ mdss_dp2_in: endpoint {
 
 					port@1 {
 						reg = <1>;
+
+						mdss_dp2_out: endpoint {
+							remote-endpoint = <&usb_1_ss2_qmpphy_dp_in>;
+						};
 					};
 				};
 

-- 
2.34.1


