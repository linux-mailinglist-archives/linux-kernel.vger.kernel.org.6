Return-Path: <linux-kernel+bounces-334208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D90197D3F5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 11:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89C9B1C21267
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D2713C80E;
	Fri, 20 Sep 2024 09:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iymm4QYV"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501ED139D0A;
	Fri, 20 Sep 2024 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726826317; cv=none; b=oP57FkRoioVdj7s3xBacByWRP4FXu+JemwmKIrjb0kgQyxAIW/DMxDAd7l1tvieW6s0B2KSa5P8HnkcrT8Vm07K3dGopJMjtMfJh2fIL+fl8ZWUCgPjMhS8YCVWUqLd4STFEAFiXOkMkCvyXuLlPU033WmVRbaXLw+/sxcKpuHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726826317; c=relaxed/simple;
	bh=88gDVpnA6PhWT5LuFMIcdjhzh9mXo979fV+FwMxeJSs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sx39IaVaxxpiM8ypGqt6Z+EihAk7Kk8yU+IUyKNHawBCEisNQJ3nAueuQu5bx03FCtefkzMm/k9cbLWyALL4e02sHUUJC1BrpFHi1KRDLa5+SMIP85XlgNF6IAjk5cFSMi7LWI9irxvk8uUSWw9eoOIfNV2FriS1WUg6LU/6obA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iymm4QYV; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20688fbaeafso20473155ad.0;
        Fri, 20 Sep 2024 02:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726826315; x=1727431115; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=krJa0YHzRYesDBmJ71AnWCcrG4bSU9zriTKtOU/d2KE=;
        b=Iymm4QYVcfgbpIlezBsS5kErH3QUhr8EyfignH5UkH+eSW6wgMnxqccYhpXBgfcTzm
         57hZr6roGxb36QsJijuX9+5Iao26Jd4nWj8DQoDJq3mci0YXK186egmhiazm5Ko/Su+u
         UdSzuiLadvd5fSGIqNXtsdbxH+WCHYxhrvLyz7GtK3T2/rMlqXrtWzt8/p3ajUx9tI/g
         OlEQgC5X9QDEZzxzb3ZUfuG0V1k0/0P5vPEeHimCf3ue10FhqfHc6R2Zz575vLeCEHgR
         R+9bTYb7Sg4LBMP33FEnlrdfhWkKelrvrJgUryoU8LMVWR+8EhNzDkC9sMo4SkRcC+nA
         cJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726826315; x=1727431115;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=krJa0YHzRYesDBmJ71AnWCcrG4bSU9zriTKtOU/d2KE=;
        b=d1Xn/QeY8Lpp4aOmypeQdz+W/xqDd3nUcE/8zMJ7gOn7dJWHaedTqWsHSf7QCY/nfR
         ZhdCbntiXVLKEQ0IgVf3DaHgCBeFONIcYyHr2sgI/6p4Bam6pnxRGGmPfZVWL9VyD7KM
         a8/7jBX71td8RN0J/oPYL2rRo896n1pVKZ7QPmDLn2nKC+UBEKNIIYJNwiVUm7IKh+Dr
         2NJY3W9CEVLPKe2Bzu0tSqUYSdo43/av0r0pylD0iciUA9bCFZvsiqjWDgliPwLyqAj3
         fK/MgwTF+uDjDDFxfomzpmLQ+Zk0vGrTBRGWwtWNRcYQR+0B+rdNkWp9H9R0Bu4bFYZA
         3ztA==
X-Forwarded-Encrypted: i=1; AJvYcCXwFAIV0EkpARcplUcWEOY93ZoSJGUFmtgjiOEkfUdEl49S1mQ2o1tKhq22Sb8eTdlOozZrggqwGZVS8cA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEoj/el0RdFZkOMOkZ2T/Y8/ycBws3bOmdYRW5+KOVYcYnGUHK
	BXHaZh0FbUP7hY1l+z9aZcHgKQx2lkGv5bC9X379AaE1aOG6u5a0
X-Google-Smtp-Source: AGHT+IE9C39w5Iba/YHQXZXIMA8mOji+ut7xuUk6fgcjEZj2VVfu1BCkhcqolvGF9lg8xcaB5dYOpA==
X-Received: by 2002:a17:902:e888:b0:205:8407:6321 with SMTP id d9443c01a7336-208d833b333mr35304595ad.9.1726826315420;
        Fri, 20 Sep 2024 02:58:35 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794767891sm91909615ad.300.2024.09.20.02.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 02:58:35 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 20 Sep 2024 17:55:52 +0800
Subject: [PATCH] ARM: dts: aspeed: catalina: add i2c-mux-idle-disconnect to
 all mux
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-catalina-i2c-mux-fix-2-v1-1-66cce7c54188@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKdG7WYC/x2MSQqAMAwAvyI5G6hB3L4iHkKNGtAqrYpQ/LvF4
 zDMRAjiVQJ0WQQvtwbdXYIiz8Au7GZBHRMDGSpNSwYtn7yqY1SyuF0PTvogYTXasmmoZjIMKT6
 8JPGP++F9PxaCMxBoAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Potin Lai <potin.lai@quantatw.com>, Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726826312; l=2479;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=88gDVpnA6PhWT5LuFMIcdjhzh9mXo979fV+FwMxeJSs=;
 b=RKgxX3dZqhkSkyCu75khWXpwggC3ECCrTel6ZpW5RF7y7Bz1hO3BitmgqL/Wfc6DGzusH8C1N
 Ng6yO4CLdJzBDWeRFQZM5aTBOna40W/Bsp0x5Man2zawENBRxcR1y4J
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add the `i2c-mux-idle-disconnect` property to all i2c-mux nodes to
ensure proper behavior when switching between multiple I2C buses.
This avoids potential confusion caused by device addresses appearing on
multiple buses when they are not actively selected.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Add the i2c-mux-idle-disconnect property to all i2c-mux nodes to
ensure proper behavior when switching between multiple I2C buses.
This avoids potential confusion caused by device addresses appearing on
multiple buses when they are not actively selected.
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 82835e96317d..fa0921a4afe2 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -185,6 +185,7 @@ i2c-mux@71 {
 		reg = <0x71>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
 
 		i2c0mux0ch0: i2c@0 {
 			#address-cells = <1>;
@@ -213,6 +214,7 @@ i2c-mux@72 {
 		reg = <0x72>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
 
 		i2c0mux1ch0: i2c@0 {
 			#address-cells = <1>;
@@ -247,6 +249,7 @@ i2c-mux@70 {
 				reg = <0x70>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				i2c-mux-idle-disconnect;
 
 				i2c30mux0ch0: i2c@0 {
 					#address-cells = <1>;
@@ -328,6 +331,7 @@ i2c-mux@73 {
 		reg = <0x73>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
 
 		i2c0mux2ch0: i2c@0 {
 			#address-cells = <1>;
@@ -356,6 +360,7 @@ i2c-mux@75 {
 		reg = <0x75>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
 
 		i2c0mux3ch0: i2c@0 {
 			#address-cells = <1>;
@@ -384,6 +389,7 @@ i2c-mux@76 {
 		reg = <0x76>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
 
 		i2c0mux4ch0: i2c@0 {
 			#address-cells = <1>;
@@ -426,6 +432,7 @@ i2c-mux@77 {
 		reg = <0x77>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
 
 		i2c0mux5ch0: i2c@0 {
 			#address-cells = <1>;

---
base-commit: baeb9a7d8b60b021d907127509c44507539c15e5
change-id: 20240920-catalina-i2c-mux-fix-2-6dc48827a20a

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


