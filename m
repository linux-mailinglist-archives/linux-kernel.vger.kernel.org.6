Return-Path: <linux-kernel+bounces-218141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB6A90B9AF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53BCB28810B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4703219883C;
	Mon, 17 Jun 2024 18:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQdlLyXZ"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEEA19923F;
	Mon, 17 Jun 2024 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648990; cv=none; b=WwoJ23rkYJvvewEj6SbrogouHQOKeGLRaRE5ioTRaGr6Nrt8mhlESTDfgASuaT2v22J/gzZ2LrrBOtlL81NBwjFx4XBgNPKDF9l0geSKx+DSpjUduwoWtBeNIyW0qGStG8z4VACxGr3WEYr+QKVwg1cVzkSSJilA9vVhRREe/Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648990; c=relaxed/simple;
	bh=FnSNCV3/dY8Km0myfhW8fZDwqPdlrAVPS2pOSSMxu0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J1AdGA4W6+HRSeKhpChY7cMLxgHXLLOR+kwBigBOuTkK8nLVsWphwY+wc5B0zcU4kEM+wouu0WG9LCNFOzmaR1QAwZIQWp+IU/E+aJjIRsCFbEK05VzjCCcr9LA/xQRSrv6C+lofSb8WAodmew8pEqFBzKcRIyEa8fALFLxiCAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQdlLyXZ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6e43dad8ecso808563066b.1;
        Mon, 17 Jun 2024 11:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718648987; x=1719253787; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KKQczdLEOKiZY5ksbDm+uWKIxh3GrP7H2rbcDsplBLE=;
        b=QQdlLyXZnuP5xx2tiYj00kohq95szmmwTSvXUe7OdcTy8SXdV+UAWlo1vgVvP8ZhyV
         FVKrfVt8LcJIrG2Q8eoOsZm/SqmNH1FhyTe/r6REbufmfGSKrU9YBRmF3NlxyNRBkX4e
         SuLsFfDg6fLIKb5ncqZa7ibAvV22HoF1HCV/B2XVFzC5kH4TNO3ZchGE/+O8rAxvnmV+
         mcnDI5dK1q7/wTCxzSmoQFyrFFjbvn6qaalipGGme9wcohDUhLMXoaZPi2pmEl+Wpxy7
         0HZG5v2BtmeficUbHWE5+Dwsid9N2ZjA03kbw1D3S7iUG9OU9vuHNfzQiYTB9/xCZ4Xa
         A3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718648987; x=1719253787;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKQczdLEOKiZY5ksbDm+uWKIxh3GrP7H2rbcDsplBLE=;
        b=RmP1SiEH2qQZ2G30UcHgeJ8TPdyC0WiaUWfmUbmZfMvS3UwRV0KoAUjcjbEiG454nw
         N9g9KUFMgRoJ+41RpZiyWtXpLSpz7f0GXWvLgN5r98N0UoQ0Rrkx+cEMfPoF1BX3dFwy
         lKALnwM91YzAID29+BqS7Wan54kEBunArG7zB43+yCvKi6A25s79p6qLIEH+OqVPFuaC
         wEVEkc4s9OY5yYoQ+eH6F8j8uEaboAkEJYV0HE2H7HgcPpFc3uz0PPW/CEodyTbvZHsi
         AyRQKTPuthBekWmZXEhtl8zp2mnpWVcYj0ofA988/LceeSuxYMzF1vTnn/OMBSP6Gt8k
         5HpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzOgZTBixg/Ho7KTUXMuKuzVmhyZn6yzC51He2dnbhyR3WI0up9R4yxiSeDlRtuHdAVZERixhixghXazxe96iVySqJKktT7tzpVvc6W5TAohTIWZM7OjxGK5hqypsswe5S+EkcQNBU8w==
X-Gm-Message-State: AOJu0Yzdm6jH/YkwGGpCTMKw4s3xgpq4BAhQQ5Pb8nFFcc/D4ZraEOgm
	A8FKJFdyqFH4eajI6T0Z/IBatCSoCEC8PGXbJEDpm/ewFFOerEEt
X-Google-Smtp-Source: AGHT+IGmWbahDJPDjyV8+kQptapzHcWa85iX57RgFcz6qMDU6c0xaMiQttmChlLXgAzjRXUEraObFw==
X-Received: by 2002:a17:906:3643:b0:a6f:6bad:b5a9 with SMTP id a640c23a62f3a-a6f94c047c4mr29901466b.7.1718648986800;
        Mon, 17 Jun 2024 11:29:46 -0700 (PDT)
Received: from latitude-fedora.lan ([2001:8f8:183b:6864::d35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f8a6e58bdsm115397666b.187.2024.06.17.11.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 11:29:46 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 17 Jun 2024 22:28:56 +0400
Subject: [PATCH v5 6/8] arm64: dts: rockchip: Add OPP data for CPU cores on
 RK3588
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-rk-dts-additions-v5-6-c1f5f3267f1e@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718648960; l=6206;
 i=alchark@gmail.com; s=20240125; h=from:subject:message-id;
 bh=FnSNCV3/dY8Km0myfhW8fZDwqPdlrAVPS2pOSSMxu0E=;
 b=NSfEjqlSUm3OIowcgGHMo+o9tFxYS2NjNAH5PvVTjFVqj4xfZ8uqiB/bGBy4tNb42b3PJ/FMu
 tqeYJL5KUQWCA+VAI+O9+/OeQxYWSrwBRQu2I7U6D0CUG7O7elFsnjA
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=xRO8VeD3J5jhwe0za0aHt2LDumQr8cm0Ls7Jz3YGimk=

By default the CPUs on RK3588 start up in a conservative performance
mode. Add frequency and voltage mappings to the device tree to enable
dynamic scaling via cpufreq.

OPP values are adapted from Radxa's downstream kernel for Rock 5B [1],
stripping them down to the minimum frequency and voltage combinations
as expected by the generic upstream cpufreq-dt driver, and also dropping
those OPPs that don't differ in voltage but only in frequency (keeping
the top frequency OPP in each case).

Note that this patch ignores voltage scaling for the CPU memory
interface which the downstream kernel does through a custom cpufreq
driver, and which is why the downstream version has two sets of voltage
values for each OPP (the second one being meant for the memory
interface supply regulator). This is done instead via regulator
coupling between CPU and memory interface supplies on affected boards.

This has been tested on Rock 5B with u-boot 2023.11 compiled from
Collabora's integration tree [2] with binary bl31 and appears to be
stable both under active cooling and passive cooling (with throttling)

[1] https://github.com/radxa/kernel/blob/stable-5.10-rock5/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
[2] https://gitlab.collabora.com/hardware-enablement/rockchip-3588/u-boot

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi | 149 +++++++++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588.dtsi     |   1 +
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi    |   1 +
 3 files changed, 151 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi
new file mode 100644
index 000000000000..35bbc3c2134f
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/ {
+	cluster0_opp_table: opp-table-cluster0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <675000 675000 950000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <712500 712500 950000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1416000000 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <762500 762500 950000>;
+			clock-latency-ns = <40000>;
+			opp-suspend;
+		};
+		opp-1608000000 {
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <850000 850000 950000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <950000 950000 950000>;
+			clock-latency-ns = <40000>;
+		};
+	};
+
+	cluster1_opp_table: opp-table-cluster1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <675000 675000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1416000000 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <725000 725000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1608000000 {
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <762500 762500 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <850000 850000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-2016000000 {
+			opp-hz = /bits/ 64 <2016000000>;
+			opp-microvolt = <925000 925000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-2208000000 {
+			opp-hz = /bits/ 64 <2208000000>;
+			opp-microvolt = <987500 987500 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-2400000000 {
+			opp-hz = /bits/ 64 <2400000000>;
+			opp-microvolt = <1000000 1000000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+	};
+
+	cluster2_opp_table: opp-table-cluster2 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <675000 675000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1416000000 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <725000 725000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1608000000 {
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <762500 762500 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <850000 850000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-2016000000 {
+			opp-hz = /bits/ 64 <2016000000>;
+			opp-microvolt = <925000 925000 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-2208000000 {
+			opp-hz = /bits/ 64 <2208000000>;
+			opp-microvolt = <987500 987500 1000000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-2400000000 {
+			opp-hz = /bits/ 64 <2400000000>;
+			opp-microvolt = <1000000 1000000 1000000>;
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
diff --git a/arch/arm64/boot/dts/rockchip/rk3588.dtsi b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
index 0bbeee399a63..7462cc1e1007 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
@@ -5,3 +5,4 @@
  */
 
 #include "rk3588-extra.dtsi"
+#include "rk3588-opp.dtsi"
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index a379269147c4..c7fecf8fe7ec 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -5,3 +5,4 @@
  */
 
 #include "rk3588-base.dtsi"
+#include "rk3588-opp.dtsi"

-- 
2.45.2


