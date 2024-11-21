Return-Path: <linux-kernel+bounces-416500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BBF9D45ED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A27D283DEF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 02:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC75713A3F2;
	Thu, 21 Nov 2024 02:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFav3kwR"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB12015539F;
	Thu, 21 Nov 2024 02:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732157618; cv=none; b=J1WddZ//GOjEisAVydube4Y5Rd8K6uk7fU07C7h/jtp72eK1Y8pjC0cctIQsim+fD3sePBwDexJ8NpXfmrkXEFjovRkYya2lJizkuiuNMmLb4jQD31e5OhKJDNKd1Bz9VncofEEUYY3zzALW5MpMX2NYB/JmS0Qhh0E1hBb26u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732157618; c=relaxed/simple;
	bh=V1hOGXGZiBL/idQ/It2mFYhUKDhAasilhxXrcPpY+xs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FEZWWscM3mAvqP8khzgZNP9rsfxCtCxlPVxBJ8/QUry+sSQrH42kTomRmlH6wdCOYwvhFSKTKEZMaiQtuT7JYgcD/2fyhrSefj6Wlrlrd7N4yijPL+1ItWJ1DJUS8Dblkn8yCUuvHf/6vbybEBdgkEPKuEsCff6F5tZXCkGtWho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFav3kwR; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7180ab89c58so183499a34.1;
        Wed, 20 Nov 2024 18:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732157615; x=1732762415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qh0sbGLe3R9T6iLNooRlLszG+yIe2rtAwnz37rl7QI0=;
        b=LFav3kwRZrASAH29nlVtwyvweVON0zdO96HI0GEG+0synHLbogjhKvayFcVo+NM0u0
         ObgJRqy33SvnHPtWACWemQs/KT0OxonLdtS8NeKo4Uy7JMIzAiWvh6k/skmKloi2u97w
         R66u+YKXWUuXzRmh7qC/oX9+Rz2CQsSQmcG8s1Ybtnaf6tftYJq5aFmczHaugyb4i72b
         pkRm7kr+cwU5RNtYw2dg6WkJYoyDzXRzPiVWfqAoBxf+pwmEYf0pVp0EjYsbG2eT/5dO
         p5MIIpatligE7zz+szguWL/+Y0LxOokJGkj06D53a4UpxLRg1ScUVoGA/vlodZLDsTD4
         7VwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732157615; x=1732762415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qh0sbGLe3R9T6iLNooRlLszG+yIe2rtAwnz37rl7QI0=;
        b=JOU65AffVQaVQj3BEzpo+QDctzcUJtLmJL++hj87yWw3ScAjTunZLucUwCCSrRM9QY
         lSEbvd9ypMhnHl2/FOGLjncMSnjDI1OKUNJ57BZj6SSgQaeJkAn4cM9gAJq2RrCSvcQ2
         p27ORfcLfSjJjSgarxK0SI8fPmT03JXsKGBjIQwSl9GF/Nh7XNXuMueAIs24Aq9j5n9+
         eV6Xmuq3voouQGH6J6dpSI4ChLMjLivSM7ErOwzeOm63o8Ka7ItIYO75G3bgoJYIfIlW
         inCqclX5FrMTUbd71ODiLeDs0VARtjWPLvglUD3A/pxw6O8l8pKOuExzjY6AWiUTqIqp
         sSPw==
X-Forwarded-Encrypted: i=1; AJvYcCURU49tfqk32j3i14f7X9t6YjfTsFZnvFkHTj/V3aSfBH3oEfsDUNOWpvKTajWXbv7ApN0IYp+VDwiy@vger.kernel.org, AJvYcCUdhFC5HoGB7jPIEU/TSxr8+nT1/VLNjg67yevzr2YcbiriYiVbO0f9MLr62CpzgLyQrvWQAPgmuUDor3Oe@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8mjOVeHlMHYTlclrNDCzEi5rrBDwYx5ESqYEb/2GYfbCXbo0n
	O32h4NBJecH0ubPSPV9qJvB2hSZlpGVG9E3GYN5Dl0C3yN8spSCA
X-Google-Smtp-Source: AGHT+IFA5UwjT3Bz4C/L6hFLi+1S8wr3VskYBXFhSYkypjXSN3g0a4vpxOgETQNmIQ+Tu9bYoG+89g==
X-Received: by 2002:a05:6830:441f:b0:718:6da0:72b with SMTP id 46e09a7af769-71ab3131e00mr5128365a34.7.1732157614993;
        Wed, 20 Nov 2024 18:53:34 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e309-7a4e-e779-1177-8427-3602.emome-ip6.hinet.net. [2001:b400:e309:7a4e:e779:1177:8427:3602])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbb64f5514sm285513a12.34.2024.11.20.18.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 18:53:34 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] ARM: dts: aspeed: Harma: Add retimer device
Date: Thu, 21 Nov 2024 10:53:19 +0800
Message-Id: <20241121025323.1403409-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241121025323.1403409-1-peteryin.openbmc@gmail.com>
References: <20241121025323.1403409-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add pt5161l device in i2c bus12 and bus21.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index ccb45ca840cd..fd85d5e34a55 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -299,6 +299,10 @@ imux21: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+			retimer@24 {
+				compatible = "asteralabs,pt5161l";
+				reg = <0x24>;
+			};
 		};
 	};
 };
@@ -429,6 +433,10 @@ eeprom@52 {
 
 &i2c12 {
 	status = "okay";
+	retimer@24 {
+		compatible = "asteralabs,pt5161l";
+		reg = <0x24>;
+	};
 };
 
 &i2c13 {
-- 
2.25.1


