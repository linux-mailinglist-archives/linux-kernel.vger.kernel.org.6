Return-Path: <linux-kernel+bounces-537768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E152A49063
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 05:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328BB3B362D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189641ADC75;
	Fri, 28 Feb 2025 04:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MI8smE62"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8471BC065;
	Fri, 28 Feb 2025 04:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740717169; cv=none; b=YRBLSU2pgR4AoI3YyT/htKb8kNJmp3fJs5g2Y8RokXGt070LmWDQZyEdsjvF45ixauvl/NMfIPf12JLTwNI7i/kkAowBDG8btzt6UdXwuOtl2Ui6FEbgcvcuVgvGRiROwI4/C7hHhAdTFkOWIM42tfsmtaOTRgeJZfumREI2+YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740717169; c=relaxed/simple;
	bh=vmNWEgr3rWQ5P/ADNnC/vtVzmlsIMI6tVOmt2QheHbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nYNh0Th1hkPCmRZsoeVP6QS7a5UDxqAUpVB7CZv+yPuLigVzCeUTfe61Sb5XmeQ95TjzMNUxqIv7FDSv7FPn7ruMHYU/FA3GtCLpIJbUisKRYSXVRw1Q+5BWd+pNyZRMfUj+XoYIhSdJVeTXr0NdlJbyV58z34jrpmeQo6zenFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MI8smE62; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22334203781so41686975ad.0;
        Thu, 27 Feb 2025 20:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740717167; x=1741321967; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGQwHVv9o7q6RnxPf9GZuF8RZdvh224WMDjiUjFtGtQ=;
        b=MI8smE62fxWrU2IwVKjA6n+l366/k43nZBM6pjcTTsLW0ttcI4B5NTgG/G9UC8xSXW
         JIC4VuyRcnhAfxOn6KPReNpnzY/8qKJtAKfo1Bzh9c9RHGZRUzg1zZCr+6VJ02lWXONq
         i9Bc71lNQyyDGCuHw1ImIe5R61wurlIeVOjFqyhg1ZhX2Vadu/kiEYLsLnF6utWv091A
         9w9Vl2iEdt81tkPViV7Cawjq01NV2J89Aj3gqR3tV/8B9lS0vEtlHLXJvEptyBsWzpM4
         57s3OFoXqQ1NUrOGZLY5qgDvGDtHlorvDNoZhbC7phzf1aiYB7swa7O1Vk5oYzVeQwlv
         GgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740717167; x=1741321967;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TGQwHVv9o7q6RnxPf9GZuF8RZdvh224WMDjiUjFtGtQ=;
        b=HvEfCkyxtxcIGfcBg9NuH61HoaQRu6PhAd0g77AuWMZ5JBvd9sZUP4qWx7LjevNJf9
         BhL2926CobIDGCz2LfB3eKmJHM/wti4SJRAPfomaJ4rZ/yP90667qUyMQPKuuMmg4+Rl
         rgDenygzL3zFcPCdW2MnEObxgi59KaXkPWUhXeDa9/xjaknZp28B4r3dA5y4w1q33mhI
         QMxaeqWtuCiz44BzFTTCPiunjMZvbdHwWPGDGMLRU/ohmQTwcYVlhLihfvb9L+ZHt7WX
         0EvY1KtxQSLrOCTXvBNPOPFNSAh6DH7q7oLF6ppzIvbdeAJj/7mQFWapKjjVYmeXdhVa
         2QFg==
X-Forwarded-Encrypted: i=1; AJvYcCWEhyHlsMx4DRWT6gfpkLoRyzk61t9VZrqKq0dakdOj4rrHFtB5O/w8yYHV8vczKp0Ppes1Da5JZUqN@vger.kernel.org, AJvYcCWuIrTRl8gYhdg20h8FQgXqksKghOnvJhw65WSZbWEt21IJrx8xwgPYnT0zd+EL5z4MrlqC3MDmn5CbJj13@vger.kernel.org
X-Gm-Message-State: AOJu0YwMEuohg7ajhiPv4uSwW9uu8f1tKZ0VkbYb8Ke8Xr88U2A2LbKC
	MhI7wNcoRhkJ2xDnR7RYF9a67siVC/nwSHwn8GTu+TJNPajGL1qy
X-Gm-Gg: ASbGncus6EkybHUqqauFP2+UdTogjCpI9wG//qlVcHBcrVZ1dSjljzPsoE016cwHg14
	Vc8XrRnP2JZk6gZ7Azpsrt0Kl8uTtmxTBOewMFHURpTLyOAU7L1vfv+UZ5Wb5zEytvX2uFIdEuj
	M/8Sno4CvlEH5mKTkaw/bJ/MiIvr3Oe6NvVYQeHslR5vTItlVAZGyIEaq8+h6BTS0zezTBbAtpU
	fKOiPX7jg86LPc57q/p43ZMtVinFP79VGinlGAO2SeR+KztAu2TonLhrQ3x8GESZnzm9sPqqrbl
	U8Apohj6P0UcPI0Y1yu7cejeMDvKfc0b1YZn64uF4i6uw9Q=
X-Google-Smtp-Source: AGHT+IGdqGiYiPdIerWjEeRPZaQx290tWlUUMzSZCFp3qxHZqw7PvtgopI0dx2KaRwGhPRKQ58mphA==
X-Received: by 2002:a05:6a00:3e25:b0:732:6276:b46c with SMTP id d2e1a72fcca58-734abf1957bmr3901217b3a.0.1740717167163;
        Thu, 27 Feb 2025 20:32:47 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-734a003dcafsm2738204b3a.132.2025.02.27.20.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 20:32:46 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Fri, 28 Feb 2025 12:32:15 +0800
Subject: [PATCH RESEND v2 4/5] arm64: dts: apple: t8010: Add backlight
 nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-dwi-dt-v2-4-69e450bc4bfb@gmail.com>
References: <20250228-dwi-dt-v2-0-69e450bc4bfb@gmail.com>
In-Reply-To: <20250228-dwi-dt-v2-0-69e450bc4bfb@gmail.com>
To: Janne Grunau <j@jannau.net>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1505; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=vmNWEgr3rWQ5P/ADNnC/vtVzmlsIMI6tVOmt2QheHbo=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnwTxhPCXsUBLNKB1jlR0unOqoSgScjctNiJtRy
 eumJJoBB0+JAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ8E8YQAKCRABygi3psUI
 JJojD/9vMZhhE3z+GKHF8IjFsnsejUXINwfdWlWe/TAyS59eXAicjPkDXVdP052aQFCYxTRJCVe
 TuViwg/UBc7j9aTOnDTP+Olel2diEOFx37jsPI1/mn9xlld5c4mZ/gq7CFQG2MvYNALS9IP+jZX
 aHRcAwSLSpYWCO3ep32nonIjQ+zKrBsAnyDrCkS5BNo4NkkxkEXmdmcJhpdojFTXGex+6dDD1yD
 WqbnHQteGHty4jDQSkZ3f+I7dwG20kqlobY3PEfUzLBiiBYpqh7+t2RH1tYUjr6Felmt98kvhUu
 DDrjPg2qOANdF9McxbnNQpoGawLlgtzeEUB9RIbqUHCcPk3wycTuOHln65LEzZ/AOnTnOIYoFSc
 YKo6Om5l/YldQNJLOkjucNjNw/H89gMznY3NNzXD8F/aQ+enqhrb21o/AJ8aUn5KhRLgCxPcFgF
 B1r5rumVz3hih+SHeeUq+x2WkyhIikAy08RjVQXhUZXSH5RxdxpU5ebiW7bpckDhzJTpnhMDbwz
 faaefGNQgFpO1ZRx9MhI+3bq/ZGO38QG6U87cTKL1QbNNSojPibYozNXDv87GTXAxk2aHtccDrD
 5wFfjWUks63EdPYxpAHb0MAfDhe1evD6Bn4HP6ZT/E/zA9OsD51iNydcd9mWZDj+NLn6BaDTcqH
 g9dj7ovSNny9Frg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add DWI backlight controller nodes for Apple A10 SoC, and enable it for:

- iPhone 7
- iPhone 7 Plus
- iPod touch 7
- iPad 6
- iPad 7

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8010-common.dtsi | 4 ++++
 arch/arm64/boot/dts/apple/t8010.dtsi        | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8010-common.dtsi b/arch/arm64/boot/dts/apple/t8010-common.dtsi
index 6613fb57c92fffd41c34a61a78e7bb6b1888a5ea..44dc968638b13814baf94e782f2267191ce267f9 100644
--- a/arch/arm64/boot/dts/apple/t8010-common.dtsi
+++ b/arch/arm64/boot/dts/apple/t8010-common.dtsi
@@ -43,6 +43,10 @@ reserved-memory {
 	};
 };
 
+&dwi_bl {
+	status = "okay";
+};
+
 &serial0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/apple/t8010.dtsi b/arch/arm64/boot/dts/apple/t8010.dtsi
index b355d443ee476e7c98b352470e3b1b5d0fae7652..17e294bd7c44c7961cc3ba0ec5f4178840d5b9c6 100644
--- a/arch/arm64/boot/dts/apple/t8010.dtsi
+++ b/arch/arm64/boot/dts/apple/t8010.dtsi
@@ -167,6 +167,13 @@ aic: interrupt-controller@20e100000 {
 			power-domains = <&ps_aic>;
 		};
 
+		dwi_bl: backlight@20e200080 {
+			compatible = "apple,t8010-dwi-bl", "apple,dwi-bl";
+			reg = <0x2 0x0e200080 0x0 0x8>;
+			power-domains = <&ps_dwi>;
+			status = "disabled";
+		};
+
 		pinctrl_ap: pinctrl@20f100000 {
 			compatible = "apple,t8010-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x0f100000 0x0 0x100000>;

-- 
2.48.1


