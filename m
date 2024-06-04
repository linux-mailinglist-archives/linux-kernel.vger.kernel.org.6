Return-Path: <linux-kernel+bounces-201370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4F98FBDA1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0984328248A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 20:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013F614BF98;
	Tue,  4 Jun 2024 20:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S8UqXFe9"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0EE14658E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 20:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717534590; cv=none; b=XqS2ngvKo29dGVx1I9dekJAZLatMNsjZEXJ+2jHb2bn3sC9s+KLnNPhUFj4HFnynORm9Jm+XiSSSwRhdyk795TqctIJeatwGzZAwk7G9JFSRidTR0mjIKDg474V2YP65NRCBrcESbkfKPAq/vi86qWoRCBnOhULsywqZlJalsMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717534590; c=relaxed/simple;
	bh=yixnwk1acrCc7j6Ry52H6KKiowljYjrZFznnIBUrPrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNk9IiZ7tnboZg80jzsJzJGiYTekiwJSvdMP5qi5h+LYp18Bv9OwFKZZtCNeiTUeEjTSfCLcQvyVSapRPnkxzThLX4GltFITqqszgdG1k247AngVYpSR/YBC7+tJbkllOjFwX6nsbaTKRCLDjtdvIsKz+lYYgiddDXt6am+pDWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S8UqXFe9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42155143bb6so5771315e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 13:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717534587; x=1718139387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/2NrBR2dMh4jxaJHvIIkbx6ft/lfiJX+xOAj1QR9Ns=;
        b=S8UqXFe99Ofy8TbJlChIvxthsH4OJcrA/sgqQ+InAU0Vgu4cLDF6M2EweSu0X4ymwW
         +MnPfbb4EF5qL0cWJ5dt0y4ziklULzbpd2V1w9vx2U6YS6baiHR4OF1XvHp2Pdenl3+n
         lVUIwq6aPI4tvR+dKeiC/qB2fUIOs7otBWa7sDAwQQA29+342zpaikJ7t/CvCcQbt75v
         9qoMpWI0hdmlCkXOqtx8gVIjHgLFmbWJvLY0gpSGE8e+HO07V9uDn2rKzsT2K6RR6IZ+
         BEs/Et3xDLcuA4wOAwztT4JzsXOweE5c0H+3zsslWGwBIq/hG3UKrx3+3mPwFuy+o4/H
         2cHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717534587; x=1718139387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/2NrBR2dMh4jxaJHvIIkbx6ft/lfiJX+xOAj1QR9Ns=;
        b=j887fZ3wbNKYM3tsqzIUVH6XTGOzP2Uun/YcEhrEToMy18uNTUCc9V/Wvk7t0b9YMB
         pYbDSJHHvWGG7CWcXoBCQn2RubadoB32as5aCuubi89T5eOLMqZA56VZL24uyYtxYx3M
         /jtw88vu6mst+BRRRpsfb6aQvEMRo3e4lI1KBNQeUVAaOYwyGQsplUYNuPFdxGyFh+ha
         W4fmITTuPdcawHtgY+Oh7/fm2Q7Nf3KmAcrHQbU9TZ9oXeHpbI2YAA/yKLp8Z4JIzzQe
         IB3Q4terVdZiyly0Fl7ri2x8SAWcKOxYBGyojY9NZiILQM9bGmUxzObmUF/WXYNQEGrr
         knXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4H6qtZthH+3qyrrBPSmcalnf37nXxIZurA+UeSLtougkGI3UNnnFwkB92dnIGTbPbSYIfkCwV7BC+BhpsoCCQ4rtCa85uI8NMXhW+
X-Gm-Message-State: AOJu0YyHC7mQwmqlFwLinuIQtpTYDXnF9AEuKlkJDeFic1AAWia9L5XF
	rL/CjU0GR+Ygf0jwwykpd2SeVE2mvW5pin8gkzC15SylqCng+K3sc/UmBhNGcmxF/vhnmR/uyXq
	DjDgzxWqdBYmj2b/ym7m2EYffsUxi6aZIcXMJ
X-Google-Smtp-Source: AGHT+IE6JmQAll+GNDs0FWYMgmBviEFJQQ7PiqrGzd9Dp0vvE7AUoPNGThQbFCpeMIguYSHNdWujsqidz+e0T1ALypc=
X-Received: by 2002:adf:f6c8:0:b0:355:41b:d391 with SMTP id
 ffacd0b85a97d-35e8ef93cc6mr429509f8f.65.1717534586541; Tue, 04 Jun 2024
 13:56:26 -0700 (PDT)
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
 <CAJD7tkbCRLdy0vD2Pd17fNrxHgkzW1VucN4qMkohLFLBLaaeCQ@mail.gmail.com> <5c69cee6-f101-4c86-b38a-7c5c8679ea9b@kernel.org>
In-Reply-To: <5c69cee6-f101-4c86-b38a-7c5c8679ea9b@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 4 Jun 2024 13:55:47 -0700
Message-ID: <CAJD7tkZx-hzVg=TttC7hNSzUXPTMzi+EjUrdO8BdnswyDVEnxA@mail.gmail.com>
Subject: Re: kswapd0: page allocation failure: order:0, mode:0x820(GFP_ATOMIC),
 nodemask=(null),cpuset=/,mems_allowed=0 (Kernel v6.5.9, 32bit ppc)
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Erhard Furtner <erhard_f@mailbox.org>, Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 1:52=E2=80=AFPM Vlastimil Babka (SUSE) <vbabka@kerne=
l.org> wrote:
>
> On 6/4/24 1:24 AM, Yosry Ahmed wrote:
> > On Mon, Jun 3, 2024 at 3:13=E2=80=AFPM Erhard Furtner <erhard_f@mailbox=
.org> wrote:
> >>
> >> On Sun, 2 Jun 2024 20:03:32 +0200
> >> Erhard Furtner <erhard_f@mailbox.org> wrote:
> >>
> >> > On Sat, 1 Jun 2024 00:01:48 -0600
> >> > Yu Zhao <yuzhao@google.com> wrote:
> >> >
> >> > > The OOM kills on both kernel versions seem to be reasonable to me.
> >> > >
> >> > > Your system has 2GB memory and it uses zswap with zsmalloc (which =
is
> >> > > good since it can allocate from the highmem zone) and zstd/lzo (wh=
ich
> >> > > doesn't matter much). Somehow -- I couldn't figure out why -- it
> >> > > splits the 2GB into a 0.25GB DMA zone and a 1.75GB highmem zone:
> >> > >
> >> > > [    0.000000] Zone ranges:
> >> > > [    0.000000]   DMA      [mem 0x0000000000000000-0x000000002fffff=
ff]
> >> > > [    0.000000]   Normal   empty
> >> > > [    0.000000]   HighMem  [mem 0x0000000030000000-0x000000007fffff=
ff]
> >> > >
> >> > > The kernel can't allocate from the highmem zone -- only userspace =
and
> >> > > zsmalloc can. OOM kills were due to the low memory conditions in t=
he
> >> > > DMA zone where the kernel itself failed to allocate from.
> >> > >
> >> > > Do you know a kernel version that doesn't have OOM kills while run=
ning
> >> > > the same workload? If so, could you send that .config to me? If no=
t,
> >> > > could you try disabling CONFIG_HIGHMEM? (It might not help but I'm=
 out
> >> > > of ideas at the moment.)
> >>
> >> Ok, the bisect I did actually revealed something meaningful:
> >>
> >>  # git bisect good
> >> b8cf32dc6e8c75b712cbf638e0fd210101c22f17 is the first bad commit
> >> commit b8cf32dc6e8c75b712cbf638e0fd210101c22f17
> >> Author: Yosry Ahmed <yosryahmed@google.com>
> >> Date:   Tue Jun 20 19:46:44 2023 +0000
> >>
> >>     mm: zswap: multiple zpools support
> >
> > Thanks for bisecting. Taking a look at the thread, it seems like you
> > have a very limited area of memory to allocate kernel memory from. One
> > possible reason why that commit can cause an issue is because we will
> > have multiple instances of the zsmalloc slab caches 'zspage' and
> > 'zs_handle', which may contribute to fragmentation in slab memory.
> >
> > Do you have /proc/slabinfo from a good and a bad run by any chance?
> >
> > Also, could you check if the attached patch helps? It makes sure that
> > even when we use multiple zsmalloc zpools, we will use a single slab
> > cache of each type.
>
> As for reducing slab fragmentation/footprint, I would also recommend thes=
e
> changes to .config:
>
> CONFIG_SLAB_MERGE_DEFAULT=3Dy - this will unify the separate zpool caches=
 as
> well (but the patch still makes sense), but also many others
> CONFIG_RANDOM_KMALLOC_CACHES=3Dn - no 16 separate copies of kmalloc cache=
s

Yeah, I did send that patch separately, but I think the problem here
is probably fragmentation in the zsmalloc pools themselves, not the
slab caches used by them.

>
> although the slabinfo output doesn't seem to show
> CONFIG_RANDOM_KMALLOC_CACHES in action, weirdly. It was enabled in the
> config attached to the first mail.
>
> Both these changes mean giving up some mitigation against potentai
> lvulnerabilities. But it's not perfect anyway and the memory seems really
> tight here.

I think we may be able to fix the problem here if we address the
zsmalloc fragmentation. In regards to slab caches, the patch proposed
above should avoid the replication without enabling slab cache merging
in general.

Thanks for chiming in!

