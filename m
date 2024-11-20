Return-Path: <linux-kernel+bounces-415674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3AE9D39C1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377501F22901
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B055A1A08D7;
	Wed, 20 Nov 2024 11:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qD1ptUYi"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5FB17BB2E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 11:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103064; cv=none; b=FgmIZPUnHBkoSJT5mXjAB4lBLjP0w7a0x2YHyeKFxWRMiFAvbNi1xanTPnmoC4IgftOArSobN8fDlDTN4Vz3uuGbecKVG0qd9T6KNLUIye6kfdYcJJ02STy6GB0tTkLR2dW1wo0qMgfWO08ee2SwXHDJtn7SkCVrOs5ODJT+cVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103064; c=relaxed/simple;
	bh=MBY1tocOleXSubrnmqvjhWAnctlm34fJboe09gcAvUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NazJ0cOOHkLJj5XUHdAqfHd3Cp5Nbd3UMDXZ6LRM0wElKv8+zdK6Hm8PlECwx0IlZgSE8uK8nDtniGCfM/rnxyisy8uL/wfNjxIWzQY5If1FkiTsGTZvvvVxE/eMqlU8ZlmxQxsXQ4ONJ+9Nqd9/q0oZmbSXBasCVn2kf+IvZH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qD1ptUYi; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e63c8678so4780380e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 03:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732103059; x=1732707859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9DRvXARQ1UdTvlDiFS+YRmTlgOqmMlEKwZDmn4BjfP0=;
        b=qD1ptUYiHUivPQZ6A7SShnaZZFwfLl1WJuEzAN76hTAEn6Op8yKKTQ8I/XGvCN2Apr
         bcbpWNOi1/sPWALTio/b6m0V6fKxj4btHa3VkoZU1lBGvvy+p8A3YWGOe/u6XDEbiEaa
         +efLHGEt7YjTfbol66haK5LTHh3Uck0OYKwLJ9uuM5Gb4ApfKR4a1AxFWDQKE2Pg66w7
         A/NzmAyYmpgiDXbHt+WFwMGV/6zDwvWqGMZQfDmhhUSSQiQEek6YQbgBnSWPL5QSQFcn
         gxt87gfvCrojtVtHgiJX99ihyCdS/BUsA+ozALim55VQaL4t7+NzBw/D9mUbruvdG1Ew
         9SBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732103059; x=1732707859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DRvXARQ1UdTvlDiFS+YRmTlgOqmMlEKwZDmn4BjfP0=;
        b=sO/pZvguwhxvc+miiGrxYEAWQRQ2fwKKq026Km4Z8bnGUL1kVe3eJRAvtZxowTIUQN
         MsoX/GU7pdfqqQQkKNFMykDqV5oQgN4EfA8tGj9K3zn9YURIuayh6SdhWQ6A7h77e4dp
         Ppjt1JXYgB7/WhyPwuY0gHFHkGHiKFAul4Q3m6c8YgX9GTh/KHZ6L3JdI/E2rKlA7qmr
         LHQAXJlo6U7xt35WWU621ui5IN9R433mK3oBYRI5yHBSfjuDqB6lx4rpEYVNj5yZ8Yk1
         wlTo/28KD/Fxco53tj8hrY6pvgEABZI2I1bBXmki8LA1Ov/O9YUePhvoIuVAxoAO5lnE
         ZicA==
X-Forwarded-Encrypted: i=1; AJvYcCX413prJIKlt565QA4LVzR/C6Z90whMpWb6wlJPJHt028jV9v39xTWqhZgC8SPd7Z5+J4FQL+WIv58pfBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzINM1LY+7Fx5mZ3VGv8E0q0IqiP9os12fvqY8/znnYRnTeLh6g
	i3Ag51r3DTpR2e9LFOPZlc4PFyDPmyNwVbXvoOn/3yULuHnfO9td9rmiyFNjewA=
X-Google-Smtp-Source: AGHT+IENehDPBicxK9JfxLgvExZQ3j1PXy75ftMbSZQj8HtpOt2sSHv8gorwetAxqzmU4d1aWMiGlA==
X-Received: by 2002:ac2:4551:0:b0:539:8bc6:694a with SMTP id 2adb3069b0e04-53dc136aa08mr913736e87.43.1732103058604;
        Wed, 20 Nov 2024 03:44:18 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd47285fsm604802e87.225.2024.11.20.03.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:44:17 -0800 (PST)
Date: Wed, 20 Nov 2024 13:44:14 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Akhil P Oommen <quic_akhilpo@quicinc.com>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Bjorn Andersson <andersson@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Connor Abbott <cwabbott0@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 07/11] drm/msm: adreno: find bandwidth index of OPP
 and set it along freq index
Message-ID: <xm2pic3yixhlsktaqnux7uvoxbxpvcmkcurylydifbqpx24x4i@lj65uktyscdq>
References: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
 <20241119-topic-sm8x50-gpu-bw-vote-v2-7-4deb87be2498@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119-topic-sm8x50-gpu-bw-vote-v2-7-4deb87be2498@linaro.org>

On Tue, Nov 19, 2024 at 06:56:42PM +0100, Neil Armstrong wrote:
> The Adreno GMU Management Unit (GMU) can also scale the DDR Bandwidth
> along the Frequency and Power Domain level, until now we left the OPP
> core scale the OPP bandwidth via the interconnect path.
> 
> In order to enable bandwidth voting via the GPU Management
> Unit (GMU), when an opp is set by devfreq we also look for
> the corresponding bandwidth index in the previously generated
> bw_table and pass this value along the frequency index to the GMU.
> 
> Since we now vote for all resources via the GMU, setting the OPP
> is no more needed, so we can completely skip calling
> dev_pm_opp_set_opp() in this situation.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 17 +++++++++++++++--
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  2 +-
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c |  6 +++---
>  3 files changed, 19 insertions(+), 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

