Return-Path: <linux-kernel+bounces-426350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 084139DF1FF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 17:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6002816317F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 16:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BF51A2574;
	Sat, 30 Nov 2024 16:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NtEtkTYy"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7BF1EB3D
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732984425; cv=none; b=G5zgMpqzFrHyNUvGpvHEpfMcVfShuVIJNTuNauXU4/hRtcYbxqK5XSdeao0LL9GWy820hd6kRdeIADYp2DNqJ3PXEUPtkRmt1mpP5wBX64x0gB4afTn3tPyUin78c3q0BGsfsJg1Fs4do912D9aqc/7z6+w0O6lU4V04BdYQ8Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732984425; c=relaxed/simple;
	bh=By/KKrb1K5ZZ6MykfSGMEk7BNFbgx30ZD8C4jEZ+dlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ky1K3N1dZY/TXJgwUboEeW2BOB+6mUPZaBVCNcfFePiuWAG3bpzNPiFTvtHG9yplSXmqaZIfAOewb14/bH8eMBLPsBWCu9s7yR8W0Qko/Pj1VQkV0irfR8cvcCzFpajfj3NTuQXEJ42u9hdY1nKsBL/8btEFW1IGTiFa79LDE1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NtEtkTYy; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-215348d1977so18948705ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 08:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732984421; x=1733589221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdLbKGX5nJEtwzgIbPzQLbGOc73ZlKkd2neK2K/meyk=;
        b=NtEtkTYyW2SCPLuGim7U8hQbvwFfP1QB2KHM+oBX3GewMK6iRlqu/QdOb1Q+X2yTXl
         EVwhdiMtIyHg5q7WfK0o+9IYHIbpAGNA6ne2NO0iHAIfllS/Yq19nUfTvR1ZCe8Gt2eS
         tgN/jCkLSgf+OP8odO+hP7oU1RSoq+d14MwVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732984421; x=1733589221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdLbKGX5nJEtwzgIbPzQLbGOc73ZlKkd2neK2K/meyk=;
        b=vsmBdYnjZ/K5s6bsTo5lxh/VCDK69192OF+5EY8mauYCpR3ME5oZtHVxqs9h1+x9wh
         HAzCtBxu+yL7lXgc1FsN9RfcLrF5/LU+ezdQIUvvfWrj8dNlSM89uYPbRb6zfAsPFOn+
         n83p0HFA/KQN6N2XgZKykTNQbikF+DcscfzgrBG5IPvzKKozCjdGcLhElPZzaWwq0e94
         286yQR6gyJDWgyS6TwbWQlX8JBC9mLHOp9TZNnNvSySeu9hwSoPUjyoS9qdNrxAUBgif
         FR7c7xE5OrC9hYIn69nMa8/pywZk2jzhobYZ0xjeNIG2NltBZGlf8qC902o3Qv2WvYoF
         jnYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSHZEWkeXkpXB8EAAOO1AD7f4pUtTrFHQ8SPKlMy4BdXS9bLOskoio0YztnYcnu8GRQoUGpABRp5IICR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy20gp82Th9dXZqEqxO0a4OK4p831hUOosYiUSMsmBHX6AJGMi/
	DJlON5dqcglkV05+atEfJTf4/Mgax+EDOEap1sONbLLBiqrE9iuykAyUsMzNsxPUSzfVWwtJHYM
	=
X-Gm-Gg: ASbGncs1sV0aqT5TuT4O6xLIKvGhpPmIq1fvxh/VwC1fioONgUi/jPHG7P3SaF2nkQz
	HjnsV9JYjZoaiuCYonFcxxNYASiOPwyxHqLzAFMjMAuK5w35dz3D8EXspv8lxrg/kfEfEGtEap3
	0Dhxntz3oh9tFnqonpZeOdSe31SepCT7H35yqf6WJCG0A6yKhyvhv6cfgTcKwoD0Bn+0Xahkzg9
	DwWhCdvmIBmfra5Wz5sFcW3+L43gZmy1HC7P3hiKsWzNcmfZoSTX1UXiD22y2194EUq1SKn/YaU
	0fDBsyzvfhIoOXv/
X-Google-Smtp-Source: AGHT+IGfzscxIPCQf5fAPWWm2+uaOlvZ0k0hcdGnx0uXS2coLKzP6vT2blc5WkBzN2N9Jn79p5bcgg==
X-Received: by 2002:a17:902:f64c:b0:20c:8763:b3f7 with SMTP id d9443c01a7336-21501380a7bmr202590385ad.17.1732984421245;
        Sat, 30 Nov 2024 08:33:41 -0800 (PST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com. [209.85.215.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2155f0a648esm12806515ad.183.2024.11.30.08.33.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 08:33:39 -0800 (PST)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7fc41b4c78bso1548733a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 08:33:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXOrGGoq4tya0Oh06ZWH+2y1AW55YBMiUBeeVTSm9kBMu4SouP/jrizp21InZ9V91QVcasmzwviwWiC/wQ=@vger.kernel.org
X-Received: by 2002:a17:90b:3d8f:b0:2ee:5bc9:75c7 with SMTP id
 98e67ed59e1d1-2ee5bc97923mr8849284a91.5.1732984418489; Sat, 30 Nov 2024
 08:33:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1732872169.git.mchehab+huawei@kernel.org>
 <99e1b9df713827ce2e6c21073276c97030071a07.1732872169.git.mchehab+huawei@kernel.org>
 <CAPybu_2O9GVNCroLoFPGgrhs_UB97p6ng1dHgtVwbGhyr9LruA@mail.gmail.com> <20241130134221.5629bf57@foz.lan>
In-Reply-To: <20241130134221.5629bf57@foz.lan>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sat, 30 Nov 2024 17:33:25 +0100
X-Gmail-Original-Message-ID: <CANiDSCt1=7TT8VN86V5w05gG3-m7MmQMxyBcKPSa-42f9kiVgw@mail.gmail.com>
Message-ID: <CANiDSCt1=7TT8VN86V5w05gG3-m7MmQMxyBcKPSa-42f9kiVgw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] docs: media: update maintainer-entry-profile for multi-committers
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4ll.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 30 Nov 2024 at 13:42, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Fri, 29 Nov 2024 16:09:41 +0100
> Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> escreveu:
>
> > Thanks for putting this together.
> >
> > I have marked some minor nits here and there. You can put my
> > Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
>
> Thanks!
>
> > The only thing that is not a nit: is changing responsible with
> > contributor. But if we agree on the meaning (and I think that we do)
> > we can always improve this doc later.
>
> See the comments below with regards to your nits.
>
> > On Fri, Nov 29, 2024 at 12:15=E2=80=AFPM Mauro Carvalho Chehab
> > <mchehab+huawei@kernel.org> wrote:
>
> > > +In the media subsystem, there are experienced developers who can pus=
h
> > > +patches directly to the development tree. These developers are calle=
d
> > > +Media committers and are divided into the following categories:
> > > +
> > > +- Committers: responsible for one or more drivers within the media s=
ubsystem.
> > > +  They can push changes to the tree that do not affect the core or A=
BI.
> >
> > Can we say contributor instead of responsible? For me responsible
> > means maintainer.
>
> Works for me.
>
> > I would like to land patches that have been properly reviewed to the
> > committers tree for areas that I do not maintiain:
> >
> > For example:
> > - Laurent has reviewed a uvc patch that I want to land asap to avoid
> > conflicts with other patchsets that I am working with.
> > - I want to land a patch for a ci breakage that has been reviewed by
> > another person, it is trivial, and none has a bad comment about it.
> > - I want to land a fix for a driver that has been properly reviewed by
> > the maintainer and none has a bad comment about it.
>
> Makes sense. Yet, for the first example you would need to coordinate
> with the uvc maintainers to avoid conflicts at the trees they would
> be using.

Sure, coordination with the maintainer is expected.

>
> > > +Media development workflow
> > > +++++++++++++++++++++++++++
> > > +
> > > +All changes for the media subsystem must be sent first as e-mails to=
 the
> > > +media mailing list, following the process documented at
> > > +Documentation/process/index.rst.
> > > +
> > > +It means that patches shall be submitted as plain text only via e-ma=
il to:
> > > +
> > > +  `https://subspace.kernel.org/vger.kernel.org.html <linux-media@vge=
r.kernel.org>`_
> >
> > nit: Maybe this is a better url? https://lore.kernel.org/linux-media/
>
> As this is focused on upcoming contributors, placing the place that conta=
ins
> the subscription link sounds better to me. There, it has links for
> subscribe, unsubscribe, post and archive (which already links to lore).
>
> IMO, works better for newbies.
>
> > > +
> > > +Emails with HTML will be automatically rejected by the mail server.
> > > +
> > > +It could be wise to also copy the media committer(s). You should use
> > nit: How does someone know who the committers are? I think sending to
> > the ML and to ./get_maintainers.pl is enough
>
> Yes, but that's what it is written...
> >
> >
> > > +``scripts/get_maintainers.pl`` to identify whom else needs to be cop=
ied.
>
> here ^
>
> > > +Please always copy driver's authors and maintainers.
> > > +
> > > +Such patches need to be based against a public branch or tag as foll=
ows:
> > > +
> > > +1. Patches for new features need to be based at the ``next`` branch =
of
> > > +   media.git tree;
> > > +
> > > +2. Fixes against an already released kernel should preferably be aga=
inst
> > > +   the latest released Kernel. If they require a previously-applied
> > > +   change at media.git tree, they need to be against its ``fixes`` b=
ranch.
> >
> > 2. Fixes against an already released kernel should preferably be agains=
t
> >    the ``fixes`` branch of the media.git tree;
>
> The better is to have such fixes against the latest released one, as
> this would mean that such patch will apply cleanly at least at the
> latest -stable.

They will apply cleanly to the latest stable, but not to our tree.
I prefer that the author to fix the conflict in coordination with the
stable team than us. If they do not respond in good time, we can step
in.

>
> Usually, conflicts are unlikely on such cases, but, when they happen,
> committers can easily solve it.
>
> As stable will be copied on both versions, that hopefully make their
> work easier, as they can just use the version without conflicts.
>
> As a notice, usually stable people doesn't solve conflicts, if they
> have a high number of patches: they send-emails requesting us and/or
> the author to do it.
>
> > > +3. Fixes for issues not present at the latest released kernel should
> > > +   preferably be against the latest -rc1 Kernel. If they require a
> > > +   previously-applied change at media.git tree, they need to be agai=
nst
> > > +   its ``fixes`` branch.
> >
> > Can we get rid of this third type? It is a bit confusing.  My mental mo=
del is:
> > - Things for the next kernel version: next
> > - Things for this kernel version: fixes
> >
> > We will make sure to close the next tree when needed, and that fixes
> > and next are upreved accordingly.
>
> Not all people reporting patches to us will be doing against the
> media tree for stuff that are on upstream. That's perfectly fine.
> Also, it is an usual practice to have patches against -rc kernels.
> This is specially true for developers working on distros: they just
> test Linus -rc during their rolling release kernels.
>
> See, for instance:
>         https://bodhi.fedoraproject.org/updates/?packages=3Dkernel
>
> So, we need to be prepared to receive patches aiming an upcoming
> release on the top of a -rc release.
>
> Maybe we can tell, instead:
>
> 3. Fixes for issues not present at the latest released kernel shall
>    be either against a -rc kernel for an upcoming release or
>    against the ``fixes`` branch of the media.git tree.
>
> That's said, it is uncommon to have conflicts there, but sometimes
> they happen.
>
> When they happen, they're trivial enough for the committers to
> handle it.

What about. Assuming Linus would have released 6.13.rc1 today

1) New features (that will land in 6.14) =3D> media.git/next

2) Fixes for 6.13.rcX =3D> media.git/fixes

3) Fixes for <=3D 6.12  =3D>  media.git/fixes . If the patch conflicts in
stable, the author will send the patches

Only 1) can be done by committers.
2) and 3) are coordinated via You and Hans.

Note that if we make the fixes branch up to date with the latest rc,
it will make everyone's life easier. Do you see many conflicts when
you uprev it?

If you like this approach I can help with the wording. If you do not
like it, we can discuss it later and add a follow-up patch.

Also I think that providing an example will make the description more
clear... but that could be me :)

>
> > > +Once a patch is submitted, it may follow either one of the following
> > > +workflows:
> > > +
> > > +a. Pull request workflow: patches are handled by subsystem maintaine=
rs::
> > > +
> > > +     +------+   +---------+   +-------+   +-----------------------+ =
  +---------+
> > > +     |e-mail|-->|patchwork|-->|pull   |-->|maintainers merge      |-=
->|media.git|
> > > +     +------+   |picks it |   |request|   |in media-committers.git| =
  +---------+
> > > +                +---------+   +-------+   +-----------------------+
> > > +
> > > +   For this workflow, pull requests can be generated by a committer,
> > > +   a previous committer, subsystem maintainers or by a couple of tru=
sted
> >
> > I guess you mean a trusted long-time contributor, not a couple.
> > can you send a PR from two people?
>
> "a couple of" means "a few", not "a couple" ;-)
>
> but yeah, "a trusted long-time contributor" works better.

nit: for this workflow, pull requests can be generated by a committer:
subsystem maintainers or trusted long-time contributors.

(previous committers already belong to  long-time contributors)
I could even suggest removing the word trusted. Whatever you prefer.

>
> >
> > > +   long-time contributors. If you are not in such group, please don'=
t submit
> > > +   pull requests, as they will likely be ignored.
> > s/be ignored/not processed/.
> >
> > Sounds a bit better :).
>
> Agreed.
>
> > Maybe you could even say: not processed, and the author notified.
>
> You meant changing it to:
>
>         please don't submit pull requests, as they will
>         not be processed, and the author notified.
>
> right? What do you mean by "and the author notified"?
> "and the author will not be notified"?

they will not be processed, and the author will be notified.

>
> > > +b. Committers' workflow: patches are handled by media committers::
> > > +
> > > +     +------+   +---------+   +--------------------+   +-----------+=
   +---------+
> > > +     |e-mail|-->|patchwork|-->|committers merge at |-->|maintainers|=
-->|media.git|
> > > +     +------+   |picks it |   |media-committers.git|   |approval   |=
   +---------+
> > > +                +---------+   +--------------------+   +-----------+
> > > +
> > > +On both workflows, all patches shall be properly reviewed at
> > > +linux-media@vger.kernel.org before being merged at media-committers.=
git.
> > > +
> > > +When patches are picked by patchwork and when merged at media-commit=
ters,
> > > +CI bots will check for errors and may provide e-mail feedback about
> > > +patch problems. When this happens, the patch submitter must fix them
> > > +and send another version of the patch.
> >
> > must fix them, or explain why the errors are false positives.
>
> Ok.
>
> Thanks,
> Mauro

Thanks :)



--=20
Ricardo Ribalda

