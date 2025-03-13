Return-Path: <linux-kernel+bounces-559574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7D9A5F5A9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF383BCDAC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB53267F5C;
	Thu, 13 Mar 2025 13:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HB9Wajep"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B05267B16;
	Thu, 13 Mar 2025 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871533; cv=none; b=gVK7WjiL/uqUOcwTiKrfUJMRIlSmyTYZleFvEIGUupucBvjtatF0ATx0HQVVZTBgHl3f8swVA+nejm6Lmf8nuIqlcDWIe6UCmBKCtTwwmKVYgrEP9OYHMakNqgptPJU+LFG23x3r3423oSN2XbgYdWVtb+Kzl0YN6OuuDJWpzJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871533; c=relaxed/simple;
	bh=9w1ScaeSlWhq6L0g6c/1U2BXB6YORXYaIQ7F9hz9/qY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OjnuUEsEYjBSw2eQUyYokU6DmYPQ37F8EfGPb0rWJrzCmiIaGYP+kOtnkS4Cb4WpYYjmSkfmH5enZUP5n7ptEJaPAu+Kg/uDD7eD3pp1Cjnc7dYLA3pUCkWlLmnBql407JI85XXWFLI7QQqjvZjGjM8uxw4rSl2ZR9+cqPPjACM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HB9Wajep; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ff85fec403so3683198a91.1;
        Thu, 13 Mar 2025 06:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741871531; x=1742476331; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VwYK1vtIGu8AKr7d5DZZujGnya4yaossipP8/xTscq4=;
        b=HB9WajepFATDdmUJw8koTd6cHjVTCR/yBl7vdrLrfWZMaSqi0MTQL2GRfJoCELGuFA
         6bskLXCWdwI3GjOTaPG2US9ykhLiUXlFj6CErvkEr3zxdZ+U+xeYV5WzqZufvWP43eQT
         JqNyUgR7Fp0lPB64LYRKRwKD0zUETDeKiB/eZUdexSGYvQaulMHRuCiIGkexugTWGJpk
         i7Y9N0P3aoSJ0abSpN2SZMftJr/2w9S9WiVU7dJrI31h6vSE7wyzAjBuamhMau//rik9
         GpItUg4HuvM4CZdcdSdZoKsBfoclqJCmb54uFoGaTfpdeC9WOhXncIVF8WH70Y4UNUd8
         KAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741871531; x=1742476331;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwYK1vtIGu8AKr7d5DZZujGnya4yaossipP8/xTscq4=;
        b=A8sSGLJhKMJiBbXWHng4/6A04NfAk8qACJ+25B0h4RaucOx71ATn/zS9GD8Bx5IOIC
         2fX0RQEI/GW0Gcd7FQZ0JLlaz0kvdSVIaNDWKjyqqTZKfT2ASEMW2kmtDCPQGbtqpihH
         M7oY0kdeqEKLSN5DkK2jd/Es5RdwO7MJrwF3eDTwOmGRLXEE3rVVudvkB11y4P//50v4
         ZwmVFZ9CsH3UU1PorXYd/40MrHBX7h/1teLIRWv7MqQexyGKuXdc1TwZFUIXE6PC2FsA
         RPDkjZUiWko8QMHW0yOpDbnW3M0rEuaQV+lq+fKGgaJHsPQA0nlv6p74+rzuWZPWIpYL
         tA4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3g0YzBM17xTWN1YClQ+FR1uc7/oXKyyIeuA/VVLW0nEZhVIUdbbb+CX8oCghTzwjU7m5jB0MI2/lMvxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6IsbgQZtMOeraA6/fbCvu4NM9nfVBgV3Yo0Hpgpyb6kXcEcaE
	FX6zh0EHCmT9nnLoorJr/B6uDKUIyA/YEK5F6Zm4p6AS6OWdjxAq
X-Gm-Gg: ASbGncuG4j5lGqTrp2BkjNqxCag1aVUTaorDmjU3YXjy6wlaDpGYzLISZqCs9Fw2bia
	qsaCh3ywQCQNWc+rirkICyHM28vnvqLamwkoUfq6UxENKdvyEZWcd+uioseDNM4t+31e0DvA9Um
	4rRq3Wt4FpZleLEmdbE/ZD49FZL/NhvOcNAnVhsbtfAhPATi7KoGgb74FCp5Ak/BvTDqrK0BU9L
	Nk9vs8uXp4yPCIJaG/ahwaU508v6nLbY2SfXVFCd47H0mTHVMoMu/UPIvYznpvvBHWpctfQACZq
	O7DZfH9z/jC4M8CpUzmt7qloBNs790qAiC8=
X-Google-Smtp-Source: AGHT+IEgH0CG5aSgef06SzCJvmgMptc8klfdSuHRJlwjKBRgnlA8cLsLiRUzsG4uJ77t6uFQlEZL9Q==
X-Received: by 2002:a17:90b:4c48:b0:2fa:603e:905c with SMTP id 98e67ed59e1d1-30135e7dd3bmr3491447a91.2.1741871530193;
        Thu, 13 Mar 2025 06:12:10 -0700 (PDT)
Received: from [198.18.0.9] ([2a0f:7803:fac5:a7b6::1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6d52sm12539615ad.116.2025.03.13.06.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 06:12:09 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Thu, 13 Mar 2025 21:11:50 +0800
Subject: [PATCH v3 2/2] riscv: sophgo: dts: Add spi controller for SG2042
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-sfg-spi-v3-2-e686427314b2@gmail.com>
References: <20250313-sfg-spi-v3-0-e686427314b2@gmail.com>
In-Reply-To: <20250313-sfg-spi-v3-0-e686427314b2@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, chao.wei@sophgo.com, 
 xiaoguang.xing@sophgo.com, dlan@gentoo.org, 
 Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741871512; l=1436;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=9w1ScaeSlWhq6L0g6c/1U2BXB6YORXYaIQ7F9hz9/qY=;
 b=y6IxyvvuwFXWUchI1WelHOu7+mju3xNDsy3WvdI9VAq511ux6fzKK48wfDsf6hrr+pVYC/vJ3
 fD4fM4zDZdgAqOqp0ypkHLmYA1Iz+IPORpPRGe7/8lHkv6KavaPjD+5
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

Add spi controllers for SG2042.

SG2042 uses the upstreamed Synopsys DW SPI IP.

Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index e62ac51ac55abd922b5ef796ba8c2196383850c4..9e0ec64e91a2330698aea202c8f0a2ca1f7e0919 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -545,5 +545,31 @@ sd: mmc@704002b000 {
 				      "timer";
 			status = "disabled";
 		};
+
+		spi0: spi@7040004000 {
+			compatible = "sophgo,sg2042-spi", "snps,dw-apb-ssi";
+			reg = <0x70 0x40004000 0x00 0x1000>;
+			clocks = <&clkgen GATE_CLK_APB_SPI>;
+			interrupt-parent = <&intc>;
+			interrupts = <110 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			num-cs = <2>;
+			resets = <&rstgen RST_SPI0>;
+			status = "disabled";
+		};
+
+		spi1: spi@7040005000 {
+			compatible = "sophgo,sg2042-spi", "snps,dw-apb-ssi";
+			reg = <0x70 0x40005000 0x00 0x1000>;
+			clocks = <&clkgen GATE_CLK_APB_SPI>;
+			interrupt-parent = <&intc>;
+			interrupts = <111 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			num-cs = <2>;
+			resets = <&rstgen RST_SPI1>;
+			status = "disabled";
+		};
 	};
 };

-- 
2.48.1


