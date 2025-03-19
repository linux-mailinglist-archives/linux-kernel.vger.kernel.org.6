Return-Path: <linux-kernel+bounces-568440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DB3A6957A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1073462E13
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0489F1E5B63;
	Wed, 19 Mar 2025 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efJgxnSB"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014A3206F14;
	Wed, 19 Mar 2025 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403014; cv=none; b=JX1xbypvIl9G+H/0R3FI7z8n0ZrPZQ0vcWAYtGawStK2vu8KGEjNJOw6HFJrmEiI8ju+ZIhIffUMRGIjdA+7TCszYPnHIJv/EVFaBzrwXWKv5spDcOuk2hr98oFkAmK3tbaQBklCZXINqujOI3MM+0R4Jcewc0UToYveyucpJFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403014; c=relaxed/simple;
	bh=jtqICxpttL+081MeVsrW0PF8g0r+obZJAZMWsooXIQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vAOzfBS6QyWuvakuqtC7DUzrR4j0MziVciSeDdTrTld0OuID/TS991J+3oaQmfU53l+xUALtaD9+I1A6EbEYk++OK+kH1yFAdpejI7AdXB+JzKvV48qGzo8FVT4SRfXNiA6UqJ2aacZn9+LZz+yQwl3sGJbhklsvAz1JtgjJUuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efJgxnSB; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-301302a328bso8461377a91.2;
        Wed, 19 Mar 2025 09:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742403012; x=1743007812; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ktd5HnARwuJ13vsAdMCAO/qEm+OczuyUS4W9n3wx7eI=;
        b=efJgxnSB1K46oPqv4mV1zE/gdakXdU2TZH+haKwc0RnB9bambJVgDAZqbGn7JFc376
         RHDGZZbx9pQMD4JDb6kg7tGbgoN1iL5u3RNaJIN5WZajV4dzw3LDe3Q69KArnx7W5SE1
         meijlHe0oli7o4eVew3qHj62iVtjM4EXYB79dG204QCNM4gRB2EznmcqsXWIHiSejA6D
         FBYIIuNsKfHTSZVPUvstzRLUeOb+JLDKk+Y0ijOHVXA/ti+cdPSavN2hyFJhTNhMBehi
         aZPc4r78HvxLn9XRLesNEW2yTbTEmvdIsiBLCB7P5pZN30fXL2e5Fpw/26huuJjYiPnj
         pv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742403012; x=1743007812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktd5HnARwuJ13vsAdMCAO/qEm+OczuyUS4W9n3wx7eI=;
        b=k5pQ41y4ItWK7ZGztRqCr0cSGEIes40AI6HVAIJ01Z65eWFMT3LWPsrpDdtVZh4mj1
         X6yLy6PN4nrBoFsq5+Lno4bJhc1EZABPqg9MHBkuV2O65tWXI8rW0j/8x4tAdFi5gmRK
         pM8R32nDet2OAlJkBHUEp8LNpaZ7Zh3Ts7SjrpHfcAlXzvz5F95EIyXuhBOSCJVk7Od5
         TsECClIxgaDVfQNOGxY8j7MbB6+KKdPTUqThHHecENumOChV/Jp7ugjdxMuJIE1WCp5h
         x7LELt0gx/2NvQqC6bHW+gKVcHbqjPIIwWP7PorDNcAo+Gr5fKSk2/aWr3r4bSpKT+9C
         nBxw==
X-Forwarded-Encrypted: i=1; AJvYcCXedfAEgAqurDEm5NFtr3mz45YMYomvRyJPZ16QBSb9cyApMMaK2uGb3lYAkGBfUsa1LikRrxTK+UYkIaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSQ7kb+1E4RaetfxG5W3D8mh2J313PvYnyvR8MDeBa8BrKjic1
	3XY2iB3U+xPSpPhpAp4wVvZBE3oDKrFnuu2yyoEIGMhRgskB3LrP
X-Gm-Gg: ASbGnctRSq1N4wEwRLOtzJhvhP12S3qDaQX64TvfVpLMJ+QMS1G3YSBfI3GlwOACwv2
	v5zxAVW4KtTX7E6AYq1tYxjG9maGsoz1Ci6bFAFaKPe1YCIK8LRZN3yaWuoTHDJzvLOMFmx63Ok
	dRl+EWH6wEyjnrD0HGnh7JI/3My/9gp4QqWKguomIJJUGcrpXdtscvcES4fmLBueG6sCERXMyyh
	GgwHBHxI85bI0hBEhz2ByfCkmoVaNxOa6S8FT+VbTD+a6uGd3GRrpUWC/5qugzxrcw8Efq/uw7J
	SECP8OffVCNdMVufRUCkF6UrLwuy8WsICbTB1F8a0CrHsyxXNhaPPYJ0cqFGfxTKd2EQSZDk/aO
	q4xCrUsXfZgW54tNB9sidFQ==
X-Google-Smtp-Source: AGHT+IGxXevDtQdSFbDZHtjF2RHmeqCAKr0zaFPCSHEdfmgNst33MgVmH/JXly1hqvsrRFBXTDuyMw==
X-Received: by 2002:a17:90b:2647:b0:2fc:b40:339a with SMTP id 98e67ed59e1d1-301bde60960mr5555739a91.10.1742403012272;
        Wed, 19 Mar 2025 09:50:12 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf576bc2sm1863641a91.5.2025.03.19.09.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:50:11 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 00:47:29 +0800
Subject: [PATCH v4 8/8] ARM: dts: aspeed: catalina: Enable multi-master on
 additional I2C buses
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-potin-catalina-dts-update-20250102-v4-8-7c34b8139014@gmail.com>
References: <20250320-potin-catalina-dts-update-20250102-v4-0-7c34b8139014@gmail.com>
In-Reply-To: <20250320-potin-catalina-dts-update-20250102-v4-0-7c34b8139014@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742402988; l=1008;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=jtqICxpttL+081MeVsrW0PF8g0r+obZJAZMWsooXIQ0=;
 b=x6Gzmnb1MJYvPzx8ZwKN1PgPtzH5ZXo5LlnNEMXuS0IyPsgHR2WVwVGglPj2osLT16/A3QCp2
 K9s+FG9+ciTAQDpvzrXkOqQ9lzlBFMDWvik3mUz8hcRRxrN+hXsLbaH
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
index 573701bb7fee..c11de5a61912 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -800,6 +800,7 @@ ssif-bmc@10 {
 
 &i2c12 {
 	status = "okay";
+	multi-master;
 
 	// Module 1 FRU EEPROM
 	eeprom@50 {
@@ -810,6 +811,7 @@ eeprom@50 {
 
 &i2c13 {
 	status = "okay";
+	multi-master;
 
 	// Module 0 FRU EEPROM
 	eeprom@50 {

-- 
2.31.1


