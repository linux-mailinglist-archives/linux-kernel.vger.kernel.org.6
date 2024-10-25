Return-Path: <linux-kernel+bounces-380939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9649AF80F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 05:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F5A2B225E2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 03:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DC818BBBB;
	Fri, 25 Oct 2024 03:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ct3Yrmju"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FAD18BBB2
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 03:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729825979; cv=none; b=Ym9IyXf0+juI33Ne9k9GsaxFtiIgdNwGD6q4Yk8Gva2wxuW63ZoA8zAN6+6I/p5TWq5m66GfIfe/kV7K4Le9xcWFmJf7RctM4lUJthuc09MwvaEwniUj3BnbvvPfGe4Eoi+bFFrx/M3iLmE2TVtwpHYpeiTy1Yq19R314NHtITU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729825979; c=relaxed/simple;
	bh=fmX52bVLdAGgnV5QgOXHDMxBc7/9SNfxadGP/9nM74A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XLhADh6rDfBC82HktITAO7X9UswoChNYwDxoevx8HYUQsYyUt1JyrvLTKe9zQ/+V8uXcgxlAklfzc4OhouSL1rAUnH2dxOWFvOoABXQyjhDAu2oYBwsDHQLkaEwCpYt7DcvOn5yIdLKnqattKSw1zZMT8TyZIzvKttUTE8u5zVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ct3Yrmju; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so1598066e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 20:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729825975; x=1730430775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J57jc6caP7dneGqTVVmCu4gt6t7MlPQxrlJAMM0H5nY=;
        b=ct3Yrmjut4M0lL66derHt8lPpbcerC6TCKjpcuoDi4PKfJIEvlyRYN/Xu8eoR4rCL7
         kxSD8OUvacj0Tw0IFnqSW3yjCg2J832TdNXgp/6MlwejrQT/kE3bVYOGOg8jMdB/9vBM
         fVACbVjVMOb+bKs98Mf+8n37T8yE+0all1psGSJ/dMQ7cHBBSsbHE5fBcZlvalGTmluu
         5qHxkvPy1XZ5+zcv7oudJWM7x/2f6FYuRynMauLVwBFT/ibI1tAnL1KHWJgQkr+Xsxsw
         yxOxpz5DgJntBIC/4Dwy8ogxBF70He6/WrWumw+gU+9JI20DtvQ6N+KJoSzyOGerL31A
         y1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729825975; x=1730430775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J57jc6caP7dneGqTVVmCu4gt6t7MlPQxrlJAMM0H5nY=;
        b=DmETAeIYfE2ROytEg1/Dj4triHTBdWm00xan5auBAdAQX8cUu7QgWuz54xDaFOHRvN
         cBHun+U3HVIBOKpZ9N+U71dUlNa+nPpCyBv8ssZ+h2aR5psqZg0kQeOrvRH0C+B2p8XB
         6oyyZjee5p9zUB9PwuCVZdhhDFEZSuR37GK25znvRbAoLEeHAShsws33E/tARgDHXojd
         j4ySKYigewtKb9iUeNRjUqebEBw7I5CpKmedvcf5dLJ+1PtHLDEUAtH90SlihsUpRuuz
         pf6Evk8bcOP6wMNCXa5zIeB2Y3F7GftVjzWmnRWVkKnDGXRjfHuJQMoPkyNSGegPuU8d
         XBzw==
X-Forwarded-Encrypted: i=1; AJvYcCVUkjM4eDdc1ACuYvZJ+FEGUuJ6joFv7TPls6VvI8IdlWMmyEtuweJklLCQmQ47Ot+hPZXCO50erTDIBec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz95knPZ4380ADK4ytcb+QzOTd16gfDnlK2kC8qII0YQIZAOnb0
	W3VCWdqTWnvzw7f9h4TDs2DNikctCD5AYw64u6xPK6RRe8OVt4D7PaBZ6Bbufb0QNW+4d7NnyS7
	cCR2Azkv9hgMr5xM6IBzTbXg+N9o=
X-Google-Smtp-Source: AGHT+IHGZoM4BzjsepQKCRxZadMrSN1riS94M2w7dDDfpmR7a3YGSEZoI7pzq+qK5MpPoCrynFj7HcqXbCuLU/yu0gc=
X-Received: by 2002:a05:6512:3a91:b0:53b:2041:e78c with SMTP id
 2adb3069b0e04-53b23e8dd14mr2457674e87.56.1729825974772; Thu, 24 Oct 2024
 20:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20221112114602.1268989-1-liushixin2@huawei.com>
 <20221112114602.1268989-4-liushixin2@huawei.com> <3780a622-03f2-4cfe-5705-0e9d0be61d57@huawei.com>
 <CAB=+i9SiiH7JN1tTrmO6FS+HqQcKnwoAs3O2PKxfPy2parM8WA@mail.gmail.com>
 <68b86f66-cd00-bb7d-b8bb-5a94e8dd1ea2@huawei.com> <02820eb8-0b8f-4aa8-9315-85368e9c331e@suse.cz>
 <0F94364A-F0C8-4C0A-B38D-3DDEA653B6B7@gmail.com> <7707ff34-16e1-4f8c-9af6-8b5b6591c77e@suse.cz>
 <511392f2-8e94-d2fc-63a6-ac3b4cac10e1@huawei.com>
In-Reply-To: <511392f2-8e94-d2fc-63a6-ac3b4cac10e1@huawei.com>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Fri, 25 Oct 2024 12:12:42 +0900
Message-ID: <CAB=+i9SEgtkXUaD9WXLgr5Mrywm_g3c+ALZwsvMa0-y697pkqg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mm/slub: Fix memory leak of kobj->name in sysfs_slab_add()
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Liu Shixin <liushixin2@huawei.com>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, 
	Linux Memory Management List <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 11:10=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com=
> wrote:
>
>
>
> On 2024/10/2 19:35, Vlastimil Babka wrote:
> > On 9/13/24 17:00, Hyeonggon Yoo wrote:
> >>
> >>
> >>> On Sep 13, 2024, at 11:10=E2=80=AFPM, Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>>
> >>> On 9/6/24 10:10, Jinjie Ruan wrote:
> >>>>
> >>>>
> >>>> On 2024/9/5 21:59, Hyeonggon Yoo wrote:
> >>>>> On Thu, Sep 5, 2024 at 12:41=E2=80=AFPM Jinjie Ruan <ruanjinjie@hua=
wei.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 2022/11/12 19:46, Liu Shixin wrote:
> >>>>>>> There is a memory leak of kobj->name in sysfs_slab_add():
> >>>>>>>
> >>>>>>> unreferenced object 0xffff88817e446440 (size 32):
> >>>>>>>   comm "insmod", pid 4085, jiffies 4296564501 (age 126.272s)
> >>>>>>>   hex dump (first 32 bytes):
> >>>>>>>     75 62 69 66 73 5f 69 6e 6f 64 65 5f 73 6c 61 62  ubifs_inode_=
slab
> >>>>>>>     00 65 44 7e 81 88 ff ff 00 00 00 00 00 00 00 00  .eD~........=
....
> >>>>>>>   backtrace:
> >>>>>>>     [<000000005b30fbbd>] __kmalloc_node_track_caller+0x4e/0x150
> >>>>>>>     [<000000002f70da0c>] kstrdup_const+0x4b/0x80
> >>>>>>>     [<00000000c6712c61>] kobject_set_name_vargs+0x2f/0xb0
> >>>>>>>     [<00000000b151218e>] kobject_init_and_add+0xb0/0x120
> >>>>>>>     [<00000000e56a4cf5>] sysfs_slab_add+0x17d/0x220
> >>>>>>>     [<000000009326fd57>] __kmem_cache_create+0x406/0x590
> >>>>>>>     [<00000000dde33cff>] kmem_cache_create_usercopy+0x1fc/0x300
> >>>>>>>     [<00000000fe90cedb>] kmem_cache_create+0x12/0x20
> >>>>>>>     [<000000007a6531c8>] 0xffffffffa02d802d
> >>>>>>>     [<000000000e3b13c7>] do_one_initcall+0x87/0x2a0
> >>>>>>>     [<00000000995ecdcf>] do_init_module+0xdf/0x320
> >>>>>>>     [<000000008821941f>] load_module+0x2f98/0x3330
> >>>>>>>     [<00000000ef51efa4>] __do_sys_finit_module+0x113/0x1b0
> >>>>>>>     [<000000009339fbce>] do_syscall_64+0x35/0x80
> >>>>>>>     [<000000006b7f2033>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> >>>>>>
> >>>>>>
> >>>>>> Hi=EF=BC=8Cevery one,
> >>>>>
> >>>>> Hi.
> >>>>>
> >>>>>> I found the same problem and it solve this problem with the patch,=
 is
> >>>>>> there any plan to update the patch and solve it.
> >>>
> >>> Hmm looks like back in 2022, Hyeonggon had some feedback to the serie=
s which
> >>> was not answered and then it got forgotten. Feel free to take over an=
d send
> >>> an updated version.
> >>
> >>
> >> I was thinking of what the fix would be with my feedback,
> >> and I still think passing different kobj_type (with a dummy release fu=
nction) for early kmem_caches
> >> will be a more appropriate approach.
> >>
> >> However, there is one concern: people that wrote kobject.rst might not=
 like it :(
> >>
> >> in Documentation/core-api/kobject.rst:
> >>> One important point cannot be overstated: every kobject must have a r=
elease() method,
> >>> and the kobject must persist (in a consistent state) until that metho=
d is called. If these constraints are not met,
> >>> the code is flawed. Note that the kernel will warn you if you forget =
to provide a release() method.
> >>> Do not try to get rid of this warning by providing an "empty" release=
 function.
> >>
> >> But obviously we don't want to release caches just because the kernel =
failed to add it to sysfs.
> >>
> >>>>> What kernel version do you use,
> >>>>
> >>>> 6.11.0-rc6
> >>>>
> >>>>> and when do you encounter it or how do you reproduce it?
> >>>>
> >>>> Hi, Hyeonggon,
> >>>>
> >>>> Thank you, I encounter it when doing inject fault test while modprob=
e
> >>>> amdgpu.ko.
> >>>
> >>> So I wonder where's the problem that results in kobject_init_and_add(=
)
> >>> failing. If it's genuinely duplicate name as commit 80da026a8e5d sugg=
ests,
> >>> 6.12-rc1 will have a warning to prevent that. Delayed destruction of
> >>> SLAB_TYPESAFE_BY_RCU caches should also no longer happen with 6.12-rc=
1. So
> >>> worth retrying with that and if it's still failing, we should look at=
 the
> >>> root cause perhaps.
> >>
> >> I thought it was because the memory allocation for a name string faile=
d due to fault injection?
> >
> > Well in any case 6.12-rc1 introduced a new one, fixed by:
> > https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/commit/=
?h=3Dslab/for-6.12-rc1/fixes&id=3D77ced98f0f03fdc196561d1afbe652899c318073
> >
> > So once that's mainline, we can see if anything remains
>
> Using the newest 6.12.0-rc4, the issue still exists in slab:
>
> unreferenced object 0xffffff80ce6da9c0 (size 16):
>   comm "modprobe", pid 12782, jiffies 4299073226
>   hex dump (first 16 bytes):
>     6f 76 6c 5f 69 6e 6f 64 65 00 6d ce 80 ff ff ff  ovl_inode.m.....
>   backtrace (crc 1a460899):
>     [<00000000edf3be8b>] kmemleak_alloc+0x34/0x40
>     [<0000000004121c8d>] __kmalloc_node_track_caller_noprof+0x304/0x3e8
>     [<00000000515e9eda>] kstrdup+0x48/0x84
>     [<000000005d2d0c1a>] kstrdup_const+0x34/0x40
>     [<00000000d14076ce>] kvasprintf_const+0x170/0x1e0
>     [<0000000060f79972>] kobject_set_name_vargs+0x5c/0x12c
>     [<00000000299f544a>] kobject_init_and_add+0xd4/0x168
>     [<000000008ceb40f4>] sysfs_slab_add+0x190/0x21c
>     [<00000000027371b9>] do_kmem_cache_create+0x354/0x5cc
>     [<00000000cc9eb2aa>] __kmem_cache_create_args+0x1b8/0x2c8
>     [<000000006a3e21cc>] 0xffffffea545a409c
>     [<0000000002f945b3>] do_one_initcall+0x110/0x77c
>     [<0000000024f23211>] do_init_module+0x1dc/0x5c8
>     [<00000000a16337d6>] load_module+0x4acc/0x4e90
>     [<00000000be447e77>] init_module_from_file+0xd4/0x128
>     [<0000000048065de1>] idempotent_init_module+0x2d4/0x57c

Hi Jinjie,

Oh, I should've Cc'd you...

https://lore.kernel.org/linux-mm/20241021091413.154775-1-42.hyeyoo@gmail.co=
m/

I wrote a fix for this and I'm adjusting feedback from Christoph and Vlasti=
mil.

Thanks,
Hyeonggon

