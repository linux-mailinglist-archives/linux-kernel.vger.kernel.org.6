Return-Path: <linux-kernel+bounces-243690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D2A92994C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 20:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38A58B20CD0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 18:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8895C8FC;
	Sun,  7 Jul 2024 18:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q1kg4cWj"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4433657CAC
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720376816; cv=none; b=cPwZLtV4KXIbVk909C3XaDGQbkU6dFYk1OdeFiSIVHPOwmrWigtIRwZo6EiLmRjPRMCaLCwaEFyxCE0F4SDrwNAhqc4B6Pif8SNEACUOLzHDeCnBZX58JRVdnq6cXC/bzQYKLLQ/2YwF1YHGf6cyr92zHHUpO7BqYrDMk3ryoqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720376816; c=relaxed/simple;
	bh=IgVGCT2xxQj0d6AEWv1d2oISYtXfXK5QvKatWJYOnV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BHywppJJP6UjH5AdeUgJPmnKtEiTYp089N5kvgo3RL0MgNzNdGZi86yhKIeEtV/SduN6vSxmSiMKjRN5f5Fksbu8OaavgQI/cnxUpO1xdoTk72+XiAHRDhlwNIN3/pqbn/sl1fwmHgVxtL5LTX4xl6jdyNpIHjIteY2Is2/MKF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Q1kg4cWj; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ee92f7137bso25028421fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 11:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720376812; x=1720981612; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5v0Nkh0XR+jIko5z42PL5jDgcJnA00NhojDwz4yKzQ4=;
        b=Q1kg4cWjvmjDGVFh3A0G7E79RO3qh6G9HXbYTaKkOewvN7zA87+1TOXVGPXG1IP0YP
         /4ZF87oGoG2BzV23JoEX0O4fTQgCDmroVLNMlyCxsG+PYlM7wVfbZYvNFBuO/wegLkIU
         Nkw53VMg3kBvlB8W2+tmGyQEku0dkiRm472v8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720376812; x=1720981612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5v0Nkh0XR+jIko5z42PL5jDgcJnA00NhojDwz4yKzQ4=;
        b=R/BTU8wmcgI/2IUsvSdTtssBCH/39pEdQV/vsJK3qEjh/O7ml9iHVDg5hLZFbalxrz
         fZ1vQlgfH1SFJ4ozMyhFboRPxdhBtXBgRT7txbz9ZC+syl+saWL+I06nJP1Q8aG7RMFl
         wURmR9hlNfBc0kXdOYndvYvE4ZOBzcXCjBAyG5SckdN364X0P+D7JmVBEMHwpLVgsNYI
         sYLJPik1jhtkk7h/l9hOp+WHWivLF9J0A1cKa8EY/JLWLFVTzdpuJ+Mo5faJH/Cs1igX
         vhOIsBjLQQ4wOnhnn8LCwA9+pa7sPIqHjTbl5kwEnlPnls6zg/lQ/6GRBjbfutNs6ErQ
         xCPg==
X-Forwarded-Encrypted: i=1; AJvYcCVwotU3dsMGGiAR+zB4MeMHcIz8VsR6LdPuuUUhiCC6dSKoH6zOCz7QGR0Aw8sOzsQoAbuUKOjEtC1Ebhph/R7xk6kR7SmIDXkeYH9i
X-Gm-Message-State: AOJu0YwIYnPqY4ZNnx7rI2lVEtSg9WZsHzYs5+KmNMJbEpMnJkHOe6ZA
	iMJtIes/sh7BzTdOhUdXROoTNFontHFmynSnbEwQsrGa/I00ajGFG2ObXcA6mq0iO4cgS4NTUCD
	ImktXOg==
X-Google-Smtp-Source: AGHT+IFx95gnFBbMEE9IBeeEzIbbs83sx7Mv6QAMEfTmQLIpKPe1/WEsOk0oQP8lWY66JlISO+rpOg==
X-Received: by 2002:a05:651c:220f:b0:2ee:7bed:2cff with SMTP id 38308e7fff4ca-2ee8ed9065dmr92256781fa.13.1720376812090;
        Sun, 07 Jul 2024 11:26:52 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee9ab96476sm4544611fa.50.2024.07.07.11.26.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 11:26:51 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52ea2ce7abaso4055407e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 11:26:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUCLWyxewqbKlOqOrxICdqIhS3nkKlZzI9ikgywd69HJl6Enz/CE7sFFUyW1dqokbr3D7OjiWcNsJCKQ33azglOfQ+bFt8TUrMAfYt0
X-Received: by 2002:a17:906:bc94:b0:a6f:58a6:fed8 with SMTP id
 a640c23a62f3a-a77ba46f8femr721323266b.28.1720376402830; Sun, 07 Jul 2024
 11:20:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240707002658.1917440-1-Jason@zx2c4.com> <20240707002658.1917440-2-Jason@zx2c4.com>
 <1583c837-a4d5-4a8a-9c1d-2c64548cd199@redhat.com>
In-Reply-To: <1583c837-a4d5-4a8a-9c1d-2c64548cd199@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 7 Jul 2024 11:19:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjs-9DVeoc430BDOv+dkpDkdVvkEsSJxNVZ+sO51H1dJA@mail.gmail.com>
Message-ID: <CAHk-=wjs-9DVeoc430BDOv+dkpDkdVvkEsSJxNVZ+sO51H1dJA@mail.gmail.com>
Subject: Re: [PATCH v21 1/4] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To: David Hildenbrand <david@redhat.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	tglx@linutronix.de, linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, 
	x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, "Carlos O'Donell" <carlos@redhat.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 7 Jul 2024 at 00:42, David Hildenbrand <david@redhat.com> wrote:
>
> But I don't immediately see why MAP_WIPEONFORK and MAP_DONTDUMP have to
> be mmap() flags.

I don't think they have to be mmap() flags, but that said, I think
it's technically the better alternative than saying "you have to
madvise things later".

I very much understand the "we don't have a lot of MAP_xyz flags and
we don't want to waste them" argument, but at the same time

 (a) we _do_ have those flags

 (b) picking a worse interface seems bad

 (c) we could actually use the PROT_xyz bits, which we have a ton of

And yes, (c) is ugly, but is it uglier than "use two system calls to
do one thing"? I mean, "flags" and "prot" are just two sides of the
same coin in the end, the split is kind of arbitrary, and "prot" only
has four bits right now, and one of them is historical and useless,
and actually happens to be *exactly* this kind of MAP_xyz bit.

(In case it's not clear, I'm talking about PROT_SEM, which is very
much a behavioral bit for broken architectures that we've actually
never implemented).

We also have PROT_GROSDOWN and PROT_GROWSUP , which is basically a
"match MAP_GROWSxyz and change the mprotect() limits appropriately"

So I actually think we could use the PROT_xyz bits, and anybody who
says "those are for PROT_READ and PROT_WRITE is already very very
wrong.

Again - not pretty, but mappens to match reality.

> Interestingly, when looking into something comparable in the past I
> stumbled over "vrange" [1], which would have had a slightly different
> semantic (signal on reaccess).

We literally talked about exactly this with Jason, except unlike you I
couldn't find the historical archive (I tried in vain to find
something from lore).

  https://lore.kernel.org/lkml/CAHk-=whRpLyY+U9mkKo8O=2_BXNk=7sjYeObzFr3fGi0KLjLJw@mail.gmail.com/

I do think that a "explicit populate and get a signal on access" is a
very valid model, but I think the "zero on access" is a more
immediately real model.

And we actually have had the "get signal on access" before: that's
what VM_DONTCOPY is.

And it was the *less* useful model, which is why we added
VM_WIPEONCOPY, because that's the semantics people actually wanted.

So I think the "signal on thrown out data access" is interesting, but
not necessarily the *more* interesting case.

And I think if we do want that case, I think having MAP_DROPPABLE have
those semantics for MAP_SHARED would be the way to go. IOW, starting
off with the "zero on next access after drop" case doesn't make it any
harder to then later add a "fault on next access after drop" version.

> There needs to be better reasoning why we have to consume three mmap
> bits for something that can likely be achieved without any.

I think it goes the other way: why are MAP_xyz bits so precious to
make this harder to actually use?

Together with that whole "maybe use PROT_xyz bits instead" discussion?

               Linus

