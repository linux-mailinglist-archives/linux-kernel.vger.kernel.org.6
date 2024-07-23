Return-Path: <linux-kernel+bounces-259488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E2A939704
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 01:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0788A2824EC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 23:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3706C4CB4E;
	Mon, 22 Jul 2024 23:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MTTw4jEh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810C58F5E;
	Mon, 22 Jul 2024 23:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721691353; cv=none; b=rwuhpPn4lx11vfmE9LUXzreCGOhLhpy26d36tlgsM92vVYjYAdyNYpgsivfFiWx7i8+XkeL1lHm2efFm9y62+33//dUgr/4ypc4Onc4t9RG1JhJJafK0H3+eBsGzD4WOBkvA6s+I5tQiuD/fTGDd4PIjV1ZAyvAfaFmBmY9WUk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721691353; c=relaxed/simple;
	bh=uHBs++XUB5PWKoO0mZ43r19mbkrWMGRIfh+BSU4Ubuc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ARzelVoyFMlM/82VxEGrbTb6kXfcEy0uSpbne4SjX1PSGvRcYEA+TaEPQKv3YFIgEtQVNotL7ZdIs9bsuCL0VcK9lTnFnahVP9jcgpwNjj1KgIIaJpz2HQ8LFFlaWuN52JpneP8LiH9NzSc58YFeZfLHT8eFtbO5DKPzQ50p8FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MTTw4jEh; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721691352; x=1753227352;
  h=date:message-id:from:to:cc:subject:in-reply-to:
   references:mime-version;
  bh=uHBs++XUB5PWKoO0mZ43r19mbkrWMGRIfh+BSU4Ubuc=;
  b=MTTw4jEhrU9kSjVhHbTiniX8jbwQJ8DeQg9WVdBvJVX4uR7e3tCoAqAW
   Enwww5QZy/7Q2aQLiicf5CIUXMLdQOj5sKr1uI6SO2vdOBG8n5HGPMhND
   DnyQmN5px/M1lFYBCSL46J12tDCoKrD+hyly6kNjePfjuK9S1BWau8ynE
   f+voZOgijwkn0272Vbyq2nsGQPuG74hiK4MQ49l8qW+JiDQoKRn9up0NE
   Rq57/G6mYYHvhjSiTAUWKnl6RnVpJY1fJIgFpyn8guSZSNj7jnO/FUWMv
   50xyLhD9wqv2Oxx5/DhojmVv11M3ILrLdIiOgZgvBGaqWAZ1X9Y+JnBIc
   Q==;
X-CSE-ConnectionGUID: tIDtT98EQKeXMNDzkndJkg==
X-CSE-MsgGUID: 5QZlejUzSDmXFCDbYhu2ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="44713379"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="44713379"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 16:35:51 -0700
X-CSE-ConnectionGUID: Djh7fBLgQL+Ljm5+Kp4vUA==
X-CSE-MsgGUID: cF1aP7AUTiyovMn8k1nhrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="51929193"
Received: from dmprieto-mobl1.amr.corp.intel.com (HELO adixit-arch.intel.com) ([10.125.48.92])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 16:35:50 -0700
Date: Mon, 22 Jul 2024 16:25:27 -0700
Message-ID: <87a5i9c8m0.wl-ashutosh.dixit@intel.com>
From: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: intel-gfx@lists.freedesktop.org,
	linux-perf-users@vger.kernel.org,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] drm/i915/pmu: Drop is_igp()
In-Reply-To: <20240722210648.80892-5-lucas.demarchi@intel.com>
References: <20240722210648.80892-1-lucas.demarchi@intel.com>
	<20240722210648.80892-5-lucas.demarchi@intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?ISO-8859-4?Q?Goj=F2?=) APEL-LB/10.8 EasyPG/1.0.0
 Emacs/29.4 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII

On Mon, 22 Jul 2024 14:06:45 -0700, Lucas De Marchi wrote:
>
> There's no reason to hardcode checking for integrated graphics on a
> specific pci slot. That information is already available per platform an
> can be checked with IS_DGFX().

Reviewed-by: Ashutosh Dixit <ashutosh.dixit@intel.com>

> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  drivers/gpu/drm/i915/i915_pmu.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
> index 3a8bd11b87e7..b5d14dd318e4 100644
> --- a/drivers/gpu/drm/i915/i915_pmu.c
> +++ b/drivers/gpu/drm/i915/i915_pmu.c
> @@ -1235,17 +1235,6 @@ static void i915_pmu_unregister_cpuhp_state(struct i915_pmu *pmu)
>	cpuhp_state_remove_instance(cpuhp_slot, &pmu->cpuhp.node);
>  }
>
> -static bool is_igp(struct drm_i915_private *i915)
> -{
> -	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
> -
> -	/* IGP is 0000:00:02.0 */
> -	return pci_domain_nr(pdev->bus) == 0 &&
> -	       pdev->bus->number == 0 &&
> -	       PCI_SLOT(pdev->devfn) == 2 &&
> -	       PCI_FUNC(pdev->devfn) == 0;
> -}
> -
>  void i915_pmu_register(struct drm_i915_private *i915)
>  {
>	struct i915_pmu *pmu = &i915->pmu;
> @@ -1269,7 +1258,7 @@ void i915_pmu_register(struct drm_i915_private *i915)
>	pmu->cpuhp.cpu = -1;
>	init_rc6(pmu);
>
> -	if (!is_igp(i915)) {
> +	if (IS_DGFX(i915)) {
>		pmu->name = kasprintf(GFP_KERNEL,
>				      "i915_%s",
>				      dev_name(i915->drm.dev));
> @@ -1323,7 +1312,7 @@ void i915_pmu_register(struct drm_i915_private *i915)
>	pmu->base.event_init = NULL;
>	free_event_attributes(pmu);
>  err_name:
> -	if (!is_igp(i915))
> +	if (IS_DGFX(i915))
>		kfree(pmu->name);
>  err:
>	drm_notice(&i915->drm, "Failed to register PMU!\n");
> @@ -1351,7 +1340,7 @@ void i915_pmu_unregister(struct drm_i915_private *i915)
>	perf_pmu_unregister(&pmu->base);
>	pmu->base.event_init = NULL;
>	kfree(pmu->base.attr_groups);
> -	if (!is_igp(i915))
> +	if (IS_DGFX(i915))
>		kfree(pmu->name);
>	free_event_attributes(pmu);
>  }
> --
> 2.43.0
>

