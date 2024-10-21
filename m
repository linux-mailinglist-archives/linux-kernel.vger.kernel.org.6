Return-Path: <linux-kernel+bounces-374850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3145B9A7112
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62022824FF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FD01EF090;
	Mon, 21 Oct 2024 17:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V46CZgB5"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79211CBEA1
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 17:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729531773; cv=none; b=t9dQ+YVfFtJK6lfbQ8x7B5fklWJ807zy1LrR2SKfBqB+lTIZvDLLqw4CiL5zZveJo7lDxA2sn5ZGkKLyODQ5Xi4YlNeYU+WHzgfkxsU/CkYLBzKdHe+8e+fehtI6e2sKCf2/Mp/PPoZRqvUym7D2L2TR1JdH8ulUPp0lMAwuweA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729531773; c=relaxed/simple;
	bh=lec2tidZmup8h1DfBg1pmUD/aaxIOPcPqf2J0RzEw5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iW9vyf974Y1g2HhyuH+h4qs9XAw2zHL38uA8GzlcI9/Np/mztd+s51zyrcrclDguD9arrkO43AQWxLEItttsagxHHKJhMECu3byfbHCjoY5ancpu4p33rYOLs1Z4YnwDMJxeiPbLNkfJU6FM6vEVi+rew3dzhOQyb/v+8Wup0Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V46CZgB5; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7eb00dc77f1so294233a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729531771; x=1730136571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBMMpOhM7o/sGaQ+IgPO+fXmm5Xj7pn8re9uxcPeOlc=;
        b=V46CZgB580gsVqESA5CaGT3T7JcOnktP6LrNzzuiKNDwMjOno8/qJs0BN6Osux1Q0s
         vT1eRP7bFEKfx0Fx9kd12vHBOqhe5N/amUij5aKXs+Y8AhnQF5MOwinpWI9v+iy7HcpH
         ywQKx8EZPnKi+4KpTfE8mate5GYH8Z03BdrBKjtDcY281gsd8P4zDY64YuJFe8RJdMDO
         ue2GYZ17iT2pQ33FE75SdFH3PZKsUps8IHNRU7rultVu5iZWv8vFFwhrf+5sKRCez8qa
         LodF4Mudsnl3mpH+loMj1oMSxGNJbfATQvDI2YLP9n2/cDOmcY6oFteXukke5o5CISs2
         GazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729531771; x=1730136571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBMMpOhM7o/sGaQ+IgPO+fXmm5Xj7pn8re9uxcPeOlc=;
        b=bT07cvqVdF8NoAtaELasR51OTiaVIiqsyQK5Jh7EOfn0uMePXg8HDcBELYLWnIKIc1
         WNxl2FmRWnlpdka26/G056V6acdBEnhexhBUiZJpMKXLlf9xtJYcxEg6L+pH/GWso4re
         Z2amV8ZYO6PPEXbXUuJF2TBkJa9NC6mg+iREdYOi8kD9aargjmsxRyjbM9kKti/KuAvk
         U0VCweQnLaeDqQkdF86jraL5OCXByGF9qDAMsKItbu4TJuZbM1d1PQ0bLfsm59ZIk+kO
         9WllplqBHtZtTd7m8eMJ5eY65ONoAiycbJf6Fvtut+tkiVjY6AwkHo0KsXlyni5mgzQf
         tQWg==
X-Forwarded-Encrypted: i=1; AJvYcCUxktk0aCe46qR/msGEBCNjdYGEOGaDBUJYwA59e8KJWFexUQYH/JujFhF+cRvxbYf4fTu8VC4g0XsuWLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7XOp4vUSGdNwuXS4zEVFNQvzuiKZVVE6ZkSTN3lGrhFhJHu99
	BIC4F241x2mkuHNmN+ApXZCEERjN1QfqUYlQkmivl/zX9FdzMP2reAg7b9HmJiDaRKyCi7a/Uhf
	WNYsziIVor7KvxCLF1cgfhnYCYrA=
X-Google-Smtp-Source: AGHT+IHVW3rUf06tmEeKO+rmrJFBlUZBUoTVTxPBQTnYQLB2bqCxcMyKhBddR2jNjdOODAjhxcK4Jt0sluAEimugIUw=
X-Received: by 2002:a05:6a21:118e:b0:1d2:f124:a1cb with SMTP id
 adf61e73a8af0-1d92c4a5373mr17184971637.9.1729531771096; Mon, 21 Oct 2024
 10:29:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021120013.3209481-1-elver@google.com> <20241021172058.GB26179@willie-the-truck>
In-Reply-To: <20241021172058.GB26179@willie-the-truck>
From: Andrew Pinski <pinskia@gmail.com>
Date: Mon, 21 Oct 2024 10:29:18 -0700
Message-ID: <CA+=Sn1m7KYkJHL3gis6+7M2-o9fuuzDtyUmycKnHK9KKEr2LtA@mail.gmail.com>
Subject: Re: [PATCH 1/2] kasan: Fix Software Tag-Based KASAN with GCC
To: Will Deacon <will@kernel.org>
Cc: Marco Elver <elver@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, llvm@lists.linux.dev, 
	syzbot+908886656a02769af987@syzkaller.appspotmail.com, 
	"Andrew Pinski (QUIC)" <quic_apinski@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 10:21=E2=80=AFAM Will Deacon <will@kernel.org> wrot=
e:
>
> On Mon, Oct 21, 2024 at 02:00:10PM +0200, Marco Elver wrote:
> > Per [1], -fsanitize=3Dkernel-hwaddress with GCC currently does not disa=
ble
> > instrumentation in functions with __attribute__((no_sanitize_address)).
> >
> > However, __attribute__((no_sanitize("hwaddress"))) does correctly
> > disable instrumentation. Use it instead.
> >
> > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D117196 [1]
> > Link: https://lore.kernel.org/r/000000000000f362e80620e27859@google.com
> > Link: https://lore.kernel.org/r/ZvFGwKfoC4yVjN_X@J2N7QTR9R3
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218854
> > Reported-by: syzbot+908886656a02769af987@syzkaller.appspotmail.com
> > Tested-by: Andrey Konovalov <andreyknvl@gmail.com>
> > Cc: Andrew Pinski <pinskia@gmail.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  include/linux/compiler-gcc.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.=
h
> > index f805adaa316e..cd6f9aae311f 100644
> > --- a/include/linux/compiler-gcc.h
> > +++ b/include/linux/compiler-gcc.h
> > @@ -80,7 +80,11 @@
> >  #define __noscs __attribute__((__no_sanitize__("shadow-call-stack")))
> >  #endif
> >
> > +#ifdef __SANITIZE_HWADDRESS__
> > +#define __no_sanitize_address __attribute__((__no_sanitize__("hwaddres=
s")))
> > +#else
> >  #define __no_sanitize_address __attribute__((__no_sanitize_address__))
> > +#endif
>
> Does this work correctly for all versions of GCC that support
> -fsanitize=3Dkernel-hwaddress?

Yes, tested from GCC 11+, kernel-hwaddress was added in GCC 11.
Also tested from clang 9.0+ and it works there too.

Thanks,
Andrew Pinski

>
> Will

