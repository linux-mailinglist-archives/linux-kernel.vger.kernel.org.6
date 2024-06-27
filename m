Return-Path: <linux-kernel+bounces-231884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF82919FE0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E547B24513
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E6E47F6F;
	Thu, 27 Jun 2024 07:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYv+jUwA"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646B4481A3;
	Thu, 27 Jun 2024 07:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719471644; cv=none; b=cXjUZN/qxJrnyipu7b8dsqR1eRms5Ikvn7fRaWthKmiiYqVGMvsI5YYTzju7ncngQGiFYhrq9FfS2pwb5mPIJUfdaGLicuOdbRZWZG/7bmdsUSZ42jjmZi3QYXNWbU/fRlQquCbRx4t9ggPvfK7auEfuAprvsDV4nEg4T2B+bHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719471644; c=relaxed/simple;
	bh=bfwB7l32/AgZaNPMn/Nei/WF/fGBbyodyqzQyhiw4MA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nr2FA8RO66QYuEQaE6BzUSUw5mqi5jBnua05/AZM1BvWH0ZdSu2BN/8SjQpozFYFahedckE5rrSZUablgQGlzffQp9hWer2+gruVBLXdOitXV6tpcJsMpXGJ/0fGODEs6LeKZG4Azmt+xFWXeLchMm5ruhXiLmSN1z2Apu3Madc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYv+jUwA; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso5592870a12.2;
        Thu, 27 Jun 2024 00:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719471643; x=1720076443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMUkek2hVzU0p0l016s6b0CKb/s4GTG52EiEP4PKD44=;
        b=HYv+jUwAgxKFFxDAMDXiPGuR/5LbR7CmxFEmA/MWScnu4HpjPOfcqM//i7ZYZVpLBs
         5Hh4knUztj1zwebhjRM8nL5qmNTCtn9ykCnSz200NfiGSgfDX9GoAoUSlBgUQu2Nw72i
         oAplWxRtdG06JG2DmZ0wU9f4gW8JcYuxQWdXZYQPoBRAbGEnqiWSANGrNT1yN7PLXxNu
         MqdbJfdJr9ISP/sk3njfx9Chv+KtQlQBE5TjOWU7mXvWCd31c+v/IRcg3iIkExz/fwpS
         r2OD0nT/WtFZ0Xvyr8gqM7G+a0a7kijxA6NZPhnuU2QFl3PN+oJY6MYiqRyseMfMBrJw
         Lx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719471643; x=1720076443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMUkek2hVzU0p0l016s6b0CKb/s4GTG52EiEP4PKD44=;
        b=oFkldnGzcqJpMS9Dh9ObIdK3piyE0JCSZ5nvEHa1ZQmOI6vHPZMGpDQ0kVpfNQJ1Ki
         w/isMDZT92K4oc+HmpLqUcnMn3TRkoAueL4iyJ0IynWBQ3FS1X9MI1pxBjwFJwikm0g6
         mpoO0/bot9qO5lguBDNH4XObS1hAoOmquL511WLL1MtX+E5kHBGhI3px6FGgCecR71mL
         EzxzG+eo+XPnRC6wi3eoOtoLnTWbfXVuHsgM/0Qj3fn3TyNrTKUua10VtigpldmtCQRL
         V13HeW4V9ed3opMcUHYORYu5ieYJdLVK2qgVtYGYZpOJxLc3GKsMx/tlAS4R6PeRTmcN
         cvWw==
X-Forwarded-Encrypted: i=1; AJvYcCXc1yDSQP4eHVv1JfLy0B5Bh65bMhIX1O+getqcHjwHddBTCdGea0e+ktWgpa40H3KY8YAxdS3txMLSpsRboZPu+zSEekQviEhPTH0dTWtgAmtlBFIG7dT/k19n6q8v/KkL91iDM6CZvQ==
X-Gm-Message-State: AOJu0Yw2lufMnhzZiu24r//a+I8GPriwwKAaHwuRgjaCLgMl6FHFlqnP
	bwg28Eq0umT72yd89mcoTA96U/zJcioTmfJICVnx5xuMoxiHWdoX
X-Google-Smtp-Source: AGHT+IHsrtkGtJf3xPmmh/936pA9VAPgzA04MqHFj6mjiEydE+Q23/XOX3ENFthF9sGCv9bORrzWtQ==
X-Received: by 2002:a05:6a20:2a24:b0:1be:c1c0:b8de with SMTP id adf61e73a8af0-1bec1c0ba08mr3209791637.42.1719471641187;
        Thu, 27 Jun 2024 00:00:41 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e306-713d-05da-7754-dfb7-477a.emome-ip6.hinet.net. [2001:b400:e306:713d:5da:7754:dfb7:477a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac997ed1sm5962145ad.211.2024.06.27.00.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 00:00:40 -0700 (PDT)
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
Subject: [PATCH v2 07/10] ARM: dts: aspeed: Harma: add fru device
Date: Thu, 27 Jun 2024 15:00:09 +0800
Message-Id: <20240627070013.2509150-8-peteryin.openbmc@gmail.com>
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


