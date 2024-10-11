Return-Path: <linux-kernel+bounces-360323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6389999934
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 03:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34BB61F251AF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 01:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F64A79DC7;
	Fri, 11 Oct 2024 01:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRr67mQw"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42009C8C7
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 01:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728609815; cv=none; b=qcGObQP2rQxbEMIUa+XsX6nVbEZf6LTBfNIptsMNNH8SivF4Iwn3NGa8WUx3/+4m3SYoV5AHoEYeNdg85g8vv3nlAJw7wzqnB6NAJvnoV3mn7wGoukyPnJDdeyhtBer2mTwROyU9odoqzTOxBTAoiXxee0nOPvIcOHzQhYPrHlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728609815; c=relaxed/simple;
	bh=zVquiWa/if4f9slk6txdy1egOOigzMAm3/AOv0Refb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZE+Uvy5q/KkP3WU2yll0dB4XwHblBl8eAIBURqBqELuLwWgm522z/GJ2vauTrYnw/BkHogyXX5Adk0NBCw3hfWRx1GChW80nikYoMgCdw9lhAEMMc6BGYbtpSH01aQHBCpTpPRGvGjEgVRFguGsHv34MblNOQm+60ZWuUb20v1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRr67mQw; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e2ab5bbc01so261016a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728609813; x=1729214613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SF/7zdQkBGcnAqqkS5uW12uxOFdbOISK7h5UIJigtJk=;
        b=VRr67mQwmUmPLnsFQpr1bnzB7vumZMXxCvQrd+XwBfEyvwAsytc/Rw1orXg68GVDYT
         +muLgaELaxosMsIXV2VrjkIce7rrt0gQlou06ViK7aE4IwpR1yuOxmdLWPIsryTlp3Sp
         QcR+kuhH9XR7QXsBQCcYR87Hgqn8aiA+mpOIJLLy9odpf57e+1VpF8tBd7PlulLqM31E
         hI1ftJSymLnKC1qUesx3T4/12qSTc6z6PdwiNSJsrmi/K/ZR3LkbkFEbgY/YBKBZFsig
         vVSmrAyGv/2blH95nKVhmNSajMOjevP5kwhHYwpnT00uhZP3zL6T+b8dHV21+pwP/QNR
         9oZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728609813; x=1729214613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SF/7zdQkBGcnAqqkS5uW12uxOFdbOISK7h5UIJigtJk=;
        b=iEspPKJKYp6XXBbC0l8CqZ1TQQ9WAgcPw2dk+jZViJhKRmhMajjR7QnnxwNmMvVz7T
         yPw2QAtGi+7PO7STnNVfP/JggQ8kzkNtlKDpX0tp+xFmUA61DNX2gS/2h84YEnA+19qE
         3vFdMlzI6G/kQFsxtHXDDIA1yv9Cmc0VddQUHCAb6JCrCUfD0zwRjqX/MOSUHAdILeil
         GWMI4FFpD9xqbj2e/i7M0M4NRWwz4aVf/4Zh4CDv+6jFh2caZeULIdAWNKkdhumH6ICs
         93YjTHbfXI2+2fqkU6vuTzfYnN5XiJgnqiyDrDFo/5nx25FbQtfnPYywuK/UZ7xMLswu
         LIJw==
X-Forwarded-Encrypted: i=1; AJvYcCVKeBjR1F34fqxBYtdyUaKMxL47tlbeTKJbcr7UHh/HpGbay3o3ZeW/hLGCh5ydGAMNHjLEdDEvPGkEiwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsfLmRbOh0iSl9T3Zy+opN0D+I6/Ys2qKz1IQihXRHmGbYqG+5
	7UfArIdqHgXQAECFnqWSQZJANkUXTwwkRRfCCZwLvL9QzPPkMsvh3RGsJwOv1QhU0xMkMn/fnFP
	0aktS5to5tkmT3O/KZZu3SXqMlw==
X-Google-Smtp-Source: AGHT+IFJTubenTa8XXbwlIGgoarsbABBYObeRlyo4i+DqWIv/1pxoVQ9UTlMygtrZ4XLsyZkhM6t72B608ORuvlAg24=
X-Received: by 2002:a05:6a20:6a0f:b0:1cf:4bd8:3a02 with SMTP id
 adf61e73a8af0-1d8bcf63271mr698504637.3.1728609813520; Thu, 10 Oct 2024
 18:23:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALGdzuo8_EXr4aUAw6X9S+yzMPi25Y82netPLWsd+3n-Ov9Pnw@mail.gmail.com>
 <10779b09-3413-6374-b4a1-1efd8821c5f2@huawei.com> <CALGdzuryBbCqGAhox9ZWaQHD5dSQNApfGmCP+rYZ7O4MCRH+rw@mail.gmail.com>
 <7138a98c-1562-3059-07b6-4d918bec9d1a@huawei.com> <CALGdzuokUpWhUk7uvWcDT2tXRRMk07dmKGS-rFANOE6ZwZZW8w@mail.gmail.com>
 <0171b6cc-95ee-3538-913b-65a391a446b3@huawei.com>
In-Reply-To: <0171b6cc-95ee-3538-913b-65a391a446b3@huawei.com>
From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Thu, 10 Oct 2024 20:23:22 -0500
Message-ID: <CALGdzuoWvy5WvpttC1pab309kZ9cUyfT5O7JB8VjsqwU2HD0Xg@mail.gmail.com>
Subject: Re: [Linux Kernel Bug] memory leak in ubi_attach
To: linux-mtd@lists.infradead.org
Cc: richard@nod.at, miquel.raynal@bootlin.com, 
	Zhihao Cheng <chengzhihao1@huawei.com>, vigneshr@ti.com, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com, Zijie Zhao <zzjas98@gmail.com>, gregkh@linuxfoundation.org, 
	rafael@kernel.org, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Linux Kernel Developers for UBI and Kernel Object,

I am writing to inquire if there have been any updates regarding this
memory leak issue. This issue remains reproducible on the latest
Linux version (6.12-rc2, commit
8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b).

Thank you for your attention to this matter.

Best,
Chenyuan

On Mon, Jan 29, 2024 at 5:51=E2=80=AFAM 'Zhihao Cheng' via syzkaller
<syzkaller@googlegroups.com> wrote:
>
> =E5=9C=A8 2024/1/24 22:41, Chenyuan Yang =E5=86=99=E9=81=93:
> > Hi Zhihao,
> >
> > Thanks very much for your reply and further exploration of this crash!
> >
> > I have attached the config to reproduce this memory leak. For the
> > command line, you can use qemu to boot the kernel (You need to build
> > the bullseye-image first).
> > ```
> > mkdir -p logs
> > qemu-system-x86_64 \
> > -m 2G \
> > -smp 2 \
> > -kernel linux/arch/x86/boot/bzImage \
> > -append "console=3DttyS0 root=3D/dev/sda earlyprintk=3Dserial net.ifnam=
es=3D0" \
> > -drive file=3Dimage/bullseye-qemu.img,format=3Draw \
> > -net user,host=3D10.0.2.10,hostfwd=3Dtcp:127.0.0.1:10021-:22 \
> > -net nic,model=3De1000 \
> > -enable-kvm \
> > -nographic \
> > -pidfile vm.pid \
> > ```
> >
> > In qemu, you can run
> > ```
> > gcc -pthread repro.c -o exe
> > ./exe
> > ```
> > to reproduce the memory leak.
> >
>
> The bad news is that I can't reproduce the problem with your kernel
> config. The good news is that I seem to find the cause of the problem by
> code reviewing:
> alloc_ai -> kmem_cache_create -> kmem_cache_create_usercopy:
>   s =3D __kmem_cache_alias
>    s =3D find_mergeable // cannot find mergeable kmem_cache, s =3D NULL
>   create_cache
>    s =3D kmem_cache_zalloc
>    __kmem_cache_create(s)
>     sysfs_slab_add
>      kobject_init_and_add(&s->kobj)
>       kobject_init(kobj) // kobj->kref =3D 1
>       kobject_add_varg
>        kobject_set_name_vargs
>         kvasprintf_const
>          kstrdup_const
>           kstrdup
>            kmalloc_track_caller // allocated memory
>         kobj->name =3D s  // assign allocated memory to kobj->name
>        kobject_add_internal
>         create_dir // failed caused by ENOMEM
>         // kobj->name won't be released even 's' is released
>
> You can reproduce it by executing ubiattach -m0 with reproduce.diff appli=
ed:
> [root@localhost ~]# cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff88813b488080 (size 16):
>    comm "ubiattach", pid 9535, jiffies 4294943095
>    hex dump (first 16 bytes):
>      3a 30 30 30 30 30 35 36 00 00 00 00 00 00 00 00  :0000056........
>    backtrace (crc 8a117ab9):
>      [<ffffffff815f91c2>] __kmalloc_node_track_caller+0x322/0x420
>      [<ffffffff81575efc>] kstrdup+0x3c/0x70
>      [<ffffffff81575f8f>] kstrdup_const+0x5f/0x70
>      [<ffffffff82535426>] kvasprintf_const+0xc6/0x110
>      [<ffffffff84b88cb0>] kobject_set_name_vargs+0x40/0xd0
>      [<ffffffff84b8911b>] kobject_init_and_add+0x8b/0xf0
>      [<ffffffff815faba9>] sysfs_slab_add+0x119/0x1e0
>      [<ffffffff815fc2dc>] __kmem_cache_create+0x41c/0x590
>      [<ffffffff81586019>] kmem_cache_create_usercopy+0x169/0x300
>      [<ffffffff815861c1>] kmem_cache_create+0x11/0x20
>      [<ffffffff82ec8896>] ubi_attach+0xc6/0x1de0
>      [<ffffffff82eb77a3>] ubi_attach_mtd_dev+0x8a3/0x1120
>      [<ffffffff82eb8bfc>] ctrl_cdev_ioctl+0x1fc/0x270
>      [<ffffffff816ca312>] __x64_sys_ioctl+0xf2/0x140
>      [<ffffffff84bc3970>] do_syscall_64+0x50/0x140
>      [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
> There are two ways to fix it:
> 1. Release kobj->name directly in the error baranch of
> kobject_add_internal() after calling create_dir().
> 2. Put kobj's refcnt in the error baranch of kobject_add_internal()
> after calling create_dir().
> I'm not sure which one is better or whether there are other fix methods,
> maybe you can send an email in kobj related mailiing lists to confirm
> the problem.
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller/0171b6cc-95ee-3538-913b-65a391a446b3%40huawei.com.

