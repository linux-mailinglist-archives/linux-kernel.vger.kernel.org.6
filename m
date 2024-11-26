Return-Path: <linux-kernel+bounces-422296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E389D973A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 13:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE03284069
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 12:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B6C1D0B82;
	Tue, 26 Nov 2024 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EAv8Kn2J"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E363D1CFEDB
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732623863; cv=none; b=rK3SoYOxY7sV2nlpvT+qGB6zFZ8BRAvnU/Wq8gQG4FtW33TTBVwDwT/v/ytW7KnJcG/tzCBi7XhwdvXhqCdzjh/gGFfBv1ZgRIcrrC9ubGb11W5EiuSDbv6iUAcIFMU2QKrnc6LtYM5oYIwmtmph+EIKvAkSzyzR6DwZHURwUlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732623863; c=relaxed/simple;
	bh=ZTHfXgFGRlIILfuHL+qBGlAm9C8PxmMo8Z9AFzfvBdw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dSy9hKSE+fXvsxtB/3bI8rHtFQhhNusuB9HF7WDFUMZIhB7hSQymFfNZ6IkiAOzg/Tg69Abgw2dI5mu/Ay8zYUXAOQA5kNMXwgkiVWg8Dic4+2ouIEstG90+Zzs+ctrHwKq98+fG5J5KFPFuOgPSRaYOUcDwKjW3gpCfTdefUY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EAv8Kn2J; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732623863; x=1764159863;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ZTHfXgFGRlIILfuHL+qBGlAm9C8PxmMo8Z9AFzfvBdw=;
  b=EAv8Kn2J7vahuuWDFlb4BWL8Hu7FQjUqcQbIa778/YL8qNDyVW5Qb9dJ
   4rw6PVYZtigWPKNOqG6/nuMnwJJvZ7gn5M6CZmq28CpJmI/r9aHkRUbV7
   VnUljVkXx0q5Qdaiq4wse7ZO8m+1dPsEWSvlxzQnnxREGr1OLP/tm4wB7
   WwE4h6qJH/K6Ug71TxHlW/RCFpbvEUjOYQDq/xrm52haGor4KfExe7lu0
   jjiBBa+2yIMMntOHLDxXzkPQDaFoWhROkZ7H3+pEosYUTovt5mNKRNSBN
   r9UQ8KtEocVS5Gz+Y7KlDrvUuS03ZLmCdUQZGGi02DmvPx3davr/onFoQ
   w==;
X-CSE-ConnectionGUID: 6+yiyzh7Qw6sbUm1iHqTiQ==
X-CSE-MsgGUID: 8CpeRIhLT4O/sx/jyW6ZLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="55278911"
X-IronPort-AV: E=Sophos;i="6.12,185,1728975600"; 
   d="scan'208";a="55278911"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 04:24:22 -0800
X-CSE-ConnectionGUID: p7mmBzIqQaSRBB7X5+uHcw==
X-CSE-MsgGUID: wzxtY/mSSE24Fp3vXFkb0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="96661073"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.49])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 04:24:15 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Sean Nyekjaer <sean@geanix.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Yannick
 Fertre <yannick.fertre@foss.st.com>, Raphael Gallais-Pou
 <raphael.gallais-pou@foss.st.com>, Philippe Cornu
 <philippe.cornu@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 1/3] drm/modes: introduce drm_mode_validate_mode()
 helper function
In-Reply-To: <20241126-spry-wildebeest-of-cubism-da0a9e@houat>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20241125-dsi-relax-v2-0-9113419f4a40@geanix.com>
 <20241125-dsi-relax-v2-1-9113419f4a40@geanix.com>
 <20241125-gleaming-anteater-of-perfection-42bd2b@houat>
 <874j3uxptp.fsf@intel.com>
 <20241126-spry-wildebeest-of-cubism-da0a9e@houat>
Date: Tue, 26 Nov 2024 14:24:12 +0200
Message-ID: <871pyyxjwz.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 26 Nov 2024, Maxime Ripard <mripard@kernel.org> wrote:
> On Tue, Nov 26, 2024 at 12:16:34PM +0200, Jani Nikula wrote:
>> On Mon, 25 Nov 2024, Maxime Ripard <mripard@kernel.org> wrote:
>> > I wonder about the naming though (and prototype). I doesn't really
>> > validates a mode, but rather makes sure that a given rate is a good
>> > approximation of a pixel clock. So maybe something like
>> > drm_mode_check_pixel_clock?
>> 
>> Quoting myself from a few weeks back:
>> 
>> """
>> Random programming thought of the day: "check" is generally a terrible
>> word in a function name.
>> 
>> Checking stuff is great, but what do you expect to happen if the check
>> passes/fails? Do you expect the function to return on fail, or throw an
>> exception? Or just log about it? If you return a value, what should the
>> return value mean? It's hard to know without looking it up.
>> 
>> Prefer predicates instead, is_stuff_okay() is better than
>> check_stuff(). Or assert_stuff() if you don't return on failures.
>> """
>
> Both is_stuff_okay() or assert_stuff() return a boolean in my mind. If
> you want to return a mode status enum, I don't think they are better
> names.

Most functions returning enum drm_mode_status are called
something_something_mode_valid(). Not check something.

BR,
Jani.


-- 
Jani Nikula, Intel

