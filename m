Return-Path: <linux-kernel+bounces-434472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606A89E674D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0236D284AB1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 06:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421271D63E8;
	Fri,  6 Dec 2024 06:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYGaQj/b"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC7813C816;
	Fri,  6 Dec 2024 06:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733466527; cv=none; b=dDA2HPLqL6rDvgL/u5FB/cB9aeLHoRaKrDjxfF4jqOCM5eEORgN67xWO682njXClgMjzLo33XJAeIjQYNKjKViJuudhdTQWkLfng9u4L74myjJwUPkqvC5XLbR36JSpYxHmEO/hpapSUF0vlkToXlwKfu1PS8isY3WT8FdTO6xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733466527; c=relaxed/simple;
	bh=ku2GDyfP0I4a3ChkgQTl2m4UxEP/9euymMyhGZ8Qq6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hQLs8Gv55BhFlVUZ4DH69lwmdwg/7aelrwToNUx5FrR59aApab13GTynweiE3a75QSSVtIhBiSlLICPosTILBbDX7YlZ6Xa3aCkqEGHDRQ4L1i0OzfGEAVQy0WJse28jTAC1yTYaP6S64OSqJWSRlTDMCCJ9a2tr4qCuMdGQ0/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYGaQj/b; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2155157c31fso13281465ad.1;
        Thu, 05 Dec 2024 22:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733466525; x=1734071325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l0H6wnCNakC8ef4Sgz33EY7S2rn0hXbOGHGBAe0xGoY=;
        b=AYGaQj/bE46iJnG5Croa3b+h2TJ60BzXYQ7/h4NC4VkCdH92FQdf0X3Brv54jJS7FD
         Re3aKwc7YdHN1zF96QgXlYORiYoyRvVGHsJbDT6vQ5R0VlzFMDRFUtvFyT1YLp7kEh73
         MFwameai1z8QxgdSdHSGCzyKiD8OnFppfdw+TdYpu8yrejbJG3a0+JiCxnQt0mb48jDQ
         EWPsbuGeUO8wpd2v1vBVdn4GnRYVRQVtVvkwlN9F4oJ0SK1QW8sH/z+BXZoaFAvLKwLf
         itjrTub/+igItsiykbvGpFU5du3yQWyZe4sBmNgQXF/v+ZR7DNcVRo9qUshZxTu5nbVw
         gpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733466525; x=1734071325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l0H6wnCNakC8ef4Sgz33EY7S2rn0hXbOGHGBAe0xGoY=;
        b=MQT+zGkXe6Y6A8mOLVAVksqUFK4xyX+xshYm2jf8MxmrKu2XUxYlC5548HaBy1k/PM
         Zlf0YL+pHifjncI277XQNYBx3Fqx8yAZEoIRG5OghakBs5g7htaS9bYapPqp4MNSGBNr
         6SYZlnc7viMLHypvlsy44tzooOqoIj0bU4cVPLWN5KwN0xT6nwUKmKK0bnpY5zZm15WX
         CETWC/Miy2K9GVsoY/OGA1F3FeC1YZoZnAUorR8uJSSwMQrRirgJf9V0REWgxD50lz1j
         hGAo53sLPyqxCT49SRNMCoLH8ZQr/bUboEO+0ELEgIHhT2i8R+KhijO/MXzHR48AS8Q4
         Bskg==
X-Forwarded-Encrypted: i=1; AJvYcCVO7QY3bOxF1Yx4rQN61jVJ1KyUPxqGg1+LR5xn/7Jwjd5LIDvvHeSIUXWitKFIdkFIFW7dCoDwpN8uoEwZ@vger.kernel.org, AJvYcCWrpDT/UaGzW5Fk3phFcOnHALB9Cg6PL7YCwkYPZqvrk9FGksKIgC7zyN1IIrbNUhlkbAoDKVu/1Z63vA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxX9j9TtAW9gkn4pC6ikxUSCI8oKRstDCzgZdOwYkvFRT9OUbNR
	WYJXxzk4OHkuUDhZCxsS9MzgwEmY/yimEq7LmFXh06b8kRNjTFHH
X-Gm-Gg: ASbGncs6zn27GYqej/F0e5MG+IMLLdoOJMCr9lmJX348qo4m1kQzq0NJYcRv2/gY05J
	UalVNdh4dkZzbbZ0Bz7SYlxnTIwT1iO63/gtNQy1yw8tTQ8A9/pHObK+ph6cp9pbNMhsm4Txt7g
	A9lNlNp0f7630gqZW1QKilzFqNda3b1ez7/ApvWJ/mse4q84dT47r6HLskwHVFNbPk08LasxXrg
	hAxwqdfZYfq/kqO4Z7E6EH8YqJ4KO2M46K7+1YC5HtcQOIwiAsqrTU=
X-Google-Smtp-Source: AGHT+IEynxMlK7XFyqJw2A+uhIBlT5Obz4BprLBL5iELA9B/m000mUOYzDOZzAsT+E6QBVEAVgNT5g==
X-Received: by 2002:a17:902:ce8c:b0:20c:d71d:69c5 with SMTP id d9443c01a7336-21610821347mr29971235ad.4.1733466525453;
        Thu, 05 Dec 2024 22:28:45 -0800 (PST)
Received: from HOME-PC ([223.185.130.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f29bcbsm21889075ad.262.2024.12.05.22.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 22:28:45 -0800 (PST)
From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
To: jbrunet@baylibre.com,
	linux-hwmon@vger.kernel.org
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	linux-kernel@vger.kernel.org,
	Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Subject: [PATCH hwmon-next] hwmon: (pmbus/tps25990) Remove unnecessary call
Date: Fri,  6 Dec 2024 11:58:39 +0530
Message-Id: <20241206062839.313292-1-dheeraj.linuxdev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit addresses a structurally dead code issue detected by
Coverity (CID 1602227). An integer is returned early in one of the
switch cases causing the later statements to never be called. The
return statement is removed following convention in the other switch
cases.

Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
---
 drivers/hwmon/pmbus/tps25990.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/tps25990.c b/drivers/hwmon/pmbus/tps25990.c
index cc0f5c7cecb0..0d2655e69549 100644
--- a/drivers/hwmon/pmbus/tps25990.c
+++ b/drivers/hwmon/pmbus/tps25990.c
@@ -130,7 +130,6 @@ static int tps25990_read_word_data(struct i2c_client *client,
 		break;
 
 	case PMBUS_VIRT_READ_IIN_MAX:
-		return TPS25990_READ_IIN_PEAK;
 		ret = pmbus_read_word_data(client, page, phase,
 					   TPS25990_READ_IIN_PEAK);
 		break;
-- 
2.34.1


