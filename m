Return-Path: <linux-kernel+bounces-404373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 412559C42F7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059712841B0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D298A1A707E;
	Mon, 11 Nov 2024 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gb4wGY5G"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD7814AD3F;
	Mon, 11 Nov 2024 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731343851; cv=none; b=CDTcyIsgBEhxLgKU38E88vUNPR7ZScBhxAxmSxbfPA4sn65TQHrVr3hObGHAHEVNlk848cGI3r7OKx6TQ4Tdc90qbS53kLCZWYtar6yPmKGVpxfksJiBForAeaR4+At7VDE+aDdyAC0hVsT1J6DkAySdJnbognFh7CRl5uY6RM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731343851; c=relaxed/simple;
	bh=nWVegVIO1iqmGgX3sTrds12vV7pNS01/SOYJetl0QIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/ywT5JWNPq4Garcp3cTq6Xu6JTfAJyHlscxcP9gDnc9A3kYzN+PHSBny4C7TfhWbVkZHby3vPDt/HoquZ1UR9sqiklHL9PYPWVeba88s9i676FoJCjTsTdmChu0itYJjNgeOBEjzaXyCbcmrpqo9bJ68eQAV0hxhBEStVuhvYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gb4wGY5G; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e710c5d0dso103560b3a.0;
        Mon, 11 Nov 2024 08:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731343849; x=1731948649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfIh7QFf8oEaQfYkdv6ZpaO6sL/ncFNHIot8BWk/VIc=;
        b=gb4wGY5GRlQIAhpzK4K5khEa0uGFXkyqJoP3ZVuqJpX0EI/6Ku0bSYeyHS7cXNKncx
         59hb/lsh+YdpkddXgkuJ2yb2DmbtKiIQ+dVreHH0zbbj40VdwYLs0WTUshmcuIgDQ+Jh
         SPp3KNqN1X2W91EO1k82h/xqzWYiZY8OMkeLHsJnpUX+6Kt6aTr1pGJMtjnakpY9dXXq
         5ZzbpLRviq9w24uWnXDA2r1mGGAF8bBiUl7oC+QFn5VqFsxLXtVk0MencrhHvJIbkrHk
         0Fp28CsiTSiEEyWmsNAd6746lPUwMTmhbQnePJmIs7sNCqf7tFCyhqAFQb5vWvrNtgZF
         HUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731343849; x=1731948649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfIh7QFf8oEaQfYkdv6ZpaO6sL/ncFNHIot8BWk/VIc=;
        b=AcdVXJydEWoQ66eqT9ym18iiYicKO3BBlWMPij2Ci2Q5526ZA/Zk7MwAcA3Rd9WlXA
         gtDcqLZ4cMAwHpTv1vL/xLv54WnWtmtF9Hb7jf/nm4T4XvrcWSs7rpYLh8+o2+PbaLkQ
         X/6ashmSIS6RloPJ6sL6Nl0T1EKATR0oG+wcyJZwI+BT3feUu+HW5kcwu5WjMeJm/DMM
         /x7lbIiDQZQeFCRnGy1Of+KWQ6IaHO0dqd5HrprR2hOV3yyMvzzKEk+ntsw0eGQMcfzU
         aE5Cir1dSI7D1W4oXBAMVjYgXWpaC1STl5PsMWg+MdOiwBCNpAX6CobmW13PlAZq18zL
         jdGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWkLCLcOq+9RpjeGzYXM7E/5DkDqeKFrLNi8vARiyHASyNrkACgZYXtIF19e3JJD8fCLLRgcOgUMefRTvb@vger.kernel.org, AJvYcCW25M1MkaO1VwZaxapaeotHFBaDGwGuEljD7+awuu7gw2H0vR7MgG/trxvWQE2/F1MWtaME65vX5P51@vger.kernel.org
X-Gm-Message-State: AOJu0YxOD7AK+uPoe4Aywq/u206qcRqO4e2sda8zUDRZnrVXNCNzXMiQ
	xsgfBXfylLTQO8rOZs/gxDIUeCFdEl/f8DrcGtQE/LqhE72LtLSK
X-Google-Smtp-Source: AGHT+IHfynhJtyo2TYb9cgYePvmyNGNyO/FFedYkfCOY6PP3kqTXtwUZx7toT125k2vM6Ak06pC67g==
X-Received: by 2002:a05:6a00:4614:b0:71e:5e9a:2db with SMTP id d2e1a72fcca58-7241338307amr7053453b3a.6.1731343849040;
        Mon, 11 Nov 2024 08:50:49 -0800 (PST)
Received: from rock-5b.. ([221.220.134.31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a19dd8sm9401955b3a.157.2024.11.11.08.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 08:50:48 -0800 (PST)
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
Subject: [PATCH 2/2] arm64: dts: rockchip: Enable HDMI0 on armsom-w3
Date: Tue, 12 Nov 2024 00:50:04 +0800
Message-ID: <20241111165026.60805-3-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241111165026.60805-1-liujianfeng1994@gmail.com>
References: <20241111165026.60805-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the necessary DT changes to enable HDMI0 on ArmSoM W3.

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>

---

 .../boot/dts/rockchip/rk3588-armsom-w3.dts    | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-armsom-w3.dts b/arch/arm64/boot/dts/rockchip/rk3588-armsom-w3.dts
index 779cd1b1798..5b5a18c8edf 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-armsom-w3.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-armsom-w3.dts
@@ -4,6 +4,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
 #include "rk3588-armsom-lm7.dtsi"
 
 / {
@@ -32,6 +33,17 @@ analog-sound {
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
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -138,6 +150,26 @@ &combphy2_psu {
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
+&hdptxphy_hdmi0 {
+	status = "okay";
+};
+
 &i2c6 {
 	status = "okay";
 
@@ -406,3 +438,18 @@ &usb_host1_xhci {
 &usb_host2_xhci {
 	status = "okay";
 };
+
+&vop_mmu {
+	status = "okay";
+};
+
+&vop {
+	status = "okay";
+};
+
+&vp0 {
+	vp0_out_hdmi0: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
+		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
+		remote-endpoint = <&hdmi0_in_vp0>;
+	};
+};
-- 
2.43.0


