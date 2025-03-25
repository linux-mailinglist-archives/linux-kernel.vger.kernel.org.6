Return-Path: <linux-kernel+bounces-576286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34345A70D77
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 00:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 629B77A3E62
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA0B254841;
	Tue, 25 Mar 2025 23:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m19BXeUe"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047FC1B4234
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 23:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742943953; cv=none; b=nkFaVQaou6CxnnuLj4WY6tIOvjJrD82OaH6TBGSTzX4icqgf8V81rTs1TtVY0MzI04DPoZjwXwaEQLTb2ZFkSAsUHhXa48lOAN51W4LgrK2lPHN1aYv9ALFXqj2EejFFKunMD2dEBjer8tBke/ZPcNipmGujBfdO4YPvI8v1OIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742943953; c=relaxed/simple;
	bh=30uExJbNla7us7TaZvc03CFiD8p46S3/jIKRWAZnYiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+N+QX/0WNnJdRJKwJVxaHFFu1mjS6gSWcxmaxXhuRn1G+f/+aitYH/eFNedWHLfYMVkVuAEfqGxkTVaZKNjzkf0DYlR4cr/S7s0LrFjFlbgC//foiXMaSP1hsVz4ZoYgvicab3Atf8UQ4neVs1WoI4Lacd1gsdhTPU9TqGVzmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m19BXeUe; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6f6ae4846c7so60087347b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742943951; x=1743548751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LYyh7cvIBy6gyg3IkrEGbKsjVJ9+uHDh9H38tA/bPY=;
        b=m19BXeUeEFK/hbi4tfeRCuszKKIckTAROJnk2SkI2vbG7HZWXuD3Nvk+p89eZOGjQs
         KumyDuv4EjiSDkLYuXkH1Uu4RyU91ZPRQ8DY5LhWLZORQBD2/q09izTQE3uQYfdNlydF
         cWJzb90vLc8TE2cuLj3o6zLdQbw6JhFOtJUdYii9UnMNUKg3mNzTIDHid9O5PwVpbYvC
         Itdtyyi799WdaWDQwWY0eSM1hOzNAF6SIb5DfQtnNRnW7/WOs30P1YtGmFWsF4jM6gqe
         GTnBcnYt846DFE8lD20k/FuiS3kwxxHTx7PAkWtFX9gT6QSOLDR+aNTS83lP2GEG8vVf
         fG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742943951; x=1743548751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LYyh7cvIBy6gyg3IkrEGbKsjVJ9+uHDh9H38tA/bPY=;
        b=QbJmWNIgLmsgb+hZmoOoaFkZNgDiIliw226+0OUgpRim9X2xmt5znxGoLzp4wjGsHf
         UZXMSayvXqrvLTCEv5Z/038KEjbNutXchbxM5Xbb6QPtudE9IL62F7d3i3eSJuZOzZrD
         1Gue4+Mny7tnTyO4bjSIbRYqas0P82g9azsjCSyrxPoSxhLP2r7dChr1DIYMOP8m5ckb
         ajC831bf7m2iEr26uMRUBTe6elfDYc6t1b/gGy2S/P0Gaccgk2pzSF4gPljuOtATj0cS
         bkT0JDYDYpzkbGVI1PlmS5uMLyQYkLukz4W6AueMSF6wqFUxbUYsIGvsbzzOmQ17lmNf
         aQUQ==
X-Gm-Message-State: AOJu0YxuVyxJeVRWfMJGhmi16/p0cf6qpBJdJuw5nZBj7LbQiPFDzu8x
	vGQEbnzuzJwLBUJX+yw/tRsP571lTKBf262AkWLkT5FqNfoIwrdtg/MvQqrjrj9LI6XO8lWS8h0
	g8LbRt8rgmGDhefkSgr/ljWE2BZ977OCH
X-Gm-Gg: ASbGncsoGb8U3dwVw6LbuG4tgN76bPaKpIPjVWPAAVxz6m9ztox1VE+IjszGNQTT9XW
	Y4iB2fkQHRj4EUQI0YNKQ7Y9dN2fG0hZWpDLbA/ehfD+lEZ+RuBh6EowGV1OKf76xKGHfrTyHoo
	YQkPMVb9BCWlpE5r/UkH50dGTV
X-Google-Smtp-Source: AGHT+IFDS0/bmylajohYScfMRJASfdJ94Z8dAaU9Iu5+MxKXgHCh/sXXScoa/kPcmSMVjhI64o9HD206lCBiVRkHZUw=
X-Received: by 2002:a05:690c:62c7:b0:6fd:22fb:f21b with SMTP id
 00721157ae682-700bac5dd77mr270803627b3.18.1742943950541; Tue, 25 Mar 2025
 16:05:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320185238.447458-1-jim.cromie@gmail.com> <20250320185238.447458-31-jim.cromie@gmail.com>
 <0828cfdb-abf3-42c5-8500-70f36affd0a8@bootlin.com> <CAJfuBxzHEtS1psJ+L_6=FP-mU3b8mgLQbXRWoizLkZoRUB6G1Q@mail.gmail.com>
In-Reply-To: <CAJfuBxzHEtS1psJ+L_6=FP-mU3b8mgLQbXRWoizLkZoRUB6G1Q@mail.gmail.com>
From: jim.cromie@gmail.com
Date: Tue, 25 Mar 2025 17:05:24 -0600
X-Gm-Features: AQ5f1JqDBPnZp9kI3zjF5AGf9PrDQTP2_tFSu-HI5zfD_s9-HLrOkUICv28MItI
Message-ID: <CAJfuBxy3HWJuiBBSySGEUtDcpSNh7Kmds2t8TRGouSOqE1O2OA@mail.gmail.com>
Subject: Re: [PATCH v2 30/59] dyndbg: drop "protection" of class'd pr_debugs
 from legacy queries
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, intel-gfx-trybot@lists.freedesktop.org, 
	jbaron@akamai.com, gregkh@linuxfoundation.org, ukaszb@chromium.org, 
	daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com, 
	ville.syrjala@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 12:29=E2=80=AFPM <jim.cromie@gmail.com> wrote:
>
> On Mon, Mar 24, 2025 at 9:20=E2=80=AFAM Louis Chauvet <louis.chauvet@boot=
lin.com> wrote:
> >
> >
> >
> > Le 20/03/2025 =C3=A0 19:52, Jim Cromie a =C3=A9crit :
> > > Current classmap code protects class'd pr_debugs from unintended
> > > changes by "legacy" unclassed queries:
> > >
> > >    # this doesn't disable all of DRM_UT_* categories
> > >    echo "-p" > /proc/dynamic_debug/control
> > >
> > >    # name the class to change it - protective but tedious
> > >    echo "class DRM_UT_CORE +p" > /proc/dynamic_debug/control
> > >
> > >    # or do it the subsystem way
> > >    echo 1 > /sys/module/drm/parameters/debug
> > >
> > > This "name the class to change it" behavior gave a modicum of
> > > protection to classmap users (ie DRM) so their debug settings aren't
> > > trivially and unintentionally altered underneath them.
> > >
> > > But this made the class keyword special in some sense; the other
> > > keywords skip only on explicit mismatch, otherwize the code falls thr=
u
> >
> > s/otherwize/otherwise/
>
> ack
>
> >
> > > to adjust the pr-debug site.
> > >
> > > So Jason Baron didn't like this special case when I 1st proposed it;
> > > I argued 2 points:
> > > - "protection gives stable-debug, improving utility"
> > > - __drm_debug is authoritative w/o dyndbg under it.
> > >
> > > I thought I'd convinced him back then, (and the patchset got merged),
> > > but he noted it again when he reviewed this series.  So this commit
> > > names the "special case": ddebug_client_module_protects_classes(), an=
d
> > > reverts it to Jason's preference.
> >   >
> > > If a class mismatch is seen, code distinguishes whether the class was
> > > explicitly given (and always skips/continue), or the DFLT was assumed
> > > because no class was given.  Here we test
> > > ddebug_client_module_protects_classes(), skip if so.
> > >
> > > Later, if any user/module wants to protect its classes, we could add =
a
> > > flag to ddebug_table, a means to set it from CLASSMAP_DEFINE, and
> > > check it when applying a classless query/cmd.
> >
> > I don't really understand the goal of the protection, do you have the
> > discussion between you and Jason so I can have some context and some
> > answer to my questions?
> >
>
> The on-list discussion is here.
>
> https://lore.kernel.org/lkml/2d3846cb-ff9a-3484-61a8-973799727d8f@akamai.=
com/
> https://lore.kernel.org/lkml/0d9f644f-3d60-02c3-7ce0-01296757e181@akamai.=
com/#t
>
> At the time I thought it was unfinished business, and expected some
> more discussion,
> but that didnt happen, and later GregKH committed the set.
>
> Last summer I emailed him privately, and he made a 5-6 points Ive
> addressed in this rev,
> (reduction of repetitive code, enforcing classmap constraints,
> protecting against misuse)
> but it also became clear he still didnt like the "specialness" of the key=
word,
> given by the _DFLT constraint applied to legacy callsites and queries.
>
> Since thats a bit of a philosophical debate, I looked for a technical sol=
ution,
> to have it either way with fairly trivial additions, and to yield
> until user experience
> dictates otherwise
>
> To be clear, I still think protecting the "classed" is proper.
> Without dyndbg, /sys/module/drm/parameters/debug is authoritative, full s=
top.
> I'm surprised any customer would give away that certainty,
> it looks like a (small caliber) footgun to me.
> But its not worth disagreeing on.
> Hence this patch reverts that "protection"
>
> > With the example you gave above, I think this could lead to a very odd
> > behavior: if I enable dyndbg, I expect any pr_dbg to be managed by
> > dyndbg settings.
>
> if by "any" you mean ALL the ones that currently exist,
> before we add a whole new "CLASS" of user,
> (with ~5k uses, all comfortable with their exclusive control)
> I can agree.
>
> echo class FOO +p > control
> gives full control.  You just have to say so for the new classes of users=
.
>
> >
> > If a user writes stuff on dyndbg control, he clearly knows what he is
> > doing, and he wants to control what logs he wants.
> >
> > And if you allow multiple "protected" users, the normal way to disable
> > all dyndbg logs will be:
> >
> >         ddcmd -p
> >         ddcmd class DRM_UT_CORE -p
> >         ddcmd class DRM_... -p # all drm classes
> >         ddcmd class SPI_... -p # all spi classes
> >         ddcmd class WHATEVER_... -p # all other subsystem
> >
> >         # And only now you can enable only what you want
> >         ddcmd module my_mod +p
> >
> > This is clearly annoying to write.
>
> It is clearly annoying.
> It doesnt need to be handy.
> thats what /sys/module/drm/parameters/debug is for.
> with modest "protection" of explicit naming,
> the sysfs knob can reasonably be expected
> to reflect whats going on underneath.
> Without it, bets are misplaced.
>

Heres an improvement:

a use of CLASSMAP_PARAM means user wants a sysfs knob.
We can reasonably conclude they prefer that mode of control
(its what DRM users would expect, since a long time ago).

In that case, protect the PARAM settings
(from unqualified settings, use of class FOO still works)
otherwise no protection.
simple to explain, no extra knobs.



> >
> > If DRM (or whatever subsystem) wants to add a debug parameter and use i=
t
> > to control their logs without being impacted by dyndbg, I believe it
> > should not use dyndbg classes to do it.
>
> hmm - dyndbg's 1st value is its NOOP cost when off.
> If thats not worth something, you wouldnt bother using it.
>
>
> In any case, its pretty clear that my viewpoint isnt prevailing here,
> and as I said, I dont care enough to disagree.
> the reversion here can stand.
>
>

apologies, since Im sounding kinda argumentative.
Jim

