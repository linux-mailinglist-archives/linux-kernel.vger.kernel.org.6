Return-Path: <linux-kernel+bounces-401749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D728A9C1EAF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA2A1C21D97
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829881EF95C;
	Fri,  8 Nov 2024 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="aokS2xF1"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437CC137E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731074341; cv=none; b=nV9w0mQ+zVKxovxGNj6R60ArZSdcbasvbJb/3Jr0GZH3j4Avup3qEfxsg35ZLgPULzk1FegGxRhZZ1l/FW2Na/SsWVSX8U9sNluBcbmyJJU+PyC6QBQoxH/xlb7qb5G/8u1vIR+vQ8hdWW2FSTh9icLjIToLlHp/ku3FTBsmeXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731074341; c=relaxed/simple;
	bh=VJCrnUUdGei/ZnbWKo/IVdIKLNCrBMpKE8oFEy+MEtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NoTn5qg0K2aQYbNxGCdFGCuyDEDm4b8YvbxkERK9k6cbFdhmvCLMB/LFAHLF1/udTE7CPkoIHoGTAH5DzV82I/ODh5kQl3gsKVG9xWjOwmaSTqTFtpK20OvRWBy6wGxCfjOFdbKvQPvM0zLkBDSK+JEXB07D8UnPyqneWFXWg1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=aokS2xF1; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-431481433bdso18749745e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 05:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1731074338; x=1731679138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=19nNoiZMI2JgXeIpnibERXoHDynmYT61X0LDoD+6J9c=;
        b=aokS2xF1F/Mi5SLlcydh7o8RUauswrA9c52O8DFGYKy7+g+Iow8tk4b5eVMWD+Ne6K
         tVk9aXOsXEm3WV+P1hmFDgHv55o6vihvNfhJHIDGo704McJL9Uh2U35A2OYBf/ii9kAA
         GTllmrCgc2sg1Y0Iq7Q0BNypXNe1XfCWMGEDGQWM3gLgr7/EzBExuMnluUYSw+/6YgYA
         fI+VMnJU19ZWlSZ8ftsLX04ig8BPK/uUrQQ3NEEE9aihwah9X2JyE4qkCwxO5psYy5Er
         /8fSSjGlIrggx+QF80+Xk1SnynWjnTYYlfZXYUx48P54PDbgsGiF3WAdDTTNqsf9TXf7
         sjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731074338; x=1731679138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=19nNoiZMI2JgXeIpnibERXoHDynmYT61X0LDoD+6J9c=;
        b=HuNUcUCQRQJU1KuydVRhmNIoyQ1by8DvLFepXMG09BWCTpqCoV3W9AjJ2OOsm2q0VW
         RwGE85ptOUbtGRQY4FDp6xR/DIwucyF6R8lJv762VBrxt0QGn4pvYtvOEnphgVwKTIeq
         tDgKjN8mQAiggP5gSbB12/lBzZAVSEoYa5TL3tRcP12mXK19yvl5CoBh0UbGNn1CzRCA
         WnM1iI5MYogXhqvFAWf2giAjuJ2zXuRYURd95mQQnhvmL5uTAM51eIr7M9FYjUNY9/nK
         b86Pc3lC7HXsb5hHIFJhGJmZKXKfYswdpEBTHxRr4iv18kJ+Jn+3vrJd7rZVPLWKtM6U
         HxaA==
X-Forwarded-Encrypted: i=1; AJvYcCUvqPkY34ybaWUI0rsd0Q61Hb4xpf0MGB8YFwCUUi0T/OLVetzAcXKFL2HWSofv1sxIx9sUNdmQb5e6n2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwONXaHTfYBO2/QSVqIMB9kSbB7Hw6462wf1Aw/mFLHthqRq4sa
	LIFG6vlqz9BBnsD/glfz+c54s3+dmz5FnXN8Ppf/x9n81xS5ZPvCN6Js9O19uvw=
X-Google-Smtp-Source: AGHT+IHddZyZHnBvXvpwpiOFOpBw0pB+ps3Rxlk3QlAmQ6sdQYs/NNEYqY/D3vFEUDZaWTay7pUGFA==
X-Received: by 2002:a05:6000:401f:b0:381:b68f:d14b with SMTP id ffacd0b85a97d-381f182fc02mr2476225f8f.45.1731074338350;
        Fri, 08 Nov 2024 05:58:58 -0800 (PST)
Received: from fedora.. (cpe-188-129-46-99.dynamic.amis.hr. [188.129.46.99])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381ed97cd97sm4924431f8f.27.2024.11.08.05.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 05:58:57 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: catalin.marinas@arm.com,
	will@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	lee@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 1/4] arm64: lan969x: Add support for Microchip LAN969x SoC
Date: Fri,  8 Nov 2024 14:57:31 +0100
Message-ID: <20241108135855.129116-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for the Microchip LAN969x ARMv8-based SoC switch family.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
* Add forgotten LAN969x architecture support itself

 arch/arm64/Kconfig.platforms | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 6c6d11536b42..4650ad3674aa 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -128,6 +128,20 @@ config ARCH_SPARX5
 	  security through TCAM-based frame processing using versatile
 	  content aware processor (VCAP).
 
+config ARCH_LAN969X
+	bool "Microchip LAN969X SoC family"
+	select PINCTRL
+	select DW_APB_TIMER_OF
+	help
+	  This enables support for the Microchip LAN969X ARMv8-based
+	  SoC family of TSN-capable gigabit switches.
+
+	  The LAN969X Ethernet switch family provides a rich set of
+	  switching features such as advanced TCAM-based VLAN and QoS
+	  processing enabling delivery of differentiated services, and
+	  security through TCAM-based frame processing using versatile
+	  content aware processor (VCAP).
+
 config ARCH_K3
 	bool "Texas Instruments Inc. K3 multicore SoC architecture"
 	select PM_GENERIC_DOMAINS if PM
-- 
2.47.0


