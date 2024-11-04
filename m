Return-Path: <linux-kernel+bounces-394959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29109BB683
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0249F1C21DA1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6C9433A4;
	Mon,  4 Nov 2024 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJB9QF2a"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D1A70813;
	Mon,  4 Nov 2024 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727749; cv=none; b=K7UrS/RZZ37xO681NxSkpxuIzmqckvQ8lOYeCRd5dXVlkkOTL1a4EWwm0i2A5oZ4ANW8YQOXGMQcxUQJYCjdNsMSVv3Ta3Eb08kSRN9EgWtq+2vv3k98mciOfIZZl8VhpwSisTClhinlmsbDJcc8BR4en6/rnbqcBe0rwSj/4xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727749; c=relaxed/simple;
	bh=sH/RYgeT8EV6l4e9LfxJpQHUCGusAJN0EsCrw0aDSNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oy2eY2dj0tN2zcfip89hKf9aIHBTQmDlQL6z9PKqT68lTpmD0cUVdKr4gQZ2jZNp5t5DXDHdsU7EmbYRL3/8bZNJwahaCbOb0EeWVRGOkujsytg4Ae2bSVnzMqsP0VA0K0iVnYCDl+OxVRzKObcgBic4VyVtBLWUVlvZTY8FQi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJB9QF2a; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f7606199so1788162e87.0;
        Mon, 04 Nov 2024 05:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730727744; x=1731332544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1kfPDrOQyOjZE2CymA0VUU4ashq3llSWs9vw5Q1LzQ=;
        b=KJB9QF2aVrq2cWgJm5ac08UHpSZG6C1QcpOqArBw7tM/Hrf9Vb9qoJUezmJ0dtjWCA
         ozShjOVFqdU/7yraSsoxEDA4UUzKGdC5G9IOq4jfmOV5qrZw9yU4uTOOzdX7U5Vhk9nc
         mdEfa2Xr0dXXZj2c+373PDKl7EljCQSY14gbWGiud6ziO+g3wGmNgemt5r54DVIfdpoR
         c01DXdGTYbQUgdCPyEw2xG299fU34MtmvFhVXdhqwclvWq2jAAMSj023R08rUbXIWEVa
         HJWdbynKWQB75xleGwysN4oXJ9YSJJxu1yno+vGo1RCYGRZNYgdlsgcz5Q+TinZmLO7T
         3M9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730727744; x=1731332544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1kfPDrOQyOjZE2CymA0VUU4ashq3llSWs9vw5Q1LzQ=;
        b=bQOn2QAtLp3STI+fPWRy8itdJT1/AqO06/DjZ5ZmYVPLfbjFxX2BH1Nr+qn9q2t32C
         l8WZRrjaWX6iaEYRvAH21a3MUCwmnx0cC18KIwL8J8yUMLwnaT0m2qooxxaMjf+7gFIn
         YWsntp7PuJ2tWTyyWxR1oyH39V4Ub62VLcq1uLHVrYCcaNlzUJ5NQxYvh+cMVLYe5JN2
         6vtMEx43fQqXX90KZFgTS0TsJTA0xdGQZmCbaMWxr4v1by6a7lVnq2OpMllGC/1lL4C9
         WkAFR1dKbYagS5OB1oidUphShAW0Nc67/wvCDwuI3/KOWL4e6Kt+kqzbVdmy3l5wDQ/l
         66lA==
X-Forwarded-Encrypted: i=1; AJvYcCWj3AwAm4nZmTCQgya5k/dhDiwyLqwmoWv2LTP3fnjr+Ia0W1gYlQfd4kMph/AFn2szvdedvNOr2G8HxR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSORwSeuX4etnNx1P63j1D7tdP9azX7vwdDa79f8EpvVEnjpX+
	mvJheThH+7OywNuXP8JsgVwb5dYxC/R/Qg5RzKKx6GnxmVZl6o2/
X-Google-Smtp-Source: AGHT+IECPa3DlQD5Iey9jB7c3gpwS3dR3RcsFO/RMA/6PkAa50BWJysHhcMvZGpSwJGpmiofiY5/CQ==
X-Received: by 2002:a05:6512:3b25:b0:539:ed5e:e224 with SMTP id 2adb3069b0e04-53b7ecd57efmr9330990e87.7.1730727743820;
        Mon, 04 Nov 2024 05:42:23 -0800 (PST)
Received: from localhost.localdomain (h-79-136-102-249.A137.corp.bahnhof.se. [79.136.102.249])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bcce4e4sm1699521e87.175.2024.11.04.05.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 05:42:22 -0800 (PST)
From: Daniel Swanemar <d.swanemar@gmail.com>
To: johan@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Swanemar <d.swanemar@gmail.com>
Subject: [PATCH 1/1] Add TCL IK512 MBIM & ECM
Date: Mon,  4 Nov 2024 14:42:17 +0100
Message-ID: <20241104134217.3838-1-d.swanemar@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the following TCL IK512 compositions:

0x0530: Modem + Diag + AT + MBIM
T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=10000 MxCh= 0
D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
P:  Vendor=1bbb ProdID=0530 Rev=05.04
S:  Manufacturer=TCL
S:  Product=TCL 5G USB Dongle
S:  SerialNumber=3136b91a
C:  #Ifs= 5 Cfg#= 1 Atr=80 MxPwr=896mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=01(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=82(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=84(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 3 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
E:  Ad=86(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:  If#= 4 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
E:  Ad=0f(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=8e(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms

0x0640: ECM + Modem + Diag + AT
T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  4 Spd=10000 MxCh= 0
D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
P:  Vendor=1bbb ProdID=0640 Rev=05.04
S:  Manufacturer=TCL
S:  Product=TCL 5G USB Dongle
S:  SerialNumber=3136b91a
C:  #Ifs= 5 Cfg#= 1 Atr=80 MxPwr=896mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=06 Prot=00 Driver=cdc_ether
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
E:  Ad=0f(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=8e(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=01(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=84(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms

Signed-off-by: Daniel Swanemar <d.swanemar@gmail.com>
---
 drivers/usb/serial/option.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 4f18f189f309..11b180c07bac 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2379,6 +2379,10 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x60) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x1bbb, 0x0530, 0xff),			/* TCL IK512 MBIM */
+	  .driver_info = NCTRL(1) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x1bbb, 0x0640, 0xff),			/* TCL IK512 ECM */
+	  .driver_info = NCTRL(3) },
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
-- 
2.43.0


