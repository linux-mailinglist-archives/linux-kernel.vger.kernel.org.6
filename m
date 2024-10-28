Return-Path: <linux-kernel+bounces-384434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4B89B2A13
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 923911F21F99
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC956191473;
	Mon, 28 Oct 2024 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwZgXXKp"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA1416FF45;
	Mon, 28 Oct 2024 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730103607; cv=none; b=mfrOX5YOg9Ophaf0LDJl2P6Knf1WaQ2FZZh6tpuuVBKZNyxxCUn1gbY6STOjWKYkBqv8d8X3lYBcPZ8f51m0ot80SQjeTqSYUK596Mt0pHOIYiijKuTTcMxOaX/TJq61SbUoSHQplrTTkbe4jmjco4jI+wqd/Lfy5iZ9VcU2xVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730103607; c=relaxed/simple;
	bh=9KgzYqnG6iqO+36iW/hPKk0FuDDy3HBUJ77k1H9GQQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BhaWJiCsWboXPr2PmL++5OzeIPGn6J3VJ+KZS4ewXfPMQAlDIDQaGaN2hX7RjOXRNK0IPpO28pvevgT7lBB+hq+NhgKHDBrWFVxSCOWK6VNbMk/r21fQf1wmffTMZvc7Dpn303ea7YZc0cWsbFAwM/jxcyu8YhU1jaKUsrWDwV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwZgXXKp; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cdda5cfb6so37069645ad.3;
        Mon, 28 Oct 2024 01:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730103605; x=1730708405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v8sdPDR1cu1RSy6KGnm0bu4ImucaLAk6cLvG3PELIM8=;
        b=dwZgXXKp+P3qZ5XM5hBatyo+zcashu2FPHyfRTOVuN4oNGdo+0ku/jmU2sSvCpQnjV
         QJW3DlqnsiKVCB8ENd/lRzJkfFpIAx2b69ajrBiw2/4NwaSLNEPHyi0sdfJPnCL3E20f
         9IVGgS1vBN0JCk+y8+kkWVt2RGDYpnDSLAn8YCL/aDq/IlTjm5bqvwYKtHyXtMleNxwE
         RVPIatQJ71cEvRJBrIwoN/7UeSpSv96UbkoxwaHXgsIaO7s167MENIyw8eJa9aH0pQes
         7jNy+Dzw6VngkmzoVm+H2CXFyvFw/WEeglJ84an9sJCcFfslzb4xnjVcElYR0Ae1Qvsd
         /9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730103605; x=1730708405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v8sdPDR1cu1RSy6KGnm0bu4ImucaLAk6cLvG3PELIM8=;
        b=L1u+W4ZYhaOZBR8TFbdMS65MbCa178TTv9XEF4cr1mzqY0uhAe0/jCnx4XetgJeq79
         akHImDjl+pIt4h/v3QTqBfg/2t9ZJMwNSmSY8txpgyp41bRekUGqymrNLRXKryl+GyB2
         h/0mY0T0HGUyA2eyqbdbKB2FQY9SwYzEK0AYntV+w3Xh0+Hu/ZyCz7YWXWlga+wr9Fwv
         LVZruIWo/fRR/maCxHOEIQY9zfMoGHtJ4WlH5V7z9xT+SsmIiFX8XbuZ1eNEKSfMrWCx
         PTE5QhJ3DTFVdMbTndnp8KjRrhoLGcD2053TTM/xLV7+546Zz8lQvUZI8V+I72Ceb7Cl
         zdsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyZ1hWBFot6n+xovELrjOGW4YQVKQlu5YEdXOOCq3XDeur0FKkcmDR61CUnEV7Sgvgar8UvkbjF8cU@vger.kernel.org, AJvYcCWQWHD1Z3xV/ZjUX5U1NHormzjri4sANwPjhNyf6NzEIKuuoX20DviE5+C91F/Is7N/GX6UG8ZidenstAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpnWlQ3A9LTfX9R8FB/QcJdyAVPEQ+VeyO/rR059OkbL/CsJuK
	LF2CDU4zFSuEDpIXx4gTZIPirCw2OfD8lwvpSnqS2zc+z1S167gN
X-Google-Smtp-Source: AGHT+IEpo881PxiXGmEfrUuaYO7xAm9Y2eiflJg/dlJsCht9s6H07Rednce93QydQNZDFVKY4bnXpg==
X-Received: by 2002:a17:902:da86:b0:20b:8109:2c90 with SMTP id d9443c01a7336-210c6d6b2b2mr88077225ad.61.1730103604665;
        Mon, 28 Oct 2024 01:20:04 -0700 (PDT)
Received: from localhost ([2402:7500:488:6621:2441:dc7a:ff1b:984a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc02dbb4sm45603115ad.183.2024.10.28.01.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 01:20:04 -0700 (PDT)
From: wojackbb@gmail.com
To: johan@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jack Wu <wojackbb@gmail.com>
Subject: [PATCH] USB: serial: qcserial: add support for Sierra Wireless EM86xx
Date: Mon, 28 Oct 2024 16:19:49 +0800
Message-Id: <20241028081949.699921-1-wojackbb@gmail.com>
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

Signed-off-by: Jack Wu <wojackbb@gmail.com>
---
 drivers/usb/serial/qcserial.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index c7de9585feb2..933589ba5869 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -168,6 +168,8 @@ static const struct usb_device_id id_table[] = {
 	{DEVICE_SWI(0x1199, 0x90d2)},	/* Sierra Wireless EM9191 QDL */
 	{DEVICE_SWI(0x1199, 0xc080)},	/* Sierra Wireless EM7590 QDL */
 	{DEVICE_SWI(0x1199, 0xc081)},	/* Sierra Wireless EM7590 */
+	{DEVICE_SWI(0x1199, 0x90e4)},	/* Sierra Wireless EM86xx QDL*/
+	{DEVICE_SWI(0x1199, 0x90e5)},	/* Sierra Wireless EM86xx */
 	{DEVICE_SWI(0x413c, 0x81a2)},	/* Dell Wireless 5806 Gobi(TM) 4G LTE Mobile Broadband Card */
 	{DEVICE_SWI(0x413c, 0x81a3)},	/* Dell Wireless 5570 HSPA+ (42Mbps) Mobile Broadband Card */
 	{DEVICE_SWI(0x413c, 0x81a4)},	/* Dell Wireless 5570e HSPA+ (42Mbps) Mobile Broadband Card */
-- 
2.34.1


