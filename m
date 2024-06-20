Return-Path: <linux-kernel+bounces-223452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68565911345
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CDD41F22143
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D238755889;
	Thu, 20 Jun 2024 20:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P328i+xN"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC443D0C5
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 20:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718915574; cv=none; b=LMFo4nck60SE6x3M+bNqpPLDUvJd18Au9XmzhQHReGTj1Y/dAA93S6m8SIDaUdo/weOKBdNYn4DBDgqGmFH/Uo5cED06yVbdL+AShPRXTeYm2epTBCdHgvNxUUz4MgQjVqj5h5T/J0EEMJ4DpTgwUP6uPVp/eSNkQ14GV3ekp6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718915574; c=relaxed/simple;
	bh=fogFjWWPw/o0m94cEvM2T1q8NqR8lntPouuA6iZsNto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuBWlwiG9AjqvZX/Ctk0y3WpuFvktRwDLp45br+OMHitJZ8zDgEXXIgMyJHwsJVx6EAVvYVZVCoM7w27L5TT4xS6rhvT+J0zCdbLKKBKJOs7AmVCBEMxYS6xsb4RexHTHPUEpiBOQ4oqPOPyJRsaa18KeVpaFJAyJBIU+l4WEkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P328i+xN; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52bc27cfb14so1829587e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 13:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718915571; x=1719520371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yq0nWUsKxD4rK/v2NoFPmPbkAY476HU9+6IpUl30jWE=;
        b=P328i+xNnq8l9/yKDg4BGri98xFaRSjVyWJ2NvFyt9MfyiEiOiBDO1ifJqjz1na72w
         P+zRvFBj8be57v+PfjLKjS8rmzuR/K5CUbcRqZz00RGmyCwHrAm6UVNH4oEm1Et5kb7n
         n1D7AHymtmDXi8RkmiWD5q38rDZ40YMz6PHjKaI40b7B/C0oInQpT9RtbxRtFh70NcR8
         ZmZngcz0EUHWXz+4xE5AodQlrBsyuCisSrYd9zY+mEWzoPB4jOtifsq8YsESZp9WoJyj
         ZKnpVk/jTUfn9Q+b1pirwL3HYJtM6jqO/2sXe3m+AShuzQxgQ+C5ynhk3n3/p6Bflotk
         MaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718915571; x=1719520371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yq0nWUsKxD4rK/v2NoFPmPbkAY476HU9+6IpUl30jWE=;
        b=KjrMfxags49639zAF2Mz+YS2H7tfNP/+7ncRkawaN+jcGp61otIg/P10QAdIj9FbMS
         tMMzuOWojrgJaoDFSG6FZ6aebRh3LLmL3OS2CC16l6kR6WYoIv5RBFRZ3JU/bQLMAgHd
         LVVDS5WxGSDeLNlJasQQiNUs6PJGGhBoBObcGWejDseSKI/1x1jofbkrHbBUrG6og4Dr
         IMMFmpJaLLHaMFm+HRgP2ECOC3UkkGOoVZDJz0U7nLIj41gKFosGbS+xHdLDKZgQ/oo2
         LqGoFRNlFR82OFxxx2Lqx1vo2l2rwnyHsj2P7iFAIcqb2kf87WkBbyoOj57eKZ3G+uuw
         6QRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlSG/RjL4HNocx/Y3l+Dpi+pYYzvEi1wMcqpQ0gLMNqNn57T6tzsfOyXDYtoagp926gt9dvqZWUmIyguC05CvZcABlWFMid9o46KhE
X-Gm-Message-State: AOJu0Yw30mQ0z28PTIwla2GckOFEiJZ1lTCzU/1JFcPR7f/maVwsYzmv
	GR5HxcwvOWb/vrksUcFjzrK3EM2XXTJ4zM93ygfd7Afg4RL6S1ObJq9UjryhaUc=
X-Google-Smtp-Source: AGHT+IHMpcwkT02hJ8steyoLT0MHFupFKcYGAIgPIehNeuT8A2kH+0oB8/Gv4eoKPRkoRs+Es9bF5Q==
X-Received: by 2002:ac2:4568:0:b0:52c:c9e4:3291 with SMTP id 2adb3069b0e04-52ccaa5958bmr4931076e87.60.1718915570794;
        Thu, 20 Jun 2024 13:32:50 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca287b245sm2162968e87.205.2024.06.20.13.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 13:32:50 -0700 (PDT)
Date: Thu, 20 Jun 2024 23:32:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/9] drm/msm/hdmi: turn mode_set into atomic_enable
Message-ID: <xymopystyfjj3hpqes3uiw2g3dqynxzvz23snrbfzf2judgxnt@j4nmpcbuy7a4>
References: <20240607-bridge-hdmi-connector-v5-0-ab384e6021af@linaro.org>
 <20240607-bridge-hdmi-connector-v5-5-ab384e6021af@linaro.org>
 <f34c4210-fd59-9d27-0987-3345631c9e35@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f34c4210-fd59-9d27-0987-3345631c9e35@quicinc.com>

On Thu, Jun 20, 2024 at 01:27:15PM GMT, Abhinav Kumar wrote:
> 
> 
> On 6/7/2024 6:23 AM, Dmitry Baryshkov wrote:
> > The mode_set callback is deprecated, it doesn't get the
> > drm_bridge_state, just mode-related argumetns. Turn it into the
> > atomic_enable callback as suggested by the documentation.
> > 
> 
> mode_set is deprecated but atomic_mode_set is not.

There is no atomic_mode_set() in drm_bridge_funcs. Also:

* This is deprecated, do not use!
* New drivers shall set their mode in the
* &drm_bridge_funcs.atomic_enable operation.

> 
> I would rather use atomic_mode_set because moving to atomic_enable() would
> be incorrect.
> 
> That would be called after encoder's enable and hence changes the sequence.
> That was not the intention of this patch.
> 
> NAK.
> 
> > Acked-by: Maxime Ripard <mripard@kernel.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 33 ++++++++++++++++++++++++++-------
> >   1 file changed, 26 insertions(+), 7 deletions(-)


-- 
With best wishes
Dmitry

