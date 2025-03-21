Return-Path: <linux-kernel+bounces-570825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E9EA6B50C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C36D17BA3F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E151F1317;
	Fri, 21 Mar 2025 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aj6jv61W"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A481F12E4;
	Fri, 21 Mar 2025 07:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742542129; cv=none; b=PMPqk3NcduY+sxCNXh9TDJ1Gx4Gx0mNBrG5GSjKmPfXmFWX2+9s5CO2rb7rsAn5XoQC67q4dvb21Ugax5JW7Wsu6r88GGh8negKvgQE+4pAXkUCcTfNw0JgrG+lRrnCyCHQQrWGmLHB8BdLa6frgH6qWwyR6ujivg02TWX2/RHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742542129; c=relaxed/simple;
	bh=p/QorKJCn9XrFKbtYC8NvQNC1AWXOIPQaV8PshPU3mA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G7pZ3klTns2ZQaGxRWVg6dtpS098lXaG3+St+qPHjp9T9rmCGlnRUc4pWeRbCsZMTnhlqxqOe0gwgRAxuMl8azRKe/S6J2C5sm+Ry2PcySVGNPG8czNkJiLNtdwEDZxHp1HzX8IZnzODyWLQlpERvjPpCDCcT9iCJUrGYBzGO0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aj6jv61W; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22409077c06so4482795ad.1;
        Fri, 21 Mar 2025 00:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742542127; x=1743146927; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6yYy4AbJx68HMcvUd81BZlBUUo2lt5qzF5zCFnIAXP0=;
        b=aj6jv61WwiZZ0fwfdwhKdNqHrVd5nNb0VpEiSqUcL8XUdRfBTxne+DRtMpKZtnXC8H
         xnJfvahIQzwSrstiTSW0RQ4iiNjpRR7m00ClJ6o+KqBDpIwCMFxrb5lO/FN4L9+zeuZD
         0SGnm58Rv7Mn2Td5RYvpx/k8EREMGVLao3QYOvkqjhkWMJYNjSiR7jOGO5135bFrWdKx
         UQxLsVi/e3NhhynvxbrGenxmzS/50JhkuKD3MKWp1rlQ3R5qhFpMVYerDvXr2ugtWQc+
         YlGJwSx/rJUGQaJkea8Tg+OoVSQTkpfgeB8ZaI1wD7D+Ad6QYX9pbmcghIdMfou3WYwy
         BVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742542127; x=1743146927;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6yYy4AbJx68HMcvUd81BZlBUUo2lt5qzF5zCFnIAXP0=;
        b=qMCsE3G1uq8sQNNi15StKpF6qsCF5dEXHMyWmzgj2luREXzyl2NTdQQYrwY5Z1hPDQ
         lD83Gnb6uqkIIMH3j4f+5MYISPpwt4J13M3HW39cGNnFqmvuuUJUIS1pbchdmKN9zvNW
         OTym8mjzdBXKm+34hiEyehuoZHjJYl5tZ4J1F++QB7wdNwv3Sogu7F6SVUuFy21tilXK
         Kbxa9yEngbTnCT6igfmpU1glKQqNwoKVuKXrKn6wsLufJemH/kVUrNkSZjee+gae5E2N
         02BWcMr9CuMGnFO1fckeGNQSkHKyZfGtA8CHT9gYSwQz59g0Gf+ZMQetTFtgh6GCZdEO
         BFIA==
X-Forwarded-Encrypted: i=1; AJvYcCUiiO26mAmKfSN38bm9UaGsVx9+GkbINn/U7ThWPocbTFhio7+7LoexnxXLHaKKR+agyG4R0LCpbD80k4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0qdZpkKYA/KIbsyn84kE5nYaKguaqzss/6lpprOG9jDRTa7c+
	KQoFHfX5PI2eZFxoX4z8E+/d8WrVlSOixpn97S+MmUkly19Yz5oL
X-Gm-Gg: ASbGncvGnVgyk/miYvN3k1IMqPPBJIba1fFi868GAp1hLdG0c6Nrsxe8YTQGP0re81W
	qNQtrupq7gPSfqpNLSnDh4kObpWuT33anWzH+WBJDybfCKOWIt1Nvw/N40yXXomfhJ0JtlV96I/
	meaSZ2Y73DEOGXWrEVPScmtKkUzXl1WXCPVygPri8t5mEMB/7RctSGd3pSERvOHgWWJHEmeKP7J
	8K0sKY5m1pd1CSXGgZ4y5xVvLC9jh+oNkgBbyfHGAr9rJIMZJUhFLTw2/V6n/2jNXl0aMrsk0Rc
	cvZ5EpQZNFjqXqZ9WMWRXs2bliDWoioqx3y6ZnMWmI4f8BP7iUXuSQH06aWvc2d9Lz4cJ3QWdzY
	tGNmPwTDP0SeHFUSrI3OnMA==
X-Google-Smtp-Source: AGHT+IFz7z9DTULNmP+oLx3nWMYzi7RsllXSFyhzZAy2FVTHB5ZXzxdUyhyyOFfzLur+HYKAMXEW7w==
X-Received: by 2002:a17:902:d2d1:b0:224:24d5:f20a with SMTP id d9443c01a7336-22780e231a1mr42741185ad.48.1742542127003;
        Fri, 21 Mar 2025 00:28:47 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f396fasm9862265ad.27.2025.03.21.00.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 00:28:46 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 21 Mar 2025 15:26:09 +0800
Subject: [PATCH v6 08/10] ARM: dts: aspeed: catalina: Enable multi-master
 on additional I2C buses
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-potin-catalina-dts-update-20250102-v6-8-4bd85efeb9b4@gmail.com>
References: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
In-Reply-To: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742542103; l=1008;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=p/QorKJCn9XrFKbtYC8NvQNC1AWXOIPQaV8PshPU3mA=;
 b=hV+DOjonfukNtIa7vGCSR+jzs82NRq4/way8tjyiwrTKrV6clGwwNua5InfHy7waqGTVFHXvK
 faEslXcUhw7DyXaYrSgm5Z7hz5gKtrp0n1tFujFjX9XQSfpXo2jPHzU
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
index 6702be32918e..2dbb65db9250 100644
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


