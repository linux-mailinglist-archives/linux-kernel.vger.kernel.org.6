Return-Path: <linux-kernel+bounces-226452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B074913E8A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 23:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D84EB20E97
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 21:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5432D184116;
	Sun, 23 Jun 2024 21:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ascVosis"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023A6181BA2
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 21:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719178056; cv=none; b=sIJkgxUIiHMkd8RSoxuFd5b3pKpPPqg54ZT7eG7YsyeNS0O0GHluOBRj4e4rUBEYLI3nx9OJfcfuO3p1PmRbFnAUYP4xDQ37sQiUu8wTX0sUd8aM/lMUpNP2Cp5C2z98TOsaP0jIcPsSVbBugg+/LylJUy1Zw48d0QDfiF+betc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719178056; c=relaxed/simple;
	bh=4Bq02Qh6lFbXgQAb7khzIsRk1cvOilxhuRJy/OsoN+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXfuT3V3m6eDYqq0ybOUIRs8b5U0/Kp8/KA3cBdHIyHwHxKQPDE/d/03/jeW7Q8o9YtTM65hyAcneZVRnk+EF2IlptIgMj8NyMAEYql5/GOLJW12kpta0wL13Ag+7EqlJs9/qcbI3bCF1/NyC04V4XqcM+CebBVbsIGotnbSvok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ascVosis; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e72224c395so39622441fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 14:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719178053; x=1719782853; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rNE32rpEcd64zunRnTjqX7aU8YPuo7H9EUSUmHlSCLk=;
        b=ascVosis0apWtztoi0HRZ0BtM7LgdtnWysiylMjR43TJ0sZQMM5swLubE7dQd5xx1z
         Mv4CcerrVAXg3epaZbgytM9TE2UQ6RizsWUWIP3XKDCKsbf9+kA3cvnctYxvVGP6Kdnu
         IWb8RxP3oivSJ87Yfmo3MzhwbuPOgK6d9LS9Hgxt3kqijG7jiGWvTDyyw2SG10jbTpdn
         UoCZA32Sbo5pGkkjFFqvSbz+LuXMcjoLJKfQePmDUlqtlIog11S5IZMpEmZmXulbsHeB
         VRL9leAI7Vfqw7v4GJITFwNNT6CvcJ+KgG4KyMDzXIgci2Wr38kac9iA5dBbKHrFWviV
         zEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719178053; x=1719782853;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rNE32rpEcd64zunRnTjqX7aU8YPuo7H9EUSUmHlSCLk=;
        b=BieZpRk0wQRGL8al7N9rGLBBpgXD6MlW89s9KVi6XIuHCujZo+GRqm6YhOtXdhd4Rj
         b6dvmFwJX/hUScbzI6oK3IEFRD0zBm2SVYX2hDZtLCNLuAwXYplxcUzVdwcZ6vEI7WG2
         CyPggPfAJBWhOJuN07o5JtAc86qxM63tqqBQs9y9aT8oQ5+tl7pKA2eT0JHmIBaAXKHo
         PbPiWkz2hHZB9q4wxB8wFMh+jIC/uq3Rf3vGFtg0zjo5Xf+y9uHCvAjXd5cWp1im9jm6
         L7dEVUWzi7XtnsPwNedy1HMGnphTCdhrBNddYVwkbke8xtJ91sGgbbuhZoFPjIV8E9ke
         Zd7w==
X-Forwarded-Encrypted: i=1; AJvYcCWaqMMsW4pQ00BQf8oHddZ8gZx4IdHwCqR1+jp+M2+IdmpZ6/BnLcLXoyV3atg+c04ukW2/3TwmodMm83eNKFP8jjxTxiFowfLJO1Ut
X-Gm-Message-State: AOJu0Yy3hBw/7mVKC+6VEDN3pESoc/65iBqpYmPkXN9+/XYHKwBTjY4U
	NdvT4jCK+LNZ2hmDjAGjto0tYVEoBsa5uVqASKocjBORiK4a4c2AaIkR5YCnIis=
X-Google-Smtp-Source: AGHT+IF/oAb9bDIV7Xq+wDnZQlYyl5KMqCSgJrrR6Xs0F6Q80XAOcNHdPbUBXLkjSn8CcIowI3qwNg==
X-Received: by 2002:a2e:3a13:0:b0:2ec:57c7:c740 with SMTP id 38308e7fff4ca-2ec5b2dd3a3mr15689171fa.39.1719178053155;
        Sun, 23 Jun 2024 14:27:33 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d787ed2sm8287631fa.130.2024.06.23.14.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 14:27:32 -0700 (PDT)
Date: Mon, 24 Jun 2024 00:27:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krishna Manikandan <quic_mkrishn@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, phone-devel@vger.kernel.org, 
	Daniil Titov <daniilt971@gmail.com>
Subject: Re: [PATCH v2 2/4] drm/msm/mdp5: Add MDP5 configuration for MSM8937
Message-ID: <53cpusdumqfqecfcbci7kfb5fmg56gacmlu44rwpe4acdftbcy@pw4wdxrcq366>
References: <20240623-dsi-v2-0-a0ca70fb4846@gmail.com>
 <20240623-dsi-v2-2-a0ca70fb4846@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240623-dsi-v2-2-a0ca70fb4846@gmail.com>

On Sun, Jun 23, 2024 at 10:30:37PM GMT, Barnabás Czémán wrote:
> From: Daniil Titov <daniilt971@gmail.com>
> 
> Add the mdp5_cfg_hw entry for MDP5 version v1.14 found on msm8937.
> 
> Signed-off-by: Daniil Titov <daniilt971@gmail.com>
> Signed-off-by: Barnabás Czémán <trabarni@gmail.com>
> ---
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c | 88 ++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

