Return-Path: <linux-kernel+bounces-356560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4CF996320
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2E00B27480
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1BE1917C9;
	Wed,  9 Oct 2024 08:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJIncWzv"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842C618BC0F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463021; cv=none; b=gR/sFcYhTo4fW2owDu9HQceID9WP2chtZiDM05BlIk1viVmdYFY1nGWKu7/1b36yJu/vbgrzpr2lVR4tnaZAoxz4iGSnypJ+L5PBhMYrjwwt5xc3FRw56VYzqMVBGHUaVeS760a0KU5Kr8nltNalXe/JthytbWaUMSta0zELGuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463021; c=relaxed/simple;
	bh=PejLkgWEIkL2r/JU0kIyFilIGHlilKEBBEpT5pgbTZk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSCIWsauDJJNRuny470f7Wzwhft5k0Zq1GBREMSmWhDv+vbGxGJ4I2IvFtyasWl1e5FYJ/mWs7noAebZ0jPwgAefhLqkjvbh8FVO29r0M6eSugyLcr2Pp91N+/PEzZWOlgg2gwE9VCJ5kdqePhoJGfNwBUrk3MPBnE9T1BC7Di4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJIncWzv; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5398b2f43b9so543618e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 01:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728463018; x=1729067818; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CxfQ1sz1oWhS3xG9DCzFadIEd73viv8KWyy+y7jHyBg=;
        b=WJIncWzv2msXdW5C6tV0LUKAic4e1Il3QiPxRrC+Tj/zusX0uUAzTAGMuUMda+OC+m
         s3xjIyuJlZpzJOh2Y4okx3tCrumDfka0Vx6B9zd8pwktlyifReKvh9X3/Erj1Nd/MU0k
         WWeffPOkEYDYJFpuMp5h3wZ8zV2Xa2KvgKVQryUBBvIO7nYVxxtvdlDMyYwSZtkMOoiA
         wVuhSTR8u9oMTgHoDbx1DTJtj5iPjdCYj5XMXMPZ3a9ZXJ2jM7bTAnn0iKiR7n9vISXX
         FytN1cn1dBNKtDQIuOCclhPf/QDexayU25qIhKS8RVGwDTnZr3EcfjoHvEWutBCiBSOY
         G8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728463018; x=1729067818;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CxfQ1sz1oWhS3xG9DCzFadIEd73viv8KWyy+y7jHyBg=;
        b=sXc2hMD+XO50q7Xvu7fIX1f51g39+IHMYaPUsVJkKHZdMrLxzPkKqZgz8SYmKh9+6p
         llr6nKtUq72/P4SFkaJ3Oh3L02xqT9O5vnoWS3OGCy7HWDB7+1WXj5EISTdCICHUj8Bn
         ee16EMRAzUtKSBlC8UBWvsY+62RXH9Q2X/YSB5iUSR9HkPLYv19E85Lqp9HU9NeJAMce
         P6jaGcAonHA2OCmwHwIvLEowmX9ysgY3cjJX+vSTtpkAaQRBZ/JvuqXqi4TFt8E4qFKE
         YH5yVlP4N2gn+CfbbdxZA89qYuEI+LcWwfDTPm7QO3GfLn3zMU7/yW+H1vIV3ku/X8Dy
         gWmg==
X-Forwarded-Encrypted: i=1; AJvYcCWN1QJpK70BCgby3o4jbdbUSsJcJOzmWglKwajUYngrm8IJEPvP5ijfGeSj9GJ2XgGds6GLtpGCA3pSPts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv25umS74/hkR+VgoXn3K45xioYGBJY/ghbIvdqIoh0+hFJYz1
	Iov38tdOL0uqT4amYOlPkRkOXZjK/+5We7ODeVztmVhJeGiLdgNg
X-Google-Smtp-Source: AGHT+IG4tzCiyhGlFHC64djRN0P499gmvfRWJ/4qz0OLQRaLCZa0DQC2YZjaFNx+FSKfC0xDDuOOzA==
X-Received: by 2002:a05:6512:2256:b0:52e:fef4:2cab with SMTP id 2adb3069b0e04-539c426a1a2mr640700e87.2.1728463017115;
        Wed, 09 Oct 2024 01:36:57 -0700 (PDT)
Received: from pc636 (host-90-233-214-196.mobileonline.telia.com. [90.233.214.196])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539afec1192sm1437206e87.18.2024.10.09.01.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 01:36:56 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 9 Oct 2024 10:36:53 +0200
To: Suren Baghdasaryan <surenb@google.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Ben Greear <greearb@candelatech.com>
Subject: Re: [PATCH lib] lib: alloc_tag_module_unload must wait for pending
 kfree_rcu calls
Message-ID: <ZwZApQ5eB-Bx8Bpe@pc636>
References: <20241007205236.11847-1-fw@strlen.de>
 <20241007181541.4bbe9b8580f6475023256515@linux-foundation.org>
 <CAJuCfpGZg8Pydy4rGUefOBgwJZ5C6_s3p913oFQJSVV+S9MQoA@mail.gmail.com>
 <ZwTb8tMVVqrpZIv2@pc636>
 <CAJuCfpFKXYEaNJce2bUDR0EJNNk8KV_cUZfRALfmp=ejCW042A@mail.gmail.com>
 <ZwUunnGM9UFJ9bdt@pc638.lan>
 <CAJuCfpEtZK-w_=WuSPcQAJRyoazNkw-jxGoRyU0Ggg+Ljz2dZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEtZK-w_=WuSPcQAJRyoazNkw-jxGoRyU0Ggg+Ljz2dZA@mail.gmail.com>

On Tue, Oct 08, 2024 at 11:34:10AM -0700, Suren Baghdasaryan wrote:
> On Tue, Oct 8, 2024 at 6:07 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > On Tue, Oct 08, 2024 at 04:16:39AM -0700, Suren Baghdasaryan wrote:
> > > On Tue, Oct 8, 2024 at 12:15 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > >
> > > > On Mon, Oct 07, 2024 at 06:49:32PM -0700, Suren Baghdasaryan wrote:
> > > > > On Mon, Oct 7, 2024 at 6:15 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > > > >
> > > > > > On Mon,  7 Oct 2024 22:52:24 +0200 Florian Westphal <fw@strlen.de> wrote:
> > > > > >
> > > > > > > Ben Greear reports following splat:
> > > > > > >  ------------[ cut here ]------------
> > > > > > >  net/netfilter/nf_nat_core.c:1114 module nf_nat func:nf_nat_register_fn has 256 allocated at module unload
> > > > > > >  WARNING: CPU: 1 PID: 10421 at lib/alloc_tag.c:168 alloc_tag_module_unload+0x22b/0x3f0
> > > > > > >  Modules linked in: nf_nat(-) btrfs ufs qnx4 hfsplus hfs minix vfat msdos fat
> > > > > > > ...
> > > > > > >  Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020
> > > > > > >  RIP: 0010:alloc_tag_module_unload+0x22b/0x3f0
> > > > > > >   codetag_unload_module+0x19b/0x2a0
> > > > > > >   ? codetag_load_module+0x80/0x80
> > > > > > >
> > > > > > > nf_nat module exit calls kfree_rcu on those addresses, but the free
> > > > > > > operation is likely still pending by the time alloc_tag checks for leaks.
> > > > > > >
> > > > > > > Wait for outstanding kfree_rcu operations to complete before checking
> > > > > > > resolves this warning.
> > > > > > >
> > > > > > > Reproducer:
> > > > > > > unshare -n iptables-nft -t nat -A PREROUTING -p tcp
> > > > > > > grep nf_nat /proc/allocinfo # will list 4 allocations
> > > > > > > rmmod nft_chain_nat
> > > > > > > rmmod nf_nat                # will WARN.
> > > > > > >
> > > > > > > ...
> > > > > > >
> > > > > > > --- a/lib/codetag.c
> > > > > > > +++ b/lib/codetag.c
> > > > > > > @@ -228,6 +228,8 @@ bool codetag_unload_module(struct module *mod)
> > > > > > >       if (!mod)
> > > > > > >               return true;
> > > > > > >
> > > > > > > +     kvfree_rcu_barrier();
> > > > > > > +
> > > > > > >       mutex_lock(&codetag_lock);
> > > > > > >       list_for_each_entry(cttype, &codetag_types, link) {
> > > > > > >               struct codetag_module *found = NULL;
> > > > > >
> > > > > > It's always hard to determine why a thing like this is present, so a
> > > > > > comment is helpful:
> > > > > >
> > > > > > --- a/lib/codetag.c~lib-alloc_tag_module_unload-must-wait-for-pending-kfree_rcu-calls-fix
> > > > > > +++ a/lib/codetag.c
> > > > > > @@ -228,6 +228,7 @@ bool codetag_unload_module(struct module
> > > > > >         if (!mod)
> > > > > >                 return true;
> > > > > >
> > > > > > +       /* await any module's kfree_rcu() operations to complete */
> > > > > >         kvfree_rcu_barrier();
> > > > > >
> > > > > >         mutex_lock(&codetag_lock);
> > > > > > _
> > > > > >
> > > > > > But I do wonder whether this is in the correct place.
> > > > > >
> > > > > > Waiting for a module's ->exit() function's kfree_rcu()s to complete
> > > > > > should properly be done by the core module handling code?
> > > > >
> > > > > I don't think core module code cares about kfree_rcu()s being complete
> > > > > before the module is unloaded.
> > > > > Allocation tagging OTOH cares because it is about to destroy tags
> > > > > which will be accessed when kfree() actually happens, therefore a
> > > > > strict ordering is important.
> > > > >
> > > > > >
> > > > > > free_module() does a full-on synchronize_rcu() prior to freeing the
> > > > > > module memory itself and I think codetag_unload_module() could be
> > > > > > called after that?
> > > > >
> > > > > I think we could move codetag_unload_module() after synchronize_rcu()
> > > > > inside free_module() but according to the reply in
> > > > > https://lore.kernel.org/all/20241007112904.GA27104@breakpoint.cc/
> > > > > synchronize_rcu() does not help. I'm not quite sure why...
> > > > >
> > > > It is because, synchronize_rcu() is used for a bit different things,
> > > > i.e. it is about a GP completion. Offloading objects can span several
> > > > GPs.
> > >
> > > Ah, thanks! Now that I looked into the patch that recently added
> > > kvfree_rcu_barrier() I understand that a bit better.
> > >
> > > >
> > > > > Note that once I'm done upstreaming
> > > > > https://lore.kernel.org/all/20240902044128.664075-3-surenb@google.com/,
> > > > > this change will not be needed and I'm planning to remove this call,
> > > > > however this change is useful for backporting. It should be sent to
> > > > > stable@vger.kernel.org # v6.10+
> > > > >
> > > > The kvfree_rcu_barrier() has been added into v6.12:
> > > >
> > > > <snip>
> > > > urezki@pc638:~/data/raid0/coding/linux.git$ git tag --contains 2b55d6a42d14c8675e38d6d9adca3014fdf01951
> > > > next-20240912
> > > > next-20240919
> > > > next-20240920
> > > > next-20241002
> > > > v6.12-rc1
> > > > urezki@pc638:~/data/raid0/coding/linux.git$
> > > > <snip>
> > > >
> > > > For 6.10+, it implies that the mentioned commit should be backported also.
> > >
> > > I see. I guess for pre-6.12 we would use rcu_barrier() instead of
> > > kvfree_rcu_barrier()?
> > >
> > For kernels < 6.12, unfortunately not :) If you have a possibility to
> > switch to reclaim over call_rcu() API, then you can go with rcu_barrier()
> > which waits for all callbacks to be completed.
> 
> We do not control the call-site inside the module, so this would not
> be possible.
> 
> >
> > Or backport kvfree_rcu_barrier(). It __should__ be easy since there
> > were not many changes into kvfree_rcu() between 6.10 and 6.12-rcX.
> 
> That sounds better. I'll take a stab at it. Thanks!
> 
You are welcome!

--
Uladzislau Rezki


