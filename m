Return-Path: <linux-kernel+bounces-428356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77199E0DFB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FBE9B399ED
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6331DEFE4;
	Mon,  2 Dec 2024 20:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XQ/Og+4E"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4981DEFE2
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 20:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733172506; cv=none; b=mxtGt59YLWxHe3gFiNIlry3h6I/J0q1MTd8yu+o8pHT0EsSXO8wuPENmB4os5xT0JutjEedwXFzClwP5lcu08Doem4mMjv2y5zguf9NYR/VzHUrTOSq33s0S0/W26vpldfGlK0N9emZOTYhxoJjUkDoXCwCrP1K8x5NfNEgNhf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733172506; c=relaxed/simple;
	bh=GHni/b/0MSd0pN8f8oRO5CkqciMJrMVOARjUxr1fKpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJbP8+dbXfNOSz/BcshBbYlkTC2AjNvycCMXA0j13Woam64Rf8fwtNYZ6i4u5poM0molVMQAz09CE5JDIzd1Nmi8R4FAAVIUy20WJDP7gHai8QCfwCh5BVwH/V26V7acTJUWI8AgvQ1zBS9T1T93t3c9Ncmva0G/XIu4eBb9jmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XQ/Og+4E; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2eecc01b5ebso1125035a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 12:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733172503; x=1733777303; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AIGdPjd1jNC5hf6BcJAIQidLbkllGvPw+ghEPw5vBW8=;
        b=XQ/Og+4EZDVCNoVcJ4JoOh50ebdGDE2PtmSLcjALvHi7N+V2ea9Oreoms+kM8N2GE+
         SUH4L64coAbR7YSlMNtULSui18Df6bDgFfux/Z7uvSJT7oyO7aAQnLFflNe0CMnfnnmW
         omaFCu0EuY6bQXyKnFC9EDCdsWTxCqodjOaEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733172503; x=1733777303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AIGdPjd1jNC5hf6BcJAIQidLbkllGvPw+ghEPw5vBW8=;
        b=Zfe0Toibth1ovnl1h1A5GTpsBBMgg5q/N3jmtx1guJ4L8JVb9Ws1avByQNaa4sIpSH
         y1wYjqGSjX4oyLxj4GUeWo/oBEDjJczqlfmLviM4/AJdzfY9QlJcBMQXL1SFuxfTkeUO
         AsXUzQiPUQeuC8rk2CNBIIeifKMevFGB76R3bxJDF0hP6nyssiksbHswjdrQw7s2ww7p
         T/fVoty1VHUZLDwOSoyRVegduZvX3DrXp2C7+o1VZJBY4afzw3iywBFUI8GxA7X/7/i/
         gOBsx8b3PPGODo4fD8MhrRHgbnjxOIYfaxczvFiYwb6xYwmj4BfhOuuE813+0+jt9AEI
         nlJw==
X-Forwarded-Encrypted: i=1; AJvYcCV/auGwoiKsPNeTSAGvsuLj0xxng+iGQTjdtT4lHnS1NQw9+wT3mP5FYOKCuFR/RHqiyrMM47C5A3e3Nmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9O6T8jrmrBvnhZvVq37zD5n6hAF+QzrQjxXpkZI4Xe9tuV8k3
	QFTWwshps2qUYwPk35JDLc8E3ZrKTeMEgGGwLuL5XhG4RvyACQnjhUcyQhFMCwAmHFKJks9Lnl8
	=
X-Gm-Gg: ASbGncsWPguuovd6XDuz0sJXMD1oEagZjVW3Vba4xcEyfMq8ZyOZSrxWaCkV2b8Y8jP
	YUv9pNz0O4riOK9DhdVP9O439Vy1fMHRUS8lOUGgO+Ii06R91V71q6JhmBEqgEgPh1qEC0Wa0mC
	JxtDWtAqjDApWkoE5VnDsI6Pu7/pXwkZ1cWYfbk4DL6HSWYJCr/+z6ETsXs2jdvXPOJs2aYpoAK
	MIgq3QjG27YWrqVs9XVp3X5fG7+iRl3Ig3srpy8StR+uXlsbnxzacVGiv7F3Ap8YGM4NrebFwhx
	HtmCqi/9W3QsP5Vc
X-Google-Smtp-Source: AGHT+IFf+wFyP7UEiFRyjbBs6bKDzkUxzMR2vze956D8l/uK+8hUCcu/2qG0QBLIOG4o0dG6pB/7mw==
X-Received: by 2002:a17:90b:274a:b0:2ee:5bc9:75c3 with SMTP id 98e67ed59e1d1-2ee5bc97965mr19579442a91.5.1733172502714;
        Mon, 02 Dec 2024 12:48:22 -0800 (PST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com. [209.85.215.170])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee50f93586sm7060360a91.6.2024.12.02.12.48.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 12:48:21 -0800 (PST)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7fbd70f79f2so4571342a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 12:48:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXbjTK/4rWnUklVKI5que+WpNFHMtDNjnoGGzJKPl2CzvXuQT6/Bkt7QthybKl9Sb9qVWu6eWVK8kFnlEs=@vger.kernel.org
X-Received: by 2002:a17:90b:17d0:b0:2ee:8abd:7254 with SMTP id
 98e67ed59e1d1-2ee8abd742amr12402946a91.36.1733172500531; Mon, 02 Dec 2024
 12:48:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733131405.git.mchehab+huawei@kernel.org>
 <e9a5f9f49b185c694d38ea620bd68252eb52e9d3.1733131405.git.mchehab+huawei@kernel.org>
 <b3837cf3-8d32-41ad-82f8-855d48256f09@xs4all.nl> <20241202145405.58499677@foz.lan>
In-Reply-To: <20241202145405.58499677@foz.lan>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 2 Dec 2024 21:48:08 +0100
X-Gmail-Original-Message-ID: <CANiDSCtteEpqWmbcy87hLO7W9TefAryNcGrYhRmxza5wJrWJcQ@mail.gmail.com>
Message-ID: <CANiDSCtteEpqWmbcy87hLO7W9TefAryNcGrYhRmxza5wJrWJcQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] docs: media: update maintainer-entry-profile for multi-committers
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4ll.nl>
Content-Type: text/plain; charset="UTF-8"

Minor nits that can be ignored

On Mon, 2 Dec 2024 at 14:54, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Mon, 2 Dec 2024 14:17:48 +0100
> Hans Verkuil <hverkuil@xs4all.nl> escreveu:
>
> > Hi Mauro,
> >
> > On 02/12/2024 10:26, Mauro Carvalho Chehab wrote:
> > > As the media subsystem will experiment with a multi-committers model,
> > > update the Maintainer's entry profile to the new rules.
> > >
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > Signed-off-by: Hans Verkuil <hverkuil@xs4ll.nl>
> >
> > xs4ll.nl -> xs4all.nl
> >
> > (it's probably my typo, but please fix this in the final version)
>
> Yes, I copied and pasted it. Will fix at the next version.
>
> >
> > > Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > >  .../media/maintainer-entry-profile.rst        | 208 ++++++++++++++----
> > >  MAINTAINERS                                   |   1 +
> > >  2 files changed, 163 insertions(+), 46 deletions(-)
> > >
> > > diff --git a/Documentation/driver-api/media/maintainer-entry-profile.rst b/Documentation/driver-api/media/maintainer-entry-profile.rst
> > > index ffc712a5f632..dc764163cf1c 100644
> > > --- a/Documentation/driver-api/media/maintainer-entry-profile.rst
> > > +++ b/Documentation/driver-api/media/maintainer-entry-profile.rst
> > > @@ -27,19 +27,139 @@ It covers, mainly, the contents of those directories:
> > >  Both media userspace and Kernel APIs are documented and the documentation
> > >  must be kept in sync with the API changes. It means that all patches that
> > >  add new features to the subsystem must also bring changes to the
> > > -corresponding API files.
> > > +corresponding API documentation files.
> > >
> > > -Due to the size and wide scope of the media subsystem, media's
> > > -maintainership model is to have sub-maintainers that have a broad
> > > -knowledge of a specific aspect of the subsystem. It is the sub-maintainers'
> > > -task to review the patches, providing feedback to users if the patches are
> > > +Due to the size and wide scope of the media subsystem, the media's
> > > +maintainership model is to have committers that have a broad knowledge of
> > > +a specific aspect of the subsystem. It is the committers' task to
> > > +review the patches, providing feedback to users if the patches are
> > >  following the subsystem rules and are properly using the media kernel and
> > >  userspace APIs.
> > >
> > > -Patches for the media subsystem must be sent to the media mailing list
> > > -at linux-media@vger.kernel.org as plain text only e-mail. Emails with
> > > -HTML will be automatically rejected by the mail server. It could be wise
> > > -to also copy the sub-maintainer(s).
> > > +Media committers
> > > +----------------
> > > +
> > > +In the media subsystem, there are experienced developers who can push
> > > +patches directly to the development tree. These developers are called
> > > +Media committers and are divided into the following categories:
> > > +
> > > +- Committers:
> > > +    contributors for one or more drivers within the media subsystem.
> > > +    They can push changes to the tree that do not affect the core or ABI.
> > > +
> > > +- Core committers:
> > > +    responsible for part of the media core. They are typically
> > > +    responsible for one or more drivers within the media subsystem, but, besides
> > > +    that, they can also merge patches that change the code common to multiple
> > > +    drivers, including the kernel internal API.
> > > +
> > > +- Subsystem maintainers:
> > > +    responsible for the subsystem as a whole, with access to the
> > > +    entire subsystem.
> > > +
> > > +    Only subsystem maintainers can push changes that affect the userspace
> > > +    API/ABI.
> > > +
> > > +All media committers shall explicitly agree with the Kernel development process
> > > +as described at Documentation/process/index.rst and to the Kernel
> > > +development rules inside the Kernel documentation, including its code of
> > > +conduct.
> > > +
> > > +Media development tree
> > > +----------------------
> > > +
> > > +The main development tree used by the media subsystem is hosted at LinuxTV.org,
> > > +where we also maintain news about the subsystem, wiki pages and a patchwork
> > > +instance where we track patches though their lifetime.
> > > +
> > > +The main tree used by media developers is at:
> > > +
> > > +https://git.linuxtv.org/media.git/
> > > +
> > > +.. _Media development workflow:
> > > +
> > > +Media development workflow
> > > +++++++++++++++++++++++++++
> > > +
> > > +All changes for the media subsystem must be sent first as e-mails to the
> > > +media mailing list, following the process documented at
> > > +Documentation/process/index.rst.
> > > +
> > > +It means that patches shall be submitted as plain text only via e-mail to
> > > +linux-media@vger.kernel.org. While subscription is not mandatory, you
> > > +can find details about how to subscribe to it and to see its archives at:
> > > +
> > > +  https://subspace.kernel.org/vger.kernel.org.html
> > > +
> > > +Emails with HTML will be automatically rejected by the mail server.
> > > +
> > > +It could be wise to also copy the media committer(s). You should use
> > > +``scripts/get_maintainers.pl`` to identify whom else needs to be copied.
> > > +Please always copy driver's authors and maintainers.
> > > +
> > > +Such patches need to be based against a public branch or tag as follows:
> > > +
> > > +1. Patches for new features need to be based at the ``next`` branch of
> > > +   media.git tree;
> > > +
> > > +2. Fixes against an already released kernel should preferably be against
> > > +   the latest released Kernel. If they require a previously-applied
> > > +   change at media.git tree, they need to be against its ``fixes`` branch.
> >
> > What is an "released kernel"? Does an -rcX kernel qualify?
> > > +
> > > +3. Fixes for issues not present at the latest released kernel shall
> > > +   be either against a -rc kernel for an upcoming release or
> > > +   against the ``fixes`` branch of the media.git tree.
> >
> > 2 and 3 remain vague, IMO. Not a blocker, but I think this needs more work
> > at some point.
>
> Some Kernel documents use "mainline release" to refer to Kernel final
> releases.
>
> One option to make it clearer would be to add a link to:
>         https://www.kernel.org/category/releases.html
>
> And then use the terms:
>         - "Mainline release" for v6.10, v6.11, v6.12...
>         - "Prepatch release" for -rc1, -rc2, -rc3...
>
> What 2 and means are:
>
>         1. Features for the next mainline release:
>
>            - baseline shall be media.git ``next`` branch;
>
>         2. Fixes bugs at mainline releases:
         2. Bug fixes for the current mainline release

>
>            - baseline shall be the latest mainline release or media.git ``fixes``
>              if changes depend on a fix already merged;
>
>         3. Fixes for the next mainline release:
         3. Bug fixes for the next mainline release
>
>            - baseline shall be a prepatch release or media.git ``fixes``
            - baseline shall be a prepatch release (rcX) or media.git ``fixes``
>              if changes depend on a fix already merged;
>
>         .. Note:
>
>            See https://www.kernel.org/category/releases.html for an overview
>            about Kernel release types.
>
> Would the above text work best you? If not please propose another
> text.
>
> In practice, we'll likely accept other baselines for fixes as
> well, for practical reasons. From my side, I don't have any issues
> if I need to rebase a tested bugfix patch produced against an
> older Kernel send by an occasional contributor, if it only has
> trivial merge conflicts.
>
> > > +Patches with fixes shall have:
> > > +
> > > +- a ``Fixes:`` tag pointing to the first commit that introduced the bug;
> > > +- when applicable, a ``Cc: stable@vger.kernel.org``.
> > > +
> > > +Patches that were fixing bugs publicly reported by someone at the
> > > +linux-media@vger.kernel.org mailing list shall have:
> > > +
> > > +- a ``Reported-by:`` tag immediately followed by a ``Closes:`` tag.
> > > +
> > > +Patches that change API shall update documentation accordingly at the
> > > +same patch series.
> > > +
> > > +See Documentation/process/index.rst for more details about e-mail submission.
> > > +
> > > +Once a patch is submitted, it may follow either one of the following
> > > +workflows:
> > > +
> > > +a. Pull request workflow: patches are handled by subsystem maintainers::
> > > +
> > > +     +------+   +---------+   +-------+   +-----------------------+   +---------+
> > > +     |e-mail|-->|patchwork|-->|pull   |-->|maintainers merge      |-->|media.git|
> > > +     +------+   |picks it |   |request|   |in media-committers.git|   +---------+
> > > +                +---------+   +-------+   +-----------------------+
> > > +
> > > +   For this workflow, pull requests can be generated by a committer,
> > > +   a previous committer, subsystem maintainers or by a trusted long-time
> > > +   contributor. If you are not in such group, please don't submit
> > > +   pull requests, as they will not be processed.
> > > +
> > > +b. Committers' workflow: patches are handled by media committers::
> > > +
> > > +     +------+   +---------+   +--------------------+   +-----------+   +---------+
> > > +     |e-mail|-->|patchwork|-->|committers merge at |-->|maintainers|-->|media.git|
> > > +     +------+   |picks it |   |media-committers.git|   |approval   |   +---------+
> > > +                +---------+   +--------------------+   +-----------+
> > > +
> > > +On both workflows, all patches shall be properly reviewed at
> > > +linux-media@vger.kernel.org before being merged at media-committers.git.
> > > +
> > > +When patches are picked by patchwork and when merged at media-committers,
> > > +CI bots will check for errors and may provide e-mail feedback about
> > > +patch problems. When this happens, the patch submitter must fix them, or
> > > +explain why the errors are false positives.
> > > +
> > > +Patches will only be moved to the next stage in those two workflows if they
> > > +don't fail on CI or if there are false-positives in the CI reports.
> > > +
> > > +Failures during e-mail submission
> > > ++++++++++++++++++++++++++++++++++
> > >
> > >  Media's workflow is heavily based on Patchwork, meaning that, once a patch
> > >  is submitted, the e-mail will first be accepted by the mailing list
> > > @@ -47,51 +167,48 @@ server, and, after a while, it should appear at:
> > >
> > >     - https://patchwork.linuxtv.org/project/linux-media/list/
> > >
> > > -If it doesn't automatically appear there after a few minutes, then
> > > +If it doesn't automatically appear there after some time [2]_, then
> > >  probably something went wrong on your submission. Please check if the
> > > -email is in plain text\ [2]_ only and if your emailer is not mangling
> > > +email is in plain text\ [3]_ only and if your emailer is not mangling
> > >  whitespaces before complaining or submitting them again.
> > >
> > > -You can check if the mailing list server accepted your patch, by looking at:
> > > +To troubleshoot problems, you should first check if the mailing list
> > > +server has accepted your patch, by looking at:
> > >
> > >     - https://lore.kernel.org/linux-media/
> > >
> > > -.. [2] If your email contains HTML, the mailing list server will simply
> > > +If the patch is there and not at patchwork, it is likely that your e-mailer
> > > +mangled the patch. Patchwork internally has a logic that checks if the
> >
> > a logic -> logic
> >
> > > +received e-mail contain a valid patch. Any whitespace and new line
> >
> > contain -> contains
> >
> > > +breakages mangling the patch won't be recognized by patchwork, thus such
> > > +patch will be rejected.
> > > +
> > > +.. [2] It usually takes a few minutes for the patch to arrive, but
> > > +       the e-mail server may be busy, so it may take up to a few hours
> > > +       for a patch to be picked by patchwork.
> > > +
> > > +.. [3] If your email contains HTML, the mailing list server will simply
> > >         drop it, without any further notice.
> > >
> > > +.. _media-developers-gpg:
> > >
> > > -Media maintainers
> > > -+++++++++++++++++
> > > +Authentication for pull and merge requests
> > > +++++++++++++++++++++++++++++++++++++++++++
> > >
> > > -At the media subsystem, we have a group of senior developers that
> > > -are responsible for doing the code reviews at the drivers (also known as
> > > -sub-maintainers), and another senior developer responsible for the
> > > -subsystem as a whole. For core changes, whenever possible, multiple
> > > -media maintainers do the review.
> > > +The authenticity of developers submitting pull requests and merge requests
> > > +shall be validated by using PGP sign. See: :ref:`kernel_org_trust_repository`.
> >
> > sign -> signing
> >
> > Hmm, merge requests through gitlab are not signed. So this isn't correct, I
> > think.
>
> No, but they are authenticated based on gitlab's user ID. The authentication
> we'll have is when the new committer sends us an e-mail providing the
> gitlab's user ID.
>
> See patch 3, as it contains some changes aiming to better explain it. Once
> it get the same people reviewing that also reviewed 1 and 2, I'll fold it.
>
> >
> > >
> > > -The media maintainers that work on specific areas of the subsystem are:
> > > +With the pull request workflow, pull requests shall use a PGP-signed tag.
> > >
> > > -- Remote Controllers (infrared):
> > > -    Sean Young <sean@mess.org>
> > > +For more details about PGP sign, please read
> > > +Documentation/process/maintainer-pgp-guide.rst.
> > >
> > > -- HDMI CEC:
> > > -    Hans Verkuil <hverkuil@xs4all.nl>
> > > +Subsystem maintainers
> > > +---------------------
> > >
> > > -- Media controller drivers:
> > > -    Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > -
> > > -- ISP, v4l2-async, v4l2-fwnode, v4l2-flash-led-class and Sensor drivers:
> > > -    Sakari Ailus <sakari.ailus@linux.intel.com>
> > > -
> > > -- V4L2 drivers and core V4L2 frameworks:
> > > -    Hans Verkuil <hverkuil@xs4all.nl>
> > > -
> > > -The subsystem maintainer is:
> > > -  Mauro Carvalho Chehab <mchehab@kernel.org>
> > > -
> > > -Media maintainers may delegate a patch to other media maintainers as needed.
> > > -On such case, checkpatch's ``delegate`` field indicates who's currently
> > > -responsible for reviewing a patch.
> > > +The subsystem maintainers are:
> > > +  - Mauro Carvalho Chehab <mchehab@kernel.org> and
> > > +  - Hans Verkuil <hverkuil@xs4all.nl>
> > >
> > >  Submit Checklist Addendum
> > >  -------------------------
> > > @@ -108,17 +225,14 @@ implementing the media APIs:
> > >  ====================       =======================================================
> > >  Type                       Tool
> > >  ====================       =======================================================
> > > -V4L2 drivers\ [3]_ ``v4l2-compliance``
> > > +V4L2 drivers\ [4]_ ``v4l2-compliance``
> > >  V4L2 virtual drivers       ``contrib/test/test-media``
> > >  CEC drivers                ``cec-compliance``
> > >  ====================       =======================================================
> > >
> > > -.. [3] The ``v4l2-compliance`` also covers the media controller usage inside
> > > +.. [4] The ``v4l2-compliance`` also covers the media controller usage inside
> >
> > The ``v4l2-compliance`` utility
> >
> > (add 'utility')
>
> Ok.
>
> >
> > >         V4L2 drivers.
> > >
> > > -Other compilance tools are under development to check other parts of the
> > > -subsystem.
> > > -
> > >  Those tests need to pass before the patches go upstream.
> > >
> > >  Also, please notice that we build the Kernel with::
> > > @@ -134,6 +248,8 @@ Where the check script is::
> > >  Be sure to not introduce new warnings on your patches without a
> > >  very good reason.
> > >
> > > +Please see `Media development workflow`_ for e-mail submission rules.
> > > +
> > >  Style Cleanup Patches
> > >  +++++++++++++++++++++
> > >
> > > @@ -199,7 +315,7 @@ tree between -rc6 and the next -rc1.
> > >  Please notice that the media subsystem is a high traffic one, so it
> > >  could take a while for us to be able to review your patches. Feel free
> > >  to ping if you don't get a feedback in a couple of weeks or to ask
> > > -other developers to publicly add Reviewed-by and, more importantly,
> > > +other developers to publicly add ``Reviewed-by:`` and, more importantly,
> > >  ``Tested-by:`` tags.
> > >
> > >  Please note that we expect a detailed description for ``Tested-by:``,
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 1e930c7a58b1..c77f56a2e695 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -14510,6 +14510,7 @@ MEDIA INPUT INFRASTRUCTURE (V4L/DVB)
> > >  M: Mauro Carvalho Chehab <mchehab@kernel.org>
> > >  L: linux-media@vger.kernel.org
> > >  S: Maintained
> > > +P: Documentation/driver-api/media/maintainer-entry-profile.rst
> > >  W: https://linuxtv.org
> > >  Q: http://patchwork.kernel.org/project/linux-media/list/
> >
> > Shouldn't this point to our patchwork instance instead?
>
> Good catch! I'll update it.
>
> >
> > >  T: git git://linuxtv.org/media.git
> >
> > Regards,
> >
> >       Hans
>
>
>
> Thanks,
> Mauro



-- 
Ricardo Ribalda

