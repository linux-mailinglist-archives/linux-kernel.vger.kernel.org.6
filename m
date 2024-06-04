Return-Path: <linux-kernel+bounces-201146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 755E68FBA22
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89D81F21F19
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE31146D6E;
	Tue,  4 Jun 2024 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lbs8xtxs"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD43B13DDAA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717521547; cv=none; b=kj9MCPrP1DklLu30K+xjpiNqyPcFgWZwj+NiSbgbO/ywoOkg7QCCwV6a4O+BlrX95I0H5790vXXQ6joOH4SndwbOQTdkBcrfns9fr8hYhcafYxQmvR5hGfUciTR7/PU/goK+ZqPOPvyFBbon8IdVBDQvnoAEj20HXibo5v/D5I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717521547; c=relaxed/simple;
	bh=ogohNARcfHl3s69mR1boc+24tgTnFa1tIMowF9fUlWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eyi6DuCxjlfxvx67krAjyuzGHV4QU3WspzP5Q+CXRyaQ3rxFIf0KIqeMMC/zJt4cTvJvVLYOIJeZjuC9Mm3pSUJ1v/u5qkWiio8SW5HTWGN/0ZjVWJmqHYVqc32k12gWPYFOOK+1JKPOEvev1enizOuld5Pjj7A173b0nexby9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lbs8xtxs; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42152bb7b81so7885e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 10:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717521544; x=1718126344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogohNARcfHl3s69mR1boc+24tgTnFa1tIMowF9fUlWI=;
        b=lbs8xtxsLup/g9OKsgBuDQ3dDMpyPdOLhBhXLI8ZYPsb7RU1x4VBBX16AzXtleFZJs
         FWSRlBG24DR730uFHHfgLH1ZH+G/FCJq2tFQkwCYvjAq/BX7slklA5qCJq894WyDP9Lq
         VgzqlKAOX61cGk9P6bg5qElWWl/8S1Ipa3dd+IHdUzPvQUS/aYQ+/lss0zktYp0w6qxr
         ltIs/ysc2SrryhRVgqQsa/7dGbVF0CKC99XjiYRaOvo0h5EGsBgiQvYcTjqRBLGhHm17
         FCfWxUKS9fWx8ncoe/Z+zj4H3ylzsaFb/lHrlwaFFQj8+NBs+5601e0T9kgqhv+0fHP9
         w+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717521544; x=1718126344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogohNARcfHl3s69mR1boc+24tgTnFa1tIMowF9fUlWI=;
        b=OK1SsT6XVLRegtyOMpo1rDid/GIi8dk/en1EjUhzdypPSsIBFMI96oVnja9HxTYlCO
         Rog6kXsQ6bxujJZ6DgA+UEzmrm+orncNBcD385Z4VO98NEi5h2FsPAQWp7gR5PjCVHnG
         +xdbWhNoKiTwyvU2gKRPIRLNXiABZCmcE1SgGG1NuOVRbDTb9FfqLCBbOn+kjnoQ4FnV
         0im5ilN9sFmhd4voSTz2a34hkxiLd8PWKjbHuWLjdLV0eT3dmOLdi7klf9T8yheaQfI2
         98Gz3RKbt/eCFWQjXoMfzxzDZqZemDeSyk2aOFm83sdP9xK3ujqaI0Zyym3AXLntQlvY
         ISeQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3ptCoAnd4sIh7XgtcYFQOuHKSNQQd4njvEjRt2YkROjUONQeWT9eP1Qdp28sVN/9W1v6G+WFVPH+r/WrhquXP5dHKFkrvK+F/imNu
X-Gm-Message-State: AOJu0YzwpLTiEpluff45zZAk3JvWJHHtStQjYKdDT+Mi3i6ePOMpACsN
	A3sRT7+tSiZK7NEYMqcR788HGzXWB4dVPS6GW2yEKTA8zCeom98boC15fQmytQfwCIx9vYlFKYb
	hfHONS9UkdqSS1RknWs5qTMt3RS7JePQhdXkd
X-Google-Smtp-Source: AGHT+IF5/uJiqqJnXLO0gjralIhLsD4wtNsd8X9tynQYjHW0e86jKHZvA4UnWrB4kknhGZbX7Nkad9V0dBq4mHb1naw=
X-Received: by 2002:a7b:c8d7:0:b0:41b:4c6a:de6d with SMTP id
 5b1f17b1804b1-4214b21954cmr2630725e9.5.1717521543952; Tue, 04 Jun 2024
 10:19:03 -0700 (PDT)
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
In-Reply-To: <CAJD7tkYjJJGthQ_8NukGw6Q9EYbLA=8sAH_7=B90KXEL6HWdSw@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 4 Jun 2024 11:18:25 -0600
Message-ID: <CAOUHufa0Fpj6SjNgB-z0n5Jg63q1ewkbOAU65forpDwQVs45qg@mail.gmail.com>
Subject: Re: kswapd0: page allocation failure: order:0, mode:0x820(GFP_ATOMIC),
 nodemask=(null),cpuset=/,mems_allowed=0 (Kernel v6.5.9, 32bit ppc)
To: Erhard Furtner <erhard_f@mailbox.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Minchan Kim <minchan@kernel.org>, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 10:12=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, Jun 4, 2024 at 4:45=E2=80=AFAM Erhard Furtner <erhard_f@mailbox.o=
rg> wrote:
> >
> > On Mon, 3 Jun 2024 16:24:02 -0700
> > Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > > Thanks for bisecting. Taking a look at the thread, it seems like you
> > > have a very limited area of memory to allocate kernel memory from. On=
e
> > > possible reason why that commit can cause an issue is because we will
> > > have multiple instances of the zsmalloc slab caches 'zspage' and
> > > 'zs_handle', which may contribute to fragmentation in slab memory.
> > >
> > > Do you have /proc/slabinfo from a good and a bad run by any chance?
> > >
> > > Also, could you check if the attached patch helps? It makes sure that
> > > even when we use multiple zsmalloc zpools, we will use a single slab
> > > cache of each type.
> >
> > Thanks for looking into this! I got you 'cat /proc/slabinfo' from a goo=
d HEAD, from a bad HEAD and from the bad HEAD + your patch applied.
> >
> > Good was 6be3601517d90b728095d70c14f3a04b9adcb166, bad was b8cf32dc6e8c=
75b712cbf638e0fd210101c22f17 which I got both from my bisect.log. I got the=
 slabinfo shortly after boot and a 2nd time shortly before the OOM or the k=
swapd0: page allocation failure happens. I terminated the workload (stress-=
ng --vm 2 --vm-bytes 1930M --verify -v) manually shortly before the 2 GiB R=
AM exhausted and got the slabinfo then.
> >
> > The patch applied to git b8cf32dc6e8c75b712cbf638e0fd210101c22f17 unfor=
tunately didn't make a difference, I got the kswapd0: page allocation failu=
re nevertheless.
>
> Thanks for trying this out. The patch reduces the amount of wasted
> memory due to the 'zs_handle' and 'zspage' caches by an order of
> magnitude, but it was a small number to begin with (~250K).
>
> I cannot think of other reasons why having multiple zsmalloc pools
> will end up using more memory in the 0.25GB zone that the kernel
> allocations can be made from.
>
> The number of zpools can be made configurable or determined at runtime
> by the size of the machine, but I don't want to do this without
> understanding the problem here first. Adding other zswap and zsmalloc
> folks in case they have any ideas.

Hi Erhard,

If it's not too much trouble, could you "grep nr_zspages /proc/vmstat"
on kernels before and after the bad commit? It'd be great if you could
run the grep command right before the OOM kills.

The overall internal fragmentation of multiple zsmalloc pools might be
higher than a single one. I suspect this might be the cause.

Thank you.

