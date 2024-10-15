Return-Path: <linux-kernel+bounces-366245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25EA99F29D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFD95B20FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E421EC006;
	Tue, 15 Oct 2024 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qac8OD/a"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B2C13B284
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 16:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729009392; cv=none; b=qARKw9zYV9pjCdXcy2aYtmVqq/oUXIWrdcJQ014Qh4q2E+nYucT6bSQUcSibt6k9lPV3gAClVxTKCxxtnLeeeAflwHIXBbiaY/rqK/CONw7XzLU91kKW9rEFyXGZz0az5rIwATsSkuOOWGO1u0pYecpD4T/fDpVZOsIv4kmHXl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729009392; c=relaxed/simple;
	bh=uefXRuLRMGJk2JENPf/9hb6iCQCpfb0wiT21exX72XY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GcBa/RdfR1nm4dE1FuIGdn8DJbvwRnGT4vIn0vMAahAjBnM3mn9PIzlqSrtXislhiVlHGCSSczkOc2qFsnO95TjlY4ff3Vzj/AkFaozIf9yRwoPZUVgkEDtxHVY2R0Hql2RxDMEYgsJeK7mSjDVcbTq7nvCaxCB9mzOInuyO8aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qac8OD/a; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4601a471aecso783971cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 09:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729009390; x=1729614190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDWOPijrZeJilZ37ZHNgChR3sqw/x2Nu3+ZmwEvNv6E=;
        b=Qac8OD/aWgNMuRL34wugqaAEPCaHg5p9UvYbva55bwMucxndK6rBfluyryeE89s+Dz
         E+zUlScivpl0wD1Kd3QDN5P5WBacjfdW/h/v2n+qhraVqBaaBBDgF2cK8yo4Wq6pNjZM
         RvaccBC5aORFXJLuhc/i8jP0nx/5LcF/Tj6uflBAyjt2Pf5V/QF9iB/qrv206uq9/6h0
         7Hj1ys5U2SWA7TSdtIp9D7UMk763Wwolqa56C3PgkBdfF5SDfoX2GRmJDJwxxZvsTVDP
         NOKOpKdqLsO7mRpNsth3BRN4MjcTTMsyjLwIljgFotf5mQrPqoi99Hrpth8FGzyqmmAf
         7xNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729009390; x=1729614190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDWOPijrZeJilZ37ZHNgChR3sqw/x2Nu3+ZmwEvNv6E=;
        b=MZ2fwcH81htksgHrrYRq00WWtXDXlXe/t7ZWw0YijyzjM7jw4DgYqAIKSR9Fx3pkNd
         DowLYnnKXhtJ80ESpbHQZJcWRBysIp+qcDO+/5j7L/psZzj9+pve2fv1tlhyi8OEa2MJ
         or69HYgP5HOwya3N0CmRfeLyE0K71Iu+/tCFeeKTqBoJm8y9tmh325/3mBlU8OQAhHOo
         7pNstcG52wBPTF6tuiGdW8JPdCPmuV5I95xK4dZZIWUUyqfoeeDEz3Yq0tlbhNNctiUE
         3AP66YoUzmK/t2+YCTfFqnpYX0Q5EdgonxAvdG9CHLadXLsFZnYwijOn1h8G7vmoC/vs
         6Nmg==
X-Forwarded-Encrypted: i=1; AJvYcCXGg1ZIzBRcmCExswblyOJAKCQHMDE5KbM4WGDxw+EzTSqAwwCxBZhLHF81NGnzRt2N/8P0m92nM4lRNaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRvlTbSZhWrMpgaJIjQd+a8JwVcxlt6zMA389BMqe/en5ReZaL
	PLG4gnrdxPkMk0QLbl54qRkqcpbjV0siXaQfLiv1XvTuLlE5LWqgyst2/gKRx0uT83mKd78sAcU
	xPMciJ0nVCFG9BO0C0tWEQOT7CWpmm9LXD3Wy
X-Google-Smtp-Source: AGHT+IEdoinHZ+gJHUrxuTfBN3ObqCd0A0nLR1UEjRZ5azygqzxHrrwrJ66HtWmyVeMZaCbHdz0pHDOuqnFsue4cYlA=
X-Received: by 2002:a05:622a:a28c:b0:45c:9d26:8f6e with SMTP id
 d75a77b69052e-46059c77ccdmr9063491cf.21.1729009389338; Tue, 15 Oct 2024
 09:23:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007205236.11847-1-fw@strlen.de> <20241007181541.4bbe9b8580f6475023256515@linux-foundation.org>
 <CAJuCfpGZg8Pydy4rGUefOBgwJZ5C6_s3p913oFQJSVV+S9MQoA@mail.gmail.com>
 <ZwTb8tMVVqrpZIv2@pc636> <CAJuCfpFKXYEaNJce2bUDR0EJNNk8KV_cUZfRALfmp=ejCW042A@mail.gmail.com>
 <ZwUunnGM9UFJ9bdt@pc638.lan> <CAJuCfpEtZK-w_=WuSPcQAJRyoazNkw-jxGoRyU0Ggg+Ljz2dZA@mail.gmail.com>
 <ZwZApQ5eB-Bx8Bpe@pc636>
In-Reply-To: <ZwZApQ5eB-Bx8Bpe@pc636>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 15 Oct 2024 09:22:55 -0700
Message-ID: <CAJuCfpHR33mZEqtstEVz=x0tgG9ZDbH4Tf0nEmVUnn5GygR+NA@mail.gmail.com>
Subject: Re: [PATCH lib] lib: alloc_tag_module_unload must wait for pending
 kfree_rcu calls
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Florian Westphal <fw@strlen.de>, 
	linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Ben Greear <greearb@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 1:36=E2=80=AFAM Uladzislau Rezki <urezki@gmail.com> =
wrote:
>
> On Tue, Oct 08, 2024 at 11:34:10AM -0700, Suren Baghdasaryan wrote:
> > On Tue, Oct 8, 2024 at 6:07=E2=80=AFAM Uladzislau Rezki <urezki@gmail.c=
om> wrote:
> > >
> > > On Tue, Oct 08, 2024 at 04:16:39AM -0700, Suren Baghdasaryan wrote:
> > > > On Tue, Oct 8, 2024 at 12:15=E2=80=AFAM Uladzislau Rezki <urezki@gm=
ail.com> wrote:
> > > > >
> > > > > On Mon, Oct 07, 2024 at 06:49:32PM -0700, Suren Baghdasaryan wrot=
e:
> > > > > > On Mon, Oct 7, 2024 at 6:15=E2=80=AFPM Andrew Morton <akpm@linu=
x-foundation.org> wrote:
> > > > > > >
> > > > > > > On Mon,  7 Oct 2024 22:52:24 +0200 Florian Westphal <fw@strle=
n.de> wrote:
> > > > > > >
> > > > > > > > Ben Greear reports following splat:
> > > > > > > >  ------------[ cut here ]------------
> > > > > > > >  net/netfilter/nf_nat_core.c:1114 module nf_nat func:nf_nat=
_register_fn has 256 allocated at module unload
> > > > > > > >  WARNING: CPU: 1 PID: 10421 at lib/alloc_tag.c:168 alloc_ta=
g_module_unload+0x22b/0x3f0
> > > > > > > >  Modules linked in: nf_nat(-) btrfs ufs qnx4 hfsplus hfs mi=
nix vfat msdos fat
> > > > > > > > ...
> > > > > > > >  Hardware name: Default string Default string/SKYBAY, BIOS =
5.12 08/04/2020
> > > > > > > >  RIP: 0010:alloc_tag_module_unload+0x22b/0x3f0
> > > > > > > >   codetag_unload_module+0x19b/0x2a0
> > > > > > > >   ? codetag_load_module+0x80/0x80
> > > > > > > >
> > > > > > > > nf_nat module exit calls kfree_rcu on those addresses, but =
the free
> > > > > > > > operation is likely still pending by the time alloc_tag che=
cks for leaks.
> > > > > > > >
> > > > > > > > Wait for outstanding kfree_rcu operations to complete befor=
e checking
> > > > > > > > resolves this warning.
> > > > > > > >
> > > > > > > > Reproducer:
> > > > > > > > unshare -n iptables-nft -t nat -A PREROUTING -p tcp
> > > > > > > > grep nf_nat /proc/allocinfo # will list 4 allocations
> > > > > > > > rmmod nft_chain_nat
> > > > > > > > rmmod nf_nat                # will WARN.
> > > > > > > >
> > > > > > > > ...
> > > > > > > >
> > > > > > > > --- a/lib/codetag.c
> > > > > > > > +++ b/lib/codetag.c
> > > > > > > > @@ -228,6 +228,8 @@ bool codetag_unload_module(struct modul=
e *mod)
> > > > > > > >       if (!mod)
> > > > > > > >               return true;
> > > > > > > >
> > > > > > > > +     kvfree_rcu_barrier();
> > > > > > > > +
> > > > > > > >       mutex_lock(&codetag_lock);
> > > > > > > >       list_for_each_entry(cttype, &codetag_types, link) {
> > > > > > > >               struct codetag_module *found =3D NULL;
> > > > > > >
> > > > > > > It's always hard to determine why a thing like this is presen=
t, so a
> > > > > > > comment is helpful:
> > > > > > >
> > > > > > > --- a/lib/codetag.c~lib-alloc_tag_module_unload-must-wait-for=
-pending-kfree_rcu-calls-fix
> > > > > > > +++ a/lib/codetag.c
> > > > > > > @@ -228,6 +228,7 @@ bool codetag_unload_module(struct module
> > > > > > >         if (!mod)
> > > > > > >                 return true;
> > > > > > >
> > > > > > > +       /* await any module's kfree_rcu() operations to compl=
ete */
> > > > > > >         kvfree_rcu_barrier();
> > > > > > >
> > > > > > >         mutex_lock(&codetag_lock);
> > > > > > > _
> > > > > > >
> > > > > > > But I do wonder whether this is in the correct place.
> > > > > > >
> > > > > > > Waiting for a module's ->exit() function's kfree_rcu()s to co=
mplete
> > > > > > > should properly be done by the core module handling code?
> > > > > >
> > > > > > I don't think core module code cares about kfree_rcu()s being c=
omplete
> > > > > > before the module is unloaded.
> > > > > > Allocation tagging OTOH cares because it is about to destroy ta=
gs
> > > > > > which will be accessed when kfree() actually happens, therefore=
 a
> > > > > > strict ordering is important.
> > > > > >
> > > > > > >
> > > > > > > free_module() does a full-on synchronize_rcu() prior to freei=
ng the
> > > > > > > module memory itself and I think codetag_unload_module() coul=
d be
> > > > > > > called after that?
> > > > > >
> > > > > > I think we could move codetag_unload_module() after synchronize=
_rcu()
> > > > > > inside free_module() but according to the reply in
> > > > > > https://lore.kernel.org/all/20241007112904.GA27104@breakpoint.c=
c/
> > > > > > synchronize_rcu() does not help. I'm not quite sure why...
> > > > > >
> > > > > It is because, synchronize_rcu() is used for a bit different thin=
gs,
> > > > > i.e. it is about a GP completion. Offloading objects can span sev=
eral
> > > > > GPs.
> > > >
> > > > Ah, thanks! Now that I looked into the patch that recently added
> > > > kvfree_rcu_barrier() I understand that a bit better.
> > > >
> > > > >
> > > > > > Note that once I'm done upstreaming
> > > > > > https://lore.kernel.org/all/20240902044128.664075-3-surenb@goog=
le.com/,
> > > > > > this change will not be needed and I'm planning to remove this =
call,
> > > > > > however this change is useful for backporting. It should be sen=
t to
> > > > > > stable@vger.kernel.org # v6.10+
> > > > > >
> > > > > The kvfree_rcu_barrier() has been added into v6.12:
> > > > >
> > > > > <snip>
> > > > > urezki@pc638:~/data/raid0/coding/linux.git$ git tag --contains 2b=
55d6a42d14c8675e38d6d9adca3014fdf01951
> > > > > next-20240912
> > > > > next-20240919
> > > > > next-20240920
> > > > > next-20241002
> > > > > v6.12-rc1
> > > > > urezki@pc638:~/data/raid0/coding/linux.git$
> > > > > <snip>
> > > > >
> > > > > For 6.10+, it implies that the mentioned commit should be backpor=
ted also.
> > > >
> > > > I see. I guess for pre-6.12 we would use rcu_barrier() instead of
> > > > kvfree_rcu_barrier()?
> > > >
> > > For kernels < 6.12, unfortunately not :) If you have a possibility to
> > > switch to reclaim over call_rcu() API, then you can go with rcu_barri=
er()
> > > which waits for all callbacks to be completed.
> >
> > We do not control the call-site inside the module, so this would not
> > be possible.
> >
> > >
> > > Or backport kvfree_rcu_barrier(). It __should__ be easy since there
> > > were not many changes into kvfree_rcu() between 6.10 and 6.12-rcX.
> >
> > That sounds better. I'll take a stab at it. Thanks!

I prepared backports for stable 6.10.y and 6.11.y branches which
contain this patch along with the prerequisite "rcu/kvfree: Add
kvfree_rcu_barrier() API" patch. I think that's the only prerequisite
required. However, since this patch is not yet in Linus' tree, I'll
wait for it to get there before sending backports to stable (per Greg
KH's recommendation). Please let me know if you think it's more
critical and should be posted earlier.
Thanks,
Suren.

> >
> You are welcome!
>
> --
> Uladzislau Rezki
>

