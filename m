Return-Path: <linux-kernel+bounces-230787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D8F9181E6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11981F211F0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF7F18EFC2;
	Wed, 26 Jun 2024 13:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GB0yFDZ5"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFEE18E761;
	Wed, 26 Jun 2024 13:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407177; cv=none; b=HzABBg20u91SKU6cqMH4mfd/kXbT4tsezmJrBfcXLLn/LYAJD2uhBcXP3EnA9dqnUiCaMP0iMT315DToeTNhLz1hILU7xRQTP/Kkt7RjqTvkL/DvoRR/8uZyP/ybrb+cLPxirNVnpVwpaMbaWny+/BoG0lVB41ZxHZ3tXyop9nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407177; c=relaxed/simple;
	bh=76tjxy8lp8oZHfjKGKB2RceWqVPZsVskBny9aqkOgNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NcKmcJrg4rRbyKUIE1nf8bSiHFa/lZeQdkooLHDYHr6vvlZ6UuAmW+J5bNKEbxdlGCt3sdBfl6y3kg67nbXK5RaBKriGuNOZdJRaJGq8k1iwgh6c0Kd1Zc1ovJC65QIS0zyMc8uM9R2ChtHxS01iDMyvmjzD3XkZUH8XaGV4CtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GB0yFDZ5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f9de13d6baso47740335ad.2;
        Wed, 26 Jun 2024 06:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719407176; x=1720011976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=770f2s193tecuqJzO0rEDeOzzz/M/ipXn0oDb/92wqA=;
        b=GB0yFDZ5zashP/0VLyOkX3RJNRJffy6umLyITcgKOBMg9J7SJqxyoA1nCnRbL9ewvR
         yvwwUQ3e3AYtFkMcAYdJCxvj1Xd4+TWQPFIIJtkCPyABA3sQDynx55B58Yd2oKpEEmjX
         fa9WUS0GcSNLGw1RrgSoXfh+zn7sATaqafcIVio/C3thwwwwGr8R4M3BcUTwiB+VcHgs
         njGoI1m6RcMjH8DD9swWN3ZAmKx3bzyMftdNr58U5G35noDd8Gx6hY9H0+CB2xbX+wSn
         utmtkzYNa4rkZKj4w8rll6toTYT/zKB3WkO0XO+bfsDb+etiQqC/5+hY4QDIa7HbnOAE
         ZWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407176; x=1720011976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=770f2s193tecuqJzO0rEDeOzzz/M/ipXn0oDb/92wqA=;
        b=bTPOktG4rVpIAvYkz6uZhA89hJMNb745+lomBfHMGPpsPuJ73lQ6J+p4odr/icdcRi
         H8XM/wuJCGGv9ZN4Db/Z2T+AWpo/aHxzjD845cLZht63w4XWJmEynf/MUPL0vYVXvCOD
         loHnJy9RbFvtg4nZdkbPYwFqJxcYsCyTD55alyMYAZBZLMCoL0GvDU3a1u7xvbGv0SnI
         KttGBi4E7jLIKo2GgfbaMOKNcqK0mT2s8THb8BdiSkdobUWevKP3mcuZVP0l2o6k9oGj
         ddyUYqESu/AutO0UkXLXLNtR66PfQiB91D9bAWLVOwA6h9vDApztph4D4dl28DRaIocQ
         DmYg==
X-Forwarded-Encrypted: i=1; AJvYcCU939Uy4pOLBzepgsisZ3pSIO2fnxCvncO8YJ01VKkTY1/E8X62KeeUEr7aR9cV2Zzs4eu1+3pjBYHvz+x4rNqIXB5A/Zc0LSqLzQSdysn3MNA6+gjT+1qbOXd0f0w8xCMNYHYVR5M/CA==
X-Gm-Message-State: AOJu0YyuFdB5FeImpC2AYRGWovMu2YSWj5gYUsn5aTw5gvBtJP5R2foK
	ly83YDndVPvdQPaxif9EqxDc4ZB9pbl0v9qbJNRxv+3obm3Na8w/
X-Google-Smtp-Source: AGHT+IFpFuRVXmzDU+6hiLsXKZf0R17rd/F3pxpvF8hL9473AzT35b5mBF8q9rmvLOIWAt7I6H0XhA==
X-Received: by 2002:a17:902:d4cc:b0:1f9:9d40:c9bf with SMTP id d9443c01a7336-1fa23f610b3mr120876115ad.18.1719407175639;
        Wed, 26 Jun 2024 06:06:15 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb7cf885sm99112395ad.224.2024.06.26.06.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:06:15 -0700 (PDT)
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
Subject: [PATCH v1 16/17] ARM: dts: aspeed: minerva: add ltc4287 device
Date: Wed, 26 Jun 2024 21:03:31 +0800
Message-Id: <20240626130332.929534-17-yangchen.openbmc@gmail.com>
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

Enable LTC4287 device on i2c-0.

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 093305b598dc..8180fa5c1854 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -144,6 +144,12 @@ power-monitor@41 {
 		shunt-resistor = <1000>;
 	};
 
+	power-monitor@44 {
+		compatible = "lltc,ltc4287";
+		reg = <0x44>;
+		shunt-resistor-micro-ohms = <2000>;
+	};
+
 	power-monitor@43 {
 		compatible = "infineon,xdp710";
 		reg = <0x43>;
-- 
2.34.1


