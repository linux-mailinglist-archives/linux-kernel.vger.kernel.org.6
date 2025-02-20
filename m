Return-Path: <linux-kernel+bounces-524442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4973CA3E331
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DF8717D739
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C8E213E7F;
	Thu, 20 Feb 2025 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJy/Cpwo"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569691FF1AC
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740074371; cv=none; b=CIHus0TnKJ6jbdvVq6wb7G/IFPxxfarZJa+nn8neSXad8GqBmTnpI+Ban7HN3FNawuPdzGHXxX7s9hIOvYVMFkDUyOEY9P6gVyeQhgOYSIf0FcFllmoWqMpIYQfO34XFE641vXtWN0TrDjWrLsXyGR9PUx2Fx1j9hPVSs8dQoOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740074371; c=relaxed/simple;
	bh=LGcWROlFBLdeVan16+vOMHWLhfhEFSSmk96G5ovRHgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q0dAyJYfp9grvBt0YIlbZQpMJ6bAv4B4XMIwHkTbGuDGRo1lDxLoBzrzoxqC9M8Ew+TB1Ukks/qHGGQDgMKZ5aylFCbeCFrGkMTYXSvsMATFLkwk2AASOJK1HvW+rLtXURuScdj0GNqeyZIptwXYFwnipEji7zux0ZG8xJcCigQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJy/Cpwo; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30761be8fa8so12636961fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740074367; x=1740679167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOjy6lwz4qvzyhozebZn6Ny8b2zY4s9PrNznDcqT9yg=;
        b=RJy/CpwoKGDr3WTR6W3ieFgLfDGzl5TBMesPYrR2euBCWfW2xw2uI6l9m+KldzDsF8
         8doEENXe0pjv2KwKfrf9Kea3zMKjxXLhR/3959HkYrMtk44sjFKb7qkNYdbPCRdK+uO/
         e28/9AiccsZt0RH0upnyKcMv++TeCaDqeoPz+tBiyh2ATTzstAzkjoWm+e7C3GOlnAbU
         g9joNkjeFnwBa/btiEqt2aPcq4lYHmHbGQ5oH1eYALx/cIkvdpemfM8Cw31u3WpwYeg2
         wJaeRxqQhGV+ZJPxPdL1z1ZjNFBCVkPFsAUYA1t9bUJ4O0FoYQYPE8e34qGfBaLqLyOt
         uSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740074367; x=1740679167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOjy6lwz4qvzyhozebZn6Ny8b2zY4s9PrNznDcqT9yg=;
        b=LWQyWOaClNYHXx7StnydhR08DVRrzwW1P/oIjOi9gJ9VDkFOuw5D9GArWYVSg1mu47
         TB1Ggyt/I+VdgbOr8Q9sK+aIRzKd6B5+Mqx/eC+8+YRmUe9cD7C0ZYTijvwMWflQ8HvZ
         ztinSTJ2QPSVI3wl+HfGHTrHkN7DQNbtDA1J+xbrgleeZ9F+aClagiEeIrQ+2pIrNBeC
         iDKcUSvUfhl86xrXpeoSybzkat6Gkuqaeu7zDr1oLokoB3GReQE80YoM70gbLz0Qpm5B
         3KvnXQmKnmh05EV/09iDUuFI8TKk7kOdCNPTXz0R/KRAk1MsGirW4QUCmU3jGszIYUjL
         NBvA==
X-Forwarded-Encrypted: i=1; AJvYcCWD49HaAU7UHK28D/XVXbCu9mE0TikT6Rku8lMgoK6k0XMGoiyGFUDeVWIfHk99kbcI6wAUFWa/MjnXRos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ssYwztkPkfT8trM/37n0Tfhd5FXrNGuB8ENpRS4QPIMl315w
	fSp7aGbhnMkAL9DgG5HTrAD5gzbNbwwa9GtH7IvRl11T/NnbCKJbl/LIuJJNfLEelLTMEifzsmz
	3/Ti8i5HqDEhdxF1v/dlIqtAICw==
X-Gm-Gg: ASbGnctiD7IE2YiReC1bRkiJztYqAeGNzJM4gYfHptHatRnKqLyZLDjYh6I8b6HkEaD
	Wrm6aLe5JZrHV4nfSQulv3TsJJm6LHhHVrC/q2fUr63t2pHUyDhjC3vKbQQI+pITXH/rZs1pckY
	eLefJy+pmZ28Q=
X-Google-Smtp-Source: AGHT+IGWnES0EL+tZSgMOsr+E9D4/sr+AH3VUqOafOn1oDRyW9eOBThS4NBAHguSqxiluPi6XyjnqJbWMGfwtbFKPJk=
X-Received: by 2002:a05:6512:4020:b0:545:2fa9:8cf5 with SMTP id
 2adb3069b0e04-5452fe93333mr9568223e87.49.1740074367202; Thu, 20 Feb 2025
 09:59:27 -0800 (PST)
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
 <CAMj1kXGG4J76o17d=e4jv-5jjzcSGyZdKRcNNB17SkCqD6+8qQ@mail.gmail.com>
 <CAMzpN2h=Mc_7MNg5RiqxEvchV_BGAiThG4a5_Xt_HHB=0+vmEg@mail.gmail.com>
 <CAMj1kXHfg5gAnrnEMb-6dwN_PY3KycjY__JL=exgtWK9q3=XWA@mail.gmail.com> <CAMzpN2iK97iWVH7+c2YqB_66sfXdKnmcyQN7QxtBq-HgD5KJ=A@mail.gmail.com>
In-Reply-To: <CAMzpN2iK97iWVH7+c2YqB_66sfXdKnmcyQN7QxtBq-HgD5KJ=A@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Thu, 20 Feb 2025 12:59:15 -0500
X-Gm-Features: AWEUYZlUOHlFW8wVgnpXSkl2OvMOEAYZ96nPwOMs2QpNshrvn6PMy5wy-omKc8U
Message-ID: <CAMzpN2gvzVq9ASD7UEooMyH9Er0TpJ8dgeggWnBvZEMdy_4UpQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] x86-64: Stack protector and percpu improvements
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 12:47=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wr=
ote:
>
> On Thu, Feb 20, 2025 at 12:36=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org>=
 wrote:
> >
> > On Thu, 20 Feb 2025 at 18:24, Brian Gerst <brgerst@gmail.com> wrote:
> > >
> > > On Thu, Feb 20, 2025 at 5:52=E2=80=AFAM Ard Biesheuvel <ardb@kernel.o=
rg> wrote:
> > > >
> > > > On Thu, 20 Feb 2025 at 11:46, Uros Bizjak <ubizjak@gmail.com> wrote=
:
> > > > >
> > > > > OTOH, we could simply do it your way and put stack canary at the
> > > > > beginning of pcpu_hot structure, with
> > > > >
> > > > > static_assert(offsetof(struct pcpu_hot, stack_canary) =3D=3D 0));
> > > > >
> > > > > for good measure.
> > > >
> > > > I think this would be the most straight-forward if there are no oth=
er
> > > > locality concerns this might interfere with.
> > >
> > > I'd prefer it at the end of pcpu_hot, that way the disassembler
> > > doesn't latch on to the __stack_chk_guard symbol when referencing the
> > > other fields of pcpu_hot.
> > >
> >
> > __stack_chk_guard would no longer exist, only __ref_stack_chk_guard,
> > which would be equal to pcpu_hot.  We could just call that
> > __ref_pcpu_hot instead if it might cause confusion otherwise. (We
> > can't use pcpu_hot directly in -mstack-check-guard-symbol=3D for the
> > same reasons I had to add the indirection via __ref_stack_chk_guard)
>
> That works for me.

Maybe not.  One quirk of how GCC implements this is that
-mstack-protector-guard=3Dglobal (used by !SMP builds) ignores the
-mstack-protector-guard-symbol option and always uses
__stack_chk_guard.  That makes things more challenging.


Brian Gerst

