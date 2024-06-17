Return-Path: <linux-kernel+bounces-218421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 222FB90BF88
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379851C20F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3848A1993B5;
	Mon, 17 Jun 2024 23:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jhZ7fiQI"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7901991BD
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 23:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718665791; cv=none; b=uyD9n3DZ6lKFbpzxik5/ATQ1ljs6YEryrc6gwzAS/KGyY6pKiuS4StUalH+wIlixL0HYSUQyc4/y5lFEZA+P86hOxj46ZSpUVgGuUMgVR7tNCsXgVzU9/DIKGhUUjsDc0nrqqBNzx0dTQFAXaYlltwvp9X15baTsz1rjrKQMY+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718665791; c=relaxed/simple;
	bh=G6usFp7bKmfUImhheG1L/hun47i/F5MEZ+BqjuZY/xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2X30C1snh8IpV6bPp4xBzrOodZ+9xnRAgq1d9r6t+LhmyIOgYGHb1hsYJOoA2YSGCReUpUzQ3swNKa5oPhwWpcNwzhamZqjDqiFq4OllgHioFDwILZtFhUOUBn/SBwnmA43BBUyvwEtYNGt3wEHynoZMlmqoUuU+7JAE18CExI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jhZ7fiQI; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52cc1528c83so689797e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 16:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718665788; x=1719270588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XTBpYs+rHA9ZGRXubRjFNJr2hj3dD85kNn0beF2XoaQ=;
        b=jhZ7fiQI+jP+pO86PxC8isd3v+iBLhimxojOUtL6SF3M2BnvSS07c83eAi+JbIgznI
         GCi8jJltUyi8Wq4/ovdFIreZXBvTiS8vGS5m96Z5vzeQuXjucUzFz+mQ1cRlQduAGUGv
         6phPpPpPOBxtgZCqGLcB3ApGLasYnN6j2fId3OTIyLKbaGxLIXlZc6x80GT3KD3TTwfC
         sJzRhPyFvV3iXX044fQLe9UCA1ahUV1UrA5EgPIWPtJzt/94miB/DP30Ukgr3adtMt7B
         YgqSEsJrJyu7b2CBC6ZWpRABjn6tu9wcdNBUzqNTD//2tzBpFcBJ3ZDXnCYmyiGNvZ91
         78ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718665788; x=1719270588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTBpYs+rHA9ZGRXubRjFNJr2hj3dD85kNn0beF2XoaQ=;
        b=I3wZI4QTYr6vTNXXHTJ/K9EUV0TJJhnrLnlAf8r5YlS60o3Xt5voS9qaPYgNTfrjyF
         naDh1I2025kItXgqc09qeySa1PYRIjP3JGxrcgudeBVNcfZlxf1dBcmR1xABM03vURw4
         KAADiHlbing1EX8YUj1gbNuHZLWAVPsIn9WGtPTVF74k89eUGdNdjh9opnDmlCS6uSur
         pdwGLdUhU5gC+2pYsXIQl5aqHAwFam9e++Bjf5f6jOHFcLXR7Rhns0xJHiY9jMG2E0NW
         x2axjfp1MtUuCE1y1wCH0BlKIqjwSiTnMAGC5RN4UFIfVdnASBfGHwlc5lp02B3Rxue0
         a6hg==
X-Forwarded-Encrypted: i=1; AJvYcCUJLqdu85EGcwtUtW4udLtne0hOQoQxFLeZ/jDAsIaL7Hryz+j7BEHHnGGG1AvLS9lSlPsiby5KcQ2FFUhMC8+sXnizZ6jtpyIIOYpm
X-Gm-Message-State: AOJu0YxsFNFNzGdmnh2zkgQVbe3bxujvuPVfx0czxskWO44BMr+S/3+x
	WdlyMebXnxe9CAVMa+rupSJqOapckLUPmtqqUWeW7BHNXe1qSphmvdD5gdQXSD8=
X-Google-Smtp-Source: AGHT+IHTs0fDZAR1ej9emSR23TPH1XNYZwIBJEMQjpG8ZC6EL1ncHYC1rF1ka09GwUmaY8K9cohTjQ==
X-Received: by 2002:a19:5e13:0:b0:52c:9d68:7443 with SMTP id 2adb3069b0e04-52ca6e56429mr5823534e87.1.1718665787866;
        Mon, 17 Jun 2024 16:09:47 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2887f0asm1397246e87.265.2024.06.17.16.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 16:09:47 -0700 (PDT)
Date: Tue, 18 Jun 2024 02:09:45 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] drm/msm/adreno: Split up giant device table
Message-ID: <wylta64t7tje2ezvcc5joyayd5rdghyxzvjbukibqeujljcnvo@ivob3zlbw3we>
References: <20240617225127.23476-1-robdclark@gmail.com>
 <20240617225127.23476-2-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617225127.23476-2-robdclark@gmail.com>

On Mon, Jun 17, 2024 at 03:51:11PM GMT, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Split into a separate table per generation, in preparation to move each
> gen's device table to it's own file.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 67 +++++++++++++++++-----
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h    | 10 ++++
>  2 files changed, 63 insertions(+), 14 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

