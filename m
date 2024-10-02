Return-Path: <linux-kernel+bounces-347413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C38A098D25F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89545282B52
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAA320126B;
	Wed,  2 Oct 2024 11:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N5hxFosR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CC51EC017;
	Wed,  2 Oct 2024 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727869523; cv=none; b=RelhCa7lc6E+QPUGQ9tACx4atyy6WEAwS3ZsI4Qi9CHnkK5KVS4ob5Jpl4Sxh8CsyrCbtKrAYF3fyLsgnNA8B3SDNyvm2nm0nebo6STKYvc9NjUaYz2c+BGqTt6inNI2gw0/gm9RwE8S6Nh7Qn6Fb8I6fhKV7M3FLl+jWFM5q1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727869523; c=relaxed/simple;
	bh=vTcIC5iYWIX8kyGe+9VaZ1HriAauQzandHaKzai+F+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXRbjqXseK+t9o3o2gg6vAqBQfG0khG73QkY3M8UuHaFXf22xqxnLb9WLVigmaIWC+IadtFR328In66qKrK5X4WNE3c5ZdoTk9J0gCiS0wTrOtKcYCQ6CacreyKipYgf5ioVVbn1V2wPsUdu+k8Rb7zdc2jsxXjCcb8halr2/a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N5hxFosR; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727869522; x=1759405522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vTcIC5iYWIX8kyGe+9VaZ1HriAauQzandHaKzai+F+o=;
  b=N5hxFosRlF3XyABv9iYlWsU69I/epxnfnYwJFUVhAgBn6pkHd8/4BlUH
   hsUX4eTbBLNjl8Ed0wX3Ir6c8U8jyUof0v4x9qMpnzxN9TJBa99k+EvaK
   LWw38DQaupYwTrNlrv4BYJ9fhJxQz3uEoU3CuDQcjZ4WrxUNTkgA8yxBg
   3uYnffrdHsj+TnEgiwHBnwjuaUoJowj+BuIyrao1wkh8mOBNNRW56sXou
   AGN/N81yLAkrH/8F+8J/yum4g1Q0H1PG9AMn7arWY5XuZFDw+tgqq43e1
   FicxzpZZUkAt1E9tPgPIs39t6F/yjuqn38ElgOP7BIUIKNm+qmKnFrZfj
   A==;
X-CSE-ConnectionGUID: pcdeJnT0Q02LN2bFkFd6Yg==
X-CSE-MsgGUID: zj6fdlg2Qc28Uz3gLG/j8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="38388355"
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="38388355"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 04:45:21 -0700
X-CSE-ConnectionGUID: 5VVvCXsjTbqrL6m4UF3JtA==
X-CSE-MsgGUID: MJx1Yoh2ROmzs0s9vzeNAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="111446338"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO intel.com) ([10.245.246.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 04:45:15 -0700
Date: Wed, 2 Oct 2024 13:45:11 +0200
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	vegard.nossum@oracle.com, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] drm/i915: Rename functions in the docs to match code
 changes
Message-ID: <Zv0yRyYbepSGZjFR@ashyti-mobl2.lan>
References: <20241001062555.1908090-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001062555.1908090-1-harshit.m.mogalapalli@oracle.com>

Hi Harshit,

On Mon, Sep 30, 2024 at 11:25:54PM -0700, Harshit Mogalapalli wrote:
> make htmldocs is reporting:
> 
> drivers/gpu/drm/i915/i915_irq.c:1: warning: 'intel_runtime_pm_disable_interrupts' not found
> drivers/gpu/drm/i915/i915_irq.c:1: warning: 'intel_runtime_pm_enable_interrupts' not found
> 
> intel_runtime_pm_disable_interrupts() is renamed to intel_irq_suspend(),
> make documentation changes accordingly.
> 
> Fixes: 3de5774cb8c0 ("drm/i915/irq: Rename suspend/resume functions")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/all/20241001134331.7b4d4ca5@canb.auug.org.au/
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks for your patch. The functions were indeed renamed here(*)
by Rodrigo.

I'm going to remove the "Fixes:" tag as I don't think
documentation fixes are part of it. Unless someone wants it
strongly.

Without the Fixes tag:

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Andi

(*) 3de5774cb8c0 ("drm/i915/irq: Rename suspend/resume functions")

> ---
> Noticed that Stephen also reported this so added a Closes URL.
> ---
>  Documentation/gpu/i915.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
> index ad59ae579237..7a469df675d8 100644
> --- a/Documentation/gpu/i915.rst
> +++ b/Documentation/gpu/i915.rst
> @@ -35,10 +35,10 @@ Interrupt Handling
>     :functions: intel_irq_init intel_irq_init_hw intel_hpd_init
>  
>  .. kernel-doc:: drivers/gpu/drm/i915/i915_irq.c
> -   :functions: intel_runtime_pm_disable_interrupts
> +   :functions: intel_irq_suspend
>  
>  .. kernel-doc:: drivers/gpu/drm/i915/i915_irq.c
> -   :functions: intel_runtime_pm_enable_interrupts
> +   :functions: intel_irq_resume
>  
>  Intel GVT-g Guest Support(vGPU)
>  -------------------------------
> -- 
> 2.46.0

