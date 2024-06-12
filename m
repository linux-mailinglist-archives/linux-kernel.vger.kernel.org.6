Return-Path: <linux-kernel+bounces-211980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C7690599E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F6831F239C8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B941836CB;
	Wed, 12 Jun 2024 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y8+hUpwu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E9F1822EC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 17:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718212097; cv=none; b=mwq9EhgR3BJWw4SGpwuFxvXn5cBaROVo+WqBOT4QxfoefZSik4pa2pqpBWrzjj8Mni/D2BVSvVbL4BY2aXardk0xLXtD0v0/bzHQoQw7j5OIFaG7o6sKNf/KcLYKFySpK+l/HiX6hlrTI7cXbqnMXWtBJto5BGSmWG1L7AfH8vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718212097; c=relaxed/simple;
	bh=kEeSe2gS2rwGrkpxxvZySMZNAlyhg90ruWTdwLppCDM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m1OwmFRQj2ckOmebK76mho3kBZcjpoJyQo0y5/3XDutAG4xhPWHWZq0tPKCpon60drM0N+YNAy74xspZtxan38ioU9+lhv5EdmMzwH3NFkgd2i9NWyLvFb5wFOjpcGL620jFFJtlLx66MLfFBW8lPpMPhgvyCyC+gJGnaC6OSkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y8+hUpwu; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718212095; x=1749748095;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=kEeSe2gS2rwGrkpxxvZySMZNAlyhg90ruWTdwLppCDM=;
  b=Y8+hUpwuGa52ej+ZxfWFSRQJugCBzLw7D59x/LzLzarscAhWHsccg+JV
   ZQ4YW7ejp2jBeCbtTSJYM/RmbWJhFEBg3NoPa5+WLg2w+kZxf0KHUUT76
   dAIUOIrXHVrDos4itx9sm/y7TEza3qzGPuXpBTX/FmB67Su48iA5eERuF
   1GWouGDSBH685banAzKzgoyQ3BP4aLYqknY+3jlbqy90kYpXW7Dd9uI1X
   hHz2mXPpMrDKc7yWLisHbWhN3RBxiUZgc/jJNErDXfIorCSuDspNjMP2r
   4GbC/BBwjoXsRvYBYIRUAfmlx4LJsOZdIUquVZlTVRqFi3z/Avu1PqN2r
   A==;
X-CSE-ConnectionGUID: zgtHpRR6SZaOv82WnB5K+A==
X-CSE-MsgGUID: 1R1jg6ZTQcSYL8Ti/gE3Mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="25670641"
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="25670641"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 10:08:14 -0700
X-CSE-ConnectionGUID: Hw5LMI+HSGudCOnpTXXBRw==
X-CSE-MsgGUID: 1qMervNJSx+u3aUrosHBCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="44793783"
Received: from snarapar-mobl1.amr.corp.intel.com (HELO [10.209.70.177]) ([10.209.70.177])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 10:08:14 -0700
Message-ID: <b4fefa29a1bbfccdadc44784453265f84a1904d5.camel@linux.intel.com>
Subject: Re: [PATCH 1/8] perf/x86/uncore: Save the unit control address of
 all units
From: Tim Chen <tim.c.chen@linux.intel.com>
To: "Liang, Kan" <kan.liang@linux.intel.com>, peterz@infradead.org, 
	mingo@kernel.org, linux-kernel@vger.kernel.org
Cc: acme@kernel.org, namhyung@kernel.org, irogers@google.com,
 eranian@google.com,  ak@linux.intel.com, yunying.sun@intel.com
Date: Wed, 12 Jun 2024 10:08:13 -0700
In-Reply-To: <eb5d91d1-2898-45e0-a2d3-aa5c66155911@linux.intel.com>
References: <20240610201619.884021-1-kan.liang@linux.intel.com>
	 <20240610201619.884021-2-kan.liang@linux.intel.com>
	 <0f1ba5d8ecc62f774590077b2f88f5b64dd98452.camel@linux.intel.com>
	 <eb5d91d1-2898-45e0-a2d3-aa5c66155911@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-12 at 10:49 -0400, Liang, Kan wrote:
>=20
> On 2024-06-10 6:40 p.m., Tim Chen wrote:
> > On Mon, 2024-06-10 at 13:16 -0700, kan.liang@linux.intel.com wrote:
> > > From: Kan Liang <kan.liang@linux.intel.com>
> > >=20
> > > The unit control address of some CXL units may be wrongly calculated
> > > under some configuration on a EMR machine.
> > >=20
> > > The current implementation only saves the unit control address of the
> > > units from the first die, and the first unit of the rest of dies. Per=
f
> > > assumed that the units from the other dies have the same offset as th=
e
> > > first die. So the unit control address of the rest of the units can b=
e
> > > calculated. However, the assumption is wrong, especially for the CXL
> > > units.
> > >=20
> > > Introduce an RB tree for each uncore type to save the unit control
> > > address and ID information for all the units.
> > >=20
> > > Compared with the current implementation, more space is required to s=
ave
> > > the information of all units. The extra size should be acceptable.
> > > For example, on EMR, there are 221 units at most. For a 2-socket mach=
ine,
> > > the extra space is ~6KB at most.
> > >=20
> > > Tested-by: Yunying Sun <yunying.sun@intel.com>
> > > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> > > ---
> > >  arch/x86/events/intel/uncore_discovery.c | 79 ++++++++++++++++++++++=
+-
> > >  arch/x86/events/intel/uncore_discovery.h | 10 +++
> > >  2 files changed, 87 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/even=
ts/intel/uncore_discovery.c
> > > index 9a698a92962a..ce520e69a3c1 100644
> > > --- a/arch/x86/events/intel/uncore_discovery.c
> > > +++ b/arch/x86/events/intel/uncore_discovery.c
> > > @@ -93,6 +93,8 @@ add_uncore_discovery_type(struct uncore_unit_discov=
ery *unit)
> > >  	if (!type->box_ctrl_die)
> > >  		goto free_type;
> > > =20
> > > +	type->units =3D RB_ROOT;
> > > +
> > >  	type->access_type =3D unit->access_type;
> > >  	num_discovered_types[type->access_type]++;
> > >  	type->type =3D unit->box_type;
> > > @@ -120,10 +122,59 @@ get_uncore_discovery_type(struct uncore_unit_di=
scovery *unit)
> > >  	return add_uncore_discovery_type(unit);
> > >  }
> > > =20
> > > +static inline bool unit_less(struct rb_node *a, const struct rb_node=
 *b)
> > > +{
> > > +	struct intel_uncore_discovery_unit *a_node, *b_node;
> > > +
> > > +	a_node =3D rb_entry(a, struct intel_uncore_discovery_unit, node);
> > > +	b_node =3D rb_entry(b, struct intel_uncore_discovery_unit, node);
> > > +
> > > +	if (a_node->pmu_idx < b_node->pmu_idx)
> > > +		return true;
> > > +	if (a_node->pmu_idx > b_node->pmu_idx)
> > > +		return false;
> > > +
> > > +	if (a_node->die < b_node->die)
> > > +		return true;
> > > +	if (a_node->die > b_node->die)
> > > +		return false;
> > > +
> > > +	return 0;
> >=20
> > Will it be better if the rb_node is sorted by id instead
> > of pmu_idx+die?
>=20
> The id and pmu_idx+die can all be used as a key to search the RB tree in
> different places.
>=20
> The id is the physical ID of a unit. The search via id is invoked when
> adding a new unit. Perf needs to make sure that the same PMU idx
> (logical id) is assigned to the unit with the same physical ID. Because
> the units with the same physical ID in different dies share the same PMU.
>=20
> The pmu_idx+die key is used when setting the cpumask. Please see
> intel_uncore_find_discovery_unit_id() in the patch 2. Perf wants to
> understand on which dies the given PMU is available.
>=20
> Since different keys can be used to search the RB tree, I think one of
> them has to traverse the whole tree. At the stage of adding a new unit,
> the tree is not complete yet. It minimizes the impact of the O(N)
> search. So I choose the pmu_idx+die rather than id.
>=20
> Also, the driver only does once to build the tree and set the cpumask at
> driver load time. I think the O(N) should be acceptable here.
>=20

Thanks for explaining.  I think you saying you are looking up pmu in the tr=
ee with id
once during driver load time but needs to look up the tree by die and pmu_i=
dx
more frequently, hence the choice for index.

May be worth mentioning that in a comment.

Tim

> Thanks,
> Kan
>=20
> >=20
> > Then it will be faster for uncore_find_unit() to run in
> > O(log(N)) instead of O(N).  Right now it looks like we
> > are traversing the whole tree to find the entry with the
> > id.
> >=20
> > Tim
> >=20
> > > +}
> > > +
> > > +static inline struct intel_uncore_discovery_unit *
> > > +uncore_find_unit(struct rb_root *root, unsigned int id)
> > > +{
> > > +	struct intel_uncore_discovery_unit *unit;
> > > +	struct rb_node *node;
> > > +
> > > +	for (node =3D rb_first(root); node; node =3D rb_next(node)) {
> > > +		unit =3D rb_entry(node, struct intel_uncore_discovery_unit, node);
> > > +		if (unit->id =3D=3D id)
> > > +			return unit;
> > > +	}
> > > +
> > > +	return NULL;
> > > +}
> > > +
> >=20
> >=20


