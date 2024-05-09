Return-Path: <linux-kernel+bounces-175016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432D18C191F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628811C21D03
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F96129A78;
	Thu,  9 May 2024 22:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XbODzUHS"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2F51292E6
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 22:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715292090; cv=none; b=ujYznMJOWt/9LiGsMeVnif2GL/w/1Hmuh25fhg1jXHL16oaPw7mcU20qGy4dPp4aG8F2ArHHEgMSYqvRsfPSKWnlNvCVib1Sh3c2sJiHV5Ef8/ZUWgFVwlFnj0Yhc9CVZ3OuQVNypRgszeFmf4SESamzgKA00YtkTTg9+rMHlmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715292090; c=relaxed/simple;
	bh=eTFM0lR+pV19/1K9nIEi52f8o0e9EXmBU+po3xooddM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJGlKqqJY+fRi84EF6079lquYF8tLsi8sEfppAay3NP4iYDR66kwrOr76W7SCE1RdwCbEqwSEZSARwZCfvNhcI71TCMmagVIJJaqWtpijHAJuJuQNOwmVVnhaCVNHvaRUSz0UVhPhgydYwhU6Y6AEJVvWIP9swVFNuY5tcaHXzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XbODzUHS; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5aa28cde736so805777eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 15:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715292087; x=1715896887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZVCnwpSsnSCs9fQXtvRvnFquz+a/pLR0kXJSXFyRYE=;
        b=XbODzUHSPCAZhBqt2SCVvCf2VPGhkSGFf6gmm8wKt+o8qaLjb9NSt4jLzgQeNuTtXZ
         8ZFtmeiPDNW+yj5NFZcI3lKGFJ415mhpt633jFbucX/CfxJnIShu8DlonsMefnwe8kr6
         PWb/fJyhMm9NSMjE4Ockm2DWyRVlchgwTSundHb7eG1qTEKTrZv5lI59fpvYw2vGoFv9
         HhyS++rud5bRn3Tq5oYNEz8IOeeKc3viailTQ8ONN9z737Kpx7p3O3ZxTQ2NI/bYNcac
         vp36tYTk6jHTdYGRlLzdjmWYEHnhdVwZWfHc2oDjhut6qSH591SLoILXDINjOlyjjdV3
         NKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715292087; x=1715896887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZVCnwpSsnSCs9fQXtvRvnFquz+a/pLR0kXJSXFyRYE=;
        b=A/pwlTjXLgZKMcacFXnOo4AbODw8Fc3RDi6TxnmbBXU8ea+FcaxJ/Trk/Ci4+22RtW
         4WMbtZ3OZ70bhXRuOiRjTbs1uhusaOgZ58sbJg2aoh83fWKGprj8fEv1NFBL7Mr6HA1i
         K1WSTPfLlKsr1r+IKAKkR+zEvvWdmoQoWnKwSvrqnNf/mfUK3oCNKhmOF7x2OG4ew8EA
         rN5Ao2/+VokDqV2KsV6O/B+smk7/ondiQIJvFBggzLpehGDhhSwgJTWNUjl769uj2M+/
         HdQ/uPARSFPHbFyhraKDn0kjJePUFtmjng63v/ZMyM389bntZ+5wWyynPo4D2pr6p4PK
         bI3A==
X-Forwarded-Encrypted: i=1; AJvYcCUSp0n/Sh0mgfGu+mMFWAudVQ9+P89QWW9CEwvvu5vNT9gdMr5tjxkXGmovlrgKbnU/7mXmFSAZgciyMCXhQUir/q2AAJBZv14UYGbk
X-Gm-Message-State: AOJu0Yz4uJPfTXPRtJYeIh1s/qBU60GPysvXNT7kkOizryHV4sm6iaph
	dNr1oOU+78PZrfoXaU1EE8EbH7Nx8gWLsU/2zKszg6mvrtI94DWbGYd5JXjbrlREs7DF9wp349n
	DOxaUXca+5sdfpi/vSoU780FsB3LzWC8iQ/+w
X-Google-Smtp-Source: AGHT+IFpfKHeAJ/sLsyM3Lqv/tlwttE2S4Wv1c320CoQA2YSLvZHSj8nXYLIh/V4Chy5bfd4fN2VsBQBoGoTLlan748=
X-Received: by 2002:a05:6358:7e41:b0:17e:bfb8:dd86 with SMTP id
 e5c5f4694b2df-193bb401498mr92029755d.3.1715292087108; Thu, 09 May 2024
 15:01:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506-b4-sio-scrollback-delta-v1-1-4164d162a2b8@google.com> <f7775510-09d8-41ef-97b2-0457e721a9ec@kernel.org>
In-Reply-To: <f7775510-09d8-41ef-97b2-0457e721a9ec@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 9 May 2024 15:01:14 -0700
Message-ID: <CAFhGd8qkYYQZi37Tsj-V5pN5S4xhcyUeAZj1of2kTXG+EtVMgg@mail.gmail.com>
Subject: Re: [PATCH] tty: vt: saturate scrollback_delta to avoid overflow
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 8, 2024 at 11:31=E2=80=AFPM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
>
> And what is actually broken, given signed overflow is well defined under
> the -fwrapv wings?
>

well-defined code can still be broken.

We want to better safeguard against accidental overflow as this is the
root cause of many bugs/vulnerabilities. So, in this spirit, we
recently enhanced the signed-integer-overflow sanitizer and its
ability to function with -fwrapv enabled [1]. On the Kernel side of
things, Kees' tree [2] has done a lot of the groundwork to get this
sanitizer enabled and less noisy.

WIth all that being said, my solution to this problem in this
particular instance is not the most elegant, as you rightly pointed
out.


> > diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> > index 9b5b98dfc8b4..b4768336868e 100644
> > --- a/drivers/tty/vt/vt.c
> > +++ b/drivers/tty/vt/vt.c
> > @@ -308,7 +308,14 @@ static inline void scrolldelta(int lines)
> >       /* FIXME */
> >       /* scrolldelta needs some kind of consistency lock, but the BKL w=
as
> >          and still is not protecting versus the scheduled back end */
> > -     scrollback_delta +=3D lines;
> > +
> > +     /* saturate scrollback_delta so that it never wraps around */
> > +     if (lines > 0 && unlikely(INT_MAX - lines < scrollback_delta))
> > +             scrollback_delta =3D INT_MAX;
> > +     else if (lines < 0 && unlikely(INT_MIN - lines > scrollback_delta=
))
> > +             scrollback_delta =3D INT_MIN;
> > +     else
> > +             scrollback_delta +=3D lines;
>
> NACK, this is horrid.

Agreed.

Does an implementation like this look any better?

static inline void scrolldelta(int lines)
{
        ...
        /* saturate scrollback_delta so that it never wraps around */
        if (lines > 0)
                scrollback_delta =3D min(scrollback_delta, INT_MAX -
lines) + lines;
        else
                scrollback_delta =3D max(scrollback_delta, INT_MIN -
lines) + lines;
        schedule_console_callback();
}

Accounting for the possibility of both underflow and overflow is what
is making this code a bit bloated but if this new approach looks good
enough I can send a v2.

>
> Introduce a helper for this in overflow.h if we have none yet.

We have these but for unsigned (size_t) types. I'm open to adding
signed_saturating_add(addend1, addend2, ceiling, floor) or something
similar.

>
> thanks,
> --
> js
> suse labs
>

[1]: https://github.com/llvm/llvm-project/pull/82432
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=
=3Ddev/v6.8-rc2/signed-overflow-sanitizer

Thanks
Justin

