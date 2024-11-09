Return-Path: <linux-kernel+bounces-402900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123DE9C2E38
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 16:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316081C20E93
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 15:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96C719B3D8;
	Sat,  9 Nov 2024 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3KAtICK"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED5A6E2BE;
	Sat,  9 Nov 2024 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731166111; cv=none; b=Kj7E2AoDS4htqXjY0TzQdsTkOVOw5sfolkEvJ/zBNigmqD4Px9rljFzRhvHNZoc0e6NlIhhd6AxOUlaK5yFINV2r1bv1Mv60sqZySNYzudNvrTt6v3+3jRefIFs3mK1I3A6BstpDUdAW9fkCZln0JR3UTV1J7WVBAfMmrV6d3R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731166111; c=relaxed/simple;
	bh=EtT54TlB+gLCXHSp2zfKxHrva+zFZOR2PVxU3xLmJJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NhM3HJctHpXRPVm9DbyYLCfpSFGYbbvzGcI51Y5z04r04u72lvc912w422URfuXKLnwy3BVcKxRwvn1y4ZlH3O8oPR4cvqh06pdw3lMJM88NbSJiGPQ/xuFO0C2VF0j2ag+QMaXlrA/PPZI1L1NSHDyMiIpd1pYN4JHvrKU4idU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3KAtICK; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb443746b8so23051601fa.0;
        Sat, 09 Nov 2024 07:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731166108; x=1731770908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lb695U3thUMY4W2kjj7hhP/zWEckwDz7lUeMPY0oj5E=;
        b=S3KAtICK2Y3WjmPfC1V2SxcpbSPApTUeYx2Eb/nzNGqj9+rjl2vW2CTtKdlj6RnTQH
         Sk9oLrfJQAsFrqYsFvlnkj5EaQlAzINRsVNNurGhr9j0phE4HT98fSfdkf6ANiL5jADl
         60Pl9C3zw0Y0B4AiGChtOGwlMvGtdYkY+YOsw560DVXriJeUTkWI8087aMnj307vrtA4
         mr2u5LdBBx9DeyFB3NgvxptYPHx+y6jQisyRtAmwMJwEro0xTflbNazksirbguOKYjB8
         bX2JiKYyZ3V8DxG/nZXeiXbIaBJ9UPojx0OaTQuL/+ODzys3sC8w5KkdsZk+fPi39ybu
         Fe0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731166108; x=1731770908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lb695U3thUMY4W2kjj7hhP/zWEckwDz7lUeMPY0oj5E=;
        b=nphp/c0dhaQNU8QZyoWPo3XOYdz1kX4Z3bOq2zT3bm+SRiGt2haMq+Mov25GtkpPgd
         09UooxyqZJ5M2uJ6OG1evZF6LPto6ze/BjkM8uLw3gD24v+9oCxxu2cbbTAoySBTIuBd
         ZlNDwoUOJ24cmCLzcA+iyiFuFUIDuipJQkyA8VPsj/JQhHpdGPNKOJlndXhbDt1uryBU
         b6tTGWqwmfnZ9ljwX5gGeDoCZdLQ4xSBfqM0dYqHv6LDbfQ2+djvW6ZuZu+sSY5G14is
         Kghp5hpeqYk2sM8MxhFP9Fw/hWXvQlqXiwlQHVnr1Ou/NMpZ9/GPnlJLSTlzXApR60Zj
         4AiA==
X-Forwarded-Encrypted: i=1; AJvYcCW+g+rLOuDeDnmBy2f46o2UsIA6GOTtReMd7L//px04E+DAKAKcx+bHWc+ofy8zc+T3f6tQsTKNBtGJ@vger.kernel.org, AJvYcCXtuF/Y3I0+3Q+vPli4m0emH1dek93BAucb75KmX7oHYqMNiduKsmzjNvVS4kjOsf489jLXdjNHGrkI/vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGbCAFihkBIb8JFC0Hofipr8EjYmHOAaBLbUterLXe8lLO39TM
	xpTNeYp3G6AivnUs7qYKeETM7l0m48/cfgU2AGtlH1lOcxe1P1ii
X-Google-Smtp-Source: AGHT+IFImos+2zQyFmc63rS1xoaJ1GwHlcj2WH2pkBNAwCNpA0TIfsl4PujRx+pmCjIAyK+Eycd/Fw==
X-Received: by 2002:a05:651c:b06:b0:2fa:cc86:f217 with SMTP id 38308e7fff4ca-2ff20307f42mr35527711fa.35.1731166107231;
        Sat, 09 Nov 2024 07:28:27 -0800 (PST)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff178dfb4bsm10636991fa.15.2024.11.09.07.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 07:28:26 -0800 (PST)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: syzbot+9760fbbd535cee131f81@syzkaller.appspotmail.com
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	oneukum@suse.com,
	snovitoll@gmail.com
Subject: [PATCH] usb/cdc-wdm: fix memory leak of wdm_device
Date: Sat,  9 Nov 2024 20:28:21 +0500
Message-Id: <20241109152821.3476218-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000e875fa0620253803@google.com>
References: <000000000000e875fa0620253803@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported "KMSAN: kernel-infoleak in wdm_read", though there is no
reproducer and the only report for this issue. This might be
a false-positive, but while the reading the code, it seems,
there is the way to leak kernel memory.

Here what I understand so far from the report happening
with ubuf in drivers/usb/class/cdc-wdm.c:

1. kernel buffer "ubuf" is allocated during cdc-wdm device creation in
   the "struct wdm_device":

	static int wdm_create()
	{
	   ...
	   desc->ubuf = kmalloc(desc->wMaxCommand, GFP_KERNEL);
	   ...
	   usb_fill_control_urb(
	      ...
	      wdm_in_callback,
	      ...
	   );
	
	}

2. during wdm_create() it calls wdm_in_callback() which MAY fill "ubuf"
   for the first time via memmove if conditions are met.

	static void wdm_in_callback()
	{
	   ...
	   if (length + desc->length > desc->wMaxCommand) {
	     ...
	} else {
	   /* we may already be in overflow */
	   if (!test_bit(WDM_OVERFLOW, &desc->flags)) {
	      memmove(desc->ubuf + desc->length, desc->inbuf, length);
	      desc->length += length;
	      desc->reslength = length;
	   }
	}
	   ...
	}

3. if conditions are not fulfilled in step 2., then calling read() syscall
   which calls wdm_read(), should leak the random kernel memory via
   copy_to_user() from "ubuf" buffer which is allocated in kmalloc-256.

	static ssize_t wdm_read()
	{
	    ...
	    struct wdm_device *desc = file->private_data;
	    cntr = READ_ONCE(desc->length);
	    ...
	    if (cntr > count)
	        cntr = count;
	    rv = copy_to_user(buffer, desc->ubuf, cntr);
	   ...
	}
	
	, where wMaxCommand is 256, AFAIU.

syzbot report
=============
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in _inline_copy_to_user include/linux/uaccess.h:180 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_user+0xbc/0x110 lib/usercopy.c:26
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 _inline_copy_to_user include/linux/uaccess.h:180 [inline]
 _copy_to_user+0xbc/0x110 lib/usercopy.c:26
 copy_to_user include/linux/uaccess.h:209 [inline]
 wdm_read+0x227/0x1270 drivers/usb/class/cdc-wdm.c:603
 vfs_read+0x2a1/0xf60 fs/read_write.c:474
 ksys_read+0x20f/0x4c0 fs/read_write.c:619
 __do_sys_read fs/read_write.c:629 [inline]
 __se_sys_read fs/read_write.c:627 [inline]
 __x64_sys_read+0x93/0xe0 fs/read_write.c:627
 x64_sys_call+0x3055/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:1
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reported-by: syzbot+9760fbbd535cee131f81@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9760fbbd535cee131f81
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 drivers/usb/class/cdc-wdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index 86ee39db013f..8801e03196de 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -1063,7 +1063,7 @@ static int wdm_create(struct usb_interface *intf, struct usb_endpoint_descriptor
 	if (!desc->command)
 		goto err;
 
-	desc->ubuf = kmalloc(desc->wMaxCommand, GFP_KERNEL);
+	desc->ubuf = kzalloc(desc->wMaxCommand, GFP_KERNEL);
 	if (!desc->ubuf)
 		goto err;
 
-- 
2.34.1


