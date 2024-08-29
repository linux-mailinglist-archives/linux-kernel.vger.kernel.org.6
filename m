Return-Path: <linux-kernel+bounces-306483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 483A1963FA0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FC3AB22D85
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EA218CBFD;
	Thu, 29 Aug 2024 09:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CnDll4y5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FE0219E0;
	Thu, 29 Aug 2024 09:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724922867; cv=none; b=InLROD6H5ZPfd/myxZrjWBiNPMuRqHSTs+67neaaNKUfHHz1Y7serSluIMQ+wbYkG6rMWLNWA8X0UMolxdsoiTqKf/bs0H/rH/aZAne+nVEI8H3EHDsy0rz7ciSda86YiYGAx9XKv8RT5UycSWVkVqZRAO3npYyCtCnRXiO94gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724922867; c=relaxed/simple;
	bh=MIucME3XFCXsnzBhP7FlwveOTqx5FsNFuqAvEHh3UDE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HOOg7inr4wPMq0wwaEn+yRIUd/Z3jIDZ/UhPYHC0ZGRDZDiC13bI2XR//QGDS8frQPKzFbjykZgWybBK+OW/Jxkv8PrS8hj1QMYaTWlkdYux5LbwS85j+12MseNnrHZ8CQedn2YvWXQi6khHNeiYhjoUTsJR6jP4prV8rMBOmxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CnDll4y5; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724922865; x=1756458865;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MIucME3XFCXsnzBhP7FlwveOTqx5FsNFuqAvEHh3UDE=;
  b=CnDll4y5GihHccJtD9/exmvIblANo02mzPCJBDNNrd5NV7u1kEXzp4Jb
   GdKY8nmpVAGMsa78dXpYJQRGzk/HMfT5vqzK13QYKnYIdnZkcObC/VC4H
   h8dWeDd3ilcxk/X4YWOgJ2ktMv5Aj1cohjmAwARvxPF87V3t3KHEMDPc0
   kO6iTY2CenZenCuISc5QrKtfP/6U0CPUvW2e3lIZB1hNsyZ7qwsEIquSz
   pTOsvlbbnBN4xUl347cqZQ8dMC6j8+UTldc7gE/fm9CZhwlg3MqzydLrd
   yINGFUhx3YBSdEJOOKHaAr7VXNb+7kd0tyquRgJW4ZHKSYN41hitLpus3
   A==;
X-CSE-ConnectionGUID: ztH2MmWKRqu8BMF/56Me6Q==
X-CSE-MsgGUID: g4kZhM6ATDSta7yy2y5xow==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="26401239"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="26401239"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 02:14:24 -0700
X-CSE-ConnectionGUID: vo80wCHYScO5Rfw0u/NZeg==
X-CSE-MsgGUID: Fb3GwusgR922JNAfKf/Acw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="67885617"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.59])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 02:14:22 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 29 Aug 2024 12:14:18 +0300 (EEST)
To: Tero Kristo <tero.kristo@linux.intel.com>
cc: Hans de Goede <hdegoede@redhat.com>, srinivas.pandruvada@linux.intel.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] platform/x86/intel-uncore-freq: Add support for
 efficiency latency control
In-Reply-To: <20240828153657.1296410-3-tero.kristo@linux.intel.com>
Message-ID: <14a0bfc9-fdbf-660c-f842-40ae82a2fc0e@linux.intel.com>
References: <20240828153657.1296410-1-tero.kristo@linux.intel.com> <20240828153657.1296410-3-tero.kristo@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-22318661-1724922858=:1289"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-22318661-1724922858=:1289
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 28 Aug 2024, Tero Kristo wrote:

> Add efficiency latency control support to the TPMI uncore driver. This
> defines two new threshold values for controlling uncore frequency, low
> threshold and high threshold. When CPU utilization is below low threshold=
,
> the user configurable floor latency control frequency can be used by the
> system. When CPU utilization is above high threshold, the uncore frequenc=
y
> is increased in 100MHz steps until power limit is reached.
>=20
> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> ---
> v2:
>   * Converted a long sequence of if (...)'s to a switch
>=20
>  .../uncore-frequency-common.h                 |   4 +
>  .../uncore-frequency/uncore-frequency-tpmi.c  | 158 +++++++++++++++++-
>  2 files changed, 160 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency=
-common.h b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-co=
mmon.h
> index 4c245b945e4e..b5c7311bfa05 100644
> --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common=
=2Eh
> +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common=
=2Eh
> @@ -70,6 +70,10 @@ enum uncore_index {
>  =09UNCORE_INDEX_MIN_FREQ,
>  =09UNCORE_INDEX_MAX_FREQ,
>  =09UNCORE_INDEX_CURRENT_FREQ,
> +=09UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD,
> +=09UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD,
> +=09UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE,
> +=09UNCORE_INDEX_EFF_LAT_CTRL_FREQ,
>  };
> =20
>  int uncore_freq_common_init(int (*read)(struct uncore_data *data, unsign=
ed int *value,
> diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency=
-tpmi.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi=
=2Ec
> index 9fa3037c03d1..50b28b4b1fc0 100644
> --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
> +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
> @@ -30,6 +30,7 @@
> =20
>  #define=09UNCORE_MAJOR_VERSION=09=090
>  #define=09UNCORE_MINOR_VERSION=09=092
> +#define UNCORE_ELC_SUPPORTED_VERSION=092
>  #define UNCORE_HEADER_INDEX=09=090
>  #define UNCORE_FABRIC_CLUSTER_OFFSET=098
> =20
> @@ -46,6 +47,7 @@ struct tpmi_uncore_struct;
>  /* Information for each cluster */
>  struct tpmi_uncore_cluster_info {
>  =09bool root_domain;
> +=09bool elc_supported;
>  =09u8 __iomem *cluster_base;
>  =09struct uncore_data uncore_data;
>  =09struct tpmi_uncore_struct *uncore_root;
> @@ -75,6 +77,10 @@ struct tpmi_uncore_struct {
>  /* Bit definitions for CONTROL register */
>  #define UNCORE_MAX_RATIO_MASK=09=09=09=09GENMASK_ULL(14, 8)
>  #define UNCORE_MIN_RATIO_MASK=09=09=09=09GENMASK_ULL(21, 15)
> +#define UNCORE_EFF_LAT_CTRL_RATIO_MASK=09=09=09GENMASK_ULL(28, 22)
> +#define UNCORE_EFF_LAT_CTRL_LOW_THRESHOLD_MASK=09=09GENMASK_ULL(38, 32)
> +#define UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE=09BIT(39)
> +#define UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_MASK=09=09GENMASK_ULL(46, 40)
> =20
>  /* Helper function to read MMIO offset for max/min control frequency */
>  static void read_control_freq(struct tpmi_uncore_cluster_info *cluster_i=
nfo,
> @@ -89,6 +95,48 @@ static void read_control_freq(struct tpmi_uncore_clust=
er_info *cluster_info,
>  =09=09*value =3D FIELD_GET(UNCORE_MIN_RATIO_MASK, control) * UNCORE_FREQ=
_KHZ_MULTIPLIER;
>  }
> =20
> +/* Helper function to read efficiency latency control values over MMIO *=
/
> +static int read_eff_lat_ctrl(struct uncore_data *data, unsigned int *val=
, enum uncore_index index)
> +{
> +=09struct tpmi_uncore_cluster_info *cluster_info;
> +=09u64 ctrl;
> +
> +=09cluster_info =3D container_of(data, struct tpmi_uncore_cluster_info, =
uncore_data);
> +=09if (cluster_info->root_domain)
> +=09=09return -ENODATA;
> +
> +=09if (!cluster_info->elc_supported)
> +=09=09return -EOPNOTSUPP;
> +
> +=09ctrl =3D readq(cluster_info->cluster_base + UNCORE_CONTROL_INDEX);
> +
> +=09switch (index) {
> +=09case UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD:
> +=09=09*val =3D FIELD_GET(UNCORE_EFF_LAT_CTRL_LOW_THRESHOLD_MASK, ctrl);
> +=09=09*val *=3D 100;
> +=09=09*val =3D DIV_ROUND_UP(*val, FIELD_MAX(UNCORE_EFF_LAT_CTRL_LOW_THRE=
SHOLD_MASK));
> +=09=09break;
> +
> +=09case UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD:
> +=09=09*val =3D FIELD_GET(UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_MASK, ctrl);
> +=09=09*val *=3D 100;
> +=09=09*val =3D DIV_ROUND_UP(*val, FIELD_MAX(UNCORE_EFF_LAT_CTRL_HIGH_THR=
ESHOLD_MASK));

I wonder if DIV_ROUND_CLOSEST() would be more appropriate in these two=20
cases, rounding up isn't well justified as I think this wants to round it=
=20
back to the original number to deal with the minor divergences due to=20
precision loss during conversions?

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> +=09=09break;
> +
> +=09case UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE:
> +=09=09*val =3D FIELD_GET(UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE, ctrl=
);
> +=09=09break;
> +=09case UNCORE_INDEX_EFF_LAT_CTRL_FREQ:
> +=09=09*val =3D FIELD_GET(UNCORE_EFF_LAT_CTRL_RATIO_MASK, ctrl) * UNCORE_=
FREQ_KHZ_MULTIPLIER;
> +=09=09break;
> +
> +=09default:
> +=09=09return -EOPNOTSUPP;
> +=09}
> +
> +=09return 0;
> +}
> +
>  #define UNCORE_MAX_RATIO=09FIELD_MAX(UNCORE_MAX_RATIO_MASK)
> =20
>  /* Helper for sysfs read for max/min frequencies. Called under mutex loc=
ks */
> @@ -137,6 +185,82 @@ static int uncore_read_control_freq(struct uncore_da=
ta *data, unsigned int *valu
>  =09return 0;
>  }
> =20
> +/* Helper function for writing efficiency latency control values over MM=
IO */
> +static int write_eff_lat_ctrl(struct uncore_data *data, unsigned int val=
, enum uncore_index index)
> +{
> +=09struct tpmi_uncore_cluster_info *cluster_info;
> +=09u64 control;
> +
> +=09cluster_info =3D container_of(data, struct tpmi_uncore_cluster_info, =
uncore_data);
> +
> +=09if (cluster_info->root_domain)
> +=09=09return -ENODATA;
> +
> +=09if (!cluster_info->elc_supported)
> +=09=09return -EOPNOTSUPP;
> +
> +=09switch (index) {
> +=09case UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD:
> +=09=09if (val > 100)
> +=09=09=09return -EINVAL;
> +=09=09break;
> +
> +=09case UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD:
> +=09=09if (val > 100)
> +=09=09=09return -EINVAL;
> +=09=09break;
> +
> +=09case UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE:
> +=09=09if (val > 1)
> +=09=09=09return -EINVAL;
> +=09=09break;
> +
> +=09case UNCORE_INDEX_EFF_LAT_CTRL_FREQ:
> +=09=09val /=3D UNCORE_FREQ_KHZ_MULTIPLIER;
> +=09=09if (val > FIELD_MAX(UNCORE_EFF_LAT_CTRL_RATIO_MASK))
> +=09=09=09return -EINVAL;
> +=09=09break;
> +
> +=09default:
> +=09=09return -EOPNOTSUPP;
> +=09}
> +
> +=09control =3D readq(cluster_info->cluster_base + UNCORE_CONTROL_INDEX);
> +
> +=09switch (index) {
> +=09case UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD:
> +=09=09val *=3D FIELD_MAX(UNCORE_EFF_LAT_CTRL_LOW_THRESHOLD_MASK);
> +=09=09val /=3D 100;
> +=09=09control &=3D ~UNCORE_EFF_LAT_CTRL_LOW_THRESHOLD_MASK;
> +=09=09control |=3D FIELD_PREP(UNCORE_EFF_LAT_CTRL_LOW_THRESHOLD_MASK, va=
l);
> +=09=09break;
> +
> +=09case UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD:
> +=09=09val *=3D FIELD_MAX(UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_MASK);
> +=09=09val /=3D 100;
> +=09=09control &=3D ~UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_MASK;
> +=09=09control |=3D FIELD_PREP(UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_MASK, v=
al);
> +=09=09break;
> +
> +=09case UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE:
> +=09=09control &=3D ~UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE;
> +=09=09control |=3D FIELD_PREP(UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE,=
 val);
> +=09=09break;
> +
> +=09case UNCORE_INDEX_EFF_LAT_CTRL_FREQ:
> +=09=09control &=3D ~UNCORE_EFF_LAT_CTRL_RATIO_MASK;
> +=09=09control |=3D FIELD_PREP(UNCORE_EFF_LAT_CTRL_RATIO_MASK, val);
> +=09=09break;
> +
> +=09default:
> +=09=09break;
> +=09}
> +
> +=09writeq(control, cluster_info->cluster_base + UNCORE_CONTROL_INDEX);
> +
> +=09return 0;
> +}
> +
>  /* Helper function to write MMIO offset for max/min control frequency */
>  static void write_control_freq(struct tpmi_uncore_cluster_info *cluster_=
info, unsigned int input,
>  =09=09=09      unsigned int index)
> @@ -156,7 +280,7 @@ static void write_control_freq(struct tpmi_uncore_clu=
ster_info *cluster_info, un
>  =09writeq(control, (cluster_info->cluster_base + UNCORE_CONTROL_INDEX));
>  }
> =20
> -/* Callback for sysfs write for max/min frequencies. Called under mutex =
locks */
> +/* Helper for sysfs write for max/min frequencies. Called under mutex lo=
cks */
>  static int uncore_write_control_freq(struct uncore_data *data, unsigned =
int input,
>  =09=09=09=09     enum uncore_index index)
>  {
> @@ -234,6 +358,33 @@ static int uncore_read(struct uncore_data *data, uns=
igned int *value, enum uncor
>  =09case UNCORE_INDEX_CURRENT_FREQ:
>  =09=09return uncore_read_freq(data, value);
> =20
> +=09case UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD:
> +=09case UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD:
> +=09case UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE:
> +=09case UNCORE_INDEX_EFF_LAT_CTRL_FREQ:
> +=09=09return read_eff_lat_ctrl(data, value, index);
> +
> +=09default:
> +=09=09break;
> +=09}
> +
> +=09return -EOPNOTSUPP;
> +}
> +
> +/* Callback for sysfs write for TPMI uncore data. Called under mutex loc=
ks. */
> +static int uncore_write(struct uncore_data *data, unsigned int value, en=
um uncore_index index)
> +{
> +=09switch (index) {
> +=09case UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD:
> +=09case UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD:
> +=09case UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE:
> +=09case UNCORE_INDEX_EFF_LAT_CTRL_FREQ:
> +=09=09return write_eff_lat_ctrl(data, value, index);
> +
> +=09case UNCORE_INDEX_MIN_FREQ:
> +=09case UNCORE_INDEX_MAX_FREQ:
> +=09=09return uncore_write_control_freq(data, value, index);
> +
>  =09default:
>  =09=09break;
>  =09}
> @@ -291,7 +442,7 @@ static int uncore_probe(struct auxiliary_device *auxd=
ev, const struct auxiliary_
>  =09=09return -EINVAL;
> =20
>  =09/* Register callbacks to uncore core */
> -=09ret =3D uncore_freq_common_init(uncore_read, uncore_write_control_fre=
q);
> +=09ret =3D uncore_freq_common_init(uncore_read, uncore_write);
>  =09if (ret)
>  =09=09return ret;
> =20
> @@ -409,6 +560,9 @@ static int uncore_probe(struct auxiliary_device *auxd=
ev, const struct auxiliary_
> =20
>  =09=09=09cluster_info->uncore_root =3D tpmi_uncore;
> =20
> +=09=09=09if (TPMI_MINOR_VERSION(pd_info->ufs_header_ver) >=3D UNCORE_ELC=
_SUPPORTED_VERSION)
> +=09=09=09=09cluster_info->elc_supported =3D true;
> +
>  =09=09=09ret =3D uncore_freq_add_entry(&cluster_info->uncore_data, 0);
>  =09=09=09if (ret) {
>  =09=09=09=09cluster_info->cluster_base =3D NULL;
>=20
--8323328-22318661-1724922858=:1289--

