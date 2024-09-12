Return-Path: <linux-kernel+bounces-326281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F159765D6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28199284EED
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3045F1922CE;
	Thu, 12 Sep 2024 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n0W5qvWg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9744118BB9E
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 09:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726133946; cv=none; b=YsgqmFhoI/iicZWQNPcXyj5c2X2QwircqZ/lSWp57PaZ4Uj+IaclpwZlAs91hgw2rhlZM4K6Ov4fjtXCc1OZ7wmRAF0lN6L6JHAcFPCXoNW4bO03etzXcGE8jGkYJHMez8gzQDYAhS4NDckrtxy1+Km9uc3Qr7rKEq4MRbq4sDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726133946; c=relaxed/simple;
	bh=1+0GP3Fhl1TeD1OEJjKM0XcsNeZlLNpmcfCIBdsnhtc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jHHNURDJo4njfRyuD1r/T9jPeIt/HG5vg+Mkmn4FcAm8CkoAGD1JVQdIUbDrMEp+rhqNcFTepnItgtVg3vVIvHk5paYj3VyHCSY+N/zPl1E88mzs/6FaUtdURuQQ3SPPV0jTPvIkDe6yn8eakg9yWvCxc4ALAPGfibuME6CYavo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n0W5qvWg; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726133945; x=1757669945;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=1+0GP3Fhl1TeD1OEJjKM0XcsNeZlLNpmcfCIBdsnhtc=;
  b=n0W5qvWgPtdCimfdYHOU9QuGX+QRZg2ybyN1Tfl7kZlwUWORn8yjgysz
   dn3GGUYL+z8gCKkr/jUjouKAmWv0fLMsbSR0QJQ89RozNzXdOOmg4OgRW
   8CeanM1eaXr480AOy7dTBdIznxL9cMAAsS4VrY6hEdQHi4MDMoOX4HoXv
   724suO/wlkynKKyjY5Znyh/cGgCElIKR+2vMv0FVyfZnfu0mAn6p565qN
   592jUhwSH9CmYO+RVyZWEClQ+K2tZZUju+6cbojWGIJXcVZq1+eRQKFJi
   /TWMk9z0TUQBLjyReR6O7P2F8iCeOivkv7goeFc3leRRnFAVKnleEU3q7
   Q==;
X-CSE-ConnectionGUID: +IMcYaoRQDu9faBnnlma1A==
X-CSE-MsgGUID: DOfUOmtxQrKv+hSpdedGqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="25171010"
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="25171010"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 02:39:04 -0700
X-CSE-ConnectionGUID: /OrnQwkOT1SwhcYdpQ+5Sg==
X-CSE-MsgGUID: ZhKrTV4FS76Xf2ApDvac0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="72244869"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.253])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 02:39:00 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Tejas Vipin
 <tejasvipin76@gmail.com>, Laurent.pinchart@ideasonboard.com,
 patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/gma500: replace drm_detect_hdmi_monitor() with
 drm_display_info.is_hdmi
In-Reply-To: <988bb389-13e6-4465-ab37-3ed94ecee9be@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240911180650.820598-1-tejasvipin76@gmail.com>
 <b0f77fcc-5d84-4727-9a17-9d1f1e2c5b76@suse.de> <87o74ti7g5.fsf@intel.com>
 <87ldzxi71s.fsf@intel.com> <988bb389-13e6-4465-ab37-3ed94ecee9be@suse.de>
Date: Thu, 12 Sep 2024 12:38:56 +0300
Message-ID: <87y13xgqj3.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 12 Sep 2024, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 12.09.24 um 10:56 schrieb Jani Nikula:
>> Moreover, in this case .detect() only detects digital displays as
>> reported by EDID. If you postpone that to .get_modes(), the probe helper
>> will still report connected, and invent non-EDID fallback modes. The
>> behaviour changes.
>
> The change in behavior is intentional, because the current test seems 
> arbitrary. Does the driver not work with analog outputs?

Not on a DVI/HDMI port. Same with i915.

That's possibly the only way to distinguish a DVI-A display connected to
DVI-D source.


BR,
Jani.


-- 
Jani Nikula, Intel

