Return-Path: <linux-kernel+bounces-358830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AE699845A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7BE1C21012
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205D01BD50C;
	Thu, 10 Oct 2024 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xXGpw50n"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BE71BD50A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558153; cv=none; b=jN8jCT+2qWRmvVBUzFaIT4BxTnxpCr8cGNYpvAtZS4KAAIFPPLL9Dn6thhgiOgK7qgoeilp3Ezz4e69M/IbNUfvkv8l18j5fVVh2xntYm5Eaey+5stEU7k7qo4E1IgawkutLeLK9FbZcr1+litzyfCEg11D5EKmyylmqK4a0nZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558153; c=relaxed/simple;
	bh=VUZtMlFmU9aktV9oOImu+gMtJQ/WQw06C2hUBzcUsec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndX1fZUx8XdvYV3cQqnqMGF0Ulh+GG2EP6GJfP8Z+my8Jaqm5LUZ1IGIkPCmQ+vCQdrRi4y5D4F2MyTKmn5B4xoUYd/1RdyoPkwnMIxJYy2gQEX+kjnl/aFZ0mONl2HLcvdjMKNYgW0DRv+IpNZwep7fyYj6XcW00L+pM278IDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xXGpw50n; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4311420b675so6590055e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728558149; x=1729162949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vm7iH+80LuUknHyKz8yii4nAbEM+GkBJz008+GYeeIk=;
        b=xXGpw50nYPqYjJGKlt5ujy9bErxHFfb0RfiiQ1ddSt5Mxq9ojHQDP/+EadvCjKZN2K
         Tl6Pk1ynAt+e8HMWzWyqgTKPMV8ScGo62n3eLxthupIWtTKMtGZHEMb7pcYuZU8aFQ2D
         Eswwa+opBSUFKw6Pn3iN2j0VYDVG/7M2znvxYYBF3R76MWJ44QnkQgxirhtLomIhqmxg
         37Q+8j8v8i+Wpi7u71qrt9AU5ULs611HZH7Vu2mPh5hci5SMHpbrmaRTqHzZJbEJENO0
         aaJBMbh7WcSTyC09ROFAMg5g3NPrgmq7oTyRpfN2Uklz7cgkNwnl1BHi5vaZ3bqENznq
         uvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728558149; x=1729162949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vm7iH+80LuUknHyKz8yii4nAbEM+GkBJz008+GYeeIk=;
        b=FrVTxG7xFaMPhmUjuOYN2Pn2tD/W8gB3bnABCtVKL8YTNRqSryvt+tFpHWIUJ7GG7W
         blMZWuQSu0ZodKpTopExFhs9Irom2ViOl9Sgjo1VP4IMaorTVSNeuFDJLQFgPWP2n25u
         8LMgd+1fIBswtssi0AaZrtPIuDVjvStyUfbg6dp9pekh9LeIs/Eks8ulaPwXgr398S4Q
         fr0yZnh6p+Wo1GsJZul2uCOpv4ArysI5hjCDBi8SZnsQqNW8Pjx5YU1mqLmCn6/0d6Lz
         KjjrvBRjNYQZs0x2mpDbFm+KwiNql836TnCe+Qm4Ntyri6Mflk1aUVJB7uoouT5cfuNb
         iVlw==
X-Forwarded-Encrypted: i=1; AJvYcCXXYIlB4mvpneorkW7FuYs69pWwSokSciuBgdwyZV1fqyIeZI9hEZ0JKURyLQ6B2fJ4P1WLjf2Tj1z+saU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEGZWUlurQ6jqXIfJQ4U0VqI0p2IGTNlZqCDgnplVTXDxw/rKw
	muHqGtG4jTCZHKfKGRIx6tBWRwQIY3A9ZjRe6+ANlyeN47rZdSijb83rxgf+u7xmFh11p4mRJEx
	ppyrduoipq4RR/OdnzMkw0vwWk1O9OV68u8Tn
X-Google-Smtp-Source: AGHT+IEhkXYyqV/bhuHZm74JThr/Q/zz0AYwVohM06m/aYfA2ou2oQr9f16G0HxUpPy5+6rG27v0LxANOflRiXXU8PU=
X-Received: by 2002:a05:600c:45c6:b0:42c:b1ee:4b04 with SMTP id
 5b1f17b1804b1-430d70b3d24mr51844575e9.28.1728558149119; Thu, 10 Oct 2024
 04:02:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010-icall-detect-vers-v1-0-8f114956aa88@google.com>
 <20241010-icall-detect-vers-v1-1-8f114956aa88@google.com> <CANiq72ndoSmGVzuPR6ikq0HG1kbMp6ADOY8BonD9=ij9tyU=EQ@mail.gmail.com>
In-Reply-To: <CANiq72ndoSmGVzuPR6ikq0HG1kbMp6ADOY8BonD9=ij9tyU=EQ@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 10 Oct 2024 13:02:17 +0200
Message-ID: <CAH5fLgj5rPgV1wBbYJy=T0kjCdECYnDvbim0pEk5y6fp7BVx3Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: rust: add `CONFIG_RUSTC_LLVM_VERSION`
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 12:55=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Oct 10, 2024 at 11:38=E2=80=AFAM Alice Ryhl <aliceryhl@google.com=
> wrote:
> >
> > From: Gary Guo <gary@garyguo.net>
> >
> > Each version of Rust supports a range of LLVM versions. There are cases=
 where
> > we want to gate a config on the LLVM version instead of the Rust versio=
n.
> > Normalized cfi integer tags are one example [1].
> >
> > For consistency with cc-version and ld-version, the new version number =
is added
> > to the existing rustc-version script, rather than being added to a new =
script.
> >
> > The invocation of rustc-version is being moved from init/Kconfig to
> > scripts/Kconfig.include to avoid invoking rustc-version.sh twice and fo=
r
> > consistency with cc-version.
> >
> > Link: https://lore.kernel.org/all/20240925-cfi-norm-kasan-fix-v1-1-0328=
985cdf33@google.com/ [1]
> > Signed-off-by: Gary Guo <gary@garyguo.net>
>
> Alice: when I apply this, I will need to add your Signed-off-by here
> (i.e. when handling patches from others, you need to add your SoB
> too).
>
> > +if output=3D$("$@" --version --verbose 2>/dev/null | grep LLVM); then
> > +       set -- $output
> > +       rustc_llvm_version=3D$(get_llvm_canonical_version $3)
> > +else
> > +       echo 0 0
> > +       exit 1
> > +fi
>
> I guess if we don't find "LLVM" in the output, something weird is
> going on, so I guess it is reasonable not printing either here.
> Although, in principle, we could preserve information and print at
> least the `$rustc` one.
>
> Anyway, we may need to rethink this when we start supporting e.g. the
> GCC backend, so I think it is fine as it is.

I guess we can just do

rustc_llvm_version=3D0

in that case?

