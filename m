Return-Path: <linux-kernel+bounces-515958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7F3A36B34
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7949C18920D5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D058A4AEE0;
	Sat, 15 Feb 2025 01:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aPJtSOgt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58BA2AE8B
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 01:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739584064; cv=none; b=k9jPPqtmafDhaDXOozZhWPLsPSKDfIoYbqzfd4+1X3tUBlwZ0YHkFkiGadMP7cCxb1sXtU7B9aFAXY8Gyf0Mcmo3OAuTGTG1u8B/U3j8dXWhdASwh1cBPenn6yPYs8KK/pAfW0TpnKEZKz4qtKBF1OrPwmOl4qtCMYav7Odjwl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739584064; c=relaxed/simple;
	bh=wNtJBJ6CPMjf5E20N3+6fEdvsPFfoiwT/BUvf67NvDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N0JxyY6yfPuNJxRx41XqF6ZaEEReVQj0xhoO3fH/S/jIIOi1XzKJVkTM7G+G2wKfLG2E/2nqW4sTetwz4JRt9OgPy+K5iQMpwOxUrHIgk6pq+2lkT6lFgCF8iSb/Bz2KZLa/gbUb1oPFn4ubqhG0BcsN5faAUCiLW2Rf7E/E9CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aPJtSOgt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739584061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jR5FKhI4FVO9AbOrqS45EooHEOiq7ojN8MeZGnbI9i8=;
	b=aPJtSOgtpN2KpDX/+k/BQaRGqpnmlSmk+Vx1RNqA4OnFfUUf6UUWe6v6vzds09b4CcXGoQ
	AsNdW3OSucOkRs/nSfT4ckgGHL0rk7a9hJkgVIJJmGTNfibEagMnDS9yL3gg/JyNLH4Ysz
	WuUl4hpdKqo+wX23Aop8w6ewJRMA048=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-Ar1Nc54SNZ-g_zNr3OrZyw-1; Fri, 14 Feb 2025 20:47:40 -0500
X-MC-Unique: Ar1Nc54SNZ-g_zNr3OrZyw-1
X-Mimecast-MFC-AGG-ID: Ar1Nc54SNZ-g_zNr3OrZyw_1739584059
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6fb5bd3bcacso1339447b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:47:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739584059; x=1740188859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jR5FKhI4FVO9AbOrqS45EooHEOiq7ojN8MeZGnbI9i8=;
        b=YnYPWFAGNfjJa5yXUylOyQ8I8NvbNb0ekurfqKb+Ccq3MIStap2y6owgPIYXOWxfIy
         kyJ9Nm6aZbvnY/BXpmPo6bUndAkJBk7DgPbOg8QBOzC78nuQnEgyJSH6fydkCgNUsHq9
         0Sk/RWnG1mfBgGl0S028CuqcJBgaa6PjsAYUZiPcYFyd6+q25YFyYlvdFiJwqjdCiqib
         R9lbYbmF4AP0txQ2BdKUUIidw1APpQtbs0PfhdynWxgIdM5RNLcn9/Ay58G/f85jXoPy
         +mCZhgHm0Xx0fqR2mFzh+ZP4qe5tY/LlsFoeudX9U6Ef1Em3tE1yuPu9yJvXo2Lf4HfJ
         FzbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYzE8jH8QaPf+OsY0lNVu4SDXei11EEgKTRHOtrgI+GXe0gxa/ozz7/Scxnj5Yio1qDOWZs9pB2Fq/FSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAAARX1CaIG6Mc5/jZytETNIwPfy3g0Ncihkgv53OFGJ9p32Hq
	VQdUoZSyGIl/UNeJ0Pw6+Z7jZ9oDbCQk5CslZ1ONZegwebNsg7+6fGeZRE9esLXbJMy2Dq9A5M7
	CS7zyzP5TliYPGdTiICHcJVxc7tUC7zkcsZWaD97xz+V90ytRPZXZe6QeGHs64zLwNtmABgnksm
	jIYSoYXBqxpKCx5HX7sC6++akuGxjm3VNPSHQ/
X-Gm-Gg: ASbGncvSayzo+ubst5iLr55R1LSzWf1yMZltSEujb9kEDNLKfOGkyr44kMC8rMEDwJ9
	Ss0LJ2VREulTdSOwpVimCYPqT3wVEizJhTBAN8rMdIwPE8YQd6lmVOFHdaATpH7H149xTKzbIxw
	w=
X-Received: by 2002:a05:6902:e05:b0:e5d:c697:8805 with SMTP id 3f1490d57ef6-e5dc9316db1mr1338200276.41.1739584059353;
        Fri, 14 Feb 2025 17:47:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6MVBDkllzmZdCUlUTnpV4eFhBlnNhsbDJcdaHr1V7wMfWnl/eem9Y6Iz4EKBhulqpEFLIK3WWji7cZMXxH2I=
X-Received: by 2002:a05:6902:e05:b0:e5d:c697:8805 with SMTP id
 3f1490d57ef6-e5dc9316db1mr1338175276.41.1739584058990; Fri, 14 Feb 2025
 17:47:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211111326.14295-1-dev.jain@arm.com>
In-Reply-To: <20250211111326.14295-1-dev.jain@arm.com>
From: Nico Pache <npache@redhat.com>
Date: Fri, 14 Feb 2025 18:47:13 -0700
X-Gm-Features: AWEUYZmQv0R5du_FIsvAIv_FcUpSBv-yTAAmkD2v_7mf3m_PrbAp8pJ9bqzwcLU
Message-ID: <CAA1CXcACBMTPN-y4-J6wgiTf90ia5576xOJKFULnvGPCt56U6w@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] khugepaged: Asynchronous mTHP collapse
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, willy@infradead.org, 
	kirill.shutemov@linux.intel.com, ryan.roberts@arm.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@gentwo.org, 
	vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com, 
	dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org, jack@suse.cz, 
	srivatsa@csail.mit.edu, haowenchao22@gmail.com, hughd@google.com, 
	aneesh.kumar@kernel.org, yang@os.amperecomputing.com, peterx@redhat.com, 
	ioworker0@gmail.com, wangkefeng.wang@huawei.com, ziy@nvidia.com, 
	jglisse@google.com, surenb@google.com, vishal.moola@gmail.com, 
	zokeefe@google.com, zhengqi.arch@bytedance.com, jhubbard@nvidia.com, 
	21cnbao@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dev,

I tried to run your kernel to get some performance numbers out of it,
but ran into the following issue while running my defer-mthp-test.sh
workload.

[  297.393032] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  297.393618] WARNING: bad unlock balance detected!
[  297.394201] 6.14.0-rc2mthpDEV #2 Not tainted
[  297.394732] -------------------------------------
[  297.395421] khugepaged/111 is trying to release lock (&mm->mmap_lock) at=
:
[  297.396509] [<ffffffff947cb76a>] khugepaged+0x23a/0xb40
[  297.397205] but there are no more locks to release!
[  297.397865]
[  297.397865] other info that might help us debug this:
[  297.398684] no locks held by khugepaged/111.
[  297.399155]
[  297.399155] stack backtrace:
[  297.399591] CPU: 10 UID: 0 PID: 111 Comm: khugepaged Not tainted
6.14.0-rc2mthpDEV #2
[  297.399593] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.3-2.fc40 04/01/2014
[  297.399595] Call Trace:
[  297.399599]  <TASK>
[  297.399602]  dump_stack_lvl+0x6e/0xa0
[  297.399607]  ? khugepaged+0x23a/0xb40
[  297.399610]  print_unlock_imbalance_bug.part.0+0xfb/0x110
[  297.399612]  ? khugepaged+0x23a/0xb40
[  297.399614]  lock_release+0x283/0x3f0
[  297.399620]  up_read+0x1b/0x30
[  297.399622]  khugepaged+0x23a/0xb40
[  297.399631]  ? __pfx_khugepaged+0x10/0x10
[  297.399633]  kthread+0xf2/0x240
[  297.399636]  ? __pfx_kthread+0x10/0x10
[  297.399638]  ret_from_fork+0x34/0x50
[  297.399640]  ? __pfx_kthread+0x10/0x10
[  297.399642]  ret_from_fork_asm+0x1a/0x30
[  297.399649]  </TASK>
[  297.505555] ------------[ cut here ]------------
[  297.506044] DEBUG_RWSEMS_WARN_ON(tmp < 0): count =3D
0xffffffffffffff00, magic =3D 0xffff8c6e03bc1f88, owner =3D 0x1, curr
0xffff8c6e0eccb700, list empty
[  297.507362] WARNING: CPU: 8 PID: 1946 at
kernel/locking/rwsem.c:1346 __up_read+0x1ba/0x220
[  297.508220] Modules linked in: nft_fib_inet nft_fib_ipv4
nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 rfkill nf_tables intel_rapl_msr intel_rapl_common
kvm_amd iTCO_wdt intel_pmc_bxt iTCO_vendor_support kvm i2c_i801
i2c_smbus lpc_ich virtio_net net_failover failover virtio_balloon
joydev fuse loop nfnetlink zram xfs polyval_clmulni polyval_generic
ghash_clmulni_intel sha512_ssse3 sha256_ssse3 virtio_console
virtio_blk sha1_ssse3 serio_raw qemu_fw_cfg
[  297.513474] CPU: 8 UID: 0 PID: 1946 Comm: thp_test Not tainted
6.14.0-rc2mthpDEV #2
[  297.514314] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.3-2.fc40 04/01/2014
[  297.515265] RIP: 0010:__up_read+0x1ba/0x220
[  297.515756] Code: c6 78 8b e1 95 48 c7 c7 88 0e d3 95 48 39 c2 48
c7 c2 be 39 e4 95 48 c7 c0 29 8b e1 95 48 0f 44 c2 48 8b 13 50 e8 e6
44 f5 ff <0f> 0b 58 e9 20 ff ff ff 48 8b 57 60 48 8d 47 60 4c 8b 47 08
c6 05
[  297.517659] RSP: 0018:ffffa8a943533ac8 EFLAGS: 00010282
[  297.518209] RAX: 0000000000000000 RBX: ffff8c6e03bc1f88 RCX: 00000000000=
00000
[  297.518884] RDX: ffff8c7366ff0980 RSI: ffff8c7366fe1a80 RDI: ffff8c7366f=
e1a80
[  297.519577] RBP: ffffa8a943533b58 R08: 0000000000000000 R09: 00000000000=
00001
[  297.520272] R10: 0000000000000000 R11: 0770076d07650720 R12: ffffa8a9435=
33b10
[  297.520949] R13: ffff8c6e03bc1f88 R14: ffffa8a943533b58 R15: ffffa8a9435=
33b10
[  297.521651] FS:  00007f24de01b740(0000) GS:ffff8c7366e00000(0000)
knlGS:0000000000000000
[  297.522425] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  297.522990] CR2: 0000000a7ffef000 CR3: 000000010d9d6000 CR4: 00000000007=
50ef0
[  297.523799] PKRU: 55555554
[  297.524100] Call Trace:
[  297.524367]  <TASK>
[  297.524597]  ? __warn.cold+0xb7/0x151
[  297.525072]  ? __up_read+0x1ba/0x220
[  297.525442]  ? report_bug+0xff/0x140
[  297.525804]  ? console_unlock+0x9d/0x150
[  297.526233]  ? handle_bug+0x58/0x90
[  297.526590]  ? exc_invalid_op+0x17/0x70
[  297.526993]  ? asm_exc_invalid_op+0x1a/0x20
[  297.527420]  ? __up_read+0x1ba/0x220
[  297.527783]  ? __up_read+0x1ba/0x220
[  297.528160]  vms_complete_munmap_vmas+0x19c/0x1f0
[  297.528628]  do_vmi_align_munmap+0x20a/0x280
[  297.529069]  ? srso_alias_return_thunk+0x5/0xfbef5
[  297.529552]  do_vmi_munmap+0xd0/0x190
[  297.529920]  __vm_munmap+0xb1/0x1b0
[  297.530293]  __x64_sys_munmap+0x1b/0x30
[  297.530677]  do_syscall_64+0x95/0x180
[  297.531058]  ? srso_alias_return_thunk+0x5/0xfbef5
[  297.531534]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
[  297.532167]  ? srso_alias_return_thunk+0x5/0xfbef5
[  297.532640]  ? syscall_exit_to_user_mode+0x97/0x290
[  297.533226]  ? srso_alias_return_thunk+0x5/0xfbef5
[  297.533701]  ? do_syscall_64+0xa1/0x180
[  297.534097]  ? srso_alias_return_thunk+0x5/0xfbef5
[  297.534587]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
[  297.535129]  ? srso_alias_return_thunk+0x5/0xfbef5
[  297.535603]  ? syscall_exit_to_user_mode+0x97/0x290
[  297.536092]  ? srso_alias_return_thunk+0x5/0xfbef5
[  297.536568]  ? do_syscall_64+0xa1/0x180
[  297.536954]  ? srso_alias_return_thunk+0x5/0xfbef5
[  297.537444]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
[  297.537936]  ? srso_alias_return_thunk+0x5/0xfbef5
[  297.538524]  ? syscall_exit_to_user_mode+0x97/0x290
[  297.539044]  ? srso_alias_return_thunk+0x5/0xfbef5
[  297.539526]  ? do_syscall_64+0xa1/0x180
[  297.539931]  ? srso_alias_return_thunk+0x5/0xfbef5
[  297.540597]  ? do_user_addr_fault+0x5a9/0x8a0
[  297.541102]  ? srso_alias_return_thunk+0x5/0xfbef5
[  297.541580]  ? trace_hardirqs_off+0x4b/0xc0
[  297.542011]  ? srso_alias_return_thunk+0x5/0xfbef5
[  297.542488]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
[  297.542991]  ? srso_alias_return_thunk+0x5/0xfbef5
[  297.543466]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  297.543960] RIP: 0033:0x7f24de1367eb
[  297.544344] Code: 73 01 c3 48 8b 0d 2d f6 0c 00 f7 d8 64 89 01 48
83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 0b 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d fd f5 0c 00 f7 d8 64 89
01 48
[  297.546074] RSP: 002b:00007ffc7bb2e2b8 EFLAGS: 00000206 ORIG_RAX:
000000000000000b
[  297.546796] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f24de1=
367eb
[  297.547488] RDX: 0000000080000000 RSI: 0000000080000000 RDI: 00000004800=
00000
[  297.548182] RBP: 00007ffc7bb2e390 R08: 0000000000000064 R09: 00000000fff=
ffffe
[  297.548884] R10: 0000000000000000 R11: 0000000000000206 R12: 00000000000=
00006
[  297.549594] R13: 0000000000000000 R14: 00007f24de258000 R15: 00000000004=
03e00
[  297.550292]  </TASK>
[  297.550530] irq event stamp: 64417291
[  297.550903] hardirqs last  enabled at (64417291):
[<ffffffff94749232>] seqcount_lockdep_reader_access+0x82/0x90
[  297.551859] hardirqs last disabled at (64417290):
[<ffffffff947491fe>] seqcount_lockdep_reader_access+0x4e/0x90
[  297.552810] softirqs last  enabled at (64413640):
[<ffffffff943bf3c2>] __irq_exit_rcu+0xe2/0x100
[  297.553654] softirqs last disabled at (64413627):
[<ffffffff943bf3c2>] __irq_exit_rcu+0xe2/0x100
[  297.554504] ---[ end trace 0000000000000000 ]---




On Tue, Feb 11, 2025 at 4:13=E2=80=AFAM Dev Jain <dev.jain@arm.com> wrote:
>
> This patchset extends khugepaged from collapsing only PMD-sized THPs to
> collapsing anonymous mTHPs.
>
> mTHPs were introduced in the kernel to improve memory management by alloc=
ating
> chunks of larger memory, so as to reduce number of page faults, TLB misse=
s (due
> to TLB coalescing), reduce length of LRU lists, etc. However, the mTHP pr=
operty
> is often lost due to CoW, swap-in/out, and when the kernel just cannot fi=
nd
> enough physically contiguous memory to allocate on fault. Henceforth, the=
re is a
> need to regain mTHPs in the system asynchronously. This work is an attemp=
t in
> this direction, starting with anonymous folios.
>
> In the fault handler, we select the THP order in a greedy manner; the sam=
e has
> been used here, along with the same sysfs interface to control the order =
of
> collapse. In contrast to PMD-collapse, we (hopefully) get rid of the mmap=
_write_lock().
>
> ---------------------------------------------------------
> Testing
> ---------------------------------------------------------
>
> The set has been build tested on x86_64.
> For Aarch64,
> 1. mm-selftests: No regressions.
> 2. Analyzing with tools/mm/thpmaps on different userspace programs mappin=
g
>    aligned VMAs of a large size, faulting in basepages/mTHPs (according t=
o sysfs),
>    and then madvise()'ing the VMA, khugepaged is able to 100% collapse th=
e VMAs.
>
> This patchset is rebased on mm-unstable (4637fa5d47a49c977116321cc575ea22=
215df22d).
>
> v1->v2:
>  - Handle VMAs less than PMD size (patches 12-15)
>  - Do not add mTHP into deferred split queue
>  - Drop lock optimization and collapse mTHP under mmap_write_lock()
>  - Define policy on what to do when we encounter a folio order larger tha=
n
>    the order we are scanning for
>  - Prevent the creep problem by enforcing tunable simplification
>  - Update Documentation
>  - Drop patch 12 from v1 updating selftest w.r.t the creep problem
>  - Drop patch 1 from v1
>
>  v1:
>  https://lore.kernel.org/all/20241216165105.56185-1-dev.jain@arm.com/
>
> Dev Jain (17):
>   khugepaged: Generalize alloc_charge_folio()
>   khugepaged: Generalize hugepage_vma_revalidate()
>   khugepaged: Generalize __collapse_huge_page_swapin()
>   khugepaged: Generalize __collapse_huge_page_isolate()
>   khugepaged: Generalize __collapse_huge_page_copy()
>   khugepaged: Abstract PMD-THP collapse
>   khugepaged: Scan PTEs order-wise
>   khugepaged: Introduce vma_collapse_anon_folio()
>   khugepaged: Define collapse policy if a larger folio is already mapped
>   khugepaged: Exit early on fully-mapped aligned mTHP
>   khugepaged: Enable sysfs to control order of collapse
>   khugepaged: Enable variable-sized VMA collapse
>   khugepaged: Lock all VMAs mapping the PTE table
>   khugepaged: Reset scan address to correct alignment
>   khugepaged: Delay cond_resched()
>   khugepaged: Implement strict policy for mTHP collapse
>   Documentation: transhuge: Define khugepaged mTHP collapse policy
>
>  Documentation/admin-guide/mm/transhuge.rst |  49 +-
>  include/linux/huge_mm.h                    |   2 +
>  mm/huge_memory.c                           |   4 +
>  mm/khugepaged.c                            | 603 ++++++++++++++++-----
>  4 files changed, 511 insertions(+), 147 deletions(-)
>
> --
> 2.30.2
>


