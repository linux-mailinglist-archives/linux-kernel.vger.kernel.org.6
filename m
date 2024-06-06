Return-Path: <linux-kernel+bounces-204717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B470F8FF2C3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52D51C25EC4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69453198A17;
	Thu,  6 Jun 2024 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hRe9ouoj"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055411CAA9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692183; cv=none; b=rc9Fm+FqR9LqGcZk5UiVjPZdENerCQSsZwsAaEPRfk4LWyaHzbo6Lkam1RurbCwNZni7YXYti20Tulg0vry2LDE+BmZ0xb5Jnk6UiXHU0N5v0Y4d0rmf1qyioUqLuOzotlvHNtZPlNaZg/91rLfi/Go+4c5B7+RV2mVkN5Nn3SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692183; c=relaxed/simple;
	bh=AJAGh2u2V4Tk6rAVOOJogH71dvDxba8eyU1Mqdojbzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ehJHw0+YPDMHRWysBr68Gkj5I3e8x63NIF9tDwvKcO/tt2ep58gFVl9gHA0Z8Q8yZdMXoZKhpV9/BoITM21rhEwgu5M8wJqDcldiM/WChHk34zBFi3I3mGXxklUUKmicq1xDY61OWN5++cwoLDwVNgsq2TgWOAxcmRz1NdFDIR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hRe9ouoj; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c9cc681e4fso628122b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 09:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717692181; x=1718296981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJAGh2u2V4Tk6rAVOOJogH71dvDxba8eyU1Mqdojbzs=;
        b=hRe9ouoj+zjoXqs45pkT4hnhTjD1/JXfX4+R645zYamVcshpCyYaIUvgmWFcR1apPF
         U03JQkwtCxzJJj1iWiETFIDMNUREIDzGGpO+0Q6Xfj3vZ+EggipQXrykbpTQTMFoM0Ej
         Jf9V9cckM2PrnvS6BlEgvHsARQnIVv+9QtZ3XOiop7OSUzcuJy6OwEAkv/DqGIpbhZo0
         py458+P4Z7ss8VyLUYJyAU3ycPETO2+OJ8H0bTSU94pT20zxftZPiWVijThMudyUwpxB
         VHHOxzTWl8Vt0Bg1J9JABOCISOzzCOxp8t1VgQH/x5O95RNYgDTHYAwXYal0IoUASeQb
         3dLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717692181; x=1718296981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJAGh2u2V4Tk6rAVOOJogH71dvDxba8eyU1Mqdojbzs=;
        b=VXD7zM6hYQ6b6zeuh5PHO8t/mGAQItcQwIdLE8QOP8XjbLxPv6dKX+CazsZS0h4p9b
         039mlYmhkE3Trjv9bD2K5alZ2D/qfSh4v8u05tpJJwm4ZNXg8ywIEQSwlkX9Yfg0Fi/T
         K7b7+VYK81NGIwj2iPlxyYvQD48f+Sh+5jnVYEP/ga1By4UXVlFI9biBOjiOIeYYpXsl
         ufBN1o010tlHJn3ZWPZv2+luKi1tbYMTdJD43oWBNxRdOz2ZYcyuST2Fr0BBGiAxl8l0
         l5mX/iWo59a/gZlBiRkC/Sqjf6RHFiE7Uja1c59SovNuXTXaRGivcU4o+jK0CRpz81TD
         9JpA==
X-Forwarded-Encrypted: i=1; AJvYcCVN8MPmro6hD2zrnq/IcykVRF6JEP598c2FoS72x6stdtvk5AZsicHN5iVmLoxKeGKvzcUt0K9QNfX2NIRLpciAsE76Bzhe4CX9fAEl
X-Gm-Message-State: AOJu0Yybw3VjFcLGdrx9KgDnxDoApVo9vmWLQXiaDdWz4KNE/BSyUVIK
	KTbseaJa0ESfEuJl1wWwmObxb+oMjCkThW2ajsHGMQ0K+sM/yzA62ZOg3bxzyonwBcWth34MqAG
	3t2gedfoDptviR4lre2rgv5PYtwWaH1KbFlYx6rxuPGv5Z2yg/4nbQps=
X-Google-Smtp-Source: AGHT+IERasBuiqHdx/CCrfgVVuGNQ623zgMJ03/a4UqBThWZ9fbNc1TBReaGQpa20gK0M9sgOEpWNx7/XFo7+8WGkqg=
X-Received: by 2002:a54:448c:0:b0:3d2:368:9251 with SMTP id
 5614622812f47-3d2044e5e2bmr6367048b6e.38.1717692180748; Thu, 06 Jun 2024
 09:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508202111.768b7a4d@yea> <CAOUHufZ36rQc8AfLtRv2QrEareysdvbprAEO5XkcG-FeDOxFLA@mail.gmail.com>
 <20240602200332.3e531ff1@yea> <20240604001304.5420284f@yea>
 <CAJD7tkbCRLdy0vD2Pd17fNrxHgkzW1VucN4qMkohLFLBLaaeCQ@mail.gmail.com>
 <20240604134458.3ae4396a@yea> <CAJD7tkYjJJGthQ_8NukGw6Q9EYbLA=8sAH_7=B90KXEL6HWdSw@mail.gmail.com>
 <CAOUHufa0Fpj6SjNgB-z0n5Jg63q1ewkbOAU65forpDwQVs45qg@mail.gmail.com>
 <CAJD7tkb=5GJ9SNUwDsu1Zy3Tus4rjsNo60Hg9N7=gGth409Diw@mail.gmail.com>
 <CAOUHufb6zXr14Wm3T-4-OJh7iAq+vzDKwVYfHLhMMt96SpiZXg@mail.gmail.com>
 <CAJD7tkZ+QY55GTzW9A7ZCm=rxAEfrW76cWXf8o5nwiKSXp8z=w@mail.gmail.com>
 <20240604231019.18e2f373@yea> <CAJD7tkYq5u7B+0UH2XKpeWJnUxoO2kJ1_XZ2JOgYpyNEVR7u0g@mail.gmail.com>
 <20240606010431.2b33318c@yea> <CAJD7tkbhWYzx=6YmzAh0F+cK-_Bn8mPOH7gMbQS7YVXmaFSgFg@mail.gmail.com>
 <CAOUHufZ8BTTx1LoXHjHGnzJE9dzyv8EnvhpXMUm0NOt=P5KHVg@mail.gmail.com>
 <CAJD7tkai+e39hFDJkQRZ_Zg_Yp8OWx2uQfawT28ZZTD=Jvh9EQ@mail.gmail.com> <20240606152802.28a38817@yea>
In-Reply-To: <20240606152802.28a38817@yea>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 6 Jun 2024 09:42:21 -0700
Message-ID: <CAJD7tkbhHDLttSC8i93G2Sq3LtC_vh=rqOuh3PEjU=NrbNrABg@mail.gmail.com>
Subject: Re: kswapd0: page allocation failure: order:0, mode:0x820(GFP_ATOMIC),
 nodemask=(null),cpuset=/,mems_allowed=0 (Kernel v6.5.9, 32bit ppc)
To: Erhard Furtner <erhard_f@mailbox.org>
Cc: Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Minchan Kim <minchan@kernel.org>, 
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 6:28=E2=80=AFAM Erhard Furtner <erhard_f@mailbox.org=
> wrote:
>
> On Wed, 5 Jun 2024 16:58:11 -0700
> Yosry Ahmed <yosryahmed@google.com> wrote:
>
> > On Wed, Jun 5, 2024 at 4:53=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrot=
e:
> > >
> > > On Wed, Jun 5, 2024 at 5:42=E2=80=AFPM Yosry Ahmed <yosryahmed@google=
.com> wrote:
> > > >
> > > > On Wed, Jun 5, 2024 at 4:04=E2=80=AFPM Erhard Furtner <erhard_f@mai=
lbox.org> wrote:
> > > > >
> > > > > On Tue, 4 Jun 2024 20:03:27 -0700
> > > > > Yosry Ahmed <yosryahmed@google.com> wrote:
> > > > >
> > > > > > Could you check if the attached patch helps? It basically chang=
es the
> > > > > > number of zpools from 32 to min(32, nr_cpus).
> > > > >
> > > > > Thanks! The patch does not fix the issue but it helps.
> > > > >
> > > > > Means I still get to see the 'kswapd0: page allocation failure' i=
n the dmesg, a 'stress-ng-vm: page allocation failure' later on, another ks=
wapd0 error later on, etc. _but_ the machine keeps running the workload, st=
ays usable via VNC and I get no hard crash any longer.
> > > > >
> > > > > Without patch kswapd0 error and hard crash (need to power-cycle) =
<3min. With patch several kswapd0 errors but running for 2 hrs now. I doubl=
e checked this to be sure.
> > > >
> > > > Thanks for trying this out. This is interesting, so even two zpools=
 is
> > > > too much fragmentation for your use case.
> > >
> > > Now I'm a little bit skeptical that the problem is due to fragmentati=
on.
> > >
> > > > I think there are multiple ways to go forward here:
> > > > (a) Make the number of zpools a config option, leave the default as
> > > > 32, but allow special use cases to set it to 1 or similar. This is
> > > > probably not preferable because it is not clear to users how to set
> > > > it, but the idea is that no one will have to set it except special =
use
> > > > cases such as Erhard's (who will want to set it to 1 in this case).
> > > >
> > > > (b) Make the number of zpools scale linearly with the number of CPU=
s.
> > > > Maybe something like nr_cpus/4 or nr_cpus/8. The problem with this
> > > > approach is that with a large number of CPUs, too many zpools will
> > > > start having diminishing returns. Fragmentation will keep increasin=
g,
> > > > while the scalability/concurrency gains will diminish.
> > > >
> > > > (c) Make the number of zpools scale logarithmically with the number=
 of
> > > > CPUs. Maybe something like 4log2(nr_cpus). This will keep the numbe=
r
> > > > of zpools from increasing too much and close to the status quo. The
> > > > problem is that at a small number of CPUs (e.g. 2), 4log2(nr_cpus)
> > > > will actually give a nr_zpools > nr_cpus. So we will need to come u=
p
> > > > with a more fancy magic equation (e.g. 4log2(nr_cpus/4)).
> > > >
> > > > (d) Make the number of zpools scale linearly with memory. This make=
s
> > > > more sense than scaling with CPUs because increasing the number of
> > > > zpools increases fragmentation, so it makes sense to limit it by th=
e
> > > > available memory. This is also more consistent with other magic
> > > > numbers we have (e.g. SWAP_ADDRESS_SPACE_SHIFT).
> > > >
> > > > The problem is that unlike zswap trees, the zswap pool is not
> > > > connected to the swapfile size, so we don't have an indication for =
how
> > > > much memory will be in the zswap pool. We can scale the number of
> > > > zpools with the entire memory on the machine during boot, but this
> > > > seems like it would be difficult to figure out, and will not take i=
nto
> > > > consideration memory hotplugging and the zswap global limit changin=
g.
> > > >
> > > > (e) A creative mix of the above.
> > > >
> > > > (f) Something else (probably simpler).
> > > >
> > > > I am personally leaning toward (c), but I want to hear the opinions=
 of
> > > > other people here. Yu, Vlastimil, Johannes, Nhat? Anyone else?
> > >
> > > I double checked that commit and didn't find anything wrong. If we ar=
e
> > > all in the mood of getting to the bottom, can we try using only 1
> > > zpool while there are 2 available? I.e.,
> >
> > Erhard, do you mind checking if Yu's diff below to use a single zpool
> > fixes the problem completely? There is also an attached patch that
> > does the same thing if this is easier to apply for you.
>
> No, setting ZSWAP_NR_ZPOOLS to 1 does not fix the problem unfortunately (=
that being the only patch applied on v6.10-rc2).

This confirms Yu's theory that the zpools fragmentation is not the
main reason for the problem. As Vlastimil said, the setup is already
tight on memory and that commit may have just pushed it over the edge.
Since setting ZSWAP_NR_ZPOOLS to 1 (which effectively reverts the
commit) does not help in v6.10-rc2, then something else that came
after the commit would have pushed it over the edge anyway.

>
> Trying to alter the lowmem and virtual mem limits next as Michael suggest=
ed.

I saw that this worked. So it seems like we don't need to worry about
the number of zpools, for now at least :)

Thanks for helping with the testing, and thanks to everyone else who
helped on this thread.

>
> Regards,
> Erhard

