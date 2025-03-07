Return-Path: <linux-kernel+bounces-550408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B80A55F02
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 04:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912783B19B6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCCB18CC10;
	Fri,  7 Mar 2025 03:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pOohmaxj"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9141632D7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 03:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741319673; cv=none; b=JiqYCSaub/aIOR0M4rkKJCG8XFBVa4ExQtun04/9fHElKlTX3tipiuQeaZHk1rj3zkfqv9PaW5gjbU2BtUvnke/eoTPimdKbJnaKbQ1IVA83CYM/0c+bIRYj6hcxaIAeenv07T4pfZZAK/2U0vbVXx39oVJkLFrZNq+BJKOjyys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741319673; c=relaxed/simple;
	bh=7xGLIoU49g1W69JlZQf4bb8G172hsr2mN1AezVR5wqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYETSo8oZzxpEQetDKRVyhgikr/gd3m0Q6rV1Ebk/wq/uYLhL+/hHhnIA4I/61+C0Ztn5E1g9pdjZKKTpYfWzFNyg6nGHut2YA3rrfWhNonVuoDe5RzUqqT1J83ZXb4uwVRBjYSAY//zKTWLSgr4V9aX2HtPCSrlL1MojUy9dmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pOohmaxj; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5439a6179a7so1417863e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 19:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741319670; x=1741924470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m+OWx/yorY2+66tlAZHZ/irBDPLHhMdijI7doxLhFUI=;
        b=pOohmaxjh5r4d/TOBQuzZ//oL4g+AkTlysHk/Iwc3Y9IzOwt3bbF3GO2VcUntjpn3A
         S0B4+0JMb0ecCxd+zolUiQN5836c7LEEU3JmEfA9wfSqtF2U0e/7v3CANflnihP7gVAv
         mfvKWpakzn+lW0L4tPTpdfjpG8I5CcsMxwm7gMVB1n8+xVWF0cSBItsypqrXNXksb0HL
         nlZnupBIClddRRUJ9PDKSuUmKZ9npflzw5wsq5YajjNCjF1ylzb8MPSQbxpmH/vxw/TA
         Z8oTwQglFV2JVwGOS7VFhJ9718nu9iRZ9yMq+9r6xT1v8FVAIFVlF9J9NMuUSNaTJcz8
         wndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741319670; x=1741924470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+OWx/yorY2+66tlAZHZ/irBDPLHhMdijI7doxLhFUI=;
        b=gpGgrSpTdkzkHvw0ZhzM+qBSU/8yjzAiUeYaY3n/MorNx/dJowlViQYQ81+xCnXRcZ
         yGbf21SvV8GJCS13s0Kehr5rYnJXHaYqEeAHS/DeZhYdiGOnRouLAr31CR28+34KoC+F
         kndtdSGc6qdgZViRtWVTWReP0Aju9OS+xLg5qUZZ8E+i4Ym6Ypm/HtChjaryDfQXP9sz
         P2HVs9SWLWJM2AtvLkAqbEF875WQZl/4ZCL0nBcyiNY3Mum2eILIcZbEs+PJ3LBwOcfY
         WHzqNA19sHykueeaXzKF2IoLYcdun4M0az2vuqOjORyQbk66yQHD2H0cWEE4IGDjQdpK
         WzpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbjGazCpU7r+UhcEnItfaXCNHx2s9zViawksEIL4SXQsE6CVH6SD+uQqif1nYIKn9GKQTEZ+/Xe1KLSJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnIjKPdnFXzzmg4R9D0zn6WvpqL4NbzgHYz/06KGwmvN6+/MQa
	y67wQ3ZpwhrN4UNGL9g0Vkz7dsdjoq0/ltrxEGRMH2UtIvXpI9qQvKTvzA45dqA=
X-Gm-Gg: ASbGnct+m982ObxUqam+iLUds1ZW38FGVafR2kNr5GgtmaY03n+IujSM9HvBM/oDILv
	73JcwtFbQl4DJSdzx4RCO7vPzkQybZr45Pq7p+FYEc8v3kUo1b9KcJb266VAtKUp6CzP8ScTDo5
	9kseo7ltnh54HqgnsADO+2Li9kmMODbgUo/yau4s+1fSVNdyJTZj+7HLZNqoKyaFtzLsJwWToL1
	hf3y2QRb6/ZVgntoWi0fVDMhrKMq10TJO1foEAe5Rd1lgozmoDSUFvL22fxgB9RyxsBCa5oGkP/
	TYBDP4AAAKDi9O8zK56YsHLcYQiXtQQwp04GAHLx7R2cihdGoLQO02QXRdhnqQA+C1tZHc5QiSV
	9OTyKByOEbV214zfns48izcbf
X-Google-Smtp-Source: AGHT+IEJgFAZPzs4rQ+GVKleLSPBx3Zx5gP9AGl5+VtS3eJ/TazNnZBeAYAWo60NeSqqg8te1ly9lQ==
X-Received: by 2002:a05:6512:ac8:b0:549:8999:8bc6 with SMTP id 2adb3069b0e04-549903f6a22mr675684e87.6.1741319669653;
        Thu, 06 Mar 2025 19:54:29 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae4623asm358766e87.49.2025.03.06.19.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 19:54:29 -0800 (PST)
Date: Fri, 7 Mar 2025 05:54:26 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run, 
	marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] drm/msm/dpu: Remove duplicate dpu_hw_cwb.h header
Message-ID: <wnqsl5clvbk3gdqlvnomsmif2zuzeuxzhmirz6wexr4ifn2e6k@yxd5fhty3vkc>
References: <20250307015030.86282-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307015030.86282-1-jiapeng.chong@linux.alibaba.com>

On Fri, Mar 07, 2025 at 09:50:30AM +0800, Jiapeng Chong wrote:
> ./drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c: dpu_hw_cwb.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=19239
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202503070155.TuUngwD3-lkp@intel.com/


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

