Return-Path: <linux-kernel+bounces-377054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 404D59AB951
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 00:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77F01F23E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EB31CCEE7;
	Tue, 22 Oct 2024 22:07:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB79C13B58A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 22:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729634825; cv=none; b=SqeWIsJ9d0EWTaSirjeA9ZRWHhjWjMJBZ3FybjG7LUtZ0mWtMqAftwWaIjjcwmENNBQV6K7nKDGMfh3RRc+hJ6NTr73gytBDnX2tsNxuxhvGnESh97Yo8ZiL8pPEDFIV976VemlB4nMtZoP87wU3NqgMKuci8BhbchX4hKhM5m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729634825; c=relaxed/simple;
	bh=pTwciWpvRMJMJwSkWUo9rSaT4JDh0nPCOQ+0MQgIC2g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bXidDdnL2Y+I0ZVJDYZGcKaZVcLdWvWGeMVxcUb0ljQpQ21a5Pkr88Ov/RS0lisfxy4bzjJgn++Yut1iaoQusdG05ulTYUS2mvCLLIGSSVZjVVeq2Q1cYB34EiczjSe8DofxccLdB+gqWiTAnebvGCRpEyPnPAIBUIbl23j10JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3ae3c2cacso59594265ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 15:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729634823; x=1730239623;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=//ell3NqZIhonYr80+xJC2YG6OXaH2iNWnrDPO83y1g=;
        b=VE7GfJuDIGBhn4qmQfMVqSAL04m0buYJpgz4OJ4rc3PQ2W6Ccvxv/z/lSBGztH2gBM
         XLJe5R5A0cpzQkLiwG6ir+JDQtUQ+gZqYlGOg4troWFLH/FFxGFdfHk93fL4TJqqUvNS
         TQKiltlk9Ih5xo3/7Z+vUaUZ0EEQ0jOL9LKIAR73BnG1DX2hvWG9iwdVuw1SrHcr+Vve
         BtkKG1hY+XmtjqgYNwA0JxINaKhajv4UfklomQ/Ks4C3LUHfopgmVZ11IGiPy3IQDCew
         5rRCutKeblIER9AVsq7JKzHbqAyEH7l1srsWwiL3k9U5yMLsf1aFmhB0EOunsOJoijWC
         lMqA==
X-Forwarded-Encrypted: i=1; AJvYcCUtZbcBuQVH4KrLoAh5boIqVGj1AxqIDftv0goWbJBw1rwZ+cjrbETrnEV3M6sStvUxw6CSNH450nKlqxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7qu3UYtRHvDlWGTsRtulS6UegSOwlX8HvlXiXLthyOffNsjAO
	OUkfrw+2yfgiAzFF5sFz6XJXNurSoRcv8hxCPub7FlsNT7OBhqgiq9ylJB54JzUBneWRnbUVB/V
	podUZoOeG1llYov8aA7wsiV77robSSlBqvjy3aW3N/070/kguGm7tz4E=
X-Google-Smtp-Source: AGHT+IFIDZO11XW5ZlRAIzH2Q8Kjoq0WCopviBtSpos8RpmpVUPiLWzcrT7wEOUGWHwxDEvY9aRccicD57SSHVsHIVO/Y7xr4yqw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a82:b0:3a3:b256:f31f with SMTP id
 e9e14a558f8ab-3a4d59c5029mr6755655ab.19.1729634822819; Tue, 22 Oct 2024
 15:07:02 -0700 (PDT)
Date: Tue, 22 Oct 2024 15:07:02 -0700
In-Reply-To: <41a67fa0-52c7-4089-8cb1-3d3d622cbcff@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67182206.050a0220.1e4b4d.007b.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfs_free_fork
From: syzbot <syzbot+2e6fb1f89ce5e13cd02d@syzkaller.appspotmail.com>
To: gianf.trad@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in hfs_free_fork

loop0: detected capacity change from 0 to 64
=====================================================
BUG: KMSAN: uninit-value in __hfs_ext_read_extent fs/hfs/extent.c:160 [inline]
BUG: KMSAN: uninit-value in hfs_free_fork+0x6b4/0xa50 fs/hfs/extent.c:320
 __hfs_ext_read_extent fs/hfs/extent.c:160 [inline]
 hfs_free_fork+0x6b4/0xa50 fs/hfs/extent.c:320
 hfs_cat_delete+0x501/0xb90 fs/hfs/catalog.c:247
 hfs_remove+0x16a/0x2f0 fs/hfs/dir.c:262
 vfs_unlink+0x676/0xa90 fs/namei.c:4469
 do_unlinkat+0x823/0xe10 fs/namei.c:4533
 __do_sys_unlink fs/namei.c:4581 [inline]
 __se_sys_unlink fs/namei.c:4579 [inline]
 __x64_sys_unlink+0x76/0xa0 fs/namei.c:4579
 x64_sys_call+0x30d3/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:88
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4091 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 __do_kmalloc_node mm/slub.c:4263 [inline]
 __kmalloc_noprof+0x661/0xf30 mm/slub.c:4276
 kmalloc_noprof include/linux/slab.h:882 [inline]
 hfs_find_init+0x91/0x250 fs/hfs/bfind.c:21
 hfs_free_fork+0x3bb/0xa50 fs/hfs/extent.c:316
 hfs_cat_delete+0x501/0xb90 fs/hfs/catalog.c:247
 hfs_remove+0x16a/0x2f0 fs/hfs/dir.c:262
 vfs_unlink+0x676/0xa90 fs/namei.c:4469
 do_unlinkat+0x823/0xe10 fs/namei.c:4533
 __do_sys_unlink fs/namei.c:4581 [inline]
 __se_sys_unlink fs/namei.c:4579 [inline]
 __x64_sys_unlink+0x76/0xa0 fs/namei.c:4579
 x64_sys_call+0x30d3/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:88
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 6057 Comm: syz.0.15 Not tainted 6.12.0-rc4-syzkaller-gc2ee9f594da8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
=====================================================


Tested on:

commit:         c2ee9f59 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11d8ca5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa3d7fc2fd6ea40d
dashboard link: https://syzkaller.appspot.com/bug?extid=2e6fb1f89ce5e13cd02d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

