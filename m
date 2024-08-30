Return-Path: <linux-kernel+bounces-309419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA652966A2E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E22283B4E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7131BF336;
	Fri, 30 Aug 2024 20:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Jmp4yEkF"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A0F1531D3
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725048306; cv=none; b=RPW1DB8PLE6xjwR3TkXP1hIJtZAh7jJr6kQfQKCEAykSLD2gGzOQDnH8Kb+DUl0Q5wmfvg3h3CyZ8rZPBzY3XkVaMMlytucG+Vd2/Sc/HIqwQHRFncIpoADHBNOX1qK4c62uE1zF32ceeeJyl2z7loJM0rO4eZZW+POU9X3RXMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725048306; c=relaxed/simple;
	bh=QWCTT5wCAH3kwRjPHh8bM3pbPPRt9Lm/Y/5a1bTXMBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ly5xrwxd1FgxfcYWEQygSVV2hylbmtUwVn7YrTKwOQ6v5f3E7nwQd1BPO601uNK2qEQbe7eB9DDP45KKNb2JkzkcEFICmtmt3LnZpctzWiyOnI1jGDCC8cJpBVOWihYMqZ8hTvjnweoCoUZkNu66BiMOVkOD8i/Xy/oEN29rhPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Jmp4yEkF; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6c91f9fb0acso20291027b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725048304; x=1725653104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=va8DMzZzwo2vc63FlxGokLNqwDKTUn/bIWuJtwnfM/0=;
        b=Jmp4yEkFpLcL+dJZkP/I0/nVV5QCV3g5nxrfvsrDijn3ERi9QVp87dVyI7cLKNCk8H
         173Rb6mHeJDBtetTSx/rXaqdqGp6aF/mkbaXD8uGqmMmt2AckKfXb8zHNUehEc3kcte9
         1dZ6Ih61yE8u1b/TEGoNzlm4aS32WhuPeC+dDkriWlzEXze0vxruBeGBhpkVlfEIFc04
         10gkEYwJryFpmW8XUKPaJfbQ0ayGaOVPNsDp0+ODE7RYxQD47F96RWp4CuuMq5twy/+K
         CqegDnrsItQIpB+k9vCbM/ytNekehxlD5gQRotjsVqxfl4ITglVMauLjWIw02t0yv1Vn
         9F7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725048304; x=1725653104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=va8DMzZzwo2vc63FlxGokLNqwDKTUn/bIWuJtwnfM/0=;
        b=DkbwP7cohIlvaudy48EaXaMobDOMqfZ4GQ/LKdRKPHQ1971lLpK2M7tgEnOCErtGEW
         9L4Drzoupmg95pDCkX5xbMsPzDAjCZcta9aFOKEQ3k1H7I99JCvd0Oo6Y/yr6dD62LAJ
         wXYNy4DnFcwQFIM1C9+URUalDPoc7TJNO9MtDvHlBLEu2p5aM1WPT3Dha0kjhB3iuSBw
         6+jQDhI7IE2I1TGPN34GdfQk2M1WVkXg/4hg6q5Hk6zGM8+qZTvDVmvahdiyT8y3bptd
         +CxNztOdNKGOtzNyxNSiy/sgnSClxzIqzZ5Z435QAVe0yMyiDHjlHItOLly4a1RjbEBL
         sd3g==
X-Forwarded-Encrypted: i=1; AJvYcCWDXlNU8qYMH1cpgqi0jbBzxrm7lVpHQdrS1MYVNPgi3U/kdU9hQX1+TgxDE+U5/PUY6nOIEHEbrfmTfDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo6EpykNqz8i3oPFKW9AlOdifUAsV+oprHRdFZp7zNTxbHyp6r
	pf4BsfqigynI++h3o2TzUBAbsEhKTpmp+AS7dTFI6O4YvfH1vLAgD+dEDE2R6J5N4/F12hnZ4HJ
	FgOOIXaxqa5sMhkJ3O1e0+Ee8u5ZFfvnOm+ok3WpqySg7URY=
X-Google-Smtp-Source: AGHT+IG/2u3Vt8cgGE1evYB6Q9q7tenaZ9SSK+DO0M2hVfDT/ltupurYSkwcJmGgXlWkrogHlxVoxs5N/nILa6/SF+8=
X-Received: by 2002:a05:690c:39a:b0:6c7:a120:e0ec with SMTP id
 00721157ae682-6d40e688e3cmr43131277b3.22.1725048304191; Fri, 30 Aug 2024
 13:05:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815083229.42778-1-aha310510@gmail.com> <CAFqZXNvXJY4Bh5k6DZ3yoLFuHo2bQRk3Q5Lv25ms6oOGyN5ZAA@mail.gmail.com>
 <CAEjxPJ4TMk3AoAd++nHQUyTHd_7vbOHC1Veq1ZSSyjH3v0kJ7A@mail.gmail.com>
 <CAHC9VhRV4j9i7YuKFJkNe9RYnKvCMLHHOi0LrRvwaFWbGJTbHA@mail.gmail.com>
 <CAEjxPJ4ObSaEG98jHhDtOssD1mF1fEAioJODa4bHKhZO=7KDGw@mail.gmail.com>
 <CAHC9VhSkQtDQktM_RRUgusq6dvCKCOPcCwUytFPL+z=grYR3FA@mail.gmail.com> <CAEjxPJ4WkYo+6xbvrbz2XwmTYQeFEoYnWAjVtExnWvGiKZyvMQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4WkYo+6xbvrbz2XwmTYQeFEoYnWAjVtExnWvGiKZyvMQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 30 Aug 2024 16:04:53 -0400
Message-ID: <CAHC9VhS3y4OCsMLMC9cALMAN1oz2VbTDJW67j1hzP7pjx4qv+w@mail.gmail.com>
Subject: Re: selinux: support IPPROTO_SMC in socket_type_to_security_class()
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Jeongjun Park <aha310510@gmail.com>, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 9:51=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Aug 21, 2024 at 4:02=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Wed, Aug 21, 2024 at 9:38=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Tue, Aug 20, 2024 at 3:51=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> >
> > ...
> >
> > > > Without passing any judgement on the patches Ondrej submitted (I te=
nd
> > > > to ignore patches as attachments for various reasons), I do share
> > > > Ondrej's concerns that this may not be as simple as suggested in th=
e
> > > > original patch in this thread.  I saw the same thing as Ondrej
> > > > regarding the TCP fallback and that immediately raised a number of
> > > > questions that I don't believe have been properly addressed yet.
> > > >
> > > > Someone needs to dig into how the standard SMC protocol works first=
 to
> > > > ensure we have the necessary access controls for the current code; =
my
> > > > guess is that we are probably okay since the socket-level controls =
are
> > > > fairly generic, but I'm not sure we've actually seen proper
> > > > confirmation that everything is good from a conceptual standpoint.
> > > > Once that is done, we need to examine how the TCP fallback works,
> > > > specifically how are connections managed and are the existing TCP
> > > > hooks sufficient for SMC (the early connection state stuff can be
> > > > tricky) and how to distinguish between normal-TCP and SMC-TCP.
> > > >
> > > > Basically I'm looking for some basic design concepts and not simply=
 a
> > > > passing test without any understanding of why/how it passed.
> > >
> > > At present, we are already applying the general socket layer access
> > > controls to AF_SMC sockets; hence, existing policies can prevent or
> > > allow use of AF_SMC sockets through that mechanism. This is useful fo=
r
> > > reducing kernel attack surface, e.g. prevent all use of AF_SMC by
> > > untrusted code, or to limit use of AF_SMC to specific
> > > processes/programs.
> >
> > That's true.  I'm not suggesting we revert what we currently have, I'm
> > only expressing some caution about moving forward with
> > AF_INET/IPPROTO_SMC without a better understanding.  Ideally we would
> > have done so before adding AF_SMC support, but we didn't, or at least
> > I don't recall much discussion at the time.
> >
> > > Since kernel commit d25a92ccae6bed02327b63d138e12e7806830f78
> > > ("net/smc: Introduce IPPROTO_SMC"), there is a way to bypass such
> > > controls by creating such sockets via (AF_INET, SOCK_STREAM,
> > > IPPROTO_SMC) instead of AF_SMC. In that situation, any process that i=
s
> > > allowed the socket layer permissions to the generic socket class woul=
d
> > > be allowed to create/use SMC sockets.
> > >
> > > Jeongjun's patch closes this bypass and ensures consistent applicatio=
n
> > > of the general socket layer access controls for SMC sockets. Given
> > > that, I don't see why we would defer merging it until someone figures
> > > out a more complete solution for SMC sockets. It's more of a bug fix
> > > than an enhancement.
> >
> > SCTP, that's why.  Granted, SCTP is likely a far more complicated
> > protocol than SMC, but the TCP fallback raises all sorts of complexity
> > red flags in my mind.  Before we go further with SMC I want to see
> > some evidence that someone has looked through the SMC protocol and can
> > write a few coherent paragraphs about how the SELinux access controls
> > for the SMC protocol should work.
> >
> > ... and yes, labeled SCTP is still broken.  Perhaps someday soon I'll
> > have the time to finish the patchset to fix it.
>
> I see this as being different than SCTP. The AF_SMC support was
> introduced with the extended_socket_class support which merely
> introduced distinct socket security classes for each address family so
> that SELinux can distinguish each address family in policy. Previously
> a number of the socket address families were defaulting to the generic
> socket security class and could not be distinguished in policy. The
> only change was introducing a distinct security class specifically for
> SMC sockets, not introducing any family/protocol-specific logic. Only
> the socket layer access controls were being applied (both before and
> after the introduction of the SMC socket class, just changing which
> class was being used). Fixing the kernel to also map IPPROTO_SMC to
> the SMC socket class likewise just ensure consistent application of
> the socket layer access controls on SMC sockets regardless of how they
> are created and doesn't introduce any SMC-specific logic.

Possibly.  However, I don't feel like it is a very big ask to have
someone spend some time to provide a basic summary of the SMC protocol
and what might be needed from a SELinux perspective; that would help
increase my confidence in our SMC support significantly and perhaps
then I would feel comfortable with the simple mapping originally
proposed here.

--=20
paul-moore.com

