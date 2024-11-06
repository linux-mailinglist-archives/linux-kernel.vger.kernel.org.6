Return-Path: <linux-kernel+bounces-397591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E39E69BDDBE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 04:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5038AB233DF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28360190667;
	Wed,  6 Nov 2024 03:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qAvtBkxN"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5704190468
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 03:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730864544; cv=none; b=HQeI3rzObKqchXQH/1bJlWaY/ZLS4EK+nwjvcHTc/cy4o/sX/YxdFODrRkAfdgQRBGR4BAQ5nIbdMdy9AVkN7B2uOQG/qKS8kQKMOFycBGqMPshbb1quaiuwUn8QEGGyRZ3yc2egMWw/vhsosGcgdit6bXXDcEKwexOXW46mZ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730864544; c=relaxed/simple;
	bh=5j2FxXW6VV2AAMaYXR9MzsYRrqLRILm/ZvqV+vsjn/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etf/J/+2AbzoJ6VYaYySo5Fzkpo0lthoSzBcmoDewldyV6/iDuuYTUePmWN3vHhks/cJbz3DsHgetGYaQCYE5Bi2ZzkWwVR6QOkd82G8ESfo4dgBsTjHwLhf4rVIljiWIUd3TryA+0ZuRPCLh8ED8wzhLC2jXxX36Sa3UhBSF+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qAvtBkxN; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7f3f184985bso912967a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 19:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730864542; x=1731469342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2zrxulVBoCR0AsXUg5w2WaDAbZzLwKamgsttf0Goms=;
        b=qAvtBkxN/2mXY3N9hMWXJCDdwJ2OQjbLX0WP+5ucs8nvjnKmgH7sFz7lbjfml/EM6t
         54btllSSBdAq8xXhSdT+IGFhuVTfhQk3sKrb4axgH15exQAmZWozFMA1JUduFF8Rwm+L
         I7ORZ1DxBeFaH9f+irQ+egL6EznTl8udtQ2VRdA3txyzKIDG/JgjIM4HQZePOU/n8BdU
         n5+KyRXSgEWmKT7l6z3zpR35p8chqOPdqMRM/2WbHtBTWS/rCl13H2WvnhYyaqrEr63s
         Erj95zwyruGHPd8niAWoKQaxNkv9C4/a2T4Af56NNK4NqbIpk77lGJkoljS2X0aMrC4r
         1FPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730864542; x=1731469342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2zrxulVBoCR0AsXUg5w2WaDAbZzLwKamgsttf0Goms=;
        b=iB8n1KVpAXEKpysXHjDjkCDZZoWqsZQ6HX3+RBBJTovyp6aC/qtm1eLwK+k1LcxxYm
         ogDHm9LbU3p+G5oYG2RRcs4fQDHju6WnZRhpFmuBwZaqjs72S8nMpaHquZ7OZvSd47TR
         Ky9SHWRHFEnhXqd6w9kyJGcNbzEIX4QnZKy4fpcIWAJUD6p8QaJ+vH52dZdOLgRBv6/J
         5IH8Rb3BtTpvRr+z4mC34v9FpaSj9eWI/WNkRMPbI5HPBpDdxz0HSMYlHZ/iaVCDyOCJ
         oNvi+eKLQzUm+5bmjonNvcfPLIEp4DGs/akjr+rG0kAjtVl/23a+wGfJM/GLcYrsPtJw
         dEGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUDBSyrkD0ijyaA04nf+tKZ4IA/4JM+uKRp2FBCRtSDTM48sKiAJ2/eljJWNur2QlsqtZ8ZCitaTcg1N0=@vger.kernel.org
X-Gm-Message-State: AOJu0YykA+ekJ0Y4tWc/4CAPYVk9SNdSHroRgOZlyzkxUI1de+fx2spN
	Nt1PSbuU0VcxyV9/pWrY3DWB8EtIs8wps8u7wX2h2CDZvkUrQjaZO/1pJ1fr26558srv2hyALg2
	iJ7Uqjb2WkISgYcsgAnHQuv3RQqTYw02ExRFU
X-Google-Smtp-Source: AGHT+IEqOOrb8YDlDXwfyFqVUppTwsu28sy3bC7DxTWEhZch2kOKe8VhsIg09TSmhYG23FtZXYpPMnlCx3/PhQad8Fo=
X-Received: by 2002:a17:90a:ca8e:b0:2e2:bad2:69ba with SMTP id
 98e67ed59e1d1-2e8f106b4aamr38783910a91.14.1730864541952; Tue, 05 Nov 2024
 19:42:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <MW5PR13MB5632321E93B031C0E107DB38FD4F2@MW5PR13MB5632.namprd13.prod.outlook.com>
 <CAGETcx_c2nfFQ++-FcsdUdLUo3e-oe07MkLgbuyrnq2FPrcsXQ@mail.gmail.com>
 <MW5PR13MB5632E4EFFD802E0839027A51FD4A2@MW5PR13MB5632.namprd13.prod.outlook.com>
 <CAGETcx-Y6LHpZZUeexeuSF4RJ1E2MDtNtST=ytEUPAj7kKzwFA@mail.gmail.com>
 <Zyqz1LBDXZosrjle@x1> <MW5PR13MB5632276F33CCE4E18D0258E0FD532@MW5PR13MB5632.namprd13.prod.outlook.com>
In-Reply-To: <MW5PR13MB5632276F33CCE4E18D0258E0FD532@MW5PR13MB5632.namprd13.prod.outlook.com>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 5 Nov 2024 19:41:42 -0800
Message-ID: <CAGETcx-5r6+-9q1GCOry6PP1hALMuPbwSco7jdcNZ24MTMcBpw@mail.gmail.com>
Subject: Re: Boot-time initiative (SIG) thoughts and next steps
To: "Bird, Tim" <Tim.Bird@sony.com>
Cc: Brian Masney <bmasney@redhat.com>, 
	"linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 4:45=E2=80=AFPM Bird, Tim <Tim.Bird@sony.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Brian Masney <bmasney@redhat.com>
> > Sent: Tuesday, November 5, 2024 5:10 PM
> > To: Saravana Kannan <saravanak@google.com>
> > Cc: Bird, Tim <Tim.Bird@sony.com>; linux-embedded@vger.kernel.org; linu=
x-kernel@vger.kernel.org
> > Subject: Re: Boot-time initiative (SIG) thoughts and next steps
> >
> > On Mon, Oct 28, 2024 at 03:=E2=80=8A33:=E2=80=8A29PM -0700, Saravana Ka=
nnan wrote: > On Sun, Oct 27, 2024 at 6:=E2=80=8A30 PM Bird, Tim
> > <Tim.=E2=80=8ABird@=E2=80=8Asony.=E2=80=8Acom> wrote: > > > On Fri, Oct=
 25, 2024 at 11:=E2=80=8A18 AM Bird, Tim <Tim.=E2=80=8ABird@=E2=80=8Asony.=
=E2=80=8Acom> wrote: >
> >
> > On Mon, Oct 28, 2024 at 03:33:29PM -0700, Saravana Kannan wrote:
> > > On Sun, Oct 27, 2024 at 6:30=E2=80=AFPM Bird, Tim <Tim.Bird@sony.com>=
 wrote:
> > > > > On Fri, Oct 25, 2024 at 11:18=E2=80=AFAM Bird, Tim <Tim.Bird@sony=
.com> wrote:
> > > > > > =3D wiki account =3D
> > > > > > The wiki where we'll be maintaining information about
> > > > > > boot time, and about activities of the boot time SIG, is the el=
inux wiki.
> > > > > > The page we'll be focusing on is: https://elinux.org/Boot_Time.
> > > > > > If you are interested in helping update and maintain the inform=
ation there
> > > > > > (which I hope almost everyone is), then please make sure you ha=
ve a user
> > > > > > account on the wiki.
> > > > > > If you don't have one, please go here:
> > > > > > https://elinux.org/Special:RequestAccount
> > > > > > I have to manually approve accounts in order to fight spambots.=
  It might
> > > > > > take a few days for me to get to your request.  It's very helpf=
ul if you
> > > > > > put a comment in one of the request fields about this being rel=
ated to
> > > > > > the boot-time initiative or SIG, so I can distinguish your requ=
est from
> > > > > > spam requests.
> > > > >
> > > > > Can we instead keep this all a part of the kernel docs instead of=
 the
> > > > > wiki? Couple of reasons for that:
> > > >
> > > > Ideally, we would put some material in the wiki, and also
> > > > produce a document - some kind of "boot-time tuning guide" that can
> > > > live in the kernel tree.
> > >
> > > This is the part I care most about being in the kernel docs. Eg: what
> > > configs to use. What commandline params to set. Dos and Don'ts for th=
e
> > > drivers, etc. So, good to see that is an acceptable option.
> >
> > I'm interested to help contribute to a boot speed document, and I
> > suspect some others at Red Hat are interested as well. Personally,
> > I would prefer to have a section in the kernel documentation over a
> > Wiki
> OK - that's at least two votes for an upstream kernel doc.
>
> I think it would be good to have a boot time tuning guide upstream.
> I hope to augment that with a tool that will check for various
> items or conditions on a machine, and give a list of recommendations.
> This could go along with the tuning guide.
>
> However, I would still plan to collect some information on the wiki
> that I don't think will be upstreamable.  For example, see this page:
> https://elinux.org/Disable_Console
>
> The first few items on that page could be sentences in a kernel tuning
> guide, but the data from actual uses I don't think belongs there, as
> it will quickly bitrot.  (Indeed the information on that page has already
> bitrotted.)
>
> I think it would be useful to gather this results information on a wiki, =
but its
> possible that if reports are sent by e-mail, just a few lore links would
> suffice.
>
> > Besides arch-specific recommendations, we can also contribute
> > some boot speed improvement techniques that we've done that are
> > specific to RT.
> That would be great.
>
> > In addition to the recommended configs, I think it would also be
> > beneficial to list some upstream patches that improve boot speed along
> > with the kernel version it was introduced in.
> I think this would be good also.
>
> We should discuss what a kernel boot-time tuning guide should look like
> and how it should be organized.  Starting this may be one of the first
> things the SIG does.

I wrote something like this for the Android ecosystem
https://source.android.com/docs/core/architecture/kernel/boot-time-opt

So, I'm happy to add something like this to the kernel doc if we have
some consensus on having a kernel doc.

-Saravana

> The other one may be a data-gathering tool that
> I've been working on, that (of all things) automatically populates a wiki
> with boot time data.  I will explain my intentions when I post the script
> (likely tomorrow).
>  -- Tim
>

