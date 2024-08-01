Return-Path: <linux-kernel+bounces-271557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054B6945001
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B21285366
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945021B9B59;
	Thu,  1 Aug 2024 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaUmPW1r"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D121BA87E;
	Thu,  1 Aug 2024 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528241; cv=none; b=spGCOgv780plDHq/yRWD9VHET9LoPesF/o5MMy3AhakFmtxwMYJ2D+Gs8Al8zvtomMUxXmO7/H5USSu2OduC3Is9YO1UvCxw5M2s7Ca9Drck/5bjx0v03S90vlJ3pyjco90Mv/G/fRc5SqJP6pzRqA6S2q19g281stzuHs9Kc3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528241; c=relaxed/simple;
	bh=bfwB7l32/AgZaNPMn/Nei/WF/fGBbyodyqzQyhiw4MA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PffKJ05SWmqKb7mAwTLGp/UFKTo6qi2uG4QJxtcWouOI0aO+M0oH6hbl+KDOJLkaHM75YMjOQRmJ5x4afCsm/P33Cluh0BtJdVODu7uDHYq4Ml23lLmhS8WXlGWHez1fIZjcoOaTLZ+UOLZ7r1vG3mDtlmkNS237UUNjgRQG6xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaUmPW1r; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2cb4c4de4cbso4807908a91.1;
        Thu, 01 Aug 2024 09:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722528240; x=1723133040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMUkek2hVzU0p0l016s6b0CKb/s4GTG52EiEP4PKD44=;
        b=SaUmPW1r51aYVkF+elYIu4Y2X3pfnGw3Ojvux1E3y2QVq69UdwdAdYHO1RU9Whcm33
         MoZNQ6MD2lzas6XB3qE65MCQWKj1bwGaH2qm71c2511quC0+9IW9EWU16yIMayHRESDD
         kC1xM7uu9l/3SjSQ7IfgrB86gB1mVk9j9aYL7fY8yDb9X+djKgWFBUQJxkXwfP3INbAc
         9S0Y0yT2hn8zh+nmk5AIImqgzDQsXIfd19V1FpWOl5qRksgIibOTmxzH2gsbVEwOAQkq
         d5d4ci6dLt/sOGwemccwShF6DupRI28MiFm2ruzAhfAa6Vhi4YCbF47XH3H+OjSYFA1u
         iGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722528240; x=1723133040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMUkek2hVzU0p0l016s6b0CKb/s4GTG52EiEP4PKD44=;
        b=c3SYNzjxA8vgCjj218AjOd7MA65d9Ms7MufPmQISRlAHEXyHeZ7UOZ2UOHPut2t8Ux
         EkqpYbtKvvS6z4RyQc8kkbesk0lO71eWfxxBVzel56wQgxmgH5VOepSSfMjYi61BOp/l
         CJZz1Oy+/qvD6csY9I85LG0qlJYdoq7Jdl4ITw9cu+NYbNIpHuHCH1mIamac1uwAPm16
         DUQPtnWFb1EkYKGTBm3rgIEyKAtY26idosC2v0eL0uLms6rqPpwW4E9JLc5789uxee5E
         h8+f6bEkwUHRsPHXlJRqid/UsyM2k0W/AaTHhwbd5dngPDgFrPZn4OLpflGLqYI/k4b3
         HH6g==
X-Forwarded-Encrypted: i=1; AJvYcCUSiXwaf9UJzTyeUOLeJC/nhUzZYWhOPk/2fav/f4zRgcAYl6cuC1ZntT2kzijAGTnfLPvA8koVzTk3ZKo2Ff18lP0zaLLfQiCehx2ksmf7EjfQG5uR4fvHTeYzjHNAEjBhOHJ/+Fx8Ow==
X-Gm-Message-State: AOJu0YwM2crCHKwvp5FuuwwwWd3e0bxmmXcPvwwcIBnu1zxaKAUggs9W
	IqdBuPXQdZ+Lmepg45ZveaIHG0ycj3l/OTzWptqiB8gp1kgTEF9+
X-Google-Smtp-Source: AGHT+IH0JtqqECKHnudAUXqhOjRTWHB80HJL81jyDNQofXWGUg5tNgWs/U7hOX2Nsy2Ud8Tz78eT4w==
X-Received: by 2002:a17:90b:4c05:b0:2c8:85c:750b with SMTP id 98e67ed59e1d1-2cff952f21emr765328a91.34.1722528239873;
        Thu, 01 Aug 2024 09:03:59 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4cf181sm3535268a91.37.2024.08.01.09.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:03:59 -0700 (PDT)
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
Subject: [PATCH v3 07/11] ARM: dts: aspeed: Harma: add fru device
Date: Fri,  2 Aug 2024 00:01:31 +0800
Message-Id: <20240801160136.1281291-8-peteryin.openbmc@gmail.com>
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

Add Aegis fru device and gpio expander device in bus 11.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index e10ee54fe472..f55ffe9c4d89 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -427,6 +427,31 @@ eeprom@52 {
 
 &i2c11 {
 	status = "okay";
+
+	gpio@30 {
+		compatible = "nxp,pca9555";
+		reg = <0x30>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+	gpio@31 {
+		compatible = "nxp,pca9555";
+		reg = <0x31>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"","","","",
+		"","","presence-cmm","",
+		"","","","",
+		"","","","";
+	};
+
+	// Aegis FRU
+	eeprom@52 {
+		compatible = "atmel,24c64";
+		reg = <0x52>;
+	};
 };
 
 &i2c12 {
-- 
2.25.1


