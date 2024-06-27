Return-Path: <linux-kernel+bounces-231877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D547919FCD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB9A1F28144
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAA14D599;
	Thu, 27 Jun 2024 07:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9j3qIun"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05804D58A;
	Thu, 27 Jun 2024 07:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719471623; cv=none; b=XLxIEAuj37wDVL1SJ5DSxN5bRphVKjwflwoPkUoiWJOuU9cGgbJ21QbUWDTvm9s/YajtbCZETUd76RiKOCiDi2GddIDO567qsHu9D1uvnUo3oQ957D8l4OHKpNdtIgDIA1BtIwHH3vLC1/etqZkGNXtSvVMFh6+t99TALwoGNEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719471623; c=relaxed/simple;
	bh=lKEyCcZ5xvVxKerc19SgPa49hrP9i/Su9pkaJ2TQK24=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D/2t/uVlfOAl6wqzQ6JpnbF0dbSvqvqo1cNZqA6nbeTMZ49EaxXcvob0VG2bnVZybFREuD28icmeKRiiGN51Ab3n88g/ubNQ2GYZGs61Np5Gg0WLxZ7Ok7haWj7C2/qK5SHM9sYkiGhaDyD30j1jHGVgRumR8toseqvVUe0cD8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9j3qIun; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f9c6e59d34so61899575ad.2;
        Thu, 27 Jun 2024 00:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719471621; x=1720076421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0oqZSVf3Pja7+3axQ7FhMBZCb9fhp3k28x1dNv+Nkh0=;
        b=T9j3qIunBo+U+4MiO+WVxvx8Vj8D5m4BTiguzwjjfng4jO43blrin9nQ534KRzyYj1
         oLjDK4VdpoDtL8psuaOChEtfxWY4hVpFyT/dxdLOihl0Vdo8iZ8Pzqzq5XlPvgO5HMf0
         IBWazHWNhw/BwHlVk0tXEUsvO65HS6Cm+58QV5cI7thhpfjWzhqPY6YVne5ffOSxUMoA
         AbwJRYWB4pHyEU03POORFD26UqdNu8v9597vdXhnva/zj612v2GEs/ZavPBX5+JT2GI4
         N5hcskuZ/xdSUayQCBh3Ry921MwXUqtfupV8G7ZlMKOaprvtRzjiVbZnI9rS0WXN50zE
         OzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719471621; x=1720076421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0oqZSVf3Pja7+3axQ7FhMBZCb9fhp3k28x1dNv+Nkh0=;
        b=AGU5/ajtOPn+hiXbA5QlwjqehXn35zDH9TIq3MbABFqxhyDiCvGUawiUvHJ3riGfN6
         kxrTtiV1coHf4RHokwEkqEDRZ59f48SI3pZf6MEXiKZlRXDwS0GC1AqfbA3TO+4ACa7+
         IGqIFGruKkHxPusAdr/PEffdYfvQIJmaXqEIqOngLgHOGpxEO7xuLN7Ejb8pyhMnON2E
         P5e9EbtznAR5fVYxPGobf3/+Msi0r0htlJSpRFLpg01tKfGCzFULStqhRYIQExS4C9bc
         F6wjEHL2J8SguQ/KCqR9jGdYfxkgKTbvynVmadfBSxfirxRNK7X1UBG4bPA1FGiueV61
         9Vcw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ/pokkc29NTHJ4cc4KHTNyt73k+jDb2zrPvPCbjpWCocVkFDvtjk2i82L4DmofP0lfASIUsDvh/f7634DoKSt3IM0h0V2Anwnbo50MkllcdptsY46bbLPHgrmN4aplVAtNID+OumfTg==
X-Gm-Message-State: AOJu0YwZ+qeFFkWQvQ4+bhFD1ny0yGpZHRpzmPY9b5Qn4aN2gfTbxQ4h
	54iZ1J3zfd5k3uGmvSlH2eVeWlcJNs9QXjseyI7zbT8SgkpuEmJw
X-Google-Smtp-Source: AGHT+IFlxyStZuPqIstUbHexek6n7CBT6uzzIbQQHjx1wgL6505KF4tirpi5W5yVRoW/ZYAMrY5X2A==
X-Received: by 2002:a17:903:18d:b0:1f9:b4eb:ce4a with SMTP id d9443c01a7336-1fa1d51c2b4mr174615415ad.23.1719471621202;
        Thu, 27 Jun 2024 00:00:21 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e306-713d-05da-7754-dfb7-477a.emome-ip6.hinet.net. [2001:b400:e306:713d:5da:7754:dfb7:477a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac997ed1sm5962145ad.211.2024.06.27.00.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 00:00:20 -0700 (PDT)
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
Subject: [PATCH v2 01/10] ARM: dts: aspeed: Harma: revise hsc chip
Date: Thu, 27 Jun 2024 15:00:03 +0800
Message-Id: <20240627070013.2509150-2-peteryin.openbmc@gmail.com>
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

Revise HSC chip name and address to match LTC4287.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index c118d473a76f..d99fba321379 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -276,11 +276,10 @@ temperature-sensor@49 {
 		reg = <0x49>;
 	};
 
-	power-monitor@22 {
-		compatible = "lltc,ltc4286";
-		reg = <0x22>;
-		adi,vrange-low-enable;
-		shunt-resistor-micro-ohms = <500>;
+	power-monitor@44 {
+		compatible = "lltc,ltc4287";
+		reg = <0x44>;
+		shunt-resistor-micro-ohms = <250>;
 	};
 };
 
-- 
2.25.1


