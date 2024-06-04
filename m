Return-Path: <linux-kernel+bounces-201213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87E28FBB06
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83DB2B276C3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5161614A09E;
	Tue,  4 Jun 2024 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y6j19kLm"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA591474D8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717523661; cv=none; b=eBGdlgAWJmlIxBIpUFMjrXKyPiM7hicWbp4dkMbX6mw65b8ygXe85tulccHm12CQ0m+A2V/Z3/UiLcVmGzuXC7R7BMZR5FaF/YvlwGuw+b/0OKY7V5YLW6ewrl/V0ZAK07LJcW/4nHxpGxhdy0CYRTbzjaYChSDFTEtOm6skL30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717523661; c=relaxed/simple;
	bh=pvjvNFsuZm1XCxQL706IG6zhzQH06/KtKZ39FICaL2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrDsFiYj9T2aoqg9zFxADXlkocLLRcDlKsXIDpMdTP9MD569m16Ha6cGX6uJ3QZ4P1b1qWA3LJxtfMDCSFc3OwJhFM4yYMyM+JAHWFO7gQ8WBLSKuPN/Tc2vNVKVylNpXYv88+WAphUc7ZImN8N8/rlTACbqHKuGHZsRPUS27Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y6j19kLm; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso2243a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 10:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717523658; x=1718128458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvjvNFsuZm1XCxQL706IG6zhzQH06/KtKZ39FICaL2E=;
        b=y6j19kLmIMOx53kal1Y8yxk/vt40VB8qfv3FuWvxMfYXEE9qCG7GmBXF5BXc/zObRP
         zLpU16KnUEtSKvmuy6VUYJ66EmgFGbHTRodn6Tv0CmGgPJj3xP6ydqCquR9wAtRANUxh
         few8m0BrqHOq4UtZm+2KcbB/hUc8ogep4HOI7OHswKovt6Zg70wm9e80ekSzPSNHvNgZ
         deSS8JNJ9eF4GclHeKifshbRmZhKl9RrSWXd9wY+sWQX3vl5DHwp09TNJkt4QL6YiHNm
         7s6rsi99Qg7leASubDCBRkg1aE0LPfCPc/b5AHj8D5OjMz3TVsXobNLpWlHbRqy/XH4T
         9QiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717523658; x=1718128458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvjvNFsuZm1XCxQL706IG6zhzQH06/KtKZ39FICaL2E=;
        b=hRR6djdIxpSdPTwNMIMMfH5V4Fnm1hPnZa/+5sZi+yMAwOJpBpdeQPq0mGaitBxqhA
         gFkF3mpsGnqIk1EcttVS6UqLq4WYbHh8dEH9ZBqM9WAVP78BZGbLpiQ66tunt5TIS9sW
         8pJ2RmPiQPihPkvhfz+XJrCppp4Q41KPtUpPisIb00DuqWT8J1FFeDEM+Zb3Ixk9logw
         A51tgl6uVwTC0Gtp7U+gSJvIEp0kLtrBOCQFIbEm741ebAweL78x2m4VQr93fvS5o4uz
         HfEv0X2W9FIetw+9koLKDzVjwX854ESckw//XcDw/j62WKo8sPrrM1tdjEPQbi1aeGQ0
         BuEQ==
X-Forwarded-Encrypted: i=1; AJvYcCURJFq/tTTRCLPyifg10oVoRMFP+xAZOuTZnwha9KliEkZmxBhBdvE97UeWi+p11Ncb44OMmLLgxQSnrrY+U0bFUMbzqZN6xHTQVC2T
X-Gm-Message-State: AOJu0YyR60HdSamgpDEF+oWE0iXuh0UglZK1ACp/m5xt1ueI6ZfDG26x
	p5xNV8OtPEtGty75VC6JKtJYVoFptqnVa4Z8rni14SbavC1acjNHoupsoPQ8feUHW6cpRJnInmk
	1InCG7lk2Zug2oZcf0f5JTzqNpHngpO+VPrgw
X-Google-Smtp-Source: AGHT+IEqQH4VcW+bet6kw3ahjQXxsK9cW/QD3nBI7Uk5BIGc4R3Umj4HZMjvuIihX6oNv84m9DLjuGyDpzWWY0nDRIs=
X-Received: by 2002:aa7:c245:0:b0:57a:2276:2a86 with SMTP id
 4fb4d7f45d1cf-57a8d6e48c9mr2045a12.4.1717523657843; Tue, 04 Jun 2024 10:54:17
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508202111.768b7a4d@yea> <20240515224524.1c8befbe@yea>
 <CAOUHufZ-9NmzOKjLedvZFp0=N0LvRZn77qC6k1WXK+NHtKr=0w@mail.gmail.com>
 <CAOUHufZ36rQc8AfLtRv2QrEareysdvbprAEO5XkcG-FeDOxFLA@mail.gmail.com>
 <20240602200332.3e531ff1@yea> <20240604001304.5420284f@yea>
 <CAJD7tkbCRLdy0vD2Pd17fNrxHgkzW1VucN4qMkohLFLBLaaeCQ@mail.gmail.com>
 <20240604134458.3ae4396a@yea> <CAJD7tkYjJJGthQ_8NukGw6Q9EYbLA=8sAH_7=B90KXEL6HWdSw@mail.gmail.com>
 <CAOUHufa0Fpj6SjNgB-z0n5Jg63q1ewkbOAU65forpDwQVs45qg@mail.gmail.com> <CAJD7tkb=5GJ9SNUwDsu1Zy3Tus4rjsNo60Hg9N7=gGth409Diw@mail.gmail.com>
In-Reply-To: <CAJD7tkb=5GJ9SNUwDsu1Zy3Tus4rjsNo60Hg9N7=gGth409Diw@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 4 Jun 2024 11:53:39 -0600
Message-ID: <CAOUHufb6zXr14Wm3T-4-OJh7iAq+vzDKwVYfHLhMMt96SpiZXg@mail.gmail.com>
Subject: Re: kswapd0: page allocation failure: order:0, mode:0x820(GFP_ATOMIC),
 nodemask=(null),cpuset=/,mems_allowed=0 (Kernel v6.5.9, 32bit ppc)
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Erhard Furtner <erhard_f@mailbox.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 11:34=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, Jun 4, 2024 at 10:19=E2=80=AFAM Yu Zhao <yuzhao@google.com> wrote=
:
> >
> > On Tue, Jun 4, 2024 at 10:12=E2=80=AFAM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > >
> > > On Tue, Jun 4, 2024 at 4:45=E2=80=AFAM Erhard Furtner <erhard_f@mailb=
ox.org> wrote:
> > > >
> > > > On Mon, 3 Jun 2024 16:24:02 -0700
> > > > Yosry Ahmed <yosryahmed@google.com> wrote:
> > > >
> > > > > Thanks for bisecting. Taking a look at the thread, it seems like =
you
> > > > > have a very limited area of memory to allocate kernel memory from=
. One
> > > > > possible reason why that commit can cause an issue is because we =
will
> > > > > have multiple instances of the zsmalloc slab caches 'zspage' and
> > > > > 'zs_handle', which may contribute to fragmentation in slab memory=
.
> > > > >
> > > > > Do you have /proc/slabinfo from a good and a bad run by any chanc=
e?
> > > > >
> > > > > Also, could you check if the attached patch helps? It makes sure =
that
> > > > > even when we use multiple zsmalloc zpools, we will use a single s=
lab
> > > > > cache of each type.
> > > >
> > > > Thanks for looking into this! I got you 'cat /proc/slabinfo' from a=
 good HEAD, from a bad HEAD and from the bad HEAD + your patch applied.
> > > >
> > > > Good was 6be3601517d90b728095d70c14f3a04b9adcb166, bad was b8cf32dc=
6e8c75b712cbf638e0fd210101c22f17 which I got both from my bisect.log. I got=
 the slabinfo shortly after boot and a 2nd time shortly before the OOM or t=
he kswapd0: page allocation failure happens. I terminated the workload (str=
ess-ng --vm 2 --vm-bytes 1930M --verify -v) manually shortly before the 2 G=
iB RAM exhausted and got the slabinfo then.
> > > >
> > > > The patch applied to git b8cf32dc6e8c75b712cbf638e0fd210101c22f17 u=
nfortunately didn't make a difference, I got the kswapd0: page allocation f=
ailure nevertheless.
> > >
> > > Thanks for trying this out. The patch reduces the amount of wasted
> > > memory due to the 'zs_handle' and 'zspage' caches by an order of
> > > magnitude, but it was a small number to begin with (~250K).
> > >
> > > I cannot think of other reasons why having multiple zsmalloc pools
> > > will end up using more memory in the 0.25GB zone that the kernel
> > > allocations can be made from.
> > >
> > > The number of zpools can be made configurable or determined at runtim=
e
> > > by the size of the machine, but I don't want to do this without
> > > understanding the problem here first. Adding other zswap and zsmalloc
> > > folks in case they have any ideas.
> >
> > Hi Erhard,
> >
> > If it's not too much trouble, could you "grep nr_zspages /proc/vmstat"
> > on kernels before and after the bad commit? It'd be great if you could
> > run the grep command right before the OOM kills.
> >
> > The overall internal fragmentation of multiple zsmalloc pools might be
> > higher than a single one. I suspect this might be the cause.
>
> I thought about the internal fragmentation of pools, but zsmalloc
> should have access to highmem, and if I understand correctly the
> problem here is that we are running out of space in the DMA zone when
> making kernel allocations.
>
> Do you suspect zsmalloc is allocating memory from the DMA zone
> initially, even though it has access to highmem?

There was a lot of user memory in the DMA zone. So at a point the
highmem zone was full and allocation fallback happened.

The problem with zone fallback is that recent allocations go into
lower zones, meaning they are further back on the LRU list. This
applies to both user memory and zsmalloc memory -- the latter has a
writeback LRU. On top of this, neither the zswap shrinker nor the
zsmalloc shrinker (compaction) is zone aware. So page reclaim might
have trouble hitting the right target zone.

We can't really tell how zspages are distributed across zones, but the
overall number might be helpful. It'd be great if someone could make
nr_zspages per zone :)

