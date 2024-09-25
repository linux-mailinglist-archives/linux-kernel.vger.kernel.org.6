Return-Path: <linux-kernel+bounces-338256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 320E3985582
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2D71F24469
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5356C158DCA;
	Wed, 25 Sep 2024 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Si5CXqrE"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051823BBEF
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727253026; cv=none; b=ckn3ny9fPlJLCj9LtGmoti6jcQccDaUX6DRubDkda+aHUxJWn4xzwTwDm48t9n9Ghoc+Mh93bzvsYizd+sqlBeW7MJc7dM//Ny54txOjRXgEq6Pjh6SjgnDEpycSR1wWYJc3LlR8FaZx1FZ+Sy1KbNCPZVnjzRGOCXtn4puFgJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727253026; c=relaxed/simple;
	bh=rs+/rSEe9VRu0Fd+3J0hA9sUMjNtbeonHFYa1ks97XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsSyw98yGMF5QKtMAV86y/03Ca6CqpW7OvTKVgw4732A42PtIQu1q+TdxgCyibbskZRJzXnwZ3/wF6RKxDiUVGXyn/GXFalTeUaK2jldKEnFTbOB9FAD2GjQPOxbWUxzbWnDkn+PwyCQ3m29iwYu9TQ37VQ6oq8jh1n4UOSmFE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Si5CXqrE; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5356bb5522bso7648928e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 01:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727253023; x=1727857823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6o6MU6ixdvNUZArkc6QNXbMB1zwtLntaWdMADJeROBs=;
        b=Si5CXqrEvEjvjHxiZARKQd1R0W16Dk73GqzlRiqP3Li8Z5aA+5Iod8OHhw/In7TnKW
         RkojaXf9nmJX9n9/VzmNNnn5kawY9rIIU81fNmRUdYM7Wbz+DJCBISY5T4vlYF2z5DRs
         hu9lN35HfLc5OTvKAjklT7e1f4L2gBXWqy4H62pbQcXwM2dmF/B54HBuPtwILhbsTFGJ
         qYuKoBQbcEFuyrQPsHXFvf95SRaJSAyAUyVxy3mlbAmSYmWbYdaMPZJRRxH/mYVMGw9P
         DzLokGuTGHgAH5w0zf1E6adBcGjP2xifRZmw/6YHygwUvX6Egtl0GhgE+UsJNaVQP057
         dQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727253023; x=1727857823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6o6MU6ixdvNUZArkc6QNXbMB1zwtLntaWdMADJeROBs=;
        b=rAF8QUTqkGHkU3czcWM9sVzNW5K8h3gJuJDmBiq7yxdA6Z2/NK8UsqbkqBo3Pgj+66
         C9QdI/IGp0W/2oE2C4L525pN+CUPc/kKJmI9nOSohOhu7OS1WQfVmca9JE1YL2xSYB5R
         RpbhE5TybQMvlNoL7HBwVAi5tY38JKYfjn1/6TorG6/rVmAgJZ0ffxeoXhA+rhkPuEi0
         r6xu5CBu03Fo8iKccqYmLSEvz4Z2tZTOs5CePMzqtdEGylgEMC5puczDePqLXT44Vr99
         2uW+Dc2lOJjIYnGvDPqzlZE1HvODVZNmi9XwzcljSLaq4IGAmOtDIsc8qr23Xg4YAgyQ
         r+dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ+MU74AtzSGpC4jZ9MU/SQCZn8zI9qYcgXlC55G1TFVA9m9Ihh4mXzyJxQLrCI7D8bzzi5uklGO51nMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeIbjUhFhv+/do6ddYzGOqOAZq0OMbQKHAIRvBS4BkQX8sMeZZ
	n3/57ov2lzxolTC03QE81gatTGF63MtTrtSZxgjVri7YPOyGPGuK1vCNQ5pM3no=
X-Google-Smtp-Source: AGHT+IFvMcEx7oBAVp0S3NPQ6xpw/MxKwhCGJtPZwcS5OitwFqPn3wedxom5YNYIQKZtYLZ34wO+Hw==
X-Received: by 2002:a05:6512:1188:b0:52c:df6f:a66 with SMTP id 2adb3069b0e04-538775666f8mr1042296e87.58.1727253022943;
        Wed, 25 Sep 2024 01:30:22 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a85f0d6bsm457500e87.106.2024.09.25.01.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 01:30:22 -0700 (PDT)
Date: Wed, 25 Sep 2024 11:30:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, quic_abhinavk@quicinc.com, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, quic_ebharadw@quicinc.com, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH v2 16/22] drm/msm/dpu: Configure CWB in writeback encoder
Message-ID: <mk7syagvawspcns3tv6eh2u2fwvhoczp2fpklopwdyhltgg3l4@nsikd77xm4be>
References: <20240924-concurrent-wb-v2-0-7849f900e863@quicinc.com>
 <20240924-concurrent-wb-v2-16-7849f900e863@quicinc.com>
 <qfqvtbc2o2xrv35caonsvhykmq6bvjpc5plnknjgkodrsoez6d@rpobkvdyqeb2>
 <fcc4fa17-910c-4c3f-8cfd-5bedad772b49@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcc4fa17-910c-4c3f-8cfd-5bedad772b49@quicinc.com>

On Tue, Sep 24, 2024 at 05:14:49PM GMT, Jessica Zhang wrote:
> 
> 
> On 9/24/2024 4:41 PM, Dmitry Baryshkov wrote:
> > On Tue, Sep 24, 2024 at 03:59:32PM GMT, Jessica Zhang wrote:
> > > Cache the CWB block mask in the DPU virtual encoder and configure CWB
> > > according to the CWB block mask within the writeback phys encoder
> > > 
> > > Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> > > ---
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        | 83 +++++++++++++++++++++-
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h   | 16 ++++-
> > >   .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c    |  4 +-
> > >   3 files changed, 100 insertions(+), 3 deletions(-)
> > > 
> > > @@ -2557,6 +2630,14 @@ enum dpu_intf_mode dpu_encoder_get_intf_mode(struct drm_encoder *encoder)
> > >   	return INTF_MODE_NONE;
> > >   }
> > > +unsigned int dpu_encoder_helper_get_cwb(struct dpu_encoder_phys *phys_enc)
> > 
> > it's called get_cwb, but it returns a mask?
> 
> I'd based this function off of dpu_encoder_helper_get_dsc(), but I can
> rename this to *_get_cwb_mask() instead

Yes, please.

> 
> > 
> > > +{
> > > +	struct drm_encoder *encoder = phys_enc->parent;
> > > +	struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(encoder);
> > > +
> > > +	return dpu_enc->cwb_mask;
> > > +}
> > > +
> > >   unsigned int dpu_encoder_helper_get_dsc(struct dpu_encoder_phys *phys_enc)
> > >   {
> > >   	struct drm_encoder *encoder = phys_enc->parent;

-- 
With best wishes
Dmitry

