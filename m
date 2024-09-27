Return-Path: <linux-kernel+bounces-341817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199E098869F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85621B2274E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B298A2AD00;
	Fri, 27 Sep 2024 14:00:25 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D9CEC5
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727445625; cv=none; b=W4Q2EbcOSxT71NdHCRYCEkwcayQhC61stZlJdNqv7FttAhMJGZeuW+cJaH1lgS0f7QY+raCzu/2gAgU4rQ3AhaUi+KLqast8QOdtl4OVMupjv22y/jGjlzACHnJCOlEnHn/qkmX0lTUG0CI2WKJZ08FHEp+7GuI6jIOolWReCKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727445625; c=relaxed/simple;
	bh=iP1HHheTA2Mql+Rf7swE/cRxQQToiG8a/UaVacXHEFM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FusRHNef8bL1dLt66pRSJffCsaVFoGhRlpoM6DENlN5b0qxst0YEOC3MYMZ8WOjW0feWfPE7g8LvEdFz/8gfxWon8Yusb2dTwqdi85GZRVF3DeO+4mve+jdcaP+vyZKYThQlustlptzZ5toTQbduOBKRPGVGm0+Gg9+X9uymeY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a0cb7141adso25380325ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727445623; x=1728050423;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tUIZ2+fQvlrTgSSe15GRKzGj4OStf8yoLOxQBxKDG5o=;
        b=tgI7BYpRo696zfG+BxtIS3CeiqHSsNlcSRx0+1NMZkgh1z+K8mXBh/mJm3fxJV+Z6a
         xZ5k/njy0jEBgAew2Uj/n2cBwaDndodXF1oqDzF1BkwepUX9m7QMz6vK5J8WSrFohaCQ
         ZMbkjg3o5tFoUG9GRTeTuEiZJC+Gdd815Urh/McnkeUkza61Z9VFT4W77nzIdNvIBDHC
         1XNDmRoF2aGAhnJqTs9f5urrBZmwX50988+SNGSJ2RbuASgVfcyFvlCAwkXOZ3Ntb84W
         4ZKujuhtStk+UIyXwaqvxawCGVLz6cQ4GPXgWw4phpP73ea3BsC+UAeIBj0LhZqCyYE6
         6UTQ==
X-Gm-Message-State: AOJu0YwRjoC1tA36T62t/UJiU4FvEI0ObiruOvk2pLi/Bg1z1jkEVrWW
	O7IaPmei+K9NPpRlfm3bGSxlcZeYzRiOASntigawKnvzHDcPoH6sdRtSptJA0hXCxPSumIOo3O5
	Yl9Ggrg70gGRc9PbQtKnZzUUxObiCBA81VsovyoGav0qIXNmzngGsJV8=
X-Google-Smtp-Source: AGHT+IEIpGWCXEggxlCHItkObwT1UNGoBe4WosDhCMl0veR1aZ8mepnT49fQ5GMohrDxjO2Kl9mCEOEjfK3Zxm1jOrPeOhPpxigh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26d:0:b0:3a3:4122:b56e with SMTP id
 e9e14a558f8ab-3a3452cc167mr29723955ab.26.1727445622958; Fri, 27 Sep 2024
 07:00:22 -0700 (PDT)
Date: Fri, 27 Sep 2024 07:00:22 -0700
In-Reply-To: <66eff723.050a0220.1b7b75.0000.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f6ba76.050a0220.46d20.0019.GAE@google.com>
Subject: Re: [syzbot] Re: [keyrings?] [lsm?] [ext4?] possible deadlock in
 keyring_clear (2)
From: syzbot <syzbot+1b2d1134e0b675176a15@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [keyrings?] [lsm?] [ext4?] possible deadlock in keyring_clear (2)
Author: lizhi.xu@windriver.com

tmp no use nofs

#syz test

diff --git a/init/main.c b/init/main.c
index c4778edae797..7e08a69fc432 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1261,12 +1261,15 @@ int __init_or_module do_one_initcall(initcall_t fn)
 	int count = preempt_count();
 	char msgbuf[64];
 	int ret;
+	unsigned int nofs_flag;
 
 	if (initcall_blacklisted(fn))
 		return -EPERM;
 
 	do_trace_initcall_start(fn);
+	nofs_flag = memalloc_nofs_save();
 	ret = fn();
+	memalloc_nofs_restore(nofs_flag);
 	do_trace_initcall_finish(fn, ret);
 
 	msgbuf[0] = 0;
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 1c77400bd88e..fa16932f799d 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1623,7 +1623,12 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
-	return __ext4_ioctl(filp, cmd, arg);
+	long ret;
+	unsigned int nofs_flag;
+	nofs_flag = memalloc_nofs_save();
+	ret = __ext4_ioctl(filp, cmd, arg);
+	memalloc_nofs_restore(nofs_flag);
+	return ret;
 }
 
 #ifdef CONFIG_COMPAT

