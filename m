Return-Path: <linux-kernel+bounces-529905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDC0A42C55
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A571892DD1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C585D1EDA31;
	Mon, 24 Feb 2025 19:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dIHNiEnW"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDD31E5B95
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424051; cv=none; b=K4KK2Dgp7SZHC7pxtzhb0+i+IWxsVDpoGWUSdxviWJ+zfgVS32itHhMaHFWUE/1ISlbuxGCNx/z7kganX8i+BZQNOLF2kGS4aFjxDgffPRyi4JbHM4bnZgE2V+PkJWYAx1g/Jx8R7HjgQfCxCKTANKvngTEP9mwZ00XRKdKG7Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424051; c=relaxed/simple;
	bh=GbuUXHqUtP/Zw8eNMCTnJLOtMqQEM+OFbTLgxZqprGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=WR5SKUxIiRDfVTAdmur2MDkovOncfDOi1Rvgyd2DnWnJj4oDQaEGkqAfxzhL0CX3FOSRzfxFfzpSTesZww9cvVaEKlmQNKrl6vsLidg/NH4vGFkU9rui3L5SLIXnu8ZDRTK/UoRNtj3RBO9s5jMjvVWX7yHxIfF+tB5qBs3hl2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dIHNiEnW; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2bc69a33810so177582fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740424048; x=1741028848; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQCHGb/1mEcTjB0ohJkHDUAZUcOj91T5VUbYgnfzfKs=;
        b=dIHNiEnWIVWmOw1r432MBjAWluocUeWXz11TtpsWGtyet7Wp2BlgSMexd2JdgAPeTS
         xxCqIPEsuKf7TbMV75RQerE6gmFmPGwetKBilHB7rqvvTfu4IEcJpqQvgf3U5L7UqU5t
         CWcb/1l09DoRfW+8MlXyOsND5znqTdgZyi/sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740424048; x=1741028848;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQCHGb/1mEcTjB0ohJkHDUAZUcOj91T5VUbYgnfzfKs=;
        b=UnWQ1DZjcnyyUAau1+U/97A1muArq5DNgPNUMZ7LF3Xvf340Vp1+RRdQMjL5GFqJVg
         4jHYxI2C5ZV1zvqNFOdxP9EmAMZGr6Gd9tOa/uCV95RLW93nt0Fw4remvc1MWuxgIFfb
         7wVUjVlj5Sq/WUz7SMJhxbztOYwxEN0815KfPw8vlgoZo9dOkQDgLkP1iEwDQSOD9auc
         9aO6XvkigbaBKBCBt/cwq0+UNTV3VJ9AkQqYesABHBWmcjzsn8CZ31kr5VfwhQJ659QH
         xozcRLYO+dIuJp4yGg0AxE0YAutN0VVvG9qCz7kImxeMxGQNC0MJCTx8VXtd1XsSzziN
         JYnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtxLl/VqGJl0uO9ZBYNbXitCqKhISnjgoXUyJqzVEpTr5FMlc87qdhDp4ERNZ3uqCALkJUwcADirs4Rns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ZwLl3Xi6tNAaH3GzPqAcABpByl0C8ut2U1DKEDuXoeGdDCdJ
	kgVoa77jSeABj+4JgKMf7WH1N2U5DTHi0viKgXqluuX/ihZ1U/9mPLbkjT7A7+O+7Hy5V++Ihlw
	lhwJsFMca8+M7j1Pu2K0bqJz56C3/LKjqx7a8
X-Gm-Gg: ASbGncsVG7MxIXHavhtAO9JMoSHJOnRTYhTadexkbTUv4lCNpRtWyJuYbnzJCeRNbZ1
	mRAjQzbQmeD87IJ+ZiGxg+ncl1bQWv2soOWhOx4dh5MH9i9FXpV4Si61Mzko0gyUXvPABnSH4fP
	QUD4ys9jB/0hXOpjQkDakAhbbIoYAJhDBJV4v9
X-Google-Smtp-Source: AGHT+IFrbrwEmuYOunYtHNdMni7okQkt3QFjQtD8vHn5l5zTdcXfnyAMvDD/7Ae+veDhcxsJz6JhhrxQ5jvSrdRN1DM=
X-Received: by 2002:a05:6808:201f:b0:3f4:11a1:615a with SMTP id
 5614622812f47-3f4247a9cd8mr4184198b6e.6.1740424048367; Mon, 24 Feb 2025
 11:07:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224174513.3600914-1-jeffxu@google.com> <20250224174513.3600914-2-jeffxu@google.com>
 <443992d7-f694-4e46-b120-545350a5d598@intel.com> <CABi2SkVKhjShryG0K-NSjjBvGs0UOVsY-6MQVOuQCkfuph5K8Q@mail.gmail.com>
 <3nxcy7zshqxmjia7y6cyajeoclcxizkrhhsitji5ujbafbvhlu@7hqs6uodor56>
In-Reply-To: <3nxcy7zshqxmjia7y6cyajeoclcxizkrhhsitji5ujbafbvhlu@7hqs6uodor56>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 24 Feb 2025 11:07:17 -0800
X-Gm-Features: AWEUYZnFbU7bWMO5mDGdFqrYIJo2aJVDJw1Nuop8sup_tSwiXkOaJwtHACFOP_4
Message-ID: <CABi2SkUfABFR+SpjBzHT9dEcsJ0OOHiyttKkQVhqrHLrtZzopA@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] mseal, system mappings: kernel config and header change
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	Dave Hansen <dave.hansen@intel.com>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	avagin@gmail.com, benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 11:03=E2=80=AFAM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * Jeff Xu <jeffxu@chromium.org> [250224 13:44]:
> > On Mon, Feb 24, 2025 at 10:21=E2=80=AFAM Dave Hansen <dave.hansen@intel=
.com> wrote:
> > >
> > > On 2/24/25 09:45, jeffxu@chromium.org wrote:
> > > > +/*
> > > > + * mseal of userspace process's system mappings.
> > > > + */
> > > > +#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
> > > > +#define MSEAL_SYSTEM_MAPPINGS_VM_FLAG        VM_SEALED
> > > > +#else
> > > > +#define MSEAL_SYSTEM_MAPPINGS_VM_FLAG        VM_NONE
> > > > +#endif
> > >
> > > This ends up looking pretty wonky in practice:
> > >
> > > > +     vm_flags =3D VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|VM_PFNMAP;
> > > > +     vm_flags |=3D MSEAL_SYSTEM_MAPPINGS_VM_FLAG;
> > >
> > > because MSEAL_SYSTEM_MAPPINGS_VM_FLAG is so much different from the
> > > other ones.
> > >
> > > Would it really hurt to have
> > >
> > >  #ifdef CONFIG_64BIT
> > >  /* VM is sealed, in vm_flags */
> > >  #define VM_SEALED       _BITUL(63)
> > > +#else
> > > +#define VM_SEALED       VM_NONE
> > >  #endif
> > >
> > > ?
> > >
> > VM_SEALED isn't defined in 32-bit systems, and mseal.c isn't part of
> > the build. This is intentional. Any 32-bit code trying to use the
> > sealing function or the VM_SEALED flag will immediately fail
> > compilation. This makes it easier to identify incorrect usage.
> >
>
> The reason that two #defines are needed is because you can have mseal
> enabled while not sealing system mappings, so for this to be clean we
> need two defines.
>
> However MSEAL_SYSTEM_MAPPINGS_VM_FLAG, is _way_ too long, in my opinion.
> Keeping with "VM_SEALED" I'd suggest "VM_SYSTEM_SEALED".
>
> > For example:
> > Consider the case below in src/third_party/kernel/v6.6/fs/proc/task_mmu=
.c,
>
> third_party?
>
Sorry, I pasted the code path from ChromeOS code base, it is actually
in the kernel itself.

fs/proc/task_mmu.c

> >
> > #ifdef CONFIG_64BIT
> > [ilog2(VM_SEALED)] =3D "sl",
> > #endif
> >
> > Redefining VM_SEALED  to VM_NONE for 32 bit won't detect the problem
> > in case that  "#ifdef CONFIG_64BIT" line is missing.
>
> I don't think it is reasonable to insist on doing things differently in
> the kernel because you have external tests that would need updating.
> These things can change independently, so I don't think this is a valid
> argument.
>
> If these are upstream tests, and we need these tests to work then they
> can be fixed.
>
As above, this is actually kernel code, not test.

-Jeff

> >
> > Please note, this has been like this since the first version of
> > mseal() RFC patch, and I prefer to keep it this way.
>
> Thanks,
> Liam

