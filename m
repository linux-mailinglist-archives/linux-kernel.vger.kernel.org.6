Return-Path: <linux-kernel+bounces-519998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B248A3A480
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27EB3A95C3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B6D26FDA5;
	Tue, 18 Feb 2025 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/5ROgL+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526E526E170
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739900676; cv=none; b=aEwDXh0YrNiBm2gww/NAy6Cd+zn3/rZPNESZsSS2ETmQ2y2igp3F89D+g3BAiPZ0XTQ0EpMh6MmzeXhE3NRc2E9TL2fUun1buELDW4BXodN0Q8J+Wyn8e2Nsl08p48GUS/eP+D4uXv3jvzBPq36eBJ89sDKYev8/sOIHPKsGyuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739900676; c=relaxed/simple;
	bh=RB11C5xGhFwgwm3JpSBvxTXWC21mzKnqdvLNRh33Wx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZeX+WkUuXH9FGlgBLZbF01Q0jO35b5UpTwrdX+zNo31Gp8g0YsHp4Dll1oQNfVBXCSvjm6toB3JKYBnLc2Cx8iAD+We5xvM0kJq8HPyZey8Ds7zv4fAqsKmvn6nSFkKiihX1G9CRl6QwFKt23xTECjef2goOQckfPvRE8DL9Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/5ROgL+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C4FC4CEEA
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739900676;
	bh=RB11C5xGhFwgwm3JpSBvxTXWC21mzKnqdvLNRh33Wx8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M/5ROgL+qOxDFybyNSGCvixbzBJYdMYiNQIym/rWaHMU9FhLRJpJhauAf1g1lbw/w
	 S2rtEc4Rl6yMXXSMbS6IxRCx/Faz6CCiWHBTV4qxoZSVornnSrqYNsLovjRQdqzJVP
	 /4TnJY3uGTOXaZSeobsDIto0lUysZA8s06TQikoACR/EgiIv2/lraNuKfI5+oef5Dk
	 Uo2wxngIpZSRrzYV66a7/ILYwvs3VLZPLfzNvxWhquCYfRxRF8cz24gNgAWs6E1aB3
	 Mv6icy9PH2PdZYMXUrntbMQ1ArMqoVg6ZVM36CvqNlPZC3WzovzXtbZ6xR0wmrkQ9p
	 S9RHBl4I9HAZw==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30613802a59so60684831fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:44:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUOMWA1z+pmm7kIAJDMET1kAtrji9sk1nngAtaZngD7eFV3vOZ/MjQqxvsxG/LPAvH2dosCbDwcV5IooXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKoVMNRHWhJMmmSvnIdJpNGEKJJ4EMIdyfZWMpJUZngEX/vcKJ
	UG/mo5KKOR97Olc9WaMKf0PDXI5bmm673qo+MnzpihjxWue7dDd3hqeTV3WWlcjEK9ro9V0rOMh
	a0z00RevUz6xcn5LluW13xpBSvA8=
X-Google-Smtp-Source: AGHT+IEFbAIf6N14a83BT0hoAGNketY8ZX2TJqyAbDa3rSAhABPHA+NXgwnKswcLPki4psTq9qIGOAts2fPtF5HRwjs=
X-Received: by 2002:a2e:7217:0:b0:309:277e:8c75 with SMTP id
 38308e7fff4ca-30a44dcbe2bmr954341fa.12.1739900674408; Tue, 18 Feb 2025
 09:44:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218092538.1903204-2-ardb+git@google.com> <20250218173827.vk4gplulq3pjdnn6@jpoimboe>
In-Reply-To: <20250218173827.vk4gplulq3pjdnn6@jpoimboe>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 18 Feb 2025 18:44:23 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHqS=fTOa13LHqs1bqxy-EeD0xNUGxJA4xK=bKya+XBwA@mail.gmail.com>
X-Gm-Features: AWEUYZmCX_aaP8gymx2-XRc5D7gKTb6-LxnRFM_D10ExjJRb_n15gixqpSDR_R8
Message-ID: <CAMj1kXHqS=fTOa13LHqs1bqxy-EeD0xNUGxJA4xK=bKya+XBwA@mail.gmail.com>
Subject: Re: [PATCH] objtool: Use idiomatic section name for relocatable
 rodata under PIE
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Feb 2025 at 18:38, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> On Tue, Feb 18, 2025 at 10:25:39AM +0100, Ard Biesheuvel wrote:
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index 91a7e824ed8b..337d3336e175 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -457,7 +457,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
> >       . = ALIGN((align));                                             \
> >       .rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {           \
> >               __start_rodata = .;                                     \
> > -             *(.rodata) *(.rodata.*) *(..rodata.*)                   \
> > +             *(.rodata) *(.rodata.*) *(.data.rel.ro*)                \
>
> If I understand correctly, this is fixing an existing bug in loongarch
> and any other arches using PIE, right?

There are no other arches using PIE as far as I know. But it indeed
fixes an oversight in how -fPIE is used in the kernel.

> And it has nothing to do with
> objtool?
>

That didn't stop you from taking the previous fix :-)

> If so, it feels like this needs to be its own patch, described as a fix.
>

Fair enough. But better to drop the previous patch from the objtool tree then.

> >               SCHED_DATA                                              \
> >               RO_AFTER_INIT_DATA      /* Read only after init */      \
> >               . = ALIGN(8);                                           \
> > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > index 3d013f1412e0..27024a128a6a 100644
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -110,7 +110,11 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> >  /* Unreachable code */
> >  #ifdef CONFIG_OBJTOOL
> >  /* Annotate a C jump table to allow objtool to follow the code flow */
> > -#define __annotate_jump_table __section("..rodata.c_jump_table")
> > +#ifndef __pie__
> > +#define __annotate_jump_table __section(".rodata.c_jump_table")
> > +#else
> > +#define __annotate_jump_table __section(".data.rel.ro.c_jump_table")
> > +#endif
>
> Why have two different section names, does .data.rel.ro.* not work for
> non-PIE?
>

Yeah, that is actually better, as long as we treat .data.rel.ro
consistently as .rodata.

