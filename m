Return-Path: <linux-kernel+bounces-524421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 008CEA3E2CF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75EF189ECCF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848BC214A71;
	Thu, 20 Feb 2025 17:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N7C2L2uF"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8228F21420C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073379; cv=none; b=hE0HQ979Znns5nPnwUZsCfkf/RuRKV4DqTweNXigfckCJPCQ6xuej/gGjE8szrghJc9h+CJMoHI7wpT/W7BhXPbPfvPAvpeOwHfvSYaEgfQa4PT66SE/LeICm8SoO1mfTJD7mtj1Eh5zm1cAGNxXVaQr8aFi9JOHAkUOEVvsJHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073379; c=relaxed/simple;
	bh=Bvqj2Bvxl3OYmN+DIORaL6pwjqZMUxhczbq8SpPpcBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F7FgZZyNaXF7AchxbAqye98xjbL6Pgpku2QisoS8/OkJ/R4RkQ5PMBJiJmp8O5j6sWNIV9WXAapl5O/rx/n93xqOuDZzO9Jl0quSHIWVK2vlFiDJd5IsvVDh77iuwXhJtXa4iS/hdEwuj12D8rmGE/eHhzFCesvBSrWvrxGBDVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N7C2L2uF; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abb90c20baeso166898866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740073376; x=1740678176; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PIvr/zIA/fHFAIJRV6jomca+cYE4/Uv6vfvvU7Z0u8E=;
        b=N7C2L2uFH2X7wa2pRPrsE5yQ/boQzwYncXn1Anb4vIDeQRXFuaepRjjCOp3A1IlSf9
         L2UrrECv5qfn9J4dPO4DdIbx9An8wCdtQY2+r72tysx2xA70WRMcalIEpK2MHLsBHM7Y
         KnTeIiUdrfxD5sdtfd8qliJDGWFKN0Dq6JH6dqyikQryM40/ysAntczeEpecgfhq3DF5
         hirue7FyT3l+M5NWW722dzyWtpLJLNa+2RiSEfQyFb4ibEHfm93JjtkOAJ1jgOPdYhv6
         ijU60Td2xAhQ7AOCOn9sEu4AqUwxeinYvEviyqgVxvi5K6iMwpudxKaUqjDZ2ahVpr4B
         P4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740073376; x=1740678176;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIvr/zIA/fHFAIJRV6jomca+cYE4/Uv6vfvvU7Z0u8E=;
        b=bUVHmwl4CUeuZiBZ/R6N7RRsToAGfbqT6bcFLh7YfNNQMc+dsAaYHuG8uN5UTdNOTG
         f/Bet4owdWZ1z2xwqj2c75RNogy1fYb0xQ1hr4vAYJinShwFqivIbmKwlNBVhaNWcTtJ
         u9HHlMpZWjKbxh2cV2nU0+Hzea5TvjKC57iSGnvSaSyq9pL/dJJVEmv2oo4Gm/b9Paiq
         XtoZGTp3neaB2BlsmbYrb7jCHhBaDtTKyp4gIOyWbUG3yokaGd+NYiVBIHsQrqds9K4B
         CfiygOJF06JyHkBfrO+j2PuCZaSHDjzSZMR5GuWPjObW8qY2TYkp6yy6q+xmVI595NsW
         YJNg==
X-Forwarded-Encrypted: i=1; AJvYcCWXk9iA5gtj9Bgg23Y78I5LGliOs/MyNDm0XvSvzqq8iw6Uv9KWTYcz4BWrsL35L7U7JhbC30IvZRao2BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdkIRTBMdhXsz0v8flnP6L1cfL7V4eGG++3NHKSHFvExtUhBLY
	d/RYKcJvg6S9sA71/B3RL48/c4d+W4gWfoU1BPuahPgyb1v/Y7zc36M80ob1F4g=
X-Gm-Gg: ASbGnculVIPMg5/5VDbmgZvfG7bTKJnsLx2Xa82N1qutuBaKZzW4Zn6jzz0QFVPGPTk
	hLaqzu2KwBhR7EEYgBr9xdVD8q3e2Qzbjmn+hQOKuqCiM5pm3gXAClMBoCQeLjeQ81pITNDu4m0
	EQiaXXDCBUQ1yX0X/OEgisz25elArRdCAUXHDdPWrtSH2eaUDux6VNsuzbZD/T4deKTE6MVSC8y
	elBEbs7LHtJ0CAnOtZ9EdEibzR9MwFGWU5evmY30sB9OYtP7z40BVD2Yvaz4nyoUqWayLOSe0c5
	lfrE5LHNsC4lxw==
X-Google-Smtp-Source: AGHT+IGQVC2etDTib4uxuvWzjjAQAb9eZZOOrQ8eRCihV5lRcYzD5dmzSu0YUxjREXP9QcJeRsKGrg==
X-Received: by 2002:a17:906:31d7:b0:aba:598b:dbde with SMTP id a640c23a62f3a-abc099b7812mr23712166b.8.1740073375789;
        Thu, 20 Feb 2025 09:42:55 -0800 (PST)
Received: from [127.0.1.1] ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8190d1b6sm1014496166b.36.2025.02.20.09.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 09:42:55 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 20 Feb 2025 19:42:33 +0200
Subject: [PATCH RESEND v5 4/4] arm64: dts: qcom: x1e80100-t14s: Enable
 external DisplayPort support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-x1e80100-dts-crd-t14s-enable-typec-retimers-v5-4-380a3e0e7edc@linaro.org>
References: <20250220-x1e80100-dts-crd-t14s-enable-typec-retimers-v5-0-380a3e0e7edc@linaro.org>
In-Reply-To: <20250220-x1e80100-dts-crd-t14s-enable-typec-retimers-v5-0-380a3e0e7edc@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Trilok Soni <quic_tsoni@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1261; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=Bvqj2Bvxl3OYmN+DIORaL6pwjqZMUxhczbq8SpPpcBg=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnt2mWEWlcTVj58VYmaZ+QdXK1+UQ82KuTSVdj0
 uFPFl0UQPyJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ7dplgAKCRAbX0TJAJUV
 VgiSD/96ILKscjqybjFGzjmSG5oFqQHGxI80ckWLkm00/fqbD/feT4h7nuq073Pzjp0fc3JxSlD
 VRa5iB1aSeoRxZragYyYvicX5x6PviB3VH0Rqa9OUPwvjXg3j6dqs/4r3z/5kz+RqWFeRgWzixm
 Qf+pXyAVkEEuCoIIfRj1hcd0/S4H8NRTeXYU5AJDe5xGtiD42zm9pVQ3GqDxFBJpKtt0pBCz0Nf
 yiRWKKI03opYAkibrFuS3XV2gY2auWPBHXcfTkntrrW1Ucr2QDrFuYc9PD3H38W/x/avFkAkzEd
 WYpZA43S0QKsUm/6Cr7+NZXnSRTAzyq84pkTPYgADl8jgDZf1k6hS5bvOqId4nkRLCIBSCUhcqs
 BG5sxcHXOYkDw8JQ6rl4tLIQstBkW9zKnetYd5edd2F/bihWa17+1uKlsBSzyT48tci2xBYg62a
 nAtf9sHHcn3/SaEupVmXSJD2RL9MIwpnUup52x2Qi0BYAznTHhP1/0d7NTrBsnQi5TZUoMo9WVA
 5Fe7Qk+CEqvo1H75ff5ZYCgXenGBz3pEDAQ9LIsobsEkdfomL2CvC4mjGg8zPZgoZTOEs5UZasT
 qGeQb4oTiaRVHc1hcm9w1aoWdFKF6piNvcEdWiqO/QbTLBfL//Q5Ir5mRn0ZIXvi1aJdsrpm6Xh
 1K8Iq19CJdv1SNg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The Lenovo ThinkPad T14s Gen6 provides external DisplayPort on all
2 USB Type-C ports. Each one of this ports is connected to a dedicated
DisplayPort controller.

Due to support missing in the USB/DisplayPort combo PHY driver,
the external DisplayPort is limited to 2 lanes.

So enable the first and second DisplayPort controllers and limit their
data lanes number to 2.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
index 8949afc2f10e8fe912ac118335f7dc471566cf8d..850fdab9f0b1d38e7b8f5f81f7187576357c4514 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
@@ -924,6 +924,22 @@ &mdss {
 	status = "okay";
 };
 
+&mdss_dp0 {
+	status = "okay";
+};
+
+&mdss_dp0_out {
+	data-lanes = <0 1>;
+};
+
+&mdss_dp1 {
+	status = "okay";
+};
+
+&mdss_dp1_out {
+	data-lanes = <0 1>;
+};
+
 &mdss_dp3 {
 	compatible = "qcom,x1e80100-dp";
 	/delete-property/ #sound-dai-cells;

-- 
2.34.1


