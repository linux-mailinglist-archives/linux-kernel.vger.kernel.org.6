Return-Path: <linux-kernel+bounces-196050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F39B8D567E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BD441C22646
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB63184124;
	Thu, 30 May 2024 23:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lB5As4BK"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0CB183994
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717112993; cv=none; b=c9njOn1N+OP3IspuaNGfq+a2NwyYKRMBQiXvrK01xk8ZcW9Cz7ornEL4Y5I3JPT8ppNXqOsxoKMXDbvC+xUZpwsemCS40JZHQRT+eq1sY40ULoEWbPnpF7P1gQ1Q/ujth1TCxafIGqfI04Uefwge3w9uG0FlvwcjiFUuih2yj6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717112993; c=relaxed/simple;
	bh=48LTV/9w5C1x+XYvcbYPDjQasFjHDygEgky4Dzmak60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGDOFQvjnnU15FOrnAXB0yvY/PLQgiiizWarNODEXcAj98x8ANaIVcGtwnec5xQsyi1AsMzxcIdijxlG2toZdr5CqUkyCTWqll4I/yAgPqPdst8P+TvjPAErUNuPncIUCDvFTHf269zKRsiE+nLcPB2IGVZGW11LKqIX8BhqgH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lB5As4BK; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52ab1d7243fso2200775e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 16:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717112989; x=1717717789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CDYD3/uNTRnX5/IFcQXFtl691HQJ47CBz0Y4ueBRd1g=;
        b=lB5As4BKLKKhYgw2Al5Nz+AGtiyAq7WHwrOKyafpF1hhBxSl5zZX87IaFP0eEltmZ+
         R4QwV7asPvAxdnSmRE08n1Dqx0DjV3XQtoxZQZ6iu2PuAOgVoVm/gjBGFsL6diptHPZ0
         DoXDhpGYovOoi7ELii3tjgU8lRO4HzhZtrlyRPCtJwnr5JcSTQ4ux/pt8gyyjx5IegFv
         XRr53IiHq1go4MwIdIfa25SgFADc8oJ1HjM4m3nwuivRdFZjD4C1u/Ajzi/YUKuuRZwJ
         wbI766Rh/QIS2esJAVD5+mUlSXijicC4MVO4DnoaIwaVoQTN6PBnoO4O6ZDm7U5WmIaz
         nviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717112989; x=1717717789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDYD3/uNTRnX5/IFcQXFtl691HQJ47CBz0Y4ueBRd1g=;
        b=sQ653aOxNDuJTGyKwlU2VVm0ZUPnjzWoNCQPY28BnpmhLfh1wfLiKlIeYmg/e4h4TS
         I2dBcahf6ER5XqX5BzP1Nq/Oyx87zaH+zBsVL/llEXQNIFFcPqlOagjNJ2wfay2pojZs
         /a00kPvU3WLRTM/tDV5JwjvXoqXWH+LIdm8arPF7W8CcrAZSrTgfzU5aCyPYlUdngHxa
         0ZnNewQjlGk+55lqN5Mum0jzav3iHbRT7TXEB9GUT1+Hq7ciAMGdPixNjaLAoyqIAsa3
         +TtKp0tJi0C3koEDRDKYD0UOOBnFcE7WVz7/v76v3PMM3SR/ptJAMDpbbLSc3RFbZ2rd
         3FTA==
X-Forwarded-Encrypted: i=1; AJvYcCUEAzu2eTPW5X5KIM9cVSavgxA6Q303mw0sJYDmaD6A+xtQ74K8mv0KZPNsY6g09rTyCsc582JCefBH4XbVVvfPyCpbjdyD8xulrgXI
X-Gm-Message-State: AOJu0YyEOmAOqM66hCl/gyDk+pU8Mp73yoIgBgkYwogq5r3RJy7t+dbW
	i6ya79EvQTRqRTrbhv/E6Z8uNdRPaX/scldlaVjBlm1yZhzgAE/7ZzWfNwzsEX4=
X-Google-Smtp-Source: AGHT+IEuUE9Lg46p5zdKMZxJSJ3EmziJWTbmzgr8/Pb3MKpEiyBc9PXxJObBVLE4P8bnoPYLCabHrg==
X-Received: by 2002:ac2:5b1e:0:b0:52b:8926:9052 with SMTP id 2adb3069b0e04-52b8955b3e8mr94961e87.5.1717112989210;
        Thu, 30 May 2024 16:49:49 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d75df5sm127078e87.178.2024.05.30.16.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 16:49:48 -0700 (PDT)
Date: Fri, 31 May 2024 02:49:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	quic_chennak@quicinc.com, stable <stable@kernel.org>
Subject: Re: [PATCH v3 8/9] misc: fastrpc: Restrict untrusted app to spawn
 signed PD
Message-ID: <q6vl2d7ekrjiwbr4h6cieh6q7vewhbiqay67wrglurphkigq4c@zoeyzywhypww>
References: <20240530102032.27179-1-quic_ekangupt@quicinc.com>
 <20240530102032.27179-9-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530102032.27179-9-quic_ekangupt@quicinc.com>

On Thu, May 30, 2024 at 03:50:26PM +0530, Ekansh Gupta wrote:
> Some untrusted applications will not have access to open fastrpc
> device nodes and a privileged process can open the device node on
> behalf of the application. Add a check to restrict such untrusted
> applications from offloading to signed PD.
> 
> Fixes: 7f1f481263c3 ("misc: fastrpc: check before loading process to the DSP")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>  drivers/misc/fastrpc.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 73fa0e536cf9..32615ccde7ac 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -328,6 +328,7 @@ struct fastrpc_user {
>  	int pd;
>  	bool is_secure_dev;
>  	bool is_unsigned_pd;
> +	bool untrusted_process;
>  	char *servloc_name;
>  	/* Lock for lists */
>  	spinlock_t lock;
> @@ -1249,13 +1250,17 @@ static bool is_session_rejected(struct fastrpc_user *fl, bool unsigned_pd_reques
>  		 * channel is configured as secure and block untrusted apps on channel
>  		 * that does not support unsigned PD offload
>  		 */
> -		if (!fl->cctx->unsigned_support || !unsigned_pd_request) {
> -			dev_err(&fl->cctx->rpdev->dev, "Error: Untrusted application trying to offload to signed PD\n");
> -			return true;
> -		}
> +		if (!fl->cctx->unsigned_support || !unsigned_pd_request)
> +			goto reject_session;
>  	}
> +	/* Check if untrusted process is trying to offload to signed PD */
> +	if (fl->untrusted_process && !unsigned_pd_request)
> +		goto reject_session;
>  
>  	return false;
> +reject_session:
> +	dev_dbg(&fl->cctx->rpdev->dev, "Error: Untrusted application trying to offload to signed PD\n");
> +	return true;
>  }
>  
>  static void fastrpc_mmap_remove_pdr(struct fastrpc_static_pd *spd)
> @@ -1504,12 +1509,20 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
>  		goto err;
>  	}
>  
> +	/*
> +	 * Third-party apps don't have permission to open the fastrpc device, so

Permissions depend on the end-user setup. Is it going to break if the
user sets 0666 mode for fastrpc nodes?

> +	 * it is opened on their behalf by a priveleged process. This is detected
> +	 * by comparing current PID with the one stored during device open.
> +	 */
> +	if (current->tgid != fl->tgid)
> +		fl->untrusted_process = true;

If the comment talks about PIDs, when why are you comparing GIDs here?

> +
>  	if (init.attrs & FASTRPC_MODE_UNSIGNED_MODULE)
>  		fl->is_unsigned_pd = true;
>  
>  
>  	if (is_session_rejected(fl, fl->is_unsigned_pd)) {
> -		err = -ECONNREFUSED;
> +		err = -EACCES;
>  		goto err;
>  	}
>  
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

