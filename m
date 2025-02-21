Return-Path: <linux-kernel+bounces-525799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C24FAA3F592
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB8916848E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7062B20E6EA;
	Fri, 21 Feb 2025 13:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DxGCo9oh"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D225220E310
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143234; cv=none; b=ohKGLdcmD/8Uksn8xApqCdBdLFqxYVSQWUCbNxMCXs8PXIprK/eGaL7PuXl/7wDj3JEwj8GSWskj2Izx/FE1ATJME68uOEEsjga3QzSdNyMksmudBq/dlP3Oq7rGW/L6Wx5myui/s35SN8vqr5MqV4wgemjA/Ho7H9m2M7UrsR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143234; c=relaxed/simple;
	bh=Wuq8PZZqTZmX+Wwqcw5TIBdEiOB/HRphCwfmFoMd2sA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uQvR5vKyc9qk/EGbFUrAxvU5rGnFSUHPYU1eMJajHlTUx+GevDxcEygMo6JI9SYZ1zqKJcib2qf1uI8y9NL9aQzzZ3fqoPgT+Mf+lI/fohpKSYSzbKpfH0KGhj5+hvjd+Am6mfkXNVM70Io30+sndzPjCgo3ylijTjSqDF82osk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DxGCo9oh; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5ded1395213so3593470a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 05:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740143231; x=1740748031; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J2YtPHkWiqQRxoGi/rdnAG9zWLBdEYwphfKc3zJwkgc=;
        b=DxGCo9oh1mPhg3jD1Co0IFQ+sQtK1LqGv5AhkON1RP9il2E3VCQbCPp1hsyvHqtpGn
         8O5YykFcq5VbeHVUQsXJ5pkHNqxLKpzmeCfu/DtmqOoNS0blB9MyOMdQoGDh1kQ+BDxl
         yP4P4N3PZTQ6/LlORZjqZHFhMidaG7GZctDih7HrcckKgVLfbQxQaGO41EZKAltKmxDX
         Siz0h17xi7yRr5ULUOn/fMXXyCydbEZRZ/WwZmn5LsJzVSDJdpspYUf8icHJ3jkSJW6M
         VvhiP07Jvadn2W/X0wsIc0h+gwTPS8wY7rsa5yYwDGPHDwIvjydHmqpRiZ/L2h+d3CUH
         W4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740143231; x=1740748031;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2YtPHkWiqQRxoGi/rdnAG9zWLBdEYwphfKc3zJwkgc=;
        b=C1C6fg0245Qk8L5UOwJHocPK3ero/GbbwEC1nfAhRk3k91INHCntYgqhYoyT/RMKAe
         HWFa6T7KyxTec+36xXXSTf9wulN9wIqbtU9hZXx9Q3IlX4rhojxPswMHVxKirBbxJLsh
         LdehAR1WIqf6HYvdzBg7L9Myt1sdZUAEKBbiRHCHCWjjx4UtKSy5MICo++s58Yf/DmsB
         Gr0enjH2MhPEYun4i07ZUZjBtROG4m58qzZsYsUKk25ssB5SlRYlmbLJp7/N877eEVds
         UGA39livwaL03D+tMM8f2ssVtWcqLHv8fPiR9Lv9uI8z09IVnvJuNWyOK5pPiYvVO6h1
         YU+A==
X-Forwarded-Encrypted: i=1; AJvYcCVXnRoe08IrinbQyqIpuMktonu49sDJ3vmzW4HfNYA09FuSI9TwM0FbJYCf+wjV1IoHQRdR/xle/VlkEIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBu1pd0y5oD0Tj1w0XbslLj/1BHpxP4S6PozevaRI/WsEKNvcJ
	pNHQkXK4MRW5K8SneF6Zf9biv/owkGcXequbeQWJcWU1cFF93Hjrtnxk9yl0Zv0gZQY4rAC+G2L
	3
X-Gm-Gg: ASbGncvJXqo30wYzJACqDUKGYUWm9gFCsZfs8dFrBdNfgwjWF5LSp2ayDCSWM4CUUw0
	5WzmNNj6iTFPtQi+iyp+XFjM1C97Pzh3eS72j6F7LlwO541lOGt/CJn3QULIY1u6dEXoUFoAuL8
	oPCiJOA7HIKUl6RM5vwugQSKmlm3UzY+ylkqOU7qMdDS3ZdK7PWVf+vS3xWtK0iG82IiS0j0GVM
	BNY96s2jGafKEs6j7EUYrOf3LXsQABq1os5Jji5hJZwlaxCKAplJeH2HXb/eA0t49woEFDUIVFz
	rCm4c7AUMwJW2yo9d3Ev9fug
X-Google-Smtp-Source: AGHT+IHdJRh7VHfi6YJp00w6m/VTpkjx4C8wPXol1hyTtGE08K0yf46cIn67ahIdjvnZFNPq3S7ylg==
X-Received: by 2002:a17:907:c2a:b0:aa6:5eae:7ece with SMTP id a640c23a62f3a-abc09c0a5bdmr293895566b.43.1740143231091;
        Fri, 21 Feb 2025 05:07:11 -0800 (PST)
Received: from [127.0.1.1] ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb7a04f8e6sm1236944366b.177.2025.02.21.05.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 05:07:10 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 21 Feb 2025 15:07:03 +0200
Subject: [PATCH v2] arm64: dts: qcom: x1e80100: Add crypto engine
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-x1e80100-crypto-v2-1-413ecf68dcd7@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHZ6uGcC/3WNzQqDMBCEX0X23JRsVKo99T2Kh5AfXSiJbCQok
 ndv6r3Hb5j55oTkmFyCZ3MCu0yJYqigbg2YRYfZCbKVQUnVS4Wt2NENEqUUho91iwIH87DYGdv
 1I9TVys7TfhnfU+WF0hb5uA4y/tL/rowChR9b7a3takm/PhQ0x3vkGaZSyhcHU+fNrwAAAA==
X-Change-ID: 20250213-x1e80100-crypto-18c7d14cd459
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2208; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=Wuq8PZZqTZmX+Wwqcw5TIBdEiOB/HRphCwfmFoMd2sA=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnuHp84Tk7fzBMY5S0/WNJQgiwVjS7hHLmH8N30
 aH09c9PJGaJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ7h6fAAKCRAbX0TJAJUV
 Vij/D/97LKM8GJDdE6GdaC7MoWCBjHqr8im4hqWkGlBzMgpdIl+izdMUvR7u7UfYFff3//AxD90
 eNrJLcA0L8AZ6jzuFEDThwIT8JRp8smjpJoj5BVMjLbCzFEfI8aQ3iVUpQXm4ur7liFBNQLfXtz
 bCvKih/9O104PsgdIqHlQkSE13FPUuZ/R617HeH1Q+X8RYUrxEmk4amrZGEFxeJhF/cYGZ1E/8H
 vStRU8Y4D8n8Y2CnPEOMBxM733UbH3TcT4gYjKfYZGKYTdYf+IdVszCyyL+gxd8KfSQPkHTn28M
 KZrS8PGWdZEU1h1IDjFP//q4EiYHMbHEXCf1/9IY9QZhICXLDzPqRIeth+QkS3X+Cr/6yfIYnZ+
 5uxenP4Ko0vG+0LDoSQqSN81BymdIvylxbmjgupnCcqCkLzLPfF8DE9fmjqgmAgG/RMoX3cWwGs
 Cv+bpUFwOr3zoypfBxCtrtlFKx9lUlgCCQhgZvxS6BszEJqt1SspgjvLfIS7KxQXhquTxzHRKI6
 ik2sWRuNDB2QWvxvu0/Kkwe698jR0kXlUFskoP3wUkr9d0+WjNT05FD7zYSlxoLHe3jwBWmz/ax
 n5y2MRXhQ4BlSnabw/qxVAhf3UxlecOsJ8Qfc/Bq9NuQQBMaUaxH+I8AKMM2Zw+DF5YFXlnEyAy
 RMSYpfS+F9PoABQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

On X Elite, there is a crypto engine IP block similar to ones found on
SM8x50 platforms.

Describe the crypto engine and its BAM.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
The dt-binding schema update for the x1e80100 compatible is here
(already picked up):

https://lore.kernel.org/all/20250213-dt-bindings-qcom-qce-x1e80100-v1-1-d17ef73a1c12@linaro.org/
---
Changes in v2:
- Added EE and channels numbers in BAM node, like Stephan suggested.
- Added v1.7.4 compatible as well.
- Link to v1: https://lore.kernel.org/r/20250213-x1e80100-crypto-v1-1-f93afdd4025a@linaro.org
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 9d38436763432892ceef95daf0335d4cf446357c..71d5f5eed4511030a51fb12e453f603d294080cc 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -3708,6 +3708,38 @@ pcie4_phy: phy@1c0e000 {
 			status = "disabled";
 		};
 
+		cryptobam: dma-controller@1dc4000 {
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
+			reg = <0 0x01dc4000 0 0x28000>;
+
+			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+
+			#dma-cells = <1>;
+
+			iommus = <&apps_smmu 0x480 0>,
+				 <&apps_smmu 0x481 0>;
+
+			qcom,ee = <0>;
+			qcom,num-ees = <7>;
+			num-channels = <30>;
+			qcom,controlled-remotely;
+		};
+
+		crypto: crypto@1dfa000 {
+			compatible = "qcom,x1e80100-qce", "qcom,sm8150-qce", "qcom,qce";
+			reg = <0 0x01dfa000 0 0x6000>;
+
+			interconnects = <&aggre2_noc MASTER_CRYPTO QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "memory";
+
+			dmas = <&cryptobam 4>, <&cryptobam 5>;
+			dma-names = "rx", "tx";
+
+			iommus = <&apps_smmu 0x480 0>,
+				 <&apps_smmu 0x481 0>;
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0 0x01f40000 0 0x20000>;

---
base-commit: d4b0fd87ff0d4338b259dc79b2b3c6f7e70e8afa
change-id: 20250213-x1e80100-crypto-18c7d14cd459

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


