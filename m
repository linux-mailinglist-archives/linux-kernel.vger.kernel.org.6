Return-Path: <linux-kernel+bounces-308423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A24965CC3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AB5E1F236EF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C60188A37;
	Fri, 30 Aug 2024 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i58vzPXo"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42D617AE0B;
	Fri, 30 Aug 2024 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725009839; cv=none; b=P7bml72/etxPWjuB8umtnqXOy64GXepNPyT0xnp+QcB8rD5CPXgyfFAy1+3V2hhUDnJH7TAsQBuiFIzeuo6mbWUgjHfIMr2hgvwgFuE73i+2TnfJ7RpXbDqD+9tYHPxiD0Ap9rt9DVLFbcbTCxRjGZjPurpk8Yw0zAWS/jkzUio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725009839; c=relaxed/simple;
	bh=zKeP+r4fvJneoNGNPQMbNW1OqefKUqpy3W7f9cHPgaw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gthGKKiMYkRm7hREfmQ42s19nmAxk2ozt+q1RCEO92X/Oalhi78Vt+ySZ9we09lK81g0IC+TtEERUjQxjhNF+KIljWpHnAvbt8ENcnvv41WiAjOvSRhJMN5lAdmEQl4tEVGp0cbfQTIOfhuzevxgEzQfor1bswjs2DXdfurD7io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i58vzPXo; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7141e20e31cso1332516b3a.3;
        Fri, 30 Aug 2024 02:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725009835; x=1725614635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=24ONLHDIg4IPXcssauearHwBYBXH9GZM3HUtiuvktw0=;
        b=i58vzPXov529NGs6rGqlzKBdPJVijgjk0hM//bP+2DcOZ0bmJi2ll+GsLuLaSV5bIr
         vNbmkfH5kGaPcBiDqjzy1fpTANkGMhUQMpQF2folA9K/AOGnfLWWbquBlVuiEuJ2niTg
         9Ezi/p8MujjE/1IrrHOZI7h5BOO/KO6ew5m/wgvVdyBXmxQC2UtxbO0X+egr7PEmvifm
         otmSwbxRvh/HfUbPbVFF/cDQ9dF5AkvTXAb2TfjIFQxVOwHxmtoHoHVUtxSJx5DkXQwf
         J+KIOZJyi2lQmY606IG7+pKR5+bNrvJRUCTidr4XVdF/JTsERPzUNz2M/Y5nOwFeEMxM
         BxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725009835; x=1725614635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24ONLHDIg4IPXcssauearHwBYBXH9GZM3HUtiuvktw0=;
        b=Lay0Bp4TCmnON7ROstVPDYzaakDclwecos0LAYSTdOu9rVgxrRxMpyj5POtYwaJOcv
         aNE9iSnnwLrp7BvkXh/xb61GADXKYAClJ1YhlXOfbI3C+MEhnsFmVjL8R14gOlibdxWg
         oJybPtlK9I+/+2A8KEtYuBG2G9YjQMnovE11D/kQ4TBUIy9IH6ifoigYrcWf6ZLCMFyn
         Nm8WgBDGAKwxCVl4sGR7ogD0avT+9QJ1teNU+PBHMFbNVze8VQdliyeAPJYrxzzsFsqL
         NWKmlCeAG7eDahEDNoyITbtREHBhvltoxSobC8qSu4ZE9DTEMyds+R9dIH+2J3OUt1ti
         GopQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/YlQbWML1c2myiBU3fQ38Hdi3jcgyrqnyRmFE4+qNvhpJhzbTRRb8yazSA5jaci6mQ245QtLkGOgI0uvW@vger.kernel.org, AJvYcCXPAJcW7NmnwV5p/8ypmWueOXDMu7b5CLKDZnNQSJZg967l73jSh2z56IXfpnZpR1ilyEGza8cCOb42@vger.kernel.org
X-Gm-Message-State: AOJu0YwS0aU4v03VOPQtRKMdW0MdPzRih7gSly6XYHscPGKBfF/7sdi7
	nhdjttI3VTXss3GkoDUNi+aBZK+STjRXgghgwL09emcyH21oZmwS
X-Google-Smtp-Source: AGHT+IHVds/gNBeqiQw80n4Y1TOS9j/5h8Ndwc6d6YZI5Jzr6qTP18YyB5qpXOuOINGKTBpa6o8eng==
X-Received: by 2002:a05:6a00:6f13:b0:714:2198:26bd with SMTP id d2e1a72fcca58-715dfb46bedmr6360284b3a.11.1725009834948;
        Fri, 30 Aug 2024 02:23:54 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e66d8f4sm2566744a12.0.2024.08.30.02.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 02:23:54 -0700 (PDT)
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
Subject: [PATCH v2 1/2] ARM: dts: aspeed: Harma: add rtc device
Date: Fri, 30 Aug 2024 17:21:46 +0800
Message-Id: <20240830092148.1574520-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830092148.1574520-1-peteryin.openbmc@gmail.com>
References: <20240830092148.1574520-1-peteryin.openbmc@gmail.com>
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


