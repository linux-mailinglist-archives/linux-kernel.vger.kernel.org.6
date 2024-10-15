Return-Path: <linux-kernel+bounces-365806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBCC99EA2D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C4C1C23DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4762A1F4705;
	Tue, 15 Oct 2024 12:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IZxHSXHy"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86511C07FB
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728996207; cv=none; b=fQTWn9cdsYfPatvmyIMot+/dAPd3Jx9BN0r/R2ueZvFYgwuIF3vauGs1X1vwVSwishOyjhBsF9D+8cIc/wcn0hKEfUUNvWlk8MmYdW36dfAFHqRmca2wXk4Awbk45BvVeVBGP/oIKYVDdnHucaUJ/+vfJd0XrpFTtia1Vvkxuto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728996207; c=relaxed/simple;
	bh=WsyoNm3Inxe+dgm35rTRKiOyqk27oY4gozorw47wODQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+0VyXFub5eDN8LW++Szr+0+GnzNMm6qC4aPdlm3Q5Orpf9hIJ2atzl/73xAlraPhGM7etT5TFTtoZN/vJgNPHMxBdFD7mTI3stOQUxaabf+ZOu0aMst4gEGzuP8/Us0zIMIHctURQ8BqZePBEXoKcuwjGCAW9uIsuVF5mRLivo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IZxHSXHy; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539fbe22ac0so1662864e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 05:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728996204; x=1729601004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dWAWLMerFNg7ziMX/kkTq0c63ntBQBUxjKKx6kq8y/c=;
        b=IZxHSXHybJDIDDf2sxo4LsKZbvf7sYMBbAcbSmXhMOe+75XckvTm2eM9NFuYaJ9srw
         SfboyF8OD6Us7fQES2CfM1/9bKrssNhw5iqBUdN/4qFGpKyoMrBH6vIsl4oV8P/eoAUR
         0fO+Udu+A6owv8DNdWb9m5nm0ABbmSs1JYCfVbF1tmOGntekrJ8XgZSs+t3AceYMBltW
         ohPPvKyBjl/FpoSE+s3XfEwycXsyvBzKwGDTEZ1bhl0rNMc0BQ7TGu4n4Xgcl0NrakTZ
         V2qxKVGEr/EgcyFrbTwk0T5wt6iUamYkX8Zzz8CO1yS4Ac8XveiWVN0kd5XRwLfNgE/O
         ugvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728996204; x=1729601004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWAWLMerFNg7ziMX/kkTq0c63ntBQBUxjKKx6kq8y/c=;
        b=elpzW5qdvhNhCpJxT4sTjQ4EyCC2IgZoaHdU4Q7KSi18rpZ8TumjXBA/25JeAxbGsX
         poblu5LEsjodVzS6IGP49+PMSRxV8ZfJdmywuToXJBRIAdc1pEUwKo5n83D996aSaCoY
         DPmktoFuKoVp1IZp7oBqcxpJlqwJA8PE0Xeu5VzYu3V0gAn2hA85FvXCSTFXP6oS2wLT
         NmF5IYpyRk4jZIdo8CRGy0TMaX2S+Wtz3ybyMA+BTyiyK5pg5Awo594JrdDIDPsUK9Es
         ElXasI+dVlprzKew1vJuyD6syXn3JiaEKRRbHhvyxoRrRiqR9O56wGsnrHM0Pu+MK2TK
         vOlw==
X-Forwarded-Encrypted: i=1; AJvYcCXfvgeNyfkBhok5JO/9v55iwl7uCJxVlDO4ZPIXvjqzBiRQKGhldG0vd88zfHRsjfF3Lonq0NUj0gZ8noA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV2pI3evxQvJZJOPlmzfUQxNlJmAmzqVf2JncES6j/rWyu0ozk
	DBibFgIeEiZ2jcnAhUBXd4pQ4wHMReGqcO6967VfjnoWn3yk/ZDyVzunxzeSYG4=
X-Google-Smtp-Source: AGHT+IFDKiJwxfvgxARv/QcbzKu7J6NoBQCUqpvWt3aC3NqNz5nV6x02/nbgYhrL2lnm8ld/sOFK6A==
X-Received: by 2002:a05:6512:158b:b0:539:fcba:cc65 with SMTP id 2adb3069b0e04-53a03f19aadmr191156e87.17.1728996203869;
        Tue, 15 Oct 2024 05:43:23 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539fffa8e3fsm161387e87.12.2024.10.15.05.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 05:43:23 -0700 (PDT)
Date: Tue, 15 Oct 2024 15:43:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@chromium.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm/dpu: don't always activate merge_3d block
Message-ID: <3bh2bs5webxfwzuvj4io24cgpikgue5ukn4mthzlm4nqun54ge@quonfyry4soc>
References: <20241011-merge3d-fix-v2-1-2082470f573c@quicinc.com>
 <kah73euzauizsxvcrgmfsatshfe4pytgb7xe5iprtajg7abhsv@l7jdcxza5gd2>
 <0ca707a4-bd5f-4a31-a424-f466afa08e0d@quicinc.com>
 <pahfbstxa6snym7bem456npsp6bdekjqhnjcsrlpbfn77hkrut@uviaesubwz2a>
 <098b51a8-0165-4d14-9365-ef56ea2bcfae@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <098b51a8-0165-4d14-9365-ef56ea2bcfae@quicinc.com>

On Mon, Oct 14, 2024 at 01:23:24PM -0700, Jessica Zhang wrote:
> 
> 
> On 10/14/2024 12:13 AM, Dmitry Baryshkov wrote:
> > On Sun, Oct 13, 2024 at 07:37:20PM -0700, Abhinav Kumar wrote:
> > > Hi Dmitry
> > > 
> > > On 10/13/2024 5:20 PM, Dmitry Baryshkov wrote:
> > > > On Fri, Oct 11, 2024 at 10:25:13AM -0700, Jessica Zhang wrote:
> > > > > Only enable the merge_3d block for the video phys encoder when the 3d
> > > > > blend mode is not *_NONE since there is no need to activate the merge_3d
> > > > > block for cases where merge_3d is not needed.
> > > > > 
> > > > > Fixes: 3e79527a33a8 ("drm/msm/dpu: enable merge_3d support on sm8150/sm8250")
> > > > > Suggested-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > > > Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> > > > > ---
> > > > > Changes in v2:
> > > > > - Added more detailed commit message
> > > > > - Link to v1: https://lore.kernel.org/r/20241009-merge3d-fix-v1-1-0d0b6f5c244e@quicinc.com
> > > > > ---
> > > > >    drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 2 +-
> > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > LGTM now. Please clarify, is there any dependency between this patch and
> > > > [1]
> > > > 
> > > 
> > > No dependency as such. Both are tackling similar issues though. One for
> > > video mode and the other for writeback thats all. Namely:
> > > 
> > > 1) We should not be enabling merge_3d block if two LMs are not being used as
> > > that block needs to be enabled only to merge two streams. If its always
> > > enabled, its incorrect programming because as per the docs its mentioned "if
> > > required". Even if thats not causing issues, I would prefer not to enable it
> > > always due to the "if required" clause and also we dont need to enable a
> > > hardware sub-block unnecessarily.
> > > 
> > > 2) We should be flushing the merge_3d only if its active like Jessica wrote
> > > in the commit message of [1]. Otherwise, the flush bit will never be taken
> > > by hardware leading to the false timeout errors.
> > > 
> > > It has been sent as two patches as one is for video mode and the other for
> > > writeback and for writeback it includes both (1) and (2) together in the
> > > same patch.
> > 
> > I think it's better to handle (1) in a single patch (both for video and
> > WB) and (2) in another patch. This way it becomes more obvious that WB
> > had two different independent issues issues.
> 
> Hi Dmitry,
> 
> Just to clarify, the patches are already being split this way.

I had a different understanding of them, but after going through the
patches second time, you are right.

-- 
With best wishes
Dmitry

