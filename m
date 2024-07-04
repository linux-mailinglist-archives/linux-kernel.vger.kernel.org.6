Return-Path: <linux-kernel+bounces-240475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC7D926E2A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 05:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6A2282A3A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABD11B810;
	Thu,  4 Jul 2024 03:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RhOwjlP6"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DD0171A7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 03:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720064786; cv=none; b=hW0axqvl7rZ3hqtoKeLbEbHmLj4dXHU9ZJbetk1l//dewPA+QOTojWVaBm3LZ+n5EEJJqRty7KQKcSfmkRW84fZU90tFS45TVXoFaXXCAQ6/Q2PEyq8lINJNgXf1Q903dxOv0vFOPeMUeFUEDEycTzLaiAH+n65AapneW3VaSrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720064786; c=relaxed/simple;
	bh=6npBs5l9VIURR9VLvxtX6O0uMnpSWtTqNRXYNrR44HY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kUVVhL6z+oYqHdmXjx18E5r7G9FWlBeraNgnG7fAWx6hejY6hYjwdYEza8PvS73yTbzWbrQnxxuJa/o9zsyQ6jsoUj5kjypLZUGDeBP6muCnwLZXzdv0n13X6au74T/qkdFt+6ZKbiGEfszD1Aqo+yiWBCLzzKlKaY1YJsafJEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RhOwjlP6; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6515b824117so1656307b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 20:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720064784; x=1720669584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EStjdsOzepjjM5A5rk8ibf/EgTstvHhiNpoW8Oevp9M=;
        b=RhOwjlP6eU5gq6m1DWnZFB659ZnbDdEEXyOjUvlf1ADg7iUrsoZEiGy4Sy1tbP2h3B
         Pl18zGWtOUXrZrQZ2eL++iese5k+nQJk0atj+dDOGSblXMp4MDBwZRKPu6TgP9loGfdb
         +POrvtfH6WYcVh3kpeeZ7OdpEvqRp705sWeBc3tKmmLSFOr0tycj432+UnUB2zHk4lmn
         t0HiSNPHfGhOu9LIJoUSuxOzqjViq2JS2oHwV1wh+v5kyIkvDt7XTcKlIymx0EFSP9Sb
         +CIk9Qez4UetYVOw783uMrjUAN0sznlWa0aLinJPebFz00m3aq8xr4PoPVSmcd82jhMH
         +SRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720064784; x=1720669584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EStjdsOzepjjM5A5rk8ibf/EgTstvHhiNpoW8Oevp9M=;
        b=QvWkxv/s0kSu8e/21iZXtCvWpwW/X1Po00i+J/sru+45vBccbbFoPgL43alIqF6Efz
         prpBNxoJbDkWzcezReIUTGOyxxZ90+8CEERWAMLx5WsV8BnT6VcrUvhRXnmMBwyBJQDV
         cZh0UsGnZGnNvRj2CWMqU1qrm9LX9cIHoIYFlV58DkvbUxaEtWrdVRzhIm/Uu7IUZtQ2
         TxkY+6b4aG16mdOvpYfCUTWeMif9Br++y1qqmLCVLQt0GNPxoKNex5BzskDRtwUbkO2f
         eqmvC+QemUHZNGXamuhJJ2vsZzpZB4+5e8IITlDSZ8uKHBl6IztJ7VVXf7rbf3bE01yd
         KMkg==
X-Forwarded-Encrypted: i=1; AJvYcCU+M/NWI+3dt6FuEA8ke0KJga9UKc6i88qw9GxvIM2+diREKUM2+drbXQLNOYCdwqMlAPQ5rZZ5PYHKdypsdZ3tIp4+CdaLR/Ue0TfH
X-Gm-Message-State: AOJu0YzF90n6u7692+r8g8pz5+JtHWomEwypg3+CteUfxZ7X/FJNgZ71
	iRdNu+/7+Jsu/Hl+o0vKOtO5QI2mZXpLpiJA09ScbyncuG2Rok7d8UCmP88u8bFT4N6NXSw0867
	s8A4av8TGmxDERpwkiDH7E+QwbopmFn945zNk
X-Google-Smtp-Source: AGHT+IFvoEALwPo0LAg3V6WKnc61is/PnFpwkxQCWmpumWnXiXKcx86WJZ+H6Wr0VtSV97C4EM6Uyh0JZvsLXjsLDXc=
X-Received: by 2002:a05:690c:ece:b0:625:1090:b54f with SMTP id
 00721157ae682-652d8039701mr5304797b3.39.1720064783654; Wed, 03 Jul 2024
 20:46:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703221520.4108464-1-surenb@google.com> <20240703155129.cbd023c14dee61e5727bb750@linux-foundation.org>
 <CAJuCfpFGRmQXxkaUjasyVGu74su_a-319o5zYe_eJD_KfbmNdg@mail.gmail.com> <CAJuCfpGA5Jy0NmO6oT0Y-KQSPvjj-=pDsM9AiT0vSUUGAM96OA@mail.gmail.com>
In-Reply-To: <CAJuCfpGA5Jy0NmO6oT0Y-KQSPvjj-=pDsM9AiT0vSUUGAM96OA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 3 Jul 2024 20:46:11 -0700
Message-ID: <CAJuCfpEJkCN1XDDE+2B4ePoFKbvSCaUA8=RO1TTg23XV56mRZg@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched.h: always_inline alloc_tag_{save|restore} to
 fix modpost warnings
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, kent.overstreet@linux.dev, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 5:10=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Wed, Jul 3, 2024 at 4:23=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
> >
> > On Wed, Jul 3, 2024 at 3:51=E2=80=AFPM Andrew Morton <akpm@linux-founda=
tion.org> wrote:
> > >
> > > On Wed,  3 Jul 2024 15:15:20 -0700 Suren Baghdasaryan <surenb@google.=
com> wrote:
> > >
> > > > Mark alloc_tag_{save|restore} as always_inline to fix the following
> > > > modpost warnings:
> > > >
> > > > WARNING: modpost: vmlinux: section mismatch in reference: alloc_tag=
_save+0x1c (section: .text.unlikely) -> initcall_level_names (section: .ini=
t.data)
> > > > WARNING: modpost: vmlinux: section mismatch in reference: alloc_tag=
_restore+0x3c (section: .text.unlikely) -> initcall_level_names (section: .=
init.data)
> > >
> > > Well, is it only about fixing warnings?  If the warning is correct th=
en
> > > this might be fixing kernel crashes.
> > >
> > > Do you know where these references are coming from?
> >
> > I *think* this happens when alloc_tag_save()/alloc_tag_restore() are
> > not inlined and are called from an __init function.  They access the
> > `tag` parameter passed to them and since that tag is a static local
> > variable inside an __init function, I assume it gets allocated inside
> > __initdata. If so, an example of such case is cma_activate_area()
> > which is an __init function and allocates memory using
> > bitmap_zalloc():
> > https://elixir.bootlin.com/linux/v6.10-rc6/source/mm/cma.c#L97. There
> > are likely more cases like that.
>
> Actually, my theory is wrong. Allocation tags are always allocated
> from the "alloc_tags" section. This makes me think that it's the
> access to current->alloc_tag that causes these warnings. After my
> change I actually see another warning like this:
>
> WARNING: modpost: vmlinux: section mismatch in reference:
> get_current+0xc (section: .text.unlikely) -> initcall_level_names
> (section: .init.data)
>
> get_current()/current_thread_info() for xtensa arch are inline functions:
> https://elixir.bootlin.com/linux/v6.10-rc6/source/arch/xtensa/include/asm=
/current.h#L22
> https://elixir.bootlin.com/linux/v6.10-rc6/source/arch/xtensa/include/asm=
/thread_info.h#L94
>
> and they return a local variable `thread_info`.
> Let me dig a bit more to understand what's really happening here.

Ok, I confirmed that the warning is happening due to the access to
"current" from alloc_tag_save()/alloc_tag_restore() functions. I guess
when these functions access "thread_info" variable:
https://elixir.bootlin.com/linux/v6.10-rc6/source/arch/xtensa/include/asm/t=
hread_info.h#L96,
compiler flags that because the variable is on the stack of an __init
function while alloc_tag_save()/alloc_tag_restore() when not inlined
are from .text section.
To fix this warning completely I also need to change get_current() and
current_thread_info() for xtensa to be __always_inline. I confirmed
that after changing that the warnings caused by memory allocation
profiling are gone. Note that there are more similar warnings when
building this architecture but they happen even when
CONFIG_MEM_ALLOC_PROFILING=3Dn. I tried fixing them all but one fix
leads to inner functions needing the same fix, so the patch grows
exponentially, so I left it for now.

If there are no objections, I'll post a v2 as two separate patches.
One changing the sched.h and the second one modifying xtensa-specific
get_current() and current_thread_info(). Will post tomorrow unless
someone replies with a better suggestion by then.
Thanks,
Suren.

>
> >
> > >
> > > I'm curious about the .text.unlikely.  Makes me wonder if we should
> > > also have .init.unlikely for unlikely() calls which happen from __ini=
t
> > > code.  Maybe we already handle that.
> >
> > I don't really know.
> >
> > >
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Closes: https://lore.kernel.org/oe-kbuild-all/202407032306.gi9nZsBi=
-lkp@intel.com/
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > Cc: Kent Overstreet <kent.overstreet@linux.dev>
> > >
> > > Fixes: 22d407b164ff ("lib: add allocation tagging support for memory =
allocation profiling")
> >
> > Yes. Do you want me to post a v2 or will handle that locally?
> >
> > > Cc: stable
> >
> > I don't think so. This feature was introduced in 6.10, so no backports
> > needed, right?
> >
> > >
> > > yes?
> > >
> > >

