Return-Path: <linux-kernel+bounces-275806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66496948A10
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6CF1C23317
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928F1166313;
	Tue,  6 Aug 2024 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H1SkLdu0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A018F62;
	Tue,  6 Aug 2024 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722929103; cv=none; b=I6TQnYlzL7HxxMsj0EKVeA115sZ27LiowtC864PGnsbtFLg+mlFsAq+3lWvwjhJtGChGeqUjYQ5YCvxfx5AeuO6mAOBFroXFUFBs+y1az8RZfcEN1vOUTFbwv4JYnMPATUbQOD5PPBhTuSvod4jZLb9LzCUwltaAOhRKr3rpBJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722929103; c=relaxed/simple;
	bh=CqTaLDPJu8un/Pohdg/7UWeq2jCz5bTL1pdakA2jlVI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=saZJONu0xp/QVFTtpqgu44OnHfijzhnHU38jLZ3xls0x9F9II75Qen3TfaBgPkdJvI5sfUkcAaIhp7ZGvuJ2LSnEDvDHYSiT5hdMpHNlQoDxq9JyoKhImL3eMGy0/qdajrRZwjpnxW6x2F9mjaPqwsdQNH+D6u7L8nozyblZAuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H1SkLdu0; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722929102; x=1754465102;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=CqTaLDPJu8un/Pohdg/7UWeq2jCz5bTL1pdakA2jlVI=;
  b=H1SkLdu0iHMMrev6wHEObmnw3jsjADqv4Swr2uS7Ag7d79OcrlEWJ6pu
   rfQbrqf85sGRfdPxH0LEnAteFI/tWgCGEGuCzcqbWr/BGJgDpi7DTh2sy
   qxMTpiay9EkPUs5m+gB9Imz0JxIKDa8IQWKpEOeHxe8QwFkkJqj43j8b2
   GvicUYis1yhkdn4E1DNQR3dJ/GF8kGNfWb8OfqdGY9NoknRC2K03PEAPL
   4jrbZGVrwt+f2HGNWOGfji5NU0mnIySnIwWAPNjYp3aAk6CKsOYdRkGaD
   Ci4EMX76mcK9zadKAsSAutbu/9mwyDmIMAH5AUKudQemsYK+qyuTs3ne4
   Q==;
X-CSE-ConnectionGUID: DOQkYQz9Sum7swAz8Z7PLQ==
X-CSE-MsgGUID: HZnKVXiOQ1G5NdTBxOiKgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="21075665"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="21075665"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 00:25:01 -0700
X-CSE-ConnectionGUID: pgQFZMDqSves7YFzk5ABag==
X-CSE-MsgGUID: ThFGYbw+THqao/ddDP8xJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="56635571"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.72])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 00:24:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 6 Aug 2024 10:24:54 +0300 (EEST)
To: =?ISO-8859-2?Q?Marek_Ma=B6lanka?= <mmaslanka@google.com>
cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, 
    Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>, 
    David E Box <david.e.box@intel.com>, Hans de Goede <hdegoede@redhat.com>, 
    John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3] platform/x86:intel/pmc: Enable the ACPI PM Timer to
 be turned off when suspended
In-Reply-To: <CAGcaFA2eXzzCVqG-DSWDb1gruV4FemRC3W+dgRub7GgcOyf7yQ@mail.gmail.com>
Message-ID: <28567169-4588-002d-85b8-906d22f12f05@linux.intel.com>
References: <CAGcaFA2sQNRo9UThN-C1NOLtGUJ3sKzc=pEC9wdDWMi501iLsA@mail.gmail.com> <20240730120546.1042515-1-mmaslanka@google.com> <87cymu7tgq.ffs@tglx> <CAGcaFA1HJBYacvDAkZAO9HNhT2dZO7OdgcBYb59p7OJkVqQ6Fw@mail.gmail.com> <87h6c55xnp.ffs@tglx>
 <CAGcaFA2eXzzCVqG-DSWDb1gruV4FemRC3W+dgRub7GgcOyf7yQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-830646355-1722860352=:1238"
Content-ID: <1a49fe45-dc74-3f0a-a030-f1528479905e@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-830646355-1722860352=:1238
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <9307d9e8-bc81-8209-1bee-fa90891a2aa3@linux.intel.com>

On Wed, 31 Jul 2024, Marek Ma=C5=9Blanka wrote:

> On Wed, Jul 31, 2024 at 6:33=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
> >
> > Marek!
> >
> > On Wed, Jul 31 2024 at 16:44, Marek Ma=C5=9Blanka wrote:
> > > On Tue, Jul 30, 2024 at 6:08=E2=80=AFPM Thomas Gleixner <tglx@linutro=
nix.de> wrote:
> > >> On Tue, Jul 30 2024 at 12:05, Marek Maslanka wrote:
> > >> +static void acpi_pm_disable(struct clocksource *cs)
> > >> +{
> > >> +       acpi_pm_enabled =3D false;
> > >> +       if (enable_callback)
> > >> +               enable_callback(false);
> > >> +}
> > >> +
> > >>  static struct clocksource clocksource_acpi_pm =3D {
> > >>         .name           =3D "acpi_pm",
> > >>         .rating         =3D 200,
> > >>         .read           =3D acpi_pm_read,
> > >>         .mask           =3D (u64)ACPI_PM_MASK,
> > >>         .flags          =3D CLOCK_SOURCE_IS_CONTINUOUS,
> > >> +       .enable         =3D acpi_pm_enable,
> > >> +       .disable        =3D acpi_pm_disable,
> > >>  };
> > >>
> > > Thanks. I'll try do this in that way. But I need to disable/enable
> > > ACPI PM timer only on suspend/resume, so I'll use suspend/resume
> > > callbacks.
> >
> > Why? What's the point of keeping it running when nothing uses it?
> >
> > Thanks,
> >
> >         tglx
>=20
> In case of Intel CPUs the watchdog (iTCO/wdat_wdt) is driven by ACPI PM
> Timer. But it may also be used by others that I don't know about, so I do=
n't
> want to disable it.

Hi Marek,

This kind of non-obvious information should be put into the changelog=20
because it helps if after ten years somebody is looking into this change=20
and asks similar why questions.

--=20
 i.
--8323328-830646355-1722860352=:1238--

