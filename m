Return-Path: <linux-kernel+bounces-301793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D285695F5A9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D6AFB21C0B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3185419413C;
	Mon, 26 Aug 2024 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a0wIp8ck"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE06849631;
	Mon, 26 Aug 2024 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687740; cv=none; b=IWDKMeJJmMcv2+o9RbnNvox/SHC497E8pmnBxmw3rnoIPnMb+UTCNtFiosotDIYinPGWJuFAyGd0saThbPRL1Szz5BeE7vO/bCUTrBlMKGveCZx8joR1EXRT+l4mz04yrxNnEL6fsdOmQ4vnL5ro/GGVfLF7b23PuR+i3XTcEVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687740; c=relaxed/simple;
	bh=PvUikjllUesVf4K5J6IbkegT/vKQ2ftQ6jz2QLk5nh8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B16OkboX5OJbMjB45NOQAY57FPRE/4bFTnCP6hHq79k5rL323osXykYe6SmYm6wmZTCpBBP0MlVlThxR63y3czTxaPnzYPaMkaAXr42o+3ERxOfNuCTMf5slH0WFobGipZvqpgaNS5qtVezGJP0tG+cDI4rRh8NVojV2Fl4WJ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a0wIp8ck; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724687738; x=1756223738;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version;
  bh=PvUikjllUesVf4K5J6IbkegT/vKQ2ftQ6jz2QLk5nh8=;
  b=a0wIp8ckH+sEMoa/dWKkdPZVuXhqb/MlSqc+HAZm9WnlVJbenpv43fkT
   RHY8va3BT+uD1l2em5ENzMSf7bkzCML2jKXN7TcI/E1MkuYlwVeN+GulR
   7LVeX9M8uFyRemH697MXB0gi0XfhtGe8xkS0E9KBzLpY5ud/3AB75p5QH
   CkB0qUuaqwB+JAsQmUibgHZa3RmCIFy4u6KDnK3skHzkvXOmlCFglCcXI
   u6bjlqExnFgfL9XLmwHZNaiWoT7M23mZHSSIPLefIKU99E3i1LmXWxoJj
   rNHrd/t9mcfgUUWK3waAMhUKXyZ3jTzq6CShMYZp9+gBp8HqaH3JH4Clq
   g==;
X-CSE-ConnectionGUID: faVgIvUYTfWNFDObIwPQBg==
X-CSE-MsgGUID: UpDYLju1Rh6K0bKj+MSgmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="22641780"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="diff'?scan'208";a="22641780"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 08:55:37 -0700
X-CSE-ConnectionGUID: rzfNeSbWQXOD4svLUTqR4g==
X-CSE-MsgGUID: iXARGO0eR8SLXLwhgn/qMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="diff'?scan'208";a="93352318"
Received: from djiang5-mobl3.amr.corp.intel.com ([10.125.110.115])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 08:55:36 -0700
Message-ID: <d8ed51f8ffd05b2f6508b82d5c10c876ff54b5c2.camel@linux.intel.com>
Subject: Re: [PATCH 2/3] platform/x86/intel-uncore-freq: Add support for
 efficiency latency control
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Tero
 Kristo <tero.kristo@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org,  LKML <linux-kernel@vger.kernel.org>
Date: Mon, 26 Aug 2024 08:55:27 -0700
In-Reply-To: <0abf523f-56a8-b0be-cf15-d799a0a4fc90@linux.intel.com>
References: <20240821131321.824326-1-tero.kristo@linux.intel.com>
	 <20240821131321.824326-3-tero.kristo@linux.intel.com>
	 <0abf523f-56a8-b0be-cf15-d799a0a4fc90@linux.intel.com>
Content-Type: multipart/mixed; boundary="=-FPINvjVEBYr1LklhMp88"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-FPINvjVEBYr1LklhMp88
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2024-08-23 at 15:48 +0300, Ilpo J=C3=A4rvinen wrote:
> On Wed, 21 Aug 2024, Tero Kristo wrote:
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
> > =C2=A0.../uncore-frequency-common.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
4 +
> > =C2=A0.../uncore-frequency/uncore-frequency-tpmi.c=C2=A0 | 153
> > +++++++++++++++++-
> > =C2=A02 files changed, 155 insertions(+), 2 deletions(-)
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
> > index 9fa3037c03d1..3a83b6ce54a5 100644
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
> > +		break;
> > +
> > +	case UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE:
> > +		*val =3D
> > FIELD_GET(UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE, ctrl);
> > +		break;
> > +	case UNCORE_INDEX_EFF_LAT_CTRL_FREQ:
> > +		*val =3D FIELD_GET(UNCORE_EFF_LAT_CTRL_RATIO_MASK,
> > ctrl) * UNCORE_FREQ_KHZ_MULTIPLIER;
> > +		break;
> > +
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > =C2=A0#define UNCORE_MAX_RATIO	FIELD_MAX(UNCORE_MAX_RATIO_MASK)
> > =C2=A0
> > =C2=A0/* Helper for sysfs read for max/min frequencies. Called under
> > mutex locks */
> > @@ -137,6 +185,77 @@ static int uncore_read_control_freq(struct
> > uncore_data *data, unsigned int *valu
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> > +/* Helper function for writing efficiency latency control values
> > over MMIO */
> > +static int write_eff_lat_ctrl(struct uncore_data *data, unsigned
> > int val, enum uncore_index index)
> > +{
> > +	struct tpmi_uncore_cluster_info *cluster_info;
> > +	u64 control;
> > +
> > +	cluster_info =3D container_of(data, struct
> > tpmi_uncore_cluster_info, uncore_data);
> > +
> > +	if (cluster_info->root_domain)
> > +		return -ENODATA;
> > +
> > +	if (!cluster_info->elc_supported)
> > +		return -EOPNOTSUPP;
> > +
> > +	switch (index) {
> > +	case UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD:
> > +		if (val > 100)
> > +			return -EINVAL;
> > +		break;
> > +
> > +	case UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD:
> > +		if (val > 100)
> > +			return -EINVAL;
> > +		break;
> > +
> > +	case UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE:
> > +		if (val > 1)
> > +			return -EINVAL;
> > +		break;
> > +
> > +	case UNCORE_INDEX_EFF_LAT_CTRL_FREQ:
> > +		val /=3D UNCORE_FREQ_KHZ_MULTIPLIER;
> > +		if (val >
> > FIELD_MAX(UNCORE_EFF_LAT_CTRL_RATIO_MASK))
> > +			return -EINVAL;
> > +		break;
> > +
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	control =3D readq(cluster_info->cluster_base +
> > UNCORE_CONTROL_INDEX);
> > +
> > +	if (index =3D=3D UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD) {
> > +		val *=3D
> > FIELD_MAX(UNCORE_EFF_LAT_CTRL_LOW_THRESHOLD_MASK);
> > +		val /=3D 100;
> > +		control &=3D
> > ~UNCORE_EFF_LAT_CTRL_LOW_THRESHOLD_MASK;
> > +		control |=3D
> > FIELD_PREP(UNCORE_EFF_LAT_CTRL_LOW_THRESHOLD_MASK, val);
> > +	}
> > +
> > +	if (index =3D=3D UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD) {
> > +		val *=3D
> > FIELD_MAX(UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_MASK);
> > +		val /=3D 100;
> > +		control &=3D
> > ~UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_MASK;
> > +		control |=3D
> > FIELD_PREP(UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_MASK, val);
> > +	}
> > +
> > +	if (index =3D=3D
> > UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE) {
> > +		control &=3D
> > ~UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE;
> > +		control |=3D
> > FIELD_PREP(UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE, val);
> > +	}
> > +
> > +	if (index =3D=3D UNCORE_INDEX_EFF_LAT_CTRL_FREQ) {
> > +		control &=3D ~UNCORE_EFF_LAT_CTRL_RATIO_MASK;
> > +		control |=3D
> > FIELD_PREP(UNCORE_EFF_LAT_CTRL_RATIO_MASK, val);
> > +	}
>=20
> Why are these not using switch/case?
>=20
I think they can reuse. Just need to repeat readq(). Something like
attached:


--=-FPINvjVEBYr1LklhMp88
Content-Disposition: attachment; filename="reuse_switch.diff"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="reuse_switch.diff"; charset="UTF-8"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3VuY29yZS1mcmVxdWVuY3kv
dW5jb3JlLWZyZXF1ZW5jeS10cG1pLmMgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC91bmNv
cmUtZnJlcXVlbmN5L3VuY29yZS1mcmVxdWVuY3ktdHBtaS5jCmluZGV4IGU2MDQ3ZmJiZWE3Ni4u
MmEzMzhkNmI4YmJmIDEwMDY0NAotLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC91bmNv
cmUtZnJlcXVlbmN5L3VuY29yZS1mcmVxdWVuY3ktdHBtaS5jCisrKyBiL2RyaXZlcnMvcGxhdGZv
cm0veDg2L2ludGVsL3VuY29yZS1mcmVxdWVuY3kvdW5jb3JlLWZyZXF1ZW5jeS10cG1pLmMKQEAg
LTE5MSw1MCArMTkxLDQ0IEBAIHN0YXRpYyBpbnQgd3JpdGVfZWZmX2xhdF9jdHJsKHN0cnVjdCB1
bmNvcmVfZGF0YSAqZGF0YSwgdW5zaWduZWQgaW50IHZhbCwgZW51bSB1CiAJY2FzZSBVTkNPUkVf
SU5ERVhfRUZGX0xBVF9DVFJMX0xPV19USFJFU0hPTEQ6CiAJCWlmICh2YWwgPiBGSUVMRF9NQVgo
VU5DT1JFX0VGRl9MQVRfQ1RSTF9MT1dfVEhSRVNIT0xEX01BU0spKQogCQkJcmV0dXJuIC1FSU5W
QUw7CisKKwkJY29udHJvbCA9IHJlYWRxKGNsdXN0ZXJfaW5mby0+Y2x1c3Rlcl9iYXNlICsgVU5D
T1JFX0NPTlRST0xfSU5ERVgpOworCQljb250cm9sICY9IH5VTkNPUkVfRUZGX0xBVF9DVFJMX0xP
V19USFJFU0hPTERfTUFTSzsKKwkJY29udHJvbCB8PSBGSUVMRF9QUkVQKFVOQ09SRV9FRkZfTEFU
X0NUUkxfTE9XX1RIUkVTSE9MRF9NQVNLLCB2YWwpOwogCQlicmVhazsKIAogCWNhc2UgVU5DT1JF
X0lOREVYX0VGRl9MQVRfQ1RSTF9ISUdIX1RIUkVTSE9MRDoKIAkJaWYgKHZhbCA+IEZJRUxEX01B
WChVTkNPUkVfRUZGX0xBVF9DVFJMX0hJR0hfVEhSRVNIT0xEX01BU0spKQogCQkJcmV0dXJuIC1F
SU5WQUw7CisKKwkJY29udHJvbCA9IHJlYWRxKGNsdXN0ZXJfaW5mby0+Y2x1c3Rlcl9iYXNlICsg
VU5DT1JFX0NPTlRST0xfSU5ERVgpOworCQljb250cm9sICY9IH5VTkNPUkVfRUZGX0xBVF9DVFJM
X0hJR0hfVEhSRVNIT0xEX01BU0s7CisJCWNvbnRyb2wgfD0gRklFTERfUFJFUChVTkNPUkVfRUZG
X0xBVF9DVFJMX0hJR0hfVEhSRVNIT0xEX01BU0ssIHZhbCk7CiAJCWJyZWFrOwogCiAJY2FzZSBV
TkNPUkVfSU5ERVhfRUZGX0xBVF9DVFJMX0hJR0hfVEhSRVNIT0xEX0VOQUJMRToKIAkJaWYgKHZh
bCA+IDEpCiAJCQlyZXR1cm4gLUVJTlZBTDsKKworCQljb250cm9sID0gcmVhZHEoY2x1c3Rlcl9p
bmZvLT5jbHVzdGVyX2Jhc2UgKyBVTkNPUkVfQ09OVFJPTF9JTkRFWCk7CisJCWNvbnRyb2wgJj0g
flVOQ09SRV9FRkZfTEFUX0NUUkxfSElHSF9USFJFU0hPTERfRU5BQkxFOworCQljb250cm9sIHw9
IEZJRUxEX1BSRVAoVU5DT1JFX0VGRl9MQVRfQ1RSTF9ISUdIX1RIUkVTSE9MRF9FTkFCTEUsIHZh
bCk7CiAJCWJyZWFrOwogCiAJY2FzZSBVTkNPUkVfSU5ERVhfRUZGX0xBVF9DVFJMX0ZSRVE6CiAJ
CXZhbCAvPSBVTkNPUkVfRlJFUV9LSFpfTVVMVElQTElFUjsKIAkJaWYgKHZhbCA+IEZJRUxEX01B
WChVTkNPUkVfRUZGX0xBVF9DVFJMX1JBVElPX01BU0spKQogCQkJcmV0dXJuIC1FSU5WQUw7CisK
KwkJY29udHJvbCA9IHJlYWRxKGNsdXN0ZXJfaW5mby0+Y2x1c3Rlcl9iYXNlICsgVU5DT1JFX0NP
TlRST0xfSU5ERVgpOworCQljb250cm9sICY9IH5VTkNPUkVfRUZGX0xBVF9DVFJMX1JBVElPX01B
U0s7CisJCWNvbnRyb2wgfD0gRklFTERfUFJFUChVTkNPUkVfRUZGX0xBVF9DVFJMX1JBVElPX01B
U0ssIHZhbCk7CiAJCWJyZWFrOwogCiAJZGVmYXVsdDoKIAkJcmV0dXJuIC1FT1BOT1RTVVBQOwog
CX0KIAotCWNvbnRyb2wgPSByZWFkcShjbHVzdGVyX2luZm8tPmNsdXN0ZXJfYmFzZSArIFVOQ09S
RV9DT05UUk9MX0lOREVYKTsKLQotCWlmIChpbmRleCA9PSBVTkNPUkVfSU5ERVhfRUZGX0xBVF9D
VFJMX0xPV19USFJFU0hPTEQpIHsKLQkJY29udHJvbCAmPSB+VU5DT1JFX0VGRl9MQVRfQ1RSTF9M
T1dfVEhSRVNIT0xEX01BU0s7Ci0JCWNvbnRyb2wgfD0gRklFTERfUFJFUChVTkNPUkVfRUZGX0xB
VF9DVFJMX0xPV19USFJFU0hPTERfTUFTSywgdmFsKTsKLQl9Ci0KLQlpZiAoaW5kZXggPT0gVU5D
T1JFX0lOREVYX0VGRl9MQVRfQ1RSTF9ISUdIX1RIUkVTSE9MRCkgewotCQljb250cm9sICY9IH5V
TkNPUkVfRUZGX0xBVF9DVFJMX0hJR0hfVEhSRVNIT0xEX01BU0s7Ci0JCWNvbnRyb2wgfD0gRklF
TERfUFJFUChVTkNPUkVfRUZGX0xBVF9DVFJMX0hJR0hfVEhSRVNIT0xEX01BU0ssIHZhbCk7Ci0J
fQotCi0JaWYgKGluZGV4ID09IFVOQ09SRV9JTkRFWF9FRkZfTEFUX0NUUkxfSElHSF9USFJFU0hP
TERfRU5BQkxFKSB7Ci0JCWNvbnRyb2wgJj0gflVOQ09SRV9FRkZfTEFUX0NUUkxfSElHSF9USFJF
U0hPTERfRU5BQkxFOwotCQljb250cm9sIHw9IEZJRUxEX1BSRVAoVU5DT1JFX0VGRl9MQVRfQ1RS
TF9ISUdIX1RIUkVTSE9MRF9FTkFCTEUsIHZhbCk7Ci0JfQotCi0JaWYgKGluZGV4ID09IFVOQ09S
RV9JTkRFWF9FRkZfTEFUX0NUUkxfRlJFUSkgewotCQljb250cm9sICY9IH5VTkNPUkVfRUZGX0xB
VF9DVFJMX1JBVElPX01BU0s7Ci0JCWNvbnRyb2wgfD0gRklFTERfUFJFUChVTkNPUkVfRUZGX0xB
VF9DVFJMX1JBVElPX01BU0ssIHZhbCk7Ci0JfQotCiAJd3JpdGVxKGNvbnRyb2wsIGNsdXN0ZXJf
aW5mby0+Y2x1c3Rlcl9iYXNlICsgVU5DT1JFX0NPTlRST0xfSU5ERVgpOwogCiAJcmV0dXJuIDA7
Cg==


--=-FPINvjVEBYr1LklhMp88--

