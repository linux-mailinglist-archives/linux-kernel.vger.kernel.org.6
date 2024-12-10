Return-Path: <linux-kernel+bounces-439874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A34F09EB54B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB01E1886550
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0D9207DF9;
	Tue, 10 Dec 2024 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAs1V3PE"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F81205513
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733845438; cv=none; b=i8Xer9KIaUMstTRIj5J5WtkcKBMT3UzJMFySCgs4aUhOPJV1UfsWvvDPqI1tdDWQOzAD3Ztv2hEXtQq9vCNM3obMkjAFGEx8SCxPNjWi09WfJ/3qwwYFC9S6K/ysmleexvGyrhz9TLxhNjGbLhXq6IYz8DtwwRIYQ+PBaNtB5ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733845438; c=relaxed/simple;
	bh=d4hi2SFZO6/riEVq4YlP0Uu3SdbmWPpl2VGnw8JR7J8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPEitm4ig5KjinZqKRUyYICI5XNQBN98kIUWVID4wICU78O/xO3TwvqNFftO4cjTKnObPHYm/eRgHGCmdde9ahsoNFb77b3x8N/FBSKZqIpp1mz3+cZTWpDuXsaNDiNnILy6YHBzUKGtcAUG7cekFAC5DQLXcjcuR7z3vSCV994=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAs1V3PE; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so4288066a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733845435; x=1734450235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZxeUd2FHjEGxYacDz2lD5/YSoJF1/uHShnQKwGuSgs=;
        b=JAs1V3PE4roXIJ2MWRxDu9cVBHop2MIZxhCaxRWv4cGx3WAahrDvcvnpaIr3jba5vT
         RYcHhNjOxdfZc2yet6mAkSFzIZdQakyKW+uPw+Krw4QW4GTNbH/T0GEclYkPkiD1G+cd
         BftKlxRO3QLb9nqvP03eAWr4/KtKnDC1+xNIrDFQsdcDKlKM/9bUMv4tj0dS0MX8Hh0j
         pFD5oALEsqBsBUra9xrrxntfY5oVUY13s9DScA6s8OModRMokoSo69dyVAV7AMQtfcii
         HegVyvVuWf9imHDRzF5ALDuvVp0TqsZ/PQY2MKfBhriJVHMR8Egd2UFF8lHoXqAn+Sn2
         tmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733845435; x=1734450235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZxeUd2FHjEGxYacDz2lD5/YSoJF1/uHShnQKwGuSgs=;
        b=sESKFzrHrbjczdtIvkAm3RNrmDpSwsqHnvOV7XSqSh9Y+Nh36FHjxSO6wyDFXHjMMU
         NrFsFHMlDK9pIpEkJfmjCBZvwWfcfq6yK/IA0rfueLJis7vpc8k5QO1TjCfw4kZH3keI
         f+Px+COx/2k6NwZU4zqzn2dGZu3+d0FHgfIUfAxsVkzruvAS0o2qUoL9wv4b67rLl8P1
         w1/oJhv0AfOeMxb56tKA3BXqQ1pPXnEhwN98PSv5x55wZ3o1rs0vQrCLt1L+LdKxVJle
         DwdOIeSkxOKRz7INLmOmjlR0uYoZscP1xzyotkWwamaTwfu5iKjkxy8y6+1xvHiFcMgY
         9RMw==
X-Gm-Message-State: AOJu0YwwXlxRtT+0LvaW+SmuE+7zQPQiRtcBfejSKuUJq2nc3uu5sQ1T
	hh/qS6Hxg9vGDN5V0FY41GopvVClqnYqk2XRSlAl+tkW8E9m9CrhUq7MONdWS6wOdTJggH1SM2k
	pHnrC/IveEOnZ3nIptcXjPcA83N5S7qds
X-Gm-Gg: ASbGnct2/dcKepWWr9LLIG4d1HYIS3hKKbTT5yyaS1juMi8V1o8NrnSDBo2mXO6yCCW
	e/amY9LYf9u6mw06ibL9eXdgUPAuAYg8m5wY=
X-Google-Smtp-Source: AGHT+IFTBamf3To05Crb4F7uz7oMNU41iQchZssi2L8lICW3owVTYqK1rutvR6C5g4cNqtsz1t1RK2eF55Z38Ynqjko=
X-Received: by 2002:a17:906:3d32:b0:aa6:50ee:d44c with SMTP id
 a640c23a62f3a-aa6a01c0cc5mr388285666b.15.1733845434894; Tue, 10 Dec 2024
 07:43:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210144945.2325330-1-arnd@kernel.org>
In-Reply-To: <20241210144945.2325330-1-arnd@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 10 Dec 2024 17:43:18 +0200
Message-ID: <CAHp75VcBV9KyRsgKkB1Y=vmQhxYw2jy4UnBLHH4Sa8dnNwQwGA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] x86: 32-bit cleanups
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 4:49=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> [sorry for sending a duplicate series, I just noticed I had
>  dropped lkml from cc when I sent this a few minutes ago]
>
> While looking at 32-bit arm cleanups, I came across some related topics
> on x86 and ended up making a series for those as well.
>
> Primarily this is about running 32-bit kernels on 64-bit hardware,
> which usually works but should probably be discouraged more clearly by
> only providing support for features that are used on real 32-bit hardware=
:
>
> I found only a few 2003-era high-end servers (HP DL740 and DL760 G2)
> that were the only possible remaining uses of HIGHMEM64G and BIGSMP after
> the removal of 32-bit NUMA machines in 2014. Similary, there is only

Similarly

> one generation of hardware with support for VT-x.  All these features
> can be removed without hurting users.
>
> In the CPU selection, building a 32-bit kernel optimized for AMD K8
> or Intel Core2 is anachronistic, so instead only 32-bit CPU types need
> to be offered as optimization targets. The "generic" target on 64-bit
> turned out to be slightly broken, so I included a fix for that as well.

...

>   x86: document X86_INTEL_MID as 64-bit-only

Acked-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

