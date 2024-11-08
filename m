Return-Path: <linux-kernel+bounces-401410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852B89C19F4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70B41C2283B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769AA1E500F;
	Fri,  8 Nov 2024 10:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="SGKaUYWX"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC731E47BD
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731060343; cv=none; b=HcYqNTzvq+02wsawj5lLm3Y4tx5IBabLlFynlFeZoa9bRrsRDGHOyoBi0LD1BeHFtAs78kzt/J+NgEz5+maoQ23STy0vg+k03/QC5iEYRcYK5q6es9p3dAaG8SuepqztweqnyLkgvTarF4slf3qf6VPsj0yJGiKqS2qVgAFd6Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731060343; c=relaxed/simple;
	bh=2I3QYGgD+fQ78laCU7YBzXYtfRiP/TAEmsHKexsSybI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y7n3oytQdTo3tfZKaqVfp6Fsruy4E9viLfIoELXkpRAMmpAkZmGWEmVJd2zObQUiar4BoPOjGjMQ1FdGoVBhxlwf/axY517u8vr4ofwpP7t3oZdH1kCdroAjrpHt+ac7HjQ4yBS4juz6yL21s6Lj5e7guoDrCGoniG+ZQUGkZIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=SGKaUYWX; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c937b5169cso1408724a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 02:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1731060340; x=1731665140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYxgBdR3L0zZjTE6Q2Xo+f56VcHJlv6CSX9bi7CoE5s=;
        b=SGKaUYWX3E5Z5NKJx6rNFdmtyCME62h8Tri5XYBQh5CiXJqc0Dvy1fNz5K0aDqYpER
         6dVPwKLfrGZ1/nhQ3kwZBF5nzaF3ncTVUlcZ1JIuODR8im6cYOn6EdZtnSYu1tm/KhQt
         ho8VSEeMfhkQojum+k1XUNY8L7adg0Zd5pATXt2Yc1fg1vk+TXpDL0SB1D5Ruew1XmHE
         8R4r0oQiKTzRwnxFx3Z+7DyYbZe845f3mH9AUFSnsqYVNlQGxFZdoVC0gfCRcdZvYM9k
         YKn22grrMOnidCJ/je23Nx34z+WerDTpyg1WHNRc6oq+/XWnLlyPgZpx/8HSFPH+86U7
         TCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731060340; x=1731665140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYxgBdR3L0zZjTE6Q2Xo+f56VcHJlv6CSX9bi7CoE5s=;
        b=SK/b+sbJcd96jCIjJkj29BlJi8DXMW1EHTWXkrvH3P241epjCGgG5+YpB/CSHDY2y/
         hGozD3ijyuJ0f/dehCX8UF8PAWMxQIeuUsxZc11bwhySXgKDCoss2aZ+TM82+lRJnZpl
         U579X2PqOQd0J9R6tmMQxddHEO5eznWxwtokXisdegXN0D061FhCACHJLsiMouIPFUBM
         OSFOdtAtkuQJcT9ZvOumzk1WozBrrCb17+WUUS0eGjMaRhozWYr819pAn16BqWccA9i3
         VL9ofkZpX4wrfmfTY7xxdU6rdLexrjoAyo6dv+hUVGsmAspKoinjvSrtDObRM4EnWnZp
         S2OA==
X-Forwarded-Encrypted: i=1; AJvYcCVjdGtnhLcbdJNohkP0GGLY8chLsXrm4d8OqHlfxMZ8d9ql3MMjN5+JX3balqbwuR9tnZ3lmeGN7ppoieo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTmTm/UYXA1vx7P86qq5tJj2VF/xNdRd/slNEBMcSWfQshCoW+
	Q4VT4o6UtOXqUv117HVI4Ccd3SVbGF2ZZ+2EPkgYyu1dzaudkFXyjdMMoIlRPJg=
X-Google-Smtp-Source: AGHT+IE7N7pylKiTXaEOCIxixMFZUU7WhiCw4v1X0VOaK6v6PAdm72v+9Seyb/j9PC7MrQVlSHFH2A==
X-Received: by 2002:a05:6402:4021:b0:5cf:1214:8146 with SMTP id 4fb4d7f45d1cf-5cf12148226mr1044954a12.4.1731060340387;
        Fri, 08 Nov 2024 02:05:40 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c4f0bdsm1775959a12.56.2024.11.08.02.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 02:05:39 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	p.zabel@pengutronix.de,
	g.liakhovetski@gmx.de,
	lethal@linux-sh.org
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 7/8] arm64: dts: renesas: rzg3s-smarc: Enable SCIF3
Date: Fri,  8 Nov 2024 12:05:12 +0200
Message-Id: <20241108100513.2814957-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241108100513.2814957-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241108100513.2814957-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Enable SCIF3. It is routed on the RZ SMARC Carrier II board on SER1_UART
interface.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index 33b9873b225a..1be21ece131e 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -9,9 +9,14 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
 
+#include "rzg3s-smarc-switches.h"
+
 / {
 	aliases {
 		i2c0 = &i2c0;
+#if SW_CONFIG3 == SW_ON
+		serial1 = &scif3;
+#endif
 		serial3 = &scif0;
 		mmc1 = &sdhi1;
 	};
@@ -102,6 +107,11 @@ scif0_pins: scif0 {
 			 <RZG2L_PORT_PINMUX(6, 4, 1)>; /* TXD */
 	};
 
+	scif3_pins: scif3 {
+		pinmux = <RZG2L_PORT_PINMUX(17, 2, 7)>, /* RXD */
+			 <RZG2L_PORT_PINMUX(17, 3, 7)>; /* TXD */
+	};
+
 	sdhi1_pins: sd1 {
 		data {
 			pins = "SD1_DATA0", "SD1_DATA1", "SD1_DATA2", "SD1_DATA3";
@@ -141,6 +151,14 @@ &scif0 {
 	status = "okay";
 };
 
+#if SW_CONFIG3 == SW_ON
+&scif3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&scif3_pins>;
+	status = "okay";
+};
+#endif
+
 &sdhi1 {
 	pinctrl-0 = <&sdhi1_pins>;
 	pinctrl-1 = <&sdhi1_pins_uhs>;
-- 
2.39.2


