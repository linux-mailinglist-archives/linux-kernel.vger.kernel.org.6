Return-Path: <linux-kernel+bounces-287081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A7A9522B0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AA501C2187E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32241BE842;
	Wed, 14 Aug 2024 19:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AV3Bm0tR"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ACF1BD510
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 19:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723663811; cv=none; b=k84PYuGf92Vd1r7lLrg6C68Cm/LD4bxpw02Sqdo8T4S18Kzw/RHiVyhVXBqKn2j1Z0RHPfrIKJiUwyL+TQTDTjme5c0NAXZJtsKZ9ZqE6d+6qVLOHDKzKauuJCC+gHibHPIY4BApGh4y1iTbcQYOz3rocwXJ/rg+Tckdf+b+2Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723663811; c=relaxed/simple;
	bh=2rkNmEF/58bW5keu0wlIOSfW+TzZxSeo+2mXbxxenf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrwNjsvG0v2a3JiNX6j5PsCTEuglg5DJa3YrZIyuR64U6Lcsb+VwqsW9NGUu9i+JTDUBpLFfg66Fe/nmJbOjyW4Qt+7zAiMWTMeIipFnXrZRLkSpQFrT1DEPLctYU4PmfTXMqBacUEk+WIErTSvjU+CSLbGYeEAiooKGg8tPwPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AV3Bm0tR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc611a0f8cso2033855ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 12:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723663809; x=1724268609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2orC+qE4+JgnSpowxeNtJQNLuO+iy/rKh6rk9hYX5eQ=;
        b=AV3Bm0tRsdRbmwcu/9P0kS+abWdAiKoiOSJ2heFDAVVMTQ63u4LVP2O4e+WgK4GBRj
         xDkk++jDS87bE+S9/lhP7xhR9Wnqq1mxMtAOZF05TIf8AlkpTEgC20Nr69cf+EfvoH4n
         nnEoqjfE5sCkyQC5czz8o5kRjw19ymPt2RxoQXhPerij2QxWrSPULcwYVDrixSXwHkeS
         CJX9ML/rtIHoPz0NlzynAcmRAeZwPjEb7IYo/FdGjqoEx3IwfsEFd/0orBHkF7o2Oh7T
         q/+fU+p3EqbnhyELSiTYjbtj0HXH3XIXNBXMUPtRwtKLUm87ogxFaypj2d89YKCzScud
         sH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723663809; x=1724268609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2orC+qE4+JgnSpowxeNtJQNLuO+iy/rKh6rk9hYX5eQ=;
        b=Mz6vT9xjQb12lChKgDGdmjNVj5ATstuo0L9eVtoK1yn0x/IrkIRC3nfvauIOGMYbtm
         VK3BkIfB7hiiqcxPTiPhh8NPQSCGP58+ILakk8kW42g6eOf8OK/4rbssIKcNlwZ7E+CG
         ucTRliJxwv+JVsyAVjUzu2oPwspxQWo5ULmYtcBL32nWVaUSnVW5B9MyWAfaraZZkJlT
         JnhJsiz8iiqpyscSNMdZUisW0QVuo7t1bDheAm8xfeJjm+2y+cq7P+Z1tsLqmoWTXQX6
         AUluEPmiZjHkyr5LAvvMToF2mqG4lbsyg3kNdyFZoqgWkEb1D1h6WnGA8eQ8wzR7B6C3
         0t4g==
X-Forwarded-Encrypted: i=1; AJvYcCVyzoUc2c7r7e84evvi3ICm5GbuSzeWVtw2LjAJqk7pRjTGGOvJ48ik92om7sArb/54ECI1OrNHvhAgLQjpkl880n/EIQIcZE+FxLYr
X-Gm-Message-State: AOJu0YyTG6zV0S/Jg0I2THDtw1AKVj40YAgP9Zj9C4waXqiGxtjAHCPS
	CQ9REnh4i0niMcuvtkN7eDRQ5VQdQKG02K9Mku2ct25dyO3Wx2FzgnR2X6Ov+WHQGnb5nVMCVsF
	noMt9qM1Wj/pC/iw/9W2dtM6y5KA=
X-Google-Smtp-Source: AGHT+IHzARyOZOqSFNAjYmj2+ulO0fvklY9400IzG1zvOPK+AV5vzIrPm4MC4kcom2idbw8b65sYapngSwa3msyPS6E=
X-Received: by 2002:a17:902:ecc4:b0:1ff:54a2:161b with SMTP id
 d9443c01a7336-201d647e620mr51176815ad.39.1723663809469; Wed, 14 Aug 2024
 12:30:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230724211428.3831636-1-michal.winiarski@intel.com>
 <CADnq5_NwDn5DXPadzZtegUJ=y=LfVHykO7kG3edmiqRTTCxMNQ@mail.gmail.com> <nqsuaaibncfcnu3d5376ulujxfswbjwq3ptrivh6djpmvcpuih@fepbhcbik272>
In-Reply-To: <nqsuaaibncfcnu3d5376ulujxfswbjwq3ptrivh6djpmvcpuih@fepbhcbik272>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Aug 2024 15:29:57 -0400
Message-ID: <CADnq5_Nsx4ii4RnhB4J878naLajOWM6aAHYHzJ6mZyzdAEj7tA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] drm: Use full allocated minor range for DRM
To: =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, 
	Pekka Paalanen <pekka.paalanen@collabora.com>, David Airlie <airlied@linux.ie>, 
	Oded Gabbay <ogabbay@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
	Emil Velikov <emil.l.velikov@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, James Zhu <James.Zhu@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 8:19=E2=80=AFPM Micha=C5=82 Winiarski
<michal.winiarski@intel.com> wrote:
>
> On Mon, Aug 12, 2024 at 01:38:38PM GMT, Alex Deucher wrote:
> > Are there any objections to this series?  We have been running into
> > this limit as a problem for a while now on big servers.
>
> I don't think there were any objections, just a general lack of
> interest - so there are no R-b / Acks.
> If you're interested to have a go at it - I can resend it.
> It should still apply on latest drm-tip.

Yeah that would be great!

Thanks,

Alex

>
> -Micha=C5=82
>
> >
> > Alex
> >
> > On Mon, Jul 24, 2023 at 5:15=E2=80=AFPM Micha=C5=82 Winiarski
> > <michal.winiarski@intel.com> wrote:
> > >
> > > 64 DRM device nodes is not enough for everyone.
> > > Upgrade it to ~512K (which definitely is more than enough).
> > >
> > > To allow testing userspace support for >64 devices, add additional DR=
M
> > > modparam (force_extended_minors) which causes DRM to skip allocating =
minors
> > > in 0-192 range.
> > > Additionally - convert minors to use XArray instead of IDR to simplif=
y the
> > > locking.
> > >
> > > v1 -> v2:
> > > Don't touch DRM_MINOR_CONTROL and its range (Simon Ser)
> > >
> > > v2 -> v3:
> > > Don't use legacy scheme for >=3D192 minor range (Dave Airlie)
> > > Add modparam for testing (Dave Airlie)
> > > Add lockdep annotation for IDR (Daniel Vetter)
> > >
> > > v3 -> v4:
> > > Convert from IDR to XArray (Matthew Wilcox)
> > >
> > > v4 -> v5:
> > > Fixup IDR to XArray conversion (Matthew Wilcox)
> > >
> > > v5 -> v6:
> > > Also convert Accel to XArray
> > > Rename skip_legacy_minors to force_extended_minors
> > >
> > > Micha=C5=82 Winiarski (4):
> > >   drm: Use XArray instead of IDR for minors
> > >   accel: Use XArray instead of IDR for minors
> > >   drm: Expand max DRM device number to full MINORBITS
> > >   drm: Introduce force_extended_minors modparam
> > >
> > >  drivers/accel/drm_accel.c      | 110 +++----------------------------=
--
> > >  drivers/gpu/drm/drm_drv.c      | 105 ++++++++++++++++---------------
> > >  drivers/gpu/drm/drm_file.c     |   2 +-
> > >  drivers/gpu/drm/drm_internal.h |   4 --
> > >  include/drm/drm_accel.h        |  18 +-----
> > >  include/drm/drm_file.h         |   5 ++
> > >  6 files changed, 69 insertions(+), 175 deletions(-)
> > >
> > > --
> > > 2.41.0
> > >

