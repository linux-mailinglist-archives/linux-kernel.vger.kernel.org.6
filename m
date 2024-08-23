Return-Path: <linux-kernel+bounces-299108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5135195D036
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 772921C2203A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126D8188590;
	Fri, 23 Aug 2024 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a0v0Mdl9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BED1E4B2;
	Fri, 23 Aug 2024 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724424186; cv=none; b=oQZQ7ROn4xqNiKnw70xLFJogTxnCr+ZiCHvERaKL4/iq/+4G/28dyZ/sgttuSe5hJMH3W1DmfOV3WQYq9hvvsvyzmyTzAYj49iOIBjY4YFpvZekVfsJpDlhdRmCY1qB+5aCkzVZj4DNF6ySKkZN1rMjYvMGNroVQGrMGdgyVnCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724424186; c=relaxed/simple;
	bh=qZ56w3M6m3+Ib8naPKDYErrKF3TaH8hFo9WLkYydJzM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C/BXYutimvzm1OlnxuctS7z+hOEHzhyoOByAeGgff7ivsSM5ZMGzwZeq9Fu5d/s0eSnfxCBjSh4FLXziIeXg75FuJxLZWok61f0Rm7uoGsD342UsBnpEB91C92eIEgHNFS/DWUIQqbwM6wBv796chjAmPOOV41c3YjXZxmWRyd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a0v0Mdl9; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724424184; x=1755960184;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=qZ56w3M6m3+Ib8naPKDYErrKF3TaH8hFo9WLkYydJzM=;
  b=a0v0Mdl9lDZQkvZidrgErS1QbPdA+9dH4rpIqfbB5FjTTGkVx/BZ+8xr
   hh03Lu0EZr6VwDrOMbo0/nx+WwiTdhNK1MakKkChwQ6Ot6vOT5CipNdfW
   zA9Ooy9fWeVRwpKGDkt5W7/x8J1i5/Cv5g5SPhBYwwwdHwGGdYv1i9IB6
   kVw6J16A/nVRyCvButqboZKG4bt/T8Z6ZLx136qYmni1diT93E7fpRgEC
   y/3i+zxtdqrjwx7xP7w4hSz7J0Sck0hia83ZJSoCeBBmWiest/vFKsKcP
   jmfD/7qfdTOCa5E97nmMEaLjCFeQJsPRov6symNYbMIIEt6MAA7Qc06Hz
   g==;
X-CSE-ConnectionGUID: IEG7RJbuSwaEiMcG3SmBqg==
X-CSE-MsgGUID: 418bNt1CSjavI9YjlA28HA==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="23065402"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="23065402"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 07:43:03 -0700
X-CSE-ConnectionGUID: a5eHacTfTqqnx1IZrmwa/g==
X-CSE-MsgGUID: 1Ya/CHx2RSmABdRzQJWmDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="92542015"
Received: from kkkuntal-desk3 (HELO [10.124.222.88]) ([10.124.222.88])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 07:43:03 -0700
Message-ID: <5ea774f522a365ef42c9e3729d123f9be4b04726.camel@linux.intel.com>
Subject: Re: [PATCH 3/3] platform/x86/intel-uncore-freq: Add efficiency
 latency control to sysfs interface
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Tero Kristo <tero.kristo@linux.intel.com>, Hans de Goede
	 <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, LKML
	 <linux-kernel@vger.kernel.org>
Date: Fri, 23 Aug 2024 10:43:01 -0400
In-Reply-To: <6adc07a2-14bc-6910-5d51-a0f68fc8ef46@linux.intel.com>
References: <20240821131321.824326-1-tero.kristo@linux.intel.com>
	 <20240821131321.824326-4-tero.kristo@linux.intel.com>
	 <4cf8d691-d00c-3603-6722-06394f00bdfc@linux.intel.com>
	 <863beeab7f6ecf36796394c75e95fc7a0396a862.camel@linux.intel.com>
	 <6adc07a2-14bc-6910-5d51-a0f68fc8ef46@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-23 at 16:29 +0300, Ilpo J=C3=A4rvinen wrote:
> On Fri, 23 Aug 2024, srinivas pandruvada wrote:
> > On Fri, 2024-08-23 at 16:03 +0300, Ilpo J=C3=A4rvinen wrote:
> > > On Wed, 21 Aug 2024, Tero Kristo wrote:
> > >=20
> > > > Add the TPMI efficiency latency control fields to the sysfs
> > > > interface.
> > > > The sysfs files are mapped to the TPMI uncore driver via the
> > > > registered
> > > > uncore_read and uncore_write driver callbacks. These fields are
> > > > not
> > > > populated on older non TPMI hardware.
> > > >=20
> > > > Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> > > > ---
> > > > =C2=A0.../uncore-frequency-common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 42
> > > > ++++++++++++++++---
> > > > =C2=A0.../uncore-frequency-common.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 13 +++=
++-
> > > > =C2=A02 files changed, 49 insertions(+), 6 deletions(-)
> > > >=20
> > > > diff --git a/drivers/platform/x86/intel/uncore-
> > > > frequency/uncore-
> > > > frequency-common.c b/drivers/platform/x86/intel/uncore-
> > > > frequency/uncore-frequency-common.c
> > > > index 4e880585cbe4..e22b683a7a43 100644
> > > > --- a/drivers/platform/x86/intel/uncore-frequency/uncore-
> > > > frequency-
> > > > common.c
> > > > +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-
> > > > frequency-
> > > > common.c
> > > > @@ -60,11 +60,16 @@ static ssize_t show_attr(struct uncore_data
> > > > *data, char *buf, enum uncore_index
> > > > =C2=A0static ssize_t store_attr(struct uncore_data *data, const cha=
r
> > > > *buf, ssize_t count,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 enum uncore_index index)
> > > > =C2=A0{
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int input;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int input =3D 0=
;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > > > =C2=A0
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (kstrtouint(buf, 10, =
&input))
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (index =3D=3D
> > > > UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (kstrtobool(buf, (bool *)&input))
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret=
urn -EINVAL;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (kstrtouint(buf, 10, &input))
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret=
urn -EINVAL;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > > =C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&uncore_=
lock);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D uncore_writ=
e(data, input, index);
> > > > @@ -103,6 +108,18 @@ show_uncore_attr(max_freq_khz,
> > > > UNCORE_INDEX_MAX_FREQ);
> > > > =C2=A0
> > > > =C2=A0show_uncore_attr(current_freq_khz, UNCORE_INDEX_CURRENT_FREQ)=
;
> > > > =C2=A0
> > > > +store_uncore_attr(elc_low_threshold_percent,
> > > > UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD);
> > > > +store_uncore_attr(elc_high_threshold_percent,
> > > > UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD);
> > > > +store_uncore_attr(elc_high_threshold_enable,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE);
> > > > +store_uncore_attr(elc_floor_freq_khz,
> > > > UNCORE_INDEX_EFF_LAT_CTRL_FREQ);
> > > > +
> > > > +show_uncore_attr(elc_low_threshold_percent,
> > > > UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD);
> > > > +show_uncore_attr(elc_high_threshold_percent,
> > > > UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD);
> > > > +show_uncore_attr(elc_high_threshold_enable,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
> > > > UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE);
> > > > +show_uncore_attr(elc_floor_freq_khz,
> > > > UNCORE_INDEX_EFF_LAT_CTRL_FREQ);
> > > > +
> > > > =C2=A0#define
> > > > show_uncore_data(member_name)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0
> > > > \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0static ssize_t show=
_##member_name(struct kobject
> > > > *kobj,=C2=A0\
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct
> > > > kobj_attribute
> > > > *attr, char *buf)\
> > > > @@ -146,7 +163,8 @@ show_uncore_data(initial_max_freq_khz);
> > > > =C2=A0
> > > > =C2=A0static int create_attr_group(struct uncore_data *data, char
> > > > *name)
> > > > =C2=A0{
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret, freq, index =3D=
 0;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret, index =3D 0;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int val;
> > > > =C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0init_attribute_rw(m=
ax_freq_khz);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0init_attribute_rw(m=
in_freq_khz);
> > > > @@ -168,10 +186,24 @@ static int create_attr_group(struct
> > > > uncore_data *data, char *name)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data->uncore_attrs[=
index++] =3D &data-
> > > > > initial_min_freq_khz_kobj_attr.attr;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data->uncore_attrs[=
index++] =3D &data-
> > > > > initial_max_freq_khz_kobj_attr.attr;
> > > > =C2=A0
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D uncore_read(data=
, &freq,
> > > > UNCORE_INDEX_CURRENT_FREQ);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D uncore_read(data=
, &val,
> > > > UNCORE_INDEX_CURRENT_FREQ);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ret)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data->uncore_attrs[index++] =3D &data-
> > > > > current_freq_khz_kobj_attr.attr;
> > > > =C2=A0
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D uncore_read(data=
, &val,
> > > > UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ret) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0init_attribute_rw(elc_low_threshold_percent);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0init_attribute_rw(elc_high_threshold_percent);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0init_attribute_rw(elc_high_threshold_enable);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0init_attribute_rw(elc_floor_freq_khz);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0data->uncore_attrs[index++] =3D &data-
> > > > > elc_low_threshold_percent_kobj_attr.attr;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0data->uncore_attrs[index++] =3D &data-
> > > > > elc_high_threshold_percent_kobj_attr.attr;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0data->uncore_attrs[index++] =3D
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&da=
ta-
> > > > > elc_high_threshold_enable_kobj_attr.attr;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0data->uncore_attrs[index++] =3D &data-
> > > > > elc_floor_freq_khz_kobj_attr.attr;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > >=20
> > > Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > >=20
> > > But I have to say I'm not big fan of this function treating any
> > > error
> > > as=20
> > > an implicit indication of ELC not supported.
> >=20
> > Also there is a check for version number, which supports ELC.
>=20
> AFAICT, the version number check is not on the path that is called
> from=20
> create_attr_group().
>=20
> The version number check is in uncore_probe() which then propagates
> this=20
> knowledge into read/write_eff_lat_ctrl() using ->elc_supported.

I mean uncore_read() should fail if the current platform doesn't
support ELC.
Here that check is via a flag cluster_info->elc_supported.

>=20
> > So this
> > condition will never be true unless some IO read failure.
>=20
> So are you saying ->elc_supported check is not required (added by
> patch=20
> 2)? It return -EOPNOTSUPP not because of an "IO read failure"??
>=20
I take back IO read fail. readq() will never fail here. uncore_read()
can only fail on non TPMI platforms only for IO issues.

 We should check elc_supported.


> > > Is that even going to be true after this:
> > >=20
> > > =C2=A0
> > > https://patchwork.kernel.org/project/platform-driver-x86/patch/202408=
20204558.1296319-1-srinivas.pandruvada@linux.intel.com/
> > >=20
> > > ...as root_domain is eliminated for other reasons than ELC=20
> > > supported/not-supported (-ENODATA return path)?
> >=20
> > Even if ELC is not supported, but all others fields will always be
> > supported from base version. The above change doesn't do anything
> > with
> > root domain.
>=20
> ??
>=20
> read/write_eff_lat_ctrl() check for ->root_domain and return -ENODATA
> if it is true. If that patch from you I linked above is applied, this
> line=20
> won't execute on some systems:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpmi_uncore->root_cluster=
.root_domain =3D true;
>=20
Yes and will return without calling any callbacks for any attribute for
root domain only on these systems. So read/write_eff_lat_ctrl() will
not be called for root domain. For other domains the callbacks are
called before this check.=20

> Will that cause an issue (for read/write_eff_lat_ctrl())?
We don't present ELC fields on root_domain on any system.

Can you tell what kind of issues you are worried about, may be I am not
getting?

>=20
> My concern here is that misusing error values like this to do=20
> supported/not-supported check leads to fragility that would not occur
> if errors would be treated as hard errors and supported is checked by
> other means (which would be easy here using ->elc_supported, AFAICT).
>=20

Attribute creation is in common part which includes non TPMI systems,
which we still support for all clients for several gens.

We can add a feature mask as part of struct uncore_data and avoid
calling uncore_read() and treat uncore_read() error as hard errors as a
separate change. elc_supported can be moved to this structure, but I
want to avoid as we will be adding some more features, which are again
TPMI specific, so more flags will be needed.

Thanks,
Srinivas






