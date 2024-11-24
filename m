Return-Path: <linux-kernel+bounces-420133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 263549D755D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 16:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEBA6287A60
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 15:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AC71B4F17;
	Sun, 24 Nov 2024 15:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LM9eJA5M"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A6718B460;
	Sun, 24 Nov 2024 15:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732462069; cv=none; b=U5/0LHwWvcdSZRGZ7MkW3YK9+khMUTVvDjcov47CwfDg3jTvMPtM1WIhXaBgm5JC/35KDNra3CYzsubUTnGP5EdNr/t3Z9MnlXMTaL1H2qsILAvZu8AZDt1sjZgCZZFtI0VQYNt2WBTaGMkRsShVLA1j0AJJAnJxWjPl5pkHnaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732462069; c=relaxed/simple;
	bh=qsF98gXILsYZ7Fnjpt+jzFG6W6+ZC1oLlwEAZA7MOrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rM5p2ZUBQIa5gRtP7+piB23RUo5HkHlab4eyKn2pL++TM32GULEImt4lC24owBzLdyjlXLS4B3t64KKWVmAzVahLNJoF+uoZrJDeLnipymlGDq9Z9c00u3xQl5JQbg7auiGmfS+HnC0PVNhtBp7FXnnngSReHgEqgctO691QiWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LM9eJA5M; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa535eed875so171432566b.3;
        Sun, 24 Nov 2024 07:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732462065; x=1733066865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8dmyx+9AXlD+Dj+sQMUrSJhAmT2X85okf6krgQ4cAfI=;
        b=LM9eJA5M6ESGNOkG9qZ7wlZaGFTcBfWSWxuKvG+op8E7NfEZ19EgGPnYe7Rn13dBwV
         lCeQLMnG2Qr4KdCC+WR7lRJT1hjrTkLxdLJuy+4KXx+DLdoLY2lqNpIp/gGacYKydJUm
         wBVUW3geVeTF6yaXJYNL1a6agpvvDzJexCu0QVM8xMqN166GVLaxnRBxfsN7DGKJ12Nh
         m/x/T7feqG7yibAwIgeLvgMx7hU2GI9E4i2vZgNrdEZlyRSWI36IPLJdEqxVsAVNQnJ8
         p1293/n1t+4ItTvP//3gluKduHlIGq17Z9elF1IAo2a53oXIhWgs5/5lPSZay8a5SsVg
         IhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732462065; x=1733066865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8dmyx+9AXlD+Dj+sQMUrSJhAmT2X85okf6krgQ4cAfI=;
        b=WlojjtO8YBWI90HVrocJkyGxA9iAOHKOMHKqJT4keOUAYxwooXRZcJ9BK0RmjYDAlx
         MdcsLnUMxZapDsSrFhbr6lE+IVSlr7DXIQlgqkM98cQ1S/VHLOvegrw9t87pLZ66kTQt
         VPao8HTOBLWAQE8CfAcbmow2j+fhiinDC7sS/TbDH3YdJI2Xa6C0rodDMyhRclQebYZP
         N3odVHlLBSs4GUEFIeUxZkYprw/KhOyVFgxs5I67yutHs8DHVjOEpPaaUtpOiGaUgtGY
         Ag3nP5SmXmWPPNRbzGBHnEpx45Es8ElIHDfgRnev5wvueT8tTi5gDv2BaHG5xPYuoped
         8e4g==
X-Forwarded-Encrypted: i=1; AJvYcCWDB0FFQ9/ZOJXN+qRE+rJXdUDS1CoBucKYjPByO+OhgAHZfmzTdNrk7WLL4y8eqNaxyvy4Kp0YdTVrD8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5ioCfTIO+9Rl53TOH6nyvj6OBEkaDG0ZWWJ+OBXRM4HsDUz4h
	oHnspp0DPr5xHpBte+6HvsRBZfP6qdy+aCal/+jlKD49FwbHN2Y0+0By0LSr
X-Gm-Gg: ASbGncujNHdwZCXP7CJ5X7hfm5pTUgNN1jyKTfLmB2UDrrwx40u8iyDlUd6YH5oDctK
	gTYfEIV2Fi49KKIVC5pbinp15e94ylM58aIECAKUNY+Ych9+dW7eklECU2a9DjLN0GynIzZtQjj
	zW5lZaFdiAML8u38dxN2nYuLsT/OdTVQtm2IRXZ0ZhfKYGr/LQJq2yX6MYzTq+PeEGgyPG90y5h
	K9OK8Fqq+Q74OSl6wXfc0FGL7l7gwL/i/pDBTfT/V9tXbvBfz2I34nODdDl6MZzBLZ0hpQ7Wto4
	fRZYsquBRmPxDOny
X-Google-Smtp-Source: AGHT+IHoDMrc6vLNy2zrAKVbsVjESiGAn40Nzb0Gg3ibdY3CCf0WB5Og+sfo6Ck55TQseUJS46JkEQ==
X-Received: by 2002:a17:906:31cb:b0:aa5:21ad:1722 with SMTP id a640c23a62f3a-aa521ad2475mr603773366b.4.1732462064639;
        Sun, 24 Nov 2024 07:27:44 -0800 (PST)
Received: from fedora.. (cable-178-148-247-197.dynamic.sbb.rs. [178.148.247.197])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa544cfc962sm107189066b.123.2024.11.24.07.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 07:27:44 -0800 (PST)
From: Aleksa Savic <savicaleksa83@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: Aleksa Savic <savicaleksa83@gmail.com>,
	Arne Schwabe <arne@rfc2549.org>,
	Jack Doan <me@jackdoan.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (aquacomputer_d5next) Fix length of speed_input array
Date: Sun, 24 Nov 2024 16:27:24 +0100
Message-ID: <20241124152725.7205-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 120584c728a6 ("hwmon: (aquacomputer_d5next) Add support for Octo
flow sensor") added support for reading Octo flow sensor, but didn't
update the priv->speed_input array length. Since Octo has 8 fans, with
the addition of the flow sensor the proper length for speed_input is 9.

Reported by Arne Schwabe on Github [1], who received a UBSAN warning.

[1]: https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/issues/100

Fixes: 120584c728a6 ("hwmon: (aquacomputer_d5next) Add support for Octo flow sensor")
Reported-by: Arne Schwabe <arne@rfc2549.org>
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
 drivers/hwmon/aquacomputer_d5next.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 34cac27e4dde..0dcb8a3a691d 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -597,7 +597,7 @@ struct aqc_data {
 
 	/* Sensor values */
 	s32 temp_input[20];	/* Max 4 physical and 16 virtual or 8 physical and 12 virtual */
-	s32 speed_input[8];
+	s32 speed_input[9];
 	u32 speed_input_min[1];
 	u32 speed_input_target[1];
 	u32 speed_input_max[1];
-- 
2.47.0


