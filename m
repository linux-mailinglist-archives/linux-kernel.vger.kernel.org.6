Return-Path: <linux-kernel+bounces-418191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E979D5E64
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86985281E6D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE321DE2B5;
	Fri, 22 Nov 2024 11:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9nIwiKR"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC821CB329
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732276277; cv=none; b=gA8KB28k6G+Esw1edkL7kxU47YDHUCDspc+qC8QVy9lGTcA2BV5PC1OjqUnxKrhv5/Tq/0EyB1+xf/pgk/6BOpzQHKz1ToM9oBETy0ZfpSLLr2URWhemTCdJ50UhAYrbhFbaLmBZqcpfzlOREepnqzmTpKGEVB0h1XnQNrCEj3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732276277; c=relaxed/simple;
	bh=e/4aTmrZgpE/YWlGgPwOERgEek3lFnIRZmHPXWTV2UE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CtrlhIdxmBrGVaq88C0Z0eGiIn9ZGFdkyPcRuz++y2p0fT1uspMlgRzg9sir/MCDcE3gNK72ip3Q0VM7WHAISYWdZohZcEY2Fd3yX95EMZHDIt9wheuZIZSEhh3Oau+TTGPtUPy1WX4AtNhSlEXxCBj6tX55YajgZv82OKE5bGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9nIwiKR; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6d42b87aceaso27724466d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 03:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732276274; x=1732881074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuaVspXSNCvk4bWhsb6UoaZtdZBO8Y18XWOd+1wmOwI=;
        b=T9nIwiKReL8VG2rM5GaIxN5KLOV+DDp6ogdEsLaoUQFGKl90sFFoqR5iu9mwTZo7pm
         l2CRnmFCX+6xfJSL0OwejGUTIaYVqKHXX0z2bzuttDJTUHLghbN7Y0KsUEyZYRypVVBA
         zdFuhXCCPe7oraOB9FiIlxlqBhCVZNse7dX04VWVD8hEQ15dqMqV0zU0kkldaFNtNimI
         3vSXXXhp25xFrLseXl7i/86Z4rLwisAt1LIDYDB8+r8lOJSwpTc7k2+RiLK67cxEjn2U
         RVTNVsmCc8eU2OJgADTBElS/JdtxuWNblC+v6fWzry7Om+gK36s2sriM1KtHBerpOcoh
         IPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732276274; x=1732881074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuaVspXSNCvk4bWhsb6UoaZtdZBO8Y18XWOd+1wmOwI=;
        b=cFTx1Aj4mUVoEvS5xPs3AC5+X7oSy+o2Ni26rPKFh+Ucbna55GiINYwRDcNnycuM9a
         AkOKtIZAACBwKmzO/aWDe21K5Qol9Ke+oORoF/yWLNUkQAhEwS79NLnWbJF3LwNJKC5H
         FlnedT4RXDX0hiRmsXAHiNvpivj7Upm2L5NyIGBih8hJxJfYHn8NRb0uP34f9+Lvc4Lv
         EuyNUMOu1/rP9U29P+4EgiUdYoqkltZrQPVODFksQlqx5DqbZ57s/IGoT8R4FelLz3Nj
         Vjn6VpcjKfzdkUNNIIzQ5KtwT+E8wFxDe57ymfu7BvMi6sq+hACVoVfgFK804mbZBtfk
         jnjw==
X-Forwarded-Encrypted: i=1; AJvYcCUgax+iZyUEHpTtovtdh/CnN2PgzCk0rIYo4Oia1CLAWnUHFiVhzApKJUsEDuShrJK3ndMu3tTcmWVFXiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLJqj5K61nNPLUSkX/2+GE3/mIISX4MBXx4+PH2ywyWmJ7F3Rj
	t2u3WdebqWiBz9CpNzEkr/+Iu4sf9xbAAp6APwwm7E1kpmiagLs3QCSap4i2s5TPrCp1R/11Bp1
	aQWERvF0OiGBAvLxqtWO4BddNflAIsnD2kqh4b0+gEu4=
X-Gm-Gg: ASbGncvGF83BpteML0TKCVMFPla89HvV+cPj+8vLW0BJKI7qtu/iXu+Mz/zhZoBV6dJ
	RFaBCfR+LqLnY45aJb22f4NS4BgBMzW2C
X-Google-Smtp-Source: AGHT+IFV2srk39HAd3+TDco+hJQHrDoUEN1d4xVxoqdDMocfLclnpbS8HRC8uRK3uT0H3YMtNvhZlVRYkagcrKhvAok=
X-Received: by 2002:a05:6214:d6e:b0:6d4:2b2:61f9 with SMTP id
 6a1803df08f44-6d442336b62mr128575416d6.5.1732276273085; Fri, 22 Nov 2024
 03:51:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120122858.22190-1-laoar.shao@gmail.com> <0aa9f3bd-b1b6-4089-b9eb-5b72d7a1541a@redhat.com>
 <CALOAHbBMebKtsRnfOFvNKorQk_4KGoCzKd0JcYv2p6pXhJqYbQ@mail.gmail.com>
 <2024112134-theater-jasmine-61f3@gregkh> <056df1ac-3b90-48b8-9bba-ac84305983a6@redhat.com>
 <CALOAHbCSTZz=FRDRjFW+eqssnpOAyq+UUi+KbYBR0crGHSB7qg@mail.gmail.com> <a74a8fb5-8434-4ed4-b6b3-519e0a14ed2c@redhat.com>
In-Reply-To: <a74a8fb5-8434-4ed4-b6b3-519e0a14ed2c@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 22 Nov 2024 19:50:37 +0800
Message-ID: <CALOAHbCuZ7LWJZuYr8+z0OhnYGa-0bWAsFYr8_pDivghHsYBwg@mail.gmail.com>
Subject: Re: [PATCH] /dev/mem: Add a new parameter strict_devmem to bypass
 strict devmem
To: David Hildenbrand <david@redhat.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, mingo@redhat.com, arnd@arndb.de, 
	x86@kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 6:58=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 22.11.24 03:14, Yafang Shao wrote:
> > On Thu, Nov 21, 2024 at 11:23=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> >>
> >> On 21.11.24 16:14, Greg KH wrote:
> >>> On Thu, Nov 21, 2024 at 10:31:12PM +0800, Yafang Shao wrote:
> >>>> On Thu, Nov 21, 2024 at 4:51=E2=80=AFPM David Hildenbrand <david@red=
hat.com> wrote:
> >>>>>
> >>>>> On 20.11.24 13:28, Yafang Shao wrote:
> >>>>>> When CONFIG_STRICT_DEVMEM is enabled, writing to /dev/mem to overr=
ide
> >>>>>> kernel data for debugging purposes is prohibited. This configurati=
on is
> >>>>>> always enabled on our production servers. However, there are times=
 when we
> >>>>>> need to use the crash utility to modify kernel data to analyze com=
plex
> >>>>>> issues.
> >>>>>>
> >>>>>> As suggested by Ingo, we can add a boot time knob of soft-enabling=
 it.
> >>>>>> Therefore, a new parameter "strict_devmem=3D" is added. The reuslt=
 are as
> >>>>>> follows,
> >>>>>>
> >>>>>> - Before this change
> >>>>>>      crash> wr panic_on_oops 0
> >>>>>>      wr: cannot write to /proc/kcore      <<<< failed
> >>>>>>
> >>>>>> - After this change
> >>>>>>      - default
> >>>>>>        crash> wr panic_on_oops 0
> >>>>>>        wr: cannot write to /proc/kcore    <<<< failed
> >>>>>>
> >>>>>>      - strict_devmem=3Doff
> >>>>>>        crash> p panic_on_oops
> >>>>>>        panic_on_oops =3D $1 =3D 1
> >>>>>>        crash> wr panic_on_oops 0
> >>>>>>        crash> p panic_on_oops
> >>>>>>        panic_on_oops =3D $2 =3D 0            <<<< succeeded
> >>>>>>
> >>>>>>      - strict_devmem=3Dinvalid
> >>>>>>        [    0.230052] Invalid option string for strict_devmem: 'in=
valid'
> >>>>>>        crash> wr panic_on_oops 0
> >>>>>>        wr: cannot write to /proc/kcore  <<<< failed
> >>>>>>
> >>>>>> Suggested-by: Ingo Molnar <mingo@kernel.org>
> >>>>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> >>>>>> ---
> >>>>>>     .../admin-guide/kernel-parameters.txt         | 16 +++++++++++=
+++
> >>>>>>     drivers/char/mem.c                            | 21 +++++++++++=
++++++++
> >>>>>>     2 files changed, 37 insertions(+)
> >>>>>>
> >>>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Doc=
umentation/admin-guide/kernel-parameters.txt
> >>>>>> index 1518343bbe22..7fe0f66d0dfb 100644
> >>>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
> >>>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >>>>>> @@ -6563,6 +6563,22 @@
> >>>>>>                         them frequently to increase the rate of SL=
B faults
> >>>>>>                         on kernel addresses.
> >>>>>>
> >>>>>> +     strict_devmem=3D
> >>>>>> +                     [KNL] Under CONFIG_STRICT_DEVMEM, whether st=
rict devmem
> >>>>>> +                     is enabled for this boot. Strict devmem chec=
king is used
> >>>>>> +                     to protect the userspace (root) access to al=
l of memory,
> >>>>>> +                     including kernel and userspace memory. Accid=
ental access
> >>>>>> +                     to this is obviously disastrous, but specifi=
c access can
> >>>>>> +                     be used by people debugging the kernel. Note=
 that with
> >>>>>> +                     PAT support enabled, even in this case there=
 are
> >>>>>> +                     restrictions on /dev/mem use due to the cach=
e aliasing
> >>>>>> +                     requirements.
> >>>>>> +             on      If IO_STRICT_DEVMEM=3Dn, the /dev/mem file o=
nly allows
> >>>>>> +                     userspace access to PCI space and the BIOS c=
ode and data
> >>>>>> +                     regions. This is sufficient for dosemu and X=
 and all
> >>>>>> +                     common users of /dev/mem. (default)
> >>>>>> +             off     Disable strict devmem checks.
> >>>>>> +
> >>>>>>         sunrpc.min_resvport=3D
> >>>>>>         sunrpc.max_resvport=3D
> >>>>>>                         [NFS,SUNRPC]
> >>>>>
> >>>>> This will allow to violate EXCLUSIVE_SYSTEM_RAM, and I am afraid I =
don't
> >>>>> enjoy seeing devmem handling+config getting more complicated.
> >>>>
> >>>> That poses a challenge. Perhaps we should also consider disabling
> >>>> functions that rely on EXCLUSIVE_SYSTEM_RAM when strict_devmem=3Doff=
,
> >>>> but implementing such a change seems overly complex.
> >>>>
> >>>> Our primary goal is to temporarily bypass STRICT_DEVMEM for live
> >>>> kernel debugging. In an earlier version, I proposed making the
> >>>> fucntion devmem_is_allowed() error-injectable, but Ingo pointed out
> >>>> that it violates the principles of STRICT_DEVMEM.
> >>>
> >>> I think that "primary goal" is the problem here.  We don't want to do
> >>> that, at all, for all the reasons why we implemented STRICT_DEVMEM an=
d
> >>> for why people enable it.
> >>
> >> +1
> >>
> >>>
> >>> Either you enable it because you want the protection and "security" i=
t
> >>> provides, or you do not.  Don't try to work around it please.
> >>>
> >>>> Do you have any suggestions on enabling write access to /dev/mem in
> >>>> debugging tools like the crash utility, while maintaining
> >>>> compatibility with the existing rules?
> >>>
> >>> I think you just don't provide write access to /dev/mem for debugging
> >>> tools as it's a huge security hole that people realized and have plug=
ged
> >>> up.  If you want to provide access to this for "debugging" then just
> >>> don't enable that option and live with the risk involved, I don't see
> >>> how you can have it both ways.
> >>
> >> Exactly. And I think a reasonable approach would be to have a debug
> >> kernel around into which you can boot, and make sure the debug kernel
> >> has such security features turned off.
> >>
> >> If you rely on distros, maybe you could convince the distro to ship th=
e
> >> debug kernel with STRICT_DEVMEM off. I just checked RHEL9, and it only
> >> seems to be off in debug kernels on arm64 and s390x (IIUC). Maybe ther=
e
> >> is a reason we don't even want that off on debug kernels on x86_64, or
> >> nobody requested it so far, because using the crash utility with write
> >> access on a live system ... is a rather weird ... debugging mechanism =
in
> >> 2024 IMHO.
> >
> > It seems I might be a bit outdated.
> > Could you share how you typically modify a live system these days? Are
> > you using live patching, writing kernel modules, or perhaps some
> > clever tools or techniques I'm not familiar with?
>
> I think modifying live systems is something people usually don't do
> anymore. The common debugging workflow is to use kdump and analyze it
> offline.
>
> I mean, people like me working for distributions analyze *a lot* of
> issues, and never really rely on /dev/mem or crash on a production
> system. Well, and apparently not even in debug kernels where some of
> them have STRICT_DEVMEM enabled.
>
> If you find yourself having to modify a live production system, you are
> probably something wrong.
>
> If you really want to modify your live system, there is kdb/kgdb.
> Alternatively, use a debug kernel where you disable security/safety
> mechanisms.

On a live system, you can experiment and try different approaches for
verification. However, with a dead system, you're left without any
options to test or debug.

In any case, thank you for your suggestion.

--=20
Regards
Yafang

