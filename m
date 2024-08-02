Return-Path: <linux-kernel+bounces-272274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B91B945988
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1281C22676
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC5E1C0DE1;
	Fri,  2 Aug 2024 08:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M9J8tg2Z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F1015CD62
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 08:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722586024; cv=none; b=s4LQ+0RnnwseTGD9EQfWpfNvZGCbg1u3h5DrNA2o3fTtou9cxpZ2r7UbufdUR+pLF+uoGCiqVPhIt9UHblSq39zZKnfPUDnnDJpx9ShdaF0kB58jJysDZQNwBlXRfhrPkGuKngS0GLmcc3JT/Og6iqh/xuQdUxU6WaMQKja5I0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722586024; c=relaxed/simple;
	bh=eNErd0gPp6JE2ltIsD8Hu8U2ej3I5B2e5zQu6VBQtqk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KtrjRg+o1gxqECXwY1AHRbJcgqCpJkzlgv1FlOhW83TQI61aqEYRSqFLWuvXUzFZ90NE+lxzfkeieqdPY+lpazoA1nH53Q2yjDmOeTByvYd7LqSST/VTuSzSGCOaSpDBUX2+Q9c1//4vwgxxIrH0KwQ8N0akF9BQ3zTz5iv3RlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M9J8tg2Z; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722586022; x=1754122022;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=eNErd0gPp6JE2ltIsD8Hu8U2ej3I5B2e5zQu6VBQtqk=;
  b=M9J8tg2ZXM85tPUfSN0cg4DZRJVHWw9YLUvTqBE6U6/zZC2RMLAP5kKE
   pt9PBFMGF9NMTKNy/NmJ7XRFpe8Sf+EKLmtTzKfalAsp/rl2E2/zriybO
   6usBUO47a3bDY8w3Ve/m2/ND/EpeBNRIvx6zIoZj4bGXweBn5caciEt3T
   FaS5TmSOwaspTLmq6Xa0h3Pe/i7it2o6R9ovf6QN2u6uAbdNhsh9xR5ve
   jp7ovvMKEv8GuvYqslmphiu87yEOeIjlCm6Qtx19dKt8STVTLOvWQ65BZ
   BWmzL9UuqEGHTSGifKkgN+H21JqO/o55jbHgWSlnRvHwX7fNS/RHDDaHg
   g==;
X-CSE-ConnectionGUID: /kMBre8CQ7OYOO4PqGWeMQ==
X-CSE-MsgGUID: 8XtF26dAT9Oju8dVBstxLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="24377872"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="24377872"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 01:07:01 -0700
X-CSE-ConnectionGUID: GEyKm2UnQYeMlsEPNcaocQ==
X-CSE-MsgGUID: wk885wdcTKCmNNSiYCq02w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="54965399"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.66])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 01:06:59 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: abid-sayyad <sayyad.abid16@gmail.com>, airlied@gmail.com
Cc: daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, abid-sayyad <sayyad.abid16@gmail.com>
Subject: Re: [PATCH v2] drm: Add documentation for struct drm_pane_size_hint
In-Reply-To: <20240801130112.1317239-1-sayyad.abid16@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240801130112.1317239-1-sayyad.abid16@gmail.com>
Date: Fri, 02 Aug 2024 11:06:53 +0300
Message-ID: <875xsj73he.fsf@intel.com>
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
> My sincere apologies for the spam and the patch subject error

Usually there's no need to resend, at least not immediately, because of
issues in the subject or the commit message. Many of them can be fixed
while applying, and if not, you'll be asked to fix and resend.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>


> Changes in v2:
> - Adress review feedback regarding indentation in the fix
> - Link to v1
> https://lore.kernel.org/all/20240801102239.572718-1-sayyad.abid16@gmail.com/
>
>  include/uapi/drm/drm_mode.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index d390011b89b4..9d398335d871 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -864,7 +864,13 @@ struct drm_color_lut {
>   * array of struct drm_plane_size_hint.
>   */
>  struct drm_plane_size_hint {
> +	/**
> +	 * @width: width of the plane in pixels.
> +	 */
>  	__u16 width;
> +	/**
> +	 * @height: height of the plane in pixels.
> +	 */
>  	__u16 height;
>  };
>
> --
> 2.39.2
>

-- 
Jani Nikula, Intel

