Return-Path: <linux-kernel+bounces-352607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CEB99216A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 22:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E91928145C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 20:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BA218A6A7;
	Sun,  6 Oct 2024 20:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SVTAStWi"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A871482E2
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 20:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728247908; cv=none; b=hVCM8wnhYBTOI4p3U6jsBXru3gf5NCXm856CelnGgPqN+S1yCH3Y8NbEDbcZZceQM/WfW/9akavSDQlCZvYKBX9CFOfHhOM4ZDFc4/n/bEuAl08O11T3r7XhRazoTz+6xucNOSpVGujeSHsJw+Qmu33R8TPgVPhyExIzyTUTGiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728247908; c=relaxed/simple;
	bh=W8tD2CFH2V3sC/LcttR86GEkCnj375hWHflq5r7CVqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4YTeICdY/hS+hTx1uRoy/MkpJfOSucOALtkCLmR38+P2Cgn0iX9KSj/3rDpQDH2NxxHf37YQqnr18azv7SPjXZ5Vc+qE20T+PUvHiiwW6WcJjxtf0wLMxxAUgGgcDGhj/m8NX480RYvj1pOkXsgABE8zl62NKmiKU3rh+Uv91Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SVTAStWi; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5398e58ceebso3318976e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 13:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728247904; x=1728852704; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6fDEjUTjzLtS905mTVQnS2WQIUmuG01B4JauAoWq8Cw=;
        b=SVTAStWiDIsRsX1sUZbKZ3QtuQxf+U5HSzuZhlz2L29AFBaNEAw83FXjvikjtlJmQB
         Sd1sgmA80aAsIOgpqhq6KA3JLcvQH3My+X8RNrj7CPhwgG3cfE5B6srs2EqlLV1Yl3Ht
         aJM6QIOqHlp8+mHO2NcXbmhUh9nSbF4D0df8YmwchXqp4IfcFUNblLtkPUaiSnUV9Vtb
         og5Mgwk+CHh8BdaZjbo0aPVghPmx4giQxRa9y9BEskDelOsJ68c6j+LkrNStRXlPaMQz
         zEII25ypxUXDW2KJotId2Lxft1zJs3on0c97Fs76ey4lbZwZuM/Bdu6X/y/z+NRuOGcJ
         0Z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728247904; x=1728852704;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6fDEjUTjzLtS905mTVQnS2WQIUmuG01B4JauAoWq8Cw=;
        b=A6lboQ1ikoFFJEtWxnlPdUS18HJ0yuOGrfyqBHCWqBHfoXjZokVimiPo7qJQCB/dF5
         eQvrWGZ2TujLTaDr3RZPowS08QATcMF0Wx38ibfqfxXbo+keZbf71KWbjkl8Z55VQY16
         Zyp3jcDx6xK3gadgznu0G6z1Tu4+nl+rX/Y0zVyoGMksFbG0tgxdJtf5/ve7rUxRB+kK
         CSJ35B10RPyrZzK7Y/Tg6F+f4KUAIVggz1bSZXm0iRETkh3QKLhrcLL+X2w+GNwbYbEO
         MGSI1WQO2glpumEQPikeURqSJADLLp2RpmAeT++YRwHyq2Mq+qsgObeSM8E+gc8b/fPt
         JcaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvDIZCcETnq3LbVtN81E1f2Vu9Js+lhP+tX/tXBVCcGdqlpv28it50EHxdWLhN1h/8GaKbBWnY4W/sZkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXYqAH6fjsmAYr/Os+knk9Y6IH38mU04zWCdOowxsVVtEtbJnV
	gVel2uZOnZN0NszDLSc2CEfjiA9QxGOBKZnT65VgZQaUDQK9oMCKhu3p4DTAkU4=
X-Google-Smtp-Source: AGHT+IHA1dhDE6pxQBeIXUSkV+5WjaiKuLQOgi9ZWdiP841coIo7OznF4+2/EqVdEHJp5/8gE8mjHw==
X-Received: by 2002:a05:6512:108e:b0:539:8dde:903e with SMTP id 2adb3069b0e04-539a627badcmr4336222e87.22.1728247904116;
        Sun, 06 Oct 2024 13:51:44 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff1d298sm611583e87.127.2024.10.06.13.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 13:51:43 -0700 (PDT)
Date: Sun, 6 Oct 2024 23:51:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Simona Vetter <simona.vetter@ffwll.ch>, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org
Subject: Re: [PATCH v2 2/4] drm/msm/dpu: Add support for MSM8953
Message-ID: <awjaaluhzpuuqjeqvcdduxeeqotbuxeqbqd6obhcy74q2qljs6@c5fyet73al2d>
References: <20240930-dpu-msm8953-msm8996-v2-0-594c3e3190b4@mainlining.org>
 <20240930-dpu-msm8953-msm8996-v2-2-594c3e3190b4@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240930-dpu-msm8953-msm8996-v2-2-594c3e3190b4@mainlining.org>

On Mon, Sep 30, 2024 at 08:35:57PM GMT, Barnabás Czémán wrote:
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Add support for MSM8953, which has MDP5 v1.16. It looks like
> trimmed down version of MSM8996. Less SSPP, LM and PP blocks. No DSC,
> etc.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> [Remove intr_start from CTLs config, reword the commit]
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  .../drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h   | 218 +++++++++++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  12 ++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
>  drivers/gpu/drm/msm/msm_drv.c                      |   1 +
>  5 files changed, 233 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

