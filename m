Return-Path: <linux-kernel+bounces-441837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7299ED4BC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E063283E3E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAC324632F;
	Wed, 11 Dec 2024 18:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m2SDwYYe"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3869D1D959B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 18:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733941978; cv=none; b=DEkG0Wd8icLaCvnF5FOFRD7f6x6E0igL3ncAEEBRPhUOKsNjkLTYw2sOUTOGTs6fYavLXLtQQT4xq+soUMUHDOFx2fQjuHjpcpUSlWvKrAMvo/BsHX/wSC0E5q33c0CQD9nW4gmcnBf1mzC70hXV4LdLE91LxC7vcOI8TNfLeJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733941978; c=relaxed/simple;
	bh=JyMdFqQ5H7a+y8ZEgtz5H4pttRzC1chxkXLm88NSVNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSLnvVr5382vlB2RgmR4C5YvbBLDxiYGAzinkSEXqM1nDsYL204ll0vPXeC9Lp57EXvtalAG1yfIUZAnTY+tMCVOhhP+pSRVfe2mswWoSw2rukH/Kkm7AkYkE1uhq1SMN7q7b6/3mTxZSwOITnnCFioCj+zPzR1FGjgsHJXDFIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m2SDwYYe; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53f22fd6887so4402575e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733941974; x=1734546774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qwjqsNH/3nF2Q3XbWudExYhlk4EBq4Q9BHCqHdvdEaI=;
        b=m2SDwYYeWD4JdE/vgvBEToHnM3qCJ0ziUxTHBlSEv4aWQsECsTww4wSKqpyVK2KUXD
         bXfA/ubryDkZ7+XpdBOrm2LBtCP4OrG0TcfIggjeD8mRIRaNZ3rGHBt97E9SzGWmN50L
         jca24gP0wWkS9UAXeVJ0YkzvIWxznoPTwdR09FSToPMVSLdN6T2cBxOeGo+iRwjs7rsW
         XkferZnL+cilsS7PzterMuEMPY+4JEnuHWhnL+/VC1FFY5ZEdFLHdu0Jv+o2UvPlGEaF
         gU7aJm9rcF9DeUFGNbXY/2EJF4yADt65sRIt9u5gdT3UdZwcYs1aKfxEBRYRUB277ThM
         n7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733941974; x=1734546774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwjqsNH/3nF2Q3XbWudExYhlk4EBq4Q9BHCqHdvdEaI=;
        b=OcHCEl1mVVV2gPetrliDTxldR6n/nf4MuH3MyfvL9nl5qXqq/SwHTblemQO684c9h2
         fTv9pfwgNkLb6A7Up1J3nlhfLHwTGBgtoxfpTBJ0Jx8bKUpmfw3QfAf21//oNxOsAlGl
         EWyKRJKen6zvabIiBqzd4N61YC8F3xjG9jEK2u9lGB85dmXlF7Y0hULJ67R4Nk1i5kQh
         +HwKtdRKnRD0DSlslrkKiOIFTK+edGE8gjAWz5fRRyPMZlR1PZW8Cqdv7WFxOezL7G+W
         /JyjimBSBpE13LFdSxy6MOqH/8pghjcTu8drS/rsGxnRFi/Sr+GHyG/WexuTFT+v/TRo
         6rTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5ekGykp9JG17rkIf16gpRRIrVlbFFg3mFWvoGuDkE8SOny4LoWJjV1GK3ClQKKbOMLzP1A694pTa2h10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7wI7vpvs9gS+TpHf/8t3vjlN/w6sxmC46y2569mWEjkwAdhja
	y6H36LLtgqBYQhaYzmRnzcoDmS/l0PPqIaBHwndX29ffwkYlKcEm/jyqgu5eYow=
X-Gm-Gg: ASbGncv6LLIOCACfLoR6x04pmAv0ZPQ7B4LCBeNZzk2pdem6tH8E9yB7R4UPwfKKnOw
	etZn/ZzyeWToe61qhUOvX1aldsKBg6x/jeyi82vRPJC7B9DX0MY+5mlVVKY9i3bxnqxGj22sN9C
	3bN+ho+I6W4JjK5tR4nrta5i5+Nbtkj61D0mvg3PAolxYWkHxd8aoe6B9d+wUGn3gEveL8lTH3w
	TdQ9MIyPWDoPEkWK6TwFLKCJvyXIqiAxKbQixfESNuBYV2xI9K9zy7WV7iT/5xFQShv09VvQUSm
	2xi3L/BFc6aSLIAfxu0Hg/2Yau8pXXNMag==
X-Google-Smtp-Source: AGHT+IFmZdkDf94Jsx8fCrALITW/9iPuUY5e7Ad8TDSKUOMmNblYCFB7l7IPRhIdF6tMpVRDpdpenQ==
X-Received: by 2002:a05:6512:1329:b0:540:1dac:c03d with SMTP id 2adb3069b0e04-5402f04d0ffmr331050e87.57.1733941974289;
        Wed, 11 Dec 2024 10:32:54 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5401d2aab5csm1134637e87.168.2024.12.11.10.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 10:32:52 -0800 (PST)
Date: Wed, 11 Dec 2024 20:32:51 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Abel Vesa <abel.vesa@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
	Danilo Krummrich <dakr@redhat.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH v2 1/4] drm/dp: Add helper to set LTTPRs in transparent
 mode
Message-ID: <3omcjrgfkdmw466ok7gej2jge25vtwzaiycwz2xgejwppyvkza@rhssgk7xz4hj>
References: <20241211-drm-dp-msm-add-lttpr-transparent-mode-set-v2-0-d5906ed38b28@linaro.org>
 <20241211-drm-dp-msm-add-lttpr-transparent-mode-set-v2-1-d5906ed38b28@linaro.org>
 <Z1mk08SHEd5_vc99@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1mk08SHEd5_vc99@hovoldconsulting.com>

On Wed, Dec 11, 2024 at 03:42:27PM +0100, Johan Hovold wrote:
> On Wed, Dec 11, 2024 at 03:04:12PM +0200, Abel Vesa wrote:
>  
> > +/**
> > + * drm_dp_lttpr_set_transparent_mode - set the LTTPR in transparent mode
> > + * @aux: DisplayPort AUX channel
> > + * @enable: Enable or disable transparent mode
> > + *
> > + * Returns 0 on success or a negative error code on failure.
> > + */
> > +int drm_dp_lttpr_set_transparent_mode(struct drm_dp_aux *aux, bool enable)
> > +{
> > +	u8 val = enable ? DP_PHY_REPEATER_MODE_TRANSPARENT :
> > +			  DP_PHY_REPEATER_MODE_NON_TRANSPARENT;
> > +	int ret = drm_dp_dpcd_writeb(aux, DP_PHY_REPEATER_MODE, val);
> > +
> > +	return ret == 1 ? 0 : ret;
> 
> This looks correct, but I had to go look at drm_dp_dpcd_writeb() to make
> sure it never returns 0 (for short transfers).
> 
> > +}
> > +EXPORT_SYMBOL(drm_dp_lttpr_set_transparent_mode);
> 
> This appears to be what the driver currently uses, but why not
> EXPORT_SYMBOL_GPL?

$ git grep EXPORT_SYMBOL drivers/gpu/drm/*.c | wc -l
962
$ git grep EXPORT_SYMBOL_GPL drivers/gpu/drm/*.c | wc -l
93


-- 
With best wishes
Dmitry

