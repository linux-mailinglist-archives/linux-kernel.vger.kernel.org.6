Return-Path: <linux-kernel+bounces-416499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCA29D45EB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3A191F21E36
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 02:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E4314E2CC;
	Thu, 21 Nov 2024 02:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoOZTgLL"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF6513C908;
	Thu, 21 Nov 2024 02:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732157614; cv=none; b=XtN+cwYFRmHij8KijhD7J9P+IdeMbnL/Q69qgyNECQ4w+eYmREUaWAyFrZ2vANa1nXacpawoJNCJLc/cxD874x6821vrVj3vrYaQRLx7PjI/fjLn5vrHrFiD1Eg/CbjaKrxI6m5gW8KApl6RMPE1tJ4ag5x0wDaO5au6LU4A8MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732157614; c=relaxed/simple;
	bh=0mMdFNOzsC0U1lp8XyHpp8Hojsli+MusqKb2/EaE5UM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W9V3xlSmirFxj/GpVRId7Xwk9ixVsbsrup82dGp6VeqqsZGxXojcaeALJyp2G0tG8lKkpW8sOc8OAFPqrVrroCH1HkRHkvsLx/DZcXD8+ZXuF+LAwHgQBpp7ap228ApVmXFTZlDvfvasYB+ddZEV4LFEE/b6Fff+lFKdGMFSTrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoOZTgLL; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6eebae6f013so4095557b3.0;
        Wed, 20 Nov 2024 18:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732157612; x=1732762412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=58c4YWEBXyCwGMl0ggHufA6EWS8/x/3Jjol810uZQ1Y=;
        b=SoOZTgLL47udL5izpJ4KIrX9RA2gSSoumBGc4W2+s5vXDfykRFHX3yCP+7axaBObH8
         U40HV4Vc3QDAEqdJwExrsRSueneBvuYzC1LBgn0q5hk5ARvRti4rQAsxn01ijEO/PfhQ
         EdqoOGWz/beMyEBbaJAzIURh7gcngEsvSX7cxT5gn0639lA0NLUTWoC6DCeUdqjtUPAK
         J7DCK/plhHFPBTcKXVtTrsoUYGl2CNVQ8ZNcGbXaqU92/WphKvwDg9gtr7L7ZXgO0lSA
         56uoInEcP9QXVu15x7+FCwMDlvm7zfTnAqPLPSJ9ZbgKENo3jn9u+HfD0XxyAvgLW8Zb
         hhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732157612; x=1732762412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58c4YWEBXyCwGMl0ggHufA6EWS8/x/3Jjol810uZQ1Y=;
        b=bZXswF9qmeNCY+r+cnKxpoiOHKPeYKfOkC5dkMLpXSatj2ssYxfPD8bjb3k3xt/boy
         bIsDbM04uiAybASK5ZgZtojIjzwEEJvUcCbWGefetPgRByao+pCnsWvl3Gm8H77NO8o1
         XfSqR0IinFLDDBDxndKE1Xumtz9uGQ2dL+lqjKftgHGIAlztDQKjbnyKvMmz6YiWjBaO
         sqSq7Dbg7T5Ky6KlSXNFagmwCqPWC9Yt/zWnnMxGw5OMGSB8UyFh3/rDkwuUPyHx3Mjs
         NDjteprqpDKK8LJsS9AVWdPGRErL5HTBqcGz7hbGxm9ALniT3338eOBrEd9PJLZpvI3y
         Lo+w==
X-Forwarded-Encrypted: i=1; AJvYcCVKc3JQGgW7s5p747Yno01CYvqvxcUAeF3tW9OGEBJ72Ite9S4eGNMgSEqrB/HQ/dt2Mal72Yf4kLOdH5yJ@vger.kernel.org, AJvYcCW3qSyut1+ZRb8lwZR/Pc4Q9/9D0+e2YJsRosWOKzCbPPZeszhxYLofixVfClI+AZJNfyxsYHiA9eDm@vger.kernel.org
X-Gm-Message-State: AOJu0YwNVPGiYcD+diay59R7qOt9+QZvF6DTjKT1b6dChfb3s71Y/iDB
	TqteEktC88OzQxoqrM8psZizPJZheZAxAzAARNG9B0xgCLxEWW++
X-Google-Smtp-Source: AGHT+IHXjRyb8nS28IN/wtJ8a+jvzEJ9+GyffRQ8T5afNpb4mgS2TbqNu1e0VRuzfkOWg4BumlDkPA==
X-Received: by 2002:a05:690c:4c0f:b0:6ee:b8ab:56a1 with SMTP id 00721157ae682-6eebd17f2a5mr59339787b3.20.1732157612091;
        Wed, 20 Nov 2024 18:53:32 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e309-7a4e-e779-1177-8427-3602.emome-ip6.hinet.net. [2001:b400:e309:7a4e:e779:1177:8427:3602])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbb64f5514sm285513a12.34.2024.11.20.18.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 18:53:31 -0800 (PST)
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
Subject: [PATCH v2 1/6] ARM: dts: aspeed: Harma: Revise node name
Date: Thu, 21 Nov 2024 10:53:18 +0800
Message-Id: <20241121025323.1403409-2-peteryin.openbmc@gmail.com>
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

Revise max31790 and delta_brick node name.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index d175e37c45c1..ccb45ca840cd 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -183,7 +183,7 @@ &kcs3 {
 &i2c0 {
 	status = "okay";
 
-	max31790@5e{
+	pwm@5e{
 		compatible = "max31790";
 		reg = <0x5e>;
 		#address-cells = <1>;
@@ -238,7 +238,7 @@ eeprom@50 {
 &i2c2 {
 	status = "okay";
 
-	max31790@5e{
+	pwm@5e{
 		compatible = "max31790";
 		reg = <0x5e>;
 		#address-cells = <1>;
@@ -311,7 +311,7 @@ eeprom@52 {
 		reg = <0x52>;
 	};
 
-	delta_brick@69 {
+	power-monitor@69 {
 		compatible = "pmbus";
 		reg = <0x69>;
 	};
-- 
2.25.1


