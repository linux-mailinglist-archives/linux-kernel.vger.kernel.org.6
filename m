Return-Path: <linux-kernel+bounces-526957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D848CA405AA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 06:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299D2189C6D7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 05:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F3F1F03DC;
	Sat, 22 Feb 2025 05:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f213V6zc"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2DC770E2
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 05:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740202332; cv=none; b=OgdjdtJY8eTEIVGbYJ8/fLFd8MVyxPihmIlmPmrCLDrkrByAW/QiIuu47Ao4dH9e4j70OURP5YZiPfp/ftawsn44L0E9mTKkRpKtdKjnruF19gDQWrXkZdMdvWfsFqSg72R7WqNQjviaHwp+ArzQ0jkt1js715sb5NztiitIEDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740202332; c=relaxed/simple;
	bh=sOtQZMxE4hxoFNddl0YwhniAj+7lfiqyMq3DClmUCpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0rEu289G2FbisblyiGdOTeJzFg6+Yg15w1Ep0ujNlNzJCdkFj+2wSdiyP1pPoovH9EfiiJAdMyleOkfgxBs33Wkhl5XUBIOiypY1qvhYBqBC1oDPRXIZnJVadd+ZUzS1lZeuK27GZ5Ksf8xtnpofAJcLh99vxlDomAZUBkTMl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f213V6zc; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5439a6179a7so3128729e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 21:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740202329; x=1740807129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=87cavELH7HieCR4xxlMRwzRSQ74aAYETIX2I5ONW3rc=;
        b=f213V6zc6pH4j1fQYUuG5bBC1T0UrB1KY7zv44pV7VGv+hOqXG2JFNGde3fn2X0HLp
         v1wMlPvsfTHj6glDTdhqYJ0z+X4borh4gBNyXkBG0S4GjC7tVSjSEnMhnKkMSvsNIdd7
         K5p/9SWMBWl3609Dpsd7Ba+6q7pEQNvHEcnLcQaSISkr5c3awuh0cyz7owYcOsg5qy58
         99ALKW5nt/JXHCmgW3/630nTeuxZtB/9GTtLWHcskJtOLtWTw1i4LDc8gm6E22QOQQPO
         d7hzfR0h8Kde5nYjEoEvJ/ALCMPOj5x6zLEUc6ZYbxLpsO5kf6rYOCeKYPxwyg1bGRm8
         HhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740202329; x=1740807129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87cavELH7HieCR4xxlMRwzRSQ74aAYETIX2I5ONW3rc=;
        b=FOof8//bcxlCL76i8w5lo3c8FDKERuDQYfde/OAdrpMz2Ibe26VLgzt3wjW0VQB8iA
         RWTdBBgaqdVC5blLMg5m7I4pyeVUHMWyUzFoXO1vCnlHmwU1Rkz2Ghcajg0ZwIPO5YIJ
         9NjcWd4qyhbe0bIicbi1sDg8CLRFUU9a9Qvvi0FQnIXMKdaHJxI8RgEt+zjNQN0T0LJQ
         +1DJmvC0MgaS62KbLyAWS4irKQgWAGbfvgUuT8mHIVrdhqy8nByvcb08UlSG3j7pZPHo
         /IsYcX/M3WrRpAYWR5fO27TQGO9yC+55QCK0+RD61SjR7b6nKgt0iMsW4JOjt9Y5Issh
         0LQg==
X-Forwarded-Encrypted: i=1; AJvYcCVAgBSr691PVB6YyvLlpNOl89FcbRNJjPB93diLLVD0hd9Yxv1LWxot/dUSw+p//ZMWac9CxOODHRGoEAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGs3SXM1YOzwha9mwJB9uL53hO5dQkNUZxjq1jWyNk9pd+Yx+S
	lMNdCzY6AWzfyv5deZGPUm3ReRNNi02J7oFbCD5BOu5u3efYdEfUUxkKA+33ies=
X-Gm-Gg: ASbGncvdxxQsC7Zdix+Mu6HHQ0/hGyMk7CPERwj52OXh6wKp1WOtVFC7qc0CxrPFhWI
	PA0XJs6zDVjzaiOC+0BDRZl3UK/+0ny8FOiKzyO1Q9nIa/OvAIgHhUk+y10L0saEqRfIoLUxkDI
	Hk2GqnkfaCI0ubwZAi2RKpTPGbK23YE0of8aKpIbPBEbGBGHBEcHFHi3EodKkRQk2e7RjTCvgHQ
	6mmysKS7PJHD1Z3DLhFYWXS5vT3e0ItahjdH3xJFJD9dAH0itzL1Q27NElleJq/Wf3t5NA0R2hj
	OXZO6IkIem6KuUnuW2DhR2BJb2WO/xTndazKQRwCnaxStecfhexCDd+MJFb58lznCAPr70QkMl9
	ghZlTlg==
X-Google-Smtp-Source: AGHT+IHD3hAlNop+4r+I7bLXqz1eBLsQgYn7t+lFx0IzcXlZ0NOucwRd5GOGb4By4F3t9ApVCfRcPw==
X-Received: by 2002:a05:6512:31c6:b0:545:d54:2ebf with SMTP id 2adb3069b0e04-54838c56ea8mr2571321e87.3.1740202328644;
        Fri, 21 Feb 2025 21:32:08 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452d9cd8a2sm2424878e87.76.2025.02.21.21.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 21:32:07 -0800 (PST)
Date: Sat, 22 Feb 2025 07:32:04 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 drm-dp 4/8] drm/hisilicon/hibmc: Refactor the member
 of drm_aux in struct hibmc_dp
Message-ID: <lya3xvxjr6j3te3swomgn4yicv2ibvzzohr6okqxr35z5jlcp7@kpwvopoesnrs>
References: <20250222025102.1519798-1-shiyongbang@huawei.com>
 <20250222025102.1519798-5-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222025102.1519798-5-shiyongbang@huawei.com>

On Sat, Feb 22, 2025 at 10:50:57AM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> Because the drm_aux of struct hibmc_dp_dev's member is not easy to get in
> hibmc_drm_dp.c, we move the drm_aux to struct hibmc_dp. Then there are some
> adaptations and modifications to make this patch compile.

Nit: move, not 'we move'.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v2 -> v3:
>   - split the patch into two parts, suggested by Dmitry Baryshkov.
> ---
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c  | 13 +++++++-----
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h |  6 ++++--
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c   |  2 +-
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h   |  2 ++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c | 22 ++++++++++----------
>  5 files changed, 26 insertions(+), 19 deletions(-)

-- 
With best wishes
Dmitry

