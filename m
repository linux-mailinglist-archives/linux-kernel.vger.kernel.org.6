Return-Path: <linux-kernel+bounces-553145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 459B7A58481
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C63E188ADD1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 13:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C781B202978;
	Sun,  9 Mar 2025 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhK5T4cR"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E65B1F4CBB;
	Sun,  9 Mar 2025 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741527061; cv=none; b=X1GzBLJ/99LqpWADB9dqjPpr369UjdqWY+XVm5N1sAGyjgFOPoyecZHmQ6+WHamFoCggfqQROFH0KmoRpvifvfFu9+7Apvd4+LzM51QgOm/ht6xXtx4LoRH3ksI2IH60tozTyR1As8Wd1QzwDO+b221sDBZNFtchAFYjdixZCNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741527061; c=relaxed/simple;
	bh=SjwFNqVbo+q+sq9X/eMttBMsoTVHeqNraIBV3KFWJoo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTBUA4OTZBziv+n+GFhOOciK2BDs8ib/iKAlbkDgKwTHb00PoH7Jbe4UUY6Q0usCgUW0bI5vikA1yyC+KIY4JU7tiy/a82k3IPd1/y+NZBjEFDqrlXXHl99RvT8gc1rgw8YhqJhZSZvQCCbyYcvw2dOMkdiuoVx0bYs+3e+JN74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhK5T4cR; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso4493745e9.3;
        Sun, 09 Mar 2025 06:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741527057; x=1742131857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oHGf9I9jetcKSy3ZjSkoEOOlmvfoewi1ZT4SC8hFxRY=;
        b=DhK5T4cRsXcxm6ueMtdVfW+GAaMNasjb3D1zEFNzGIFNA5tH/1CzOvWFgy2pQg7x/t
         jsxdOt0kspLGszJKFxY7Ea/6GQgf8TeE9hPMx9zoyQpMiCfGgTWJaFp3gvfLL8s9KoBg
         uq/zE6S19w48W5QJKW7vqBzIsI0XXtpP3HjVZ6Z4WeiadEzHcS1+70W/t35ew+sFCIG8
         Fw/p3+w2lYKeDhwnaGoU4/NfLY4feKa6zEeY/PektqTOMoQoA1PB1jpv116A3xj5be5A
         n0mgVW8TnS0cyD1hgKloUm2B4sffoarMGTX10b55JfowT2Nakrsj/UxAuV4KtEyS1wX3
         jgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741527057; x=1742131857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHGf9I9jetcKSy3ZjSkoEOOlmvfoewi1ZT4SC8hFxRY=;
        b=BdXPYWq/UOx2rAHRU+Jf/KK8E2yVt1j9xHsieOhNPWsyjglOMBioAT5EQqwor04d8X
         hJKwZiKwGSg87tegiBunsNZwAhK+tOtqu3jpW027FTGnDlpH8ZQYDntoCsjwuVSYZI3d
         Tlo4biRNIGniBH8TbzMs5IgkO/jHGW+y96naNspR9UQV1vVLs4IdCmdGf+m4aE9UTeva
         dXeGV4xx6Zxf6ZUdMwOtPCEjURCX6kMy3iCGCJ1CeybIRQ3SHnCL3HtcfPy+Y7X58tvM
         CRVOhHSkw6vuXstIyOYvtTedBgC0dyG5AkEejICa+0BSPbPsX0uPv8tPx1gtGnS7MswE
         o3BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC/orNNrDkevNkwR/Ge+aCX0uoAz02zLNyAly6prYUPW+AXohO+BGT3AffRYx6dPciZRwXVz/GlCIX@vger.kernel.org, AJvYcCWOQY4SIf59hH1Cf6IgoRKAYmnig1jH6fLbc7l/TfMopE8o0PQJlgOO4jiUPwwgKZhejIKQ+HuPgs8H@vger.kernel.org, AJvYcCWbLaIOwLPG5D1pEm+zcoYwCL2nM3eQwo/3zFTFqipuqEtzChd4tjHx+eE3r5ydt1XNEfJpK3nNgYzU@vger.kernel.org, AJvYcCXI7W3gr681mKncA08lFhriXmXcP+rTn13I+yO8PtKFQrMO7u6rar3cqp59flsf+VpikM/PIVu5jB4FRi2u@vger.kernel.org
X-Gm-Message-State: AOJu0YzyFyB8PZk1WRo1d2wq8+oj0KY0Mo+vEN7ZhjEc6X1OZSciBMfn
	qtBxP4wc9MZRG+5ZwgaFMy07ANScCQxa/OqMvmdCR2vySfRLX5j9
X-Gm-Gg: ASbGncum3GliH3IsfX3X82bEN3pdytIuSNpwxBBRbu3iolQNoB5G4xPRWynz4DvKUXP
	cTd0Uf/vcSEi+DDHPwNtUztucBu9lVJxHE+mSQdvwzB9e6mVKut7inqRoKzHOybG69Ab5MgWUuq
	anCQhk8sdh10UpPv1cXqnW73VV9vOTdW+gK2IQsgTcPG4Ti+gkRyyFZljAlF7czeoUdkuoyQkKH
	LTcVdgcTkg6rGhx0sixeSoPS0784sBc1gBuSFzrXHAWx9en1J3aYrYXlb7ArDgOq0578cHGxqg3
	/UVtU3hjqxICkeg6vaOa7lYtVBbJDYn/5owBn2g3Bz65kVVgHDqhDZwgMDWbxeoNMElk+U6DGF7
	FdjEgVFpOTIuF2A==
X-Google-Smtp-Source: AGHT+IHh2pIg42W9ZdtyAbGtU1E8eclkophsMoFuh4X5tdSn2AE1TqJ6fGru5g4aiRfyb7QzTWo1Eg==
X-Received: by 2002:a05:6000:1f8f:b0:391:2ba9:4c59 with SMTP id ffacd0b85a97d-39132d986d7mr8560947f8f.43.1741527057566;
        Sun, 09 Mar 2025 06:30:57 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912bee262esm11867536f8f.0.2025.03.09.06.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:30:57 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Danzberger <dd@embedd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Guo Ren <guoren@kernel.org>,
	Yangyu Chen <cyy@cyyself.name>,
	Ben Hutchings <ben@decadent.org.uk>,
	Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-usb@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH 12/13] arm64: dts: airoha: en7581: convert SCU clock node to MFD implementation
Date: Sun,  9 Mar 2025 14:29:43 +0100
Message-ID: <20250309132959.19045-13-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309132959.19045-1-ansuelsmth@gmail.com>
References: <20250309132959.19045-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert SCU clock node for Airoha EN7581 to MFD implementation in
preparation for USB support.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm64/boot/dts/airoha/en7581.dtsi | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/airoha/en7581.dtsi b/arch/arm64/boot/dts/airoha/en7581.dtsi
index 26b136940917..dfc12fa99748 100644
--- a/arch/arm64/boot/dts/airoha/en7581.dtsi
+++ b/arch/arm64/boot/dts/airoha/en7581.dtsi
@@ -173,11 +173,16 @@ spi_nand: nand@0 {
 			};
 		};
 
-		scuclk: clock-controller@1fb00000 {
-			compatible = "airoha,en7581-scu";
+		system-controller@1fb00000 {
+			compatible = "airoha,en7581-scu-sysctl", "syscon", "simple-mfd";
 			reg = <0x0 0x1fb00000 0x0 0x970>;
-			#clock-cells = <1>;
-			#reset-cells = <1>;
+
+			scuclk: clock-controller {
+				compatible = "airoha,en7581-scu";
+
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
 		};
 
 		uart1: serial@1fbf0000 {
-- 
2.48.1


