Return-Path: <linux-kernel+bounces-230780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A589181D7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F22228620B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149A1187551;
	Wed, 26 Jun 2024 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JinQx6pn"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB4C188CBE;
	Wed, 26 Jun 2024 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407164; cv=none; b=dthC27qn9SdaA76cwRAJswFaJ5nQOtsZahkAJ9Gr4JEmIN14VkbjcEYVLgGXNk13RAif4we7rCEpqbfGQiJCTr/JKeJpvRXPcj4NUB8V0DoTUMcovdpTIMQGY5/Z7UiEZ0VoVEgzjXNR4OsqG/Mf4hd1yLRyFKzpEo6/BT/GFBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407164; c=relaxed/simple;
	bh=jUNhN5Q73J+G9Tl6xUmVfO3w35S4DDhZPvF5YGCeHEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C6zXwnHCeFt6Wc/yWAJ/jnKA7pvTMupE4JQR2dnI07RxJ2c3ptM0WqhzraQ+qBjFdS82SXTQg/dmaKHapnD+j3514u20+iJcZVl21KDEQvIhAO8nmICyiWQucQ3uvYG7+TF2TbyLvXuIxRaOOk8bRBZGxbhaWRzru8PBb7p4d/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JinQx6pn; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f4a5344ec7so4309495ad.1;
        Wed, 26 Jun 2024 06:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719407162; x=1720011962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqsSYdsGNy1ml2i2nb2KczLx9uSIN7hDvVpf7dyFvwY=;
        b=JinQx6pnHbxc1ny6J5XiGeLZs/uWe1H94nI1iXsvOsRK1JT4/RCLvgcuGeL4KatpIh
         gioJ55+hWaemwSmmBgkPmymCvP0fsmGL8wmhJ+629vTqb1z49W/KyOW1dK2UNnoXAe+V
         z39Qb+LhAjMizpDMcDtwhJQq6jb72tUa7LOqQBab173cxlNkgwVpkW4Hz+67LP1BfOCv
         tQ6OcDaaQMQFLsdPwucZUjKwBNJg1YZJo7udVuAhIw4m2e4y5FvauV8SI8tLJkB0TpgX
         PcEq5hTG37pISKkcdGWt+aE6eyth5eGuCAKFJHOyXAthZBATFAZLQUTFR5ZyXp5ypEsQ
         ENMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407162; x=1720011962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqsSYdsGNy1ml2i2nb2KczLx9uSIN7hDvVpf7dyFvwY=;
        b=WzZYteQM7X041/LrGc6V/uwAA/g8VlZFw2LIuzIQ982n63hxv8iC/JrflD1vBFi/Ja
         Dz3vHX/7fLh4gFHsRcvGZIWmyYT9jW+teluIhNA/98vwaz4i4vzx6zKzO3kRgtihmywp
         8/VIFlLOO53PIkzsjoMLc0XeoHTZYLN2i9oDGRq/eQ2qhrGg+t9/8rWWyAqg8bSoOmaN
         uztZO1WjWWx9giur+xSJIN2i2SxqUgyrhBAbOEEKZ2XKDnEAzzaR+nDmiA/XgCBWJ/DW
         tjVX4gdFxoUzWfuKFLqvhpaFGYtPPeQv8ZOzU3h1s3zyGTSEdU8w2O/Z7j+36PJqNM2w
         bP4A==
X-Forwarded-Encrypted: i=1; AJvYcCVvEmgwAF2A7ihJzZlpzed4UQi1ArnZ8gurfhHGSIMJQYajxyTqCvCEJxedV072kvU+EpwRFNCtOVl4JQXqLFcxplKyRtU84+Cf1NR0KH2oOzVMQFZHT7C6jXzDnrrKTSuL5iPBT5shRA==
X-Gm-Message-State: AOJu0Yybn5UG3tdOzCSjVDf0L9/R2ZP24mm31WPt00AbZucOsqouzy+4
	875sUIkZcMQOcO13CPLp1G6UG+m5+IG4Hyx7Cs/Ag2SjIurY1P666Ln27obt
X-Google-Smtp-Source: AGHT+IEquapQGluFst4GQTayITLbBV+AzezwxNVM3Yrgm4DVdGViRjtWItWW9QO2qQLajyEKCKgzSw==
X-Received: by 2002:a17:902:f70b:b0:1fa:918e:eb8 with SMTP id d9443c01a7336-1fa918e117fmr18861285ad.47.1719407162220;
        Wed, 26 Jun 2024 06:06:02 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb7cf885sm99112395ad.224.2024.06.26.06.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:06:01 -0700 (PDT)
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
Subject: [PATCH v1 10/17] ARM: dts: aspeed: minerva: enable ehci0 for USB
Date: Wed, 26 Jun 2024 21:03:25 +0800
Message-Id: <20240626130332.929534-11-yangchen.openbmc@gmail.com>
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

Enable ehci0 for USB.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index f41dcb36243a..fd769578f826 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -531,6 +531,10 @@ &adc1 {
 	pinctrl-0 = <&pinctrl_adc10_default>;
 };
 
+&ehci0 {
+	status = "okay";
+};
+
 &ehci1 {
 	status = "okay";
 };
-- 
2.34.1


