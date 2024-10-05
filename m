Return-Path: <linux-kernel+bounces-351986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D189918B7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 19:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8643B20E5D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 17:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD3B158A1F;
	Sat,  5 Oct 2024 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+ofos39"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945DF1B960
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728148371; cv=none; b=f3pQmJd0KugC1S+4hmQoL2AOLpSkqKcAxDW2sPnONoK6JZQ1Laan4HeqmAGIwqoeoeXJ1jYkUp8ztr0E0VkYsoSl9EjBlClB/Wr1rmg2b4UUDOhbumslB0A29wx/1qdgd3TKTMfqunsjA18Ve/z1eWdKz2wjVy/pZp6CosuTZJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728148371; c=relaxed/simple;
	bh=qA4Kb70nMLfOZ9+Gu0UDEMSanL+bg90/3Lc7G0xjTuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9n1gzEFanUprQD5rk42CPCuObERCIq+9AZYSqbep93fDxPLw4BSLQILLJm7lyaOFd/dskNWYUlT31Cg6gmXVI9QQfSJKQm9aEqtUXAxWPy8JkblPwap5EsEV2ybC4LRcuKbfFD/Wj42jloVQ89IXg9HLxwK+3vK2qONhEjctgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+ofos39; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71dec1cf48fso1339110b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 10:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728148369; x=1728753169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fMWPlNWWXTGb7OtDpFy3gXAwrALuscHO9LtwDhUXN6s=;
        b=h+ofos39tkprhA21hCXHXgDHlEEZBxFsPFJFbnkyhHLIPK1XYkl68Yo1mT7BgC7lGk
         iUGA269I0C8YaILcR7w9FQv4I2vIWihUWN19mg5Db4IEI7s2lHqWYmEzfecUNmhSUL+S
         NkwUEeXU2Hrkfw44MyuIsUcgFLaWmaG42OG288eOw1IRYARbMsNCaRny1uy0usejrEuX
         4ocarVHAM/w1PGK04UcfT03Yf5nsa6Jcl8kUA8JINH2NkhrBWcFTUKOzC2HQz8ZotOFr
         B728oW0U2pBMclH6WKoi1Q3HW60Wi+5zkIasPCDs9Bp/UZogd1aGhl8zbYoxZfxUx10Y
         A7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728148369; x=1728753169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMWPlNWWXTGb7OtDpFy3gXAwrALuscHO9LtwDhUXN6s=;
        b=fP/fTMjQq8x1bFKyNHtPS9VOKzkXcPtXLL+/X/I8tWPjAY/O2FjAxAnjhffdiOW1Jt
         d9rYnF2m9cmf/5r090gVv09V3J5l653TrVU5GGS3gb15ZUJKD1rp1Fx3a2/XXsSHxFq8
         thwYukPcabb89dG72k/jI6o1NrCrWl91OKySktW7PeFP8isKzVZxbU+WDx3EDojRPDil
         YOQC7wkDoItbVARxCsXe/rIpb2MLiAQbY0Aiad/0TUmhKwHSjrvaRD+Ub3JuXLyhWJP4
         pOXBakGB8D0xlndD6B9eTDtZS7bo3XV7aMwO+5p5G+dxJops3EUCi8GHg/vYZ4iKa6wA
         1VpQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/+Hxt4JhdpKdoYwyJGhmRuQySuii7cNW2AGGpcmhy8fdlIjZCPMonBEs77z31sYV5Be7TzSbeWTs6rx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF+5Iwz+VLM8q2HqtLkUQiFjnUx0Y76RCXJDQZuR89NCy/oagb
	M3lzU3TLBXrlIDnxt5wp8Q/9nrLEVSJuHaImq5j3H30wTAGbX8DQ
X-Google-Smtp-Source: AGHT+IH2x8/1WWH8WpYqqnFgHANq2gUXUzzLwUNi85zKAghrNgRgluSTu2bqzhYglFIl65mGtDDlQQ==
X-Received: by 2002:a05:6a00:2ea2:b0:714:1f6d:11e5 with SMTP id d2e1a72fcca58-71de23b720cmr10432312b3a.12.1728148368733;
        Sat, 05 Oct 2024 10:12:48 -0700 (PDT)
Received: from nuc10 ([74.3.163.187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbf602sm1698217b3a.37.2024.10.05.10.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 10:12:47 -0700 (PDT)
Date: Sat, 5 Oct 2024 10:12:46 -0700
From: Rustam Kovhaev <rkovhaev@gmail.com>
To: syzbot <syzbot+013715179d3f910d4c86@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING in page_counter_cancel (5)
Message-ID: <20241005171246.GA2236@nuc10>
References: <67000a50.050a0220.49194.048d.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67000a50.050a0220.49194.048d.GAE@google.com>

On Fri, Oct 04, 2024 at 08:31:28AM -0700, syzbot wrote:
> ------------[ cut here ]------------
> page_counter underflow: -512 nr_pages=512
> WARNING: CPU: 1 PID: 5225 at mm/page_counter.c:60 page_counter_cancel+0x110/0x170 mm/page_counter.c:60
> Modules linked in:
> CPU: 1 UID: 0 PID: 5225 Comm: syz-executor334 Not tainted 6.12.0-rc1-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> RIP: 0010:page_counter_cancel+0x110/0x170 mm/page_counter.c:60
> Code: e8 55 23 98 ff 45 84 ed 75 24 e8 6b 21 98 ff c6 05 1a ef 10 0e 01 90 48 c7 c7 c0 9d 5c 8b 4c 89 e2 48 89 ee e8 91 9a 59 ff 90 <0f> 0b 90 90 e8 47 21 98 ff be 08 00 00 00 48 89 df e8 9a 71 f9 ff
> RSP: 0018:ffffc900032dfae8 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: ffff8881404a9440 RCX: ffffffff814e2a49
> RDX: ffff88801df38000 RSI: ffffffff814e2a56 RDI: 0000000000000001
> RBP: fffffffffffffe00 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000200
> R13: 0000000000000000 R14: 0000000000000001 R15: ffff888077bbdc18
> FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f6b788f5243 CR3: 000000007ec10000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  page_counter_uncharge+0x32/0x70 mm/page_counter.c:182
>  hugetlb_cgroup_uncharge_counter+0xd6/0x410 mm/hugetlb_cgroup.c:431
>  hugetlb_vm_op_close+0x3fe/0x5b0 mm/hugetlb.c:5065
>  remove_vma+0xa8/0x1a0 mm/vma.c:330
>  exit_mmap+0x4e0/0xb30 mm/mmap.c:1888
>  __mmput+0x12a/0x480 kernel/fork.c:1347
>  mmput+0x62/0x70 kernel/fork.c:1369
>  exit_mm kernel/exit.c:571 [inline]
>  do_exit+0x9bf/0x2d70 kernel/exit.c:926
>  do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
>  __do_sys_exit_group kernel/exit.c:1099 [inline]
>  __se_sys_exit_group kernel/exit.c:1097 [inline]
>  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
>  x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f6b7889d879
> Code: Unable to access opcode bytes at 0x7f6b7889d84f.
> RSP: 002b:00007ffcea637828 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6b7889d879
> RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
> RBP: 00007f6b78911350 R08: ffffffffffffffb8 R09: 0000000000000000
> R10: 0000000000000003 R11: 0000000000000246 R12: 00007f6b78911350
> R13: 0000000000000000 R14: 00007f6b78911da0 R15: 00007f6b78866f40
>  </TASK>
> 
Hello,
Reproduced the same issue in my lab. I'll try to take my chances and fix
this one, unless someone is already working on it.
In copy_vma() we go to out_vma_link and execute hugetlb_vm_op_close()
which uncharges the counter to 0.
Then, when the process terminates we execute hugetlb_vm_op_close() again
against the same vma and the counter goes negative.


