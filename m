Return-Path: <linux-kernel+bounces-532170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC3EA44999
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1054B17FDBC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86E420E018;
	Tue, 25 Feb 2025 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vkmQ7jAk"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525D520CCF1
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506613; cv=none; b=uKO34xrfbA/NgEkHD1hkEnpr9BSVvKqe7Wt7kBJfxNetcjwxmV0sJwAfD1NbAFr6u80Gnv4lOQWxS0FH+gZ8uszp6bmqsZkx+LM2NEmeRMNpuDfBEschjnZHwBiajJaxqazq/o4Z5OlSGLCCB3HqrflMfjyQFfuvSAFpDaWBl1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506613; c=relaxed/simple;
	bh=S0vGc2fxgTl4TxHz9pfDkbgBvrLucJN6TxhxE7gqfBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkIfghSvZbHJ/ESJ94spXdr04aC+yxsmr6DT9vUHqyl3q8FOZJcihYpQedX9qd9NRSvA2GhI8xU4e0Nhh1gyNRXotDf+CK4N7swgncdPE1ZaZ9Lpn8eUWG34ZCNNhbPQ4jtvZxrHsU+ORppRw4GVm6jwvE1TEs1lxGp/Q6KadpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vkmQ7jAk; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-546202d633dso5840625e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740506609; x=1741111409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8O4HWot5EUMVzTxv5rN66ccO0MtiNkXIqoN+/YVntbU=;
        b=vkmQ7jAkN/gYQOO/5PmGlbB38HvpHUF3j2ctzKvtglnij1M+kLRqO4oLONj46WY8sL
         sClSzi7xzDdbeqiDx3V9DJMsgMxkiJ3wSunK8xSsjIHWeddQL6T1Je4bVG9SvDh2/vIC
         azBqLO65ZNsfY6OkEChuajieEB99xb1Sjf0p0ABi7tznhF057mmCf8Cmpr+tUFwpF/MQ
         tlSLnSilpjDIqsT9rxlErVlDtyQnuyTS53VYFTyQCA+OlC8ucnFPyi56h7vfi580DBlT
         xCCOW6chyEwdeY5XHksc5ZoP2SF4BBV0C9wMSUvGpsLGpaXsVYB1L2TPQA6CGzInwHeH
         02Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506609; x=1741111409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8O4HWot5EUMVzTxv5rN66ccO0MtiNkXIqoN+/YVntbU=;
        b=j0kBBhdonADiHNB4g1MPbCVjceIUxBmT4a4C4kt85kc6pQcNJjt6DnLNvueBxi3OmY
         dYRXWG0sShHDDKu5Ww49dvpnABXpNNh7y3nU7m1aA/QmeHupWUAaRLRejfWwRgm+EZkw
         H4NCLIAS643j/lA0+X+3AVwPUv6G8tS5fvmu9dAOBDcsa7YHPel8KzT7mSP5shH3afLs
         Qvz2bkJygf3ClLTAZz0ZnWRhRn5z7Nooq2tzGpOux63JRlxEdm3YYoTHfvD5U20eeWuo
         5rbMcwlkF/abtoOVsaiqYdCa9fIFn2jamRUfNsD+gb5cax9b+89g4DKXlvKeflaC600H
         mWbg==
X-Forwarded-Encrypted: i=1; AJvYcCUOTnYomWxbFW61DVqm5jqs0bovX9C5VavfgxCnQYmyNJlKPmfK2KvE2ErWFD8+2YiBLV78QejQIpfJFQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw9gteDBlsGqspRBIIElfZ0Rrtghi8K2E5kmDz1uoAByibyHRC
	w+JdVvXRQcw7CXohrBFG8NRj68JUR8TxdWV/0l1JPh5hARgJgglyXRUCVrd1Gjc=
X-Gm-Gg: ASbGncvSJIu4zMWr77m5T7pLzVpJLvpisOit9kPWJm0mdLkqHH82AYhavgNceZo5aDa
	nu/ccET5K2/9bdPWenCXXBAbk6R+K3GDSIj3ZNclxAEGFfXeU+snsAk9PbjjxporubmlCB0K979
	R5DbFmm07hJeBRxS3PwQAZYumjnZD84P4brwm63CdWBE4DcLUtM4u0RLZ7ptC7mTa18JmTxU74O
	3uOwTIkBGmMGWrGKtzDuTs95Ag/SrBpNJDwEhD0hoJn8ASb3nEMPYhvaHUw2srpxxGejfHX7G+h
	8t1kHfi4EytU+dVHk7tOARTYkhrjSzNHORMc96Z0IYf+zbcycbIWTjc/o1tJX9FydQb/OqNrWgv
	1WU3WBg==
X-Google-Smtp-Source: AGHT+IG0Zc7wZsxG0nheOFfzzmCVwdzpAM4bFH1CEvsvsI0SU1fbCv6O1tOWiwsm5/goJ00WgZzfcA==
X-Received: by 2002:a05:6512:b05:b0:545:8c5:44cb with SMTP id 2adb3069b0e04-548510dc89emr2751908e87.31.1740506609286;
        Tue, 25 Feb 2025 10:03:29 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514fb084sm234263e87.221.2025.02.25.10.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 10:03:28 -0800 (PST)
Date: Tue, 25 Feb 2025 20:03:26 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ayushi Makhija <quic_amakhija@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	robdclark@gmail.com, sean@poorly.run, marijn.suijten@somainline.org, 
	andersson@kernel.org, robh@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org, 
	konradybcio@kernel.org, conor+dt@kernel.org, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, 
	jonas@kwiboo.se, jernej.skrabec@gmail.com, quic_abhinavk@quicinc.com, 
	quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com, quic_jesszhan@quicinc.com
Subject: Re: [PATCH 11/11] drm/bridge: anx7625: change the gpiod_set_value API
Message-ID: <rgdujikhrizof6p67cztu3oh4svy7do4okvowlgxg6rddeoqkq@hjc7pni57ilb>
References: <20250225121824.3869719-1-quic_amakhija@quicinc.com>
 <20250225121824.3869719-12-quic_amakhija@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225121824.3869719-12-quic_amakhija@quicinc.com>

On Tue, Feb 25, 2025 at 05:48:24PM +0530, Ayushi Makhija wrote:
> Use gpiod_set_value_cansleep() instead of gpiod_set_value()
> to fix the below call trace in the boot log:
> 
> [    5.690534] Call trace:
> [    5.690536]  gpiod_set_value+0x40/0xa4
> [    5.690540]  anx7625_runtime_pm_resume+0xa0/0x324 [anx7625]
> [    5.690545]  __rpm_callback+0x48/0x1d8
> [    5.690549]  rpm_callback+0x6c/0x78
> 
> Certain GPIO controllers require access via message-based buses
> such as I2C or SPI, which may cause the GPIOs to enter a sleep
> state. Therefore, use the gpiod_set_value_cansleep().
> 
> Signed-off-by: Ayushi Makhija <quic_amakhija@quicinc.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

