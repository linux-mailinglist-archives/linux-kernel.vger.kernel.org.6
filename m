Return-Path: <linux-kernel+bounces-404190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 043C69C406D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B7B1C21857
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E769719F12A;
	Mon, 11 Nov 2024 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IIZvOGzY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A9D19CD0E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334346; cv=none; b=PlfK9Ltjt0YLbIVzSfVypJOyZLDSfjcdDwvNrzyzUmGKCOVdeRBI9En8yVdtBvj26likBVtJIFr92KeLzVD30oSARbvSvBpemlWBM2RtUQKGlSIUKcAfzwTxL8ZmtF9zY8xE85kv7ySFl4G2gEiv5Zbb9e0kSGHLLmncHDcXoys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334346; c=relaxed/simple;
	bh=d194LAtbHHA+WQxpTakn4/4xXjdgsxHN5zzVyFMbmZo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DOcw3wryqP5zyy/BQ5ETMv51A4s49bJ9MWC6cMSynKE8LumVVkkBnXcbtx+b+BMB/rLMmetVGT9FwXzOrYIo5UMRjUokZtH3K/EM2BaEihakOaZ5SBFWyaJ2Yf/F/Ac/P8bN7FuZkcq0dGYK4Yryp6HfXr9xG675sA3AjCD604s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IIZvOGzY; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731334345; x=1762870345;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=d194LAtbHHA+WQxpTakn4/4xXjdgsxHN5zzVyFMbmZo=;
  b=IIZvOGzY6sHlW6YxAl4QjWTWnWsUfIvFyw7wUtiscGWX64y0RRjdlUUM
   9vyNZFlrxW1WpcKX66wJRDkukJhnrBWFL5OoRdJCj3OPVVNPdazMPT8vf
   BlvRSTCS9mVkmlBnbtptOG9Tpiy3tipFqTEJb/l5jDKcjWawpzFon2IKs
   1J6wm1i8bol0Af/PAakyO2rv+TsgOKGPxqMDSkVa/edhIftZejK8zGYEL
   Z3pwfxtbgqu5RC8PtWdt5cZOKOZkdnYSmDxFkIxQvTIzcb9cn072oDhQT
   uo0ImhZMvmi13CUvJLNnpmBGt3ikfEmmDF1z1qjcMrBLW6BG/V6fDGpwc
   g==;
X-CSE-ConnectionGUID: 5gwy1huAQK65ALQcrGGFgA==
X-CSE-MsgGUID: dt/AWaObTrizn0xoDwuXtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="56535210"
X-IronPort-AV: E=Sophos;i="6.12,145,1728975600"; 
   d="scan'208";a="56535210"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 06:12:24 -0800
X-CSE-ConnectionGUID: 0O9YeO9nR0mJkqccr+rJfg==
X-CSE-MsgGUID: Ws0h1OM1QryPUar4jSR7LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,145,1728975600"; 
   d="scan'208";a="117864269"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by fmviesa001.fm.intel.com with ESMTP; 11 Nov 2024 06:12:21 -0800
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 alexander.shishkin@linux.intel.com
Subject: Re: [PATCH] hwtracing: Switch back to struct platform_driver::remove()
In-Reply-To: <20241111110922.334610-2-u.kleine-koenig@baylibre.com>
References: <20241111110922.334610-2-u.kleine-koenig@baylibre.com>
Date: Mon, 11 Nov 2024 16:12:20 +0200
Message-ID: <87h68duaez.fsf@ubik.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> writes:

> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
>
> Convert all platform drivers below drivers/hwtracing to use .remove(),
> with the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
>
> Also adapt some whitespace to make indention consistent.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

> ---
> Hello,
>
> I did a single patch for all of drivers/hwtracing. While I usually
> prefer to do one logical change per patch, this seems to be
> overengineering here as the individual changes are really trivial and
> shouldn't be much in the way for stable backports. But I'll happily
> split the patch if you prefer it split. Maybe split for coresight vs.
> intel_th? Also if you object the indentation stuff, I can rework that.

I'm fine with it as is.

> This is based on today's next, if conflicts arise when you apply it at
> some later time and don't want to resolve them, feel free to just drop
> the changes to the conflicting files. I'll notice and followup at a
> later time then. Or ask me for a fixed resend. (Having said that, I
> recommend b4 am -3 + git am -3 which should resolve most conflicts just
> fine.)

Does anybody want to pick this up or should I? I'm fine either way, but
if there are any conflicts they won't be from my end of things, so it
might make sense to take it via the coresight path.

Thanks,
--
Alex

