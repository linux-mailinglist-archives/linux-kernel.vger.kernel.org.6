Return-Path: <linux-kernel+bounces-525059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D045DA3EA4D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 669E3189E5B6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9FB1D5143;
	Fri, 21 Feb 2025 01:45:16 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3081ADC6D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740102315; cv=none; b=X0zaXeeVu7jzC8zLab/fukY/M8V4vPmV80LZmXQ1cUiGPd8Jfl4TuqCLSgDvqEwPIMCw6G2kHjzHhg5jHnbOMt8e7h2uEvkknFu9Wvz2ed0OphJVCCwYvRnPgQOMsJIy2uiNYfvM3V9GiStydoYGd5+EOmPC/5NqQs23cjxcM0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740102315; c=relaxed/simple;
	bh=+DtpFkZoTuloBbuwRtYWENA6LTEh1oLBG5/3ogzTrjU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fS5SpQtnrDy7Rqi4Z4q1ZEJLvA8KvW5J7a83ykNr/MkB7IJMKY2dUnzPhkxgQl1M3H0DRzIlHloHueywBa3IAdVFPC3VvFL+zI4wvdhrxV7ySG0/aILqnPwljxzfLfQZB2EXg+IVZUWnWGc6Odf+I57JINpAfnjrCamTSmpeDF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ce7a0ec1easo15201555ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:45:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740102313; x=1740707113;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2yXmra/UzwZvD/xpc+KacWtHK3dXEXPHLRqv0g+UuMc=;
        b=v+pRA7bBD45PBXZRhhghPncNKJtD+zzfnx1tdJrxSLMUIXDhzfwSea2g8x4N7UqODV
         jKKHr/EN/qY0kPvz7mN9x8oaBGlN7G6idg6ghw7XK/wilDoOAi4iXLYvr1nldRSUADk8
         XBVes/1CebR4w88ONHONks/FcjBx1oeSvfcrmtwL9fg+ouYnyw/HLRHY+p4IkVZm7AZM
         N6vf9NM656VtwSkwoe7+SJ8fFCWsN4Ur+gXj83JnwfRfejhlnhSYVv7uek2L5oj/KsGt
         RTzkqJuyZ4p2f913c/CrWDpGvGj7dZhn3XA7ObHSj3nA+ZL9eSyl0qLRwASREVxy0Khv
         6Iyg==
X-Gm-Message-State: AOJu0YzDn4REInJctkS/KgD/CGGglt1oBK55ztfD7H6idJk73xVj4U89
	rTFNqW2PdJwTKqGG88gaNUsdkdDjBBp+qgvPAqVyT93jym7+Lt8VDMF1Z4LA4nMC7ux3nhF3kcf
	juUeUjtBUyl3oNF2bT51PnTHfOGcpgkmsKES43ZE5AYcIXn11C1IJdHc=
X-Google-Smtp-Source: AGHT+IEpS4Sxloj+JX8XmDpGP4Rjpt4sElKp6i0+h3EsFH4p4NLJal5rzg/M7Lh6ws0Bc9oDOy320G9kuMEAaiobe/dtF4yv/Ehv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2e:b0:3d0:4e57:bbda with SMTP id
 e9e14a558f8ab-3d2cae4f3a6mr12857745ab.1.1740102312919; Thu, 20 Feb 2025
 17:45:12 -0800 (PST)
Date: Thu, 20 Feb 2025 17:45:12 -0800
In-Reply-To: <67b74749.050a0220.14d86d.02b4.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b7daa8.050a0220.14d86d.0305.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [pm?] possible deadlock in lock_system_sleep
From: syzbot <syzbot+ace60642828c074eb913@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [pm?] possible deadlock in lock_system_sleep
Author: lizhi.xu@windriver.com

#syz test

diff --git a/kernel/params.c b/kernel/params.c
index 0074d29c9b80..d19881fbb2ec 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -583,7 +583,9 @@ static ssize_t param_attr_store(const struct module_attribute *mattr,
 	if (!attribute->param->ops->set)
 		return -EPERM;
 
-	kernel_param_lock(mk->mod);
+	if (!kernel_param_trylock(mk->mod))
+		return -EPERM;
+
 	if (param_check_unsafe(attribute->param))
 		err = attribute->param->ops->set(buf, attribute->param);
 	else
@@ -607,6 +609,11 @@ void kernel_param_lock(struct module *mod)
 	mutex_lock(KPARAM_MUTEX(mod));
 }
 
+int kernel_param_trylock(struct module *mod)
+{
+	return mutex_trylock(KPARAM_MUTEX(mod));
+}
+
 void kernel_param_unlock(struct module *mod)
 {
 	mutex_unlock(KPARAM_MUTEX(mod));
diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index bfb85fd13e1f..c7b1da7b9563 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -306,11 +306,15 @@ struct kparam_array
 
 #ifdef CONFIG_SYSFS
 extern void kernel_param_lock(struct module *mod);
+extern void kernel_param_trylock(struct module *mod);
 extern void kernel_param_unlock(struct module *mod);
 #else
 static inline void kernel_param_lock(struct module *mod)
 {
 }
+static inline void kernel_param_trylock(struct module *mod)
+{
+}
 static inline void kernel_param_unlock(struct module *mod)
 {
 }

