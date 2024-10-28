Return-Path: <linux-kernel+bounces-384417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 221BF9B29DD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA303286562
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B641D54D1;
	Mon, 28 Oct 2024 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4TMAKMv"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CDC1D4605;
	Mon, 28 Oct 2024 08:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730102685; cv=none; b=hML4f1w/C7gHsBAifsJ//HNCm5JtpJjbMvceWVmEKVuwcrlDo3flZ5SaNLrs/hltC33LpAvZgbzqXqO+tSyTyGJrD5ssiRe6VSUOAWyabXAqFz+5ILGW/SjWQg5lIhGUpJg9LUjQkLrNAG3IiXuJmtX7sC4UaA7S+At0Pb6zwGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730102685; c=relaxed/simple;
	bh=px0akK44Pnon/IUmYmPa0nxDuWcRJmwM/cXbQ0Y2yPc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=prfg7JaPmgjzpnIIuAUQZS18+UlUcqjlfpcU/iCfkfkoUqBOb3lqmNu5aOT7v4ULizvkj78SFL1pv/Ec0Ob3An/Dh4UGRLUj8txlVyQQSgWw8nWT0827sg0M2XMTfB+5kAKXJCE52lo7kyAzgy4O0qzVkNhv/95fwUv6uPcANoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4TMAKMv; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ede82dbb63so512754a12.2;
        Mon, 28 Oct 2024 01:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730102683; x=1730707483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y1wPbpOHvrVR6b5Iz9OqlHN9S68A6RZqEvUNgT5njSQ=;
        b=A4TMAKMvavhD8VfGhp9vAeSUC+JYyxhFexRSFOnpovsxz0pXzpCb8PeFITl9DveBG5
         gBo7u7ZFzNz0AnAA9ueI0kZxkNYvwtyJoOExCj3n6oGMPo/JVw8uY3GkFEjvjwnqWffu
         O949J+wHosDES1V0J4jV3AQxeEPA9DuIIFW9zu8RBZ4/e3foZpOABxWEHa+0+qWyeLqK
         hCgmVEG3C3kTul9qj7DPMeVkyF4S3hVScYAa1rdE45wiqR9YKKSj/AuPqI3ljuOf5U5P
         sUj7ReqPgqFIUNrNsOYwj2UD9mVHELduWS4EsCk99wxoB2zqziC+pTgqBU/D5dZhsWfi
         HKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730102683; x=1730707483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y1wPbpOHvrVR6b5Iz9OqlHN9S68A6RZqEvUNgT5njSQ=;
        b=lHLL3RR4YS9a0n6ZYB96vjenburCB58lqAFwrL3O0p4jG1eqUsCi6vTZcYpmLqI39j
         7CTrn/DDcBsanE/fsl8yRpYGhnL8Oqj4i/KZJpCrw7Mz8jhGlJmvH0/5DItzucTWHo02
         iV5C5hTvzd6711wkt+7wnH+XdxLU582In4nC4Z8MnIF/VFUX5N7ot6TOFkddWksahLOH
         jReY0oontWAxh9rg6iA1ltTX0oKkpHzSr0WmsMdpmaNCqt/KR3pL/FmWAWhZ/tWMcfZ7
         wANH3Z3YZeCS9AYO3UZIU0M6yrGmegWWCSxwLtz5ihkkPrLwxsdSTCatNGrXG4tfRVbN
         bxgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSTOGAUQ+SAEINcAGrzhsvsUt/iTTeeF5iEFhRpE8MlLFubXb/oNm7KR/AMSjC3+z/Kwa2F+srisizEBE=@vger.kernel.org, AJvYcCWSzA6GhfRGXT+aUTZT9ldbzmiklQkY7hqLVrZx0Wls1lu0aNglYUxr/npkdl3HgvdNlQSCE88PPV1f@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9bwvrYtElYC9A0PGBoMaAGym+Seg8vslKKRfQl6iGFlDn+63a
	mkgA6zzQh2lYATFEhP6k7iHmy8Bs5R8L3FGHZ/tk4eetudx0n1my
X-Google-Smtp-Source: AGHT+IGbSevwBYaqUV266/S43UKd21qQoPrJSj6hau3YriYsYTYyyfCW7RuMVTlyA8zlBEfKx39H5w==
X-Received: by 2002:a05:6a21:2d8f:b0:1d8:f977:8cda with SMTP id adf61e73a8af0-1d9a8400813mr9274823637.27.1730102682848;
        Mon, 28 Oct 2024 01:04:42 -0700 (PDT)
Received: from localhost ([2402:7500:488:6621:2441:dc7a:ff1b:984a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0d025sm5174882b3a.101.2024.10.28.01.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 01:04:42 -0700 (PDT)
From: wojackbb@gmail.com
To: johan@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jack Wu <wojackbb@gmail.com>
Subject: [PATCH] USB: serial: option: add MediaTek T7XX compositions
Date: Mon, 28 Oct 2024 16:04:15 +0800
Message-Id: <20241028080415.697793-1-wojackbb@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Wu <wojackbb@gmail.com>

Add the MediaTek T7XX compositions:

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

Signed-off-by: Jack Wu <wojackbb@gmail.com>
---
 drivers/usb/serial/option.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 4f18f189f309..b6118f545386 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2244,6 +2244,7 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(2) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, 0x7127, 0xff, 0x00, 0x00),
 	  .driver_info = NCTRL(2) | NCTRL(3) | NCTRL(4) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, 0x7129, 0xff, 0x00, 0x00) },	/* MediaTek T7XX */
 	{ USB_DEVICE(CELLIENT_VENDOR_ID, CELLIENT_PRODUCT_MEN200) },
 	{ USB_DEVICE(CELLIENT_VENDOR_ID, CELLIENT_PRODUCT_MPL200),
 	  .driver_info = RSVD(1) | RSVD(4) },
-- 
2.34.1


