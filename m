Return-Path: <linux-kernel+bounces-187415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AB58CD17E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E566B21551
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FA913BC02;
	Thu, 23 May 2024 11:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eu2MPfML"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF823307B
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 11:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716464889; cv=none; b=uVSw09UaVlcfwkkAMbST77/hnR9EbR6t3rpnuL7XIWBCE2+UN/E784rfeX4uWR3e+/DZmgh/kZpQUZ/YFHWoJXxodwnM/Y3IvYygI04TBCMbJyLAsadWowsv7rRMRTEG2rbAubiWO8Sto9AhZP0xFuSQ38b5OCiTncJ4Z/SG+Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716464889; c=relaxed/simple;
	bh=6V+8CtsowbR+5woKWil3/uTefTydyG91roAsOsQIUwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAitaW8a0THMhXA+SmflZY8Vq9UjxPAdo/CGxYZI/qhEqQp7GquGwwTWJxWl7XrT7XnihJGF+csb5t4tzPi7s6tASysYYW0rmoOPt4QYFLa/JzNvwcAi9r0DKgPUkc3XF04Mv8kao8A8qqUPni5aZ8/qIz7wFYyIQFAy0N0FCDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eu2MPfML; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51fcb7dc722so1787834e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 04:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716464886; x=1717069686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6E61Jxzxjq7f22HqS8A7YYLGqKHl4SecZqgeLR9j6N4=;
        b=eu2MPfML45bIbUkFG9ND0l32+AcC1mGrmcpzDDPaGNeIJBK1SaBEBWaP4r93sVEEMU
         q6Qb9n3kziLw5Sol37PE/WmpDh61TfDG71RL3jHfK/fmaAPYVyw18mn9OtVYFVM9WIww
         oHBWW7mZNOCNDzT1zFdi7uxz+1RbObBB4NG2CSZzRMuvMLfGYvGiR7ep3QGpZABOH/vy
         MvGI3hW+AWwXlBix6M9RUF5apPzISk7LdGNaeMBtmFEvUD6EL3LCOTiDAQhaG7J5XOQM
         GGHwQwFv1ZctJBjHqvkTlcJYOXyFZyU+MzeRhAHmQ1LmNQDCTrFuqPpDq48+jxe98ADc
         wjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716464886; x=1717069686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6E61Jxzxjq7f22HqS8A7YYLGqKHl4SecZqgeLR9j6N4=;
        b=f3/TDF16rNg8jtmnpj/mBVgpPW+z68CnOSUKK1lLciN0tHIQPqosTPkC1fBAGpmVkH
         oWsrhXl1e6bOa/2Y75QMEMlXstlokBmrfEmtOagXm2HxKPCI9AmhQx8qHMWoqpc0yX8A
         PvChxkbRVoQSXQsupPfsIdG2PJib8yPBiTGMon7BQRs6Rj8DfYm+IXaImIsBLwVXQYaO
         cKp7WataQamb0fdJBzeFi2x0mZld1m47mp+gqMnowDFkmXF9V+YlMjnY6Oh1jFJSwFoW
         kJTfclzQeJ47vPeOufRs25iQTl7d7vqnLoI8YTzMjwpgeORC2/sqUv0wXkmrLkk6uzKU
         mcqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo7++n1vtK23sYhN1T6t8Sj+GbfXJNqGEiSAsVvOno+fMaNVm8KbRUTsH0dWcTp/WIlsAWDJm0VSzQ+pJgsQfnOl3dzioAHeXCojvr
X-Gm-Message-State: AOJu0Ywy4bVGuJI9iFcP/RE8IvKxoN2XwRZKTSA1zniOkgY5TNydpWeE
	jj3ub0r38/6lnqf4zRdszDb4i1DfUeNVMo6t3q8X9Uc3Z0nGCCOpxgO1Z8+EIBs=
X-Google-Smtp-Source: AGHT+IEyzI18nfzrDPezUD9GxCNOdOCNYajNRn6pfAF677xU9i/D+vNI4ocAHpHkdn63Af8sVdouJw==
X-Received: by 2002:a19:2d45:0:b0:51f:30dd:f35f with SMTP id 2adb3069b0e04-527ef9d932bmr566891e87.14.1716464886556;
        Thu, 23 May 2024 04:48:06 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-528ce560b22sm42924e87.238.2024.05.23.04.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 04:48:06 -0700 (PDT)
Date: Thu, 23 May 2024 14:48:04 +0300
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
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v14 23/28] drm/connector: hdmi: Create Infoframe DebugFS
 entries
Message-ID: <dflaec5kcwlo2y23txb5susqimiohuvf5uox5kecmbrcs4wnox@dq7xak3vcazm>
References: <20240521-kms-hdmi-connector-state-v14-0-51950db4fedb@kernel.org>
 <20240521-kms-hdmi-connector-state-v14-23-51950db4fedb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521-kms-hdmi-connector-state-v14-23-51950db4fedb@kernel.org>

On Tue, May 21, 2024 at 12:13:56PM +0200, Maxime Ripard wrote:
> There has been some discussions recently about the infoframes sent by
> drivers and if they were properly generated.
> 
> In parallel, there's been some interest in creating an infoframe-decode
> tool similar to edid-decode.
> 
> Both would be much easier if we were to expose the infoframes programmed
> in the hardware. It won't be perfect since we have no guarantee that
> it's actually what goes through the wire, but it's the best we can do.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_debugfs.c | 152 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 152 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

