Return-Path: <linux-kernel+bounces-236251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A5C91DF82
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EAA6B2152D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070C4156F54;
	Mon,  1 Jul 2024 12:40:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2138577115
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837604; cv=none; b=ApSCc/IpPbxSkgc7oNq4hWJdhT2A/sKEdz7XBhZwi/Fg3hVxknmjbpPqbsOVermet+ZEs207y9NkVOALNGHoft1tGp/X/SLdHZ6Vd6jxvfG+Yhrrq41ne6vA8LYAdrGGmFodGY04SRHejYN+pSK6PEoJToXD9VU4T/npQ8yJNpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837604; c=relaxed/simple;
	bh=J+H5UKWgYzC7vHdzBbsztrubuN+R2ryxmUAqzToRA/o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VrtyEzxSfmifsu31Ea5fkCxi4dXbxLnU5UyjmoWKIHaCktk8Q5FVpblbANgfEdS/o6v8Q6fHYO7s+c1LrSw3l0YzwM8ChtoO4z5lRTHEzJCcTTz+fKRGyJwzklhH0MnAV4sJcWGlhQ9rrSXN0/SExJwHkI2JfwtiHCDg6+KKWfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f61da2de1eso316536139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 05:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719837602; x=1720442402;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YJTKaR9V+bhTIjvCX9awLS/dYvrnWBq/4WYc0wqzcXo=;
        b=b6NxEy9jpqLbpm362lLGTq1/oU61UX72odmf+YUv7M0MKbRVlh1ge31FIUhAbnCIKx
         HHlM+urxCBrdzBTEGY83bySzg+Uy1KNTuU36hOfghYmSfM47arQm1Qvk6aGBSetzhxIt
         5zIqDJnJbvuz7oSyZnQJSDURfqUV9Zj8WYWEVhdHU+rgKXvVGmb2ZUw2bH9DTaH/HI3C
         PyJoac6WThPMHsI/n7FI8e4HaZ9RhSCgr2M0NtQij3MPAwZECvlYcZo9bJqLwNh7I3Vc
         FbellNcRcP9y2422OFGXqGtU0YCKgHbXZZq+N78ewuJaPjSpXtlGRRCCx/t7Tb1Ye3M3
         +u2w==
X-Gm-Message-State: AOJu0YyDmNj4tK70PPwOl9pC4PI+t7O1Y91mfXCC3Xj1OmMxWteCRgFg
	z1k6lSlU5m2JrDZGwYJ0RN4WOaVMZ5DHW9Z6KSI3ygjr0iqMYMGnNrPpbX9UlURyXk7y/A5RiI6
	AZk1giW8GLytkJ5B5a8yTtR2D/90TalANqMxk3yE5Fm7P8LOKGvhhLrI=
X-Google-Smtp-Source: AGHT+IGm+MJea1H0xFdonl2/ViMaxPJPY533DO5RDlmJjlb/kb58Le7Cv2yASxLR8pUHvOHVoGkuTbbLwH4h30kWEkdN2s/2D4UZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:238e:b0:4b9:b122:d07d with SMTP id
 8926c6da1cb9f-4bbb6e7ca4fmr463602173.4.1719837602043; Mon, 01 Jul 2024
 05:40:02 -0700 (PDT)
Date: Mon, 01 Jul 2024 05:40:02 -0700
In-Reply-To: <20240701101742.15473-1-wojciech.gladysz@infogain.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000576bfa061c2ee53e@google.com>
Subject: Re: [syzbot] [bpf?] [net?] KMSAN: uninit-value in bpf_prog_test_run_xdp
From: syzbot <syzbot+6856926fbb5e9b794e5c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in bpf_prog_test_run_xdp

=====================================================
BUG: KMSAN: uninit-value in bpf_prog_test_run_xdp+0x175d/0x1a40 net/bpf/test_run.c:1287
 bpf_prog_test_run_xdp+0x175d/0x1a40 net/bpf/test_run.c:1287
 bpf_prog_test_run+0x6b7/0xad0 kernel/bpf/syscall.c:4240
 __sys_bpf+0x6aa/0xd90 kernel/bpf/syscall.c:5649
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5736
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was stored to memory at:
 bpf_test_run+0x52e/0xc30
 bpf_prog_test_run_xdp+0xeaa/0x1a40 net/bpf/test_run.c:1277
 bpf_prog_test_run+0x6b7/0xad0 kernel/bpf/syscall.c:4240
 __sys_bpf+0x6aa/0xd90 kernel/bpf/syscall.c:5649
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5736
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was stored to memory at:
 ___bpf_prog_run+0x58c4/0xe0f0
 __bpf_prog_run512+0xb5/0xe0 kernel/bpf/core.c:2252
 bpf_dispatcher_nop_func include/linux/bpf.h:1233 [inline]
 __bpf_prog_run include/linux/filter.h:667 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_test_run+0x43e/0xc30 net/bpf/test_run.c:423
 bpf_prog_test_run_xdp+0xeaa/0x1a40 net/bpf/test_run.c:1277
 bpf_prog_test_run+0x6b7/0xad0 kernel/bpf/syscall.c:4240
 __sys_bpf+0x6aa/0xd90 kernel/bpf/syscall.c:5649
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5736
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was stored to memory at:
 ___bpf_prog_run+0x9098/0xe0f0
 __bpf_prog_run512+0xb5/0xe0 kernel/bpf/core.c:2252
 bpf_dispatcher_nop_func include/linux/bpf.h:1233 [inline]
 __bpf_prog_run include/linux/filter.h:667 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_test_run+0x43e/0xc30 net/bpf/test_run.c:423
 bpf_prog_test_run_xdp+0xeaa/0x1a40 net/bpf/test_run.c:1277
 bpf_prog_test_run+0x6b7/0xad0 kernel/bpf/syscall.c:4240
 __sys_bpf+0x6aa/0xd90 kernel/bpf/syscall.c:5649
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5736
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Local variable stack created at:
 __bpf_prog_run512+0x45/0xe0 kernel/bpf/core.c:2252
 bpf_dispatcher_nop_func include/linux/bpf.h:1233 [inline]
 __bpf_prog_run include/linux/filter.h:667 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_test_run+0x43e/0xc30 net/bpf/test_run.c:423

CPU: 0 PID: 5442 Comm: syz-executor.0 Not tainted 6.9.0-rc1-syzkaller-00257-ge478cf26c556-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
=====================================================


Tested on:

commit:         e478cf26 Merge branch 'bpf-fix-a-couple-of-test-failur..
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux
console output: https://syzkaller.appspot.com/x/log.txt?x=14d7871e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2599baf258ef795
dashboard link: https://syzkaller.appspot.com/bug?extid=6856926fbb5e9b794e5c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=162e5ed1980000


