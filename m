Return-Path: <linux-kernel+bounces-337906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5328C9850E3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 04:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C764F1F24C50
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1554F1482E6;
	Wed, 25 Sep 2024 02:19:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B42946F
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 02:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727230747; cv=none; b=lvZ37hYbMBbd/37ZUWcF/ZJDBMAvBKr9jJpbDu9fqFVlHDL2KokccvKx+zHyYWXCX5hnEfMieElfnMUkEHFOL0z87Sh2+E8odA+TNDy4otJAw9Vc6eMHHff8uzjPaW93oZOJgjpImqRsGcZsSGqwgbG9ZOXwrPlwSlocDhINyXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727230747; c=relaxed/simple;
	bh=lHhKCkoPC0PrlsrOze2PU3Heo3y9YoHQn6DFLcLVffU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=NUQ2JgqVGpcClutoFhJmw57rgoGtiMTe9f8lmHaVdQriheRsUiS2pVXbbNPo36PHJ0CMpKKhObWhGl0H81omPfUITTdgwHwuUdSXK52njdczEfgHjCGypCIr0KNbyl5kTd1+0FiHLYgJtbUCtng+930HkiOefajcSdMarVStX7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a04bf03b1aso71333575ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 19:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727230745; x=1727835545;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bPUHdGmS+SjsWjSfuMG2FtBZlTQg9FYxScXDZPqRa7A=;
        b=de3tXrPJdy2ESSyjs6XrrmkLstYpprPPOXG11dxT62d/+Esa0Z8wx8mpZa+jWFEdpy
         KAq38sJIrhh1/+T3dEVBPNUnE5QPNnJuWqOKs3kmFw8SDwKsPjbtgG7BkAaEJ0tuBTu8
         dnXR3L2sSzEt7wLonqnzPK3t7igQQrzszN5heaDPoxKDtMmKGW639qQuUJpQw19NAxRu
         Z3/JNn4r1fwiVFrKaDxb1E4IlnBXmA6F7FyhgGj90dfnIqhjVLVzpyEinGib9+bB2w8n
         0EWuc9TNq99aiowoQ5TZkU1JZGmm1j1tT/o2OrXhBHCwFc6s/fXs+IpbKmPAtj0X1zxB
         iNoQ==
X-Forwarded-Encrypted: i=1; AJvYcCURFp9brL5FiE6FJaKeFWWrXvAhC5D/e2SuxeXSU6myDKTyM4fc4dTaqlPEPTqdKjzcHoGFZvi5+CWowOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ2yhvkMh0dJVGDy3IXFcEG/L2hQqsDeQ9v6lYlqKiaCDhFCUO
	pC54SNy27xvKgH3gU92F+ZINE3UNRq8JxkqqD6vjuiNPQp+0z+D5MksDP6EgURlvT0KhtsAKSER
	5XCZ7i8kIAFVltYRDNUQEiwcQdnRfXNF4cjecByQcPBRCNi1OF+IRHok=
X-Google-Smtp-Source: AGHT+IHJzyy8UnzwP1VRJ0PrTyBx/TaI5Y4+mnCVw8oOQ+hhmmHMyWOSq+oZkuvpbiiKIhAAQup1Wo03BijxOZcKBIWC/YHsBcUv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184a:b0:3a0:9e83:21e5 with SMTP id
 e9e14a558f8ab-3a26d7bbb25mr15448805ab.20.1727230745037; Tue, 24 Sep 2024
 19:19:05 -0700 (PDT)
Date: Tue, 24 Sep 2024 19:19:05 -0700
In-Reply-To: <3a4a1d88-0a5c-4636-ace9-ffc269c64d4b@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f37319.050a0220.30ac7d.0007.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KMSAN: uninit-value in ocfs2_get_block
From: syzbot <syzbot+9709e73bae885b05314b@syzkaller.appspotmail.com>
To: joseph.qi@linux.alibaba.com
Cc: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> This blames p_blkno is uninitialized when ocfs2_extent_map_get_blocks()
> fails.
>
> #syz test: upstream

want either no args or 2 args (repo, branch), got 5

>
> diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
> index 1fea43c33b6b..db72b3e924b3 100644
> --- a/fs/ocfs2/aops.c
> +++ b/fs/ocfs2/aops.c
> @@ -156,9 +156,8 @@ int ocfs2_get_block(struct inode *inode, sector_t iblock,
>         err = ocfs2_extent_map_get_blocks(inode, iblock, &p_blkno, &count,
>                                           &ext_flags);
>         if (err) {
> -               mlog(ML_ERROR, "Error %d from get_blocks(0x%p, %llu, 1, "
> -                    "%llu, NULL)\n", err, inode, (unsigned long long)iblock,
> -                    (unsigned long long)p_blkno);
> +               mlog(ML_ERROR, "get_blocks() failed, inode: 0x%p, "
> +                    "block: %llu\n", inode, (unsigned long long)iblock);
>                 goto bail;
>         }
>
> On 9/25/24 9:28 AM, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    baeb9a7d8b60 Merge tag 'sched-rt-2024-09-17' of git://git...
>> git tree:       upstream
>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=172af607980000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=acaa65be5f19fc5a
>> dashboard link: https://syzkaller.appspot.com/bug?extid=9709e73bae885b05314b
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161e2ca9980000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151bff00580000
>> 
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/cac89ddb3388/disk-baeb9a7d.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/ddec90b149ab/vmlinux-baeb9a7d.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/f8db8244cc07/bzImage-baeb9a7d.xz
>> mounted in repro: https://storage.googleapis.com/syzbot-assets/25ed405f5727/mount_0.gz
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+9709e73bae885b05314b@syzkaller.appspotmail.com
>> 
>> OCFS2: ERROR (device loop0): int __ocfs2_find_path(struct ocfs2_caching_info *, struct ocfs2_extent_list *, u32, path_insert_t *, void *): Owner 17 has empty extent list at depth 312
>> On-disk corruption discovered. Please run fsck.ocfs2 once the filesystem is unmounted.
>> OCFS2: Returning error to the calling process.
>> (syz-executor337,5180,0):ocfs2_find_leaf:1940 ERROR: status = -30
>> (syz-executor337,5180,0):ocfs2_get_clusters_nocache:421 ERROR: status = -30
>> (syz-executor337,5180,0):ocfs2_get_clusters:624 ERROR: status = -30
>> (syz-executor337,5180,0):ocfs2_extent_map_get_blocks:671 ERROR: status = -30
>> =====================================================
>> BUG: KMSAN: uninit-value in ocfs2_get_block+0xed2/0x2710 fs/ocfs2/aops.c:159
>>  ocfs2_get_block+0xed2/0x2710 fs/ocfs2/aops.c:159
>>  do_mpage_readpage+0xc45/0x2780 fs/mpage.c:225
>>  mpage_readahead+0x43f/0x840 fs/mpage.c:374
>>  ocfs2_readahead+0x269/0x320 fs/ocfs2/aops.c:381
>>  read_pages+0x193/0x1110 mm/readahead.c:160
>>  page_cache_ra_unbounded+0x901/0x9f0 mm/readahead.c:273
>>  do_page_cache_ra mm/readahead.c:303 [inline]
>>  force_page_cache_ra+0x3b1/0x4b0 mm/readahead.c:332
>>  force_page_cache_readahead mm/internal.h:347 [inline]
>>  generic_fadvise+0x6b0/0xa90 mm/fadvise.c:106
>>  vfs_fadvise mm/fadvise.c:185 [inline]
>>  ksys_fadvise64_64 mm/fadvise.c:199 [inline]
>>  __do_sys_fadvise64 mm/fadvise.c:214 [inline]
>>  __se_sys_fadvise64 mm/fadvise.c:212 [inline]
>>  __x64_sys_fadvise64+0x1fb/0x3a0 mm/fadvise.c:212
>>  x64_sys_call+0xe11/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:222
>>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> 
>> Local variable p_blkno created at:
>>  ocfs2_get_block+0xc7/0x2710 fs/ocfs2/aops.c:140
>>  do_mpage_readpage+0xc45/0x2780 fs/mpage.c:225
>> 
>> CPU: 0 UID: 0 PID: 5180 Comm: syz-executor337 Not tainted 6.11.0-syzkaller-07341-gbaeb9a7d8b60 #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
>> =====================================================
>> 
>> 
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>> 
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>> 
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>> 
>> If you want syzbot to run the reproducer, reply with:
>> #syz test: git://repo/address.git branch-or-commit-hash
>> If you attach or paste a git patch, syzbot will apply it before testing.
>> 
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>> 
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>> 
>> If you want to undo deduplication, reply with:
>> #syz undup
>

