Return-Path: <linux-kernel+bounces-299926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D755695DC51
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 08:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 494D8B22685
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 06:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F7015383B;
	Sat, 24 Aug 2024 06:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYcv9N7U"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5FE14D708
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 06:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724481690; cv=none; b=FMbZTyws062uIvGVJk+cqfAx9u0HVcld/cGNlVTUmDwEHSPOaEmcSvEIZs+oCJhkdxU6W7L3lmFjGKnOsR2uMaWWE1uQ7iyD6NTblyb5b+PpGdZvhTDmYO7BRhyZCI3u+MoRG8Q+hFkrp/RorR+H07Myst/fLGZmi1nLbRWf9N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724481690; c=relaxed/simple;
	bh=Dc2oA+rQ8miBH34Mh6BzgnuxyX5VWuTkY98HeeGLLFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SAtXUQ9U5D5E8gyaggJLQGLQMKrIhPDrHK9yrX2Uf6AEYS96ofoMxQxdesDESVHohcICTwhl7biKG3T9/PxCo90b3KX7ekXhyvPmzw0RYqEvrVsGfN/XPT9vw7eVAGmaqG+RypCQyaPgrqxeYl1udj2ApW7103dYmpjnlaiG1c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYcv9N7U; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7c1324be8easo2626578a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 23:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724481689; x=1725086489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLgAkkCBaXoGirDhhKnzRXuj0CxXS9rHgzxSe9Wjab4=;
        b=aYcv9N7UOaNmv/wPSuRZVNegLFrgjZgXcLi/XssF3qeJUDi2Kx2dWx58tL99wjHMPC
         OePDKktXw7JYrg6AlwcAqRoFuorTCqN5ymsJygRAstMXkPe3sP47sgQTOz8ZcI7GQO9u
         HS6COPbYAoSwgh4MEaoD8VaMSK76nBJaWCT2uEzN+yLCWhzHcZjsxCg5iuQ46c5p4th7
         KGZXrmN8kWJaiUZ5mMK9YojUaa/7ZwWMyYHV71mW2+o8k950gLaxQtd7GrNYmMytph9O
         vipcsSwVAz1gzVIBKH9gj/o4WgxUSAzfOM2d+50TtOb+8RMdKtuq+tnUIbpxL9tV+Pae
         DZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724481689; x=1725086489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLgAkkCBaXoGirDhhKnzRXuj0CxXS9rHgzxSe9Wjab4=;
        b=R4W7ZBVpB/sGrxPz0vNvJz40bdsgmN/rSJPIBhu91LqE0N4sZZ1wt+zBMV0xa2v+OB
         bYp0lw1yK362SvXn7VKg7SvCR9UAE9fIGo6oVKb/h5ZamC/3NE+e7F18dCwR7P90Pmr0
         6T7MG1aw03AOF7bcxKWuJCEKHT0Zqk/K0jGGvGL09VnAhXXQg3GEztP94D3Z+bl7gf4O
         5n1SdB2zr04erEzRiqZ6Pjolafhu5SIGXrGjAlYWETDnquRS6mMJN/QQB+SCKvvUArsl
         H6htDrTi0CG8hYiiHG0B7RTD8RM3CUQ8wME9oDLvB/0CpA8CJM5SwNeMxEA2tYGURYU6
         OQSw==
X-Forwarded-Encrypted: i=1; AJvYcCWkbvTRk0+5PEhdo9rh88E6JSu2pLUPwHR37DNKKNdmr5OXq3U5TuVuoZnlXY6H8pzMxl+3wN7knlDHqAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF/y/07C8k+gKYwby4DikSvMLV8gAeK8KJZYnrx5uMOKVYwgfq
	/P5CvQWI57b4H0nmiGO08IR9OIBFDqJhjVLCSwrainD3XJKjD/4x3jxsLAE/UDYyY4IimGLz1Ld
	+GhbjEElnG7IbnJBmGlEKRm5X+lX0z0TN
X-Google-Smtp-Source: AGHT+IHpVnut0KgCccnCub4pr8gA7C8vdcD165fpWrPmQYnEl7CcYwuL6lIAjHnHR8x73vrE6gxEmEEFH2ZoBhsjHmU=
X-Received: by 2002:a17:90b:33c4:b0:2cb:5829:a491 with SMTP id
 98e67ed59e1d1-2d644af966dmr7824484a91.20.1724481688651; Fri, 23 Aug 2024
 23:41:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202408220755.LlaA10C6-lkp@intel.com> <3ba6caea-654e-4dcd-a4a4-bfdcf808f0e5@intel.com>
In-Reply-To: <3ba6caea-654e-4dcd-a4a4-bfdcf808f0e5@intel.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 23 Aug 2024 23:41:17 -0700
Message-ID: <CAMo8BfJOPNaHb0f3Rf2GyhApCDg5bFfCGETWU9-LBJWiJpLeFw@mail.gmail.com>
Subject: Re: WARNING: [xtensa] modpost: vmlinux: section mismatch in
 reference: ice_adv_lnk_speed_maps+0x14 (section: .data) ->
 __setup_str_initcall_blacklist (section: .init.rodata)
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Pawel Chmielewski <pawel.chmielewski@intel.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Paul Greenwalt <paul.greenwalt@intel.com>, 
	Simon Horman <horms@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Przemek,

On Thu, Aug 22, 2024 at 1:23=E2=80=AFAM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
> > WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
> > WARNING: modpost: vmlinux: section mismatch in reference: put_page+0x78=
 (section: .text.unlikely) -> initcall_level_names (section: .init.data)
> >>> WARNING: modpost: vmlinux: section mismatch in reference: ice_adv_lnk=
_speed_maps+0x14 (section: .data) -> __setup_str_initcall_blacklist (sectio=
n: .init.rodata)
>
> I have spent just half of hour on that and I'm clueless.
>
> For reference, the driver code is:
>         static const u32 arr_name[] __initconst =3D {
>                 SOME_CONST,
>         };
> and core kernel has:
>         #define __initconst __section(.init.rodata)
>
>
> @Max Filippov, you have authored much of xtensa arch for kernel,
> especially XIP support, and touched .init.rodata back then;
> perhaps you have any idea what is going here?

I see the following:

static struct ethtool_forced_speed_map ice_adv_lnk_speed_maps[]
__ro_after_init =3D {
       ETHTOOL_FORCED_SPEED_MAP(ice_adv_lnk_speed, 100),

that array goes into the .data, but ETHTOOL_FORCED_SPEED_MAP
expands to the following:

#define ETHTOOL_FORCED_SPEED_MAP(prefix, value)                         \
{                                                                       \
       .speed          =3D SPEED_##value,                                \
       .cap_arr        =3D prefix##_##value,                             \
       .arr_size       =3D ARRAY_SIZE(prefix##_##value),                 \
}

so the first entry of that array quoted above above gets the following
initializer:

  .cap_arr =3D ice_adv_lnk_speed_100,

and ice_adv_lnk_speed_100 is defined as

  static const u32 ice_adv_lnk_speed_100[] __initconst =3D {

so this array goes into .init.rodata.
That's a reference from .data to .init.rodata that upsets the modpost check=
er.
I see that modpost incorrectly deduces where this link points (it's
ice_adv_lnk_speed_*, not __setup_str_initcall_blacklist).
I also see that this link is not used after the init phase, so it's harmles=
s.

--=20
Thanks.
-- Max

