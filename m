Return-Path: <linux-kernel+bounces-213537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8CE90769B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B586287994
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD6914A0B9;
	Thu, 13 Jun 2024 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bp2Se0zP"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD55B14A093;
	Thu, 13 Jun 2024 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292400; cv=none; b=ibnFRLMVJvuxxXUbvQzneiHlc7jI4sNL0ikDVYq8M4n7WmmklU9WQemWq3HUV41cQoYw1O/AP1+yHBMn7NSg9wOxemK26qAbw+KR+H0PDpDi3qBFtNr8jgSHYq1r2Tk1YanYI9B3HuQmePuSM3up9cB6gCZzQ2PzXaus3+/jIeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292400; c=relaxed/simple;
	bh=7dOVn9fex2D1bzdJbHbJ2ukAVY4lruqwL1x38JLToNM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YPcqNVUp770PiYlJU2uwHWmDLRVhVkwwiI21WIqiJbh3rbUM+Cin5P04d8JAQt+QcbnzUVFWPLouvqCgl1VCrCD9sJ4Y8viivDQmFtdeZBg5+tQThaW0wsDpN7EJxD6+mMlQz+kxGgehW+Y6BaO1ejTLkhr3Dh8/n9Df/HTMylw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bp2Se0zP; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f9fbec4fd9so668223a34.2;
        Thu, 13 Jun 2024 08:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718292398; x=1718897198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+iX8aCdLeiSd9q28ms9w1B6bv8MCufq0seR2PtHpfUk=;
        b=bp2Se0zPMp5Jq0BFnOFC86irZ8j7qthBVGItDbBO3SjLQOvGFG3RCfTtAFyTkvz4I7
         ZRSrCLLeVpuffgwYen+DCLB5klT3mTsOmS91C/rPLXUntrLIlzwm47R1a9Rlj9tozX8O
         2jK13HgFIOA1GAXCYABe/dSmSWInkg7i74Ph5qEeYpF5DPEJaz5whKolIqsS/mc4CPed
         ONnb0YviuHHMHJA7ORxJetQzNZxHh/4eV6r/4MctVdzyCGBFzfRriQ9uQxzrrTwOZAdz
         GqvjY8ZeM0gQ/ptdgALJONQK7VZLDuB2ifmmcMk/ztkDxppBmV5IbIx1veWPHfj6TYik
         a3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718292398; x=1718897198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+iX8aCdLeiSd9q28ms9w1B6bv8MCufq0seR2PtHpfUk=;
        b=PX/QbSi3UCy0Jq/9eQ1Ug+tkalb4hkGPCXPo47S7ddC4EKqtMujfBPSj+xfviQLpUF
         QG6IYHDOrnzXF5Po6BaG1vOeD6JP3xE5xqvtYoSp3xF8y9vcqkb2Hef9zp+xuaIvIfWO
         AG4QfJHT6JSH30oJgHSFSvYV3ry14zqAB8am2X5Fd614Zu9dmRePESsl2CVhAKGVeWNR
         oRX+MctlHDWHIwBDTyslnilHd92ONJ9j6GdT9BEO/EWaEHSOc36CNrUn4p0G7AS5qR2e
         ucU/4alsInU942kZm0MIzR5HjN2JCxo/QU67fl/V6+pLHYguMXUkmZucGJWqSKroJj62
         qudg==
X-Forwarded-Encrypted: i=1; AJvYcCUjFfRljvPQTFtyv5IVtjJs5JbK3JmMgOQMV2UAo9YlyhRBkzCSsULjcxYaS0+lcj+K8u68qiv/Ta+Vxzkv4wSWzf6GXVULEr2z0VdaUdFT4MDlLtnIGnZumSSe5GiH7dfm+XSGXSgj1w==
X-Gm-Message-State: AOJu0YzqIjI6so8LPO8yL1dqqfHu6LNmu1+H7fSr35if/a/W0QQP1H3+
	Tp8nzkEckP70C4OWHRz/ksDdy73aXmO4Vd5Ll2dxJR6q2CCEJ0IP
X-Google-Smtp-Source: AGHT+IEj3DrHn3ST/RUxDPjwBzLIUyUdRzaBpzGlYtxwv9jX4plp5kdttH1p22qdwS0sdbs8pkEyzw==
X-Received: by 2002:a05:6358:7e0e:b0:19f:174c:7fa0 with SMTP id e5c5f4694b2df-19fb500f43fmr7937055d.24.1718292397778;
        Thu, 13 Jun 2024 08:26:37 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fee41663d2sm1198183a12.92.2024.06.13.08.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 08:26:37 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/7] ARM: dts: aspeed: Harma: add sgpio name
Date: Thu, 13 Jun 2024 23:24:21 +0800
Message-Id: <20240613152425.1582059-4-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613152425.1582059-1-peteryin.openbmc@gmail.com>
References: <20240613152425.1582059-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add power-chassis-control and power-chassis-power
for phosphor-power

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index ef5ffe190445..06c8b5ff1125 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -520,13 +520,14 @@ &gpio0 {
 	/*O0-O7*/	"","","","","","","","",
 	/*P0-P7*/	"power-button","power-host-control",
 			"reset-button","","led-power","","","",
-	/*Q0-Q7*/	"","","","","","","","",
+	/*Q0-Q7*/	"","","","","","power-chassis-control","","",
 	/*R0-R7*/	"","","","","","","","",
 	/*S0-S7*/	"","","","","","","","",
 	/*T0-T7*/	"","","","","","","","",
 	/*U0-U7*/	"","","","","","","led-identify-gate","",
 	/*V0-V7*/	"","","","",
-			"rtc-battery-voltage-read-enable","","","",
+			"rtc-battery-voltage-read-enable","",
+			"power-chassis-good","",
 	/*W0-W7*/	"","","","","","","","",
 	/*X0-X7*/	"","","","","","","","",
 	/*Y0-Y7*/	"","","","","","","","",
-- 
2.25.1


