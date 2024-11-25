Return-Path: <linux-kernel+bounces-420720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 853CE9D828A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24CFD1634E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397E21A76CC;
	Mon, 25 Nov 2024 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LC1WsC7v"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194991922ED
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732527310; cv=none; b=AvxxYSE0f7F5Eu7Lboxs23GFm1346IQL+qwkrwMa3GLDB64qldIALKNBn0Lx/6VXLE9zueuJLIWP1gtAix+e5DFadKUfZJWQQLWYZ7srHc4JlJ0HARPCd7wPO4QF31YsDTr8m19orw7S7yiNBzbxgCScNCoqrJB90H76zuLu+1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732527310; c=relaxed/simple;
	bh=jaT2gMZATI1cr2w+kBtCP6nseVsxavYfNusYFbNNQeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tDeI9Lhcjom8sQrhST0yL6lT0XcOmlgOQPxdI5V8TdFMrPbypgNmOuhDrJWXzQgtJYcBiPWbN3mML4vKuIiIVNdgZN+Cw9xTfkiLrVhn6gAvYFV6tl2CjQCHhBldOVEe0MSf9VZoC17CzgqPzWyOV5Jvoo/WcpkkQSWHDe3J44w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LC1WsC7v; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cfc264b8b6so8387a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 01:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732527307; x=1733132107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaT2gMZATI1cr2w+kBtCP6nseVsxavYfNusYFbNNQeg=;
        b=LC1WsC7vumtgFuP6Cv9Yu8t1TMXoT6wbw7rxEaaVq1teHsOm9l3az9HUMRmSSAdcec
         yGGQYM9bs7ELHgZjkSenvYVkcgsujwFxZaAaQgSG9lBayHhlLlNeppF2JGZt4cejK3nG
         Jw5aCvZlATCCXiBaxqR6b5PgzxAvesl8zL1hFKrlb6Fo6Ct7D02KGPLvdRxF8lgbRpDo
         C8/JN1PSpOH/1DnolDcNNCiGqYWJ1hsYWQ/nF7AvTTeTfsMfQmB/Uc6ijDsKuzoHD0HI
         YdWH2XAvRWL7n7nA0mqzMwvL1F9/Al2BL10ifZC4zoJZlSSavarFEB1prweZYn16pu3u
         gcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732527307; x=1733132107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaT2gMZATI1cr2w+kBtCP6nseVsxavYfNusYFbNNQeg=;
        b=oap56OIFSQznIL9Z3KCUQHkdWazpMpE3N647JQWlXhg3lhC35gajAgxE8LvY1wh1bv
         LNXHzfLkKj43+Xov+ZFAW2lNZZgzBlcOmVd3IVUGV9Vp0esx/HasZeUX/fk49o9Dc4j3
         g/GEDtPfpMQOV7OZ55ZG+7dfrOMDV0tgkHdvZyUCWFJV+UbrQ9R3hqmv4t9NtMa+k9QE
         AEyTFPsJWP5pda9t1+BVyDO7tJp2PSDT1sozvEWemnzkl3ZM3EtcWRyMVt2vPpOXpnNh
         9/i2G5YT6JEt/VwHZwkA6W2lUjbQnKwUlE0bkG3aghvM7/4sQyok10/Aq9txBWgUVUSj
         gLIg==
X-Forwarded-Encrypted: i=1; AJvYcCXCM7q73X2NaOyg7E+6JMTvMEAubvQ4o8u7Ws/yxYpVeYo92vAlMfp7uO3pbFGvWjg1Fb83ln+6E05p6mA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfP/oZLD/x2f6GXgdtGkBsnNp3PgtSKSOkji8AztFdIvu0CxJ1
	B1m8XwyRvPEJdyvzazCJdA8K1SEos/EK43bk6S2YSzUFeOdTPhqim3gkxWElL6gyElk4dVQ4zXX
	953gUJRFiC8BuCr1618RGxX2aJJ/fQCM3wmZm
X-Gm-Gg: ASbGncvBtasLnAWC/bfYjN5UDrjeV/rJnL1LK44+FwVg/gr4lo6UHJjoZeky6YwXyui
	7/2fyYL0vfyCvqocTogqTiPp7hU2AyyKq
X-Google-Smtp-Source: AGHT+IGTmrlfZpaacQIL7m1sVBbpke3zA30uDeHjmOTDx5UHOJssl129/RankrUjb/fulgjiVDxdQ2FhiBHkvVnjtVM=
X-Received: by 2002:aa7:ce09:0:b0:5d0:3ddd:c773 with SMTP id
 4fb4d7f45d1cf-5d03dddc84bmr69002a12.4.1732527307223; Mon, 25 Nov 2024
 01:35:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121204220.2378181-20-samitolvanen@google.com>
 <CA+icZUX-gf8624z8u+h-W8KeddCruYDng-4vTggNGwC61NzfNA@mail.gmail.com> <CA+icZUWSKygQJNiODzdauNiHz2Di-2eSGGmd-fgBrFpdyh_HgA@mail.gmail.com>
In-Reply-To: <CA+icZUWSKygQJNiODzdauNiHz2Di-2eSGGmd-fgBrFpdyh_HgA@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Mon, 25 Nov 2024 11:34:30 +0200
Message-ID: <CABCJKudwpKX1_j46Tp6=eAJ0JU2zWE15+c8OFq9LMAnSqwesOw@mail.gmail.com>
Subject: Re: [PATCH v6 00/18] Implement DWARF modversions
To: sedat.dilek@gmail.com
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>, 
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Miroslav Benes <mbenes@suse.cz>, 
	Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 23, 2024 at 1:23=E2=80=AFPM Sedat Dilek <sedat.dilek@gmail.com>=
 wrote:
>
> > BTW, I am testing with the latest kmod-git and pahole-git.
> >
> > I will give this a try when Linux v6.12.1 is released.
> >
>
> I have a prolonged build-time of +22,75 per cent.
> Compared gendwarfksyms-v5 + Linux-v6.12.0 VS. gendwarfksyms-v6 + Linux-v6=
.12.1
>
> Is this a known issue?

In my tests, compared to a genksyms defconfig build with debugging
information, v5 was slightly faster, and v6 was 5.6% slower. This is
because the expansion limits were dropped in this version to ensure
version stability when exports are removed. See the explanation here:

https://lore.kernel.org/linux-modules/20241120215454.GA3512979@google.com/

I did profile this quickly and most of the time seems to be spent in
libdw looking up attributes. We might be able to speed this up by
limiting the number of attributes we look up depending on the DIE
type, but I haven't had time to look into it yet. I'll take a closer
look when I'm back from my vacation in about three weeks.

Sami

