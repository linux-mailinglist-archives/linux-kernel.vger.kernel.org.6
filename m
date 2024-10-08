Return-Path: <linux-kernel+bounces-354637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 867DE99407E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A38284574
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE2A1FEFBE;
	Tue,  8 Oct 2024 07:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIc22Rbq"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91BF1DE4C4
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 07:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728371705; cv=none; b=QL8xJRVstNs06dmr55A6iNCkhMqIRwBUICtW3QCly/pXoqTHFzpwlKwRgTeoM9DkTyQoTvdZ9w/ERT8iS1eo6QD1dULwXXWnL3zbeTQZugGM4eUGvG36f+AaucEuG8aECwX6cbhdQgyfO5PKTVYqSFN77QrCXWEF+dOwdOFp5jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728371705; c=relaxed/simple;
	bh=MlWkskWq7M08x2HfnAtappkywVjbSX/cUwFAB3SUyoQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHYwy8YktqXSfhRVaQTG5UKK6J5W34TwsAvqJjHfjt/yU7QGoURauxiO7KheCJgTXdCfTJzBc4S87PauHr3FpAppNL1NHeSwT5huZeBtG4BG8V0gR8MESNTIyt6g0QNTTl3UOpmzczbWmk2MyOSiyJW8NxUJ+p8DwRQ1CpBIq8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIc22Rbq; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fad100dd9fso72616201fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 00:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728371702; x=1728976502; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vf12fRPMKFIWt6cIL+waKLbwMQoVemuomhPLrxh5ZGk=;
        b=iIc22RbqRCzLHq6CfBwROsSk4IgWck69/kKMARD+tifgQFHPE/SWGgq81YmsP5QtSs
         yD0P8DHEP9HeM4liDZ3+CBVbvgUy8V9e0jE1JRjqZKpwIzb8Xsg5tKPJPyzSl4rYdUq0
         inquUvcKoR8jUaphWMHrGgxByPbMXSWmysBaVKETEqs/dPt+9EfallYOR5KOy+l5Gaex
         FNLpeHESfc1YqyPIbf0YgbhS8qWnEtdq1QTcLrF0h+ZyZ+f5HQmcIQHyNtlEx7PlATYE
         tl31aXKiBnFjCqDemZBeFzvoexcplAfvPW0JEYc1C11B7ClQsiQoinJFdbktwyCK3pxs
         vffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728371702; x=1728976502;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vf12fRPMKFIWt6cIL+waKLbwMQoVemuomhPLrxh5ZGk=;
        b=rL8+c3nXKW60SenPnjVTgWT33O6TQ9S+9YhPebCb14yTcTFUXrrSOas+j9mrXHHQWI
         1TOChzQ+VNmx1OU/XaS33Yql3+UzzmOHHXhzorlNxGzIWbS18arfIovChs1x/Ab3BfZ8
         CrRZPdnlfvIqjznBy66RD0xUFh1fz4ekms2gyy+7hIEhYEYgzs8wHY+Sd7iKKEzp5YYe
         nRj0loB3EzXTd82teGnAXTjogN8HRZYUP/0PvmbrA0Fh//JzQgnKQtFEujUwrU+OgQ9j
         RfLwdVT0YFYwRBkg7RVMJvumEFM8ao8jo012hLusD5+YzuX/kngbjWUEpCpIxz6Z710m
         ZNhg==
X-Forwarded-Encrypted: i=1; AJvYcCVVsFyDTlyel+fRgT6YwZLe+umUkhvNET5P1bxnak9iAq1Gr79qsqHUzKUzHLimXDmb34VmXmd5QU+RVQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB7uhIwHQYDswUjhZeHERaChtMpIYu1S1mSDslAZYshGg5NKQY
	XemEIamZ6aniN+VipmSri9DUhV+Z5or3gSIbTIte9hrOSnQbeU6g
X-Google-Smtp-Source: AGHT+IFFf0kHTEafVzpnJVLLvBBpcPeb3i6eGAm4OVoAfQZJX9JISJA6ZOmBo1PbZo0wR6BSn4gTEA==
X-Received: by 2002:a05:6512:1256:b0:536:741a:6bc5 with SMTP id 2adb3069b0e04-539ab84e0ebmr7859304e87.12.1728371701405;
        Tue, 08 Oct 2024 00:15:01 -0700 (PDT)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff2336fsm1107601e87.203.2024.10.08.00.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 00:15:00 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 8 Oct 2024 09:14:58 +0200
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Ben Greear <greearb@candelatech.com>
Subject: Re: [PATCH lib] lib: alloc_tag_module_unload must wait for pending
 kfree_rcu calls
Message-ID: <ZwTb8tMVVqrpZIv2@pc636>
References: <20241007205236.11847-1-fw@strlen.de>
 <20241007181541.4bbe9b8580f6475023256515@linux-foundation.org>
 <CAJuCfpGZg8Pydy4rGUefOBgwJZ5C6_s3p913oFQJSVV+S9MQoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGZg8Pydy4rGUefOBgwJZ5C6_s3p913oFQJSVV+S9MQoA@mail.gmail.com>

On Mon, Oct 07, 2024 at 06:49:32PM -0700, Suren Baghdasaryan wrote:
> On Mon, Oct 7, 2024 at 6:15 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Mon,  7 Oct 2024 22:52:24 +0200 Florian Westphal <fw@strlen.de> wrote:
> >
> > > Ben Greear reports following splat:
> > >  ------------[ cut here ]------------
> > >  net/netfilter/nf_nat_core.c:1114 module nf_nat func:nf_nat_register_fn has 256 allocated at module unload
> > >  WARNING: CPU: 1 PID: 10421 at lib/alloc_tag.c:168 alloc_tag_module_unload+0x22b/0x3f0
> > >  Modules linked in: nf_nat(-) btrfs ufs qnx4 hfsplus hfs minix vfat msdos fat
> > > ...
> > >  Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020
> > >  RIP: 0010:alloc_tag_module_unload+0x22b/0x3f0
> > >   codetag_unload_module+0x19b/0x2a0
> > >   ? codetag_load_module+0x80/0x80
> > >
> > > nf_nat module exit calls kfree_rcu on those addresses, but the free
> > > operation is likely still pending by the time alloc_tag checks for leaks.
> > >
> > > Wait for outstanding kfree_rcu operations to complete before checking
> > > resolves this warning.
> > >
> > > Reproducer:
> > > unshare -n iptables-nft -t nat -A PREROUTING -p tcp
> > > grep nf_nat /proc/allocinfo # will list 4 allocations
> > > rmmod nft_chain_nat
> > > rmmod nf_nat                # will WARN.
> > >
> > > ...
> > >
> > > --- a/lib/codetag.c
> > > +++ b/lib/codetag.c
> > > @@ -228,6 +228,8 @@ bool codetag_unload_module(struct module *mod)
> > >       if (!mod)
> > >               return true;
> > >
> > > +     kvfree_rcu_barrier();
> > > +
> > >       mutex_lock(&codetag_lock);
> > >       list_for_each_entry(cttype, &codetag_types, link) {
> > >               struct codetag_module *found = NULL;
> >
> > It's always hard to determine why a thing like this is present, so a
> > comment is helpful:
> >
> > --- a/lib/codetag.c~lib-alloc_tag_module_unload-must-wait-for-pending-kfree_rcu-calls-fix
> > +++ a/lib/codetag.c
> > @@ -228,6 +228,7 @@ bool codetag_unload_module(struct module
> >         if (!mod)
> >                 return true;
> >
> > +       /* await any module's kfree_rcu() operations to complete */
> >         kvfree_rcu_barrier();
> >
> >         mutex_lock(&codetag_lock);
> > _
> >
> > But I do wonder whether this is in the correct place.
> >
> > Waiting for a module's ->exit() function's kfree_rcu()s to complete
> > should properly be done by the core module handling code?
> 
> I don't think core module code cares about kfree_rcu()s being complete
> before the module is unloaded.
> Allocation tagging OTOH cares because it is about to destroy tags
> which will be accessed when kfree() actually happens, therefore a
> strict ordering is important.
> 
> >
> > free_module() does a full-on synchronize_rcu() prior to freeing the
> > module memory itself and I think codetag_unload_module() could be
> > called after that?
> 
> I think we could move codetag_unload_module() after synchronize_rcu()
> inside free_module() but according to the reply in
> https://lore.kernel.org/all/20241007112904.GA27104@breakpoint.cc/
> synchronize_rcu() does not help. I'm not quite sure why...
>
It is because, synchronize_rcu() is used for a bit different things,
i.e. it is about a GP completion. Offloading objects can span several
GPs.

> Note that once I'm done upstreaming
> https://lore.kernel.org/all/20240902044128.664075-3-surenb@google.com/,
> this change will not be needed and I'm planning to remove this call,
> however this change is useful for backporting. It should be sent to
> stable@vger.kernel.org # v6.10+
>
The kvfree_rcu_barrier() has been added into v6.12:

<snip>
urezki@pc638:~/data/raid0/coding/linux.git$ git tag --contains 2b55d6a42d14c8675e38d6d9adca3014fdf01951
next-20240912
next-20240919
next-20240920
next-20241002
v6.12-rc1
urezki@pc638:~/data/raid0/coding/linux.git$
<snip>

For 6.10+, it implies that the mentioned commit should be backported also.

--
Uladzislau Rezki

