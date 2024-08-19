Return-Path: <linux-kernel+bounces-292514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA2795705B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B369F1F23FDE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F63175D20;
	Mon, 19 Aug 2024 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dd+MqviX"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F373345C1C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724085173; cv=none; b=t6Awpj5rrdtpE3IbXQ/cX4ZqNG9DaJyT+QE8xtpypunsVnPsYYXZR7UA8JJsQ6KS4GzGz8Q9ee5Tjls+g8DlOthSYhzqU6SbQ7hRTNain1kwyTBL0Hs0pfpuyBgfypsXYDd13kwxGnJm36ZVTVHONy3glkC5pqTrUDmbIEdtpL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724085173; c=relaxed/simple;
	bh=K0q193bN5JOax1rhlDmcjYqO+uYhbBCDOeJQcoTxJMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcF4pzohptrOyVI1kxjuyuRvkmhnQPkgj9BjGMUGA79Uizoc5085y8NmVsWwSoaNZ0eCVBCg73g+A4Vcmm6mCPCiW2x9xaxDNx+kv6fGV6iuqa8VncF6OE6J0nN+UNACyh1yVXCe/WM+xvFjeiN4dYD+GPWHw5LX2KQ61+GXs6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dd+MqviX; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-710bdddb95cso2594499b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724085171; x=1724689971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iTLJkDxNCgz7MzPLIVAzrv8NyvHyRZtNC2lGZWfIhOw=;
        b=Dd+MqviXRFih64nkgiaX3qkMWS3vXGDRmSPMzzylkQq2on6Q1zoaKs/sxby2kDGSJ7
         P2whGPurbHvo8d7pxIRrCAdKHQh/cKIt3StUT1XwxkT308f9RuXOWwF2zEd6eNHccg+k
         Kj54F7AdsmDsUGZCDTPsYFTPN2l/IQ3g8EVo7RkKgw2B0o9UARdvz7rSQb9yT1xVdcSk
         IHGTyQvY3gcejB7RgWNQgyWLskz+WqUU/lAAUKt7CzQjwfjiahgOCYVRx8v9Ojwc3gzd
         pSsd30oud5wqVNyKmeGH7ajpaZexlVB+9XHSmKNdrvhaQ2YOBr6TnObyEzKrhT2CwNRu
         QPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724085171; x=1724689971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTLJkDxNCgz7MzPLIVAzrv8NyvHyRZtNC2lGZWfIhOw=;
        b=iMq3T9IwhmWGbQUnO1ItJJxXyHB8s3TLrLnFVpzu7trM6cPe/se6/2y4eXegBQr1uP
         M8wMJ/rHevkwIEUScwRFwhWs0zUHOUuMznbzdCZq7hJuVwZueKUm1TXBfSf/8lTxkoBJ
         gnpU+TKyLqow/RFYhurJHnP/lzdIekxYBpgHQdrRw4l44cE0XeKLlAzoEYTZeInlxSic
         8S/o4vObkQgNw+P7LXSs8MlOEOvIQcF2sPTM3u7wXiFq6T1crInPo/k+xM9C2ZPdC8gY
         93yLSok66EQJN+Je0wMklYZyxyb9ppSnuoAJx4vR6lSsUak5IXYKVzmbv/ldItfAwYDf
         3exA==
X-Forwarded-Encrypted: i=1; AJvYcCWapCKM6famKLMkmAqTPl1eG2JEfxVFIwdPppimBCa24WgNwe2DccIGwH1JSvnLpAseSyIFushWlfeXhr4sc+G3FwpzJWPFS45p5NQu
X-Gm-Message-State: AOJu0YzwNMkitsYeqbIR0jYiASHmEL4w4lfyxvZkHdn0H8LkcIWFw+YC
	+Nw8IXfdD3CoTNSY0Rs5doakxte4x+ER1HCSCkYpaL1WcSEAGkoikKe1ACrCcwE=
X-Google-Smtp-Source: AGHT+IGd9BomTOEkHSrU8yURSLWC4Z5e2W/4EhRS2sSRKbSLBn+YZp1LHRiMhzFNnRZa9sIzuHFmgQ==
X-Received: by 2002:a05:6a00:91d9:b0:70d:3354:a194 with SMTP id d2e1a72fcca58-713c4df5f72mr10370415b3a.2.1724085171195;
        Mon, 19 Aug 2024 09:32:51 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:903:55bf:2534:1807])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add6b3dsm6779761b3a.8.2024.08.19.09.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:32:50 -0700 (PDT)
Date: Mon, 19 Aug 2024 10:32:48 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: andersson@kernel.org, afd@ti.com, hnagalla@ti.com, u-kumar1@ti.com,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: k3-r5: Delay notification of wakeup event
Message-ID: <ZsNzsDByD5okM6Xx@p14s>
References: <20240809060132.308642-1-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809060132.308642-1-b-padhi@ti.com>

On Fri, Aug 09, 2024 at 11:31:32AM +0530, Beleswar Padhi wrote:
> From: Udit Kumar <u-kumar1@ti.com>
> 
> Few times, core1 was scheduled to boot first before core0, which leads
> to error:
> 
> 'k3_r5_rproc_start: can not start core 1 before core 0'.
> 
> This was happening due to some scheduling between prepare and start
> callback. The probe function waits for event, which is getting
> triggered by prepare callback. To avoid above condition move event
> trigger to start instead of prepare callback.

I can see the race condition.

> 
> Fixes: 61f6f68447ab ("remoteproc: k3-r5: Wait for core0 power-up before powering up core1")
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> [ Applied wakeup event trigger only for Split-Mode booted rprocs ]
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>  drivers/remoteproc/ti_k3_r5_remoteproc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> index 39a47540c590..f1710a61247f 100644
> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> @@ -464,8 +464,6 @@ static int k3_r5_rproc_prepare(struct rproc *rproc)
>  			ret);
>  		return ret;
>  	}
> -	core->released_from_reset = true;
> -	wake_up_interruptible(&cluster->core_transition);
>  
>  	/*
>  	 * Newer IP revisions like on J7200 SoCs support h/w auto-initialization
> @@ -587,6 +585,9 @@ static int k3_r5_rproc_start(struct rproc *rproc)
>  		ret = k3_r5_core_run(core);
>  		if (ret)
>  			goto put_mbox;
> +
> +		core->released_from_reset = true;
> +		wake_up_interruptible(&cluster->core_transition);

This patch doesn't apply due to recent changes made to the k3-r5 driver.  Please
rebase and resubmit.

Thanks,
Mathieu

>  	}
>  
>  	return 0;
> -- 
> 2.34.1
> 

