Return-Path: <linux-kernel+bounces-564603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A0FA65823
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1C8C3AA5F5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3028219FA92;
	Mon, 17 Mar 2025 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCxGGASL"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE2D17A2EC;
	Mon, 17 Mar 2025 16:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229171; cv=none; b=Ly22wOLTA5NjyxHqTR4yNjTPrDAZRxF7EdXtWUrNNKMBUWPPdbwMceSxsO09Q9PRh4ZDnlhRO/2RwVCR0K0R+BHLAY0Zfcwsn1qov9Pk7fu3FVhu/rqHc2Ii7m7nN5VsmHbbEl7AY4+s/Ivh4iFZxndjC3taMok9dNMGQhAP8Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229171; c=relaxed/simple;
	bh=aItrNmrh7DUF2JjagDOmP2PvMR40bL1wWKe0CKEFit4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gh2/W66NhmZyRZPnI2FS84Bsb4u7i90eeUCIe8fBA8GFKNCRmay1vMqbHo8MZpma0TPYl7QnyRBG6fSIZaFgtPwUNA2YgHviDyviy/5pF8lhBzr5vrIgNPEPqJ1spPxcFOEUzJBYTYJcymBPLcPJzpSPUvIEXViybejVDJ75SCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCxGGASL; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2260202c2a1so4706725ad.3;
        Mon, 17 Mar 2025 09:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742229169; x=1742833969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YWWEyuRSXEh4jYuipM2cPauSQC9QSyQVuvZY6z5PEnM=;
        b=hCxGGASLlKaXSpTLUBXKlrwMcqm1OMGy1+6iF9/0LKLa9P5W0o1i0exZCSZu+knTZc
         Kk+GbcGyq3pZAyvam5Mwpr38gja8sP8qoWWruo+L24e4Du6qKGdHomqyWiNKTDkZIU2f
         uLGMefo6M0LuOJvnaalXhMnfhwBd1yeXQU+zcL0UJJCqFO6/CADIZpHBIknlemMzEPlU
         fNaHnu9G8i+fZjovbSWR+AMjHY7aH/11plDJc/NPgJRHEiPH7CFo3rQkNLou/BlZAwoY
         lemgp4J+X+/AkFinCJP4HtZE7LAYq2KwSJxtV4jU3p7REE9csaohU5XgOt1uOrVJg80/
         rJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742229169; x=1742833969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YWWEyuRSXEh4jYuipM2cPauSQC9QSyQVuvZY6z5PEnM=;
        b=Ymkwpnn3dSZChVX4Far88PXeFW/3kPmNSIVosI2Zw6K8KpsplfqpX5yvncZwJqg+Di
         muR6kge3owMDFLEsARjdxTIltWk424astVsEpMWf/X+QGYJ0n/LHCyY6i84Hi0jJHsaf
         hPpf/2yRzemwytWtNTTRT70lPQViM/1YdIAp28O5l/VruELofS7356aB98UDT9S0db2k
         bh7b64UFZDEe5rkjfW14N8IpR4/PSDFyNuM4mUk5WAfssFzJZr2kHyAX4Bq8Djb3cu3p
         RDMbgxglt5q9pIMoPVEMJ0n3fTmdZr2M1TIHvachLfRn8180O32OFzlHWtQ9QdWntMcA
         R2Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVhasq9+kGsD+YkSs2FttVJs3Xn/wlcmzX0V8hXG0EU4hNvIF3L0CMv4fY0AkQSGi7+YFgVk/yl6ETrec2M@vger.kernel.org, AJvYcCXGlYr39qbe/RX+y7iu4Rxd2FTU81kDQ1PtXUwqyMV7Cigg/esC2z8KXHNDr1w61+7yF+6hAiKBGb71@vger.kernel.org
X-Gm-Message-State: AOJu0YxKyOmp00wv8LMtCyMXk9ORHjPZs2zHiwRlaMCS61p2ukl5j10M
	apiDmRleX3HD03eX6YSJltT7ijRCmVxPMkiGSgaCsApL9xXxAPv9
X-Gm-Gg: ASbGncsPfiLTplqD+aavTEukobKoRD4Ude89BbGmfaNz1b9u00uC86eHaYdV0DaZTMn
	yR7GhPjciWAd8ra8AsDXZI4tvlj6jYwrfIJMtvMfLUHy6AuTXEQfnXPph/PFwYJHhfRZTt7Ez/z
	TU2kJEbaVNeTtJ72IpIg+0A3czOhiHpeKdrxgStMCaOVGDqAuxZEH3PxQo2WYa9zvguFE0o3g1a
	7cjtKimeNpEhkdfJsrGdBsc0uaZvhrlKdcPXnq+Ez3GjoJEPoZUK8OF0mlwd370zf4ZJurS+aYu
	35GRuFARr8Q6SVs7qJuu+RpPuXv2fcwnUsgeuyXF3mfs69MIJA==
X-Google-Smtp-Source: AGHT+IHcoui3nf6KS5wNjwxWgXPGU2WvUeQ+KSV0Bq5p427ioSnqGupQXz+IQZm/xDJmnCLpIAFiyw==
X-Received: by 2002:a17:903:1207:b0:224:252c:eae1 with SMTP id d9443c01a7336-225e0a666d3mr63113675ad.6.1742229169062;
        Mon, 17 Mar 2025 09:32:49 -0700 (PDT)
Received: from rock-5b.. ([221.220.131.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm77282825ad.70.2025.03.17.09.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 09:32:48 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Jianfeng Liu <liujianfeng1994@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Enable HDMI ports on ArmSoM W3
Date: Tue, 18 Mar 2025 00:32:21 +0800
Message-ID: <20250317163240.3083908-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the two HDMI ports on ArmSoM W3. And audio output of these two
ports are also enabled.

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---

 .../boot/dts/rockchip/rk3588-armsom-w3.dts    | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-armsom-w3.dts b/arch/arm64/boot/dts/rockchip/rk3588-armsom-w3.dts
index 779cd1b1798c..6ad2759ddcca 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-armsom-w3.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-armsom-w3.dts
@@ -4,6 +4,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
 #include "rk3588-armsom-lm7.dtsi"
 
 / {
@@ -32,6 +33,28 @@ analog-sound {
 		pinctrl-0 = <&hp_detect>;
 	};
 
+	hdmi0-con {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi0_con_in: endpoint {
+				remote-endpoint = <&hdmi0_out_con>;
+			};
+		};
+	};
+
+	hdmi1-con {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi1_con_in: endpoint {
+				remote-endpoint = <&hdmi1_out_con>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -138,6 +161,54 @@ &combphy2_psu {
 	status = "okay";
 };
 
+&hdmi0 {
+	status = "okay";
+};
+
+&hdmi0_in {
+	hdmi0_in_vp0: endpoint {
+		remote-endpoint = <&vp0_out_hdmi0>;
+	};
+};
+
+&hdmi0_out {
+	hdmi0_out_con: endpoint {
+		remote-endpoint = <&hdmi0_con_in>;
+	};
+};
+
+&hdmi0_sound {
+	status = "okay";
+};
+
+&hdmi1 {
+	status = "okay";
+};
+
+&hdmi1_in {
+	hdmi1_in_vp1: endpoint {
+		remote-endpoint = <&vp1_out_hdmi1>;
+	};
+};
+
+&hdmi1_out {
+	hdmi1_out_con: endpoint {
+		remote-endpoint = <&hdmi1_con_in>;
+	};
+};
+
+&hdmi1_sound {
+	status = "okay";
+};
+
+&hdptxphy0 {
+	status = "okay";
+};
+
+&hdptxphy1 {
+	status = "okay";
+};
+
 &i2c6 {
 	status = "okay";
 
@@ -192,6 +263,14 @@ i2s0_8ch_p0_0: endpoint {
 	};
 };
 
+&i2s5_8ch {
+	status = "okay";
+};
+
+&i2s6_8ch {
+	status = "okay";
+};
+
 &package_thermal {
 	polling-delay = <1000>;
 
@@ -406,3 +485,25 @@ &usb_host1_xhci {
 &usb_host2_xhci {
 	status = "okay";
 };
+
+&vop {
+	status = "okay";
+};
+
+&vop_mmu {
+	status = "okay";
+};
+
+&vp0 {
+	vp0_out_hdmi0: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
+		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
+		remote-endpoint = <&hdmi0_in_vp0>;
+	};
+};
+
+&vp1 {
+	vp1_out_hdmi1: endpoint@ROCKCHIP_VOP2_EP_HDMI1 {
+		reg = <ROCKCHIP_VOP2_EP_HDMI1>;
+		remote-endpoint = <&hdmi1_in_vp1>;
+	};
+};
-- 
2.43.0


