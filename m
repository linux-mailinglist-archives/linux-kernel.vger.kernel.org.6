Return-Path: <linux-kernel+bounces-398068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1993B9BE4D6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B5D7B2339D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30D41DE4C5;
	Wed,  6 Nov 2024 10:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsccR76I"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52F41DE3B2;
	Wed,  6 Nov 2024 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890242; cv=none; b=lS0yq55eaA+Xz7wk42rziMvoQgi49QlIuRbOK3v4NyktUdlR0IV2O3svKQszy4sxVAkxIpIuU68pP8DXx9g5xVhM5ajBF/N8UQHNJtilkEMuMmJcjT9hL4h1Xy4gCrOQsx+N1wUkwnnKL1DhpkboayI1vTJbo7zUzmDRAiFMFIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890242; c=relaxed/simple;
	bh=enLWSo2YXRAv+ZqWC8kAIoUZxolAeWHZx8LOTN18IhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Oj8Rvi989mnIL8a7NUNRzJafewKU8GvsCJt6cbCXVm8Y2SQ0Br3COgc76vEAFwfYJyQnFIPbOiSIsHbeZJVyClx4rO8K+oTactBqQUx+KLvCFAsQeoHxiL+9syTOhkRPTZuVbUv10qKKjpcnbNoxrhj13NC1/4UTNQ+K1vabYvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsccR76I; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-720b2d8bcd3so5286816b3a.2;
        Wed, 06 Nov 2024 02:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730890240; x=1731495040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2QtLjExH5AoubN8x0Zn77So4C3gTd16bi72kzG07/Q=;
        b=HsccR76I1HZGg3KrxFKByQ0S7j2xk+NrY57VC+UvswE04xFHQiiLvHdK6lGGXvwT+e
         63XBZdREBcJIxMOjBN2R0cc8agRINoiwoiPmXKv4tglVUvR0ADQSFJugdf7jmhg8TBjn
         4eJ5K07jOtTy6xL2ZlLdxGy2HrIOtYVv33sXrMSOjzrduLGlgk0hrctoFGh97IQpHQDb
         Lt3Sh7l19TK5a4xc8xH7qaFS57xqAr59xVP7D0M3XiKeNT++eQhsqWokGAQJ36rgM6JK
         3uQscGuCtLchWUrD1yIadOSmZKdVB1lXIoj9etgy+LW2/7Q/YBoM9N8srwahM9tK8IZm
         7Ndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730890240; x=1731495040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z2QtLjExH5AoubN8x0Zn77So4C3gTd16bi72kzG07/Q=;
        b=d0RwrWUO/qeFgsWpEnknM3N9TXKReHiaBVIszi8iufrJafbM9CCfyMjFAp8nwQ5JuG
         1EWBgWgDg9EoB+r4kGmD9ykdUoukyO8bxPbLPTsC/2sw2qg5dObe98mAqldusMQyp0Bx
         o1ThrGtoty4PRyrbQoxVQirqzd4ZADJM8mE//tp2HmH16n6tiPIQMWVg1LE+R3tGK+r6
         KaUUbQ+WKxN0ye0P2Hz5hy30Tl5Hevr5WeEhcCClFkgkjZXrDJlDMeIxQkKbNdt4jld6
         yf2FOyAWOO0Gxh29fPiMvfh2d0b67sQuvZmEPz2cPF211y/KdfRL7sL4fCopF6guFGKe
         Gipg==
X-Forwarded-Encrypted: i=1; AJvYcCU5fuRtJP5D4NRfL+nYAh0ufzbA+tJ4J2JHYVhZA0MfnbIVKZbw0XAquy6cOcQTrcULBfmCtUW1pzU8GRs=@vger.kernel.org, AJvYcCUn5jJAkqcVJJNVsizeptYhuDUNDL3XZDSrucyNRUk+Zodw3thf+NjpPgwK0QTaHt0kxDsFbQL3ixzY@vger.kernel.org
X-Gm-Message-State: AOJu0YxLKGsVhvU38K/+Db96fLbSG+yjNmH1qr+u3OBwwN+BcA5Y9yTJ
	YL4tapmG7VjAIStdGRcYY9NJlsxwNNvfOw2NvK4EKbTAFcEHX1jqZTQ7defx
X-Google-Smtp-Source: AGHT+IH70Py1645yPhFYihm+YPJ01Phd4Hf24ER/37j+l5Wz6JMXmAEIJtg1Hl2CYam1jn1+xw1GFA==
X-Received: by 2002:a05:6a00:39a8:b0:720:2e44:8781 with SMTP id d2e1a72fcca58-72062fb82bcmr51199352b3a.11.1730890239950;
        Wed, 06 Nov 2024 02:50:39 -0800 (PST)
Received: from localhost ([2402:7500:579:df4c:d854:3b57:31f1:c2a7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee45a0dd6fsm10770077a12.81.2024.11.06.02.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 02:50:39 -0800 (PST)
From: wojackbb@gmail.com
To: johan@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jack Wu <wojackbb@gmail.com>
Subject: [PATCH] [v3]USB: serial: qcserial: add support for Sierra Wireless EM86xx
Date: Wed,  6 Nov 2024 18:50:29 +0800
Message-Id: <20241106105029.338457-1-wojackbb@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Wu <wojackbb@gmail.com>

Add support for Sierra Wireless EM86xx with
USB-id 0x1199:0x90e5 & 0x1199:0x90e4.

0x1199:0x90e5
T:  Bus=03 Lev=01 Prnt=01 Port=05 Cnt=01 Dev#= 14 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1199 ProdID=90e5 Rev= 5.15
S:  Manufacturer=Sierra Wireless, Incorporated
S:  Product=Semtech EM8695 Mobile Broadband Adapter
S:  SerialNumber=004403161882339
C:* #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=500mA
A:  FirstIf#=12 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=qcserial
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=qcserial
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=85(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:* If#=12 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00 Driver=cdc_mbim
E:  Ad=87(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:  If#=13 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
I:* If#=13 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

0x1199:0x90e4
T:  Bus=03 Lev=01 Prnt=01 Port=05 Cnt=01 Dev#= 16 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1199 ProdID=90e4 Rev= 0.00
S:  Manufacturer=Sierra Wireless, Incorporated
S:  SerialNumber=004403161882339
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=  2mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=10 Driver=qcserial
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
---
v3 changes: the entries sorted by PID
---
Signed-off-by: Jack Wu <wojackbb@gmail.com>
---
 drivers/usb/serial/qcserial.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index c7de9585feb2..13c664317a05 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -166,6 +166,8 @@ static const struct usb_device_id id_table[] = {
 	{DEVICE_SWI(0x1199, 0x9090)},	/* Sierra Wireless EM7565 QDL */
 	{DEVICE_SWI(0x1199, 0x9091)},	/* Sierra Wireless EM7565 */
 	{DEVICE_SWI(0x1199, 0x90d2)},	/* Sierra Wireless EM9191 QDL */
+	{DEVICE_SWI(0x1199, 0x90e4)},	/* Sierra Wireless EM86xx QDL*/
+	{DEVICE_SWI(0x1199, 0x90e5)},	/* Sierra Wireless EM86xx */
 	{DEVICE_SWI(0x1199, 0xc080)},	/* Sierra Wireless EM7590 QDL */
 	{DEVICE_SWI(0x1199, 0xc081)},	/* Sierra Wireless EM7590 */
 	{DEVICE_SWI(0x413c, 0x81a2)},	/* Dell Wireless 5806 Gobi(TM) 4G LTE Mobile Broadband Card */
-- 
2.34.1


