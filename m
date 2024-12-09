Return-Path: <linux-kernel+bounces-437515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1459E944B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395631887E51
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AC8224893;
	Mon,  9 Dec 2024 12:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J08g3rdj"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214632236EF
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747628; cv=none; b=aK+JkWT7wHGI6w9J1cNR/vrqUacJ9VK05eay73iMm9hgmSj//szM2wpfYODsgLql+3W1z5ejoRyF3SUMZzuFllhtMDrvwDN2jNGsSmUXJ8LTNnyMuz4qmE1VijR6QaHoIUemFNBwNswOjkm4XmU3f2UB1JHHTN5LTuYe0qv79Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747628; c=relaxed/simple;
	bh=lg9r4oT0lo3KngBxJqPIseRfkXlNopePHOk27wupgOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDh7O6i7q/PMiGrGncnXiYB/KGg9gxGFGUpE9tLXBW9NeyAvfBoAQjTg/12aPh9ecZy7kyW9AJZretpgHpOAQht+H46rb0S479lcT2SBQ5/CtmXWcOd7iM00IrOx2ar/V9gxeFUnyXJch2n48Uuq/TeJuBshoHwHmewp0HobAwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J08g3rdj; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3e829ff44so2907257a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 04:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733747625; x=1734352425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2pvDmHMFpKjNXtOvcnN8HckneEUA9P81c6+aivOyhU=;
        b=J08g3rdjQAe0hVD3xFoAPFR6PtzpbR+VU4MdM6/qtaqmQ0ZIRNzTBK+KAGm3vAA+Cb
         SM8mbNA1u9aTbpDBNbbjlHNzEtfN11DQtiFluZzJZf6NQKtX+dr5XauiLzm86VA/ozif
         OEK4qULhu184cR6CmGKv1U2xc7jEW5r0+P5AvljnOfekH6Mp055pI4OJDt0fGrsy6rA1
         hrxglLNaWzAUrf9mvcT9nB/AdxxN6irCtBxn5L0ISgMG7PVCZFQP6bFcKARC+HVvfkPY
         kGYY0qWtktAnOlH2NmU4DKCD9Szqx7zyiPDw5+JftCS0toOy9Kkh1dlABFfamySlmm5D
         eAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733747625; x=1734352425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2pvDmHMFpKjNXtOvcnN8HckneEUA9P81c6+aivOyhU=;
        b=YIfhPtqthC3Qnl6FPoKagiSw1ZWlvfiee3v/HKKxSfDWPygC9PP0Uf0zvZgs2dOrsW
         K9EjUewMutmZPwZCJX5pqbwhTd9t+PiQlFYFKJGRv40lJEpXOCaqFyo6jQnK2DShnqJB
         kd+b4Z30wE28cGBEmFzXcGv6L3Aw4MVj8SWiPVrBQFccdjTbi7dbjlZYanD4VACtM4EE
         BFPX9pnPt7G41CXTFyMkr12slnPuAN9fmDWURjRQzbvcvmFL1ySlUm9z5to0Ly8MAaBV
         La0KSRtX6kuP2Hc6KHy6oX/Bnq4t6GdzOi2tjjA8kujP89cy8GxuJueiYpEbVki4DdNl
         y8NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWihcPL7zGNvlWjgEk4i3PlAH9jWljmgdIBZVCpZgBL6d8X9N7r0ZSlVX1mnrDkVvtqrYFpzqGGu9b6dGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+H7CIpLySp3l5V8Ew5QS2f7xAAvfZCvhnT5qQCoOkeRXZ4qxF
	ApIF+FM0Uw0fzTelaqmxwC9BpuqX9a9uVhGXnfgnwduaA5Ok9vDDCxxERZ8xPsOxjKVUxL7rFTV
	afxEVa7mmPIwYps8WS6yM4wkWxgM=
X-Gm-Gg: ASbGnctgkylE1q8CJmb6OgXZLx9MfdKbLUtlVYeKoTwQpxotQEG0bZSG/KMynyaqRPW
	l2CwfyCHGDTp3o+we7bmYfit5KS7vIhU=
X-Google-Smtp-Source: AGHT+IHxoRAINPLiegG4e8RLcEdgpBzrsZZYp/8i82FH8iLwYGPbSBJnSWpvJJbzOY68RyzzLQK0MMijVUlkBibGDl4=
X-Received: by 2002:a17:907:2da5:b0:aa6:9346:6a76 with SMTP id
 a640c23a62f3a-aa69346bf30mr150837966b.22.1733747625063; Mon, 09 Dec 2024
 04:33:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241207082931.1707465-1-mjguzik@gmail.com> <94d0dcbe-2001-4a9c-a767-b337b688b616@redhat.com>
 <CAGudoHEggB=F9j7r+ndQs1WxpRWB4O5VdBo+PLx+yd1xrj4-Ew@mail.gmail.com> <606fbf9a-c9ba-4f08-a708-db38fe6065ce@redhat.com>
In-Reply-To: <606fbf9a-c9ba-4f08-a708-db38fe6065ce@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 9 Dec 2024 13:33:33 +0100
Message-ID: <CAGudoHFLTet0ZpOkDMFBh0yBDhJ47st-aRrCLZojdrCgQKznUQ@mail.gmail.com>
Subject: Re: [PATCH] mm: remove an avoidable load of page refcount in page_ref_add_unless
To: David Hildenbrand <david@redhat.com>
Cc: yuzhao@google.com, akpm@linux-foundation.org, willy@infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 11:56=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 09.12.24 11:25, Mateusz Guzik wrote:
> > On Mon, Dec 9, 2024 at 10:28=E2=80=AFAM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 07.12.24 09:29, Mateusz Guzik wrote:
> >>> Explicitly pre-checking the count adds nothing as atomic_add_unless
> >>> starts with doing the same thing. iow no functional changes.
> >>
> >> I recall that we added that check because with the hugetlb vmemmap
> >> optimization, some of the tail pages we don't ever expect to be modifi=
ed
> >>    (because they are fake-duplicated) might be mapped R/O.
> >>
> >> If the arch implementation of atomic_add_unless() would trigger an
> >> unconditional write fault, we'd be in trouble. That would likely only =
be
> >> the case if the arch provides a dedicate instruction.
> >>
> >> atomic_add_unless()->raw_atomic_add_unless()
> >>
> >> Nobody currently defines arch_atomic_add_unless().
> >>
> >> raw_atomic_fetch_add_unless()->arch_atomic_fetch_add_unless() is defin=
ed
> >> on some architectures.
> >>
> >> I scanned some of the inline-asm, and I think most of them perform a
> >> check first.
> >>
> >
> > Huh.
> >
> > Some arch triggering a write fault despite not changing the value is
> > not something I thought about. Sounds pretty broken to me if any arch
> > was to do it, but then stranger things did happen.
>
> Yeah, it really depends on what the architecture defines. For example,
> on s390x for "COMPARE AND SWAP" the spec states something like
>
[snip]

Well in this context you need to do the initial load to even know what
to CAS with, unless you want to blindly do it hoping to get lucky,
which I'm assuming no arch is doing.

Granted, if there was an architecture which had an actual "cas unless
the value is x" then this would not hold, but I don't know of any.
[such an extension would be most welcome fwiw]

Assuming you indeed want the patch after all, can you sort out adding
a comment to atomic_add_unless yourself? ;) I presume you know the
right people and whatnot, so this would cut down on back and forth.

That is to say I think this thread just about exhausted the time
warranted by this patch. No hard feelz if it gets dropped, but then I
do strongly suggest adding a justification to the extra load.

Cheers,
--=20
Mateusz Guzik <mjguzik gmail.com>

