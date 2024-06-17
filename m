Return-Path: <linux-kernel+bounces-218142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8EB90B9B2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61C3D1C217F8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E161993BB;
	Mon, 17 Jun 2024 18:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRNoWXuH"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AA6199259;
	Mon, 17 Jun 2024 18:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648994; cv=none; b=f7PvWk7MIUIQbKq8Bxi1Hu85kpVZvxvEelZyXGX9TcljQ0347Y9NFpwHAfm0M4z2KzMFCr6aV4zl9Xt3Yq+pOY9mqtjtcI5ymRj/7KNNqXXrOqMiyC2k4dz3/YyLdtfiN9zw1+sQBTAOycND4vjMsyxHtGuz/Pvfvh9sL0JC4L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648994; c=relaxed/simple;
	bh=9usg1860HeLN2D86kwAGVsch0yxyMQiUOvKvhiX96F0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JRnrfwaMnd5qzb7sHF4q18j6h16V0G3sJsOCUhj5j1bKDOzTdKCAfOHH45ShyfR5aOnzqOEDS3jzqmbNupytWWi1THiFveG2cOpVnnSA7VJAv5pBXDvZ11tPBhLpKdu+fj/obCCjWYTCT9lAf6o9l69TdoC9ykgtZ2v0bDL5Yuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRNoWXuH; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6f958a3a69so12551966b.1;
        Mon, 17 Jun 2024 11:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718648991; x=1719253791; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/gIdEIvbMDrmnrZNpEG2mYTheifxVrjfELjOF2EAXlQ=;
        b=IRNoWXuH0GYK5yPfH1kZ57Z3Sx3NJD6MXo1OOa/EApNK1wEuk6LVIqc6JY5ieYY/dH
         beBqPj9r6L4KVYPNnClCJJCEt3HGH3VSsLSVuXTBZtX+edVkmQyIBhSqkn1ktsmJiItT
         DxpDopWWsbGXz5kROTKa9MSwyLm3FncbvkXtwyAAoIeLeND8Q5cDozatQexFrAslynxg
         43rBmE77RElodgww3CpAyhnfJFbtUPMPwBxWU5qX1RhAxYb1D+jEypRpw6abhfANjPG4
         FqN7xJjpqFfuWWC/0Z27XG5UFb1YKpUP620PfK8asUbcMbxUMTbNEQ5GqllseTeOBe7R
         v8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718648991; x=1719253791;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gIdEIvbMDrmnrZNpEG2mYTheifxVrjfELjOF2EAXlQ=;
        b=bcz33RCsYpCdg4LJ6ulyh9gsR7fBpfAp1KKOaEKPcTZ/25qlHPOA705+H72ACVd2fy
         LAg/AbAqvB1iObSOrGB4jMHkXWCh6rRHWpBKmnqRNoxqJywx/yUG3qr8zw+rJTt+uwva
         XpyAiGEAWuSqUpRmaKH1tcXfCkIDahjcYloGE07BzPSTW8dHfgT1WizKYHg4XvCF+d5O
         stpAwFoqwYmNfmDSCJTHYFXpWmTNvW3Csu4K0jbA6PjHmx1Flsmt01SfllrDiXzkz9Xj
         tI4LfECiHn4GY2oNdavM055kVjhwfAUt33ijHSW1yWWbQhWJISDlRvwkw2ujOsTZH/pK
         /low==
X-Forwarded-Encrypted: i=1; AJvYcCVVXBGEDfYUWAfpGc2z+ffWiqVj6Z7KcqCeACCXtLtLM6Tlc8TTJ412EflGxVllH8NsnB11xKC5kKbqAbcU8B1nrecApAiPqmsiJpqD3niuXBOG0d/Dfg3O+E3ToayEZSjbZmhuKz1Tbg==
X-Gm-Message-State: AOJu0Yznd6nHKDRWl0JqEEjyWLvSu5nV3fUn98HMWIkq006hsM3Wg5xW
	JnpMnpuUTNa1+WsvYa16hC5lgCm4xW5SqzwfOajfLZ5iGcLxtTIt
X-Google-Smtp-Source: AGHT+IGxtlWZi7OlzUSA5/V0aa2jJMNFKKU21CTRD337ilM22mWB124cbV/KHSY2+Nr88qWjg9DCVQ==
X-Received: by 2002:a17:906:3b46:b0:a6f:277c:d890 with SMTP id a640c23a62f3a-a6f60dc362amr688721966b.56.1718648990713;
        Mon, 17 Jun 2024 11:29:50 -0700 (PDT)
Received: from latitude-fedora.lan ([2001:8f8:183b:6864::d35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f8a6e58bdsm115397666b.187.2024.06.17.11.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 11:29:50 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 17 Jun 2024 22:28:57 +0400
Subject: [PATCH v5 7/8] arm64: dts: rockchip: Add OPP data for CPU cores on
 RK3588j
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-rk-dts-additions-v5-7-c1f5f3267f1e@gmail.com>
References: <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com>
In-Reply-To: <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Dragan Simic <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Diederik de Haas <didi.debian@cknow.org>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718648960; l=3675;
 i=alchark@gmail.com; s=20240125; h=from:subject:message-id;
 bh=9usg1860HeLN2D86kwAGVsch0yxyMQiUOvKvhiX96F0=;
 b=7qkTQpuDo2mnr2AksYS5eW7EJtXMddKluUT3j2BIeU1VziywewZDKtSMHT8+bGsuRwNzNZAFz
 b/X7C7+JSK/DwNleZDa/3++SYYeZ4QAj5dZ6D+I/8RWiDgsuLhaJa81
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=xRO8VeD3J5jhwe0za0aHt2LDumQr8cm0Ls7Jz3YGimk=

RK3588j is the 'industrial' variant of RK3588, and it uses a different
set of OPPs both in terms of allowed frequencies and in terms of
applicable voltages at each frequency setpoint.

Add the OPPs that apply to RK3588j (and apparently RK3588m too) to
enable dynamic CPU frequency scaling.

OPP values are derived from Rockchip downstream sources [1] by taking
only those OPPs which have the highest frequency for a given voltage
level and dropping the rest (if they are included, the kernel complains
at boot time about them being inefficient)

[1] https://github.com/rockchip-linux/kernel/blob/604cec4004abe5a96c734f2fab7b74809d2d742f/arch/arm64/boot/dts/rockchip/rk3588s.dtsi

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588j.dtsi | 108 ++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588j.dtsi b/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
index 0bbeee399a63..b7e69553857b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
@@ -5,3 +5,111 @@
  */
 
 #include "rk3588-extra.dtsi"
+
+/ {
+	cluster0_opp_table: opp-table-cluster0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-1416000000 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <750000 750000 950000>;
+			clock-latency-ns = <40000>;
+			opp-suspend;
+		};
+		opp-1608000000 {
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <887500 887500 950000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1704000000 {
+			opp-hz = /bits/ 64 <1704000000>;
+			opp-microvolt = <937500 937500 950000>;
+			clock-latency-ns = <40000>;
+		};
+	};
+
+	cluster1_opp_table: opp-table-cluster1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-1416000000 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <750000 750000 950000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1608000000 {
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <787500 787500 950000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <875000 875000 950000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-2016000000 {
+			opp-hz = /bits/ 64 <2016000000>;
+			opp-microvolt = <950000 950000 950000>;
+			clock-latency-ns = <40000>;
+		};
+	};
+
+	cluster2_opp_table: opp-table-cluster2 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-1416000000 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <750000 750000 950000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1608000000 {
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <787500 787500 950000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <875000 875000 950000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-2016000000 {
+			opp-hz = /bits/ 64 <2016000000>;
+			opp-microvolt = <950000 950000 950000>;
+			clock-latency-ns = <40000>;
+		};
+	};
+};
+
+&cpu_b0 {
+	operating-points-v2 = <&cluster1_opp_table>;
+};
+
+&cpu_b1 {
+	operating-points-v2 = <&cluster1_opp_table>;
+};
+
+&cpu_b2 {
+	operating-points-v2 = <&cluster2_opp_table>;
+};
+
+&cpu_b3 {
+	operating-points-v2 = <&cluster2_opp_table>;
+};
+
+&cpu_l0 {
+	operating-points-v2 = <&cluster0_opp_table>;
+};
+
+&cpu_l1 {
+	operating-points-v2 = <&cluster0_opp_table>;
+};
+
+&cpu_l2 {
+	operating-points-v2 = <&cluster0_opp_table>;
+};
+
+&cpu_l3 {
+	operating-points-v2 = <&cluster0_opp_table>;
+};

-- 
2.45.2


