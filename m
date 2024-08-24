Return-Path: <linux-kernel+bounces-299930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F71695DC5D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 09:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48F601C215D5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 07:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87855154435;
	Sat, 24 Aug 2024 07:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icGTbV/3"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426FA15350D;
	Sat, 24 Aug 2024 07:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724483374; cv=none; b=svRbf7dk55OABzio3BMDtJT0bcmpmt7nFxlL/bBajO0IzJ3xXoL3Jm1yO2UhSW5pi+cJXsMVVOMNHdC+ONUo7JchXUvNuxw53EsA7aLCHWuRngFPUFfjLfUwPo7QZPkUBbagPhN/YUqYariK+Bwu0zRMrLx0BgY38O3nE8sDAL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724483374; c=relaxed/simple;
	bh=oW829Qj1Acj1xLhwGdFiHwNZ5GC5viGfHLykdWuf2UY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=A3DNwhoEJYAbRXxa5DrFox3A+1gdJDd3i2e5MdKOdpf1SgeKJBU8f4l+eiQmGT7TUmIRn0JnK7u1TRoJ0DFYkQxuij9eV3RGM0fFeJ7FYOQiS4PxuaBEgQW/m89DPYvfFksXj6AgKuYHupjOSdsOrqpM5zIeCfNDJ6wgy6GrV6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icGTbV/3; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8692bbec79so349379366b.3;
        Sat, 24 Aug 2024 00:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724483371; x=1725088171; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kfjDR/1rSB9keE+iHqPgfwEHIVsDSqAHRyufwZuzetI=;
        b=icGTbV/3izIjC3B3uD3pGtvSZL+aiK04JFrxLLvln0His2ygRzNSXI37q2wHE8F5wH
         4kdBrKSm9UQyu85JALE/3ieX2CRbwWlEyPv+AOH/yDpqlsG1tWz2w87WmmCn8IHSVX2n
         VBihrDS/jJWOnlpOXrvwA5k2DeMj+5L1cVReC+mObZFc3Oub8Q6uHe1q1k2FFaTwgziJ
         0CK+NmjWV22ohT2az540AXDoAVvduH0ftSlfqoW9r3f31WDSko89aaqKhCkeqCvMuva8
         qwQfCyS71XHRRrfoTtJMpZl4JTjhp7z/fDG7E1LRt5xktDAkKE/lDDHZEgtJd0gJn2OE
         Cuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724483371; x=1725088171;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kfjDR/1rSB9keE+iHqPgfwEHIVsDSqAHRyufwZuzetI=;
        b=KURsfC2mCFauAJsubha0kjqYPHHGcCYPKuhyqjmTtAh8VvlHvjjcyBkl6ngxxp8X4v
         /cQAzWjEmMsmIamq/vO/sZ1e/hKA6GsIUj7cFVrLAA5WeEgBy4KV0Q2W440mo00TFYAZ
         RRAiisY8jG7l0I7BnkKWUVtFvRQYGshULc2vAH5OQcKXlDL7rDHBHv5i4VBVXe717xX4
         wBwM9uFOIwHM4J3r9PU8qi+kdgu3mFRfWiFm0uJENfh1VJz/K2wblWeVsT7Gg/prxJTK
         50iO004dCR+sst50f39qa3EI1UEhEtVdXKPfpfI7MNIRMZ4pgWTTIrWCW2evyp4BLQj2
         6mfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkSjuA/ZVnlKw6V4vy2yTB81FQ4SY8MyMcKYAeGVHIbbjmQuL+YoOHsySfYBBD3cy0OiUHNZfom9vqpnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRhryZg4T1iO3UQWCTTlQHeLC1Gl1L0cs2iq4OBGVUT6Ii315x
	hACFn0tQ7ab+wva4CzsfI1mhRlWzNaqMMTFkHPfDKxAmWB4pkX6vvEj4jyNdRY4=
X-Google-Smtp-Source: AGHT+IGXpjiUM9XnUIP8+efruOHQLPcgeCdaJd02WdJcnnVH0P5w/ib5uHRsIa/UiP82Qoz8QJxsKw==
X-Received: by 2002:a17:907:e249:b0:a86:9487:f1d2 with SMTP id a640c23a62f3a-a86a52c65d0mr278144766b.40.1724483370607;
        Sat, 24 Aug 2024 00:09:30 -0700 (PDT)
Received: from cleve-worktop. (85-193-33-51.rib.o2.cz. [85.193.33.51])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a868f437997sm360192266b.106.2024.08.24.00.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 00:09:30 -0700 (PDT)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Date: Sat, 24 Aug 2024 09:09:05 +0200
Subject: [PATCH PATCH] arm64: dts: sunxi: nanopi-neo-plus2: Add pio
 regulators
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240824-b4-fix-nanopineoplus2-pio-regs-v1-1-7c5f7da445af@gmail.com>
X-B4-Tracking: v=1; b=H4sIABCHyWYC/x2N0QqDMAwAf0XybMC1Kbj9yvCh2qiBkZaGyUD89
 xUfD467E4yrsMGrO6HyISZZGzz6DpY96sYoqTG4wdEwOsKZcJUfatRcRDmXz9ccFslYeTOcA3k
 f0hifTNAipXLT78F7uq4/Hv8LZnAAAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724483370; l=1230;
 i=cleverline1mc@gmail.com; s=20240824; h=from:subject:message-id;
 bh=oW829Qj1Acj1xLhwGdFiHwNZ5GC5viGfHLykdWuf2UY=;
 b=r2KcuKbi/bWODmEtaXS/TN+uKOeiAFQiRRt1HI6i/CAL58u7++m/huOwFodBeYWEiRXZvC8aJ
 5D0VzG/NMN5ArYwQRD/EiRm+7Za/J4Iyylpj3wh80rOACXGT1d6kcdn
X-Developer-Key: i=cleverline1mc@gmail.com; a=ed25519;
 pk=CQifx5FUgTQKAoj5VCYrwYHi235AkXQ5yT1P6gkaBxM=

The board does not have a dedicated regulator for pio and r_pio,
but this fixes the kernel warning about dummy regulators being used.
Tested on the actual board.

Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
index b69032c44557..2841c9a8aa50 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
@@ -146,6 +146,18 @@ &ohci3 {
 	status = "okay";
 };
 
+&pio {
+	vcc-pa-supply = <&reg_vcc3v3>;
+	vcc-pc-supply = <&reg_vcc3v3>;
+	vcc-pd-supply = <&reg_vcc3v3>;
+	vcc-pf-supply = <&reg_vcc3v3>;
+	vcc-pg-supply = <&reg_vcc3v3>;
+};
+
+&r_pio {
+	vcc-pl-supply = <&reg_vcc3v3>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pa_pins>;

---
base-commit: c3f38fa61af77b49866b006939479069cd451173
change-id: 20240824-b4-fix-nanopineoplus2-pio-regs-b54335d8a9e4

Best regards,
-- 
Kryštof Černý <cleverline1mc@gmail.com>


