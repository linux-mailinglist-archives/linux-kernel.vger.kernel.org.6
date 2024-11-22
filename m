Return-Path: <linux-kernel+bounces-418411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DCA9D6158
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E46316046A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A501DF974;
	Fri, 22 Nov 2024 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P1p9zTcu"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FA61DF27F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732289228; cv=none; b=Ly9c9LZBzP1rAgjL/61aHKMeSl3Jx2rcqIMn+ZUgSkQFp32ljxHTVEvPQigyeQ/xJ4oVPMYj/+7e4Nww4cwcoAYOl/pkNR8xp3jVD0WSRSiaOiGKaZcMr1wGwWSZxCd5XvdWQnDOXFu/hWJZgv1eCbzIY78pdUDtBq4lI6XrxsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732289228; c=relaxed/simple;
	bh=qjecPisH1rDv0vmW4e3Z5k4GWR0TA6ZJS+WGTzwZWHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O5cak56foSc0qYR5RrrwAFLUdktsUtWNkfzb6NXytYfKmbcPSD3mhlYhPITEURr3ogN42VIjkmnhedVt5Cg6lhijz1+XVWvgGTjuDliuDOv1wb84J5GERDjlpAyrBaW5bdB5y1HQXNC2w5YXekFYdVcTV28Gu5l0uhs4h4P9lk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P1p9zTcu; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43159469053so1973915e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 07:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732289224; x=1732894024; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0X1Xegl4oVpMjzZ8PB7qzQH/4FIAntXlEuYmUQlA770=;
        b=P1p9zTcuEjExdh+BEeflgQrlhbkpyxsZxeJQCuB9bfS/5/bYpNbOJVpumsNRvUOHKq
         mvkpt5zIxBjGlmwt7gnX08HApaWYLc/SRcwClpnAkGBWKW7i03xOQilQPFYOM/D6ka/z
         JQBzhMZtdQ2tfJqWzmiCiRLSPNImSOt7bNEbCj+S96oi6TGl+OrhbM47q2ZWy6muGX6u
         1/m4v8QYuUJOC4TQ1L5eaC9BzHSZX1d3d34M3Tn/Y4XtbCr/D5IU4aBcfB7CaW9ie6qu
         AbsBwsKYY8ftk4e7VZYgJ2UracQQzldpUs4eufU1xoVh0wWkw+T7u8QTqLLzYM4DUS7G
         xRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732289224; x=1732894024;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0X1Xegl4oVpMjzZ8PB7qzQH/4FIAntXlEuYmUQlA770=;
        b=DgKI3EgD7UviZbIfRTwFSmEDnOgG6p8eFdZIOd7IiPITRFkEgxQUjn6iEEsMEg0u4h
         hXUQj/SXJ+jm7sEBNOcgMTu7O191LkggxbahkzTxmakllB+84hvr8HWJf38Z72v7oaqi
         9Ei7S7eHfpUjprJHcvPq+N+bcCwNTEpRDTiW8qcwm0e6imD5S4WbHi6lLkXosJaDz0ZO
         ElNtzYTpokD5DVhSHMxg904BhMR9AzJtNqkDR5PXjeWFD/tIfUd105RhuL/bFEixyjkd
         7kn+6+SMGiIef22TJot0z0bELhTxdbwp0eEAMPn6ZfLNLOxMshpi9i+w8s1R+p9qCzpg
         gnbg==
X-Forwarded-Encrypted: i=1; AJvYcCWt+qSOVfdHHG5HK78lYMH0QTA+MwJP8F7s2jnjqwLyli1U+ZWhycsj2P2Nk3gh6bFIBL0YlWk2fGoYpKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7r8xHqdeImCLE56Xjsw50ZdHKNNo6gVM3FE0azw66a0uAxEoH
	mYideCBh3/ayGYQ13ZdfKxOXoLJq0/+jjXeZlchvJZ4D3/4y5lhH2PKCp3hIXeY=
X-Gm-Gg: ASbGnctgD4FhoDgR/0fRiv4jYIPJrBdvuFi2TDuYTiB+LbMnSdbmTxfGDRZn6abHYj1
	r8LsipeUNX6HNt4j65v+rPs3rMVykohX1VwJGD8F4481BnyaOSHYSMPaUOLTu+MRQ8dJpq+1zKb
	vgQsqDZEQWN8EnBIp8xbDsvPuLZ8buzMsiLBC2JxScJqlGpQrdQRv5QP9maxgh2LuvXgDYCXP+h
	nUhVSSvhvpsb/HHsWSEml4oPj95yPswJ0E6SA6zM2D7QR7d9Ed9xybu+CIPFRGosA==
X-Google-Smtp-Source: AGHT+IFH6jXnahHKvEKTrcqIFxJfwrjr+1CcU0LecZfJrqwau291DbTfkYHttu8w0eM6MmGhjaWi2w==
X-Received: by 2002:a05:600c:1c03:b0:430:52ec:1e2a with SMTP id 5b1f17b1804b1-433ce4aa1c1mr12469075e9.7.1732289224313;
        Fri, 22 Nov 2024 07:27:04 -0800 (PST)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45d4c68sm93002935e9.22.2024.11.22.07.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 07:27:03 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 22 Nov 2024 16:26:51 +0100
Subject: [PATCH 4/4] arm64: dts: qcom: sm8750-qrd: Enable CDSP and mention
 MPSS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-b4-sm8750-cdsp-v1-4-9a69a889d1b7@linaro.org>
References: <20241122-b4-sm8750-cdsp-v1-0-9a69a889d1b7@linaro.org>
In-Reply-To: <20241122-b4-sm8750-cdsp-v1-0-9a69a889d1b7@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=981;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=qjecPisH1rDv0vmW4e3Z5k4GWR0TA6ZJS+WGTzwZWHQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnQKLAImNxV7FL9Y805KQGpPyfRUNmJWupleiZ1
 xHDFKUZM92JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ0CiwAAKCRDBN2bmhouD
 14fUD/9+MGN9EtNpnhWMVCubiXnLItxYnghxOB6jcruviHcyqwxYrmHMQHYDaxa69m2y7tubP0s
 ixkobsktYXURi7urv/JxDulHtlTgBN7a1lfsKs1vd3eVbAgJUKCLfRHth7DoM1j4C2wT+j0wnAf
 jVG49hZxFDHGY1Cp8SNwUHdNkwIhJPa7yi06BgAB/X/7wD/a0WY+eNkbesACnDNryFWJIsKppA0
 QYi+RxWtXjzHaRkRFcPC10vQVquBRXGC6MnoYijmhpwhCKYywMkrjBr1r4eTCM9bfdZs3XLb8N/
 BHf2Wt9qBiPoaWSIYFxy7DOQXUKWjKEscryWQYPoWGdeUb5skYJ5a428242MIaUnaNh1FsqKQBb
 N1xWUX3ipZFwiu8PbgwMqGrfbxhaMfV0Ajsd9fARujY4aAMfhrB5++f0JKjGkN3hW7twvWmYxbG
 pl1a8BKRB4/9MgA+lNbybORe/c5gNYVY5usbCptWyH3kGDPLYO/epsC0YGM2Kf+aFuC8URQQKYP
 JzFwfhPUbFHBE+9/rQx0ECshR68UP/n4jES0MKofv1/oGBL0ohA7H49aN0PHVYheTPUa/68OSI0
 sTV7O9sCnHAx1geMU/2sfN6BfuzA0cP/opX7bVUKIjlWTnpaKl8/AMtkvzey4DW4KH6eH6nSNG7
 gakbmYF5n5l1B/Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Enable the CDSP and MPSS (modem) on QRD8750 board.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested on QRD hardware.
---
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
index 341774bb042ff88af8acf49c2f0ef14f9994dfc9..840a6d8f8a24670a01376f8fce511da222159016 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
@@ -789,6 +789,20 @@ &remoteproc_adsp {
 	status = "okay";
 };
 
+&remoteproc_cdsp {
+	firmware-name = "qcom/sm8750/cdsp.mbn",
+			"qcom/sm8750/cdsp_dtb.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/sm8750/modem.mbn",
+			"qcom/sm8750/modem_dtb.mbn";
+
+	status = "okay";
+};
+
 &tlmm {
 	/* reserved for secure world */
 	gpio-reserved-ranges = <36 4>, <74 1>;

-- 
2.43.0


