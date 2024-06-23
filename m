Return-Path: <linux-kernel+bounces-226312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC29B913CE4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 18:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19878B20C2B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 16:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3B3183073;
	Sun, 23 Jun 2024 16:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gqu+qL/Z"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF46C181D14
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719161518; cv=none; b=dmY0TOJ88hrrNLJbcOVoepjdWGrH+8KYfGRcOF8aiv3DE6XR7DlxsdvK9vrPITEGgIB+NPtGDN7NRQzUIbjhDOoyhmtJInMgpUIhF17mrWzQXJ6Np2sO7NwV/t78MYc7EPyKNDzWHR2dIOp2oxTVSzeYLbCcVMkq/5wq5CKfk7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719161518; c=relaxed/simple;
	bh=NZQyaZf7FOnKMjA4vLphHGmCC8OBy/rwt7kqfFcNkaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qSH1PM9SWsxR+ZyuvLS4kV6SyA/MomySiHH54k92EkWEkbLAcyYQLFiZqiN3WBF3NEiof2flG/v76hhPqb7KUfZaEQP3Hi5lHYG+c381NM3zv8gJA5WVIYix9uEha2aZcK2IfAk6Xz+L3rdUQonQOjI1agH1encM4Fr/9NkJTjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gqu+qL/Z; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eaea28868dso46608211fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 09:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719161515; x=1719766315; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JZK30fVnygMHCN0lsNw1v+SdKhqY12DdFDA/r56Sx/E=;
        b=gqu+qL/ZNWXS7B3rbRsGaz3CHTpPWfBcS/BNBaNskJwkJIRUsyrXGkRDX+gzl1N0HD
         8BAO4vOHWkZrirVQI6cxslHUEphnJ07yAP6Qpo6Tvl4nl4NzPrqWbL9Qc/hYXfP6kelN
         GclcE45np3k2e1gFfvnv9hPTHMvgD6Jl6wcIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719161515; x=1719766315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZK30fVnygMHCN0lsNw1v+SdKhqY12DdFDA/r56Sx/E=;
        b=mN3FNWmiCbgHUNzDtXoCDl4elSmL1zaO//T9T2/gdthGF5jxVUM03sA3axLpF+Ff3E
         BtV58fQPoSk7uqrNpXfTsS15JEkelms9/QN3pvTLYoCX3EMFPpKC9/rBrWTn1Bc0LvJt
         dht4ibiQCKdLDBNABdfCwfKtPQYTeNvy7iO+Zucv4++r5uGtZvRf4r2Y/8iUJsUasE6V
         tyToUm1uXZdeSKEKevg1fIyiavd/VVNpoteb1DvmKsk4OcndMf5lNu9CtERDC0Jcele7
         u9ylNAHgwtHmQ4BH0JeoZXluK7oIrgFF1oIl3xqJRZwkK0zCOGkailXB4GfoYcSBDTvS
         v98A==
X-Forwarded-Encrypted: i=1; AJvYcCUREoIceeXmkzZwEfsgJ9oSELYYD6ivSUoRBJgaNIMhIkSVuqBhrOTY9TvlhuBmOq/st9C1N6VHkXh11Xr/14GnsgCYfaXSoxC90h9d
X-Gm-Message-State: AOJu0YxkWPzL1PKf3uCGtoqXMlofcNt7pYpuUdOaydXpjRP3v6QGqzSa
	Dg/n6mjU07pzuFhtYMHpZr5ncvueAbSX3A/Rdej/Rck/pQAF3IlnJDmQcA65o8ug6shaD7h6Nm9
	aKfSdgg==
X-Google-Smtp-Source: AGHT+IFZyF5Ct+mH5clqydm1+ox6o0ncx4wxlzyin3kUYGK9pMx3TsbrE8H8E+en7TZVn+Jo/pilPQ==
X-Received: by 2002:a2e:7811:0:b0:2ec:55b5:ed44 with SMTP id 38308e7fff4ca-2ec5b2c4ebemr19105451fa.11.1719161514893;
        Sun, 23 Jun 2024 09:51:54 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf428c72sm320913366b.36.2024.06.23.09.51.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jun 2024 09:51:54 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57ccd1111b0so1912234a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 09:51:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVw6AG+hF5+9usJLkAQBkA9TVEKDUtVv8UuQxa0T/k95auKTj6lvQyX3suDyrmMKIn+PibIPHlHHazMEXpxaPb753TSmKvQWQDVP65l
X-Received: by 2002:aa7:da99:0:b0:57d:5d68:718 with SMTP id
 4fb4d7f45d1cf-57d5d6807b3mr89557a12.41.1719161513740; Sun, 23 Jun 2024
 09:51:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620181736.1270455-1-yabinc@google.com> <CAKwvOd=ZKS9LbJExCp8vrV9kLDE_Ew+mRcFH5-sYRW_2=sBiig@mail.gmail.com>
 <ZnVe5JBIBGoOrk5w@gondor.apana.org.au>
In-Reply-To: <ZnVe5JBIBGoOrk5w@gondor.apana.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 23 Jun 2024 12:51:37 -0400
X-Gmail-Original-Message-ID: <CAHk-=wgubtUrE=YcvHvRkUX7ii8QHPNCJ_0Gc+3tQOw+rL1DSg@mail.gmail.com>
Message-ID: <CAHk-=wgubtUrE=YcvHvRkUX7ii8QHPNCJ_0Gc+3tQOw+rL1DSg@mail.gmail.com>
Subject: Re: [PATCH] Fix initializing a static union variable
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Yabin Cui <yabinc@google.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Jun 2024 at 07:07, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Thu, Jun 20, 2024 at 12:31:46PM -0700, Nick Desaulniers wrote:
> >
> > Can you also please (find or) file a bug against clang about this? A
> > compiler diagnostic would be very very helpful here, since `= {};` is
> > such a common idiom.
>
> This idiom is used throughout the kernel.  If we decide that it
> isn't safe to use then we should change the kernel as a whole rather
> than the one spot that happens to have been identified.

Again - the commit message and the whole discussion about the C23
standard is actively misleading, as shown byu this whole thread.

The bug IS NOT ABOUT THE EMPTY INITIALIZER.

The exact same problem happens with "{ 0 }" as happens with "{ }".

The bug is literally that some versions of clang seem to implement
BBOTH of these as "initialize the first member of the union", which
then means that if the first member isn't the largest member, the rest
of the union is entirely undefined.

And by "undefined" I don't mean in the "C standard sense". It may be
that *too* in some versions of the C standards, but that's not really
the issue any more.

In the kernel, we do expect initializers that always initialize the
whole variable fully.

We have actively moved away from doing manual variable initialization
because they've generated both worse code and sometimes triggered
other problems. See for example 390001d648ff ("drm/i915/mtl: avoid
stringop-overflow warning"), but also things like 75dc03453122 ("xfs:
fix xfs_btree_query_range callers to initialize btree rec fully") or
e3a69496a1cd ("media: Prefer designated initializers over memset for
subdev pad ops")

In other words, in the kernel we simply depend on initializers working
reliably and fully. Partly because we've literally been told by
compiler people that that is what we should do.

So no, this is not about empty initializers. And this is not about
some C standard verbiage.

This is literally about "the linux kernel expects initializers to
FULLY initialize variables". Padding, other union members, you name
it.

If clang doesn't do that, then clang is buggy as far as the kernel is
concerned, and no amount of standards reading is relevant.

And in particular, no amount of "but empty initializer" is relevant.

I *hope* this is some unreleased clang version that has this bug.
Because at least the clang version I have access to (clang 17.0.6)
does not seem to exhibit this issue.

              Linus

