Return-Path: <linux-kernel+bounces-240357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE749926CA8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 02:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7B01F22CBB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 00:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A462F802;
	Thu,  4 Jul 2024 00:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ch9CFvKa"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E7E23AD
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 00:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720051818; cv=none; b=MTUpalJ1i34Gn3/FcKiZNbUGaMWVJxU2GvykM/EJ8M3KaVICN1BI7ZTE5hW9PlIvDtTtjk8UKDfURiGQeBW/CUmp6R/WmyHhuPYaDRcXhr3zAu78S4WyrKzBmsaB8LWtNNijZjWuKSCTO6njuG5YNkT7yj4WWFKb5QNLLIfgJy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720051818; c=relaxed/simple;
	bh=FhmuSKblrIjQad4qH998vzAAzGqibWTVQxbRcFUuMro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDo3FHn6dpIjG3yxgPEIXN9VZLB17SEJkcbf8wt+SrwvTDtBrP06yHhknJb99xQyWtVaTz1FEVED2/lyV6oxEhKCB0JC6/OTmn6BMHd2wpPvk4Q3Kwt3KGy8MNzd8Zg1vKm8zeI0GJ6MU6sq6iyW+kncDNNN8s9zhIZVMT/DinM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ch9CFvKa; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e03a581276eso60020276.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 17:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720051816; x=1720656616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEbfWjcf8PAR0VFi6cTERFAiZNLDG/oudltE/b+orzs=;
        b=ch9CFvKaWGbajQkTCPn2TGyb+JjT4KVRPVEpyQL+NTnX3z9sf0Zpy4H+bh+zCreP2I
         tk3ARkD8I0B9GDqfk+SY0gPC9U7hciJ//BW2ov+d+SVRKMfqw0uPSajPnrvDpq8/LIZZ
         ceNMFvLYQK42ugo02PZEzKqB0I0icQx456A/e3iL4wmf+/4EE1Z+xuXv4U7k6/qrhMPw
         8LU1mvieOsXhZY8lKpkTGdtHmHGP6x7Uxi4L7dNst8t3aUB0ronGDCwYFZ/LJjezv8+c
         pjVcQYFc6Pv/kW3uMxN4j2qt4ftFVN568HipxYxzTGNMvJDnXYi1+W1uLIsmV/kkU4rR
         D9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720051816; x=1720656616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEbfWjcf8PAR0VFi6cTERFAiZNLDG/oudltE/b+orzs=;
        b=RWOLEDmoccRM+NarSb9Dvatsu1breZk0rAxaqp2KlW4JegdmNySdJejUM4BGRMysQN
         Pg0RxmzU6ZsABFRUwpFzUeFU7X+0Lh9g8eekvrtQl7AKhq13H9d79sTpNQO4RFZZXMpP
         xsnSv3ERNpdehq1HdluBLH1II8uesiZqmIs3/NS9zDhnD9s55YrGdCNAOvPoJpNz0+SR
         VOrTl5LoWENebxN5SgmqfhisZwOH58KV1sOCk51uoHHLs6w3FJyIr1/kkvCq/3JrTnYy
         coZVPle5CVtNXcUgDbRZwXkXoXncv616o2KdtEyGkYnRg5ncqQUs9mgSfO2pOt0O2Oro
         aPvg==
X-Forwarded-Encrypted: i=1; AJvYcCXMitsWqMIPR9G5T0h1SrVYsNUetHMY8KyqjJk4Pp17YkZ1InWgY70hStOw4yoI4lRKe41CbDm+1cwUy1YQiFL4yDq0B6SUAfOpefj5
X-Gm-Message-State: AOJu0YwE83PLTE2UFawjcIDGHNEx8kajXpURtzBuWvQj+npZywF6s6CC
	RylGKkSZvK11sXWHI6PaG4R62B3JTecR8c5Vi0dEwX7KwqOHXyFw/fhL/tgl4jeWbjAmKSxbMGI
	FWYsjP6Z/UUO7b5z1PMBrXk4UYlIylYXFAx0y
X-Google-Smtp-Source: AGHT+IHVbIWY8+MVAQjJm4Dh88U1jIaIBZCk9ebjd4qqMvfCYk7Sz2Xrnttdv8cAjwn6phUd2np0ytvMSwjnJs1uOVU=
X-Received: by 2002:a0d:ea83:0:b0:64b:bad:2108 with SMTP id
 00721157ae682-652d7d528a8mr852177b3.39.1720051815989; Wed, 03 Jul 2024
 17:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703221520.4108464-1-surenb@google.com> <20240703155129.cbd023c14dee61e5727bb750@linux-foundation.org>
 <CAJuCfpFGRmQXxkaUjasyVGu74su_a-319o5zYe_eJD_KfbmNdg@mail.gmail.com>
In-Reply-To: <CAJuCfpFGRmQXxkaUjasyVGu74su_a-319o5zYe_eJD_KfbmNdg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 3 Jul 2024 17:10:03 -0700
Message-ID: <CAJuCfpGA5Jy0NmO6oT0Y-KQSPvjj-=pDsM9AiT0vSUUGAM96OA@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched.h: always_inline alloc_tag_{save|restore} to
 fix modpost warnings
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, kent.overstreet@linux.dev, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 4:23=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Wed, Jul 3, 2024 at 3:51=E2=80=AFPM Andrew Morton <akpm@linux-foundati=
on.org> wrote:
> >
> > On Wed,  3 Jul 2024 15:15:20 -0700 Suren Baghdasaryan <surenb@google.co=
m> wrote:
> >
> > > Mark alloc_tag_{save|restore} as always_inline to fix the following
> > > modpost warnings:
> > >
> > > WARNING: modpost: vmlinux: section mismatch in reference: alloc_tag_s=
ave+0x1c (section: .text.unlikely) -> initcall_level_names (section: .init.=
data)
> > > WARNING: modpost: vmlinux: section mismatch in reference: alloc_tag_r=
estore+0x3c (section: .text.unlikely) -> initcall_level_names (section: .in=
it.data)
> >
> > Well, is it only about fixing warnings?  If the warning is correct then
> > this might be fixing kernel crashes.
> >
> > Do you know where these references are coming from?
>
> I *think* this happens when alloc_tag_save()/alloc_tag_restore() are
> not inlined and are called from an __init function.  They access the
> `tag` parameter passed to them and since that tag is a static local
> variable inside an __init function, I assume it gets allocated inside
> __initdata. If so, an example of such case is cma_activate_area()
> which is an __init function and allocates memory using
> bitmap_zalloc():
> https://elixir.bootlin.com/linux/v6.10-rc6/source/mm/cma.c#L97. There
> are likely more cases like that.

Actually, my theory is wrong. Allocation tags are always allocated
from the "alloc_tags" section. This makes me think that it's the
access to current->alloc_tag that causes these warnings. After my
change I actually see another warning like this:

WARNING: modpost: vmlinux: section mismatch in reference:
get_current+0xc (section: .text.unlikely) -> initcall_level_names
(section: .init.data)

get_current()/current_thread_info() for xtensa arch are inline functions:
https://elixir.bootlin.com/linux/v6.10-rc6/source/arch/xtensa/include/asm/c=
urrent.h#L22
https://elixir.bootlin.com/linux/v6.10-rc6/source/arch/xtensa/include/asm/t=
hread_info.h#L94

and they return a local variable `thread_info`.
Let me dig a bit more to understand what's really happening here.

>
> >
> > I'm curious about the .text.unlikely.  Makes me wonder if we should
> > also have .init.unlikely for unlikely() calls which happen from __init
> > code.  Maybe we already handle that.
>
> I don't really know.
>
> >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202407032306.gi9nZsBi-l=
kp@intel.com/
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Cc: Kent Overstreet <kent.overstreet@linux.dev>
> >
> > Fixes: 22d407b164ff ("lib: add allocation tagging support for memory al=
location profiling")
>
> Yes. Do you want me to post a v2 or will handle that locally?
>
> > Cc: stable
>
> I don't think so. This feature was introduced in 6.10, so no backports
> needed, right?
>
> >
> > yes?
> >
> >

