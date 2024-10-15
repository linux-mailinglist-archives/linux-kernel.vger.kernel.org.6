Return-Path: <linux-kernel+bounces-366678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5068F99F891
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8D171F225E8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB551FAEF3;
	Tue, 15 Oct 2024 21:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="KXO9R0Gi"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2A61F76BA
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729026259; cv=none; b=TjdPnjw6oqhNXpwTn6z1e5GSgV75PB4CqooaRrly8QbEChcubVArj+yxjRmpZ4Vms6d+7eEvVFbZOccQwin8V22VWU8dP2aVba0S03X/qu+thkjqmlFUQPUP7cb5fLbTFeLZTgDXqXi6yyK7TF+hJNdO++fpDbnLIZCa9ZQrino=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729026259; c=relaxed/simple;
	bh=Kkdd6ff+KpXBntfKkv85C/9BSpxOJGjkgUJDUsuh9wM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B5NH3Zu5J8sXkAKEYpXmKtm+QatdHD3iuFCIKNE7lnBJ+eaBvM3Fge+9Hm19E1SxfTTZVMFizOTlwOz0Tcd5xyzqUPR92M7NQsT8Q8651M3ARFm9bkxz5rPgcBvN4Z110qVz3OI2MR9mctXYStDUjPSBSmUjTAdcy5ro5VSMCRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=KXO9R0Gi; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7db1f13b14aso4848621a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1729026257; x=1729631057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9VyyCpmipSwY90kbSrIopf/4vKgm9p64A6xi8/YUkg8=;
        b=KXO9R0GitJKEEphIFNih+GPYh4DmpECEwouingk+cxJtrXA2R0hoo/h4/HY8J6ZKX5
         TR4o/4uPgOSrjPYPBqMK1duwN14eanyXPs3tCYiXSIzwP25OjDRqbt/9v4v41lGZVl5K
         4yoGW8Mo+uGndCjdU0yl4w4/6c4UFCdrFtdXyWm/ZN7DiRv8OIYD7iSFml3b3I+fEj5h
         nVusDyMjML/dgB1L7hINIl8fZkqj66emDIhW4wTpSrSQUZeUUIGJh+zXwURwAOKXGfTg
         nR//gR46gGQ4o6taSY326Uxkp5C/Xq2Xhoy1jB7wssWC7qr1y2VS2m9MGgXkkS66KfjW
         OgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729026257; x=1729631057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VyyCpmipSwY90kbSrIopf/4vKgm9p64A6xi8/YUkg8=;
        b=Of8zm3OWkI8okscJ1ylScvy3Yvluq2gTF0XJrYRMAaKCwIwUUvr7uXBL+VP/6KVeR2
         +FBiwlBdy7OWP4WFGd3j9uTPIWq886+DCFaEcKndn+5AHicD7XasbTToEw33MexbKxMW
         d/iOTOJs82sggWLd4yXYxv951La6RfWVsGvt0mhVbr/ic/SgSpbJ7q2e/kuwIOf+YP3I
         Jjx0D75NeJcGy2HeQncO2yv+Io8boNJ8p8Er/Z7PbOSvTL8hfttHYjWczGzzqAdRvqqS
         d6CzU6a1VTMdHpCoXW1EeUfptiAW92mIlux3DU78DqFQixZf6e/aD9dX/O655xgAAP2C
         HuSA==
X-Forwarded-Encrypted: i=1; AJvYcCV69YxvoL6vqAXr3LtmwZiRI04SAOkbIuH87n4cAqOIXGPXZwgFwXNb13h28ikXHKFJKp9Sc9ZaQwYWrOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjXqCa5pV7vAsrzrpfPVqU9qwVZMQ/75wPPexfyVCSshjTnwgL
	1y9QPpSP5vMtVZ77LdPyGtutTPwYHhRED0zUTPKoVD/GdoRkMdEW3pD5i5rtMYs=
X-Google-Smtp-Source: AGHT+IGfXJn4tGXJ7k9K3+eze+dIDh/mipxp6am0cLYFj+vHhfSQfPILSNXol1LEa/ieRQEpX4UoLA==
X-Received: by 2002:a05:6a21:e93:b0:1d3:ba1:18f4 with SMTP id adf61e73a8af0-1d905f10178mr2320066637.26.1729026256833;
        Tue, 15 Oct 2024 14:04:16 -0700 (PDT)
Received: from localhost.localdomain ([81.17.122.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71e774cf5b0sm1755646b3a.167.2024.10.15.14.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 14:04:16 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: dpenkler@gmail.com,
	gregkh@linuxfoundation.org
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	skhan@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: gpib: Remove unused value
Date: Tue, 15 Oct 2024 15:02:57 -0600
Message-ID: <20241015210300.17941-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable `complement_count` is assigned a value which is again
overwritten in the next statement.
Fix this by removing the first value assigning statement

This issue was reported by Coverity Scan.
Report:
CID 1600790: (#1 of 1): Unused value (UNUSED_VALUE)
assigned_value: Assigning value from length to complement_count here,
but that stored value is overwritten before it can be used.

Fixes: 4e127de14fa7 ("staging: gpib: Add National Instruments USB GPIB driver")
Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
index 1da263676f2a..e19e18892468 100644
--- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
+++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
@@ -759,7 +759,6 @@ static int ni_usb_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 	if (!out_data)
 		return -ENOMEM;
 	out_data[i++] = 0x0d;
-	complement_count = length;
 	complement_count = length - 1;
 	complement_count = ~complement_count;
 	out_data[i++] = complement_count & 0xff;
-- 
2.43.0


