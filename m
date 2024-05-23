Return-Path: <linux-kernel+bounces-187286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 988FB8CCF7A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 380A41F2324A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECA513D296;
	Thu, 23 May 2024 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E5NYLLE2"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8834317F6
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 09:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716457273; cv=none; b=RTFf/0xSWDc6uaTzjBukCFyOqb1lcgsOy8rHmpAkFm9KZ/Pkq1BrgEU994U0R8eF1T53/b2fiFgkXR4eUpDoFtOGV2JPxTOZ0XINeyxUHt2YAUJ3rHuXaQHRk+My/4SkZgVYI3P2JN6nw2NcATAdiLnkmQN/+InmGjXgNVj2UqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716457273; c=relaxed/simple;
	bh=j2zx3VaHX0GsfKBrlQgn1untBcEyimrqEdjGH5+DWdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3/HOMAzguKb28tO2L4qXO2oIodSa0dvO0kVD6keIv6j3zPa5+6D6dRAy60/j2/5fZ7vg88fDeyrHaVo+e58mPoCTmTcAtC4Is/39G1D0BF4kn/Ls4Fq/Fdx759HoIPMQxSCQFSRTQlYpAx5u44VF+vhhXF3VV3gZh9ViUbIVWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E5NYLLE2; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51f57713684so8996839e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 02:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716457270; x=1717062070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ymOIxLRXX6/t992boJGrCdN0THAC8qBuamXJNsylAfs=;
        b=E5NYLLE2otA5YJCF3nLVWisS/DzmSW2A0uqi6T4ZhdoRKjLe7LLqbSCX9/WS1vWBsB
         Za9COMKgC3G4chCxrt97Umzv9xuceDHoVQD4vywBhAsxxfDFscGNlG1Ws+ncyuyfsJsB
         LSQprJnj4VqnMO8qY8/h/aQmZrjLV5HGPh8whUw8HJJxf/ynW5W01PEuj8K92yY9b23t
         FKppsKdzuhLTSUrVILe0WtJxx4rVnkqvBDAOlQ98O7uHt4ctCwl4EWdH5a2q+Mx8/qbk
         fI6rg9f0+4CBwOYtYM/BRlfaa/YhAk2iJfYPN2PIKj7WY+3PCIBHgmBUJ76S5IbO2Dzo
         xHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716457270; x=1717062070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymOIxLRXX6/t992boJGrCdN0THAC8qBuamXJNsylAfs=;
        b=tFm8zP3SAmPXI32SVt8gHZM8VR8DREZnStTm50AAE4lknNG3T73T+UnqumbcDPdLG+
         B/IJPbbtof8fS1wHHrOgAcubzkgfLobkmqwLNpcRrETzlGWjQPnuNu0heOD2K9mgUDQ3
         gcPTMDLeHoaqcRm0IXB6cVz/+5g1MbP/MQ2NfGhQO78gDV/AdX5Tc2E+JD1OBTo6wSVE
         Fmw4HcC0LXbL39tEqec+Gb3gKb3NuMttWKxCF/XIjIpDhbzEKc6FoiHXiA3FS+efXK+v
         M5lcLwkbflpb6EEL0mI+E/cu26SS117UpD3hSEMqPabW7lS+Jzly6Pw2eaST2J6vnK27
         kDYw==
X-Forwarded-Encrypted: i=1; AJvYcCWd36fWlK0dolyMs6rnmeUTkK09+E7ZGB0NWrmzJCGeWHDvkfPMADxPno3LXQlmkSJKTkLr0AyGAUeiiK20QTjBM8sAJf0H8iIs/ylU
X-Gm-Message-State: AOJu0YxglRZX2juLBbaKE437zLUfC1DyVbAV0fbRxh4Cs+I+2lXyk6fg
	F8WTestH7kFXzwA96A+aSfKBudIUrnb5W/ZC1TQSdyLvB5iwr9sqdy8srBfG91w=
X-Google-Smtp-Source: AGHT+IGDBnS6Yxc91Ez/LJRvHEhoF+0Je5SmLoZcaOOlSUX1bIaRGc7t5bjpMnVmIRgP+hN+dWcqmQ==
X-Received: by 2002:a05:6512:611:b0:51e:f1a6:ac39 with SMTP id 2adb3069b0e04-526be6ea79amr2624505e87.12.1716457269807;
        Thu, 23 May 2024 02:41:09 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52394a319f1sm2983965e87.64.2024.05.23.02.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 02:41:09 -0700 (PDT)
Date: Thu, 23 May 2024 12:41:07 +0300
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
Subject: Re: [PATCH v14 12/28] drm/tests: Add TDMS character rate connector
 state tests
Message-ID: <ghotwzdstmtpnovbmt2fgvxxkcno67hfwydzjzbyfn6dkt247c@52ycrfinmimo>
References: <20240521-kms-hdmi-connector-state-v14-0-51950db4fedb@kernel.org>
 <20240521-kms-hdmi-connector-state-v14-12-51950db4fedb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521-kms-hdmi-connector-state-v14-12-51950db4fedb@kernel.org>

On Tue, May 21, 2024 at 12:13:45PM +0200, Maxime Ripard wrote:
> The previous patch stores in the connector state the expected TMDS
> character rate matching the configuration of the HDMI connector. Let's
> add a few tests to make sure it works as expected.
> 
> Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 166 ++++++++++++++++
>  drivers/gpu/drm/tests/drm_kunit_edid.h             | 216 +++++++++++++++++++++
>  2 files changed, 382 insertions(+)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

