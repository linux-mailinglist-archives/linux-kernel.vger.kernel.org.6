Return-Path: <linux-kernel+bounces-263322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C751593D453
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C98A1F247D7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AF317D363;
	Fri, 26 Jul 2024 13:38:28 +0000 (UTC)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F3A17C23B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722001106; cv=none; b=o/agRNhW9aPsLpcd3Niyv/4gtHGLQw8rgZ6KH64N++jJdmZCg8HdLn0mq9boRcHpoj0zdY85p2R3jBuDBl+fxGjq3sHOV/RiFHGKr9Hca0+vteKjJmFOnJeKWHoW3Z/+JMlZG4lZDUQZsyZmeIuXqSdA3Yh0dRnJerMCVeMLVRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722001106; c=relaxed/simple;
	bh=bDQffbUZA5bghK/autS3tZR2RkAAIHVmCSryVm5aDTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gv7frXUYC+f6t1rfniejugzbRgE2umZXxFE9VqOiiFEpjEPSpZ+Da3+6Xjc0gOERUmPom1H+d8qUlueqt+BXm3hG3pcd6xxZUvqVPGpq45Hln2RTPcMQ5kyGse4TPUUkn2u/ITPEKJRnDbpT0wJ+Ga76FzGlKYsEQHE+A4DLIW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:3d94:87cf:603a:d7ae])
	by xavier.telenet-ops.be with bizsmtp
	id sDeE2C0051mGjv501DeER1; Fri, 26 Jul 2024 15:38:15 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sXL8p-003cML-V5;
	Fri, 26 Jul 2024 15:38:13 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sXL9B-004G6a-Mw;
	Fri, 26 Jul 2024 15:38:13 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 6/7] arm64: dts: renesas: r8a779g0: Add OTP_MEM node
Date: Fri, 26 Jul 2024 15:38:11 +0200
Message-Id: <3c12681c9b1ab9fc389521666cc1e14b518215f7.1721999833.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721999833.git.geert+renesas@glider.be>
References: <cover.1721999833.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a device node for the OTP non-volatile memory on the R-Car V4H
(R8A779G0) SoC, which provides E-FUSE services.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
v3:
  - No changes,

v2:
  - Add Reviewed-by.
---
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
index d6770d3d488b833a..3a0991a7789f4d13 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
@@ -463,6 +463,11 @@ tsc: thermal@e6198000 {
 			#thermal-sensor-cells = <1>;
 		};
 
+		otp: otp@e61be000 {
+			compatible = "renesas,r8a779g0-otp";
+			reg = <0 0xe61be000 0 0x1000>, <0 0xe61bf000 0 0x1000>;
+		};
+
 		intc_ex: interrupt-controller@e61c0000 {
 			compatible = "renesas,intc-ex-r8a779g0", "renesas,irqc";
 			#interrupt-cells = <2>;
-- 
2.34.1


