Return-Path: <linux-kernel+bounces-287485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234D0952848
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 05:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480201C222CF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 03:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5CE36AF8;
	Thu, 15 Aug 2024 03:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0WBqIejO"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EC679EA
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 03:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723692533; cv=none; b=K2qywmioLOphXdCVxcqWOe/4k60E9it3GAmioU3TPkgt6mPSXa8DV39vgBA7/saJOUGgOsYAny1qOlAVO15Hn8afnDe2NDYIY+vQjbqVzMC8qs4Mv55v4EHeKyAVNGP3ulCUNzIQJOn2qPDDaILa4SI/+qEGSoxsmy+QHvuhrPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723692533; c=relaxed/simple;
	bh=pHk2y705314CsPI2YL9Jn7MSA4P7y50mbU8JVEertSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r5kbe9TRoj8PVl3iB+I6YX1Dwrl9NgZTeL/jHG+M25a3Ss0Hcw+TiwLjbBaR4YQrUUKYl31zxbi0lWxPY35/xMl61GJ0/TmVljZ5K/Ydd0ryS4L2Wo8NVg3tqJ8wA2N3RBbilV5T70SMkBVKJUUlp/MqUmJ2pbgtR84EGY9sfEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0WBqIejO; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52f00ad303aso634230e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 20:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723692529; x=1724297329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wjx59lWoXbwmdfqWfaPSPqk+zYnJcqiORbyfT+nNPs=;
        b=0WBqIejOVh2XJWAsQSDrUTVgILfj1m4oR9rmkdPEDEFASbj2S7qp5DIvdPelYbrTQz
         zatf8fxRlLrwLh4AAcf7neIelb5Cs/x80qEZwraGAriqLWgxZ/8z080BTYymTbNyA8bz
         rEemlnEeaKQQH1tUFrYAwSplKNW9NVsV0hwg5u4xtZ5E6VqA8iLIWx67zw5E2iX1maIc
         ZnEP8BJyksxsHiFIc5W6UP3pDsOpiXsC2kW/w+XZrEs+8MZl6DNEjbGP7xE+PqSGtAcC
         qFg69jTsDk6zRgsFaBrflx2TwYUHZpbmfeA7wdpTXPr21uHilz6BsLkVWA5J2Qt3bpqC
         9IRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723692529; x=1724297329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wjx59lWoXbwmdfqWfaPSPqk+zYnJcqiORbyfT+nNPs=;
        b=tYIyI/NY8yC1yjrEq+OBTFSzlawtbbVKxy2dRBUyt6tRsEOWyhz48ThjTkLiF5K5IK
         jFa2xe+flNMb81lS7TbLwj5Ak/aGekJPxTFx3L020FSYPiujpQF1iaXeHx4WmS0pF+8N
         6y8fL39v2strXlzNq0lQ+2vYvyHT8LTBCSJq986OAshBr37tyLuTOHfBE7S5qTbJjxDE
         pDMJsgXx/5TRpBEs6ot9yEM9Z87uYUigBfyw5aFVqpng00upntR4H/Jtvn2WPtn8nUb3
         5yXynIfBietLXCkRrnnty2ViL1Gym9N7KVdh9JIY7rR6sJDwUHnEPJ+kHAQT5rFM63l4
         mSMA==
X-Forwarded-Encrypted: i=1; AJvYcCUqYdtB/DOhm7CqauV4WXBQKOybefobzQEnp9F3lRm6QAeM2yhwBLGIQsNkI5bVnYUV1W8t5Ukc/t5NxPG9qH1uEu86NY81JBrZIATO
X-Gm-Message-State: AOJu0Yxat9LDqHsotfr5CwPQLS1REaE7W55bajbl/GF9YzoxRcl0uGnC
	qkgMcl19jqCQrGpyv0tHGnQlDO98d6bA05DWoTStTMuyRM5Rn2c98TpQ3Aj/pDttFIH4TuXMLmB
	BGdqbYuxdDlHbvvbcc4Qxyl9iYxXohEpG4EpJVH8HjmhqKPpJIz8f
X-Google-Smtp-Source: AGHT+IG+oFQPlgLf1D7mZieVo5I4Z9fny4yaWPInD4rQ6bQmW7z6rkEtgozX1zdXoPSI3L0Cf9iS9LwOrb1z3xYRvdk=
X-Received: by 2002:a05:6512:2216:b0:52e:74f5:d13 with SMTP id
 2adb3069b0e04-532eda81aa2mr2706631e87.30.1723692528957; Wed, 14 Aug 2024
 20:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718173423.1574395-1-maskray@google.com> <a97e6b4232394e837666adbaf7e657900cb7b1a8.camel@xry111.site>
 <CAFP8O3LcEZD2L6KFw-Qh5jGivtifFUzqTM=JceWKU4nJrBaBZg@mail.gmail.com>
In-Reply-To: <CAFP8O3LcEZD2L6KFw-Qh5jGivtifFUzqTM=JceWKU4nJrBaBZg@mail.gmail.com>
From: Fangrui Song <maskray@google.com>
Date: Wed, 14 Aug 2024 20:28:35 -0700
Message-ID: <CAFP8O3JdJ+NA_L4juLMN+C7ZsOws5OXJxxuoD+eq=6oSawkg0w@mail.gmail.com>
Subject: Re: [PATCH] arm64/vdso: Remove --hash-style=sysv
To: Xi Ruoyao <xry111@xry111.site>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 6:23=E2=80=AFPM Fangrui Song <maskray@google.com> w=
rote:
>
> On Wed, Aug 14, 2024 at 12:56=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> w=
rote:
> >
> > On Thu, 2024-07-18 at 10:34 -0700, Fangrui Song wrote:
> > > glibc added support for .gnu.hash in 2006 and .hash has been obsolete=
d
> > > for more than one decade in many Linux distributions.  Using
> > > --hash-style=3Dsysv might imply unaddressed issues and confuse reader=
s.
> > >
> > > Just drop the option and rely on the linker default, which is likely
> > > "both", or "gnu" when the distribution really wants to eliminate sysv
> > > hash overhead.
> > >
> > > Similar to commit 6b7e26547fad ("x86/vdso: Emit a GNU hash").
> > >
> > > Signed-off-by: Fangrui Song <maskray@google.com>
> >
> > Hi Fangrui,
> >
> > If I read tools/testing/selftests/vDSO/parse_vdso.c correctly, it does
> > know DT_GNU_HASH as at now.  Thus after this change the vDSO selftests
> > are skipped with "Couldn't find __vdso_gettimeofday" etc if the distro
> > enables --hash-style=3Dgnu by default.
> >
> > So it seems we need to add DT_GNU_HASH support for parse_vdso.c to keep
> > test coverage.
>
> Hi Xi,
>
> Perhaps the selftests file needs DT_GNU_HASH support like
> https://github.com/abseil/abseil-cpp/commit/1278ee9bd9bd4916181521fac96d6=
fa1100e38e6

Created https://lore.kernel.org/linux-kselftest/20240815032614.2747224-1-ma=
skray@google.com/T/#u
([PATCH] selftests/vDSO: support DT_GNU_HASH)

>
> > > ---
> > >  arch/arm64/kernel/vdso/Makefile   | 2 +-
> > >  arch/arm64/kernel/vdso32/Makefile | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso=
/Makefile
> > > index d63930c82839..d11da6461278 100644
> > > --- a/arch/arm64/kernel/vdso/Makefile
> > > +++ b/arch/arm64/kernel/vdso/Makefile
> > > @@ -21,7 +21,7 @@ btildflags-$(CONFIG_ARM64_BTI_KERNEL) +=3D -z force=
-bti
> > >  # potential future proofing if we end up with internal calls to the =
exported
> > >  # routines, as x86 does (see 6f121e548f83 ("x86, vdso: Reimplement v=
dso.so
> > >  # preparation in build-time C")).
> > > -ldflags-y :=3D -shared -soname=3Dlinux-vdso.so.1 --hash-style=3Dsysv=
       \
> > > +ldflags-y :=3D -shared -soname=3Dlinux-vdso.so.1 \
> > >            -Bsymbolic --build-id=3Dsha1 -n $(btildflags-y)
> > >
> > >  ifdef CONFIG_LD_ORPHAN_WARN
> > > diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vd=
so32/Makefile
> > > index cc4508c604b2..25a2cb6317f3 100644
> > > --- a/arch/arm64/kernel/vdso32/Makefile
> > > +++ b/arch/arm64/kernel/vdso32/Makefile
> > > @@ -98,7 +98,7 @@ VDSO_AFLAGS +=3D -D__ASSEMBLY__
> > >  # From arm vDSO Makefile
> > >  VDSO_LDFLAGS +=3D -Bsymbolic --no-undefined -soname=3Dlinux-vdso.so.=
1
> > >  VDSO_LDFLAGS +=3D -z max-page-size=3D4096 -z common-page-size=3D4096
> > > -VDSO_LDFLAGS +=3D -shared --hash-style=3Dsysv --build-id=3Dsha1
> > > +VDSO_LDFLAGS +=3D -shared --build-id=3Dsha1
> > >  VDSO_LDFLAGS +=3D --orphan-handling=3D$(CONFIG_LD_ORPHAN_WARN_LEVEL)
> > >
> > >
> >
> > --
> > Xi Ruoyao <xry111@xry111.site>
> > School of Aerospace Science and Technology, Xidian University
>
>
>
> --
> =E5=AE=8B=E6=96=B9=E7=9D=BF



--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF

