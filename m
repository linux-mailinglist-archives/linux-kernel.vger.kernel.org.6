Return-Path: <linux-kernel+bounces-212018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65020905A0F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBA2CB26793
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F3E1822FA;
	Wed, 12 Jun 2024 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="azdUnHZe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C6A1822C9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718213588; cv=none; b=SblIYMoqO+lmKjnjJY/bEukSsH0JfomCP2zLItUUdLLWc6VmGQ/5a7mGrI+RLSn24Wf9Cgu8r8w2r6bL/LuqIqOl1lfYKc/EbShZgCHuCJaa/27swxp40W9pezzcDj3rpuuFnoC66rPg8W+RtUfxhdb++IpBNQ0tHeF6pjZQyfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718213588; c=relaxed/simple;
	bh=8QslqOf6bq40lwL09Fh9oEB2dYpfPrXAnjP/2bJhEbo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bR6rIKqNnus6DdJOWA1JksSs4t/D1nUy/0V09MFOcWVzqY8H489qWJ4Z0Kss4GqnaQMeOQl2wl4RwXvWqQ/CCC/HzYCm7bSa8POddBLveB8yZ0Oc5cZBHLLzwB2fX3k8BS6J+4tvBQFJcWMcSlCZzby+yB2tMgVOjxb7YWOJVWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=azdUnHZe; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718213587; x=1749749587;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=8QslqOf6bq40lwL09Fh9oEB2dYpfPrXAnjP/2bJhEbo=;
  b=azdUnHZeBpXgJmfCE0k7PQtk9aHTyh6/jtJJIlDMveJJzzvVn5Ww2XRn
   NnisEqc+YkiZSnSYNEo73WliMi30XB9hr7PXdRAR5fmF8/c4/ZnpAS0gI
   s7faV4wKM5AuZslxu5ZJElMRwBFELagx6GG34zTYlKUhM6/oWuaZVdnbF
   mhZs0muI2u2yMXuN5DuL17vOpgjXmxh84dTA68uyh8mo+yKudgy0rKkPQ
   x6tIBcKwQY2Y5InJOLbvNkmd5l4M0zlJBBiF8/hHVVx1VBrijFFDFi43E
   y6Ymxo+JsZaRg/htATKdCdDu73NlIzh9Ok2i+PDQAVl3jbny465sssE7/
   w==;
X-CSE-ConnectionGUID: ykSRmcSYSyGXm+cUPkmJuQ==
X-CSE-MsgGUID: N83F2mraQlCnhQjImxX1Qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="18774231"
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="18774231"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 10:33:07 -0700
X-CSE-ConnectionGUID: YXNGLTNPSBqIRyGNs4AMOw==
X-CSE-MsgGUID: 3j9w/nRHRcCD46NM1qJW1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="39928976"
Received: from snarapar-mobl1.amr.corp.intel.com (HELO [10.209.70.177]) ([10.209.70.177])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 10:33:06 -0700
Message-ID: <47fad008a152957c87e9846fdbf40746b6e2871a.camel@linux.intel.com>
Subject: Re: [PATCH 1/8] perf/x86/uncore: Save the unit control address of
 all units
From: Tim Chen <tim.c.chen@linux.intel.com>
To: "Liang, Kan" <kan.liang@linux.intel.com>, peterz@infradead.org, 
	mingo@kernel.org, linux-kernel@vger.kernel.org
Cc: acme@kernel.org, namhyung@kernel.org, irogers@google.com,
 eranian@google.com,  ak@linux.intel.com, yunying.sun@intel.com
Date: Wed, 12 Jun 2024 10:33:05 -0700
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
>=20
> The id and pmu_idx+die can all be used as a key to search the RB tree in
> different places.
>=20
> The id is the physical ID of a unit. The search via id is invoked when
> adding a new unit. Perf needs to make sure that the same PMU idx
> (logical id) is assigned to the unit with the same physical ID. Because
> the units with the same physical ID in different dies share the same PMU.

This info about having same physical ID implies the same PMU
is worth mentioning in a comment and will be quite helpful in
understanding the rb-tree organization.

Thanks.

Tim
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
> Thanks,
> Kan


