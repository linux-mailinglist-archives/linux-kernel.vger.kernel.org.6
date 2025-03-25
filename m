Return-Path: <linux-kernel+bounces-575140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C306BA6EE2E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0786B3A5B55
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9181EF0B9;
	Tue, 25 Mar 2025 10:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BbQf5gxz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4157EC4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899678; cv=none; b=j2xcsJ87pqypJoW47X/qfJwYPLi9QsPyb9zgVGLZryxu9+ufW6bu2OPccei3y5XBvFRQDPRhJmLbuVGJo7cuskmG+AVOR3wt2sLKfO6oiJ8cXTOLgmS7QuujnE/tOfGdhjzB7HGZ/2G/TuootmEFaCyKNkis6WUJhtwsL62ahKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899678; c=relaxed/simple;
	bh=pRFdoRxHQv4ASkQQbPf/QJW+Fkq5GR+papCZB7h7xWQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ocVMDmpbeab+Qr5F78t+Cemd3byO4cs8Y/PQHGk8ZUjzMV9oFS3OIM8K/69rUtSErKVPtTwnkYBq+gTqJkiotiqFWFQmwfbiQjEaCPzpvft60BgJcufAHumuHmdTbuQ7YS19nihN7hzcH17w+EIy8HYUmFWDLAnEZaFU9lyLxNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BbQf5gxz; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742899675; x=1774435675;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=pRFdoRxHQv4ASkQQbPf/QJW+Fkq5GR+papCZB7h7xWQ=;
  b=BbQf5gxzSfGd2K7A/UDhgS+VmlXEqwVwrrb2BZIHPmccKqP7t92iqlxk
   BoF0kzv7Nqk+TEZFgQripSgR1XmUmZDaVH4Ngn9MrIyXNpMWIInHDizmb
   QXk2SKR+2T4RYsSlG8/NlevFzZJnQI2pxg7gTsANRvr2drnOvctGPqt9u
   9Lp29IQSL48FBKh/gFsPMfrJYlE2SUTbcLcH0cLi+nPEorrcWUhJTQk8f
   CGWeU2bW6TEGgQXraZgyjRdC04EOOZpAUQBxCBWPH4GQzLwkhW6zhNAP8
   cf0jgAxsyWmWUPjhQ1wMfogxmIq+kRHo2sdL+0Axf/NyHUnLItd+xBmsf
   A==;
X-CSE-ConnectionGUID: 3L7Gh7jkQ6yhkS8G8g+qzw==
X-CSE-MsgGUID: 4L0+4ryQR/+RCTWkLSmE4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="43864138"
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="43864138"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 03:47:55 -0700
X-CSE-ConnectionGUID: 29i981N9Ru+pvd9UBP+X9w==
X-CSE-MsgGUID: u86+9+DOQpaMYgpMgvreWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="124058557"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.134])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 03:47:52 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: devbrones <jonas.cronholm@protonmail.com>,
 maarten.lankhorst@linux.intel.com, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/edid: Add non-desktop quirk for Playstation VR
 Headsets with Product ID 0xB403
In-Reply-To: <20250325-inquisitive-ebony-mouse-bdf185@houat>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250322122048.28677-1-jonas.cronholm@protonmail.com>
 <875xjxa2rk.fsf@intel.com> <20250325-inquisitive-ebony-mouse-bdf185@houat>
Date: Tue, 25 Mar 2025 12:47:49 +0200
Message-ID: <87pli58jze.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 25 Mar 2025, Maxime Ripard <mripard@kernel.org> wrote:
> On Tue, Mar 25, 2025 at 11:16:47AM +0200, Jani Nikula wrote:
>> On Sat, 22 Mar 2025, devbrones <jonas.cronholm@protonmail.com> wrote:
>> > This fixes a bug where some Playstation VR Headsets would not be assigned
>> > the EDID_QUIRK_NON_DESKTOP quirk, causing them to be inaccessible by
>> > certain software under Wayland.
>> 
>> Please file a bug over at [1], and attach the EDID on that bug, so we
>> have some clue what's going on.
>>
>> [1] https://gitlab.freedesktop.org/drm/misc/kernel/-/issues/new
>
> I'd rather have them in the commit log. Nobody uses gitlab issues for
> drm-misc, and those kind of issues are just lingering around and
> becoming stale.

For this one, it's fine as long as we preserve the raw EDID for
posterity. Unless the EDID does indicate VR and we need to dig deeper,
that is.

BR,
Jani.

-- 
Jani Nikula, Intel

