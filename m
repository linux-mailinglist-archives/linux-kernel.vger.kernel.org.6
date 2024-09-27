Return-Path: <linux-kernel+bounces-342164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8465988B1D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 22:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08CB1C23173
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A571C32F1;
	Fri, 27 Sep 2024 20:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TAaacyuA"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571651C2DCC;
	Fri, 27 Sep 2024 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727468015; cv=none; b=CuosqRw4z0gP3XlLnBVtXaaslD5Q0I55DCswApMt970cm/8QWJ+P1kMMutpFRwqIDTFTcN6NndnwgT6dcddOcMEuLpzF3RMxu4ModVw9tXbDEfEo1F/PTGTB8a6wGNFhsGaUO0cz/E2IMO0WoWG/9cwIY/5sAqAGqx5qo1EQ8Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727468015; c=relaxed/simple;
	bh=OYlpggxcIKhEZG6OUwarmtV6b8eMoZMubnmGsW0X1F0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EoOAkn+tEcyLRKNsrFToFpApreL5Jd72RINWqHZ8UDe9CHAa1x+bJ/XA7FDpvBWFtn4cIx2dcT44JF0nzwilC7Gobu+woZMql64fm5drqCp+5gx2oYGryNc4fzRlb8jmEBts96lH0TLIx6ZsJFWFIfW3CSPyu43gH8+CY/NK2UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TAaacyuA; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727468012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2En2LUWhEsQHsqEJNOotoHkKE7KQmkeHw7ybLj3Q3A=;
	b=TAaacyuAZ2phbSPNJBSf2hQIc73wP9BJuK/+QPeAuC9Y0+1Eb36NCx/XCa2/OHHEyHd2xB
	VFMHpzd33Qn0aAGBWM5e/yDzIevb6MbwM1QEOR0eYC9EfMLULQVY5ALVC99Ko3PZYKHE9b
	2iT21C3wxeBVfh9jF2I+bMLcBHR3IjY=
From: Sean Anderson <sean.anderson@linux.dev>
To: Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>,
	linux-arm-kernel@lists.infradead.org
Cc: linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adam Ford <aford173@gmail.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 2/3] arm64: dts: renesas: hihope: Add SD/OE pin properties
Date: Fri, 27 Sep 2024 16:13:12 -0400
Message-Id: <20240927201313.624762-3-sean.anderson@linux.dev>
In-Reply-To: <20240927201313.624762-1-sean.anderson@linux.dev>
References: <20240927201313.624762-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add SD/OE pin properties to the devicetree so that Linux can configure
the pin without relying on the OTP. This is based on Geert's analysis of
the schematic [1].

[1] https://lore.kernel.org/linux-arm-kernel/CAMuHMdUmf=BYrVWGDp4kjLGK=66HSMJbHuMvne-xGLkTYnGv2g@mail.gmail.com/

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 arch/arm64/boot/dts/renesas/hihope-common.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/hihope-common.dtsi b/arch/arm64/boot/dts/renesas/hihope-common.dtsi
index 83104af2813e..6abe094fc253 100644
--- a/arch/arm64/boot/dts/renesas/hihope-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/hihope-common.dtsi
@@ -198,6 +198,8 @@ versaclock5: clock-generator@6a {
 		#clock-cells = <1>;
 		clocks = <&x304_clk>;
 		clock-names = "xin";
+		idt,shutdown = <0>;
+		idt,output-enable-active = <1>;
 	};
 };
 
-- 
2.35.1.1320.gc452695387.dirty


