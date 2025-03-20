Return-Path: <linux-kernel+bounces-569932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEDAA6A9C9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B4948590E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866691E7C1C;
	Thu, 20 Mar 2025 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4dVh8qs"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919951EB1B7;
	Thu, 20 Mar 2025 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484278; cv=none; b=D6yNBybjvyAxpaPVPQ7UOC52TiOApELes1vwNO9kQtmw0e+v0mmNDtIB6O0lkMgKkABvUH2X5bzwPhuqn7x6JNWnpXogLS1W1b9UEEd42o6XJ83G5Js4T2Qf61j6oTmcvMdFbgkFJ1jj3uRwwzi10IkqozTOUlYM9StQv7cns/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484278; c=relaxed/simple;
	bh=BbOh4hpBKP+yiYoTLN8aSP+ooMjZZlQ3ZAt1eegwZSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cN3q8Ks3cHtQ5deo8ocgmbOTla0zfg512Q8ll/L48WCKN/7g68Q2B9nFQWLd5OZxiLFoo9TIMEVMLkULSskYUSRfdDDOhzz4mrCl8cyZgNgbvtBpJeQyl0vjfo9Nb9eDT9nfWRXRisIa3MR4zlAlGrI6nllqvuVjuIF8m114PiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4dVh8qs; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223594b3c6dso21828025ad.2;
        Thu, 20 Mar 2025 08:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742484277; x=1743089077; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05OyaXbL0WKbLYpImlnz0xJZmG54ud3JNw7Cj+unigE=;
        b=K4dVh8qslEy2kVelZg3RzuNofZtzqiTZfYXtg3mEUVYLNgqazGpGkOHJ97BQUdsY68
         oUPaGkSdXme0prpEkBpDHCAndQmKG8nGA6HX6UbXu3qtuvV786Hr8Ad8GKQlz52YghhW
         BUoElDqV+3UP61hR3cRinTL4Um05a133a4qV4hrnqgZNFX17sZP05dJyc1mMCG9cBfot
         o4gSqBWL1LYHquyJCjPKAFXWevzFcufPVdJGZzpWBoZQxFM+w2GninJp6UPPnNKuRM4V
         t14Za0qrRLFaicvkXGChoY0xfHniQIe0ggImGFtU89j+nMTjF4A5+cmDW9YV3aK13rES
         SaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742484277; x=1743089077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05OyaXbL0WKbLYpImlnz0xJZmG54ud3JNw7Cj+unigE=;
        b=wPMJQmzNI0So59vlx2s0hs5VE1L6iODDKA+ZnKRczMLHJhY7NZfkbzvV09uoEVcfmf
         6V0+cuLM1Ih/G+Lph762r11vOlNhYcOzb+mG+v/awBy4sm9sJjZYtnt3f2LI8RmVWZNw
         p+7OR+TtWI581mQixboNUsghXdejwE/YZ+kpAgwMbKZeQuVQOZmo3zdpZcZuDaBfNGjB
         PHahkmdySXfqgyeTQln4DENOQ1OCNGgEZ/8wmkqIcSRkjW1zzipMsQVdwK4ikrhI6dTH
         Fz416pj45w8zvoBXbv/BYHnmWOi77mFQMpizq042ZDrAa8cWo4PRz5J1IuPKd8bK16YL
         O1lQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3KZL1tHxyBMxg/KIkzgtyH6iilct0TwosPvJr2q0iQC45gjuU0rq0Q9hWhK6658xB1ir+DNpTVGLH6jg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9vduK5ymhYegxHkUnua6v3zKsJUb8dL7p9HEXo36bdNS/ejJ0
	DJAbH5OLtbfY9W1XWhb3sIO/mQTbXo57N+oCIE6y+C5LkCb7i4UD
X-Gm-Gg: ASbGncvcENweKMxxlF27tIty1J6N8pUES8hq0SBJap1TJJmlJmgRCqYiSxmkAp1Wh4+
	akqY5k4n4YNJoC6PU83DX5im1S8VICErbvkWYpqH1T2KAR5lLF0cbgphfQ31xuPcWMp1lkAI6cA
	Xmta5yVIbF3zv2SIQU4dT+YutTxUAa8L/gLZ37koOVRX/1HAdOJYcXIdRi8gCsdowTmB56KTHn0
	HfZB1exOmVksGurik/RnCnXgqbSySFl36i5hvFeRofBoP/VJs7ZT/aW/XPY0kx+thnlFbS/nZw0
	ha86v3VUc5tXDv+KaztMEaelMXY6XwLOEvYWLFkWv6RmMbaAoXx05yQSXKn1+XgYsx/T1hMWGhy
	6qMuZTzlq2HUG40cDuRfNFw==
X-Google-Smtp-Source: AGHT+IHj1hKtEvHY4K2obRAbNlNDdOGviaxrQInMcRrSsFARmQxza4ZWUoKeC3VbewMkZiKEd3E/Ew==
X-Received: by 2002:a17:902:e952:b0:21f:6fb9:9299 with SMTP id d9443c01a7336-22649a39147mr113462995ad.27.1742484276613;
        Thu, 20 Mar 2025 08:24:36 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4a8fsm136905515ad.234.2025.03.20.08.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:24:36 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 23:21:53 +0800
Subject: [PATCH v5 03/10] ARM: dts: aspeed: catalina: Add MP5990 power
 sensor node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-potin-catalina-dts-update-20250102-v5-3-e161be6583a7@gmail.com>
References: <20250320-potin-catalina-dts-update-20250102-v5-0-e161be6583a7@gmail.com>
In-Reply-To: <20250320-potin-catalina-dts-update-20250102-v5-0-e161be6583a7@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742484265; l=843;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=BbOh4hpBKP+yiYoTLN8aSP+ooMjZZlQ3ZAt1eegwZSA=;
 b=t3XeTPeMe/feqDs5kyWMJO1V/KGXDZV/e8pSivSrIpjBo0AGxGT5K/40MgRoH34PqMC2NE2Ao
 STCG4dYtDd7BiMAKbAO6DBcz7ALnIqU7gxBuIE9ZodGDZH1RkiU29DZ
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add a device tree node for the MP5990 power sensor to enable monitoring of
the P12V supplying power to the fans.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 307af99e833c..f5f47245796a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -428,6 +428,10 @@ i2c1mux0ch0: i2c@0 {
 			#size-cells = <0>;
 			reg = <0x0>;
 
+			power-sensor@22 {
+				compatible = "mps,mp5990";
+				reg = <0x22>;
+			};
 			power-sensor@41 {
 				compatible = "ti,ina238";
 				reg = <0x41>;

-- 
2.31.1


