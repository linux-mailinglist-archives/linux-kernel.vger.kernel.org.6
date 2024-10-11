Return-Path: <linux-kernel+bounces-360741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 021C6999ED6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31AAF1C22E39
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE33E20ADF5;
	Fri, 11 Oct 2024 08:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bQ3oX4xd"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7312E20A5D5
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728634767; cv=none; b=HoSSsusjAzg9QOxyGIzT4GidDz/Pc42A15BCCsq+TQhcyjvwZ8X2/pCveJ6+qaHtaBW1WoCVUGCEv+1eQONC3wA5KYjyR4xVdl78wawDo8KRzj429h+dClYh9mm41XXZgoSWcfzXmEhiQRisnaLRfEDbEKKrEjkb27syr5A5p34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728634767; c=relaxed/simple;
	bh=gvAocyFZCxC9vLyotH/Jkh4qPbPfSwGxlwgXJFGlyuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdzgtSuBymysGvKZQhjU1DxT1YKAKWxhXTy3gVZpb7/yHJDUCXSyAqAiufwc6IV4zDgQBrprfQSrEq3JNrvOTWhhqHqtcFvI3qWdEbHRROppE+dj5vB1mh1YF/gWfJ8mfaypp3MQWF8STZrkfMhxULgtJK5AL+Mn3Gm4y5NLURE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bQ3oX4xd; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d55f0cf85so379883f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 01:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728634764; x=1729239564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6J+uE5iMA3/H+CWTUJR3uTJQSjnSupLoaiF+Mj5l3T0=;
        b=bQ3oX4xdcmeyiJJvMK+PEwfg0DSOGRqDvO8YbwH9yO2LDWLss8O7hVcfDMSiNgjrdE
         PVm3qfDrTR4pLAv7jQkfF2MXBEghc+HYicj9Nas6rlJ28BC/KCuiYcP3ix9tLv4BIre8
         unHjodLWCfPu8F5AZO693l7JUQrUojpFD9MoatsxwcmyQQLoyZr19wKNEhE+DJ+Ff7SW
         FmLu9ISiFrRqkHWnAS2fZoimGrj0zWU8kFtML0g4RSMCBUdTrYd/5bI0qcGZZsfJcHdp
         gpk8kwqbcCSA4he0NTF6ZmInjnxuYaYV67mXaMXi5gIIyzIr4c+I9QyTlndZ1GYeQXz+
         gdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728634764; x=1729239564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6J+uE5iMA3/H+CWTUJR3uTJQSjnSupLoaiF+Mj5l3T0=;
        b=gb2Ib0gWoz9eSMMyMf9MtBOtUtohB1CXZm2rZeS5kTerVgF+oawCXB+vRTsKDQOWRK
         r9TFXquvYgTHhE/JXllqqsLdJxYbuabLEHRYixlU/Fj4VsV3z4nhdYnjVEyI9sShqOst
         W8YbWXNHBW2Yepn4p3UdrB55ro2iQPzQap4+TkcWmXqOpiiqKzJFIdVcNV603l7zarnm
         sieMZqgDb/WmfC3zXHEFzVxBfBNUevP/GQMHK4jMy4cCzNBFSgQ02PwK+A0gY7XbC2ce
         JbMT99eHYAD3uSDQa07hx9hRTw02B6n3mVh+V4FTejaM+VooVBYSfTzBaYzCHJLPYLCM
         mUmw==
X-Forwarded-Encrypted: i=1; AJvYcCVvdbZ/N1mSasBeXa+nAU1u9m8N/ofhXYKF8Jd4bkl0/kr0iZ5NpUyhLF0UhItwtLHEiya1JzKRwn/7dn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEAbyuYy95XoJyJdvZCWsInhG58kIYuu4ext2BFfIjK31Slk+H
	vmR6/LGPihGJ/XMxenQ3wXcVSvZ3x9sB9wbuptKw8PWTU+WN6p+tl4kZwc3JQrM=
X-Google-Smtp-Source: AGHT+IEh1qHegvlY8LqZOcJFQcPmv4Q5bDdymgLxEN3Xxvmlyb6iR2FO3wDaCT1RCr7OgyZ3OSgJ4Q==
X-Received: by 2002:adf:e908:0:b0:37c:cd0d:3437 with SMTP id ffacd0b85a97d-37d5530438bmr1300655f8f.58.1728634763634;
        Fri, 11 Oct 2024 01:19:23 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a87d3sm3346373f8f.11.2024.10.11.01.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 01:19:22 -0700 (PDT)
Date: Fri, 11 Oct 2024 11:19:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Everest K.C." <everestkc@everestkc.com.np>
Cc: robdclark@gmail.com, sean@poorly.run, konradybcio@kernel.org,
	quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
	marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
	skhan@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/msm/a6xx: Remove logically deadcode in
 a6xx_preempt.c
Message-ID: <ef752080-130f-463e-bcd4-e1a33fc962bd@stanley.mountain>
References: <20241011052315.4713-1-everestkc@everestkc.com.np>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011052315.4713-1-everestkc@everestkc.com.np>

On Thu, Oct 10, 2024 at 11:23:14PM -0600, Everest K.C. wrote:
> The ternary operator never returns -1 as `ring` will never be NULL.
> Thus, the ternary operator is not needed.
> Fix this by removing the ternary operation and only including the
> value it will return when the `ring` is not NULL.
> 
> This was reported by Coverity Scan.
> https://scan7.scan.coverity.com/#/project-view/51525/11354?selectedIssue=1600286
> 
> Fixes: 35d36dc1692f ("drm/msm/a6xx: Add traces for preemption")
> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> ---

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


