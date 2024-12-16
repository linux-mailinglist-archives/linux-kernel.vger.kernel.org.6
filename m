Return-Path: <linux-kernel+bounces-448239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A869F3D5A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F5C168866
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557A91D618E;
	Mon, 16 Dec 2024 22:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jpYjJdp3"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF355FB8D
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 22:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734387715; cv=none; b=YOrzLMtnECq9GUUS6qFfXJX9oMHGu4W+XnF9U7WSX9XhKmBLntDrG8pDruaQzK5r3MroD+Ss1AR8K8nH9tDZ9VmB4rU8wtxNCgCpGZVjVp5fKC9ao3eUs8QSwvxza0LXSTjd4WIrraBY1fLAN8BSH6zpCaWsh3cy8rmhiabVN6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734387715; c=relaxed/simple;
	bh=Kx3rxgkHnsgYQalU/HqGShGuuqblnvVmLLPRGsI0+Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snVPUAibwna9bHfiK2+xsJMFUCyLmDqzGge5DJiHZYxkSTEokAdPr2phmTdE9Him106q48FJkGN47khn9DD6TBf8M8knPwAEl2rmOXcsoLPo6Zgzi1CymWaq1NHFK2GO9SovKw92nGr6/dMsY0HvqZRxUqIi0wPJuHnaNuiDL4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jpYjJdp3; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53e399e3310so5526309e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 14:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734387712; x=1734992512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=np9l1SxTtZSdosqDOIcl3yLnm6oukk5vBVkET6t6L00=;
        b=jpYjJdp3QPQg3UtaKdklQYtPJuDWcEq0rsVsldlYGcFEHlY73T0JD4enWzAqaAKC5t
         CsgnDQ7BpzfQl1sN9a6ehn6ogDvaLO8jiF9mAKRAns5zPtckPIMJLxZJVPT8x94Kref8
         wpBV3e+rsviZ2ZVl4S3Z/5sD6C1En8T0h3KW3vVJO4K0Bgzg7FLwjtdTGkcCHWYMGuBq
         UCQpiW83yYGl0IgzxOBsrCO8SvfjzSvYoNE5zSAZILUFDUhZ2lk8dUJtBB1RuoP+5PtZ
         tCyI4mXatKNtRYKtay7WFsxZQqYjMEiJBGgnOr+0DDoLxWCrhX8EJ9bsc0MJDKGZ4Dny
         tTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734387712; x=1734992512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=np9l1SxTtZSdosqDOIcl3yLnm6oukk5vBVkET6t6L00=;
        b=fSvjSlSXIrrTa0bHlM00FEPoYOjgJ16hSsKBqexQBtT66mRsNvYb8jSmiykjxF/i5g
         ZMsZQhlaP3a0BSx/qIn1t2Pi0fCQP5UElMekyfynKTTypczeZZumcRcT3mwREqAzFyKK
         YBjWWqNBpJe3OkWVyu5RQxcRSeuryJOgBl8dkUMxxNuguLp+wx6+TeLYR/Uj0JIXfDlz
         zRQx+kR9AenS+FeOye7TkgizhFADoIjbTUIXTNzeGA5M8yCbrNkjwmfhksIUyEUwHtuo
         wolO3H6LWPgVmV05rRGG6xHC53BDYneAG8dQ6qKKEEv9TEAxpQWpZ00lR9fQDqUnz9eP
         8+Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXHZEKVHp8+QNo8SMtBRSg5cCg6lkX6boBYUFm6cdmWlecBqRzPjXh7oxNpmvXHuv5/UgFQZx/K4xJ1ewA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytp4uwSvYt4kpjeOH2rEL3JeX3CW31wAjlsDv46CPrOJvaKyHY
	00hvWU0WHPM7eq29bt47ggLrLI0Jq1T6rBz7d0rtzafBuTe6rjRnODePMAHEPew=
X-Gm-Gg: ASbGncvZMjSs4+bIAOTyPjK7BgH91Zl6DEsqRu8zbvBCZEQYSj44O0brz55AqwMJsHu
	TYLFLbZoC4AwI5TnnLJp9hmCaTlsSPNHUEqNbAnnVrZQ6diFZCMq/5gucNWKSEbDII3N4WfPyBZ
	agb0g3KvmBA1j3raTnlfF3gvUZ/HmAJbtoO/FEXwtDmVvrk/zTXdHxX9EEpVrpZilPnX47Es+jl
	hFHv/KnrJs6O9fGlXkaTubk7N9yVUk238qNUMLdr7CQBazy1GNjNwUyM/E/vHqVwEGp9pLrLr2Q
	BNKwNLxnP4BbHy4Xjtlolxg5K48RLa+6agI9
X-Google-Smtp-Source: AGHT+IEnVvJJwRCeSyiKHoHt+hZL09awH4q3F+CSQYY24saJkz00Ofn+xL3gjf2WmIFrEYiDjuRo3w==
X-Received: by 2002:a05:6512:3b2b:b0:540:1d6c:f1c1 with SMTP id 2adb3069b0e04-5408ad81cc1mr3830374e87.2.1734387711878;
        Mon, 16 Dec 2024 14:21:51 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c13d5esm980911e87.216.2024.12.16.14.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 14:21:50 -0800 (PST)
Date: Tue, 17 Dec 2024 00:21:48 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Robert Foss <rfoss@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Richard Acayan <mailingradian@gmail.com>, Rob Clark <robdclark@chromium.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] drm/msm/dpu: link DSPP_2/_3 blocks on SM8150
Message-ID: <og2qlg7fy3gwh3uv7nvmqxmjbzqpdeuekefflzgdet4vnltdtr@q7suuz4ujxp5>
References: <20241216-dpu-fix-catalog-v1-0-15bf0807dba1@linaro.org>
 <20241216-dpu-fix-catalog-v1-1-15bf0807dba1@linaro.org>
 <d6be6564-ce24-4a27-a014-45aa9ff28d24@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6be6564-ce24-4a27-a014-45aa9ff28d24@quicinc.com>

On Mon, Dec 16, 2024 at 01:11:35PM -0800, Abhinav Kumar wrote:
> 
> 
> On 12/16/2024 12:27 AM, Dmitry Baryshkov wrote:
> > Link DSPP_2 to the LM_2 and DSPP_3 to the LM_3 mixer blocks.
> > 
> > Fixes: 05ae91d960fd ("drm/msm/dpu: enable DSPP support on SM8[12]50")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> 
> Change looks fine
> 
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> One question below (not tied to the change but arose due to it):
> 
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
> > index 6ccfde82fecdb4e3612df161814b16f7af40ca5f..421afacb7248039abd9fb66bcb73b756ae0d640a 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
> > @@ -164,6 +164,7 @@ static const struct dpu_lm_cfg sm8150_lm[] = {
> >   		.sblk = &sdm845_lm_sblk,
> >   		.lm_pair = LM_3,
> >   		.pingpong = PINGPONG_2,
> > +		.dspp = DSPP_2,
> >   	}, {
> >   		.name = "lm_3", .id = LM_3,
> >   		.base = 0x47000, .len = 0x320,
> > @@ -171,6 +172,7 @@ static const struct dpu_lm_cfg sm8150_lm[] = {
> >   		.sblk = &sdm845_lm_sblk,
> >   		.lm_pair = LM_2,
> >   		.pingpong = PINGPONG_3,
> > +		.dspp = DSPP_3,
> >   	}, {
> >   		.name = "lm_4", .id = LM_4,
> >   		.base = 0x48000, .len = 0x320,
> > 
> 
> the consumer of .dspp seems to be in the RM code which is used to map the
> DSPP to encoder_id but is there really any case where lm_id != dspp_id ... I
> guess I am missing the context of why DSPP id needs to be tracked as LMs and
> DSPPs go together. Let me also check this part internally.

For example check the SDM845, the LM_5 is tied to DSPP_3.

LM | DSPP
---------
0  |  0
1  |  1
2  |  2
5  |  3

-- 
With best wishes
Dmitry

