Return-Path: <linux-kernel+bounces-301191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 294C995ED7E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6981F22648
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C83814A4E1;
	Mon, 26 Aug 2024 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SWuGQcfE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2336F067;
	Mon, 26 Aug 2024 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724665062; cv=none; b=AmhvdQEWIMfnLC08wvQ+qHml0HTgfbbtmXn72Iq+c1Oj6Af4OaA2vEcXVqY6L4r6j+/m6eqgAW/8gkzBQ1hGVIjg9bXy9sE483fiwTLEwd7V7ArKdKnV3SdsbkESxIcQNW+4C/Bd3GdXXo61RdlIU/NjQse0Qv276Juj8ph3r8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724665062; c=relaxed/simple;
	bh=qBqWEFXL0uWCHo/iXquZb9sVcjFlbgO8/bqJFiH5l10=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IcdlVoYJiaiX5gxiOIJ+ONHKez9vcelVL2H18gBlP3fDr1+t5k8w1TyBGVxNmlqNg6PQqskjKK62jYO2BYLKHeyfY0rd6gGd/PhIm4GoZ55uB7ol2uYb/wiiFgfjGD69/5rs3J+YrxkkTe/+JgUWn4/aWINX3/mR+xgx8vj/eNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SWuGQcfE; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724665060; x=1756201060;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qBqWEFXL0uWCHo/iXquZb9sVcjFlbgO8/bqJFiH5l10=;
  b=SWuGQcfEVnC4sNE7JTdszMlNA+TSxoIZDJtARyrzS7Q0Czvt9KfNEjM4
   7yutNv9hgsgqAJRUK4UvE4HQd+H1f3b5/eCdYOCr5v7gG66FJeqB9hzcp
   n5+MDkmOgH3XB7iU5N4637XKyhliedKmUInQhT9ZQX2VQuB7aYj4zqKhK
   e5OPVDwZhIwQw11mMIXcXCvgg3ASfUWrSghDHdybJy6FCOtm5Q29JhoRP
   i9QJ7O21iFZs6hMIHwQcXWny4Kz40gU+bUwzmPW+9+fAWUfSzMX39PS1y
   HzwJfvwZbaB8qMXjZZAfS9v9inJQXx+llaY0a3Luow993t3Qygbb86nKM
   A==;
X-CSE-ConnectionGUID: cf3Ymh2oRF2gN4PkiN953Q==
X-CSE-MsgGUID: /oSMBB8MSP69hDdDLnbvMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="23253811"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="23253811"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 02:37:40 -0700
X-CSE-ConnectionGUID: S+kDyVEPQrq2vzbYG2vNOA==
X-CSE-MsgGUID: OexUrrrDQ1yPnS8V0Yn3zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="67357522"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.174])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 02:37:37 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 26 Aug 2024 12:37:33 +0300 (EEST)
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
cc: Tero Kristo <tero.kristo@linux.intel.com>, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] platform/x86/intel-uncore-freq: Add efficiency
 latency control to sysfs interface
In-Reply-To: <5ea774f522a365ef42c9e3729d123f9be4b04726.camel@linux.intel.com>
Message-ID: <855e49e2-197d-4a9d-7c06-c8bf1c5dcbce@linux.intel.com>
References: <20240821131321.824326-1-tero.kristo@linux.intel.com>  <20240821131321.824326-4-tero.kristo@linux.intel.com>  <4cf8d691-d00c-3603-6722-06394f00bdfc@linux.intel.com>  <863beeab7f6ecf36796394c75e95fc7a0396a862.camel@linux.intel.com> 
 <6adc07a2-14bc-6910-5d51-a0f68fc8ef46@linux.intel.com> <5ea774f522a365ef42c9e3729d123f9be4b04726.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1750317670-1724665053=:1013"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1750317670-1724665053=:1013
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 23 Aug 2024, srinivas pandruvada wrote:

> On Fri, 2024-08-23 at 16:29 +0300, Ilpo J=C3=A4rvinen wrote:
> > On Fri, 23 Aug 2024, srinivas pandruvada wrote:
> > > On Fri, 2024-08-23 at 16:03 +0300, Ilpo J=C3=A4rvinen wrote:
> > > > On Wed, 21 Aug 2024, Tero Kristo wrote:
> > > >=20
> > > > > Add the TPMI efficiency latency control fields to the sysfs
> > > > > interface.
> > > > > The sysfs files are mapped to the TPMI uncore driver via the
> > > > > registered
> > > > > uncore_read and uncore_write driver callbacks. These fields are
> > > > > not
> > > > > populated on older non TPMI hardware.
> > > > >=20
> > > > > Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> > > > > ---
> > > > > =C2=A0.../uncore-frequency-common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 42
> > > > > ++++++++++++++++---
> > > > > =C2=A0.../uncore-frequency-common.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 13 +++=
++-
> > > > > =C2=A02 files changed, 49 insertions(+), 6 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/platform/x86/intel/uncore-
> > > > > frequency/uncore-
> > > > > frequency-common.c b/drivers/platform/x86/intel/uncore-
> > > > > frequency/uncore-frequency-common.c
> > > > > index 4e880585cbe4..e22b683a7a43 100644
> > > > > --- a/drivers/platform/x86/intel/uncore-frequency/uncore-
> > > > > frequency-
> > > > > common.c
> > > > > +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-
> > > > > frequency-
> > > > > common.c
> > > > > @@ -60,11 +60,16 @@ static ssize_t show_attr(struct uncore_data
> > > > > *data, char *buf, enum uncore_index
> > > > > =C2=A0static ssize_t store_attr(struct uncore_data *data, const c=
har
> > > > > *buf, ssize_t count,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 enum uncore_index index)
> > > > > =C2=A0{
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int input;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int input =3D=
 0;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > > > > =C2=A0
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (kstrtouint(buf, 10=
, &input))
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (index =3D=3D
> > > > > UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE) {
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (kstrtobool(buf, (bool *)&input))
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
return -EINVAL;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (kstrtouint(buf, 10, &input))
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
return -EINVAL;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > > > =C2=A0
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&uncor=
e_lock);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D uncore_wr=
ite(data, input, index);
> > > > > @@ -103,6 +108,18 @@ show_uncore_attr(max_freq_khz,
> > > > > UNCORE_INDEX_MAX_FREQ);
> > > > > =C2=A0
> > > > > =C2=A0show_uncore_attr(current_freq_khz, UNCORE_INDEX_CURRENT_FRE=
Q);
> > > > > =C2=A0
> > > > > +store_uncore_attr(elc_low_threshold_percent,
> > > > > UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD);
> > > > > +store_uncore_attr(elc_high_threshold_percent,
> > > > > UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD);
> > > > > +store_uncore_attr(elc_high_threshold_enable,
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE);
> > > > > +store_uncore_attr(elc_floor_freq_khz,
> > > > > UNCORE_INDEX_EFF_LAT_CTRL_FREQ);
> > > > > +
> > > > > +show_uncore_attr(elc_low_threshold_percent,
> > > > > UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD);
> > > > > +show_uncore_attr(elc_high_threshold_percent,
> > > > > UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD);
> > > > > +show_uncore_attr(elc_high_threshold_enable,
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE);
> > > > > +show_uncore_attr(elc_floor_freq_khz,
> > > > > UNCORE_INDEX_EFF_LAT_CTRL_FREQ);
> > > > > +
> > > > > =C2=A0#define
> > > > > show_uncore_data(member_name)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0
> > > > > \
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0static ssize_t sh=
ow_##member_name(struct kobject
> > > > > *kobj,=C2=A0\
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct
> > > > > kobj_attribute
> > > > > *attr, char *buf)\
> > > > > @@ -146,7 +163,8 @@ show_uncore_data(initial_max_freq_khz);
> > > > > =C2=A0
> > > > > =C2=A0static int create_attr_group(struct uncore_data *data, char
> > > > > *name)
> > > > > =C2=A0{
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret, freq, index =
=3D 0;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret, index =3D 0;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int val;
> > > > > =C2=A0
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0init_attribute_rw=
(max_freq_khz);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0init_attribute_rw=
(min_freq_khz);
> > > > > @@ -168,10 +186,24 @@ static int create_attr_group(struct
> > > > > uncore_data *data, char *name)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data->uncore_attr=
s[index++] =3D &data-
> > > > > > initial_min_freq_khz_kobj_attr.attr;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data->uncore_attr=
s[index++] =3D &data-
> > > > > > initial_max_freq_khz_kobj_attr.attr;
> > > > > =C2=A0
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D uncore_read(da=
ta, &freq,
> > > > > UNCORE_INDEX_CURRENT_FREQ);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D uncore_read(da=
ta, &val,
> > > > > UNCORE_INDEX_CURRENT_FREQ);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ret)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data->uncore_attrs[index++] =3D &data-
> > > > > > current_freq_khz_kobj_attr.attr;
> > > > > =C2=A0
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D uncore_read(da=
ta, &val,
> > > > > UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ret) {
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0init_attribute_rw(elc_low_threshold_percent);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0init_attribute_rw(elc_high_threshold_percent);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0init_attribute_rw(elc_high_threshold_enable);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0init_attribute_rw(elc_floor_freq_khz);
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0data->uncore_attrs[index++] =3D &data-
> > > > > > elc_low_threshold_percent_kobj_attr.attr;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0data->uncore_attrs[index++] =3D &data-
> > > > > > elc_high_threshold_percent_kobj_attr.attr;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0data->uncore_attrs[index++] =3D
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
&data-
> > > > > > elc_high_threshold_enable_kobj_attr.attr;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0data->uncore_attrs[index++] =3D &data-
> > > > > > elc_floor_freq_khz_kobj_attr.attr;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > >=20
> > > > Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > > >=20
> > > > But I have to say I'm not big fan of this function treating any
> > > > error
> > > > as=20
> > > > an implicit indication of ELC not supported.
> > >=20
> > > Also there is a check for version number, which supports ELC.
> >=20
> > AFAICT, the version number check is not on the path that is called
> > from=20
> > create_attr_group().
> >=20
> > The version number check is in uncore_probe() which then propagates
> > this=20
> > knowledge into read/write_eff_lat_ctrl() using ->elc_supported.
>=20
> I mean uncore_read() should fail if the current platform doesn't
> support ELC.
> Here that check is via a flag cluster_info->elc_supported.
>=20
> >=20
> > > So this
> > > condition will never be true unless some IO read failure.
> >=20
> > So are you saying ->elc_supported check is not required (added by
> > patch=20
> > 2)? It return -EOPNOTSUPP not because of an "IO read failure"??
> >=20
> I take back IO read fail. readq() will never fail here. uncore_read()
> can only fail on non TPMI platforms only for IO issues.
>=20
>  We should check elc_supported.
>=20
>=20
> > > > Is that even going to be true after this:
> > > >=20
> > > > =C2=A0
> > > > https://patchwork.kernel.org/project/platform-driver-x86/patch/2024=
0820204558.1296319-1-srinivas.pandruvada@linux.intel.com/
> > > >=20
> > > > ...as root_domain is eliminated for other reasons than ELC=20
> > > > supported/not-supported (-ENODATA return path)?
> > >=20
> > > Even if ELC is not supported, but all others fields will always be
> > > supported from base version. The above change doesn't do anything
> > > with
> > > root domain.
> >=20
> > ??
> >=20
> > read/write_eff_lat_ctrl() check for ->root_domain and return -ENODATA
> > if it is true. If that patch from you I linked above is applied, this
> > line=20
> > won't execute on some systems:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpmi_uncore->root_clust=
er.root_domain =3D true;
> >=20
> Yes and will return without calling any callbacks for any attribute for
> root domain only on these systems. So read/write_eff_lat_ctrl() will
> not be called for root domain. For other domains the callbacks are
> called before this check.=20

Okay, I see. I was missing this piece of understanding about the root=20
domain.

> > Will that cause an issue (for read/write_eff_lat_ctrl())?
> We don't present ELC fields on root_domain on any system.
>=20
> Can you tell what kind of issues you are worried about, may be I am not
> getting?

I don't think there will any issue with that other patch now that I=20
understand the internals a bit better than before.

> > My concern here is that misusing error values like this to do=20
> > supported/not-supported check leads to fragility that would not occur
> > if errors would be treated as hard errors and supported is checked by
> > other means (which would be easy here using ->elc_supported, AFAICT).
> >=20
>=20
> Attribute creation is in common part which includes non TPMI systems,
> which we still support for all clients for several gens.
>=20
> We can add a feature mask as part of struct uncore_data and avoid
> calling uncore_read() and treat uncore_read() error as hard errors as a
> separate change. elc_supported can be moved to this structure, but I
> want to avoid as we will be adding some more features, which are again
> TPMI specific, so more flags will be needed.

Okay, lets just keep things as they are for now.

--=20
 i.

--8323328-1750317670-1724665053=:1013--

