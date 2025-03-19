Return-Path: <linux-kernel+bounces-568608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2BAA69849
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207C119C265C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E0E20C480;
	Wed, 19 Mar 2025 18:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M7C8YYTX"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914E01B393D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742409957; cv=none; b=TIZmsgzZEInSJx1o2gGo6hmtYdxvsYT/ioGbQnxDDJ/EqclzFOxbOvK3KqAS8k4+bulE2aQDeOvOGr2gWLETIokX+Qe2t7dHYYYQGQoamOaD7qz3ipa2AWL9KjRPjHe0FI4Zt5SpS7FX4lJ9j/n74bobnYh6ThXcc45oo/GUraQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742409957; c=relaxed/simple;
	bh=UXiJSheHG32APdl3w7LPrJu9PqnU26FCXtZSCbxyCxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EosWDEnNSxZi3+UkzZOHykHmekhUcyqo7vmbE7edKVhnw5dXBy9yYXLXBsMRjrwZW6bW6l5ZJk8LNg+JMs9DS49YoUtpsJFuIOs+XH3qLHTU2lewQTbe3peeAMj/PPPxrbhmwjOra4S0jFMXDC2ZzzGtrzJBfEut5nV8eFuMmL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M7C8YYTX; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e789411187so2013a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742409954; x=1743014754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ecbEbpemCNUdOmyna3XYF3XUix1B1tTekXhoJuXd4A=;
        b=M7C8YYTXU6a80eZH3U4gi0RE2DHczUUU66dSb+RvGkEFuOtkQ7xpg2zBZhu59Fmv5V
         yfWRfXMlnBO14I3trOGw1y+24dK6TriCzOXgfB0nwPcsmmLa9IBFppS61xvmC93yeEGv
         8xC1okaT6eITJE1HYXQHTupOK5NCN2D7ffm+azr0SDenCrSIaTxbhmvPhvqBl9XESg+f
         zWSNWImJdwKrOHMjz1xYx2utg8SdksfJJAPVWXut/NOGxs0P7npexAfYhcvU56uWJ4sO
         xoam1pavAGGSZ0S4itiCZnI0wFfzESsfFUkGuao+TJMRHRPp4BxuGdojAxuVVsj6IhZr
         kbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742409954; x=1743014754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ecbEbpemCNUdOmyna3XYF3XUix1B1tTekXhoJuXd4A=;
        b=ClGH7Ey/LyAByFOaYc0V8CfFNW2J8jn/2EBWUWe1g2kvtzKITQdERVKtPc48PqBBfk
         LSlLKs5k4dj9HGwNa/i6aWUkhq93E5Asf3N/pRX/wSMzUOgZozzUjN3CYX8m3gMICMcb
         YcE2OFJwigBLFw5WZLO4eITOryOgjv5+XdX9HuEBYQ3e6yURWNeSQh+ksb7LOia8bkl3
         c4UfVwDoB0bjIIw4/fnGfy471mXgroMOCLgWt9OUf9chwfYkle05qlrmqSVIBl6MHdbK
         HGz88ePuyKuAIsfeEBcz3os2Y/BRsTfaIBn92DlJ4QDSCQGHEOGxaId/lubLdWzhF4p0
         29mg==
X-Forwarded-Encrypted: i=1; AJvYcCXELOaOleJOH2LawFEE9QamVhWUnFM6shdk7TLq7ZW3MljjTbWw82aneLjXiFOhNJf/dScXaC2h+yL+u60=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOX0R951ZhKjfUIUFZ7HbHf1uppgETVwSl5NXwzP/4l8QGwXLv
	vfqClMoYFP5xichFxupQgwoZ+mp5MhPJKGnPRHd7Znp/lE9Hd589xsE3iUQOuJAVy0Y5y/YW4Wi
	I07e87iod9vvVgt171o2zh06EHrvMLEM60PEP
X-Gm-Gg: ASbGncvlko7BJNuMr+5ESehRRRRnKUEx/JDA4+e78WXjB+Va0w9b+ywnvi+I4P1WING
	eUVyeIgnwYkN8Rh/Wr4xUW/CD1CUovxQ4OIvDoaJOQUJa9LXePIF5em0CXiWfiAZMZHvSQI7+8z
	PjOtBK83wrEiUQINqoaq9OvceUe8Jm85YeatUbHVkkMrbeqXtJCu7AMw==
X-Google-Smtp-Source: AGHT+IFQVFvJoLLYYGEpCQCrcpmJcgAjvu9lMlPw1Apq+b9AsPYUrSsWWyw8j004BwTFyagC58jmJdwZkqIXOfbzzQ0=
X-Received: by 2002:aa7:de95:0:b0:5eb:5d50:4fec with SMTP id
 4fb4d7f45d1cf-5eba06cb25cmr14678a12.0.1742409953588; Wed, 19 Mar 2025
 11:45:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67bab9f0.050a0220.bbfd1.000e.GAE@google.com> <CANp29Y6MOsEyXmR8Z_aA+3xQMQQFSWzsGfJUXohdeN6fG6EwRA@mail.gmail.com>
 <CAMj1kXH2JUWsxgd67+EHPgbo++OiGkx6TAu+8YcOcKjGR7ShRg@mail.gmail.com>
In-Reply-To: <CAMj1kXH2JUWsxgd67+EHPgbo++OiGkx6TAu+8YcOcKjGR7ShRg@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 19 Mar 2025 18:45:16 +0000
X-Gm-Features: AQ5f1JqU9r27v2sT_VaPIO6dFeriwVbCMWMTGjju9UQ4rRIs0sxTRsZw-3WZHqE
Message-ID: <CABCJKuednNrveGz6tQqHj7bbnVzLJFgCLt0CuZLT2KOvt8aNrg@mail.gmail.com>
Subject: Re: [syzbot] linux-next build error (20)
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Aleksandr Nogikh <nogikh@google.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	syzbot <syzbot+06fd1a3613c50d36129e@syzkaller.appspotmail.com>, brgerst@gmail.com, 
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com, 
	Dmitry Vyukov <dvyukov@google.com>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ard,

On Wed, Mar 19, 2025 at 8:38=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> The issue here is that we deliberately hide __ref_stack_chk_guard from
> the compiler, because Clang will otherwise generate incorrect code.
> [0]
>
> I managed to work around this issue using the hack below, but I'm not
> too familiar with the gendwarfksyms code, so I'll leave it up to Sami
> and Masahiro to decide whether this is the right approach before
> sending out a patch.
>
>
> --- a/arch/x86/include/asm/asm-prototypes.h
> +++ b/arch/x86/include/asm/asm-prototypes.h
> @@ -20,6 +20,7 @@
>  extern void cmpxchg8b_emu(void);
>  #endif
>
> -#if defined(__GENKSYMS__) && defined(CONFIG_STACKPROTECTOR)
> +#if (defined(__GENKSYMS__) || defined(__GENDWARFKSYMS__)) \
> +       && defined(CONFIG_STACKPROTECTOR)
>  extern unsigned long __ref_stack_chk_guard;
>  #endif
>
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -311,7 +311,8 @@
>  ifdef CONFIG_GENDWARFKSYMS
>  cmd_gensymtypes_S =3D                                                   =
 \
>         $(getasmexports) |                                              \
> -       $(CC) $(c_flags) -c -o $(@:.o=3D.gendwarfksyms.o) -xc -;         =
 \
> +       $(CC) -D__GENDWARFKSYMS__                                       \
> +               $(c_flags) -c -o $(@:.o=3D.gendwarfksyms.o) -xc -;       =
 \
>         $(call getexportsymbols,\1) |                                   \
>         $(gendwarfksyms) $(@:.o=3D.gendwarfksyms.o)
>  else

The patch looks reasonable to me. Thanks for figuring this out!

Sami

