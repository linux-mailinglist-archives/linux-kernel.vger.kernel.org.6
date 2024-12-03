Return-Path: <linux-kernel+bounces-428643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DAC9E11B2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 04:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A5EB164C71
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646571632DA;
	Tue,  3 Dec 2024 03:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gcw6yILa"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E3D150997
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 03:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733196433; cv=none; b=l2yDjhBLA/aaMBmuqp3XvwnFk7vyUG+VJ/LaZQU7DA22yb78S9DADOTFuZudoesaYZhjW/JAsP9dvgzgKQDSxe54fKYCAy1poIrJlb9qbCCfTSEwMKGQR7NUOXr7t6gsB6e802w1aAsKyBjs7b6sJR3dkrFUFyMNb+fKSN30aww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733196433; c=relaxed/simple;
	bh=xxX4mtXtsL3HvpD3DEwgqiX7H446zPSyw4NWZR47W+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTszAV6AofqikfPoysmninDJ90LNJpVXaVWkf1s6V7vuSTsdq9z2XsBTrfKYqf+RjF+hKbfpBOPTtWBnzUSxu+EvcbAzjzyM4a+opAch+ZxqdvipiCKg+7QV3RmpIQ/ZCVbuVtjPwhF/9rMqSDzTYnL98GkxY+gCyUbP7fO/sJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gcw6yILa; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e333af0f528so3266016276.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 19:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733196430; x=1733801230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqbJjD/3nUVjn98k1gBtcANA0piu00UED1UVG49fhPo=;
        b=gcw6yILacpck+oq6fU2aClJXWiF15UTEm/SEkiXekBwvzCFG5g5GFVcQXflJ5qoMib
         EDahgpb3X3Y9KpQwjo76cnt7f1hp0l/rSeI0Ov3AjgNNxZMhFgdThxF8mhbZBbG3G/SP
         9H7EJ3UzsqK4CXAbhFYA8+4itl5j5rEnY4TPazvQO08kdrupoU5hO5E+B11aIQmfQY/R
         0+uVkke5LcGLpJumiOOILP2of28LTsdQIMtb91OEGMsAz/SeCNNldOl+ToG+tkERbGr5
         Y5js0ASNxXxy8KZXFoYfMjr2nvpXiXC8hcdtiLOIvIVMhT15Qgu4+k7boPF5G2woDL1A
         5tPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733196430; x=1733801230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqbJjD/3nUVjn98k1gBtcANA0piu00UED1UVG49fhPo=;
        b=HK+vevbd88+f69zUS4A/4yZDyk0DI9ubzNFExeMTpA/3f9B5Naq8ElEf1Haog8IyG1
         /9t1cgkwLN9wgzEeno9ygiI6guqWsTKxEVfjoXhpzYx9YjdufdYTj7SwsoNa6r/403O9
         5xAAS6q2v0dBOTZtGhakptoRPzAYkJnlJUhBRNeXtZ0a7eQj6JmTjtaNVHZFy75tssON
         YUIn3SSihfbDO2YKWz4DPg57Vw/xcZ1GxbfV86VIalEegVZPTLUkP3gfDPFOIzBqOQ3X
         DUhR7MlPkiKdG8SCUofTBjTipTdvQ+0U3M6FHUvTz6KtfNg7l+7RHz6Evf4a5yTNZuso
         RPhw==
X-Forwarded-Encrypted: i=1; AJvYcCXYFjq9O0Clrgt/ymXt0uKUH7R9jVTlmd2+oXKNP9/WU977VwnOWEhZaOP/aWsBmWF6UzdKFvqWVfPEMuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu7YoR5KZDgR2Q00+bvTrQZ8bdgbEzYvParoC3mtvXpyujNgAT
	o+pNiNEiRyu6sFX/JLmVlFVi6IVahMgPGzEiEdqPeS3Yt6g1sSXbkskakRY+IJGVlduUW8stOdw
	o11EEAaTByi7BJXLynIWwcQXS+rlIew+KRFYa
X-Gm-Gg: ASbGncsl7pz5OaQpf79Zat8LpSDBXvjpVbpXgRiPzmm7zBIYSqnBdE250ECC8PJFWXi
	VpZQSQ1oq6y2Yr38Ly+l93MxWF9B4+w==
X-Google-Smtp-Source: AGHT+IEkcOjmvhEh78VcP2e0jS38kT2oh7bT2DzYciiYn+NwgjyVMTp4temsxNmRcfgs3ScADEJb9hsdztWw6w8Szrk=
X-Received: by 2002:a05:6902:2482:b0:e35:e965:40c2 with SMTP id
 3f1490d57ef6-e39d3a29287mr1035446276.21.1733196430070; Mon, 02 Dec 2024
 19:27:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405161042.260113-1-cgoettsche@seltendoof.de>
 <20241023152719.24118-1-cgoettsche@seltendoof.de> <CAHC9VhQ+SmaYB-1zz2q9j1XJeAFaY+emn_KoNiXxqJDt6wjT0w@mail.gmail.com>
 <CAJ2a_DcHZMkGuwPm69xD1VGnJe2Qjjucn8qRNJ65aqNS1VBAYw@mail.gmail.com>
In-Reply-To: <CAJ2a_DcHZMkGuwPm69xD1VGnJe2Qjjucn8qRNJ65aqNS1VBAYw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 2 Dec 2024 22:26:59 -0500
Message-ID: <CAHC9VhRzT_5HNOHx78v99VKqtiPN9MC8My4g4nRgUNnPh9xXOw@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: add support for xperms in conditional policies
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	=?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	Jacob Satterfield <jsatterfield.linux@gmail.com>, Eric Suen <ericsu@linux.microsoft.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	Canfeng Guo <guocanfeng@uniontech.com>, GUO Zihua <guozihua@huawei.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 7:49=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> On Thu, 31 Oct 2024 at 23:20, Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Oct 23, 2024 at 11:27=E2=80=AFAM Christian G=C3=B6ttsche
> > <cgoettsche@seltendoof.de> wrote:
> > >
> > > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > >
> > > Add support for extended permission rules in conditional policies.
> > > Currently the kernel accepts such rules already, but evaluating a
> > > security decision will hit a BUG() in
> > > services_compute_xperms_decision().  Thus reject extended permission
> > > rules in conditional policies for current policy versions.
> > >
> > > Add a new policy version for this feature.
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > ---
> > > v2:
> > >   rebased onto the netlink xperm patch
> > > ---
> > >  security/selinux/include/security.h |  3 ++-
> > >  security/selinux/ss/avtab.c         | 11 +++++++++--
> > >  security/selinux/ss/avtab.h         |  2 +-
> > >  security/selinux/ss/conditional.c   |  2 +-
> > >  security/selinux/ss/policydb.c      |  5 +++++
> > >  security/selinux/ss/services.c      | 12 ++++++++----
> > >  6 files changed, 26 insertions(+), 9 deletions(-)
> >
> > This looks fine to me, but I believe there are some outstanding
> > userspace issues that need to be resolved?
>
> Hi,
>
> I know it's very late in the development cycle, but I wanted to ask if
> there is a chance this could be merged for 6.13?

I'm sorry, but it is/was too late for those changes to be merged into
the kernel.  I'm sure you've seen this already, but the process is
documented in the README.md file which is linked below:

* https://github.com/SELinuxProject/selinux-kernel/blob/main/README.md

The relevant potion is copied below:

"During the development cycle that starts with the close of the kernel
merge window and ends with the tagged kernel release, patches will be
accepted into the stable-X.Y and dev branches as described in their
respective sections in this document. While patches will be accepted
into the stable-X.Y branch at any point in time, significant changes
will likely not be accepted into the dev branch when there are two or
less weeks left in the development cycle; this typically means that
only critical bugfixes are accepted once the vX.Y-rc6 kernel is
released."

> The userspace patches are merged and currently part of 3.8-rc1, and
> these kernel changes are quite simple, since most of the needed
> functionality was already in place.
> I created a testsuite patch over at
> https://github.com/SELinuxProject/selinux-testsuite/pull/98.

Thank you!

--=20
paul-moore.com

