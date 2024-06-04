Return-Path: <linux-kernel+bounces-201168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2DE8FBA8D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D086F1C21968
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11AD14A086;
	Tue,  4 Jun 2024 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wTCzgzp8"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286B81494CB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522489; cv=none; b=qdVjug02HRrnhwxU/1UusVmfTNEGPjaoOzcMbLjtqKh7Wr0wyDi2ZbLLWDFIBDzLN8GllPSvdEwX8U0NQNyZOtibS0m1CvfP6ci7C4kNQE9p7FrUzWlN0C+YtGDnjoY9884X7ivCiYtbGbHNd0jJEqjpvwvVEX0doShWCWyMDTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522489; c=relaxed/simple;
	bh=FSAsMIUgpkuY+akx1I0POUHLWSTt61sSZO6HEcvaGx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftkD4ldtJWvRZG7YHTt6rpQ2t4xZhD8K95reA80vQOTx0hI85w0ydTJoULLvlp87RptkWy7uLVvypj86o9V55bMYgppAW3gv4d05c6CMlHuOdiqZjSlhpZyF3tTqQtHxxF4t/AOXbVocftMI3KCMi7bhbzBoHWPkiYf/T6lPQRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wTCzgzp8; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52961b77655so1415019e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 10:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717522486; x=1718127286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSAsMIUgpkuY+akx1I0POUHLWSTt61sSZO6HEcvaGx0=;
        b=wTCzgzp8h/jhyFFO3biznZkrkXsgLrAK9bnCLMpd4nyO2uCL8MKoMA+JSj50qRlAom
         MfkrjRP47vnOPfZ3D7J8MsuaNqffzMuwk6vxtLCW/QmEAarQhc4hfe62UmBQ/EVClDkF
         v2nw8kI8Isudnp98WWzNRlH+Sn2wqu8IBw5r0P8vYnJnmqoLxBPtarwFIEgwOFm2QrRw
         XGRGubfu1ZiRCqZ1A9r4zzct7n8ndRMQzs3EHTZomWmerIDZDH+d6YRw21QHNcWwNt4g
         mQXmlHDrz9QIEBgNVGneK9bnEkdb91y+qZPIFMVbl3zbjrdkF7CvYRceq+jCo4EVMsHZ
         TEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717522486; x=1718127286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSAsMIUgpkuY+akx1I0POUHLWSTt61sSZO6HEcvaGx0=;
        b=pIDSbwX2dW6WGyQgqLSsTkRt6A66ajr/c8J+mdECUJNrfKLHyETwKfT1qeb/026GVL
         2UOuawUbkJf4EFBADjhFrezBSluheXkQ0VO/BAWIgD0dZLAClHqE300ZQzzmK6XrHk1H
         tPNBhkgNN5YHfEUZtM4e/xilKlNat5l20s/xFlKBfosrV9HpdsX8fh1cjV83BL5EcN82
         F2bqcTWDAnjBQO7oAtbsib4eizCHwkX9eob2CsQN3gaXMTiAM8tgA/c8p/9XGZj8waTD
         Edb6mKGt+36sArSfHftGZBodCOYcITz0GDsHuE34hfjHpMil8cIWyO2Gygy5awFSZ3Qk
         Istg==
X-Forwarded-Encrypted: i=1; AJvYcCVolhYFzyk3w+szJtkx2Dj0LRT1bPXrZWHKfeDJVnfULHeJUBeadtbu+SfTyALGW8ORafl0j/sLEnp4qB8f3/HG34Jr1/JcB/tCfqR4
X-Gm-Message-State: AOJu0YzTta59dWBIuPFBpIvx/CTY4+5COxbU/mJS4gtQMwBDGuHPCUHd
	Vzxa0hDqR/yrtBlw5POPePvDVl8OyCNkBKoA2pZYEFT26Vh6h2Oq9qHxVUT/Jy36EhfxRxRFmBV
	kK48AUyYD83iOTg3w5A1joA3Upm1zKVR1dSIr
X-Google-Smtp-Source: AGHT+IHW7hvfcVnmpj1/QggPMRaKYlE7gegvyFwo9KyDFTK+obmZomYA3kKP97Zw+Ic1XOVGi3IkSE+oKfX0RqFKMmE=
X-Received: by 2002:a05:6512:3da3:b0:51f:5872:dd8c with SMTP id
 2adb3069b0e04-52bab4e8a85mr148583e87.39.1717522486012; Tue, 04 Jun 2024
 10:34:46 -0700 (PDT)
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
 <CAOUHufa0Fpj6SjNgB-z0n5Jg63q1ewkbOAU65forpDwQVs45qg@mail.gmail.com>
In-Reply-To: <CAOUHufa0Fpj6SjNgB-z0n5Jg63q1ewkbOAU65forpDwQVs45qg@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 4 Jun 2024 10:34:07 -0700
Message-ID: <CAJD7tkb=5GJ9SNUwDsu1Zy3Tus4rjsNo60Hg9N7=gGth409Diw@mail.gmail.com>
Subject: Re: kswapd0: page allocation failure: order:0, mode:0x820(GFP_ATOMIC),
 nodemask=(null),cpuset=/,mems_allowed=0 (Kernel v6.5.9, 32bit ppc)
To: Yu Zhao <yuzhao@google.com>
Cc: Erhard Furtner <erhard_f@mailbox.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 10:19=E2=80=AFAM Yu Zhao <yuzhao@google.com> wrote:
>
> On Tue, Jun 4, 2024 at 10:12=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Tue, Jun 4, 2024 at 4:45=E2=80=AFAM Erhard Furtner <erhard_f@mailbox=
.org> wrote:
> > >
> > > On Mon, 3 Jun 2024 16:24:02 -0700
> > > Yosry Ahmed <yosryahmed@google.com> wrote:
> > >
> > > > Thanks for bisecting. Taking a look at the thread, it seems like yo=
u
> > > > have a very limited area of memory to allocate kernel memory from. =
One
> > > > possible reason why that commit can cause an issue is because we wi=
ll
> > > > have multiple instances of the zsmalloc slab caches 'zspage' and
> > > > 'zs_handle', which may contribute to fragmentation in slab memory.
> > > >
> > > > Do you have /proc/slabinfo from a good and a bad run by any chance?
> > > >
> > > > Also, could you check if the attached patch helps? It makes sure th=
at
> > > > even when we use multiple zsmalloc zpools, we will use a single sla=
b
> > > > cache of each type.
> > >
> > > Thanks for looking into this! I got you 'cat /proc/slabinfo' from a g=
ood HEAD, from a bad HEAD and from the bad HEAD + your patch applied.
> > >
> > > Good was 6be3601517d90b728095d70c14f3a04b9adcb166, bad was b8cf32dc6e=
8c75b712cbf638e0fd210101c22f17 which I got both from my bisect.log. I got t=
he slabinfo shortly after boot and a 2nd time shortly before the OOM or the=
 kswapd0: page allocation failure happens. I terminated the workload (stres=
s-ng --vm 2 --vm-bytes 1930M --verify -v) manually shortly before the 2 GiB=
 RAM exhausted and got the slabinfo then.
> > >
> > > The patch applied to git b8cf32dc6e8c75b712cbf638e0fd210101c22f17 unf=
ortunately didn't make a difference, I got the kswapd0: page allocation fai=
lure nevertheless.
> >
> > Thanks for trying this out. The patch reduces the amount of wasted
> > memory due to the 'zs_handle' and 'zspage' caches by an order of
> > magnitude, but it was a small number to begin with (~250K).
> >
> > I cannot think of other reasons why having multiple zsmalloc pools
> > will end up using more memory in the 0.25GB zone that the kernel
> > allocations can be made from.
> >
> > The number of zpools can be made configurable or determined at runtime
> > by the size of the machine, but I don't want to do this without
> > understanding the problem here first. Adding other zswap and zsmalloc
> > folks in case they have any ideas.
>
> Hi Erhard,
>
> If it's not too much trouble, could you "grep nr_zspages /proc/vmstat"
> on kernels before and after the bad commit? It'd be great if you could
> run the grep command right before the OOM kills.
>
> The overall internal fragmentation of multiple zsmalloc pools might be
> higher than a single one. I suspect this might be the cause.

I thought about the internal fragmentation of pools, but zsmalloc
should have access to highmem, and if I understand correctly the
problem here is that we are running out of space in the DMA zone when
making kernel allocations.

Do you suspect zsmalloc is allocating memory from the DMA zone
initially, even though it has access to highmem?

>
> Thank you.

