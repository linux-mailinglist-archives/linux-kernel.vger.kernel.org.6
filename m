Return-Path: <linux-kernel+bounces-296101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7AB95A599
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 22:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CEA11F2304B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 20:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C729716EBF2;
	Wed, 21 Aug 2024 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ussy6yFY"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE2A136337
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724270531; cv=none; b=c3R4IMGyzH11wUji3i/vMsfY21H8DFyEqIoVhjviRsadv/BsPJgxtQgVF3qQOvb4Ofz+ccBzJn26SpF2DJiE+OYG0/TM7yFo3QYwmiPh00maWQQb6iStv76ZVM5D22bJzPVHBT4tfTVW69+aBWT0qw4JJpqIWUOaKuo2AA0OrS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724270531; c=relaxed/simple;
	bh=OnXcytC53/4o5Pt1aPpx2AkSZNydd/aCmCVXtxs6jEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azR8eVUtoklzdtQpbNz4m/JSyelEOBHMeXiaXLWLnZGT78ecHVcmkd2PEC0/dfeH/c61v2RY3OYrxr9ydrM1gm+H8Sl4nCzNdaKroDjLHzdksY1t3dRGovSqRs/Nu35MPuygEj65o49SrUWahykQcm4CdqWbDuKmpIx81VvzqUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ussy6yFY; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e04196b7603so133434276.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724270528; x=1724875328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sd4fCf38q7zmEAJ7MeRruj4icO1IpN4DXf4IAgnQqlM=;
        b=Ussy6yFYAgh23Zp3b7QJ6nyXt0mFkIsLOVV7i48OuJ8Vm/T6Wy/tu8i3OKEvZyeyNP
         ggHrcnkdZuUr0ZmrQ31L4YoYw6YvKS0J7QvfxYjqWEHSIaED45jDOx0LebxHab+B/EXY
         tA4Icy3S6f9sORNOxLSnOHBrcMRj0CFOOHo+A4HgXS40kXqFKT2hjT8wFPHib4dg4ik8
         3OzOx0ytsZcE24FM+n9OaU9LhuQbkwhrh8IEz3y+yOEF5dD7mijXbzn0wp8ptAdIjtWU
         JwKYhRBvHRPAo4bqt7/sM9LvZSo74abJSwjqYVm8hU2H3n4MoCKHBz0FvF2byA1e94Kg
         VD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724270528; x=1724875328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sd4fCf38q7zmEAJ7MeRruj4icO1IpN4DXf4IAgnQqlM=;
        b=UfKYEeX/rGrf+a+YL/+FxWMIfh4iW5mIQ7SrT6iSCOmb9JEsrjQgSsfPXeNYb+MKcE
         MzKs8AeO2OR/JvAoh1CgBztXGCDypq8CjWy84GZRgm1+nGBefP7tHQpKuHgBFr9iidwm
         QDsHY5g9lWsQQAQhD3yL5k+H51hqOUkfgAcRZqM46pOA3mg1n2d0eb8aSnSzY7fOKcc5
         nybRMt+TupO5aJI7e6eT6NMQxDqBxRV2UB5V/IFrTL8OV6egb0J4hEAbQpnWkrtsUZsD
         EhrcYrxIotzdJzmbiqt1eiVX9SBtLsv3hK0SqTTJRnzJlF2paou75D+CdlSVx2ZN7X8i
         tqxg==
X-Forwarded-Encrypted: i=1; AJvYcCX0HOOHaN3a1gDIt28qFww+v4Qii47PaVg5xFfOche8ebGHmI6LOwsTJFO3JsRYj/CjhOWdIzPoVKGhlQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEKAH2nBxxUT/zoKKDNjC2rYzmDpaCieQiiRsIsG9CJW+UyASK
	FtnT84WoZexkH0QzPQX/H6YWwQnN1J5oiRB9cQ2sYVyVg05HmhM21ibwOvAcE7fADdhX4P02VxM
	oT9DLVA6lVvfEikFlihdbFOVzlL3eYtkoVRCe
X-Google-Smtp-Source: AGHT+IE2QO57xS8SgeCLUqJT3hCavShJNH5jHqpIvVtKtPyOZLLtL5WZ7rGTH2dX5GBAahZ77OWb2kXbFsOhpzxCaQQ=
X-Received: by 2002:a05:690c:6c07:b0:61b:342e:91ae with SMTP id
 00721157ae682-6c0a0141ae8mr44149257b3.36.1724270528366; Wed, 21 Aug 2024
 13:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815083229.42778-1-aha310510@gmail.com> <CAFqZXNvXJY4Bh5k6DZ3yoLFuHo2bQRk3Q5Lv25ms6oOGyN5ZAA@mail.gmail.com>
 <CAEjxPJ4TMk3AoAd++nHQUyTHd_7vbOHC1Veq1ZSSyjH3v0kJ7A@mail.gmail.com>
 <CAHC9VhRV4j9i7YuKFJkNe9RYnKvCMLHHOi0LrRvwaFWbGJTbHA@mail.gmail.com> <CAEjxPJ4ObSaEG98jHhDtOssD1mF1fEAioJODa4bHKhZO=7KDGw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4ObSaEG98jHhDtOssD1mF1fEAioJODa4bHKhZO=7KDGw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 Aug 2024 16:01:57 -0400
Message-ID: <CAHC9VhSkQtDQktM_RRUgusq6dvCKCOPcCwUytFPL+z=grYR3FA@mail.gmail.com>
Subject: Re: selinux: support IPPROTO_SMC in socket_type_to_security_class()
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Jeongjun Park <aha310510@gmail.com>, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 9:38=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Aug 20, 2024 at 3:51=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:

...

> > Without passing any judgement on the patches Ondrej submitted (I tend
> > to ignore patches as attachments for various reasons), I do share
> > Ondrej's concerns that this may not be as simple as suggested in the
> > original patch in this thread.  I saw the same thing as Ondrej
> > regarding the TCP fallback and that immediately raised a number of
> > questions that I don't believe have been properly addressed yet.
> >
> > Someone needs to dig into how the standard SMC protocol works first to
> > ensure we have the necessary access controls for the current code; my
> > guess is that we are probably okay since the socket-level controls are
> > fairly generic, but I'm not sure we've actually seen proper
> > confirmation that everything is good from a conceptual standpoint.
> > Once that is done, we need to examine how the TCP fallback works,
> > specifically how are connections managed and are the existing TCP
> > hooks sufficient for SMC (the early connection state stuff can be
> > tricky) and how to distinguish between normal-TCP and SMC-TCP.
> >
> > Basically I'm looking for some basic design concepts and not simply a
> > passing test without any understanding of why/how it passed.
>
> At present, we are already applying the general socket layer access
> controls to AF_SMC sockets; hence, existing policies can prevent or
> allow use of AF_SMC sockets through that mechanism. This is useful for
> reducing kernel attack surface, e.g. prevent all use of AF_SMC by
> untrusted code, or to limit use of AF_SMC to specific
> processes/programs.

That's true.  I'm not suggesting we revert what we currently have, I'm
only expressing some caution about moving forward with
AF_INET/IPPROTO_SMC without a better understanding.  Ideally we would
have done so before adding AF_SMC support, but we didn't, or at least
I don't recall much discussion at the time.

> Since kernel commit d25a92ccae6bed02327b63d138e12e7806830f78
> ("net/smc: Introduce IPPROTO_SMC"), there is a way to bypass such
> controls by creating such sockets via (AF_INET, SOCK_STREAM,
> IPPROTO_SMC) instead of AF_SMC. In that situation, any process that is
> allowed the socket layer permissions to the generic socket class would
> be allowed to create/use SMC sockets.
>
> Jeongjun's patch closes this bypass and ensures consistent application
> of the general socket layer access controls for SMC sockets. Given
> that, I don't see why we would defer merging it until someone figures
> out a more complete solution for SMC sockets. It's more of a bug fix
> than an enhancement.

SCTP, that's why.  Granted, SCTP is likely a far more complicated
protocol than SMC, but the TCP fallback raises all sorts of complexity
red flags in my mind.  Before we go further with SMC I want to see
some evidence that someone has looked through the SMC protocol and can
write a few coherent paragraphs about how the SELinux access controls
for the SMC protocol should work.

... and yes, labeled SCTP is still broken.  Perhaps someday soon I'll
have the time to finish the patchset to fix it.

--=20
paul-moore.com

