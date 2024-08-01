Return-Path: <linux-kernel+bounces-271184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1AE944A7F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3529D1C2570D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB0A18E05D;
	Thu,  1 Aug 2024 11:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/+odljp"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC03218E049
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722512159; cv=none; b=hAw1YhlJNa/08+DR3aKBsuLoWkUJPNemX4r086ErjDeclCmjk4yw0E+mbvV4KSsvw1gAWclxjiomL7QjiiielK5CCHtPDkeJrPLTcnxY700+bphm+rxGRI1+n0XEh+zz5bI1YzXcmxaIomvczJhL2rEAVwU/ZTbVC4A0GxnrCeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722512159; c=relaxed/simple;
	bh=d/+q9Md9W9Ccsp+MbCbOywiqiCRsNKMi0z7SVcpPO7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qCHnQo5KYvJlydQdtAok3oYoRFjO1l+rIDHKyuxs/l5QwJMRa0mmiMkVxYBQBev4t1g4JLj//KIkr6eMGXMfQqw4FpMmpjWJAOsR8C8J0btP41A4jE7qOy23QfTkFXOkZAOS5SsucGlcKn/dqg/F+S3QtJnqZm8cqU3DOEHZzOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/+odljp; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d1a74a43bso5016065b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 04:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722512157; x=1723116957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ahAduSWWDHc6rTsON2tIDoOGddirMabU3Z6RKqvztKU=;
        b=E/+odljpt6YAlYhQqi5QJYUUcZojS/XbGCGn0+DUT30Fm7WT57JKGzDa3ctRLfQ/Re
         bth0Wl5caXuKFuVuY7kppRDs5j0YQ2rGMwMAJQ+zylHFEpInnPme70uMWd9r5xkadhM9
         EqDa3fKWMei0HzHSMi29WU+LFkQ4dHlUFIDGMqUo+9rpujAVFJ/meH9jZGpx347tpVpX
         Smbo31wMN9dnCMsldEC5NR6GJMGvuCpMZGPpE++7JMgHVA6N5Uwa6TXbtq0F+voGsNtK
         TF55iJ8eXBKCB2j8s8qznL9i/Q4P41fXF6mpYLyfIhTEg9tf0SYZB4/0S8m7H/JTemU2
         QMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722512157; x=1723116957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ahAduSWWDHc6rTsON2tIDoOGddirMabU3Z6RKqvztKU=;
        b=R2A47Oely6DyfzEMZ060cxKZvhR44lr7IGV0KDaxN+rKD8HrznxhiSVdhtLp32t0gR
         VKETYhjv9Y54NWDfpIIDieTAaZoArYhfjzx/F5y+C9+Ng3BGk/9y9OlF2CeFp9K42w/g
         GrZOXUZM4zU5g6VBT16N4eGZ/8R6cAYRFGg2LncBlj8A+RKkrn0c+XP89fwjopQDCIFA
         FWqALIacnrzexwK7WA+Ql7dmDYy1uExw7jkcRxV2pvvEfYDlxDF9XOW9JEIVyNwt/+PE
         LnjEiDSZdQ8pCu+WZDAl0TTAevTjgYx9LcWEkWQqmNI7UBJCfGwmumeL7Ov+87GvyRWK
         lUBA==
X-Forwarded-Encrypted: i=1; AJvYcCVB/YrFOn+INIqIJ1W1U7XX9uFL/0xF1lDxZu0MujY73WJU6rbVMk1MZ8SRFQjeFZwXGI+XSnNvTovpFddGro1Gy6zcFA6Uei2DEwQD
X-Gm-Message-State: AOJu0YxGjwfyiGEse0T0y1itxnrG6X3ISRS4/aB6TRqOTYw9spN6YRE0
	ZtwPebrEq5XQEtK+T3RkN72IfK3SAXaa0Aqk444q3Rl1QzS/fh63
X-Google-Smtp-Source: AGHT+IHRZmtTgr6he6ex/3IxTum2N2nQFsd/76F6cHkWMDcWAlM/FcGS67DN5B0FCDeBvZy3n8DhQA==
X-Received: by 2002:a05:6a21:9989:b0:1c0:eb1e:868e with SMTP id adf61e73a8af0-1c68cec7a74mr3171675637.19.1722512156787;
        Thu, 01 Aug 2024 04:35:56 -0700 (PDT)
Received: from [10.3.80.76] ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4513ecsm3072495a91.20.2024.08.01.04.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 04:35:56 -0700 (PDT)
Message-ID: <d1132708-204a-45fc-b14a-6432993cb33a@gmail.com>
Date: Thu, 1 Aug 2024 17:05:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/mipi-dsi: add more multi functions for better
 error handling
To: Jani Nikula <jani.nikula@linux.intel.com>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 neil.armstrong@linaro.org, quic_jesszhan@quicinc.com
Cc: dianders@chromium.org, airlied@gmail.com, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240730060659.455953-1-tejasvipin76@gmail.com>
 <20240730060659.455953-2-tejasvipin76@gmail.com> <87cymswld0.fsf@intel.com>
Content-Language: en-US
From: Tejas Vipin <tejasvipin76@gmail.com>
In-Reply-To: <87cymswld0.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/1/24 4:39 PM, Jani Nikula wrote:
> On Tue, 30 Jul 2024, Tejas Vipin <tejasvipin76@gmail.com> wrote:
>> Add more functions that can benefit from being multi style and mark
>> older variants as deprecated to eventually convert all mipi_dsi functions
>> to multi style.
> 
> What?
> 
> Why would a lot of regular DSI commands that are not exclusively used
> for one time setup need to be deprecated or converted to _multi()?
> 

All of the functions I've marked as deprecated here have a good amount
of their usage in conjunction with other mipi_dsi functions (an
exception being mipi_dsi_dcs_get_display_brightness which I have
realized is not suitable for this type of conversion). Them being
rewritten as multi style functions saves a lot of early returns and
errors being repeated over and over again across the codebase.

In the cases where they are just called by themselves, there is very little
overhead in replacing them with a multi variant. These functions would
be better off converted to multi variants, and the old versions removed
when all the function calls are replaced.

> BR,
> Jani.
> 
>>
>> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
>> ---
>>  drivers/gpu/drm/drm_mipi_dsi.c | 226 +++++++++++++++++++++++++++++++++
>>  include/drm/drm_mipi_dsi.h     |  12 ++
>>  2 files changed, 238 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
>> index a471c46f5ca6..05ea7df5dec1 100644
>> --- a/drivers/gpu/drm/drm_mipi_dsi.c
>> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
>> @@ -603,6 +603,8 @@ EXPORT_SYMBOL(mipi_dsi_shutdown_peripheral);
>>   * mipi_dsi_turn_on_peripheral() - sends a Turn On Peripheral command
>>   * @dsi: DSI peripheral device
>>   *
>> + * This function is deprecated. Use mipi_dsi_turn_on_peripheral_multi() instead.
>> + *
>>   * Return: 0 on success or a negative error code on failure.
>>   */
>>  int mipi_dsi_turn_on_peripheral(struct mipi_dsi_device *dsi)
>> @@ -652,6 +654,7 @@ EXPORT_SYMBOL(mipi_dsi_set_maximum_return_packet_size);
>>   * @pps_selector: Select PPS from the table of pre-stored or uploaded PPS entries
>>   *
>>   * Enable or disable Display Stream Compression on the peripheral.
>> + * This function is deprecated. Use mipi_dsi_compression_mode_ext_multi() instead.
>>   *
>>   * Return: 0 on success or a negative error code on failure.
>>   */
>> @@ -703,6 +706,7 @@ EXPORT_SYMBOL(mipi_dsi_compression_mode);
>>   * @pps: VESA DSC 1.1 Picture Parameter Set
>>   *
>>   * Transmit the VESA DSC 1.1 Picture Parameter Set to the peripheral.
>> + * This function is deprecated. Use mipi_dsi_picture_parameter_set_multi() instead.
>>   *
>>   * Return: 0 on success or a negative error code on failure.
>>   */
>> @@ -1037,6 +1041,8 @@ EXPORT_SYMBOL(mipi_dsi_dcs_read);
>>   * mipi_dsi_dcs_nop() - send DCS nop packet
>>   * @dsi: DSI peripheral device
>>   *
>> + * This function is deprecated. Use mipi_dsi_dcs_nop_multi() instead.
>> + *
>>   * Return: 0 on success or a negative error code on failure.
>>   */
>>  int mipi_dsi_dcs_nop(struct mipi_dsi_device *dsi)
>> @@ -1055,6 +1061,8 @@ EXPORT_SYMBOL(mipi_dsi_dcs_nop);
>>   * mipi_dsi_dcs_soft_reset() - perform a software reset of the display module
>>   * @dsi: DSI peripheral device
>>   *
>> + * This function is deprecated. Use mipi_dsi_dcs_soft_reset_multi() instead.
>> + *
>>   * Return: 0 on success or a negative error code on failure.
>>   */
>>  int mipi_dsi_dcs_soft_reset(struct mipi_dsi_device *dsi)
>> @@ -1124,6 +1132,8 @@ EXPORT_SYMBOL(mipi_dsi_dcs_get_pixel_format);
>>   *    display module except interface communication
>>   * @dsi: DSI peripheral device
>>   *
>> + * This function is deprecated. Use mipi_dsi_dcs_enter_sleep_mode_multi() instead.
>> + *
>>   * Return: 0 on success or a negative error code on failure.
>>   */
>>  int mipi_dsi_dcs_enter_sleep_mode(struct mipi_dsi_device *dsi)
>> @@ -1143,6 +1153,8 @@ EXPORT_SYMBOL(mipi_dsi_dcs_enter_sleep_mode);
>>   *    module
>>   * @dsi: DSI peripheral device
>>   *
>> + * This function is deprecated. Use mipi_dsi_dcs_exit_sleep_mode_multi() instead.
>> + *
>>   * Return: 0 on success or a negative error code on failure.
>>   */
>>  int mipi_dsi_dcs_exit_sleep_mode(struct mipi_dsi_device *dsi)
>> @@ -1162,6 +1174,8 @@ EXPORT_SYMBOL(mipi_dsi_dcs_exit_sleep_mode);
>>   *    display device
>>   * @dsi: DSI peripheral device
>>   *
>> + * This function is deprecated. Use mipi_dsi_dcs_set_display_off_multi() instead.
>> + *
>>   * Return: 0 on success or a negative error code on failure.
>>   */
>>  int mipi_dsi_dcs_set_display_off(struct mipi_dsi_device *dsi)
>> @@ -1181,6 +1195,8 @@ EXPORT_SYMBOL(mipi_dsi_dcs_set_display_off);
>>   *    display device
>>   * @dsi: DSI peripheral device
>>   *
>> + * This function is deprecated. Use mipi_dsi_dcs_set_display_on_multi() instead.
>> + *
>>   * Return: 0 on success or a negative error code on failure
>>   */
>>  int mipi_dsi_dcs_set_display_on(struct mipi_dsi_device *dsi)
>> @@ -1202,6 +1218,9 @@ EXPORT_SYMBOL(mipi_dsi_dcs_set_display_on);
>>   * @start: first column of frame memory
>>   * @end: last column of frame memory
>>   *
>> + * This function is deprecated. Use mipi_dsi_dcs_set_column_address_multi()
>> + * instead.
>> + *
>>   * Return: 0 on success or a negative error code on failure.
>>   */
>>  int mipi_dsi_dcs_set_column_address(struct mipi_dsi_device *dsi, u16 start,
>> @@ -1226,6 +1245,9 @@ EXPORT_SYMBOL(mipi_dsi_dcs_set_column_address);
>>   * @start: first page of frame memory
>>   * @end: last page of frame memory
>>   *
>> + * This function is deprecated. Use mipi_dsi_dcs_set_page_address_multi()
>> + * instead.
>> + *
>>   * Return: 0 on success or a negative error code on failure.
>>   */
>>  int mipi_dsi_dcs_set_page_address(struct mipi_dsi_device *dsi, u16 start,
>> @@ -1268,6 +1290,8 @@ EXPORT_SYMBOL(mipi_dsi_dcs_set_tear_off);
>>   * @dsi: DSI peripheral device
>>   * @mode: the Tearing Effect Output Line mode
>>   *
>> + * This function is deprecated. Use mipi_dsi_dcs_set_tear_on_multi() instead.
>> + *
>>   * Return: 0 on success or a negative error code on failure
>>   */
>>  int mipi_dsi_dcs_set_tear_on(struct mipi_dsi_device *dsi,
>> @@ -1291,6 +1315,9 @@ EXPORT_SYMBOL(mipi_dsi_dcs_set_tear_on);
>>   * @dsi: DSI peripheral device
>>   * @format: pixel format
>>   *
>> + * This function is deprecated. Use mipi_dsi_dcs_set_pixel_format_multi()
>> + * instead.
>> + *
>>   * Return: 0 on success or a negative error code on failure.
>>   */
>>  int mipi_dsi_dcs_set_pixel_format(struct mipi_dsi_device *dsi, u8 format)
>> @@ -1334,6 +1361,9 @@ EXPORT_SYMBOL(mipi_dsi_dcs_set_tear_scanline);
>>   * @dsi: DSI peripheral device
>>   * @brightness: brightness value
>>   *
>> + * This function is deprecated. Use mipi_dsi_dcs_set_display_brightness_multi()
>> + * instead.
>> + *
>>   * Return: 0 on success or a negative error code on failure.
>>   */
>>  int mipi_dsi_dcs_set_display_brightness(struct mipi_dsi_device *dsi,
>> @@ -1357,6 +1387,9 @@ EXPORT_SYMBOL(mipi_dsi_dcs_set_display_brightness);
>>   * @dsi: DSI peripheral device
>>   * @brightness: brightness value
>>   *
>> + * This function is deprecated. Use mipi_dsi_dcs_get_display_brightness_multi()
>> + * instead.
>> + *
>>   * Return: 0 on success or a negative error code on failure.
>>   */
>>  int mipi_dsi_dcs_get_display_brightness(struct mipi_dsi_device *dsi,
>> @@ -1639,6 +1672,199 @@ void mipi_dsi_dcs_set_tear_on_multi(struct mipi_dsi_multi_context *ctx,
>>  }
>>  EXPORT_SYMBOL(mipi_dsi_dcs_set_tear_on_multi);
>>  
>> +/**
>> + * mipi_dsi_turn_on_peripheral_multi() - sends a Turn On Peripheral command
>> + * @ctx: Context for multiple DSI transactions
>> + *
>> + * Like mipi_dsi_turn_on_peripheral() but deals with errors in a way that
>> + * makes it convenient to make several calls in a row.
>> + */
>> +void mipi_dsi_turn_on_peripheral_multi(struct mipi_dsi_multi_context *ctx)
>> +{
>> +	struct mipi_dsi_device *dsi = ctx->dsi;
>> +	struct device *dev = &dsi->dev;
>> +	int ret;
>> +
>> +	if (ctx->accum_err)
>> +		return;
>> +
>> +	ret = mipi_dsi_turn_on_peripheral(dsi);
>> +	if (ret < 0) {
>> +		ctx->accum_err = ret;
>> +		dev_err(dev, "Failed to turn on peripheral: %d\n",
>> +			ctx->accum_err);
>> +	}
>> +}
>> +EXPORT_SYMBOL(mipi_dsi_turn_on_peripheral_multi);
>> +
>> +/**
>> + * mipi_dsi_dcs_soft_reset_multi() - perform a software reset of the display module
>> + * @ctx: Context for multiple DSI transactions
>> + *
>> + * Like mipi_dsi_dcs_soft_reset() but deals with errors in a way that
>> + * makes it convenient to make several calls in a row.
>> + */
>> +void mipi_dsi_dcs_soft_reset_multi(struct mipi_dsi_multi_context *ctx)
>> +{
>> +	struct mipi_dsi_device *dsi = ctx->dsi;
>> +	struct device *dev = &dsi->dev;
>> +	int ret;
>> +
>> +	if (ctx->accum_err)
>> +		return;
>> +
>> +	ret = mipi_dsi_dcs_soft_reset(dsi);
>> +	if (ret < 0) {
>> +		ctx->accum_err = ret;
>> +		dev_err(dev, "Failed to mipi_dsi_dcs_soft_reset: %d\n",
>> +			ctx->accum_err);
>> +	}
>> +}
>> +EXPORT_SYMBOL(mipi_dsi_dcs_soft_reset_multi);
>> +
>> +/**
>> + * mipi_dsi_dcs_set_display_brightness_multi() - sets the brightness value of
>> + *	the display
>> + * @ctx: Context for multiple DSI transactions
>> + * @brightness: brightness value
>> + *
>> + * Like mipi_dsi_dcs_set_display_brightness() but deals with errors in a way that
>> + * makes it convenient to make several calls in a row.
>> + */
>> +void mipi_dsi_dcs_set_display_brightness_multi(struct mipi_dsi_multi_context *ctx,
>> +					       u16 brightness)
>> +{
>> +	struct mipi_dsi_device *dsi = ctx->dsi;
>> +	struct device *dev = &dsi->dev;
>> +	int ret;
>> +
>> +	if (ctx->accum_err)
>> +		return;
>> +
>> +	ret = mipi_dsi_dcs_set_display_brightness(dsi, brightness);
>> +	if (ret < 0) {
>> +		ctx->accum_err = ret;
>> +		dev_err(dev, "Failed to write display brightness: %d\n",
>> +			ctx->accum_err);
>> +	}
>> +}
>> +EXPORT_SYMBOL(mipi_dsi_dcs_set_display_brightness_multi);
>> +
>> +/**
>> + * mipi_dsi_dcs_set_pixel_format_multi() - sets the pixel format for the RGB image
>> + *	data used by the interface
>> + * @ctx: Context for multiple DSI transactions
>> + * @format: pixel format
>> + *
>> + * Like mipi_dsi_dcs_set_pixel_format() but deals with errors in a way that
>> + * makes it convenient to make several calls in a row.
>> + */
>> +void mipi_dsi_dcs_set_pixel_format_multi(struct mipi_dsi_multi_context *ctx,
>> +					 u8 format)
>> +{
>> +	struct mipi_dsi_device *dsi = ctx->dsi;
>> +	struct device *dev = &dsi->dev;
>> +	int ret;
>> +
>> +	if (ctx->accum_err)
>> +		return;
>> +
>> +	ret = mipi_dsi_dcs_set_pixel_format(dsi, format);
>> +	if (ret < 0) {
>> +		ctx->accum_err = ret;
>> +		dev_err(dev, "Failed to set pixel format: %d\n",
>> +			ctx->accum_err);
>> +	}
>> +}
>> +EXPORT_SYMBOL(mipi_dsi_dcs_set_pixel_format_multi);
>> +
>> +/**
>> + * mipi_dsi_dcs_set_column_address_multi() - define the column extent of the
>> + *	frame memory accessed by the host processor
>> + * @ctx: Context for multiple DSI transactions
>> + * @start: first column of frame memory
>> + * @end: last column of frame memory
>> + *
>> + * Like mipi_dsi_dcs_set_column_address() but deals with errors in a way that
>> + * makes it convenient to make several calls in a row.
>> + */
>> +void mipi_dsi_dcs_set_column_address_multi(struct mipi_dsi_multi_context *ctx,
>> +					   u16 start, u16 end)
>> +{
>> +	struct mipi_dsi_device *dsi = ctx->dsi;
>> +	struct device *dev = &dsi->dev;
>> +	int ret;
>> +
>> +	if (ctx->accum_err)
>> +		return;
>> +
>> +	ret = mipi_dsi_dcs_set_column_address(dsi, start, end);
>> +	if (ret < 0) {
>> +		ctx->accum_err = ret;
>> +		dev_err(dev, "Failed to set column address: %d\n",
>> +			ctx->accum_err);
>> +	}
>> +}
>> +EXPORT_SYMBOL(mipi_dsi_dcs_set_column_address_multi);
>> +
>> +/**
>> + * mipi_dsi_dcs_set_page_address_multi() - define the page extent of the
>> + *	frame memory accessed by the host processor
>> + * @ctx: Context for multiple DSI transactions
>> + * @start: first page of frame memory
>> + * @end: last page of frame memory
>> + *
>> + * Like mipi_dsi_dcs_set_page_address() but deals with errors in a way that
>> + * makes it convenient to make several calls in a row.
>> + */
>> +void mipi_dsi_dcs_set_page_address_multi(struct mipi_dsi_multi_context *ctx,
>> +					 u16 start, u16 end)
>> +{
>> +	struct mipi_dsi_device *dsi = ctx->dsi;
>> +	struct device *dev = &dsi->dev;
>> +	int ret;
>> +
>> +	if (ctx->accum_err)
>> +		return;
>> +
>> +	ret = mipi_dsi_dcs_set_page_address(dsi, start, end);
>> +	if (ret < 0) {
>> +		ctx->accum_err = ret;
>> +		dev_err(dev, "Failed to set page address: %d\n",
>> +			ctx->accum_err);
>> +	}
>> +}
>> +EXPORT_SYMBOL(mipi_dsi_dcs_set_page_address_multi);
>> +
>> +/**
>> + * mipi_dsi_dcs_get_display_brightness_multi() - gets the current brightness value
>> + *    of the display
>> + * @ctx: Context for multiple DSI transactions
>> + * @brightness: brightness value
>> + *
>> + * Like mipi_dsi_dcs_get_display_brightness() but deals with errors in a way that
>> + * makes it convenient to make several calls in a row.
>> + */
>> +void mipi_dsi_dcs_get_display_brightness_multi(struct mipi_dsi_multi_context *ctx,
>> +					       u16 *brightness)
>> +{
>> +	struct mipi_dsi_device *dsi = ctx->dsi;
>> +	struct device *dev = &dsi->dev;
>> +	int ret;
>> +
>> +	if (ctx->accum_err)
>> +		return;
>> +
>> +	ret = mipi_dsi_dcs_get_display_brightness(dsi, brightness);
>> +	if (ret < 0) {
>> +		ctx->accum_err = ret;
>> +		dev_err(dev, "Failed to get display brightness: %d\n",
>> +			ctx->accum_err);
>> +	}
>> +}
>> +EXPORT_SYMBOL(mipi_dsi_dcs_get_display_brightness_multi);
>> +
>> +
>>  static int mipi_dsi_drv_probe(struct device *dev)
>>  {
>>  	struct mipi_dsi_driver *drv = to_mipi_dsi_driver(dev->driver);
>> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
>> index 0f520eeeaa8e..7c6239d7b492 100644
>> --- a/include/drm/drm_mipi_dsi.h
>> +++ b/include/drm/drm_mipi_dsi.h
>> @@ -365,6 +365,18 @@ void mipi_dsi_dcs_set_display_off_multi(struct mipi_dsi_multi_context *ctx);
>>  void mipi_dsi_dcs_set_display_on_multi(struct mipi_dsi_multi_context *ctx);
>>  void mipi_dsi_dcs_set_tear_on_multi(struct mipi_dsi_multi_context *ctx,
>>  				    enum mipi_dsi_dcs_tear_mode mode);
>> +void mipi_dsi_turn_on_peripheral_multi(struct mipi_dsi_multi_context *ctx);
>> +void mipi_dsi_dcs_soft_reset_multi(struct mipi_dsi_multi_context *ctx);
>> +void mipi_dsi_dcs_set_display_brightness_multi(struct mipi_dsi_multi_context *ctx,
>> +					       u16 brightness);
>> +void mipi_dsi_dcs_set_pixel_format_multi(struct mipi_dsi_multi_context *ctx,
>> +					 u8 format);
>> +void mipi_dsi_dcs_set_column_address_multi(struct mipi_dsi_multi_context *ctx,
>> +					   u16 start, u16 end);
>> +void mipi_dsi_dcs_set_page_address_multi(struct mipi_dsi_multi_context *ctx,
>> +					   u16 start, u16 end);
>> +void mipi_dsi_dcs_get_display_brightness_multi(struct mipi_dsi_multi_context *ctx,
>> +					       u16 *brightness);
>>  
>>  /**
>>   * mipi_dsi_generic_write_seq - transmit data using a generic write packet
> 

-- 
Tejas Vipin

