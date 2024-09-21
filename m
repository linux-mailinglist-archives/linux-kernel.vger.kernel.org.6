Return-Path: <linux-kernel+bounces-334713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B1297DAF7
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 02:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A098283DED
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 00:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B665A1877;
	Sat, 21 Sep 2024 00:18:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D045810E4
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 00:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726877884; cv=none; b=aKSuoXM8lYpFbukVpaYhSnoqPhjgYeCBoBtYveiXEaaZ+hL1f9Ri/EH1XIZ0COEbOjyuf/7CxK0SONrRTSvofa9IPudx6OdjhoxeXqorQ/UwcGKspDsbtbb97J8kEHMZ4pelB5HgfMqw+BCDHc3If/i4+h6HPn20tYPYvULkFa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726877884; c=relaxed/simple;
	bh=+rFHY6LX3wu5Yi34XEwLjcxrlfxbIq4wsATaXsIXu4Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Eu+Iuvmo6x6a3coHmbyjeuLdRQn1PIucVlWimsRRzRtdk0C9cHXethXay+LHbHN501Tr9RVemHrLpeieZp4jwY5/zB+pXwo/Ls5VFst4DQEret1CMsSnU9mj73BeScvyIX6sEWew5EisoSk091oYqt1p48R90iDFZ8pEzqjNVJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82cd9c20b2bso309363439f.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 17:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726877882; x=1727482682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rhPG4mMcan2MINJQZSdzC5dYrMXj9BLl6scztKHsYZ4=;
        b=dBovj303jGAGWXeL2rr4P76A38vw6GFUImCtIflG5FXtn0nHvBFmWFLORqjQP/dCLH
         fnRbNZ02H/m0WM4E+JDFBrVLmyoD6kWmAy7BiIl0DwW/4cnmzt79NuOrEIpN483hD09z
         XKuluGsjUkGXNYMVbUZiptWA9jwQR8fdwiIw26Yex02XfpXI8mAQc+uUHs5ZVGkxch8A
         GKmMirxTPiLt2DpXlo/9yjY7XI1sF4hB/ljkInI36+PzvJLEWuhI9SszeOVZbIfHp744
         fa2OJO5wzxZn2yxEs3ydSdIMWAZEx56wvg1oYuY1Z28+IDXJNA5034EuLn0T1xI9iN/g
         Q4Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWbI3k83r546D0g/6qwKCbFq/Uc2Ky+JRcTsibDUUr8Z4FpvJsn725EBrc1SGZlt8Um+s3mxOEoQQsTG/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLI3Zrg7I0vT9wRmX8PToqsgNr0MGS0BeB0tvqBuK0crI6gnOq
	WenqO/y/PDzJRJHLRpdLjaHAx6lrW+FymXSXesjkINMHZfiAYhQZYXAEKorb0AehuWa/TyRW8B8
	eDAdhAiCRqHvBbnAwQTa/8eSk8X9YYXac82dNDuGQTcLD80XFq8cTmuk=
X-Google-Smtp-Source: AGHT+IFRtvtEoKGZs3ec4+kbRcRmO0TjZoTMgbajzltTR8eKMw87chbhzFscl22xh2RgvpP8ohaxcfQzRQaUPW50LVCrfSAyp1oA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1748:b0:39a:eb57:dc7 with SMTP id
 e9e14a558f8ab-3a0c8c6a2f2mr51975725ab.1.1726877881885; Fri, 20 Sep 2024
 17:18:01 -0700 (PDT)
Date: Fri, 20 Sep 2024 17:18:01 -0700
In-Reply-To: <20240920235414.755-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ee10b9.050a0220.3195df.001e.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_advance
From: syzbot <syzbot+7c48153a9d788824044b@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in p9_client_create

------------[ cut here ]------------
kmem_cache of name '9p-fcall-cache' already exists
WARNING: CPU: 0 PID: 7251 at mm/slab_common.c:107 kmem_cache_sanity_check mm/slab_common.c:107 [inline]
WARNING: CPU: 0 PID: 7251 at mm/slab_common.c:107 __kmem_cache_create_args+0xb0/0x3c0 mm/slab_common.c:294
Modules linked in:
CPU: 0 UID: 0 PID: 7251 Comm: syz-executor103 Not tainted 6.11.0-syzkaller-07341-gbaeb9a7d8b60-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:kmem_cache_sanity_check mm/slab_common.c:107 [inline]
RIP: 0010:__kmem_cache_create_args+0xb0/0x3c0 mm/slab_common.c:294
Code: 98 48 3d d0 de 11 8e 74 25 48 8b 7b 60 48 89 ee e8 35 ae 3c 09 85 c0 75 e0 90 48 c7 c7 58 bb 59 8d 48 89 ee e8 01 38 80 ff 90 <0f> 0b 90 90 be 20 00 00 00 48 89 ef e8 bf af 3c 09 48 85 c0 0f 85
RSP: 0018:ffffc90008aaf900 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888030f54780 RCX: ffffffff814e16a9
RDX: ffff888027479e00 RSI: ffffffff814e16b6 RDI: 0000000000000001
RBP: ffffffff8ca2e820 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000008004 R14: ffffc90008aaf9f0 R15: 0000000000020018
FS:  0000555587ca4380(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555587ca4ca8 CR3: 000000005152e000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 kmem_cache_create_usercopy include/linux/slab.h:361 [inline]
 p9_client_create+0xebd/0x11b0 net/9p/client.c:1042
 v9fs_session_init+0x1f8/0x1a80 fs/9p/v9fs.c:410
 v9fs_mount+0xc6/0xa50 fs/9p/vfs_super.c:122
 legacy_get_tree+0x10c/0x220 fs/fs_context.c:662
 vfs_get_tree+0x92/0x380 fs/super.c:1800
 do_new_mount fs/namespace.c:3507 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3834
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount fs/namespace.c:4032 [inline]
 __x64_sys_mount+0x294/0x320 fs/namespace.c:4032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2f88775f39
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeb6e17418 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f2f88775f39
RDX: 0000000020000040 RSI: 0000000020000000 RDI: 0000000000000000
RBP: 00007f2f887bf04e R08: 0000000020000300 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffeb6e1742c
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>


Tested on:

commit:         baeb9a7d Merge tag 'sched-rt-2024-09-17' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13556e9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a0a1caedf9d578f
dashboard link: https://syzkaller.appspot.com/bug?extid=7c48153a9d788824044b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10a17607980000


