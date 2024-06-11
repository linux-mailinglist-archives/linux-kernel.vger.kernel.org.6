Return-Path: <linux-kernel+bounces-209621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28B5903883
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AA5C1C21FC3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5B7178381;
	Tue, 11 Jun 2024 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tf/rxAEP"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECFB4502C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718100872; cv=none; b=rRMZguSpbyiccicF52ubZCozX1cifm+AOkjQkyfZNbIATBwBmyKL0zmASYeIza/LC1RvBAB9VPHHddYo41lNfbpBKuQNb8eypyFE76Qt7rZ9wqdGI1YZ+pJNgBl+lU+d9SHHDdScs7/eiv8ENds2PyBD4XYhxwUYkZMxE9dgrUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718100872; c=relaxed/simple;
	bh=iKGvUEHOkDWAWbm4FC3suiyvbneE9PgG55/ovOVkw9E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=QTq4+wyLBJznE7wwyFWKyfO+GP7/n+zmDiMMOA87YYErAn22/8kvFSj1BMZoi/RK8l3lt1LXSxvo/eT+6RfCT8q96XDu/ny9EC6zRlEEDyvn2Chrz4jmvAaBIvV38EaMG7ZE2/GL/DVSap68k7Er3LGX8dAIhBmgisAhuSR2a3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tf/rxAEP; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-48c54370c56so646944137.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 03:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718100868; x=1718705668; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xv4FPghCBNdh80KsgjAzya6Doag1UITFNvJMLBijXlc=;
        b=Tf/rxAEPJRF6dvKo4KSkLm2yt3Y80N6B+9Rxl0JLDFmvBqTia9yHgNTeBADsKXQVJz
         yYj9xZbZ2hX33eLZKYyYi14alNH1l58jFRczVGwaRPulOKwZvRfgSs3S7TeqNnoP3s4W
         q18Lzzz9GL7KHoYhopKHyH5fOTIiez5Yz5teN/ckUXdn2dmcILyeXVfAtLEzOzHWZObM
         HNQqGSKRMQXrn85WWMC9Jnp2SrJ+kc+5zlwty9tA37L0IQ4vWCPa0cpxeBc0uQqz07E8
         jWu7qe5BttBMRbjulqo662lMcVI1N8dehCp7K+MurSMQHnA+er9rFaT4iCU3j1t02F93
         VhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718100868; x=1718705668;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xv4FPghCBNdh80KsgjAzya6Doag1UITFNvJMLBijXlc=;
        b=Mg8uHCY/62IQfxk3Oco+Mi0MMDJW7xjX1X30kmWJq03Y6pjoo/ymdAQox3kT3313hF
         D5f/L52nki21dV8RsxHVCWXrnGvPjQN88XQvc6wtSmD6yEsg114kJqmRGMQc5k3SWp1f
         5Envwm9KEE2AqVTsML9Q8k89/3oBH914vtlnhxAX3jRasyO9D5ZD/q4EIZM1M/I5xiAz
         XFqEdj8V3vv30lBK/i+axwUPpn57Y87E4yx3Sq9AUBtDrPwZfi3IhF/jl5seU+/T9CGo
         AoJjhkiYAHSaiClkiqEQOK7iJdRNDjlhzYKY+AR6L9sG9MfkF/KBwA2vT+l62N3aUuoJ
         Ypfg==
X-Gm-Message-State: AOJu0YwGs5uV45gPOmKvveZ0o8kAaxpeNg2ryRlCprPDOAYh3kU8GwFE
	s1XShsJ4grr2LFCQNKIdQW7gRm0fFcAkhj/fICdUm7jsXLTFL4k5YMaH8x/opKMb4T2OuKvlD3d
	lkv5vDxUW+AsEn6/ZPv3uW5K6PFAYxlElnYMeEKWdKP7/Uyj8txY=
X-Google-Smtp-Source: AGHT+IESfgUR+r8qqluSdcXGGPAP4rluNhs7qNtZjNO7RLCzq0+wiQQ0UWVouENGnNf/qQnyh6XHVjCTPCovll7lIuk=
X-Received: by 2002:a67:f851:0:b0:48c:3b13:7ff5 with SMTP id
 ada2fe7eead31-48c3b138113mr8689740137.22.1718100867787; Tue, 11 Jun 2024
 03:14:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 11 Jun 2024 15:44:15 +0530
Message-ID: <CA+G9fYvKmr84WzTArmfaypKM9+=Aw0uXCtuUKHQKFCNMGJyOgQ@mail.gmail.com>
Subject: LTP: fork13: kernel panic on rk3399-rock-pi-4 running mainline 6.10.rc3
To: open list <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <baohua@kernel.org>, 
	David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The kernel panic was noticed while running LTP syscalls fork13 (long running) on
the mainline master 6.10.rc3 kernel on arm64 rk3399-rock-pi-4 device.

Please find detailed logs in the links,

As you know fork13 is a stress test case trying to generate a maximum number
of PID's in a 100,000 loop.

This device is running via NFS mounted filesystem.

I have tried to reproduce this problem in a loop but failed to reproduce the
crash.


Crash flow:
------
fork13 run started
BUG: Bad page map in process fork13
BUG: Bad rss-counter state mm:
Unable to handle kernel paging request at virtual address
Internal error: Oops: 0000000096000046
run for 800 secs ( 13 minutes) and more.
fork14 run started and completed

fpathconf01 run started and completed
sugov:

Unable to handle kernel NULL pointer dereference at virtual address

Insufficient stack space to handle exception!
end Kernel panic - not syncing: kernel stack overflow

I have tried to decode stack dump by not being useful [1].
[1] https://people.linaro.org/~naresh.kamboju/output-rk3399.txt

Test log :
--------
tst_test.c:1733: TINFO: LTP version: 20240524
tst_test.c:1617: TINFO: Timeout per run is 0h 15m 00s
[  904.280569] BUG: Bad page map in process fork13  pte:2000000019ffc3
pmd:80000000df55003
[  904.281397] page: refcount:1 mapcount:-1 mapping:0000000000000000
index:0x0 pfn:0x19f
[  904.282098] flags:
0x3fffe0000002004(referenced|reserved|node=0|zone=0|lastcpupid=0x1ffff)
[  904.282842] raw: 03fffe0000002004 fffffdffc00067c8 fffffdffc00067c8
0000000000000000
[  904.283532] raw: 0000000000000000 0000000000000000 00000001fffffffe
0000000000000000
[  904.284216] page dumped because: bad pte
[  904.284572] addr:0000aaaad9af9000 vm_flags:00000075
anon_vma:0000000000000000 mapping:ffff0000300d4188 index:29
[  904.285512] file:fork13 fault:filemap_fault mmap:nfs_file_mmap
read_folio:nfs_read_folio
[  904.286267] CPU: 3 PID: 22685 Comm: fork13 Not tainted 6.10.0-rc3 #1
[  904.286831] Hardware name: Radxa ROCK Pi 4B (DT)
[  904.287239] Call trace:
[  904.287458]  dump_backtrace+0x108/0x190
[  904.287805]  show_stack+0x24/0x38
[  904.288103]  dump_stack_lvl+0x40/0xa0
[  904.288436]  dump_stack+0x18/0x28
[  904.288736]  print_bad_pte+0x234/0x298
[  904.289075]  unmap_page_range+0xb24/0xe90
[  904.289434]  unmap_vmas+0x118/0x1c8
[  904.289748]  exit_mmap+0x108/0x440
[  904.290055]  __mmput+0x48/0x150
[  904.290340]  mmput+0x34/0x70
[  904.290603]  exit_mm+0xb0/0x138
[  904.290887]  do_exit+0x1b4/0x938
[  904.291177]  do_group_exit+0xa4/0xb0
[  904.291498]  __arm64_sys_exit_group+0x24/0x30
[  904.291887]  invoke_syscall+0x4c/0x118
[  904.292229]  el0_svc_common+0xb4/0xf0
[  904.292559]  do_el0_svc+0x28/0x40
[  904.292859]  el0_svc+0x40/0x88
[  904.293138]  el0t_64_sync_handler+0x90/0x100
[  904.293522]  el0t_64_sync+0x190/0x198
[  904.293916] Disabling lock debugging due to kernel taint
[  904.294564] BUG: Bad page map in process fork13  pte:200000002e4fc3
pmd:80000000df55003
[  904.295275] page: refcount:2 mapcount:-1 mapping:000000007885152f
index:0x6 pfn:0x2e4
[  904.295973] memcg:ffff0000016b4000
[  904.296282] aops:nfs_file_aops ino:853161 dentry name:"libonig.so.5.4.0"
[  904.296887] flags:
0x3fffe0000000028(uptodate|lru|node=0|zone=0|lastcpupid=0x1ffff)
[  904.297619] raw: 03fffe0000000028 fffffdffc000b8c8 fffffdffc000b948
ffff0000009fa048
[  904.298305] raw: 0000000000000006 0000000000000000 00000002fffffffe
ffff0000016b4000
[  904.298985] page dumped because: bad pte
[  904.299337] addr:0000aaaad9afb000 vm_flags:00000075
anon_vma:0000000000000000 mapping:ffff0000300d4188 index:2b
[  904.300224] file:fork13 fault:filemap_fault mmap:nfs_file_mmap
read_folio:nfs_read_folio
[  904.300959] CPU: 3 PID: 22685 Comm: fork13 Tainted: G    B
    6.10.0-rc3 #1
[  904.301647] Hardware name: Radxa ROCK Pi 4B (DT)
[  904.302054] Call trace:
[  904.302272]  dump_backtrace+0x108/0x190
[  904.302616]  show_stack+0x24/0x38
[  904.302912]  dump_stack_lvl+0x40/0xa0
[  904.303243]  dump_stack+0x18/0x28
[  904.303540]  print_bad_pte+0x234/0x298
[  904.303876]  unmap_page_range+0xb24/0xe90
[  904.304235]  unmap_vmas+0x118/0x1c8
[  904.304547]  exit_mmap+0x108/0x440
[  904.304852]  __mmput+0x48/0x150
[  904.305136]  mmput+0x34/0x70
[  904.305396]  exit_mm+0xb0/0x138
[  904.305678]  do_exit+0x1b4/0x938
[  904.305966]  do_group_exit+0xa4/0xb0
[  904.306285]  __arm64_sys_exit_group+0x24/0x30
[  904.306672]  invoke_syscall+0x4c/0x118
[  904.307010]  el0_svc_common+0xb4/0xf0
[  904.307339]  do_el0_svc+0x28/0x40
[  904.307637]  el0_svc+0x40/0x88
[  904.307913]  el0t_64_sync_handler+0x90/0x100
[  904.308294]  el0t_64_sync+0x190/0x198
[  904.309309] BUG: Bad page map in process fork13  pte:20000000cc6fc3
pmd:80000000df55003
[  904.310031] page: refcount:1 mapcount:-1 mapping:0000000000000000
index:0x6 pfn:0xcc6
[  904.310728] head: order:3 mapcount:-1 entire_mapcount:0
nr_pages_mapped:8388607 pincount:0
[  904.311457] flags:
0x3fffe0000000044(referenced|head|node=0|zone=0|lastcpupid=0x1ffff)
[  904.312159] page_type: 0xffffefff(slab)
[  904.312509] raw: 03fffe0000000000 fffffdffc0033001 fffffdffc0033188
dead000000000400
[  904.313325] raw: 0000000000000000 0000000000000000 00000000fffffffe
0000000000000000
[  904.314020] head: 03fffe0000000044 ffff000000788200
dead000000000122 0000000000000000
[  904.314711] head: 0000000000000000 0000000000060006
00000001ffffefff 0000000000000000
[  904.315401] head: 03fffe0000000003 fffffdffc0033001
fffffffffffffffe 00000000ffffffff
[  904.316091] head: 0000000000000008 0000000000000000
00000000ffffffff 0000000000000000
[  904.316780] page dumped because: bad pte
[  904.317146] addr:0000aaaad9afc000 vm_flags:00000075
anon_vma:0000000000000000 mapping:ffff0000300d4188 index:2c
[  904.318036] file:fork13 fault:filemap_fault mmap:nfs_file_mmap
read_folio:nfs_read_folio
[  904.318774] CPU: 3 PID: 22685 Comm: fork13 Tainted: G    B
    6.10.0-rc3 #1
[  904.319463] Hardware name: Radxa ROCK Pi 4B (DT)
[  904.319869] Call trace:
[  904.320087]  dump_backtrace+0x108/0x190
[  904.320432]  show_stack+0x24/0x38
[  904.320728]  dump_stack_lvl+0x40/0xa0
[  904.321060]  dump_stack+0x18/0x28
[  904.321357]  print_bad_pte+0x234/0x298
[  904.321695]  unmap_page_range+0xb98/0xe90
[  904.322052]  unmap_vmas+0x118/0x1c8
[  904.322365]  exit_mmap+0x108/0x440
[  904.322670]  __mmput+0x48/0x150
[  904.322955]  mmput+0x34/0x70
[  904.323215]  exit_mm+0xb0/0x138
[  904.323498]  do_exit+0x1b4/0x938
[  904.323786]  do_group_exit+0xa4/0xb0
[  904.324106]  __arm64_sys_exit_group+0x24/0x30
[  904.324493]  invoke_syscall+0x4c/0x118
[  904.324831]  el0_svc_common+0xb4/0xf0
[  904.325158]  do_el0_svc+0x28/0x40
[  904.325456]  el0_svc+0x40/0x88
[  904.325733]  el0t_64_sync_handler+0x90/0x100
[  904.326114]  el0t_64_sync+0x190/0x198
[  904.326666] BUG: Bad page map in process fork13  pte:20000000268fc3
pmd:80000000df55003
[  904.327390] page: refcount:1 mapcount:-1 mapping:00000000f0624181
index:0x1b pfn:0x268
[  904.328094] memcg:ffff0000016b4000
[  904.328401] aops:nfs_file_aops ino:8526e6 dentry
name:"libgpg-error.so.0.36.0"
[  904.329051] flags:
0x3fffe000000002c(referenced|uptodate|lru|node=0|zone=0|lastcpupid=0x1ffff)
[  904.329878] raw: 03fffe000000002c fffffdffc0009a48 fffffdffc022f3c8
ffff00000688bd60
[  904.330561] raw: 000000000000001b 0000000000000000 00000001fffffffe
ffff0000016b4000
[  904.331240] page dumped because: bad pte
[  904.331590] addr:0000aaaad9afe000 vm_flags:00000075
anon_vma:0000000000000000 mapping:ffff0000300d4188 index:2e
[  904.332476] file:fork13 fault:filemap_fault mmap:nfs_file_mmap
read_folio:nfs_read_folio
[  904.333245] CPU: 5 PID: 22685 Comm: fork13 Tainted: G    B
    6.10.0-rc3 #1
[  904.333936] Hardware name: Radxa ROCK Pi 4B (DT)
[  904.334343] Call trace:
[  904.334562]  dump_backtrace+0x108/0x190
[  904.334905]  show_stack+0x24/0x38
[  904.335200]  dump_stack_lvl+0x40/0xa0
[  904.335529]  dump_stack+0x18/0x28
[  904.335826]  print_bad_pte+0x234/0x298
[  904.336161]  unmap_page_range+0xb24/0xe90
[  904.336517]  unmap_vmas+0x118/0x1c8
[  904.336828]  exit_mmap+0x108/0x440
[  904.337132]  __mmput+0x48/0x150
[  904.337415]  mmput+0x34/0x70
[  904.337675]  exit_mm+0xb0/0x138
[  904.337955]  do_exit+0x1b4/0x938
[  904.338242]  do_group_exit+0xa4/0xb0
[  904.338561]  __arm64_sys_exit_group+0x24/0x30
[  904.338946]  invoke_syscall+0x4c/0x118
[  904.339283]  el0_svc_common+0xb4/0xf0
[  904.339611]  do_el0_svc+0x28/0x40
[  904.339908]  el0_svc+0x40/0x88
[  904.340184]  el0t_64_sync_handler+0x90/0x100
[  904.340564]  el0t_64_sync+0x190/0x198
[  904.340903] BUG: Bad page map in process fork13  pte:20000000734fc3
pmd:80000000df55003
[  904.341613] page: refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x734
[  904.342294] head: order:1 mapcount:-1 entire_mapcount:0
nr_pages_mapped:8388607 pincount:0
[  904.343020] flags:
0x3fffe0000000044(referenced|head|node=0|zone=0|lastcpupid=0x1ffff)
[  904.343716] page_type: 0xffffeffe(slab|0x1)
[  904.344091] raw: 03fffe0000000044 ffff000000401a00 dead000000000122
0000000000000000
[  904.344771] raw: 0000000000000000 0000000000100010 00000001ffffeffe
0000000000000000
[  904.345463] head: 03fffe0000000044 ffff000000401a00
dead000000000122 0000000000000000
[  904.346152] head: 0000000000000000 0000000000100010
00000001ffffeffe 0000000000000000
[  904.346837] head: 03fffe0000000001 fffffdffc001cd01
fffffffffffffffe 00000000ffffffff
[  904.347524] head: 0000000000000002 0000000000000000
00000000ffffffff 0000000000000000
[  904.348208] page dumped because: bad pte
[  904.348555] addr:0000aaaad9aff000 vm_flags:00000075
anon_vma:0000000000000000 mapping:ffff0000300d4188 index:2f
[  904.349445] file:fork13 fault:filemap_fault mmap:nfs_file_mmap
read_folio:nfs_read_folio
[  904.350163] CPU: 5 PID: 22685 Comm: fork13 Tainted: G    B
    6.10.0-rc3 #1
[  904.350848] Hardware name: Radxa ROCK Pi 4B (DT)
[  904.351252] Call trace:
[  904.351469]  dump_backtrace+0x108/0x190
[  904.351807]  show_stack+0x24/0x38
[  904.352101]  dump_stack_lvl+0x40/0xa0
[  904.352427]  dump_stack+0x18/0x28
[  904.352722]  print_bad_pte+0x234/0x298
[  904.353056]  unmap_page_range+0xb98/0xe90
[  904.353412]  unmap_vmas+0x118/0x1c8
[  904.353722]  exit_mmap+0x108/0x440
[  904.354024]  __mmput+0x48/0x150
[  904.354304]  mmput+0x34/0x70
[  904.354562]  exit_mm+0xb0/0x138
[  904.354842]  do_exit+0x1b4/0x938
[  904.355128]  do_group_exit+0xa4/0xb0
[  904.355443]  __arm64_sys_exit_group+0x24/0x30
[  904.355828]  invoke_syscall+0x4c/0x118
[  904.356161]  el0_svc_common+0xb4/0xf0
[  904.356487]  do_el0_svc+0x28/0x40
[  904.356783]  el0_svc+0x40/0x88
[  904.357058]  el0t_64_sync_handler+0x90/0x100
[  904.357436]  el0t_64_sync+0x190/0x198
[  904.359764] BUG: Bad rss-counter state mm:00000000ed4ce266
type:MM_FILEPAGES val:1
[  904.360469] BUG: Bad rss-counter state mm:00000000ed4ce266
type:MM_ANONPAGES val:-1
[  904.432431] Unable to handle kernel paging request at virtual
address ffff00000019f000
[  904.433177] Mem abort info:
[  904.433452]   ESR = 0x0000000096000046
[  904.433789]   EC = 0x25: DABT (current EL), IL = 32 bits
[  904.434262]   SET = 0, FnV = 0
[  904.434538]   EA = 0, S1PTW = 0
[  904.434820]   FSC = 0x06: level 2 translation fault
[  904.435255] Data abort info:
[  904.435517]   ISV = 0, ISS = 0x00000046, ISS2 = 0x00000000
[  904.436812]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
[  904.437450]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  904.437937] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000004b1c000
[  904.438536] [ffff00000019f000] pgd=0000000000000000,
p4d=18000000f7dff003, pud=18000000f7dfe003, pmd=0000000000000000
[  904.439516] Internal error: Oops: 0000000096000046 [#1] PREEMPT SMP
[  904.440073] Modules linked in: overlay btrfs xor xor_neon raid6_pq
zstd_compress libcrc32c snd_soc_hdmi_codec brcmfmac dw_hdmi_i2s_audio
dw_hdmi_cec brcmutil hantro_vpu crct10dif_ce panfrost v4l2_h264
snd_soc_simple_card snd_soc_audio_graph_card gpu_sched hci_uart
snd_soc_spdif_tx v4l2_vp9 rockchipdrm snd_soc_simple_card_utils btqca
drm_shmem_helper btbcm dw_mipi_dsi analogix_dp bluetooth dw_hdmi
cfg80211 v4l2_mem2mem snd_soc_rockchip_i2s phy_rockchip_pcie
videobuf2_v4l2 cec videobuf2_dma_contig drm_display_helper
videobuf2_memops drm_dma_helper rfkill videobuf2_common rtc_rk808
snd_soc_es8316 rockchip_saradc drm_kms_helper
industrialio_triggered_buffer coresight_cpu_debug rockchip_thermal
kfifo_buf pcie_rockchip_host fuse drm backlight dm_mod ip_tables
x_tables
[  904.446155] CPU: 3 PID: 18150 Comm: fork13 Tainted: G    B
    6.10.0-rc3 #1
[  904.446848] Hardware name: Radxa ROCK Pi 4B (DT)
[  904.447257] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  904.447873] pc : clear_page+0x18/0x58
[  904.448213] lr : prep_new_page+0x90/0x188
[  904.448578] sp : ffff80008636b700
[  904.448874] x29: ffff80008636b700 x28: 0000000000000000 x27: fffffdffc00067c0
[  904.449513] x26: 0000000000000068 x25: ffff801000000000 x24: ffff7ff00019f000
[  904.450151] x23: 0000000000000001 x22: 0000000000440dc0 x21: 0000000000000000
[  904.450788] x20: 0000000000000801 x19: fffffdffc00067c0 x18: 0000000000000000
[  904.451426] x17: 0000000000000002 x16: ffff0000080ecc00 x15: 00000000ffffffff
[  904.452063] x14: ffff0000f75e2a00 x13: 0000000000000001 x12: 0000000000000000
[  904.452700] x11: 0000000000000000 x10: ffff800074e85000 x9 : ffff80008038b6d0
[  904.453337] x8 : ffff7ff00019f000 x7 : 0000000000000000 x6 : 0000000aaaadfa96
[  904.453974] x5 : ffff0000f7493f60 x4 : ffff0000f7493f40 x3 : 0000000000000801
[  904.454612] x2 : 0000000000000004 x1 : 0000000000000040 x0 : ffff00000019f000
[  904.455249] Call trace:
[  904.455469]  clear_page+0x18/0x58
[  904.455770]  get_page_from_freelist+0x1450/0x1498
[  904.456194]  __alloc_pages_noprof+0x164/0x328
[  904.456586]  alloc_pages_mpol_noprof+0x144/0x250
[  904.457003]  alloc_pages_noprof+0x8c/0xa0
[  904.457365]  __pte_alloc+0x40/0x210
[  904.457686]  copy_page_range+0x186c/0x1d28
[  904.458059]  copy_mm+0x538/0x8e0
[  904.458360]  copy_process+0x618/0xd20
[  904.458695]  kernel_clone+0xb8/0x368
[  904.459022]  __arm64_sys_clone+0x68/0xa0
[  904.459381]  invoke_syscall+0x4c/0x118
[  904.459727]  el0_svc_common+0xb4/0xf0
[  904.460064]  do_el0_svc+0x28/0x40
[  904.460371]  el0_svc+0x40/0x88
[  904.460656]  el0t_64_sync_handler+0x90/0x100
[  904.461046]  el0t_64_sync+0x190/0x198
[  904.461388] Code: 37200121 12000c21 d2800082 9ac12041 (d50b7420)
[  904.461929] ---[ end trace 0000000000000000 ]---
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Cannot kill test processes!
Congratulation, likely test hit a kernel bug.
Exiting uncleanly...
tst_test.c:1733: TINFO: LTP version: 20240524
tst_test.c:1617: TINFO: Timeout per run is 0h 05m 00s
[ 1754.220079] __vm_enough_memory: pid: 22760, comm: fork14, bytes:
4294967296 not enough memory for the allocation
[ 1754.221810] __vm_enough_memory: pid: 22760, comm: fork14, bytes:
5368709120 not enough memory for the allocation
[ 1754.223469] __vm_enough_memory: pid: 22760, comm: fork14, bytes:
6442450944 not enough memory for the allocation
[ 1754.225731] __vm_enough_memory: pid: 22760, comm: fork14, bytes:
7516192768 not enough memory for the allocation
[ 1754.227306] __vm_enough_memory: pid: 22760, comm: fork14, bytes:
8589934592 not enough memory for the allocation
[ 1754.228858] __vm_enough_memory: pid: 22760, comm: fork14, bytes:
9663676416 not enough memory for the allocation
[ 1754.230502] __vm_enough_memory: pid: 22760, comm: fork14, bytes:
10737418240 not enough memory for the allocation
[ 1754.232020] __vm_enough_memory: pid: 22760, comm: fork14, bytes:
11811160064 not enough memory for the allocation
[ 1754.233586] __vm_enough_memory: pid: 22760, comm: fork14, bytes:
12884901888 not enough memory for the allocation
[ 1754.235058] __vm_enough_memory: pid: 22760, comm: fork14, bytes:
13958643712 not enough memory for the allocation
fork14.c:93: TPASS: fork() failed as expected

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
tst_test.c:1733: TINFO: LTP version: 20240524
tst_test.c:1617: TINFO: Timeout per run is 0h 05m 00s
fpathconf01.c:36: TPASS: fpathconf(fd, tc->value) returned 255
fpathconf01.c:36: TPASS: fpathconf(fd, tc->value) returned 255
fpathconf01.c:36: TPASS: fpathconf(fd, tc->value) returned 0
fpathconf01.c:36: TPASS: fpathconf(fd, tc->value) returned 127
fpathconf01.c:36: TPASS: fpathconf(fd, tc->value) returned 255
fpathconf01.c:36: TPASS: fpathconf(fd, tc->value) returned 4096
fpathconf01.c:36: TPASS: fpathconf(fd, tc->value) returned 4096
fpathconf01.c:36: TPASS: fpathconf(fd, tc->value) returned 1
fpathconf01.c:36: TPASS: fpathconf(fd, tc->value) returned 1

Summary:
passed   9
failed   0
broken   0
skipped  0
warnings 0
[ 1760.029333] Unable to handle kernel paging request at virtual
address fffffffffffffe40
[ 1760.029659] Unable to handle kernel paging request at virtual
address 0040050000000070
[ 1760.030077] Mem abort info:
[ 1760.030763] Mem abort info:
[ 1760.030765]   ESR = 0x0000000096000004
[ 1760.030768]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1760.030771]   SET = 0, FnV = 0
[ 1760.030774]   EA = 0, S1PTW = 0
[ 1760.030776]   FSC = 0x04: level 0 translation fault
[ 1760.030779] Data abort info:
[ 1760.030781]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[ 1760.030784]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 1760.030786]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 1760.031040]   ESR = 0x0000000096000006
[ 1760.031280] [0040050000000070] address between user and kernel address ranges
[ 1760.031285] Internal error: Oops: 0000000096000004 [#2] PREEMPT SMP
[ 1760.031621]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1760.032082] Modules linked in: overlay
[ 1760.032359]   SET = 0, FnV = 0
[ 1760.032630]  btrfs xor xor_neon raid6_pq
[ 1760.033172]   EA = 0, S1PTW = 0
[ 1760.033317]  zstd_compress libcrc32c snd_soc_hdmi_codec brcmfmac
dw_hdmi_i2s_audio
[ 1760.033810]   FSC = 0x06: level 2 translation fault
[ 1760.034245]  dw_hdmi_cec brcmutil hantro_vpu crct10dif_ce panfrost
[ 1760.034721] Data abort info:
[ 1760.035045]  v4l2_h264 snd_soc_simple_card snd_soc_audio_graph_card
gpu_sched hci_uart
[ 1760.035678]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
[ 1760.036220]  snd_soc_spdif_tx v4l2_vp9 rockchipdrm snd_soc_simple_card_utils
[ 1760.036695]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 1760.037018]  btqca drm_shmem_helper btbcm dw_mipi_dsi
[ 1760.037327]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 1760.037638]  analogix_dp bluetooth dw_hdmi cfg80211 v4l2_mem2mem
snd_soc_rockchip_i2s
[ 1760.037930] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000004b1c000
[ 1760.038583]  phy_rockchip_pcie videobuf2_v4l2 cec
videobuf2_dma_contig drm_display_helper
[ 1760.039021] [fffffffffffffe40] pgd=0000000000000000
[ 1760.039553]  videobuf2_memops drm_dma_helper rfkill
videobuf2_common rtc_rk808
[ 1760.039818] , p4d=00000000054a3003
[ 1760.040501]  snd_soc_es8316 rockchip_saradc drm_kms_helper
industrialio_triggered_buffer
[ 1760.040992] , pud=00000000054a4003
[ 1760.041600]  coresight_cpu_debug rockchip_thermal kfifo_buf
pcie_rockchip_host fuse drm backlight dm_mod ip_tables x_tables
[ 1760.041622] CPU: 5 PID: 15526 Comm: kworker/u26:13 Tainted: G    B
D            6.10.0-rc3 #1
[ 1760.041628] Hardware name: Radxa ROCK Pi 4B (DT)
[ 1760.041637] Workqueue:  0x0
[ 1760.042085] , pmd=0000000000000000
[ 1760.042518]  (rpciod)
[ 1760.042523] pstate: a00000c5 (NzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 1760.042994]
[ 1760.043670] pc : __schedule+0x3d8/0x9a8
[ 1760.051229] lr : __schedule+0x22c/0x9a8
[ 1760.051572] sp : ffff8000858e3d30
[ 1760.051863] x29: ffff8000858e3d70 x28: ffff00000a0c0710 x27: ffff8000825f2008
[ 1760.052492] x26: ffff00000a0c0000 x25: ffff800082653458 x24: 0000000000000402
[ 1760.053119] x23: ffff800082bf0000 x22: ffff000000cc1300 x21: ffff8000815a5864
[ 1760.053745] x20: ffff00000a0c0000 x19: ffff0000f74d1900 x18: ffff8000815efc10
[ 1760.054371] x17: 0000000000000001 x16: 000000000005f400 x15: 0000000000000064
[ 1760.054998] x14: 0000000000000001 x13: 0000000000000004 x12: 00000009d5bb53d6
[ 1760.055625] x11: 00000001000591ce x10: 000000386c47db4f x9 : 0000000000000000
[ 1760.056252] x8 : ffff000001d517c0 x7 : 5702b6d600000000 x6 : 600aa44181070001
[ 1760.056878] x5 : ffff00002e631880 x4 : ffff8000858e3c74 x3 : 0000000000000004
[ 1760.057505] x2 : 0000000000000006 x1 : ffff00000a0c0080 x0 : 0040050000000000
[ 1760.058132] Call trace:
[ 1760.058352]  __schedule+0x3d8/0x9a8
[ 1760.058661]  schedule+0x12c/0x1e0
[ 1760.058956]  worker_thread+0xc4/0x3d8
[ 1760.059284]  kthread+0x104/0x1a8
[ 1760.059571]  ret_from_fork+0x10/0x20
[ 1760.059892] Code: f942c688 b40002c0 eb00011f 540001e0 (b9407009)
[ 1760.060425] ---[ end trace 0000000000000000 ]---
[ 1760.060831] note: kworker/u26:13[15526] exited with irqs disabled
[ 1760.060834] Internal error: Oops: 0000000096000006 [#3] PREEMPT SMP
[ 1760.061922] Modules linked in: overlay btrfs xor xor_neon raid6_pq
zstd_compress libcrc32c snd_soc_hdmi_codec brcmfmac dw_hdmi_i2s_audio
dw_hdmi_cec brcmutil hantro_vpu crct10dif_ce panfrost v4l2_h264
snd_soc_simple_card snd_soc_audio_graph_card gpu_sched hci_uart
snd_soc_spdif_tx v4l2_vp9 rockchipdrm snd_soc_simple_card_utils btqca
drm_shmem_helper btbcm dw_mipi_dsi analogix_dp bluetooth dw_hdmi
cfg80211 v4l2_mem2mem snd_soc_rockchip_i2s phy_rockchip_pcie
videobuf2_v4l2 cec videobuf2_dma_contig drm_display_helper
videobuf2_memops drm_dma_helper rfkill videobuf2_common rtc_rk808
snd_soc_es8316 rockchip_saradc drm_kms_helper
industrialio_triggered_buffer coresight_cpu_debug rockchip_thermal
kfifo_buf pcie_rockchip_host fuse drm backlight dm_mod ip_tables
x_tables
[ 1760.068164] CPU: 2 PID: 120 Comm: sugov:0 Tainted: G    B D
   6.10.0-rc3 #1
[ 1760.068862] Hardware name: Radxa ROCK Pi 4B (DT)
[ 1760.069279] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 1760.069905] pc : clk_propagate_rate_change+0x8c/0x160
[ 1760.070384] lr : clk_propagate_rate_change+0xb0/0x160
[ 1760.070848] sp : ffff8000837abaf0
[ 1760.071149] x29: ffff8000837abb10 x28: 0000000000000000 x27: 0000000000000000
[ 1760.071803] x26: ffff80008264ec68 x25: 00000000000927c0 x24: 0000000000000001
[ 1760.072456] x23: ffff8000837abd28 x22: 0000000000000000 x21: ffff800082875300
[ 1760.073107] x20: 0000000000000001 x19: ffff000000723000 x18: ffff0000026400d4
[ 1760.073759] x17: 00000000000927c0 x16: 0000000000000001 x15: 000000000000000c
[ 1760.074411] x14: 0000000000000000 x13: ffff8000837a8000 x12: 00000000000181c3
[ 1760.075061] x11: 0000000000000000 x10: 0000000000000001 x9 : 00000000000001f5
[ 1760.075713] x8 : fffffffffffffe40 x7 : 00000072b5503510 x6 : 0000000000300000
[ 1760.076365] x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000837ab990
[ 1760.077016] x2 : ffff00000611df00 x1 : 0000000000000000 x0 : 0000000000000001
[ 1760.077667] Call trace:
[ 1760.077893]  clk_propagate_rate_change+0x8c/0x160
[ 1760.078332]  clk_propagate_rate_change+0x128/0x160
[ 1760.078774]  clk_propagate_rate_change+0x128/0x160
[ 1760.079216]  clk_core_set_rate_nolock+0x1bc/0x3b0
[ 1760.079647]  clk_set_rate+0x9c/0x148
[ 1760.079979]  _opp_config_clk_single+0x44/0xa0
[ 1760.080382]  _set_opp+0x21c/0x508
[ 1760.080697]  dev_pm_opp_set_rate+0x110/0x1f8
[ 1760.081094]  set_target+0x3c/0x50
[ 1760.081409]  __cpufreq_driver_target+0x18c/0x2e8
[ 1760.081833]  sugov_work+0x5c/0x80
[ 1760.082146]  kthread_worker_fn+0xf0/0x238
[ 1760.082515]  kthread+0x104/0x1a8
[ 1760.082816]  ret_from_fork+0x10/0x20
[ 1760.083159] Code: f94002d6 eb1502df 54000180 d10702c8 (f9400108)
[ 1760.083703] ---[ end trace 0000000000000000 ]---
[ 1760.591975] Unable to handle kernel paging request at virtual
address 0000000001003fb8
[ 1760.592684] Mem abort info:
[ 1760.592931]   ESR = 0x0000000096000004
[ 1760.593260]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1760.593725]   SET = 0, FnV = 0
[ 1760.593993]   EA = 0, S1PTW = 0
[ 1760.594269]   FSC = 0x04: level 0 translation fault
[ 1760.594696] Data abort info:
[ 1760.594950]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[ 1760.595429]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 1760.595870]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 1760.596337] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000068
[ 1760.597101] Mem abort info:
[ 1760.597347]   ESR = 0x0000000096000004
[ 1760.597676]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1760.598140]   SET = 0, FnV = 0
[ 1760.598409]   EA = 0, S1PTW = 0
[ 1760.598684]   FSC = 0x04: level 0 translation fault
[ 1760.599111] Data abort info:
[ 1760.599364]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[ 1760.599843]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 1760.600284]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 1760.600748] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000068
[ 1760.601512] Mem abort info:
[ 1760.601758]   ESR = 0x0000000096000004
[ 1760.602087]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1760.602550]   SET = 0, FnV = 0
[ 1760.602820]   EA = 0, S1PTW = 0
[ 1760.603095]   FSC = 0x04: level 0 translation fault
[ 1760.603522] Data abort info:
[ 1760.603775]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[ 1760.604254]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 1760.604696]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 1760.605160] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000068
[ 1760.605923] Mem abort info:
[ 1760.606169]   ESR = 0x0000000096000004
[ 1760.606498]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1760.606961]   SET = 0, FnV = 0
[ 1760.607230]   EA = 0, S1PTW = 0
[ 1760.607507]   FSC = 0x04: level 0 translation fault
[ 1760.607933] Data abort info:
[ 1760.608187]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[ 1760.608665]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 1760.609106]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 1760.609570] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000068
[ 1760.610334] Mem abort info:
[ 1760.610580]   ESR = 0x0000000096000004
[ 1760.610908]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1760.611372]   SET = 0, FnV = 0
[ 1760.611639]   EA = 0, S1PTW = 0
[ 1760.611915]   FSC = 0x04: level 0 translation fault
[ 1760.612342] Data abort info:
[ 1760.612596]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[ 1760.613074]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 1760.613515]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 1760.613979] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000068
[ 1760.614742] Mem abort info:
[ 1760.614988]   ESR = 0x0000000096000004
[ 1760.615317]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1760.615780]   SET = 0, FnV = 0
[ 1760.616048]   EA = 0, S1PTW = 0
[ 1760.616323]   FSC = 0x04: level 0 translation fault
[ 1760.616750] Data abort info:
[ 1760.617003]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[ 1760.617482]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 1760.617922]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 1760.618386] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000068
[ 1760.619150] Mem abort info:
[ 1760.619396]   ESR = 0x0000000096000004
[ 1760.619725]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1760.620188]   SET = 0, FnV = 0
[ 1760.620457]   EA = 0, S1PTW = 0
[ 1760.620732]   FSC = 0x04: level 0 translation fault
[ 1760.621157] Data abort info:
[ 1760.621409]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[ 1760.621888]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 1760.622328]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 1760.622792] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000068
[ 1760.623555] Mem abort info:
[ 1760.623799]   ESR = 0x0000000096000004
[ 1760.624128]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1760.624591]   SET = 0, FnV = 0
[ 1760.624859]   EA = 0, S1PTW = 0
[ 1760.625134]   FSC = 0x04: level 0 translation fault
[ 1760.625559] Data abort info:
[ 1760.625811]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[ 1760.626289]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 1760.626730]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 1760.627194] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000068
[ 1760.627957] Mem abort info:
[ 1760.628203]   ESR = 0x0000000096000004
[ 1760.628532]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1760.628995]   SET = 0, FnV = 0
[ 1760.629264]   EA = 0, S1PTW = 0
[ 1760.629539]   FSC = 0x04: level 0 translation fault
[ 1760.629966] Data abort info:
[ 1760.630220]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[ 1760.630699]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 1760.631139]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 1760.631604] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000068
[ 1760.632367] Mem abort info:
[ 1760.632613]   ESR = 0x0000000096000004
[ 1760.632941]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1760.633405]   SET = 0, FnV = 0
[ 1760.633674]   EA = 0, S1PTW = 0
[ 1760.633949]   FSC = 0x04: level 0 translation fault
[ 1760.634376] Data abort info:
[ 1760.634629]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[ 1760.635108]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 1760.635549]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 1760.636013] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000068
[ 1760.636776] Mem abort info:
[ 1760.637022]   ESR = 0x0000000096000004
[ 1760.637350]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1760.637813]   SET = 0, FnV = 0
[ 1760.638082]   EA = 0, S1PTW = 0
[ 1760.638357]   FSC = 0x04: level 0 translation fault
[ 1760.638782] Data abort info:
[ 1760.639036]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[ 1760.639514]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 1760.639955]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 1760.640419] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000068
[ 1760.641182] Mem abort info:
[ 1760.641428]   ESR = 0x0000000096000004
[ 1760.641757]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1760.642220]   SET = 0, FnV = 0
[ 1760.642489]   EA = 0, S1PTW = 0
[ 1760.642764]   FSC = 0x04: level 0 translation fault
[ 1760.643190] Data abort info:
[ 1760.643442]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[ 1760.643920]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 1760.644363]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 1760.644827] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000068
[ 1760.645590] Mem abort info:
[ 1760.645836]   ESR = 0x0000000096000004
[ 1760.646164]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1760.646628]   SET = 0, FnV = 0
[ 1760.646897]   EA = 0, S1PTW = 0
[ 1760.647173]   FSC = 0x04: level 0 translation fault
[ 1760.647598] Data abort info:
[ 1760.647852]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[ 1760.648330]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 1760.648771]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 1760.649235] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000068
[ 1760.650000] Mem abort info:
[ 1760.650245]   ESR = 0x0000000096000004
[ 1760.650574]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1760.651037]   SET = 0, FnV = 0
[ 1760.651305]   EA = 0, S1PTW = 0
[ 1760.651580]   FSC = 0x04: level 0 translation fault
[ 1760.652007] Data abort info:
[ 1760.652259]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[ 1760.652737]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 1760.653178]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 1760.653642] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000068
[ 1760.654407] Mem abort info:
[ 1760.654653]   ESR = 0x0000000096000004
[ 1760.654981]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1760.655444]   SET = 0, FnV = 0
[ 1760.655712]   EA = 0, S1PTW = 0
[ 1760.655989]   FSC = 0x04: level 0 translation fault
[ 1760.656414] Data abort info:
[ 1760.656667]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[ 1760.657145]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 1760.657586]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 1760.658050] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000068
[ 1760.658814] Mem abort info:
[ 1760.659060]   ESR = 0x0000000096000004
[ 1760.659388]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1760.659851]   SET = 0, FnV = 0
[ 1760.660119]   EA = 0, S1PTW = 0
[ 1760.660394]   FSC = 0x04: level 0 translation fault
[ 1760.660820] Data abort info:
[ 1760.661074]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[ 1760.661552]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 1760.661992]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 1760.662456] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000068
[ 1760.663220] Mem abort info:
[ 1760.663466]   ESR = 0x0000000096000004
[ 1760.663794]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1760.664258]   SET = 0, FnV = 0
[ 1760.664527]   EA = 0, S1PTW = 0
[ 1760.664803]   FSC = 0x04: level 0 translation fault
[ 1760.665230] Data abort info:
[ 1760.665483]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[ 1760.665962]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 1760.666402]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 1760.666867] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000068
[ 1760.667630] Mem abort info:
[ 1760.667876]   ESR = 0x0000000096000004
[ 1760.668204]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1760.668668]   SET = 0, FnV = 0
[ 1760.668937]   EA = 0, S1PTW = 0
[ 1760.669213]   FSC = 0x04: level 0 translation fault
[ 1760.669640] Data abort info:
[ 1760.669892]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[ 1760.670370]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 1760.670811]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 1760.671275] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000068
[ 1760.672038] Mem abort info:
[ 1760.672284]   ESR = 0x0000000096000004
[ 1760.672612]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1760.673076]   SET = 0, FnV = 0
[ 1760.673345]   EA = 0, S1PTW = 0
[ 1760.673622]   FSC = 0x04: level 0 translation fault
[ 1760.674048] Data abort info:
[ 1760.674302]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[ 1760.674780]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 1760.675221]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
** 1 printk messages dropped **
[ 1760.675688] Insufficient stack space to handle exception!
[ 1760.675690] ESR: 0x0000000096000047 -- DABT (current EL)
[ 1760.675692] FAR: 0xffff800082dd7ff8
[ 1760.675693] Task stack:     [0xffff800082dd8000..0xffff800082ddc000]
[ 1760.675696] IRQ stack:      [0xffff800082d98000..0xffff800082d9c000]
[ 1760.675697] Overflow stack: [0xffff0000f7499320..0xffff0000f749a320]
[ 1760.675702] CPU: 4 PID: 22769 Comm: kworker/u26:1 Tainted: G    B D
           6.10.0-rc3 #1
[ 1760.675707] Hardware name: Radxa ROCK Pi 4B (DT)
[ 1760.675711] Workqueue:  0x0 (rpciod)
[ 1760.675722] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 1760.675726] pc : vsnprintf+0x30/0x690
[ 1760.675734] lr : vscnprintf+0x40/0x88
[ 1760.675737] sp : ffff800082dd7fe0
[ 1760.675739] x29: ffff800082dd8000 x28: ffff0000f749c041 x27: 00000000000000c0
[ 1760.675744] x26: ffff800082673000 x25: 0000000000000058 x24: 0000000000000000
[ 1760.675749] x23: 00000199f072e543 x22: ffff800082dd8218 x21: ffff800082dd817c
[ 1760.675754] x20: 0000000000000000 x19: 0000000000000058 x18: ffff8000815efc10
[ 1760.675758] x17: 72646461206c6175 x16: 7472697620746120 x15: 0000000000000036
[ 1760.675763] x14: 0000000000000011 x13: ffff800081672246 x12: 00007fffffffffff
[ 1760.675767] x11: ffffffffffffffff x10: 00000000ffffffc8 x9 : 0000000000000000
[ 1760.675772] x8 : a661107c55742e00 x7 : 656c62616e553101 x6 : 656c62616e553101
[ 1760.675776] x5 : ffff800082dd8120 x4 : ffff8000821d986a x3 : ffff800082dd8068
[ 1760.675781] x2 : ffff8000821d986a x1 : 0000000000000058 x0 : ffff800082cccf60
[ 1760.675786] Kernel panic - not syncing: kernel stack overflow
[ 1760.675790] SMP: stopping secondary CPUs
[ 1761.842460] SMP: failed to stop secondary CPUs 1,4-5
[ 1761.842465] Kernel Offset: disabled
[ 1761.842466] CPU features: 0x04,00001041,60100000,4200421b
[ 1761.842469] Memory Limit: none
[ 1761.857077] ---[ end Kernel panic - not syncing: kernel stack overflow ]---

metadata:
---
  git_describe: v6.10-rc3
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
  git_sha: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
  git_short_log: 83a7eefedc9b ("Linux 6.10-rc3")
  arch: arm64
  device: rk3399-rock-pi-4b

Links:
 - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.10-rc3/testrun/24268294/suite/log-parser-test/tests/
 - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.10-rc3/testrun/24268294/suite/log-parser-test/test/check-kernel-panic/log
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2hgP9Karl1eQX5uFJst2smk8GIQ
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2hgP7ACUmGhLsh7LVmWQ4SCXopw/

Test case:
----
 - https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/fork/fork13.c

Steps to reproduce:
----
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2hgP9Karl1eQX5uFJst2smk8GIQ/reproducer


--
Linaro LKFT
https://lkft.linaro.org

