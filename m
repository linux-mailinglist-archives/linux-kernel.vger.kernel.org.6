Return-Path: <linux-kernel+bounces-340331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4089871B6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB881C2490C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235DD1AED48;
	Thu, 26 Sep 2024 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I06fjO7L"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E441AD5CB
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727347135; cv=none; b=jC1i5BdbmlTjCxMlGadMsROjucscx838DJ2zDUqfLKFyQu6qPYX3KqCFE9/+ror8dJqxECYtQ3pXYfHegUAjA/hwHIlTP2WIHsLX89nMKBoI+h8Wy5zkgFdGkRnfN3CTGrQvWJ4fVMT631hGx8t8eFcln+MREwCTgv27XR175hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727347135; c=relaxed/simple;
	bh=8r1pcZkfw/tFfZR6si2jJmP1lsdT9fdbbtCLXQYgb+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jEnDcMyQ6E0j1VuSIRq34OZxgAjG9XdNeh0n1z7Ok9w46SqF4ssIke1dBfLamJAGALWWgbMqYGHToyG+xF2fWRGfiCqooDYprSS97U95oUxXP05lThmb1wzqhn4ueGNHm0fOmVXhgaSlcai3mmj6+raGmcVOIaJqNzm3cU+dAAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I06fjO7L; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37cd3419937so3689f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 03:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727347131; x=1727951931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsEcz1fbSNxPzlZJA2pt/9oZVDJuGBFj7OVbuqkmeN0=;
        b=I06fjO7LaKok3OIAYCTlgHRfm8QtC/FzLlACcjjGolR76AATX8bnk7s2B9q91pD0Sw
         INimwp/+vULcEBGor6PHdzSbzRlhAcoMNZFH8iAolvCwUndbyXXauxCwcMXXPERw0C07
         cOvtdthGT/GdA8ehMpHGbbh2WGQf6EQMN1HBvTKW/newkK6iCVHRxcYFPULxVNUK1KMk
         y6qiRalTbqGv+v/ap6EE+Q69U92zUGk4iuuwAy/6Ias9CuaXuRSkKkt+7gzLSwp/3pXN
         Z5rGBZs20J6NY4ln5XfzaWkJPs+2CSDas0vXnBWh8NWCNZN2aFJl6rZ7tMORfUMYmRkX
         ZH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727347131; x=1727951931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsEcz1fbSNxPzlZJA2pt/9oZVDJuGBFj7OVbuqkmeN0=;
        b=EysSUMxAtjfUCoE3NPnTipqNadSWIaSfxwAYKaxhpyjEHpPXK2LAtfZLca2i3Hn42U
         xE3bVdwUYbQFDKkA5CMseuGTeRIn26/wJexI71FnxnVo2mH0dt+ashUKXoOC7XR2Y32J
         DgQa3QujDYsRVYEJV+T/92naJ+HpWsQkDQ5gUKuxflA+b/5Xl4mfxwGPfq/l2lTI3OFf
         7u8DgVOfi8ZrN9DKlJgNQnXvgbnjP1obAE4jV5lqISSntaKShf/KKbNOeVIRgpSMNhwH
         +yIjnolH14nAwEvznbAzkWKU0DhHh0xkv5oY9aKvX9JsOpNuCxzh0Quhz7hMe/D3WbyO
         ve+w==
X-Forwarded-Encrypted: i=1; AJvYcCVVMRWqyOhtII4dg98SiBUuA4O9iH/q+3iS5rpChBKMRwVZDIRKw6NhLQ9hPTyVQdoSj06AEbUYLwzhbAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF1zbaQAfXsf9deON6fh4cmDG3ES5MVDh+5xG54nHS1VLsKRu6
	aiQ1wrtIbwLMKtRYxGFu4bseG367VcKXGyBE1HN3BLpFvx4VHOp6aduHWSH12zmqTC/hEqqR1w8
	2BLp+7LK3RkETQWuhUx/lOMHgriiPQdBdpWga
X-Google-Smtp-Source: AGHT+IG5GKlP6TVqHse15LFnIap0YvbFb8l1DzbrYAO+qzwI5i5VHGfbIunMaThYXrhbKoz3QqKt8XmqA8AbgALoDCU=
X-Received: by 2002:a5d:4e0c:0:b0:374:ba83:8d73 with SMTP id
 ffacd0b85a97d-37cc245b82fmr3076607f8f.8.1727347131137; Thu, 26 Sep 2024
 03:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925-cfi-norm-kasan-fix-v1-1-0328985cdf33@google.com> <20240926000053.GA3188344@google.com>
In-Reply-To: <20240926000053.GA3188344@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 26 Sep 2024 12:38:38 +0200
Message-ID: <CAH5fLgjoQvxFj5S1s_fUsfSho9QRCV5acHsQxpZdvEztpaxqCw@mail.gmail.com>
Subject: Re: [PATCH] cfi: encode cfi normalized integers + kasan/gcov bug in Kconfig
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Gatlin Newhouse <gatlin.newhouse@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev, 
	linux-kbuild@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 2:01=E2=80=AFAM Sami Tolvanen <samitolvanen@google.=
com> wrote:
>
> Hi Alice,
>
> On Wed, Sep 25, 2024 at 08:10:18AM +0000, Alice Ryhl wrote:
> > An alternative solution is to inspect a binary created by clang or rust=
c
> > to see whether the faulty CFI tags are in the binary. This would be a
> > precise check, but it would involve hard-coding the *hashed* version of
> > the CFI tag. This is because there's no way to get clang or rustc to
> > output the unhased version of the CFI tag. Relying on the precise
> > hashing algorithm using by CFI seems too fragile, so I have not pursued
> > this option.
>
> I suppose there would be no need to hardcode hashes in the test,
> it's enough to verify that the hashes for the compiler-emitted
> functions change when integer normalization is enabled. Still, I
> agree that this doesn't sound worth it in this case.

Future compilers could change it so that the same hash works in both
cases. After all, the signatures in question have no integers in them.

> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index ee58df8b1080..b8066bf43153 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -829,7 +829,7 @@ config CFI_CLANG
> >  config CFI_ICALL_NORMALIZE_INTEGERS
> >       bool "Normalize CFI tags for integers"
> >       depends on CFI_CLANG
> > -     depends on $(cc-option,-fsanitize=3Dkcfi -fsanitize-cfi-icall-exp=
erimental-normalize-integers)
> > +     depends on HAVE_CFI_ICALL_NORMALIZE_INTEGERS
> >       help
> >         This option normalizes the CFI tags for integer types so that a=
ll
> >         integer types of the same size and signedness receive the same =
CFI
> > @@ -842,6 +842,22 @@ config CFI_ICALL_NORMALIZE_INTEGERS
> >
> >         This option is necessary for using CFI with Rust. If unsure, sa=
y N.
> >
> > +config HAVE_CFI_ICALL_NORMALIZE_INTEGERS
> > +     def_bool !GCOV_KERNEL && !KASAN
> > +     depends on CFI_CLANG
> > +     depends on $(cc-option,-fsanitize=3Dkcfi -fsanitize-cfi-icall-exp=
erimental-normalize-integers)
>
> This looks reasonable to me. Thanks for the fix!
>
> Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Thanks for taking a look!

Alice

