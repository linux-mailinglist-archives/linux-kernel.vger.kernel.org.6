Return-Path: <linux-kernel+bounces-298322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A51895C5BB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7D3285373
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 06:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9158113B585;
	Fri, 23 Aug 2024 06:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akxEyxe/"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D29513A878;
	Fri, 23 Aug 2024 06:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724395416; cv=none; b=qw02VFnPBkYRW82/c2VG55sc9DkjALK1neMmeQUYMoJ4x2S5ElHr6Tu3aFPf/IhzLWV37l6A1nwNZgTELDOo4912V9JI/2CQKTYWio/xzVANGMJcSFgVA2KW9Gd2zpyU9MirZCWl3ER9l9xzh2YCmvIPs4d4pUwbLStlGWL+JRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724395416; c=relaxed/simple;
	bh=lYDLdUYCrwY6a5mhCSzWWqlmyXeb1cIG1mcHjoTXl7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sGVBMSiyHzZr3/SQB3eSh4bvD1ilYbSJ+55pz/jeJNn088gu0wq74gj9XU2wkeoZQnA7nE+lZeArfBxTcz22q2RsNuQNHIAdoZBL9/IVfpLAe8a2tkIjj9V3xSkqISXTCxyoWxs+BOn43o++rdkP30HLAJxWqxi6nyDI5X45cQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akxEyxe/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71430e7eaf8so1353556b3a.1;
        Thu, 22 Aug 2024 23:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724395414; x=1725000214; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYOh/f+PKMG60Z8skNFtKlY3aoSCdSNzYowt/XP3s7A=;
        b=akxEyxe/WgUShzjXOpIqVMe6CHIvuWSTsUg485RGWb2noiT2ibWQ+44a68Q/iuCB8h
         CshDHeniV7M+sdBHa3YHJo4nqZW3DhNmN84bq+3yI7jnbLnhYBVichbC3DMe8nicTC9h
         aCVHsZgykkiyJ/Kj2K6uM03HCMIMaF28NFM15nphmYrehtVVUf8ldFwpa3dORtnI2PzK
         O6/MuvwurcdTZykzU6UKV1Drs6fFHcNbzd0gymFzrKF0v35IMQ8KYHfX3mC3ibEblINN
         Q9nsDq25G5lAP4RP/Ab6D7yxb2zB0RTpOI4q9zR1xp2K1vjy1DzUx0Ul5ME9nWVvfZeB
         U4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724395414; x=1725000214;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYOh/f+PKMG60Z8skNFtKlY3aoSCdSNzYowt/XP3s7A=;
        b=sa5xEownC4AaB7JWVwV15o83cEsusP01ciENvoXihzEpvpiODdlcWsR3kK+z80i4Gh
         2MozclomrzrWO80SmdLPdbXHou5GBT05e5Mdw3pl5RNrH/x1jdQepMwR1c3ra0/7U12j
         2lgO6AiLnfL4wtEHOqAKsl+EH8q/ePQ1pPlGt/YhdPPcUxtLWwL9lRiEHsgqK0nj3XPC
         9ePViMv8ueqWSOnNb9bzzbFWJm4JzcN/WUX6mk7Bn+gMvYdd6SR73LXbaubMCmvDBJbA
         vMyN1Ou+umkFeu0BsnnmllzqDu11yqBwnHM+8XOtJz6zhgph2JCMMP0pu1SHuoe2MDLu
         BWrQ==
X-Forwarded-Encrypted: i=1; AJvYcCV63MUeYdJxCEuFrZvAMa5NyvPTIaTsZh4U4GSK3QEPJ7OmOq2TkDzMACaaLRD7bj+arzOCC1jlfth8vVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLgnQKLDNpQui3z3WOR5BZGrrgNhSzjrLxhjtv5sdMG0FxM8x7
	kjtuGTWFg7A9ygKW5rRtPQ02iDcv9AITkBAsJj/z20O7huR5akmhgNaBow==
X-Google-Smtp-Source: AGHT+IGlBZYDSqKBx7X1Mk43LIUY+lx64RE6npOl/5VVD27Pa2wZ0FJ9ehRRbEHdmBkFN3jhNBCJ1A==
X-Received: by 2002:a05:6a21:648b:b0:1c3:ea28:3c0e with SMTP id adf61e73a8af0-1cc8a219ff8mr1663209637.33.1724395414091;
        Thu, 22 Aug 2024 23:43:34 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385565468sm22339945ad.11.2024.08.22.23.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 23:43:33 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 23 Aug 2024 14:41:11 +0800
Subject: [PATCH 2/2] ARM: dts: aspeed: catalina: update io_expander7 &
 io_expander8 line name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-catalina-ioexp-update-v1-2-4bfd8dad819c@gmail.com>
References: <20240823-catalina-ioexp-update-v1-0-4bfd8dad819c@gmail.com>
In-Reply-To: <20240823-catalina-ioexp-update-v1-0-4bfd8dad819c@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Potin Lai <potin.lai.pt@gmail.com>, Potin Lai <potin.lai@quantatw.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724395406; l=1175;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=lYDLdUYCrwY6a5mhCSzWWqlmyXeb1cIG1mcHjoTXl7Q=;
 b=oHa/a+5k0qYnt5eQi/NyV+gpqBLSkMV2yxTRp0mT7pJWN3Zb+iBz0wLKCBsEJubzC8SNYExBi
 VD2c4DsfhCgC0/oze2kJY6QlG1hQhr1+4i6WFBYQ2sQP1YPrr2qj7BD
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

io_expander7
- P1-5: MCU_GPIO
- P1-6: MCU_RST_N
- P1-7: MCU_RECOVERY_N

io_expander8
- P1-5: SEC_MCU_GPIO
- P1-6: SEC_MCU_RST_N
- P1-7: SEC_MCU_RECOVERY_N

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 3a00182084a5..82835e96317d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -1024,7 +1024,7 @@ &io_expander7 {
 		"CX_TWARN_CX0_L","CX_TWARN_CX1_L",
 		"CX_OVT_SHDN_CX0","CX_OVT_SHDN_CX1",
 		"FNP_L_CX0","FNP_L_CX1",
-		"","","","";
+		"","MCU_GPIO","MCU_RST_N","MCU_RECOVERY_N";
 };
 
 &io_expander8 {
@@ -1035,7 +1035,7 @@ &io_expander8 {
 		"SEC_CX_TWARN_CX0_L","SEC_CX_TWARN_CX1_L",
 		"SEC_CX_OVT_SHDN_CX0","SEC_CX_OVT_SHDN_CX1",
 		"SEC_FNP_L_CX0","SEC_FNP_L_CX1",
-		"","","","";
+		"","SEC_MCU_GPIO","SEC_MCU_RST_N","SEC_MCU_RECOVERY_N";
 };
 
 &io_expander9 {

-- 
2.31.1


