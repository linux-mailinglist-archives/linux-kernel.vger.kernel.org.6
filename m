Return-Path: <linux-kernel+bounces-564571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3076A6578D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968A9178470
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9084B1E52D;
	Mon, 17 Mar 2025 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="blgYBjPI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4BC199931;
	Mon, 17 Mar 2025 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742227647; cv=none; b=fo6FSblCk8cAW5zyT3+HsTaP/Frjikb+8zSTsIq+NbW+jyZVsXNVdX85cSHQMlnHzjUXbnxoxO6/j9Q2Kwzupkc0wFEK3P82iDzrR4a5/7r73oMMd5F4ozfVqFzc/1v9CGf5WYvg5ecsufByXxrW4/iW2sQ0qM/ePeQgrJNBaOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742227647; c=relaxed/simple;
	bh=9GNkcEKj9sgBWueMkXaZ04oaSqcU6vqT0TxpdglAf/I=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jggiUuSjPG4WUb+CjCBUtaW7FSgfAdToBQHpJBURgJY4qsNglyzpsgx4Yz7P8CNQmXF1I9WLwkvZU9cHG387CuoISrcSFZ2rAlKdXB6B5jW2hGVZHV0+sF+YBoIyfuwL2G3jlQ8QzuCVhLrx8lpkPloyNTnAGBIqg7syH6a+OSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=blgYBjPI; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742227645; x=1773763645;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=9GNkcEKj9sgBWueMkXaZ04oaSqcU6vqT0TxpdglAf/I=;
  b=blgYBjPI2QgHzB997tm5Bw9gCVwaCg+YnAjarB/0lPY1wmA4sW0racXw
   cZt8AmKbN8mw4Ppd0uSv6bK/A+m3MekQqrz+3emq6Q2nNZHIN6ESihhTa
   wzJL2l7GVuBzlFZ/9+VMnKHAkDdjhMZe+uJ8i0wzHY8X52xA3x1pZuQ1y
   ft3Q9Pv7kQwDEOdYK/Fme+ZDwoQhRUqmJIfdDsotm7NA2VSc1l+j7w9FV
   Bb+8pl5Um/LmWWVXsQ45gVqoJHhPjJem3wN2QxdBnP88ZmGdyR7gcoEzm
   S9VgMysRjvFOZMmk7BQNwG3xKRKoVXJF/4WGof9EC7MuhIkwtzXkaOmFA
   w==;
X-CSE-ConnectionGUID: PA7Gym3iQH20psODk7bn7Q==
X-CSE-MsgGUID: QLdcH4VGSt2m8tpUbbWA4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="68688138"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="68688138"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 09:07:19 -0700
X-CSE-ConnectionGUID: nE3KFyJnRGWIHjO8dfqL6A==
X-CSE-MsgGUID: Ghpa7GUEQaiNLolPKbNTIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="122711584"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.60])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 09:07:17 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 17 Mar 2025 18:07:13 +0200 (EET)
To: Chenyuan Yang <chenyuan0y@gmail.com>
cc: W_Armin@gmx.de, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: wmi: Add Null check for device
In-Reply-To: <CALGdzuoWo+sT5ShVRpY6Q0R=5GOBvbOY10hyvUeT8DL9vsSj3w@mail.gmail.com>
Message-ID: <dcd30b77-a856-3613-6905-79d2de7f7e73@linux.intel.com>
References: <20250313162820.3688298-1-chenyuan0y@gmail.com> <ff53debd-05bd-3a7f-89a5-2110b8103fad@linux.intel.com> <CALGdzuoWo+sT5ShVRpY6Q0R=5GOBvbOY10hyvUeT8DL9vsSj3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-993793629-1742227572=:944"
Content-ID: <277831c5-2f93-6670-7039-7be7e1d11df4@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-993793629-1742227572=:944
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <3a226e0c-01ed-8b74-fa1d-d14c69292990@linux.intel.com>

On Fri, 14 Mar 2025, Chenyuan Yang wrote:

> Hi Ilpo,
>=20
> Thanks for pointing this out.
> This was found by our static analyzer.
> Sorry that the checker didn't make further reasoning.

Hi Chenyuan,

Then you should be the one who does that further reasoning before sending=
=20
the patch out. :-) Please don't assume tools couldn't return also false=20
positives. It's good to study all the code related to the lines and=20
functions changed beyond just the patch context so you can understand=20
whether the change makes sense and explain how the problem can manifest=20
for real.

Please also name the tool in future in the changelog when problems are=20
found by some code analysis tool (as is also required by the submission=20
guidelines under Documentation/process/).


--=20
 i.


> On Fri, Mar 14, 2025 at 6:41=E2=80=AFAM Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Thu, 13 Mar 2025, Chenyuan Yang wrote:
> >
> > Hi,
> >
> > Could you please be consistent in style and write "NULL" also in the
> > shortlog in the subject.
> >
> > > Not all devices have an ACPI companion fwnode, so device might be NUL=
L.
> > > This is similar to the commit cd2fd6eab480
> > > ("platform/x86: int3472: Check for adev =3D=3D NULL").
> >
> > Please fold the paragraph normally.
> >
> > > Add a check for device not being set and return -ENODEV in that case =
to
> > > avoid a possible NULL pointer deref in parse_wdg().
> > >
> > > Note, acpi_wmi_probe() under the same file has such a check.
> >
> > Hmm, is this a bogus fix, as parse_wdg() is only called from
> > acpi_wmi_probe() so how can ACPI companion turn NULL in between??
> >
> > How was this problem found??
> >
> > > Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> > > ---
> > >  drivers/platform/x86/wmi.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> > > index 646370bd6b03..54e697838c1e 100644
> > > --- a/drivers/platform/x86/wmi.c
> > > +++ b/drivers/platform/x86/wmi.c
> > > @@ -1091,6 +1091,9 @@ static int parse_wdg(struct device *wmi_bus_dev=
, struct platform_device *pdev)
> > >       u32 i, total;
> > >       int retval;
> > >
> > > +     if (!device)
> > > +             return -ENODEV;
> > > +
> > >       status =3D acpi_evaluate_object(device->handle, "_WDG", NULL, &=
out);
> > >       if (ACPI_FAILURE(status))
> > >               return -ENXIO;
> > >
> >
> > --
> >  i.
> >
>=20
--8323328-993793629-1742227572=:944--

