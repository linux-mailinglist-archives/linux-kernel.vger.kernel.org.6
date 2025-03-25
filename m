Return-Path: <linux-kernel+bounces-575934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B89A70908
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3357A3A810E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D449919B3EC;
	Tue, 25 Mar 2025 18:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awRqFqxo"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CF31991D2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 18:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742927386; cv=none; b=myO7emeLRAGSqvfNXUqgpMfmhrG6FwefwaGWhZVDuluJEJYgNqq3k9EmAJYGvCPxO62ffqi44bgdlpJN5EJmi8yAasL/O5I54sd572u0WKXKH4FkWjY6aZJy182OblVVxjM1oD4+A/EWoO7D4TLstFjAiKtUdGgqqM21i1P/+fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742927386; c=relaxed/simple;
	bh=NuI7FIOIqRGJQoJEUHE4oqATBzjAmNttmo4568EtUFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZIRhMahTthoS19abKlgPSFEiBxO0aROn1trtz28r1htG3X9pvm8S0D6t3Ub0uCZEOb3RZuNU1swmIAfKiQY0z2195iVxHMcR+4XueuoHw680834lWzT4yryKhRE0ve1+h1G2ejwEAcC1zynCffAcL5crrkYxFYSUOV5X6yX6fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awRqFqxo; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ef7c9e9592so49966457b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742927383; x=1743532183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrcQMqawSQzJcQ5iaIhabL0LanhIuq3ELqb60ctwCEk=;
        b=awRqFqxoD2DL7XemqCJuLEYi9XLs3B0YsIirdJ53MyQR8b2YivD8EIX/+/SZvoA3xE
         j2K4CopWhf5DxxByT9xd6Y1nY8kNYY/PA73D5Qf8iPgVXAm5XqsJwW62cz6HOBR/snK0
         9RyQr8pQoLcW3q3mluh5JSxa6rp5lewkQWki4GqCPvqQEJ0fgcTnU7K2fYgycmyYEkWK
         eTU+NJUpW20vVtUY4wOfSIyJuZt62G5O8+yFWBE/NET2FGgpqMIdyqdq60/n52CPZ+Gu
         Cx8LxnC0ecm9gvLZBN+86EZPcVuqMIJP/cfWhPqeSOrMh5x2r6XJzmKynWB7jTJeCF3Y
         f4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742927383; x=1743532183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MrcQMqawSQzJcQ5iaIhabL0LanhIuq3ELqb60ctwCEk=;
        b=jV1UaWdg3vP1R7uQza3HpQM0yMHxDXRw/2OwF1MtzVRDsOsdQkTF4dK1dT8YA8t1CC
         bVUjyPHpGGffphvf1OyA6gPm6ESuN1jx6a9/okMlMSbh/ECyVmArp4nmH5tAHeDlqfQS
         kuIgvFdiqMTXNZzSpeLGL18AU0KnZTTy64wAZzWC47kNJmcqJCUJ0uBPuYUEM5CHpR2L
         KGdFZ9J94dQMBRmvEQmCAdbohoqNd95GqEgbbOVJR0NPlVngmLi7mw5lSpGJnPwkbGx6
         pWNIMIavAOG3kV9dh4Wb868geXCfNEv4gSsS9E2xUF6BhnPPN+eQgsbI+1eEyiKhxY9A
         /cMg==
X-Gm-Message-State: AOJu0YyChXuXuaLi9wEGrAxKyAhDbE/1Dxet31EvA22Bllki5IjY5LLz
	zPbrK/twSnBgeIU3CBEMzzsFmCrQt8HjKzt39Z2VG4KguiKc6qdw1d/hFEJzOwPg5xNpn+wvhTR
	30WwP4IvwfhMNKXT+SVdMTSXgsP0=
X-Gm-Gg: ASbGncvzOJMEVWIr5kHfCWX4gciH0tGFKh3/vAlgUKRcXMybzSAMlXOIxEDMgFfu10V
	cU9sNir9a9f7brnJtSc08tYXDUG1WATH+unIH8wovaVPabwtBJqlfv7tVfuZlthP9oBd7h4+kNN
	pdXLm1gut5rBDAQJrn/wZZwwEW
X-Google-Smtp-Source: AGHT+IGSYmYgheX9gYmSYWZVtqE6/0HkKR1jPp2CwbNY9HGr77Lm7kMi0w0OpRvDpWIHY8B30zbphEO20QwIKfu/s4A=
X-Received: by 2002:a05:690c:640d:b0:6fb:b4e7:1471 with SMTP id
 00721157ae682-700babf5ec9mr217278727b3.7.1742927382961; Tue, 25 Mar 2025
 11:29:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320185238.447458-1-jim.cromie@gmail.com> <20250320185238.447458-31-jim.cromie@gmail.com>
 <0828cfdb-abf3-42c5-8500-70f36affd0a8@bootlin.com>
In-Reply-To: <0828cfdb-abf3-42c5-8500-70f36affd0a8@bootlin.com>
From: jim.cromie@gmail.com
Date: Tue, 25 Mar 2025 12:29:16 -0600
X-Gm-Features: AQ5f1JpL4zfuR5gFvMhO5JMn9AbG8jHdc2qnKxdZBAmkJZi1rc9OZZj-4YfgnjU
Message-ID: <CAJfuBxzHEtS1psJ+L_6=FP-mU3b8mgLQbXRWoizLkZoRUB6G1Q@mail.gmail.com>
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

On Mon, Mar 24, 2025 at 9:20=E2=80=AFAM Louis Chauvet <louis.chauvet@bootli=
n.com> wrote:
>
>
>
> Le 20/03/2025 =C3=A0 19:52, Jim Cromie a =C3=A9crit :
> > Current classmap code protects class'd pr_debugs from unintended
> > changes by "legacy" unclassed queries:
> >
> >    # this doesn't disable all of DRM_UT_* categories
> >    echo "-p" > /proc/dynamic_debug/control
> >
> >    # name the class to change it - protective but tedious
> >    echo "class DRM_UT_CORE +p" > /proc/dynamic_debug/control
> >
> >    # or do it the subsystem way
> >    echo 1 > /sys/module/drm/parameters/debug
> >
> > This "name the class to change it" behavior gave a modicum of
> > protection to classmap users (ie DRM) so their debug settings aren't
> > trivially and unintentionally altered underneath them.
> >
> > But this made the class keyword special in some sense; the other
> > keywords skip only on explicit mismatch, otherwize the code falls thru
>
> s/otherwize/otherwise/

ack

>
> > to adjust the pr-debug site.
> >
> > So Jason Baron didn't like this special case when I 1st proposed it;
> > I argued 2 points:
> > - "protection gives stable-debug, improving utility"
> > - __drm_debug is authoritative w/o dyndbg under it.
> >
> > I thought I'd convinced him back then, (and the patchset got merged),
> > but he noted it again when he reviewed this series.  So this commit
> > names the "special case": ddebug_client_module_protects_classes(), and
> > reverts it to Jason's preference.
>   >
> > If a class mismatch is seen, code distinguishes whether the class was
> > explicitly given (and always skips/continue), or the DFLT was assumed
> > because no class was given.  Here we test
> > ddebug_client_module_protects_classes(), skip if so.
> >
> > Later, if any user/module wants to protect its classes, we could add a
> > flag to ddebug_table, a means to set it from CLASSMAP_DEFINE, and
> > check it when applying a classless query/cmd.
>
> I don't really understand the goal of the protection, do you have the
> discussion between you and Jason so I can have some context and some
> answer to my questions?
>

The on-list discussion is here.

https://lore.kernel.org/lkml/2d3846cb-ff9a-3484-61a8-973799727d8f@akamai.co=
m/
https://lore.kernel.org/lkml/0d9f644f-3d60-02c3-7ce0-01296757e181@akamai.co=
m/#t

At the time I thought it was unfinished business, and expected some
more discussion,
but that didnt happen, and later GregKH committed the set.

Last summer I emailed him privately, and he made a 5-6 points Ive
addressed in this rev,
(reduction of repetitive code, enforcing classmap constraints,
protecting against misuse)
but it also became clear he still didnt like the "specialness" of the keywo=
rd,
given by the _DFLT constraint applied to legacy callsites and queries.

Since thats a bit of a philosophical debate, I looked for a technical solut=
ion,
to have it either way with fairly trivial additions, and to yield
until user experience
dictates otherwise

To be clear, I still think protecting the "classed" is proper.
Without dyndbg, /sys/module/drm/parameters/debug is authoritative, full sto=
p.
I'm surprised any customer would give away that certainty,
it looks like a (small caliber) footgun to me.
But its not worth disagreeing on.
Hence this patch reverts that "protection"

> With the example you gave above, I think this could lead to a very odd
> behavior: if I enable dyndbg, I expect any pr_dbg to be managed by
> dyndbg settings.

if by "any" you mean ALL the ones that currently exist,
before we add a whole new "CLASS" of user,
(with ~5k uses, all comfortable with their exclusive control)
I can agree.

echo class FOO +p > control
gives full control.  You just have to say so for the new classes of users.

>
> If a user writes stuff on dyndbg control, he clearly knows what he is
> doing, and he wants to control what logs he wants.
>
> And if you allow multiple "protected" users, the normal way to disable
> all dyndbg logs will be:
>
>         ddcmd -p
>         ddcmd class DRM_UT_CORE -p
>         ddcmd class DRM_... -p # all drm classes
>         ddcmd class SPI_... -p # all spi classes
>         ddcmd class WHATEVER_... -p # all other subsystem
>
>         # And only now you can enable only what you want
>         ddcmd module my_mod +p
>
> This is clearly annoying to write.

It is clearly annoying.
It doesnt need to be handy.
thats what /sys/module/drm/parameters/debug is for.
with modest "protection" of explicit naming,
the sysfs knob can reasonably be expected
to reflect whats going on underneath.
Without it, bets are misplaced.

>
> If DRM (or whatever subsystem) wants to add a debug parameter and use it
> to control their logs without being impacted by dyndbg, I believe it
> should not use dyndbg classes to do it.

hmm - dyndbg's 1st value is its NOOP cost when off.
If thats not worth something, you wouldnt bother using it.


In any case, its pretty clear that my viewpoint isnt prevailing here,
and as I said, I dont care enough to disagree.
the reversion here can stand.


>
> > CC: jbaron@akamai.com
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> >   lib/dynamic_debug.c | 34 +++++++++++++++++++++++++---------
> >   1 file changed, 25 insertions(+), 9 deletions(-)
> >
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index c44502787c2b..13de0dd3a4ad 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> > @@ -193,6 +193,17 @@ static int ddebug_find_valid_class(struct ddebug_t=
able const *dt, const char *cl
> >       return -ENOENT;
> >   }
> >
> > +/*
> > + * classmaps-v1 protected classes from changes by legacy commands
> > + * (those selecting _DPRINTK_CLASS_DFLT by omission), v2 undoes that
> > + * special treatment.  State so explicitly.  Later we could give
> > + * modules the choice to protect their classes or to keep v2 behavior.
> > + */
> > +static inline bool ddebug_client_module_protects_classes(const struct =
ddebug_table *dt)
> > +{
> > +     return false;
> > +}
> > +
> >   /*
> >    * Search the tables for _ddebug's which match the given `query' and
> >    * apply the `flags' and `mask' to them.  Returns number of matching
> > @@ -206,7 +217,7 @@ static int ddebug_change(const struct ddebug_query =
*query, struct flag_settings
> >       unsigned int newflags;
> >       unsigned int nfound =3D 0;
> >       struct flagsbuf fbuf, nbuf;
> > -     int valid_class;
> > +     int slctd_class;
>
> Nitpick: can you use full words? slctd is difficult to read.
>
> >
> >       /* search for matching ddebugs */
> >       mutex_lock(&ddebug_lock);
> > @@ -218,21 +229,26 @@ static int ddebug_change(const struct ddebug_quer=
y *query, struct flag_settings
> >                       continue;
> >
> >               if (query->class_string) {
> > -                     valid_class =3D ddebug_find_valid_class(dt, query=
->class_string);
> > -                     if (valid_class < 0)
> > +                     slctd_class =3D ddebug_find_valid_class(dt, query=
->class_string);
> > +                     if (slctd_class < 0)
> > +                             /* skip/reject classes unknown by module =
*/
> >                               continue;
> >               } else {
> > -                     /* constrain query, do not touch class'd callsite=
s */
> > -                     valid_class =3D _DPRINTK_CLASS_DFLT;
> > +                     slctd_class =3D _DPRINTK_CLASS_DFLT;
> >               }
> >
> >               for (i =3D 0; i < dt->info.descs.len; i++) {
> >                       struct _ddebug *dp =3D &dt->info.descs.start[i];
> >
> > -                     /* match site against query-class */
> > -                     if (dp->class_id !=3D valid_class)
> > -                             continue;
> > -
> > +                     if (dp->class_id !=3D slctd_class) {
> > +                             if (query->class_string)
> > +                                     /* site.class !=3D given class */
> > +                                     continue;
> > +                             /* legacy query, class'd site */
> > +                             else if (ddebug_client_module_protects_cl=
asses(dt))
> > +                                     continue;
> > +                             /* allow change on class'd pr_debug */
> > +                     }
> >                       /* match against the source filename */
> >                       if (query->filename &&
> >                           !match_wildcard(query->filename, dp->filename=
) &&
>
> --
> Louis Chauvet, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
>

