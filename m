Return-Path: <linux-kernel+bounces-308178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A368996584E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D7E1C22FF1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEF9153BF9;
	Fri, 30 Aug 2024 07:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hmKpLiHT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8CE1509A0;
	Fri, 30 Aug 2024 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725002519; cv=none; b=g8WkRaP941m/AwIwKtWrJKKJiQUgq3CB8nciwEiUZrlppraFIcwOkfg8v+umF8Z+o7wSicbkXLAKYslTgfsxGc/9Sw4CyaYJ39O0IhXPcaxDk6zynqeRdCQx4oiou8C8+uwkiKf+n70l+fXCOdWH8Kd5Y71H3Z0IXli1u4m1y08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725002519; c=relaxed/simple;
	bh=Q17qs27gXm0WAy4uXxY+RKoXrFyT7/7kppEpeiqyuAU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bX8srigyWTQFbENZpWhf06YESlaUd8oOVPapReoCglLY6a50e2CB6zmTjPNY9IX8ITcjZIOJEcODHdWJ1cSUlLI0+U2QxLISPBRARLHLYf8rilH96+jAwz85e5JQlcGk2TYqdkdmwk0DkhIpFcZUQx7+GNtUGFA2d6255SCchTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hmKpLiHT; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725002517; x=1756538517;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Q17qs27gXm0WAy4uXxY+RKoXrFyT7/7kppEpeiqyuAU=;
  b=hmKpLiHTZEDwcVPfTHApZJoRf80SdtD+HJX7o5jGlaXBQ37OTLyOf+YE
   d4uMfRKoJpM3ATG6Av2So5EDHcKJ9cM8LmPHSIIkm6lRTg34dldSWN6d1
   iY+hGoxU/1i9+5YqM7RRdpDckmp+E83OzkOBwOJMZPCIB2xQ6A0BxrOJi
   28HrTZ+swKCtUCTWUMu0nFk4j3siXrEB4t62oag8qiQoBJYPvHYbg2rzW
   Bt2cfsYEkaCpLeIBWIU0Qyyh7P82VsMPVMpX+JbTWOZFTNHyO3IBk29Eu
   XcZibbmapPBBwM+LEYmAuU6aSb1nbMNq7uIvwV9sJPz7UrNNWZcV3skOv
   Q==;
X-CSE-ConnectionGUID: ie0bXW6FTSCm5/y3obVMUA==
X-CSE-MsgGUID: KiDuO46/SuWoyvi3gT1UTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23787859"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="23787859"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 00:21:57 -0700
X-CSE-ConnectionGUID: wX5S6WnSS46yo4UbxqCSbQ==
X-CSE-MsgGUID: XP/1OZj6TMiJoh26VlGZBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="63780789"
Received: from mwiniars-desk2.ger.corp.intel.com ([10.245.246.70])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 00:21:56 -0700
Message-ID: <5faa73b422ba9346f8542c3b88f3f0a1a00d8c22.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/3] platform/x86/intel-uncore-freq: Add support for
 efficiency latency control
From: Tero Kristo <tero.kristo@linux.intel.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 srinivas.pandruvada@linux.intel.com,  platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
Date: Fri, 30 Aug 2024 10:21:52 +0300
In-Reply-To: <14a0bfc9-fdbf-660c-f842-40ae82a2fc0e@linux.intel.com>
References: <20240828153657.1296410-1-tero.kristo@linux.intel.com>
	 <20240828153657.1296410-3-tero.kristo@linux.intel.com>
	 <14a0bfc9-fdbf-660c-f842-40ae82a2fc0e@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-29 at 12:14 +0300, Ilpo J=C3=A4rvinen wrote:
> On Wed, 28 Aug 2024, Tero Kristo wrote:
>=20
> > Add efficiency latency control support to the TPMI uncore driver.
> > This
> > defines two new threshold values for controlling uncore frequency,
> > low
> > threshold and high threshold. When CPU utilization is below low
> > threshold,
> > the user configurable floor latency control frequency can be used
> > by the
> > system. When CPU utilization is above high threshold, the uncore
> > frequency
> > is increased in 100MHz steps until power limit is reached.
> >=20
> > Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> > ---
> > v2:
> > =C2=A0 * Converted a long sequence of if (...)'s to a switch
> >=20
> > =C2=A0.../uncore-frequency-common.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
4 +
> > =C2=A0.../uncore-frequency/uncore-frequency-tpmi.c=C2=A0 | 158
> > +++++++++++++++++-
> > =C2=A02 files changed, 160 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-
> > frequency-common.h b/drivers/platform/x86/intel/uncore-
> > frequency/uncore-frequency-common.h
> > index 4c245b945e4e..b5c7311bfa05 100644
> > --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-
> > common.h
> > +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-
> > common.h
> > @@ -70,6 +70,10 @@ enum uncore_index {
> > =C2=A0	UNCORE_INDEX_MIN_FREQ,
> > =C2=A0	UNCORE_INDEX_MAX_FREQ,
> > =C2=A0	UNCORE_INDEX_CURRENT_FREQ,
> > +	UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD,
> > +	UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD,
> > +	UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE,
> > +	UNCORE_INDEX_EFF_LAT_CTRL_FREQ,
> > =C2=A0};
> > =C2=A0
> > =C2=A0int uncore_freq_common_init(int (*read)(struct uncore_data *data,
> > unsigned int *value,
> > diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-
> > frequency-tpmi.c b/drivers/platform/x86/intel/uncore-
> > frequency/uncore-frequency-tpmi.c
> > index 9fa3037c03d1..50b28b4b1fc0 100644
> > --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-
> > tpmi.c
> > +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-
> > tpmi.c
> > @@ -30,6 +30,7 @@
> > =C2=A0
> > =C2=A0#define	UNCORE_MAJOR_VERSION		0
> > =C2=A0#define	UNCORE_MINOR_VERSION		2
> > +#define UNCORE_ELC_SUPPORTED_VERSION	2
> > =C2=A0#define UNCORE_HEADER_INDEX		0
> > =C2=A0#define UNCORE_FABRIC_CLUSTER_OFFSET	8
> > =C2=A0
> > @@ -46,6 +47,7 @@ struct tpmi_uncore_struct;
> > =C2=A0/* Information for each cluster */
> > =C2=A0struct tpmi_uncore_cluster_info {
> > =C2=A0	bool root_domain;
> > +	bool elc_supported;
> > =C2=A0	u8 __iomem *cluster_base;
> > =C2=A0	struct uncore_data uncore_data;
> > =C2=A0	struct tpmi_uncore_struct *uncore_root;
> > @@ -75,6 +77,10 @@ struct tpmi_uncore_struct {
> > =C2=A0/* Bit definitions for CONTROL register */
> > =C2=A0#define
> > UNCORE_MAX_RATIO_MASK				GENMASK_ULL(14, 8)
> > =C2=A0#define
> > UNCORE_MIN_RATIO_MASK				GENMASK_ULL(21, 15)
> > +#define
> > UNCORE_EFF_LAT_CTRL_RATIO_MASK			GENMASK_ULL(28, 22)
> > +#define
> > UNCORE_EFF_LAT_CTRL_LOW_THRESHOLD_MASK		GENMASK_ULL(38, 32)
> > +#define UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE	BIT(39)
> > +#define
> > UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_MASK		GENMASK_ULL(46, 40)
> > =C2=A0
> > =C2=A0/* Helper function to read MMIO offset for max/min control
> > frequency */
> > =C2=A0static void read_control_freq(struct tpmi_uncore_cluster_info
> > *cluster_info,
> > @@ -89,6 +95,48 @@ static void read_control_freq(struct
> > tpmi_uncore_cluster_info *cluster_info,
> > =C2=A0		*value =3D FIELD_GET(UNCORE_MIN_RATIO_MASK, control)
> > * UNCORE_FREQ_KHZ_MULTIPLIER;
> > =C2=A0}
> > =C2=A0
> > +/* Helper function to read efficiency latency control values over
> > MMIO */
> > +static int read_eff_lat_ctrl(struct uncore_data *data, unsigned
> > int *val, enum uncore_index index)
> > +{
> > +	struct tpmi_uncore_cluster_info *cluster_info;
> > +	u64 ctrl;
> > +
> > +	cluster_info =3D container_of(data, struct
> > tpmi_uncore_cluster_info, uncore_data);
> > +	if (cluster_info->root_domain)
> > +		return -ENODATA;
> > +
> > +	if (!cluster_info->elc_supported)
> > +		return -EOPNOTSUPP;
> > +
> > +	ctrl =3D readq(cluster_info->cluster_base +
> > UNCORE_CONTROL_INDEX);
> > +
> > +	switch (index) {
> > +	case UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD:
> > +		*val =3D
> > FIELD_GET(UNCORE_EFF_LAT_CTRL_LOW_THRESHOLD_MASK, ctrl);
> > +		*val *=3D 100;
> > +		*val =3D DIV_ROUND_UP(*val,
> > FIELD_MAX(UNCORE_EFF_LAT_CTRL_LOW_THRESHOLD_MASK));
> > +		break;
> > +
> > +	case UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD:
> > +		*val =3D
> > FIELD_GET(UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_MASK, ctrl);
> > +		*val *=3D 100;
> > +		*val =3D DIV_ROUND_UP(*val,
> > FIELD_MAX(UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_MASK));
>=20
> I wonder if DIV_ROUND_CLOSEST() would be more appropriate in these
> two=20
> cases, rounding up isn't well justified as I think this wants to
> round it=20
> back to the original number to deal with the minor divergences due to
> precision loss during conversions?

Yes, this makes it sure that what is written to the file gets also read
back as the same value. Using DIV_ROUND_CLOSEST() will not do the
trick. Tried this out by using DIV_ROUND_CLOSEST() and got following:

# echo 94 > elc_high_threshold_percent=20
# cat elc_high_threshold_percent
94
# echo 95 > elc_high_threshold_percent=20
# cat elc_high_threshold_percent=20
94
# echo 96 > elc_high_threshold_percent=20
# cat elc_high_threshold_percent=20
95

However, using DIV_ROUND_UP() all values from 0-100 work just fine.

-Tero

>=20
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>=20


