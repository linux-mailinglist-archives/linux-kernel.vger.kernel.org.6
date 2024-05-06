Return-Path: <linux-kernel+bounces-170354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53A38BD591
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99038B218AC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9751615ADA4;
	Mon,  6 May 2024 19:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s8/zrvH2"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAEA15749D
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 19:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715024616; cv=none; b=V78PikNhkexhdYlxAQUMDibTApAu+UvPzBGQdwezO7DRPD/2hyZBSc+CU7T8JIKXauRHbn4+NWqsqktgpdbMAmrZQ9b0KDFCwubZYxXdy0EIYcWRYNRTrEk4iMuHJneN1UpI7VkUPi78ToFFqiOZYsHe+dCDn23eyxlTkEjwUQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715024616; c=relaxed/simple;
	bh=DKq1/S1mvND3bjPrxatyn7VET9OItUwcH7q3NBufJKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdSTn8DXbX5hdjuFNovsX/h4Z8sH2nohJV92tygJ96i/QSRMpKnDLYfbaSda7j+Qn87+ek1C88hqOocDjsR9P0nuU/iTNRqr8kimiCOTNh7VgpPpB7tBmLTsyQGQvXkG3lonID9xd2I9vz17Vuuct+4ruX8Vzyy2iWKW9k78gCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s8/zrvH2; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2b3c711dfd3so1832458a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 12:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715024615; x=1715629415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HfyTe+aA68nIYMVD5N9eoPdgr6eemqU/CSX3fB6JqgI=;
        b=s8/zrvH2PP02FyIYUm630fpQIr9AuuQb5IXm7WAjLE48zxIUHC8KQKZDK/z+rN8op3
         DQno0AK92LsNAU8WkmlbkI1KH2/p6mPP1bCod2kBvvXKgIgpj00vfdJufhZcytPaiSoe
         PWRsmrVdRDCacYvREfGSiKaQBTXDdG6/bctIdvVMxksvSZLwRG1z+kfcRlJmbhpRzLpH
         lSk6M3ILILmcYacZSojev5M7qUqmatQ9+PKpFP7PAA9mUAxDWunBFiGN9k0p1SaBxKsc
         MgjQ+/AZBIdapT+Olj+l/E9sIPKY/e4nJAtxq1fxs4WZpt9Kh+0Sf3fx5mw/9mhMZ2ut
         tnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715024615; x=1715629415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfyTe+aA68nIYMVD5N9eoPdgr6eemqU/CSX3fB6JqgI=;
        b=v+zCC8HnFpbGU+FTb9jIOwR3JmGnaIgETV0n0WsT4Wvcv1GLV5WwWJ4qdWWxRNxqDn
         YoUGJq4XgzAqtPKw5tJ3IRKOlCGhjzAXkwVg+x+wNYFKu5K/vwuhnyefzMEnxXgE4D87
         XVPI7SirSW6zUuwlf1hfPKbX/J5mfXCbAl/O4H0j1IMFBaR9kzTIyV/5gjR3lKi4bTKv
         OLc9wlu2dWxY9m0Uo8QdNBdEJbGUNCKGUloARK24muAv1bn5VDYk4IU08Fu+4n/tH5ce
         ays4GrcZUI5ym+S1JCTKRrx2Z0KZBPUtAJaL6FTI/CbSgRmCfASVQqP24V5N4/xvvCuC
         zYQw==
X-Forwarded-Encrypted: i=1; AJvYcCX41WFcpEVzD9TCZwWwfXouf1QTvRvKPr0hxBD+xMJrIFL39hO7sfG2Vc/gyf0DmvmGsiPCuce8w7u2p4J09eJrypnsmcvnTgvVn8o1
X-Gm-Message-State: AOJu0Yy65ujdvSmLJIsy316rdJ+j0l+GrsooI2l2k+h3/KorCDsEblm0
	C9tRy9y5b/VDDk/6HhuB5W/hCGf4fIBPjTtD3ChpjxOgdla2hhJibDzOVzLS8Cg=
X-Google-Smtp-Source: AGHT+IGkB7X6GUEdfi+4pYo7W9/+lkuI+IkhEHYzDeewt/ILJR/tYZgRUhk8GJOD/BNtvf2Lt54RFg==
X-Received: by 2002:a17:90a:68ce:b0:2a5:badb:30ea with SMTP id q14-20020a17090a68ce00b002a5badb30eamr9053231pjj.36.1715024614703;
        Mon, 06 May 2024 12:43:34 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:d0a8:32b:6e71:43af])
        by smtp.gmail.com with ESMTPSA id st12-20020a17090b1fcc00b002a5d62a7e75sm10393094pjb.52.2024.05.06.12.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 12:43:34 -0700 (PDT)
Date: Mon, 6 May 2024 13:43:29 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: andersson@kernel.org, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
	hnagalla@ti.com, devarsht@ti.com, nm@ti.com, s-anna@ti.com,
	u-kumar1@ti.com
Subject: Re: [PATCH] remoteproc: k3-r5: Jump to error handling labels in
 start/stop errors
Message-ID: <Zjky4V7dAcaDKjL3@p14s>
References: <20240506141849.1735679-1-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506141849.1735679-1-b-padhi@ti.com>

On Mon, May 06, 2024 at 07:48:49PM +0530, Beleswar Padhi wrote:
> In case of errors during core start operation from sysfs, the driver
> directly returns with the -EPERM error code. Fix this to ensure that
> mailbox channels are freed on error before returning by jumping to the
> 'put_mbox' error handling label. Similarly, jump to the 'out' error
> handling label to return with required -EPERM error code during the
> core stop operation from sysfs.
> 
> Fixes: 3c8a9066d584 ("remoteproc: k3-r5: Do not allow core1 to power up before core0 via sysfs")
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
> As stated in the bug-report[0], Smatch complains that:
> drivers/remoteproc/ti_k3_r5_remoteproc.c:583 k3_r5_rproc_start() warn: missing unwind goto?
> drivers/remoteproc/ti_k3_r5_remoteproc.c:651 k3_r5_rproc_stop() warn: missing unwind goto?
> 
> This patch addresses the warnings by jumping to appropriate error
> labels in case an error occurs during start/stop operation from sysfs.
> 
> [0]-https://lore.kernel.org/all/acc4f7a0-3bb5-4842-95a5-fb3c3fc8554b@moroto.mountain/
> 
>  drivers/remoteproc/ti_k3_r5_remoteproc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> index 1799b4f6d11e..50e486bcfa10 100644
> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> @@ -580,7 +580,8 @@ static int k3_r5_rproc_start(struct rproc *rproc)
>  		if (core != core0 && core0->rproc->state == RPROC_OFFLINE) {
>  			dev_err(dev, "%s: can not start core 1 before core 0\n",
>  				__func__);
> -			return -EPERM;
> +			ret = -EPERM;
> +			goto put_mbox;
>  		}
>  
>  		ret = k3_r5_core_run(core);
> @@ -648,7 +649,8 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
>  		if (core != core1 && core1->rproc->state != RPROC_OFFLINE) {
>  			dev_err(dev, "%s: can not stop core 0 before core 1\n",
>  				__func__);
> -			return -EPERM;
> +			ret = -EPERM;
> +			goto out;
>  		}

Applied

Thanks,
Mathieu

>  
>  		ret = k3_r5_core_halt(core);
> -- 
> 2.34.1
> 

