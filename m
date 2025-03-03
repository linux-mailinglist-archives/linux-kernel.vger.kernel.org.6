Return-Path: <linux-kernel+bounces-544538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0AFA4E2BA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9086881EA5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3E7204C1A;
	Tue,  4 Mar 2025 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b="DuYMaTJs"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC27523A9AB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100228; cv=pass; b=DEg5+VdJHnLJGRKJcVUA0ue1gRe3b8gu+2Pf3mGNZ9JJ7BIVMPOGCl08xo6+s720G3Qur/0XycE3Nqr18md2ABTN860SddlwHHkEgC/VtKueNGnPQ2xdP05Xo5XWXY0kzAXEzLoNdL2fqUGOtcfRpW1KPdCZQuRH2IPtv/ISJVY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100228; c=relaxed/simple;
	bh=IudflqImdm+ZwbpvNjpoNoGi2CoQwHJjQFVz8r3/Sj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G56nJ3QTZJjTD75oDR+tDnlTd3Eu4igN8TcyB00d8NTrYM0z7DgCQvOD5wi2S4KDv1JVtnYCYpDBD/EApRIhLQdcFwyKPyvhwwq/W2iCHEYmObAqMZKOvVVRn2RaHQ+idsfmQnG910quGm/nBdjplXKxaGJ7AprKyueTMNMJf20=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b=DuYMaTJs; arc=pass smtp.client-ip=136.143.188.94; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id EAE9940D0C8A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:57:04 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=kingxukai@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=DuYMaTJs
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dvX4vSLzFxsN
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:52:40 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 43BB442732; Tue,  4 Mar 2025 17:52:34 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b=DuYMaTJs
X-Envelope-From: <linux-kernel+bounces-541696-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b=DuYMaTJs
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 3BC6942461
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:24:09 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id C74B73064C07
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:24:08 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9DDB3AB2ED
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC80212D66;
	Mon,  3 Mar 2025 12:22:18 +0000 (UTC)
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054B2212B02;
	Mon,  3 Mar 2025 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004535; cv=pass; b=JClR+cplaTw6XeeNS4xY0hkiwNrHfDU/4aRId67wsV8xIdrlEDdk0DHFPE00jgypA7wmdEzIvmwncttTDXcsVyJ49jnGjCCTZpO4kDqku2YtvJPjIT+nf6ZQEzr92kqcyrtrKDhWPHoAEFrcGZt1td25870mltZcCVKFag6yTQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004535; c=relaxed/simple;
	bh=IudflqImdm+ZwbpvNjpoNoGi2CoQwHJjQFVz8r3/Sj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IGnfdL2+L8hlhUkhEaMFleHGfKDhKhWGXshAOrtaC5i8hKwphG0aV3CLYCNSHZHECc3q8HoolooZzq+sT0Q5MsrdbZ+jOwZvZK8RhgIYLtYhoIE6snzfwVJneJ5Q0GLvBsdRMPHFrRV0ir/uzaYadTq9Da4I2kYE/KBl4REFpxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b=DuYMaTJs; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1741004505; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VU/H2PZZzU95D3j8gNHRHKj0WtOBpiPI98KgbepbzlvJIKbnDU3qfSgYD1p0gWmeZgDMa95zh5hi5nge8mDwJB2UyPZHH5Ivrj9x8XgLexDX39BmLW5lRHKZFxmDCC57KXyq58fBx75bxer1GqWhSJwFvlVIdGgqdCRi+/xCyGY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741004505; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EPlebBCWRgSBAYpdwC7xAZIbyevkA4TQGmd5kkCqttQ=; 
	b=Ji/wcOeQ3aoSY0tnUXO6IZqOki1B7LB/jN46tQ9ZP4mPTT+PwoS6AuyxU6I5DhMSYk5YpuetT8OdGwlTbyxb+CkYD1Ycre0auVkJEiR9m5zUGQz+i0pu6ETEDWamq1OBKEuGWR1LnEoKajN9wOk4PH1/DxLfrCvw51Z5DdPEKZI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=kingxukai@zohomail.com;
	dmarc=pass header.from=<kingxukai@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741004505;
	s=zm2022; d=zohomail.com; i=kingxukai@zohomail.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=EPlebBCWRgSBAYpdwC7xAZIbyevkA4TQGmd5kkCqttQ=;
	b=DuYMaTJsOHfjiX9+2+C7LGiuI22AFbdTzNCjhb44sxpcGTYuaZcY36v/guV1dCdt
	ZKDsHCdxqDO2Ec8s1Ord0BxzVHnQWBS1wb2oYQ6XZ/9G3aJMCjCggF1S1tpH+hl5XXp
	PHBvdYtn8oDUyor5o2rMEdSx0JPDse7gA3QUA6qo=
Received: by mx.zohomail.com with SMTPS id 1741004501200414.4200697404116;
	Mon, 3 Mar 2025 04:21:41 -0800 (PST)
From: Xukai Wang <kingxukai@zohomail.com>
Date: Mon, 03 Mar 2025 20:20:39 +0800
Subject: [PATCH v5 3/3] riscv: dts: canaan: Add clock definition for K230
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-b4-k230-clk-v5-3-748d121283e3@zohomail.com>
References: <20250303-b4-k230-clk-v5-0-748d121283e3@zohomail.com>
In-Reply-To: <20250303-b4-k230-clk-v5-0-748d121283e3@zohomail.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Xukai Wang <kingxukai@zohomail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Troy Mitchell <TroyMitchell988@gmail.com>
X-Mailer: b4 0.14.2
Feedback-ID: rr08011227e2147aa24874712226dc26760000586f8874787f4a6d72561c1308b8421776f82c43f9d82fc0af:zu080112270093cfddc4763c54b4577d2900007b6bb1e3fb3d534e2083681ede70111f5b98537885daf9054d:rf0801122c3ebd15007b09d8c36c868581000091f3a48bbb219b948ec20d7df113f5ee97e31ac3b1a866027a26bb0bee98:ZohoMail
X-ZohoMailClient: External
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dvX4vSLzFxsN
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741704917.35693@7/skvvMSS/V6VrG5udLkmA
X-ITU-MailScanner-SpamCheck: not spam

This patch describes the clock controller integrated in K230 SoC
and replace dummy clocks with the real ones for UARTs.

Co-developed-by: Troy Mitchell <TroyMitchell988@gmail.com>
Signed-off-by: Troy Mitchell <TroyMitchell988@gmail.com>
Signed-off-by: Xukai Wang <kingxukai@zohomail.com>
---
 arch/riscv/boot/dts/canaan/k230.dtsi | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/boot/dts/canaan/k230.dtsi b/arch/riscv/boot/dts/canaan/k230.dtsi
index 95c1a3d8fb1192e30113d96d3e96329545bc6ae7..e688633acbbf2cee36354220c557252111f56ff5 100644
--- a/arch/riscv/boot/dts/canaan/k230.dtsi
+++ b/arch/riscv/boot/dts/canaan/k230.dtsi
@@ -3,6 +3,7 @@
  * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
  */
 
+#include <dt-bindings/clock/canaan,k230-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 /dts-v1/;
@@ -58,10 +59,10 @@ l2_cache: l2-cache {
 		};
 	};
 
-	apb_clk: apb-clk-clock {
+	osc24m: clock-24m {
 		compatible = "fixed-clock";
-		clock-frequency = <50000000>;
-		clock-output-names = "apb_clk";
+		clock-frequency = <24000000>;
+		clock-output-names = "osc24m";
 		#clock-cells = <0>;
 	};
 
@@ -89,10 +90,18 @@ clint: timer@f04000000 {
 			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
 		};
 
+		sysclk: clock-controller@91102000 {
+			compatible = "canaan,k230-clk";
+			reg = <0x0 0x91102000 0x0 0x1000>,
+			      <0x0 0x91100000 0x0 0x1000>;
+			clocks = <&osc24m>;
+			#clock-cells = <1>;
+		};
+
 		uart0: serial@91400000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x91400000 0x0 0x1000>;
-			clocks = <&apb_clk>;
+			clocks = <&sysclk K230_LS_UART0>;
 			interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
@@ -102,7 +111,7 @@ uart0: serial@91400000 {
 		uart1: serial@91401000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x91401000 0x0 0x1000>;
-			clocks = <&apb_clk>;
+			clocks = <&sysclk K230_LS_UART1>;
 			interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
@@ -112,7 +121,7 @@ uart1: serial@91401000 {
 		uart2: serial@91402000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x91402000 0x0 0x1000>;
-			clocks = <&apb_clk>;
+			clocks = <&sysclk K230_LS_UART2>;
 			interrupts = <18 IRQ_TYPE_LEVEL_HIGH>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
@@ -122,7 +131,7 @@ uart2: serial@91402000 {
 		uart3: serial@91403000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x91403000 0x0 0x1000>;
-			clocks = <&apb_clk>;
+			clocks = <&sysclk K230_LS_UART3>;
 			interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
@@ -132,7 +141,7 @@ uart3: serial@91403000 {
 		uart4: serial@91404000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x91404000 0x0 0x1000>;
-			clocks = <&apb_clk>;
+			clocks = <&sysclk K230_LS_UART4>;
 			interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
 			reg-io-width = <4>;
 			reg-shift = <2>;

-- 
2.34.1



