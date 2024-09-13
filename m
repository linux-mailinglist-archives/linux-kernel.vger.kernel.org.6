Return-Path: <linux-kernel+bounces-328420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7BA97832B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296572815C7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BC347F4D;
	Fri, 13 Sep 2024 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtTZUxVM"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF283CF65
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 15:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726239661; cv=none; b=lAYnuaKhFPgH69yazzJMPsCW/FJ49/lr7xU1uTh3Jkj1qK0xwuYfGTLas6Ts0MQGoC3jllsFVQPRAUBpcmFcClZ3v6QESQcujoEVkSMZAQN0v2hJLUm12zUeCt7eQ41qPGlu+FJkpT/Et8WvTCKqpwa9A5dSrj9iCpNwXPdcvwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726239661; c=relaxed/simple;
	bh=D0BsqrESUn3CNNANd71RGCDL9Jb0VyXIGkZQYIFY77w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lFtwdnCQcTzfC6eCuidYWX9eY72UW+BFmI6oMYNW6uD1JnDSyOB8EgPyNYTH7TPlUJXqNn39cjgwdCxiMJ9o1F9+eici3h7tBQ0uTl8yumoBYHX9x0RhwnF1+wvhWz8382hgTn8YrYh1a4jaXPK74kCFrcTBXxBFQvXh3pQH25c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtTZUxVM; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7d4fbe62bf5so633766a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726239659; x=1726844459; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3Mppbi6m7S/7tZ1+dZD34mmp/ZIrHqDzlLOK34QtX4=;
        b=YtTZUxVMRAXwUGb63klcouevl6e4CVeZSeRTVLz4rrXcye+dJaNYkyumGlJpKu5JdE
         x1cZN9o0g8o//iGDplDskrMW0P16uv/bCD4ZwdVbtWR/6dEUWsnyQoGgkr6N2bdiCRrK
         IfCSs5tc2jhrPY+TJXYAH8oVCots4wukM4JmqqnFXhcOfVhw9kXljcCUbsfNtebDiUOB
         WBwQ+Cv2IKgp33T+QTLuNSdAAne88WKq1uuhwiKaBJqD10k9N69yynblujOAuHcohtrg
         6j/kqW4tXMmoeaVzwpC82sSY4rII5oS4p1D/TzRiQLq6sHLfP0eslSFbd97Dxn9WU32q
         hYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726239659; x=1726844459;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3Mppbi6m7S/7tZ1+dZD34mmp/ZIrHqDzlLOK34QtX4=;
        b=F+XF32mWQccAL2JAEWKCwv+2w0wGacOc5U0FT/PPEvUZwSz3F+gDyveOe0vRWQqLz4
         iFxpZeiq6WdzwvfyvIt1d+KNuaBD+cuB6QUmzWR/KMNpsMDEiN8zYmkrhqPWQs+4kyWP
         nZCVROcTQzxhtwuqlx7DANXe8ztSdxYnxf1tEY0VFOg3Nw+lCbvN78rCPz2zgtQrvcZe
         NMAlA1I8xA/3qhQ+4y1pU0zNMT3Ju4NseauvqsFR3sGhGUoQUmoMSvbOXQByZLznHkg6
         e9Gia8bxY0ZxM53MPnOQXjyADU7bD3vebGBvz3rhFUXDT7QOaOGzr7XDAkcy6jIqlsPW
         ZT0w==
X-Forwarded-Encrypted: i=1; AJvYcCWdEDN8iR3mPyB3smBx8vHojOa5ZZkIk9t//2Qm0XRTeclfILZTbbKxCe0oZjLkhSV14hvMaF46ruaVjNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Ob9ubFsiR4O2sO85th0wkBV27odF/I9bSetAZr1MaoX0Ovyz
	wBuua++EEZXxIIFhPr85HJFoJd5vdvEeF84QBR9QUvXVeSvEyiAd
X-Google-Smtp-Source: AGHT+IGM3XnVTc2vJfX07FmlXZSJzOFVd3e3Zszr5uh21tUMVvFkskiIYylTVNjdU7ivL37Ac9CLQw==
X-Received: by 2002:a05:6a21:3482:b0:1cf:489a:52c1 with SMTP id adf61e73a8af0-1d112b68d47mr5130543637.18.1726239658677;
        Fri, 13 Sep 2024 08:00:58 -0700 (PDT)
Received: from smtpclient.apple ([114.29.21.112])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090ad428sm6408659b3a.142.2024.09.13.08.00.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2024 08:00:57 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.46\))
Subject: Re: [PATCH v4 3/3] mm/slub: Fix memory leak of kobj->name in
 sysfs_slab_add()
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
In-Reply-To: <02820eb8-0b8f-4aa8-9315-85368e9c331e@suse.cz>
Date: Sat, 14 Sep 2024 00:00:40 +0900
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
 Liu Shixin <liushixin2@huawei.com>,
 Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Linux Memory Management List <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0F94364A-F0C8-4C0A-B38D-3DDEA653B6B7@gmail.com>
References: <20221112114602.1268989-1-liushixin2@huawei.com>
 <20221112114602.1268989-4-liushixin2@huawei.com>
 <3780a622-03f2-4cfe-5705-0e9d0be61d57@huawei.com>
 <CAB=+i9SiiH7JN1tTrmO6FS+HqQcKnwoAs3O2PKxfPy2parM8WA@mail.gmail.com>
 <68b86f66-cd00-bb7d-b8bb-5a94e8dd1ea2@huawei.com>
 <02820eb8-0b8f-4aa8-9315-85368e9c331e@suse.cz>
To: Vlastimil Babka <vbabka@suse.cz>
X-Mailer: Apple Mail (2.3826.200.46)



> On Sep 13, 2024, at 11:10=E2=80=AFPM, Vlastimil Babka <vbabka@suse.cz> =
wrote:
>=20
> On 9/6/24 10:10, Jinjie Ruan wrote:
>>=20
>>=20
>> On 2024/9/5 21:59, Hyeonggon Yoo wrote:
>>> On Thu, Sep 5, 2024 at 12:41=E2=80=AFPM Jinjie Ruan =
<ruanjinjie@huawei.com> wrote:
>>>>=20
>>>>=20
>>>>=20
>>>> On 2022/11/12 19:46, Liu Shixin wrote:
>>>>> There is a memory leak of kobj->name in sysfs_slab_add():
>>>>>=20
>>>>> unreferenced object 0xffff88817e446440 (size 32):
>>>>>   comm "insmod", pid 4085, jiffies 4296564501 (age 126.272s)
>>>>>   hex dump (first 32 bytes):
>>>>>     75 62 69 66 73 5f 69 6e 6f 64 65 5f 73 6c 61 62  =
ubifs_inode_slab
>>>>>     00 65 44 7e 81 88 ff ff 00 00 00 00 00 00 00 00  =
.eD~............
>>>>>   backtrace:
>>>>>     [<000000005b30fbbd>] __kmalloc_node_track_caller+0x4e/0x150
>>>>>     [<000000002f70da0c>] kstrdup_const+0x4b/0x80
>>>>>     [<00000000c6712c61>] kobject_set_name_vargs+0x2f/0xb0
>>>>>     [<00000000b151218e>] kobject_init_and_add+0xb0/0x120
>>>>>     [<00000000e56a4cf5>] sysfs_slab_add+0x17d/0x220
>>>>>     [<000000009326fd57>] __kmem_cache_create+0x406/0x590
>>>>>     [<00000000dde33cff>] kmem_cache_create_usercopy+0x1fc/0x300
>>>>>     [<00000000fe90cedb>] kmem_cache_create+0x12/0x20
>>>>>     [<000000007a6531c8>] 0xffffffffa02d802d
>>>>>     [<000000000e3b13c7>] do_one_initcall+0x87/0x2a0
>>>>>     [<00000000995ecdcf>] do_init_module+0xdf/0x320
>>>>>     [<000000008821941f>] load_module+0x2f98/0x3330
>>>>>     [<00000000ef51efa4>] __do_sys_finit_module+0x113/0x1b0
>>>>>     [<000000009339fbce>] do_syscall_64+0x35/0x80
>>>>>     [<000000006b7f2033>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>>>=20
>>>>=20
>>>> Hi=EF=BC=8Cevery one,
>>>=20
>>> Hi.
>>>=20
>>>> I found the same problem and it solve this problem with the patch, =
is
>>>> there any plan to update the patch and solve it.
>=20
> Hmm looks like back in 2022, Hyeonggon had some feedback to the series =
which
> was not answered and then it got forgotten. Feel free to take over and =
send
> an updated version.


I was thinking of what the fix would be with my feedback,
and I still think passing different kobj_type (with a dummy release =
function) for early kmem_caches
will be a more appropriate approach.

However, there is one concern: people that wrote kobject.rst might not =
like it :(

in Documentation/core-api/kobject.rst:
> One important point cannot be overstated: every kobject must have a =
release() method,
> and the kobject must persist (in a consistent state) until that method =
is called. If these constraints are not met,
> the code is flawed. Note that the kernel will warn you if you forget =
to provide a release() method.
> Do not try to get rid of this warning by providing an "empty" release =
function.

But obviously we don't want to release caches just because the kernel =
failed to add it to sysfs.

>>> What kernel version do you use,
>>=20
>> 6.11.0-rc6
>>=20
>>> and when do you encounter it or how do you reproduce it?
>>=20
>> Hi, Hyeonggon,
>>=20
>> Thank you, I encounter it when doing inject fault test while modprobe
>> amdgpu.ko.
>=20
> So I wonder where's the problem that results in kobject_init_and_add()
> failing. If it's genuinely duplicate name as commit 80da026a8e5d =
suggests,
> 6.12-rc1 will have a warning to prevent that. Delayed destruction of
> SLAB_TYPESAFE_BY_RCU caches should also no longer happen with =
6.12-rc1. So
> worth retrying with that and if it's still failing, we should look at =
the
> root cause perhaps.

I thought it was because the memory allocation for a name string failed =
due to fault injection?

>=20
>>>=20
>>> --
>>> Hyeonggon



