Return-Path: <linux-kernel+bounces-520001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6090A3A493
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56E417A4C04
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA1626B975;
	Tue, 18 Feb 2025 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECKrAZyw"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68F426FD9A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739900814; cv=none; b=VoipM6lw0xO5iUIZQ4ugYTwqbS3hc0DbX24T1myCC9oM4oA5titfNjYQBkX0MRySV6OB2hiAgL0GmnwtV/Wm1w2g3taKQje49g4n+ZWq5ZHVcjWc+Da3U+nwzD9w6WLpTvYVkuqmTCV1NFufzCkNeeJhQAnde02LOeY8+A6fNEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739900814; c=relaxed/simple;
	bh=01veb3WVsnrXHj1g4e7rs6tNbuB2calOUzLSaBzzHFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFMnm7AujUiq0HbzF+bQlk7fYCFP6TTR3zTSYTLdrfOnsLd0lF/bX4HqldR/zoABseIJ7zmrsbivGhlapTjxzDAAoYbqDLkU04gUbfEjWUkLFJXS89Oa9OSXkVu1/9BBpGFZGO2p3DXxy0kMkha1QJp2V0/2qG0YFvHbtUDKYiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECKrAZyw; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30613802a6bso60051551fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739900811; x=1740505611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEsRMKBz47Xbn7YaHFg5r7eTHGgr4YkUOdLi5Xasyi8=;
        b=ECKrAZywrPtIhp+dMTnCphBmBR/GJli6gET+1DNg7p+3WChF62E2kHC1mC1YzJ0jte
         zT5ohNd3wCYf+69vsPUeaGGUKP8TU7E7ajssu29eAp5TnlbTCHA2nMf2XG6kfwwI9CoC
         WMxrkG2UowcFjAbn1+ZGLEPSKElJWq+GhoVJ1Lx+AyB2QzrQ9yqFY69eMy2s4KIk6NJq
         yht5EbPosfei36FKfmucLhDFu3aAoAaTov+I6Lv1jTkEB2gGhR44vY40NQnZ50cbnp6R
         hNA8vvm0uDQYOI9l5JNUkdfQEzOHIVaIFNzYQjIDL4I6gt/zgfT8uTugIiHJWCIxrH+n
         8N4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739900811; x=1740505611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEsRMKBz47Xbn7YaHFg5r7eTHGgr4YkUOdLi5Xasyi8=;
        b=qFL0HxXbO4OsCI6xLgS6fbLE9Se6IscSgMKyw7JZN7M7mAHqAIVOWGkZfOHPt7u17x
         fxzleVkfSPAR/wP7ymUOEB0/YP5NUvNHX/z1mIYdu0QBpNy3IAhLJYUKQ36ewIihB2yo
         dlEnj7nohgNWn0xisY93lRUgcc7ue4gJMULzDhn6K58Lq0NkhIqYbCoSXwVpIxt9d31q
         +aCGH5Bvbak1+A9LUNLSQzcntwLfJY9G728fNi+5J9Gf4THG+krr6nVw67VU53QxQduB
         dCFB4eNIvjQaV2t83L6l0fSgSYgkBvIQPjQ6WogbKJkOa9lYYwkRVqUDrLcHNnw3VbdX
         fS5w==
X-Forwarded-Encrypted: i=1; AJvYcCVqwojYtqG8w6FmgadxHk/YhGRO5748eg2s57XyOXDpgXUvklOBxTG3ZuhYufQIVOZDTCLxc6R5ruxPIwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9zytRIPCg9FzaGu0I80dCQpuc1yf/V15LJ0W2a5KrvHohAuHY
	OE9Cz6gPyn/joDIRgy9SdK6TuplRYf0wvSE5l4riQnf8spFo2EBBMkqWyHXm2I4zY65/uLx4MNk
	IGUZ14yhyyCcaJwgmZzRxvVVG4mY=
X-Gm-Gg: ASbGncvjyIC4nG5JSZcGcDwDorTDblLWhjRbVng+RHzMQLHvxVG16IdXlwxA30ufVXM
	JvXQmjjhqLSKhqYQrfjHMBcq42ZDl7YUZ/AvzEM3jgwX+tseS5yQAQPwLtGcCKCX9i4kxa93g
X-Google-Smtp-Source: AGHT+IE2hkZE4OsUK2pDrlvu4Qf1GWZaq6Ndq1ZKN/ajoKEbdVfxpjXx2j5I1USDmFME5hqc/EF0Qb4Wkd0a48owpF4=
X-Received: by 2002:a2e:80d8:0:b0:308:f479:5684 with SMTP id
 38308e7fff4ca-30927a59cf0mr46910811fa.17.1739900810733; Tue, 18 Feb 2025
 09:46:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123190747.745588-1-brgerst@gmail.com> <Z7RRZ0jdqsrADMm0@gmail.com>
In-Reply-To: <Z7RRZ0jdqsrADMm0@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Tue, 18 Feb 2025 18:46:38 +0100
X-Gm-Features: AWEUYZkjBiBNV_M7qA0mCdEneKyyFTuA7zX8Ad611LRTbqyvooI_Lr02ppDp_Ms
Message-ID: <CAFULd4Z_QoOLKCOawyeFtRe6V4+oaaGxfQxav9dS-Di-Ne7tfw@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] x86-64: Stack protector and percpu improvements
To: Ingo Molnar <mingo@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 10:22=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wro=
te:
>
>
> * Brian Gerst <brgerst@gmail.com> wrote:
>
> > Currently, x86-64 uses an unusual percpu layout, where the percpu secti=
on
> > is linked at absolute address 0.  The reason behind this is that older =
GCC
> > versions placed the stack protector (if enabled) at a fixed offset from=
 the
> > GS segment base.  Since the GS segement is also used for percpu variabl=
es,
> > this forced the current layout.
> >
> > GCC since version 8.1 supports a configurable location for the stack
> > protector value, which allows removal of the restriction on how the per=
cpu
> > section is linked.  This allows the percpu section to be linked normall=
y,
> > like other architectures.  In turn, this allows removal of code that wa=
s
> > needed to support the zero-based percpu section.
> >
> > v6:
> > - Rebased to current tip tree
> > - Dropped patches already applied
> > - Fixed typos in commit messages
> > - Added Reviewed-by tags
> >
> > Ard Biesheuvel (1):
> >   x86/module: Deal with GOT based stack cookie load on Clang < 17
> >
> > Brian Gerst (14):
> >   x86: Raise minimum GCC version to 8.1
> >   x86/stackprotector: Remove stack protector test scripts
> >   x86/boot: Disable stack protector for early boot code
> >   x86/pvh: Use fixed_percpu_data for early boot GSBASE
> >   x86/relocs: Handle R_X86_64_REX_GOTPCRELX relocations
> >   x86/stackprotector/64: Convert to normal percpu variable
> >   x86/percpu/64: Use relative percpu offsets
> >   x86/percpu/64: Remove fixed_percpu_data
> >   x86/boot/64: Remove inverse relocations
> >   x86/percpu/64: Remove INIT_PER_CPU macros
> >   percpu: Remove PER_CPU_FIRST_SECTION
> >   percpu: Remove PERCPU_VADDR()
> >   percpu: Remove __per_cpu_load
> >   kallsyms: Remove KALLSYMS_ABSOLUTE_PERCPU
>
> >  33 files changed, 100 insertions(+), 475 deletions(-)
> >  delete mode 100755 scripts/gcc-x86_32-has-stack-protector.sh
> >  delete mode 100755 scripts/gcc-x86_64-has-stack-protector.sh
>
> Thank you for doing this series - it all looks pretty good from my side
> and I've applied it experimentally to tip:x86/asm. I fixed up the trivial
> details other reviewers and me noticed.
>
> Note that the merge is tentative, it might still need a rebase if some
> fundamental problem comes up - but let's see how testing goes in -next.

I wonder if there would be any benefit if stack canary is put into
struct pcpu_hot?

Uros.

