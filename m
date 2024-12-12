Return-Path: <linux-kernel+bounces-442799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609129EE20B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739D81633DB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F79E20E028;
	Thu, 12 Dec 2024 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aGTVv0gN"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A336B20DD79
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733993899; cv=none; b=J+Pv7NMoLj5AoUOH0fHl6DgKG2TO3DFeEJcc7kyNRaaz84yQZ1DIUFUc4XHqmkO8SteVyVAmzSFKvFe+mPjKS7tXZ3a30zLZLKYF6pfjPAjocBRo5NsW5Kz+d4fMey214mJS5Jn8QZdIHrr6KLtzqGJ6JPcBlYnry4NyEOIcHU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733993899; c=relaxed/simple;
	bh=I4Xk/D8rfiESpxcW0fqo/qFa7AlWlyEHMzoX9E5YCvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqUt336jtm9dZwawwBr9+OA2PHOI0AxCVFjmS2D12AdGEI4kev89o0+JAJ6qALgvLCfD8TwjEwDYGzsy6NlmZ+OupFlh67y/YlhNV0IHXTBs7UmpO8UiSQuPtL/D3yRgkXGJP+Ob0Na///QmccpsIXPQrNXczjjgnrz6pNgywLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aGTVv0gN; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54020b0dcd2so1680996e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733993895; x=1734598695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0zULvzH3pBwj/buB357mGt94OsxfZJXtnXCYQYT/Q3I=;
        b=aGTVv0gNW0+hzvZbSAgiC77FO9xllafa2qYC+ldZN1cFAAkU+hB5qKRBiXnJLKe7oi
         ww98wFpcP1ci2IHdPRQq0VL8uow6JzM0S1wx+3DS5oBFf6Buut7zpjrL3cxkwRVoSBKv
         VSdXv8m5luMazuQmHBZDousjOJhAizCS03ycIm9DqQronM61yPXdS7H9LRDY21EETVQV
         CgnKCrRiJypUtTp3Ij6QmPaOQ8TVvxSDlFkmzPF1sQ0zylKrA1ZyFdOeT7YlX7YZ2ZZH
         lUaIdhotV2hyDgnFMj554Mz4Yk1KpzzII6HZoNlPD5kjcxv8SFlZ1LJhmPc4bpjIW2YR
         H7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733993895; x=1734598695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zULvzH3pBwj/buB357mGt94OsxfZJXtnXCYQYT/Q3I=;
        b=O0+tUen5li2coEWo+ajPQN4KmSi0SCr1UjKyD+pKpVCIt1HALuXrX99btk4L0p+wyd
         7Wwi8QOa/yC+v7aB4g7/siMhq2jTTfKfynCUujtZmRo01bn0LGpTCkq7IsaHKOxD4qAx
         BPrxCCjgUeALyywiH3QtNDk/SgMIpc2qVppOYSJcs3l0Qag537zVhfDk1XIWNAWikZZq
         GCl6yXz9GcqaMizfXT1Wa7VN5yUDyKYldi4Xe/Z+hx3YggLkjLXJH8e+c3QxCrP/Ppw/
         9Pj2GapVMzH+XbKEb5VbUkICqQSD5NlMfhK4TQpYh9756gkuSowGRxmo2YFIKZuyn2an
         song==
X-Forwarded-Encrypted: i=1; AJvYcCXpqR23z11l8R7qViPbvPE24STdNwsCk+ZBKTkaz8pk4IIoDunU9bfozjjIJXFIAhH04R3TrmyQHug36ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIJUzxP0vM+Cc4fBR9JsYDRIO71/KN8xpf8ZbqvhnyTptrn1eE
	kDKGrcq/sUaJOqJJMUJxeFAVdVFpIJKiYxr6KIpkSXhNPuXA7+/XD+gPaud1hrI=
X-Gm-Gg: ASbGncvel0WgJ9nq+0MkhhBk281Xwo5LlnfrDEoG9ScKm6Bn8ycJTN7okIjxhKxrhBy
	xLf5Y9pyzBf0M/7q/L71pW8B5Bbq8dhHe7CxH1Zb8v4XwaqAytG064alONN/CHjsCH4b1NgTvLi
	hdgzJASvep0e89+Vk0N05g6tV/h9YW4iUEhQeUt0Qb8qr/21ofmDiYW/mGbOq4H4PS4ijoLGbf3
	2niFdy4nULpeT3+gzv8qM3RV5WemfvKUUcU9udJ911JuzKw7dXDmAgU9ULQxfaLM3JnVVO+ZfYK
	Bybs4jcd/W+sXu3RIB+lvp27XY/dILK3iXr0
X-Google-Smtp-Source: AGHT+IFu73D5FA5z5HI+3RvFUYF8dHx/2OrBQKBCGrrR98zpwQOoDZGpuD2JAU6jhKxYEcNRR36Ziw==
X-Received: by 2002:a05:6512:ba0:b0:540:2fe6:6a3c with SMTP id 2adb3069b0e04-54032bfde4fmr243145e87.0.1733993895382;
        Thu, 12 Dec 2024 00:58:15 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e36ec76fesm1884440e87.246.2024.12.12.00.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 00:58:14 -0800 (PST)
Date: Thu, 12 Dec 2024 10:58:11 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Paloma Arellano <quic_parellan@quicinc.com>, 
	Douglas Anderson <dianders@chromium.org>, Stephen Boyd <swboyd@chromium.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 01/14] drm/msm/dp: set safe_to_exit_level before
 printing it
Message-ID: <iugoc25pnh5zzzr5mamutycqohj2z2255omgh3ztyoqgyjkg23@c7axf3mg5wy5>
References: <20241212-fd-dp-audio-fixup-v3-0-0b1c65e7dba3@linaro.org>
 <20241212-fd-dp-audio-fixup-v3-1-0b1c65e7dba3@linaro.org>
 <01f84965-8a11-4d6d-99a6-b0e37240d4cb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01f84965-8a11-4d6d-99a6-b0e37240d4cb@quicinc.com>

On Wed, Dec 11, 2024 at 05:14:18PM -0800, Abhinav Kumar wrote:
> 
> 
> On 12/11/2024 3:41 PM, Dmitry Baryshkov wrote:
> > Rather than printing random garbage from stack and pretending that it is
> > the default safe_to_exit_level, set the variable beforehand.
> > 
> > Fixes: d13e36d7d222 ("drm/msm/dp: add audio support for Display Port on MSM")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202411081748.0PPL9MIj-lkp@intel.com/
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/gpu/drm/msm/dp/dp_audio.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/dp_audio.c
> > index 74e01a5dd4195d5e0e04250663886f1116f25711..5cbb11986460d1e4ed1890bdf66d0913e013083c 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_audio.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_audio.c
> > @@ -329,10 +329,10 @@ static void msm_dp_audio_safe_to_exit_level(struct msm_dp_audio_private *audio)
> >   		safe_to_exit_level = 5;
> >   		break;
> >   	default:
> > +		safe_to_exit_level = 14;
> >   		drm_dbg_dp(audio->drm_dev,
> >   				"setting the default safe_to_exit_level = %u\n",
> >   				safe_to_exit_level);
> > -		safe_to_exit_level = 14;
> >   		break;
> >   	}
> > 
> 
> This was already picked up in -fixes, so no need to include

I have been rebasing on linux-next. Please make sure that your -fixes
branch is a part of linux-next.

-- 
With best wishes
Dmitry

