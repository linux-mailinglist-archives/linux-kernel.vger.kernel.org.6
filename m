Return-Path: <linux-kernel+bounces-552194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93497A576AB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 01:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE24B171431
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C80679E1;
	Sat,  8 Mar 2025 00:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mY4NHDD/"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDCEA59
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 00:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741392902; cv=none; b=X9sNpqz8pdTFW22ovGQXl5NOGmyGyQE8QEq0wA/Jzrlnjx4ATWsIqYOn+T1Io2exP8fg0LLdysxgDodHHjJc2X1cE74lqzKGRvAJ8V99wO1gLKRR1maZ1W1CsK+Cybh3FOs8yEBJsQyx9x9Mx9kqzX/ZHavm5AGcB9KkGisarFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741392902; c=relaxed/simple;
	bh=ew/35kdLK4qgIIWfEjIh84RGMmwMswvqotUpp4L04wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLqIIxiJWzJeTLxvQ82Hmg6wuM+EceuiopVrx3g82PkMxwIXhQhzJIXonGBg5xZzBIWcZbB5Z4bS0RfqyIsW68A+pQNpHvbQa2sxLCkuQ5mvbWWC+c1q4qEZKIuuFsYwQxvwxUKC0uIrm/A87icZwChSq1bjPz21IYJsl4OoMAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mY4NHDD/; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54954fa61c8so2665628e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 16:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741392898; x=1741997698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OI+9sOurb7xWpdPzZDCFl9IV8OhNe2U1hJtvoJa6TD4=;
        b=mY4NHDD/+iY0k/NZbgEBPCVJ7vRSQouileBGpEoGxTkNS8tin5t2lyUpuA5/ae/658
         hkOtOasz0CAcJHQDz/c41qJgNqMuM9iAMQGn5tDNF5ECchNB4JRE8W/NzNbD0zU4G0aw
         n2O1w3JpxRdYi8RUV+lWwSyWhc0Hc2k/KPp0PRgRctvrJHLS5HVosJWQlsYDhL7AGOya
         g+vqCmcCS8QGSlQhzxPmH1LY2Ba3XLzuHgTa0yMJVfEDFEJxTEJUVMt+0iACRbPsVBSW
         J5F1zZ3v4mLSc0vzGo7nQWbqhZSMS0PkprRe0AZHEQ+tR6iqmxllZji6KHjr4knqdBq/
         KelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741392898; x=1741997698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OI+9sOurb7xWpdPzZDCFl9IV8OhNe2U1hJtvoJa6TD4=;
        b=BdjO4sAN9GJxigdgQ9AamdWv3eplohKmN+znP6aeDYdnu/JOIDEUjT3ExQ1OdwRtWr
         VThG0xXjGJcYALhdM1P3eOL5w1ZwuULVSCNwY+B/F6QgQ4+eSA5ccbkHHoF5YYhotzGc
         8pqFgVVL/vmjqvN6G2baOJSC2OHdZGfBdtlXq9HFZEbkIKjdXhTMdSRvuQdpdrYv5Qw7
         cIVdG8NjLbhC1IEmqDpDtO+LwRdDBItliNf6Sflzbn03oFd+6W++Pck7eKibhRqacX+e
         ULt9dwsYAJo360fZztGM8ufPmfqNuQxi4jmYY4PyE269le2kDSE7GjqsKVbT0l/cML9l
         2uUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXItBtS8C8FS65vEsX8zGECtbXhA4TybT6DKl8o627YSY7AX4fYdmPIO0EYY8zWAwyDDsF+YvodD5rc6zA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHqwud/rNgYjfKpJL2+bCSuSBxcR9BVd2V25P5tPItdwoXWMhp
	UOqPhQ834cdeQDjt51p/apVBh6hNLRVDUmr2Q/e0gEDP0f8ZLujSVfYACBR2q0k=
X-Gm-Gg: ASbGnctJfoRhetUCY0KzCiHhduZ6L3+ua+VYYUPUYyObfk5WIGwvWSA44Yn9bTtoo8V
	3j2rReLbWpCRpj9DXD6M/QZplYt7oW1RrVawvJyf69syffwVw2Cp7bI09kk9k/DONC5nltAG85X
	v6c3GrvYuxgmLU3L6ct/kMXOgbJJWBkbvy9vUwK8higrsthlHzdBnBd3esRhxlkgr4mTlFkCSvA
	5PS7v1AXsx8qkf7tJgQYLd0wm8CfLjfG//OG4LNaY74CXBF3kU898aQcdFy4pwy2KKJ8Kw2C8Ut
	ldb8kefI/VqYJZ3TMUS2IplgwYROnhHsSnTJqq2yo1+voA+R26rK0+le1u7fOcdZRfmCQaRpOw/
	miDoqB6BNUYVSV/hLR5VaufLP
X-Google-Smtp-Source: AGHT+IFbuhinx1qF4on+W3zSP7LNgSQf0IHtNKaQVFWJQ8VobeRY0aVJ73nWM+CnKCUkmpRbt4NgHA==
X-Received: by 2002:a05:6512:118a:b0:549:5b54:2c77 with SMTP id 2adb3069b0e04-54990eaa9e3mr1876943e87.32.1741392897791;
        Fri, 07 Mar 2025 16:14:57 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b0bd5b5sm651008e87.158.2025.03.07.16.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 16:14:56 -0800 (PST)
Date: Sat, 8 Mar 2025 02:14:54 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] drm/msm/dpu: Fix uninitialized variable in
 dpu_crtc_kickoff_clone_mode()
Message-ID: <vvg6cvpjtcekulvjrovxhjpsd2loh7ath4eu3nya2dffoabgvw@mtcmctbmpble>
References: <f8ba03dc-0f90-4781-8d54-c16b3251ecb1@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8ba03dc-0f90-4781-8d54-c16b3251ecb1@stanley.mountain>

On Fri, Mar 07, 2025 at 12:29:39PM +0300, Dan Carpenter wrote:
> After the loop there is a check for whether "wb_encoder" has been set
> to non-NULL, however it was never set to NULL.  Initialize it to NULL.
> 
> Fixes: ad06972d5365 ("drm/msm/dpu: Reorder encoder kickoff for CWB")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

