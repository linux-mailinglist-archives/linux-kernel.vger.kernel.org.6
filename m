Return-Path: <linux-kernel+bounces-354749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F37E99420F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2BD2907D2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6531EABA2;
	Tue,  8 Oct 2024 08:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AL1uiv3l"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269051E9096
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 08:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374536; cv=none; b=c2wHY6AU6wiWFgQdNY/zpp8afNVqF/wdZ1+5RiUKg2/uIDRjAPh6zolTvJ+r+UzKYloH/V1DBgHdY3rHb1z7auhyJuFKKlvVUhOGLNr+Y6E40oZ07OrhUUKDYRJlOaXuzVYluahBJ7ghH97ak9MPGo1IrUkQxqKFqyBahl2vjHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374536; c=relaxed/simple;
	bh=7VehN6/sA7scoHVq/2vjZajmO4qxvPaVz+856WDXYgU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=kIU59sz9X289b1WJlVNOBiuCvBGtAxUopNc4wz4xUyqcUazmfuHuvFloycYBKhXj4rSnJUIEOdYPrZ/7B9V52JI6m9r7kYiXjFpHs+84+usXgvZrflbjxIJboDgQ6vmtHs/YJfswn2+my/r5XKYufDSfM1UnGp70mWOek5sGPSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AL1uiv3l; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c89f3f28b6so7670356a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 01:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728374533; x=1728979333; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASSyEZaEK+fjzPx/loN6jK2Ph/Q6/tnmWzvvgqi9yto=;
        b=AL1uiv3liwgRg4LmXAS1T2MGUjO5tjfLxkMCrHZ2uojoAH+oL1KK+YohU9R75inpyg
         v6c4ZvGl00vbPRRyB58ZuXAIksv4hbpe09gSzMfQZFgAisRnW+WO9WOll3L0IxFedz7o
         NlQxua/xAVrhLRuiI9IId1w+KzjeU59abOiQeYCZEcsFSZDp3fN2iKgNxe/321EyTWaL
         lyvMRUB83TVty/dTX/T9Fz+v8NLaGOQfyqJ/DTkfV8BRElSQAhBgLYIy0M07EXHL7Ysd
         VS2bMtjGLpvERPTv18g9I4BbF1olCxvAkUSjhkYxyp/BbtyuXjR5owd9LH6d0DSZrvop
         YXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728374533; x=1728979333;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASSyEZaEK+fjzPx/loN6jK2Ph/Q6/tnmWzvvgqi9yto=;
        b=ad13pyrLkyZRcRIsft4QZT7VvzkjKLPpbhBFLTU9LRteJ1dyhIvHc7oV722TTy1HoX
         in6i0P4WtiqmBZ4xLBTBn5mJWnQvysnUvOqutsUSYTZSP1m6IHbIUF2YzsNE2Sg/zmQM
         XeXlC4cEnGnXh2T11mrQFBToqzWzN+xv/f5xhHN8bVjuGM7vGwb8AcwV+z5FRipN0+DZ
         DQtazMjwLorYPs3Jvcl/EAEWLVF8PWsR+qXTD+y7eDyHufYqb1o2AD85wG1olWcnMcHb
         nvGR/S6jUn/XFaWD5WvcJr+Q4FZoN6g31B+Ym8ch73YyuUElpPCSLcsPDDsWgocTs/vw
         vRjw==
X-Forwarded-Encrypted: i=1; AJvYcCWBXSL/+Xd3SJvi/ws8s9dlOF80l8a9cKjViqwAlzx76GxjMbw66xutB/zvS/KwGIlA07yQBkQh3eemVvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi6KryApExn3z80gyZdfhDeSQKye9lBBPSRF7UDW7kJDhV1rzz
	RC2R32p8fvMQ5elJs+RbaFJeraHJ4fGttH72YKctIpV9F4tagDXm
X-Google-Smtp-Source: AGHT+IGkp0hHD6UVYzNqnXUxluHgElIZySQvi4pC+lBzmHcz26wsCD3h182nTDZ82oFp+oBWJUqAyA==
X-Received: by 2002:a05:6402:4584:b0:5c8:a29f:be92 with SMTP id 4fb4d7f45d1cf-5c8d2e25765mr12699596a12.20.1728374532915;
        Tue, 08 Oct 2024 01:02:12 -0700 (PDT)
Received: from localhost.localdomain ([2a02:e0:9843:5500:80c9:ead7:b605:3ea7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e0594f55sm4054851a12.13.2024.10.08.01.02.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2024 01:02:12 -0700 (PDT)
From: Omer Faruk BULUT <m.omerfarukbulut@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: pkshih@realtek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	Omer Faruk BULUT <m.omerfarukbulut@gmail.com>
Subject: [PATCH] Staging: rtl8192ee: Remove unused macros in rtl8192ee/reg.h
Date: Tue,  8 Oct 2024 11:01:13 +0300
Message-Id: <20241008080113.7005-1-m.omerfarukbulut@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Remove unused macros.

Signed-off-by: Omer Faruk BULUT <m.omerfarukbulut@gmail.com>
---
 .../wireless/realtek/rtlwifi/rtl8192ee/reg.h  | 28 -------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/reg.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/reg.h
index 0164e006f43e..da48ac7c08e4 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/reg.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/reg.h
@@ -1206,34 +1206,6 @@
 
 #define	HAL_8192C_HW_GPIO_WPS_BIT		BIT(2)
 
-#define	RPMAC_RESET				0x100
-#define	RPMAC_TXSTART				0x104
-#define	RPMAC_TXLEGACYSIG			0x108
-#define	RPMAC_TXHTSIG1				0x10c
-#define	RPMAC_TXHTSIG2				0x110
-#define	RPMAC_PHYDEBUG				0x114
-#define	RPMAC_TXPACKETNUM			0x118
-#define	RPMAC_TXIDLE				0x11c
-#define	RPMAC_TXMACHEADER0			0x120
-#define	RPMAC_TXMACHEADER1			0x124
-#define	RPMAC_TXMACHEADER2			0x128
-#define	RPMAC_TXMACHEADER3			0x12c
-#define	RPMAC_TXMACHEADER4			0x130
-#define	RPMAC_TXMACHEADER5			0x134
-#define	RPMAC_TXDADATYPE			0x138
-#define	RPMAC_TXRANDOMSEED			0x13c
-#define	RPMAC_CCKPLCPPREAMBLE			0x140
-#define	RPMAC_CCKPLCPHEADER			0x144
-#define	RPMAC_CCKCRC16				0x148
-#define	RPMAC_OFDMRXCRC32OK			0x170
-#define	RPMAC_OFDMRXCRC32ER			0x174
-#define	RPMAC_OFDMRXPARITYER			0x178
-#define	RPMAC_OFDMRXCRC8ER			0x17c
-#define	RPMAC_CCKCRXRC16ER			0x180
-#define	RPMAC_CCKCRXRC32ER			0x184
-#define	RPMAC_CCKCRXRC32OK			0x188
-#define	RPMAC_TXSTATUS				0x18c
-
 #define	RFPGA0_RFMOD				0x800
 
 #define	RFPGA0_TXINFO				0x804
-- 
2.17.1


