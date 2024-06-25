Return-Path: <linux-kernel+bounces-228838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0689167AB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B080B26DF0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549BB16FF59;
	Tue, 25 Jun 2024 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mx+EakFC"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6872A158D76;
	Tue, 25 Jun 2024 12:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318078; cv=none; b=NuHSF9obkE1Sp45V9Fzhy9Joc1xSC8fXzKxwrz6CilrWKbbQb63YtpEBwN2tt/9k1DY5XV263QQz3Ya8mb4YMuDM6cR4wS8l2UFipEpFv1tHVr0BrZUzbVMsUjKjfmeV9q4k2iA5C2k1o88p/HDjYKCYsxmpZK4M+hsVgo/F+tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318078; c=relaxed/simple;
	bh=nV568M/o+uaGVPHuxQfi90HA4xiTwKDWfMmadnEC2ws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g0SXMov7D+HaxqTqou3rcYc+IsOvlZbC8I0aUxM+AoXxTb1Y10H6W0B749zvgMDe7D9juHq2NCwwxTaTvVyzLNylC/LmAQQDALiPpWRnRhWObAkx7v6MbfhQEvx4HhT/E+vQnRSMgPYvX0OgqgnJ/f9V4vlcE5dj2KCuEg+NFxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mx+EakFC; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-706642b4403so2177981b3a.1;
        Tue, 25 Jun 2024 05:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719318077; x=1719922877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPpPQPrSFdxwRiFvGPyzNU87S8im5iQckUTLujqJKDw=;
        b=Mx+EakFCkySzobDEsFXlVd3K/V4SANLCy7FVGRYOB1WqqVDB/flW3+kvF0yQrjhZ+j
         ZJaHPHLjYCJ7xTkyFRc9zDzx+CcKHtHn0VOm6ODNHw/Psy0WHozApjyUaGbAYt7HniRE
         arSSYhlKpbB9VFdzvKD7BPFcIESYFCC2L2ZNuuPUQ2q2dj2f/+1TOpzOlgyNEveWDnDo
         noAJZSSghJl58Xx13ZXbT61JFl6SXyHxvDltnKO8JYIjnfGhtEsgLIbrhQaA3JIwVo0B
         9RUa5uJTtSndSSN87OZCTyx2Cc6XfazRHvHhHc3t5LAJK7Su8chbmvoXn5hCbZS7fZk+
         i1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719318077; x=1719922877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPpPQPrSFdxwRiFvGPyzNU87S8im5iQckUTLujqJKDw=;
        b=RJzDYq2FSlZq9lh0m0UVVoEDq8hmmK5nIrPdUhgcvnyXEp32Dfk/COhbiwcyY0fe0v
         wqgERdX59agjALVLW7H3RFDlrs6+6wZRblJHp5w70j3k9L8PMRw0i5PZs4MSBCFuUx+X
         4VHxYe45BrY7+kE4xXF+N5CgMrx8AZFEB771SlWfRLzZkoA+UTjhl0jerJlJRJXgXwgx
         GOcBKJbALg2pA8zpT5NTdaW38J7eCWxmHYgHE4C/93hBqUrfur4idrDZzmTZZIkhf8XP
         XRROA+PGT7KcCz+J7JES8WZGkQUdQx/DCDffdsFAUMZFFP3miWh0L7lw+cFvMOtl1urG
         6sYA==
X-Forwarded-Encrypted: i=1; AJvYcCVF2ea5/KKDi6b/X26GUYEf91fuRcnc8Jb5n5Y5DliuxNIDI1RrB7JkhMqQK1wWmkjR/6un/7N2/zDO57Y+qTLOGtB91gqZNvR3Nyw4yTLbuoVSSAasvEf9qW3njiJryhdkRPXm0ttaDQ==
X-Gm-Message-State: AOJu0Yy7wgQpuXzdGtkV9zzUBD3JUuMGt9jt9YJ9VpF18Di65+910+/G
	t6TUXsKDQshfY1KOmJteQKpjfGAimp4XjN3gBzPrSa0MSmJaG73w
X-Google-Smtp-Source: AGHT+IH45w9VIPw2Adgujbb05Hh7fQwfR4efuZfljK39HStJbVTuQ21UuyqEOGETLUCEErof/GhyMg==
X-Received: by 2002:a05:6a21:339a:b0:1bd:199a:6347 with SMTP id adf61e73a8af0-1bd199a652bmr4424258637.5.1719318076674;
        Tue, 25 Jun 2024 05:21:16 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70650e312e4sm7978146b3a.0.2024.06.25.05.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 05:21:16 -0700 (PDT)
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
Subject: [PATCH 17/17] ARM: dts: aspeed: minerva: add ltc4287 device
Date: Tue, 25 Jun 2024 20:18:35 +0800
Message-Id: <20240625121835.751013-18-yangchen.openbmc@gmail.com>
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

Enable LTC4287 device on i2c-0.

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 288d4ba06b99..896e84cd03de 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -165,6 +165,12 @@ power-monitor@41 {
 		shunt-resistor = <1000>;
 	};
 
+	power-monitor@44 {
+		compatible = "lltc,ltc4287";
+		reg = <0x44>;
+		shunt-resistor-micro-ohms = <2000>;
+	};
+
 	power-monitor@43 {
 		compatible = "infineon,xdp710";
 		reg = <0x43>;
-- 
2.34.1


