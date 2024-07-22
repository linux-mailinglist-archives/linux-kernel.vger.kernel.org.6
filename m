Return-Path: <linux-kernel+bounces-258645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1F8938B0F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FD6D1C210C8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE031684B0;
	Mon, 22 Jul 2024 08:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eC4BGD5k"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C833416726E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721636308; cv=none; b=m6hNEE27vNwmbV9GOmmx4JSOxtikkr9UxK3Gqkstpvg8vyw7gtvTHbRQnpY13ZryrTqi27qQBjg4kaLq1Ug5XpUM7zfbsGMSciLIMmFoFZmL1Ogcae5mlLaeHchMF2XY+mcwf6vaix6m+g6BzLBzeSgnWCKSvm/QgDBiim+b6D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721636308; c=relaxed/simple;
	bh=v4mM+bgWeSg6rjqV2ojgpf+DYYgWDnrtaQ/tokfk8Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiSkSMO0BRWBt9dQ2NE+jsR53gpCoFeOEQJbsqjmJ4jUisUVEItYo7Qn+iVKLidFm98QsH9EZmSyhSJfb3eP46s9z0y3Rem9Uk3Nri0k9OVdqgiER6PJOCjxaILLdClGIfy5wrjiL7LGSExxxavFBnP9m1W6viAMeLtaP43d77E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eC4BGD5k; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ef2fbf1d14so5501331fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 01:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721636304; x=1722241104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j2YYNydr91hY9SUP1qO73rcnIKppoYrhA5vIDVvsVpM=;
        b=eC4BGD5kTaLme0E/+y5MLBPYrdEc0HZOkXA9LG1pJ6uesyNFW9ulmk/BpUjVZ/ZSAb
         d+mNjpFLfBDG7cvx1CT+QS2qZtRPMJ3K/4wxok0oOJGnnNh/i6XXoweR8Z2ghdyimmYU
         iAXZxfx3y9IEI2kzsw3l/Ll/D66VhNTuQsMZEd/iXHgaVWjS/WbxW4+OJO+0VM9WxnCr
         5OQ6SySdck2qpbfIPj0+zDFzfUSxts00yZ2U2xQwrgCjzW3r3fK6sEP1vUe5hX8nxUU7
         7DcM0wjGFN5BuyBinZ6OwtcYs3O+m98T9tsRvfmIpurMmJ/Na6FX5mABxi92h7qB6s4y
         lb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721636304; x=1722241104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2YYNydr91hY9SUP1qO73rcnIKppoYrhA5vIDVvsVpM=;
        b=U2Ewwb0NMngrZXVh0I8ICJ9edgVRvKbZ6+r2vXQAYGfErl6ZUeS4GDBQ98zIt8CLPv
         ooSLFWPxZ368WmCdZ/txfW2CdYCsdybi8VWoH3tAf2AIc9UfaC6iR5jFUFekIH213tKd
         7vrLN4/NBsbaBytzk0rLuj82KnT+G8wUHeAwKbJxOO//IejCn+fVb4sl7jXJ2TdacB8v
         F+TNAdYDtBVomlICaWxGyTBQbeGhcPzRZFH7ujgZo2IpZqoQi+3HfGUCemM6GR6Io1Ap
         EiavEtLT/S+DzW6KUwMYjK49etT8QJybj01l8O5m+FRkNlgAyxmCpxql4ef3J+pQqtUY
         4a+A==
X-Forwarded-Encrypted: i=1; AJvYcCVzn+QAIx5N7XpsAfior07zCnAarfd+97gdlkju7PjRcXyx4nbCCOIdM8CUvd6+A1EOIDxIvalYApOVm1EzhHh9Y8+MX/vpxD9F1FUp
X-Gm-Message-State: AOJu0YzuH3z3lA9otJr4pMr9qeruxMUA/k6NLpjY8uCbzof18GUZb2sH
	oSC0No7htFnmVSf7Ghp4tOp2g6VIJHXEubTJ6+eBxOyvGUzt8kMTszw0Z+FFcvY=
X-Google-Smtp-Source: AGHT+IEbkru7fNizX7xMy50mhZzku9vEb3dv34HFkQDPLX7osSafc3vJ5cXUQ79K1sqUjMAbPMPwvA==
X-Received: by 2002:a2e:b8d4:0:b0:2ef:1efb:1b6b with SMTP id 38308e7fff4ca-2ef1efb1e0dmr16408341fa.15.1721636303917;
        Mon, 22 Jul 2024 01:18:23 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ef2aba1489sm5951191fa.78.2024.07.22.01.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 01:18:23 -0700 (PDT)
Date: Mon, 22 Jul 2024 11:18:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org, arnd@arndb.de
Subject: Re: [PATCH v2] misc: fastrpc: Add support for multiple PD from one
 process
Message-ID: <nggoobovb223pxknzai5luaq6wqrv7ovtawodds4bjiegbxlth@ro5cvoxed24w>
References: <20240720034611.2219308-1-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240720034611.2219308-1-quic_ekangupt@quicinc.com>

On Sat, Jul 20, 2024 at 09:16:11AM GMT, Ekansh Gupta wrote:
> Memory intensive applications(which requires more tha 4GB) that wants
> to offload tasks to DSP might have to split the tasks to multiple
> user PD to make the resources available.
> 
> For every call to DSP, fastrpc driver passes the process tgid which
> works as an identifier for the DSP to enqueue the tasks to specific PD.
> With current design, if any process opens device node more than once
> and makes PD initmrequest, same tgid will be passed to DSP which will
> be considered a bad request and this will result in failure as the same
> identifier cannot be used for multiple DSP PD.
> 
> Allocate and pass an effective pgid to DSP which would be allocated

effective pgid makes me think about the setegid() system call. Can we
just name them "client ID" (granted that session is already reserved)?
Or is it really session ID? Can we use the index of the session instead
and skip the whole IDR allocation?

> during device open and will have a lifetime till the device is closed.
> This will allow the same process to open the device more than once and
> spawn multiple dynamic PD for ease of processing.
> 
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
> Changes in v2:
>   - Reformatted commit text.
>   - Moved from ida to idr.
>   - Changed dsp_pgid data type.
>   - Resolved memory leak.
> 
>  drivers/misc/fastrpc.c | 49 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 37 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index a7a2bcedb37e..b4a5af2d2dfa 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -105,6 +105,10 @@
>  
>  #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
>  
> +#define MAX_DSP_PD	64	/* Maximum 64 PDs are allowed on DSP */

Why?

> +#define MIN_FRPC_PGID	1000

Is it some random number or some pre-defined constant? Can we use 0
instead?

> +#define MAX_FRPC_PGID	(MIN_FRPC_PGID + MAX_DSP_PD)
> +
>  static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
>  						"sdsp", "cdsp"};
>  struct fastrpc_phy_page {


-- 
With best wishes
Dmitry

