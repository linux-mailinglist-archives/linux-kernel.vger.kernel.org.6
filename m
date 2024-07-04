Return-Path: <linux-kernel+bounces-241368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61375927A5B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF8F01F2345D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16201B140F;
	Thu,  4 Jul 2024 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y5GNWXp0"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1221AE866
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720107881; cv=none; b=qVO0i1SPGHsq3WuqarH9ZNtEZktC5/NgrFa+AzQvB3vv8hWTDez9FMMGZOe1bhC71YWlJ3/7qPIbfCA0RDAaRldOvoXsmt7/6KDnoGaoB+pn3L+Xypjx2YUwAFmv/MmX+wMup7YKJEAXAM9JeTllkzXKPZtGR4VvPf/TP1+FgBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720107881; c=relaxed/simple;
	bh=o5YyURreYGQuqS7GOLdNDGbDt6jPvS7mpQOtOlZZc1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4sZwF3n22Jeqd2pUO11P62QdUJW3qeyky/O8kGjRkbQDrk/6SdfywLWxQT4GQ16ZOGp/HpEYqwPu/eXv6sxzwxkH0bhz7WV4RVqBbEQsq7XhDTpQqo92/qdrDxmrcL6EHh/fFLzIdUeyJ/0Vrz7PN0OaYG3sod25FgMV5LCQTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y5GNWXp0; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6e7e23b42c3so428972a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 08:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720107879; x=1720712679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=goVPoxaUI2y65aB/cJo20joVog0pnDpvEJK/omY3OKQ=;
        b=Y5GNWXp0Ru4sXyGTgzwQSQhVqrtWYGcb3BCTXjgxm6aViFSToAlJJXpe296vBmK88S
         IPpTiNoovh6rzaJw+mfSuuVhFsSMwBjRZrSQF6ojbEEMFtj59aRDniw63GdwK2zdoHvR
         e8d9w5LWgFUaBtqi5+r98bGhxZ0+Qn9LOSsgtJOgnJtWCixFW/LDqXXbnRbICyIaJP2u
         UjR1SRd6ve9F+sRD5UOgJ7mzhMylAnFzf2bgZPRvVTDcr+b4IhEpkEXQSIgZ0rzJScrm
         4P33csoK0Y3LkA7xWSMbWNKepSmqIgs0I7MMRYTrI/JQWJt4EYy7tdY32SnUM5upyOSu
         t7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720107879; x=1720712679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goVPoxaUI2y65aB/cJo20joVog0pnDpvEJK/omY3OKQ=;
        b=pjNXMt+QKVSoBqXCYha1Sbz0zZ3IDUtXivbwgRmui0yMnqpsgwzoCxLC+1PzaEYRKI
         QnRs6XRYBUrElnj8QBDfuGscZzeeWdrmJqhBAw5ywyS51wu+MIJFgUuZrl56AQOrWv4b
         uIKjzQa2C+Am6l0ZYzwWaCHUuiUvLxkqYlK1SOmKOPyjq7cVmCund01gQ3BSLyLMm4ST
         +wwV2CYNe1zEW5goVbFNp/Q7M6ubj2j0LGkXJ23/YS+SyDaITuKpP83IdUj0VUx6W6EO
         fa5lI/YJ+qniXIso8FbEAe9Ix9iovaI4JoaR14HBtbasOHF8CsSOrDasfR6dvC4cmBgM
         ZHlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj5tWOWMCbJutupIGmSnboIjdVw3Ojtr1nktTyVyws2xqYqpCkhwsVGLHxTFGE20wUPYhyZCuwMHkHEs+vU/4Pi7cOmubv+niGbIsX
X-Gm-Message-State: AOJu0YwJAHsddvDTZoxwZaYI1XPoDlqxrsIDSaotd6hiVFz2dICLmCVt
	ZNezW8nESKIVDj8vmQa0eaptcUjV9XyLcVusN3uaRL3vWF9yC1u3pHn2EnAJ8rk=
X-Google-Smtp-Source: AGHT+IEZZAgrGC2Rfb97YGGptE4y+3B0HWnowCKHQ3/hj0ImHHV4ebI4HTp2GHw6XcgNEbHZSL5V0A==
X-Received: by 2002:a05:6a20:a10c:b0:1be:c955:4ed0 with SMTP id adf61e73a8af0-1c0cc8d7d95mr2194917637.57.1720107878967;
        Thu, 04 Jul 2024 08:44:38 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:fb65:8622:7ca1:51c8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a989416sm1685051a91.29.2024.07.04.08.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 08:44:38 -0700 (PDT)
Date: Thu, 4 Jul 2024 09:44:35 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Garrett Giordano <ggiordano@phytec.com>
Cc: andersson@kernel.org, w.egorov@phytec.de,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: Re: [PATCH v2] remoteproc: k3-dsp: Fix log levels where appropriate
Message-ID: <ZobDYz8qeKfiaG75@p14s>
References: <20240626191438.490524-1-ggiordano@phytec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626191438.490524-1-ggiordano@phytec.com>

On Wed, Jun 26, 2024 at 12:14:38PM -0700, Garrett Giordano wrote:
> Driver was logging information as errors. Changed dev_err to dev_dbg
> where appropriate.
> 
> Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
> ---
> -v2
>   - Change from dev_info to dev_dbg
>   - Drop k3-r5 PATCH
> ---
>  drivers/remoteproc/ti_k3_dsp_remoteproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied.

Thanks,
Mathieu

> diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> index 3555b535b168..a22d41689a7d 100644
> --- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> @@ -327,7 +327,7 @@ static int k3_dsp_rproc_start(struct rproc *rproc)
>  		goto put_mbox;
>  	}
> 
> -	dev_err(dev, "booting DSP core using boot addr = 0x%x\n", boot_addr);
> +	dev_dbg(dev, "booting DSP core using boot addr = 0x%x\n", boot_addr);
>  	ret = ti_sci_proc_set_config(kproc->tsp, boot_addr, 0, 0);
>  	if (ret)
>  		goto put_mbox;
> --
> 2.25.1
> 

