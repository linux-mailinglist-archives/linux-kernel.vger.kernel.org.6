Return-Path: <linux-kernel+bounces-357222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C2A996DF3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093631F245EC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC0E1A2C0E;
	Wed,  9 Oct 2024 14:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LBFMzaqb"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F8D1A0BC9
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484317; cv=none; b=Yy0uTba240gLGcDZ/AE70+3db5RnkYeFj5ugQBMIuTKvq3QjCRttYOi064wYiwXcPdb5ystpQ6cl6xqt49ZHLjPjSRo4d/2cVHkrs0KK7lNEVUa07Tw5nbM9AeATRE81ABfvHNdS97HNbOIRAH4kwHyFpzxl8ZU4THz8SZiqlnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484317; c=relaxed/simple;
	bh=vEMD4WwYjuWGV8CRSbzQuaznLnofRsqAOpvMvrJYPx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pslWJnIY/borlcDUQdA+6JboqQ0HVpM+Wb0MZQx3CgsCKKGD3buB7vV3shdEsr9l/pEQYhJ//W0JM0Y6nQuNRkeP02UWjmOfiOlhsbXY74UKvcAbDDJtNignVNE9iBb/eGXQdqAU0Jv0ZjDZApqaxAHipB1X9d6G2+h4ANQB5ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LBFMzaqb; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53988c54ec8so8140708e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 07:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728484314; x=1729089114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yYNI+1PfHh385gTjnwclbpcox+TxtFeH4zJJpG/htMY=;
        b=LBFMzaqbS6CNopMMzS7j1Egnunlehav6V1k38I2Q687jzc9k5fMQ5NnxU1P+LZI459
         /nxN76frRCVsQ+UCmaxBFe4U6AtQDzu1c6hVXyRBe0xupsU/KWDL1N3anBNnffngDQco
         YZO8ZzkqA1DZqadUpQh432zQweIa4D1G7CsNDqikMrmTWZf7n4LLelGEXWBwPUh5iA6o
         jxiUhqSYQgZEoi62YAuMN3EKM1FI89XSpXlgly3EVnwoOJ6MkeASll24Az0w6K+jWbA1
         /wg3CqW9ka/wINlGzeb2Kc2RVxhYpqImW6K/K5E7pjSJADsFVhMYRem1bP01GrdOuSWM
         lBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728484314; x=1729089114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYNI+1PfHh385gTjnwclbpcox+TxtFeH4zJJpG/htMY=;
        b=FZjwqsEDBPmZUJPcrmusf1Zwg6UXBJPwpOvVVcqTX8O3cvYeCUkSEkgriAHE9RB5qU
         XI1ymD/IRjvzYR5PoKIaYbbTHcnxpjic6MajtSn8j8vH+OBRLbZyk/eKf3bIie3L4yjM
         ul+2qPCBt/lbd54Tz+fM8CgcdjnjmdV9h9HkUXDiD+FtkKR7P7tHOYKtOoD9ekdWgnjb
         sCKPHXu79EC3o0HI6/D6xecYJ0nBbRX3jf+JFL3ZX7hZoVIm5gnE1axUCDzUhuTkNdoY
         4IaKXDdrCmmyFlxlnT36FIUU6qAer404OcxLW9STS9AAigoI3lwK0Ln64ObavsIDxRkL
         jNFA==
X-Forwarded-Encrypted: i=1; AJvYcCXAOSRetyJKqFh6u3uYHsAQunJqflOxmb2/vlBMUPh3LyEscfw2rIe41tPYVoT9C4W3GjxHJjqLuFF+GZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRqhzHqzum9e7RPhvoCuFQW6+usqfpqQ6vPqWp1AoxfSgiohOL
	p1TGPczoDynXtuDBZzPZGobEBLOASk/PsClSombcwmWHN5jUNwW/t1GW1wsmCUi7jJ/w0uW9lkf
	w
X-Google-Smtp-Source: AGHT+IHCvSUk5aTqtkn8zMjzs4QnYv/VwZVXDuQvKiNM6UHYhHBWh5lnpPRTzXF/gWo0nNPnlYwRog==
X-Received: by 2002:a05:6512:1193:b0:539:8d2c:c01c with SMTP id 2adb3069b0e04-539c494f272mr1716621e87.41.1728484313620;
        Wed, 09 Oct 2024 07:31:53 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d6fab6casm22070955e9.48.2024.10.09.07.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 07:31:52 -0700 (PDT)
Date: Wed, 9 Oct 2024 17:31:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Qianqiang Liu <qianqiang.liu@163.com>, leon@kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/nldev: Fix NULL pointer dereferences issue in
 rdma_nl_notify_event
Message-ID: <1799e36d-2083-4904-8bab-91be64cc9f60@stanley.mountain>
References: <20240926143402.70354-1-qianqiang.liu@163.com>
 <Zva71Yf3F94uxi5A@iZbp1asjb3cy8ks0srf007Z>
 <20241004201302.GA3317055@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004201302.GA3317055@nvidia.com>

On Fri, Oct 04, 2024 at 05:13:02PM -0300, Jason Gunthorpe wrote:
> On Fri, Sep 27, 2024 at 10:06:13PM +0800, Qianqiang Liu wrote:
> > nlmsg_put() may return a NULL pointer assigned to nlh, which will later
> > be dereferenced in nlmsg_end().
> > 
> > Fixes: 9cbed5aab5ae ("RDMA/nldev: Add support for RDMA monitoring")
> > Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
> > ---
> >  Changes since v1:
> >  - Add Fixes tag
> > ---
> >  drivers/infiniband/core/nldev.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> > index 39f89a4b86498..7dc8e2ec62cc8 100644
> > --- a/drivers/infiniband/core/nldev.c
> > +++ b/drivers/infiniband/core/nldev.c
> > @@ -2816,6 +2816,8 @@ int rdma_nl_notify_event(struct ib_device *device, u32 port_num,
> >  	nlh = nlmsg_put(skb, 0, 0,
> >  			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_MONITOR),
> >  			0, 0);
> > +	if (!nlh)
> > +		goto err_free;
> 
> It doesn't look to me like nlmsg_put can fail in this usage, but we
> should probbaly put the if to avoid getting static checkers warning on
> it.
> 
> Applied to for-rc, thanks

It's difficult for static checkers to predict when a function can *really*
return NULL or not.  Smatch checks allocation functions and that's basically it.

I suspect there is a heuristic here where it warns if the percent of callers
that check is over 70% or something.

regards,
dan carpenter

