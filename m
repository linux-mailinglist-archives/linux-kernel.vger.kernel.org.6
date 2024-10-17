Return-Path: <linux-kernel+bounces-369664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D58159A20B1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F64285BE0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0583F1DBB13;
	Thu, 17 Oct 2024 11:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwCoS6uo"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FF01DB929
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 11:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729163356; cv=none; b=bGtSf7akoMCkdNiznxc6ADo2DcKNHE2pmu/nK715w0WwSMLadE+cAPgwDEZ6VfOF5mvduk60nSHdMCStjYFGeOMy8vObbUSiXUVYTiB+e5mfIal81TVG+pmQP8azPMOlIIw/RP8aw8L4Z2DoZ82fmbjjhhSjtkU4LiJqy9dcsmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729163356; c=relaxed/simple;
	bh=2FNuYyeHMQ8JKGGNhq1qu5oZuY5ADJyF92IWL7xTkUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndvvCpdcsgAqqpwOoFepw+Taz8KBXrpQfiMfuMVi9VRpdTZJ0S7llIRoDJe1xkJ6GTOUBRuPoytcQNQmJYu+YMa/Jm9quC6hX92Qrk8zGIrZU2FcHp0hTVl3nd3fy9/+8vrlguGlL5REKV94D8Wl6O9zhdmcverjQzeIln1/EXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwCoS6uo; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c9388a00cfso956776a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 04:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729163350; x=1729768150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3douvtpLsUx3AakEC5m5aR6A7p1Pr4kaWKKKD9KYE+Q=;
        b=CwCoS6uoTrP1MYz/ATqIQxEsfDarIzz8rsgyzA+8hzObUozyfqumlSVl7NlzL3gucW
         HDVRkDGi+BBjMrhwukNpXys4DMZMPj406hV11IWmWo/08tqkHvxQuaYif3zotRuo+ecb
         WvK9oBY2MOD/sZAASLyPRpSlxlV2s9HGAD7xn/T6Ol4/3rIadTiY5PYBhcxOVA1h95b2
         2UET+mLR8Tce/N51T25w/i8GhvwkjnDXFaRdEoEnPfoHvVKbkYjI2xPv9k/Pqu1AyRwJ
         6jYXQv+RVx1t5W76CLEKrojMa/x0K7OnpJkWT6AoH0wsuR5chU5smFoJ0rpV4eC3ebJo
         Cn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729163350; x=1729768150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3douvtpLsUx3AakEC5m5aR6A7p1Pr4kaWKKKD9KYE+Q=;
        b=eLG57zxNvMOh8qquxxHgf/7Unza0Bvd5NCwAr+7vijKiKadvbK5pBFyWl/LkTF77CY
         9xo3O9HFuU8rqkH/S15ZKjaohSsNciFk4QP6MP/aGKIn/PFghDPNWfV0H12Qr0ggkM3Y
         VcMDNEss1yKDm94EVGGs0/6mbAy0mU7J+xb75v7on65aHEbeH+740Ld4wSPrtpoMzwG9
         s4z52HJJTd9j32Atkk3i+MKd9hupM2nBxb8fPsbjC4LSh4LFB/N4c47KPLRiAG9tlcdb
         YSqUrn+qMQ6SnON3/Y35p6h9V8g3nZhWyhR2NgALpm2ComPcWVIgjQhgEXW2gEoMer76
         HcYA==
X-Forwarded-Encrypted: i=1; AJvYcCXSO/S/dFNALSP/9Ve8b3Fq6St91t5wRb43mrWPn6au3DiL0YKrGOUWC8zPP1++6kK+JIHTCIAbFVDLf9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxevTkxfHbKR7JeN4IuoouTamQ4nL7fH+xX1Tq2JOjAYfEZQRgJ
	cBq9U/lkQb709iz2bzyVUKU2F2shunyNW6Bd/0HXODvWP+sWir+Z3Evp5ORS3jsmk5metjkjCBj
	5pBqZkDK4oWmoGkVJ5QiELLYummc=
X-Google-Smtp-Source: AGHT+IHd22yNSgtHkexQd1qDKDJ44tq/+TpDvOZkbi+jKQMsmVZa3qkBv3TtbZgQcG7pUZABbm9JOkq2QMZ3n20X13o=
X-Received: by 2002:a05:6402:520e:b0:5c8:9f81:43e4 with SMTP id
 4fb4d7f45d1cf-5c99501c722mr6352803a12.7.1729163350172; Thu, 17 Oct 2024
 04:09:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014131416.27324-1-vimal.agrawal@sophos.com> <f38e017e-40ef-4241-8701-fc56c5c2d06d@stanley.mountain>
In-Reply-To: <f38e017e-40ef-4241-8701-fc56c5c2d06d@stanley.mountain>
From: Vimal Agrawal <avimalin@gmail.com>
Date: Thu, 17 Oct 2024 16:38:58 +0530
Message-ID: <CALkUMdSzeH-7=jXsGV1+ubzfqHVOC3z0RbN9BG08HTKwFoAWeg@mail.gmail.com>
Subject: Re: [PATCH] misc: misc_minor_alloc to allocate ids for all
 dynamic/misc dynamic minors
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, linux-kernel@vger.kernel.org, 
	gregkh@linuxfoundation.org, arnd@arndb.de, lkp@intel.com, 
	oe-kbuild-all@lists.linux.dev, vimal.agrawal@sophos.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

Both warning and missed case for return from this function for static
minor are already fixed in the v2 version of the patch. I will be
sending out the v3 version shortly ( after splitting it from kunit
changes).
Thanks for pointing this out.

Vimal

On Wed, Oct 16, 2024 at 7:52=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> Hi Vimal,
>
> kernel test robot noticed the following build warnings:
>
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Vimal-Agrawal/misc=
-misc_minor_alloc-to-allocate-ids-for-all-dynamic-misc-dynamic-minors/20241=
014-211915
> base:   char-misc/char-misc-testing
> patch link:    https://lore.kernel.org/r/20241014131416.27324-1-vimal.agr=
awal%40sophos.com
> patch subject: [PATCH] misc: misc_minor_alloc to allocate ids for all dyn=
amic/misc dynamic minors
> config: sparc64-randconfig-r072-20241015 (https://download.01.org/0day-ci=
/archive/20241016/202410161811.aIPEJHOt-lkp@intel.com/config)
> compiler: sparc64-linux-gcc (GCC) 14.1.0
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202410161811.aIPEJHOt-lkp@intel.com/
>
> smatch warnings:
> drivers/char/misc.c:89 misc_minor_alloc() error: uninitialized symbol 're=
t'.
>
> vim +/ret +89 drivers/char/misc.c
>
> d52c84545e305b Vimal Agrawal    2024-10-14  66  static int misc_minor_all=
oc(int minor)
> ab760791c0cfbb D Scott Phillips 2022-11-14  67  {
> ab760791c0cfbb D Scott Phillips 2022-11-14  68          int ret;
> ab760791c0cfbb D Scott Phillips 2022-11-14  69
> d52c84545e305b Vimal Agrawal    2024-10-14  70          if (minor =3D=3D =
MISC_DYNAMIC_MINOR) {
> d52c84545e305b Vimal Agrawal    2024-10-14  71                  /* alloca=
te free id */
> ab760791c0cfbb D Scott Phillips 2022-11-14  72                  ret =3D i=
da_alloc_max(&misc_minors_ida, DYNAMIC_MINORS - 1, GFP_KERNEL);
> ab760791c0cfbb D Scott Phillips 2022-11-14  73                  if (ret >=
=3D 0) {
> ab760791c0cfbb D Scott Phillips 2022-11-14  74                          r=
et =3D DYNAMIC_MINORS - ret - 1;
> ab760791c0cfbb D Scott Phillips 2022-11-14  75                  } else {
> ab760791c0cfbb D Scott Phillips 2022-11-14  76                          r=
et =3D ida_alloc_range(&misc_minors_ida, MISC_DYNAMIC_MINOR + 1,
> ab760791c0cfbb D Scott Phillips 2022-11-14  77                           =
             MINORMASK, GFP_KERNEL);
> ab760791c0cfbb D Scott Phillips 2022-11-14  78                  }
> d52c84545e305b Vimal Agrawal    2024-10-14  79          } else {
> d52c84545e305b Vimal Agrawal    2024-10-14  80                  /* specif=
ic minor, check if it is in dynamic or misc dynamic range  */
> d52c84545e305b Vimal Agrawal    2024-10-14  81                  if (minor=
 < DYNAMIC_MINORS) {
> d52c84545e305b Vimal Agrawal    2024-10-14  82                          m=
inor =3D DYNAMIC_MINORS - minor - 1;
> d52c84545e305b Vimal Agrawal    2024-10-14  83                          r=
et =3D ida_alloc_range(&misc_minors_ida, minor, minor, GFP_KERNEL);
> d52c84545e305b Vimal Agrawal    2024-10-14  84                  }
> d52c84545e305b Vimal Agrawal    2024-10-14  85
> d52c84545e305b Vimal Agrawal    2024-10-14  86                  if (minor=
 > MISC_DYNAMIC_MINOR)
> d52c84545e305b Vimal Agrawal    2024-10-14  87                          r=
et =3D ida_alloc_range(&misc_minors_ida, minor, minor, GFP_KERNEL);
>
> What about if minor is >=3D DYNAMIC_MINORS (128) but <=3D MISC_DYNAMIC_MI=
NOR (255)?
>
> d52c84545e305b Vimal Agrawal    2024-10-14  88          }
> ab760791c0cfbb D Scott Phillips 2022-11-14 @89          return ret;
> ab760791c0cfbb D Scott Phillips 2022-11-14  90  }
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

