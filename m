Return-Path: <linux-kernel+bounces-423051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C94A9DA1E6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 06:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D79284EA7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 05:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BA41474A9;
	Wed, 27 Nov 2024 05:59:34 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260861448E4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 05:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732687173; cv=none; b=ZMwyHq7pFdZt151UpqMJJgPRDH9YPHSx1zeBtwDQz50eHh5Mh3nJuj3bqAG1WhFEt3O6NiOBs8nJFDukPNSyqhdlL7frRL1pvlDqAMjyD8NMT24wA3WoJp1YDg9UPRLm09Z4K32Agb2HGB8JgBFA3Id4SHpxvTMjNyJHoCJYUEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732687173; c=relaxed/simple;
	bh=EM36v8ghERBtXXNw/SzJc/eIWdVY+FWna6XekeNhXl4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=M9ITPpjrCwHQviaQPDU5i2VURR4XHEwIvAalw2w0MwtB6y0BTR1k7bxSI92hBsrp/pYr0KiUA2o+tqkOFJJ1EAl0wFWWuGuZBTaVd7pHKLsAvhtmkceLw8Vk13LYXaEvOKVe+sm0KrnFD4lv4RnyASwHjh31ol+xdwRcPbQB2j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a794990ef3so4762045ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 21:59:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732687171; x=1733291971;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTovsUnFQLNpXr4OQ1i7aG29GnjFVAgjz5nr+IKaBLE=;
        b=NLtg50auuW6HsrCLbWPFkDd79pW9bHfjTalBVz9nRP4H5dFs61WaAWFUcecuDwtlmv
         HBytWo3pouPTS4ajeUxEb8k6GPQjOk+/8biHPuPVfCTkjwE7QvAKtRMuB/u8E4c9MorM
         nNoaM7DXHH/dQLECJhYFJbceZGah6ZG+RdYY8NlzqiJN6IlalWYS6o5V8c7S8IQIIZSG
         CleAt8XTdjzllmTIQHrlj2mdgFBlKJvgayUdWly4wE/kIguUmjSUVGAzQVfpAwffaPAM
         WfgU6eHFo182CaxF9xgGE9wF6WQqWfgGSAb6RcRTQ4cx9n2lhuKDDyW030CcOJ/NXpj2
         ytig==
X-Forwarded-Encrypted: i=1; AJvYcCULhcX9SrPxHb3wAUnlCv087+PAVy84/q3qk/wp+JPJbtWgJjQfwM4pcR72UJDoN92PFrYImwxec1FyIwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrlZJ5IhH4mNXFPVgjvRgRoWfGYrStiwRIZwy0M8MlwJFqnKGF
	JCJMB/vv3h+GPS3FP0RSI4POSN/XKtSGkZYvttfZp1ajX7eupUTjHTD32jMZ/wLqjBNXLHRlwD9
	xZWGA1IxFh2WzLw69SuTMdvMYF/iE6YYZhdwCnPlqifLcrsXG9Gly4Ag=
X-Google-Smtp-Source: AGHT+IFzmOZzVVt14aLz9y/fopTi8rjINh8cnqihEFxUBARGCm9hLP3FW3unHyZseo9uSZGyo0dKUY3YDbMj0ewsYv8vrT6NIsAU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c3:b0:3a7:c53e:a0ef with SMTP id
 e9e14a558f8ab-3a7c53ea31bmr13932335ab.7.1732687171437; Tue, 26 Nov 2024
 21:59:31 -0800 (PST)
Date: Tue, 26 Nov 2024 21:59:31 -0800
In-Reply-To: <CAFj5m9JTrOdETvLY=pO=6oXC6NXPumAPa82281qra0sfakjr=g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6746b543.050a0220.1286eb.0029.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in blk_mq_submit_bio
From: syzbot <syzbot+5218c85078236fc46227@syzkaller.appspotmail.com>
To: ming.lei@redhat.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.lei@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Sat, Nov 23, 2024 at 11:37=E2=80=AFPM syzbot
> <syzbot+5218c85078236fc46227@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    06afb0f36106 Merge tag 'trace-v6.13' of git://git.kernel=
.o..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D148bfec05800=
00
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db011a14ee4cb=
9480
>> dashboard link: https://syzkaller.appspot.com/bug?extid=3D5218c85078236f=
c46227
>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for =
Debian) 2.40
>> userspace arch: i386
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/=
7feb34a89c2a/non_bootable_disk-06afb0f3.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/aae0561fd279/vmlin=
ux-06afb0f3.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/faa3af3fa7ce/=
bzImage-06afb0f3.xz
> ...
>
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>>
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>>
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>
> #syz test: https://github.com/ming1/linux v6.13/block-fix

This crash does not have a reproducer. I cannot test it.

>

