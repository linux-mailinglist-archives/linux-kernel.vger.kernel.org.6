Return-Path: <linux-kernel+bounces-337570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C03D984BCA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 21:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A47221F23B48
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031CE137905;
	Tue, 24 Sep 2024 19:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UtN0fbRT"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C29881749
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 19:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727207390; cv=none; b=BfLMLTFnSfmNCgl9KEGDfRbxSXtEZ+4ERjAXfvdhGjAzE/mZB/J8QKMJtIckbJ+h+zKkpAxgaR7IrWH5YMSLihqSgDY+la8kJWXhddKE6jjCco/26QwkZw3YuHu/vDH6a1gz8HZx7H807VmZUvJBN4zUlU+0fn6Z4eRrLcRSW/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727207390; c=relaxed/simple;
	bh=yqpJS+KhJYLxK6OoVvTSrnYnrYtRpSyQL6/IbvXFFHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBCmFqBof0j6Qy09rK7Oxo3d3IxPfCGuOfpzUS1xAf/pKcyiKdFw2SiAhrCxpzFXAnAz+bTLy7xwsHjIhKdBlwGw9u+Sa+iyExwEJH+37p+JYloamQRmv+Y8TUJsKwRqD04jyuEV1dIYr1SdJDBiYX0hZ87v9JHgqNoNz7ciT/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UtN0fbRT; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f761cfa5e6so64655701fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727207386; x=1727812186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k/dGUOExCYI9ma3C9NHHq3S03j3KfaoxW6Zsr+oPoic=;
        b=UtN0fbRTlH03LIBPrLzsuVvoNkIGyeD3M0//9LwiXNnjSQEMYlSWaEkS0jcwb3ddEO
         scgysvZSADl7T7zbMcb7dooZV0rP6fRmHwIOQwh2H/dHG9uUVIOAED1dkRS4ecploMd4
         YORs50IeBGZ/1UWDskwrgFKZL/5TKUjEc2sfECJDGIpWT5Fn19Ur7URc5A1v02rPy3Y6
         6/2Ys5UPDp5LzISS/bEASz+WoXc+vgKSk92BvGwd4pmXa+mqf/g+frOk7UEXJFxEzaEb
         AsCozV+gCusEuet0tCqpE8odxYzN2HyGmQHtYmgSdZfCk2D4MTcjKeNF/4Oi5SpfHz3y
         dB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727207386; x=1727812186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/dGUOExCYI9ma3C9NHHq3S03j3KfaoxW6Zsr+oPoic=;
        b=G1tKHREnYQ0yn4qob7wJm/S91tWcEoqsqvPS9rm4lJUSWWfvDDoev1r2+Qwq9iOfL3
         0E95t9o5JG4ivg1P/jW65k8+et8geOUa8mS5UTKMfEhaX443ZRF4VrpXzHcNDO9kZpty
         F9dGHq9tS6y9D1zrrt7PjBa5kKVaaDmMvBnm0F5vYUgaqlWhIcYQXThJCvxGaZQ8Uupl
         Y0XUkpv7wLlxwa9bpRFITF79/8283pRPGCFdWms/PlpSiS+/p6wR9lju/PofQ+l/0/KT
         73PW/TaEME0SFjKxBWUrvOUcKz8+l9w3aX9ZlA2xi1S+Ii3qYDY3iq/ahMtqXmoSMUSh
         Jmgw==
X-Forwarded-Encrypted: i=1; AJvYcCVEtMpSv423iw/G5mKleQ4NYw4AEBPcPO4IAZd+wxqztmeeybXOOx0/nD5x041tAig0mqyXW7t0p+LfnQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrkR/iuAOCfgRCXNxtox3scNN7NUu2YxNkIft6fKAIFAFhNwd8
	/q4wCMggrTLPWu8Qu1RzCLRtmANN+NuuFSYvRCm/V3vH1KW7Sbm/Y4Zaytu7gg8=
X-Google-Smtp-Source: AGHT+IF9Vrp5F23MjW0sqPHOc45CN/oE/KimpqLNFA5AlE9guRs5rUgE0mmPmEVD0LZgx4xD8k2FRg==
X-Received: by 2002:a2e:130a:0:b0:2f7:53b8:ca57 with SMTP id 38308e7fff4ca-2f915ff565bmr2545221fa.19.1727207385621;
        Tue, 24 Sep 2024 12:49:45 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d282fcabsm3133401fa.23.2024.09.24.12.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 12:49:44 -0700 (PDT)
Date: Tue, 24 Sep 2024 22:49:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Sibi Sankar <sibis@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org, Sibi Sankar <quic_sibis@quicinc.com>
Subject: Re: [PATCH] remoteproc: qcom: q6v5-mss: Use common error handling
 code in q6v5_mpss_load()
Message-ID: <tn4kxsouzpgimregroywzzvi3sjib7pvnpcnkcvccer5b7woxk@yzaqjwjxeyki>
References: <bea9842e-6910-4452-8f90-cb7482f3e76f@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bea9842e-6910-4452-8f90-cb7482f3e76f@web.de>

On Tue, Sep 24, 2024 at 04:08:11PM GMT, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 24 Sep 2024 15:55:06 +0200
> 
> Add jump targets so that a bit of exception handling can be better reused
> at the end of this function implementation.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/remoteproc/qcom_q6v5_mss.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index 2a42215ce8e0..b398ae3083a1 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -1451,9 +1451,7 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
>  				dev_err(qproc->dev,
>  					"failed to load segment %d from truncated file %s\n",
>  					i, fw_name);
> -				ret = -EINVAL;

Please keep error assignment where it is. It is much cleaner to read it
this way, rather than checking the error-handling basement.

> -				memunmap(ptr);
> -				goto release_firmware;
> +				goto e_inval_unmap;
>  			}
> 
>  			memcpy(ptr, fw->data + phdr->p_offset, phdr->p_filesz);
> @@ -1464,18 +1462,15 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
>  							ptr, phdr->p_filesz);
>  			if (ret) {
>  				dev_err(qproc->dev, "failed to load %s\n", fw_name);
> -				memunmap(ptr);
> -				goto release_firmware;
> +				goto unmap_mem;
>  			}
> 
>  			if (seg_fw->size != phdr->p_filesz) {
>  				dev_err(qproc->dev,
>  					"failed to load segment %d from truncated file %s\n",
>  					i, fw_name);
> -				ret = -EINVAL;
>  				release_firmware(seg_fw);
> -				memunmap(ptr);
> -				goto release_firmware;
> +				goto e_inval_unmap;
>  			}
> 
>  			release_firmware(seg_fw);
> @@ -1528,6 +1523,12 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
>  	kfree(fw_name);
> 
>  	return ret < 0 ? ret : 0;
> +
> +e_inval_unmap:
> +	ret = -EINVAL;
> +unmap_mem:
> +	memunmap(ptr);
> +	goto release_firmware;

Ugh. No. ptr should be a variable that is declared inside the loop.
Calling memunmap outside of the for loop is incorrect. And goto just
complicates things by adding non-linearity.

>  }
> 
>  static void qcom_q6v5_dump_segment(struct rproc *rproc,
> --
> 2.46.1
> 

-- 
With best wishes
Dmitry

