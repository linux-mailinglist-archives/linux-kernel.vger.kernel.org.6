Return-Path: <linux-kernel+bounces-349546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372EE98F81B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 22:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8DCB283104
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC731B85CC;
	Thu,  3 Oct 2024 20:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eyYSzBsr"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ABB1AF4EF
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 20:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727987405; cv=none; b=PFeq4SqcPick1XZ0NSSwvz/mG4zQ5gFS8pzUuWk3BkEozx4NFNr/21ldTcTuWSPbLSGDwJ5C5eOSPAVoLuJiWVpq3mOIYha4rHExzWav1VWU+DaS/EfVLVlbD7xxj//JMCAp1jBKFfJcBY6X9VHm7Oe2tx+qRhQC9Ogc72wQfFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727987405; c=relaxed/simple;
	bh=SwGtc2Xda+ni7sn2/rxr5H2HBb82wmmYGATvDJbQMV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IKMgUSzlWpyDHMAfBsKOutdFstoI+o85L5kmmYP46hLpXUoDPTkxeyBsf+fB2zBLgcxds+sOhmsqkWR36OVlScHoVxjRZGmgcSbQ/eOC4SVHLhNL4PsJMikOkCgQ5cpJC6jSICSU0DTIM8dIv+NYa/IKmfvo9EYB5L++zlQLXZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eyYSzBsr; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e235a61bcbso16771157b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 13:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727987403; x=1728592203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jb4MBypfKjTl+k0Kb3ThenrsifvOPVM8YBQVfXJ85Jk=;
        b=eyYSzBsr94ipfVs+YorWrg3C5zzVcm+4gTguyo1Rv03b7wAMwDJV5mz3C1VKSNDdLt
         H8dUO0Omj8wV0iEFewykJhqmLISffNsslDO8Zkh3uiCqzyX/S7iP0KGOKqfsZCCbs10O
         tFhpODaKnFcW39rYPmzCHqc5IR2o1sXWu1+OWPFRDkhOHyRsJu87Dxyp5vzvEuD1NF/5
         Vf0sL5eRiRvJ+qnoAAZn1OJaA7p2KBQys/MEzkoosY5tPbNBvDiGa/7MKhHBdcGrUQrw
         ke4Ygrr5wf1SHZr4aoLgAXPuBmDOEHzleJOcUEu/VRwdilunuKyqt82KCKb+wh+IXG/B
         1n+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727987403; x=1728592203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jb4MBypfKjTl+k0Kb3ThenrsifvOPVM8YBQVfXJ85Jk=;
        b=VbWXMnl70bXQBa3xSPDDyGuQqR2Jj9DWLm9dyM8OnHGEuYRSWmYFE7c2BTY/+ri+gb
         SNbwM07S1QsR/OcuKK2Z/IKAA2k7PkJYs1WLDuntRPrfSHZw04UjjoKJk5QSCGYIwn9a
         qwNXtxTa97yM8LIcIC6znM6K30biXaexdhIBUf0NsPapCpCkvvB98VVfNQkcU6IkO1QF
         lAURkYvTMyjmY7hsMjK5YVb1KNfGen0UXdnltJa2n9M9Ucleq9KTAdE+2/SS8aw+W+8N
         YUp08UPG+WBSWLMorpzJPnRlJ8WxGR9JslfbZLTWJ1c9IbRVFaain1ksYq9WImP64s39
         b4Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWEwM2CbKo99UKCqyskg6frhGyl7PL+QaHjTAKcr3ExDzj2EHr6QefBTZA5sbfikSaT5D89i9rkN3iuA+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbky/uSFgiYhJvR5jBlChhUcFU1XJvrK/8OA44ugvckU1RX1H9
	cFn4Vm45tyytwtuahxJcDD+R1I1p+hC0AHWi5EBHZOgrMz6IkyvVguJgB3QRZtFWdc0K79YFaTh
	xe97P6Qt0avzswA1xp0cGZ06envcO2BhmPQ82
X-Google-Smtp-Source: AGHT+IF236ZlsWjXinwnGBmUpr4ToS/9qMFMURISOyD71bvORHgRCXLSxeA2JJ/YfKI3o++dhjRkbTIBz2+RcKvZ9a4=
X-Received: by 2002:a05:690c:6889:b0:6d6:c5cd:bde0 with SMTP id
 00721157ae682-6e2b53e65afmr36758307b3.15.1727987402869; Thu, 03 Oct 2024
 13:30:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906172934.1317830-1-masahiroy@kernel.org> <CAHC9VhS=5ohpS18kkXUKaE4QR5HfGZ-ADbR14WPQPor3jeFSuw@mail.gmail.com>
In-Reply-To: <CAHC9VhS=5ohpS18kkXUKaE4QR5HfGZ-ADbR14WPQPor3jeFSuw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 3 Oct 2024 16:29:51 -0400
Message-ID: <CAHC9VhQ6teo2OQTRZp_a8wVr-WsiiYGn_3c2fx862i2xaZK5ew@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] selinux: do not include <linux/*.h> headers from
 host programs
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	selinux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Daniel Gomez <da.gomez@samsung.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 2:37=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Fri, Sep 6, 2024 at 1:29=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
> >
> > The header, security/selinux/include/classmap.h, is included not only
> > from kernel space but also from host programs.
> >
> > It includes <linux/capability.h> and <linux/socket.h>, which pull in
> > more <linux/*.h> headers. This makes the host programs less portable,
> > specifically causing build errors on macOS.
> >
> > Those headers are included for the following purposes:
> >
> >  - <linux/capability.h> for checking CAP_LAST_CAP
> >  - <linux/socket.h> for checking PF_MAX
> >
> > These checks can be guarded by __KERNEL__ so they are skipped when
> > building host programs. Testing them when building the kernel should
> > be sufficient.
> >
> > The header, security/selinux/include/initial_sid_to_string.h, includes
> > <linux/stddef.h> for the NULL definition, but this is not portable
> > either. Instead, <stddef.h> should be included for host programs.
> >
> > Reported-by: Daniel Gomez <da.gomez@samsung.com>
> > Closes: https://lore.kernel.org/lkml/20240807-macos-build-support-v1-6-=
4cd1ded85694@samsung.com/
> > Closes: https://lore.kernel.org/lkml/20240807-macos-build-support-v1-7-=
4cd1ded85694@samsung.com/
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> > Changes in v2:
> >   - Reword the commit description
> >   - Keep the location of CAP_LAST_CAP
> >   - Include <stddef.h> for host programs
> >
> >  scripts/selinux/genheaders/Makefile              |  4 +---
> >  scripts/selinux/genheaders/genheaders.c          |  3 ---
> >  scripts/selinux/mdp/Makefile                     |  2 +-
> >  scripts/selinux/mdp/mdp.c                        |  4 ----
> >  security/selinux/include/classmap.h              | 11 ++++++++---
> >  security/selinux/include/initial_sid_to_string.h |  4 ++++
> >  6 files changed, 14 insertions(+), 14 deletions(-)
>
> This looks much better, thank you.  We're currently at -rc6 which is
> later than I would like to merge patches like this (I try to stick to
> bug fixes or trivial changes at this point in the development cycle),
> so I'm going to hold on to this until after the upcoming merge window
> where I'll merge it into selinux/dev.  See the below doc for more
> information on how the SELinux tree is managed:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/tree/=
README.md

I just merged this into selinux/dev, you should see it reflected in
the kernel.org shortly.

--=20
paul-moore.com

