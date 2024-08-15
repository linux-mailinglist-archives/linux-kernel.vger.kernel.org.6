Return-Path: <linux-kernel+bounces-287410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90F995277E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 03:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1303283A2B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 01:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBAE4A0F;
	Thu, 15 Aug 2024 01:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mIqgNiG8"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEF417C9
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 01:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723685041; cv=none; b=afnoz74sgNghoFYIWXnWK49RxAv8/IgVvW3+8zdprRVTyaapwbtFV3iPr96tGONLKUO+ZLHWHdu3QVfYc83jq807Jjb8mw+hMilyKZczI5zhPEBXUQFOjpbV3699VfyJIIVzfcp1l7otRKWKUKUOdYa60yLKESbkN2G+Hqm5sfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723685041; c=relaxed/simple;
	bh=IPanApsJyaaxjvVuTuWizOqptJ7DXErfoFO3SGXCop0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHVqTYItOqvgFANZuheIOg78o4zt24TWPeckhFjjt8mbs8iiVT3xWsYwB5QTPfjig98N/1gdFeup7RW3neJA3OrwbKGwZ7GO/P69YLF76DV6BYwwm8Pzi4Jkl0t5m9iiEB2J+pnmNurP0br3bXECAsb7cp+TpruHnamxMyTknf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mIqgNiG8; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so943533e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 18:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723685038; x=1724289838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQp22hCpTnstTtw8wIhx12A0v1Bwi4IEODinYcz0rtQ=;
        b=mIqgNiG8yULWufamW0g/yWCTaymeS8DOpIw04pPcaph7qjpQk742GK2IWvtS6g2N+M
         mR3Bddgr1fFg1yjQadfaMRTG/T+SZOFyomNuRYk1Mi0MIB7P/k+f79F/OgsTf7zOIuvc
         8YQGxujPWIGM1u6OL/cijXClvcBbOz07jf1wMb4q1ZYWiW1C1E2qKMFJns7P5D7ZYOaX
         daoPmT8prAg5DRXcAeI8FQOOKcDYYRRVX0W6BGdJtTZ5P9oIZeKzJM/8iSzBc2B5OnvE
         WmG1Riq/x12hP1kKmIXNH8+p4ZPURYi0T6c6WONGmYUs1AgCQpjn+fW79tCAPeFuJinJ
         MNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723685038; x=1724289838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQp22hCpTnstTtw8wIhx12A0v1Bwi4IEODinYcz0rtQ=;
        b=oG2YyDnUU3DiUCTEbxGuVKmqtxt5Ey2MvMIY2So8VtAHtelwL3K7GAc/qWG/yV52o1
         if4F5MtucR3ArNWV/NvTswP5Xc6fsicSNFR/erJpQdXc6qKD9NYjw4sJKXQOyxrtGcgD
         DfLaAPwob61bIebkiVJcVqQYZ8oXh8ixwG4MaSkq2xKC1JVSDBjaOS8r034Q0SE4e97t
         tGwBoKakhrdhTzwGw2KDMV8LEXrj8xRnltBo9PNeiSz8ia+GcJJHyJU1qAZu8tHZTrUI
         rvoqeC+mbhFEflH6FjAT3lbhh48HIeb+NlMaARDwz0SVN6MccZYdU6bDCmxXTx6l4Gba
         xyQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWA14xXyZFcfsbt2ORhZr5XsJ5fiV64Ip3SRq2wN4pEP45Gud652rnGjHLF2IvuyaroU1aDa962IPvKLZvahZexSumQD3Rle2hOcnzM
X-Gm-Message-State: AOJu0YyMQ7xEeXQfu8kR924l0Ihe6voMMzRjQdFiGfxSIVZp5HG7nvAY
	EeSAPWcRKKirVOeAWvVEQ0X+PWmknRlD68GZL5ecfKNa+9ZxwnRQbljFFJEWD8yD9zgqdAMF/FZ
	8mCCWBhXcSmjL9iAH23qoCwCb9NVUUnSPZ3GV
X-Google-Smtp-Source: AGHT+IFrmbv+IGINyaiTjjFMEcT1EM7N8NhQ+gfP0HDbTjV9qfqTdAooQ6NiqoWk3LCU+4dwnx1K8uEXRcbmhM9BWxg=
X-Received: by 2002:ac2:5695:0:b0:532:fb9e:a175 with SMTP id
 2adb3069b0e04-532fb9ea617mr2873611e87.6.1723685036624; Wed, 14 Aug 2024
 18:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718173423.1574395-1-maskray@google.com> <a97e6b4232394e837666adbaf7e657900cb7b1a8.camel@xry111.site>
In-Reply-To: <a97e6b4232394e837666adbaf7e657900cb7b1a8.camel@xry111.site>
From: Fangrui Song <maskray@google.com>
Date: Wed, 14 Aug 2024 18:23:43 -0700
Message-ID: <CAFP8O3LcEZD2L6KFw-Qh5jGivtifFUzqTM=JceWKU4nJrBaBZg@mail.gmail.com>
Subject: Re: [PATCH] arm64/vdso: Remove --hash-style=sysv
To: Xi Ruoyao <xry111@xry111.site>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 12:56=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wro=
te:
>
> On Thu, 2024-07-18 at 10:34 -0700, Fangrui Song wrote:
> > glibc added support for .gnu.hash in 2006 and .hash has been obsoleted
> > for more than one decade in many Linux distributions.  Using
> > --hash-style=3Dsysv might imply unaddressed issues and confuse readers.
> >
> > Just drop the option and rely on the linker default, which is likely
> > "both", or "gnu" when the distribution really wants to eliminate sysv
> > hash overhead.
> >
> > Similar to commit 6b7e26547fad ("x86/vdso: Emit a GNU hash").
> >
> > Signed-off-by: Fangrui Song <maskray@google.com>
>
> Hi Fangrui,
>
> If I read tools/testing/selftests/vDSO/parse_vdso.c correctly, it does
> know DT_GNU_HASH as at now.  Thus after this change the vDSO selftests
> are skipped with "Couldn't find __vdso_gettimeofday" etc if the distro
> enables --hash-style=3Dgnu by default.
>
> So it seems we need to add DT_GNU_HASH support for parse_vdso.c to keep
> test coverage.

Hi Xi,

Perhaps the selftests file needs DT_GNU_HASH support like
https://github.com/abseil/abseil-cpp/commit/1278ee9bd9bd4916181521fac96d6fa=
1100e38e6


> > ---
> >  arch/arm64/kernel/vdso/Makefile   | 2 +-
> >  arch/arm64/kernel/vdso32/Makefile | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/M=
akefile
> > index d63930c82839..d11da6461278 100644
> > --- a/arch/arm64/kernel/vdso/Makefile
> > +++ b/arch/arm64/kernel/vdso/Makefile
> > @@ -21,7 +21,7 @@ btildflags-$(CONFIG_ARM64_BTI_KERNEL) +=3D -z force-b=
ti
> >  # potential future proofing if we end up with internal calls to the ex=
ported
> >  # routines, as x86 does (see 6f121e548f83 ("x86, vdso: Reimplement vds=
o.so
> >  # preparation in build-time C")).
> > -ldflags-y :=3D -shared -soname=3Dlinux-vdso.so.1 --hash-style=3Dsysv  =
     \
> > +ldflags-y :=3D -shared -soname=3Dlinux-vdso.so.1 \
> >            -Bsymbolic --build-id=3Dsha1 -n $(btildflags-y)
> >
> >  ifdef CONFIG_LD_ORPHAN_WARN
> > diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso=
32/Makefile
> > index cc4508c604b2..25a2cb6317f3 100644
> > --- a/arch/arm64/kernel/vdso32/Makefile
> > +++ b/arch/arm64/kernel/vdso32/Makefile
> > @@ -98,7 +98,7 @@ VDSO_AFLAGS +=3D -D__ASSEMBLY__
> >  # From arm vDSO Makefile
> >  VDSO_LDFLAGS +=3D -Bsymbolic --no-undefined -soname=3Dlinux-vdso.so.1
> >  VDSO_LDFLAGS +=3D -z max-page-size=3D4096 -z common-page-size=3D4096
> > -VDSO_LDFLAGS +=3D -shared --hash-style=3Dsysv --build-id=3Dsha1
> > +VDSO_LDFLAGS +=3D -shared --build-id=3Dsha1
> >  VDSO_LDFLAGS +=3D --orphan-handling=3D$(CONFIG_LD_ORPHAN_WARN_LEVEL)
> >
> >
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University



--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF

