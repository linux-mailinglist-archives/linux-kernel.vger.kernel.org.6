Return-Path: <linux-kernel+bounces-230434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98607917CCB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42AE11F22BF7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA8516CD19;
	Wed, 26 Jun 2024 09:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AW9RFeWE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A521E1684A4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 09:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719395074; cv=none; b=OC31SjfxAILDDijf6KMEt15niMfvE5KnosfdyzsNbODCJeJIDEuX61sBKKrJ2+gAzSqNBK3Yyk/pX7VwnldV330fpJuanm6QCygETMO7haA7Osi2xeC5rAsDPX0+VrGQmQUFhKmp9x1IV2oXucM3XXC9HE43rrS1hpAX6WreEQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719395074; c=relaxed/simple;
	bh=8oj6vqU/PrvAFjUQi14sL3u4RL2wfEfrUPz8HaO20Cg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DmNOuLYbnzHQJCg0fkhRNIwOdDR5LmZF+1wg8APtgZsS99nYTdjYuVgwZupgNDdvh/1DgyX8CBTvLQJS/MraZncygwatkVOWgsCG4uIJV+LvgYKAlqXuZtPgtoK6JnQBp1WvefN1vNg7azDr/bTNaCGQKqtXotHYcRdjE9E9/VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AW9RFeWE; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719395072; x=1750931072;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=8oj6vqU/PrvAFjUQi14sL3u4RL2wfEfrUPz8HaO20Cg=;
  b=AW9RFeWEIgAiZccyE/weKfsQ/jVlI7nC2ruJtJr76rJ+bw4A+ZGqzyA2
   enxn3P0oRNueun68It0ubDPC7wT9LJhV3CSQ1NjynZCIGrhO3zZyWiLek
   1wrrqmaAzzb+anh49VKECax8Eu7h35+HkvxOrnm97RcuEi8QoaFwecgyO
   iOw4jQU0fYrJZr82a0l7VZ6gO6fko7TqCGJeJSonQaGptQUjVSldhcq+5
   IW91dCgt78/rSVwRYSPaGn0iGyDuOufQIeYr40jErEo8eCSAJF6irSOb1
   40qHGzikZJbBe8/StV97Zclrj43m/3cO17WbOSriNZaazxs1gSQITkXrK
   g==;
X-CSE-ConnectionGUID: 71jsrH+2Tt2g+NzgGOaORw==
X-CSE-MsgGUID: YUm2FsynSNWJmSvWV1CTkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16598041"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="16598041"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 02:44:31 -0700
X-CSE-ConnectionGUID: 7FTY5V5eSnyjRNefLzoS/A==
X-CSE-MsgGUID: oZKct96xRY2xVb/2TmCQIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="75154744"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.95])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 02:44:28 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ma Ke <make24@iscas.ac.cn>, kherbst@redhat.com, lyude@redhat.com,
 dakr@redhat.com, airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ma Ke <make24@iscas.ac.cn>
Subject: Re: [PATCH] drm/nouveau: fix null pointer dereference in
 nouveau_connector_get_modes
In-Reply-To: <20240626013013.2765395-1-make24@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240626013013.2765395-1-make24@iscas.ac.cn>
Date: Wed, 26 Jun 2024 12:44:21 +0300
Message-ID: <875xtwdone.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 26 Jun 2024, Ma Ke <make24@iscas.ac.cn> wrote:
> In nouveau_connector_get_modes(), the return value of drm_mode_duplicate()
> is assigned to mode, which will lead to a possible NULL pointer
> dereference on failure of drm_mode_duplicate(). Add a check to avoid npd.
>
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/gpu/drm/nouveau/nouveau_connector.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
> index 856b3ef5edb8..010eed56b14d 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -1001,6 +1001,8 @@ nouveau_connector_get_modes(struct drm_connector *connector)
>  		struct drm_display_mode *mode;
>  
>  		mode = drm_mode_duplicate(dev, nv_connector->native_mode);
> +		if (!mode)
> +			return -ENOMEM;

Do not return negative values from .get_modes().

BR,
Jani.

>  		drm_mode_probed_add(connector, mode);
>  		ret = 1;
>  	}

-- 
Jani Nikula, Intel

