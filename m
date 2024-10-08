Return-Path: <linux-kernel+bounces-355239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60476994DA7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82D7D1C229FA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2641DED43;
	Tue,  8 Oct 2024 13:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiGv8s53"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA69D1DE4CC
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 13:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392868; cv=none; b=UpxH8gB+mSoyIoeh6p0dVrsI6qzH/Dv1U3rcwTg6PXLJ0c/vvcgPED1DeaSmUmZd6I55m1BNsHtI5I1Vhty4u0SLitfxBO4dxO3vK9ThqWT2QSEnuR/LrRAotxDtQgw7431yieUWKHWJWMegXULQHSzdeL1WhkfU8O0LL6AHWqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392868; c=relaxed/simple;
	bh=OqQwAG1+Wd+xkoYa9IhSIw7EReBQWix6RR2NIKpOCW8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTOP5A8vTVHo6hgMiBlajzq3nK5LnMoT/ntjFZy/tTxu8cEOiAkS01SVgCl6UZz4wA4i8upOYg939i99ETjvLhcvzEHhelgUH8ChG0C5QZS7SH5VuWOY+E6xJpcVJhmT62gY1u7WcK0R7pOqQsk9ndXal95t1QkKVie5/LJRh20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiGv8s53; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fabc9bc5dfso63884871fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 06:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728392865; x=1728997665; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lT6pGI6GfPJ9eeEOCTDmxxlTllDNaCKPLF8loj3wx54=;
        b=BiGv8s53FU83ASKtfZqYawEFrIzko+gxiaUavOXBJz3hjDLftMkUyvvpkJck7Wdxco
         92T9aqs7VitdLinH9YBZvrP/oZh1RBJkjamHXIYWOCTkggSvX/YpNaG9d3JGdFY5sgcB
         rkNUYaS40K5VK0rduJkRiWsEETb0jy5ZP5cfac+GqrcU5YuFvVxgHl/zCvjILk2Uklu/
         SVF0R7dk+oT61Xo/z5gwV/7svIbxgas7KPsMaHTr3a8QODD7CxXwMucA6khc7zu6FWHt
         dryMLKciUavJimrHALBbMHp97X0d8TtafRINo71xfLL/JNF5s2TnVWWL24q+K4hUlYc6
         IgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728392865; x=1728997665;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lT6pGI6GfPJ9eeEOCTDmxxlTllDNaCKPLF8loj3wx54=;
        b=fBVXgJq9huEyr21nQQVZ7XfAVdbwLCaoL45RHlL2/0WPBwqPRgzxpSzHk8ES5/xQD9
         0JC8P9QY+DswUBQjkbp/T1OSjHdrXoSK86uHH51GPK36TUMmycBBLZR+7PrdAtVo0xpu
         QpIbxH1LDGedzTCaBydnfLVt5DB5qtlh3fSxTeU0Oc6ZkfRd7gDSCR/vzCTg0fNQM5To
         S+Kze5CVbaQQzPLje2gZ/CFoUjI7jlr1O/nhaHSB/LZq6PR7rVV2doyydK6myAThrHNd
         oUyPb1MjY7vV3ky595k6NBPoxmTjGr7/DmrntlS0GSQl9Pau5PUrf/2VK5VPB5Ftn5Ln
         0mKw==
X-Forwarded-Encrypted: i=1; AJvYcCWrM26/rHn4uKDPkYXBTbO8/3i9fVcYRW0GMGj1URyRpEQ2ZC01HbuDFHiEXvBx/HgiVvPEx+tg9jAr9wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLBsPJusCRMfc7ch+UOdi6qQ8l+9NSEkkiNf9MCq2GmAD+Jffu
	KkOOVQqJvJHAjjU6w8bWiqgzlSNs4cu3r96hGlT1Vz7SBUik2yTh
X-Google-Smtp-Source: AGHT+IHXjdLc6CPIc+sHIE8dY47K1Awfe/ujMVWfYqS8CRiZQOqoDa2lKoyh0UTdDsTGGFibXT6CQA==
X-Received: by 2002:a05:651c:2210:b0:2f4:5d9:e8e3 with SMTP id 38308e7fff4ca-2faf3c14096mr85876981fa.7.1728392864507;
        Tue, 08 Oct 2024 06:07:44 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faf9ab2967sm11404821fa.16.2024.10.08.06.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 06:07:43 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date: Tue, 8 Oct 2024 15:07:42 +0200
To: Suren Baghdasaryan <surenb@google.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Ben Greear <greearb@candelatech.com>
Subject: Re: [PATCH lib] lib: alloc_tag_module_unload must wait for pending
 kfree_rcu calls
Message-ID: <ZwUunnGM9UFJ9bdt@pc638.lan>
References: <20241007205236.11847-1-fw@strlen.de>
 <20241007181541.4bbe9b8580f6475023256515@linux-foundation.org>
 <CAJuCfpGZg8Pydy4rGUefOBgwJZ5C6_s3p913oFQJSVV+S9MQoA@mail.gmail.com>
 <ZwTb8tMVVqrpZIv2@pc636>
 <CAJuCfpFKXYEaNJce2bUDR0EJNNk8KV_cUZfRALfmp=ejCW042A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFKXYEaNJce2bUDR0EJNNk8KV_cUZfRALfmp=ejCW042A@mail.gmail.com>

On Tue, Oct 08, 2024 at 04:16:39AM -0700, Suren Baghdasaryan wrote:
> On Tue, Oct 8, 2024 at 12:15 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > On Mon, Oct 07, 2024 at 06:49:32PM -0700, Suren Baghdasaryan wrote:
> > > On Mon, Oct 7, 2024 at 6:15 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > >
> > > > On Mon,  7 Oct 2024 22:52:24 +0200 Florian Westphal <fw@strlen.de> wrote:
> > > >
> > > > > Ben Greear reports following splat:
> > > > >  ------------[ cut here ]------------
> > > > >  net/netfilter/nf_nat_core.c:1114 module nf_nat func:nf_nat_register_fn has 256 allocated at module unload
> > > > >  WARNING: CPU: 1 PID: 10421 at lib/alloc_tag.c:168 alloc_tag_module_unload+0x22b/0x3f0
> > > > >  Modules linked in: nf_nat(-) btrfs ufs qnx4 hfsplus hfs minix vfat msdos fat
> > > > > ...
> > > > >  Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020
> > > > >  RIP: 0010:alloc_tag_module_unload+0x22b/0x3f0
> > > > >   codetag_unload_module+0x19b/0x2a0
> > > > >   ? codetag_load_module+0x80/0x80
> > > > >
> > > > > nf_nat module exit calls kfree_rcu on those addresses, but the free
> > > > > operation is likely still pending by the time alloc_tag checks for leaks.
> > > > >
> > > > > Wait for outstanding kfree_rcu operations to complete before checking
> > > > > resolves this warning.
> > > > >
> > > > > Reproducer:
> > > > > unshare -n iptables-nft -t nat -A PREROUTING -p tcp
> > > > > grep nf_nat /proc/allocinfo # will list 4 allocations
> > > > > rmmod nft_chain_nat
> > > > > rmmod nf_nat                # will WARN.
> > > > >
> > > > > ...
> > > > >
> > > > > --- a/lib/codetag.c
> > > > > +++ b/lib/codetag.c
> > > > > @@ -228,6 +228,8 @@ bool codetag_unload_module(struct module *mod)
> > > > >       if (!mod)
> > > > >               return true;
> > > > >
> > > > > +     kvfree_rcu_barrier();
> > > > > +
> > > > >       mutex_lock(&codetag_lock);
> > > > >       list_for_each_entry(cttype, &codetag_types, link) {
> > > > >               struct codetag_module *found = NULL;
> > > >
> > > > It's always hard to determine why a thing like this is present, so a
> > > > comment is helpful:
> > > >
> > > > --- a/lib/codetag.c~lib-alloc_tag_module_unload-must-wait-for-pending-kfree_rcu-calls-fix
> > > > +++ a/lib/codetag.c
> > > > @@ -228,6 +228,7 @@ bool codetag_unload_module(struct module
> > > >         if (!mod)
> > > >                 return true;
> > > >
> > > > +       /* await any module's kfree_rcu() operations to complete */
> > > >         kvfree_rcu_barrier();
> > > >
> > > >         mutex_lock(&codetag_lock);
> > > > _
> > > >
> > > > But I do wonder whether this is in the correct place.
> > > >
> > > > Waiting for a module's ->exit() function's kfree_rcu()s to complete
> > > > should properly be done by the core module handling code?
> > >
> > > I don't think core module code cares about kfree_rcu()s being complete
> > > before the module is unloaded.
> > > Allocation tagging OTOH cares because it is about to destroy tags
> > > which will be accessed when kfree() actually happens, therefore a
> > > strict ordering is important.
> > >
> > > >
> > > > free_module() does a full-on synchronize_rcu() prior to freeing the
> > > > module memory itself and I think codetag_unload_module() could be
> > > > called after that?
> > >
> > > I think we could move codetag_unload_module() after synchronize_rcu()
> > > inside free_module() but according to the reply in
> > > https://lore.kernel.org/all/20241007112904.GA27104@breakpoint.cc/
> > > synchronize_rcu() does not help. I'm not quite sure why...
> > >
> > It is because, synchronize_rcu() is used for a bit different things,
> > i.e. it is about a GP completion. Offloading objects can span several
> > GPs.
> 
> Ah, thanks! Now that I looked into the patch that recently added
> kvfree_rcu_barrier() I understand that a bit better.
> 
> >
> > > Note that once I'm done upstreaming
> > > https://lore.kernel.org/all/20240902044128.664075-3-surenb@google.com/,
> > > this change will not be needed and I'm planning to remove this call,
> > > however this change is useful for backporting. It should be sent to
> > > stable@vger.kernel.org # v6.10+
> > >
> > The kvfree_rcu_barrier() has been added into v6.12:
> >
> > <snip>
> > urezki@pc638:~/data/raid0/coding/linux.git$ git tag --contains 2b55d6a42d14c8675e38d6d9adca3014fdf01951
> > next-20240912
> > next-20240919
> > next-20240920
> > next-20241002
> > v6.12-rc1
> > urezki@pc638:~/data/raid0/coding/linux.git$
> > <snip>
> >
> > For 6.10+, it implies that the mentioned commit should be backported also.
> 
> I see. I guess for pre-6.12 we would use rcu_barrier() instead of
> kvfree_rcu_barrier()?
> 
For kernels < 6.12, unfortunately not :) If you have a possibility to
switch to reclaim over call_rcu() API, then you can go with rcu_barrier()
which waits for all callbacks to be completed.

Or backport kvfree_rcu_barrier(). It __should__ be easy since there
were not many changes into kvfree_rcu() between 6.10 and 6.12-rcX.

--
Uladzislau Rezki

