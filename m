Return-Path: <linux-kernel+bounces-265673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C60393F444
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39E91C21EAC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C4714658C;
	Mon, 29 Jul 2024 11:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HtNa+Aft"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17956146015;
	Mon, 29 Jul 2024 11:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253144; cv=none; b=fsyyuuCilTf1kX1pOIZick5N0WJf0yKIow9xlASSU/eHC57sSF4ME5xFgq8XuKN/H098InvLGNBxwzULQpF+rBP6zudjGvmPlFSCwDjMKbDmnuHAhapM6I81jSCpEd+M1RBlbm4PaNU2IPND/oUQ/bq5bnjeD6+QctunfHIymVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253144; c=relaxed/simple;
	bh=G2Hxq5SH6mbRM8TQwL+GQBN/WkWJKoHCUsfMqH0CoXA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=F3OX5I1ys+pRcVCCCruyVI+aDrO+6GNEB+Mra8u9AfALIBtM4Iocbr/gIxJkcOAlaoC6Uqslm4Fg0Vl5TroqcTUn/NsLrBNOQtMsJuChXlboHI2zTsF03YBkkmOyJx3LGlTNCZfK0UcCx05s0gWFik/CE0jxUzWyaUlDEvMyoAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HtNa+Aft; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722253143; x=1753789143;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=G2Hxq5SH6mbRM8TQwL+GQBN/WkWJKoHCUsfMqH0CoXA=;
  b=HtNa+AftHcuSm75RtKC0R1GIYGtzscNSTeo2UvVAqJ/57U36MsVHgas8
   AQWwwDBDPuO2H5wD5fI3wj1OHqFhnvN8PKP0XRFno5VS9JcxjEEyi1Jf9
   mkwHZz1ekIhkDdgTqboYQXpT+Qp5MjGjEu3PZPqDMW2X59ysaCfvjaAZF
   HeL2LJR4CyE0LpTkLKXO+zFlfmbPOYpTL66susbonlvhyZyRVWalbqrNx
   vvHJ6optgSfgYbgSMsqm6sa+FpttP1lVDu81McefhhRvJx44JqMQ6wnZC
   DGtc5PhL0upsDEjM8TGjRnn2lgUnDdtNzmtHnPYLxNoIXZFNpD3rVI727
   A==;
X-CSE-ConnectionGUID: Vj86qRKhSIiGDltFMj/+9A==
X-CSE-MsgGUID: vIM38PbLQNe5FrUuXsKm2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="22911019"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="22911019"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 04:39:02 -0700
X-CSE-ConnectionGUID: VNKbjXX0QM2GakN6lLTgSQ==
X-CSE-MsgGUID: ga+LzIzZQN+D+Gp3TUIEcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="84593276"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.151])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 04:39:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 29 Jul 2024 14:38:57 +0300 (EEST)
To: Kane Chen <kane.chen@intel.com>
cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 1/1] platform/x86/intel/pmc: Show live substate
 requirements
In-Reply-To: <20240719122807.3853292-1-kane.chen@intel.com>
Message-ID: <edfd1b36-7532-c0ba-6d24-b3e296e1cf0b@linux.intel.com>
References: <20240719122807.3853292-1-kane.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-713672148-1722253137=:983"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-713672148-1722253137=:983
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 19 Jul 2024, Kane Chen wrote:

> While debugging runtime s0ix, we do need to check which required IPs
> are not power gated. This patch adds code to show live substate status
> vs requirements in sys/kernel/debug/pmc_core/substate_requirements to
> help runtime s0ix debug.
>=20
> Signed-off-by: Kane Chen <kane.chen@intel.com>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
>  drivers/platform/x86/intel/pmc/core.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86=
/intel/pmc/core.c
> index 2ad2f8753e5d4..b93ecc5169745 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -791,13 +791,15 @@ static void pmc_core_substate_req_header_show(struc=
t seq_file *s, int pmc_index)
>  =09pmc_for_each_mode(i, mode, pmcdev)
>  =09=09seq_printf(s, " %9s |", pmc_lpm_modes[mode]);
> =20
> -=09seq_printf(s, " %9s |\n", "Status");
> +=09seq_printf(s, " %9s |", "Status");
> +=09seq_printf(s, " %11s |\n", "Live Status");
>  }
> =20
>  static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unu=
sed)
>  {
>  =09struct pmc_dev *pmcdev =3D s->private;
>  =09u32 sts_offset;
> +=09u32 sts_offset_live;
>  =09u32 *lpm_req_regs;
>  =09int num_maps, mp, pmc_index;
> =20
> @@ -811,6 +813,7 @@ static int pmc_core_substate_req_regs_show(struct seq=
_file *s, void *unused)
>  =09=09maps =3D pmc->map->lpm_sts;
>  =09=09num_maps =3D pmc->map->lpm_num_maps;
>  =09=09sts_offset =3D pmc->map->lpm_status_offset;
> +=09=09sts_offset_live =3D pmc->map->lpm_live_status_offset;
>  =09=09lpm_req_regs =3D pmc->lpm_req_regs;
> =20
>  =09=09/*
> @@ -828,6 +831,7 @@ static int pmc_core_substate_req_regs_show(struct seq=
_file *s, void *unused)
>  =09=09for (mp =3D 0; mp < num_maps; mp++) {
>  =09=09=09u32 req_mask =3D 0;
>  =09=09=09u32 lpm_status;
> +=09=09=09u32 lpm_status_live;
>  =09=09=09const struct pmc_bit_map *map;
>  =09=09=09int mode, idx, i, len =3D 32;
> =20
> @@ -842,6 +846,9 @@ static int pmc_core_substate_req_regs_show(struct seq=
_file *s, void *unused)
>  =09=09=09/* Get the last latched status for this map */
>  =09=09=09lpm_status =3D pmc_core_reg_read(pmc, sts_offset + (mp * 4));
> =20
> +=09=09=09/* Get the runtime status for this map */
> +=09=09=09lpm_status_live =3D pmc_core_reg_read(pmc, sts_offset_live + (m=
p * 4));
> +
>  =09=09=09/*  Loop over elements in this map */
>  =09=09=09map =3D maps[mp];
>  =09=09=09for (i =3D 0; map[i].name && i < len; i++) {
> @@ -868,6 +875,9 @@ static int pmc_core_substate_req_regs_show(struct seq=
_file *s, void *unused)
>  =09=09=09=09/* In Status column, show the last captured state of this ag=
ent */
>  =09=09=09=09seq_printf(s, " %9s |", lpm_status & bit_mask ? "Yes" : " ")=
;
> =20
> +=09=09=09=09/* In Live status column, show the live state of this agent =
*/
> +=09=09=09=09seq_printf(s, " %11s |", lpm_status_live & bit_mask ? "Yes" =
: " ");
> +
>  =09=09=09=09seq_puts(s, "\n");
>  =09=09=09}
>  =09=09}
>=20

--8323328-713672148-1722253137=:983--

