Return-Path: <linux-kernel+bounces-242783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A1F928D1F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 19:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B461C2217A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 17:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D42416C42C;
	Fri,  5 Jul 2024 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QOiAspFb"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E0FA955
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720201211; cv=none; b=FLzjsHVshUuAmGaobd7phwF0YgwK9KKaV591XpoTYJ5szUGMaCzjeYNhu5Cfx0g8dcLTZKaTi0qCOW3x75rjJaoqYY76+HO43vCuQcOHJRFvv7LoPtdOmI9AN+GDTZx7jQ0543Wi2E1QufNyHdlilEcJbn2U+6h0RK36wQzNFAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720201211; c=relaxed/simple;
	bh=iiEikNZYbb8ZldJJ+mVB6IFq8+89XDJ/uaZP/7G6Y/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dAFx0DKzEjE1JesJuwijOT8KrhTErV1jvd62PqFKFbC5QLL2POSbP4yzxI/XFRpSBRUo2ohZCs+DHEXNS1gVHi5/EoLbjVNoi8qL6HPLiNplY3w7dy+Q88pMmT9jiRn7DtWoq0+KNIZxGNEKi/flMcJOmDbhiheBBFgXCVQDczc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QOiAspFb; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4f2ee99e2d0so583999e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 10:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720201208; x=1720806008; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LPJ0n42QIeccvnIZAc2xDP7fmD0L91wk2KmnW5GY1qk=;
        b=QOiAspFbDSydlGyI52ICiwx3Gpb/yYTBQzwcdc05P98BULYZ0D8G+0JTtmmZaUbZSN
         QfQSFX4Sr2B8G/JS2Xq6Z2SRtXwO03glUWdsx2eAZqKpXfjPy8iPKbCpkcWUSj8n33Gd
         DMeKEV+7VmSKePriXq/h/XMr+Pht2+44lfQno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720201208; x=1720806008;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPJ0n42QIeccvnIZAc2xDP7fmD0L91wk2KmnW5GY1qk=;
        b=CZ11eyINaUAGYNueBIldVaBtguZo9RJvB079Rgu4MDa+pr2r/ieqTm+My4q8hqV5Xr
         P7+w7XcNAyDwfNt4wQJ7FkHz/Cz92sGj37xO/k2KOJgGkEfy+MbvVJJ6jpEDzCE06i8k
         YBzclNzbi57wybeV5bkZ9Xsdy6zMqJA8VbRmBpYdLfAj4lVc0oX3ufBlG3UjkTBm9A5R
         UOFGqaUa3ZjNPowXp/pZbi/Uv9p2Z28SSvQVjS3JKOOJNJkDTFa8dOP0hKy1FEervbvX
         TF7i0cdoMrtLNEXeUiTWwHvc+rmo8kwCjZ4Ck9w7m9gHOrrU6olJdGr3Ij9rZbm2J9DA
         6D2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDJXJfHmZInMnJcw3dFrZ7YkF2mkj/QTW0Ck71CfsFN1q6dz1TvhViW/eUJBuKm27cYRu6OKvoyZQapv5c/IYOeDHrvQGPa0RZNrtR
X-Gm-Message-State: AOJu0YwFUgln3jBJ57JwsQWTc6haZnCYc1xQzEDrNPLUKfDydOeHN2pm
	MeoM9hOC5cQByySPyzzBlZwTwLBJ0hNOaGsH9Sx1UNx4kjp49/8qu62wAnmwBRhqKhsjYjUYfIE
	srSML5w==
X-Google-Smtp-Source: AGHT+IE3sT+65gSw/jY3pV504D9k6qA5H+2JoiT3bHyFTm72LCLkt6HWibkx2XSLL9awz6WxkWsqDw==
X-Received: by 2002:a05:6122:4710:b0:4df:261c:fc0c with SMTP id 71dfb90a1353d-4f2f3f93b8dmr5072785e0c.13.1720201207737;
        Fri, 05 Jul 2024 10:40:07 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f2db263a09sm796961e0c.42.2024.07.05.10.40.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 10:40:06 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4ef765e6dcaso583640e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 10:40:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXC2/So3wQNJCHRjp4/+xRpI5YEAPBhwH6+j9qxgyR0uuyaDENoKWRFjCgCAVlQlEjSfstugVf8LoHiz4IWOFB+ELrQa+pDVAweLNPN
X-Received: by 2002:a05:6122:4b18:b0:4ec:f7d0:e71c with SMTP id
 71dfb90a1353d-4f2f3e5f987mr5137773e0c.4.1720201206311; Fri, 05 Jul 2024
 10:40:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zobf3fZOuvOJOGPN@zx2c4.com> <CAHk-=whf2Pb8fSmUsLRSn6CnYvQoyUkLikKpFDWN_xnTJqix=A@mail.gmail.com>
 <CAHmME9pm+ZE2_qf1DNxukB6ufPrjTAsnwin05-VX_gS03Yq-ag@mail.gmail.com>
 <CAHk-=whTjdO6szgRKp51ZeDLDmA1+YYSbg+vEUt9OsxTMDUtjQ@mail.gmail.com>
 <CAHk-=wgqD9h0Eb-n94ZEuK9SugnkczXvX497X=OdACVEhsw5xQ@mail.gmail.com>
 <Zobt_M91PEnVobML@zx2c4.com> <CAHk-=wh47WSNQYuSWqdu_8XeRzfpWbozzTDL6KtkGbSmLrWU4g@mail.gmail.com>
 <CAHmME9pgFXhSdWpTwt_x51pFu2Qm878dhcQjG9WhPXV_XFXm9w@mail.gmail.com>
 <CAHk-=wjCmw1L42W-o=pW7_i=nJK5r0_HFQTWD_agKWGt4hE7JQ@mail.gmail.com>
 <CAHk-=win2mesMNEfL-KZQ_jk1YH8N8dL9r=7XOLp28_WMazpVg@mail.gmail.com> <ZogcxjLv3NAeQYvA@zx2c4.com>
In-Reply-To: <ZogcxjLv3NAeQYvA@zx2c4.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Jul 2024 10:39:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=whRpLyY+U9mkKo8O=2_BXNk=7sjYeObzFr3fGi0KLjLJw@mail.gmail.com>
Message-ID: <CAHk-=whRpLyY+U9mkKo8O=2_BXNk=7sjYeObzFr3fGi0KLjLJw@mail.gmail.com>
Subject: Re: deconflicting new syscall numbers for 6.11
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: jolsa@kernel.org, mhiramat@kernel.org, cgzones@googlemail.com, 
	brauner@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jul 2024 at 09:18, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> VM_DROPPABLE *is* actually a very useful feature. Or it at least seems
> like it could be one.

Yes. It's been discussed exactly in that "this _could_ be very useful"
sense, although we've never actually pulled the trigger.

I tried to find previous discussions on lore, but failed miserably, so
I can't point to previous discussions from long ago, but one question
was also always about whether you wanted some explicit "populate this
page range" interface together with getting a SIGBUS when it's
unpopulated (so that you can basically do demand-paging in user
space).

With just a "this could be useful" but no hard users, it never really
got anywhere.

Anyway, I really don't mind VM_DROPPABLE with "it just gets
re-populated as a new anonymous page" model, particularly since we
could easily then later decide that we could expand on it as a
MAP_SHARED thing with SIGBUS semantics and explicit initialization if
we ever really want it.

End result: I don't think there are necessariyl *lots* of users, but I
do think that this is something where some enterprising person goes "I
can use this", and makes some cool library that uses it for caching,
and then we'd be stuck with it.

> And then, indeed, it'd make sense to eventually expose this properly to
> mmap() and let people use it. (Or if you want to do that in reverse,
> adding it to mmap() first, so that people don't misuse
> vgetrandom_alloc(), that's fine.)

Yes. And it should be pretty trivial.

We just at least initially have to be very careful to limit it to
MAP_ANONYMOUS and MAP_PRIVATE. Because dropping dirty bits on shared
mappings sounds insane and like a possible source of confusion (and
thus bugs and maybe even security issues).

It's possible that we might even use a MAP_TYPE flag for this. Or make
it a PROT_xyz bit rather than a MAP_xyz.

So there's some trivial sanity checks and some UI issues to just pick,
but apart from "just pick something sane", exposing this for mmap() is
_not_ hard, and I do think it needs to be done first.

And once it's done, I think the argument for having a special system
call is basically gone too.

> - The "mechanism" needs to return allocated memory to userspace that can
>   be chunked up on a per-thread basis, with no state straddling pages,
>   which means it also needs to return the size of each state, and the
>   number of states that were allocated.
>
> - The size of each state might change kernel version to kernel version.

Just pick a size large enough.

And why would that size not  be one page?

Considering that you really don't want to rely on page-crossing state
*ANYWAY* because of the whole "one page can go away while another one
sticks around" issue, I would expect that states over one page per
thread would be a *very* questionable idea to begin with.

I don't think we'll ever see systems with page sizes smaller than 4k.
They have existed in the past, but they're not making a comeback.
People want larger pages, not smaller ones.

And the stat size rigth now is what - 200 bytes? So a single page
seems (a) sufficient and (b) kind of the sane maximum anyway due to
the dropping.

No?

              Linus

