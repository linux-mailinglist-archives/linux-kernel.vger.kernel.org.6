Return-Path: <linux-kernel+bounces-183142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D798C952D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 17:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EEA1B2121C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 15:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E56481DA;
	Sun, 19 May 2024 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fr1q0gqS"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F9D282F0
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716132786; cv=none; b=n8wgXforCHWqxL52+uZrq4CknBp88mtcaln2lO6U6yfURuBx0bzLb00BMVNNYOQRwOUvYnemD1y+BpZnpfRDD/du4mFgNLLjLzzHepC4EHM9dtq88dylOpy0UQdq6IxQYn9r/wOyQoiB+TBgpdb9gaYdttHmfQ3sJ4BRRIOMlvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716132786; c=relaxed/simple;
	bh=W1zr+c9KPmDePWUwRbBn2agwLQGITDaLC8ySFgxeN5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPX4lr/bnpXpMIdCxZSHe4l5KUBlcjM0ZhfuxoyEGnFVpT7KkP6t8aaXp4QcBaAN44QyG7TaJz+lsz16vwZFTkzt60m+U95/qVbPyYJqdo/5yZRq4V6kM5G8h0wi0X3FcSWfW6ICzWhDbQvZ6x+YRya7X4gBrkt96mSvQXy1teM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fr1q0gqS; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-523b017a5c6so5286820e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 08:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716132782; x=1716737582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MDJiaiU5rkttwfgCtw/KvgAida8xU4nH18aWOxHr77A=;
        b=fr1q0gqSLreOjDw5XCyHdcGtGbhgQ9H0WGB3OXtweItSLgkwbNRBZOYfat145YIvjI
         U5oqMZhn4ElQKSXOmsPGDiYctdmOpIB9TFvHd+mf17y0l0JDHwgcwmk0Bpf+muYjiEBK
         0z7xmzo6Byy+aMQCyc71oxErMW6e2EvQmR35k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716132782; x=1716737582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MDJiaiU5rkttwfgCtw/KvgAida8xU4nH18aWOxHr77A=;
        b=BR5mh6tMkP3FoPyZs/NnYVt5ncHdUHOB64iqzPbPmoNEFEHRQfe52PNmJOxY5u9KvZ
         b6QWBom4KIY9TfYg7xMvlpfji4UQC92pIF3Yt82zBAsuLpq9cc81H92IQNB4qGHL5b7N
         Yjm+4ZEJQbiYHZTnYLyC3iS4VjlstOO8mNChGrvycn/OA+3TGdkC8+5iN89zycZ3yU1t
         Ab4pd7p44eMjUf2zGeqU5yVZUB8sDZxHlscm3eoxjJKrZD87vaP/u/t0xuN1dOUEKif0
         k7xKGFDcOfC/3U/Y8dkxFrCkV2JIeENSzjpeYPxn5NdF4iyADrb02b5xDRPm9FDZirhT
         PG/w==
X-Forwarded-Encrypted: i=1; AJvYcCW3goATUHsoC4/BIgjAzek+psZrSm7YTBjCqJkd9op5FqguAmU6FFLN5GHSs2HI3D9cMWET04fa7F4M4n3WzUYSbRxx+T9pc3aw1oNX
X-Gm-Message-State: AOJu0YwW0pAwEjtmtK9G/lZbu5+4M+mMYC7d7OHfJfd8rJUWNL2y9Ou/
	VhSWvOx+awwaGfNw0TZsmUtIX4N4k5W9h9v4apaJxS+gLpIlK3Pi6JZ+9udXlHeMG5Yi7aX9VPQ
	NUAG2fA==
X-Google-Smtp-Source: AGHT+IFcHLBWuicU7IFI3viKIL7s4yKF1e7i3IEbdcTdEejQiez2hcZQzHGJ/WIKX+RM4NYxfrmCMA==
X-Received: by 2002:a05:6512:3b84:b0:51d:8842:f0b8 with SMTP id 2adb3069b0e04-5220fc7c5bdmr29084337e87.13.1716132781971;
        Sun, 19 May 2024 08:33:01 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d3770sm3932000e87.159.2024.05.19.08.33.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 May 2024 08:33:01 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-523b017a5c6so5286796e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 08:33:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXRFyEJwXpw5Wezvl1qYTbZ4YtoeUlRO9qXUiAa2LNmEQucGjvf04+LDqaRmXgPF1XMluNY3W3D5suaXFHYBB9hRg81Fd+YE5CoDg6E
X-Received: by 2002:a05:6512:444:b0:51f:3e0c:ace3 with SMTP id
 2adb3069b0e04-5220fd7c6bdmr22793661e87.16.1716132780601; Sun, 19 May 2024
 08:33:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517192239.9285edd85f8ef893bb508a61@linux-foundation.org>
In-Reply-To: <20240517192239.9285edd85f8ef893bb508a61@linux-foundation.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sun, 19 May 2024 08:32:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=whEAquncw0wb59-XVAHmVh4CWSfwuWh4bTJjJzvx0=PzQ@mail.gmail.com>
Message-ID: <CAHk-=whEAquncw0wb59-XVAHmVh4CWSfwuWh4bTJjJzvx0=PzQ@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.10-rc1
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, mm-commits@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 May 2024 at 19:22, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> include/linux/slab.h
>         https://lkml.kernel.org/r/20240429114302.7af809e8@canb.auug.org.au

This is not only a merge conflict, your tree is actively buggy.

You have introduced changes like this:

  -static inline __alloc_size(1, 2) void *kvcalloc(size_t n, size_t
size, gfp_t flags)
  -{
  - return kvmalloc_array(n, size, flags | __GFP_ZERO);
  -}
  +#define kvcalloc(_n, _size, _flags) kvmalloc_array(_n, _size,
_flags|__GFP_ZERO)

and that's just completely wrong. Note the "_flags|__GFP_ZERO": yes,
the bitwise or is fairly low down in the operator precedence rules,
and it probably work sin practice because most cases will just pass in
a simple expression for the flags, but it's still *horribly* wrong.

I'm going to take this pull and fix up the cases I find, but I'm not
happy with this kind of trivial C preprocessor misuse.

I also note that you have *SEVEN* pointless merges that have no
explanation for them. I'm happy that you use git, but that means that
you also need to either

 (a) not do merges at all and treat it as a patch queue

 (b) do merges _properly_ and not throw them around like some madman

And doing them properly means not only writing good commit messages,
but actually having good reasons for them. As it is, we have

  5d1bc760583f ("merge mm-hotfixes-stable into mm-nonmm-stable to pick
up needed changes")
  640958fde130 ("Merge branch 'master' into mm-stable")
  4e2e36129225 ("Merge branch 'master' into mm-stable")
  1dd4505cf4c8 ("Merge branch 'master' into mm-stable")
  71919308943d ("Merge branch 'master' into mm-stable")
  b228ab57e51b ("Merge branch 'master' into mm-stable")
  5e2806112864 ("Merge branch 'master' into mm-stable")

and those one-liners are all the explanation there are for the merges,
and NONE OF THOSE MERGES ARE VALID IN THE FIRST PLACE!

They shouldn't have been merges! You literally have no new code on the
other side. You should have just fast-forwarded to the new state,
since your side didn't contain anything relevant any more.

So the merges are doubly wrong. They have no explanation, but part of
the reason that they have no explanation is probably exactly the fact
that there *IS* no explanation for them.

There is one fundamental rule of merges: if you can't explain why
you'd need to merge, DON'T DO IT.

There are lots of smaller rules too. See

    Documentation/maintainer/rebasing-and-merging.rst

for at least some of them.

                 Linus

          Linus

