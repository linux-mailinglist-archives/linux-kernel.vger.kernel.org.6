Return-Path: <linux-kernel+bounces-406184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC189C5BCD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0AA1F22D91
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EC8200BA7;
	Tue, 12 Nov 2024 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SHXIbhkd"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2348A200B8D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731425182; cv=none; b=dqRCY6bvPmiaF/CbGCSarL7kCvObsiZ1mX2hyWDd4P2X9UQ+sCcvD6xRXbFEUZJdxAlLf1ZIuJg3qhGJoW0Eeoc0qG4NGDv/uIOO7f2/yaTr5mani1fdKPtmC1KUNy7UNjK1Cyn+ugYE27j2W8tTgfs19ujmO05UWLlK4DjTEv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731425182; c=relaxed/simple;
	bh=2aGa9uuY9cAMDKxGiUiBWpsOEVDMFnj8X/+FL4Uyvyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEia/9XaHAhhVZfuKpEumcjDLMTmXDyr9zcWe6rc7yt/uKfRTyaG0CY3XDppYKAa/MOVedCqrtn3FQ7KOO26iqBwT8mjTn8AIq3k9BzCEfe0IVPCqadjJdfruB5+09NnGZkGSzbPmXddetHT/EHOSk4bjOaH38l95Uj8m8xJPQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SHXIbhkd; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-460b295b9eeso219841cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 07:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731425179; x=1732029979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SueiPZcu6v2iTwrZiV1Do5slfePSN7Fwh1eeaBeVNFM=;
        b=SHXIbhkd7i3jKtt/vED02b2YVzZaBqnYLZKlA9QcVOf1ZWIvwNPa0Iyvw1kZhNkV7x
         R2QcWkU4JmlCRhk47nwo6OuSTJve5XP7FnPUnfbKNv0GiCcq6gA+HR6iNwAL98PBa4fo
         8TGYXGG6m9eShww6uH6IB+CZWZF9zbgvgD8Ew92w2t/e94JVUIIBmYWwpU3fN6flUJW5
         aVLnt4Wp2Wb08GeYCjftokHT29RVyGi4QCYMso2h1EusQ2Py70kj/kracf31N2Jmm7YM
         FKi5hHzI9LYKjHc6QQ6ZCDtBsTFTkWyTK9kB+ezgJ+Abk2s1Ddc1g10L2p9apDFdr2JS
         lXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731425179; x=1732029979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SueiPZcu6v2iTwrZiV1Do5slfePSN7Fwh1eeaBeVNFM=;
        b=UbaTn2ixBaLZw71d5vPP66tg9yIZw2CrQV5mVx2453SQPUurZfSjCbrIIqrDpagpqK
         LIk6Ie0Dg60uqWmILtldDhYpJodnbHwx8PL8YsPrr1RmOLnBDzYLjAcGz/OpAMelZt21
         NyGPs+ztJeUZKXebN/6n3IY5yY8VVzcumK9Lbr1wLIUnoB5RLrpiGLmZ37kxarTSep1w
         QBwa5Q45KIf2YMgQV37vVkFe01aE/cx1oaGSz2jHUkiyXofbf9lbOqbr99wXHGShMZfp
         Yne4gFg0T2afHVUsiFtqtwn5XyRdzoaXNAiXmAPGkA6v9izsajVss1s/R1s6Ff9B8lJq
         XMmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkMXvXDQMhiuTT80w/yKCOJPTOiU3Qhsu07e+jxMj6+QkAUUFz43k9G82bYULnOmYLZpCOC0+qYljx1Qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkKrt5SYxEOnJjcSZuK+W7zUKzhBbMqN0hsHNF3WN8+yBnWij1
	UHQXKQJOoRy+Im8XqbAbxxr9YY3PnX2j3siabUHWf24IE+YjcGzAuhhr6Si7gw/aa5adTXLSLq3
	bGESYKwwamlw+wXLcX3GWDpEE7wOgAlgl1Oe9
X-Gm-Gg: ASbGnctxHsc5XsYzQqBr9vVlICKSvyidm1jAtEQYVekRfr4G/kwiJYxrlvhNGyrkyCu
	4MLLLMnFKMwJBl31WYFbnO+8/LICC+EUhLnHg1V3mMaXLSDCElX4gg2pKL8hi5Q==
X-Google-Smtp-Source: AGHT+IHVKwHvBOjdxW3YDg7/1w2kJNlWwQohouDO6yr8O/K7fRMUFrm9z09c9z1MkF4Bdk7aMPMitZkBUxs02yNzHBk=
X-Received: by 2002:a05:622a:190a:b0:462:c96a:bb30 with SMTP id
 d75a77b69052e-4633ef60502mr4067291cf.2.1731425178672; Tue, 12 Nov 2024
 07:26:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108075004.131911-1-hao.ge@linux.dev> <CAJuCfpEp_3Dz32fdpUaUbPaP6KZ+0fXmXBvBV1jRt9Q+LMRQAQ@mail.gmail.com>
 <71703c20-8311-ce3f-fbed-27d2ec3a2c82@linux.dev>
In-Reply-To: <71703c20-8311-ce3f-fbed-27d2ec3a2c82@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 12 Nov 2024 07:26:07 -0800
Message-ID: <CAJuCfpGpU6TsbbFvR2pw54YFg17+od3BLtxLoxRY_6o6mhopyA@mail.gmail.com>
Subject: Re: [PATCH] lib/alloc_tag: Remove the sysctl configuration to prevent
 users from disabling it at runtime
To: Hao Ge <hao.ge@linux.dev>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Hao Ge <gehao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 7:31=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> Hi Suren
>
>
> Firstly, please forgive me for my improper wording in the commit message.
>
> After sending it, I realized that I should have used "suggestion"
> instead of "decided".
>
> Secondly, please forgive me for taking a few days to respond. I've been
> quite busy these days.

No worries.

>
>
> Let's continue to discuss this issue.
>
>
> On 11/9/24 02:16, Suren Baghdasaryan wrote:
> > On Thu, Nov 7, 2024 at 11:50=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote=
:
> >> From: Hao Ge <gehao@kylinos.cn>
> >>
> >> After much consideration,I have decided to remove
> >> the "mem_profiling" sysctl interface to prevent
> >> users from dynamically enabling or disabling the
> >> MEMORY ALLOCATION PROFILING feature at runtime.
> >>
> >> I have taken the following actions: I set
> >> CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=3Dy to
> >> enable memory allocation profiling by default,
> >> and then made adjustments to mem_profiling dynamically
> >> during runtime.
> >>
> >> When I ran the OOM test program, I obtained useful
> >> information that was indeed very helpful for debugging.
> >>
> >> [ 1023.065402] Memory allocations:
> >> [ 1023.065407]     12.8 GiB     6546 mm/huge_memory.c:1328 func:do_hug=
e_pmd_anonymous_page
> >> [ 1023.065412]      873 MiB   229985 arch/arm64/mm/fault.c:986 func:vm=
a_alloc_zeroed_movable_folio
> >> [ 1023.065415]      187 MiB    29732 mm/slub.c:2412 func:alloc_slab_pa=
ge
> >> [ 1023.065418]     99.8 MiB    25560 mm/memory.c:1065 func:folio_preal=
loc
> >> [ 1023.065421]     47.2 MiB     3189 mm/readahead.c:434 func:ra_alloc_=
folio
> >> [ 1023.065424]     30.0 MiB       15 mm/khugepaged.c:1072 func:alloc_c=
harge_folio
> >> [ 1023.065428]     28.6 MiB      514 mm/compaction.c:1880 func:compact=
ion_alloc
> >> [ 1023.065430]     25.8 MiB     6592 mm/page_ext.c:271 func:alloc_page=
_ext
> >> [ 1023.065433]     25.6 MiB     6546 mm/huge_memory.c:1161 func:__do_h=
uge_pmd_anonymous_page
> >> [ 1023.065436]     23.5 MiB     6017 mm/shmem.c:1771 func:shmem_alloc_=
folio
> >>
> >> After running echo 0 > /proc/sys/vm/mem_profiling
> >> and then executing the same test program,
> >> I obtained the following results
> >>
> >> [ 1156.509699] Memory allocations:
> >> [ 1156.509703]      187 MiB    29645 mm/slub.c:2412 func:alloc_slab_pa=
ge
> >> [ 1156.509707]      142 MiB     9357 mm/readahead.c:434 func:ra_alloc_=
folio
> >> [ 1156.509710]      136 MiB    41325 arch/arm64/mm/fault.c:986 func:vm=
a_alloc_zeroed_movable_folio
> >> [ 1156.509713]     99.7 MiB    25531 mm/memory.c:1065 func:folio_preal=
loc
> >> [ 1156.509716]     56.0 MiB       28 mm/huge_memory.c:1328 func:do_hug=
e_pmd_anonymous_page
> >> [ 1156.509719]     30.0 MiB       15 mm/khugepaged.c:1072 func:alloc_c=
harge_folio
> >> [ 1156.509723]     28.6 MiB      514 mm/compaction.c:1880 func:compact=
ion_alloc
> >> [ 1156.509725]     26.3 MiB     7460 mm/readahead.c:264 func:page_cach=
e_ra_unbounded
> >> [ 1156.509728]     25.8 MiB     6592 mm/page_ext.c:271 func:alloc_page=
_ext
> >> [ 1156.509730]     23.5 MiB     6016 mm/shmem.c:1771 func:shmem_alloc_=
folio
> >>
> >> Because mem_profiling was disabled by executing
> >> echo 0 > /proc/sys/vm/mem_profiling,we are unable to
> >> record memory allocation information after the disablement.
> > Naturally you are unable to track the allocations after disabling it.
> > You disabled it as root, so I assume you know what you are doing.
> >
> >> These output logs can mislead users. And similarly, the same
> >> applies to alloc_info.
> > I would understand if you made /proc/allocinfo empty after disabling
> > it to avoid confusing the user, but ripping out the ability to
> > enable/disable profiling at runtime does not make sense to me. Once
> > you collect required data, disabling profiling gets you back the
> > performance that you pay for it. There are usecases when a program on
> > a remote device periodically enables profiling for some time, records
> > the difference in allocations and then disables it. Your change breaks
> > such users.
>
>
> Actually, my original intention was also to make /proc/allocinfo empty
> when disabling it,
>
> but I considered the following scenario: after we disable it and clear
> /proc/allocinfo,
>
> we then start a memory-intensive application,
>
> such as our OOM (Out-Of-Memory) test program.
>
> If we later enable it again, the issue described in my commit message
> would still arise.

The absolute values won't mean anything once profiling is disabled. In
cases when profiling gets disabled, the only useful way to use it
again is to enable it and record the initial states, let your workload
run, capture the states after the workload is complete and compare it
with the recorded initial state. Deltas can be useful, the absolute
values would not matter.
But maybe I'm not getting your usecase. Could you please explain what
you are trying to achieve and what are your expectations of how
profiling should act?
Thanks,
Suren.

>
> Perhaps we need to further consider how to handle this situation.
>
> Thanks Best regards Hao
>
> >> We already have boot parameters that allow users to
> >> choose whether to enable or disable.
> >> In order to maintain the accuracy of memory allocation
> >> information,I have decided to remove the runtime switch.
> > Well, I disagree with your decision.
> > NAK.
> >
> >> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> >> ---
> >>   lib/alloc_tag.c | 26 --------------------------
> >>   1 file changed, 26 deletions(-)
> >>
> >> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> >> index 81e5f9a70f22..47fa969c23f3 100644
> >> --- a/lib/alloc_tag.c
> >> +++ b/lib/alloc_tag.c
> >> @@ -227,31 +227,6 @@ struct page_ext_operations page_alloc_tagging_ops=
 =3D {
> >>   };
> >>   EXPORT_SYMBOL(page_alloc_tagging_ops);
> >>
> >> -#ifdef CONFIG_SYSCTL
> >> -static struct ctl_table memory_allocation_profiling_sysctls[] =3D {
> >> -       {
> >> -               .procname       =3D "mem_profiling",
> >> -               .data           =3D &mem_alloc_profiling_key,
> >> -#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
> >> -               .mode           =3D 0444,
> >> -#else
> >> -               .mode           =3D 0644,
> >> -#endif
> >> -               .proc_handler   =3D proc_do_static_key,
> >> -       },
> >> -};
> >> -
> >> -static void __init sysctl_init(void)
> >> -{
> >> -       if (!mem_profiling_support)
> >> -               memory_allocation_profiling_sysctls[0].mode =3D 0444;
> >> -
> >> -       register_sysctl_init("vm", memory_allocation_profiling_sysctls=
);
> >> -}
> >> -#else /* CONFIG_SYSCTL */
> >> -static inline void sysctl_init(void) {}
> >> -#endif /* CONFIG_SYSCTL */
> >> -
> >>   static int __init alloc_tag_init(void)
> >>   {
> >>          const struct codetag_type_desc desc =3D {
> >> @@ -264,7 +239,6 @@ static int __init alloc_tag_init(void)
> >>          if (IS_ERR(alloc_tag_cttype))
> >>                  return PTR_ERR(alloc_tag_cttype);
> >>
> >> -       sysctl_init();
> >>          procfs_init();
> >>
> >>          return 0;
> >> --
> >> 2.25.1
> >>

