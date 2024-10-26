Return-Path: <linux-kernel+bounces-383266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A463B9B1936
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 17:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC331F2207F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 15:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A667346F;
	Sat, 26 Oct 2024 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WZar5dy4"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1978533997
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729957016; cv=none; b=tBo2XIpwKozucr6h69beO2+sI88VO0zFG3jfKTdMpQ1PEPEHCRn0qrWtjAxLUS8PVAroGTenEtG7UuGRrvZAV1ZogQp4edD1sddRNOsD4om/Fdj+xAaO4MYm4RZZcPfqPCYwcIN/pG3WG5AcjDoxgTn85blJcv7CgjnYKFFKymM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729957016; c=relaxed/simple;
	bh=c/zRoaoDocjTotnoTNri6+oKTvHdwtFowxI0mIXpM/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvUp5vxLRotxtpz1nyAvEHq+j/V9M3GvqNHcU+ZZSL6L9UoinkXkMtYrkf2UIG4e4/i3/vlqYd4/Cg1gwg530Zthp/rjIdnVkgJQIn0X+WT1gq/LIHMvd/SAPSAkLEQm31ZDkBHaknIrp/U4R9FE4n6bvq0HAUkqomDbpIdosbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WZar5dy4; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539f1292a9bso3651312e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 08:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729957012; x=1730561812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KWck6eIL58uZzSAub6tD78hTuIVPy9/y+aNlZR8moG0=;
        b=WZar5dy43bhokuJDavK/vPJbNWjExzLdBmArbZ2z6SwWTpMtXkxu4zB+iBOo3mPPNI
         /j97xDsHdkdmPbhUuwGvXCK3pZfFi8/mHhTo59opZlfxkruTljWhk0OdubEE/eBA12Ep
         dLbLFEc5fC7EG5njW1uTiv1aRyW9yfboT2M/1IyPOf0OTOkPHebk8wzfCtls4RixW0rC
         udhqg3VpRSeis0ptnRavUsOcIWN3o7q4XCsE4FLpx74WPLLljIdBck0EOT4OhOJpI7Ev
         PhOjoo+c/qlDL/+vWBtukilaM1MmumIjS4hUCFS/nCndvPFBKtUhXJm29SyDXCRbKWfQ
         qqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729957012; x=1730561812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWck6eIL58uZzSAub6tD78hTuIVPy9/y+aNlZR8moG0=;
        b=C/7XOVrxIIqMdc49K53cjPPMLQm7aGSLTFBhcaw89UMzcxmvZDnuKsod/D/sWu69d7
         UHbUmoeU0MZB844eUkX19PYgN+ix33dnno613bzxBmjOo2Hp35L4Fv9sRfvc/OqF6PUh
         UCE1X4PMLtND0bzIfdioi7IpbUXb7Ub9ojK5ph5EgckT2GJFJtJr1hctN5XPOHOJJdGW
         etitTN4KBumCxGvUzIRYz1jN+mR2+zx0v0zodTmwokY6XPJzkaMMmumNB+ey2oQbiasu
         gNXfVAKxCuMHoGb64zokWgAeLQSSL3PTPcZeENc2IwU7veR3R2iskcKMglNpxKanwC/1
         SnGA==
X-Forwarded-Encrypted: i=1; AJvYcCVquH+jzCaSOHitrhQaP5fCxEHQpxjrTdJoj11+IK/7Ar906ySYixHEnF9IbAXYEEUhuGdu25BaBSbw+jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOj2LOadLZpht/FdZNJsDeUPS0agqk2qf1GmWbesMVKyk5b7/t
	o+ih0URWcCBi8d9AY5aTnezZWUdsbX9mUNPOAcj+ESE6Vy/N5Jm9yfFuOnbAfPQ=
X-Google-Smtp-Source: AGHT+IEYw0zyqkyjhXmQoZPWSefeN4g3iItCWqhnrUze/+8BNQVvNaHa9jvcY6diKY38/iJBVJWP0A==
X-Received: by 2002:a05:6512:ba2:b0:539:968a:9196 with SMTP id 2adb3069b0e04-53b34a2d6e3mr1048350e87.48.1729957012345;
        Sat, 26 Oct 2024 08:36:52 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1de0b2sm538020e87.246.2024.10.26.08.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 08:36:51 -0700 (PDT)
Date: Sat, 26 Oct 2024 18:36:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: robdclark@gmail.com, sean@poorly.run, konradybcio@kernel.org, 
	quic_abhinavk@quicinc.com, marijn.suijten@somainline.org, airlied@gmail.com, 
	simona@ffwll.ch, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/gpu: Fix missing error check for
 dev_pm_qos_add_request()
Message-ID: <mq5tggw4x6gsiidxzllay55wlqfvtdvdgwsirty5uqjfuzw3ym@j2vuy22ixffi>
References: <20241026093738.523882-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026093738.523882-1-ruanjinjie@huawei.com>

On Sat, Oct 26, 2024 at 05:37:38PM +0800, Jinjie Ruan wrote:
> dev_pm_qos_add_request() can fail, and it returns -EINVAL in case of
> wrong parameters, return -ENOMEM if there's not enough memory to allocate
> for data structures, and return -ENODEV if the device has just been
> removed from the system. If it fails in msm_devfreq_init(), there is
> no point in going on, also call dev_pm_qos_remove_request() in the next
> error path is also meaningless
> 
> Fixes: 7c0ffcd40b16 ("drm/msm/gpu: Respect PM QoS constraints")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/gpu/drm/msm/msm_gpu_devfreq.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

I'm sorry, a similar patch has already been sent:

https://patchwork.freedesktop.org/series/140162/

-- 
With best wishes
Dmitry

