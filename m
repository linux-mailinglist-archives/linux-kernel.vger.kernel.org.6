Return-Path: <linux-kernel+bounces-383848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0BE9B20E4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 22:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E50F0281565
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146CE186E54;
	Sun, 27 Oct 2024 21:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWWqmLld"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A44B2F29;
	Sun, 27 Oct 2024 21:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730065587; cv=none; b=g7yzcRo38Y8E24q50aqomNiPkkCVYyifSufNVz/+8a5tJSFlY+2PPv7DEXg35I1hrgqRGoZHk3uhaVf1VMQ6bhOtcapvSpv3WpuW5VIbGU7Mp8GeYIj8L4dH9Xl6XBJ7EhM6QheEC44BQn/DhdjtnPmhtN0+igIzO7k2sE4vEAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730065587; c=relaxed/simple;
	bh=w3emN0tP05LaGJ29Lr3R6ZdF7QF4SoRokOWBxguA+ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLu7i+SxM7fT68CUhQxvtLPZqmN791dcNW6QEXnbP5VZbZtsjVQjFZWL1EuGiKXRTAA9cAkZVyEod3VhsAOtavA1cLiQ5fjz2qqU/BhBdTBaIT5kk2DLQ/sENlzqzpUwHuuaUoQiv9yO0IDle6cuoXsSgIc1HdRmSF73C9gTq+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWWqmLld; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4a5b15cedd6so1208868137.2;
        Sun, 27 Oct 2024 14:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730065584; x=1730670384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9oTkj8bBEqNAwnIZUOGE9Yg4O2hyKu0DItFkCfpVWE=;
        b=NWWqmLldN8Hw9T/gHdsMdo7BpaibJZLew2tC7WJ9mwOCYkJgTett26aKBVrz3TPPe3
         yh2XXpDj5S/MCQQnwxQf3QgRufKV19kuGBOUfSRXerC+pnO5fiul3m2Dv+pmRyBTD8Gm
         wDb/n4iJNexaJZZ4qCrLxQZ2N9MtmGZHPvKXjBlvRP7813cTP2xEMgSS7K/9/RVglO3e
         YbzrhV4oFNwCohNR/9YMdOG+/4PeXFT6QG2PhsHFaUhlnH+w+wz7uL/poitsLs41tyyu
         W79MOaqutX5X8lXrjR2c2Wq7/+z3X/BNb4BCisMz2oY/Us8GeHZFpJqg7Vd6JNHAvQvo
         EN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730065584; x=1730670384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9oTkj8bBEqNAwnIZUOGE9Yg4O2hyKu0DItFkCfpVWE=;
        b=lQfKnJ/tU0DipFYISBD9KU69H7ZsyJvaF/pjjxheROY6rJQPvCl2pmRkE5oKGZRvjQ
         TZwusWW666Yg252MomeJPCPjlqkrl381GJ5Y+fQ1M359jlkmQ8XIpaUxMkAM7o1Dlrqn
         tjNBgI7zvGH7z0iRTEPMZVKeniP+6zcoZ1LwgiUdiyQaWJURsOKMjOGEhF/VZHeA7RCd
         kVLZDgRIstrrvBwBhn5206n9kmimyQbNCAefwZuiCP+rlQs9D0ta2t6d5LcFTuW7F3on
         Gpje0IAGfloYnDCq6uBzMHiuc6Dv4X/WPb4Lu+zbx3ud1afKNWrhstiRkh9AV2y0iMVs
         DoMw==
X-Forwarded-Encrypted: i=1; AJvYcCWiKSXJJys2hImhwQFMNUbOID2G4SHbyE/LyvX3sHIMuHTvgtYQKDeMlMMXdHbUsin0Mh4Sj9yoNzpIw13R@vger.kernel.org, AJvYcCX9MfgYm4w0zbv51PvMuT3q86l6aLk6GySiE1VDzr2eV4mFLfxE1aYzd1/LrLmkkXB2T7/FW1UH9N4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZCFTLFsGALqy1XZjtr64RHZufUkbR5uUXqjpTv+yexU7yHQKC
	Hpmgw1T3CL9kg09lcw8anNaXMEIhGrXiNrkAKbUuL/fPKTs1pv2avguprtwiCdPSNqdtjOAhJzA
	mG924Dq6lxvmNIsQutoNiMfReyX8=
X-Google-Smtp-Source: AGHT+IHMWiV7HxZ47mkYjFvoPjop7URgZhPeI0L1vtlzgFiJ6JayqVE/TbmZrZJMuetU452adEGrVpgcrFsL3jIWNnc=
X-Received: by 2002:a05:6102:f08:b0:4a3:cc16:e4db with SMTP id
 ada2fe7eead31-4a8cfd5728bmr3780856137.27.1730065583997; Sun, 27 Oct 2024
 14:46:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027175743.1056710-1-mcanal@igalia.com> <20241027175743.1056710-2-mcanal@igalia.com>
 <CAGsJ_4xPr3X_EXh73c4gN-cUSxaXZ-XR=_VNE750zNH61nyR-Q@mail.gmail.com> <9126583d-5865-4dcb-afe5-e846cccbea4c@igalia.com>
In-Reply-To: <9126583d-5865-4dcb-afe5-e846cccbea4c@igalia.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 28 Oct 2024 10:46:12 +1300
Message-ID: <CAGsJ_4wuNXD_6q_3hUidETLY8QQdDpdh71fNdmnok-PLiaMu5g@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: fix the format of the kernel parameter ``thp_anon=``
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 9:36=E2=80=AFAM Ma=C3=ADra Canal <mcanal@igalia.com=
> wrote:
>
> Hi Barry,
>
> On 27/10/24 16:52, Barry Song wrote:
> > On Mon, Oct 28, 2024 at 1:58=E2=80=AFAM Ma=C3=ADra Canal <mcanal@igalia=
.com> wrote:
> >>
> >> If we add ``thp_anon=3D32,64KB:always`` to the kernel command line, we
> >> will see the following error:
> >>
> >> [    0.000000] huge_memory: thp_anon=3D32,64K:always: error parsing st=
ring, ignoring setting
> >>
> >> This happens because the correct format isn't ``thp_anon=3D<size>,<siz=
e>[KMG]:<state>```,
> >> as [KMG] must follow each number to especify its unit. So, the correct
> >> format is ``thp_anon=3D<size>[KMG],<size>[KMG]:<state>```.
> >
> > what if 32768,64K: always?
>
> ``32768,64K:always`` works. From the kernel parameters documentation, I
> see that:
>
> "Finally, the [KMG] suffix is commonly described after a number of
> kernel parameter values. These =E2=80=98K=E2=80=99, =E2=80=98M=E2=80=99, =
and =E2=80=98G=E2=80=99 letters represent the
> _binary_ multipliers =E2=80=98Kilo=E2=80=99, =E2=80=98Mega=E2=80=99, and =
=E2=80=98Giga=E2=80=99, equaling 2^10, 2^20,
> and 2^30 bytes respectively. Such letter suffixes can also be entirely
> omitted"
>
> AFAIU this means that [KMG] can be omitted if we use bytes. But if we
> don't use bytes, it cannot be omitted.

Thanks! Could we change the subject of this commit to "fix the doc" without
mentioning format fixes? we are obviously only fixing the doc. With that,
please feel free to add:

Acked-by: Barry Song <baohua@kernel.org>

>
> Best Regards,
> - Ma=C3=ADra
>
> >
> >>
> >> Therefore, adjust the documentation to reflect the correct format of t=
he
> >> parameter ``thp_anon=3D``.
> >>
> >> Fixes: dd4d30d1cdbe ("mm: override mTHP "enabled" defaults at kernel c=
mdline")
> >> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> >> ---
> >>   Documentation/admin-guide/kernel-parameters.txt | 2 +-
> >>   Documentation/admin-guide/mm/transhuge.rst      | 2 +-
> >>   2 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documen=
tation/admin-guide/kernel-parameters.txt
> >> index 1518343bbe22..1666576acc0e 100644
> >> --- a/Documentation/admin-guide/kernel-parameters.txt
> >> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >> @@ -6688,7 +6688,7 @@
> >>                          0: no polling (default)
> >>
> >>          thp_anon=3D       [KNL]
> >> -                       Format: <size>,<size>[KMG]:<state>;<size>-<siz=
e>[KMG]:<state>
> >> +                       Format: <size>[KMG],<size>[KMG]:<state>;<size>=
[KMG]-<size>[KMG]:<state>
> >>                          state is one of "always", "madvise", "never" =
or "inherit".
> >>                          Control the default behavior of the system wi=
th respect
> >>                          to anonymous transparent hugepages.
> >> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentatio=
n/admin-guide/mm/transhuge.rst
> >> index 203ba7aaf5fc..745055c3dc09 100644
> >> --- a/Documentation/admin-guide/mm/transhuge.rst
> >> +++ b/Documentation/admin-guide/mm/transhuge.rst
> >> @@ -303,7 +303,7 @@ control by passing the parameter ``transparent_hug=
epage=3Dalways`` or
> >>   kernel command line.
> >>
> >>   Alternatively, each supported anonymous THP size can be controlled b=
y
> >> -passing ``thp_anon=3D<size>,<size>[KMG]:<state>;<size>-<size>[KMG]:<s=
tate>``,
> >> +passing ``thp_anon=3D<size>[KMG],<size>[KMG]:<state>;<size>[KMG]-<siz=
e>[KMG]:<state>``,
> >>   where ``<size>`` is the THP size (must be a power of 2 of PAGE_SIZE =
and
> >>   supported anonymous THP)  and ``<state>`` is one of ``always``, ``ma=
dvise``,
> >>   ``never`` or ``inherit``.
> >> --
> >> 2.46.2
> >>
>

Thanks
barry

