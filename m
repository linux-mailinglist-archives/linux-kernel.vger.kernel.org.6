Return-Path: <linux-kernel+bounces-366361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D6799F452
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DDAAB22B40
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22291FAEE2;
	Tue, 15 Oct 2024 17:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mrys1Lpo"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9431F667A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729014263; cv=none; b=WNy+Q5GV7OEcLooC/jxGAOj+ZGm37kmB1dE6RV7jd7l6zRha/zK6dy2Rax6yoblyJ+mN1rGdlO4UIbWYwi3Wv9UnDkGvuLdYFuMqYfBaoqwF4hmRQVuMBoArIYh5LvxTtFg6028pk1WUh8Sm47rgCyr43lsmmtrVfVfi23c3Olg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729014263; c=relaxed/simple;
	bh=xUKXSRlD18XA9mNb7FmDwlo6fes0gPhIKZ1+QttloHA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQJagFWk87YBlT/wmrb3ptpEEZJvfGspPHoS+la0k+G7pM1N8mynZP85J9N8QDjC+KVNm9L2s6TTm2w/dzLTrAUi7VNHh7Mj/ZQMxDG41hYT5xCMXOnLkhFWEHlOd8a8uqC9i/N22oUxxWsZdqBUeWjCufbho0AA6yLaAjPJ4b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mrys1Lpo; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539ee1acb86so3368241e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729014259; x=1729619059; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hnlOYyq78jtdj0I7HrGxmDY7wkI1TSgFE0Ag3E5VwQs=;
        b=Mrys1LpocyLFq66h8bwUqNoMyTN5o8s97VGx0ai70cO/0CoAiLMWium1tckQoJkNem
         MfhXmtCdZcC2P2R8bdNOQcPOD0wXxRQLIOGeUyhFP693q+TudFheGNr+LhHLVRQLW6Dj
         jsWetQSKw79qIE8lXwwsWaI/jubEOeZ3q3AAgaifmdjSqYyA9JHQnZa61uh4dJ5xw7TZ
         BJe1/TKVeRqsB+jHMTXIHKtZkuNRAI8KS7m+k4bFCIAI+yOe1qtfJdEiH4DUiQkHJjpB
         1Oz8J+fndvAIAlnVYBJqNuN+DwXWnGw6ltGMf9hvhhjeT2sFX2l9T13hHYGPFoQ85fh6
         Jl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729014259; x=1729619059;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hnlOYyq78jtdj0I7HrGxmDY7wkI1TSgFE0Ag3E5VwQs=;
        b=TgLjpWcszRV2nPlpwIJY0jjYrc34tVzRun29Ou4NQjycvB9l3csaXkM47snfOEI9ih
         kmSTN4bB9HRVH15iyR5Sa7yR2grxzedkdAU6abBu4BGvzqgtubNtRLf5rqdOdGWukuPy
         eLjn4L3We3gmuIlcOwz4f+XnVDj9im6s7xm6YvhReGh5yFJzJFbVpI9Tmy7gxevT3p7l
         cdVY2gh868DlErb2PazgyhcF3a1MstM1uZpOqHULtbLXxN6Lb/Lb5ayKD/AN1uVmoHGx
         2JRCR8GDBwljGQVa/kBcpRiD2ciPNp7qG2jmNfzIQXkq3ZZjy9gHDQvq4mtpDcyxrQqr
         pexg==
X-Forwarded-Encrypted: i=1; AJvYcCVe6I2BEz6RV9l9NUgkUOH+LWx/qqSV6FZZORAnvDOFv8+mvxzXGOHZw54ash/a2w3OeTmG50kwW9nMJvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIUp/nibm0JJ4stkT3NgRt7DA1Tofy/d81i04jtfl/Or350mhe
	QAO3tVMIz7I48Ci/VRavP/h4D3Aa2J/Hp24ysqSnwL6vOl4duO6XMiiMqA==
X-Google-Smtp-Source: AGHT+IHP8tekOYqLGW5BtdJaWSZuebJ+tS/VS6wGIcug89i5AD5MTYrYCOssET86nmt9m1GVDUNqyQ==
X-Received: by 2002:a05:6512:b9a:b0:539:e282:ce9e with SMTP id 2adb3069b0e04-539e5762573mr6047997e87.60.1729014258866;
        Tue, 15 Oct 2024 10:44:18 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539ffff379bsm225069e87.143.2024.10.15.10.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 10:44:18 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date: Tue, 15 Oct 2024 19:44:16 +0200
To: Suren Baghdasaryan <surenb@google.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Ben Greear <greearb@candelatech.com>
Subject: Re: [PATCH lib] lib: alloc_tag_module_unload must wait for pending
 kfree_rcu calls
Message-ID: <Zw6p8DgzdLtoDzVL@pc638.lan>
References: <20241007205236.11847-1-fw@strlen.de>
 <20241007181541.4bbe9b8580f6475023256515@linux-foundation.org>
 <CAJuCfpGZg8Pydy4rGUefOBgwJZ5C6_s3p913oFQJSVV+S9MQoA@mail.gmail.com>
 <ZwTb8tMVVqrpZIv2@pc636>
 <CAJuCfpFKXYEaNJce2bUDR0EJNNk8KV_cUZfRALfmp=ejCW042A@mail.gmail.com>
 <ZwUunnGM9UFJ9bdt@pc638.lan>
 <CAJuCfpEtZK-w_=WuSPcQAJRyoazNkw-jxGoRyU0Ggg+Ljz2dZA@mail.gmail.com>
 <ZwZApQ5eB-Bx8Bpe@pc636>
 <CAJuCfpHR33mZEqtstEVz=x0tgG9ZDbH4Tf0nEmVUnn5GygR+NA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHR33mZEqtstEVz=x0tgG9ZDbH4Tf0nEmVUnn5GygR+NA@mail.gmail.com>

On Tue, Oct 15, 2024 at 09:22:55AM -0700, Suren Baghdasaryan wrote:
> On Wed, Oct 9, 2024 at 1:36 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > On Tue, Oct 08, 2024 at 11:34:10AM -0700, Suren Baghdasaryan wrote:
> > > On Tue, Oct 8, 2024 at 6:07 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > >
> > > > On Tue, Oct 08, 2024 at 04:16:39AM -0700, Suren Baghdasaryan wrote:
> > > > > On Tue, Oct 8, 2024 at 12:15 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, Oct 07, 2024 at 06:49:32PM -0700, Suren Baghdasaryan wrote:
> > > > > > > On Mon, Oct 7, 2024 at 6:15 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > > > > > >
> > > > > > > > On Mon,  7 Oct 2024 22:52:24 +0200 Florian Westphal <fw@strlen.de> wrote:
> > > > > > > >
> > > > > > > > > Ben Greear reports following splat:
> > > > > > > > >  ------------[ cut here ]------------
> > > > > > > > >  net/netfilter/nf_nat_core.c:1114 module nf_nat func:nf_nat_register_fn has 256 allocated at module unload
> > > > > > > > >  WARNING: CPU: 1 PID: 10421 at lib/alloc_tag.c:168 alloc_tag_module_unload+0x22b/0x3f0
> > > > > > > > >  Modules linked in: nf_nat(-) btrfs ufs qnx4 hfsplus hfs minix vfat msdos fat
> > > > > > > > > ...
> > > > > > > > >  Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020
> > > > > > > > >  RIP: 0010:alloc_tag_module_unload+0x22b/0x3f0
> > > > > > > > >   codetag_unload_module+0x19b/0x2a0
> > > > > > > > >   ? codetag_load_module+0x80/0x80
> > > > > > > > >
> > > > > > > > > nf_nat module exit calls kfree_rcu on those addresses, but the free
> > > > > > > > > operation is likely still pending by the time alloc_tag checks for leaks.
> > > > > > > > >
> > > > > > > > > Wait for outstanding kfree_rcu operations to complete before checking
> > > > > > > > > resolves this warning.
> > > > > > > > >
> > > > > > > > > Reproducer:
> > > > > > > > > unshare -n iptables-nft -t nat -A PREROUTING -p tcp
> > > > > > > > > grep nf_nat /proc/allocinfo # will list 4 allocations
> > > > > > > > > rmmod nft_chain_nat
> > > > > > > > > rmmod nf_nat                # will WARN.
> > > > > > > > >
> > > > > > > > > ...
> > > > > > > > >
> > > > > > > > > --- a/lib/codetag.c
> > > > > > > > > +++ b/lib/codetag.c
> > > > > > > > > @@ -228,6 +228,8 @@ bool codetag_unload_module(struct module *mod)
> > > > > > > > >       if (!mod)
> > > > > > > > >               return true;
> > > > > > > > >
> > > > > > > > > +     kvfree_rcu_barrier();
> > > > > > > > > +
> > > > > > > > >       mutex_lock(&codetag_lock);
> > > > > > > > >       list_for_each_entry(cttype, &codetag_types, link) {
> > > > > > > > >               struct codetag_module *found = NULL;
> > > > > > > >
> > > > > > > > It's always hard to determine why a thing like this is present, so a
> > > > > > > > comment is helpful:
> > > > > > > >
> > > > > > > > --- a/lib/codetag.c~lib-alloc_tag_module_unload-must-wait-for-pending-kfree_rcu-calls-fix
> > > > > > > > +++ a/lib/codetag.c
> > > > > > > > @@ -228,6 +228,7 @@ bool codetag_unload_module(struct module
> > > > > > > >         if (!mod)
> > > > > > > >                 return true;
> > > > > > > >
> > > > > > > > +       /* await any module's kfree_rcu() operations to complete */
> > > > > > > >         kvfree_rcu_barrier();
> > > > > > > >
> > > > > > > >         mutex_lock(&codetag_lock);
> > > > > > > > _
> > > > > > > >
> > > > > > > > But I do wonder whether this is in the correct place.
> > > > > > > >
> > > > > > > > Waiting for a module's ->exit() function's kfree_rcu()s to complete
> > > > > > > > should properly be done by the core module handling code?
> > > > > > >
> > > > > > > I don't think core module code cares about kfree_rcu()s being complete
> > > > > > > before the module is unloaded.
> > > > > > > Allocation tagging OTOH cares because it is about to destroy tags
> > > > > > > which will be accessed when kfree() actually happens, therefore a
> > > > > > > strict ordering is important.
> > > > > > >
> > > > > > > >
> > > > > > > > free_module() does a full-on synchronize_rcu() prior to freeing the
> > > > > > > > module memory itself and I think codetag_unload_module() could be
> > > > > > > > called after that?
> > > > > > >
> > > > > > > I think we could move codetag_unload_module() after synchronize_rcu()
> > > > > > > inside free_module() but according to the reply in
> > > > > > > https://lore.kernel.org/all/20241007112904.GA27104@breakpoint.cc/
> > > > > > > synchronize_rcu() does not help. I'm not quite sure why...
> > > > > > >
> > > > > > It is because, synchronize_rcu() is used for a bit different things,
> > > > > > i.e. it is about a GP completion. Offloading objects can span several
> > > > > > GPs.
> > > > >
> > > > > Ah, thanks! Now that I looked into the patch that recently added
> > > > > kvfree_rcu_barrier() I understand that a bit better.
> > > > >
> > > > > >
> > > > > > > Note that once I'm done upstreaming
> > > > > > > https://lore.kernel.org/all/20240902044128.664075-3-surenb@google.com/,
> > > > > > > this change will not be needed and I'm planning to remove this call,
> > > > > > > however this change is useful for backporting. It should be sent to
> > > > > > > stable@vger.kernel.org # v6.10+
> > > > > > >
> > > > > > The kvfree_rcu_barrier() has been added into v6.12:
> > > > > >
> > > > > > <snip>
> > > > > > urezki@pc638:~/data/raid0/coding/linux.git$ git tag --contains 2b55d6a42d14c8675e38d6d9adca3014fdf01951
> > > > > > next-20240912
> > > > > > next-20240919
> > > > > > next-20240920
> > > > > > next-20241002
> > > > > > v6.12-rc1
> > > > > > urezki@pc638:~/data/raid0/coding/linux.git$
> > > > > > <snip>
> > > > > >
> > > > > > For 6.10+, it implies that the mentioned commit should be backported also.
> > > > >
> > > > > I see. I guess for pre-6.12 we would use rcu_barrier() instead of
> > > > > kvfree_rcu_barrier()?
> > > > >
> > > > For kernels < 6.12, unfortunately not :) If you have a possibility to
> > > > switch to reclaim over call_rcu() API, then you can go with rcu_barrier()
> > > > which waits for all callbacks to be completed.
> > >
> > > We do not control the call-site inside the module, so this would not
> > > be possible.
> > >
> > > >
> > > > Or backport kvfree_rcu_barrier(). It __should__ be easy since there
> > > > were not many changes into kvfree_rcu() between 6.10 and 6.12-rcX.
> > >
> > > That sounds better. I'll take a stab at it. Thanks!
> 
> I prepared backports for stable 6.10.y and 6.11.y branches which
> contain this patch along with the prerequisite "rcu/kvfree: Add
> kvfree_rcu_barrier() API" patch. I think that's the only prerequisite
> required. However, since this patch is not yet in Linus' tree, I'll
> wait for it to get there before sending backports to stable (per Greg
> KH's recommendation). Please let me know if you think it's more
> critical and should be posted earlier.
>
To me it sounds reasonable.

--
Uladzislau Rezki

