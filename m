Return-Path: <linux-kernel+bounces-289711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B68954AD2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE3EFB21336
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A328F1B8EA6;
	Fri, 16 Aug 2024 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KDajUZ2l"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201761B8E86
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723813953; cv=none; b=jf05ZUBjxndpfgU4aP/xLHA3qu5WJkKWmOsFCclXpN1WAkUXl7AFsihiUHVlYAqEDHJckFJv7wBM2k4bqCT318+3elbFr70PEmKoGRrZiSHrbXN6JPNx++ZXNayTSm4pDVMsStR8xXeyOMiXsN2Llw6b717RpqEfGWEA3BshdU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723813953; c=relaxed/simple;
	bh=CSNRPAmNVIQVfSpw7eMIfJxVBuuHOmb1Ba5ZLcKKGME=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mb30JzsSvABRSMTfWacGM5eSHpCXF/J3FNgmXZl6lil4fbP2+jcqN8d/51NMfkpXebpMe2+I4hmXfgRRDEOZ7URRwABJvyHNvJvY0YlmTTvRTK8qgWmvct2xPuX12m/aDsONmO59YOCnRuS/hpw0yzhr1BY4lEQUijdddO3eVA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KDajUZ2l; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723813950; x=1755349950;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=CSNRPAmNVIQVfSpw7eMIfJxVBuuHOmb1Ba5ZLcKKGME=;
  b=KDajUZ2lBy1xN3d9xQw7V5QE1rRBf1qOVkBScEuOUqqSmd/JzDwvXizP
   nhTRdNQlXzjyTVPDfb/u73vZgPQ9tYbBkq3GrUzBcjRAGKqPU7VlGIOed
   nkc4NzxVNRyEgaZx/uT1B428Fjd1Xc9wj47vSf3Jpt4uyysLOR2yIElDH
   GSWp/aZuFBfzCH0oPq8grq38rFH6tFbB2NcTL0hCo8kodcDnJe4Zc0GX5
   mRdpHGSrolX6bmLXSSVPLNSeH72iJ4A7lBBQ9DdU4WOtC/TL7o1UKuDle
   Uibmqtt3Pp8lx7GP5fscUxTIx6VIXxlwLgwjnE0AnkMWW5FQjJehSr461
   g==;
X-CSE-ConnectionGUID: ZpeZMX1PQ6SdveY0VSK3gg==
X-CSE-MsgGUID: 7Oceoi83S5y6falWgQjf/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="32743500"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="32743500"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 06:12:28 -0700
X-CSE-ConnectionGUID: 8vH0jRjNQTiHB7BsNgeZUg==
X-CSE-MsgGUID: bf53aPjkSO+HYej1rgtMEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="64065126"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.214])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 06:12:26 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 2/2] drm: use mem_is_zero() instead of !memchr_inv(s,
 0, n)
In-Reply-To: <202408150907.5B5C5FCDF@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240814100035.3100852-1-jani.nikula@intel.com>
 <20240814100035.3100852-2-jani.nikula@intel.com>
 <202408150907.5B5C5FCDF@keescook>
Date: Fri, 16 Aug 2024 16:12:20 +0300
Message-ID: <87ed6o7gsr.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 15 Aug 2024, Kees Cook <kees@kernel.org> wrote:
> On Wed, Aug 14, 2024 at 01:00:35PM +0300, Jani Nikula wrote:
>> Use the mem_is_zero() helper where possible.
>> 
>> Conversion done using cocci:
>> 
>> | @@
>> | expression PTR;
>> | expression SIZE;
>> | @@
>> |
>> |   <...
>> | (
>> | - memchr_inv(PTR, 0, SIZE) == NULL
>> | + mem_is_zero(PTR, SIZE)
>> | |
>> | - !memchr_inv(PTR, 0, SIZE)
>> | + mem_is_zero(PTR, SIZE)
>> | |
>> | - memchr_inv(PTR, 0, SIZE)
>> | + !mem_is_zero(PTR, SIZE)
>> | )
>> |   ...>
>> 
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>
> Thanks for these patches! Since drm is the first user, feel free to
> carry it there unless you'd prefer I carry it in my trees?
>
> Reviewed-by: Kees Cook <kees@kernel.org>

Thanks for the reviews. I've gone ahead and merged both to
drm-misc-next, heading for the next merge window.

BR,
Jani.


-- 
Jani Nikula, Intel

