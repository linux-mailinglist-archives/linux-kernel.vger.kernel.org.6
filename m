Return-Path: <linux-kernel+bounces-271144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B8C944A1C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4609F1C22440
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11E9187FE4;
	Thu,  1 Aug 2024 11:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TLaDy3/v"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8671662F1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 11:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510566; cv=none; b=AlK7MrUaQax+6LivWWx6Ujkpiaj86aQ7Pc4I7rN+4wxEDwQ9tHynSkcfduBk7HqzS0Ss4jKb92YTkwQJKVqzFoPzMo8H7PWUSqspbTt68lG634myuMbDxU+wUaSvaVlEigfOXhrGBbHNVo9zp2sZt9k32ORwc7EUSKX33sC8STo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510566; c=relaxed/simple;
	bh=N0vUjFMeraSmnWiWFVlkuWQJYL07Yl5H9H8muw1J3v4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q8lmBoJFnavhAS3PQaeQXBghStVW0SfQI0TEr7+OSyL06SAdBFJPEY91yXAx2VJqAA4UqPwzDJoqzgMlaNRZqbPD5dibpencxBfFHAxJ4EJSji0GHXmMxHtyUIwNvy/f4ilEJ/e8pZRSxbz+/sFEYEWqRPxYzUqeXLGUPhcNPDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TLaDy3/v; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722510564; x=1754046564;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=N0vUjFMeraSmnWiWFVlkuWQJYL07Yl5H9H8muw1J3v4=;
  b=TLaDy3/vliLRK86ArXhhjX7fgn7PsmIM5cr6AVAMBpt+cRSmRpih6Ptx
   xqB1NdeS2w129+8uVXc2QUHth+IFCEDF3CxzqxA7xZbCj4RfULulPqD5q
   XBd0D29VfQ6Kt+prx1Bv/B7oqMjRCAKHIzsL3x6WAQeKu+lS6iUuKy4RO
   899HoGcSV3E7F+v3dOV/WKgDDdFQmrEBJ+6voSNGvYZJTM1Jet6wbMKd1
   KU5FGUe7kb5pGzKjnDROfoosQRv5r7pvXkHTOHlkAU4BKQUlSDOVRIdbP
   y3+DzmxsMns3x166XliM/+hfqNfnvgWUAP8wvi1d5WPXm4YFr4IuV94o9
   g==;
X-CSE-ConnectionGUID: uXI7cn7GRiavx8rRNqVcNA==
X-CSE-MsgGUID: Kn9APfU6TTa6rSmQ0dsMMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="31090284"
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="31090284"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 04:09:23 -0700
X-CSE-ConnectionGUID: Tpz9ZdgUSLy08L9k8zDj3g==
X-CSE-MsgGUID: 2te1x6H3RpuQoogx06rR5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="92528649"
Received: from jnikula-mobl4.fi.intel.com (HELO localhost) ([10.237.66.160])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 04:09:19 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Tejas Vipin <tejasvipin76@gmail.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, neil.armstrong@linaro.org,
 quic_jesszhan@quicinc.com
Cc: dianders@chromium.org, airlied@gmail.com, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Tejas Vipin
 <tejasvipin76@gmail.com>
Subject: Re: [PATCH v2 1/2] drm/mipi-dsi: add more multi functions for
 better error handling
In-Reply-To: <20240730060659.455953-2-tejasvipin76@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240730060659.455953-1-tejasvipin76@gmail.com>
 <20240730060659.455953-2-tejasvipin76@gmail.com>
Date: Thu, 01 Aug 2024 14:09:15 +0300
Message-ID: <87cymswld0.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 30 Jul 2024, Tejas Vipin <tejasvipin76@gmail.com> wrote:
> Add more functions that can benefit from being multi style and mark
> older variants as deprecated to eventually convert all mipi_dsi functions
> to multi style.

What?

Why would a lot of regular DSI commands that are not exclusively used
for one time setup need to be deprecated or converted to _multi()?

BR,
Jani.

>
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c | 226 +++++++++++++++++++++++++++++++++
>  include/drm/drm_mipi_dsi.h     |  12 ++
>  2 files changed, 238 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
> index a471c46f5ca6..05ea7df5dec1 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> @@ -603,6 +603,8 @@ EXPORT_SYMBOL(mipi_dsi_shutdown_peripheral);
>   * mipi_dsi_turn_on_peripheral() - sends a Turn On Peripheral command
>   * @dsi: DSI peripheral device
>   *
> + * This function is deprecated. Use mipi_dsi_turn_on_peripheral_multi() instead.
> + *
>   * Return: 0 on success or a negative error code on failure.
>   */
>  int mipi_dsi_turn_on_peripheral(struct mipi_dsi_device *dsi)
> @@ -652,6 +654,7 @@ EXPORT_SYMBOL(mipi_dsi_set_maximum_return_packet_size);
>   * @pps_selector: Select PPS from the table of pre-stored or uploaded PPS entries
>   *
>   * Enable or disable Display Stream Compression on the peripheral.
> + * This function is deprecated. Use mipi_dsi_compression_mode_ext_multi() instead.
>   *
>   * Return: 0 on success or a negative error code on failure.
>   */
> @@ -703,6 +706,7 @@ EXPORT_SYMBOL(mipi_dsi_compression_mode);
>   * @pps: VESA DSC 1.1 Picture Parameter Set
>   *
>   * Transmit the VESA DSC 1.1 Picture Parameter Set to the peripheral.
> + * This function is deprecated. Use mipi_dsi_picture_parameter_set_multi() instead.
>   *
>   * Return: 0 on success or a negative error code on failure.
>   */
> @@ -1037,6 +1041,8 @@ EXPORT_SYMBOL(mipi_dsi_dcs_read);
>   * mipi_dsi_dcs_nop() - send DCS nop packet
>   * @dsi: DSI peripheral device
>   *
> + * This function is deprecated. Use mipi_dsi_dcs_nop_multi() instead.
> + *
>   * Return: 0 on success or a negative error code on failure.
>   */
>  int mipi_dsi_dcs_nop(struct mipi_dsi_device *dsi)
> @@ -1055,6 +1061,8 @@ EXPORT_SYMBOL(mipi_dsi_dcs_nop);
>   * mipi_dsi_dcs_soft_reset() - perform a software reset of the display module
>   * @dsi: DSI peripheral device
>   *
> + * This function is deprecated. Use mipi_dsi_dcs_soft_reset_multi() instead.
> + *
>   * Return: 0 on success or a negative error code on failure.
>   */
>  int mipi_dsi_dcs_soft_reset(struct mipi_dsi_device *dsi)
> @@ -1124,6 +1132,8 @@ EXPORT_SYMBOL(mipi_dsi_dcs_get_pixel_format);
>   *    display module except interface communication
>   * @dsi: DSI peripheral device
>   *
> + * This function is deprecated. Use mipi_dsi_dcs_enter_sleep_mode_multi() instead.
> + *
>   * Return: 0 on success or a negative error code on failure.
>   */
>  int mipi_dsi_dcs_enter_sleep_mode(struct mipi_dsi_device *dsi)
> @@ -1143,6 +1153,8 @@ EXPORT_SYMBOL(mipi_dsi_dcs_enter_sleep_mode);
>   *    module
>   * @dsi: DSI peripheral device
>   *
> + * This function is deprecated. Use mipi_dsi_dcs_exit_sleep_mode_multi() instead.
> + *
>   * Return: 0 on success or a negative error code on failure.
>   */
>  int mipi_dsi_dcs_exit_sleep_mode(struct mipi_dsi_device *dsi)
> @@ -1162,6 +1174,8 @@ EXPORT_SYMBOL(mipi_dsi_dcs_exit_sleep_mode);
>   *    display device
>   * @dsi: DSI peripheral device
>   *
> + * This function is deprecated. Use mipi_dsi_dcs_set_display_off_multi() instead.
> + *
>   * Return: 0 on success or a negative error code on failure.
>   */
>  int mipi_dsi_dcs_set_display_off(struct mipi_dsi_device *dsi)
> @@ -1181,6 +1195,8 @@ EXPORT_SYMBOL(mipi_dsi_dcs_set_display_off);
>   *    display device
>   * @dsi: DSI peripheral device
>   *
> + * This function is deprecated. Use mipi_dsi_dcs_set_display_on_multi() instead.
> + *
>   * Return: 0 on success or a negative error code on failure
>   */
>  int mipi_dsi_dcs_set_display_on(struct mipi_dsi_device *dsi)
> @@ -1202,6 +1218,9 @@ EXPORT_SYMBOL(mipi_dsi_dcs_set_display_on);
>   * @start: first column of frame memory
>   * @end: last column of frame memory
>   *
> + * This function is deprecated. Use mipi_dsi_dcs_set_column_address_multi()
> + * instead.
> + *
>   * Return: 0 on success or a negative error code on failure.
>   */
>  int mipi_dsi_dcs_set_column_address(struct mipi_dsi_device *dsi, u16 start,
> @@ -1226,6 +1245,9 @@ EXPORT_SYMBOL(mipi_dsi_dcs_set_column_address);
>   * @start: first page of frame memory
>   * @end: last page of frame memory
>   *
> + * This function is deprecated. Use mipi_dsi_dcs_set_page_address_multi()
> + * instead.
> + *
>   * Return: 0 on success or a negative error code on failure.
>   */
>  int mipi_dsi_dcs_set_page_address(struct mipi_dsi_device *dsi, u16 start,
> @@ -1268,6 +1290,8 @@ EXPORT_SYMBOL(mipi_dsi_dcs_set_tear_off);
>   * @dsi: DSI peripheral device
>   * @mode: the Tearing Effect Output Line mode
>   *
> + * This function is deprecated. Use mipi_dsi_dcs_set_tear_on_multi() instead.
> + *
>   * Return: 0 on success or a negative error code on failure
>   */
>  int mipi_dsi_dcs_set_tear_on(struct mipi_dsi_device *dsi,
> @@ -1291,6 +1315,9 @@ EXPORT_SYMBOL(mipi_dsi_dcs_set_tear_on);
>   * @dsi: DSI peripheral device
>   * @format: pixel format
>   *
> + * This function is deprecated. Use mipi_dsi_dcs_set_pixel_format_multi()
> + * instead.
> + *
>   * Return: 0 on success or a negative error code on failure.
>   */
>  int mipi_dsi_dcs_set_pixel_format(struct mipi_dsi_device *dsi, u8 format)
> @@ -1334,6 +1361,9 @@ EXPORT_SYMBOL(mipi_dsi_dcs_set_tear_scanline);
>   * @dsi: DSI peripheral device
>   * @brightness: brightness value
>   *
> + * This function is deprecated. Use mipi_dsi_dcs_set_display_brightness_multi()
> + * instead.
> + *
>   * Return: 0 on success or a negative error code on failure.
>   */
>  int mipi_dsi_dcs_set_display_brightness(struct mipi_dsi_device *dsi,
> @@ -1357,6 +1387,9 @@ EXPORT_SYMBOL(mipi_dsi_dcs_set_display_brightness);
>   * @dsi: DSI peripheral device
>   * @brightness: brightness value
>   *
> + * This function is deprecated. Use mipi_dsi_dcs_get_display_brightness_multi()
> + * instead.
> + *
>   * Return: 0 on success or a negative error code on failure.
>   */
>  int mipi_dsi_dcs_get_display_brightness(struct mipi_dsi_device *dsi,
> @@ -1639,6 +1672,199 @@ void mipi_dsi_dcs_set_tear_on_multi(struct mipi_dsi_multi_context *ctx,
>  }
>  EXPORT_SYMBOL(mipi_dsi_dcs_set_tear_on_multi);
>  
> +/**
> + * mipi_dsi_turn_on_peripheral_multi() - sends a Turn On Peripheral command
> + * @ctx: Context for multiple DSI transactions
> + *
> + * Like mipi_dsi_turn_on_peripheral() but deals with errors in a way that
> + * makes it convenient to make several calls in a row.
> + */
> +void mipi_dsi_turn_on_peripheral_multi(struct mipi_dsi_multi_context *ctx)
> +{
> +	struct mipi_dsi_device *dsi = ctx->dsi;
> +	struct device *dev = &dsi->dev;
> +	int ret;
> +
> +	if (ctx->accum_err)
> +		return;
> +
> +	ret = mipi_dsi_turn_on_peripheral(dsi);
> +	if (ret < 0) {
> +		ctx->accum_err = ret;
> +		dev_err(dev, "Failed to turn on peripheral: %d\n",
> +			ctx->accum_err);
> +	}
> +}
> +EXPORT_SYMBOL(mipi_dsi_turn_on_peripheral_multi);
> +
> +/**
> + * mipi_dsi_dcs_soft_reset_multi() - perform a software reset of the display module
> + * @ctx: Context for multiple DSI transactions
> + *
> + * Like mipi_dsi_dcs_soft_reset() but deals with errors in a way that
> + * makes it convenient to make several calls in a row.
> + */
> +void mipi_dsi_dcs_soft_reset_multi(struct mipi_dsi_multi_context *ctx)
> +{
> +	struct mipi_dsi_device *dsi = ctx->dsi;
> +	struct device *dev = &dsi->dev;
> +	int ret;
> +
> +	if (ctx->accum_err)
> +		return;
> +
> +	ret = mipi_dsi_dcs_soft_reset(dsi);
> +	if (ret < 0) {
> +		ctx->accum_err = ret;
> +		dev_err(dev, "Failed to mipi_dsi_dcs_soft_reset: %d\n",
> +			ctx->accum_err);
> +	}
> +}
> +EXPORT_SYMBOL(mipi_dsi_dcs_soft_reset_multi);
> +
> +/**
> + * mipi_dsi_dcs_set_display_brightness_multi() - sets the brightness value of
> + *	the display
> + * @ctx: Context for multiple DSI transactions
> + * @brightness: brightness value
> + *
> + * Like mipi_dsi_dcs_set_display_brightness() but deals with errors in a way that
> + * makes it convenient to make several calls in a row.
> + */
> +void mipi_dsi_dcs_set_display_brightness_multi(struct mipi_dsi_multi_context *ctx,
> +					       u16 brightness)
> +{
> +	struct mipi_dsi_device *dsi = ctx->dsi;
> +	struct device *dev = &dsi->dev;
> +	int ret;
> +
> +	if (ctx->accum_err)
> +		return;
> +
> +	ret = mipi_dsi_dcs_set_display_brightness(dsi, brightness);
> +	if (ret < 0) {
> +		ctx->accum_err = ret;
> +		dev_err(dev, "Failed to write display brightness: %d\n",
> +			ctx->accum_err);
> +	}
> +}
> +EXPORT_SYMBOL(mipi_dsi_dcs_set_display_brightness_multi);
> +
> +/**
> + * mipi_dsi_dcs_set_pixel_format_multi() - sets the pixel format for the RGB image
> + *	data used by the interface
> + * @ctx: Context for multiple DSI transactions
> + * @format: pixel format
> + *
> + * Like mipi_dsi_dcs_set_pixel_format() but deals with errors in a way that
> + * makes it convenient to make several calls in a row.
> + */
> +void mipi_dsi_dcs_set_pixel_format_multi(struct mipi_dsi_multi_context *ctx,
> +					 u8 format)
> +{
> +	struct mipi_dsi_device *dsi = ctx->dsi;
> +	struct device *dev = &dsi->dev;
> +	int ret;
> +
> +	if (ctx->accum_err)
> +		return;
> +
> +	ret = mipi_dsi_dcs_set_pixel_format(dsi, format);
> +	if (ret < 0) {
> +		ctx->accum_err = ret;
> +		dev_err(dev, "Failed to set pixel format: %d\n",
> +			ctx->accum_err);
> +	}
> +}
> +EXPORT_SYMBOL(mipi_dsi_dcs_set_pixel_format_multi);
> +
> +/**
> + * mipi_dsi_dcs_set_column_address_multi() - define the column extent of the
> + *	frame memory accessed by the host processor
> + * @ctx: Context for multiple DSI transactions
> + * @start: first column of frame memory
> + * @end: last column of frame memory
> + *
> + * Like mipi_dsi_dcs_set_column_address() but deals with errors in a way that
> + * makes it convenient to make several calls in a row.
> + */
> +void mipi_dsi_dcs_set_column_address_multi(struct mipi_dsi_multi_context *ctx,
> +					   u16 start, u16 end)
> +{
> +	struct mipi_dsi_device *dsi = ctx->dsi;
> +	struct device *dev = &dsi->dev;
> +	int ret;
> +
> +	if (ctx->accum_err)
> +		return;
> +
> +	ret = mipi_dsi_dcs_set_column_address(dsi, start, end);
> +	if (ret < 0) {
> +		ctx->accum_err = ret;
> +		dev_err(dev, "Failed to set column address: %d\n",
> +			ctx->accum_err);
> +	}
> +}
> +EXPORT_SYMBOL(mipi_dsi_dcs_set_column_address_multi);
> +
> +/**
> + * mipi_dsi_dcs_set_page_address_multi() - define the page extent of the
> + *	frame memory accessed by the host processor
> + * @ctx: Context for multiple DSI transactions
> + * @start: first page of frame memory
> + * @end: last page of frame memory
> + *
> + * Like mipi_dsi_dcs_set_page_address() but deals with errors in a way that
> + * makes it convenient to make several calls in a row.
> + */
> +void mipi_dsi_dcs_set_page_address_multi(struct mipi_dsi_multi_context *ctx,
> +					 u16 start, u16 end)
> +{
> +	struct mipi_dsi_device *dsi = ctx->dsi;
> +	struct device *dev = &dsi->dev;
> +	int ret;
> +
> +	if (ctx->accum_err)
> +		return;
> +
> +	ret = mipi_dsi_dcs_set_page_address(dsi, start, end);
> +	if (ret < 0) {
> +		ctx->accum_err = ret;
> +		dev_err(dev, "Failed to set page address: %d\n",
> +			ctx->accum_err);
> +	}
> +}
> +EXPORT_SYMBOL(mipi_dsi_dcs_set_page_address_multi);
> +
> +/**
> + * mipi_dsi_dcs_get_display_brightness_multi() - gets the current brightness value
> + *    of the display
> + * @ctx: Context for multiple DSI transactions
> + * @brightness: brightness value
> + *
> + * Like mipi_dsi_dcs_get_display_brightness() but deals with errors in a way that
> + * makes it convenient to make several calls in a row.
> + */
> +void mipi_dsi_dcs_get_display_brightness_multi(struct mipi_dsi_multi_context *ctx,
> +					       u16 *brightness)
> +{
> +	struct mipi_dsi_device *dsi = ctx->dsi;
> +	struct device *dev = &dsi->dev;
> +	int ret;
> +
> +	if (ctx->accum_err)
> +		return;
> +
> +	ret = mipi_dsi_dcs_get_display_brightness(dsi, brightness);
> +	if (ret < 0) {
> +		ctx->accum_err = ret;
> +		dev_err(dev, "Failed to get display brightness: %d\n",
> +			ctx->accum_err);
> +	}
> +}
> +EXPORT_SYMBOL(mipi_dsi_dcs_get_display_brightness_multi);
> +
> +
>  static int mipi_dsi_drv_probe(struct device *dev)
>  {
>  	struct mipi_dsi_driver *drv = to_mipi_dsi_driver(dev->driver);
> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> index 0f520eeeaa8e..7c6239d7b492 100644
> --- a/include/drm/drm_mipi_dsi.h
> +++ b/include/drm/drm_mipi_dsi.h
> @@ -365,6 +365,18 @@ void mipi_dsi_dcs_set_display_off_multi(struct mipi_dsi_multi_context *ctx);
>  void mipi_dsi_dcs_set_display_on_multi(struct mipi_dsi_multi_context *ctx);
>  void mipi_dsi_dcs_set_tear_on_multi(struct mipi_dsi_multi_context *ctx,
>  				    enum mipi_dsi_dcs_tear_mode mode);
> +void mipi_dsi_turn_on_peripheral_multi(struct mipi_dsi_multi_context *ctx);
> +void mipi_dsi_dcs_soft_reset_multi(struct mipi_dsi_multi_context *ctx);
> +void mipi_dsi_dcs_set_display_brightness_multi(struct mipi_dsi_multi_context *ctx,
> +					       u16 brightness);
> +void mipi_dsi_dcs_set_pixel_format_multi(struct mipi_dsi_multi_context *ctx,
> +					 u8 format);
> +void mipi_dsi_dcs_set_column_address_multi(struct mipi_dsi_multi_context *ctx,
> +					   u16 start, u16 end);
> +void mipi_dsi_dcs_set_page_address_multi(struct mipi_dsi_multi_context *ctx,
> +					   u16 start, u16 end);
> +void mipi_dsi_dcs_get_display_brightness_multi(struct mipi_dsi_multi_context *ctx,
> +					       u16 *brightness);
>  
>  /**
>   * mipi_dsi_generic_write_seq - transmit data using a generic write packet

-- 
Jani Nikula, Intel

