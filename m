Return-Path: <linux-kernel+bounces-357219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC00F996DCE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0965284CBB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4C881AC8;
	Wed,  9 Oct 2024 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IRQR2Fhb"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D7417555
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484209; cv=none; b=l8c7zI/UXE5HxTM8M91ZqHY4Cq7jHfVbMzNaf+bPmN6+hICwTD1CS6r4Rrs2eevJSOjQgc1Wo/wLDv2Bzfp1CjrbEKRPhe+alh3L86SBcGeQxO+COmqhbnET9kNzwBETmpj9yVJzcsiBkWsdsg+kNEywaH9xm5fip4XR+X9cRNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484209; c=relaxed/simple;
	bh=6DUxtqFeYCk0yVNMLdhvhgUM+KP6wb51Y9BDmTKikvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRiMESzKLeM6jcsWvXgYEqILf30YalI7CcAo39hOG3V5NC8fF0OpD0gKQAkU4vG9ZvvtnhLanJ8I8ZeoGCpwdUXkUGyR/ik5fK2GjkMRTpuaC+A/GXotRHuXIG7PJEvi725qCu3j2j9C4HcEqBwL9pYn0iHBcZmsu0Gz0lT8nEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IRQR2Fhb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42e82f7f36aso61318605e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 07:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728484206; x=1729089006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VYe0UDJwZywf5zVofsmCoLxxt4WBBMPiUob9KTaisSA=;
        b=IRQR2FhbuT2JRHCcfVHueSiaLI35s7TST7fzhbTXTnrt4DfIw/41rvrWR5pVfzqqu9
         4bgfmiqgbbS4UWBvk35I52/Su5IOwKyd5FpsXZlb83ZkW0GO1mQuGjc6Yq5yx0RrA3eb
         UzqU9RvUNL48/UEg7SCVuPB8gz3i+5rX3DNx9mjKo4zGNjNAAKt3ceMbjgvRJD3fTA4U
         3l0Bm0wALwpeTVFUiIz52AxPpRglIm8DW4rBBvDjc46aWyPkNZJh90r1btF0rjCOe1nu
         hG1MLb4j0b7XPKWCssuZlakanunrfZbnoP9djcJHJvRTSYZVBY3lYMYd7jwvojb91G0U
         I+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728484206; x=1729089006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYe0UDJwZywf5zVofsmCoLxxt4WBBMPiUob9KTaisSA=;
        b=tsp+tQj8s6FkRtLjLSsf1DngNR5PX5x4kggzB8+dnCggb72hdFMvmr60Kp+HwwgZvX
         o9sU5zEXE2pO+weBLPTtD2Aro8iO21xHR4o0abLeARQE8Bfg2Nnmi+T9UxXqA64h4xrg
         ZOyGeEHtOAood/IsDD4p3FF+HlA8gqfbv2dEJpsLhAy/mAkUO7BslQOEdfuSRHKcd0in
         XvKdPTqh5e8kdrU7HTHRCeYtTuaPxjT+QNJIwxEdqPI1cxFMMZlZWRNO/HaukcX+SocX
         pRxz1OvcQN4p9Xv50t7R/0KSTQjndlspYo18IRZBMn+tPRrQQ1/QL7sS3w+hrmN4RNiI
         wpmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkOelN3ZZaXoC+pu5LyuNr958vhva+o0X97fXC8hJk3/q3Lxq61C3XSWGxqB1M8EYjuObdQch3MQ8P6kc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1L/jxmv2+GYiUza5Ofy7y+0DpNCSZyuPyMz7stJi0GlFTpmVq
	WlFX5c3+2PBvkYE+HmH+wFSlSJFFNAHxZJSOi3FsqBwbr5k2MvR5+qDpp9eWm8scOBMV7yYx4PF
	p
X-Google-Smtp-Source: AGHT+IGlS2o4g/GZdl5D/67AlFAU0IALKSNCiQ5PhERwo+PloE/WKbeKZuNI0nFK8YJ1ev0hhpW/4A==
X-Received: by 2002:a05:600c:1d09:b0:42f:68e8:d874 with SMTP id 5b1f17b1804b1-430d70b3e15mr19146415e9.31.1728484206301;
        Wed, 09 Oct 2024 07:30:06 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf4f7aesm22176065e9.12.2024.10.09.07.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 07:30:05 -0700 (PDT)
Date: Wed, 9 Oct 2024 17:30:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/nldev: Fix NULL pointer dereferences issue in
 rdma_nl_notify_event
Message-ID: <a84a2fc3-33b6-46da-a1bd-3343fa07eaf9@stanley.mountain>
References: <20240926143402.70354-1-qianqiang.liu@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926143402.70354-1-qianqiang.liu@163.com>

On Thu, Sep 26, 2024 at 10:34:03PM +0800, Qianqiang Liu wrote:
> nlmsg_put() may return a NULL pointer assigned to nlh, which will later
> be dereferenced in nlmsg_end().
> 
> Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
> ---
>  drivers/infiniband/core/nldev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> index 39f89a4b8649..7dc8e2ec62cc 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -2816,6 +2816,8 @@ int rdma_nl_notify_event(struct ib_device *device, u32 port_num,
>  	nlh = nlmsg_put(skb, 0, 0,
>  			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_MONITOR),
>  			0, 0);
> +	if (!nlh)
> +		goto err_free;

Need to set the error code before the goto.  "ret = -EMSGSIZE;"

regards,
dan carpenter


