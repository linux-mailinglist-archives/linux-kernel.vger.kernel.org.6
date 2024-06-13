Return-Path: <linux-kernel+bounces-213538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E279B90769E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF5D1B23541
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B310814A4E1;
	Thu, 13 Jun 2024 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFqrAly5"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F8914A4C6;
	Thu, 13 Jun 2024 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292403; cv=none; b=jVmJ0fkjUcYfUT0QjmY/TcKzUUmm2qZLA0eOfklNupK9HkQ5M3Axhhy130DzSTLiFlWW+sdUijud/BiEPE3AYsmgDe3fKEUNmhLVzrwKXVwxN73Hg7U7noR7D7csF7p1xfL6DXgODWhloHkiMYkpEZpgFCHFqUxU2iIbfRJPgj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292403; c=relaxed/simple;
	bh=mVJTRvcXI0l4MKTY/6tXxN8U27m4Bokwy52L3jcXe/Y=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rG786/YMG7e6UXe0ORmCcmPUfuwtJ+5ma454K7RHAlMs12UbObhOho0eyzGPiSw3Y0Zta7eA8Zv3cSArYfNhBX77prE/xjUlYldROkQsT+QsUVq7od9wT4cJiBwJbFCAvwNfK5GzL1R5Tvsfmhz3odz7v5Kq7L6ttcyqCiT1OQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFqrAly5; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5bae81effd1so572134eaf.2;
        Thu, 13 Jun 2024 08:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718292400; x=1718897200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uN0iVbvUCtHrusvPM7j5d8Cr0NiexIYpDbZftj2H28Y=;
        b=AFqrAly5uyPf9taYMlWcwP1s46iEBqG8aX4NxJe2RQk5vAE+FQxc7earYdpYT7aQLf
         7Fmtja2cF1DaVbreqpJpUF1N+9RkWdAdYzs2HKMR4kfEiyx7zyycIzb31RLOn7joHmQU
         W+P1oHXiwkK70je/8dzjZb3qRmsMEyAxf+3QflYXY1hYl7YBsTKDNhQdOx8miLT4b2mY
         bUhVkQWU9s5I0SToheV7EWfd+euH2HDF+3TMmbP7y8OIWuh5/MMh5s+ZLS/j0Zik7Egu
         aPDOlpKiANiAwJpqehGSbZBgqooUGMA3o1y3Whqzh4+Q1hZCmtmhMgAGxt6aIvwJ/4AQ
         hWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718292400; x=1718897200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uN0iVbvUCtHrusvPM7j5d8Cr0NiexIYpDbZftj2H28Y=;
        b=uDCy+aQZdNg8pUYy3p2I/wrikqseGWyOyU6U/Qd3hlJKSf4nkW40KBZOydqEQruKtl
         jGN2+KYrgq52BBGVuPb5AF7YrL1hqgItUOxdaSFsYfJT7katHDfHyrfKKKX+DiyWUeob
         KAtDdyjDkYD56kSC3gIer7dU0SirMFMGQArMFMw3GNqlFUIG5aHnnARDxA46arbf+RSa
         KNUpqiVPYFC9ouVcnzI6z89r1fg+BvZjTlw5gWt9a2HWkuoJ+1niD5XJV1VuLnxXiQi8
         DZWiJy58cYKXLU9Fl3CUzM+AWfloKUb/4IGYUvOE8R42Gy0QGIVyuM7JhrHJS3x3cpAN
         YHOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/bpcjiJT/MULn52LIQRTbZu9/qWde5EdSQV43e1zcEDk4H3Dl2LexSw5PDs2VigO83sU+iRBvzSHAOcv4VOvy5b2TcHIuGuJrdV9HDB5b7ViMMN9mt5r6Rqjg44YOjIcZUg+cHAYHpw==
X-Gm-Message-State: AOJu0YyPd2Yx6ISUJ8oGlWZxA47TSxHKnL8auunAddCxqUB+bFb4NXze
	lI/46rw3JiuCIq0pfciD40Qy5qq3Mua8ZKT5ed4nxel/6u/2ezFv
X-Google-Smtp-Source: AGHT+IEf10NElgIFM/CEvfdR+k7HaTuO6/i/+QFJcKhnj7u317VP70MArazE03nYYpgOWFTfeto06g==
X-Received: by 2002:a05:6358:5328:b0:19e:fa9c:5ec9 with SMTP id e5c5f4694b2df-19fa9e5c31dmr11451155d.9.1718292400375;
        Thu, 13 Jun 2024 08:26:40 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fee41663d2sm1198183a12.92.2024.06.13.08.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 08:26:40 -0700 (PDT)
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
Subject: [PATCH v1 4/7] ARM: dts: aspeed: Harma: add ina238
Date: Thu, 13 Jun 2024 23:24:22 +0800
Message-Id: <20240613152425.1582059-5-peteryin.openbmc@gmail.com>
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

Add INA238 power monitor for Harma fan board.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 06c8b5ff1125..05020e23a901 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -198,6 +198,30 @@ pwm@5e{
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
+
+	power-sensor@40 {
+		compatible = "ti,ina238";
+		reg = <0x40>;
+		shunt-resistor = <1000>;
+	};
+
+	power-sensor@41 {
+		compatible = "ti,ina238";
+		reg = <0x41>;
+		shunt-resistor = <1000>;
+	};
+
+	power-sensor@44 {
+		compatible = "ti,ina238";
+		reg = <0x44>;
+		shunt-resistor = <1000>;
+	};
+
+	power-sensor@45 {
+		compatible = "ti,ina238";
+		reg = <0x45>;
+		shunt-resistor = <1000>;
+	};
 };
 
 &i2c1 {
@@ -224,6 +248,30 @@ pwm@5e{
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
+
+	power-sensor@40 {
+		compatible = "ti,ina238";
+		reg = <0x40>;
+		shunt-resistor = <1000>;
+	};
+
+	power-sensor@41 {
+		compatible = "ti,ina238";
+		reg = <0x41>;
+		shunt-resistor = <1000>;
+	};
+
+	power-sensor@44 {
+		compatible = "ti,ina238";
+		reg = <0x44>;
+		shunt-resistor = <1000>;
+	};
+
+	power-sensor@45 {
+		compatible = "ti,ina238";
+		reg = <0x45>;
+		shunt-resistor = <1000>;
+	};
 };
 
 &i2c3 {
-- 
2.25.1


