Return-Path: <linux-kernel+bounces-187231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DFD8CCEDE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA151C21458
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C83113CFBC;
	Thu, 23 May 2024 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="duIunlHh"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A018A13C9BD
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455904; cv=none; b=nuzSl4gx763Tb1wZ5Ds51wVtLCe0GEeIltZdBHcxw/irg2wV60wP+YtgX47xrRqZwh/eywwp4hGLtXcHnLBZ1BfHriv8xhfL/9bqD/+ZiCneBly44irokbaRjuG+YbV0LPwKspNmNZcATPuW+OhY/4AgHRpdMQ/Plf2WWOOlw2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455904; c=relaxed/simple;
	bh=RGxM2jOVFTwquoP32KsAE1HBbRxX9MhiaEXuZQ252p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbZJ2VC0lMGbThCrV8E9BzwQMmv2YzJQFt6Iy1Nuvm4VgSp6nWr1+I3aHqRmajydYldrhC1p9fXU6t7CDQNwjIy5u+3JkcQjYprkeCjMKrdWeMCRRNhJMdj8pOQZf2pfI97kO8oLAprcA51/ehdlvzj7tuyXZzGV/pRqldyJXfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=duIunlHh; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e73359b8fbso41095711fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 02:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716455901; x=1717060701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hq01rfxiJkhZS3QzRfqemO50XhU1PhV9rUGPBC31chs=;
        b=duIunlHhbEkvY9GRSWx0dzNEMcEoEb4mv5KxsGMvI/ybm8E2dXOgTTEKyFdvM48nnM
         pIKTbk9SCPTESHlRvV1SVCRF3kwfqs2FakFwIwrKWZ5wnHK8wYYKxlFxGmBGxLQ1opye
         Wt/W6Cx6AllnosgtjEiWfkWEELISXjB1uJY5SJmYSdFSbUpYbMJdloAywFgVkK6T+Zfb
         womBoap+dfgKvrUDqqWgHYvU1sdw+s4GcDEBIf7NGKyjIDDppTgh4tNhTzaFWvTX40e6
         hqyhjY2IyV/PsmHzi2GCKHYPeW2z8yOjat3JB6deo9ea/buc98AHPh5DIsdhpr9w33v4
         ruYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716455901; x=1717060701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hq01rfxiJkhZS3QzRfqemO50XhU1PhV9rUGPBC31chs=;
        b=UV1DYUrYfz49V1mQzb+DhohF3WnH5ZGKvAxCwHQULO2LqWUqEc93pu1bpop37I7w+x
         7rFasbhIuHpTiKBOYctTKWNqZvIO6rgIuYau8Oy/2HZXN39dvPi3jAaUL5FggDeSLGLf
         QFVsstOq91OuNsj5Bhylgib0sT0zk73cM32iXBGYYjowGIF2auyGPXQVCMlVrAQqz7xR
         Arv2se6lJhJNYvx6hhCoGvcvhlOa+oazrC9tjckQREwJ5OfChMroHordpzZx/wvEOLhg
         4zDEcj74DVIFTXV3CeMTxt4vvlhwDcNr8a9S31DAcf4fKqPh0FpuRpj6q5wGTDHfcyS8
         zRZg==
X-Forwarded-Encrypted: i=1; AJvYcCWWvAfhUb64hdDo7DwOmugijiogbRc6jOOmLgfmkUmVXRv+FmZIfaLgiCQhuHsP8OaIUXjyOk+wmPVwnOTT2VbXv01i5Bfl88LhSKnM
X-Gm-Message-State: AOJu0YydaE9ntS/NHx9I7aH8HPvc9ACm7ZSMptUVq/NT/aBstGPSFMoJ
	XoLp0d09Ye+jSM+0pUu77WH6lEcLoyXE22hmsyd2X5dsXmpHESBkQIx2WVWq9LE=
X-Google-Smtp-Source: AGHT+IHtkzdUfQObjmEVprHkzFN8zKAN9fTh1YCm+Kcmac6VM9gqN/CwHy0s14ABNvz7H4Poi3qpvg==
X-Received: by 2002:a2e:a792:0:b0:2e9:564a:db29 with SMTP id 38308e7fff4ca-2e9564ade37mr5621401fa.29.1716455900802;
        Thu, 23 May 2024 02:18:20 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e5686b802asm36602901fa.95.2024.05.23.02.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 02:18:20 -0700 (PDT)
Date: Thu, 23 May 2024 12:18:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Sandy Huang <hjc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Andy Yan <andy.yan@rock-chips.com>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Sebastian Wick <sebastian.wick@redhat.com>, 
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v14 08/28] drm/tests: Add output formats tests
Message-ID: <h4t3rsxz6yez5fosi6lyvob5mbngkjb7ad5e4euddhokcjimn6@dif2qzr2xjhc>
References: <20240521-kms-hdmi-connector-state-v14-0-51950db4fedb@kernel.org>
 <20240521-kms-hdmi-connector-state-v14-8-51950db4fedb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521-kms-hdmi-connector-state-v14-8-51950db4fedb@kernel.org>

On Tue, May 21, 2024 at 12:13:41PM +0200, Maxime Ripard wrote:
> Now that we track the HDMI output format as part of the connector state,
> let's add a few tests to make sure it works as expected.
> 
> Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/tests/drm_connector_test.c         | 99 +++++++++++++++++++++-
>  drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 32 +++++++
>  2 files changed, 130 insertions(+), 1 deletion(-)
> 
> +
> +KUNIT_ARRAY_PARAM(drm_hdmi_connector_get_output_format_name_valid,
> +		  drm_hdmi_connector_get_output_format_name_valid_tests,
> +		  drm_hdmi_connector_get_output_format_name_valid_desc);
> +
> +static void drm_test_drm_hdmi_connector_get_output_format_name_invalid(struct kunit *test)
> +{
> +	KUNIT_EXPECT_NULL(test, drm_hdmi_connector_get_output_format_name(4));

Nit: it might be better to use a bigger value here. It's easier to miss
this if other formats get added for whatever reason.

Nevertheless:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> +};
> +
> +static struct kunit_case drm_hdmi_connector_get_output_format_name_tests[] = {
> +	KUNIT_CASE_PARAM(drm_test_drm_hdmi_connector_get_output_format_name,
> +			 drm_hdmi_connector_get_output_format_name_valid_gen_params),
> +	KUNIT_CASE(drm_test_drm_hdmi_connector_get_output_format_name_invalid),
> +	{ }
> +};
> +

-- 
With best wishes
Dmitry

