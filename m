Return-Path: <linux-kernel+bounces-385365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E759B3632
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE905B25014
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99AF1DED68;
	Mon, 28 Oct 2024 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V3OYq5QK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51F81DED43
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730132021; cv=none; b=ue0t1lvUxxoLQlpCUo93ZhcOIcqrAq1/wvJED6NcN6vkccG/a+3qQmEoSBEJBskGlF9D1vigqUZNlzAMcOH2IkIEEyF3DpczUd3sEv8njTokJK/L2X0FvNEeoGECjWBYxYnV1XYV8FhW3C31RaIHVIvfdZEGqDd+CO/iyfTyFFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730132021; c=relaxed/simple;
	bh=mROlKK52lgEqYiNfHo/ZXkh8akAZhq+V3ESgp9rVRBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXgIEWd9aGElP8XeSuZQ3mMgfG+nA0GIngOM1kahV3FTCGXBW5MvVwYrk9VMbkTsTjzWaJ5EbL1TNjNhgtJJHvWGSh74ooVCOwyBxqJD37u0pIIBb6Ne9t69K0BSgasNF2IFVOvef6u8BJSLYSUrlEw4OVrX586HhPZwCowAnUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V3OYq5QK; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730132019; x=1761668019;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mROlKK52lgEqYiNfHo/ZXkh8akAZhq+V3ESgp9rVRBU=;
  b=V3OYq5QKEeZBjVtEBQWWEwR80fQz8kljwaWD2rrXnohwg4RcmOfzMler
   VHb49Ew7WlXnIzbByIgqUiYsWxIa41toZBDsSJBEh4FVoULY9pLIEOov/
   5F5Q0qB82a7L/k2k7ZwT2J1xe0ucxcGI1ytflodU7gMUi9NVWrhXojl12
   rZv+QHvvD0bMUDtrPboy3n4fcyzeShL+7a9YCgbr0xJNZ6c1t+hUMgk5W
   FxjoZ/kGRd7wo2IFUkJSr6RSh7F94h0ou6yraZ1Asc6/xFh1F04sumqnX
   g+ZqTaFzbNLUOw6y9l7pAf3vubRaFJ2gP3uJ5c0o1Tork8KG5t91OJqO/
   g==;
X-CSE-ConnectionGUID: 1ch7j51OS+6lVOilh52SBA==
X-CSE-MsgGUID: L8PO0ZkHQF2B6ix3QEZ2uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="47217440"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="47217440"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 09:13:38 -0700
X-CSE-ConnectionGUID: o97lDHrNTLyjP91Ots4lFw==
X-CSE-MsgGUID: o8x44AavSNW8mXaeKhAVvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="81772224"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 28 Oct 2024 09:13:34 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 28 Oct 2024 18:13:34 +0200
Date: Mon, 28 Oct 2024 18:13:34 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: linux@treblig.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] drm/vblank: Remove unused
 drm_crtc_vblank_count_and_time
Message-ID: <Zx-4LsWPQEB_1mED@intel.com>
References: <20241022232934.238124-1-linux@treblig.org>
 <20241022232934.238124-4-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241022232934.238124-4-linux@treblig.org>
X-Patchwork-Hint: comment

On Wed, Oct 23, 2024 at 12:29:32AM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> drm_crtc_vblank_count_and_time() was explicitly added by
> commit cf6483050e9b ("drm/irq: Add drm_crtc_vblank_count_and_time()")
> in 2015, but never used.

I see a bunch of places that could trivially use it.
That might be the more sensible thing to do so that
we keep moving towards using the crtc for everything.

The EXPORT_SYMBOL() looks completely pointless though.

> 
> Remove it, and rework comments that reference it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/gpu/drm/drm_vblank.c | 44 +++++++-----------------------------
>  include/drm/drm_vblank.h     | 10 ++++----
>  2 files changed, 12 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index 94e45ed6869d..67d6367e9f4b 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -908,10 +908,10 @@ drm_get_last_vbltimestamp(struct drm_device *dev, unsigned int pipe,
>   * drm_crtc_accurate_vblank_count() for such use-cases.
>   *
>   * Note that for a given vblank counter value drm_crtc_handle_vblank()
> - * and drm_crtc_vblank_count() or drm_crtc_vblank_count_and_time()
> - * provide a barrier: Any writes done before calling
> - * drm_crtc_handle_vblank() will be visible to callers of the later
> - * functions, if the vblank count is the same or a later one.
> + * and drm_crtc_vblank_count() provide a barrier:
> + * Any writes done before calling drm_crtc_handle_vblank() will be
> + * visible to callers of the later functions, if the vblank count is
> + * the same or a later one.
>   *
>   * See also &drm_vblank_crtc.count.
>   *
> @@ -936,7 +936,6 @@ EXPORT_SYMBOL(drm_crtc_vblank_count);
>   * modesetting activity. Returns corresponding system timestamp of the time
>   * of the vblank interval that corresponds to the current vblank counter value.
>   *
> - * This is the legacy version of drm_crtc_vblank_count_and_time().
>   */
>  static u64 drm_vblank_count_and_time(struct drm_device *dev, unsigned int pipe,
>  				     ktime_t *vblanktime)
> @@ -959,33 +958,6 @@ static u64 drm_vblank_count_and_time(struct drm_device *dev, unsigned int pipe,
>  	return vblank_count;
>  }
>  
> -/**
> - * drm_crtc_vblank_count_and_time - retrieve "cooked" vblank counter value
> - *     and the system timestamp corresponding to that vblank counter value
> - * @crtc: which counter to retrieve
> - * @vblanktime: Pointer to time to receive the vblank timestamp.
> - *
> - * Fetches the "cooked" vblank count value that represents the number of
> - * vblank events since the system was booted, including lost events due to
> - * modesetting activity. Returns corresponding system timestamp of the time
> - * of the vblank interval that corresponds to the current vblank counter value.
> - *
> - * Note that for a given vblank counter value drm_crtc_handle_vblank()
> - * and drm_crtc_vblank_count() or drm_crtc_vblank_count_and_time()
> - * provide a barrier: Any writes done before calling
> - * drm_crtc_handle_vblank() will be visible to callers of the later
> - * functions, if the vblank count is the same or a later one.
> - *
> - * See also &drm_vblank_crtc.count.
> - */
> -u64 drm_crtc_vblank_count_and_time(struct drm_crtc *crtc,
> -				   ktime_t *vblanktime)
> -{
> -	return drm_vblank_count_and_time(crtc->dev, drm_crtc_index(crtc),
> -					 vblanktime);
> -}
> -EXPORT_SYMBOL(drm_crtc_vblank_count_and_time);
> -
>  /**
>   * drm_crtc_next_vblank_start - calculate the time of the next vblank
>   * @crtc: the crtc for which to calculate next vblank time
> @@ -1978,10 +1950,10 @@ EXPORT_SYMBOL(drm_handle_vblank);
>   * This is the native KMS version of drm_handle_vblank().
>   *
>   * Note that for a given vblank counter value drm_crtc_handle_vblank()
> - * and drm_crtc_vblank_count() or drm_crtc_vblank_count_and_time()
> - * provide a barrier: Any writes done before calling
> - * drm_crtc_handle_vblank() will be visible to callers of the later
> - * functions, if the vblank count is the same or a later one.
> + * and drm_crtc_vblank_count() * provide a barrier:
> + * Any writes done before calling * drm_crtc_handle_vblank() will be
> + * visible to callers of the later functions, if the vblank count is
> + * the same or a later one.
>   *
>   * See also &drm_vblank_crtc.count.
>   *
> diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
> index 151ab1e85b1b..572e54425970 100644
> --- a/include/drm/drm_vblank.h
> +++ b/include/drm/drm_vblank.h
> @@ -141,10 +141,10 @@ struct drm_vblank_crtc {
>  	 * Current software vblank counter.
>  	 *
>  	 * Note that for a given vblank counter value drm_crtc_handle_vblank()
> -	 * and drm_crtc_vblank_count() or drm_crtc_vblank_count_and_time()
> -	 * provide a barrier: Any writes done before calling
> -	 * drm_crtc_handle_vblank() will be visible to callers of the later
> -	 * functions, iff the vblank count is the same or a later one.
> +	 * and drm_crtc_vblank_count() provide a barrier:
> +	 * Any writes done before calling drm_crtc_handle_vblank() will be
> +	 * visible to callers of the later functions, iff the vblank count is
> +	 * the same or a later one.
>  	 *
>  	 * IMPORTANT: This guarantee requires barriers, therefor never access
>  	 * this field directly. Use drm_crtc_vblank_count() instead.
> @@ -260,8 +260,6 @@ struct drm_vblank_crtc *drm_crtc_vblank_crtc(struct drm_crtc *crtc);
>  int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs);
>  bool drm_dev_has_vblank(const struct drm_device *dev);
>  u64 drm_crtc_vblank_count(struct drm_crtc *crtc);
> -u64 drm_crtc_vblank_count_and_time(struct drm_crtc *crtc,
> -				   ktime_t *vblanktime);
>  int drm_crtc_next_vblank_start(struct drm_crtc *crtc, ktime_t *vblanktime);
>  void drm_crtc_send_vblank_event(struct drm_crtc *crtc,
>  			       struct drm_pending_vblank_event *e);
> -- 
> 2.47.0

-- 
Ville Syrjälä
Intel

