Return-Path: <linux-kernel+bounces-517896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39139A38715
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF5F6188F046
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7AE22488E;
	Mon, 17 Feb 2025 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzEf6qKo"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3C3223700;
	Mon, 17 Feb 2025 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739804278; cv=none; b=pvFhzZdQj782Qo00z7XlOn3n89TFH/7irQZe9hhcZ+LcnuYTL+npghRvrNLvswm3vmYMeYhW9b7J2eRTT6uoZPOOOWYu0ErCXi3tLOeJ6RdK5Lfx1wT/mx7bQVPtHbe2eKfNTPbbrzqDbu2VZ5OPAeaJFTpcgYrVmlSHKRwye64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739804278; c=relaxed/simple;
	bh=I1hO+jrBobkK6tDTAx37eg/nls81LVdsjmCxcnp9w90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sa7z4qz/atQ8MLUFUj92Nu2hkceHtIhLnxXJoP5jrQqYmCn9+3ETWJCej+3R0KZ1e3FgZZfLJG660NPUTLXIR4vRccsr4JgiB2JH+nOCJK5yUyd9M3WqP3Pj72VujF0Y3p6jt5s7WDkofB/tFflS3kYccl3ehxboAVkE+xhOkxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzEf6qKo; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f22fe889aso3475085f8f.3;
        Mon, 17 Feb 2025 06:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739804275; x=1740409075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ih/+2A3WZbQ5wsR+LDXs5XUfJzJaHQlaqkNsPAr1kV4=;
        b=AzEf6qKoZZx0YJgRAlxLn3iJqXyHE9ZUdNO10RSlkBOaQ3Kkoj6wCBq5yr0ldTo+QE
         md2onD2Fmz6gxWdtGN7z8J3q/LwWDb+to4ABoWjs6xphDx1ZXh/Wagsn0wLv0om2JVAj
         aF07/MNvkUCktZggDXXF46U423240FPaa5Xjs3V5BDMQmXkIVErN+UfdfTM6pqqVhWY8
         eygj5IMuwNFsPcN6TY1qAimcotaoxwspbDk0CsCraI9kN4zJYa+3xV5+7rO08xoKVHKj
         0in5hDnsLUm00t1LHa2oyeCjZTuKg0DkuOnXsPGOJ/PeVvCewp7rekWalvTJPSEhs42r
         IthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739804275; x=1740409075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ih/+2A3WZbQ5wsR+LDXs5XUfJzJaHQlaqkNsPAr1kV4=;
        b=Arm842qiWmpZ7NKixjPN7s3GQ55hstGFnFBwPnLCGwza/Rn2CduJARkmgCO4y6tpUf
         7/h0jFFih62BzNinf0Trg+WiVA/IJgFKbIpC5/EACX8wS57s3XUbuP5sAGK559ErlZtZ
         0gwB7tjn6oQNYQc/D15AoOJG4buVcIEEtl8hEOfdgHN+S5u4sDOUV9ulNGeeg3n5hanG
         effMQnJLgwjh3KOEVVLeEjZHhoSxU8rihkFssM8IF/oGgTOQ+ShVgK4mfWiC58V9kULe
         q4KU5VJq103Jw4bwiVW/9U6Doq8X8I4qreOqbTu0I/xsDSSTEZE8gTyhvfawKjtZWS0n
         J5rA==
X-Forwarded-Encrypted: i=1; AJvYcCU3SjRWXeNU+kE8OzBdM/mktGZ/+0GCi747tklrUduZLxAIShe1Wag7zKLTUUNKtlWlD7E2ikL1UeFPqZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPz0ckaPT6MqCi9Lh897XC7izzyDMybkodpfmLi/r6kT4NXrYm
	7SrVkYx4HHW1UKBEI5cgsnoTxnQNSeprIBrZrsOZqJLvbbk4SLYR
X-Gm-Gg: ASbGncuCdttXrUMRIj+T6bSsw0vLILmL1+8LoPWM38Gw91iT1wcTb3tE2x2Rjb5cRmM
	vNp1wLLHeGjv4ysJXJ/zPUh96j/XSf2iglyS/o2u7oZRckouN2RFbyoQANlLDTkRLB7BKYa2e9Q
	7EWM3Tco5v4TArog1CnUvs6N37u6uixdqLU7dz3DK+6O+HGtZpXu31s465AE+7XGpH5EnvgpII7
	WPr3jPacMAmx6P1tYzIRIaGayaTmmMKXCcMF5AUtBfaGeZVGaUCqdrpM2xxMbY5ejPT887PKzu0
	Ch5gi/2TBUa/APZ3DLStqhw9TKMWeQo=
X-Google-Smtp-Source: AGHT+IHjp5xkbSer+ukVA4n6fLYTh4A8nSLa3ksBu6rUSbaeoJGAAh6W2etq0RvQn+XBG68Y744nOw==
X-Received: by 2002:a5d:64e6:0:b0:38d:c9da:d0d7 with SMTP id ffacd0b85a97d-38f33f125ebmr8481928f8f.2.1739804274990;
        Mon, 17 Feb 2025 06:57:54 -0800 (PST)
Received: from eichest-laptop.toradex.int ([2a02:168:af72:0:48e7:ac19:aeba:f677])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25915146sm12645020f8f.56.2025.02.17.06.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:57:54 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	francesco.dolcini@toradex.com
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v1 2/2] arm64: dts: freescale: imx8mm-verdin-dahlia: add Microphone Jack to sound card
Date: Mon, 17 Feb 2025 15:56:41 +0100
Message-ID: <20250217145744.179213-3-eichest@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250217145744.179213-1-eichest@gmail.com>
References: <20250217145744.179213-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

The simple-audio-card's microphone widget currently connects to the
headphone jack. Routing the microphone input to the microphone jack
allows for independent operation of the microphone and headphones.

This resolves the following boot-time kernel log message, which
indicated a conflict when the microphone and headphone functions were
not separated:
  debugfs: File 'Headphone Jack' in directory 'dapm' already present!

Fixes: 6a57f224f734 ("arm64: dts: freescale: add initial support for verdin imx8m mini")
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
index ce20de2598054..3d0b149681310 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
@@ -16,10 +16,10 @@ sound_card: sound-card {
 			"Headphone Jack", "HPOUTR",
 			"IN2L", "Line In Jack",
 			"IN2R", "Line In Jack",
-			"Headphone Jack", "MICBIAS",
-			"IN1L", "Headphone Jack";
+			"Microphone Jack", "MICBIAS",
+			"IN1L", "Microphone Jack";
 		simple-audio-card,widgets =
-			"Microphone", "Headphone Jack",
+			"Microphone", "Microphone Jack",
 			"Headphone", "Headphone Jack",
 			"Line", "Line In Jack";
 
-- 
2.45.2


