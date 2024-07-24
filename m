Return-Path: <linux-kernel+bounces-260862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DC593AF93
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 12:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C93E11C20FF9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 10:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9811155A53;
	Wed, 24 Jul 2024 10:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JAG19PeR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B42814D293;
	Wed, 24 Jul 2024 10:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721815566; cv=none; b=WSvCP+88icmvFbSrlHjB9B5STKGr5xZXgWPjlpuwzaM53rtN/Ids8dRQ7h2whFyTfkB1P3VwwSQdVuBMjVxK3ApFzS3xCH9k/Kf4W1n1VqBSk6meQM6ix0K3Ukl/zfuGh785YOHxvCvfi9OuYeanwkTwqBUXw/M4DFEnhjUeb70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721815566; c=relaxed/simple;
	bh=R6nytAPZD4VSGNeS55Spjqw6SGRF9f95mchzaxhpM1k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=udNnU5bj0jF72wBG8bI7QBM8l+ouLAsh2UmMO9sCElYOkiOJySk4tINAeMOmsGzC9ceXdzcsXb0kRAkFaqb7lfshU1Ln/uF9VFwq8jIMHFKmqGNw+QW1E7QqwTNGlUi0GA8KWGsiIuW4EXayxrzpdCyJ3PzdNfIzkfz+HljPowY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JAG19PeR; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721815565; x=1753351565;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=R6nytAPZD4VSGNeS55Spjqw6SGRF9f95mchzaxhpM1k=;
  b=JAG19PeRt/mvWJ+0XrFZiRPoEa+upklWr5N2wdqAUtejo9eOpUfguhmO
   xHhgPtyN2WNybGiXw7YcXSxFD/Q/QvcqmHuWjP3RSId+mUDvZ8j1xsukn
   c8Wh29BKnGnN0uMBATbLagprd2A97lurgTMr1j+796oDscpfODTbIMUau
   weubgQlFpu3W2sxk8tUFvEU/KIz57p9lXUqoSrTk6/w1Ae8LdIYzTxGDl
   2/LPCTdkJlwvqvzVQJKufWLQY22xsWGQMUztRgj0L+L970ea/7Gwn1egR
   w5xHQPjRqYpl6hFJRHWldFN9nZlDrTkEusGeisqxLD0kxnjnoSMw59MXI
   A==;
X-CSE-ConnectionGUID: K/+n6sedTeOJF85L9BsnUQ==
X-CSE-MsgGUID: GpGBkXHdSg+LQIsG1/v8lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19096981"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="19096981"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 03:06:04 -0700
X-CSE-ConnectionGUID: YtIHWzjnTKi1WnBKn0frTg==
X-CSE-MsgGUID: 23DthYL/QFaQDRvlZzjYGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="56684670"
Received: from iklimasz-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.170])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 03:06:00 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Colin Ian King <colin.i.king@gmail.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/i915/dp: Make read-only array bw_gbps static
 const
In-Reply-To: <20240722153937.574819-1-colin.i.king@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240722153937.574819-1-colin.i.king@gmail.com>
Date: Wed, 24 Jul 2024 13:05:56 +0300
Message-ID: <87frrzf6kb.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 22 Jul 2024, Colin Ian King <colin.i.king@gmail.com> wrote:
> Don't populate the read-only array bw_gbps on the stack at run time,
> instead make it static const.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Pushed to drm-intel-next, thanks for the patch.

BR,
Jani.

> ---
>  drivers/gpu/drm/i915/display/intel_dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 59f11af3b0a1..a082ed8f5464 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -3434,7 +3434,7 @@ static void intel_dp_get_pcon_dsc_cap(struct intel_dp *intel_dp)
>  
>  static int intel_dp_pcon_get_frl_mask(u8 frl_bw_mask)
>  {
> -	int bw_gbps[] = {9, 18, 24, 32, 40, 48};
> +	static const int bw_gbps[] = {9, 18, 24, 32, 40, 48};
>  	int i;
>  
>  	for (i = ARRAY_SIZE(bw_gbps) - 1; i >= 0; i--) {

-- 
Jani Nikula, Intel

