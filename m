Return-Path: <linux-kernel+bounces-230785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 032589181E2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69A1FB272F3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E2818C345;
	Wed, 26 Jun 2024 13:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnofyXPd"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D040E18A953;
	Wed, 26 Jun 2024 13:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407173; cv=none; b=PVBz+evx6Bc/phjOILepAs4B02RN5DXU4C9B/Fo0dZJQpZ5rT1jSOe80cXRQpu+UxDu7o9rZeni+RA77f0f/9TscFvz8Xq16o2QWlgj9igE5nkOYPfDRNJcX9jRfWnMy5hXAVqgAD1qb7JwI5HHoxil2PVJA1xAmLJhWzdvxAq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407173; c=relaxed/simple;
	bh=ncsi16LngT4JZVwP+iJ9hsx7pd8g3rxzMgYpNeocmsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HW3tZKHvwGUeDRd50KklHKlDgay6Xu9gq/Sk8aQ2Qdt/EudCTOlaEXS0C4gzlrJjIS9C/PPPsgK1nD5L8K23wv5QWSyt+ehF8SzPhD4WKM5l33VzQGuyY1sYrz1a+0vPRwBCipHOf+oeZ/4UqY23UeIjiiod5J7t+t6WYbPH6oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnofyXPd; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f6a837e9a3so41169925ad.1;
        Wed, 26 Jun 2024 06:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719407171; x=1720011971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvFxbMreeuSo/wVfgiSYE826uiYtvaR7mJSAkGu1qGI=;
        b=cnofyXPd04xtIYz+iwc7ChExNBz5AW8qvnZE5afgUcL6LdWmTS3HhOYJvYeGOLQ+Rf
         Gd2XbCCUALqEvWmT+D57qKXolF3wbgY/+xenHLSG5/XM69jGPvEuvtB8oTeejeNu/Vub
         7Od4G154/ZDcd06KmrmBj3V0c76keHJpC+tNEftf8CPH5hzc6ONuP6WqrKBM6BSz8bnu
         i6ToTbUfA4V03bw3DIDaxtH6SL42DT0vqqtgbg+8LceJfy3WmUp/JYdGCxFnn5lDydi/
         IYNPFx7YWRZTc7EMtMzsxqrbG+J0eTfQOHBWrbjfpf+fhIYvSfiUoQMA8l1R96emYhK1
         uhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407171; x=1720011971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvFxbMreeuSo/wVfgiSYE826uiYtvaR7mJSAkGu1qGI=;
        b=w9CMR7ziQFyMglUs3d2eiERLZiUzZSzfHsWH5sIDvsjvL4BGESswnMS5O0ZwCcMCCe
         bE8PQeDmU+9HhNZZjnmcILwG6/wuZpGTiUPBKnH3/dl9FklunDx6qR2HGxtuwmfdte01
         GhgouwXz3N5ENV+GuL6MCH2qc49WApxG5Sla9ri53Hx3VnDoXmIjBDlEFqZ65ZhgC/Aq
         OxkyKIALs9RZ0fBibDqnkBXna91SBaPP084UPzWcWCzggwQvNLUZKY+ahnwLmecTKKgn
         R0FHiHtw9PjiIVImtgh9qscJGGMXh2/B8B+8GGMDySBqctMQEmQXjP7aimR1StJEWOD9
         HppQ==
X-Forwarded-Encrypted: i=1; AJvYcCX55f5ICevyUmojCL1FTdvBFY4Z27atByONzWX9LuG3SvJX6x0uUDANr2Pavo2Q0O3F6CKEGkzGVQYuMXL8pSqFrqmwGWjJ94EF39LDhhsQMKziUnZUjaYMAQsRoinAAKkFPyrGuYk+MA==
X-Gm-Message-State: AOJu0Ywt4Oo49NXVmsFwExYw3eK7OuESgyqk4z4TrbV/qlJZ1qiCF1f6
	RMls/wMCf90SIJQ6WEjOCWo/UmVTm3bzp50+MedUOOQ7603Jp27LZYoSiXTZ
X-Google-Smtp-Source: AGHT+IGueZvTrYwVA/faedHrbTl2mOgWOsC1cuMKwfkCZai5FZoLoKDrXojgNWmol/DIiaCQiA5EgA==
X-Received: by 2002:a17:902:ea01:b0:1f9:8f8d:cc8f with SMTP id d9443c01a7336-1fa23f07230mr127107075ad.11.1719407171209;
        Wed, 26 Jun 2024 06:06:11 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb7cf885sm99112395ad.224.2024.06.26.06.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:06:10 -0700 (PDT)
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
Subject: [PATCH v1 14/17] ARM: dts: aspeed: minerva: Switch the i2c bus number
Date: Wed, 26 Jun 2024 21:03:29 +0800
Message-Id: <20240626130332.929534-15-yangchen.openbmc@gmail.com>
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

Switch the i2c bus number to map the i2c tag according to the hardware design.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 7a790e347853..8f3f15a5c148 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -384,7 +384,7 @@ temperature-sensor@4b {
 			};
 		};
 
-		imux20: i2c@4 {
+		imux20: i2c@5 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <4>;
@@ -430,7 +430,7 @@ temperature-sensor@4b {
 			};
 		};
 
-		imux21: i2c@5 {
+		imux21: i2c@4 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <5>;
-- 
2.34.1


