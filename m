Return-Path: <linux-kernel+bounces-398451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A429BF17A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50081C21B89
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27B0202F76;
	Wed,  6 Nov 2024 15:22:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C1D200CB5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 15:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906526; cv=none; b=ZW0k5ew50Efj8bONaTq4/vNuOZpiy4knzkDsROpaIxfiLETBHJPUtEnHqmMIJBG/Fk+x59CPTxenOggrtfqnWec1V+ujhSRiuuyr93oMgWAal4i+aGWf5852hVnW1y75snpfeLJLjgwROX+6sct7EBZTgt3BZg2fAImyzhGz5Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906526; c=relaxed/simple;
	bh=hwQb6Bgpzxjusi1sNjee+JRXjDmZXCInqM6lgcIFXi0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RDzeDUm3PhUVSCtdFEij5A6ovFO7DFbRS/pu52XJ7jKQwbZK384nrwz6Wuo3EcyIPXCXzxFFRp0CYAVZIaXokAoWQa42ulNDSaxu04MTb6QFu5SpkmBkIjU2OOfzDab5UqmZ4i1RVCUpSlgR3dEmfIdUSnUidjWZ2Ax9LAOsW3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3b9c5bcd8so70077305ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 07:22:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730906524; x=1731511324;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TxtIZrToYDUsmz51BXFewoWsiGAdqJraREWxLhVJXpA=;
        b=i1ZMioZ/RQQhOndDytQI5L5IU4IvTqKbc9j5wSeEE84/VI2VEg/gHctkZkRoI2r946
         dWAKG1lQBVJCxSJW4iq0FHVMUwGOwYB6HPbtYKjX9qEXBa/zvj6ZM0KrAqbLFOy21ZZn
         4gSu8KR50jIxAcohPafQeXxrbiXW0WTcXsLZupMXowwkMMgN1bUqtSk4bnafGe69YLsv
         2sViEDfauXea9xHMv5YQa24IjqGdfnpARQ2oBCe5XqdKvMu1ex+s9BYWhUzlXh810vND
         PiWXYxzLsl3E4jw0xvxzcZTVt9fi1U4R2K5cL7eMCLjGLgElMQLyqWgiSYaWe01l/leW
         yydg==
X-Forwarded-Encrypted: i=1; AJvYcCXv95K8FiDbt6X1vg4DC8SHa/QzhYMD2yu+SxPafh8m2cQCpDgu6MNg/FXuiELqrqq7/AEKaMME/pDCoZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgvXPEbTGRUps0Fyyyp/5Zj4LpUeNYpfhBKvr3jkePSkr5eObV
	uKUP0z1iS9Km+uBjPNaWIh7Zuhr3gyEn/RUEJK7pdRrboEvgCjJjF8uVA4w5dXiA5xSzgq2r+ui
	Eh45kQ1rfy8438G0CdRsjzHnuq8oqByLZolSHjO1Up6VAmAqYKS1Fnm0=
X-Google-Smtp-Source: AGHT+IGB0fuX92rvZS/mWn27iW0EG8h6GUgkVshI6dXgd3sqA8coI/pcSaFgr7mzopz8lL1dOWvuvS+ns96sVHW4jkdJMv2qVU9o
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:505:b0:3a5:e1f5:156a with SMTP id
 e9e14a558f8ab-3a5e1f51a6bmr238666775ab.2.1730906524025; Wed, 06 Nov 2024
 07:22:04 -0800 (PST)
Date: Wed, 06 Nov 2024 07:22:04 -0800
In-Reply-To: <671c2223.050a0220.2fdf0c.021c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672b899c.050a0220.350062.026d.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Write in ext4_insert_dentry
From: syzbot <syzbot+0c99c3f90699936c1e77@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, adilger@dilger.ca, eadavis@qq.com, jack@suse.cz, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com, 
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, oe-lkp@lists.linux.dev, 
	oliver.sang@intel.com, sandeen@redhat.com, syzkaller-bugs@googlegroups.com, 
	tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 5872331b3d91820e14716632ebb56b1399b34fe1
Author: Eric Sandeen <sandeen@redhat.com>
Date:   Wed Jun 17 19:19:04 2020 +0000

    ext4: fix potential negative array index in do_split()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15b9ce30580000
start commit:   2e1b3cc9d7f7 Merge tag 'arm-fixes-6.12-2' of git://git.ker..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17b9ce30580000
console output: https://syzkaller.appspot.com/x/log.txt?x=13b9ce30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=921b01cbfd887a9b
dashboard link: https://syzkaller.appspot.com/bug?extid=0c99c3f90699936c1e77
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173636a7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1600cf40580000

Reported-by: syzbot+0c99c3f90699936c1e77@syzkaller.appspotmail.com
Fixes: 5872331b3d91 ("ext4: fix potential negative array index in do_split()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

