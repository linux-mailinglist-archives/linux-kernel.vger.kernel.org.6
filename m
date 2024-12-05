Return-Path: <linux-kernel+bounces-433311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B209E5662
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D9BA166400
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2AA218856;
	Thu,  5 Dec 2024 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HLQ8vfo9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E19F11712;
	Thu,  5 Dec 2024 13:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733404709; cv=none; b=AaRAxaNukuIw+L0AYYnB4M3QIvPFRfylLRY3OrRH/o0xivS36/rjJWDYMZR+EI9Us/lvws4vr+8SilAGTS/Jd15WBaI4LfZtbgq/ef6mJlYC6V7URqmbNSaL3Zpy8eyPP+nDhtb8nPT18RcQm/NT/JtyU4lXnfLKCqfFCBMcx/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733404709; c=relaxed/simple;
	bh=KPbFtWvfaAtDpa8K4wargw1mVZ1FSiGfJOQg9kXIK9E=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JKOvfy4KkctrZ+Nt60vtbxNYIcTSpoPa2TdzDXhfFRZIpFG+WJQDGvSJ7d1cy9hCjnbf/BT7njcjpPkqYPWjxxb7HXo9q6IBItX5vtRXlxUO4x+4pWE5DZk3jnkOxcqpg6MyH41xl9nrvP/UhNmAEctK9FWNgef3YQdtsAb2AAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HLQ8vfo9; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733404708; x=1764940708;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=KPbFtWvfaAtDpa8K4wargw1mVZ1FSiGfJOQg9kXIK9E=;
  b=HLQ8vfo90UWpW6yYcY7EzV+g+ZTRPqlG1iDxLUVn6hGuS3ueFVjWz5a/
   FOKoHKcCzgLNCWF2skRmxTXOIL3xdmCt3aEbEg+FOPwwOBqWnCe2eketX
   ICr7Jv8TNzbOGMoXi/UjbfEIhZ2ukVfDb2ZnoWQgogoCww8wN6J+ez82Z
   W8+zClqOh1OlMKQP7hKGJxmqHcCcxp03017RfNmgeLW0EAArwmQod9Q6p
   hCjLzjQhNNx8AbSV2S9z7yhUtNxI7l2MMiDVQqrYaE6aTMdG42K1tIAVq
   kn59trKLdNKBshqg3MdIC0Nhj2sY2erBgLTnPKkBkG0mokAV4fgqTZ39X
   w==;
X-CSE-ConnectionGUID: K+xR3tyaTY+k5IvT07P9nQ==
X-CSE-MsgGUID: YIVkuivxTFO8DtxgEYlFJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33632035"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="33632035"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 05:18:27 -0800
X-CSE-ConnectionGUID: E8eMyo/vRouLrVtWCC5gmg==
X-CSE-MsgGUID: t1eSacJSSXSkSZv8MdW2fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="94287506"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.60])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 05:18:24 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 5 Dec 2024 15:18:20 +0200 (EET)
To: Kurt Borja <kuurtb@gmail.com>
cc: Dell.Client.Kernel@dell.com, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>, mario.limonciello@amd.com, 
    platform-driver-x86@vger.kernel.org, w_armin@gmx.de
Subject: Re: [RFC PATCH 05/21] alienware-wmi: Refactor rgb-zones sysfs group
 creation
In-Reply-To: <fme54i5psnvamh6u7u7o7wlnyzpstiuus6jk73tkjfkoulg2m6@kxicd7efw2rx>
Message-ID: <b051f580-a6e0-bd32-a6ad-2d172de3aecc@linux.intel.com>
References: <20241205002733.2183537-3-kuurtb@gmail.com> <20241205004005.2184945-2-kuurtb@gmail.com> <5d0ebcc9-062d-7252-956a-2ad8294d7077@linux.intel.com> <fme54i5psnvamh6u7u7o7wlnyzpstiuus6jk73tkjfkoulg2m6@kxicd7efw2rx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-383455427-1733404247=:932"
Content-ID: <8d7dd4de-7254-8453-11b6-f9bfe310ecc7@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-383455427-1733404247=:932
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <bfb803eb-7c41-0657-8e2e-f8b43400d8c1@linux.intel.com>

On Thu, 5 Dec 2024, Kurt Borja wrote:

> On Thu, Dec 05, 2024 at 12:17:01PM +0200, Ilpo J=E4rvinen wrote:
> > On Wed, 4 Dec 2024, Kurt Borja wrote:
> >=20
> > > Define zone_attrs statically with the use of helper macros and
> > > initialize the zone_attribute_group with driver's .dev_groups.
> > >=20
> > > This makes match_zone() no longer needed, so drop it.
> > >=20
> > > Signed-off-by: Kurt Borja <kuurtb@gmail.com>

> > >  =09zone_data =3D
> > >  =09    kcalloc(quirks->num_zones, sizeof(struct platform_zone),
> > >  =09=09    GFP_KERNEL);

You kcalloc() zone_data here for quirks->num_zones entries....

> > > -=09for (zone =3D 0; zone < quirks->num_zones; zone++) {
> > > -=09=09name =3D kasprintf(GFP_KERNEL, "zone%02hhX", zone);
> > > -=09=09if (name =3D=3D NULL)
> > > -=09=09=09return 1;
> > > -=09=09sysfs_attr_init(&zone_dev_attrs[zone].attr);
> > > -=09=09zone_dev_attrs[zone].attr.name =3D name;
> > > -=09=09zone_dev_attrs[zone].attr.mode =3D 0644;
> > > -=09=09zone_dev_attrs[zone].show =3D zone_show;
> > > -=09=09zone_dev_attrs[zone].store =3D zone_set;
> > > +=09for (zone =3D 0; zone < 4; zone++)
> > >  =09=09zone_data[zone].location =3D zone;
> >=20
> > You allocate quirks->num_zones entries to zone_data above but use a=20
> > literal here?
>=20
> I did this because quirks->num_zones controlls only visibility now.

This kind of information would be useful to put into the commit message!

It does not control only visibility, see the kcalloc() code above. Did you=
=20
mean to alter the alloc too but forgot?

> I didn't feel comfortable leaving an out of bounds access on zone_show()
> and zone_set() when they do `zone_data[location]`.
>=20
> Still those out of bounds accesses are hidden from user-space (right?) an=
d
> alienware_wmi_init() is getting dropped anyway so I should just leave it
> as zone < quirks->num_zones.

The assignment within this loop will write out of bounds if=20
quirks->num_zones is less than 4.

--=20
 i.
--8323328-383455427-1733404247=:932--

