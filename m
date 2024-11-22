Return-Path: <linux-kernel+bounces-418531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A799D62B3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 207A1B21388
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D341DE2BD;
	Fri, 22 Nov 2024 17:05:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878FE7080C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732295105; cv=none; b=XXk47kCehFm+C+HOAF5N9n8e8LGkpId00rxvHYHDUpIGzncy02giDeY1k9QMHFv4ejmrdGVrqdK9cn9igdkqyCgtpGBx1RmB1tqiD8F+o62cv85BJ8YGCgIkNZGvLCaMBKLh34svQNP7FvO8d9ssWZqrEfnktyMulknCXGX5i7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732295105; c=relaxed/simple;
	bh=fiILnnkT0f3Sk6+TIANC+LOPxiJ9Dbug9M8chnDoeEQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KTLatZoBo7OA0g6fjg0JmJr3HzG/A0KcOD/FE4G+c0Au2UlwjNm6ilMaib7BGI4B/ihEZQZajZxDYwsavpp2Lv0wvJw7tKxn0IbGzjLpABFqIiGDgOB+4hzt5NsWtADDuBaP/SZtJFzJ6lG0PpuywAq+Hs5zVA+fqAPGfRI3oE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7a72bd3a2so3326775ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:05:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732295102; x=1732899902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eiYt7JnYh8zSIrdwmS1xz/AnJ63+g27Xyvtfwt9f9Yk=;
        b=wuBNT3mWG9k5ZEFxrdSViJrlx+xgN1sarY4qDHH4ne+jrK5utxWhmnzLUZBJr7uJSH
         aFESK4I2FJvniGveYRcERt4mqTfKKKDrHYQ21/sFWpKVgJwBS10lCq96qh9At5Xz938O
         6Xse8HEPytmv0iKpYmvytLOgXVNt99aQfdaE7rf9sLPzaLZiSWic0wVrEhyrCAL66Flx
         /Lc3P6oI3+gcU6Ing4RkUz1m4aKb4PH3WCDn8Y6pvXOHP3/hl5wp5JJIhpOD5p1VJPkk
         Sxlr70tQxtqDhZlGFofxHnNDG19P2anlNDN51P3MfsNKzM1QfaD8vUvVGu7mQ9MZvyfO
         F84Q==
X-Forwarded-Encrypted: i=1; AJvYcCVfFs5yhwFHt4OvRvakXvfIRgyBzd5vEFI4CoFmDuXitvCZIWHgvfVGiVQ5sW0WSKHn4d/9sP3C3fj++4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuVMC0InGfkUbSFWrsuJo7zR/mTfY7OAP8kpm2rHAYAO16DbcV
	0tT3KaKGtlhm4yYTKoakoe7JRTnPISqvTQJB+JXhstGQlBEG3EDOTjylvxiG4oIf7l29lW4yNI2
	aQQVYzqnR8m/2SzhjQmcBkGAmeKbxVSEIUylfHRI/eHg4uc4n8HVz8NQ=
X-Google-Smtp-Source: AGHT+IFxLqmKQQ3aDbt+/5R15HP+DurTHA2Yuys20IgxFrah37Vht3qInWPtVRNe5MlFLAOiOjVTECXectC98XU+KRlfDDXCmHI9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a82:b0:3a7:86ab:bebf with SMTP id
 e9e14a558f8ab-3a79af6d1b5mr41537495ab.19.1732295102747; Fri, 22 Nov 2024
 09:05:02 -0800 (PST)
Date: Fri, 22 Nov 2024 09:05:02 -0800
In-Reply-To: <CAHiZj8g8dFUZj+wL5Z-Y_aL4wM-ZtC0uymGytx-oFNAWUEBz1A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6740b9be.050a0220.363a1b.0148.GAE@google.com>
Subject: Re: [syzbot] [iommu?] WARNING in iommufd_device_unbind
From: syzbot <syzbot+c92878e123785b1fa2db@syzkaller.appspotmail.com>
To: iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, 
	surajsonawane0215@gmail.com, syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: trying to register non-static key in iommufd_object_remove

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 1 UID: 0 PID: 6664 Comm: syz.3.18 Not tainted 6.12.0-syzkaller-07749-g28eb75e178d3-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 assign_lock_key+0x241/0x280 kernel/locking/lockdep.c:981
 register_lock_class+0x1cf/0x980 kernel/locking/lockdep.c:1295
 __lock_acquire+0xf3/0x2100 kernel/locking/lockdep.c:5101
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
 iommufd_object_remove+0x3b7/0x770 drivers/iommu/iommufd/main.c:149
 iommufd_fops_ioctl+0x4d6/0x5a0 drivers/iommu/iommufd/main.c:418
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd7df57e759
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd7e0445038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fd7df736058 RCX: 00007fd7df57e759
RDX: 0000000020000400 RSI: 0000000000003b80 RDI: 0000000000000003
RBP: 00007fd7df5f175e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fd7df736058 R15: 00007ffc4693c708
 </TASK>


Tested on:

commit:         28eb75e1 Merge tag 'drm-next-2024-11-21' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12817ec0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=402159daa216c89d
dashboard link: https://syzkaller.appspot.com/bug?extid=c92878e123785b1fa2db
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16933930580000


