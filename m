Return-Path: <linux-kernel+bounces-308521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00481965DFF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81CE41F2263F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592E717B516;
	Fri, 30 Aug 2024 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OLFHoqcf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DAE14C5A4;
	Fri, 30 Aug 2024 10:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012578; cv=none; b=ddQv0BEuNUVh3tbuCqVK9rxlij7AeIccODuTo8NG+S8bSYpBxsakcD4Z+zT78toPVUrdKjqN8mjQ2mrDicTA9eRQPikTvy5CXXm4XTa7Sc4fhKQXGnkhRT167FiUOyxa4slfrY3AyJQZlurIQT+yNMqPs9bF/XgGYfH9M9fjSCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012578; c=relaxed/simple;
	bh=62yW3Pg8hRKUON2SRC8CEJGhvkk5lfHWXyxtkFI9mlc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oV9y40pN2V7vCPWAzsSRw1KlT9kfio0Lkp1GwgZYE79+Edcez6tWmWPSyIalqbYytO2k2apa2vvmAT+tBjcFRmtFmcegnVdvYTOGyy1AHALDKqIXq+ULUa7ZhOxdQ0Db4QtvI3ZrjvH52+OakDuW1oqn4BJfhZiqOvFQvl1MZmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OLFHoqcf; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725012578; x=1756548578;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=62yW3Pg8hRKUON2SRC8CEJGhvkk5lfHWXyxtkFI9mlc=;
  b=OLFHoqcf4T51lSPwGoFOCjT0jB+k+RwdfQ74k3bR6hv4LoGaC23/iLB+
   Y4Dlzm5LDLdYDQHWGtdsPqMJ69inqFCJYZZ8R72rsgUVRkfHLFsWP8h6b
   USXcXJaR+/+afhiIrNL4HWiZsigkpdrrUB6a/iqYRV1v0X0oTLGSbd957
   VXSeC3JmS5al+dYqTzWY0GxOz+De+o+60uyHVkW689c2zgxqCRWSY9QiU
   Dep1PQ1LhmBNTrZOxr5exlO6zjRCxeBCxTwtb398PShgdFcKv7z07D5Zy
   hJLSewxWn3UIFzZr0utjzc690VClVve7A1HjubOgSQwmfyncf2UK5nria
   A==;
X-CSE-ConnectionGUID: Eq43sDHHRLinQALSbtbi0w==
X-CSE-MsgGUID: j+E+cq9oTpC8DNgL9fNJgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34807925"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="34807925"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 03:09:37 -0700
X-CSE-ConnectionGUID: PM/q0XSoSAu5yhX28TjaBw==
X-CSE-MsgGUID: RmUbyR79RjKYwEiYvbYhIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="64200857"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.174])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 03:09:33 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 30 Aug 2024 13:09:29 +0300 (EEST)
To: Tero Kristo <tero.kristo@linux.intel.com>
cc: Hans de Goede <hdegoede@redhat.com>, srinivas.pandruvada@linux.intel.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] platform/x86/intel-uncore-freq: Add support for
 efficiency latency control
In-Reply-To: <5faa73b422ba9346f8542c3b88f3f0a1a00d8c22.camel@linux.intel.com>
Message-ID: <f5bf69f5-be65-ffec-8ef0-e409f788aaa3@linux.intel.com>
References: <20240828153657.1296410-1-tero.kristo@linux.intel.com>  <20240828153657.1296410-3-tero.kristo@linux.intel.com>  <14a0bfc9-fdbf-660c-f842-40ae82a2fc0e@linux.intel.com> <5faa73b422ba9346f8542c3b88f3f0a1a00d8c22.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1523374286-1725012569=:1027"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1523374286-1725012569=:1027
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 30 Aug 2024, Tero Kristo wrote:

> On Thu, 2024-08-29 at 12:14 +0300, Ilpo J=C3=A4rvinen wrote:
> > On Wed, 28 Aug 2024, Tero Kristo wrote:
> >=20
> > > Add efficiency latency control support to the TPMI uncore driver.
> > > This
> > > defines two new threshold values for controlling uncore frequency,
> > > low
> > > threshold and high threshold. When CPU utilization is below low
> > > threshold,
> > > the user configurable floor latency control frequency can be used
> > > by the
> > > system. When CPU utilization is above high threshold, the uncore
> > > frequency
> > > is increased in 100MHz steps until power limit is reached.
> > >=20
> > > Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> > > ---
> > > v2:
> > > =C2=A0 * Converted a long sequence of if (...)'s to a switch
> > >=20
> > > =C2=A0.../uncore-frequency-common.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 4 +
> > > =C2=A0.../uncore-frequency/uncore-frequency-tpmi.c=C2=A0 | 158
> > > +++++++++++++++++-
> > > =C2=A02 files changed, 160 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-
> > > frequency-common.h b/drivers/platform/x86/intel/uncore-
> > > frequency/uncore-frequency-common.h
> > > index 4c245b945e4e..b5c7311bfa05 100644
> > > --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-
> > > common.h
> > > +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-
> > > common.h
> > > @@ -70,6 +70,10 @@ enum uncore_index {
> > > =C2=A0=09UNCORE_INDEX_MIN_FREQ,
> > > =C2=A0=09UNCORE_INDEX_MAX_FREQ,
> > > =C2=A0=09UNCORE_INDEX_CURRENT_FREQ,
> > > +=09UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD,
> > > +=09UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD,
> > > +=09UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE,
> > > +=09UNCORE_INDEX_EFF_LAT_CTRL_FREQ,
> > > =C2=A0};
> > > =C2=A0
> > > =C2=A0int uncore_freq_common_init(int (*read)(struct uncore_data *dat=
a,
> > > unsigned int *value,
> > > diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-
> > > frequency-tpmi.c b/drivers/platform/x86/intel/uncore-
> > > frequency/uncore-frequency-tpmi.c
> > > index 9fa3037c03d1..50b28b4b1fc0 100644
> > > --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-
> > > tpmi.c
> > > +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-
> > > tpmi.c
> > > @@ -30,6 +30,7 @@
> > > =C2=A0
> > > =C2=A0#define=09UNCORE_MAJOR_VERSION=09=090
> > > =C2=A0#define=09UNCORE_MINOR_VERSION=09=092
> > > +#define UNCORE_ELC_SUPPORTED_VERSION=092
> > > =C2=A0#define UNCORE_HEADER_INDEX=09=090
> > > =C2=A0#define UNCORE_FABRIC_CLUSTER_OFFSET=098
> > > =C2=A0
> > > @@ -46,6 +47,7 @@ struct tpmi_uncore_struct;
> > > =C2=A0/* Information for each cluster */
> > > =C2=A0struct tpmi_uncore_cluster_info {
> > > =C2=A0=09bool root_domain;
> > > +=09bool elc_supported;
> > > =C2=A0=09u8 __iomem *cluster_base;
> > > =C2=A0=09struct uncore_data uncore_data;
> > > =C2=A0=09struct tpmi_uncore_struct *uncore_root;
> > > @@ -75,6 +77,10 @@ struct tpmi_uncore_struct {
> > > =C2=A0/* Bit definitions for CONTROL register */
> > > =C2=A0#define
> > > UNCORE_MAX_RATIO_MASK=09=09=09=09GENMASK_ULL(14, 8)
> > > =C2=A0#define
> > > UNCORE_MIN_RATIO_MASK=09=09=09=09GENMASK_ULL(21, 15)
> > > +#define
> > > UNCORE_EFF_LAT_CTRL_RATIO_MASK=09=09=09GENMASK_ULL(28, 22)
> > > +#define
> > > UNCORE_EFF_LAT_CTRL_LOW_THRESHOLD_MASK=09=09GENMASK_ULL(38, 32)
> > > +#define UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE=09BIT(39)
> > > +#define
> > > UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_MASK=09=09GENMASK_ULL(46, 40)
> > > =C2=A0
> > > =C2=A0/* Helper function to read MMIO offset for max/min control
> > > frequency */
> > > =C2=A0static void read_control_freq(struct tpmi_uncore_cluster_info
> > > *cluster_info,
> > > @@ -89,6 +95,48 @@ static void read_control_freq(struct
> > > tpmi_uncore_cluster_info *cluster_info,
> > > =C2=A0=09=09*value =3D FIELD_GET(UNCORE_MIN_RATIO_MASK, control)
> > > * UNCORE_FREQ_KHZ_MULTIPLIER;
> > > =C2=A0}
> > > =C2=A0
> > > +/* Helper function to read efficiency latency control values over
> > > MMIO */
> > > +static int read_eff_lat_ctrl(struct uncore_data *data, unsigned
> > > int *val, enum uncore_index index)
> > > +{
> > > +=09struct tpmi_uncore_cluster_info *cluster_info;
> > > +=09u64 ctrl;
> > > +
> > > +=09cluster_info =3D container_of(data, struct
> > > tpmi_uncore_cluster_info, uncore_data);
> > > +=09if (cluster_info->root_domain)
> > > +=09=09return -ENODATA;
> > > +
> > > +=09if (!cluster_info->elc_supported)
> > > +=09=09return -EOPNOTSUPP;
> > > +
> > > +=09ctrl =3D readq(cluster_info->cluster_base +
> > > UNCORE_CONTROL_INDEX);
> > > +
> > > +=09switch (index) {
> > > +=09case UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD:
> > > +=09=09*val =3D
> > > FIELD_GET(UNCORE_EFF_LAT_CTRL_LOW_THRESHOLD_MASK, ctrl);
> > > +=09=09*val *=3D 100;
> > > +=09=09*val =3D DIV_ROUND_UP(*val,
> > > FIELD_MAX(UNCORE_EFF_LAT_CTRL_LOW_THRESHOLD_MASK));
> > > +=09=09break;
> > > +
> > > +=09case UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD:
> > > +=09=09*val =3D
> > > FIELD_GET(UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_MASK, ctrl);
> > > +=09=09*val *=3D 100;
> > > +=09=09*val =3D DIV_ROUND_UP(*val,
> > > FIELD_MAX(UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_MASK));
> >=20
> > I wonder if DIV_ROUND_CLOSEST() would be more appropriate in these
> > two=20
> > cases, rounding up isn't well justified as I think this wants to
> > round it=20
> > back to the original number to deal with the minor divergences due to
> > precision loss during conversions?
>=20
> Yes, this makes it sure that what is written to the file gets also read
> back as the same value. Using DIV_ROUND_CLOSEST() will not do the
> trick. Tried this out by using DIV_ROUND_CLOSEST() and got following:
>=20
> # echo 94 > elc_high_threshold_percent=20
> # cat elc_high_threshold_percent
> 94
> # echo 95 > elc_high_threshold_percent=20
> # cat elc_high_threshold_percent=20
> 94
> # echo 96 > elc_high_threshold_percent=20
> # cat elc_high_threshold_percent=20
> 95
>=20
> However, using DIV_ROUND_UP() all values from 0-100 work just fine.

Okay, thanks for checking this out.

--=20
 i.

--8323328-1523374286-1725012569=:1027--

