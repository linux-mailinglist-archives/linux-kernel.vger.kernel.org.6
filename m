Return-Path: <linux-kernel+bounces-231292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A376918A47
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC041C21EF5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9C719005D;
	Wed, 26 Jun 2024 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xfMHYoCj"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2440C19004C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719423854; cv=none; b=E0vm7636bH7d92kT0yTXBRMxTGZz7OA0vElF5KYxIFoHw0CUjWV7YQjyZkACpOZirtbpPnQmId+SoWsHH+iXZzBEOWlXbHsJNnmfhQarn4eey3D23O6Rs7gY83/08vb0XQY/DyW3/gQtKpvhTW3vLgzMc4ymWZtjTq1ZxEk6798=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719423854; c=relaxed/simple;
	bh=/io84hCwNbZcZKn9HhK0O8w0sd+tGoi/1ISDC9vOJx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVq+v7+yIgVwPyvN55CD1taaRd5v51h/MUOQvacgIkgYc1awNdWe+LJle89JuNoYKjKZmKev+q04hslhSQHAf4UKJollSmyLzQlYToXr0Av8aw0Gy5WfM3Isk+Af5c7NTy2DWbhs865IjwOzYBzJhQEYe6Bbcqo3mbzStXj/eCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xfMHYoCj; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52ce09b76e0so724304e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 10:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719423851; x=1720028651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/+RSCVFLz9dWkUiNsQKrMfnEz/6x83/Tw3aZ3JSUbSg=;
        b=xfMHYoCjoWZorBkeORDx2hka6n5QDUpkeVOvAHEXpIWT0hOBHicTjFvaZqflPFbxbr
         mfuZyWs6E7wxFt8HBXMbyEgV0N6NDgKNwqhZOtnZKndgvRhIjFritQnanzIu2KZQ/K8c
         R7TqqkHE8hSxL+XgxV1hUFDuQODE+OhJMvFr9Bf+13jgnLcUCXEa+XtzChAbdCMxDBV6
         ZVGAqcDXkI80Ih7CluRtuf1rnEPHxkMQKezCN5KjFgj/LIYpRuxZDhjTLlAzuJZTwlnW
         ArYSPyfNkHaT9cgVRHKbbQkp2cKs55MiXDYStPq0rm86qKEVKdkkYR6dNV/ogVExvwKZ
         oOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719423851; x=1720028651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+RSCVFLz9dWkUiNsQKrMfnEz/6x83/Tw3aZ3JSUbSg=;
        b=eilRsTmtxnYKjQ7OgraIyxohY27krQauIQHUER/GSXXqEeC8pdyqJzsMsrxprPyZuf
         /Qb+shGf+EDP7HypGPwHar/aJAZQMJXu82/Vs65wQPnvymSdfR3XpYCQyWdtWe+NbzCO
         QxSiQkcI6e4Y1EM/adfi0w3lCAAJW5WUizGvSXqCrozdzx+iSaWOsV1UDcZm0e8uHWLr
         y4XoN+NcLcOp+W5ieqfnh2RXYjfSnOEzZ4bV2skE7s8EM+sH/+S6R07J6eUzJfdHi2Of
         ToURSy1RrTVdmkyfkPj7JHtA5KFgfIGxAFwdxrctiR+8SYEVrKEzcT91TZCVZ3M8KgwJ
         gakg==
X-Forwarded-Encrypted: i=1; AJvYcCX+zfVKY+Brq4i0MIUUM/KfMPhcDLpwN60LYbKWt67eIRfXY9kT1w4x/ecnXqZPBW88WkShCQaDFryEKG0KcpE1Es3b8xXMw/ahvH/Q
X-Gm-Message-State: AOJu0YxVOJCx4oyrGKfU7z66z7y0ae+24aCzueWCyDuTTI+b2nEwRR8Y
	57DuPOwkl66ZGoD/X3WYdshXup9aixEli0HXnsFQ9E5AFyngsVFdqa2WxOBYk7g=
X-Google-Smtp-Source: AGHT+IGnUAROwlJn+4uQP1wT4fjtCJ2sVWNGvlK5tM6g25KfhEOOoihtvJG60M8WXMyNj0tndQxo8Q==
X-Received: by 2002:a05:6512:b91:b0:52c:a070:944 with SMTP id 2adb3069b0e04-52e6ecf7b82mr69374e87.23.1719423849374;
        Wed, 26 Jun 2024 10:44:09 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cde8b5658sm1339462e87.256.2024.06.26.10.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 10:44:08 -0700 (PDT)
Date: Wed, 26 Jun 2024 20:44:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ram Prakash Gupta <quic_rampraka@quicinc.com>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_cang@quicinc.com, quic_nguyenb@quicinc.com, 
	quic_pragalla@quicinc.com, quic_nitirawa@quicinc.com
Subject: Re: [PATCH 1/2] scsi: ufs: Suspend clk scaling on no request
Message-ID: <62m4bfyhgzidseda2mduetaq4b2onlpjkxzsc3skc3fx7iw3xh@eyt2nwn2cuoi>
References: <20240626103033.2332-1-quic_rampraka@quicinc.com>
 <20240626103033.2332-2-quic_rampraka@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626103033.2332-2-quic_rampraka@quicinc.com>

On Wed, Jun 26, 2024 at 04:00:32PM GMT, Ram Prakash Gupta wrote:
> Currently ufs clk scaling is getting suspended only when the
> clks are scaled down, but next when high load is generated its
> adding a huge amount of latency in scaling up the clk and complete
> the request post that.
> 
> Now if the scaling is suspended in its existing state, and when high
> load is generated it is helping improve the random performance KPI by
> 28%. So suspending the scaling when there is no request. And the clk
> would be put in low scaled state when the actual request load is low.
> 
> Making this change as optional for other vendor by having the check
> enabled using vops as for some vendor suspending without bringing the
> clk in low scaled state might have impact on power consumption on the
> SoC.
> 
> Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> ---
>  drivers/ufs/core/ufshcd.c | 3 ++-
>  include/ufs/ufshcd.h      | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 1b65e6ae4137..0dc9928ae18d 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -1560,7 +1560,8 @@ static int ufshcd_devfreq_target(struct device *dev,
>  		ktime_to_us(ktime_sub(ktime_get(), start)), ret);
>  
>  out:
> -	if (sched_clk_scaling_suspend_work && !scale_up)
> +	if (sched_clk_scaling_suspend_work && (!scale_up ||
> +				hba->clk_scaling.suspend_on_no_request))

Really a nit: moving !scale_up to the next line would make easier to
read.

>  		queue_work(hba->clk_scaling.workq,
>  			   &hba->clk_scaling.suspend_work);
>  
> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
> index bad88bd91995..c14607f2890b 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -457,6 +457,7 @@ struct ufs_clk_scaling {
>  	bool is_initialized;
>  	bool is_busy_started;
>  	bool is_suspended;
> +	bool suspend_on_no_request;
>  };
>  
>  #define UFS_EVENT_HIST_LENGTH 8
> -- 
> 2.17.1
> 

-- 
With best wishes
Dmitry

