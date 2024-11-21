Return-Path: <linux-kernel+bounces-416503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2D29D45F3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26DE01F21FF2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 02:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32081885B7;
	Thu, 21 Nov 2024 02:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3xEBqVm"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7401197531;
	Thu, 21 Nov 2024 02:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732157626; cv=none; b=XLasAazpwkTak9FDvxvvhiu24QkG3oaC3L4lqt8goYhHt2lUGbf8YN3ZdjTTRMHaSNTHtIi6QofBmbOuTmilX9P4ZDecVwjj8n+EYGSp+xBiJDl4OWea82RpxjrgJrJZ1uUTe4Z24+STh/9isrcoRixFoy8r32ao+DJ6RSS2FGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732157626; c=relaxed/simple;
	bh=Zoej5bs/m8hJTMD3G6AdGwEKkQ5iouMMeKxD1Smvb2U=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OfLK+BWL62i6QqE3Kda/C0FOXql24T8aHrxMf2NWW1I6irbghDFPpEdUrTyXx0Bn1GzlmFm9JbAoDl3l1x6bA+sgy3WwGeMF/ntpFxnrazk/dgiBhqIddD2Idtu2GU5SGDUpoinSAJa6UbzGiZxDwi0VcYY3/9yK1Gd0WOtbWws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3xEBqVm; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e382589e8fdso416756276.0;
        Wed, 20 Nov 2024 18:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732157624; x=1732762424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNks32tb/xOghmG+mNYQSKO0C3AuMd7n2d+nPZVJVl4=;
        b=M3xEBqVmsV4Du4EXxAmVcUuir0q4rHvlM9K5VkMiGPpg42iwGj8tGMCJnkA9IajD3h
         43RlglAyXWr23AKTvwGe58OLXM8n3m2JatJLIJTz0gNMLP+8dSiLUK7+69+j/x/7wQsy
         drD3HFqOB9LwtMDktC4tNiA29zHcGXjhPPDiQQvJzfKocKNq5rM+kkWr34uyJQnbtA4t
         22Z85WiJ18vChgfT4uzKDF4siIs2N4K2DreKXoBfkS2fC9SeNqrSm0oP8Xwm5ukXbVwQ
         60iARmZly+lGe5OPylwusBeJzLaWVq8fJFOfXAul25g1TvMyhbqehhRgXBeqghFQNBpg
         fVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732157624; x=1732762424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNks32tb/xOghmG+mNYQSKO0C3AuMd7n2d+nPZVJVl4=;
        b=goHQ0/M6uq79AGRIZj8U0B9Al74aj/P6ka7Tiy+aTsnXWc/yXX4NGQddsF8NgHuB8G
         73rCg6y4soDj0DKH0t9TvBvTFL/Z2vPtyrQimWQZy7yQisq2JbeG6sTKxjldC0H/sVTS
         CXATsYkWW3lIXnso0oq4PPFsznPnCWWbU+ovNZoEvcaXum/T9EgTDRcDFx18Z+1iVfBb
         csB+fjuO8/KzBXGUMHu9hmXfvpJrYfR2aBsluC6oxNp3SmLd+8bqb+f5lWPqvctfKj/g
         TGFikCb2Leh+CzzkxOsz7FTnhkqRPwcalILvTzhDVZEmh4WaIVG3I50LmlVFcQBSiLjC
         XOEA==
X-Forwarded-Encrypted: i=1; AJvYcCUibyEJyFfccY0RLp4rh3LgwS9ny9dt+VRB//1WZGv2gIRwbso4THkOIVEcKz8Lb1CdUw+xlVhrgbqb8ezZ@vger.kernel.org, AJvYcCVQfnBe7jORm9S3jADiER8LZShAeXJeAB79rFf1i8opAfrPXk3bFq29Vhh3/ciT8CU81RMQC+QwkAD0@vger.kernel.org
X-Gm-Message-State: AOJu0YwmaKD5r6Df4V1n3eiJ5/rNJ6XY5QyjIUnJiWldpCjZDq973mPv
	IkHAlCShZ41zGhXQ/gngLuU66XlN10iF6SjEnSsv881zXGy6pXcZ
X-Google-Smtp-Source: AGHT+IFMgccuI6rNZuzdmJfzJU0QMp14kZJiCMh2XqmUc3OoqgAkCbJZmDufzaxQBAaiW1nvsjTGRw==
X-Received: by 2002:a05:6902:2487:b0:e38:7d0d:d7df with SMTP id 3f1490d57ef6-e38cb7173ebmr4643665276.50.1732157623896;
        Wed, 20 Nov 2024 18:53:43 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e309-7a4e-e779-1177-8427-3602.emome-ip6.hinet.net. [2001:b400:e309:7a4e:e779:1177:8427:3602])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbb64f5514sm285513a12.34.2024.11.20.18.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 18:53:43 -0800 (PST)
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
Subject: [PATCH v2 5/6] ARM: dts: aspeed: Harma: fan board io-expander
Date: Thu, 21 Nov 2024 10:53:22 +0800
Message-Id: <20241121025323.1403409-6-peteryin.openbmc@gmail.com>
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

Add fan board gpio io-expander to check fan board status.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 9d7e7208562b..58eba5fb6262 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -218,6 +218,25 @@ temperature-sensor@4b {
 		compatible = "ti,tmp75";
 		reg = <0x4b>;
 	};
+
+	gpio@12 {
+		compatible = "nxp,pca9555";
+		reg = <0x12>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <116 IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-line-names =
+		"","",
+		"","",
+		"","",
+		"","",
+		"","",
+		"","",
+		"","fcb1-activate",
+		"","";
+	};
 };
 
 &i2c1 {
@@ -273,6 +292,25 @@ temperature-sensor@4b {
 		compatible = "ti,tmp75";
 		reg = <0x4b>;
 	};
+
+	gpio@12 {
+		compatible = "nxp,pca9555";
+		reg = <0x12>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <114 IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-line-names =
+		"","",
+		"","",
+		"","",
+		"","",
+		"","",
+		"","",
+		"","fcb0-activate",
+		"","";
+	};
 };
 
 &i2c3 {
-- 
2.25.1


