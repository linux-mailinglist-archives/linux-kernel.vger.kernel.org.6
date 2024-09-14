Return-Path: <linux-kernel+bounces-329419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC9D97911B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 15:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8860A282B33
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 13:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E0A43ABD;
	Sat, 14 Sep 2024 13:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OETWaeGL"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A632D4C7D
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 13:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726321530; cv=none; b=Gz3AzGP0BicZ/t4bYmxNDNUnfSii4V8j2PhlB1z87uReymDOYD6f4kapj/XZ92gnwmsiPf0McY9sR6jLDGB3cQex8kCODkp0r2Oo48cBEQ/wO+gvRLQewqgR8b3G7u3w5NWLgOnzxDWHxg99FqnbRW2NbdRNADd92wkB28jbmFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726321530; c=relaxed/simple;
	bh=3Mw5ZMAxbwuXJTOvXIs8Xe/mcjqxT37F0+3zX+8m+Us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pj5peA6MqJP6KmBUzbA43kc1q1GzY5LpJrwFGvnlXcd0WZOCTBUrzxncgqSXOzh5PvXCiU+wxBd8H4MU8r3fLnb6Wbso5RkVB3VbaWpdoa7ZCEXEFLvnL9UjyNyBJHWViyY6YaLkBL85UKbN4anMVIXt0/em83Tv2uVL1W6Hh9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OETWaeGL; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5365c060f47so3557899e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 06:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726321527; x=1726926327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dnx6z67Qvm8Om8aao/Sb8GX+CmG9uaSgAAMTwiPf1j4=;
        b=OETWaeGLJQuSWD7pZUYPAh6ibumxC6yCf3SSNiiyXb9M7OPHbVl6we0cXa8AjJ4zG8
         CGQc1jp1EhyEGOcLCO4DZR5Y4ttE3IzCDyD+X6ibI0gUhZ7gPLWoJwM8kN6O0u6ah8Ny
         dR0XeR4JTMIKrZnJ4yzPACu4DzdIkdkq6t3jxuY1AEtbi46bD5YCuHnsgqQhL9pm1Ge3
         pzUI/e0Mw0InymYoLFE6fgzB413YTqy5Ah+sfii2CiQSaBlP7utPET4ATBJBAx5La5nF
         t9+1bdBpyLmMLsCDIKjDbG82ppQFWMmBQ4Ct6rzG/m/41DlC4ziVHcbt2spJTX4hCgAR
         d/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726321527; x=1726926327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dnx6z67Qvm8Om8aao/Sb8GX+CmG9uaSgAAMTwiPf1j4=;
        b=UqNOAuViESCA0ppJ53R+3vk3z14cXEF7XJKB5sZGh6PifyNok/fHpUKv2XobIbUD75
         dT64Q1NJNjfJx9Mbfj/Mdq71g+9n3jzUeMZojTpu4Am3D95tu/weubWW9Qzc4qT25h2j
         qaDJWUzCvAVUErNUPAHQhard6i1cdPuuujOO9AJp24FCgPifBg1gUjMPu8olHOD968mh
         xssugCpzezLcW9GrPPWzMLu5o91NHTeRXB3KgaN4mi5ltSg9k3pTPvvR0T3XgCKUnO32
         TxMdLkxwVzm/BiJ9p1ng5ngkISzYYIlXZVEtvM86fE6DHW/w+dZ1cCTObdcCoMzZ6cOv
         XfYA==
X-Forwarded-Encrypted: i=1; AJvYcCXImZJ7XKSk99bT14sXHjHBjRRwjsFUko8pCAtk+isXHdxAtcxTHAdhTTo1dLV0W4Tkq0cEGF2RhqvPaNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeXAKFLMsvx2vJycsHKO+B1o6ShKKYUFqHbKGFQGN1LJdFOaOO
	U/wutJ906Og9D4YKpT+7oqx4w/yIaTPxXth9heeb0DWfFCmqr/ZtclDHMO0F26cJlZy3Ih+Nne3
	oW1LRdVsEfYrTyGIqoF4woMs56U4=
X-Google-Smtp-Source: AGHT+IGbsdHKb+cxECZzgxcilu2dyLbNfszhUAzcNWB/SvN9RP1kKKljZFHLhLufBTxBpmgsNE/LruHhG1Fyv0ydQM4=
X-Received: by 2002:a05:6512:138c:b0:535:6778:952b with SMTP id
 2adb3069b0e04-53678fed19cmr5292708e87.44.1726321526389; Sat, 14 Sep 2024
 06:45:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819070204.753179-1-liuyongqiang13@huawei.com>
 <CAB=+i9TxYRcr+ZRMD31SDay+899RXOwTvQevC=8sv7b27ZO1Vg@mail.gmail.com> <6e744d2b-bbb3-4e1f-bd61-e0e971f974db@huawei.com>
In-Reply-To: <6e744d2b-bbb3-4e1f-bd61-e0e971f974db@huawei.com>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Sat, 14 Sep 2024 22:45:14 +0900
Message-ID: <CAB=+i9RF_kjYgnsPJrE-1STT+zbCOKr3dHPKN1RyR7-jk4NdpA@mail.gmail.com>
Subject: Re: [PATCH] mm, slub: prefetch freelist in ___slab_alloc()
To: Yongqiang Liu <liuyongqiang13@huawei.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, zhangxiaoxu5@huawei.com, 
	cl@linux.com, wangkefeng.wang@huawei.com, penberg@kernel.org, 
	rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, 
	vbabka@suse.cz, roman.gushchin@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 3:58=E2=80=AFPM Yongqiang Liu <liuyongqiang13@huawe=
i.com> wrote:
>
>
> =E5=9C=A8 2024/8/19 17:33, Hyeonggon Yoo =E5=86=99=E9=81=93:
> > On Mon, Aug 19, 2024 at 4:02=E2=80=AFPM Yongqiang Liu <liuyongqiang13@h=
uawei.com> wrote:
> >> commit 0ad9500e16fe ("slub: prefetch next freelist pointer in
> >> slab_alloc()") introduced prefetch_freepointer() for fastpath
> >> allocation. Use it at the freelist firt load could have a bit
> >> improvement in some workloads. Here is hackbench results at
> >> arm64 machine(about 3.8%):
> >>
> >> Before:
> >>    average time cost of 'hackbench -g 100 -l 1000': 17.068
> >>
> >> Afther:
> >>    average time cost of 'hackbench -g 100 -l 1000': 16.416
> >>
> >> There is also having about 5% improvement at x86_64 machine
> >> for hackbench.
> > I think adding more prefetch might not be a good idea unless we have
> > more real-world data supporting it because prefetch might help when sla=
b
> > is frequently used, but it will end up unnecessarily using more cache
> > lines when slab is not frequently used.
>

Hi,

sorry for the late reply.
Thanks for explaining how it impacts hackbench, even when prefetch is
added in the slow path.

However, I still think the main issue is that hackbench is too
synthetic to make a strong argument that
prefetch in the slow path would help in most real-world scenarios.

> Yes, prefetching unnecessary objects is a bad idea. But I think the slab
> entered
>
> in slowpath that means it will more likely need more objects.

The fast path is hit when an object can be allocated from the CPU slab
without much work,
and the slow path is hit when it can=E2=80=99t. This doesn't give any
indication about future allocations.

To be honest, I'm not even sure if prefetching in the fast path really
helps if slab is not frequently called.
Just because it hits the fast path or slow path doesn=E2=80=99t necessarily
mean more objects will be needed in the future.

And then, I don't think "Prefetch some data because we might need it
in the future" is not a good argument
because if we don't need it, it just wastes a cache line. If it helps
in some cases but hurts in other cases,
is not a net gain.

I might be wrong. If I am, please prove me wrong and convince me and others=
.

Best,
Hyeonggon

> I've tested the cases from commit 0ad9500e16fe ("slub: prefetch next free=
list pointer in
> slab_alloc()"). Here is the result:
> Before:
>
> Performance counter stats for './hackbench 50 process 4000' (32 runs):
>
>                  2545.28 msec task-clock                #    6.938 CPUs
> utilized        ( +-  1.75% )
>                       6166     context-switches          #    0.002
> M/sec                    ( +-  1.58% )
>                      1129      cpu-migrations            #    0.444
> K/sec                     ( +-  2.16% )
>                    13298      page-faults                  # 0.005
> M/sec                    ( +-  0.38% )
>          4435113150      cycles                           # 1.742
> GHz                         ( +-  1.22% )
>          2259717630      instructions                 #    0.51 insn per
> cycle           ( +-  0.05% )
>            385847392      branches                     #  151.593
> M/sec                    ( +-  0.06% )
>               6205369       branch-misses            #    1.61% of all
> branches       ( +-  0.56% )
>
>             0.36688 +- 0.00595 seconds time elapsed  ( +-  1.62% )
> After:
>
>   Performance counter stats for './hackbench 50 process 4000' (32 runs):
>
>                 2277.61 msec task-clock                #    6.855 CPUs
> utilized            ( +-  0.98% )
>                      5653      context-switches         #    0.002
> M/sec                       ( +-  1.62% )
>                      1081      cpu-migrations           #    0.475
> K/sec                        ( +-  1.89% )
>                    13217      page-faults                 # 0.006
> M/sec                       ( +-  0.48% )
>          3751509945      cycles                          #    1.647
> GHz                          ( +-  1.14% )
>          2253177626      instructions                #    0.60 insn per
> cycle             ( +-  0.06% )
>            384509166      branches                    #    168.821
> M/sec                    ( +-  0.07% )
>                6045031      branch-misses           #    1.57% of all
> branches          ( +-  0.58% )
>
>             0.33225 +- 0.00321 seconds time elapsed  ( +-  0.97% )
>
> >
> > Also I don't understand how adding prefetch in slowpath affects the per=
formance
> > because most allocs/frees should be done in the fastpath. Could you
> > please explain?
>
> By adding some debug info to count the slowpath for the hackbench:
>
> 'hackbench -g 100 -l 1000' slab alloc total: 80416886, and the slowpath:
> 7184236.
>
> About 9% slowpath in total allocation. The perf stats in arm64 as follow=
=EF=BC=9A
>
> Before:
>   Performance counter stats for './hackbench -g 100 -l 1000' (32 runs):
>
>         34766611220 branches                      ( +-  0.01% )
>             382593804      branch-misses                  # 1.10% of all
> branches          ( +-  0.14% )
>           1120091414 cache-misses                 ( +-  0.08% )
>         76810485402 L1-dcache-loads               ( +-  0.03% )
>           1120091414      L1-dcache-load-misses     #    1.46% of all
> L1-dcache hits    ( +-  0.08% )
>
>             23.8854 +- 0.0804 seconds time elapsed  ( +-  0.34% )
>
> After:
>   Performance counter stats for './hackbench -g 100 -l 1000' (32 runs):
>
>         34812735277 branches                  ( +-  0.01% )
>             393449644      branch-misses             #    1.13% of all
> branches           ( +-  0.15% )
>           1095185949 cache-misses             ( +-  0.15% )
>         76995789602 L1-dcache-loads             ( +-  0.03% )
>           1095185949      L1-dcache-load-misses     #    1.42% of all
> L1-dcache hits    ( +-  0.15% )
>
>              23.341 +- 0.104 seconds time elapsed  ( +-  0.45% )
>
> It seems having less L1-dcache-load-misses.
>
> >
> >> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> >> ---
> >>   mm/slub.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/mm/slub.c b/mm/slub.c
> >> index c9d8a2497fd6..f9daaff10c6a 100644
> >> --- a/mm/slub.c
> >> +++ b/mm/slub.c
> >> @@ -3630,6 +3630,7 @@ static void *___slab_alloc(struct kmem_cache *s,=
 gfp_t gfpflags, int node,
> >>          VM_BUG_ON(!c->slab->frozen);
> >>          c->freelist =3D get_freepointer(s, freelist);
> >>          c->tid =3D next_tid(c->tid);
> >> +       prefetch_freepointer(s, c->freelist);
> >>          local_unlock_irqrestore(&s->cpu_slab->lock, flags);
> >>          return freelist;
> >>
> >> --
> >> 2.25.1
> >>

