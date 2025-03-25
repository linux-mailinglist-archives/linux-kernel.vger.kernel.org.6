Return-Path: <linux-kernel+bounces-575588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C4DA70484
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F283ABBC1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F9C258CD6;
	Tue, 25 Mar 2025 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hvMhKkNg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8786C208AD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742915036; cv=none; b=beLgjD3GexG2FHa5BeE4uMuvy0PJS92+3bmbpfrbKHwxjj85o79dFF35tgMghQlj4fF+Bsva9cB9a7/LjA3+FitjP9dYQR+PHv2//jPqp1/Su3vDwfGLFHWdHtsnCWT62gljYivse0mZzIR0ILFAkbIkZ8t7rVwAG1JsPmmZkxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742915036; c=relaxed/simple;
	bh=kFbh0LlV4qyD9Zc+BpYtdVXJlfeuU7uh04pxDYsqlmE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bpIYUKHVQTt8uwXbohRcum5HKiQ5fVddGc6wccml1zq9/bi2uFKOGSxwxQmrLlVHnZvnh7V9CTIJfQXhCwcpc9M+xFfOn07QtLfofMZn+TksXe7iesJRRGxUOfhBAxrPAbk4LQUwPso5INg8mAJeRBhwy/eiy8lUUWIQgQ1oFWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hvMhKkNg; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742915034; x=1774451034;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=kFbh0LlV4qyD9Zc+BpYtdVXJlfeuU7uh04pxDYsqlmE=;
  b=hvMhKkNg8HTY5nHWqfH1XQZmdVe8BLcbF2cxGJTcmWd64vo7zGAcx1bJ
   XhRCduvuqYm+aVxxqQwoz9REawBh0LoDgAj9ALeGNGmFZd1C02PPQPLVA
   a1gJfZesRhRcoNhpDyFARM8RLG7rouzyF6rWPF1MbjO27WIEgYsVy2CsL
   4jFIzRewfJOyKQS+7exsqr/vBpvS2Ku1/mukHIAOXcxP0nGrOG32xKGW6
   Ky5PDl1OsuSgFXZM8sgN9htYMArZhYoEkvl5DcbfGx7dTmiAmh1ScaNVU
   SVdFvH4eKkBh/husIWzj3L1qZ6sRuaTDujOEK6dT/w+1QYQH+7YJ24Lpn
   A==;
X-CSE-ConnectionGUID: aHreRGUMQLyM6lmqTYMJlw==
X-CSE-MsgGUID: C9zrUPzLTveUOXz/7+XJiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="31769682"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="31769682"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 08:03:53 -0700
X-CSE-ConnectionGUID: DMDtKWK4Rae/QIGFg7jTfg==
X-CSE-MsgGUID: tg4WBIDZRqSUcwN/2lvOmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="124374348"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.134])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 08:03:50 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: devbrones <jonas.cronholm@protonmail.com>,
 maarten.lankhorst@linux.intel.com, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/edid: Add non-desktop quirk for Playstation VR
 Headsets with Product ID 0xB403
In-Reply-To: <20250325-annoying-precise-uakari-6b6438@houat>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250322122048.28677-1-jonas.cronholm@protonmail.com>
 <875xjxa2rk.fsf@intel.com> <20250325-inquisitive-ebony-mouse-bdf185@houat>
 <87pli58jze.fsf@intel.com> <20250325-annoying-precise-uakari-6b6438@houat>
Date: Tue, 25 Mar 2025 17:03:46 +0200
Message-ID: <87h63h884t.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 25 Mar 2025, Maxime Ripard <mripard@kernel.org> wrote:
> On Tue, Mar 25, 2025 at 12:47:49PM +0200, Jani Nikula wrote:
>> On Tue, 25 Mar 2025, Maxime Ripard <mripard@kernel.org> wrote:
>> > On Tue, Mar 25, 2025 at 11:16:47AM +0200, Jani Nikula wrote:
>> >> On Sat, 22 Mar 2025, devbrones <jonas.cronholm@protonmail.com> wrote:
>> >> > This fixes a bug where some Playstation VR Headsets would not be assigned
>> >> > the EDID_QUIRK_NON_DESKTOP quirk, causing them to be inaccessible by
>> >> > certain software under Wayland.
>> >> 
>> >> Please file a bug over at [1], and attach the EDID on that bug, so we
>> >> have some clue what's going on.
>> >>
>> >> [1] https://gitlab.freedesktop.org/drm/misc/kernel/-/issues/new
>> >
>> > I'd rather have them in the commit log. Nobody uses gitlab issues for
>> > drm-misc, and those kind of issues are just lingering around and
>> > becoming stale.
>> 
>> For this one, it's fine as long as we preserve the raw EDID for
>> posterity. Unless the EDID does indicate VR and we need to dig deeper,
>> that is.
>
> What I was trying to say is if "posterity" means "a forever open issue
> in drm-misc", then no, sorry, that doesn't work for me.

I want to check the EDID before we merge the quirk.

If the EDID does not indicate VR, we can merge. I want the EDID
preserved so we can track them down later if we need to drop or modify
the quirks.

If the EDID does indicate VR, either the quirk is unnecessary or there's
a bug somewhere. This requires further debugging, and we must not merge
the quirk.


BR,
Jani.


-- 
Jani Nikula, Intel

