Return-Path: <linux-kernel+bounces-230781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 192319181D9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F5B1F21C94
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598D71891D5;
	Wed, 26 Jun 2024 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8R30bOK"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52830187573;
	Wed, 26 Jun 2024 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407166; cv=none; b=sGtaC49rur1DcQydxfcs+MsiKGTpHOYdfmZBWdweCbScvjWLNCU1qRW00ojWdegX2kBW4fT13zl5aBEF6wQchqqq2XwHD5wkNzMLulRj74LZ2nOvjIaYtkQcx0DL0ncDDBtrkwCu/BncNnO8BXtvdMf8q8aYhC3JApdAupdElxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407166; c=relaxed/simple;
	bh=EumEm5duHxEEwpxzkXJK4oniFdyQm6f8zp/Sh3K7kLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qnePQzLjZOxzEt+bmNkRhYPmJ+NajEm4FNvmk4fBVASchsVhKqdDSvVoA0jDgwNEHC7/aLrHMDnEoZtJRApJhSQAVQv8ANcQJpR1soU6luje2YPz5MzTSYjXTznfshtj78TYY+ohCKC+C7hm5h7SkDwBCnA/buVE4Wz2EbFHnA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8R30bOK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f9aa039327so55198875ad.2;
        Wed, 26 Jun 2024 06:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719407164; x=1720011964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhXK344Q+BpjbqsqUSHdDG5MpVvT/P130hkel56cMb8=;
        b=Y8R30bOKaY6n0c1NxIviZNjFiMkA6n2KmPx2bsiZ8rcywYatcjVbVwpT4w3oWaSeU6
         97M76uuoGNIvnky+bKXVvUI5Yq1vsI1jF3fRrhBCN2QI79k0GHIvnN9dqYoT1k/eDk5d
         q3k4yzVD+UhLICZuShKJz1mjVAcJbiE4/xIRK115JFzFasSRTCCXGWOJ4NrgdSkgos7H
         NssVkLg8r4TRJ6KvGqRgPYrOo+6JKFXbvYgY6pbavk7VblmX3/tbrnuSEYgnuN776lMc
         esrzWOOCh9HCHn7nVSqNP17R6xYBdg6x1rP7i0yiW6Smke5K7F9WXTB5wEbqtHzQT4Cw
         MOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407164; x=1720011964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhXK344Q+BpjbqsqUSHdDG5MpVvT/P130hkel56cMb8=;
        b=P2GyNmQJJrhg9JtZjrPzcgzTEJ0Lis0bxd6b1aqXq5ye95nxBgzaxGhoUpsemr574X
         QiK6tgTvHBkC4G997F8iqSsMoXcAJ5lMbB6hUwkurKzYN2p8rXpq8z7WxBI2H3mmCOy3
         s8k5bd/KF5H519zu+ydM20f3iTmcfh9WZMSRzCXoQZtBkgWhmPeIFwV5GYm3atn5oD2l
         eeTQFcUBmlcfSakHhGBMOBT1o+OULkeGwODFyuEn4ca6trPVfxjWexJImvZYBCgmoUdn
         L1GMf4smLicrde+41s8EykGKIs97i4un0o6ae/DA0X0SgMLxvF8SUL841/zPR7JqtOc0
         +FEA==
X-Forwarded-Encrypted: i=1; AJvYcCWP7f0KMCmXXawiF7rXbunFYV90V5AZq4S4JaiMmQSvLDnnTUSnY6ZGAIuUTclIOh/gXJehQjUfJVl/p6fTooOOSHq51DB+HbsFyz6a+ZQK0GOb2Zv//ZmUofc3TxtkIV/XE0aWcex+8g==
X-Gm-Message-State: AOJu0YyFGtPG83UueR+3eFhBY9zmygJZZyIOKXQgCKTQGA777hVWNgzb
	I7K1WqK0dyf0D1boiVFk9ZZqhHRRzgK/AVLDQFA/V4ceZUN0HU3P
X-Google-Smtp-Source: AGHT+IEKpsmL1kM064iGPqVHITvzDtrUyCPao6Q5sZbn4k7xg/3YMH0t1b3telcRyOckfqAAkEa0OQ==
X-Received: by 2002:a17:903:2290:b0:1f8:393e:8b8c with SMTP id d9443c01a7336-1fa1d683c9dmr110656935ad.60.1719407164447;
        Wed, 26 Jun 2024 06:06:04 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb7cf885sm99112395ad.224.2024.06.26.06.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:06:04 -0700 (PDT)
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
Subject: [PATCH v1 11/17] ARM: dts: aspeed: minerva: add tmp75 sensor
Date: Wed, 26 Jun 2024 21:03:26 +0800
Message-Id: <20240626130332.929534-12-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626130332.929534-1-yangchen.openbmc@gmail.com>
References: <20240626130332.929534-1-yangchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Chen <yang.chen@quantatw.com>

Add tmp75 sensor on the i2c bus connect to each fan board.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index fd769578f826..3d80993885b7 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -231,6 +231,11 @@ power-sensor@45 {
 				reg = <0x45>;
 				shunt-resistor = <1000>;
 			};
+
+			temperature-sensor@4b {
+				compatible = "ti,tmp75";
+				reg = <0x4b>;
+			};
 		};
 
 		imux17: i2c@1 {
@@ -273,6 +278,11 @@ power-sensor@45 {
 				reg = <0x45>;
 				shunt-resistor = <1000>;
 			};
+
+			temperature-sensor@4b {
+				compatible = "ti,tmp75";
+				reg = <0x4b>;
+			};
 		};
 
 		imux18: i2c@2 {
@@ -315,6 +325,11 @@ power-sensor@45 {
 				reg = <0x45>;
 				shunt-resistor = <1000>;
 			};
+
+			temperature-sensor@4b {
+				compatible = "ti,tmp75";
+				reg = <0x4b>;
+			};
 		};
 
 		imux19: i2c@3 {
@@ -357,6 +372,11 @@ power-sensor@45 {
 				reg = <0x45>;
 				shunt-resistor = <1000>;
 			};
+
+			temperature-sensor@4b {
+				compatible = "ti,tmp75";
+				reg = <0x4b>;
+			};
 		};
 
 		imux20: i2c@4 {
@@ -399,6 +419,10 @@ power-sensor@45 {
 				reg = <0x45>;
 				shunt-resistor = <1000>;
 			};
+			temperature-sensor@4b {
+				compatible = "ti,tmp75";
+				reg = <0x4b>;
+			};
 		};
 
 		imux21: i2c@5 {
@@ -441,6 +465,10 @@ power-sensor@45 {
 				reg = <0x45>;
 				shunt-resistor = <1000>;
 			};
+			temperature-sensor@4b {
+				compatible = "ti,tmp75";
+				reg = <0x4b>;
+			};
 		};
 	};
 };
-- 
2.34.1


