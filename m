Return-Path: <linux-kernel+bounces-317212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3C896DAFD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7053F1C247B7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457C519DF60;
	Thu,  5 Sep 2024 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqO+2nPU"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB3A19923F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544768; cv=none; b=c+Chcky8UAaVY/hACqfV6UkfZ6FWpDIuOKPTDLciri7siTSKwVO6ZYZHLF8esweM/goNbyKZYG48ejfth+TtwRUn+98ev5QEMCBGoZ0T4ogiiA9UJ2N1rmIx46mIylGn/dOEZfoH4Yl50hOx1PaAyMEMeY2udKxbBuXLLGzidU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544768; c=relaxed/simple;
	bh=yPo41mr1Z2HdR+mMY1pD7LVraOvgcwSMKbI4Nh5OyqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QUd0TOehzupeFSFF41aORSpbELVe7iX1zo5mIDIA+1kotNj3Vyzm10JjPoiLeJcf9mDYQQM816aJ6sOMM77La6knfP8aDB/cw9+3oajxF+jEDMSAqyZAsYO3oqpuk6jieEijbhD3EZJavVaG0+8DINPPt6Bh2I4GSIR8THeOyRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqO+2nPU; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5353cd2fa28so979047e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 06:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725544765; x=1726149565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vife+4ZTF2oXftiFxvdfKNakPX2GSpX7wpd5U1ID8tg=;
        b=DqO+2nPUtJkxiJCQs7S+7HMKoGzxzRws4wiPor6ZrQlFyTvdBwdfCGV7l6bIQf7Mib
         +jaty0T8To9FKkSBwEWn4IQijrkuXFcT4nm5w8aQuEH7F6YvG1idi8X+vqtElOOBnYID
         sHPgPfuon6y5zhh5aABV40ONuE/41t1Y4aNWGDPKYG+thLP0jzdNyzl2kTOYgIKp7+aS
         gtfmwzfGjU9L//oWYaNm6mbbU3hlLIZ+w8VR9bOdff+vRDDU0ZWLt+9cXkI/PLhEQd5k
         piplmK1S24mXWyHKeRXaH65kzxhbsWY17lD1SRQNLF65HsbaxRjqZXSRE1FS7z9kffTH
         /+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725544765; x=1726149565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vife+4ZTF2oXftiFxvdfKNakPX2GSpX7wpd5U1ID8tg=;
        b=k9t85FlmTKHlXr1DkOQLZmETSAMmO3YxkO7VqQ1ayaNempW9eR4i8Pn/giAyNfQ5fA
         hmPjkWLG/SmaE1YgOj9PgxEb1fxWRJ5cpnR0W41o6M7tHicLn/DROFtrEERQUGh0Zlxj
         L6fAEHAKoRvohssazRd/NOnIqzpz0MaeQ8obUnLCNcUZXj9NQeRqs9eOh6wcyBT1juSk
         5ERUe9oFkl21UDXgcTE+HyYKJItJiz22VmMlkh3NupdgLtijLg17XfatKVtuh50+5lbX
         kKW6TE2lnVLcak2qR2qCOL9otBI1AqaARTb5u3u1CbjpZBwIMrZRFWth9qnpIszklA0q
         8rJg==
X-Forwarded-Encrypted: i=1; AJvYcCUaOSrrX+jFP8i1mlooRK5xrTa9WR1AuyLVFV12cQcRPDg66dd0iBXzvzJ/spuIeS03s0Bbx8NXJAFWINg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+XxNlF2jBR1p1F0k/U0vCw3LkMzeTJcPE+vs+ptXeEHuA+AmD
	7+k10a4Z5jalPKs1EU45AIMRXH/NQBPJ5DqqZjX5fCKvLieS150G3vIHrGGtQgg5DApBw3dLK/J
	HPzA/Sw2qpCGIRJy9A3zIigYGBYQ=
X-Google-Smtp-Source: AGHT+IEPU1QigGvdtM0L8Avx5Fii/b5btBRBdHRMbrQ6kyqy0AFePVOfRAXoHWn9e00knQfqd+lkQ1HAQzvvCB8mi/8=
X-Received: by 2002:a05:6512:3c8a:b0:530:aa09:b6bf with SMTP id
 2adb3069b0e04-53546b34938mr13958753e87.24.1725544764671; Thu, 05 Sep 2024
 06:59:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20221112114602.1268989-1-liushixin2@huawei.com>
 <20221112114602.1268989-4-liushixin2@huawei.com> <3780a622-03f2-4cfe-5705-0e9d0be61d57@huawei.com>
In-Reply-To: <3780a622-03f2-4cfe-5705-0e9d0be61d57@huawei.com>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Thu, 5 Sep 2024 22:59:12 +0900
Message-ID: <CAB=+i9SiiH7JN1tTrmO6FS+HqQcKnwoAs3O2PKxfPy2parM8WA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mm/slub: Fix memory leak of kobj->name in sysfs_slab_add()
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Liu Shixin <liushixin2@huawei.com>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 12:41=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:
>
>
>
> On 2022/11/12 19:46, Liu Shixin wrote:
> > There is a memory leak of kobj->name in sysfs_slab_add():
> >
> >  unreferenced object 0xffff88817e446440 (size 32):
> >    comm "insmod", pid 4085, jiffies 4296564501 (age 126.272s)
> >    hex dump (first 32 bytes):
> >      75 62 69 66 73 5f 69 6e 6f 64 65 5f 73 6c 61 62  ubifs_inode_slab
> >      00 65 44 7e 81 88 ff ff 00 00 00 00 00 00 00 00  .eD~............
> >    backtrace:
> >      [<000000005b30fbbd>] __kmalloc_node_track_caller+0x4e/0x150
> >      [<000000002f70da0c>] kstrdup_const+0x4b/0x80
> >      [<00000000c6712c61>] kobject_set_name_vargs+0x2f/0xb0
> >      [<00000000b151218e>] kobject_init_and_add+0xb0/0x120
> >      [<00000000e56a4cf5>] sysfs_slab_add+0x17d/0x220
> >      [<000000009326fd57>] __kmem_cache_create+0x406/0x590
> >      [<00000000dde33cff>] kmem_cache_create_usercopy+0x1fc/0x300
> >      [<00000000fe90cedb>] kmem_cache_create+0x12/0x20
> >      [<000000007a6531c8>] 0xffffffffa02d802d
> >      [<000000000e3b13c7>] do_one_initcall+0x87/0x2a0
> >      [<00000000995ecdcf>] do_init_module+0xdf/0x320
> >      [<000000008821941f>] load_module+0x2f98/0x3330
> >      [<00000000ef51efa4>] __do_sys_finit_module+0x113/0x1b0
> >      [<000000009339fbce>] do_syscall_64+0x35/0x80
> >      [<000000006b7f2033>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>
>
> Hi=EF=BC=8Cevery one,

Hi.

> I found the same problem and it solve this problem with the patch, is
> there any plan to update the patch and solve it.

What kernel version do you use,
and when do you encounter it or how do you reproduce it?

--
Hyeonggon

