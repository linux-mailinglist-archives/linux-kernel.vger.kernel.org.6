Return-Path: <linux-kernel+bounces-347428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E49C198D298
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E9FEB2141E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7116220010D;
	Wed,  2 Oct 2024 11:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ws6I8YWi"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5BA19750B;
	Wed,  2 Oct 2024 11:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727870176; cv=none; b=a2IthzvNfxKyT72/MS3cJBAJIIKt2qhS6NfBCkN7NEnjhR4A+Uo9Phh4sBuabiFQrnyhsRxqdoyruGuwWqGnqZHX5WWFZXAiS173SuZBBJaRxoF3HnfcuQid74nqWFhB2JI5LrdLE9PUoOhdRDz/dOQSOza67VfNEWDuSSzL9a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727870176; c=relaxed/simple;
	bh=raOhVeNqBV61SFOByBrg+r08qM75hSp4zGzzG59QNRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gEIy38vbQ8KnXisSzy2rnLWQ0n2kP020IFbbob+51/tCMdzruWYCTh31a6DDo9l7GCL1HweJwd3FoJJCZDVf2F94DliOU8zTtzoBW9jLZio/xVDjSFYFehLHex9lzoJiWI2xzSDd0LzG90DPifSmdbmtaHuIbHUkVBJrUPovsS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ws6I8YWi; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7e9b2d75d92so33840a12.0;
        Wed, 02 Oct 2024 04:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727870175; x=1728474975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dco6YH40fR+DfvK0RKqxFWi8Vj8kvWpFDwURjqtH78g=;
        b=Ws6I8YWiujZmB6b8CPFBUw5YAAaW07py5EvW1/U7xaJr4hA6YNbRfW2fY81/XfzL2X
         b6VDloJwIhqAZCpFWd8kybo7giFWbUX7l1X8plEnZcfTPPCP88HCgO8B01Mhi1HXudtS
         38pXv8hrGoEpiLsPmOdd80pBZat4QMdIPnn1y0GBGZ99crqjAI73TdBb2vscyDPQOwji
         o0TRDZsbn6uKep2DKcy7kdJ4HxaprTbiMeVtXmYzC+0e7trrXlpituwtlOn7GG5Kt4AN
         QgeRNcRdm96SNY4OK4WVYQJg1DG41iypm/3OozvT7AwTzLcmPsRRjMVYiWuui9OIIn+b
         kZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727870175; x=1728474975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dco6YH40fR+DfvK0RKqxFWi8Vj8kvWpFDwURjqtH78g=;
        b=Q9NJrXrU4hOLNnrv5ytFVQvnwQiT+Lh8qFOBKR0ewz+n3DzqF89UdKqgaoOoRo1SGD
         uqnzjtNwBMbaO/uu1Bib/3yDzDgRv+qdv81DRd6He6nyDmIIu2BxLz6UQN4KLzZpW79Z
         8qQSeStpzV9LTkXqFq/aGbvzOEbhHXyWieHB1SOLWmx2Cyrs+G4asCbg+jNQjZSztXPR
         ZFi0DtyBxYBijYS0QaSDZ1aQ5zu2VCm3kEjFbl0LdnP+1mnEHoGDgGHoGD3msk9RrQFs
         QZblR5Su+mMjnAZ6f4Wjab0GYJhzF+e/SgLzxur9nb433fokE59P2iwPBwssEUxyJ+tS
         TGOg==
X-Forwarded-Encrypted: i=1; AJvYcCUiPFW48NlADAlMeqRt9DxKxmYJvFoLTNjRu1GzxU6k0QNvvfc8KazYKkyP3M13qOoBj4XZFbX0W7IUjyL8deQ=@vger.kernel.org, AJvYcCVkrbgrPU9flynP+bbOA5hJ2lc/FxE/Rad+v7NjnyEi0IeCLSbslSIyv6LJNsymNJ3aweHaRQSrKXuV+I8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9q09SJDCttZCmVvwHtppLAOMJQ7jsf39PSmqeiNFjMPYRMjqd
	8YZ5rLwPfejyj1aN+6s6KNBBZInbdJVL1U9zEn3c/7JdyU77Y3fwJEyWoEqtsWUm5hSL9KCCwz6
	ZT0PFc0wo+thzBrDeI34IqHdcS9U=
X-Google-Smtp-Source: AGHT+IEgSDDYv3tAfbVsnvY5D4yC7PapkP0f3WU8QmzFtmzqAZLmg0w0EvdOoI4AaouZIUMLHjmiU2e3qECruy+w0zM=
X-Received: by 2002:a05:6a21:9990:b0:1cf:2be2:8dd1 with SMTP id
 adf61e73a8af0-1d5e2d4cc65mr1914134637.10.1727870174786; Wed, 02 Oct 2024
 04:56:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002022749.390836-1-paddymills@proton.me> <20241002022749.390836-2-paddymills@proton.me>
In-Reply-To: <20241002022749.390836-2-paddymills@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 2 Oct 2024 13:56:00 +0200
Message-ID: <CANiq72kEPEcqqJmLEtT7=Ku5mseHe6Js_jptVQHMzRwfUzFtMQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] checkpatch: warn on known non-plural rust doc
 headers and empty doc comments
To: Patrick Miller <paddymills@proton.me>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Hridesh MG <hridesh699@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 4:29=E2=80=AFAM Patrick Miller <paddymills@proton.me=
> wrote:
>
> Signed-off-by: Patrick Miller <paddymills@proton.me>

These tags are typically placed before your Signed-off-by (tags after
it are usually the ones added by the next person handling the patch,
i.e. the next Signed-off-by).

> Co-developed-by: Hridesh MG <hridesh699@gmail.com>

This tag requires a Signed-off-by -- please see:

    https://docs.kernel.org/process/submitting-patches.html#when-to-use-ack=
ed-by-cc-and-co-developed-by

> Suggested-by: Trevor
> Gross <tmgross@umich.edu>

It seems like the patch has been wrapped in a couple places.

>   - merged Hridesh MG's patch[2] to check against consecutive rustdoc com=
ments
>   - revised Hridesh MG's
>  patch to match against $prevrawline being new
>       or existing
>   - added fix to Hridesh MG's patch

It may be clearer and simpler (for attribution purposes) to avoid
merging them, and instead add a check in each patch (you can still
rebase Hridesh's into yours on top, so that you add it inside the
`realfile` condition etc.).

I would also include Hridesh's cleanup here too if we are doing
everything here. Something like:

#1: clean A
#2: add check for A
#3: clean B
#4: add check for B

> +# checks for rust files

We already have other checks for Rust files that are shared with other
languages. Perhaps we can be slightly more clear with "checks for Rust
files (only)" or "Rust-only checks" or "checks that only apply to Rust
files"?

Thanks!

Cheers,
Miguel

