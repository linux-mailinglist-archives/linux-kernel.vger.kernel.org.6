Return-Path: <linux-kernel+bounces-558578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40905A5E7F8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DCE23B3E98
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6FF1F1500;
	Wed, 12 Mar 2025 23:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c1W97pOi"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7CD1F130D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741820609; cv=none; b=pg/CMWqQeWzE4jEx9EbDgM4P+d4OHGcGsBoqqRViemSaJhgEyaGQMGkEEyAkvoQ5nkeGr+zGKrWV1Qhz8I20HQEYRsIXlf2qcTMOpGsgBrdJbfzAoECGnoAlTyhu4gFl9BIyxQ3+xuJQ+E33It1A1bmWtFG4NCuZpElqUl5OncQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741820609; c=relaxed/simple;
	bh=ncnj6DEyq4V+1fddj7rDLXvHMUxNYGk41E+E9MumYPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxahs09viocK8BnJZXFurXzSL9d1rlZhkU/Q0hf97HLxs9h9b+KbQfi32TFlzNSnUikyfBX3bF3idN9sSy9m3eCr8qe9XwmY60QRRHTvbkDb/e3FZJDl5CRwSQN4s25OCYNA2xJIfs2XOr0Re9U1DtiSBZZmqQuBXJ+oD1sVwQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c1W97pOi; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e8f916e75fso16668786d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741820606; x=1742425406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qYrmNm28Kbw32wLRrVnMqeid/1PxhmzHXFH5s1Tsus=;
        b=c1W97pOilO+MeA5i1Jym5U604FounHFSYccplsDtuIMOu79l3nCAzgvA5/KnL/7zE/
         06JKg5OnWFuXbbXo8ftBobIrAk3DRXUCdKHFZ8Hw9dkoEXa0/5X8OJ09u1k4a2w2NbAj
         Ux05GNvEIsdETkHbmBgE4RRVdByX04fSMuNxKREgGe0ATWvnbefAc5C0eGsAae8fsz5Z
         cISpocSZcjsJ5PG8WCPrPoFZ9hW52eTuQ1eDBqVp6dm9B5RCAGc/fvz9tfVQNRCiaCKp
         iU6LZusrEwhtaI3Oba5tjv8tTs7547pj0Fs4Bzxs/U7nlIt/QChY67cG5R1zRRWAtAGt
         bKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741820606; x=1742425406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qYrmNm28Kbw32wLRrVnMqeid/1PxhmzHXFH5s1Tsus=;
        b=v5dnE+a3ObX4OKnriq9jL62Ef4qTU8uzxlVEuKrltn1TSOYoyHa56sOTcjxR/0DRUy
         tdVxQ6joEd75bQV8SzRa3JwUpoUYtKd+3dIxMKWDvL5ZriWYSE/jFJY2mJ1vJefdEHPI
         7qlnQpNG8Z1q+ah1C9GWtUMqjoSXEmETaDTgqKzJmhDUpnFIvt2BYlxUgX+glPaVGh/D
         dAphOzRPcEQHi/WvfAyWIJ4YxauKWmNd0xR3lwSvoW2DthCYglU3R1q5vcrM3IYmPBNk
         NlOm7KimPGPMo5ofSlYcm91GmdirprENHwQDul/vjRymt7h4TD/iYUFe746Xh/prwYeu
         k1pA==
X-Forwarded-Encrypted: i=1; AJvYcCWQB/3ty2nu3Eld0MGzw89G7harmfBM4hVDLYmScyIBrRmVGUZOXhX69wy3x9IsJEw3+HddzR7UyDPFEUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4TNEAh8Zh0nD+1dESFZ6eXGvDlLbR/puPP+Ryr66RUp/7TbNb
	qbq/6efmvSBwgvWYn6NWfWeV/Vo6UoYSyuGmmBJ15VvHXp1eWYNf+8PiyMpaqMP19+W/ykiXNcL
	5inU2ICaXwPq3FjiAyGv8lNqFjRKoxdBgeZj1
X-Gm-Gg: ASbGncvgwdSMb3HMbsjOliE8oHpRNAyIyLyKQY8PntUrPeJe9jI2U2fB6u5aNMqHFmk
	x7OW6IuSvyEHqA/sVkKx6m/K2uRLJxtD9pXOLsNnxxvcv4GdYKhsm+Mq0ld8s5wv0mMJRJ5oB0W
	KCferzvFlctAFzOnpl0GH665eItkjpfMNG2Yy7CiU7XeeL54fU1zbiG55nOJ8=
X-Google-Smtp-Source: AGHT+IHB7pncreoeC4bTOjrVVg4/vW8W4R0WcMKYKN/Jsv2LJ8M/D1/XBHH+OQofZ7tzOftMoBTB7uaxt6A72/lT5DU=
X-Received: by 2002:a05:6214:319a:b0:6d9:ac3:e730 with SMTP id
 6a1803df08f44-6eadded9779mr6616146d6.5.1741820606563; Wed, 12 Mar 2025
 16:03:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312021154.102262-2-elsk@google.com> <CAK7LNARRtmLBiU+-+O4-jzCz+1YamRwVgBXkBA=v5Vo5djRPpA@mail.gmail.com>
 <CAABy=s1t0rLJdcXbeoE8E2Dz9zBA8F3Cf0tQPGrM2hgUx=G_8g@mail.gmail.com>
In-Reply-To: <CAABy=s1t0rLJdcXbeoE8E2Dz9zBA8F3Cf0tQPGrM2hgUx=G_8g@mail.gmail.com>
From: "Hong, Yifan" <elsk@google.com>
Date: Wed, 12 Mar 2025 16:02:50 -0700
X-Gm-Features: AQ5f1JqbOFiq626fnNDIWAXDkcMWcBTgf7vgtqZJEigPOHH0mkJkXGkyX_fY6Ng
Message-ID: <CAABy=s18Sn-v78=_UWXnZ-o8Yx9ZnRdd+NqVBN_qKcZAu4dgDw@mail.gmail.com>
Subject: Re: [PATCH v1] setlocalversion: use ${objtree}/include/config/auto.conf
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 12:13=E2=80=AFPM Hong, Yifan <elsk@google.com> wrot=
e:
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

Actually, I noticed two more include/config/auto.conf mentions below
this line. If the overall idea looks good to you, I'll upload a
separate version that fixes the two mentions below as well.

> > > --
> > > 2.49.0.rc0.332.g42c0ae87b1-goog
> > >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada

