Return-Path: <linux-kernel+bounces-255013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D107E933A7F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0916F1C217F3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3C817E8F0;
	Wed, 17 Jul 2024 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYAizP4d"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E761CD2A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 09:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721210287; cv=none; b=kQz0B4/yRBCWbET7In/g1ASKfc6VKLg/M7Oi+ThBIHhlB9OyoJVhScoi3j3ssSs+A8QqZxjUmqMCAuLxp1s0hfeJjzxs4uhz+AZrbUrpe11AlrtLRUgMBmfIjvcKa2Dsiw17lHXz5RQVgykoY6VA1afiXR7p+AkouAc6BHxRyQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721210287; c=relaxed/simple;
	bh=rd9VQQUGHMdCa2JtHrlY1tCMBHA9nX6ICq5BnWj0TGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QjB6p5ZsLkx1ft+U4jQm+njKc3wjAKuCMsS6TnE8PvB/UuupMJH8ULKMH1JH288YCHtbH/p54gJB8RhNfC3tWAByQR0r1AArxAeXNZZhcn1mSZGJbEghDGdnLNpIEttPidfhySwlOoKdbziaweVLeDHSSas6wW50/UsP8k32H7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYAizP4d; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fb05b0be01so45552135ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 02:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721210285; x=1721815085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oFYkOL5E3FUWqtNNaC4rEpQsyl0OqCKhsiSOdcp83/4=;
        b=FYAizP4df4WstS9JxxhoFN4ylN5uV+Hxmr9d+YquTIndMieMxSCxGR0UGqSaRouxsb
         BQ8567KG0zG5woKEEW3UL1IkMY8d0Stkde0JjyIv8NaPGaLGj3CnDk81zbToh2CEm6l8
         Qv0RaFeImuhfuRcaDXpyj4DHDrKAFRevH1gpyAuv8ytOfTHbcPFsfqQypBV+ySk7ouV3
         0HOKl94sYp7VAEsyKv9M2lJYiHY+Y0O51VL0tmHtyQwBz4zQfmA03EuqGtro+iWBlMiE
         lqlQRBMFwrwprLVNaeuAMXxrUNU9AGE68mXfsEKDiY5HLZ+wxZCesKaaqj/5N6fP1WNm
         Mq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721210285; x=1721815085;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oFYkOL5E3FUWqtNNaC4rEpQsyl0OqCKhsiSOdcp83/4=;
        b=qn3NurRYdLRq+3MH9RcAw2CWqPjywVt/vj98ajiyU6RlogGC4VknuFgzA9QV65pqa9
         yiSWD7RiBtm587Y7IEIeocd5UI4t+ylDR9hP/x5ocronq2UG8ai7V6KUgqQsjJyxQ5c9
         sUDeW1QsTe8feXpE5ia46H3W/w7b7LgyDRZLnGyLaW9APiDT636qywgYMpDMup6KoCqo
         I8EdoLluXYB+9U0kuw/SybC+iCeXJvc0GrD3QLkvznIt/2GJCogkxnBxls22wmQdHFAP
         99qkCNluBL4+fR4C1himFztbVl4pe5hUdkRjb+oyuz6phSG1mJTV+qmGmwzHc3HDIxPe
         2tag==
X-Forwarded-Encrypted: i=1; AJvYcCXWzs2efVACd7w1NvI8El5pImmcEUOR3G7JAufegcZL2qKEQ4vSVOUcfYJ5oKXfcpWkw5WH54kcvB3nk58btJUv8IN3mFma2yHilJEJ
X-Gm-Message-State: AOJu0YyEsl4S6hZgT61QLhWiCQGljLHQ0hRpuZrqKrSBDaaoHxQ76NvB
	ZGQRH8ZQv6i9AR5/3rjs6+e6w5Jkdfl6UXa3MBZg7B2YobGMTMa/
X-Google-Smtp-Source: AGHT+IF6jklU2qTTvW7oJDrVGWHRFiQz/zOOy3QZsnyKcee6qfXg0v/DPwwUFemay4LgIhgTbeO6Vg==
X-Received: by 2002:a17:902:e548:b0:1fb:7c7f:6447 with SMTP id d9443c01a7336-1fc4e56517emr7554345ad.25.1721210285141;
        Wed, 17 Jul 2024 02:58:05 -0700 (PDT)
Received: from [10.3.80.76] ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb6f4f3sm71986755ad.17.2024.07.17.02.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 02:58:04 -0700 (PDT)
Message-ID: <a05b4e6e-272a-43be-8202-2b81049a41a4@gmail.com>
Date: Wed, 17 Jul 2024 15:28:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mipi-dsi: Introduce macros to create mipi_dsi_*_multi
 functions
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, dianders@chromium.org, airlied@gmail.com,
 daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240716133117.483514-1-tejasvipin76@gmail.com>
 <p7fahem6egnooi5org4lv3gtz2elafylvlnyily7buvzcpv2qh@vssvpfci3lwn>
Content-Language: en-US
From: Tejas Vipin <tejasvipin76@gmail.com>
In-Reply-To: <p7fahem6egnooi5org4lv3gtz2elafylvlnyily7buvzcpv2qh@vssvpfci3lwn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/16/24 10:31 PM, Dmitry Baryshkov wrote:
> On Tue, Jul 16, 2024 at 07:01:17PM GMT, Tejas Vipin wrote:
>> Introduce 2 new macros, DSI_CTX_NO_OP and MIPI_DSI_ADD_MULTI_VARIANT.
>>
>> DSI_CTX_NO_OP calls a function only if the context passed to it hasn't
>> encountered any errors. It is a generic form of what mipi_dsi_msleep
>> does.
>>
>> MIPI_DSI_ADD_MULTI_VARIANT defines a multi style function of any
>> mipi_dsi function that follows a certain style. This allows us to
>> greatly reduce the amount of redundant code written for each multi
>> function. It reduces the overhead for a developer introducing new
>> mipi_dsi_*_multi functions.
>>
>> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
>> ---
>>  drivers/gpu/drm/drm_mipi_dsi.c | 286 ++++++++++-----------------------
>>  1 file changed, 83 insertions(+), 203 deletions(-)
>>
> 
> [...]
> 
>> -void mipi_dsi_dcs_set_tear_on_multi(struct mipi_dsi_multi_context *ctx,
>> -				    enum mipi_dsi_dcs_tear_mode mode)
>> -{
>> -	struct mipi_dsi_device *dsi = ctx->dsi;
>> -	struct device *dev = &dsi->dev;
>> -	ssize_t ret;
>> -
>> -	if (ctx->accum_err)
>> -		return;
>> -
>> -	ret = mipi_dsi_dcs_set_tear_on(dsi, mode);
>> -	if (ret < 0) {
>> -		ctx->accum_err = ret;
>> -		dev_err(dev, "sending DCS SET_TEAR_ON failed: %d\n",
>> -			ctx->accum_err);
>> -	}
>> -}
>> -EXPORT_SYMBOL(mipi_dsi_dcs_set_tear_on_multi);
>> +#define MIPI_DSI_ADD_MULTI_VARIANT(proto, err, inner_func, ...)	\
>> +proto {								\
>> +	struct mipi_dsi_device *dsi = ctx->dsi;			\
>> +	struct device *dev = &dsi->dev;				\
>> +	int ret;						\
>> +	\
>> +	if (ctx->accum_err)					\
>> +		return;						\
>> +	\
>> +	ret = inner_func(dsi, ##__VA_ARGS__);			\
>> +	if (ret < 0) {						\
>> +		ctx->accum_err = ret;				\
>> +		dev_err(dev, err, ctx->accum_err);		\
>> +	}							\
>> +}								\
>> +EXPORT_SYMBOL(inner_func##_multi);
>> +
>> +MIPI_DSI_ADD_MULTI_VARIANT(
>> +	void mipi_dsi_picture_parameter_set_multi(
>> +	struct mipi_dsi_multi_context *ctx,
>> +	const struct drm_dsc_picture_parameter_set *pps),
>> +	"sending PPS failed: %d\n",
>> +	mipi_dsi_picture_parameter_set, pps);
> 
> I'd say that having everything wrapped in the macro looks completely
> unreadable.
> 
> If you really insist, it can become something like:
> 
> MIPI_DSI_ADD_MULTI_VARIANT(mipi_dsi_picture_parameter_set
> 	MULTI_PROTO(const struct drm_dsc_picture_parameter_set *pps),
> 	MULTI_ARGS(pps),
> 	"sending PPS failed");
> 
> (note, I dropped the obvious parts: that the funciton is foo_multi, its
> return type is void, first parameter is context, etc).
> 
> However it might be better to go other way arround.
> Do we want for all the drivers to migrate to _multi()-kind of API? If
> so, what about renaming the multi and non-multi functions accordingly
> and making the old API a wrapper around the multi() function?
> 

I think this would be good. For the wrapper to make a multi() function
non-multi, what do you think about a macro that would just pass a 
default dsi_ctx to the multi() func and return on error? In this case
it would also be good to let the code fill inline instead of generating
a whole new function imo. 

So in this scenario all the mipi dsi functions would be multi functions,
and a function could be called non-multi like MACRO_NAME(func) at the
call site.

I also think there is merit in keeping DSI_CTX_NO_OP.

What do you think?

-- 
Tejas Vipin

