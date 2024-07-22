Return-Path: <linux-kernel+bounces-259162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C1E93920A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A861C216DE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC4716E88B;
	Mon, 22 Jul 2024 15:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="mIV5IpPs"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0362C134B6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 15:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721663222; cv=none; b=cuTNq4SMffMeJUjqEpAaa/BWXpLh3RTxWUZsEycL4xURHdQyQrYFOptBQRRE4raSD0X9KIPAtDx9zMVZ066259z0vdumw4FwwL0G3xpdpKFzG2ZeASgZmMLle4kp+tt5xhzrLnhheSyw+8omb28wvc3bC1weXyEbq5ZSv7x1h5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721663222; c=relaxed/simple;
	bh=BeLMWibimfFzBPoanEeoNm7JK5WFtArtOTr7BFhDoho=;
	h=Subject:Date:Message-ID:MIME-Version:Cc:From:To; b=Ph0Km4shsWIhz8m3HAlCMEJ2u8Ose/xN1PzHx9Jq+NAXRx6YT2a+dJoNnfdoH3/R+kdJ0emoZStTV4HlJaDo2gKA7mm3WPMxQEODd5Hc6hlKni/j7pSW+mQzBMDIco68WX2mHqxjmmNnn7s2vegZKY4SZ15pE/k5wyaBY2wqyz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=mIV5IpPs; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc60c3ead4so28904015ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 08:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721663220; x=1722268020; darn=vger.kernel.org;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=qFsD8P56tt4tzwUvq3CqBdSHL92rhAxRHlnzX+/Z2KY=;
        b=mIV5IpPsSu477EyoSrmhwmVB8oaqz6VqXy0O3UHavj3r273hyBd1fe7b68JRALNp3x
         EPyqkItesadtptqcTY34lUgGqLW2PodBmAGoU4rEQy9Y34Bc3hz98mcPM9T6P13F+GMm
         rYnJu5WpPmjL3V5jj6n6ymiRui2iigBRIimJhsKaYPzeeJx+tQ4VnyspuBwSoGGqbqw/
         MlO4nUuTUycNl5yYffBMQWcezCP7irdo0Fqsr94iEQCvZ6x9ol2LyH2KGbtUUfk1nYyW
         YN8IOaY3xV/T9CpQF04Jhcahd95ve1hIeiuctXPPwOSuOFH01WzjJrE/re+zGx+kLZif
         r6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721663220; x=1722268020;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qFsD8P56tt4tzwUvq3CqBdSHL92rhAxRHlnzX+/Z2KY=;
        b=c9Z+cuoVMXOf9a5bgYyBiSSzkAW4HRNhYtg4Qdzfn8m8X/0UwjMS/dYQRb4teO0174
         Wo674SrzcBK/k2yN6Q8pxlyBE8qD2ZoNPeVEf6p6OQPYmLu8Dnp7q8XZrDShiZfJ8D9z
         YDVpKq0bw82rSJ/gnwQzu4UeBU+8C14Nsfiy40oTZE+bZty6r9PaXe81Pl8IO6OKlB7w
         yMMwIDtZqWHmBC6/8R0ZxOJBkf7JpR6byzbZtcEWjomEI6veHcmTRXTDCYaGX/to4z5v
         zNXyt55IVGOAYgl18HW8ym/WTpJ6jdVPqbsDsC1LyUVynPX//38ZDMPywQtqV7LnOwTr
         Fyxw==
X-Forwarded-Encrypted: i=1; AJvYcCWO29gWJwMaw91pkO+PiVRXsJz25fFlfbO73woH3xRcxVXvvxFhroRJrWb6Vm2wyBj/Unv6WMM2BAsDveCIgQJm9QRq2G9rAa6UaTBS
X-Gm-Message-State: AOJu0YyFZsaaNWR0UOQvw/tsryrcf0cTpkdr8sDpU01BQHhIrUUiWIMo
	2KfSVnTDpkImMbKaQwO7QChnWAlZ9c47ZaqAGx3EbJVOmzmRAk6bKo/gU7K2peY=
X-Google-Smtp-Source: AGHT+IFPGavVgezBjaiJSW9/MTpsmyBqfw6HVevGo8Pxdxe7DzmjhIH1eDdDiCNeVyONE21ZhTaYug==
X-Received: by 2002:a17:902:ec86:b0:1fd:88d2:47f6 with SMTP id d9443c01a7336-1fd88d24ae9mr36782385ad.38.1721663220183;
        Mon, 22 Jul 2024 08:47:00 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f25aa4csm56031345ad.30.2024.07.22.08.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 08:46:59 -0700 (PDT)
Subject: [PATCH v2] cache: StarFive: Require a 64-bit system
Date: Mon, 22 Jul 2024 08:45:20 -0700
Message-ID: <20240722154519.25375-2-palmer@rivosinc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
  Conor Dooley <conor.dooley@microchip.com>
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, emil.renner.berthing@canonical.com

From: Palmer Dabbelt <palmer@rivosinc.com>

This has a bunch of {read,write}q() calls, so it won't work on 32-bit
systems.  I don't think there's any 32-bit StarFive systems, so for now
just require 64-bit.

Fixes: cabff60ca77d ("cache: Add StarFive StarLink cache management")
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
Changes since v1 <20240719163841.19018-1-palmer@rivosinc.com>:

* Drop the STARLINK_CACHE_ADDRESS_RANGE_MASK chunk, it's meaningless
  without 32-bit support (as Emil pointed out on IRC).
---
 drivers/cache/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
index 94abd8f632a7..db51386c663a 100644
--- a/drivers/cache/Kconfig
+++ b/drivers/cache/Kconfig
@@ -18,6 +18,7 @@ config STARFIVE_STARLINK_CACHE
 	bool "StarFive StarLink Cache controller"
 	depends on RISCV
 	depends on ARCH_STARFIVE
+	depends on 64BIT
 	select RISCV_DMA_NONCOHERENT
 	select RISCV_NONSTANDARD_CACHE_OPS
 	help
-- 
2.45.2


