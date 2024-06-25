Return-Path: <linux-kernel+bounces-228836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 755CF9167A6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BB9C1F2539E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C8D16F834;
	Tue, 25 Jun 2024 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pv9kyThn"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E058B152780;
	Tue, 25 Jun 2024 12:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318074; cv=none; b=MOcPQ+1AXtWoCaxXfCWxjeTwx6hI69o3yEndMDNypBzJmqOWIfvJAJs3RMZNULm6PB2+NLfgTF82zcjvU2+5XKl2nBesswQejqyekQrFCabw2LDANFpT42mKMDHGsS+aRHpiwdeqSw/4lvVGhLmsRgNAxDidy0iPx2ZsC4ekklw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318074; c=relaxed/simple;
	bh=5lXq8p5pk5rbK8uHbRt0ytYVF2tdyL2YC+93mqvE/Qw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A31wJbjk5QyhZu4StgtW7PoTFMDKKZ7Ht6FiH8AAiuKdslOA02Wcg1JEjo1/Q2SumeVBKE2d3W6fWvtd5Syz7+ekBTPiAIo4NHTXCW5CeD7BMz3fipHZNNC4CZRf8EzxdHveRFXYkWlD7eDcZOF43I82VzxzCDGeEgyKiHJGaMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pv9kyThn; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7067a2e9607so2037093b3a.3;
        Tue, 25 Jun 2024 05:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719318072; x=1719922872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1+ZY9MnH9MSIo3P/myoXe4SqRYQt+K5cKi8iBD/pYg=;
        b=Pv9kyThnfSCry2Qhp80rrdPCDIyHJeb9yyJEl3lJwfoSMcJkzomoDWfEkp/vj62s4D
         5L+L0HuZ5NoWGxRIEjlqQNJnETO7vZ8D0f3mN6QFYXdzdOZ5LAHOkjNht11u8Tmu/6f8
         K1xP5kKDCxxYgyp4G6gUPaNfPWbHNFl6Bek/E8oQPYKXKdy7Cvr+QZW2Fs6ugcjy/31x
         z8X5vcd56L1NFj3UzCunlybMM1RixKGzC5606FsFGnpnAcGeWUkNSMBKHFwoLlkumgKv
         Mi0o9770WzkCR4cdEsaZAClTXXSAwEkcowjyJuojyu3gzilKyLp8RJJaDZ7/auNMyKdd
         Vayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719318072; x=1719922872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1+ZY9MnH9MSIo3P/myoXe4SqRYQt+K5cKi8iBD/pYg=;
        b=Ufw0pbQciBEN3XSliIXfkD+CP5ShegoyG2Kn8BpkzKbO7pBix2ssYx+Ahq8E4T45ov
         z8MvG16EMIsGOZT94+hahByl97eHvSkysfakRQvX2rGOWivHdgMS0W/EMQoFi/8kj5lY
         mS5K47T09rNMUhIGPgcSJI9fdXcLobl486qqzOeiRgH/gumDpMfDzTZ33ZZ5omnXXqbY
         OZ7JVyXN1p2bCRg23sqMI6U+wvdkW0nPrc+hULWLQwZ9AW2L1FbNaAfrhOrWZ0pS1FS8
         ubbG1YT+AV6zaiY63pLD5CCKTfE7v+gGwKf8PJ4waBHXulYFQerey9Zx7nv0UhPlzg4O
         tc3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVmPgAl7sUbZUbTVN+8nDxSGl/4nQg9fJTnl5bGPHB5u4t4nSXGLcjZChFQDtEngDmDCvgFnMwXVAaWXFCvIgoUeQZ6DHhXEWWkestxN96r6YktD4GMLnbt7BsLZLc7Q3+hxGAs9aUUxQ==
X-Gm-Message-State: AOJu0YyRaH7ra/VIKKznIuV3b8jdRT2wgxHgTvf2L8donPwk9Iv7FRnc
	1j5z2ZibvGEc7B5NAodEiqJYv++nVhkAPesUOet3K4Kkn2BuuRFj
X-Google-Smtp-Source: AGHT+IFHqLhGUImj+b/k14mrq94/fo0odtjnw+y814qaRfArf+OENLnysBYzvY6GBeeoij1w+51Yqw==
X-Received: by 2002:a05:6a00:180c:b0:704:1ac0:bf16 with SMTP id d2e1a72fcca58-70670e8fc2bmr9825666b3a.5.1719318072233;
        Tue, 25 Jun 2024 05:21:12 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70650e312e4sm7978146b3a.0.2024.06.25.05.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 05:21:11 -0700 (PDT)
From: Yang Chen <yangchen.openbmc@gmail.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	patrick@stwcx.xyz,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Jerry.Lin@quantatw.com,
	yangchen.openbmc@gmail.com
Subject: [PATCH 15/17] ARM: dts: aspeed: minerva: Switch the i2c bus number
Date: Tue, 25 Jun 2024 20:18:33 +0800
Message-Id: <20240625121835.751013-16-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
References: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Chen <yang.chen@quantatw.com>

Switch the i2c bus number to map the i2c tag according to the hardware design.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index ba67422a49b2..8dd2bbb15576 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -405,7 +405,7 @@ temperature-sensor@4b {
 			};
 		};
 
-		imux20: i2c@4 {
+		imux20: i2c@5 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <4>;
@@ -451,7 +451,7 @@ temperature-sensor@4b {
 			};
 		};
 
-		imux21: i2c@5 {
+		imux21: i2c@4 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <5>;
-- 
2.34.1


