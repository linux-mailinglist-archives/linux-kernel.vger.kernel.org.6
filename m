Return-Path: <linux-kernel+bounces-231881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 846F2919FDC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1708AB21B54
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAC773451;
	Thu, 27 Jun 2024 07:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1yyJGFJ"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CBD6FE21;
	Thu, 27 Jun 2024 07:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719471637; cv=none; b=uRGN/yvNQfED75nmmNoNrJKneNDdTKxktrMQVvrHZQMq9VN2ko9WdazeeRUFzGDwU09yN/ISnNNfEP+AfQSLlGM4V/n9MXMew2jBT/TEMGr2b+1l++QRRIfaWYQ13lh4X5lSU3zTP1bJuqVV8aZfjD2XBDfs+p5sKiizH6oQBr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719471637; c=relaxed/simple;
	bh=qD5mKUPsOffm3Vw4RvRq91ySvZyMyi8SCo4G6Vl9FFY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ouKyOq07mENmJ8dWVYPtYj3F4uCTjj6xWUzuBwMF1u62zPsXKVcWRJvt/O3QW/LBJg+ddVeWFbKtwmdJ0pLA2/wLIW4QbOajR9QUfC6jkhzFze1kNHTFgUVOVQlEOuiHzcgO5sJnS3OeUDYkWmWeQTRqn7X4Y9vFW0DZMEEFUfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1yyJGFJ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7067108f2cdso3953482b3a.1;
        Thu, 27 Jun 2024 00:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719471635; x=1720076435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i53cLyoOWskUbqWkTIcWB8akUWR3OQ8O+64UE165czU=;
        b=T1yyJGFJrvT+b0r8CWj4gug/aaZUIQ+v6dRgIyWy9+yVVWewo8wqIL2KAQk6QZBuSo
         Zh+i2+YjbMVC1+gz7CRBQOS7x/GJKOEOAFpCGVNO+8C0TcuOEwgxv8F44dyyjlm+U3Ui
         4woBON2lY4qgR4XLWXtdREZpUi4xF524QPrDD8AUZ3NFdDCNAtue+vR/4g8B2oD7YROh
         OL/BLfPndGxPc1GpurZSJCivTaGDres7XXn8k9DftjUI2xs6ffKG9APNW4RqYn3l4JQj
         XWvHRLhHgcACGHPgJwZjxjeAM46rbzl+AAFH1Uu0O8cHgtyuJXF0KKjcy6zo9ymi7SGT
         aZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719471635; x=1720076435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i53cLyoOWskUbqWkTIcWB8akUWR3OQ8O+64UE165czU=;
        b=CGIvE7yDiyt1i7yI1kwckSH5h9qD1Vksr0E1Lg/VJgf6vfV7aSq9KO2LjwPBdU0hYQ
         GJzvPZ4/0WlXq0rSEzbK+iepCiIC8IHDj753aAsdXaZQD2ra/ZkBunorfp4g5BKhAVp+
         f3cTnB2teqrD3l9xErBaajbvC8H7DAH56pheRPhiiEo/YerMVTNvfHssJqgE4yeLfpbM
         F7LeE/GaEGvCDZ1eg761VWVjfg4oXl3RMUdbsKlhiyA3RUABjr3v1f3AUdz5vAT1r3j0
         rXcmHQ9TDYXbnpzm4tz4oVChs8A8lespCk9+/k/LDXBDXCAafITDef67SEBRbT7t6MaT
         vWaA==
X-Forwarded-Encrypted: i=1; AJvYcCXceawT/duWg8X3LDuEKIFxlIoWGS5avJ2l0011ImjT5hOKXqdU4/nV9DzkZbaKTnpvR4TgXX0+xgOh7o2Co663R99uOypb7w03A/i2W9B0skv+PLKX29KFi4jRv5Pu5xWT7TUnLnrBlQ==
X-Gm-Message-State: AOJu0YxxHWeVi9DaBOvgKfH458OjecAd6i3oIa7PZZpM40BRwG1PZ6i+
	HwVDLPwQuWk6cOIa4wj0EfNrIMDrW1ahAlK8QdTH4e8SLJGtlNl1
X-Google-Smtp-Source: AGHT+IGQP12PAiVlcbL6uPoDRoBa8b7kEnCv6Dx8RcyZU3Of7JGT/laCF7tyJWI2YkxI7D17OHIuhA==
X-Received: by 2002:a05:6a21:32aa:b0:1be:c2f4:2e3f with SMTP id adf61e73a8af0-1becda4aa27mr1438583637.56.1719471634740;
        Thu, 27 Jun 2024 00:00:34 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e306-713d-05da-7754-dfb7-477a.emome-ip6.hinet.net. [2001:b400:e306:713d:5da:7754:dfb7:477a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac997ed1sm5962145ad.211.2024.06.27.00.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 00:00:34 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	amithash@meta.com,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/10] ARM: dts: aspeed: Harma: add power monitor xdp710
Date: Thu, 27 Jun 2024 15:00:07 +0800
Message-Id: <20240627070013.2509150-6-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240627070013.2509150-1-peteryin.openbmc@gmail.com>
References: <20240627070013.2509150-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add HSC xdp710 device in i2c4.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 7d809f1636d6..77eaa89b5eb5 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -329,6 +329,11 @@ power-monitor@44 {
 		reg = <0x44>;
 		shunt-resistor-micro-ohms = <250>;
 	};
+
+	power-monitor@40 {
+		compatible = "infineon,xdp710";
+		reg = <0x40>;
+	};
 };
 
 &i2c5 {
-- 
2.25.1


