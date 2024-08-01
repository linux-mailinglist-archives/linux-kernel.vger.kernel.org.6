Return-Path: <linux-kernel+bounces-271561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7902994500B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 354A8285E82
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500781BC089;
	Thu,  1 Aug 2024 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iL1So2GR"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E8D1BBBFE;
	Thu,  1 Aug 2024 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528252; cv=none; b=mmBfcOx8CPXZH5fPM71I8X9xjTjH05LPIcGVJLwkGruAqXap1AmgpHjDQ7fgbJpXgWZk7ygKocrgbZleqTkCDRAVpI8TmoUsnRomc3jJr6ZoA0jTkvSA4ugEDSppNUuVQIm5zU3m8WeooyUPRSGnRDxdFuxePUfLZBogOwEsWb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528252; c=relaxed/simple;
	bh=HnjvJtny44jqlitgsTMTi4vCgVMO+EzSF7aIOKVgyp4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pYL8ZAug+Kv0ujkcJGtu8h1xTwFF9TwjLjOytWJ8G5iPImA1YHRojvv3aZyQshTqiM8wA0nnNBFjJXHsazgkfF0XPx6zx/qO0nzESLcxdsGQDpUq0DXc40lzbMYIJcyIBxfqs3gcVq7qybTcZZZNuYdC3iJc4MUkZBx1depq4Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iL1So2GR; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7515437ff16so5425574a12.2;
        Thu, 01 Aug 2024 09:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722528251; x=1723133051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ikAlSYKd4FAKko+mbSzcnWgebllBxMH0Ig9OFX5Pv8Y=;
        b=iL1So2GRBcfudNWCT6svVv24Tn4tb8O210wikFNlZw0kEnuUTOEDuYdqbko8WmGdkY
         hsAeOugdlrkEreykGLsZmdDSricMKOzNUDHLck5t82O/X39e7IKS7RekzYK2ZTYKkNCx
         ISg81dz4nEjsxXfJwKGjEAmmJnPvs6cp103o9pNp8Y2Ms8pN9gZN1uo8pvhCe9eWYIgT
         B2mTJijYj0kxCv2TyJOyPeiBubbZuoPrjrcjaRF1vnzTllNxeTM9bnJ6aqVyEp00BySq
         oYoFNU6LVFzic6oVakcyeRR8nQEeg5zAQ2Jte1gINIwlfxIOlOfQJOv800zbsWQQz1vC
         P/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722528251; x=1723133051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikAlSYKd4FAKko+mbSzcnWgebllBxMH0Ig9OFX5Pv8Y=;
        b=oN2Af3lN42fDRVICdSV9G9il2Z3X00LG6uayKKzZiOLuXpPK4Q0bIjdqvzstlug3fx
         ui44uxbbGAczXpU7mPg5P4j4BCmqfDAi2Faq4OzG1hrwQ5cu10AfLXZuJJUEwc68UZ6W
         d8DMq/0z9zxNB5zdXFZ3Nc8KiEPm0pybH3mK2UFeDo7HhndAPQwfA4KK2dUjUFD1JQ8Z
         ubR6YXm2v8gPS7PgJ04jiCmeBHxx11z0rRbmUee9ECrkruhK9HNcDEQDyuqaQ87ABsLH
         d51qRuMqViHJ/g5oIvqHZ4OOrX7y3GNVDsr/1N6JMXi7AYC1q85zYuGEMRUEfznEQvCl
         bbYA==
X-Forwarded-Encrypted: i=1; AJvYcCVkaUzxqr3PEPe39fKYcroA5z/akJzFEYx6x1Zk8tG+LOCXp8c2xHKzQx+FXlpt/tmqazwarqtOdRqQy2s1kn/FAjNFS96NhIm8Fspl8RaVSeqW61oYP39zRJxmV+scIeeWsWaQDM320w==
X-Gm-Message-State: AOJu0YzwsvzzjJzIjE7jhlF/HEp6/0PbI4dG59DWJdLW7UcFacmP6qsw
	2RcNiu1+a+UpeR+WbiEUbU9H6J784zfRlT2M2AAzbJhPyOQXlhpJz01Bsg==
X-Google-Smtp-Source: AGHT+IFKgL3S2d5GTrQ0YRnV85K+aqoVwG/L93JmVq42fiXFGURtoW8VEBS9oWRamZEmCVq/LzyS9w==
X-Received: by 2002:a17:90a:fe88:b0:2c9:7fba:d88b with SMTP id 98e67ed59e1d1-2cff9419943mr852723a91.14.1722528250638;
        Thu, 01 Aug 2024 09:04:10 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4cf181sm3535268a91.37.2024.08.01.09.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:04:10 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/11] ARM: dts: aspeed: Harma: remove pca9546
Date: Fri,  2 Aug 2024 00:01:35 +0800
Message-Id: <20240801160136.1281291-12-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240801160136.1281291-1-peteryin.openbmc@gmail.com>
References: <20240801160136.1281291-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove pca9546 device from i2c bus 9.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 31 -------------------
 1 file changed, 31 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 4421822eb134..cf3f807a38fe 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -20,10 +20,6 @@ aliases {
 		i2c21 = &imux21;
 		i2c22 = &imux22;
 		i2c23 = &imux23;
-		i2c24 = &imux24;
-		i2c25 = &imux25;
-		i2c26 = &imux26;
-		i2c27 = &imux27;
 		i2c28 = &imux28;
 		i2c29 = &imux29;
 		i2c30 = &imux30;
@@ -409,33 +405,6 @@ gpio@31 {
 		"","","","";
 	};
 
-	i2c-mux@71 {
-		compatible = "nxp,pca9546";
-		reg = <0x71>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		imux24: i2c@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-		};
-		imux25: i2c@1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-		};
-		imux26: i2c@2 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <2>;
-		};
-		imux27: i2c@3 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <3>;
-		};
-	};
 	// PTTV FRU
 	eeprom@52 {
 		compatible = "atmel,24c64";
-- 
2.25.1


