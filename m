Return-Path: <linux-kernel+bounces-355760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3EA9956B4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61FC6B22FA9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A96212D1F;
	Tue,  8 Oct 2024 18:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HPSLVeE4"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE8A1E0DDD
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 18:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412464; cv=none; b=tATtN9ZLu8J62w3rJOxriQmxbjWpDLbPzJ6cbYRI6hb9+zjFbmtuhYBwGhq/6gh25szsmEttjZlTUdm2/Fm+KzRKD+ZHgGPRKhBbUwIa4LZNBDjMU9llH10AZoaH2VKd0O+ZVdCrUYPFvKS7Xcy5UsRUQWuSYlHHxIr1FegADC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412464; c=relaxed/simple;
	bh=GJGwVwtU+/UmvJPKTfVkQenm57XSfCCtss0jb/6Ljak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QuOGwMMzJtueVcW1WTH3LxKqzVVJmFORwAEGe/l6S2gyq282aN2+dZFjFGv7CTjinIjnwghpczNsUHKOYp/OeGQwekRK5x7YDJkWCb2zB6RNMxTXAfx5omu14x5d3JE63o5Bg4oWmsd/Vbs5jlMWixMu4KAaHAulsRBblodovzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HPSLVeE4; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4582fa01090so42051cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 11:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728412461; x=1729017261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBAuPFzdJdc6F932jhMJRA0roa1BThHB3bwvOOSA+8g=;
        b=HPSLVeE4p4f5ev8N+ymJSXvaFxmvYahpZ1Rondc58nyoep6pbKJIRoI2ar3VdQPyZy
         4uM+m/QmjPKMvEPiX2M3BIc9t28PM6P9iJ3osqKjoT9m0+U7OlqqiOJDWZMwIl6pquGQ
         vJCkfRwN3eV/yw91eZw55iEffVxlRgvUnOpU8MpMUIsi2WcfhMQ9mQCFlXbBfMp8dCnB
         tr3ANwSzon/PG4Jt48jl8Kmzbd/s1R+s3CPp7gGsUJKzhpPssj9X09SxAcVPGS/ndXGH
         JiD0AY/F/DKuQA9Zy5JJ6o49DHv9WCJamvP7n7Z7WiNPkIQzhGNlNa4lyI6KTU+/owx8
         IWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728412461; x=1729017261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBAuPFzdJdc6F932jhMJRA0roa1BThHB3bwvOOSA+8g=;
        b=oSIA6Kk341WhxwUea2ZglYkyK3yBFI2eTOnq+7xTO1y9cAHyGRlk9txwLVos46W2yL
         LZzyW0ov5mwwxb1b2y1HuHhDKAZ9my4Xs9WbBKfF0VEaBvX+BdZ+RkrfaJNfPWU1WNw8
         42vZkez13bXvwn2kwJnSh8Or6t1yRxm3r0PIUex3vx3DVV9hw+6PSQ/I6k1+43he0SXc
         397R/PvdFaUFVwTKlbh4OP5FSNWhyBCeLpBEM5UHcqo+su0RvFWjPwg5drxZNmoUh81g
         +/fZVunAFLs7bG6lvByoNYSnHgddSXMXC8vDTdTuNUVIgnJayGtMn1PQ0190YUGbocDp
         FurA==
X-Forwarded-Encrypted: i=1; AJvYcCV1sPttrHeSK34WeKjBLtR5LYjMuFN2qIvxMP7BmMDubd/Pq1IdNEGDT9ZGMZ62EgP0xc/UcmBThQjHNQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpgBVtkS/MEnR3nMvjOtk1FVWvkDpngzezpe4bbf2mTMHkjuLL
	tL0LJ08Uk1hcCktjDHPTi+VMv2csOLRdBPTthLCZJYesB2q9fV8/LGFje8nz+LJH2M2nJp3bG5t
	IDxMzZ3ex+FZaXJtXRccGafhMh9TJtVMjPnxU
X-Google-Smtp-Source: AGHT+IFChIN6TVDzPLQXOQhLwRkigCpz1eZ2gu2UYpAekhKWmT5W64oPBso5H82h41wV0qiCCdquG6G56TjG1b/VeLo=
X-Received: by 2002:ac8:6489:0:b0:45e:fea6:a3b1 with SMTP id
 d75a77b69052e-45f1f71c391mr71371cf.19.1728412460997; Tue, 08 Oct 2024
 11:34:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007205236.11847-1-fw@strlen.de> <20241007181541.4bbe9b8580f6475023256515@linux-foundation.org>
 <CAJuCfpGZg8Pydy4rGUefOBgwJZ5C6_s3p913oFQJSVV+S9MQoA@mail.gmail.com>
 <ZwTb8tMVVqrpZIv2@pc636> <CAJuCfpFKXYEaNJce2bUDR0EJNNk8KV_cUZfRALfmp=ejCW042A@mail.gmail.com>
 <ZwUunnGM9UFJ9bdt@pc638.lan>
In-Reply-To: <ZwUunnGM9UFJ9bdt@pc638.lan>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 8 Oct 2024 11:34:10 -0700
Message-ID: <CAJuCfpEtZK-w_=WuSPcQAJRyoazNkw-jxGoRyU0Ggg+Ljz2dZA@mail.gmail.com>
Subject: Re: [PATCH lib] lib: alloc_tag_module_unload must wait for pending
 kfree_rcu calls
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Florian Westphal <fw@strlen.de>, 
	linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Ben Greear <greearb@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 6:07=E2=80=AFAM Uladzislau Rezki <urezki@gmail.com> =
wrote:
>
> On Tue, Oct 08, 2024 at 04:16:39AM -0700, Suren Baghdasaryan wrote:
> > On Tue, Oct 8, 2024 at 12:15=E2=80=AFAM Uladzislau Rezki <urezki@gmail.=
com> wrote:
> > >
> > > On Mon, Oct 07, 2024 at 06:49:32PM -0700, Suren Baghdasaryan wrote:
> > > > On Mon, Oct 7, 2024 at 6:15=E2=80=AFPM Andrew Morton <akpm@linux-fo=
undation.org> wrote:
> > > > >
> > > > > On Mon,  7 Oct 2024 22:52:24 +0200 Florian Westphal <fw@strlen.de=
> wrote:
> > > > >
> > > > > > Ben Greear reports following splat:
> > > > > >  ------------[ cut here ]------------
> > > > > >  net/netfilter/nf_nat_core.c:1114 module nf_nat func:nf_nat_reg=
ister_fn has 256 allocated at module unload
> > > > > >  WARNING: CPU: 1 PID: 10421 at lib/alloc_tag.c:168 alloc_tag_mo=
dule_unload+0x22b/0x3f0
> > > > > >  Modules linked in: nf_nat(-) btrfs ufs qnx4 hfsplus hfs minix =
vfat msdos fat
> > > > > > ...
> > > > > >  Hardware name: Default string Default string/SKYBAY, BIOS 5.12=
 08/04/2020
> > > > > >  RIP: 0010:alloc_tag_module_unload+0x22b/0x3f0
> > > > > >   codetag_unload_module+0x19b/0x2a0
> > > > > >   ? codetag_load_module+0x80/0x80
> > > > > >
> > > > > > nf_nat module exit calls kfree_rcu on those addresses, but the =
free
> > > > > > operation is likely still pending by the time alloc_tag checks =
for leaks.
> > > > > >
> > > > > > Wait for outstanding kfree_rcu operations to complete before ch=
ecking
> > > > > > resolves this warning.
> > > > > >
> > > > > > Reproducer:
> > > > > > unshare -n iptables-nft -t nat -A PREROUTING -p tcp
> > > > > > grep nf_nat /proc/allocinfo # will list 4 allocations
> > > > > > rmmod nft_chain_nat
> > > > > > rmmod nf_nat                # will WARN.
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > --- a/lib/codetag.c
> > > > > > +++ b/lib/codetag.c
> > > > > > @@ -228,6 +228,8 @@ bool codetag_unload_module(struct module *m=
od)
> > > > > >       if (!mod)
> > > > > >               return true;
> > > > > >
> > > > > > +     kvfree_rcu_barrier();
> > > > > > +
> > > > > >       mutex_lock(&codetag_lock);
> > > > > >       list_for_each_entry(cttype, &codetag_types, link) {
> > > > > >               struct codetag_module *found =3D NULL;
> > > > >
> > > > > It's always hard to determine why a thing like this is present, s=
o a
> > > > > comment is helpful:
> > > > >
> > > > > --- a/lib/codetag.c~lib-alloc_tag_module_unload-must-wait-for-pen=
ding-kfree_rcu-calls-fix
> > > > > +++ a/lib/codetag.c
> > > > > @@ -228,6 +228,7 @@ bool codetag_unload_module(struct module
> > > > >         if (!mod)
> > > > >                 return true;
> > > > >
> > > > > +       /* await any module's kfree_rcu() operations to complete =
*/
> > > > >         kvfree_rcu_barrier();
> > > > >
> > > > >         mutex_lock(&codetag_lock);
> > > > > _
> > > > >
> > > > > But I do wonder whether this is in the correct place.
> > > > >
> > > > > Waiting for a module's ->exit() function's kfree_rcu()s to comple=
te
> > > > > should properly be done by the core module handling code?
> > > >
> > > > I don't think core module code cares about kfree_rcu()s being compl=
ete
> > > > before the module is unloaded.
> > > > Allocation tagging OTOH cares because it is about to destroy tags
> > > > which will be accessed when kfree() actually happens, therefore a
> > > > strict ordering is important.
> > > >
> > > > >
> > > > > free_module() does a full-on synchronize_rcu() prior to freeing t=
he
> > > > > module memory itself and I think codetag_unload_module() could be
> > > > > called after that?
> > > >
> > > > I think we could move codetag_unload_module() after synchronize_rcu=
()
> > > > inside free_module() but according to the reply in
> > > > https://lore.kernel.org/all/20241007112904.GA27104@breakpoint.cc/
> > > > synchronize_rcu() does not help. I'm not quite sure why...
> > > >
> > > It is because, synchronize_rcu() is used for a bit different things,
> > > i.e. it is about a GP completion. Offloading objects can span several
> > > GPs.
> >
> > Ah, thanks! Now that I looked into the patch that recently added
> > kvfree_rcu_barrier() I understand that a bit better.
> >
> > >
> > > > Note that once I'm done upstreaming
> > > > https://lore.kernel.org/all/20240902044128.664075-3-surenb@google.c=
om/,
> > > > this change will not be needed and I'm planning to remove this call=
,
> > > > however this change is useful for backporting. It should be sent to
> > > > stable@vger.kernel.org # v6.10+
> > > >
> > > The kvfree_rcu_barrier() has been added into v6.12:
> > >
> > > <snip>
> > > urezki@pc638:~/data/raid0/coding/linux.git$ git tag --contains 2b55d6=
a42d14c8675e38d6d9adca3014fdf01951
> > > next-20240912
> > > next-20240919
> > > next-20240920
> > > next-20241002
> > > v6.12-rc1
> > > urezki@pc638:~/data/raid0/coding/linux.git$
> > > <snip>
> > >
> > > For 6.10+, it implies that the mentioned commit should be backported =
also.
> >
> > I see. I guess for pre-6.12 we would use rcu_barrier() instead of
> > kvfree_rcu_barrier()?
> >
> For kernels < 6.12, unfortunately not :) If you have a possibility to
> switch to reclaim over call_rcu() API, then you can go with rcu_barrier()
> which waits for all callbacks to be completed.

We do not control the call-site inside the module, so this would not
be possible.

>
> Or backport kvfree_rcu_barrier(). It __should__ be easy since there
> were not many changes into kvfree_rcu() between 6.10 and 6.12-rcX.

That sounds better. I'll take a stab at it. Thanks!

>
> --
> Uladzislau Rezki

