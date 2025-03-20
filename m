Return-Path: <linux-kernel+bounces-569938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3498A6A9E7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6891882151
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DE12253BD;
	Thu, 20 Mar 2025 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpGkCgkh"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF452248AC;
	Thu, 20 Mar 2025 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484291; cv=none; b=Hj6iaj7+3Jey1pLAwplTjYdSW2rFXpENwGh5PC9uUyT7fVxfmBW6PNjqQ+O2kTYb7JuTwNFpgWxZAIht0jI7X+50mu2sDiJ5ltpFdqBicYhVc8WATyea2IHIbCuCkwzqHH4jiQRWU4efkAJYijfd9vOShgM9OCAZw67f9UvK9IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484291; c=relaxed/simple;
	bh=EUweIVFlYiMF8bhCySW4H9ia8wPetO4bJ+6FKYLTF4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OgbieLwn7fpAlSC1qXL/EiwEzfSLzfxIOCJ2Mhl5ovE6/m7BxUBw3I/22vjxO8ETp0EaeVPdlb6TJ1gIYRAUAWdpmtZaPKyLJE1FVu043m6eNYNNKRfNPVo70UwEPek+Ts1m1cgP70jf1HQ4YnuaHYkg8Kk2bzAvYvzVDWNhvM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpGkCgkh; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22580c9ee0aso19771325ad.2;
        Thu, 20 Mar 2025 08:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742484290; x=1743089090; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2C2x2YqAzE+wgdoLnExW9swbh2264Dz3KcOzm8hz2vw=;
        b=dpGkCgkhPyutCh2bOEPnUMNCiebbMHzgnldbY10gYQyoLzllYzD05Ei2FW6KCWZoG1
         BpwjKaZIMhipt8f+i/1gK695DRwqJCoFk9TTqm9YxA4X7Fsll02Cp+IWuZq5hVfSPhgQ
         jtDgbms0aS1LcC5Kq1Q+61Cdj+JYFkIffqMR4LuHH9MkUh98hnFK7eOIqDExYARJxwc4
         W2PuNlpjo9/9hjhrt8ncXDPODvo7QvwAq4r3dSe/65occorXm/POIHaEwDG9pEA7nAfh
         vKcPppBavKhga61JmKMnysVfWBjqOBpZdIExb43mkejE0cO7pu0FVZvZ/gAyEP00pPnQ
         o7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742484290; x=1743089090;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2C2x2YqAzE+wgdoLnExW9swbh2264Dz3KcOzm8hz2vw=;
        b=tMt64PFXFDLajjAAgarr0rPVvX5Iv9yOeskXqJDFrvB82SIeOrH3eLUufYNEyJhGJD
         UZfHrm0IuQg+Wa8a5zDRTadov4YwBBXmTPLn44JxfKwb0zggiCb5PLLftn1wdd95TWcr
         NLedsKDdjEbhXXx1oGhOIjFvxgrD0VY4eKVWvjbvf1PmjhpXJZRUxalPHbrS2ozM4ra4
         VEJFasmc0req2QXa8OeXB0AeSMqt52sOCgCxjH0OUW5agItamnCcDAu/0SNAOSE54zEx
         6ok8uhdKDLOQccu8rcUEuWCJ/6FNZNlXpptsnBvgGsrHUS0gUkFFoZ6wxfwiIs1mrVwB
         4GVA==
X-Forwarded-Encrypted: i=1; AJvYcCW8xQ3libMHvt/zxrmE2ZfK6reUzRIojIAy05C0fFqga9l6gnS6fYBa32Rsd++boAwY4Gw/Hl3wc0XgJmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwabEljVvdxsVu8JsURet+AbFy0QOpDamFtQ8BWx2SpxLJmQ8dq
	qBT77iqFF7Df1LB1TYAxHgpOUA1xG4y/gZe0wKq2jxdqFm5sL4ax
X-Gm-Gg: ASbGncupHh0m/pgCv/ssX2f/tJbkyO0+kXVFSv2f4Hgec64VvRgRwhepIEssEpLIT/c
	wC2EHdr131n353J9V81PCamK/l4srKZG8PzD2OpeUP5zGQ6sZpKwsCX6AZq173UhMwsbS6pfU/F
	xfnyKsdp/XZYDJ2Ga5r4TvY6MJUOilBGueXBK/9hj97yJlM+CcpQop8e+Yk/PsBRvdIlZVJhNAQ
	O50X9vBTAA1CpGvQ4h+P0JWxUESyXlVPvlhq6C0QPJ3S8WeIGvA2qLzONeWUxeUFQrmlnFvw6DX
	c3bVwG+68t9r6HwuHtPYX8qSJUu5sjmoW7JapeUjcz8ioFNjzCGECdhbdvdcd6UlBAD/XrqdT+i
	7nuM19Iq918Q08PhDUVrsOg==
X-Google-Smtp-Source: AGHT+IElDPX6u20sc4jGPjSUZZw3qo1ZEYivqxwtIPDdkwEzTDmmDNvT5Nl4muFEx+julDo++r1G7g==
X-Received: by 2002:a17:902:ce07:b0:223:5e54:c521 with SMTP id d9443c01a7336-2265ea35407mr58249745ad.0.1742484289793;
        Thu, 20 Mar 2025 08:24:49 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4a8fsm136905515ad.234.2025.03.20.08.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:24:49 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 23:21:58 +0800
Subject: [PATCH v5 08/10] ARM: dts: aspeed: catalina: Enable multi-master
 on additional I2C buses
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-potin-catalina-dts-update-20250102-v5-8-e161be6583a7@gmail.com>
References: <20250320-potin-catalina-dts-update-20250102-v5-0-e161be6583a7@gmail.com>
In-Reply-To: <20250320-potin-catalina-dts-update-20250102-v5-0-e161be6583a7@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742484265; l=1008;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=EUweIVFlYiMF8bhCySW4H9ia8wPetO4bJ+6FKYLTF4U=;
 b=kSwteKt/arVVylSZep8fMc7WzfoOs3oC1D9o+m9HYvsgOQiQth90tnxsRf2VTGYVDfLpsy4mP
 dIl4AtyZ4hDAbZWkIA0376ck9AuceRHGOiZ5GZ3b6BUT8stH+r6v5DK
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Update the device tree to enable `multi-master` mode on I2C buses shared
between the host BMC and the NV module with HMC. This ensures proper bus
arbitration and coordination in multi-master environments, preventing
communication conflicts and improving reliability.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 1e1bcc9ac2f0..abf15d322605 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -815,6 +815,7 @@ ssif-bmc@10 {
 
 &i2c12 {
 	status = "okay";
+	multi-master;
 
 	// Module 1 FRU EEPROM
 	eeprom@50 {
@@ -825,6 +826,7 @@ eeprom@50 {
 
 &i2c13 {
 	status = "okay";
+	multi-master;
 
 	// Module 0 FRU EEPROM
 	eeprom@50 {

-- 
2.31.1


