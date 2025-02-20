Return-Path: <linux-kernel+bounces-524407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A25A3E29C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A6031895756
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF50C2135C7;
	Thu, 20 Feb 2025 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7833T/F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5FA1D63D9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072968; cv=none; b=CONECJRzdANX9AqC4uBcAn7P/TZbdQv2TcrQFXh+IzZgfBvTEDY4eIT0wEoaQ909sxxSnv5jaMjupm0kc96BqFF8FI8UBXbDufHCveVIEZx0yJsJMpplYMTA8vqhx2yPGYAemd8niHgKOVi0WqSVO0TWL1R05SBDPBoFzDWM7HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072968; c=relaxed/simple;
	bh=NW+u9DQRTyPRUQHkr0bsPRMbYkCakUee0Cq7Wgwt8l4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J788GnskFIVzBBBQPTHwEOVIa/18XtHE42uNObCKNeS+QuHCu4hp3kCEw9mphjnt6Ffp0kdyZhjdHmiUrg9WHBCWQgCoo12o0tEL/Kx7YWxkqp9xGV8yjV+R/9XT9pFfHNS6AJRkD6CUIXNqRFePKTsrxMnhOHEPYWS5kHaHcgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7833T/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11F4C4CED1
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740072967;
	bh=NW+u9DQRTyPRUQHkr0bsPRMbYkCakUee0Cq7Wgwt8l4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P7833T/FB7olQRSy3BkWqim/bytTPbQhRvPZIDHzbn3xHvKKEvDESFJj3j6P94LfR
	 BhcGYfIaK0fdGwoS/XrRQRW9dfQxBjFJrD0Tlri4nz3lXaE1Zfm7fwyOTWgU0FSzTu
	 7d6zjoPHMHQd40Yb0dvEE+k/R+IQkX1g6KR8YDhxGw03BSLw66KdljL1V+zJA1adhX
	 O0NejxugUuZey1AuVKrMKOTSvHL0RUk3QXCWDWP5kMK5/JTOYaD7eN/+K4Mlp7Fj6u
	 cx1cNYuNMs3ZErcHfIGk96zoO3auHoKI1p3X2GgWC/z+nQafU2Fv3I4bBgMJ49TbtJ
	 WYbHQxuUK2jiw==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3076262bfc6so12573861fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:36:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQI4WuZmWyH4PUcyuzeO0my3K23W7OwOm7EhhqqoMypGIJtaJatof5f5KuRYRvs0evZYTYV9NqIWCf2Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv31Cb17fu4/n4I70uohKGvb1hvPO0WS+Q8Lxi5pQ+6/8dRpcx
	Rba1/hpzKXWB/lZPziO0rJQSkVG+a0HVx491vQLgUA9gbbFC96TUlsqSqrmqAQo/4pMmr0QK9mv
	an2kP87hNCd3NVB1ziaL3U04UG6U=
X-Google-Smtp-Source: AGHT+IGQtGLgU3DBuP26uw1NyqOdPNADpIcwsjOKt4j7qIzlm/NrmjdohNhmlG5xVn5Ox3dd2HqQY2Pm8fvNxZ7PooM=
X-Received: by 2002:a05:6512:ac2:b0:542:213f:78fd with SMTP id
 2adb3069b0e04-5452fe86927mr8218748e87.40.1740072966246; Thu, 20 Feb 2025
 09:36:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123190747.745588-1-brgerst@gmail.com> <Z7RRZ0jdqsrADMm0@gmail.com>
 <CAFULd4Z_QoOLKCOawyeFtRe6V4+oaaGxfQxav9dS-Di-Ne7tfw@mail.gmail.com>
 <Z7XE0P6ZFHxtlYXw@gmail.com> <CAMzpN2gyhEnYsimxLhLNPc4HTpVdRGTiBfm9pXiFTL6_3-O=sg@mail.gmail.com>
 <CAFULd4ZQ8VoKvQ7aOgcfeLNROM4-rDYn=wHo=FYMO8ZkuQeSAQ@mail.gmail.com>
 <CAMj1kXFgfbLqVkcs2T8QHRKKJ0X7+mLd-bNjricfd_niY-dxRA@mail.gmail.com>
 <CAFULd4aYjnWzWaN8WA0LetN1Li7F8MY3qnxbhY8=tNFxqHCP1w@mail.gmail.com>
 <CAMj1kXGG4J76o17d=e4jv-5jjzcSGyZdKRcNNB17SkCqD6+8qQ@mail.gmail.com> <CAMzpN2h=Mc_7MNg5RiqxEvchV_BGAiThG4a5_Xt_HHB=0+vmEg@mail.gmail.com>
In-Reply-To: <CAMzpN2h=Mc_7MNg5RiqxEvchV_BGAiThG4a5_Xt_HHB=0+vmEg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 20 Feb 2025 18:35:55 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHfg5gAnrnEMb-6dwN_PY3KycjY__JL=exgtWK9q3=XWA@mail.gmail.com>
X-Gm-Features: AWEUYZnCWODrVMkwCf9Kykdv13lK6muPB1_H2bGEDjbRsZroSlujP2o6OttCEcE
Message-ID: <CAMj1kXHfg5gAnrnEMb-6dwN_PY3KycjY__JL=exgtWK9q3=XWA@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] x86-64: Stack protector and percpu improvements
To: Brian Gerst <brgerst@gmail.com>
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Feb 2025 at 18:24, Brian Gerst <brgerst@gmail.com> wrote:
>
> On Thu, Feb 20, 2025 at 5:52=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> =
wrote:
> >
> > On Thu, 20 Feb 2025 at 11:46, Uros Bizjak <ubizjak@gmail.com> wrote:
> > >
> > > OTOH, we could simply do it your way and put stack canary at the
> > > beginning of pcpu_hot structure, with
> > >
> > > static_assert(offsetof(struct pcpu_hot, stack_canary) =3D=3D 0));
> > >
> > > for good measure.
> >
> > I think this would be the most straight-forward if there are no other
> > locality concerns this might interfere with.
>
> I'd prefer it at the end of pcpu_hot, that way the disassembler
> doesn't latch on to the __stack_chk_guard symbol when referencing the
> other fields of pcpu_hot.
>

__stack_chk_guard would no longer exist, only __ref_stack_chk_guard,
which would be equal to pcpu_hot. We could just call that
__ref_pcpu_hot instead if it might cause confusion otherwise. (We
can't use pcpu_hot directly in -mstack-check-guard-symbol=3D for the
same reasons I had to add the indirection via __ref_stack_chk_guard)

