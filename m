Return-Path: <linux-kernel+bounces-441971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5899ED64E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1390C188DC92
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D344A1C54AE;
	Wed, 11 Dec 2024 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Et8Fe4Lu"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A111C245C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943640; cv=none; b=S1pa2NIwtyRpMyg6ZdKboq8Br2tzooh8drRxbgRaPHTw/GjOmxjVGxWPHqJskkHVSXedPRXsBSu4fGsfXmcGgFyuZmHt39umoO0lVMmQ6yX4MBoRbHUdpcOC8XqRxxBBo9OaJQXZXmZwRBx4vvmA883JOww3Vn8/ubTYhUkjFtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943640; c=relaxed/simple;
	bh=fi0lDtOLuW0t/tSmG3MOxUksjKQjuEDF/3frKFG8+Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwXkkHUndeufvkJg9FK6uapHsLR9SbOXJ0ScC6D0rRbQNHCQssBiLNca6wSlfkPM/wY0jRMWgKjU1qtP9tcRBe8jznvCScytFHP2RKgHi5igrs7Ng558oYX9QEaO2nJOGzCAwAyYgH7LpEG8bdQVC86ngC2wx76LYNOX4Mwlwcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Et8Fe4Lu; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3022c6155edso26869311fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 11:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733943636; x=1734548436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3sm2j3frVX6XobbLx+2sssGo00nVIVVj/64ej0M6DaQ=;
        b=Et8Fe4LuxVo+moKmPKiqqRs9a3nmy6Gklnq5RodP/Ihs+W4jCwghiKzn8VT7wUkHVf
         PyvJ3i3JEHcRAaigVbmbsbCJm9HHnt7KIjF4CEaApf2Xm5sng9BEzPEstgu/RvyEagTj
         xKJ3vQedKxGLgfElhQ3B8R2njpnmdTC7KualqhNaoqjOvqwvsy+yBKVcynU12MetO9au
         Cs7FxiyUYiEw1KmfvCMD7gK9IlpsHSicD5JbwoCqnsMQeJo8qp/x0KviUXZPiYwO3wH3
         nhLmSs6s7fK0W02U+GjG/twBH1ZlW8WwRgbCtQdm/9BjrJu378HvG0nvxHKd6ftOi1EA
         mnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733943636; x=1734548436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sm2j3frVX6XobbLx+2sssGo00nVIVVj/64ej0M6DaQ=;
        b=b9++6CzNQHmZxIYNjE/uxnJobVFeDMR5LbP8dOQfiBSBtmyzBXM9wdGme6GPdBV2Pn
         nMUIcYP/YMYaRrJzgQTpRHP1Wfbe+D+tRDytSDrWVOqFZemyrlIKtrPdk/MlJ/z+mqr8
         xK3GHYptnhzSrdJPrbFrlrE47RUMGVf1ooED+mOd9jA3Gt/4vaJzoAxJTsAC1DsPu3os
         SXf4tgKUVfnNpvdlPtk3ADkKUI35jJvZTSre+4yaaw7RGz5M0e+UGC1QgrCdQ2l3ZEiH
         RG8MpD+Lzom7dBlOfQ/qhjjmqyzFYXdi9LjPmhsoHHyTKiz/0tlOPZIBiJM+jxEl3cms
         Z5Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXYzMAwx41NKQRWQphXn8M8mO0F4b1z9SSeooJ9wnWoJ4/FjjMZq7FylVrdBBCiBCfLFxIafrjBb7RFdAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAJmjORyhIhJ+Zt3ZaF16U2TYV/5USsOAAgoEsG3B9Ww7PlotG
	R4mGuYDmzCTug65c1Z/SXAQB+DHEqUeAU/h1LgXVI2PP1C+tgPAIpyLAJXPZ3Oo=
X-Gm-Gg: ASbGnctuD0CK/ebx2FPzDyU+0QN/xv/YEmIAYx8UaPKv3f4aiA4i/qdm402QWmw1Ovc
	NUf5tZ37VqnvEuBjoHe+JkOO4scg/hMtwQm64wrL35Q1g/FneevXBGRTSlP1MlmDRlBwhg2p+8k
	W2jX1DVE6Rf/HDj+5f2rAIwaePwByCRScv2jz+dJYutXFg4vSEjmNlRoVJELGRAtVPx8CBGDXmG
	nFlFeC24JBUFNUWGnaVxUXz3uUzIocNMlfBbhn16xkAWif7vkVuZVIyl+Qo72B4L1XDFl7iZuQ/
	VAgsmVeZ9PsR55ABGfLEu77KmiHmMkqpLw==
X-Google-Smtp-Source: AGHT+IGsgdXAdVI72VjehBhRAGYyQYi2ZlWZ5S+RtIUjGgQQsMEhY9vE/LoWlhZJn7MQjhDvpgk8fA==
X-Received: by 2002:a2e:bea2:0:b0:302:2620:ecc7 with SMTP id 38308e7fff4ca-30249e89ee5mr1842641fa.35.1733943636318;
        Wed, 11 Dec 2024 11:00:36 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-302292959c0sm8657671fa.94.2024.12.11.11.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 11:00:34 -0800 (PST)
Date: Wed, 11 Dec 2024 21:00:31 +0200
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
Message-ID: <qh5ochh2cjqj76qqbbj7e2jmyie6pbnvgcr5wti5eigc4qxjod@v5tov4s65sdb>
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

Indeed. It got me a while to check that drm_dp_dpcd_writeb() ->
drm_dp_mst_dpcd_write() -> drm_dp_send_dpcd_write() ->
drm_dp_mst_wait_tx_reply() never returns '0'. I'd prefer an explicit

if (ret < 0)
	return ret;
return (ret == 1) ? 0 : -EIO;

> 
> > +}
> > +EXPORT_SYMBOL(drm_dp_lttpr_set_transparent_mode);
> 

-- 
With best wishes
Dmitry

