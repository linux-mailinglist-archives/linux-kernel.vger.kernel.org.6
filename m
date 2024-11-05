Return-Path: <linux-kernel+bounces-395762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7345E9BC28C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 02:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CE942844A7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 01:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985E31C6BE;
	Tue,  5 Nov 2024 01:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccDSTEkf"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAE414287
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 01:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730770106; cv=none; b=Y/W7UK/kjZF4MkLbOZS/ffsIOygnTRoJo96CPTFTxiBR5BIuUEatGa5eJOzaOLRJXMNHvDmGNwE9b9ge2J6pU801+HCUbTtwMiUunY8PX0L5WojF3gFm2GXezI2UxCGO3g8hbaAqCgxeS4JmRQs1qH0uInGDqM+wqrNWTEsBeSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730770106; c=relaxed/simple;
	bh=Fk6qIV0s2WJyzY3NctHO9NywZieff7g3gNXR2mVMyCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emR/wiH6CV3CPUd/v6Qq0wF+fhm3jO/hfQPB+zKyTwLYLf41ZN0bGAOumxhe+1Wnf8fAC/KkNIm1VACqOWALiuBJRjh0y7oiUZx+w0JpKani9m9kYd4D22Yj7OsV0MjZVq/nVq0UKRPWwUrizYAwKwx9qsGru4ZdWqtO8X5GSyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccDSTEkf; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-50d4780a24eso1708496e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 17:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730770104; x=1731374904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9lG9v/L+g7cvpfj/8Aw1HwndNdBUrPfREGehXWjQnE=;
        b=ccDSTEkfN54lyqgjuSauXKq1iX/v0EaLIn8jus9+K486VD1IloXBdEXnHRlU05keb5
         pEsmHwR/JfvllLzgtc8YPRWoOwV4vmYH1+GM3EDL8Tzss2eqHdiKA4BLhoXdSh9NMZIR
         Sfae0WTPoeA8LzfmZu9Gx3QA9q3wHrk0f1dhVvVWrvRlOZaLEOeGlZbAF+WACvY5wGrq
         Kh8i39WNoFqbC7kMdYX8xrk0TlUIu+rF4xorDD8evmci01Oojztp7BLFMbN7YDJYZuwo
         Tx3HXWbWQfYf1S1TLCPRQLkbZAdCuarExHMflFvICqYH95M8eqVUpQY/NTRM66Dkbfx7
         oVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730770104; x=1731374904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9lG9v/L+g7cvpfj/8Aw1HwndNdBUrPfREGehXWjQnE=;
        b=t8wB8SXG4d6smujNEN9fV/qLbieJ5O1FOm28rkXIu8snxfyF+9Mpre/Eimfw7BvrwC
         TEFRyXt9DDiF4P6na7aD9A4HYQ3k3YUM7ykhvjPUo4HCtpIkUdlFuoTevqK+sX5cxtrq
         a9Q7pqnAlFnAxyT1s65b4jnhp+kauOrKAhI5OZIxFxPh2eLP9bNihIqh4osMucGEIGx4
         Y2Np7FKHK5y7w9X7tXtUu1NvLUdRBv0fpE/I26feGZHFH+A2AMSbwwsFMOJHXdhN4Yw6
         p5nRkgfmM6uVgtLwKwMFrhc68bm4Ij5TKX88ryWRdv61HqA12qC4mLDXhXUYiOYIgwTJ
         JdOA==
X-Forwarded-Encrypted: i=1; AJvYcCUwkTYNgfiJzFkuFvaiIBBkD/inHo9jylWT4lriW7SZjMjh1cbapj+2J2rFvqvbuLF3XWluWEWERVNJdGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNsugjQ7aJHR/xKnF02+cGslOffsXkviMUWq6Ldvd9ZZzmXoOC
	q5a4BEcMKh7vQbAzCAPulurapRCvqVQWyIqslTLGaccWUwjRc9tZpq7OoqoLFqvwz71daSttz6s
	RxTxjt7wA3WFTDFZXR3VHjngA3nk=
X-Google-Smtp-Source: AGHT+IHznrBUG+lmELMTQdGn40EXjdLWD+kI5R3L09EXnEk8rZ0luEoALD8Ff7X3L8nSvvUVLl/23RtcrgE9Y4N4dEw=
X-Received: by 2002:a05:6122:1793:b0:509:e7d:b7b2 with SMTP id
 71dfb90a1353d-512270ca7dbmr12294320e0c.2.1730770104049; Mon, 04 Nov 2024
 17:28:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102101240.35072-1-21cnbao@gmail.com> <c7a90ccf-c1b1-480c-9f2a-88ef37c3d89e@redhat.com>
 <20241104163402.GA810664@cmpxchg.org> <c9c5bea0-7542-4587-9d02-0dc25574c548@redhat.com>
 <3ac28c1a-44d4-4b10-966e-0907df716da0@gmail.com> <410abcf1-d43c-4368-b217-4ff894903440@redhat.com>
 <79deed1a-9b0e-42e0-be2f-f0c3ef5fee11@gmail.com>
In-Reply-To: <79deed1a-9b0e-42e0-be2f-f0c3ef5fee11@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 5 Nov 2024 14:28:13 +1300
Message-ID: <CAGsJ_4wVS79FUMVJLTo4HHSxoOK86mccycsqOzcvdDdjZBXy-Q@mail.gmail.com>
Subject: Re: [PATCH v2] mm: count zeromap read and set for swapout and swapin
To: Usama Arif <usamaarif642@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andi Kleen <ak@linux.intel.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Kairui Song <kasong@tencent.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, joshua.hahnjy@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 10:24=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 04/11/2024 20:56, David Hildenbrand wrote:
> > On 04.11.24 19:48, Usama Arif wrote:
> >>
> >>
> >> On 04/11/2024 17:10, David Hildenbrand wrote:
> >>> On 04.11.24 17:34, Johannes Weiner wrote:
> >>>> On Mon, Nov 04, 2024 at 01:42:08PM +0100, David Hildenbrand wrote:
> >>>>> On 02.11.24 11:12, Barry Song wrote:
> >>>>>> @@ -1599,6 +1599,16 @@ The following nested keys are defined.
> >>>>>>           pglazyfreed (npn)
> >>>>>>             Amount of reclaimed lazyfree pages
> >>>>>>     +      swpin_zero
> >>>>>> +        Number of pages moved into memory with zero content, mean=
ing no
> >>>>>> +        copy exists in the backend swapfile, allowing swap-in to =
avoid
> >>>>>> +        I/O read overhead.
> >>>>>> +
> >>>>>> +      swpout_zero
> >>>>>> +        Number of pages moved out of memory with zero content, me=
aning no
> >>>>>> +        copy is needed in the backend swapfile, allowing swap-out=
 to avoid
> >>>>>> +        I/O write overhead.
> >>>>>
> >>>>> Hm, can make it a bit clearer that this is a pure optimization and =
refer
> >>>>> to the other counters?
> >>>>>
> >>>>> swpin_zero
> >>>>>      Portion of "pswpin" pages for which I/O was optimized out
> >>>>>      because the page content was detected to be zero during swapou=
t.
> >>>>
> >>>> AFAICS the zeropages currently don't show up in pswpin/pswpout, so
> >>>> these are independent counters, not subsets.
> >>>
> >>> Ah. now I understand the problem. The whole "move out of memory" "mov=
e into memory" here is quite confusing TBH. We're not moving anything, we'r=
e optimizing out the move completely ... yes, you could call it compression=
 (below).
> >>>
> >>>>
> >>>> I'm leaning towards Barry's side on the fixes tag.
> >>>
> >>> I think the documentation when to use the Fixes: tag is pretty clear.
> >>>
> >>> Introducing new counters can hardly be considered a bugfix. Missing t=
o adjust some counters that *existing tools* would know/use might be  IMO (=
below).
> >>>
> >>>>   When zswap handled
> >>>> the same-filled pages, we would count them in zswpin/out. From a use=
r
> >>>> POV, especially one using zswap, the behavior didn't change, but the
> >>>> counts giving insight into this (potentially significant) VM activit=
y
> >>>> disappeared. This is arguably a regression.
> >>>>>> swpout_zero
> >>>>>      Portion of "pswout" pages for which I/O was optimized out
> >>>>>      because the page content was detected to be zero.
> >>>>
> >>>> Are we sure we want to commit to the "zero" in the name here? Until
> >>>> very recently, zswap optimized all same-filled pages. It's possible
> >>>> somebody might want to bring that back down the line.
> >>>
> >>> Agreed.
> >>>
> >>>>
> >>>> In reference to the above, I'd actually prefer putting them back int=
o
> >>>> zswpin/zswpout. Sure, they're not handled by zswap.c proper, but thi=
s
> >>>> is arguably just an implementation detail; from a user POV this is
> >>>> still just (a form of) compression in lieu of IO to the swap backend=
.
> >>>>
> >>>> IMO there is no need for coming up with a separate category. Just ad=
d
> >>>> them to zswpin/zswpout and remove the CONFIG_ZSWAP guards from them?
> >>>
> >>
> >> hmm, I actually don't like the idea of using zswpin/zswpout. Its a
> >> bit confusing if zswap is disabled and zswap counters are incrementing=
?
> >>
> >> Also, it means that when zswap is enabled, you won't be able to distin=
guish
> >> between zswap and zeropage optimization.
> >
> > Does it matter? Because in the past the same would have happened, no (b=
ack when this was done in zswap code)?
> >
>
> When it was in zswap code, there was zswap_same_filled_pages stat as well=
 to see
> how many zero-filled pages were part of zswap. (Not the same as counter, =
but you
> could still get a good idea about same filled page usage).
>
> The other thing is it affects zram as well..
>
> Maybe We could have a hybrid approach?
> i.e. have the zswpin/zswpout counter incremented at zero filled pages as =
suggested,
> but then also have a zero_swapped stat that tells how much of the zeromap=
 is
> currently set (similar to zswapped).

I still think we should keep zswap and zeromap separate. On a system
without zswap,
zero-page swap-in and swap-out are included in pswpin and pswpout counts.

Although zram has same_page_filled, it's still treated as a block
device after the
swap layer.

Thanks
Barry

