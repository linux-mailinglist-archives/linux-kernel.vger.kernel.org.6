Return-Path: <linux-kernel+bounces-197321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFC08D6949
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030C11F26735
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDA67F499;
	Fri, 31 May 2024 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="R++cZoet"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A447E774
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 18:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717181793; cv=none; b=psEow6TTdFL/aR1HybmDRPsmhdBKx4MJFB+DWMfZvFQ1D3LpTKMAXSKI60tCugl/o+MxprBKgjMkrEwbDSE+YdHEuXbK9U5Ih6QuFMLPHV70zIBiAzKblO/jug+0Ei6623AGUDhmQ+tXxZkpn1IojsbhSwl9mwWIt56th5nqHBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717181793; c=relaxed/simple;
	bh=2Qz7Mobi1Jemvm70CEaxkqIwHatVUT3Igmm0sp2NxxE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rf7DuUpTnvSx8QyOYwSeqYVM7MAhigZSSNHmWJrtG4G0YqWiw1lUbKXGuaF9YBvKHbDNAxkHUDfID9pdWnT54EmM4ZP/3YyteIQ+KuDX+2WVMWYFTG4sLfJq8B3JLXx5c8VqS3WrEkI5gdquyl7FlQBGGDBtIIBFlOQbvFo2cmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=R++cZoet; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1717181789; x=1717440989;
	bh=EF2H09lbmyaCypwI54sg4h1wzWqn3R/Ehd3dbT5gr3w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=R++cZoet/HlxcS1UtROgiYK3uqFp81tksJBCGM4M82AQG/p6GOCAZVTkOO3+tm3Q7
	 FgjmQDMd+qNoKjbXdSZgzhT5U1SkKHBfxP3i8getlQUpSLWaxprF1h68ycnMkPmidO
	 1AZge7qOctjLg2iFTQF4HzQdDsXpvgcsz3bK7SGwCEOGTIvROYEkDRYbEPxL/CWBgQ
	 G6/Gu1NgBpsXDBwmPVNk9KpaIwocA8ycWPWDu2BJ0YY+PMi/hbhKtVR5EbBPnl1cWa
	 DOdqmlKlf5gd82o4mRNpoIVpwdIMNzSf1TPHh9sCWWYv9d74PngRgoS6VPyFPiBZjJ
	 /rpGGncprRing==
Date: Fri, 31 May 2024 18:56:22 +0000
To: Jeff Xu <jeffxu@google.com>
From: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc: David Rheinsberg <david@readahead.eu>, Jeff Xu <jeffxu@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, cyphar@cyphar.com, dmitry.torokhov@gmail.com, Daniel Verkamp <dverkamp@chromium.org>, hughd@google.com, jorgelo@chromium.org, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, skhan@linuxfoundation.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] memfd: fix MFD_NOEXEC_SEAL to be non-sealable by default
Message-ID: <2fQi6XI7TmRN_qi9xldglgYFujpzMvr0bbkxhYNJhY6VRYjDsyTDqavR6OPU6DNBtCKAPgBVKxV0SMo7WnjUaDit-zxsBZauGavgKzqcNy8=@protonmail.com>
In-Reply-To: <CALmYWFv+Tsqwv96oB4rTrJ7_ZC3CoNZFjmKFYKQgGZuceqZ6vg@mail.gmail.com>
References: <20240524033933.135049-1-jeffxu@google.com> <20240524033933.135049-2-jeffxu@google.com> <79b3aa3e-bc70-410e-9646-0b6880a4a74b@app.fastmail.com> <CALmYWFu61FkbboWkXUSKBGmXeiNtBwrgfizS5kNvPMx4ByUqPQ@mail.gmail.com> <b8cGJnU5ofWgsiKD5z8RGlW-2ijs7IW9h4LUg1tzFBu3agFinCvdxuiSaUDG_DfVen2vCDNu-QbGfOR7DeARf4jsy3CNNTfzQGMX1HfqHdo=@protonmail.com> <CALmYWFv+Tsqwv96oB4rTrJ7_ZC3CoNZFjmKFYKQgGZuceqZ6vg@mail.gmail.com>
Feedback-ID: 20568564:user:proton
X-Pm-Message-ID: 10e36116d14daed7d928f575d8afdac320345604
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

2024. m=C3=A1jus 30., cs=C3=BCt=C3=B6rt=C3=B6k 0:24 keltez=C3=A9ssel, Jeff =
Xu <jeffxu@google.com> =C3=ADrta:

> On Wed, May 29, 2024 at 2:46=E2=80=AFPM Barnab=C3=A1s P=C5=91cze <pobrn@p=
rotonmail.com> wrote:
> >
> > Hi
> >
> >
> > 2024. m=C3=A1jus 29., szerda 23:30 keltez=C3=A9ssel, Jeff Xu <jeffxu@go=
ogle.com> =C3=ADrta:
> >
> > > Hi David and Barnab=C3=A1s
> > >
> > > On Fri, May 24, 2024 at 7:15=E2=80=AFAM David Rheinsberg <david@reada=
head.eu> wrote:
> > > >
> > > > Hi
> > > >
> > > > On Fri, May 24, 2024, at 5:39 AM, jeffxu@chromium.org wrote:
> > > > > From: Jeff Xu <jeffxu@google.com>
> > > > >
> > > > > By default, memfd_create() creates a non-sealable MFD, unless the
> > > > > MFD_ALLOW_SEALING flag is set.
> > > > >
> > > > > When the MFD_NOEXEC_SEAL flag is initially introduced, the MFD cr=
eated
> > > > > with that flag is sealable, even though MFD_ALLOW_SEALING is not =
set.
> > > > > This patch changes MFD_NOEXEC_SEAL to be non-sealable by default,
> > > > > unless MFD_ALLOW_SEALING is explicitly set.
> > > > >
> > > > > This is a non-backward compatible change. However, as MFD_NOEXEC_=
SEAL
> > > > > is new, we expect not many applications will rely on the nature o=
f
> > > > > MFD_NOEXEC_SEAL being sealable. In most cases, the application al=
ready
> > > > > sets MFD_ALLOW_SEALING if they need a sealable MFD.
> > > >
> > > > This does not really reflect the effort that went into this. Should=
n't this be something along the lines of:
> > > >
> > > >     This is a non-backward compatible change. However, MFD_NOEXEC_S=
EAL
> > > >     was only recently introduced and a codesearch revealed no break=
ing
> > > >     users apart from dbus-broker unit-tests (which have a patch pen=
ding
> > > >     and explicitly support this change).
> > > >
> > > Actually, I think we might need to hold on to this change. With debia=
n
> > > code search, I found more codes that already use MFD_NOEXEC_SEAL
> > > without MFD_ALLOW_SEALING. e.g. systemd [1], [2] [3]
> >
> > Yes, I have looked at those as well, and as far as I could tell,
> > they are not affected. Have I missed something?
> >
> In the example, the MFD was created then passed into somewhere else
> (safe_fork_full, open_serialization_fd, etc.), the scope and usage of
> mfd isn't that clear to me, you might have checked all the user cases.
> In addition, MFD_NOEXEC_SEAL  exists in libc and rust and go lib.  I
> don't know if debian code search is sufficient to cover enough apps .
> There is a certain risk.
>=20
> Fundamentally, I'm not convinced that making MFD default-non-sealable
> has  meaningful benefit, especially when MFD_NOEXEC_SEAL is new.

Certainly, there is always a risk, I did not mean to imply that there isn't=
.
However, I believe this risk is low enough to at least warrant an attempt a=
t
eliminating this inconsistency. It can always be reverted if it turns out t=
hat
the effects have been vastly underestimated by me.

So I would still like to see this change merged.


Regards,
Barnab=C3=A1s P=C5=91cze


>=20
>=20
> >
> > Regards,
> > Barnab=C3=A1s
> >
> >
> > >
> > > I'm not sure if this  will break  more applications not-knowingly tha=
t
> > > have started relying on MFD_NOEXEC_SEAL being sealable. The feature
> > > has been out for more than a year.
> > >
> > > Would you consider my augments in [4] to make MFD to be sealable by d=
efault ?
> > >
> > > At this moment, I'm willing to add a document to clarify that
> > > MFD_NOEXEC_SEAL is sealable by default, and that an app that needs
> > > non-sealable MFD can  set  SEAL_SEAL.  Because both MFD_NOEXEC_SEAL
> > > and vm.memfd_noexec are new,  I don't think it breaks the existing
> > > ABI, and vm.memfd_noexec=3D0 is there for backward compatibility
> > > reasons. Besides, I honestly think there is little reason that MFD
> > > needs to be non-sealable by default.  There might be few rare cases,
> > > but the majority of apps don't need that.  On the flip side, the fact
> > > that MFD is set up to be sealable by default is a nice bonus for an
> > > app - it makes it easier for apps to use the sealing feature.
> > >
> > > What do you think ?
> > >
> > > Thanks
> > > -Jeff
> > >
> > > [1] https://codesearch.debian.net/search?q=3DMFD_NOEXEC_SEAL
> > > [2] https://codesearch.debian.net/show?file=3Dsystemd_256~rc3-5%2Fsrc=
%2Fhome%2Fhomed-home.c&line=3D1274
> > > [3] https://sources.debian.org/src/elogind/255.5-1debian1/src/shared/=
serialize.c/?hl=3D558#L558
> > > [4] https://lore.kernel.org/lkml/CALmYWFuPBEM2DE97mQvB2eEgSO9Dvt=3DuO=
9OewMhGfhGCY66Hbw@mail.gmail.com/
> > >
> > >
> > > > > Additionally, this enhances the useability of  pid namespace sysc=
tl
> > > > > vm.memfd_noexec. When vm.memfd_noexec equals 1 or 2, the kernel w=
ill
> > > > > add MFD_NOEXEC_SEAL if mfd_create does not specify MFD_EXEC or
> > > > > MFD_NOEXEC_SEAL, and the addition of MFD_NOEXEC_SEAL enables the =
MFD
> > > > > to be sealable. This means, any application that does not desire =
this
> > > > > behavior will be unable to utilize vm.memfd_noexec =3D 1 or 2 to
> > > > > migrate/enforce non-executable MFD. This adjustment ensures that
> > > > > applications can anticipate that the sealable characteristic will
> > > > > remain unmodified by vm.memfd_noexec.
> > > > >
> > > > > This patch was initially developed by Barnab=C3=A1s P=C5=91cze, a=
nd Barnab=C3=A1s
> > > > > used Debian Code Search and GitHub to try to find potential break=
ages
> > > > > and could only find a single one. Dbus-broker's memfd_create() wr=
apper
> > > > > is aware of this implicit `MFD_ALLOW_SEALING` behavior, and tries=
 to
> > > > > work around it [1]. This workaround will break. Luckily, this onl=
y
> > > > > affects the test suite, it does not affect
> > > > > the normal operations of dbus-broker. There is a PR with a fix[2]=
 In
> > > > > addition, David Rheinsberg also raised similar fix in [3]
> > > > >
> > > > > [1]:
> > > > > https://github.com/bus1/dbus-broker/blob/9eb0b7e5826fc76cad7b025b=
c46f267d4a8784cb/src/util/misc.c#L114
> > > > > [2]: https://github.com/bus1/dbus-broker/pull/366
> > > > > [3]:
> > > > > https://lore.kernel.org/lkml/20230714114753.170814-1-david@readah=
ead.eu/
> > > > >
> > > > > Cc: stable@vger.kernel.org
> > > > > Fixes: 105ff5339f498a ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXE=
C")
> > > > > Signed-off-by: Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
> > > > > Signed-off-by: Jeff Xu <jeffxu@google.com>
> > > > > Reviewed-by: David Rheinsberg <david@readahead.eu>
> > > >
> > > > Looks good! Thanks!
> > > > David
> > >

