Return-Path: <linux-kernel+bounces-358595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF06E99814E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633481F24ADD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60E91BFE0B;
	Thu, 10 Oct 2024 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VBJY2TyO"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3991BFE0F
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550733; cv=none; b=d5c0bJBce1bLXrFqEEapWMeEpSvtDy/ng5h0gIiRKSVeZDWDX/1QGDZyCU3pZN0XII4llhJnpTYjf6fsxZHBTmrjYu5ToW1ViYxtIi25iYAXaCfiStsN9k6UiwSfPf0amCgmKjAIgi+YNMEZ985ea4cVQqsSClHI+7z2K1wv+To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550733; c=relaxed/simple;
	bh=EsMI0s4E+0qLYMAtq9e3tM7tPmzWfYE6in+q0dd9Mnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5Nmy4Or6LSNDF+0ywaX81znW91Y6I2RarHgOl8SOLahEQVH7ExCbTgFBAXEyr9Wxo24nbIK66MDuhAxEor2Ze+W+hU2PbVM8KIOCMsU4PLlixB9GaKqTQax4sBGrXLCsggI3G0GsLJSZKHTg4FPuht2nsC/vXjvXl5fFGib8m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VBJY2TyO; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fad8337aa4so7247781fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 01:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728550729; x=1729155529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hSsNkar600D9ZS/rhMKseaM9FDT8QDKYX4lmde1efg=;
        b=VBJY2TyObe9n6GjscbBCHO/3VNwyOESevhuXl9qln0aUP9z6YlgLSRkRu/7ZLLO+Mr
         iSePywkc3kqM0newwl6c9y6uTsQgf+hLf+QDKglvJAdhNO3+IPoJhetvokAyb8xAd5NQ
         8shOS7XYSk7caEk5Kz0RX4OFPa8cBFSoePML+38tBCA8+L1zXmfYPeT7Uz7nUCndlwuS
         NuZiNIdFCqGqsdgK0GpWgrTRUbQmekHjeOu3UNF9UAwcqafs+24ebrysOSr7lgFDHDMb
         b0bipaPckZQkwTmGQHC0EcjWpiRm+9X4dhC39I84tSZ4QLYJAuk/pyRs4YdYO25segjO
         SjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728550729; x=1729155529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hSsNkar600D9ZS/rhMKseaM9FDT8QDKYX4lmde1efg=;
        b=Tsp7jgZKmLzbPG3KHJL7Bg1UtylR2vbYdxuUtaPemABONWjtQzvzYcHNJ/UABceFYN
         tkldvG9Ia3SHUdWz0LkOD1Tn4W5lXdUAQlVBsHSiVo96QEcVLfSthHMHDZtHCnj6gSni
         61eMI8tnC7azXSzo6umwD5gV5Z3IiV7xwgPMZjnblKVJw5SWiJ51yDvfJBE+QxAvNx+e
         26dYwmjA4ZfoK0f9n052QHg8OrWuFbAfAj+nbNewUxBOOjEzpq7tBcBdo0gJTGM6p/LZ
         H0OwRuDHF9WiGvVlevLryrDeM0VzWXvqToChsZRXUqzUva4YEqeJf7+vwNUTmmgMRA6r
         QRJg==
X-Forwarded-Encrypted: i=1; AJvYcCXblUJkFCRb6BqTBXU4Zl7nBsuv7pd0s3BMN3QDbMPCElYMHX3dbdwoC9PlQuxFgH7lWFUIktFQhyY3Xpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM754mmqxogSmd1pIOILyIhW3VchUohA1cdPesRW1upzfMo0Sz
	1f9+SV9Q8Jchzri9YPUEdccssnSlrBkaKW0XfOGDNN2I90dvlnmqmQFxPXdkOEiIaYepNnB9VH8
	WhKPD7HgOqKNG8gByY7AwfGywh5UCi3QZULrJ
X-Google-Smtp-Source: AGHT+IE6f9Rcf5D/qF2TbtTGH8ECVNOAYarzaBRP9IQLt4gwqTzS6g6S40SS+6fjQOthVBSIocenU81IaD5yB/GKo8A=
X-Received: by 2002:a2e:8e6f:0:b0:2fa:bb5d:db67 with SMTP id
 38308e7fff4ca-2fb187aeb2emr26908961fa.32.1728550728649; Thu, 10 Oct 2024
 01:58:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZweN3SiUk4bK9N7u@ly-workstation>
In-Reply-To: <ZweN3SiUk4bK9N7u@ly-workstation>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 10:58:35 +0200
Message-ID: <CANn89iKNZ4AZVYfxzhGWnx82T44_7tw5P63-TE0-GUn+sTRkZg@mail.gmail.com>
Subject: Re: [Syzkaller & bisect] There is KASAN: slab-use-after-free Read in
 __nf_unregister_net_hook in v6.12-rc1
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, 
	yi1.lai@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 10:19=E2=80=AFAM Lai, Yi <yi1.lai@linux.intel.com> =
wrote:
>
> Hi Eric,
>
> Greetings!
>
> I used Syzkaller and found that there is KASAN: slab-use-after-free Read =
in __nf_unregister_net_hook in v6.12-rc1
>
> After bisection and the first bad commit is:
> "
> 78c3253f27e5 net: use synchronize_rcu_expedited in cleanup_net()
> "
>
> All detailed into can be found at:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241001_170248___nf_=
unregister_net_hook
> Syzkaller repro code:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241001_170248___nf_=
unregister_net_hook/repro.c
> Syzkaller repro syscall steps:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241001_170248___nf_=
unregister_net_hook/repro.prog
> Syzkaller report:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241001_170248___nf_=
unregister_net_hook/repro.report
> Kconfig(make olddefconfig):
> https://github.com/laifryiee/syzkaller_logs/tree/main/241001_170248___nf_=
unregister_net_hook/kconfig_origin
> Bisect info:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241001_170248___nf_=
unregister_net_hook/bisect_info.log
> bzImage:
> https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/241001_17=
0248___nf_unregister_net_hook/bzImage_9852d85ec9d492ebef56dc5f229416c925758=
edc
> Issue dmesg:
> https://github.com/laifryiee/syzkaller_logs/blob/main/241001_170248___nf_=
unregister_net_hook/9852d85ec9d492ebef56dc5f229416c925758edc_dmesg.log
>
> "
> [   16.910304] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   16.910757] BUG: KASAN: slab-use-after-free in __nf_unregister_net_hoo=
k+0x640/0x6b0
> [   16.911156] Read of size 8 at addr ffff8880106fe400 by task repro/725
> [   16.911529]
> [   16.911674] CPU: 1 UID: 0 PID: 725 Comm: repro Not tainted 6.12.0-rc1-=
9852d85ec9d4+ #1
> [   16.912338] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [   16.913460] Call Trace:
> [   16.913859]  <TASK>
> [   16.913983]  dump_stack_lvl+0xea/0x150
> [   16.914262]  print_report+0xce/0x610
> [   16.914585]  ? __nf_unregister_net_hook+0x640/0x6b0
> [   16.914845]  ? kasan_complete_mode_report_info+0x80/0x200
> [   16.915133]  ? __nf_unregister_net_hook+0x640/0x6b0
> [   16.915497]  kasan_report+0xcc/0x110
> [   16.915687]  ? __nf_unregister_net_hook+0x640/0x6b0
> [   16.916082]  ? __pfx_bpf_link_release+0x10/0x10
> [   16.916398]  __asan_report_load8_noabort+0x18/0x20
> [   16.916655]  __nf_unregister_net_hook+0x640/0x6b0
> [   16.916895]  ? __pfx_bpf_link_release+0x10/0x10
> [   16.917177]  ? __pfx_bpf_link_release+0x10/0x10
> [   16.917467]  nf_unregister_net_hook+0xea/0x140
> [   16.917770]  bpf_nf_link_release+0xda/0x1e0
> [   16.917983]  bpf_link_free+0x139/0x2d0
> [   16.918187]  bpf_link_release+0x68/0x80
> [   16.918397]  __fput+0x414/0xb60
> [   16.918603]  ____fput+0x22/0x30
> [   16.918777]  task_work_run+0x19c/0x2b0
> [   16.919006]  ? __pfx_task_work_run+0x10/0x10
> [   16.919235]  ? free_nsproxy+0x344/0x470
> [   16.919448]  ? switch_task_namespaces+0xf9/0x110
> [   16.919711]  do_exit+0xb19/0x2a30
> [   16.919913]  ? audit_log_end+0x156/0x2c0
> [   16.920202]  ? __pfx_do_exit+0x10/0x10
> [   16.920419]  ? audit_seccomp+0x1b2/0x220
> [   16.920656]  ? audit_seccomp+0x1b9/0x220
> [   16.920872]  __secure_computing+0x2f5/0x350
> [   16.921109]  syscall_trace_enter+0x9b/0x230
> [   16.921354]  do_syscall_64+0x115/0x140
> [   16.921551]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   16.921816] RIP: 0033:0x7f2464518a4d
> [   16.922038] Code: Unable to access opcode bytes at 0x7f2464518a23.
> [   16.922363] RSP: 002b:00007ffe02122928 EFLAGS: 00000246 ORIG_RAX: 0000=
0000000000e7
> [   16.922759] RAX: ffffffffffffffda RBX: 00007f24645f69e0 RCX: 00007f246=
4518a4d
> [   16.923163] RDX: 00000000000000e7 RSI: ffffffffffffff80 RDI: 000000000=
0000000
> [   16.923583] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000=
0000020
> [   16.923965] R10: 00007ffe021227d0 R11: 0000000000000246 R12: 00007f246=
45f69e0
> [   16.924353] R13: 00007f24645fbf00 R14: 0000000000000001 R15: 00007f246=
45fbee8
> [   16.924750]  </TASK>
> [   16.924870]
> [   16.924962] Allocated by task 725:
> [   16.925153]  kasan_save_stack+0x2c/0x60
> [   16.925387]  kasan_save_track+0x18/0x40
> [   16.925607]  kasan_save_alloc_info+0x3c/0x50
> [   16.925853]  __kasan_slab_alloc+0x62/0x80
> [   16.926065]  kmem_cache_alloc_noprof+0x114/0x370
> [   16.926334]  copy_net_ns+0xf0/0x6e0
> [   16.926520]  create_new_namespaces+0x403/0xb40
> [   16.926769]  unshare_nsproxy_namespaces+0xca/0x200
> [   16.927038]  ksys_unshare+0x424/0xa10
> [   16.927242]  __x64_sys_unshare+0x3a/0x50
> [   16.927451]  x64_sys_call+0xcf1/0x20d0
> [   16.927670]  do_syscall_64+0x6d/0x140
> [   16.927888]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   16.928148]
> [   16.928243] Freed by task 51:
> [   16.928414]  kasan_save_stack+0x2c/0x60
> [   16.928631]  kasan_save_track+0x18/0x40
> [   16.928841]  kasan_save_free_info+0x3f/0x60
> [   16.929073]  __kasan_slab_free+0x3d/0x60
> [   16.929308]  kmem_cache_free+0x1aa/0x550
> [   16.929529]  cleanup_net+0x8af/0xae0
> [   16.929745]  process_one_work+0x92e/0x1b50
> [   16.929981]  worker_thread+0x68d/0xe90
> [   16.930204]  kthread+0x35a/0x470
> [   16.930424]  ret_from_fork+0x56/0x90
> [   16.930626]  ret_from_fork_asm+0x1a/0x30
> [   16.930843]
> [   16.930935] The buggy address belongs to the object at ffff8880106fd40=
0
> [   16.930935]  which belongs to the cache net_namespace of size 6912
> [   16.931597] The buggy address is located 4096 bytes inside of
> [   16.931597]  freed 6912-byte region [ffff8880106fd400, ffff8880106fef0=
0)
> [   16.932280]
> [   16.932430] The buggy address belongs to the physical page:
> [   16.932757] page: refcount:1 mapcount:0 mapping:0000000000000000 index=
:0x0 pfn:0x106f8
> [   16.933195] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped=
:0 pincount:0
> [   16.933592] memcg:ffff88801157d281
> [   16.933783] flags: 0xfffffc0000040(head|node=3D0|zone=3D1|lastcpupid=
=3D0x1fffff)
> [   16.934155] page_type: f5(slab)
> [   16.934329] raw: 000fffffc0000040 ffff88800d71cdc0 dead000000000122 00=
00000000000000
> [   16.934782] raw: 0000000000000000 0000000080040004 00000001f5000000 ff=
ff88801157d281
> [   16.935209] head: 000fffffc0000040 ffff88800d71cdc0 dead000000000122 0=
000000000000000
> [   16.935610] head: 0000000000000000 0000000080040004 00000001f5000000 f=
fff88801157d281
> [   16.936038] head: 000fffffc0000003 ffffea000041be01 ffffffffffffffff 0=
000000000000000
> [   16.936507] head: 0000000000000008 0000000000000000 00000000ffffffff 0=
000000000000000
> [   16.936913] page dumped because: kasan: bad access detected
> [   16.937285]
> [   16.937398] Memory state around the buggy address:
> [   16.937698]  ffff8880106fe300: fb fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb
> [   16.938149]  ffff8880106fe380: fb fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb
> [   16.938634] >ffff8880106fe400: fb fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb
> [   16.939010]                    ^
> "
>
> I hope you find it useful.
>
> Regards,
> Yi Lai
>
> ---
>
> If you don't need the following environment to reproduce the problem or i=
f you
> already have one reproduced environment, please ignore the following info=
rmation.
>
> How to reproduce:
> git clone https://gitlab.com/xupengfe/repro_vm_env.git
> cd repro_vm_env
> tar -xvf repro_vm_env.tar.gz
> cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v=
7.1.0
>   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65=
 v6.2-rc5 kernel
>   // You could change the bzImage_xxx as you want
>   // Maybe you need to remove line "-drive if=3Dpflash,format=3Draw,reado=
nly=3Don,file=3D./OVMF_CODE.fd \" for different qemu version
> You could use below command to log in, there is no password for root.
> ssh -p 10023 root@localhost
>
> After login vm(virtual machine) successfully, you could transfer reproduc=
ed
> binary to the vm by below way, and reproduce the problem in vm:
> gcc -pthread -o repro repro.c
> scp -P 10023 repro root@localhost:/root/
>
> Get the bzImage for target kernel:
> Please use target kconfig and copy it to kernel_src/.config
> make olddefconfig
> make -jx bzImage           //x should equal or less than cpu num your pc =
has
>
> Fill the bzImage file into above start3.sh to load the target kernel in v=
m.
>
>
> Tips:
> If you already have qemu-system-x86_64, please ignore below info.
> If you want to install qemu v7.1.0 version:
> git clone https://github.com/qemu/qemu.git
> cd qemu
> git checkout -f v7.1.0
> mkdir build
> cd build
> yum install -y ninja-build.x86_64
> yum -y install libslirp-devel.x86_64
> ../configure --target-list=3Dx86_64-softmmu --enable-kvm --enable-vnc --e=
nable-gtk --enable-sdl --enable-usb-redir --enable-slirp
> make
> make install


Probably reported in
https://lore.kernel.org/all/000000000000635bfa0607ed5cdc@google.com/T/

You probably should CC netfilter maintainers on this one.

