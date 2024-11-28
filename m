Return-Path: <linux-kernel+bounces-424187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4984A9DB16F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 03:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2307165AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB2F51C5A;
	Thu, 28 Nov 2024 02:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8HdnH8w"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A234045005;
	Thu, 28 Nov 2024 02:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732760574; cv=none; b=hWF9Eny9Oz20w7G4V9JYR3IKvBNFerg7cKyVcLgpYBw0i3Cen4iJ0hrsRpE4lMA8tkAyTUtOVkYBOA7HyMSOSvx4+cYEzSGGVIMUgdFJmVtX+Ges0AcczqsJ/c8WmRorcYuaZ1aKxaYb7qkY9KJSGUYAJrAFDchrev6KwMhvIh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732760574; c=relaxed/simple;
	bh=+3yEbUpVJHErlhQVGitLUUwpUF07C/iOclEhx9DELeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QKevQhAfrn/DbCXKuRkz2DXuEkzCe4guo3cEEwDTsXqu/R5zE234mhiwgWhhohPGrRaAXCYBcb44vHuhNoIp5RVUq0JSOMt2Ljapxwy1quVWXskqH8SI1Mlpxh9GytazxiTGLEI+rmT2zCUOvLYkuUM4KRhS6u87Gp9F0FiROXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8HdnH8w; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ea752c0555so296934a91.3;
        Wed, 27 Nov 2024 18:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732760572; x=1733365372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E68xRyigClUvwUR6lCW/eJ34/F/SpAWPBL/RXhFR5TM=;
        b=D8HdnH8wwPEUFcSYnKvg4VV6huzo2MwZpn0E+uHdcw+xKcHohe9BBVAfmVHlWh0Bnh
         4pHl4xlF+EXKOSG/TUARhA6eygnHQp9n6YEICCO3nXILBIiLfZhl0TfnFzN/jqSy2M2G
         9jtpGw+4eH6y+RQARsIiwyVUnTNGCLT9AivFnbtsMht2/C8cvKJRd/CqXcPqO5A8KaPs
         /KKr0KiqEjwLlPbyw6FTpxmKA5HvEbpdnnAO7kpZkHzI18uo85nralSeKZHElONpceCh
         M0OzEQsUg9mAaTom4nZ+E3tzld/aRca6FKGTUmYZYE0BfmoGaHaqUpQCtuuBFEwZ8aho
         RjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732760572; x=1733365372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E68xRyigClUvwUR6lCW/eJ34/F/SpAWPBL/RXhFR5TM=;
        b=wEeQeKCpkHmvFe4WnpEhQGK5Q5IvyEL/QWd43uM5NX5g2bgbdC3kwydENkWCI9k6PZ
         WzSFVJdPZP+s81Ar4rSPheb2T7lksOdZrW0sWeSlX246jMP7P4spynGd2ROMW27kO700
         Ck12acCv7wEr21jx++agq0xzwmIW9awRtNJNh3Sn+cqiiibDHR1Q4DpARDsruB4BI1a1
         mBrYQYpl/wqOJrjv948zIcJ3jpGH7f12AyvydT22IHmRMKJIXTnBZi+x3L2s2OjH1bE6
         uhDbRP9Q8EnEZohye7nVqjlGAWZy8hyxmAS5QZXk8X465Q7kq/tPQxxo5IN8WZ2mFhyk
         IXEw==
X-Forwarded-Encrypted: i=1; AJvYcCUjj6gY7ygJ4vBI8xcmEcvx42Pe9S7lKgKeMNRZvFcruBaGlbeyuL9mkPlNqs1REb3ysHtSc4ZH+N1fhnw=@vger.kernel.org, AJvYcCX4SJgFCJD3fb1pda9rPra1EOpNosmuVmltQEKzkp9pJjHtkKgtCugQinpBy3QA1ATSDDASTSX1vLrp@vger.kernel.org
X-Gm-Message-State: AOJu0YzGA+vroVLSljPIsPBX2QDp8Q9Gq4SF/PqjBzaQ7h2C8craXazz
	T980K65Vl6XwR/IBjHZDlamUptWuHLGn5bmPdFd3VX7d812XQ0cP
X-Gm-Gg: ASbGncuBDd1xHJQKYpyrQXnFSusDxJYhOavHz/7jtBPET9hhY4Vq8zTFBPb1QglJ+nZ
	5J234VstDWn+PaiFr2742fZ1+b3mOWnP9WeBTFL7ogpSv/byjC6GzQBhbBMUTbDmJaU8J6LzMDS
	QSFoHJxsXl/ro5VzvS3oRVUu3J686AiMHA/sWwmQRKvNF6ste4kbG0ZqFJo4s8H6g3HT5dXQ8EK
	kJZHwMkTne+AzojJLzuOkpvQAEf9MXMrJ+RBEnqUCnKye8=
X-Google-Smtp-Source: AGHT+IG04RJqmdp6NjPYOcNv/NdD0ONIDGFl3Te1sWDBBb68PsQb8kGuXxXHrggYkyOK57gtO4Nk2Q==
X-Received: by 2002:a17:90b:2782:b0:2ea:b564:4b3a with SMTP id 98e67ed59e1d1-2ee08eaf00amr7329845a91.9.1732760571758;
        Wed, 27 Nov 2024 18:22:51 -0800 (PST)
Received: from localhost ([2402:7500:587:82b8:6566:ea7f:84f:75cf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee2b007affsm310099a91.12.2024.11.27.18.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 18:22:51 -0800 (PST)
From: wojackbb@gmail.com
To: johan@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jack Wu <wojackbb@gmail.com>
Subject: [PATCH] [v2]USB: serial: option: add MediaTek T7XX compositions Add the MediaTek T7XX compositions:
Date: Thu, 28 Nov 2024 10:22:27 +0800
Message-Id: <20241128022227.717101-1-wojackbb@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Wu <wojackbb@gmail.com>

T:  Bus=03 Lev=01 Prnt=01 Port=05 Cnt=01 Dev#= 74 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0e8d ProdID=7129 Rev= 0.01
S:  Manufacturer=MediaTek Inc.
S:  Product=USB DATA CARD
S:  SerialNumber=004402459035402
C:* #Ifs=10 Cfg#= 1 Atr=a0 MxPwr=500mA
A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00 Driver=cdc_mbim
E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 7 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 8 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=08(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 9 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=8a(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=09(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

-------------------------------
| If Number | Function        |
-------------------------------
| 2         | USB AP Log Port |
-------------------------------
| 3         | USB AP GNSS Port|
-------------------------------
| 4         | USB AP META Port|
-------------------------------
| 5         | ADB port        |
-------------------------------
| 6         | USB MD AT Port  |
------------------------------
| 7         | USB MD META Port|
-------------------------------
| 8         | USB NTZ Port    |
-------------------------------
| 9         | USB Debug port  |
-------------------------------

Signed-off-by: Jack Wu <wojackbb@gmail.com>
v2: add NCTRL and more description
---
 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 4f18f189f309..1b798244b675 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2244,6 +2244,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(2) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, 0x7127, 0xff, 0x00, 0x00),
 	  .driver_info = NCTRL(2) | NCTRL(3) | NCTRL(4) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, 0x7129, 0xff, 0x00, 0x00),        /* MediaTek T7XX  */
+	  .driver_info = NCTRL(2) | NCTRL(3) | NCTRL(4) },
 	{ USB_DEVICE(CELLIENT_VENDOR_ID, CELLIENT_PRODUCT_MEN200) },
 	{ USB_DEVICE(CELLIENT_VENDOR_ID, CELLIENT_PRODUCT_MPL200),
 	  .driver_info = RSVD(1) | RSVD(4) },
-- 
2.34.1


