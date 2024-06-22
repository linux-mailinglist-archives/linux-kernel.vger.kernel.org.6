Return-Path: <linux-kernel+bounces-225665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3BA913372
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 13:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 177BD1C211CF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 11:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D606C15445D;
	Sat, 22 Jun 2024 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LPzAKJUq"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE0214B950
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719056694; cv=none; b=F/ZQ0k8OpWa6FhMjf80/0qJYnv1WeLmArChRBcKCHTrE34/2iz2/mVEIiuGNKkYMUgpManb7c5YdHXdjlctnBhyoCtwqHi+buPy/lNdFSVfQiBwIH6zJPwM0N+5L/P7KTuXQepBLx+C5vq3ezyjq8HOk+yId6EORo5N5xsPdALw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719056694; c=relaxed/simple;
	bh=ILrMcRABfLu5odx0xmODTpZOJXAX3oCtYEXvGESWBRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUTlXow7kjhkMJnYtOqT+0mTNvxV/QT9WnAXaw2ttzslN3eP+mJecjps9YGwAs2mstjgPXFecWLHaIzWnX8ZfUwnopR09kn9l6m1VxgQoGIIe6JH2C/psBssZ/uknJ/skez3DiQ+oHt27yjN+6T+aA9H8lwg2vRxAhfmm7EbyLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LPzAKJUq; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52cdea1387eso427356e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 04:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719056689; x=1719661489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ax1qSIZw8a9/jFifgEYbxj7FR9Vvqi+T0eMK+uliwIg=;
        b=LPzAKJUqGJ7VjvpE4c2PPsMgiG5pltezr9qHYz+ZbfnFhjPrTnYmrosoFux9kG34up
         knsTTGbMpb6a8lJZA7nKnmwtQ8NiembOY9m4n7fZA3wxvfDbEh2D+fH0PURJ85mn/P1f
         wSxTGD9VaVpGjBQ0XvaPW3ldY6aEpXoSLTz3THTyb2TYYQ77zrrsdJl9yBMG/KIrcVla
         1uF85LHfjXZ6EA6h/vJD9OM/Dmh+VSrwPMQ7Mhg5agy8WVGRMRrT/OUnSmc4PyyWFhAk
         CpMM5bbAfU+UCcKp8WFDwZdBaIS+s17jnDPfYpMOf08ng+nmtZ+A//90KG2pSaYiXcVP
         WCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719056689; x=1719661489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ax1qSIZw8a9/jFifgEYbxj7FR9Vvqi+T0eMK+uliwIg=;
        b=M6PHbHK537Cxk1zW6hgMU+AA/JiSUhQBpykbQiCNLKwDzt0G40KzlHsnmHRPl4wlLo
         P84KXOYiOKtWW0H+B6eMOl1m/Gchny6z6RZPHs9kFgFMAJ4u6lExSfTDpu++wAVcJImL
         JLICeLPWPAYuBq3jJZ6U1RWbjWKPxuhFf7VuVWirvNstqenslrymTCu6Tr1lQINwdIoy
         3eVoNf7yyeZLbwJ8gOIRBPqLf83g9kv9h1dIBel+IsH6tyr+WBUB5VSngV++qa9SKmbs
         hK9FUYvt2kzDJMNStOJ0p/VhNZ5hGF+oaUajk0sEafmLorZPHuVhJsqq/eqch4o/u+zZ
         2HeA==
X-Forwarded-Encrypted: i=1; AJvYcCWHAbeCbWYhYaKckdv0Y37TwCQvVUsg65INNtPJDlx+i1pDKK90PNMoeERq4mE/VsHwrfWU6IyQot9+DyFtDw3JxuvD9N/CTZbeyvq7
X-Gm-Message-State: AOJu0YzrWZrtb1HB1rrmTbo+9EzqpenrofVFCoZ2yIsfhG/x0eMaLg6E
	JY+7e+15f6WLhJBDEWOGhSuBmTkJjTXujPMxktmnihSM/2M4R3ekGC6futfYFXY=
X-Google-Smtp-Source: AGHT+IEuZ2USoydSTh3MwiJDZ0wxf9ZiV0ueTgAhwf/h2tPzISGQ48W190i27F9kY7dhP1o1sgjyVw==
X-Received: by 2002:a05:6512:3496:b0:52c:d96d:6c7a with SMTP id 2adb3069b0e04-52cd96d6d3bmr1871338e87.60.1719056689522;
        Sat, 22 Jun 2024 04:44:49 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd63cd698sm469653e87.118.2024.06.22.04.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 04:44:49 -0700 (PDT)
Date: Sat, 22 Jun 2024 14:44:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Danila Tikhonov <danila@jiaxyga.com>
Cc: robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run, 
	marijn.suijten@somainline.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, quic_rmccann@quicinc.com, 
	konrad.dybcio@linaro.org, neil.armstrong@linaro.org, jonathan@marek.ca, 
	swboyd@chromium.org, quic_khsieh@quicinc.com, quic_jesszhan@quicinc.com, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] drm/msm/dpu: Add SM7150 support
Message-ID: <oks3xgn3ks2fobtdys5b3ssw74fwn433q32glhebq37snz2df6@oc2h6pi34tlg>
References: <20240614215855.82093-1-danila@jiaxyga.com>
 <20240614215855.82093-3-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614215855.82093-3-danila@jiaxyga.com>

On Sat, Jun 15, 2024 at 12:58:53AM GMT, Danila Tikhonov wrote:
> Add definitions for the display hardware used on the Qualcomm SM7150
> platform.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>  .../msm/disp/dpu1/catalog/dpu_5_2_sm7150.h    | 335 ++++++++++++++++++
>  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    |   1 +
>  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |   1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |   1 +
>  4 files changed, 338 insertions(+)
>  create mode 100644 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_2_sm7150.h
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

