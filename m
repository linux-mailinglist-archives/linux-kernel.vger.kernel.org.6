Return-Path: <linux-kernel+bounces-173112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2758BFBAD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B52CB226D3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A65682486;
	Wed,  8 May 2024 11:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Lyioe+l1"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D550B7D07F
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715166972; cv=none; b=SRVRQk/dQq56ZSzT7lcFOEB0YHVDt65HTZvo8MzbvF1DRGlVZro3/1g7+2E0FxcxkA9Fob8J9/IVNLKkZsnsDLqimWOi+MvZq7w4z71cWpOPRv6Jq+DY1UufUJXLTdwqR4tqTuxdLTdxlTSegL2RwmD0evhu749ZkIpNSMGFlz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715166972; c=relaxed/simple;
	bh=F3m98SryOb/x5XWClShpUXV2JbrsUxTW10RXS5LFe7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2hO+n2gNKwkdR+N/8/nkzgs6wjtscvABFjBW94RYYyE8mBzhWPWqluKJ+/23zk12OgWnCmhud0t9/O2xaRLjAraw4H4Um86FjEoKqWpFvjDrdtCaV5StqK3ybhXPI7oH7pc9JPU4qndwRU3sTWZlp20IwcPJeAsMuTQJIapcl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Lyioe+l1; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 194054061D
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715166968;
	bh=D0ew36e5vVU/6+Iw9oM1mZEw1Uv4LlOrlkufMVDQOq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=Lyioe+l1itDvD5ZOJBka37D29x0BRFxqXLS6HjamKjlE3CgumoqV3LTYD5GnWGCqv
	 Oh9Q17G9U7LIQx4YPcjeyy2WeBZYfTy2uP62zis1KBrDMfAlMv16dohiL6VUEsMWvR
	 fPekKoAcZ0GuOM9lYSisbSaVMJNCYdPlmVRoquM/X9eQ+TqJkGXL8iMrhGQgUR2Tqv
	 oxT9DXlfhAMz/+AB4nUdZtKQmW5HHMrfXCd0GZQxQUFf3Q3iMCxbQJnEhp1HKCkIOQ
	 oP8ZeeagnyCEAr5mKiIwQ26S6d9JzWNtntz99Pv6GqK0/NL1bXzetVF8MElPdYfvG1
	 KxqXAbfjTwF2g==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a59ad486084so223456966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 04:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715166967; x=1715771767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0ew36e5vVU/6+Iw9oM1mZEw1Uv4LlOrlkufMVDQOq8=;
        b=t9iTp5S+5rXj4Qx55mIANieEU4pRMVI6tNcsp/kGagwNlO9dBDTGNji4CEYAnegFrW
         BtzOFwgJgXmy7TtCCj4vMU7TXkEneD/PPlsDLMU6mVdZ4tsaMdCFj6fvzIx/mOF6Ysaz
         3667Xb9oRbYLHAjQunC+W24nMCvhd531XS3eim8BVivRl0do+INEnpAuh3AFBU2YauEm
         RuE48nQ2mFDBWqbKT+Jm0EU25TnrKfMfWDV89BF4Qka2svito/GxTYwXYutOtwdAZX1c
         md7XDngbC8R0ACLhWsszC184/hL5Un6EMx+J8pVSeQRivzSA4SWLBlBRUkYROdNvXnEM
         9hqw==
X-Forwarded-Encrypted: i=1; AJvYcCUd+25V9ziExP3NzjYnNG4GhV4nF5jasPGbxwaEQcqfiLVkip+DIECamHrKc/YAUQO96Ggk+p3TFYLv3iuKvTnCn4fiCRKZGNUr8831
X-Gm-Message-State: AOJu0YwJn/+Ui45vg2+Nkf8Loy6wsWE5PhJ/gimFOf4/fy4Vg9hbVv81
	0WS9VtUuvYo86kgCaftbRszH4H3d/7BpgBry2rt0cATEMR4mnPvIxov/LP5YATmsJPjPblUYI+1
	tRawttaUgxY1p36M6ZqD1GWdmknUpPpHZug2wmrZ4kyz5sCGfwsj/hFLfCAblR+QWJLXIx4Rh41
	+NSw==
X-Received: by 2002:a50:8707:0:b0:572:a76e:645a with SMTP id 4fb4d7f45d1cf-5731d9d2df6mr1558875a12.12.1715166967753;
        Wed, 08 May 2024 04:16:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqGr0GivLfWF6z1E1QkljJkrnAc2l74CIT39UNlpuCzyDWw8jOzF9sDgwy5FEt/BbrEhk8ig==
X-Received: by 2002:a50:8707:0:b0:572:a76e:645a with SMTP id 4fb4d7f45d1cf-5731d9d2df6mr1558861a12.12.1715166967248;
        Wed, 08 May 2024 04:16:07 -0700 (PDT)
Received: from stitch.. ([2a01:4262:1ab:c:8ce6:9eb:cd7b:fcdd])
        by smtp.gmail.com with ESMTPSA id co22-20020a0564020c1600b00572a865af10sm7513556edb.44.2024.05.08.04.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 04:16:06 -0700 (PDT)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH v1 1/2] riscv: dts: starfive: Add JH7100 high speed UARTs
Date: Wed,  8 May 2024 13:15:54 +0200
Message-ID: <20240508111604.887466-2-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240508111604.887466-1-emil.renner.berthing@canonical.com>
References: <20240508111604.887466-1-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Renner Berthing <kernel@esmil.dk>

Add missing device tree nodes for UART0 and UART1 on the StarFive JH7100
SoC. UART0 is used for Bluetooth on the BeagleV Starlight and StarFive
VisionFive V1 boards.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 arch/riscv/boot/dts/starfive/jh7100.dtsi | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
index 9a2e9583af88..34c1622d5496 100644
--- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
@@ -258,6 +258,32 @@ sysmain: syscon@11850000 {
 			reg = <0x0 0x11850000 0x0 0x10000>;
 		};
 
+		uart0: serial@11870000 {
+			compatible = "starfive,jh7100-hsuart", "snps,dw-apb-uart";
+			reg = <0x0 0x11870000 0x0 0x10000>;
+			clocks = <&clkgen JH7100_CLK_UART0_CORE>,
+				 <&clkgen JH7100_CLK_UART0_APB>;
+			clock-names = "baudclk", "apb_pclk";
+			resets = <&rstgen JH7100_RSTN_UART0_APB>;
+			interrupts = <92>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+
+		uart1: serial@11880000 {
+			compatible = "starfive,jh7100-hsuart", "snps,dw-apb-uart";
+			reg = <0x0 0x11880000 0x0 0x10000>;
+			clocks = <&clkgen JH7100_CLK_UART1_CORE>,
+				 <&clkgen JH7100_CLK_UART1_APB>;
+			clock-names = "baudclk", "apb_pclk";
+			resets = <&rstgen JH7100_RSTN_UART1_APB>;
+			interrupts = <93>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+
 		i2c0: i2c@118b0000 {
 			compatible = "snps,designware-i2c";
 			reg = <0x0 0x118b0000 0x0 0x10000>;
-- 
2.43.0


