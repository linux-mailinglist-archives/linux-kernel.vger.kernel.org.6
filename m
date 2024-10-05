Return-Path: <linux-kernel+bounces-351949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2229991836
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 18:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 202921C20E47
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 16:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2D515746E;
	Sat,  5 Oct 2024 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dJMf8OMe"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACFB14E2DA
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728145305; cv=none; b=ocgq0nuwwoWGE2CBPy/4+/xU+V5LKJDh3RcXdxjQrWm101FS54XTk0S9jXBA9saDM1l4b+cSbBafjO71yIJhI/9U489NiNFnKm5HLUfQ7j9r4DfDY/HUePY/jxr93OW4BmiM3JB3/tre689xz4iKCIoQ4gsI5do5Q2fRWOD8fHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728145305; c=relaxed/simple;
	bh=CieQIkKd5QiUkyaGk0l2c7XAKqDRw+lQNSg1vGYK8aY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8OcNxU/3PCE3HKvNo9BRTkl2Nq3NHVFcPAtQQRZr4inthB0g/BODhv3VKdzR2EyKNIAjn1kRw9wbqfDZG86XFoW+mFio7+F1kzfLMoJ1FJs6oyuv2Klzptp8I8IYXPjIne22O1uEF9s74flsaWoAwkCX76ydHM6NmEUZYr4/4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dJMf8OMe; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e25d57072dcso2732802276.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 09:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728145302; x=1728750102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=na9IuPyEFt8kAzX30ydR0TtAKYYtK7o2TPoZ/aH8lhM=;
        b=dJMf8OMejIjPyOMkBAfZnomtTkPoKB7wRfSDpuTaCB60Y03a1VMgjfLiIImpSpptGj
         AWI8IF0JD8v4y5fmCGzkRlqWBkkyOnLVsf1lSllVs2mgdIQnJ/6Z9Fj4bDdAoDjIMk3j
         q/jn41lixwPsvijHDW6gG1SeWTDuHVAXf/FTMFdcqhMk/WwjDlRUY0LKo6lPrC8FHHXO
         Y0D7FdUxGTu8ZnNLeNlK90rSbPeuKMyEHcoPgJOg1rh+I+V68VcNvBbWFxKZEI2FtbOk
         22aKlFrpq7VlEFL48XYLldSQrmi0c+SDRRY5u6v0i6vuV2qq52wOlTetWIUygY+3uHWN
         gabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728145302; x=1728750102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=na9IuPyEFt8kAzX30ydR0TtAKYYtK7o2TPoZ/aH8lhM=;
        b=aJgTNP5EkqXvE016UF3FF0LqzbTUriuRqQfmqQauYfd9jWoWA+60i9GuRv/ybBueYu
         c1DwpcHYIMmQtbUrRHAPgqvNymQDskHJUq6ZCw3QM6f1Uky6edairp4I6jhptX91OQWn
         f4RsIcSyWxiB7AQGtRZ/oe9RpnRk8lWfNPMrxoejJmxel8XdDCuK9j+RL3ChtzZnEIYA
         nudroupLDnFMJMNiwpB1ReXOORYdD9RyNlaNgPQPRZ06qHExxQ/uBWsYvk0MKa/St4Ul
         If5ceqK+l9VZiZ5QrNm8194l7MkAPV1w3p7T7eokM9pQWtwY4Tiw99emQqXaWhtgHIM9
         uEAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXa8uWR6cBXnTn0h7UF6qKCf+rs5rBVhadbumULnE9BMninXwW7l7xfuXg81GOlynGI/aNLC2F7lWSw1Es=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPGwCk7ao1OhFnRkBvZx6DAzVSKaOYP9y+JnyRXmQ2M+E2+vNS
	IJzEvg/e6nzVlu5DTunc7y8poZ88VMY9XdxHhA9KjQUziOfRGavTPm9Ut21DrlrNz6HGUJ0zvta
	j7PVW9L8WuH3bjJFyIZ5YNx7+MP/pgXnX2lAw
X-Google-Smtp-Source: AGHT+IHsjoNiUXK8FiI8rxIVKKnYGdEQlV97/yqrXcDBKtN5zyf6URnWHAcg5LXsgLAvyYNircrJYmKEgy7LOQ3e7uA=
X-Received: by 2002:a05:6902:1688:b0:e25:c0b4:f363 with SMTP id
 3f1490d57ef6-e28936bf5dcmr4937740276.6.1728145302343; Sat, 05 Oct 2024
 09:21:42 -0700 (PDT)
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
 <20241005023357.GA20577@wind.enjellic.com>
In-Reply-To: <20241005023357.GA20577@wind.enjellic.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 5 Oct 2024 12:21:31 -0400
Message-ID: <CAHC9VhSoPK7zMQjUNiHG23Je-iSmxOSdRFvp1ikqCeCxkS9zWw@mail.gmail.com>
Subject: Re: [GIT PULL] tomoyo update for v6.12
To: "Dr. Greg" <greg@enjellic.com>
Cc: John Johansen <john.johansen@canonical.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, LKML <linux-kernel@vger.kernel.org>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 10:34=E2=80=AFPM Dr. Greg <greg@enjellic.com> wrote:
> On Fri, Oct 04, 2024 at 02:58:57PM -0400, Paul Moore wrote:
> > On Fri, Oct 4, 2024 at 2:40???PM Dr. Greg <greg@enjellic.com> wrote:
> > > On Wed, Oct 02, 2024 at 07:27:47PM -0700, John Johansen wrote:
> > > > On 10/2/24 03:38, Dr. Greg wrote:
> > > > >On Tue, Oct 01, 2024 at 09:36:16AM -0700, Linus Torvalds wrote:
> > > > >>On Tue, 1 Oct 2024 at 07:00, Paul Moore <paul@paul-moore.com> wro=
te:
> >
> > ...
> >
> > > The third problem to be addressed, and you acknowledge it above, is
> > > that there needs to be a flexible pathway for security innovation on
> > > Linux that doesn't require broad based consensus and yet doesn't
> > > imperil the kernel.
>
> > The new LSM guidelines are documented at the URL below (and
> > available in the README.md file of any cloned LSM tree), the
> > document is also linked from the MAINTAINERS file:
> >
> > https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-l=
sm-guidelines
> >
> > The guidelines were developed last summer on the LSM mailing list
> > with input and edits from a number of LSM developers.
> >
> > https://lore.kernel.org/linux-security-module/CAHC9VhRsxARUsFcJC-5zp9pX=
8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com
>
> We are intimately familiar with those documents.
>
> Our reference was to the need for a technical solution, not political
> medicaments.

Seeing that document as a purely political solution to the challenge
of gaining acceptance for a new LSM is a telling perspective, and not
an accurate one as far as I'm concerned.  The document spells out a
number of things that new LSMs should strive to satisfy if they want
to be included in the upstream Linux kernel; it's intended as guidance
both for the development of new LSMs as well as their review.

If those guidelines are too restrictive or otherwise stifling, you are
always welcome to suggest changes on the LSM list; that is how the doc
was established and that is how we'll keep it current and resonable.

However, if you find yourself objecting to the guidelines simply
because they are trying your patience, or you find that the technical
reviews driven by those guidelines are incorrect, but are unable to
properly respond in a way that satisfies the reviewer, then the
upstream Linux kernel may not be the best place for your LSM.

--=20
paul-moore.com

