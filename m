Return-Path: <linux-kernel+bounces-353109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 563EC9928BE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FA2528559A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358371B85D1;
	Mon,  7 Oct 2024 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="CR3c9qPu"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F511AC441
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 10:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728295392; cv=none; b=m70NEDdHCz02f45yoIrrvILBs9+63krZQvrWGmHskchSvwhvXqXVwsqMQEqmIgwEUvpsOBi9h1KZGBZeXIec3wDoojUUxqI8O/HBzlQbJ/C41AMlbFput2MZ2jHAusaXt1ggjMOoQ1s90NTE3/rCDXYchYaw8hks/mKqV3zpUXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728295392; c=relaxed/simple;
	bh=Qedr4QQ/Ci5NTghGhYHkshxX+XruaUl7BBaLaB8o2wA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nvy3O+FPOKK3YGhv+bnkWnPmL8P8NP2Ps9taMDMPpBuExQMl7Ra0/VLDBTXFHStWTTFIH7GVueRLBONEGAVYv62SPM0gSLqaf9jQMEq10/Ad3eUBwHy0vPg0VgpS3Jt+J8gWUfAhPAo6D7IpRPJwE/7Ng2sJx5OgQoJuhmjNVvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=CR3c9qPu; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cbc38a997so25863675e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 03:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728295389; x=1728900189; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDPJeKXQRNvp96VknSMumvbAzeUP8Qqjm3PSVUPnmYw=;
        b=CR3c9qPunhfXCGcAWWFZWtnV1ArmrlQi6mVO6OCFa5D2oKgFVx1RbRgIyuprDkud7I
         4h7cGvNsZJh1qiH/I4Yi+av9betthr9PY9GwxFQy5AOpGqrBBSExAmB5eyhigLFa/6yR
         PaifBp+pW6ODv9yffUhlr/e5MwVQkgo98ZHc+tgj6BR2VFKWnNUKj0YUGK7eN5VGdr2q
         u5wEh1PR5KMJvjORDmBPIKO3BWWaHQDvMtYLoCg/dDtxXetAegnivpND6TbVSZnACYDj
         BMUdz8Kmk/pXmoVE33w3y3JOp94svEJWw4fM0CecGO3aI8U9ND7Tc6cOfcOm5hZvgv9L
         6+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728295389; x=1728900189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDPJeKXQRNvp96VknSMumvbAzeUP8Qqjm3PSVUPnmYw=;
        b=qFzqh6Nhepo/l+88HYd3dPs6NP2L1bQ6/uGGNONjy6El1M8MOmQQrcJ3RG8fyg5EDP
         kXG2upAtTUPkmlXrrxp5KTWNnrarwliMFqxkZU0IaTDWRM4L1nX1NEP2uWKyYqPfewdf
         u14NdXMvqw8tUWqKaQTpsPpGklTqeTWYxKMXbFZsVGL14B1HHGJ/elwUBL49cjtt+bpf
         1Mp+nrFETiF/h+AqM6WrQ/fBhMjL/xCe3UrsHbgIB45s9g5CH4Mh3Jx1rogEjbPCTUN+
         JQgkrVj4oUILE/hrMN+WzAq7Ml7hz0pWHZe+AGVpDRPpvBd9zd8to1NFUQuBT7ZCbIBu
         EdgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9jExk3VslrkbDgFSq/4z64dscW68vCg9pDrvz+y31oVZkPmUNS9zd4OszTp7tYUiUnmrtokID9Ve4Ca0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiPBx23lBTb9UUFtgOvSRFK6Xhd2Uw4DS9o00TL2LHbR+pby+R
	1ePkMWBvCdIJqMpfchUtb+iqQsiw1/XR5JN13Ht+PvuidhmFsViewvgaAH0y0o0=
X-Google-Smtp-Source: AGHT+IHhpiB0/M7O7LiNqs0dGrfLbUSNShQcwonmzdn9+TRQIgtk+7aYfTZho1gHKcjwIiueAflEKA==
X-Received: by 2002:a05:600c:3b91:b0:42f:8515:e4ad with SMTP id 5b1f17b1804b1-42f856d271dmr62747855e9.14.1728295389476;
        Mon, 07 Oct 2024 03:03:09 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:6100:637:cbe9:f3bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f9384f648sm8498695e9.20.2024.10.07.03.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 03:03:08 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 07 Oct 2024 12:02:57 +0200
Subject: [PATCH v8 3/3] arm64: dts: qcom: sa8775p: extend the register
 range for UFS ICE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-wrapped-keys-dts-v8-3-05ee041f2fc1@linaro.org>
References: <20241007-wrapped-keys-dts-v8-0-05ee041f2fc1@linaro.org>
In-Reply-To: <20241007-wrapped-keys-dts-v8-0-05ee041f2fc1@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=803;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=w+GVkZBb0mClyuuApKk5SlFyaRlsMHyW1TE4UOIg0+U=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnA7HX5rAZ0LCU6w17eSRAVTXeKMp8tr+nIDklb
 MHOjFevYUeJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZwOx1wAKCRARpy6gFHHX
 crnLD/9yML0IPSLYKbmWyjBXHRr6EMCQ7lHP6FJHs8KDcnpmwCIrpFndrEzhjbvw/cGjnUioLqN
 l5pzRbff9K45OOJ0RZwPKff30ekVr9H7iwY8nVWsNAd22qNDiVrwStc0BG3epQhPgRbr3Po9CvN
 1m3IJoxyFcP2QW+Ohav3+VZDFKgIfQpgr4ViFOTMKgpQ6OewkHRHt+4no2NF4J6U2PLykwG+j+u
 xCfMtAH+GiTDFwJKIUquC2W4tbjPJ1YTvQqMk3Cd8HhZlyvhzh56Qmmzgjl6os1A+O75m5bTgcO
 hWJHlctAXZaPOA8/swMYDxePEviUh46H8OK0W2U1RL/hqFoDYzaS7phzDKRAl0WpBkUHSS3cx3L
 FyPd8UQFnAtHIRsCih/IAay+mE3x+6LXUMOESk9bBZBfiNf4BALM9vfvMi2lpgFy0MZxF0Vah7e
 of2AJr7JAubmPwx36QEO8tXUO/Wl/pppxw0G0JZP9s8UsgwWsqZ3qmLYHpznuI0rjowiG2p3UBO
 wmKRVsAxYHfhIe1gwErD7S0ePGCSauWHxJjKGE+w6BPtoIwU7/ddM4oo+nCzThoBffYwDOGVQqV
 IMopVvUna3ZvxUpQe6mV7oBnX14MnvUKjWgDVJDGkE/MLJGRDiK2uR4YCyqr5K4ltcana0WVjQy
 gYS0nTFNYqBrESg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The full register range for ICE on sa8775p is 0x18000 so update the
crypto node.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index e8dbc8d820a6..82099d7d0472 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -1908,7 +1908,7 @@ ufs_mem_phy: phy@1d87000 {
 		ice: crypto@1d88000 {
 			compatible = "qcom,sa8775p-inline-crypto-engine",
 				     "qcom,inline-crypto-engine";
-			reg = <0x0 0x01d88000 0x0 0x8000>;
+			reg = <0x0 0x01d88000 0x0 0x18000>;
 			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
 		};
 

-- 
2.43.0


