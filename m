Return-Path: <linux-kernel+bounces-443127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62F09EE7BA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF341648A4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CF92153D5;
	Thu, 12 Dec 2024 13:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQitOKiI"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B47215048;
	Thu, 12 Dec 2024 13:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734010481; cv=none; b=IMZwqClBE/VkUze0wA0jZ6L6IZKCW9LIzNvNmWlnPr8PY9CQEn2ykhjwHzBlhiWA//Vz+dOm+WobK64r8PpsBiy2nCzdadIPKRk9v31vi0D48dm5zRJEmoDSjthbIwm+xwr0BmGAlSQoSEd4tOc2FYSXlHTPOvrR0HqHEPpprHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734010481; c=relaxed/simple;
	bh=IKs7djqn2vFIQjZnww1dPBMFgv+BR8vUYK59HfRScQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bs3PMxbmm8YYvkHXy1Zf+8oGtx/XkNKc1yK++LfP8zLJ3DZd8AG7LmVXhn6eN78upycv6mpjBKEM4FreAo073MB6BOT/AwkQZpw6j6Gi76s4jDmIcgHTjqdlPdwgimsGWducgQ2X/pUwh6+15LPaUC3MsHF0v24fTf9SiflvhKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQitOKiI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2163dc5155fso5429015ad.0;
        Thu, 12 Dec 2024 05:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734010479; x=1734615279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wf0lUEIsGTnJndimnrt/UOqCv8R701BigsdRuKPieQY=;
        b=LQitOKiIW8CcnpDmIXArloBiKrDpdNTECE3NGu0VAsVA+spF2BB7cPvvvKLFjC5ubq
         ZDDIscfu3/45Xem5FenRmXKKMuT3awkEUW9da16aMLK4aobi1LNzo8PuXTmLlMATHAhd
         MRVvhuIhfUw6ju/Ap24Tn2yK2Mh9uynOXQLa4sTySVA4XDiTQIVCHYoNDuocTcZ63+Li
         f2Z3VZVNdIEmg6YUp2gdysbDsKlwY6xvid9Qh3oNthcV/44lXp7S2i9i39gOCpVneGqh
         W42AxNQ8eLV+BmNOm8EzAOwYBdSWqtSc6qtIQqtIDxFVYeHBa+QV5aLLFtZW4o4Y0Zx0
         fNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734010479; x=1734615279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wf0lUEIsGTnJndimnrt/UOqCv8R701BigsdRuKPieQY=;
        b=qYa4iD2f1Z9oHvCVnvsvB/W5BzwVrPZ72e700NJMSum4el7I5iiF2SA8mc2Wk3t6FX
         CysWXWY9z6/J/h3MQsmh2AFZE39qNt5N1ehEFcABKREwIE7csS/qMvWn7YEtY90UZxY7
         A+CPuJnJCiWOWHmiAzP0uo7lyp6AbzqTSvyXZyy47HoSoM8Ot4kBd8UFR28xL79keLZO
         XPy4b++Afwqji7titI2zthcdQ8xiuFmIEeWao2jP2resTv2FwEq6JIiTDyNK/cVPyfX5
         q5qb1GCLHiLk2cgJby3bgp4LcoYUBxR3LoP6ArUX7HnGcTZJ61ptM9MDF1wz/XgdbABr
         Squw==
X-Forwarded-Encrypted: i=1; AJvYcCV1K1CS/f0clrkw0U7piT82L7H43gO3fQxZ8/iNifA2l5vUiSXnJvXi9rT+ZfKAHOwUK66zY/+Y+/7o@vger.kernel.org, AJvYcCWZ+fIjV8g9Knx3JGatsL8vnzgOCugtP32+69iB+2ZCeB/Y5ApIH4q8UTCjouH8UYKtB+B5q/U07eWHKvnT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+cBXvYcWlTrOpg7tUeQ7VFlSZQQWHcjH3PK/VQs1T/HilvFzQ
	HA2JuKNLtK4Itwa3pw9OloBJXoRxQteFzj4Ah7o34p/uMfUa7Rx1DTeHCQ==
X-Gm-Gg: ASbGncuLn6JUXmqeedsau27iOIzy8vXKqlfvbDoDhFniScqP5GRpvrWJuY061SCvD+y
	tVat5puNSUDBpg+1yX59n+5Ek8reDS6fNsmnNkOKG2H/SCXymmMPk9tc1aH6FL8Hpmb6xu6ncYM
	OeJu3Fir04mlbS+YNZU2vzbiXdfLGylal52ctWASAcBOy0lWqsE1xE7FdwaSg/5Gl+ubh3Azhf6
	CV/bSWckn3f9ItITOvke87ovQsvU/XoixSySZPir6n4y0dhccHTOOSsucX2ezOWKBpLsIJEj0B0
	7OkMaofQrPn2i2IpklHasS8zS6mi6KPCoE1lwWvDMPQHN1qoGTxwgeSf7VAeF5yJsCBCWzaa2PZ
	GWPRJ
X-Google-Smtp-Source: AGHT+IG72CSpTzAbD2aJjX7X490Q3VfJnza4dGyLAZeAdhGFBrbCMchjemqwfL5MBOt5N81pQsYWJw==
X-Received: by 2002:a17:902:da86:b0:216:725c:a137 with SMTP id d9443c01a7336-217783c0b13mr109498415ad.28.1734010478887;
        Thu, 12 Dec 2024 05:34:38 -0800 (PST)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2163562a838sm83390165ad.29.2024.12.12.05.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 05:34:38 -0800 (PST)
From: Yang Chen <yangchen.openbmc@gmail.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	patrick@stwcx.xyz,
	amithash@meta.com
Cc: Jerry.Lin@quantatw.com,
	yang.chen@quantatw.com
Subject: [PATCH v1 3/4] ARM: dts: aspeed: minerva: add bmc ready led setting
Date: Thu, 12 Dec 2024 21:32:25 +0800
Message-Id: <20241212133226.342937-4-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212133226.342937-1-yangchen.openbmc@gmail.com>
References: <20241212133226.342937-1-yangchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add GPIO BMC_READY on LED and give it active value and transitory flag.

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 9cd225ae96cb..7fddbe833cc2 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -101,6 +101,11 @@ led-4 {
 			gpios = <&leds_gpio 10 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
+
+		led-5 {
+			label = "bmc_ready_noled";
+			gpios = <&sgpiom0 141 (GPIO_ACTIVE_HIGH|GPIO_TRANSITORY)>;
+		};
 	};
 
 	spi_gpio: spi {
-- 
2.34.1


