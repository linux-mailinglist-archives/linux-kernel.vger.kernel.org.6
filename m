Return-Path: <linux-kernel+bounces-449404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8FC9F4E82
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24F8170241
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2381F8F0F;
	Tue, 17 Dec 2024 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JkcTx9eB"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C83F1F8933
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447093; cv=none; b=sRq9qJv5E3sg4ZXp3fZBm0adz5c5u6lo6lLQyYMe8gGBHCCVlLmTbgYUkCKSRCzKVX1/Tl9JcZFogYHAA/Gdh6sWUP2ECp+iCdjPAXw30+7PBVp+HRIUKoCTap6UpvJtIT87bRV9p4CawP/IifXC4W4PjNjS+CPWug9zTcGAOZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447093; c=relaxed/simple;
	bh=mRmcybJomrA8DtYq9fiyqS6rR7q297sl5lRf/i/VlGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zz/PpFnNdNr7HI1bLJ4+n3KsXhIQ5xou1sLTWjUdDBpNSmENOaPtngNgZHOS/r7nxwmf0hL0LSgrbQ9w9Mmv1g6tT4B9AjRwA2jc/6IdE4b3R94y2yW/EiNvXJSObncTkTbaCj/Mm/asBA5XHfoP9uej/4WcQV9qHUFvHoFbsdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JkcTx9eB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4361fe642ddso57120945e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 06:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734447090; x=1735051890; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B4/tn0+NaXoZvCxd7DO6dwQt1/7UILyIFVNQSPfY62g=;
        b=JkcTx9eB7LbW2fZ+UpWG1Lq2HbaANHFAMorJmRbh3Od2LPwcbPrwpQ4k3Gg8d14Ps9
         StgvvH52ydLqEFVQDhnNHcjIvwUcnX00hoVBIDadVq2OkDevgYnv8uqb0o5DMblWpJcz
         BF99Rw9VlvnrdXZvoaMtMjZToFI+BBw8BOjtQHo+Et3tLiHGVbQh/Zp7tIQlASwdp2ww
         Nq/QK1hobw3qccW/U3X+UzPpYFJyoAnNb9ExlSfZpUWjeENC7PCLNi3tPbi9mNz9MRsZ
         0xBXBFbXORW+Btmm/ImkpA/ygd5pBO2NuowZe4IVvs/rXvNRtFa8UAxqu5wxkuOeDSCK
         S0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734447090; x=1735051890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4/tn0+NaXoZvCxd7DO6dwQt1/7UILyIFVNQSPfY62g=;
        b=OAhcr2rIKuFyO0GFOZju0WXI8kvzhH3G3zdho7tDSVvGiCFyq1A1IfbB/Xh6LFxJ1b
         Wq6wcdV/He+sRgs+M5elaQhUpK83CzXkZi4rqlWsj77scD4aZikvDsWzB9xOM2HMeCwb
         waOsS1fRJ4EQqLzGSoJRVbTqG7RNi/pqUNBaLmIGyPxiUIyhEnPwRcGMPEJeZAx55Zn3
         wey1P265JfFh+En7Wep6VBKeHL+BoS58DbTcu8wsY7d0IJK3Hpt4VcNAks4TMmECXtot
         XFxQY28Be0f3Pm4Y1GrsYEbK6JIVbQybP7fEzE1v8Cprm7eyBoAHhzkcErzmIcHSnHhu
         SRhA==
X-Forwarded-Encrypted: i=1; AJvYcCUyETU1yIrj1zOsNQ84bpdwjaOwQifu797nklegdBvQSxLFLRk+xZrM2t0i9QBfeel/fFUqqapx+hHTC5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya3K+5lN237jZveXcoPWwvb+38YahGoCa+Z5SlB92AxFYDeyE+
	5XLvKymm+V32MatjpIaFDjy7OlEUwIiK/ajSxy93A/zxk3VwlDAx7tg+1K3bllM=
X-Gm-Gg: ASbGncvqq5aziNyOD2YZWOKxT4qZBQj1OCl/7ZuuC5WuY5uKzljijpcu9wbjoaQbu6j
	aDfB0AEv79l3nNnyulo8F4blC2wIRRt0vkdQnzDA2+0lo633wvJv8GQLwbA30NTc/BsJJtWsUjh
	6cX9c3uhUYLVEmfXWjDIV5sqGCxDm0HAMshdfxRmo883UBHEUJxJz4CQtwqYa3X4MnhgcTLJdiD
	BfCg+ryGnxi97c4+nRUG1kga6HSdfL3HBfbD0FQ/zjioCPYwr2YrziUsh3Kzg75KeZ22FMDYG56
	Ow==
X-Google-Smtp-Source: AGHT+IH/5sriNzAD6IaFFPEiS4CWanvVfWJxtccBMyLLxpopN0MCzfz2fRQvDKyhFZ41uHBFsZ98Mw==
X-Received: by 2002:a05:600c:1f0b:b0:434:a94f:f8a9 with SMTP id 5b1f17b1804b1-4362aaa495emr130893345e9.28.1734447089987;
        Tue, 17 Dec 2024 06:51:29 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43636066f51sm118417375e9.22.2024.12.17.06.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 06:51:29 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 17 Dec 2024 15:51:20 +0100
Subject: [PATCH v6 7/7] arm64: qcom: dts: sm8650: add interconnect and
 opp-peak-kBps for GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-topic-sm8x50-gpu-bw-vote-v6-7-1adaf97e7310@linaro.org>
References: <20241217-topic-sm8x50-gpu-bw-vote-v6-0-1adaf97e7310@linaro.org>
In-Reply-To: <20241217-topic-sm8x50-gpu-bw-vote-v6-0-1adaf97e7310@linaro.org>
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2681;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=mRmcybJomrA8DtYq9fiyqS6rR7q297sl5lRf/i/VlGk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnYY/obfz13xZbRrotrGQIw50hlz2scCvq+FWxJcUZ
 9RBFiZeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ2GP6AAKCRB33NvayMhJ0TEbD/
 9LdU33QP0qcYGWuG7UuVR7KT5vp8m/DQImoa/Hpl51HouhcVrZshNZwY4bSn1uMlj2v8iCcI8lQ006
 UnDSdei+wedcHwZdYM5t4ME6EPDaIBWI0PDVozWIUy4jbDaCp6G/0zWgJIoY4nCRCnA7RGaeusFVXa
 9rVGS0aCsmF2uiYynvpqgrsc5Z6FHtKVNTb9lCIXBpfzIXlDsFGTKQzKRjJvOHBmEKJB3APvjextbd
 EOw0N6KiAsCHqysZgpIW1BpjcwEfW3Sh2ko4kYiBBzl0Qbz20wAbg8HAMj/LGQQ747ajKjICqZzZTd
 1FS3N4LWO59SmtPLRImaDO14GFniJkLyhtptdiT/R/7RY9i6gDHdBe1ZZoiBN9AHHt3qyc2rvMxxxE
 Ml5iK0AkBQZYdGUR6moLrQlAybVFqlOAdikPA7bXQpsNiAIME3tQXBZFQtK0gzhMQd5HBkgNU+o5it
 sbrod/DJiHI1NFK7+U0XA8+/lEr3xvurM5EWKsdh6W4vYBU73vGogyNpDNfg6SH2GFk20qSIrRD9Gq
 6pLjhanFozPRudSjnyN5HBmvBsNeGKv8LBNsmicf24Yq33zlyKFFC21DcjTbEscCyjaoR3zK9/k/eo
 vpF8hw9h9kDloT50VlK1fAuWdBaf/CjJgQq1B93WyYgl87GZe1X9OmlTiyLA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Each GPU OPP requires a specific peak DDR bandwidth, let's add
those to each OPP and also the related interconnect path.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 25e47505adcb790d09f1d2726386438487255824..c76c0038c35ab048c88be9870b14c3a0b24b4183 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -2636,6 +2636,10 @@ gpu: gpu@3d00000 {
 			qcom,gmu = <&gmu>;
 			#cooling-cells = <2>;
 
+			interconnects = <&gem_noc MASTER_GFX3D QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "gfx-mem";
+
 			status = "disabled";
 
 			zap-shader {
@@ -2649,56 +2653,67 @@ gpu_opp_table: opp-table {
 				opp-231000000 {
 					opp-hz = /bits/ 64 <231000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
+					opp-peak-kBps = <2136718>;
 				};
 
 				opp-310000000 {
 					opp-hz = /bits/ 64 <310000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
+					opp-peak-kBps = <2136718>;
 				};
 
 				opp-366000000 {
 					opp-hz = /bits/ 64 <366000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D0>;
+					opp-peak-kBps = <6074218>;
 				};
 
 				opp-422000000 {
 					opp-hz = /bits/ 64 <422000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					opp-peak-kBps = <8171875>;
 				};
 
 				opp-500000000 {
 					opp-hz = /bits/ 64 <500000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_L1>;
+					opp-peak-kBps = <8171875>;
 				};
 
 				opp-578000000 {
 					opp-hz = /bits/ 64 <578000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+					opp-peak-kBps = <8171875>;
 				};
 
 				opp-629000000 {
 					opp-hz = /bits/ 64 <629000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L0>;
+					opp-peak-kBps = <10687500>;
 				};
 
 				opp-680000000 {
 					opp-hz = /bits/ 64 <680000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					opp-peak-kBps = <12449218>;
 				};
 
 				opp-720000000 {
 					opp-hz = /bits/ 64 <720000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
+					opp-peak-kBps = <12449218>;
 				};
 
 				opp-770000000 {
 					opp-hz = /bits/ 64 <770000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					opp-peak-kBps = <12449218>;
 				};
 
 				opp-834000000 {
 					opp-hz = /bits/ 64 <834000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+					opp-peak-kBps = <14398437>;
 				};
 			};
 		};

-- 
2.34.1


