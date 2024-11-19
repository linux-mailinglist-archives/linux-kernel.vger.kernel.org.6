Return-Path: <linux-kernel+bounces-414790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7979D2D66
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB2471F25C68
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0031DB54C;
	Tue, 19 Nov 2024 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ami6pZiz"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A14E1D3567
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039021; cv=none; b=ZSrrFfgvX7f3fSZ/L0P7mxQ9NFmNErF4uCi0Me+19fK0uoD5ZJpCFYyuq+LvITky8XQMeV47vm8fJ71o7yPBLv0x3QMydfnLjv1UiuLfHaO3P0zTmQacbVyi0k9jpMtH2Nk2p8NkFRk0k0G6ItTkN6pTtYjgZOsdcztY45hlqVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039021; c=relaxed/simple;
	bh=xTy0814t50k26n3IdWEnCW6RpXe9FNt3pkGR9JMo8Wo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WIMu22Xnyq5FMOjh6OCFi2GJnIb4bXonJJkr8QX0SnaYlly0OvOaLCwpXQKnmhzEZISGcqE32Y4u2gqyXAAj8Q/R5LWeuzhFkanoRp2SFanrauJx0jPZdjCj0pFy0RfeDoNzBWnUQH2dH7MeofxQ5RHh5AL1RcdqTVo05f7Ivko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ami6pZiz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43163667f0eso30885495e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 09:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732039017; x=1732643817; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9QLp1s6RunFlEIPDGsvb0lHzi+DB0IAKSMWyP0xL4Qc=;
        b=ami6pZizYYug6inMcS9g+gW7sbkXUWmX01xO9L9jYxk21sMfWqPX9Jfsjg2VCLyPXN
         B9FXC/L8TfKUby3KDD4idVuQNIurRrvCRilW7mwLzL2o4IRnDsmjTx4tQm2mlNKpftWE
         ykdvzZgq3r6kvYzMypFLgCh1UyjDD86Q5TPiUoV7uy2eqmJF3ADyv2iwypRutRedfzP3
         EN0XNFYJx2ElTGzpdn6EeZbWA31/BkfgTnyd4KnU8TzSbVM3gevqP/RUI1+gB2SdehFW
         J5LohhClJqnZnmX4fjg3qrtPwXOZ1g+3qhJbIv5NvtMUV9AhWWD/6i5B4Mawz2l02v67
         Cnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732039017; x=1732643817;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QLp1s6RunFlEIPDGsvb0lHzi+DB0IAKSMWyP0xL4Qc=;
        b=Nl2V7xHJSjqlrX/ufVDhQaKnvYiG0Zsue+LKxEqLqYeHBNVfJGKMM5tVE0VjLXGXMM
         59MACY2kEhJGHiqFBRQA50VKzhxRoReEWFZGMejlW5vV7ufUHSgDZTUVoEG769bbVSw+
         qdoAQrHUv/tcy+XRAl5YdTzWXSCFbuD1p+krAZsVZ3B/cvdA5dYoICwJmB38hS2BYf4A
         MBZAwLF0yh5ux6kvSWjIl/JJtC3NjE8MV8X5EyHJgVlTkNloJ1pxx17EQqJld+nXLSV1
         +RQplp///UdLNJH03x6gwuTJMC74jEsIqe7WKAfEyNYrZm1JH3+IuLSnwUkYK3BGSGiS
         irAw==
X-Forwarded-Encrypted: i=1; AJvYcCUUiaPHuVIvQXj2kV0dFufIx2CPnLaYmDWUef+70o+psB8jmMLPxXV0Yg3fFaIfrydcTasLZp5ZfNO5mSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBh2haTVDjMpbj0UL5OT+U4jvhEkBfBmv99GX4y2RMVhac/NIb
	dQYUKb0z9kIwmFEdV95bxKlmebdiF7v9fws4q0xXhcikAuRyCU5UeRo4jmOTy7I=
X-Google-Smtp-Source: AGHT+IGVsBGgDLeziU/OzjRWtYuWJehF5iLVaaBSNw6aG2zEDYNlB3n01ca6GHiJX62rmk6DiM4//g==
X-Received: by 2002:a05:600c:4f06:b0:431:5533:8f0b with SMTP id 5b1f17b1804b1-432df78e7demr126208745e9.32.1732039017561;
        Tue, 19 Nov 2024 09:56:57 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da27fe68sm208302275e9.24.2024.11.19.09.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:56:57 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 19 Nov 2024 18:56:45 +0100
Subject: [PATCH v2 10/11] arm64: qcom: dts: sm8550: add interconnect and
 opp-peak-kBps for GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-topic-sm8x50-gpu-bw-vote-v2-10-4deb87be2498@linaro.org>
References: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
In-Reply-To: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Connor Abbott <cwabbott0@gmail.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2162;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=xTy0814t50k26n3IdWEnCW6RpXe9FNt3pkGR9JMo8Wo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnPNFbd07WfUX+D3DO8S9DCJmtm3fmLCUXBbP0PPX5
 yQHxYC6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZzzRWwAKCRB33NvayMhJ0dxhD/
 0eLXNGnWTLn0HhT5yDPUlg/ODVerSk5fLn5D0uGYbMNd6xHehmhMi7HzPEVFIlHAqzm0mbVZ8aXz3U
 xV7/qI2EAkv70rCMw9s269YKLo4UBvAc5DL0pflSy+gJaMeEPH3pCpCoRzVahSWTnYnfKEbUDTLaHV
 sO13U/ZkaHm4B3RCHbdglvwFS9kRz5Snqw/kXBzvsFTWhJfO25VsGiGE3iiWOtN3t8mKq19B59WCK1
 aMzFlsensMqpdXOMPihgc3TkDXleatgpi6n+p/shVsUeyrxLvLp0LSxI0fiUCB3k/JDK/MiR4nKNeJ
 9d9YgeuCEaPajGFk/H1MsfJ8HjjxPQhfLzrNcd51u+dJxlOOSqLXdWAfNDJFvqJWLd28yUSBeclw3j
 iGerbFp9eGbfn2PNDJgA73NmDT/e81goHVXesCs00ET40y5TPrcvq+PN1hZ6H4gYId4QVmNioMIu7Q
 cvFagAEBfgItx/18KTFIxatu6J8x/f4ZSetvCgU3e3tUgrHi5m2Av4bMoZkjn7pVnlycEXq2+bAbVy
 L8Pc8dHEGHh0+EZPumH9bYKCUiv85Odas2Mg7k0HrYcSRGIULlh7XMhc7j8Bi+o+KQLwc35xsj2+Pn
 eKCapM6aujBfwjSimn9B4NP0SvuYrtbyAe+AjnBKhhEEu3q6wf0JpwBD0LWA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Each GPU OPP requires a specific peak DDR bandwidth, let's add
those to each OPP and also the related interconnect path.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 9dc0ee3eb98f8711e01934e47331b99e3bb73682..808dce3a624197d38222f53fffa280e63088c1c1 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2113,6 +2113,9 @@ gpu: gpu@3d00000 {
 			qcom,gmu = <&gmu>;
 			#cooling-cells = <2>;
 
+			interconnects = <&gem_noc MASTER_GFX3D 0 &mc_virt SLAVE_EBI1 0>;
+			interconnect-names = "gfx-mem";
+
 			status = "disabled";
 
 			zap-shader {
@@ -2126,41 +2129,49 @@ gpu_opp_table: opp-table {
 				opp-680000000 {
 					opp-hz = /bits/ 64 <680000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					opp-peak-kBps = <16500000>;
 				};
 
 				opp-615000000 {
 					opp-hz = /bits/ 64 <615000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L0>;
+					opp-peak-kBps = <16500000>;
 				};
 
 				opp-550000000 {
 					opp-hz = /bits/ 64 <550000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+					opp-peak-kBps = <12449218>;
 				};
 
 				opp-475000000 {
 					opp-hz = /bits/ 64 <475000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_L1>;
+					opp-peak-kBps = <8171875>;
 				};
 
 				opp-401000000 {
 					opp-hz = /bits/ 64 <401000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					opp-peak-kBps = <6671875>;
 				};
 
 				opp-348000000 {
 					opp-hz = /bits/ 64 <348000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D0>;
+					opp-peak-kBps = <6074218>;
 				};
 
 				opp-295000000 {
 					opp-hz = /bits/ 64 <295000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
+					opp-peak-kBps = <6074218>;
 				};
 
 				opp-220000000 {
 					opp-hz = /bits/ 64 <220000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
+					opp-peak-kBps = <6074218>;
 				};
 			};
 		};

-- 
2.34.1


