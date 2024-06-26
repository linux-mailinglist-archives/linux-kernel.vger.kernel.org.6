Return-Path: <linux-kernel+bounces-230770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA369181BC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7911C2115B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BD6185E70;
	Wed, 26 Jun 2024 13:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaWC2Lw1"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3351850A3;
	Wed, 26 Jun 2024 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407141; cv=none; b=Ww1O7knT2M+dldPyR/PlPzteW9VRiWfq6L1Bchb9tyIviiIWPgCKCNVESRjGQkZBJJS25hzW4EA9JSie7NbjLtugJ4JLREMKwYwDBl0rzB3UxzO1ICw2hxt/4Kv4TO4QQDBiTRa9KtdXTQgYRgZ7MnlQ+B32d8YW/2t5YZUaU0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407141; c=relaxed/simple;
	bh=yNwDHGDOMYwKf3XYtOIwSI1qyvcgNeGK2320XD8Ouak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZgBTfsYmzS4ztA+j5cKi84Hl1vQbeLNcmgDmWhQTgW9RWhGqaJAocjBVzHg+Ci1blTp6XG4nrQ9sJbYLKEfFeqen7SdK1lWLnGmKc+DBIAisPkBVmJyLwDUz/YxyH/Ebh46fMI9TFIFmXJr18y8dSUqm8KNHKodcKNLyP8T23o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaWC2Lw1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f480624d0fso53100575ad.1;
        Wed, 26 Jun 2024 06:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719407140; x=1720011940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyqW/YPcUcSECKMKEcpbBGmhotZwVjBgiijoMXMXMs0=;
        b=JaWC2Lw1Jd+P9UqG5fBoINvW/4EDk0krtDS7PJqQ3/U39EMTG73rDSAbuyXX4kfr7E
         OpY92jX3qk++58TMnLvf5PpVHMKzqovDxX/6jpKj+8WqQddaUaxVmA6wEtmW75mEpO8q
         KJx1JSdG/5ivzkzD+pDpWrLZ36UGWYZE1pSuU3A+PxD1IAMyCv02fiZqW5N++CD4ZpPl
         +ljnoC4/IsNqiI0mqZMHYRgbWAT3rrdCuvsdp4afTUIMw2E3pBSaHNsMgbrtSV2vnIVX
         ZUkiF/CXGMT6kPTUwoyK7Du16vts7AwpJ4XWpKp56RcfjiChzYDpintOuVCQa/jrOaEq
         ZzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407140; x=1720011940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyqW/YPcUcSECKMKEcpbBGmhotZwVjBgiijoMXMXMs0=;
        b=lgaXFlej/qxlVrP8MOVpvnX10PNbaT2/7lzbGmgXQP7mfrL7iqT9PFRSEWBiNU+jaL
         hxBs97CTFSN3QJhiDEZ2fF6fT6M882idFT6DVjv5bkG67Xi478zNEcn9Zk4y4ZRWhuM9
         FP7ZazfH0rqcrLLMOy8FwgsQzwPGOGFQXsW+xxCikRrMtDC5IJPZQbuo5/0SdKqyiTtc
         Kpdn1zfSyTa6nkR+mDl+x7nW0DOwnZnnv7SgcIFQkdyRVy4LJu8aBR+daqnuq7Lcs9kE
         vskwpB/eXdCGy8HYzm6lxB9WsKVIOX/N6Kq9v8MCVTLlI7Nik1LnEiwwyrcmvX3aoBn6
         2nMA==
X-Forwarded-Encrypted: i=1; AJvYcCVWOavTfYWHqhYEW29IWt1o0hz9AzLY7tkAOdhsDx2IJ+VQ+anCOJyz7Tg+s0rWoAIAHdtjZCI2FCD5ylYoOa2D29+CyhMOyoDiaKE+9QH0t+nDXP0slk1D+MLp5qKxreEXY1H6SWGJmg==
X-Gm-Message-State: AOJu0YzRpCGwZZ6yhgzwpss20uHFLVqGHTDTb9w6tyYcChKmczBwpv4k
	O+grQ9XlvYyL6tca/94aYlTduI8v4Inhz/JmyZaIpEHOdLlbTldK
X-Google-Smtp-Source: AGHT+IFXKI3ZK9KhGk+NOro9WzwgcP0es2mZLIvNIGkh7ef2OoZcyOGBPs6/d8NBHWVVUni0wDeFFA==
X-Received: by 2002:a17:902:e84d:b0:1f9:9691:7b9d with SMTP id d9443c01a7336-1fa23f22833mr119940605ad.11.1719407139777;
        Wed, 26 Jun 2024 06:05:39 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb7cf885sm99112395ad.224.2024.06.26.06.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:05:39 -0700 (PDT)
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
Subject: [PATCH v1 01/17] ARM: dts: aspeed: minerva: change the address of tmp75
Date: Wed, 26 Jun 2024 21:03:16 +0800
Message-Id: <20240626130332.929534-2-yangchen.openbmc@gmail.com>
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

Revise the address of tmp75 on I2C bus 1 from 0x48 to 0x4f due to design
change.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 942e53d5c714..e20e31917d6c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -145,9 +145,9 @@ temperature-sensor@4b {
 		reg = <0x4b>;
 	};
 
-	temperature-sensor@48 {
+	temperature-sensor@4f {
 		compatible = "ti,tmp75";
-		reg = <0x48>;
+		reg = <0x4f>;
 	};
 
 	eeprom@54 {
-- 
2.34.1


