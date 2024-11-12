Return-Path: <linux-kernel+bounces-405943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D59A9C5953
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EFABB30901
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA36419CC26;
	Tue, 12 Nov 2024 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZIPh1g4"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A47C14F9FD;
	Tue, 12 Nov 2024 13:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731418179; cv=none; b=kbgE1BRZrpAt+HP0YNt6rtnD/u9UKaRUcHX2dwK6pOFVux0Irw/GuTDpLBJmw1EWM4kF6dkz2oNRF5q4/AqHfrhToMJ0OcNhiGTj3nO8yK2K4AWIgPrkk8pcvmk+KccPlTYGp5O/2Mxm+0uCSQ9lV39cB2G2ZWCsvmt6ZgQAKAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731418179; c=relaxed/simple;
	bh=Zt1iFl8bPvsVnfaior9rOt4ZNa8YowcKei0yxfdwlo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LjB0GClJi1n1jdqwZMQQLoG98U2kiG8vi6zE1KeV3JVgWwnfpAUHw4cXZZmcmS4MiGFQVnwrhe1rLvvLagh9E3TeAYD4SuvGIRqmCTkbFRlj0OnaT/ZHtx1qnu2yynceQWLlWm1yLtLZfa6YT1+AcuFAVGApr+jIhzKLs9Xb95U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZIPh1g4; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-382026ba43eso1248348f8f.1;
        Tue, 12 Nov 2024 05:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731418175; x=1732022975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mnP8i1P+vpLbvP/cUn7DPi/Fv02Hf/oohUMk15Vn8s=;
        b=bZIPh1g4Ge7E1nG4ZcriwWPl0fntJfz63EFXH7+WW+ncLnN/BRDu3y877FTY30SLLe
         y3FlOZ0MWSr9bkCvGqNXij5/8amvjHfexv47veMdo+uSQq8F6d9RdwxGyeqnQE+xYUsz
         clWjklB7yc1RT+ebkLS2An3KUCgsYtU2u1D1Ap1LLOpePMpsohWD51eYE+HCW/+760QH
         rllY3BzLQsRh07qoHwECbtT3MSZJ0h0eQreuDx5PKvtHAks28qG4mfHQjEjqf1S39AvL
         uXJgHM+ogemI1C5OLOm3SeG+GFN8pFNSbrCcJ38NYhIZUHhdIImbjCRi3GWv7odKhN6l
         IBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731418175; x=1732022975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mnP8i1P+vpLbvP/cUn7DPi/Fv02Hf/oohUMk15Vn8s=;
        b=mTVbMlxxj+AzaITAIB/ifaYI6iP3J6QijamluZS0LuOnSRhUXGWBCRgR/HAHz0ddCA
         sfXGOOPmPASC1oERic82klcXaPF5Kcoh5cZNU23idV9ucvhp31Hlgx7DYP0nyYSv5xym
         r+O6pulK2PQFonTvXzNYqoJwMqSCieRymL5kz3Fd0Hir39LMXDR2m4Ia72Af20SuSG7L
         RNCpTz8Ocy4eS26cQTs/IYwXZHU2tqub6eTezA5wXPkoYl3tBhaiokeirp1zy7XmPwbJ
         itQcuXeueynOCVWSN80xbln9slLz08IXXxxzAJbyFhsvO02rN1+xLElMMxvjTw9lFbQJ
         XMbg==
X-Forwarded-Encrypted: i=1; AJvYcCWuIVZfF4H6tTYXGomdpyigRbkWT35mkNIlwF9JXSKmrK1Ju6T4xMdKh5XuBOVD9ffpnDhihjKfA1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLPp4bBr7043zBFMcsaON+ZotO+sSmUvAUanvNo/RiNvfxrOoU
	aJLpoXOQVfFcdKQmK/KBFv98wGubnYsdJEQ3Mqen21VGjiDInRsz
X-Google-Smtp-Source: AGHT+IGosRxkCc8ECvFcdmBsOMrfz8iVl+h+Kecsd7CY1ES03tYdT6k/oApMgIqx+jjpJwqFfWfXvA==
X-Received: by 2002:a05:6000:1547:b0:374:c8e5:d568 with SMTP id ffacd0b85a97d-382081245e6mr2028721f8f.29.1731418175336;
        Tue, 12 Nov 2024 05:29:35 -0800 (PST)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9973aesm15392966f8f.51.2024.11.12.05.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 05:29:34 -0800 (PST)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: gregkh@linuxfoundation.org,
	oneukum@suse.com,
	stern@rowland.harvard.edu
Cc: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	snovitoll@gmail.com,
	syzbot+9760fbbd535cee131f81@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH v4] usb/cdc-wdm: fix memory info leak in wdm_read
Date: Tue, 12 Nov 2024 18:29:31 +0500
Message-Id: <20241112132931.3504749-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024111232-relative-bottom-4995@gregkh>
References: <2024111232-relative-bottom-4995@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported "KMSAN: kernel-infoleak in wdm_read", though there is no
reproducer and the only report for this issue.

The check:

	if (cntr > count)
		cntr = count;

only limits `cntr` to `count` (the number of bytes requested by
userspace), but it doesn't verify that `desc->ubuf` actually has `count`
bytes. This oversight can lead to situations where `copy_to_user` reads
uninitialized data from `desc->ubuf`.

This patch makes sure `cntr` respects` both the `desc->length` and the
`count` requested by userspace, preventing any uninitialized memory from
leaking into userspace.

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
Changes v3 -> v4:
- changed min() to min_t() due to type safety (Greg).

Changes v2 -> v3:
- reverted kzalloc back to kmalloc as the fix is cntr related (Oliver).
- added constraint to select the min length from count and desc->length.
- refactored git commit description as the memory info leak is confirmed.

Changes v1 -> v2:
- added explanation comment above kzalloc (Greg).
- renamed patch title from memory leak to memory info leak (Greg).
---
 drivers/usb/class/cdc-wdm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index 86ee39db013f..5a500973b463 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -598,8 +598,9 @@ static ssize_t wdm_read
 		spin_unlock_irq(&desc->iuspin);
 	}
 
-	if (cntr > count)
-		cntr = count;
+	/* Ensure cntr does not exceed available data in ubuf. */
+	cntr = min_t(size_t, count, desc->length);
+
 	rv = copy_to_user(buffer, desc->ubuf, cntr);
 	if (rv > 0) {
 		rv = -EFAULT;
-- 
2.34.1


