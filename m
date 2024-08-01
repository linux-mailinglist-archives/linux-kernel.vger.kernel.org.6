Return-Path: <linux-kernel+bounces-271148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E08944A23
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34AF71C22805
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA17188016;
	Thu,  1 Aug 2024 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L7wmgubd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609761662F1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510658; cv=none; b=ObvwE7DkyRu6+ssDXJKQZbA8E6OFdJ1moTZoMpNZnSQi35mXTJ7At2DyeHAO3ZDcRN6jq1gDKnfJPvy5xZPoxh+8BV5VaOFvonm/jqj5HunGXPBzy4eI2pgiFySYJsYQ56G/vaEbuH/EGCYlc1Kpb0QuUmUxUU9Pd+rwrg04qdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510658; c=relaxed/simple;
	bh=5l9aE1h769+Hwh7h7EbvJTbpdW7mS3Os6L9EY4ofOYk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JZEdiziZ+JqTviYUQs7pv1B9pDXpIYOA3NJpJMasKeofQ3OKo46AW60WLSsSuLYiXPQz5IP+uaKkIaLTWV7LfJ0EPUbjP56b/DA230e+LF3Sj7V8D+CuaC4SOIuRjNQlv2UhWqqDY89oAfaea37NhSaiQlfhdACNglu00rcUaIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L7wmgubd; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722510656; x=1754046656;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=5l9aE1h769+Hwh7h7EbvJTbpdW7mS3Os6L9EY4ofOYk=;
  b=L7wmgubdutV8TLBXQmsllsEXtGUSlZKfHfG8Ko5GVmlisF8UbacVLd9u
   iGC8zwN8FzDFul1UQCiEnVKazxnjH8xqgzIP7TF66MpFkOCAr9BRrQ7z5
   VPgKDTDqUlxZcy7Mq6obIOzE9Cos1BfbuIN1YqO9Wt5wze1H3bHV7moLI
   VMHOzM/kgUsza2VB9vfaWVlJLou7EV7gzpVeqvlsdsVTviCunb3bXrHG6
   NdijNP//ppIBwllTAJpA07pSX+r+8+Y9HXNs1q0/C/+hFFn1TKnVN4uWX
   JJedUNGVI9kB1p2AORzFMhih7ikDCCbdGZRuZ5WZQ0zNcKpYeN5KKojv9
   Q==;
X-CSE-ConnectionGUID: /hGndYTZRTGroLcBYShq/Q==
X-CSE-MsgGUID: LMEtoUcCRwm2JbDIZunK6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="31108180"
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="31108180"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 04:10:56 -0700
X-CSE-ConnectionGUID: Wtj7OfyuR8qKKVMbKXv0Xg==
X-CSE-MsgGUID: 6FzmdjcjTYGEzWOf5F1FnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="54975213"
Received: from jnikula-mobl4.fi.intel.com (HELO localhost) ([10.237.66.160])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 04:10:53 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: abid-sayyad <sayyad.abid16@gmail.com>, airlied@gmail.com
Cc: daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, abid-sayyad <sayyad.abid16@gmail.com>
Subject: Re: [PATCH] drm: Add documentation for struct drm_pane_size_hint
In-Reply-To: <20240801102239.572718-1-sayyad.abid16@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240801102239.572718-1-sayyad.abid16@gmail.com>
Date: Thu, 01 Aug 2024 14:10:50 +0300
Message-ID: <87a5hwwlad.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 01 Aug 2024, abid-sayyad <sayyad.abid16@gmail.com> wrote:
> Fixed warning for the following:
> ./include/uapi/drm/drm_mode.h:869: warning: Function parameter or struct member
> 				'width' not described in 'drm_plane_size_hint'
> ./include/uapi/drm/drm_mode.h:869: warning: Function parameter or struct member
> 				'height' not described in 'drm_plane_size_hint'
>
> Signed-off-by: abid-sayyad <sayyad.abid16@gmail.com>
> ---
>  include/uapi/drm/drm_mode.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index d390011b89b4..b581d384d4b5 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -864,7 +864,13 @@ struct drm_color_lut {
>   * array of struct drm_plane_size_hint.
>   */
>  struct drm_plane_size_hint {
> +	/**
> +	 * @width : width of the plane in pixels.

Please no space before :.

BR,
Jani.

> +	 */
>  	__u16 width;
> +	/**
> +	 * @height : height of the plane in pixels.
> +	 */
>  	__u16 height;
>  };

-- 
Jani Nikula, Intel

