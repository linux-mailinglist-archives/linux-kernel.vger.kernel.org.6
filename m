Return-Path: <linux-kernel+bounces-298942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 688AB95CDD7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F588282E9A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C19A186E5E;
	Fri, 23 Aug 2024 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UbEgJISV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA4618661A;
	Fri, 23 Aug 2024 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724419801; cv=none; b=NfWttZQQsfIENQmFXu5lslDJHV1KhNcyVv889t1ZJQ5z/g+UONOOSSuMs7wehasbfo0btbo6ddxf6WazYLmgTTuISSSpFTSGnQc+7Ma3429CCjrRIFA5o1R+I/jWRcOne0N8D4DaNiqJEmvbwa7ATt8fCYXoGLoCqwbw07CKU6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724419801; c=relaxed/simple;
	bh=lxPnCqRE2SMW9DTd0bsncIN/4sowD1QrLleoMKQGYJc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=F4RaDDFp9nLzQMPNqq/aEG9FvAy0rGVa9plMbxbwqDCJvNJKRkMBXklXmcDakW2CJGjhDWl8GjTDU+z6/IiIZOabGmMsJ8R1pRYnP2oQYze77IZhzk/jaL+PgGhZU0JHfvst3x1WDVVZkLPARF/v473EjATcNZUfLJHgMrsK8mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UbEgJISV; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724419799; x=1755955799;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lxPnCqRE2SMW9DTd0bsncIN/4sowD1QrLleoMKQGYJc=;
  b=UbEgJISVH3hjkYNFFVpmBTeWjYTE0x+4I/We6AJ9Rx21DdIirLwvYCou
   GJJVssLoh04KWpoykM2v6N0ZGHE5WMxvr1SV5hncYJiUK/QJ7vocNCLmf
   N7mNi4SiZhA4w2WXbdeW8FRWzohvSm5nm2lskW5Kkdiq7rSyARoGz5aEJ
   9SXxrp0N9RjZnqDzFBoXcyeH1xZe/TTcoGdvh3LgI4f+RICtGozwbKxOt
   /paMFnNDvYg4zzxEaNGUePZAuZvdqbYVe7LkIhf2rGJEvOAvl6uy0ZM4U
   dorApyA0zKRakca9EPPx4swUoOOdjoEIiYXC+vlgKjbVGppRde6sgkuV7
   g==;
X-CSE-ConnectionGUID: L6YL9xvuTHGtONELHZe8lQ==
X-CSE-MsgGUID: ke7BsIi1Q3S9fP6ZMAg3pA==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="13170253"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="13170253"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 06:29:59 -0700
X-CSE-ConnectionGUID: eEfZ/s4YTjKDZt67vv+SUQ==
X-CSE-MsgGUID: zrWoLhGvReOkMmtvp2WPcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="99317550"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.2])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 06:29:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 23 Aug 2024 16:29:52 +0300 (EEST)
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
cc: Tero Kristo <tero.kristo@linux.intel.com>, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] platform/x86/intel-uncore-freq: Add efficiency
 latency control to sysfs interface
In-Reply-To: <863beeab7f6ecf36796394c75e95fc7a0396a862.camel@linux.intel.com>
Message-ID: <6adc07a2-14bc-6910-5d51-a0f68fc8ef46@linux.intel.com>
References: <20240821131321.824326-1-tero.kristo@linux.intel.com>  <20240821131321.824326-4-tero.kristo@linux.intel.com>  <4cf8d691-d00c-3603-6722-06394f00bdfc@linux.intel.com> <863beeab7f6ecf36796394c75e95fc7a0396a862.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2110916037-1724419792=:2230"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2110916037-1724419792=:2230
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 23 Aug 2024, srinivas pandruvada wrote:
> On Fri, 2024-08-23 at 16:03 +0300, Ilpo J=C3=A4rvinen wrote:
> > On Wed, 21 Aug 2024, Tero Kristo wrote:
> >=20
> > > Add the TPMI efficiency latency control fields to the sysfs
> > > interface.
> > > The sysfs files are mapped to the TPMI uncore driver via the
> > > registered
> > > uncore_read and uncore_write driver callbacks. These fields are not
> > > populated on older non TPMI hardware.
> > >=20
> > > Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> > > ---
> > > =C2=A0.../uncore-frequency-common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 42
> > > ++++++++++++++++---
> > > =C2=A0.../uncore-frequency-common.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 13 +++++-
> > > =C2=A02 files changed, 49 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-
> > > frequency-common.c b/drivers/platform/x86/intel/uncore-
> > > frequency/uncore-frequency-common.c
> > > index 4e880585cbe4..e22b683a7a43 100644
> > > --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-
> > > common.c
> > > +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-
> > > common.c
> > > @@ -60,11 +60,16 @@ static ssize_t show_attr(struct uncore_data
> > > *data, char *buf, enum uncore_index
> > > =C2=A0static ssize_t store_attr(struct uncore_data *data, const char
> > > *buf, ssize_t count,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 enum uncore_index index)
> > > =C2=A0{
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int input;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int input =3D 0;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > > =C2=A0
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (kstrtouint(buf, 10, &i=
nput))
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (index =3D=3D
> > > UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (kstrtobool(buf, (bool *)&input))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret=
urn -EINVAL;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (kstrtouint(buf, 10, &input))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret=
urn -EINVAL;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&uncore_lo=
ck);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D uncore_write(=
data, input, index);
> > > @@ -103,6 +108,18 @@ show_uncore_attr(max_freq_khz,
> > > UNCORE_INDEX_MAX_FREQ);
> > > =C2=A0
> > > =C2=A0show_uncore_attr(current_freq_khz, UNCORE_INDEX_CURRENT_FREQ);
> > > =C2=A0
> > > +store_uncore_attr(elc_low_threshold_percent,
> > > UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD);
> > > +store_uncore_attr(elc_high_threshold_percent,
> > > UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD);
> > > +store_uncore_attr(elc_high_threshold_enable,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENA=
BLE);
> > > +store_uncore_attr(elc_floor_freq_khz,
> > > UNCORE_INDEX_EFF_LAT_CTRL_FREQ);
> > > +
> > > +show_uncore_attr(elc_low_threshold_percent,
> > > UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD);
> > > +show_uncore_attr(elc_high_threshold_percent,
> > > UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD);
> > > +show_uncore_attr(elc_high_threshold_enable,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE);
> > > +show_uncore_attr(elc_floor_freq_khz,
> > > UNCORE_INDEX_EFF_LAT_CTRL_FREQ);
> > > +
> > > =C2=A0#define
> > > show_uncore_data(member_name)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0\
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0static ssize_t show_#=
#member_name(struct kobject *kobj,=C2=A0\
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct kobj_attribute
> > > *attr, char *buf)\
> > > @@ -146,7 +163,8 @@ show_uncore_data(initial_max_freq_khz);
> > > =C2=A0
> > > =C2=A0static int create_attr_group(struct uncore_data *data, char *na=
me)
> > > =C2=A0{
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret, freq, index =3D 0=
;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret, index =3D 0;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int val;
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0init_attribute_rw(max=
_freq_khz);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0init_attribute_rw(min=
_freq_khz);
> > > @@ -168,10 +186,24 @@ static int create_attr_group(struct
> > > uncore_data *data, char *name)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data->uncore_attrs[in=
dex++] =3D &data-
> > > >initial_min_freq_khz_kobj_attr.attr;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data->uncore_attrs[in=
dex++] =3D &data-
> > > >initial_max_freq_khz_kobj_attr.attr;
> > > =C2=A0
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D uncore_read(data, =
&freq, UNCORE_INDEX_CURRENT_FREQ);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D uncore_read(data, =
&val, UNCORE_INDEX_CURRENT_FREQ);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ret)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0data->uncore_attrs[index++] =3D &data-
> > > >current_freq_khz_kobj_attr.attr;
> > > =C2=A0
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D uncore_read(data, =
&val,
> > > UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ret) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0init_attribute_rw(elc_low_threshold_percent);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0init_attribute_rw(elc_high_threshold_percent);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0init_attribute_rw(elc_high_threshold_enable);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0init_attribute_rw(elc_floor_freq_khz);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0data->uncore_attrs[index++] =3D &data-
> > > >elc_low_threshold_percent_kobj_attr.attr;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0data->uncore_attrs[index++] =3D &data-
> > > >elc_high_threshold_percent_kobj_attr.attr;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0data->uncore_attrs[index++] =3D
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&da=
ta-
> > > >elc_high_threshold_enable_kobj_attr.attr;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0data->uncore_attrs[index++] =3D &data-
> > > >elc_floor_freq_khz_kobj_attr.attr;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> >=20
> > Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> >=20
> > But I have to say I'm not big fan of this function treating any error
> > as=20
> > an implicit indication of ELC not supported.
>
> Also there is a check for version number, which supports ELC.

AFAICT, the version number check is not on the path that is called from=20
create_attr_group().

The version number check is in uncore_probe() which then propagates this=20
knowledge into read/write_eff_lat_ctrl() using ->elc_supported.

> So this
> condition will never be true unless some IO read failure.

So are you saying ->elc_supported check is not required (added by patch=20
2)? It return -EOPNOTSUPP not because of an "IO read failure"??

> > Is that even going to be true after this:
> >=20
> > =C2=A0
> > https://patchwork.kernel.org/project/platform-driver-x86/patch/20240820=
204558.1296319-1-srinivas.pandruvada@linux.intel.com/
> >=20
> > ...as root_domain is eliminated for other reasons than ELC=20
> > supported/not-supported (-ENODATA return path)?
>
> Even if ELC is not supported, but all others fields will always be
> supported from base version. The above change doesn't do anything with
> root domain.

??

read/write_eff_lat_ctrl() check for ->root_domain and return -ENODATA
if it is true. If that patch from you I linked above is applied, this line=
=20
won't execute on some systems:

=09tpmi_uncore->root_cluster.root_domain =3D true;

Will that cause an issue (for read/write_eff_lat_ctrl())?

My concern here is that misusing error values like this to do=20
supported/not-supported check leads to fragility that would not occur
if errors would be treated as hard errors and supported is checked by=20
other means (which would be easy here using ->elc_supported, AFAICT).

--=20
 i.

--8323328-2110916037-1724419792=:2230--

