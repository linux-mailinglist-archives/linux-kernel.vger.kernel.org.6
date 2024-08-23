Return-Path: <linux-kernel+bounces-298910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEAA95CD1B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4381A282E92
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDA91862B9;
	Fri, 23 Aug 2024 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HVok9p74"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C881448E3;
	Fri, 23 Aug 2024 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724418201; cv=none; b=d22puWJhomoFUObNIyb0Polf9L/Bjh6qckgX7bdRVCt4rDuGGuuwgQ206lGcuQIjkhv/W+M0ag29XoRfTjNVasl+4/HmZ6wbVOLUKBk3T14oBdtGOV6oBMsNdLMlGTJ6sSqid7QQL3BSTFwOPbVE92zQRmuc/I+FC2+zmiFtIcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724418201; c=relaxed/simple;
	bh=kftPDIMou2j2K+rX+hqfHFHLY9B1r/w2V+XY9ebi6Ik=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uLW/uHBSJn4IhzemTOhluwLFX93Dy7VZ+LHSqx/mBrJRLRrRE1mqWEa0Uu0+NIiSPNLZT2VWS+KmY7nRuN6mbiSKV/Tv1SVxUAINYORPYgl8m8zrEJV+vNfS/CNOHe5Rmmm3cgwmashNSifkfLv0JPiKTfstvP1h5a+iYwHqm3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HVok9p74; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724418200; x=1755954200;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kftPDIMou2j2K+rX+hqfHFHLY9B1r/w2V+XY9ebi6Ik=;
  b=HVok9p745i+ohqjxavg8UWL9cSB0lrE3tg8AnasAF9k8zMB0DdysjIm2
   vEOrwLYKq06GW5DaHkLHaw4l1L6ln801eVKYlfgSPjCRkENiJlaOcvM5z
   BoPKlBf7y+bDcAILHvKXtfp3YI35b02jo0XKr6mw03QQSK2J5w2AjL4jy
   4K2wLnZoSfWwO1lRyOXN/rap64HfgpxCul83IyJwTNyM9FDdICm0FcrK6
   DP7lQ9o0BiwRqeALVltnBMGZd8ogZ/ioGZHgIt5nGiA2h+RUkCO9hx8eM
   3x8jt4WjeDeKED/cI18F3nijehu6msFs2G13IH1kwWRI/Ip5PlBnZm5GH
   Q==;
X-CSE-ConnectionGUID: VuuKUXQOTcSR04bq/4sjmQ==
X-CSE-MsgGUID: 3ysZ16UOT5+BNG0mDgboQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="23067641"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="23067641"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 06:03:19 -0700
X-CSE-ConnectionGUID: vndR6h0URo2bn8zQZWaY7Q==
X-CSE-MsgGUID: paIPwhL1SuyF/Qy62KEuQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="92583856"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.2])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 06:03:17 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 23 Aug 2024 16:03:13 +0300 (EEST)
To: Tero Kristo <tero.kristo@linux.intel.com>
cc: srinivas.pandruvada@linux.intel.com, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] platform/x86/intel-uncore-freq: Add efficiency
 latency control to sysfs interface
In-Reply-To: <20240821131321.824326-4-tero.kristo@linux.intel.com>
Message-ID: <4cf8d691-d00c-3603-6722-06394f00bdfc@linux.intel.com>
References: <20240821131321.824326-1-tero.kristo@linux.intel.com> <20240821131321.824326-4-tero.kristo@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1768064745-1724418193=:2230"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1768064745-1724418193=:2230
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 21 Aug 2024, Tero Kristo wrote:

> Add the TPMI efficiency latency control fields to the sysfs interface.
> The sysfs files are mapped to the TPMI uncore driver via the registered
> uncore_read and uncore_write driver callbacks. These fields are not
> populated on older non TPMI hardware.
>=20
> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> ---
>  .../uncore-frequency-common.c                 | 42 ++++++++++++++++---
>  .../uncore-frequency-common.h                 | 13 +++++-
>  2 files changed, 49 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency=
-common.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-co=
mmon.c
> index 4e880585cbe4..e22b683a7a43 100644
> --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common=
=2Ec
> +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common=
=2Ec
> @@ -60,11 +60,16 @@ static ssize_t show_attr(struct uncore_data *data, ch=
ar *buf, enum uncore_index
>  static ssize_t store_attr(struct uncore_data *data, const char *buf, ssi=
ze_t count,
>  =09=09=09  enum uncore_index index)
>  {
> -=09unsigned int input;
> +=09unsigned int input =3D 0;
>  =09int ret;
> =20
> -=09if (kstrtouint(buf, 10, &input))
> -=09=09return -EINVAL;
> +=09if (index =3D=3D UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE) {
> +=09=09if (kstrtobool(buf, (bool *)&input))
> +=09=09=09return -EINVAL;
> +=09} else {
> +=09=09if (kstrtouint(buf, 10, &input))
> +=09=09=09return -EINVAL;
> +=09}
> =20
>  =09mutex_lock(&uncore_lock);
>  =09ret =3D uncore_write(data, input, index);
> @@ -103,6 +108,18 @@ show_uncore_attr(max_freq_khz, UNCORE_INDEX_MAX_FREQ=
);
> =20
>  show_uncore_attr(current_freq_khz, UNCORE_INDEX_CURRENT_FREQ);
> =20
> +store_uncore_attr(elc_low_threshold_percent, UNCORE_INDEX_EFF_LAT_CTRL_L=
OW_THRESHOLD);
> +store_uncore_attr(elc_high_threshold_percent, UNCORE_INDEX_EFF_LAT_CTRL_=
HIGH_THRESHOLD);
> +store_uncore_attr(elc_high_threshold_enable,
> +=09=09  UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE);
> +store_uncore_attr(elc_floor_freq_khz, UNCORE_INDEX_EFF_LAT_CTRL_FREQ);
> +
> +show_uncore_attr(elc_low_threshold_percent, UNCORE_INDEX_EFF_LAT_CTRL_LO=
W_THRESHOLD);
> +show_uncore_attr(elc_high_threshold_percent, UNCORE_INDEX_EFF_LAT_CTRL_H=
IGH_THRESHOLD);
> +show_uncore_attr(elc_high_threshold_enable,
> +=09=09 UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE);
> +show_uncore_attr(elc_floor_freq_khz, UNCORE_INDEX_EFF_LAT_CTRL_FREQ);
> +
>  #define show_uncore_data(member_name)=09=09=09=09=09\
>  =09static ssize_t show_##member_name(struct kobject *kobj,=09\
>  =09=09=09=09=09   struct kobj_attribute *attr, char *buf)\
> @@ -146,7 +163,8 @@ show_uncore_data(initial_max_freq_khz);
> =20
>  static int create_attr_group(struct uncore_data *data, char *name)
>  {
> -=09int ret, freq, index =3D 0;
> +=09int ret, index =3D 0;
> +=09unsigned int val;
> =20
>  =09init_attribute_rw(max_freq_khz);
>  =09init_attribute_rw(min_freq_khz);
> @@ -168,10 +186,24 @@ static int create_attr_group(struct uncore_data *da=
ta, char *name)
>  =09data->uncore_attrs[index++] =3D &data->initial_min_freq_khz_kobj_attr=
=2Eattr;
>  =09data->uncore_attrs[index++] =3D &data->initial_max_freq_khz_kobj_attr=
=2Eattr;
> =20
> -=09ret =3D uncore_read(data, &freq, UNCORE_INDEX_CURRENT_FREQ);
> +=09ret =3D uncore_read(data, &val, UNCORE_INDEX_CURRENT_FREQ);
>  =09if (!ret)
>  =09=09data->uncore_attrs[index++] =3D &data->current_freq_khz_kobj_attr.=
attr;
> =20
> +=09ret =3D uncore_read(data, &val, UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHO=
LD);
> +=09if (!ret) {
> +=09=09init_attribute_rw(elc_low_threshold_percent);
> +=09=09init_attribute_rw(elc_high_threshold_percent);
> +=09=09init_attribute_rw(elc_high_threshold_enable);
> +=09=09init_attribute_rw(elc_floor_freq_khz);
> +
> +=09=09data->uncore_attrs[index++] =3D &data->elc_low_threshold_percent_k=
obj_attr.attr;
> +=09=09data->uncore_attrs[index++] =3D &data->elc_high_threshold_percent_=
kobj_attr.attr;
> +=09=09data->uncore_attrs[index++] =3D
> +=09=09=09&data->elc_high_threshold_enable_kobj_attr.attr;
> +=09=09data->uncore_attrs[index++] =3D &data->elc_floor_freq_khz_kobj_att=
r.attr;
> +=09}

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

But I have to say I'm not big fan of this function treating any error as=20
an implicit indication of ELC not supported.

Is that even going to be true after this:

  https://patchwork.kernel.org/project/platform-driver-x86/patch/2024082020=
4558.1296319-1-srinivas.pandruvada@linux.intel.com/

=2E..as root_domain is eliminated for other reasons than ELC=20
supported/not-supported (-ENODATA return path)?

--=20
 i.
--8323328-1768064745-1724418193=:2230--

