Return-Path: <linux-kernel+bounces-187804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B72AC8CD8C9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 18:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455B51F2313A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A188528E0F;
	Thu, 23 May 2024 16:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="b8C5NO4i"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1231D179B7
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716483392; cv=none; b=RZQGIN0YZhmvfTtumiRgKnGzk1fHRCSlxgUTocdmhIJn7P3BypE4DfH+aebSMgpzPk/137SVOliDo84XRPJIa4bDRt6qRZTr0tJ3r6yHovfmaQfipzJjvkzc8E/gPSJdF2C/7mffFmFEb5WLxX/Z4vUjYC7TTdQso/suFAzj0gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716483392; c=relaxed/simple;
	bh=YfD9x1g6qsIKtJyoOpnGZso8OyH0pVAlCijDbTqHqaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vDw97DsQ36OXhYFrsJXOFGvrqkPEeTbPEePHmEkttGbhnGiHrtwM0QhtOXIqVqWyHnVcsVoOuOiej5APpOsB0eiaXH51YnGAncWtvbwpq1+K97/sV/D5yPYdJrhj0gWMUpqhdIs5OSmuZ0pLwJiMhPKW7yEKkHmWrgk9rvz3NVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b8C5NO4i; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso502a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 09:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716483389; x=1717088189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPAtRznjngEuylGql36bL+F2W4ou0WGvI25eR8lDSc8=;
        b=b8C5NO4iduiWjxm71nzJZLgi88DD8541MOkOSUPEBDJKowTL5GFeGu1n1GKzV+Z7TQ
         hdmAOQvAiMmrX+55MZpVV3WeZzKKzIyyoxn79lHWxuA4NjNkPF4/xhLR8ZMp32YvMVeN
         gKq8irrRv2UiQ8jfLTXyYMjJ8MH7MGSMDPoJJkA2DpeRA+nyswxVYEsRYfBjVnBUtw9E
         6PJWrwhE8q6k+wTzgAKA33pRIzt6v8OU4h/xiKiQ4mm3shOXTEKj7r/P+OW+egavfkK2
         YGned/WJ0SFNLoXd6MtBpoCMMqC/ULaC8JVXU7usfDLQw752aKYtA46A/getWskBvWsO
         mKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716483389; x=1717088189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPAtRznjngEuylGql36bL+F2W4ou0WGvI25eR8lDSc8=;
        b=n1mpLZWc2nZb1FbJX/FdjGwEIIW3pQdgMV9ucMu3FRsEweHq8V2gkB1de+MsC778Ku
         dzmJsCAIHDV8PbAG7vakUujcfqlI7oHlWoJyboNsqnPUrjStad1NUHBNXkdsWNwtIJT+
         BVDirkf3d7i+7vf922IO0+CzBBh2rM4Lm15nkWc2IqnFPoXcyE/4p6QtAegs8xj23dqA
         gAbBoRq19pTcIVoqmhg+OYc+/S96zviLxLMcMdmgkEM2E42TTA6ApeBqcvKbaRO6cZWp
         Q0uGXxpgjav9Bxrbi7hjFeHNf+Si/bHm++f3/qOKaWKOHOWZmzIYOiR5GhlWNsBKiSmC
         6USQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1P1nBSCeAwv+j7qDff1c/fqubtI5tNTvPJuadNUFVWojPUv3ZX4TiTlKGcuJ2b6qIYiXpsZEG7mkGPTh/0QQjIxJKg+w3YA5txZNF
X-Gm-Message-State: AOJu0Yx+fDYxOm18tVOaxgFLWpLTy72oaqcVL55r32wPm1imSISeLoVh
	umjbQTBHdtCVFZ5U+Kjs68Js2QtM2UBWsWBV0OCeDafJKCzKnHihDWa6fp0ypsQVnpRcdpxNFJF
	bNCwlbf/iToPF8WYRgFPJZjJ+TDX+hHsZs/8+
X-Google-Smtp-Source: AGHT+IEKxt/I7KxNLtu/2LXDIV7NhlcEwSk7jCcefTmMVoqPfxnhzgRDeNpi0+DdXteBBS3nmRzXpW9VoLpXJ+m+V9I=
X-Received: by 2002:a05:6402:5209:b0:576:68c7:f211 with SMTP id
 4fb4d7f45d1cf-57843f5afc9mr236334a12.6.1716483389025; Thu, 23 May 2024
 09:56:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513191544.94754-1-pobrn@protonmail.com> <CALmYWFt7MYbWrCDVEKH4DrMQGxaXA2kK8qth-JVxzkvMd6Ohtg@mail.gmail.com>
 <20240522162324.0aeba086228eddd8aff4f628@linux-foundation.org>
 <1KDsEBw8g7ymBVpGJZp9NRH1HmCBsQ_jjQ_jKOg90gLUFhW5W6lcG-bI4-5OPkrD24RiG7G83VoZL4SXPQjfldsNFDg7bFnFFgrVZWwSWXQ=@protonmail.com>
 <08450f80-4c33-40db-886f-fee18e531545@app.fastmail.com> <CALmYWFv9dK5ZPzwx3WCLMXzuuDadvFxh84+8rrT7aL105+ZZAQ@mail.gmail.com>
In-Reply-To: <CALmYWFv9dK5ZPzwx3WCLMXzuuDadvFxh84+8rrT7aL105+ZZAQ@mail.gmail.com>
From: Jeff Xu <jeffxu@google.com>
Date: Thu, 23 May 2024 09:55:49 -0700
Message-ID: <CALmYWFtedtEnfGFp5DYacHYOE7+GB8yoQC-iyw7JAxySmgQ7vw@mail.gmail.com>
Subject: Re: [PATCH v1] memfd: `MFD_NOEXEC_SEAL` should not imply `MFD_ALLOW_SEALING`
To: David Rheinsberg <david@readahead.eu>, Aleksa Sarai <cyphar@cyphar.com>
Cc: =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	dmitry.torokhov@gmail.com, Daniel Verkamp <dverkamp@chromium.org>, hughd@google.com, 
	jorgelo@chromium.org, skhan@linuxfoundation.org, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 9:20=E2=80=AFAM Jeff Xu <jeffxu@google.com> wrote:
>
> On Thu, May 23, 2024 at 1:24=E2=80=AFAM David Rheinsberg <david@readahead=
eu> wrote:
> >
> > Hi
> >
> > On Thu, May 23, 2024, at 4:25 AM, Barnab=C3=A1s P=C5=91cze wrote:
> > > 2024. m=C3=A1jus 23., cs=C3=BCt=C3=B6rt=C3=B6k 1:23 keltez=C3=A9ssel,=
 Andrew Morton
> > > <akpm@linux-foundation.org> =C3=ADrta:
> > >> It's a change to a userspace API, yes?  Please let's have a detailed
> > >> description of why this is OK.  Why it won't affect any existing use=
rs.
> > >
> > > Yes, it is a uAPI change. To trigger user visible change, a program h=
as to
> > >
> > >  - create a memfd
> > >    - with MFD_NOEXEC_SEAL,
> > >    - without MFD_ALLOW_SEALING;
> > >  - try to add seals / check the seals.
> > >
> > > This change in essence reverts the kernel's behaviour to that of Linu=
x
> > > <6.3, where
> > > only `MFD_ALLOW_SEALING` enabled sealing. If a program works correctl=
y
> > > on those
> > > kernels, it will likely work correctly after this change.
> > >
> > > I have looked through Debian Code Search and GitHub, searching for
> > > `MFD_NOEXEC_SEAL`.
> > > And I could find only a single breakage that this change would case:
> > > dbus-broker
> > > has its own memfd_create() wrapper that is aware of this implicit
> > > `MFD_ALLOW_SEALING`
> > > behaviour[0], and tries to work around it. This workaround will break=
.
> > > Luckily,
> > > however, as far as I could tell this only affects the test suite of
> > > dbus-broker,
> > > not its normal operations, so I believe it should be fine. I have
> > > prepared a PR
> > > with a fix[1].
> >
> > We asked for exactly this fix before, so I very much support this. Our =
test-suite in `dbus-broker` merely verifies what the current kernel behavio=
r is (just like the kernel selftests). I am certainly ok if the kernel brea=
ks it. I will gladly adapt the test-suite.
> >
memfd is by default not sealable, and file is by default sealable,
right ? that makes the memfd  semantics different from other objects
in linux.
I wonder what is the original reason to have memfd  this way?

Another solution is to change memfd to be by-default sealable,
although that will be an api change, but what side effect  will it be
?
If we are worried about the memfd being sealed by an attacker, the
malicious code could also overwrite the content since memfd is not
sealed.

> > Previous discussion was in:
> >
> >     [PATCH] memfd: support MFD_NOEXEC alongside MFD_EXEC
> >     https://lore.kernel.org/lkml/20230714114753.170814-1-david@readahea=
d.eu/
> >
> > Note that this fix is particularly important in combination with `vm.me=
mfd_noexec=3D2`, since this breaks existing user-space by enabling sealing =
on all memfds unconditionally. I also encourage backporting to stable kerne=
ls.
> >
> Also with vm.memfd_noexec=3D1.
> I think that problem must be addressed either with this patch, or with
> a new flag.
>
> Regarding vm.memfd_noexec, on another topic.
> I think in addition to  vm.memfd_noexec =3D 1 and 2,  there still could
> be another state: 3
>
> =3D0. Do nothing.
> =3D1. This will add MFD_NOEXEC_SEAL if application didn't set EXEC or
> MFD_NOEXE_SEAL (to help with the migration)
> =3D2: This will reject all calls without MFD_NOEXEC_SEAL (the whole
> system doesn't allow executable memfd)
> =3D3:  Application must set MFD_EXEC or MFD_NOEXEC_SEAL explicitly, or
> else it will be rejected.
>
> 3 is useful because it lets applications choose what to use, and
> forces applications to migrate to new semantics (this is what 2 did
> before 9876cfe8).
> The caveat is 3 is less restrictive than 2, so must document it clearly.
>
> -Jeff
>
> > Reviewed-by: David Rheinsberg <david@readahead.eu>
> >
> > Thanks
> > David

