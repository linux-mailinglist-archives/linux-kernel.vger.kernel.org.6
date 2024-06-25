Return-Path: <linux-kernel+bounces-229651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6110917261
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 22:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C291C22DBF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631D217D37D;
	Tue, 25 Jun 2024 20:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p6mj5BRc"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E58A178394
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 20:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719346724; cv=none; b=R7CWpW8iWUt+ISR8+vVKJcvOAzlFTmLNf/wZKP/Aj/yxezP/xnN5S7sLBZ3DhPkkyuVdzevaRLlV1ThMJtv7wcNCMpCm5FNY2S3u98CqrXxl21JcWj+tDQ8wx/cMgXYz0WGtveo4UIcAe1cPReHZpgCJRscIuvbOHVqDKZaNlbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719346724; c=relaxed/simple;
	bh=oCFFyXpS9EO2My7WikIyEOWe4OKBnkUKSgmJOOWdWDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Stl4mGw2YT7tK4QAvcFdZuFi2KkS240MZoOsmUC5dcwOMNmk8jbA+ivsp+x6bE4K0h9Ps0kriW5gDdgAdD56Af6TkHJmGYcL0nedPGdfLuBIP3xJZQiqnSQnntXKmB2D0MMF3l19NUeMn5nXqtql1oXZIl5sIcin6Gz+IVVcofM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p6mj5BRc; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-63bd10df78dso55988467b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719346722; x=1719951522; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hl0vn1IfpeicnMOwpEfyDxO5oFF0xIRhWfGVIKpdxKk=;
        b=p6mj5BRcJLU8qmqAFv4cDljoNScjpFzFy41Mb2wMD4Dzav0fd8T8EyQzN1EvRFOGKZ
         377P9QVpEj5g/pf3OgJwxXCyIC0T8kZW+QESEVLUKT1kbzb2v8yB4xX1WPNlJhpYQU04
         gcAazYgmuFwsSPrpN8HdMD5bx7il276Y1K/zoJJhgYJjjOVrXtHQMj0D/R2Yvu8+1G27
         PsogDGsLi3YjWWByhPU9ExrP5+GzmcDJhdGjyAEXSrIvq3nGt9vwOZGmR37qp30CqN4W
         wX/VhyknH/hrK24awD85+rRfztp86Pm0byCuZjMmZKg90YmA5AtFLVX8jK6Q7K+N6Iyo
         j7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719346722; x=1719951522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hl0vn1IfpeicnMOwpEfyDxO5oFF0xIRhWfGVIKpdxKk=;
        b=k+iIQWwvgPSzDl1kSkStGKk4SDnFBcg6xtcFIjOc5m2rwtSk5390Nx/xh1XYR8yCj6
         D69OJsIuithU3V4zHBmKVqIVGBBANoTOIcE/qV3lIqt1Bsl4eVDeqZ/vBV2xnfO4/v+4
         ZCL4LX+aQL/YZGtjC1Yve1tnjkfZoJPXcnhrD37BMKqUOekWmRk8x2H/FdfGtyGq1lHp
         SiYnFx+Cx9+SSAgz3BReI/T4N3PNupY7aZEmB0D3xBLcRXWZYd2dvrkz+pJ72/SCGCab
         inEkHnsnzbkSMmV136iQ5I04L09HHFocWm1uCwA82o1Ic+zcfe5ge0all+75CZOxlU1I
         YXZw==
X-Forwarded-Encrypted: i=1; AJvYcCWxFyIzItrA8vldCGbFo7Mg+E6eM82WolSNoQoxZJduh0IuTkEZrUfa6Q0Ymw0ibloE2FaeGgv54JYJ5yO5bp8KGIgMFNpoAU1nFfnq
X-Gm-Message-State: AOJu0YzjvjMJ1hQic++7dsJ344Ql4b31rdduZX2Hs5QdNaARuPiN0qCA
	MS2el6HsRorfRQlRdMb9r7+hWFvp1bL4SAF5kEH7TBise9c5Dij514PkFd+yYrLm1qVHqMCCXCC
	o7eaWsJ7YT66+HkhMZciCKrVk/YlhJ3hUxaUnNQ==
X-Google-Smtp-Source: AGHT+IGhh7cMGkaHnGaMvg5sqr7zzAMtsWcZCW0A35zu7AxPMIv8wJrJE/YBk35y+kSqxRG2SLUIsYgPhykOiRmUsIc=
X-Received: by 2002:a81:8547:0:b0:631:8274:1611 with SMTP id
 00721157ae682-6433dd74338mr83572967b3.20.1719346722141; Tue, 25 Jun 2024
 13:18:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625-adreno_barriers-v2-0-c01f2ef4b62a@linaro.org> <20240625-adreno_barriers-v2-2-c01f2ef4b62a@linaro.org>
In-Reply-To: <20240625-adreno_barriers-v2-2-c01f2ef4b62a@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 25 Jun 2024 23:18:30 +0300
Message-ID: <CAA8EJpqnFEkWx4hq_UDgQ9n5qNj=WjN-Td0+ELGh8hrDpBFjGQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Revert "drm/msm/a6xx: Poll for GBIF unhalt status
 in hw_init"
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Marijn Suijten <marijn.suijten@somainline.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Akhil P Oommen <quic_akhilpo@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jun 2024 at 21:54, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> Commit c9707bcbd0f3 ("drm/msm/adreno: De-spaghettify the use of memory

ID is not present in next

> barriers") made some fixups relating to write arrival, ensuring that
> the GPU's memory interface has *really really really* been told to come
> out of reset. That in turn rendered the hacky commit being reverted no
> longer necessary.
>
> Get rid of it.
>
> This reverts commit b77532803d11f2b03efab2ebfd8c0061cd7f8b30.

b77532803d11 ("drm/msm/a6xx: Poll for GBIF unhalt status in hw_init")

>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 4083d0cad782..03e23eef5126 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -867,10 +867,6 @@ static int hw_init(struct msm_gpu *gpu)
>                 gpu_read(gpu, REG_A6XX_RBBM_GBIF_HALT);
>         }
>
> -       /* Some GPUs are stubborn and take their sweet time to unhalt GBIF! */
> -       if (adreno_is_a7xx(adreno_gpu) && a6xx_has_gbif(adreno_gpu))
> -               spin_until(!gpu_read(gpu, REG_A6XX_GBIF_HALT_ACK));
> -
>         gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_CNTL, 0);
>
>         if (adreno_is_a619_holi(adreno_gpu))
>
> --
> 2.45.2
>


-- 
With best wishes
Dmitry

