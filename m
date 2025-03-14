Return-Path: <linux-kernel+bounces-561538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EB3A6133D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679C519C13BF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2493200116;
	Fri, 14 Mar 2025 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lZlbcuvD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178B41FCF7D;
	Fri, 14 Mar 2025 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741960764; cv=none; b=pzgLDa3kItlMcUqFALe27iBrmdaILK62+B63pbOKewT/4LmB1pi1f7sC2/zTti2vRErkfGkPN1VPTqSB6Nkc1JB9r+PT7c29n6H5diFE7fvbGNs5YxXcpB/VhrkdaCWRoW5uNtmKZWKbXNVBe/FQks+Xpzbx2cuTN7ffsJBC/pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741960764; c=relaxed/simple;
	bh=tWgripgzVsas+qOUIR7LTha2CLQlLotbIOYZtXB4pPg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Xo9xaSvQCf/+RPt/qHfMPoOLUqvK9J9V4lq7oQVlvIYGO12qsSd+pBjJGSEs5zYJhbD42yY0XbWBGUaRELaoSylDCmksL/CVtDZSyxUkjN2uuUKyhmA6mQB6Xi/ooiGDPJoEIcbQrA0q5QfFcs681NLbFJ/w2daXtJB5MfeMugo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lZlbcuvD; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741960762; x=1773496762;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tWgripgzVsas+qOUIR7LTha2CLQlLotbIOYZtXB4pPg=;
  b=lZlbcuvDWOvREDbl2Qjb+oTkAmHKHOGlx+mrZVqOloavfj8NZD7ZAy+Q
   yjpI+1QVxBcL8JBMC/XsmqyEmx9ptb5bsWKgD8rifcRn+DCkCrNnrtYVl
   Gh1VUbBfBUtfzIvlCzQiDne+/xnl+x2lIIBlqKNrVVUkxy49SiiId7bHx
   ZT6bTBuVmuY9tRIL6w9mstFOIIlK8yto9p1xzWCZ7PftMSzcf2jkf0JqN
   CLWUAzWVaVe1ahchW2eKjcI1zcJnwtt0yuYlWdAvHKuZKNuv4mnec/P3s
   Aax21u+6Hxp6DwE9nl/QiJAqPI+XxzgLokjD81pF3KnBYpCIVYOqgzkWL
   w==;
X-CSE-ConnectionGUID: UYf+YlHPTbaEp0Es5cQ+qA==
X-CSE-MsgGUID: rcndQ0JOSjKiVh7Dhk/MyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="42360920"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="42360920"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 06:59:21 -0700
X-CSE-ConnectionGUID: jxpPO/uoRsmbTq31ulCqDg==
X-CSE-MsgGUID: WzKRZISmTq6N/BMa9pu+7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121785779"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.56])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 06:59:18 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 14 Mar 2025 15:59:15 +0200 (EET)
To: Werner Sembach <wse@tuxedocomputers.com>
cc: Hans de Goede <hdegoede@redhat.com>, Jean Delvare <jdelvare@suse.com>, 
    Guenter Roeck <linux@roeck-us.net>, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86/tuxedo: Implement TUXEDO TUXI ACPI TFAN
 via hwmon
In-Reply-To: <49ceb1f4-93b1-47ed-a87b-b936fee1b371@tuxedocomputers.com>
Message-ID: <ad2e303d-1b13-d575-d58c-f4785e71d6e7@linux.intel.com>
References: <20250306132639.642369-1-wse@tuxedocomputers.com> <70633701-31d2-c2ab-f4f4-043dd186f485@linux.intel.com> <75556900-5fe3-4083-b81b-240994e4f8e0@tuxedocomputers.com> <4344644a-582b-aee6-7eef-8afd3c0ee16f@linux.intel.com>
 <49ceb1f4-93b1-47ed-a87b-b936fee1b371@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-237687533-1741960755=:10784"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-237687533-1741960755=:10784
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 14 Mar 2025, Werner Sembach wrote:

> Sorry, resend, mail client did html message by accident

Np.

> Am 14.03.25 um 11:05 schrieb Ilpo J=C3=A4rvinen:

> > > > > +=09=09=09S32_MAX : (retval - TUXI_FW_TEMP_OFFSET) *
> > > > > 100;
> > > > Is the math wrong, as you do retval - TUXI_FW_TEMP_OFFSET before
> > > > multiplying?
> > > No, retval is in 10th of =C2=B0K (but the last number is always 0) so=
 is
> > > TUXI_FW_TEMP_OFFSET which is there to convert it to 10th of =C2=B0C, =
the * 100
> > > is
> > > then to bring it in line with hwmon wanting to output milli degrees
> > So is result of S32_MAX correct when retval is 21474837?
> >=20
> > (21474837-2730)*100
> > 2147210700
> > 2^31-1
> > 2147483647
> >=20
> > 2147210700 would have been representable but the upper bound is
> > still applied (the value might be large enough to not have practical
> > significance but to me the code looks still illogical why it applies th=
e
> > bound prematurely).
>
> Yeah my though was: this check is only here to catch the firmware doing s=
ome
> crazy stuff and sending highly unrealistic values, so gifting a small bit=
 of
> the available range away doesn't matter

But it does matter as you could note. I stumbled on the logic which didn't=
=20
look right while reviewing. You even claimed afterwards is not wrong when=
=20
I raised this. :-/

Please just correct the logic so it makes sense to the code reader, there=
=20
seems to be no well justified reason to keep the illogical code even if=20
the practical impact is very low. It's probably done the way it is only=20
because the variable types are what they are so you couldn't do the=20
subtraction like I proposed ;-). At minimum you'd need to add a comment to=
=20
warn about the inconsistency at which point rewriting to correct logic is=
=20
already way simpler.

> > I see you already sent another version, it would have been prudent to w=
ait
> > a bit longer as you contested some of the comments so you could have se=
en
> > my replies before sending the next version.
>
> I'm sorry. I just wanted to show that I'm iterating as I wait for the rep=
ly if
> the design with the periodic safeguard is acceptable. If that's gets reje=
cted
> this driver must be rewritten anyway.

Kernel development is not a sprint. It's better to avoid sending versions=
=20
unnecessarily, a day or two isn't worth it when compared with ending up=20
into people's low priority bin which will inevitably happen when the=20
version counter starts to grow beyond v5-6.

I (and likely others too) appreciate if they don't have to waste review=20
cycles on something that is not "complete" because we have to look at the=
=20
completed one later too. Maintainers work in good faith that developers=20
are simply improving their patches (or working on some other great=20
improvements to the kernel :-)) while nothing seemingly happens for a=20
while. There's no need to prove that something is going on just for the=20
sake of proving.

Obviously RFC patches are still fine to ask specific questions about=20
something, but that's not about proving progress (in fact, RFC patches are=
=20
more about being "stuck" than about making progress).

> > > > Shouldn't it be like this:
> > > >=20
> > > > =09=09retval -=3D TUXI_FW_TEMP_OFFSET;
> > > > =09=09*val =3D min(retval * 100, (unsigned long long)S32_MAX);
> > > As retval is unsigned this would not work with (theoretical) negative=
 =C2=B0C.
> > So your code relies on implicit type conversion in this: (retval -
> > TUXI_FW_TEMP_OFFSET) ?
>=20
> I can add an explicit cast, np.
>=20
> [snip]
>=20
> > > > > +=09}
> > > > > +=09if (temp >=3D temp_high)
> > > > > +=09=09ret =3D i;
> > Now that I reread things, is this also incorrect, as "i" is at the
> > terminator entry at this point?
>=20
> Yes that's intentional, the 3 entries in the array open up 4 ranges:
>=20
> lower then 1st entry i=3D0, between 1st and 2nd entry i=3D1, 2nd and 3rd =
i=3D2,
> higher then 3rd i=3D3 (the value that terminates the for loop)

I didn't realize that. To me { } looks just an terminating entry. So=20
what's the min_speed going to be for that last entry since it's=20
initialized to 0?

Oh, I see you're taking .min_speed from temp_levels[temp_level - 1] which
I don't like either. You have a "state" and then store min_speed for the=20
state into other index inside the array?!?

> > > > > +
> > > > > +=09=09temp =3D retval > S32_MAX / 100 ?
> > > > > +=09=09=09S32_MAX : (retval - TUXI_FW_TEMP_OFFSET) *
> > > > > 100;
> > > > Same math issue comment as above.
> > > >=20
> > > > Why is the read+conversion code duplicated into two places?
> > > because here it is with special error handling and didn't thought abo=
ut an
> > > own
> > > function for a defacto 2 liner
> > A function that does read+conversion would be 6-8 lines with the error
> > handling.
>=20
> I can add it.
>=20
> [snip]
>=20
> Thanks for the code review again.
>=20
>=20
> Last but not least: As already mentioned, I still wonder if the design wi=
th
> the periodic safeguard is ok or not or?

I'm not sure if fully understand Daniel's suggestion [1] as it=20
doesn't specify who/what is sending that notification to the thermal=20
engine.

[1] https://lore.kernel.org/all/286f5efc-cd15-4e0b-bec2-2e9bbb93dd37@linaro=
=2Eorg/#t


When it comes to your own concerns, I'm not exactly buying the argument=20
that userspace can do dangerous things. Yeah, it can shoot one's own=20
foot, no doubt, such as unloading this driver and there goes your periodic=
=20
safeguards. If the argument would be that userspace fails to respond (in=20
time), I would have less trouble in accepting that argument.

--=20
 i.

--8323328-237687533-1741960755=:10784--

