Return-Path: <linux-kernel+bounces-353395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D84992D3A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2360AB20BAA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3861D3560;
	Mon,  7 Oct 2024 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GqUsdUMs"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EAE14AD17
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307696; cv=none; b=kFPDDguc6Y97cciKhpmRQy2wkXY9jjKafjw31ZAIddEI7nBQF0TLPwhjTFnIPmUTYHc8aIfI3XkK6UDtE9dXlfVURrq/g0JuHv1U/G20r5AAgXzbGgAginfRwY+yXC3lvKfL1KMTNLv/NeuaQ9O0CsL/QbtF0LB99TVQ5AeJpi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307696; c=relaxed/simple;
	bh=QYElmbYO2v7I2S+NnUwfzpgeBY70fC1omeo8a7+7xVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J05zPoYctn5TxiTHmVX9jtuk45yNLbNtzX0HSVXB0ZxlXkJecG/fEBO46NyjvDmEif3nWbwSNN+qbeYzPh8+JTM3so+ijQ4aqNEUNau8KNKbAXxXNM1pkXoUW2QDJeL/LflALmk5tketI7f1aKDn9C03MxwDh2A8Ig41CWDVxh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GqUsdUMs; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e251eda7f03so3460229276.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 06:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728307693; x=1728912493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WoCoIIdTG3gSxbgyt39obU2mZ3O4ZMNj1i8+RtkDTBk=;
        b=GqUsdUMsw8EoOz/g2DlquARXqX8frQoX7xTZNHiOtw1LDHSFiSKghfRnOfVSr1rPuQ
         VrbJWsMhzFSlkyLLcQzo+pTrsb72AVZyOkKOsh7trsmZCbLgbV/2rQb2fO/grXymw5oU
         7mwkWRqWuA6HtQxPs2CWpLewUNOeryW5xfrD3DHIsGzPSjgpHrUQrPpzemRhHXMiYsmj
         YM9TtyfnFWDv501JvbvDYl7+zsp9hbBLXtQkT9TPoMbRpgTK9YZaMe1v6EZpDXNQkW2X
         GPM/s31dIu7/qtG155vytoh540mcpmTtR2ivPTuRsqLlEZcQPm+rXA3ORlVTUDwWbK95
         hFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728307693; x=1728912493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WoCoIIdTG3gSxbgyt39obU2mZ3O4ZMNj1i8+RtkDTBk=;
        b=AhMRKgXDTsmihWI3SsiNsAYd2YYS1xFxGrf5NIQrPwE23gp/Hs92go0G2bozKiA2bO
         BzIjGQdGH1OcrwY0OOldMg9O/15BoASA99LVEXlOpWktp2MbII2is101yb5Rnu9Alw9j
         rQAMO+Isb3/CCH4ceZTFscENyrh2Emy5CtV0e5KhWG5eXihJR/fQmY45sRkZs6+c8JBX
         lhU8crkymHOEGuSTBTK+xvQevhix8BQSQc5WdeKdW2Ll07JNshHlN7Cr2HlJEMXUVkfe
         pV23iyobC3N/ulzsyg1Jp6MN6pk9Czdb1qjX3hfXfc4yh+dEBSfpuMohFrjxVL0APdMX
         efWA==
X-Forwarded-Encrypted: i=1; AJvYcCWbhC8d9Qw6K81Tpm591Mo3hlfDApf4PGi6/TbrVrDC42QXR0xr9Sd0AoHBQwHo4HANaERNKkp7IKPxAco=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTGPvPjTkMCArZB+KUhEEsUjcwRUrYhI6iHneVaEk6RFdq3rw6
	8i/Llz7nkWSi7e+4/sm83yQSJ0o8hKsevqda7hhf7MQkE3uRCtHEIxbtloloMwMgJOOd7g+V/WE
	v7oS4L2xfEGNVVJEAXSB/Pcm+vl6CNK5SJ6EW3S62W5Jd10k=
X-Google-Smtp-Source: AGHT+IHWGySCZcp9NDmU3/vV0yiG6rZxItNXPqzGEZGutNjXf9pgVysGf+iEEBM1PrJj5zM+mDLteSP5Y/qLKfThdgc=
X-Received: by 2002:a25:7b87:0:b0:e28:c6be:4ce6 with SMTP id
 3f1490d57ef6-e28c6be5345mr2280453276.28.1728307693621; Mon, 07 Oct 2024
 06:28:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp>
 <877cavdgsu.fsf@trenco.lwn.net> <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com>
 <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com>
 <20241002103830.GA22253@wind.enjellic.com> <033eb4d9-482b-4b70-a251-dc8bcc738f40@canonical.com>
 <20241004184019.GA16388@wind.enjellic.com> <CAHC9VhS0aeDB2GzxJPHN8_LDk59gT_RuRKwb26K+3SzX7SQ=3g@mail.gmail.com>
 <20241005023357.GA20577@wind.enjellic.com> <CAHC9VhSoPK7zMQjUNiHG23Je-iSmxOSdRFvp1ikqCeCxkS9zWw@mail.gmail.com>
 <20241007112158.GA10114@wind.enjellic.com>
In-Reply-To: <20241007112158.GA10114@wind.enjellic.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 7 Oct 2024 09:28:01 -0400
Message-ID: <CAHC9VhSvQEE8k7tGwH6LVhq1a3GyBrnCJ_g03MqtnQxEm26VwQ@mail.gmail.com>
Subject: Re: [GIT PULL] tomoyo update for v6.12
To: "Dr. Greg" <greg@enjellic.com>
Cc: John Johansen <john.johansen@canonical.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, LKML <linux-kernel@vger.kernel.org>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 7:22=E2=80=AFAM Dr. Greg <greg@enjellic.com> wrote:
> On Sat, Oct 05, 2024 at 12:21:31PM -0400, Paul Moore wrote:
> > On Fri, Oct 4, 2024 at 10:34???PM Dr. Greg <greg@enjellic.com> wrote:
> > > On Fri, Oct 04, 2024 at 02:58:57PM -0400, Paul Moore wrote:
> > > > On Fri, Oct 4, 2024 at 2:40???PM Dr. Greg <greg@enjellic.com> wrote=
:
> > > > > On Wed, Oct 02, 2024 at 07:27:47PM -0700, John Johansen wrote:
> > > > > > On 10/2/24 03:38, Dr. Greg wrote:
> > > > > > >On Tue, Oct 01, 2024 at 09:36:16AM -0700, Linus Torvalds wrote=
:
> > > > > > >>On Tue, 1 Oct 2024 at 07:00, Paul Moore <paul@paul-moore.com>=
 wrote:
> > > >
> > > > ...
> > > >
> > > > > The third problem to be addressed, and you acknowledge it above, =
is
> > > > > that there needs to be a flexible pathway for security innovation=
 on
> > > > > Linux that doesn't require broad based consensus and yet doesn't
> > > > > imperil the kernel.
> > >
> > > > The new LSM guidelines are documented at the URL below (and
> > > > available in the README.md file of any cloned LSM tree), the
> > > > document is also linked from the MAINTAINERS file:
> > > >
> > > > https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#n=
ew-lsm-guidelines
> > > >
> > > > The guidelines were developed last summer on the LSM mailing list
> > > > with input and edits from a number of LSM developers.
> > > >
> > > > https://lore.kernel.org/linux-security-module/CAHC9VhRsxARUsFcJC-5z=
p9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com
> > >
> > > We are intimately familiar with those documents.
> > >
> > > Our reference was to the need for a technical solution, not political
> > > medicaments.
>
> > Seeing that document as a purely political solution to the challenge
> > of gaining acceptance for a new LSM is a telling perspective, and not
> > an accurate one as far as I'm concerned.  The document spells out a
> > number of things that new LSMs should strive to satisfy if they want
> > to be included in the upstream Linux kernel; it's intended as guidance
> > both for the development of new LSMs as well as their review.
> >
> > If those guidelines are too restrictive or otherwise stifling, you are
> > always welcome to suggest changes on the LSM list; that is how the doc
> > was established and that is how we'll keep it current and resonable.
> >
> > However, if you find yourself objecting to the guidelines simply
> > because they are trying your patience, or you find that the technical
> > reviews driven by those guidelines are incorrect, but are unable to
> > properly respond in a way that satisfies the reviewer, then the
> > upstream Linux kernel may not be the best place for your LSM.
>
> The document is an embodiment of a political process, let me take a
> swing at defining what it is:

It's a shame that such a pedantic response failed to take note that
the first sentence in my original comment on the doc never claimed
there wasn't a political aspect, only that to consider it entirely, or
"purely", political is not accurate in my opinion.

Of course you're welcome to believe whatever you like about the
document, its intent, etc. as that is no business of mine outside a
mischaracterization of my own comments.  I think that's about all I've
got to say on that issue right now.

> So the path forward to address this problem, the best that we can hope
> for, is to develop an architecture that minimizes the need for
> consensus on how to implement a security architecture.
>
> Tetsuo has placed one idea on the table, we will see where that goes
> and how long it ultimately takes.

I have yet to see any patches over the past year or two changing how
LSMs are registered with the LSM framework from Tetsuo that are
acceptable upstream.

--=20
paul-moore.com

