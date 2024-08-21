Return-Path: <linux-kernel+bounces-295053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57843959626
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 09:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B4A1C20AC8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 07:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F47D19ABB9;
	Wed, 21 Aug 2024 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ra2MLnlj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE711B81D5;
	Wed, 21 Aug 2024 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724225444; cv=none; b=BbxbH3oOBcdd61PdQsXBHf7Ua/uTMiuVMj1Riq4XaloZZXFkNA5+AntpdxXifZ2X5Hs9owlpn0qKzJM6FM8HLfjyW4ISyWL8vw6lZVrzMLn8n3cPzQSz06DTy6uYmSraqfo8tHABHUBrkgzJPJ86y8jffkgUSZgOeQiWWM730es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724225444; c=relaxed/simple;
	bh=/tEr+7aRGRUHgWH6P1voUkKY5buJ2qP3gh+K5EEHLcs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=udqZz181zZ7DioHt/zQG39rVpnV6fS5PB+RmIqwk//2ljPx/TS3CyaQwmLxF+TxAGqXIAyzIoH5q65I+8guTZby4x3FRNcmfxTPv9dSbNfXUeJfaIKZeW78APln6eYv/vz1LjPTheJhv3EyWvV30JUKtWBJA25O4x0zJwGuzEXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ra2MLnlj; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724225443; x=1755761443;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/tEr+7aRGRUHgWH6P1voUkKY5buJ2qP3gh+K5EEHLcs=;
  b=Ra2MLnljhdU8IH/rT17pECZqEmj0KO4tq0dCACeNZivhd3g0KKwJJ4TH
   fMLMQpxUb866ZHDmKjinP7ViogRlHxPsNSbMXnOBrH1orq8rR7z/qfz1I
   JuvnbchdyqIs1edr+wsaM9cVQ4OUEAylKN0ZvVxeBFiBdaXmRceBhMZzv
   +J5YPJ+h8aOl7mGrkd78txr9wP2OF5KvcPqh7eU1O1XhuNcPVZqcQfsPG
   dI/VMIIQxgURVoZ5VmSnuzu7vuHZFsAInL3ezdtn2prJoBlvpAAvAVuzu
   3iq4rebV9XH2c35E68S1uthWGniyDNBGFmoA6usYUWj8YJdkv03QSalHV
   Q==;
X-CSE-ConnectionGUID: DPq0ZNkLSGuPDPP5OIbJ/A==
X-CSE-MsgGUID: 9Jd1YdwqSLm9UhxOHtf03g==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22435342"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="22435342"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 00:30:42 -0700
X-CSE-ConnectionGUID: KVcoWeYvS9SA6Njn1YrQFw==
X-CSE-MsgGUID: l4pYpQ3aTfO1MR7RahKEdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="61535992"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.181])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 00:30:40 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 21 Aug 2024 10:30:37 +0300 (EEST)
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] platform/x86/intel-uncore-freq: Do not present separate
 package-die domain
In-Reply-To: <20240820204558.1296319-1-srinivas.pandruvada@linux.intel.com>
Message-ID: <7dca8e46-4c33-875d-d645-55bb9bbc421f@linux.intel.com>
References: <20240820204558.1296319-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1899909308-1724225437=:5260"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1899909308-1724225437=:5260
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 20 Aug 2024, Srinivas Pandruvada wrote:

> The scope of uncore control is per power domain with TPMI.
>=20
> There are two types of processor topologies can be presented by CPUID
> extended topology leaf irrespective of the hardware architecture:
>=20
> 1. A die is not enumerated in CPUID. In this case there is only one die
> in a package is visible. In this case there can be multiple power domains
> in a single die.
> 2. A power domain in a package is enumerated as a die in CPUID. So
> there is one power domain per die.
>=20
> To allow die level controls, the current implementation creates a root
> domain and aggregates all information from power domains in it. This
> is well suited for configuration 1 above.
>=20
> But for configuration 2 above, the root domain will present the same
> information as present by power domain. So, no use of aggregating. To
> check the configuration, call topology_max_dies_per_package(). If it is
> more than one, avoid creating root domain.
>=20
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
> This is a forward looking change as TPMI is architectural and should
> support all topologies.
>=20
> v2
> Updated commit description as suggested.
>=20
>  .../x86/intel/uncore-frequency/uncore-frequency-tpmi.c     | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency=
-tpmi.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi=
=2Ec
> index 2016acf44f6a..e6047fbbea76 100644
> --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
> +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
> @@ -557,6 +557,9 @@ static int uncore_probe(struct auxiliary_device *auxd=
ev, const struct auxiliary_
> =20
>  =09auxiliary_set_drvdata(auxdev, tpmi_uncore);
> =20
> +=09if (topology_max_dies_per_package() > 1)
> +=09=09return 0;
> +
>  =09tpmi_uncore->root_cluster.root_domain =3D true;
>  =09tpmi_uncore->root_cluster.uncore_root =3D tpmi_uncore;
> =20
> @@ -580,7 +583,9 @@ static void uncore_remove(struct auxiliary_device *au=
xdev)
>  {
>  =09struct tpmi_uncore_struct *tpmi_uncore =3D auxiliary_get_drvdata(auxd=
ev);
> =20
> -=09uncore_freq_remove_die_entry(&tpmi_uncore->root_cluster.uncore_data);
> +=09if (tpmi_uncore->root_cluster.root_domain)
> +=09=09uncore_freq_remove_die_entry(&tpmi_uncore->root_cluster.uncore_dat=
a);
> +
>  =09remove_cluster_entries(tpmi_uncore);
> =20
>  =09uncore_freq_common_exit();
>=20

--8323328-1899909308-1724225437=:5260--

