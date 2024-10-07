Return-Path: <linux-kernel+bounces-353369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC08992CF3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B746A285946
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC761D4149;
	Mon,  7 Oct 2024 13:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sk6qloce"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720841D3644
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307023; cv=none; b=fEnBFZthSQdgYL1invnccRQ8QJgzeEQqA3NffR8QshNq355Q05p3n7tzEgHREvsR3q7wiesM9+TrlMYEUhJFhHWW9f7lPgoGqRoJTpxrtnxSrphMwtuIqUdTZTkfk7AgX3t5BCfisVo4TpGMiC858qNmN0krYHW57xfUmyMFYlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307023; c=relaxed/simple;
	bh=bQCnwp48K9oO6qUwa6rSERrhuCN6Vwe1If08ID2b/wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiKr347C8vdui45eEud8n1/62iWTxYHCgHSYXo7vmkew3VIg7/1G6BGrrZ0JCPgMO0NQrNRXkfKMLJKAYRbm9EauXuGSrPs7ZF0gAwy/OQBFcrDpYkx0gY2ZbgFkMN50qniSxPDLUpQnXnAK6ZCVL2ZmCWxBNKIldrIIL6jbl0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sk6qloce; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fabd2c4ac0so46895931fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 06:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728307020; x=1728911820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+pWYExryHfEOHSZj+Ne8AORcHVOO1VxvRGvUXHt9asg=;
        b=sk6qloceFWkCteMsVeEDuoPTACHBrBaEt4sN7+QZNYE7hkyCqxouX7ADgJBRad+0q/
         NCDP/9HT5x7mr+ZWPYfQzuvVDim6uWcIpUIjH4zH1u7boSMSVrE/oBiX187cKy/mrmki
         IFXsemM1zAUz8o6iIEM6wSy7X9TJ/Iwe1rErZktv8AE/7Pmm4aLRiA2EZEXz9fAgH//H
         GqfOvIE1ny5YhfZFKZFZKkPhB1z9LeOAaNA+nOzjlpDUznDNEJmDqMLxzzT9dBUcVqjD
         7QzXtyrM0Jx+POjGuPrQxWJUMQrpEmyuLvljAMSjX8uLKRgJT6ANqGDuax4b1a2ka9EO
         xIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728307020; x=1728911820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pWYExryHfEOHSZj+Ne8AORcHVOO1VxvRGvUXHt9asg=;
        b=bTQeoFGb8bQ5x3LpD5PYjRlcv/hd85idgXFEaxJA+8i68XQu4NBuwf/oJBSa37NQ9R
         UsdILxqvzob3QBRyCE8m17ZS5+fVu83gxora8qBZO+Q/Y3QDpw+lj7yvK0QI62TztgGa
         WwwkwgU5zUK/xQkjX+4IqlMGaSajS7m8CODvajI6BSqVA3iBv/wOyQvfOfuibjeS4lm9
         kppWWU+3JVQNYBNGpagwAJQHivmfp9yGHkKZJ/bQ4yANjBHMZ/NjXrSykvIbkwlLmiXp
         seqqL0C8QnhcrZNdSLbZ1hbvtDdBi3sfCo6A9KegUcTqqRBPKRFVgPVBBZRjcjVFTfY/
         wBdg==
X-Forwarded-Encrypted: i=1; AJvYcCXvjIymnDTna451sXNmGHPLLR2tPXvcRC1W94nh+Sqzqmv97gZyKKIq807ORBYN7ok9MQ501vgnv1LPwtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIBy8GrVhiPOrA73jXmRk+WPHLclWu7XYBpTAQ/Ep3Hp5lHgKc
	3DFKq9CLh6Z56GPJw8Q7mPVsdJR1O1WaDawlmHhMn2FwB6Rd0XmHM1qj+VgXGJQ=
X-Google-Smtp-Source: AGHT+IF5Z5M06yNJGCi1ez/Gx/T8VjldzZqMCqhBqFS3zMMX19PR8zfmRYYeTqG1usnU6bJUYarfKQ==
X-Received: by 2002:a05:6512:3c9b:b0:539:9155:e8d4 with SMTP id 2adb3069b0e04-539ab862530mr4922913e87.8.1728307019585;
        Mon, 07 Oct 2024 06:16:59 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539afec157asm851578e87.58.2024.10.07.06.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:16:58 -0700 (PDT)
Date: Mon, 7 Oct 2024 16:16:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jonathan Marek <jonathan@marek.ca>
Cc: freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, 
	"open list:DRM DRIVER for Qualcomm display hardware" <linux-arm-msm@vger.kernel.org>, 
	"open list:DRM DRIVER for Qualcomm display hardware" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] drm/msm/dsi: improve/fix dsc pclk calculation
Message-ID: <gd3bevkbevqqn54xq54dfc5imq3koc7ggudkila7jxgaxcluvz@5mkw2ra6pgoh>
References: <20241007050157.26855-1-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007050157.26855-1-jonathan@marek.ca>

On Mon, Oct 07, 2024 at 01:01:48AM GMT, Jonathan Marek wrote:
> drm_mode_vrefresh() can introduce a large rounding error, avoid it.
> 
> Fixes: 7c9e4a554d4a ("drm/msm/dsi: Reduce pclk rate for compression")
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

