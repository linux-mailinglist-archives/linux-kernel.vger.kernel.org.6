Return-Path: <linux-kernel+bounces-203868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7477F8FE176
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D6281C2150C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC4813D516;
	Thu,  6 Jun 2024 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a33ZkSh/"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FD319D8B5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663701; cv=none; b=koLQRTuzehs3Kjg+KhV/duz3wIQf42JiY6Q9bKbRUNWvIXfPTVW4vUXMOWjGPzXjoQRljcPXKXHb/ePzEQBh688l/V6otzuKzw4HSk24OOw6MPCz3F4F2FDfgRIlCl20GUZfOghvGH5HZ8jZGvlrJQT9ox05pK+993B10FFqJK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663701; c=relaxed/simple;
	bh=tl3H+UTcHVmPxt9zBws9MAHMOmP/ihRvaabSVS/9m/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yd9Age25ZXBEuhvZItbg+UjuGz9Ti5aGUDVJugN7WtsdPpRULmTsqZwUQxwGVZHmVEQSBvPlnEmICbmJTXpGi5ILAJUy1KXySe4aipqXiDWvzQVG8eY+L5lgdaMX3jNPpXsmA7HkCgdffSthdl07UHVKi83sd/xaMn00odwE7Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a33ZkSh/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4215f694749so2118925e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717663698; x=1718268498; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6OHHCCXmw/6bmz1M3IfcTnLr1KRtx4diLLcV5lamp0=;
        b=a33ZkSh/F+CLpyTW1RSPF3x6DuZW8pJdRile/75cDLMOIo+ebPCXqDYF2xUrRKD3xX
         wl1U8+PJZA1ywpG23mnx7pbE85wLxtuiuVTmOqfEWEXBj9EoiTtfvDKLDzpROLGdW0n9
         mdrCEILAKkMV3280aNdFvqw59FH2FlhnqkcwPufZZJYrokoaMQnB9FTtjyiBmJAO896+
         Ktln3g38CWKiS4RbK9leqNk87fccmjWMa60SE/6RefEjFguzGIgIlzvQ2PWQqvHtmKgY
         ohl2sVhXqJLkucPt9vzJGRpwzEKJMTbw7dF5JRBv7Db08frYrwlK7vSV1zWhvQbMomKh
         Z69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717663698; x=1718268498;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6OHHCCXmw/6bmz1M3IfcTnLr1KRtx4diLLcV5lamp0=;
        b=Q4m4YZyzp1Ai3t1YlMyxCIF318oicl+nE3ZAZBn1crB4wD7L+JfMfTzjh+viUnjkaZ
         CU3u9bbYVLfdtc1As41Tg/Yz4nQIrVeMTnS30uL/s9Y4rlfeg65y3Hgu82W4X8CKA4wB
         N+tnjASilKtWb8fzpb2HXC+dzNj7VUpmf83xIrjnFKS+oH5jjexnR2quB0Ji6+xKIYOF
         xRLupDP7vcl9XtPDnzt7g7T3O6w2DuuoMF5aIHXv/vv9Axb8MoAMhiWuOaBuJO2hWjpG
         NAZRdWkdNaImTJ8Err7PyJH8qOKoDqZ3DIVMta7CdFT1gWGUMVB7DHz2SpokuAGddanG
         sBww==
X-Forwarded-Encrypted: i=1; AJvYcCUs4o4i/PNAAoKSqW4US3awXOUZEjoqLNlESjI+uG2q9CphAdmqvh/6cxRivIr9kJ3P3c2ngsgjiDDIXxnVDo5eu3ZDWpww6MucbDNg
X-Gm-Message-State: AOJu0Yz6raT9xICtocOnxFQmq3CGXpxhSuVsSyPQhh55oM2aAj+AV7cr
	K8AMj9eC2MnnlubXB2EzGigef/vmxL7kDRwJDpolKeEilNAWDzDjUyv3ajG+G4W2D8hbQvsVEIs
	S
X-Google-Smtp-Source: AGHT+IH+f9N41jKu7yGAWRjAEjcoye90s8RyP3e82L51Lfe+HhWRkITUaejtLiPLrCN/vvA0R4rDKA==
X-Received: by 2002:a05:600c:19c9:b0:421:52ce:6878 with SMTP id 5b1f17b1804b1-4215632d091mr41108525e9.29.1717663697734;
        Thu, 06 Jun 2024 01:48:17 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2c690dsm14227445e9.34.2024.06.06.01.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:48:17 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 06 Jun 2024 10:48:09 +0200
Subject: [PATCH 02/12] arm64: dts: amlogic: move ao_pinctrl into aobus
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-topic-amlogic-upstream-bindings-fixes-dts-v1-2-62e812729541@linaro.org>
References: <20240606-topic-amlogic-upstream-bindings-fixes-dts-v1-0-62e812729541@linaro.org>
In-Reply-To: <20240606-topic-amlogic-upstream-bindings-fixes-dts-v1-0-62e812729541@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12903;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=tl3H+UTcHVmPxt9zBws9MAHMOmP/ihRvaabSVS/9m/s=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmYXfKtjTh/6E7KMQquhZx7uNekZ5DQr5QRH9o7BLD
 r0EezK2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZmF3ygAKCRB33NvayMhJ0b9tD/
 0fN6N7nyG9gvaI7iirKChzsj1lg5p/BEKaQXnl5QXXAklJ4Ad8d6N/dIitOIKQebgr+QZlAmOK6O1U
 yt8gRv6QaIu/IobE/Ay+3ZwDGo74hCPALHihKMeHMkxpu3oZYliBrD3o9Y0KVyid8MAmtvNphwCorA
 n79aUDM07CxugvSLRQSjMOqO3WMyD2C4FLxnDkSU7kBhI5MDeEtWYAf76WvT517YnCWfknLxBIcZtj
 NKWtS0Vm0CrjeugQYlxjyj2DfCIaXLWJApjpv3iC+iecg2L939Sjk7xZunkqdGeFohidsG9T+yn110
 zLagKPxCMFSDE70R8yZwTWztndqrB5bsFTEHBZ9gXFES+3bl+I+mp7cuYTfp9dEfIeOad6a0u/16NV
 fUOsI5kgUvNks4rDWcMwHagR4Dg+tXjbUT6ei2IYmLyVO2Uv0EcbaQ+ML+J1+xRnrTv1y5IiQoerOz
 TTjNdEKoDQ4D3lRp5yvubRvAxgJTtv1WivsCMx0/DCRutwguwTO+PQMYSbuFbIJOn8nA1n8m00sMeK
 1uCkrWPsrKC+56clITaGR7dRKdGcbSbjlzVnbv531F/wxfX60ZPNzAEIN+ju+LA81Kwh6zpojDtwQL
 6FKOa2DQmmhdM+Mm8pLcHFtwhwY4m0odlUj+DRzJXzGhZ0ocE7anNzgs3R7A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The AO pinctrl was mis-described as beeing part of AO rti sysctrl, move it
it into aobus like it's also done in GX SoCs, and remove the now invalid
'#address-cells', '#size-cells' & 'ranges from the sys-ctrl@0 node.

This fixes:
sys-ctrl@0: '#address-cells', '#size-cells', 'ranges' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 427 +++++++++++-----------
 1 file changed, 212 insertions(+), 215 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index b058ed78faf0..138fb18c6480 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -1741,9 +1741,6 @@ rti: sys-ctrl@0 {
 				compatible = "amlogic,meson-gx-ao-sysctrl",
 					     "simple-mfd", "syscon";
 				reg = <0x0 0x0 0x0 0x100>;
-				#address-cells = <2>;
-				#size-cells = <2>;
-				ranges = <0x0 0x0 0x0 0x0 0x0 0x100>;
 
 				clkc_AO: clock-controller {
 					compatible = "amlogic,meson-g12a-aoclkc";
@@ -1752,278 +1749,278 @@ clkc_AO: clock-controller {
 					clocks = <&xtal>, <&clkc CLKID_CLK81>;
 					clock-names = "xtal", "mpeg-clk";
 				};
+			};
 
-				ao_pinctrl: pinctrl {
-					compatible = "amlogic,meson-g12a-aobus-pinctrl";
-					#address-cells = <2>;
-					#size-cells = <2>;
-					ranges;
+			ao_pinctrl: pinctrl@14 {
+				compatible = "amlogic,meson-g12a-aobus-pinctrl";
+				#address-cells = <2>;
+				#size-cells = <2>;
+				ranges;
+
+				gpio_ao: bank@14 {
+					reg = <0x0 0x14 0x0 0x8>,
+					      <0x0 0x1c 0x0 0x8>,
+					      <0x0 0x24 0x0 0x14>;
+					reg-names = "mux",
+						    "ds",
+						    "gpio";
+					gpio-controller;
+					#gpio-cells = <2>;
+					gpio-ranges = <&ao_pinctrl 0 0 15>;
+				};
 
-					gpio_ao: bank@14 {
-						reg = <0x0 0x14 0x0 0x8>,
-						      <0x0 0x1c 0x0 0x8>,
-						      <0x0 0x24 0x0 0x14>;
-						reg-names = "mux",
-							    "ds",
-							    "gpio";
-						gpio-controller;
-						#gpio-cells = <2>;
-						gpio-ranges = <&ao_pinctrl 0 0 15>;
+				i2c_ao_sck_pins: i2c_ao_sck_pins {
+					mux {
+						groups = "i2c_ao_sck";
+						function = "i2c_ao";
+						bias-disable;
+						drive-strength-microamp = <3000>;
 					};
+				};
 
-					i2c_ao_sck_pins: i2c_ao_sck_pins {
-						mux {
-							groups = "i2c_ao_sck";
-							function = "i2c_ao";
-							bias-disable;
-							drive-strength-microamp = <3000>;
-						};
+				i2c_ao_sda_pins: i2c_ao_sda {
+					mux {
+						groups = "i2c_ao_sda";
+						function = "i2c_ao";
+						bias-disable;
+						drive-strength-microamp = <3000>;
 					};
+				};
 
-					i2c_ao_sda_pins: i2c_ao_sda {
-						mux {
-							groups = "i2c_ao_sda";
-							function = "i2c_ao";
-							bias-disable;
-							drive-strength-microamp = <3000>;
-						};
+				i2c_ao_sck_e_pins: i2c_ao_sck_e {
+					mux {
+						groups = "i2c_ao_sck_e";
+						function = "i2c_ao";
+						bias-disable;
+						drive-strength-microamp = <3000>;
 					};
+				};
 
-					i2c_ao_sck_e_pins: i2c_ao_sck_e {
-						mux {
-							groups = "i2c_ao_sck_e";
-							function = "i2c_ao";
-							bias-disable;
-							drive-strength-microamp = <3000>;
-						};
+				i2c_ao_sda_e_pins: i2c_ao_sda_e {
+					mux {
+						groups = "i2c_ao_sda_e";
+						function = "i2c_ao";
+						bias-disable;
+						drive-strength-microamp = <3000>;
 					};
+				};
 
-					i2c_ao_sda_e_pins: i2c_ao_sda_e {
-						mux {
-							groups = "i2c_ao_sda_e";
-							function = "i2c_ao";
-							bias-disable;
-							drive-strength-microamp = <3000>;
-						};
-					};
-
-					mclk0_ao_pins: mclk0-ao {
-						mux {
-							groups = "mclk0_ao";
-							function = "mclk0_ao";
-							bias-disable;
-							drive-strength-microamp = <3000>;
-						};
+				mclk0_ao_pins: mclk0-ao {
+					mux {
+						groups = "mclk0_ao";
+						function = "mclk0_ao";
+						bias-disable;
+						drive-strength-microamp = <3000>;
 					};
+				};
 
-					tdm_ao_b_din0_pins: tdm-ao-b-din0 {
-						mux {
-							groups = "tdm_ao_b_din0";
-							function = "tdm_ao_b";
-							bias-disable;
-						};
+				tdm_ao_b_din0_pins: tdm-ao-b-din0 {
+					mux {
+						groups = "tdm_ao_b_din0";
+						function = "tdm_ao_b";
+						bias-disable;
 					};
+				};
 
-					spdif_ao_out_pins: spdif-ao-out {
-						mux {
-							groups = "spdif_ao_out";
-							function = "spdif_ao_out";
-							drive-strength-microamp = <500>;
-							bias-disable;
-						};
+				spdif_ao_out_pins: spdif-ao-out {
+					mux {
+						groups = "spdif_ao_out";
+						function = "spdif_ao_out";
+						drive-strength-microamp = <500>;
+						bias-disable;
 					};
+				};
 
-					tdm_ao_b_din1_pins: tdm-ao-b-din1 {
-						mux {
-							groups = "tdm_ao_b_din1";
-							function = "tdm_ao_b";
-							bias-disable;
-						};
+				tdm_ao_b_din1_pins: tdm-ao-b-din1 {
+					mux {
+						groups = "tdm_ao_b_din1";
+						function = "tdm_ao_b";
+						bias-disable;
 					};
+				};
 
-					tdm_ao_b_din2_pins: tdm-ao-b-din2 {
-						mux {
-							groups = "tdm_ao_b_din2";
-							function = "tdm_ao_b";
-							bias-disable;
-						};
+				tdm_ao_b_din2_pins: tdm-ao-b-din2 {
+					mux {
+						groups = "tdm_ao_b_din2";
+						function = "tdm_ao_b";
+						bias-disable;
 					};
+				};
 
-					tdm_ao_b_dout0_pins: tdm-ao-b-dout0 {
-						mux {
-							groups = "tdm_ao_b_dout0";
-							function = "tdm_ao_b";
-							bias-disable;
-							drive-strength-microamp = <3000>;
-						};
+				tdm_ao_b_dout0_pins: tdm-ao-b-dout0 {
+					mux {
+						groups = "tdm_ao_b_dout0";
+						function = "tdm_ao_b";
+						bias-disable;
+						drive-strength-microamp = <3000>;
 					};
+				};
 
-					tdm_ao_b_dout1_pins: tdm-ao-b-dout1 {
-						mux {
-							groups = "tdm_ao_b_dout1";
-							function = "tdm_ao_b";
-							bias-disable;
-							drive-strength-microamp = <3000>;
-						};
+				tdm_ao_b_dout1_pins: tdm-ao-b-dout1 {
+					mux {
+						groups = "tdm_ao_b_dout1";
+						function = "tdm_ao_b";
+						bias-disable;
+						drive-strength-microamp = <3000>;
 					};
+				};
 
-					tdm_ao_b_dout2_pins: tdm-ao-b-dout2 {
-						mux {
-							groups = "tdm_ao_b_dout2";
-							function = "tdm_ao_b";
-							bias-disable;
-							drive-strength-microamp = <3000>;
-						};
+				tdm_ao_b_dout2_pins: tdm-ao-b-dout2 {
+					mux {
+						groups = "tdm_ao_b_dout2";
+						function = "tdm_ao_b";
+						bias-disable;
+						drive-strength-microamp = <3000>;
 					};
+				};
 
-					tdm_ao_b_fs_pins: tdm-ao-b-fs {
-						mux {
-							groups = "tdm_ao_b_fs";
-							function = "tdm_ao_b";
-							bias-disable;
-							drive-strength-microamp = <3000>;
-						};
+				tdm_ao_b_fs_pins: tdm-ao-b-fs {
+					mux {
+						groups = "tdm_ao_b_fs";
+						function = "tdm_ao_b";
+						bias-disable;
+						drive-strength-microamp = <3000>;
 					};
+				};
 
-					tdm_ao_b_sclk_pins: tdm-ao-b-sclk {
-						mux {
-							groups = "tdm_ao_b_sclk";
-							function = "tdm_ao_b";
-							bias-disable;
-							drive-strength-microamp = <3000>;
-						};
+				tdm_ao_b_sclk_pins: tdm-ao-b-sclk {
+					mux {
+						groups = "tdm_ao_b_sclk";
+						function = "tdm_ao_b";
+						bias-disable;
+						drive-strength-microamp = <3000>;
 					};
+				};
 
-					tdm_ao_b_slv_fs_pins: tdm-ao-b-slv-fs {
-						mux {
-							groups = "tdm_ao_b_slv_fs";
-							function = "tdm_ao_b";
-							bias-disable;
-						};
+				tdm_ao_b_slv_fs_pins: tdm-ao-b-slv-fs {
+					mux {
+						groups = "tdm_ao_b_slv_fs";
+						function = "tdm_ao_b";
+						bias-disable;
 					};
+				};
 
-					tdm_ao_b_slv_sclk_pins: tdm-ao-b-slv-sclk {
-						mux {
-							groups = "tdm_ao_b_slv_sclk";
-							function = "tdm_ao_b";
-							bias-disable;
-						};
+				tdm_ao_b_slv_sclk_pins: tdm-ao-b-slv-sclk {
+					mux {
+						groups = "tdm_ao_b_slv_sclk";
+						function = "tdm_ao_b";
+						bias-disable;
 					};
+				};
 
-					uart_ao_a_pins: uart-a-ao {
-						mux {
-							groups = "uart_ao_a_tx",
-								 "uart_ao_a_rx";
-							function = "uart_ao_a";
-							bias-disable;
-						};
+				uart_ao_a_pins: uart-a-ao {
+					mux {
+						groups = "uart_ao_a_tx",
+							 "uart_ao_a_rx";
+						function = "uart_ao_a";
+						bias-disable;
 					};
+				};
 
-					uart_ao_a_cts_rts_pins: uart-ao-a-cts-rts {
-						mux {
-							groups = "uart_ao_a_cts",
-								 "uart_ao_a_rts";
-							function = "uart_ao_a";
-							bias-disable;
-						};
+				uart_ao_a_cts_rts_pins: uart-ao-a-cts-rts {
+					mux {
+						groups = "uart_ao_a_cts",
+							 "uart_ao_a_rts";
+						function = "uart_ao_a";
+						bias-disable;
 					};
+				};
 
-					uart_ao_b_2_3_pins: uart-ao-b-2-3 {
-						mux {
-							groups = "uart_ao_b_tx_2",
-								 "uart_ao_b_rx_3";
-							function = "uart_ao_b";
-							bias-disable;
-						};
+				uart_ao_b_2_3_pins: uart-ao-b-2-3 {
+					mux {
+						groups = "uart_ao_b_tx_2",
+							 "uart_ao_b_rx_3";
+						function = "uart_ao_b";
+						bias-disable;
 					};
+				};
 
-					uart_ao_b_8_9_pins: uart-ao-b-8-9 {
-						mux {
-							groups = "uart_ao_b_tx_8",
-								 "uart_ao_b_rx_9";
-							function = "uart_ao_b";
-							bias-disable;
-						};
+				uart_ao_b_8_9_pins: uart-ao-b-8-9 {
+					mux {
+						groups = "uart_ao_b_tx_8",
+							 "uart_ao_b_rx_9";
+						function = "uart_ao_b";
+						bias-disable;
 					};
+				};
 
-					uart_ao_b_cts_rts_pins: uart-ao-b-cts-rts {
-						mux {
-							groups = "uart_ao_b_cts",
-								 "uart_ao_b_rts";
-							function = "uart_ao_b";
-							bias-disable;
-						};
+				uart_ao_b_cts_rts_pins: uart-ao-b-cts-rts {
+					mux {
+						groups = "uart_ao_b_cts",
+							 "uart_ao_b_rts";
+						function = "uart_ao_b";
+						bias-disable;
 					};
+				};
 
-					pwm_a_e_pins: pwm-a-e {
-						mux {
-							groups = "pwm_a_e";
-							function = "pwm_a_e";
-							bias-disable;
-						};
+				pwm_a_e_pins: pwm-a-e {
+					mux {
+						groups = "pwm_a_e";
+						function = "pwm_a_e";
+						bias-disable;
 					};
+				};
 
-					pwm_ao_a_pins: pwm-ao-a {
-						mux {
-							groups = "pwm_ao_a";
-							function = "pwm_ao_a";
-							bias-disable;
-						};
+				pwm_ao_a_pins: pwm-ao-a {
+					mux {
+						groups = "pwm_ao_a";
+						function = "pwm_ao_a";
+						bias-disable;
 					};
+				};
 
-					pwm_ao_b_pins: pwm-ao-b {
-						mux {
-							groups = "pwm_ao_b";
-							function = "pwm_ao_b";
-							bias-disable;
-						};
+				pwm_ao_b_pins: pwm-ao-b {
+					mux {
+						groups = "pwm_ao_b";
+						function = "pwm_ao_b";
+						bias-disable;
 					};
+				};
 
-					pwm_ao_c_4_pins: pwm-ao-c-4 {
-						mux {
-							groups = "pwm_ao_c_4";
-							function = "pwm_ao_c";
-							bias-disable;
-						};
+				pwm_ao_c_4_pins: pwm-ao-c-4 {
+					mux {
+						groups = "pwm_ao_c_4";
+						function = "pwm_ao_c";
+						bias-disable;
 					};
+				};
 
-					pwm_ao_c_6_pins: pwm-ao-c-6 {
-						mux {
-							groups = "pwm_ao_c_6";
-							function = "pwm_ao_c";
-							bias-disable;
-						};
+				pwm_ao_c_6_pins: pwm-ao-c-6 {
+					mux {
+						groups = "pwm_ao_c_6";
+						function = "pwm_ao_c";
+						bias-disable;
 					};
+				};
 
-					pwm_ao_d_5_pins: pwm-ao-d-5 {
-						mux {
-							groups = "pwm_ao_d_5";
-							function = "pwm_ao_d";
-							bias-disable;
-						};
+				pwm_ao_d_5_pins: pwm-ao-d-5 {
+					mux {
+						groups = "pwm_ao_d_5";
+						function = "pwm_ao_d";
+						bias-disable;
 					};
+				};
 
-					pwm_ao_d_10_pins: pwm-ao-d-10 {
-						mux {
-							groups = "pwm_ao_d_10";
-							function = "pwm_ao_d";
-							bias-disable;
-						};
+				pwm_ao_d_10_pins: pwm-ao-d-10 {
+					mux {
+						groups = "pwm_ao_d_10";
+						function = "pwm_ao_d";
+						bias-disable;
 					};
+				};
 
-					pwm_ao_d_e_pins: pwm-ao-d-e {
-						mux {
-							groups = "pwm_ao_d_e";
-							function = "pwm_ao_d";
-						};
+				pwm_ao_d_e_pins: pwm-ao-d-e {
+					mux {
+						groups = "pwm_ao_d_e";
+						function = "pwm_ao_d";
 					};
+				};
 
-					remote_input_ao_pins: remote-input-ao {
-						mux {
-							groups = "remote_ao_input";
-							function = "remote_ao_input";
-							bias-disable;
-						};
+				remote_input_ao_pins: remote-input-ao {
+					mux {
+						groups = "remote_ao_input";
+						function = "remote_ao_input";
+						bias-disable;
 					};
 				};
 			};

-- 
2.34.1


