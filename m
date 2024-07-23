Return-Path: <linux-kernel+bounces-259590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E663E939900
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 06:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240E01C21A46
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 04:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FD713C67F;
	Tue, 23 Jul 2024 04:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZsplcYC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D79428E8;
	Tue, 23 Jul 2024 04:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721710449; cv=none; b=UJqZAY6+9PWqIM4C9oOmGFS/xT4TTCXeu/unXGWRPl/yDZnpLA7gM2rdTxGLSgbCsTmoDXIdADa1ECaJ91WSSDkC0UeQvQ6m995RcwMkE9/RSI85d58q1E0sIlEoxgFBoUqaZravlsJb7WSnpGxykLMZzOT/Tk4vUOkucIrkdMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721710449; c=relaxed/simple;
	bh=JG2uTvuHOTSEiYBaoN+6HbN2i7+PPxkKQbrGanmbEA0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dLtdihHsgGHFlWyprhh5jiBEH/wvilV3znwKFo1zqOMi7ELB6RnC5k/sZmCJl8eX9sjNQAKXpW56/Hb+9J4oPUYjs1vOqUkzSm03UArMmXQWz00gNxJi82D3hkBVM6kSjQFVIFu2TTZFU8M1KYe7zgnq2sgue0z8XcQax8P08XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZsplcYC; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721710447; x=1753246447;
  h=date:message-id:from:to:cc:subject:in-reply-to:
   references:mime-version;
  bh=JG2uTvuHOTSEiYBaoN+6HbN2i7+PPxkKQbrGanmbEA0=;
  b=ZZsplcYC5KqDEt+KXpBriLJWbVmAiCVVNnBL8JXcAkn/3vwhhix93dWE
   A+/bvDNGIUkG4PYfGSWITlLmEMyJV5dIkzycTGLyVGwGS/9MQpkm3QW4T
   JvsoSbllKkKxhXpBeE7vT/9KNKyKBznhkPJy1wmhMQ06J9dMAoy+t0xfZ
   x1dU7zaSCp/PK0Aq2LxYUOqxU1p01e/KQzbgReY2IoonXAJ9hKcQ0b7ia
   Yr4m2PtKo07Q0J7kY3z36BKW7lKTOn/GPfdoP1zSi7IId+einaHTz+440
   0Nus9jzJAKhMMgsa9VTU+Y1nIaq9hdMnAyeX987vkOpqCqu3qdiOvwCNy
   Q==;
X-CSE-ConnectionGUID: hNbiXDa5SkuBTB27x6AnRw==
X-CSE-MsgGUID: /Nm158nbQZSU92ef8i6mWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="30699438"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="30699438"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 21:54:07 -0700
X-CSE-ConnectionGUID: nvoczLzaSuu5iY0KO25QYQ==
X-CSE-MsgGUID: 2PlpN+mpTSeS/pftXHIaCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="57219890"
Received: from dmprieto-mobl1.amr.corp.intel.com (HELO adixit-arch.intel.com) ([10.125.48.92])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 21:54:06 -0700
Date: Mon, 22 Jul 2024 21:35:45 -0700
Message-ID: <878qxsd8ta.wl-ashutosh.dixit@intel.com>
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
Subject: Re: [PATCH 3/7] drm/i915/pmu: Use event_to_pmu()
In-Reply-To: <20240722210648.80892-4-lucas.demarchi@intel.com>
References: <20240722210648.80892-1-lucas.demarchi@intel.com>
	<20240722210648.80892-4-lucas.demarchi@intel.com>
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

On Mon, 22 Jul 2024 14:06:44 -0700, Lucas De Marchi wrote:
>
> i915 pointer is not needed in this function and all the others simply
> calculate the i915_pmu container based on the event->pmu. Follow the
> same logic as in other functions.

Reviewed-by: Ashutosh Dixit <ashutosh.dixit@intel.com>

>
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  drivers/gpu/drm/i915/i915_pmu.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
> index cb5f6471ec6e..3a8bd11b87e7 100644
> --- a/drivers/gpu/drm/i915/i915_pmu.c
> +++ b/drivers/gpu/drm/i915/i915_pmu.c
> @@ -820,15 +820,14 @@ static void i915_pmu_event_start(struct perf_event *event, int flags)
>
>  static void i915_pmu_event_stop(struct perf_event *event, int flags)
>  {
> -	struct drm_i915_private *i915 =
> -		container_of(event->pmu, typeof(*i915), pmu.base);
> -	struct i915_pmu *pmu = &i915->pmu;
> +	struct i915_pmu *pmu = event_to_pmu(event);
>
>	if (pmu->closed)
>		goto out;
>
>	if (flags & PERF_EF_UPDATE)
>		i915_pmu_event_read(event);
> +
>	i915_pmu_disable(event);
>
>  out:
> --
> 2.43.0
>

