Return-Path: <linux-kernel+bounces-218423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EA990BF90
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B1B283B45
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B066D1993BE;
	Mon, 17 Jun 2024 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cbhiOl6R"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E46719923B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 23:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718665829; cv=none; b=YcYntgkLvbo9xygPt2TtbLzkQaPKGZ+IyRhQeXvt96GW5abUsLJkq23wQNBC58JPkyUNLjfTZfZSt265d1ZlsyEDz5xExPCiLGnQgk3HRa0yGF44nBrTpfkR8mTqNB0VA3lFeaNRROl+2LAExvpg/+yGVu46n+6VNl1dgENXbbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718665829; c=relaxed/simple;
	bh=JUQxuvj9BML1Hkx6TtF7g5KKvm9pIFZvW9FQlreKw5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cio0aBqbaDlCjtqEawP8M0MJ9o5U05jqllc0ZozwXY7y5d0OkabKsbqe6WWHlWtlyn/s3Hy8Sq0hd1uPaXQJ7w1jXL5IM2dUSvddIWh1x2AGjPys26dUYo7xWtUzMH532gPgRr7OBrxyt8ORLW8ES+ZKn8wajpJHVe/epW9+QzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cbhiOl6R; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52bd48cf36bso5627277e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 16:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718665825; x=1719270625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=We+cMzzEfPyNJs4E8h7UGUZk04qxzQ0Y4iOOEjzjP+g=;
        b=cbhiOl6RTaXFF9ZLvZ+WqsZSrMzNwQB/nFGtPJJ0Imyk8T/rDa0TAR7vijiUHwZj/i
         cbkl/2CmSsSY+iQmTZqpDov3AIgSgT8Hi2mejiiUC/ZjeBPnLHnC8Z9pSTQZSaQLDUCr
         TDwfuHMUY0QAQRFePRzg0ZoKr2Iq26wh/s7rOR9Qvh4peEw9YStqGG+vcoNbgXmbXPcJ
         Wq8fxbYYByshTqSOsmJl8c4YnrgqXB0mVW4oPzNhn1gojSZ3bftHbnj+lx1I54kMsyB0
         xyR5oBuJIlV3EHFvG5EMS92dRtaQTvGeq1+X0mCnqRcPiEIO8ERDUqUGIpI2piVJzSGw
         a/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718665825; x=1719270625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=We+cMzzEfPyNJs4E8h7UGUZk04qxzQ0Y4iOOEjzjP+g=;
        b=D+JY3xujIn3oavzmquTgXeoEvLF8KtvBLdytG/ij1suITu1z4lvQGcoHMPt9ho2LP6
         3DsDHRj/aTDqoj2fnK3iK/TPrM95Xdtezfp1y9bPdbIwHh9kST0yqPmmKK28s3rf7zRk
         Jln9kHvQ4CGiOW435tgO2bvABIG6Xl6aWV8C7PAMmvG0Q0MKzn0LmfS1637zS8mU0+5x
         1VURB1Ta95HBpsG4whFsmVSldUX7t/fA5mdeybS9Shj4xILG9Tk24U6q06YAQ9O54Cwf
         R1sp8+FhsYHejgkq+R+N5/EmG82YSKL/FDKGBMKMcblMpH7bbd3LhC1C30z32XX8xGWz
         Gctg==
X-Forwarded-Encrypted: i=1; AJvYcCV2iWPhY4y/mflKOehnDJnDN6Wv/arfA57rZwUuzOOJucElvSyAbtRRnzujA+0fgFK72wrhBhRWLPnXuhWmuElMGgZlh9fthFiRTPzR
X-Gm-Message-State: AOJu0YzFMgY2kGFw8b3sxGrpUNEGnPkWU4sUZCaR1Fi6uW7bytdrLojH
	WAvreiAid3NV00BBRtIIzZphaFqRq/wVRd+wBHpVOsq7S1UJ+OKjDBPuFHktxZg=
X-Google-Smtp-Source: AGHT+IE6WSPz5JkX+9XH3yVWV8ckTdvQ10ELe26IE1/Ux/k9Utl8IdxCmMwFdOH8UA/7aA0NlFVE8g==
X-Received: by 2002:a05:6512:1083:b0:52c:8405:4869 with SMTP id 2adb3069b0e04-52cbd4eacbdmr2770357e87.66.1718665825451;
        Mon, 17 Jun 2024 16:10:25 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2ed0ac7sm1345613e87.125.2024.06.17.16.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 16:10:25 -0700 (PDT)
Date: Tue, 18 Jun 2024 02:10:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] drm/msm/adreno: Move hwcg regs to a6xx hw catalog
Message-ID: <ysodcykcvjbv3wx2s4gdjnz66sn4cwbf5dyswncxgmnz3be4vk@fr62mulvuj4c>
References: <20240617225127.23476-1-robdclark@gmail.com>
 <20240617225127.23476-4-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617225127.23476-4-robdclark@gmail.com>

On Mon, Jun 17, 2024 at 03:51:13PM GMT, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Move the hwcg tables into the hw catalog.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 619 ++++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 617 ---------------------
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h   |   3 -
>  3 files changed, 619 insertions(+), 620 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

