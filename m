Return-Path: <linux-kernel+bounces-558310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B80C4A5E431
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F7C03B3A98
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4692571C4;
	Wed, 12 Mar 2025 19:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="USkmVdbi"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895AC1D54E2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 19:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741806849; cv=none; b=gFLmL+ATrthN1lfWkTThGNJIaYsPbeRcW/Rn9xw+PsFvc9eSwnQBllEZ0btTEzHVUpB7cARDUf9+P0YTmvHbxeLNVjK7McN1pA5zB5hgAUc+LweYLWha9qz03Q9rNK59Krcq/aDGYXluNp/dNKJEka3ndBU7DH+tG3CCjbjIhOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741806849; c=relaxed/simple;
	bh=xB3p6t3m9e8dyHML85k6WbLl3AbARiK1iVJSCsfknH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLG2JBxr04iJSupKfWhNqSgxOsUOQDNVFquXPIlAeJlL1yQdRhCG2YCtlBvxrpTACKZwyKtGtRn7yQkasKh4FlIcoqAjTKQUa8ZUR2uOn3qEP66JlqOpJHHLlmS0Elj1qbTQ3Ik32aVeQ/kKSr/L/szgzHbLq/t4683vDEXFUD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=USkmVdbi; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8fd49b85eso3354656d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741806845; x=1742411645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okHnBQoclPqX8nR3XjyTLK8SXgT4btY/ekUJg4HzQFQ=;
        b=USkmVdbi9REeZuzmXmVfpI6Qg1HaOU7LWtHQg5U4lXr3PqV7suDOVuU60e7wU6XGqC
         hPp465aHSCXM2pIpHvNt1WlG0JYWFecxn5r/ayk+3XzA3rWrb//v2ed0Wkph3BvFI4xw
         seXbaeqsJJLL602ylHHj527fYPsHKE8/FUMfVmeJ8bImf9U6FWZCXg8eLwHd4AlNkNAX
         XCEJ4WcjsMOc/5YxCwdHrJhSPiq0DStVoZQpBxmMZcOgXsKIHxGQvHdOUoYgtNnIl8tL
         MZRFSuVNB2S7RPf+TQP2VPLAC2og8e2HEp5O3Qfh1druRUJ2WW29YOlCy9AITootKC/O
         SaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741806845; x=1742411645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okHnBQoclPqX8nR3XjyTLK8SXgT4btY/ekUJg4HzQFQ=;
        b=GpirUFtDo/NrN9irHsM140UE8ceHHutcnN7bTX2gQPUQ2/SwMnPr45T04pi6b4i7kj
         AwbWZizitJhIBMKcHk57OcjqjJwmZA1ZJstzA9o319i+rQSrpCOGnaJFvj0VrQ9xcOiz
         0+rNg45ZPmkvlXhm6xJ4eiBCz0x0OGvH4sqpdgfksYyne0t4vVN588ZtHnjcqL6fZjY/
         oJ+TLHKoLujvj2CIvyyOkO9aY+c//dOW7lhuWWbE5WPJB4ZEvAZUDfO2XZ6O9KqpdXej
         1Yrx8Rgfm93SDeJqscEC+pdwirf2D9xUrjqlVpmNn33njE5qGnO1iJJtwiyNG8jC0yMT
         dmrw==
X-Forwarded-Encrypted: i=1; AJvYcCVkuDJLjegNTQ7ne8QGMHw+VtD3kRax/lUDKA8t8DoZ8tD5oLBs2G/jCkaKts8gStpHuIr6yIbDXrOqDlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHK3PHLd4eL2yX6d0sTrBRDDXIqUMHOBEqDkFQRflqnMybbJgk
	b8bID//TuqNoEA8KHp1n9+e5ek+cYL4uZoT6aZQlHlI8Hjuz5mk6svjU2SRxrf0qf/B+54Ikc5y
	3ylCjOrLimTCQxZiZkCuKNW+fvFnvsUT8A3bl
X-Gm-Gg: ASbGncu3unP1qG9tROAU859RsTSuMNyypJrD9GRNFC377pMgpVGzE8B4/eWi6ekcRNX
	g6A8vVZCIcSvJKFHZoM4dhiWyGAncGm1NZQD5Y4zgY614ETwT5nwRMjy35JS6evZkV6h8/04iij
	UrvVARID8cZUTaO44vsWUezde4LPwiF3v5xrgaIsA+0rk7sxN6weM0WRomag==
X-Google-Smtp-Source: AGHT+IGeO4PLIQhBrvACur4J9TBZ3OFlujIt3pSXquq0FEJfrZWESsMbOfgZanXV4CNNoxqtkG5mZHg05ybXYe0ClIo=
X-Received: by 2002:a05:6214:268b:b0:6d4:1680:612d with SMTP id
 6a1803df08f44-6e9004f9eb6mr388614816d6.0.1741806845090; Wed, 12 Mar 2025
 12:14:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312021154.102262-2-elsk@google.com> <CAK7LNARRtmLBiU+-+O4-jzCz+1YamRwVgBXkBA=v5Vo5djRPpA@mail.gmail.com>
In-Reply-To: <CAK7LNARRtmLBiU+-+O4-jzCz+1YamRwVgBXkBA=v5Vo5djRPpA@mail.gmail.com>
From: "Hong, Yifan" <elsk@google.com>
Date: Wed, 12 Mar 2025 12:13:29 -0700
X-Gm-Features: AQ5f1Jru0KLI4ofUSH-IPCK0KzB9pPauckEoUw5SeetoMJ0e4uTQfb-r4t79-JA
Message-ID: <CAABy=s1t0rLJdcXbeoE8E2Dz9zBA8F3Cf0tQPGrM2hgUx=G_8g@mail.gmail.com>
Subject: Re: [PATCH v1] setlocalversion: use ${objtree}/include/config/auto.conf
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 12:31=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> On Wed, Mar 12, 2025 at 11:12=E2=80=AFAM HONG Yifan <elsk@google.com> wro=
te:
> >
> > setlocalversion reads include/config/auto.conf, which is located below
> > $(objtree) with commit 214c0eea43b2 ("kbuild: add $(objtree)/ prefix to
> > some in-kernel build artifacts").
> >
> > Hence, the setlocalversion script needs to use
> > $(objtree)/include/config/auto.conf as well.
> >
> > Note that $(objtree) is not necessarily `.` when O (aka KBUILD_OUTPUT)
> > is set, because of commit 13b25489b6f8 ("kbuild: change working
> > directory to external module directory with M=3D").
>
> Is this a real issue?
> If so, please attach some commands to reproduce an issue.
>
> setlocalversion is invoked only at line 1238 of the top-level Makefile,
> within the check "ifeq ($(KBUILD_EXTMOD),)"
> So, it is never called with external module builds.

Thanks Masahiro. You are right; this is not a real issue as the code
is right now.

In our case, we have this issue because we have
https://lore.kernel.org/all/20210121213641.3477522-1-willmcvicker@google.co=
m/
("[PATCH v6] modules: introduce the MODULE_SCMVERSION config")
in our tree to support the SCM version for modules. The patch was not
accepted so
we applied this patch locally. Hence, technically this patch should also on=
ly be
applied locally by us. The paragraph that says "Note that $(objtree) is not
necessarily `.`..." is not correct.

Still, I think it makes sense to be consistent with other places that menti=
ons
include/config/auto.conf.

Should I update the commit message and send another patch? Or would you
like to reject this change?

>
>
>
>
>
>
>
> > Signed-off-by: HONG Yifan <elsk@google.com>
> > ---
> > Implementation note: Should I test -z ${objtree} before using it? Other=
wise it
> > looks at /include/config/auto.conf which is wrong.
> > Or should I fall back to `.` if objtree is not found in the environment
> > variables?
> > I could also `exit 1` if $objtree is not set. Please let me know what y=
ou think.
> >
> >  scripts/setlocalversion | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/setlocalversion b/scripts/setlocalversion
> > index 28169d7e143b..88f54eb5a7c2 100755
> > --- a/scripts/setlocalversion
> > +++ b/scripts/setlocalversion
> > @@ -186,7 +186,7 @@ if ${no_local}; then
> >         exit 0
> >  fi
> >
> > -if ! test -e include/config/auto.conf; then
> > +if ! test -e ${objtree}/include/config/auto.conf; then
> >         echo "Error: kernelrelease not valid - run 'make prepare' to up=
date it" >&2
> >         exit 1
> >  fi
> > --
> > 2.49.0.rc0.332.g42c0ae87b1-goog
> >
>
>
> --
> Best Regards
> Masahiro Yamada

