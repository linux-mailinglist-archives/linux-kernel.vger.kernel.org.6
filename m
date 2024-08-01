Return-Path: <linux-kernel+bounces-271172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518E6944A57
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB9662810C8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20E118B479;
	Thu,  1 Aug 2024 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxnvHp1+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ECD189BBC
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722511598; cv=none; b=ABZDs4sNICv7/+jRag8VvK/vadPM50DEwrQTiuFUVq3efQwmH2AiykJlgCG0S2N8StFuhVlTv9koIIcfoAEJkGaXy8bK5gpme0fylUUsfnJU0uaWl9pt2a9hVg7TngDNy2oHvqopZTJzUnPD+GBmMsOeAKcNSifCPXQcCnf9gxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722511598; c=relaxed/simple;
	bh=YB7E9+6r7PMOi7Xp/YGD46NfB9XBz/LOjzQs4MkOHeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0smMPvYdcB/YhmDdYEjFWAeINUxMC8LAVphZ4mpHSNo56vyloD7G0XfcAsuCJVyE+77Di1lYm49G08wT7/9LcaccQ/QTmvf7he1cTVzlnhOXkKnXP4FBDvzrxckyj7o3VIK7yRudIeNKrNjitvV7qy3O/moaFux2GbKWQEFxJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxnvHp1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE678C4AF0F
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 11:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722511598;
	bh=YB7E9+6r7PMOi7Xp/YGD46NfB9XBz/LOjzQs4MkOHeE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TxnvHp1+b+KnvhuFnqN/Mvc0xs+ef7gcU2FV5XhkAfDkpvaMGbNbSj3HAMyc3PO2j
	 J0a2xXAP57qtYaM9v5yLRXsS4MaHiCYmHtpV2B3Xxnk09NjQNDnDVqe+gtkdYM4SaO
	 fP+6KH3yl2bzsUlc4jkguvkafATKhZZLfXPVRCYG/0DR6bFCypEgU980cmsTo9p/Cj
	 XC8rZjtu+ljuoRr8g0pa+rblrKfVzgfBCl2O8WL90kbGhK4DXgPiU+naUnid+FWWsD
	 tGvELCecaeeLJ+GcYJavKbHIUUzhJwaTBZF8128bZhk8ma8amcnGJQM/CJR56sCNL9
	 D7WM240Y7jvfA==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a167b9df7eso10803323a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 04:26:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVfzo+79KNwCQSNuI9qmNqlXkTKtkQSxS2hwYv4fdLbs2RJmV+vic75LzUOrMwk48I9fDcYfj6kUYSi130zFf1FNWQTEa07GW5PzEZ
X-Gm-Message-State: AOJu0YzUxPe+SGfGYCRboEZ2IQuYTz578fTM6qYt14upNxNhTfFZH1wy
	1wTZ98RXFDFjtSc5RBKUfhHmAbeW62IN8eUYn+dhTKyqk9uupVTWs0bBphEsM4ag+3ZFvNi6WiK
	KIJMKFGnjtteOa1VMioDxQkNGVSJ8geHMSbf/
X-Google-Smtp-Source: AGHT+IE6eI090/VSwIKbss3Mkvx4/Yoy6N8fsdbd3CNDdWpYZYI6rsMa04kEYUcZMFbv4fjzECURghzGRAdAHNeq0z0=
X-Received: by 2002:a05:6402:5154:b0:5a2:2654:7fd1 with SMTP id
 4fb4d7f45d1cf-5b7008ac4bamr1080394a12.36.1722511596491; Thu, 01 Aug 2024
 04:26:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731213429.2244234-1-kpsingh@kernel.org> <CAHC9VhQEYutCiAMitEv0JY4PRY4tdLdqEy76qvY1xB5q8Y13mg@mail.gmail.com>
 <20240801083441.GL33588@noisy.programming.kicks-ass.net>
In-Reply-To: <20240801083441.GL33588@noisy.programming.kicks-ass.net>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 1 Aug 2024 13:26:25 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7JP86O9DD8EBG9aHiUeK1FZGz5LFbzRG-_x+9SHavhiQ@mail.gmail.com>
Message-ID: <CACYkzJ7JP86O9DD8EBG9aHiUeK1FZGz5LFbzRG-_x+9SHavhiQ@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Do jump_label_init before early_security_init
To: Peter Zijlstra <peterz@infradead.org>
Cc: Paul Moore <paul@paul-moore.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bp@alien8.de, sfr@canb.auug.org.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 10:34=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Jul 31, 2024 at 09:15:04PM -0400, Paul Moore wrote:
> > On Wed, Jul 31, 2024 at 5:34=E2=80=AFPM KP Singh <kpsingh@kernel.org> w=
rote:
> > >
> > > LSM indirect calls being are now replaced by static calls, this requi=
res
> > > a jumpt_table_init before early_security_init where LSM hooks and the=
ir
> > > static calls and keys are initialized.
> > >
> > > Fixes: 2732ad5ecd5b ("lsm: replace indirect LSM hook calls with stati=
c calls")
> > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > > ---
> > >  init/main.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > Does this look okay, static call folks?
>
> Are we confused between jump_label/static_branch and static_call ?

Not confused, just rushed, from my side, we need both static_call_init
and jump_label_init() before early_security_init(). It fixes the error
for me but as you folks mentioned, we need to check with the arch
folks if this okay.

>
> > > diff --git a/init/main.c b/init/main.c
> > > index 206acdde51f5..5bd45af7a49e 100644
> > > --- a/init/main.c
> > > +++ b/init/main.c
> > > @@ -922,6 +922,8 @@ void start_kernel(void)
> > >         boot_cpu_init();
> > >         page_address_init();
> > >         pr_notice("%s", linux_banner);
> > > +       /* LSM and command line parameters use static keys */
> > > +       jump_label_init();
> > >         early_security_init();
> > >         setup_arch(&command_line);
> > >         setup_boot_config();
> > > @@ -933,8 +935,6 @@ void start_kernel(void)
> > >         boot_cpu_hotplug_init();
> > >
> > >         pr_notice("Kernel command line: %s\n", saved_command_line);
> > > -       /* parameters may set static keys */
> > > -       jump_label_init();
> > >         parse_early_param();
> > >         after_dashes =3D parse_args("Booting kernel",
> > >                                   static_command_line, __start___para=
m,
> > > --
> > > 2.46.0.rc2.264.g509ed76dc8-goog
> >
> > --
> > paul-moore.com

