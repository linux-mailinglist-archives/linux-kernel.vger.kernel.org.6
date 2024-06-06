Return-Path: <linux-kernel+bounces-203952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F03B28FE2E5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52760B2CA2A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29292144D2E;
	Thu,  6 Jun 2024 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aea6/10b"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E77143728;
	Thu,  6 Jun 2024 09:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664783; cv=none; b=nPuxDIu0kRPTj0K5axTqfBgvB4IlvoPMdBmIpjaAURb4/nYwoQpnAcgc7kIcIJrPIvLXr9J2wmh8ARn57yNQcz+K2Q0F7NiUrwEaP1rcwrak+xbhiJrqfHA5VQEW+YG511u+aSZDJdUWyEmGMMUOiJnAV0zoS3ewsVtlugKTaDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664783; c=relaxed/simple;
	bh=pFOtPENkEYp+aGPNKyrau6rllOMWnZ6E2cEGzNLEPZY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=db3T0hzUnB8psjm5i+Gmb2MA4rUIOSfO8fK2bKZr1FarjGZR91dl398G5PxTOpwP19kv/FEEjU7Nkl4bRq11TE7wCw9AgZw/1S9lx5g5DTjSvOUJ+45zp+WCaCtRzl93s8sdoWptiPWVlU+eHNmpMHUd+qwd9cpFUkmU2555ON0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aea6/10b; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-421208c97a2so7778215e9.1;
        Thu, 06 Jun 2024 02:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717664780; x=1718269580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4rgFWRbmc/mITagCbJLY2C7AsEpsBUmMdP3ARGdK//c=;
        b=Aea6/10bjkmb0yJw0y2y2UvBxxBS7XzE7LfdNvPZbSa2JYXzRFZjMWbxZRNZF9cRNn
         fwziwpOFUj1h+UEg+430/FlDCv3u4XY4do5mJ2ZSmVlVD8BJK1j8ILpVYuROo/eIw9TN
         aCeeUh+Q4OtfKxVonHr4Id8zTzLzUMBWUvBSO0xQkpq4SBxV8KsFylg6RAE4mTWjd8Dt
         XbqSvLShRKw+w9BKyZWexAd6d4wUJfYJ4r3qYsFbOxX2hjJHqS2IvU+ml0fqa1MrQb1r
         JtVUUmmTAKap9yuWzwB/nzpqwXIGNbw5D6xWPK2wJFXZnu2pWDqkM1YsCGLlwGaPJ6fO
         ASxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717664780; x=1718269580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4rgFWRbmc/mITagCbJLY2C7AsEpsBUmMdP3ARGdK//c=;
        b=xC2B525NcrV6AQE2zcwVROFss2ZHz8YbtUZ8lSvN7b1l4dSC8iqnAfs/vM38OjFRwH
         QFHD2C+Dvvaw0mUdubpj4qwviH0thusaFKmwu6uNEbJV38IFmPKLJJFeVUTPtImqxEBj
         moDJL/2REBNOFC/sE0n5BerNrZAlgsnc/u/J07JW6d9A4Q8oukcWqA0JXpSR5XlMIX5u
         w5yMhlhlYng621oPjGXkqDhX9BQAbb5Thlwq76MBsRda2glWnVDBAK355jjhQLcZ+bcz
         DtrB5JSGUqUI75M9PQsl1beAfzTRHZjuvmuVAaRrhEt59Zt9x2k2ESX2z77le0o/8qcm
         jmuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQMkKPfFPmynAHlc9O2+x0cLg8BpAPQbiICbjLSs16DQlVzlxoqbvOQ7SelcsiHstGOjQQznE2tGhPuZDzKTnFxcxc3tdpGHW6oOv+PDUmSHTuu2utS/8AyPoGhR6kHRu/SU5/g/pEjw==
X-Gm-Message-State: AOJu0YwM0Dn4VaOAGLqodI6tM7QOSn84l0qu7DlWOHoN73ETJJ6Fh1sx
	Y/ph/6okNq47gX2Uwq/mj6VZAIlb9k+x2HBEZRkBMNF99yDxMRGf
X-Google-Smtp-Source: AGHT+IEO0mxczR/mD4wLnGOWDtPXarRkHd0Rx/ObbVCaBZXqNJf3Cix3+QyXppwMd8bDvj8jMfKeAw==
X-Received: by 2002:a05:600c:1e0b:b0:421:5a37:d45e with SMTP id 5b1f17b1804b1-4215a37d578mr23685335e9.37.1717664779758;
        Thu, 06 Jun 2024 02:06:19 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215814f141sm48483655e9.42.2024.06.06.02.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 02:06:19 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Christian Hewitt <christianshewitt@gmail.com>,
	Yuntian Zhang <yt@radxa.com>
Subject: [PATCH v2] arm64: dts: meson: radxa-zero2: add pwm-fan support
Date: Thu,  6 Jun 2024 09:06:15 +0000
Message-Id: <20240606090615.3946433-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The A311D on Zero2 needs active cooling and the board includes a header to
connect a simple fan. Add pwm-fan support with basic thermal properties so
the fan runs when connected.

Suggested-by: Yuntian Zhang <yt@radxa.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
Changes since v1: [0]
- Drop min/max state to comply with bindings
- Drop ddr_thermal node
- Add cpu_thermal trips
- Use cooling map2 to avoid clashing with dtsi inherited maps

[0] https://patchwork.kernel.org/project/linux-amlogic/patch/20231028075445.3515664-1-christianshewitt@gmail.com/

 .../dts/amlogic/meson-g12b-radxa-zero2.dts    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts
index 890f5bfebb03..8445701100d0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts
@@ -33,6 +33,13 @@ memory@0 {
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
+	fan0: pwm-fan {
+		compatible = "pwm-fan";
+		#cooling-cells = <2>;
+		cooling-levels = <0 64 128 192 255>;
+		pwms = <&pwm_AO_ab 0 40000 0>;
+	};
+
 	gpio-keys-polled {
 		compatible = "gpio-keys-polled";
 		poll-interval = <100>;
@@ -286,6 +293,23 @@ &cpu103 {
 	clock-latency = <50000>;
 };
 
+&cpu_thermal {
+	trips {
+		cpu_active: cpu-active {
+			temperature = <70000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map2 {
+			trip = <&cpu_active>;
+			cooling-device = <&fan0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
 &frddr_a {
 	status = "okay";
 };
-- 
2.34.1


