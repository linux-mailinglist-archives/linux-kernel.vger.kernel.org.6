Return-Path: <linux-kernel+bounces-562450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF4EA62812
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 08:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4035A19C1B90
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 07:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6C51D8A12;
	Sat, 15 Mar 2025 07:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WF008w7y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BA118C92F
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 07:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742023761; cv=none; b=OTZ2ZfRyyOPW3z2WGfGBA7VUc9ueHmWzhI3dg9TGOF4DtCeIgYe96L3hBLej1Jy1X5hWBIQUPFoq36GgpGNIrwoIb+4a1o808na8Ry2S2tL/i6loeGMtjaJAXFFvb2WQXtgk75wkHFnG3eU9KvLAQRapYQnAfakpzkmDzJmEkB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742023761; c=relaxed/simple;
	bh=FDQR4o8U2vq/ccYqG+y/zFOW/I+hxqhWbr3nWfXvYRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFYFuPXX7JaMJ4qfhCobyFk3N0FYLhcCq8EYan/oAn7jfDkldnxxyGxjueENLckNWs1PKG7vpsGWBduFRwTn7gykhK5gLFDdyv3ikujSgOc8ts1uyTz22azAKhW2/I+ZuO8e+UN305RKSi5IxWYP6dlyAkGDIcd17pyi8LgLQLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WF008w7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248E3C4CEED
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 07:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742023761;
	bh=FDQR4o8U2vq/ccYqG+y/zFOW/I+hxqhWbr3nWfXvYRM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WF008w7yTWH+w6rjSyRIiJOE/QMQmtpYZuzc5M7LASVkrETZWT2LqHIO5IbBbE9SA
	 Y2Fxhhky+XD3Novna3/hcw9GmumSGOp+h+wy8f2UyJs+6yA8y7sSY4YwdoSikEtA99
	 lD60f4XW4QBZmiauqId178KSJM9fyQIDwbuk8CWy9Ru1OoGgClRsg0XdYGygwCiIJC
	 77LZ9KZwo3/5iCA7zI5bTR/6MdXJqVvyVFBcpnivMPzIl23qm9lywehObSbQw8ZEHS
	 Ve2NbBrTOHiFbDORue4TWNLOMNyMo4kXU8huOwWhufmODCZkSQ2jZYccDFJ0snIPpT
	 +h1JGzf/dnUxQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-549644ae382so3245093e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 00:29:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGKLDGx5HbJPbdR5+1jfBYWjgBVpPo931YOIsQCyPOfdpfEt4dR06Iy1p+EHnKfmPf1RiiT6BW3jvvhko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDGtUs6OFvU7zPO+kYxQ02IU3u/sAXjwBUeyH6ejZadmYitvNQ
	Y6VjF+aU8gPLTcAb3U2PX1QZZc08HLPtcdizIP8W4HHfyvTUbx3xLFQ0nUvEP/0zlqiU6HSt5MS
	iyzKqz1T4QMUpNKfGbm1D7+CWVWw=
X-Google-Smtp-Source: AGHT+IFMTr6GV0Z/B51xWSUvynOIEOrt02uGTNzJ0XwDAc7JahcWHFRXfFGsYcvtMdf0u7DdCZDagbuyRfm/KpzLmbk=
X-Received: by 2002:a05:6512:3b8f:b0:545:c7d:1796 with SMTP id
 2adb3069b0e04-549c39af160mr1842583e87.43.1742023759804; Sat, 15 Mar 2025
 00:29:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312021154.102262-2-elsk@google.com> <CAK7LNARRtmLBiU+-+O4-jzCz+1YamRwVgBXkBA=v5Vo5djRPpA@mail.gmail.com>
 <CAABy=s1t0rLJdcXbeoE8E2Dz9zBA8F3Cf0tQPGrM2hgUx=G_8g@mail.gmail.com>
In-Reply-To: <CAABy=s1t0rLJdcXbeoE8E2Dz9zBA8F3Cf0tQPGrM2hgUx=G_8g@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 15 Mar 2025 16:28:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNASqYkDTPNo20Bj1knwsJMrp=nbQyh__=Do67eWq4CKU3A@mail.gmail.com>
X-Gm-Features: AQ5f1Jrl9FdPADmweVOgkYmdpO1A2CqwhdBsmurkwRSmQt6PuAhvi7-u7oBTjIg
Message-ID: <CAK7LNASqYkDTPNo20Bj1knwsJMrp=nbQyh__=Do67eWq4CKU3A@mail.gmail.com>
Subject: Re: [PATCH v1] setlocalversion: use ${objtree}/include/config/auto.conf
To: "Hong, Yifan" <elsk@google.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 4:14=E2=80=AFAM Hong, Yifan <elsk@google.com> wrote=
:
>
> On Wed, Mar 12, 2025 at 12:31=E2=80=AFAM Masahiro Yamada <masahiroy@kerne=
l.org> wrote:
> >
> > On Wed, Mar 12, 2025 at 11:12=E2=80=AFAM HONG Yifan <elsk@google.com> w=
rote:
> > >
> > > setlocalversion reads include/config/auto.conf, which is located belo=
w
> > > $(objtree) with commit 214c0eea43b2 ("kbuild: add $(objtree)/ prefix =
to
> > > some in-kernel build artifacts").
> > >
> > > Hence, the setlocalversion script needs to use
> > > $(objtree)/include/config/auto.conf as well.
> > >
> > > Note that $(objtree) is not necessarily `.` when O (aka KBUILD_OUTPUT=
)
> > > is set, because of commit 13b25489b6f8 ("kbuild: change working
> > > directory to external module directory with M=3D").
> >
> > Is this a real issue?
> > If so, please attach some commands to reproduce an issue.
> >
> > setlocalversion is invoked only at line 1238 of the top-level Makefile,
> > within the check "ifeq ($(KBUILD_EXTMOD),)"
> > So, it is never called with external module builds.
>
> Thanks Masahiro. You are right; this is not a real issue as the code
> is right now.
>
> In our case, we have this issue because we have
> https://lore.kernel.org/all/20210121213641.3477522-1-willmcvicker@google.=
com/
> ("[PATCH v6] modules: introduce the MODULE_SCMVERSION config")
> in our tree to support the SCM version for modules. The patch was not
> accepted so
> we applied this patch locally. Hence, technically this patch should also =
only be
> applied locally by us. The paragraph that says "Note that $(objtree) is n=
ot
> necessarily `.`..." is not correct.
>
> Still, I think it makes sense to be consistent with other places that men=
tions
> include/config/auto.conf.
>
> Should I update the commit message and send another patch? Or would you
> like to reject this change?

OK, I will accept this if the commit message correctly describes this.

And, please fix up all the 3 occurrences for consistency.

Thanks.




>
> >
> >
> >
> >
> >
> >
> >
> > > Signed-off-by: HONG Yifan <elsk@google.com>
> > > ---
> > > Implementation note: Should I test -z ${objtree} before using it? Oth=
erwise it
> > > looks at /include/config/auto.conf which is wrong.
> > > Or should I fall back to `.` if objtree is not found in the environme=
nt
> > > variables?
> > > I could also `exit 1` if $objtree is not set. Please let me know what=
 you think.
> > >
> > >  scripts/setlocalversion | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/scripts/setlocalversion b/scripts/setlocalversion
> > > index 28169d7e143b..88f54eb5a7c2 100755
> > > --- a/scripts/setlocalversion
> > > +++ b/scripts/setlocalversion
> > > @@ -186,7 +186,7 @@ if ${no_local}; then
> > >         exit 0
> > >  fi
> > >
> > > -if ! test -e include/config/auto.conf; then
> > > +if ! test -e ${objtree}/include/config/auto.conf; then
> > >         echo "Error: kernelrelease not valid - run 'make prepare' to =
update it" >&2
> > >         exit 1
> > >  fi
> > > --
> > > 2.49.0.rc0.332.g42c0ae87b1-goog
> > >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada



--=20
Best Regards
Masahiro Yamada

