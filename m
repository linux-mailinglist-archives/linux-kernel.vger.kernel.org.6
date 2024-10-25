Return-Path: <linux-kernel+bounces-381893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9379B05EF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8268B23E2F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135EF1FDF81;
	Fri, 25 Oct 2024 14:37:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC6C1632D0
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 14:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729867025; cv=none; b=GiNWpfbG9li8+VLri96Ta3sH0uTRQRIT6wbX0jASNjn3aX97SRiHqHIKk3KPmvtg6HL1042qXpDy1VmCOC961iuIaqyAcn6D6jVtzXq2HZ+szt8CYNVI2xcue9ypKgTxP7+V9HlxGCTTTNAl6R7hNs1pzw7GDqu6eJnOPBr5Lfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729867025; c=relaxed/simple;
	bh=i5kyUGmngpeEbSoHcqf4R/ifjOxSrrB/7qxlrN4APLU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=StygXuEmXbLN6qYWTKsvfZ288t7zewgSExnVDv2zF1r3OXSwuEtKIcnr+FXZDsTMfiCIcYmTPyDbXR+N75DsXNQyGYIZZ8Bzlvaq8kFqK6G+gjjpHk/vNJI/G8Xu51YTUmKbepqdV/pwhuYR1tzhjQgSaOaH1zchcpq17hAbqj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a4e5c68f6bso8604685ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729867023; x=1730471823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAP+JQm7MtQXN5qC0edOO4xnIqWWt6/i4z24NVYYOX0=;
        b=oAhyeKHT4LErsaGefs1zx5+vUPQmkrFxrKi3PVYM5HdbvgB2b43ICU7ETtlHHsBmeW
         Xl3JExXY4Tr3wOZbSm+4+GNXAyqP+oMbWtFVsWSdDweKVIqvxowzsfegmgH45eZe6Ntg
         ERqn4cKY+xd1Ce3M04LKRsx/7jLEsRdnngRnGkMm+86CfzIGh1gZUCGx50CD0paPG9Xd
         DUONtakGAzzz0C1PtMi4LTYbsC7EFGCL3teGmhOhEQ5e9AHvnWT+PguyiXlExyU5aEyn
         WBvmn1W2ZyKV3vJgLY217F+n8gfqNNuBgwaLDUCfe3t0UN1FjxAyqSi9ZraeBGBvgNfG
         GgfA==
X-Forwarded-Encrypted: i=1; AJvYcCWAGo/ugjLTYU8vi1wEHKeKjgFPQIRT3Nlm3eqFHTMlB6aL8JX0cibGqgTsEQrJQmtIY6Yci/Do3s3JJFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCj1nqoEPBAetvfbm3t8SsEMoh9lNR+4bLM1IVLp/eyNY79yKZ
	qvRgAckBBRymKZ97/z2rHNU7ivdmqvVd+4mI8KTyC6ReX5xIep7otgGfqPjCnzqGFgkByuGdd+s
	HjHLze2nOKgIttu2L9kJUxMp+G1q1AP7qln2CIFYn6rVgUhfVFNoORSo=
X-Google-Smtp-Source: AGHT+IHFSkC4mJvRLd1l6cWmhVvnv9f3tn2kYer9lnjWnNOXP7XH2ec45RZ5H7pHdpM/vuVPBqj+KPMYEJC0l9kiHWl4qQen32YZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d01:b0:3a3:b240:ff71 with SMTP id
 e9e14a558f8ab-3a4d5938519mr103662995ab.4.1729867022836; Fri, 25 Oct 2024
 07:37:02 -0700 (PDT)
Date: Fri, 25 Oct 2024 07:37:02 -0700
In-Reply-To: <8f093f2e-04ff-497d-b857-c328e4e6746a@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671bad0e.050a0220.2e773.0006.GAE@google.com>
Subject: Re: [syzbot] [erofs?] BUG: unable to handle kernel NULL pointer
 dereference in read_cache_folio
From: syzbot <syzbot+4089e577072948ac5531@syzkaller.appspotmail.com>
To: gianf.trad@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: unable to handle kernel NULL pointer dereference in read_cache_folio

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Mem abort info:
  ESR = 0x0000000086000006
  EC = 0x21: IABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
user pgtable: 4k pages, 52-bit VAs, pgdp=0000000045e33a80
[0000000000000000] pgd=080000004bfb6003, p4d=080000004bd49003, pud=080000004bde6003, pmd=0000000000000000
Internal error: Oops: 0000000086000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 UID: 0 PID: 3935 Comm: syz.0.15 Tainted: G    B              6.12.0-rc4-syzkaller-gae90f6a6170d #0
Tainted: [B]=BAD_PAGE
Hardware name: linux,dummy-virt (DT)
pstate: 61400809 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=-c)
pc : 0x0
lr : filemap_read_folio+0x44/0xf4 mm/filemap.c:2367
sp : ffff8000897b3ac0
x29: ffff8000897b3ac0 x28: fdf0000003bf9180 x27: 0000000020ffd000
x26: 0000000000000000 x25: 0000000000000000 x24: 0000000002100cca
x23: f6f0000003c63780 x22: 0000000000000000 x21: f6f0000003c63780
x20: 0000000000000000 x19: ffffc1ffc0354cc0 x18: ffff8000897b3c20
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000001
x14: 0000000000000000 x13: 0000000000000003 x12: 000000000006b8f7
x11: 0000000000000001 x10: ffff800081f1ae18 x9 : 0000000000000000
x8 : fff07ffffd1ef000 x7 : fff000007f8e9d58 x6 : 0000000000000001
x5 : ffffc1ffc0354cc0 x4 : 0000000000000000 x3 : fbf0000004756d80
x2 : 0000000000000000 x1 : ffffc1ffc0354cc0 x0 : f6f0000003c63780
Call trace:
 0x0
 do_read_cache_folio+0x18c/0x29c mm/filemap.c:3825
 read_cache_folio+0x14/0x20 mm/filemap.c:3857
 freader_get_folio+0x1bc/0x214 lib/buildid.c:77
 freader_fetch+0x44/0x164 lib/buildid.c:120
 __build_id_parse.isra.0+0x98/0x2a8 lib/buildid.c:305
 build_id_parse+0x18/0x24 lib/buildid.c:359
 do_procmap_query+0x670/0x7a0 fs/proc/task_mmu.c:534
 procfs_procmap_ioctl+0x2c/0x44 fs/proc/task_mmu.c:613
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __arm64_sys_ioctl+0xac/0xf0 fs/ioctl.c:893
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x48/0x110 arch/arm64/kernel/syscall.c:49
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:151
 el0_svc+0x34/0xec arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
Code: ???????? ???????? ???????? ???????? (????????) 
---[ end trace 0000000000000000 ]---


Tested on:

commit:         ae90f6a6 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16d3de40580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed4ea7a5e1330003
dashboard link: https://syzkaller.appspot.com/bug?extid=4089e577072948ac5531
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.

