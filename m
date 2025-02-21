Return-Path: <linux-kernel+bounces-526185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAB3A3FB4A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E81A7AD659
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5921F8AC5;
	Fri, 21 Feb 2025 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iG7/S1gJ"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633411F12E4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155042; cv=none; b=RsxPSl2k18MegeVKRFNf4F0ZlgNflC5wUesgQF8sEHEkrF4lx+3rPzOep4HtzXlg0koA15Clfih9UuNCARjuO+2ehSopCfW19sUN0hMj/j7tDIFARzp73nsmeHJNbWWgqoD2V4uxPkefAjpcblhxnziNE4RSs7uSZaE5XR/vbH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155042; c=relaxed/simple;
	bh=nVhLu0AiCCxQH/soBCHuVFIETyl7UMc6C9vhLI8S8To=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s4qu84KW609FIoy2X4cmG4TgtczcKxolnRP79s5MX4Uf2qrfx+9ZNOhy0E0wEfmkAzMS0NDWBzHu9lkt3WOFf7xUpiys27sF5FAR9XbghHTJak7CkCFnngD3lDzZPpeAE2c6A7jYcpAJ1jIzxj0qos8Gbh/Enfx4yW/F+aaiKw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iG7/S1gJ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7d8953b48so34410166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740155039; x=1740759839; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DjLNng74rhxdSjD2x2QVGFVe11P7mYgAEe28w7w2n8s=;
        b=iG7/S1gJGXkCPOXCN80REPq7pdRejN7cFkpjTNsZqiKjNXnswu85xhKbNPcBiTTprU
         xeUaQV3d/dC+zDgPrfb6BzmCLAdae7fYsCBv3Fu9pr1j7+ynAAe1nTT1l/TEkXWr/AUH
         tU42KpaVsalkBmPx5K6bnYW5R3v0FqMo/rM76LQIij/WqD6pA3pSU8f9jU7xcHZ+wi5w
         FxvSjKLSMJYRYZ8YLfYUzGCcmCpBY78Qa64WLV7wrMxibYFrlE4xvEszodwaOuz+kjtm
         gFWXwc/VLvu4H4Cac+VKbQPsFFCQNTwPFiQusx9Mc9TMZNu0JDPFNIQWd9FSL7eRuRyA
         fJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740155039; x=1740759839;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjLNng74rhxdSjD2x2QVGFVe11P7mYgAEe28w7w2n8s=;
        b=KqTiQCA9hWvyM5/B0cUaCTPtmGDAoZdgCCKsAemQHI62rYZ7cPrOEDQ4hn6CDzKdhI
         wHDEG2/pTLlCaClu6WKJRMwdrTRjZEKak4Lst9ZnqESSPZoZvTUoJb5vlnHJ/3KheFg7
         nPH1G3Z7rj6ZJfDqSPwdoS0QB+SVAVlL67EdVcyQ5PjbfibPzV9yoLwtqjTNffgl1/ME
         RrqEP7aUWhA9PhyL2K1/J437bO8Tlhi3WPoE+jPkJf6FvztVhIBq/o2AudJnoj253G5H
         WXjFyXMW8NEsHEKT95XGQXz8zyyzNrbBIwArLALsTcQxA296VuF9Y+Hoif6ZEIYQfCA9
         o1Vw==
X-Forwarded-Encrypted: i=1; AJvYcCU2z80LEZBlXMl45sNg0TzV0b8o4CNlH+0EuPiDIpODPqR8zO2uWOMPsZ+1yX1WlbJTiJ98XK1FLCD6fYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSLXUOb6cRbf/zy37yECcHRunnfmXcox8O1/ViNuZ3cNJAuWW1
	fABpP8wcAQbHDcnPGNeqavt+EWUGMpc8XMQwPEchDdGuXNTMDWtSOi1PakOXdk4=
X-Gm-Gg: ASbGnctoZU4v2M2NFieuiQ+FZqgeQE0WpLaShtu2Ik5bApXvzWE31B8KN0ejnyyT9mK
	vCMkwU182YChtrXadmYQGrLjvFIx9HwGnogeXQRsq16wH5zkCcfnr29QYcjmWgI2Ey2M7ML1oVY
	I/p5eVyt3UGjQRpXY+0X27C3kVczrnBXTFVfhDbxqtG4iJMLNc66cbvE25MJ/nq/JFo+c7JEZht
	egJSKfaVsCL0KbJLwntjyp7yKBEnm2BI+zaC/F3vVys7HrZTFIFDBIW/q9In2xEJorhffgDbyXa
	j+Ggi5cNSjNqyeqIgIAfZTAjpwLlp+zSQVOC+XNIS6f9obFPoe2keE1qJ6fX6IR1xq8mLtFwgkn
	4
X-Google-Smtp-Source: AGHT+IE9n8WT+LZbEeNJpCmaPGDaxOuwTNa0Yfora0XCWQhgh3qzuxNavIa1QJcqz2nfqkDrP/IXTw==
X-Received: by 2002:a17:907:2d8b:b0:ab6:db64:b040 with SMTP id a640c23a62f3a-abc09e5c67bmr164906566b.12.1740155038670;
        Fri, 21 Feb 2025 08:23:58 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9723a559sm1050545366b.96.2025.02.21.08.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 08:23:58 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 21 Feb 2025 17:23:51 +0100
Subject: [PATCH v3 3/3] arm64: dts: qcom: sm8750-qrd: Enable CDSP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-b4-sm8750-cdsp-v3-3-fe2891beeef7@linaro.org>
References: <20250221-b4-sm8750-cdsp-v3-0-fe2891beeef7@linaro.org>
In-Reply-To: <20250221-b4-sm8750-cdsp-v3-0-fe2891beeef7@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=884;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=nVhLu0AiCCxQH/soBCHuVFIETyl7UMc6C9vhLI8S8To=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnuKiYweY66DfEO3Vn72kN6l3tvIOj52ZgdsS6B
 bowczgEv8SJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7iomAAKCRDBN2bmhouD
 1zUMD/9c+LZFMNblY0pAJwmhJIgLjwDovglQ/SnLT913ZfW7JB9/Bt2bYjdVoUt5cvtjgW3PY5B
 nX+9+k4rULTwP1U50Of7pRlWr6bwEXebQfXWYalK2MAD13IvsTOTPrWzQQIPTNyNMlcieRrsuYm
 DUXco0J6ysvljhb329joVqD6tsjI0noQ4Pi+6IL9yMPMerhwwbG6WOQwlP4btsaXnZrwnR54NC8
 7IYQ3tJTnocgzsWVfgyWXOz0+1TfzRlBfPHQsmXQFYovvg9+uZmkgHJtIct3hbPNzncV7qIta4l
 nCmF9XuetgMUfi8QXZ+h2qtkMHBy01oEHnzVj3XDQfKuYP4X6+c8WPLTGB7bl5jC6R2zLxdZ2v6
 bfQRB4bCp1UPpld+cnf8BcfqVRDUjc0e1oJ3inYuABQ+SwLIx1yvMC6MPJhFKtVc3u5hJHdyayh
 3Cg057i24QBD5l0j11+P7VAj8UA5LAB2ZevBulvhqiJ/ZC/gbJDpLu0r8W6tjgs0MVPBOMlPWqk
 6r4GzXhXIvvEoDOB/EBI5UftETxnXCJtddvo5AKnRVROTkuZKlqexYvW6OZ4OiTnNGWcFMVsaht
 KMZS0RGU6TsHoLBQbpyGSDyyWQVYZDRHggWUmQf6QfK/K+73VaOcjYCA5/xNcwn3OSMurckRriB
 E+3rCVf4BMDAG2A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Enable the CDSP on QRD8750 board.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Not tested on QRD hardware.
---
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
index 341774bb042ff88af8acf49c2f0ef14f9994dfc9..7f1d5d4e5b2813c59ea9dba2c57bee824f967481 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
@@ -789,6 +789,13 @@ &remoteproc_adsp {
 	status = "okay";
 };
 
+&remoteproc_cdsp {
+	firmware-name = "qcom/sm8750/cdsp.mbn",
+			"qcom/sm8750/cdsp_dtb.mbn";
+
+	status = "okay";
+};
+
 &tlmm {
 	/* reserved for secure world */
 	gpio-reserved-ranges = <36 4>, <74 1>;

-- 
2.43.0


