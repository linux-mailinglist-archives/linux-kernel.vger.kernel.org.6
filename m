Return-Path: <linux-kernel+bounces-293779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9638495848E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 533E128280B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9932618DF91;
	Tue, 20 Aug 2024 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVcMThcM"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AA618D651;
	Tue, 20 Aug 2024 10:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149874; cv=none; b=XY+V94cKqNNwOiCpTcsNZFcIgNIzpySqtuEPA+iyD0NpTLfv2F4+jeNNTsid4a0gGybdQHF5zF7Jo/96ACEA7HU2Bi7JOV9umrW7fkfp+I35JpuEX3EZf5ZGwt0AH4jy2DJtkmYPAOSS3MECCNx3s80SRlfivtvFjxYhMuzwUkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149874; c=relaxed/simple;
	bh=zKeP+r4fvJneoNGNPQMbNW1OqefKUqpy3W7f9cHPgaw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ajpihVuWtRoZWJGFAiVdXzNYM8WA3ed8Qd+gTa2+NJGmACcMbs/s2wbaakFGmPpf7mcTRQyPiaqIMk+figLxoywC+pfP9Bp/ETh6O59RxrW6iId/Bi274tXJPfqYnghxzPN6/lzGG7sMFEw9IwrQquNC0np8Mwu58aierHsI/ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVcMThcM; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2020ac89cabso29675065ad.1;
        Tue, 20 Aug 2024 03:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724149871; x=1724754671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=24ONLHDIg4IPXcssauearHwBYBXH9GZM3HUtiuvktw0=;
        b=UVcMThcMheXJA/MthJwg/g/jMpK/9T6Vef75EqONn69/Wfun/LJHF+bS+EyB4tgKiV
         0Kr+yfZBbyL25mgzCeifUiEKou9HkqkzkZj9N+tj1hnQ9lKcQQ43A6zBnj2fQg4dmsfr
         /p/G691x7Q8WRCqmXk4V6s7EWQa8HNsN5+26CaFLg5zQ436kEokUPI0cMFDHOfB6NG/e
         CnrGJbAhLklSEFMVBzVm2arfzeoLUXhuEyfGXyA1e/GSS6exLbCOIi8G9kHRJVw5T6m6
         jlZwHGuRqzAQNcyob6TgaXPbY/vdiRvqr84ZJg6KZ1c165cO8fOL5V8oEn2qeExDrJlA
         Uidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724149871; x=1724754671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24ONLHDIg4IPXcssauearHwBYBXH9GZM3HUtiuvktw0=;
        b=dtd/xRYsvdrSTBcncHeugCFxrmtMsxsISaMoDrZyC6KcdUGv+gFM2zfT0YNIqBlvSd
         dNX3aV0VA9yEaev8FNx2bEapgsH4FiOe4d0jbYEmdIlhW0Gjgjo7ar1MqaYVsJ8JI/f/
         7FSuj49J4X0Xlj6ESAz/QUf2xr2i0XItIhPv5kHydcUoaRZBeZR/etvNREwUAA6LBXd7
         Jd/mVGqcayPXOamdaPMxYywBq3JuPFS0PDu3h9iYkU8qSV3K/4hbXhj1PUNYD57ypXgQ
         h0rydZitTz4vcSfnu+qvDbhenZNBTfNjV84X3OkklnFWxSgnsa6z5QftD0Fvf3c9O2XO
         V+Og==
X-Forwarded-Encrypted: i=1; AJvYcCVViLlqJNz5FCVOXUN4xMmVQaBrLlM4/BczU7z15/vAzQ6mSsaz7kTHyJ2KzbMJ9FpITfsvfPezst26qOkI@vger.kernel.org, AJvYcCW23KZ/k9lJZqpc/ELG2TXNwYjyevK50EVKkgyN+HV0eGkg6aSWcbC3noWch5KexDey/HSjwwlr6JGC@vger.kernel.org
X-Gm-Message-State: AOJu0YwUOZWmjieoYJcL0YPZ8JSY7mqrSk5PjUNXyhqKI5D0/eNazIvw
	cTjUWA7zVPbqrJOuZY2CsJf9N4s+Z0NSdA12OV1rcBILjKwyvXvu
X-Google-Smtp-Source: AGHT+IF34yvCZ+WaAxx8Rz0TTX7mD5iF01qeopb0BCg3H+ioPzaZt5thGHcQz8juaF/35r7N5SVxlg==
X-Received: by 2002:a17:902:ec88:b0:202:2ed:b3a3 with SMTP id d9443c01a7336-20203ebecd8mr104218515ad.32.1724149870867;
        Tue, 20 Aug 2024 03:31:10 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f02faa5dsm75444115ad.2.2024.08.20.03.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 03:31:10 -0700 (PDT)
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
Subject: [PATCH v1 1/2] ARM: dts: aspeed: Harma: add rtc device
Date: Tue, 20 Aug 2024 18:29:02 +0800
Message-Id: <20240820102904.1756785-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240820102904.1756785-1-peteryin.openbmc@gmail.com>
References: <20240820102904.1756785-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "nxp,pcf8563" device and the slave address is 0x51.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index cf3f807a38fe..92068c65eae4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -135,10 +135,6 @@ &mac3 {
 	use-ncsi;
 };
 
-&rtc {
-	status = "okay";
-};
-
 &fmc {
 	status = "okay";
 
@@ -506,6 +502,11 @@ imux31: i2c@3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <3>;
+
+			rtc@51 {
+				compatible = "nxp,pcf8563";
+				reg = <0x51>;
+			};
 		};
 	};
 };
-- 
2.25.1


