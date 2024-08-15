Return-Path: <linux-kernel+bounces-287788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEAC952C91
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8AF1C216DF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA19D1D54DC;
	Thu, 15 Aug 2024 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3SRBPwk"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887C41D47B1;
	Thu, 15 Aug 2024 10:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723716828; cv=none; b=pcBtWtvrPieXCA64SeItmYY9XILvGmX7XYtTpO8tnl95/oZrlVLTeubI134xGjOFQkOf/eRKrqxY9d4kyXnZL0zIEOq8xeX9GiBI4E7XVtHr52+x8UnwNnQ9iemenRuaXCzAhKLXHOUAh6bBCHBwkDZ+zYZH+HVX+8krnci8rTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723716828; c=relaxed/simple;
	bh=+TvEdzQ/9c6jut9k59bJZ2duT+YJw9UO7silmCKO2qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sne4BQ4ienyTFCNnvoWdEod2rvlE7HY+ARd0KOMbMuQlxFBb8aA6I/2MMkD+BY1gFjN/uBW0URGvpG0bWTfi7MtjylyOhgNdYJ3549Z1/J/o+vTiDPAK+NsPlRKt4CLTfroDQTutmHbG5dVWOO7j5H+aCAKFT3LUEfmGYQzX6TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3SRBPwk; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a15692b6f6so1076698a12.0;
        Thu, 15 Aug 2024 03:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723716825; x=1724321625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o06GvniUcfmhMUL6PwyXbMvRJebr6Xj9XehasRnJgSU=;
        b=c3SRBPwkPmI6Hk7Epn9i0cOzj/K+mwuG1KgIVzYmUnLqVwET6R5ZMf43LrKlfereMj
         VwhlIrAEoA2ispbGzdMHftiZSB3WGSbnFOXYZ2BmnFflV9PMC566pniypsgno2ftnfhD
         97dicDI4RD1yxGKrqNK8CjkaTmt1+CW1pEmHiczO+arrFwZJb8aQbT2ew4dAMgV/inAA
         eXLRTH3Pv+35nSzFotIGAAYBiXSYwIcHP+BwJDQM8PJulhePBg4iTwq7Zwn9jdI4+61K
         AKVuJuKl7JikPij+EYdGZmLFQogVDFOBBngmWOr9bF7bsOvuAZoO4sCk4S1rIcdv+bcP
         cxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723716825; x=1724321625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o06GvniUcfmhMUL6PwyXbMvRJebr6Xj9XehasRnJgSU=;
        b=RX+HhVzocm1hjb7ET9pX2VhjEqhH9dxZglXhYm2JubtdgMeshY55SaSOJ4J/SRd0TK
         FbtSZW3MrL2b2Ay4DwvL7bg4teAxT+qKdY61rI74zXjnRHkByRP9qWoXXRiToCou3Mu5
         RQpv+GcsUF7p6t1bxPYWeoqSKeRg01HoJPtasdMqBt2s0vnbQBePiImtYp2eZxnEwyc9
         NliFVEs39jyLtDSJrQ/BXS0CqJAwb7gARCbDgjBjmoGIuYT2+bdXo6W0IfYU6ru1WjhD
         b/k/k5oETvTLAOkAxCFG4/ZT3cyfoTQQD+z4XUIZzSrnyMms/cjVI9gQ43sPTw56l+ut
         1PQw==
X-Forwarded-Encrypted: i=1; AJvYcCW12bvbLx08pPNx2KASYDjOfyPInrmakwIA3/k8X1gnRCioYXHI/SuLPQGaRe2utIRerKctoK2o29AMBivfQxGbq0F253jJB3ztMlrN
X-Gm-Message-State: AOJu0YyOYlFnmMjXTppLAOH6aBS35S4dg02BiYpSvFuhppl4tbIC2pt4
	OpwGs4c713Hjqc4DQ0fmAisXe/W5RPuqhX9UrPcscQWbwA3Q24PM
X-Google-Smtp-Source: AGHT+IExnRsk3ybYD81mC/sRU/KcANLw9XOwqYwQOZ49cA7sbJcoOHx8/qUzIYtLwlrxf45lZiUF6w==
X-Received: by 2002:a05:6402:4416:b0:58e:4e62:429b with SMTP id 4fb4d7f45d1cf-5bea1cb315cmr4763525a12.33.1723716824492;
        Thu, 15 Aug 2024 03:13:44 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbde48a9sm690760a12.25.2024.08.15.03.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 03:13:44 -0700 (PDT)
Date: Thu, 15 Aug 2024 12:13:42 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: sprd: sc2731: move fuel-gauge
 monitored-battery to device DTS
Message-ID: <5fc955715c956eac0edf922623c87ab382e4295c.1723716331.git.stano.jakubek@gmail.com>
References: <cover.1723716331.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723716331.git.stano.jakubek@gmail.com>

The monitored-battery property is a property of the board, not the PMIC.
Move this property to the DTS of its only user, sp9860g-1h10.
While at it, disable the fuel-gauge node by default and enable it only
for its users, as it requires board-specific properties to work correctly.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Note that the 'sprd,calib-resistance-micro-ohms' property isn't specified
as I do not have the board or any other source of information about it.

If the SPRD folks could chime in here, that'd be great.

 arch/arm64/boot/dts/sprd/sc2731.dtsi      | 4 ++--
 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index c8b30c0479fd..0eb4aca0a139 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -94,17 +94,17 @@ pmic_adc: adc@480 {
 			nvmem-cells = <&adc_big_scale>, <&adc_small_scale>;
 		};
 
-		fuel-gauge@a00 {
+		pmic_fgu: fuel-gauge@a00 {
 			compatible = "sprd,sc2731-fgu";
 			reg = <0xa00>;
 			bat-detect-gpios = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
 			io-channels = <&pmic_adc 3>, <&pmic_adc 6>;
 			io-channel-names = "bat-temp", "charge-vol";
-			monitored-battery = <&bat>;
 			nvmem-cell-names = "fgu_calib";
 			nvmem-cells = <&fgu_calib>;
 			interrupt-parent = <&sc2731_pmic>;
 			interrupts = <4>;
+			status = "disabled";
 		};
 
 		vibrator@ec8 {
diff --git a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
index cd8b1069e387..a5f6acafee3a 100644
--- a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
+++ b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
@@ -84,6 +84,11 @@ bat: battery {
 	};
 };
 
+&pmic_fgu {
+	monitored-battery = <&bat>;
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.34.1


