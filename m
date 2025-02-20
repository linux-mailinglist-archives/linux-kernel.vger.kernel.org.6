Return-Path: <linux-kernel+bounces-524116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C164BA3DF60
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0849717E237
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EFA14A82;
	Thu, 20 Feb 2025 15:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVUxaFza"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D071D5CD9;
	Thu, 20 Feb 2025 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066706; cv=none; b=EnaAJmm+SYfxdvYJn3KLCRZfTSHHOp7o7/Y7TD0Fl4jnm/83GPsyn0UbeyPivS36+5Un1WIJsHbXi00vV06c86URPl+8u1GkrdDH6GE12Udp+plyFJe5N73PSvNpKvPLUVlbuV2ctxPYoOc/AGQXHR6Q+kPDkuR907uuza2e/ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066706; c=relaxed/simple;
	bh=oYN3yBwKAFhDDm+1KS08ubJwkHA6hRvCCNjKCImv9Lo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ni7BQpp4LPUHyOlr4PI0LUuJiBUxPTg6SYwr4LR1dVN3PwrFkOWoUeDrqShswE7EI4G687KehZkE235VR6ztM96agk3I9fJLx6YNlGszCkLYkavF1su3XihVVRyVNznuw/MaXBkvZUZgoA16L6i5K9XI4VIMW0gsftuNSOxYOnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVUxaFza; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22128b7d587so21253225ad.3;
        Thu, 20 Feb 2025 07:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740066704; x=1740671504; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NR8wjcpxYR1ODwGW2lEP9QG5C1p3MxomWI2/rfhGN4U=;
        b=FVUxaFza+wAoyBd2M6qghrsn/x65ZuUW+kDzxUHKYsfu/pdUSCZLgQnJgNLmBN7dR4
         TGT8y5KgcZKZf4HpKYcebG3na3OuDBmw7nAFCEjLUvEpc//juwi8aUVMJSkvherBIOr0
         GnAd7EZUoy+1D+xazA9AN43CTOH81k6mtThgRibYZ/N38vZ7RMpnwJ6xZGXSB1WWWYTW
         YH4GnAkxRqzVNFGUFAITKu5O9t0obhSsaumwGhw4ynC4GT+D13yzSfNzFqKkY+V1oN1e
         Qe0j6cgOVEmtQhOGAoD8P9Gg1DMfPxNCY4BUDtaiOGqJ7koTRhFff6QG7lxhm7fy/CQS
         dzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740066704; x=1740671504;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NR8wjcpxYR1ODwGW2lEP9QG5C1p3MxomWI2/rfhGN4U=;
        b=FdDDdeYH7neTEH9GQhzWeh0ZmRRMZjSFbVDikal3ypnsZT58Bx3q0rxOi7WHDiZYdY
         lXY1asSBVm5QIKMjdLaW6Id6uIf9rDVNXgW/TrfwXK7IndDEUHRoo0E2TJqF89FzG+Zz
         q6uVexObShpAZ/h9QICQcpw5Xu8KHUA0rnnsCBNT2WjUD0fA4D+1YPc9LFYBrFGdT5jJ
         ZOdThUb19FScBSvG0lBExfRTB8cXAGXOLYyZA4hLcRku6XNlsNsE2wXEPSRtNG96iUKy
         k2QaQI5/9wCWduiwPZa650DhNCfVpaieHD+DjYBcT65ET/DkelaqBeL3J0syu/F7pNDP
         CVNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyR7B56SanfdaWSuyWfm4GVE9SnNe3bmvJucy0YE8XVnUsePYzDtyxI6je0LYs1oWQnb0oou8pdDrsk1Ok@vger.kernel.org, AJvYcCXe8/PKkjRJw0P+5YSSek59bZzupjm/n/QNsE8Y8AhtqTvxjdtoyDRsipu1Dy4s+23ZchKBl5HB9/6d@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm5lSX51BAun0P/6CNhguLCKoOJgwklW34J6YVVc6pRLAqAldl
	sAX7R1Uxxl/XYuZWtoPQVUPj1qP44QnYZ4pahkfOP8Vqheonj+zp
X-Gm-Gg: ASbGncsO/I83Hs0Md6ZpwnuzlR2sHZaonkjVjWkFCKsGIoxnz3k1Aqq9bcY/JFWPHbm
	jOzhzy5ZDSEeGUrhcLFUtwCzsguUwVxtsyNnBwRUgFU2C1AoB2U7C5c0In6DCxROon5Vh3BLnbK
	y3ZlUjW4rg8vwwO8SRhnlVJuEbmZ0r75fLLnyXcx9I98dM6Durmg7tt6ancUD4Z70KYnst2S8L5
	Y2/8iSmADtms+qXYAUthdKKB7GGMcyQypQI+l67j9oUInbh8J3p/h8SUz+xkjSq1xoxYCxrIhUW
	0YVgRgjHubz45TOwPw==
X-Google-Smtp-Source: AGHT+IEPhTJ7Bb4lHaVGDGh+KJhL7uPvRBoISpPixnwur50FdUhQQiFL6DTY+T3N+joX7r91AEIt9Q==
X-Received: by 2002:a17:902:da92:b0:221:7e36:b13e with SMTP id d9443c01a7336-2217e36e109mr106022935ad.12.1740066703713;
        Thu, 20 Feb 2025 07:51:43 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-220d5349019sm123694345ad.36.2025.02.20.07.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:51:43 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH 0/5] arm64: dts: apple: Add DWI backlight dt nodes
Date: Thu, 20 Feb 2025 23:51:02 +0800
Message-Id: <20250220-dwi-dt-v1-0-d742431c7373@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGZPt2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyMD3ZTyTN2UEt1ky2TzxDRj46QUQzMloOKCotS0zAqwQdGxtbUAUIX
 q01gAAAA=
X-Change-ID: 20250220-dwi-dt-c9c7af33bd16
To: Janne Grunau <j@jannau.net>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1533; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=oYN3yBwKAFhDDm+1KS08ubJwkHA6hRvCCNjKCImv9Lo=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnt0+MA7ICfOW6+7b5FNbtbwzzWetcXXX3Ugu7b
 wy4NbpzBBeJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ7dPjAAKCRABygi3psUI
 JD9sD/0bhTf5uHb6Eivm89d6HiPlsmiSfNzME1MqWK/3RuukOjP0F9KRGyYTRV1X4EAjahNswEN
 eKiMl2Czugtw4m8N6udUQhbnHgeSRj5ztf6qy9aruaXVKt6WA0OTASzmzhCadhfl8E4oBWriZ8O
 oFMO0m/IHBI50Jhb8uv6EuOeng1HIBtW3oWFiKW99U5Gv6aM/WdOYkKZUUlIFmTkpHpAzBHjNIS
 7zeS5OQnB9FMzTKqt2cQobcVV3wtc1hRg2i2l/hpTJD2MN3yKg/LRo6QTwgTPD1ntqNnFK3ol7G
 SAqq6cogOhqOXl2kFRZKQsIsUuhFZ2evgLJ5JPO/dBN1Fhz4R8o2udBxGoIWV9/o2NkXuBRd78U
 kRdzsMjRrPugHF5/bVlycF74hmNfBeqGT3IDA2ApEn7PtvZ5RY6E5J83aBsEFtPQPUc0yCcE7Oi
 TpcWzEnjJ6I7K88RJS2u65z/JSxmg7HvEKU3Ik8D9stTXpFZ2J6X8Cppx5yAJA3Cyid+b4GSBny
 f+KpBpsoyUoCgMiLkU2LgNhxmVA5+H7cEdxiNC23vzDU2m3ZIYUImQKvAxNtAn3XHd5uZtDWB52
 m06nV2Nbdj4naLaUMiu6bpFG3SZ8ZYwaAy1JMFra7SbCP9kGSgM7/LfniRYNTrEz6zUmZwoWnEo
 DcZhuh9XZ43nSFg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add device tree nodes for DWI backlight found on some Apple iPhones, iPads
and iPod touches. Not all devices have this feature, as some devices
instead have their backlights directly connected to the WLED output of a
PMU or use self-emissive panels.

Devicetree bindings are in the driver series. Last version at:
https://lore.kernel.org/asahi/20250214040306.16312-1-towinchenmi@gmail.com/

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
Nick Chan (5):
      arm64: dts: apple: s5l8960x: Add backlight nodes
      arm64: dts: apple: t7000: Add backlight nodes
      arm64: dts: apple: s800-0-3: Add backlight nodes
      arm64: dts: apple: t8010: Add backlight nodes
      arm64: dts: apple: t8015: Add backlight nodes

 arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi     | 4 ++++
 arch/arm64/boot/dts/apple/s5l8960x.dtsi        | 7 +++++++
 arch/arm64/boot/dts/apple/s800-0-3-common.dtsi | 4 ++++
 arch/arm64/boot/dts/apple/s800-0-3.dtsi        | 7 +++++++
 arch/arm64/boot/dts/apple/t7000-handheld.dtsi  | 4 ++++
 arch/arm64/boot/dts/apple/t7000.dtsi           | 7 +++++++
 arch/arm64/boot/dts/apple/t8010-common.dtsi    | 4 ++++
 arch/arm64/boot/dts/apple/t8010.dtsi           | 7 +++++++
 arch/arm64/boot/dts/apple/t8015-8.dtsi         | 4 ++++
 arch/arm64/boot/dts/apple/t8015.dtsi           | 7 +++++++
 10 files changed, 55 insertions(+)
---
base-commit: 3febe9de5ca5267618675650871a626d0901f8cb
change-id: 20250220-dwi-dt-c9c7af33bd16

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>


