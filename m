Return-Path: <linux-kernel+bounces-416635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E94B9D4811
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2DE51F22026
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 07:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871B71C75F9;
	Thu, 21 Nov 2024 07:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b="nPnFPFsC"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB4D74068
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 07:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732173211; cv=none; b=NhgPTpcaq0XWVhq6JrJv434+rez0BnuM49Hlj5bslIMA33RbxScuGlWQBmMz77S+PkoHbWZwmEFsmigO8m/WSpi9SCI+GiY7Lxg/0/LqrJbkIN2ABnEtcMkPFlDka6hBHuJ/8rOWeoWMzjofeguHKxXDQO2WJXFKsxrz+Ng0AHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732173211; c=relaxed/simple;
	bh=EJF/0GRK8gCHAuxzBGfX3/SDOj+YnZQWV+rfBX8YA5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AZmNeUnP7nABVrKEUOmrI2bTPo9Nflcn8kkgp7vbOnJs249qzvhAdQoKUdUkbsk1EpBbo6M6XftkdoBRBcFlTmoagsuUOL5tIYXiAxZaub+43vM+yNw9koHJF1CCzs5OGA2pj1T9RArRLi27FrG9E4y+rcnjApzW2KestxtvMXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org; spf=none smtp.mailfrom=nigauri.org; dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b=nPnFPFsC; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nigauri.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21263dbbbc4so5525165ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 23:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20230601.gappssmtp.com; s=20230601; t=1732173209; x=1732778009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LFNrZw48YC7Nd4NK6Qt7/KlvAITIs4SoN8m0X5EQI9c=;
        b=nPnFPFsC+J/+hF4W+Ru3h7KjpefhxfDMNTwHu5V9v1RCK0piQ5jpRsTb/lva8JqZal
         3aMuggZHm/XNwjj2Fs/QaLjV68Z7TqyMIzMUIlDjMEfGCNm+twoxwiTpT1D3iFI91p8W
         3117VlGLI7jfHBT4MDPmopG0RGnTzsi8jQTTc+Lf8tuFAI5sdGS3fETWSsC3UjcuoeEP
         V8goeAmZ9MlB/4Tpjw5wovJ/feYLml4AQc7/rKMW5NjuASl2BWEEB+cziRfBWuporld4
         /Cj3rwNm2GvSyGwVpjZYjb7kEtVk6Ilfem94BakfOXpC9udtXC+McmaH/Bn4WKffvB69
         jYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732173209; x=1732778009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LFNrZw48YC7Nd4NK6Qt7/KlvAITIs4SoN8m0X5EQI9c=;
        b=UHdZltDJrnEEowcwCSTw2QWsD5liB0SwjB7VHI3pp5d6Y4WFXbJXqCv0gp98pjQqv6
         iAgREYNBFLrstW39p97WR8y18KXKkj8JqVJDLepOAP17Q139vAp672H8wl89Zt5rZnjT
         u/AbJeAAErLHzs9bogkIp3+onL+C9uWJvGPE/Ty/Zm2OZUxCayRDZ22MzkJF3g6g2QEx
         D6Et4ymq47b2u7R79t0aqMYLZUzBv6VYQVJsYMWZzgpOLeGhiz9k69AaS6yv0iRBVTIf
         XN0gSI3tdyRJhu6ksY01hArrJ9MJm0oz7QcuQ6WzHPx0HEvY7e1uXIvi09jci3ZCWrKA
         jaCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg79wUQC2LTYg8fJR94nAl8tzbLFLzyVfCOnzaVMh4R0QU/0d58rGASkRkEBCjomquQWxaW5g8Yo0CChY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0d1K6HKXzxlxZ7Bf0CW7g1GY3NHWtmD74ixljN2xoSnpWj/XX
	is3sScFzdXU/rNv8+NGEOCMJaBlPuIei+D14IKYPV8uzAzLQWGgtRDfSBgh/
X-Gm-Gg: ASbGncuCZkhlm7VzyiIrfOwzf+HwxH2TD/TwdCo1AYsDAtJvk9IsJuClAY4VC6k4LZi
	r9TE//zzBlzT+xBVX7fRFndLK8ZvpwpvuQ5nfH87cComTZRU8quhUPm22QD6EQVM4FSIzSSJJN/
	057M54fKJX8eF+d+Q8JoxNEDyt7WOcZc/G1HKqHq/wbboknMcO+F+uL2N4Ww/IJTyx/fwd0xxN4
	ScAVMaCQ79RGIIvZKk0J2LyAGGDLkUIJ8QGRZQKX54zcp+8/Ts=
X-Google-Smtp-Source: AGHT+IGLelbtxaQE3NcbOHx4mUq3l9XVdB1+aGkET78P0R+07B/6hdLZ5zog+84Wtv0TlE5OHYP81g==
X-Received: by 2002:a17:902:f707:b0:20c:5b80:930f with SMTP id d9443c01a7336-2126c0b946bmr72891265ad.12.1732173209619;
        Wed, 20 Nov 2024 23:13:29 -0800 (PST)
Received: from localhost ([2405:6581:5360:1800:b535:6545:798f:8db5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212883fee10sm6709725ad.264.2024.11.20.23.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 23:13:29 -0800 (PST)
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To: dinguyen@kernel.org,
	robh+dt@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH v2] ARM: dts: socfpga: sodia: Fix mdio bus probe and PHY address
Date: Thu, 21 Nov 2024 16:13:25 +0900
Message-ID: <20241121071325.2148854-1-iwamatsu@nigauri.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On SoCFPGA/Sodia board, mdio bus cannot be probed, so the PHY cannot be
found and the network device does not work.

```
stmmaceth ff702000.ethernet eth0: __stmmac_open: Cannot attach to PHY (error: -19)
```

To probe the mdio bus, add "snps,dwmac-mdio" as compatible string of the
mdio bus. Also the PHY address connected to this board is 4. Therefore,
change to 4.

Cc: stable@vger.kernel.org # 6.3+
Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 v2: Update commit message from 'ID' to 'address'.
     Drop Fixes tag, because that commit is not the cause.

 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts
index ce0d6514eeb571..e4794ccb8e413f 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts
@@ -66,8 +66,10 @@ &gmac1 {
 	mdio0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		phy0: ethernet-phy@0 {
-			reg = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		phy0: ethernet-phy@4 {
+			reg = <4>;
 			rxd0-skew-ps = <0>;
 			rxd1-skew-ps = <0>;
 			rxd2-skew-ps = <0>;
-- 
2.45.2


