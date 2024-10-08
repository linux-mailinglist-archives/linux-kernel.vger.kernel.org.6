Return-Path: <linux-kernel+bounces-355041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 219B599465E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4246A1C234E9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79B21CEE90;
	Tue,  8 Oct 2024 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3/t/fAVH"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8082F18CC13
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 11:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728386220; cv=none; b=M0kqbUnTL0/Je62eVjjSFOSyweZ7nnyBOUemDBSvPrZ+eshphiuOBbRooIqfyYp54uGzT5I/AkRnigGu50AzF+Jp2Vcppyo8m2bC0Qk0BtOphRMbwfkAR1TSTr8ovNSOtyLuQ1NkhOjdOUT3a9UZ0O0OIKvJJLPqFxvgmPEDJxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728386220; c=relaxed/simple;
	bh=2ug4GQTLq46laZ4FLFYMnnf+0UJr2qh2sYtC965i3xE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C0iyWU4/RdKgSUFnJB9Gaha7SX1QBCD+urb0f9fD/3n11c2nzGjAcadWBFD5J3R2Ba5WnLoiFcHeS8WS9a+qmflduVZ6OoYIwRchGE8c1ymQnCPG+y84Q+y4jQy0EM0K3O5qS32lyo+SFbTLG3CK85zZuZoXhOI1WyWXBM715bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3/t/fAVH; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a0cb892c6aso273495ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 04:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728386217; x=1728991017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfduNa9S+5CbmjKt4d003RrStTLV4Mm/ebDfA/iEhTQ=;
        b=3/t/fAVHd+QpmRyPJ7AwtkTon/IqVbdjgaNxp7gb6g9+j66i6DQyYr3+tupjK9M2u8
         0sl018CzjFS7yrNVRC5F30GwwjOE/aAJ710JSUhHx4QUqdk60AB1wJwTeS+Vb58YSqhW
         NNVVbMlBuCXio5FO1Po93KfyAfs+nAGU9hXm7vXgtPXBzGGWIlXkCCYJIRmqO8uKOiBE
         FPlYB+fWvh3wag6Wqp4wJMOobbFag+iV6QSrncYh+kn0VFkVO5BkOJb2JAO3LhHCyxbe
         E9AtvmNaa/zpCdVLQsR5JtqRufudz6nn24Y3DK2Mbp1wK8fBNvjhMFRr2TiMiHEqiJcM
         FeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728386217; x=1728991017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfduNa9S+5CbmjKt4d003RrStTLV4Mm/ebDfA/iEhTQ=;
        b=RM8ew9FMCRIpJB22nyq1Q+RPySIfsBPMxx2N278SozTFd6TXhHM3dSCuNL0+z6mPns
         3VnxjrdsP6y0UldvT12O3n1+rFXPHMp6hW7nj5YGkcMFGC7CwzPwY8/BUHK83gSCHukP
         peor9XEBjXJRuOsp/ZhlvnwbrUemugWss2jKkst/qCxKvLUBh9BrVQ9t3GkHaQ/k8HfI
         iT4bdeV/mv4szNlvmnu0yFPFRcVV5anV5mB51zDmRh2H81tpAGr52KCTr4WXo6apVFY0
         Qiy9JpDIlwAisKsROokBvEiGuoYsQQpqczzB0kV7d4bm7b9M3W8c2DnPaUyV4SRKVBNT
         RycA==
X-Forwarded-Encrypted: i=1; AJvYcCWhf5J+hZ4r7u96qKN8jKCzzTE7kKOs+F29Mkqf8taYVNqAlAdCyiAO7O9P6BkMT3eQyDp00H0R2zFaGs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMGmM8b2mdnjoYuXjsfdJUcNwjhN6LOjI97nQrPCCi9IcjNbMs
	folEkgKntuf7kSnslio0pgggznFJuMK2agttr/mCf6pBA40qYjAORvqWhBMHW3MK4s0PnbwMIS4
	Sa4rLK794PQXfjlIjexMD2etuDcrtOSuFmCMm
X-Google-Smtp-Source: AGHT+IGy/rBOOYCIkTWtnFOjjrUEliy6p4WfFm8CYdLi4PiT7fvNmIDA0DNayplkeyTFUCK36E0b2jOdZXOZFF8FzLM=
X-Received: by 2002:a05:6e02:1a86:b0:3a0:9e83:21ea with SMTP id
 e9e14a558f8ab-3a38ea105f7mr3031155ab.17.1728386212685; Tue, 08 Oct 2024
 04:16:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007205236.11847-1-fw@strlen.de> <20241007181541.4bbe9b8580f6475023256515@linux-foundation.org>
 <CAJuCfpGZg8Pydy4rGUefOBgwJZ5C6_s3p913oFQJSVV+S9MQoA@mail.gmail.com> <ZwTb8tMVVqrpZIv2@pc636>
In-Reply-To: <ZwTb8tMVVqrpZIv2@pc636>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 8 Oct 2024 04:16:39 -0700
Message-ID: <CAJuCfpFKXYEaNJce2bUDR0EJNNk8KV_cUZfRALfmp=ejCW042A@mail.gmail.com>
Subject: Re: [PATCH lib] lib: alloc_tag_module_unload must wait for pending
 kfree_rcu calls
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Florian Westphal <fw@strlen.de>, 
	linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Ben Greear <greearb@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 12:15=E2=80=AFAM Uladzislau Rezki <urezki@gmail.com>=
 wrote:
>
> On Mon, Oct 07, 2024 at 06:49:32PM -0700, Suren Baghdasaryan wrote:
> > On Mon, Oct 7, 2024 at 6:15=E2=80=AFPM Andrew Morton <akpm@linux-founda=
tion.org> wrote:
> > >
> > > On Mon,  7 Oct 2024 22:52:24 +0200 Florian Westphal <fw@strlen.de> wr=
ote:
> > >
> > > > Ben Greear reports following splat:
> > > >  ------------[ cut here ]------------
> > > >  net/netfilter/nf_nat_core.c:1114 module nf_nat func:nf_nat_registe=
r_fn has 256 allocated at module unload
> > > >  WARNING: CPU: 1 PID: 10421 at lib/alloc_tag.c:168 alloc_tag_module=
_unload+0x22b/0x3f0
> > > >  Modules linked in: nf_nat(-) btrfs ufs qnx4 hfsplus hfs minix vfat=
 msdos fat
> > > > ...
> > > >  Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/=
04/2020
> > > >  RIP: 0010:alloc_tag_module_unload+0x22b/0x3f0
> > > >   codetag_unload_module+0x19b/0x2a0
> > > >   ? codetag_load_module+0x80/0x80
> > > >
> > > > nf_nat module exit calls kfree_rcu on those addresses, but the free
> > > > operation is likely still pending by the time alloc_tag checks for =
leaks.
> > > >
> > > > Wait for outstanding kfree_rcu operations to complete before checki=
ng
> > > > resolves this warning.
> > > >
> > > > Reproducer:
> > > > unshare -n iptables-nft -t nat -A PREROUTING -p tcp
> > > > grep nf_nat /proc/allocinfo # will list 4 allocations
> > > > rmmod nft_chain_nat
> > > > rmmod nf_nat                # will WARN.
> > > >
> > > > ...
> > > >
> > > > --- a/lib/codetag.c
> > > > +++ b/lib/codetag.c
> > > > @@ -228,6 +228,8 @@ bool codetag_unload_module(struct module *mod)
> > > >       if (!mod)
> > > >               return true;
> > > >
> > > > +     kvfree_rcu_barrier();
> > > > +
> > > >       mutex_lock(&codetag_lock);
> > > >       list_for_each_entry(cttype, &codetag_types, link) {
> > > >               struct codetag_module *found =3D NULL;
> > >
> > > It's always hard to determine why a thing like this is present, so a
> > > comment is helpful:
> > >
> > > --- a/lib/codetag.c~lib-alloc_tag_module_unload-must-wait-for-pending=
-kfree_rcu-calls-fix
> > > +++ a/lib/codetag.c
> > > @@ -228,6 +228,7 @@ bool codetag_unload_module(struct module
> > >         if (!mod)
> > >                 return true;
> > >
> > > +       /* await any module's kfree_rcu() operations to complete */
> > >         kvfree_rcu_barrier();
> > >
> > >         mutex_lock(&codetag_lock);
> > > _
> > >
> > > But I do wonder whether this is in the correct place.
> > >
> > > Waiting for a module's ->exit() function's kfree_rcu()s to complete
> > > should properly be done by the core module handling code?
> >
> > I don't think core module code cares about kfree_rcu()s being complete
> > before the module is unloaded.
> > Allocation tagging OTOH cares because it is about to destroy tags
> > which will be accessed when kfree() actually happens, therefore a
> > strict ordering is important.
> >
> > >
> > > free_module() does a full-on synchronize_rcu() prior to freeing the
> > > module memory itself and I think codetag_unload_module() could be
> > > called after that?
> >
> > I think we could move codetag_unload_module() after synchronize_rcu()
> > inside free_module() but according to the reply in
> > https://lore.kernel.org/all/20241007112904.GA27104@breakpoint.cc/
> > synchronize_rcu() does not help. I'm not quite sure why...
> >
> It is because, synchronize_rcu() is used for a bit different things,
> i.e. it is about a GP completion. Offloading objects can span several
> GPs.

Ah, thanks! Now that I looked into the patch that recently added
kvfree_rcu_barrier() I understand that a bit better.

>
> > Note that once I'm done upstreaming
> > https://lore.kernel.org/all/20240902044128.664075-3-surenb@google.com/,
> > this change will not be needed and I'm planning to remove this call,
> > however this change is useful for backporting. It should be sent to
> > stable@vger.kernel.org # v6.10+
> >
> The kvfree_rcu_barrier() has been added into v6.12:
>
> <snip>
> urezki@pc638:~/data/raid0/coding/linux.git$ git tag --contains 2b55d6a42d=
14c8675e38d6d9adca3014fdf01951
> next-20240912
> next-20240919
> next-20240920
> next-20241002
> v6.12-rc1
> urezki@pc638:~/data/raid0/coding/linux.git$
> <snip>
>
> For 6.10+, it implies that the mentioned commit should be backported also=
.

I see. I guess for pre-6.12 we would use rcu_barrier() instead of
kvfree_rcu_barrier()?

>
> --
> Uladzislau Rezki

