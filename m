Return-Path: <linux-kernel+bounces-228827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7806916791
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051061C20BE7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02644160860;
	Tue, 25 Jun 2024 12:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbE1c2mR"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1464215FA7C;
	Tue, 25 Jun 2024 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318054; cv=none; b=K0XNGnbLEjxhKenCpyHJSXi+WjyfaSVkGfD0rKxhEo2VOz7UaybCTij/AlCRGlPJZPu4ZNAC5SPazTPyQrVYdGzoer4xK1wo8NZxAO/CmxJvEQZiVAXl3r1FvO2LWM5dB8L3JUUiB0g67/HBycTGnRS3XrcY0voOZBD4Jv9M7JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318054; c=relaxed/simple;
	bh=J2toIYfZjWVGhCcUDQMoYDAtZSlmegm6/lShkywG0jw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KjDkxTsDiCjWqDSau8LQ/koYy1C/eos83MsSk89rmU4sRy5s21NcnktBpDkTG4am0rL+oibuTAkbQ8pQW3OMK5cB+Rs/uZRj3a3w5gp9bEG5xe8Ar+tq4BxyTEWJLknN+fxF93HNhxBjVOCXFm/AyBSEs3IHFC27ySQIhVQoHow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbE1c2mR; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70673c32118so1881833b3a.3;
        Tue, 25 Jun 2024 05:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719318052; x=1719922852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGiKCgocnymn+yHqK126jXlfsSgcwH3iwTb3bF9H5Lg=;
        b=QbE1c2mRzw6k1BvyIe2zHOXvOz8ieXo8wgVXC9zIrL2EajyQrjJ5Ci+N7783GsSLsk
         VTh/g8Ej/PTJHg+Ni3DUARJDkDILfS+WMJwXhs+eSYNr9D9iuwOH+FluqrZgzGQvtA5V
         LeDCPqvcv70oePdzpp+bEhXllsv6/eCt4tJ6s/z+OOQs3CFaO8n40T332bxjIlBE+zyN
         mXliW76cw4J4fQnE6dh5aNk+ICIU++KZElA6KdFvpD7jA4WruygOdjLwD0cTemJL1FPX
         oazef7Ms1KkebpMOwt6l/E16jtxID6uLOdIURhDPHZWqw5CHq9Hiz6Py9xJa1xrN7ZWv
         +NJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719318052; x=1719922852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGiKCgocnymn+yHqK126jXlfsSgcwH3iwTb3bF9H5Lg=;
        b=Qs6nPi7CdZ36Q1X5JStMqT5DJKtSDf7cCo5mRfDv7Y1CqjG6giVygyxa4kKldg5B4k
         SK0MHMUE8K081Isu2Fr+u22RAa9muorYRpfqN7UUOg7Kdo1xRZia7H23F6/5ScrT7Nue
         w1gxXch18CkgzO0MGSRYkFDE7MH6bHj+J88h+UQe3dcbnR0a/YhMLH8YKJ+PXTCNz2Ml
         tu+/DBDqKfh9gLOK4R2CpSnrXuVKnkMtN7D462EoLEa3jJPPzi9Iqla1OqtbTAZYXJk1
         70I4SK1xwoDekTrUIMs2Iov3tmxp6BL3PrWia0iuwehMYvlSRUnyBa6APUnL550Dd1j6
         UIJg==
X-Forwarded-Encrypted: i=1; AJvYcCUttLSMs7Kfj1SKBx0JDww211XDIY4vnNt5CU95bAZM0PRmS3epsc7FTffBjCN+7gHcHoS6O6TVpXPG3Y5HoCPZDzDa4TfUFC70EMnsPhjjtPsBqu54D4aL4pWcsvqYXsw7R8qGf9y6lg==
X-Gm-Message-State: AOJu0YzcdsxRjel9Cct8F2LFpQU4FktxNd5LTQZz1uZeST+bEthTMQlw
	o487wsVoLFQ25KlFZ4XJUZWYD6rcKmDpOU/Y69I3rcZVE0o7O3a3
X-Google-Smtp-Source: AGHT+IEEPEHbmFKpDEhIVhgQPNqT88rVvqOmw5tPlFHrVpuX5vXa32ZKy/X+/Jzigl5dadnhr78QSA==
X-Received: by 2002:a05:6a20:9695:b0:1bd:126e:b4c1 with SMTP id adf61e73a8af0-1bd126eb6c4mr3358782637.7.1719318052386;
        Tue, 25 Jun 2024 05:20:52 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70650e312e4sm7978146b3a.0.2024.06.25.05.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 05:20:52 -0700 (PDT)
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
Subject: [PATCH 06/17] ARM: dts: aspeed: minerva: enable mdio3
Date: Tue, 25 Jun 2024 20:18:24 +0800
Message-Id: <20240625121835.751013-7-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
References: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Chen <yang.chen@quantatw.com>

Change usage of I2C bus 11 to mdio3.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 32400284479e..4d67ef29023c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -99,6 +99,10 @@ fixed-link {
 	};
 };
 
+&mdio3 {
+	status = "okay";
+};
+
 &fmc {
 	status = "okay";
 	flash@0 {
@@ -336,10 +340,6 @@ &i2c10 {
 	status = "okay";
 };
 
-&i2c11 {
-	status = "okay";
-};
-
 &i2c12 {
 	status = "okay";
 };
-- 
2.34.1


