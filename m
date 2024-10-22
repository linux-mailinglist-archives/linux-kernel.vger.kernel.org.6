Return-Path: <linux-kernel+bounces-377028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F99B9AB8F3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EE591C20E27
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7C31CCEF1;
	Tue, 22 Oct 2024 21:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BEN1fABf"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9461CC150
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 21:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729633400; cv=none; b=kkuwuw7mzKnrOKabyrleIMoGxBJnHbXDdTHxScDK1XjXKBbC2knYyvbw41B1EtAdPE1zbV5G5SxPKN4NCU/mVrCS0tvlQ3irdaESV6rlA0AisNip8JrwZA+5eHVPvt4vC9HY3hQlu7D48g5kGPf7PfV1UmTTlpgora89n357QP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729633400; c=relaxed/simple;
	bh=6CE9iMBC3y9cAYCu1l54VdZn1idKxLhum6UdhdsDFus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5LxfeN244/OTe9ljYKONptMKaxO3ErTvdM96gDi33ui8dAT9jbTdq1qXwcH4hqV0L4kf8wkH0beOsWc84EyLDZeNEINFk7DWzf+1k4KfB76+njH9/Wjnh4hbYU6gry5PO7uRpQ1vk1cFcStwZlA7Q2dJDXO494eUjOx+JEE7/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BEN1fABf; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e2e2d09decso184691a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 14:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729633399; x=1730238199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TRNlHgfETbV9PWZsrG5Dbl77hFjmMLfOcM3aLCB/1g=;
        b=BEN1fABf9UP5oDLzoWoAALvFGi2r8yL9azxiV0CEVi+IOmc/XY1VG1u/8X0Qxm1iH+
         a2e0C3WV7fZ1i7zBlc7/60wkoCqVvc71BtjElcD2bVn+/W6myHRwVGSEVC8kkp4g8CQT
         FVPZuVLuVqzhE7A9U8fAwVRlZrdedL1ATdJvgsal8Ti880k2VkeBM8BJwDWyLkAM88Am
         tZHhjS8IBl9WjYjyHtp5WnSUQvi29PqzUeeIQc2X0rcRskh54sRQKlgA44WlOtKXLxfw
         IjrgvECiC7XPCbe/i5iCqzNGwvQniknmkfY+uP69G3mrLcz7WRZY5JYj0zMDpHy14OiP
         6uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729633399; x=1730238199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9TRNlHgfETbV9PWZsrG5Dbl77hFjmMLfOcM3aLCB/1g=;
        b=wj3wsegNtSWEyeyvORyxhKnlZDJuYzh8jg74VL/X/wOo7hGxgSn4eCgzvz+qJtviTr
         HC0R/AqcDsbdlI5R9FiRk4CzCJkrxMVDyJC/LROnZmLIwZJhJZMsQcmbpCkRjeJaqH/M
         TUc2ziQwOmgWYkWm91aqKVsH8iO+HSqnzyNj470P/dObiTbuURsbZEYDXNMh6KkH+ZZG
         Wat9E+M3cInevR+p31wtXGZfiJBCcH26XKbYZVr8yt26LodzR0pdD4SH/9U2uAYwL/St
         J1T5RWAyi7EfrHpjspiNqlDwVVseGZWyjYNMzCZRN36Y13s01AhiLQ6iSM241SMonFSo
         4nZA==
X-Forwarded-Encrypted: i=1; AJvYcCVHS8dGCtI14PE+iJpJG8PWExlCZBOrH1IVCDsS3+HmzIQQjeAMGHVJY8vzq6yKoSZJyKqBuJsjMuIeRcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwENSJN1bxJNk3f4hCgm1S9R+PX7btq9kljLp6U6SkVleitfDIe
	nclQnyUiNhpaOwidByZXNMdxZ3wwpdoLtvLCFtJLLlbzVXWvKvpgyj7rSOFfumXj9b05oh0CJlP
	T6UcmGScFtCuI8nWDeC4qCl+T5j24a4CPAX8r
X-Google-Smtp-Source: AGHT+IHA/ihaW8uIyp28j2yq18kymqL2kOT1y+soR0FtL2dQLmvnKXDLwCYe+yFSH9ZHxjgCJ2qkIig5+mCCWrbuZjg=
X-Received: by 2002:a17:90a:448d:b0:2e0:89f2:f60c with SMTP id
 98e67ed59e1d1-2e76a721744mr802998a91.11.1729633398336; Tue, 22 Oct 2024
 14:43:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021120013.3209481-1-elver@google.com> <20241021172058.GB26179@willie-the-truck>
 <CA+=Sn1m7KYkJHL3gis6+7M2-o9fuuzDtyUmycKnHK9KKEr2LtA@mail.gmail.com>
In-Reply-To: <CA+=Sn1m7KYkJHL3gis6+7M2-o9fuuzDtyUmycKnHK9KKEr2LtA@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Tue, 22 Oct 2024 23:42:40 +0200
Message-ID: <CANpmjNOf94nQL8YVr94L=9qXA6eHcm-AxbS+vz+Sm1aHJT2iAQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kasan: Fix Software Tag-Based KASAN with GCC
To: Andrew Pinski <pinskia@gmail.com>
Cc: Will Deacon <will@kernel.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, llvm@lists.linux.dev, 
	syzbot+908886656a02769af987@syzkaller.appspotmail.com, 
	"Andrew Pinski (QUIC)" <quic_apinski@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Oct 2024 at 19:29, Andrew Pinski <pinskia@gmail.com> wrote:
>
> On Mon, Oct 21, 2024 at 10:21=E2=80=AFAM Will Deacon <will@kernel.org> wr=
ote:
> >
> > On Mon, Oct 21, 2024 at 02:00:10PM +0200, Marco Elver wrote:
> > > Per [1], -fsanitize=3Dkernel-hwaddress with GCC currently does not di=
sable
> > > instrumentation in functions with __attribute__((no_sanitize_address)=
).
> > >
> > > However, __attribute__((no_sanitize("hwaddress"))) does correctly
> > > disable instrumentation. Use it instead.
> > >
> > > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D117196 [1]
> > > Link: https://lore.kernel.org/r/000000000000f362e80620e27859@google.c=
om
> > > Link: https://lore.kernel.org/r/ZvFGwKfoC4yVjN_X@J2N7QTR9R3
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218854
> > > Reported-by: syzbot+908886656a02769af987@syzkaller.appspotmail.com
> > > Tested-by: Andrey Konovalov <andreyknvl@gmail.com>
> > > Cc: Andrew Pinski <pinskia@gmail.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > ---
> > >  include/linux/compiler-gcc.h | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gc=
c.h
> > > index f805adaa316e..cd6f9aae311f 100644
> > > --- a/include/linux/compiler-gcc.h
> > > +++ b/include/linux/compiler-gcc.h
> > > @@ -80,7 +80,11 @@
> > >  #define __noscs __attribute__((__no_sanitize__("shadow-call-stack"))=
)
> > >  #endif
> > >
> > > +#ifdef __SANITIZE_HWADDRESS__
> > > +#define __no_sanitize_address __attribute__((__no_sanitize__("hwaddr=
ess")))
> > > +#else
> > >  #define __no_sanitize_address __attribute__((__no_sanitize_address__=
))
> > > +#endif
> >
> > Does this work correctly for all versions of GCC that support
> > -fsanitize=3Dkernel-hwaddress?
>
> Yes, tested from GCC 11+, kernel-hwaddress was added in GCC 11.
> Also tested from clang 9.0+ and it works there too.

+1 yes. From what I can tell GCC always supported
no_sanitize("hwaddress") for -fsanitize=3Dkernel-hwaddress.

Even for Clang, we define __no_sanitize_address to include
no_sanitize("hwaddress"):
https://elixir.bootlin.com/linux/v6.11.4/source/include/linux/compiler-clan=
g.h#L29

So this has just been an oversight when GCC support for KASAN_SW_TAGS
was introduced.

Having a Fixes tag for this would be nice, but I don't think we
explicitly added GCC support, and instead just relied on
CC_HAS_KASAN_SW_TAGS with cc-option telling us if the flag is
supported.

But maybe we can use this:

Fixes: 7b861a53e46b ("kasan: Bump required compiler version")

Because it's the first time we encountered issues with no_sanitize,
and bumped the required GCC version as a result. Perhaps going along
with that should have been fixing of compiler-gcc.h's definition of
__no_sanitize_address.

