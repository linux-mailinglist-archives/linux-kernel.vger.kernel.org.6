Return-Path: <linux-kernel+bounces-209014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005E6902BD9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 00:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 583C5B21764
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115191509A6;
	Mon, 10 Jun 2024 22:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UvcLL07o"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7DC150981
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 22:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718059262; cv=none; b=dPVH7UnZYYiQlRBN4jwpUZg7fbU0zxjvOre5Sbmk+G7IMn8do1Z8DOJVHef10vKEkKkR5b1RJYeMLyChTpvPl05KLrxkvvg3oL3q0VMutLNu/ar+NNagzzkzAVY/OIgl38FZu0K7UtnMh3mmWV3CYTvKuIz0x9e3gNGs55ell2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718059262; c=relaxed/simple;
	bh=sLaT1b+jqYY13JWFb12MhvlcS48VvrXkN64Mql/YLgA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VfJCATy2AnCR+Re+51AuyziwxK2WaLMGq6+jVEuXEL3G/0Lvux5RY6EPkgEGv96LEORh4KX+kUUDF+6BE8GhEH7S4sMI+3t4HhyHnfmDz2c9YrIshST/AFZvJMxxdQGW/Yw5oe27toBZhJ+SrBZUb8jWWaIlq9RPS6x568woEVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UvcLL07o; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718059261; x=1749595261;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=sLaT1b+jqYY13JWFb12MhvlcS48VvrXkN64Mql/YLgA=;
  b=UvcLL07oKDc0Jodmfh6laQUp0+WEsNyboVPhyWqUM659RGB2x4nJMW64
   OyixrnCcM/UTJ3EB/FtSxhtNH48E8p3qXTk496imh+spzlRnrr24tD1tR
   Zey3rwpuDOL7RT5M68COuuNJcJQGvrhUfKexTcAZJf1kpmIc/r5ghVyAZ
   yEO7RwCS/KSWPrkGRMK2Iy+R0I/ezjjqPveIbPvZDhoV1/kAt9MT7fns9
   /Gi7XKAXoHbnT0ikXdhGfgXDdjmqPBmn3a8lRwdvPWe3qH6ny4ngBprX7
   6YGILDD6KPCdoEYBL/FEK0LEcCnZJubwazBSmzgy8mRkVThim9cI6Vo7q
   w==;
X-CSE-ConnectionGUID: kkfzZfxuSQGNrYJUCpbWuQ==
X-CSE-MsgGUID: H66Pv34SQc69Q6BodkvX3g==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="17663729"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="17663729"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 15:41:00 -0700
X-CSE-ConnectionGUID: Grgz2+d+TKGhIdtuMwwnWg==
X-CSE-MsgGUID: +gzXi1AHS2CJ5qX2E9+yYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43630839"
Received: from zshen-mobl.amr.corp.intel.com (HELO [10.209.70.146]) ([10.209.70.146])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 15:40:59 -0700
Message-ID: <0f1ba5d8ecc62f774590077b2f88f5b64dd98452.camel@linux.intel.com>
Subject: Re: [PATCH 1/8] perf/x86/uncore: Save the unit control address of
 all units
From: Tim Chen <tim.c.chen@linux.intel.com>
To: kan.liang@linux.intel.com, peterz@infradead.org, mingo@kernel.org, 
	linux-kernel@vger.kernel.org
Cc: acme@kernel.org, namhyung@kernel.org, irogers@google.com,
 eranian@google.com,  ak@linux.intel.com, yunying.sun@intel.com
Date: Mon, 10 Jun 2024 15:40:59 -0700
In-Reply-To: <20240610201619.884021-2-kan.liang@linux.intel.com>
References: <20240610201619.884021-1-kan.liang@linux.intel.com>
	 <20240610201619.884021-2-kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-10 at 13:16 -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
>=20
> The unit control address of some CXL units may be wrongly calculated
> under some configuration on a EMR machine.
>=20
> The current implementation only saves the unit control address of the
> units from the first die, and the first unit of the rest of dies. Perf
> assumed that the units from the other dies have the same offset as the
> first die. So the unit control address of the rest of the units can be
> calculated. However, the assumption is wrong, especially for the CXL
> units.
>=20
> Introduce an RB tree for each uncore type to save the unit control
> address and ID information for all the units.
>=20
> Compared with the current implementation, more space is required to save
> the information of all units. The extra size should be acceptable.
> For example, on EMR, there are 221 units at most. For a 2-socket machine,
> the extra space is ~6KB at most.
>=20
> Tested-by: Yunying Sun <yunying.sun@intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/events/intel/uncore_discovery.c | 79 +++++++++++++++++++++++-
>  arch/x86/events/intel/uncore_discovery.h | 10 +++
>  2 files changed, 87 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/i=
ntel/uncore_discovery.c
> index 9a698a92962a..ce520e69a3c1 100644
> --- a/arch/x86/events/intel/uncore_discovery.c
> +++ b/arch/x86/events/intel/uncore_discovery.c
> @@ -93,6 +93,8 @@ add_uncore_discovery_type(struct uncore_unit_discovery =
*unit)
>  	if (!type->box_ctrl_die)
>  		goto free_type;
> =20
> +	type->units =3D RB_ROOT;
> +
>  	type->access_type =3D unit->access_type;
>  	num_discovered_types[type->access_type]++;
>  	type->type =3D unit->box_type;
> @@ -120,10 +122,59 @@ get_uncore_discovery_type(struct uncore_unit_discov=
ery *unit)
>  	return add_uncore_discovery_type(unit);
>  }
> =20
> +static inline bool unit_less(struct rb_node *a, const struct rb_node *b)
> +{
> +	struct intel_uncore_discovery_unit *a_node, *b_node;
> +
> +	a_node =3D rb_entry(a, struct intel_uncore_discovery_unit, node);
> +	b_node =3D rb_entry(b, struct intel_uncore_discovery_unit, node);
> +
> +	if (a_node->pmu_idx < b_node->pmu_idx)
> +		return true;
> +	if (a_node->pmu_idx > b_node->pmu_idx)
> +		return false;
> +
> +	if (a_node->die < b_node->die)
> +		return true;
> +	if (a_node->die > b_node->die)
> +		return false;
> +
> +	return 0;

Will it be better if the rb_node is sorted by id instead
of pmu_idx+die?=20

Then it will be faster for uncore_find_unit() to run in
O(log(N)) instead of O(N).  Right now it looks like we
are traversing the whole tree to find the entry with the
id.

Tim

> +}
> +
> +static inline struct intel_uncore_discovery_unit *
> +uncore_find_unit(struct rb_root *root, unsigned int id)
> +{
> +	struct intel_uncore_discovery_unit *unit;
> +	struct rb_node *node;
> +
> +	for (node =3D rb_first(root); node; node =3D rb_next(node)) {
> +		unit =3D rb_entry(node, struct intel_uncore_discovery_unit, node);
> +		if (unit->id =3D=3D id)
> +			return unit;
> +	}
> +
> +	return NULL;
> +}
> +


