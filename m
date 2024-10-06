Return-Path: <linux-kernel+bounces-352493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81205991FFD
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 19:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348461F212FF
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 17:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC5D184F;
	Sun,  6 Oct 2024 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kWLS+PfG"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD034D8CB
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 17:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728236164; cv=none; b=Y2oOFSApHLandGWO49EPv6VLGAR295Te9Jyq2sBtLmRDYAJoW7ukz/6YRxC20bMpQPszj2a2ojVQk1uLERzdIHS2CCZu/DGLYly4h5xX/OauWeIcygWOvDUXIPMWs9cw4fR82b9UJasbAa+mMlge3EL+OG+G+Ow8aaU/Rk9sy+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728236164; c=relaxed/simple;
	bh=Hm4a5C5S8cU8SRZ6MrRN6r38b8e4yHNIwRLzRHIYPg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuJk6WGfzKrINmJSHtuxVlUNrjSJ8Ohfnfn5FdNjVkf3co33SKRTUMDltGa1Bsux3mp+R9Vsi0RpT48hhCS9NLHlQAfOPIo9aw0g1luhmrO/jQg9vOsn+pHiTGZjr208gh7l62cGR5X6QvDA2ktChg141Er9zE6XqoYFS7SaI4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kWLS+PfG; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53959a88668so4441431e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 10:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728236160; x=1728840960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2jqjA3t+uJH5C3u6T2WtPr91xISIEaMidxKBcqx9++M=;
        b=kWLS+PfGwuMsM1o6t8nIcquDNveUAqRVLVyH/pAn8/W+aK1U3FKOaMLFYr3+9NmkZb
         SMzuK6X0C19l+6n7/vR4PE4JePA9X/82jKq2GZmKvO/J/d0ULX2G8B573zDS3wavo0aS
         98XqNgg9E4fMkskpPGIIwu+VE5uoCW+qr4JqYMhM/sOWSeOpcCTSPZ0/Z0B5xQmUh20U
         swFXLAX3q6pW24nbC1RXaxK2Lq8nDAfiCtNHEU7Ku0Ak8APq3cm3Kd4NYOyfW2qOrLeE
         9rkhjyXgDRX+p5sH/58V3DWLesi6hALGdasje4r71KzwXFxEn4WRCzVd+3oVwpJNvwHf
         8PvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728236160; x=1728840960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jqjA3t+uJH5C3u6T2WtPr91xISIEaMidxKBcqx9++M=;
        b=HaGcu01qTzd2GmLEP4zyvv1HV+rJOVsad00/yeRatEg35hfY7XAOrukFgNtVc6KQoo
         4GgsBczdMFnvGeSBlnOeevOUHyB1a1tZCaTuZ4I+p64SdtST1nvDB+MNWHn2Bjd8+/4p
         kFsJtizEA07DgNFXsfP1yJSnNNdglMIvqhTGFLOpV0MZJvz4DS4Yv7pieeW8rxkoVIkY
         xzAWMHrfn8c+gzkDgxh8d4Jo2b78Vw7eO1A55hwitClR1yI17uV2wI7EhnkQBaBkT039
         z2ZdzRr+dUL01lgFvybZJmcViaBNlNa6Bvbl2pAVdX8ZHWOFCo3AoLKNeMboGNz3De/A
         uyMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhUmrFslVS32puw1EXNdNFW9siOTPF4RCmz3PH23kaudAOfXK8+sAutgnA3noVBcoXw3fiVi9Mxp7YBro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ei49asdBbmX4WL0qcTP5bwhPWNCPpHNHk18u9SI6t8HAchJs
	ICFvry3rrKrecAztHT9xCVw6xqMcVqSba1vj/wMNybczpg3hVclGM/c1E/9zYpw=
X-Google-Smtp-Source: AGHT+IHWh4w88xN+QzKpi0f2iKqrojofn8hslRswLVLKHnZEdTKJTweHLoAMSSAGDcgRdxs/9LEn2g==
X-Received: by 2002:a05:6512:1387:b0:530:daeb:c1d4 with SMTP id 2adb3069b0e04-539ab85c0fcmr4556394e87.12.1728236160467;
        Sun, 06 Oct 2024 10:36:00 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff233a0sm564542e87.199.2024.10.06.10.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 10:35:59 -0700 (PDT)
Date: Sun, 6 Oct 2024 20:35:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Kuldeep Singh <quic_kuldsing@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Qingqing Zhou <quic_qqzhou@quicinc.com>
Subject: Re: [PATCH 1/2] firmware: qcom: scm: Return -EOPNOTSUPP for
 unsupported SHM bridge enabling
Message-ID: <2fi7pyhpetqyhipjiihuafddggwdrh7abuvfkks5hu5qid2rfm@ibuiecrhijey>
References: <20241005140150.4109700-1-quic_kuldsing@quicinc.com>
 <20241005140150.4109700-2-quic_kuldsing@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005140150.4109700-2-quic_kuldsing@quicinc.com>

On Sat, Oct 05, 2024 at 07:31:49PM GMT, Kuldeep Singh wrote:
> From: Qingqing Zhou <quic_qqzhou@quicinc.com>
> 
> Currently for enabling shm bridge, QTEE will return 0 and put error 4 into
> result[0] to qcom_scm for unsupported platform, tzmem will consider this
> as an unknown error not the unsupported case on the platform.
> 
> Error log:
> [    0.177224] qcom_scm firmware:scm: error (____ptrval____): Failed to enable the TrustZone memory allocator
> [    0.177244] qcom_scm firmware:scm: probe with driver qcom_scm failed with error 4
> 
> Change the function call qcom_scm_shm_bridge_enable() to remap this
> result[0] into the unsupported error and then tzmem can consider this as
> unsupported case instead of reporting an error.
> 
> Signed-off-by: Qingqing Zhou <quic_qqzhou@quicinc.com>
> Co-developed-by: Kuldeep Singh <quic_kuldsing@quicinc.com>
> Signed-off-by: Kuldeep Singh <quic_kuldsing@quicinc.com>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 10986cb11ec0..620313359042 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -111,6 +111,10 @@ enum qcom_scm_qseecom_tz_cmd_info {
>  	QSEECOM_TZ_CMD_INFO_VERSION		= 3,
>  };
>  
> +enum qcom_scm_shm_bridge_result {
> +	SHMBRIDGE_RESULT_NOTSUPP	= 4,
> +};
> +
>  #define QSEECOM_MAX_APP_NAME_SIZE		64
>  
>  /* Each bit configures cold/warm boot address for one of the 4 CPUs */
> @@ -1361,6 +1365,8 @@ EXPORT_SYMBOL_GPL(qcom_scm_lmh_dcvsh_available);
>  
>  int qcom_scm_shm_bridge_enable(void)
>  {
> +	int ret;
> +
>  	struct qcom_scm_desc desc = {
>  		.svc = QCOM_SCM_SVC_MP,
>  		.cmd = QCOM_SCM_MP_SHM_BRIDGE_ENABLE,
> @@ -1373,7 +1379,11 @@ int qcom_scm_shm_bridge_enable(void)
>  					  QCOM_SCM_MP_SHM_BRIDGE_ENABLE))
>  		return -EOPNOTSUPP;
>  
> -	return qcom_scm_call(__scm->dev, &desc, &res) ?: res.result[0];
> +	ret = qcom_scm_call(__scm->dev, &desc, &res);
> +	if (!ret && res.result[0] == SHMBRIDGE_RESULT_NOTSUPP)
> +		return -EOPNOTSUPP;
> +
> +	return ret ?: res.result[0];

Could you please make it less cryptic?

if (ret)
	return ret;

if (res.result[0] == SHMBRIDGE_RESULT_NOTSUPP)
	return -EOPNOTSUPP;

return res.result[0];

>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_shm_bridge_enable);
>  
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

