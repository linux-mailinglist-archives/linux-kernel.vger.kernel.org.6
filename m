Return-Path: <linux-kernel+bounces-179761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ADD8C64F5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 12:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B122A1F24185
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAC35C614;
	Wed, 15 May 2024 10:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RsGu3Riu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF4559154
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715768902; cv=none; b=fTE+tSgmOCJvBeZSGEIYV/doW+PPzXNPb1ieHPvWXUiVii3znuLk+jY1Epv0HvugkMj0hgPmQlqxknckg+cCdlrVNVZfbEGIE6u6unJqbql64ad1RmZxzOw86s2phYUsZqkiec8ED89x7KQhqgxuK0yxYX/s9qi/pLpNCTaNfXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715768902; c=relaxed/simple;
	bh=SZoWlGnmgV61Pl2VHs2CbLi62HpXvCNSpYiN4VVjKVE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rzbdOqo9Nx5dJW+VL6liOKDSv6I2FWZ8a6Mob2HPFe/ovx371avXg+Xo6tHoVbUYgvJeoAZB40KkpxyUePm5uGQ/cI1ony2Sc+5uxJq6zL+0fBEt0Qi7JIQBJ8DB65GTzGEnyILGitjP7+htGgtbFSbC7q0+ofbZuxZ+tf0IK8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RsGu3Riu; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715768900; x=1747304900;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=SZoWlGnmgV61Pl2VHs2CbLi62HpXvCNSpYiN4VVjKVE=;
  b=RsGu3RiuZ9+V5MsQXKWTXR1MDKzAw/DAYbq0pTb8uIJcqLgYAkQb4bs4
   aFYmFBQkJE9YQeqK1THGpl5gfeZsQdBtIClulSxmLWMK7oEgu5iBVq/3b
   ldXSqyqLBEdV2oLLJnsZa1GEZloJ/L5TuODRCAcmIKpriasbdq7xhqbDQ
   S08H5lv9GmxPaOrI3/lrR8MI3UmVOoXY9IDfdNaxSITBm4fCz5BKnuT+g
   6WfhuE4MGaDe3SSmtYs8d0oQ31tuyRn0K3xnlmXyHkAozaxjJQ3f51DkO
   TDOtWg0bEd5gAMQpH0I0akfK0PWHvQ+96r4bzz6p8T2OEeXxEvNhSKq8Y
   A==;
X-CSE-ConnectionGUID: CsZLiZBnQgyEP+kafJVfoA==
X-CSE-MsgGUID: PIYuMFZsSyaq44epXvgfqQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11927594"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="11927594"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 03:28:20 -0700
X-CSE-ConnectionGUID: kMvaXwGjT2+AJuapoRbj7Q==
X-CSE-MsgGUID: L2aWUYKIQD6r7RxqrmwhoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="35480132"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO localhost) ([10.245.246.141])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 03:28:15 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>, Neil Armstrong
 <neil.armstrong@linaro.org>, Maxime Ripard <mripard@kernel.org>, Dmitry
 Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/bridge: Support finding bridge with struct device
In-Reply-To: <cd81893c-ef0b-4906-8c9c-a98b1e4669e6@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240514154045.309925-1-sui.jingfeng@linux.dev>
 <20240514154045.309925-2-sui.jingfeng@linux.dev>
 <87v83fct2e.fsf@intel.com>
 <cd81893c-ef0b-4906-8c9c-a98b1e4669e6@linux.dev>
Date: Wed, 15 May 2024 13:28:11 +0300
Message-ID: <87pltncqtg.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 15 May 2024, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
> Hi,
>
>
> On 5/15/24 17:39, Jani Nikula wrote:
>> On Tue, 14 May 2024, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>>> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
>>> index 584d109330ab..1928d9d0dd3c 100644
>>> --- a/drivers/gpu/drm/drm_bridge.c
>>> +++ b/drivers/gpu/drm/drm_bridge.c
>>> @@ -213,6 +213,23 @@ void drm_bridge_add(struct drm_bridge *bridge)
>>>   }
>>>   EXPORT_SYMBOL(drm_bridge_add);
>>>   
>>> +/**
>>> + * drm_bridge_add_with_dev - add the given bridge to the global bridge list
>>> + *
>>> + * @bridge: bridge control structure
>>> + * @dev: pointer to the kernel device that this bridge is backed.
>>> + */
>>> +void drm_bridge_add_with_dev(struct drm_bridge *bridge, struct device *dev)
>>> +{
>>> +	if (dev) {
>>> +		bridge->kdev = dev;
>>> +		bridge->of_node = dev->of_node;
>>> +	}
>>> +
>>> +	drm_bridge_add(bridge);
>>> +}
>>> +EXPORT_SYMBOL_GPL(drm_bridge_add_with_dev);
>> 
>> I don't actually have an opinion on whether the dev parameter is useful
>> or not.
>> 
>> But please don't add a drm_bridge_add_with_dev() and then convert more
>> than half the drm_bridge_add() users to that. Please just add a struct
>> device *dev parameter to drm_bridge_add(), and pass NULL if it's not
>> relevant.
>> 
>
> To be honest, previously, I'm just do it exactly same as the way you
> told me here. But I'm exhausted and finally give up.
>
> Because this is again need me to modify *all* callers of 
> drm_bridge_add(), not only those bridges in drm/bridge/, but also
> bridge instances in various KMS drivers.
>
> However, their some exceptions just don't fit!
>
> For example, the imx/imx8qxp-pixel-combiner.c just don't fit our
> simple model. Our helper function assume that one device backing
> one drm_bridge instance (1 to 1). Yet, that driver backing two or
> more bridges with one platform device (1 to 2, 1 to 3, ..., ).
> Hence, the imx/imx8qxp-pixel-combiner.c just can't use 
> drm_bridge_add_with_dev().
>
> The aux_hpd_bridge.c is also bad, it store the of_node of struct device 
> at the .platform_data member of the struct device.

Like I said, "pass NULL if it's not relevant."

"_add_with_dev" is a terrible function name.

What if you need to add another parameter later? Add _add_with_foo and
_add_with_dev_and_foo variants?

BR,
Jani.


-- 
Jani Nikula, Intel

